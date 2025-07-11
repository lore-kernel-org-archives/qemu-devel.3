Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7CE7C83F1A
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Jul 2025 10:03:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uaAX8-0006KM-IB; Fri, 11 Jul 2025 05:59:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1uaAWz-0006Ez-6M
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 05:59:01 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1uaAWx-0004rv-Cw
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 05:59:00 -0400
Received: from pps.filterd (m0127843.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56B8McKm016805;
 Fri, 11 Jul 2025 02:58:57 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=rALzJfhuFuyIke5siyIOHEim4J/yO7Z/nRt5alFVg
 kc=; b=fgzkpZB/uN26CSfu/u58NhOQwlHiJL7nXBAOaET4H18wZX8cVVbCMpjkt
 8CLHkXLzjhIUxVRC6MPXQM/qqFYENPk62kB57uejlfdiMWXyuYBdncF2n2o9k8Gs
 gEpsH01q97yc7ueVYSIANUyV6yChgJnnQjMCj1URE2e994urv5XhXvbrWhdk946w
 QCPbzzNmDZQKehpUv927SsW6BqdBmgkQGgJgeCv8WPOICLd2pB2/zdhHF+Nae+ka
 ngTiXow9olbKZjKnU0qTSGOK2OHssd+imgF3a3rEBVWS/2Cwact5AvqCODVWczMk
 TwuMxfBv75pN77wetiwRM2um5cG7Q==
Received: from nam04-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2118.outbound.protection.outlook.com [40.107.101.118])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 47ta49k6dp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 11 Jul 2025 02:58:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k4XGUxnk6b9jRTF0qsmtAdsiEFQUCTzecN7clcNdT2AJPJhjbXBQYQo8knl6Kyef60t8fS1hY3oUfMMocbKVOBL1D1yDPZLePrOWO943TmqvXHknUHUPytGAJeKnVibHz2wUMFRw4OxgLFeH2O15i/Y7u3kqsXmT54vAm+CiPQf0V6RDu9iecUK4cYRBGizut2NzB1hKfecxepsnvHcWUapkbSyiwWb1BZ+z/4/GDjjqQ6ri/OnL9GIsCSkkgg/KNfRK016bFCIV7kaC5O3hMrOLbntfUp8kXpr2B5emfFrdi5smN1+20YTKZCumy7CJUOWfwLSuw7k1NWmLZfZqcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rALzJfhuFuyIke5siyIOHEim4J/yO7Z/nRt5alFVgkc=;
 b=c+Z1qMSzOEECOVdvygEeG0RcucANTMJj8C6cXm4PxCRaHucQzrwBwnStH2UOoD4EUCd52gLf+QE8C7UZ1pNaVmUGjevPtR52JSJYIDNrl7SGMvgRIijNtmsqzqsgzmR371KP9AdKebTvZ35/HgZ4ISHlNUKSeewDPC6+hoi8yqoCHDN4uc3RXaRqX4N0NQgEAs1ktm+joC2LkRad3mq72c0qV3ahZ/KxJuGjcklEL+LGsPkr5DEFjrWyCJiIT/Xl6U1aswydKw/z6zL2pup0UQoZHLVnQlsvSGSw8jcWrSdifQZ6x/hw0YpCcJ5TS9z8E4p0u+ocq3izA9yL0UTIzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rALzJfhuFuyIke5siyIOHEim4J/yO7Z/nRt5alFVgkc=;
 b=GoKvB2HUZQuUatqRkf31qNDfzdLEeQooU1xYCsKcCncPqK7exNns6fgwINB48R5yEvriknVzewIJGWAasc6x3Vl5XBQ/4WYcOFFyczL+CLxIq/p3x9FDpc9W8vovj/Yx5HdeKOf1F41ByKCVAno93eZWQnVaPL2OrQSggFihFs95QR3rsm5di2hpRZJtg4tIlt2iSuUUnEzMTT45/QFJyzFP/JV9OTVvvIYcvtRUPIA43mR8Po/jheP7fW3q12kTRJ1Rv5vcVCpagLVUdn/VV6WftgwBQkVDPFoX045GVVUNeUqkZVZvjB69qFJrYeg0jXZbkt8aZsgU3KnsSVF6+Q==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by BN0PR02MB7918.namprd02.prod.outlook.com (2603:10b6:408:161::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.25; Fri, 11 Jul
 2025 09:58:55 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88%5]) with mapi id 15.20.8901.028; Fri, 11 Jul 2025
 09:58:55 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: pbonzini@redhat.com, mst@redhat.com, marcel.apfelbaum@gmail.com,
 eduardo@habkost.net, imammedo@redhat.com, qemu-devel@nongnu.org
Subject: [PATCH v5 11/19] hw/i386/pc_piix.c: remove
 pc_system_flash_cleanup_unused() from pc_init_isa()
Date: Fri, 11 Jul 2025 10:57:13 +0100
Message-ID: <20250711095812.543857-12-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250711095812.543857-1-mark.caveayland@nutanix.com>
References: <20250711095812.543857-1-mark.caveayland@nutanix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P265CA0249.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:350::14) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|BN0PR02MB7918:EE_
X-MS-Office365-Filtering-Correlation-Id: ad9e5cad-2fe2-4d78-fdce-08ddc0618bf8
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0; ARA:13230040|376014|1800799024|366016|10070799003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cGZEVHFtNmNiUjRKcFN1K2RBeG55K295cHZTaG10ckwyaGcrZXcrMnUrbXFI?=
 =?utf-8?B?RVJqRHVLcDAxd1piVXhhS1NEYVo5OXpXclc5K042SUZRVUJzMFcxdWV0Y05F?=
 =?utf-8?B?bDQrRkxwTzZlZHpzMERMdDc1SzdzREVIdHAyVXMvSmFvb1lTSXUrUk9UYXNB?=
 =?utf-8?B?VjB6cEdNTFV2MU1HMU13ZktQMFBJdXR1YUovU3RLcjAzL2FOL0J3aXFXMzR6?=
 =?utf-8?B?dk0wRE5tNDh0K1ZRUml1RTdIL3ZjN001UFF2TDhDV0wyWmN1OUZzRThla3J3?=
 =?utf-8?B?aHZReW5nWUdCbmh0bWhodVlVdFI0Tzh1bzhWZWs5VlFLeDFRNjFPbzlheC91?=
 =?utf-8?B?UWhtVEFIQnNjdmFiaW5SQmxhZ3J0alNXV0tZTUpURDB1Z29iV3FReTZjVlJi?=
 =?utf-8?B?bXNic2VVbHdCR1FNQkd0R0NSa3ZXM2pqbVRxa0FKRDBWYnlkc1htTjFqek5J?=
 =?utf-8?B?N2Y1RlVnWmwxcWJOdFIvTFZJdEdHVjA1UVNJWk80Q1NHeTVVVTU4WFhiUEh0?=
 =?utf-8?B?dm9TQy9EYld0OWd0WTRFRFNjTWlXR1ExdmdESXVNY0QxaFh1MnpKaEhleHBU?=
 =?utf-8?B?VDA4NG82MkJKbGVoeHhkV0xKUDV4TWRvTVJZVzB4ejZ6bjh6RlVoYW56NjB5?=
 =?utf-8?B?a3lKdnVZTStTWXZvR21qaFFtRUNRbVpXNC8yZXhyYjUrOU9ieDZzbmliMVN3?=
 =?utf-8?B?Wk9OYkhuZXc0bXRhZFJydlNYQXN2bEEwaTM5U29CWUVDU1JBclVna2VnZ2Fa?=
 =?utf-8?B?bnI1TGFLeTlJTXZUeDNrZ3dXeTB5SGpyZnE2R0tKRUlnaVJsV24wMzNXRXcw?=
 =?utf-8?B?NEIrR29lRTRKRDV1TEh5NU5QK0RYanNSSk5pY0RoV3JwZXI5SEpUbm9tNU8x?=
 =?utf-8?B?b2d2RS9sVzZweGw3Wms0bGVrN3dCSzN1LzM4ZzB3OUFvdGNIRW4wbU9LWFlk?=
 =?utf-8?B?bjErVlpxR3M2eG1EMzJNTGt0ZmNtZ1FNUFBPZW15Zm9nZUZkMGZjKzJpTlhw?=
 =?utf-8?B?aVg3RHZuSEgwSHJMUE9BbVpCc2JSNkNKZTFSdXVUOGtnakZGejhPQXJTTmE4?=
 =?utf-8?B?V1JLL2JjMGh5K21Zd2YyR1hCUlNWN2hYYnVDY0R6ZUxNeWlpS3R2Wll2andu?=
 =?utf-8?B?MTh6eDZWcit0RzdTcVlydExrWjBtVGp5RFBUVS9nZWNLZmVZZ2pFWTFSRUdJ?=
 =?utf-8?B?Tk1xWngwZTN5cEQ1NlVxVEcxL1FNRzlkQjZEVGFhWGdlSFc1QkhXeTlSUTQ2?=
 =?utf-8?B?NkhTbittZ3YvcGlGdG4yYUtLMHo3OG1qMzFRb05za0lvb1ZXRHA1aEdzZGtY?=
 =?utf-8?B?NUJZc1p5UlVhVHl2NUdMdnRwK0h5eGpPZUZrM21hb2dUeVpyZFFZbTZxcFIz?=
 =?utf-8?B?WjFybFdwOWoralh0c29pT3RQNTBJZDRJa0p0WWpTajN5T2NzYUl3Z2J0OG9P?=
 =?utf-8?B?Nm0vMklXcWtDRWFuWE9nckVudlN1Snp6MVZoM0hMdEtYZGtZbzdEdnBQcHZw?=
 =?utf-8?B?TEFUWUFkQzFpbWtGcFRuU0Y3NmQ5ejVIQ3lxa1dQNzltMFY2VUpQMThoRlJy?=
 =?utf-8?B?dmxGbEtadnJKVm52Q2VqTWFTbGMzQmlGTllQV1dMOFhTbEZheDIvVUpKcDNi?=
 =?utf-8?B?MXRsUXYwMkNSTENodm9ocHNWTXNxamxXeVdsL3JvdnUvT3RTSUwxang0UGQ1?=
 =?utf-8?B?VHd4RVpNakV3L2pxbjlrUjNMalI5RWt3SUpjZ0RQM1Bpbmh2aGFYWjFxeFRL?=
 =?utf-8?B?ZkxmTXFMRGI0cGY0NmE0emxaOS9kRHRDTmRvWDkwR2YxbVZ1R3p3bVlPWStu?=
 =?utf-8?B?ci9VVy9Vd2dVb3JXTVM1YWJFT0lhbWFwblRLT3hOcThYdW5VT1BDaUR3UUsw?=
 =?utf-8?B?ZzNTMFdpbDMwYlV2dzhNa2VzTmxJMExxNXdIS0JYdEhmbDV6eE1VdUEyK2Vp?=
 =?utf-8?Q?3C1aTiJIjR8=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(10070799003); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NG8rbHpiN2M4STZMTVVSSXluTjBhVnR6d2lxMExtWndScmhBZ0NndWE0M0xZ?=
 =?utf-8?B?RW9pdGVUK2NuT2RxL1RhME95SENkdGNyTHRWWjBJalVueDEvVnJoQS9wMFM4?=
 =?utf-8?B?bnc5L0wvTWx2dXkyV2VRdFZYWUw1OUdiS1pMU2puTkZ5NnY3cVBNT1kvWnIw?=
 =?utf-8?B?bW5DRkRrTUlWZ1BpeW01ZGk2YjE5OWVSSVB3UUZhY2t5aytZS2VSUWlwVVpE?=
 =?utf-8?B?Q3NYWlBXWUMzU29JRm15SGQyckFhYnR1STRVWVl3OTlSN0Y2ek5BS1h3YkNq?=
 =?utf-8?B?d0wwb2p1UUNWdU14MDFYUDNGanBRc2hDZ21aUFhyWm9Ea01FYWtYY3E4Vkpl?=
 =?utf-8?B?c3BsUyswRWo5c0pXZEhESmk0bUY5c0RsRlpTckRBOEwxeFZvRzVSdmV6OGxj?=
 =?utf-8?B?ZmFXeEpUcWFpUGdKNHBYR2N4VEJRMlRMSEJjaW1OdUhlTXM4bEZieDk1M29J?=
 =?utf-8?B?d3ZVd3ptV1pwQ0c3VnJIZEttRWk5V2t5N2tiK3FPaC83RzhsUWJjN1VUaXpn?=
 =?utf-8?B?Z3lueDNiMWpCd0lsd0lrMnQ4amhIMDdDWkR5WklYYUhJcDlBNU5maW03M3FZ?=
 =?utf-8?B?b3dGcE5mS0lwODRNSU1Da1ZSTFZRa1FDWVRXb1dkZ2hWMGV4OHo4Um9rL2Jq?=
 =?utf-8?B?TTMxV0VzQUNhVE43bmJKYVdVdlJqdEdtSnRDUktsVllVUGxtZWRNd3hUakhR?=
 =?utf-8?B?enpMQnV1ZWdmWCs3aG9UaEFROWJnWE9xekRKRnBQY2Zid0U3cGdqRzFJS0I5?=
 =?utf-8?B?Ykw1RThwekY5YVQ2dGlZRFRsN0RValgxazRYVDg2ZFUzOXJSdU1Vemo5czJD?=
 =?utf-8?B?VEd2eHJIT0xqSHBQWXYvSjNaWkxqQ0NNSTIzR0dKOUY3dDZreHIxT0k0aDJp?=
 =?utf-8?B?cWFhVDgrZmViMURyRVRaN2dBQXQrY0MrUjdrYkJ6TEJEeWE1c0sxNUIvblMy?=
 =?utf-8?B?YTN3VGRHMDZTM1BTZVFVZlE5Q1g3UDdQNHFCSWZacXlnMXRIOUxrQ0QrdWI0?=
 =?utf-8?B?K0xGR1hhS2VmeUR6QldVdjhJVFdoYzNCS1NFNGlTeEdXZzRMcEJEbHFHeTNX?=
 =?utf-8?B?ekZuYmlKOTcxT3VONUJrUzFNWmxqbGVXNjgwdzNXbEplTEt6cFEvZjZQaWFr?=
 =?utf-8?B?QWpMVWVVQzBBV3pvSmxBZFc3elVYeWZCdHN3Wjl5QzhyTW9XbUFaN1lXZGF1?=
 =?utf-8?B?NFo5eXBBV2tRaVBPbC9LQTlhdjZVb1NHbzNDNEdTMzRlQjZ0SGhpUklnVlRy?=
 =?utf-8?B?V24rZ2RZNXFUQ0hTSVgwbm4wdWRLcDdhRVAvbENWTUQ3TjBCUlNjN0V4bjF2?=
 =?utf-8?B?NlRKWEdNdkdydXAwQndYSEhTOE44emdzTnZZNEpSa2NZTG5Obm5SWFpSelBR?=
 =?utf-8?B?ajRpeC9vRGx2T0w1c0xGUUJpbEE0dCtRc0krd3cwckdSYVFieW9QNXlzdm5m?=
 =?utf-8?B?M3RwZGpoQnFoRUxzdVhxK2F2dG4waXUxZW1yWW13ODJqaEVJc21xSkFmb3Fs?=
 =?utf-8?B?aHV0V1pjVGlsQ3NLTjdqK1gwWTFyVVd2RkJsV0lEU0lGTk40MFd6UjArTGJi?=
 =?utf-8?B?Wm1pZjk4S1YwMG1VTHk5Uzdpa2Z4bEU2V1V1VnNsSXB4VTEwSUZZUGNGOStn?=
 =?utf-8?B?azlSMHlSd0EzQ0JjUXlkSnY1bmozaXkyWEhucExramc0Z0MrTzlXMU9OcHBL?=
 =?utf-8?B?a3hOZkMxekxSWkRmUU9xTHhhTWlYa1NjTXlqajYwT1RBdHNJVjVXell0QjVK?=
 =?utf-8?B?WU9JMHpRc0t0bmtFQk50am4yVkw4RkpGQ2lkZUt6bzN6d3ZvaVBOa0FjMGVp?=
 =?utf-8?B?RENHcGthcUdYVi81cnNkSUF6d0xlcis4bXQ0NGllbWFHU2VmOHdWWi9ZQnB1?=
 =?utf-8?B?WXFzNVZRbjBGSlFOVkhZeVFiWkxuVFoxbTZ6Qm82L2UzRk1ORTZqZEtvT2Zn?=
 =?utf-8?B?OUtZWlBRd1BvcnNIM3orcXhFQm9ZL3J2TDdZb3RnNjluVFcrSTIwTVFRNXRW?=
 =?utf-8?B?bDBNVjVraXlFNG04NlNNRXN4R1ZrRzBEenNSeDhleWxreUhnaDVKZmRTTkZj?=
 =?utf-8?B?dUlkTFR3ajNkYUphRDUwSWVxYkZRK0thOGdKTHFjRk8zL0xaTGlkVy9aM3N0?=
 =?utf-8?B?c3Z1QWkwaldjb0ZUaHZDSDFZOXMycE5randlOGZtM1prWW1nRHBHS281YnNu?=
 =?utf-8?B?TldKWmI5NHRCWnJ5UFR2WUU5Rjd3N2pCei9WS3JVUndHRzBPNHV1RklGY3Bj?=
 =?utf-8?B?cDA2R2hYL3NMUHlNbk90VUVBbThnPT0=?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad9e5cad-2fe2-4d78-fdce-08ddc0618bf8
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2025 09:58:55.0302 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZyE7vUDSphqJBQBUfdm1SBBWrG4uDeHlz/QzdK/xAG+9RVp4bQPkVapOy4EfSxWPAkV67fGHRg/LmC0fleEG4nbF6AYU3nuw6Dn9Q1Brvwg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR02MB7918
X-Proofpoint-ORIG-GUID: iGW5O4ZQq88qTu96_qkaoZ5w6FPibly2
X-Proofpoint-GUID: iGW5O4ZQq88qTu96_qkaoZ5w6FPibly2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzExMDA3MCBTYWx0ZWRfXyqqV4BZfZM+5
 2jInVa+HTVlLKX96brUlJ9Jxi4Rl0fjeRl2kQMjBHzJITLeEIXCDH5wXRVlTSXwFsPaWVpx8T/G
 w+rlkwcrLd0FxrJsOgalopVOs/zMa0/SVUiVBbvuqjqhUMuSmb/AwT1zcMVB510C25UeO3FOsnq
 35hwipsJHKu4tFmlx5b2QgmXrD1LKcJYD0p5yyQBAJdXhLMXWISmdGLfQPBGZ1+iFmgBbPCqrW7
 3/XO12iz/0UHdH88xP5ZbR0VaCesoRJ1M5aLo0F/N7rimaLFgHJ9xEuCuSrzbPiGziwduLlFNjb
 Jisp+Tv+Ef80mkyA75fca1e4x2KxhuU639F7bPl1fnZwmEO1Z6tIrSgGHGQnnuF0SflW/DKkXTk
 JOvRAGW28Pv74UH9/BJ/VNGFqLjbxCr8nY5doh9Oe1jPZy6MzrVIRNnkhKAxMPpLjPhlEdi6
X-Authority-Analysis: v=2.4 cv=fNg53Yae c=1 sm=1 tr=0 ts=6870e060 cx=c_pps
 a=VIP9IjDh2lSQMlgnK/Goww==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=0kUYKlekyDsA:10
 a=64Cc0HZtAAAA:8 a=KKAkSRfTAAAA:8 a=_jvWDQGc8cL8bECqUo4A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-11_03,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

This function contains 'assert(PC_MACHINE_GET_CLASS(pcms)->pci_enabled)' and so we can
safely assume that it should never be used for the isapc machine.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/i386/pc_piix.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index f64588f01c..27dfdd5403 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -466,7 +466,6 @@ static void pc_init_isa(MachineState *machine)
         assert(machine->ram_size == x86ms->below_4g_mem_size +
                                     x86ms->above_4g_mem_size);
 
-        pc_system_flash_cleanup_unused(pcms);
         if (machine->kernel_filename != NULL) {
             /* For xen HVM direct kernel boot, load linux here */
             xen_load_linux(pcms);
-- 
2.43.0


