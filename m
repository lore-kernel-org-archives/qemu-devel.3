Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17B0FC83F1A
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Jul 2025 10:06:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uaAXi-00073U-Ky; Fri, 11 Jul 2025 05:59:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1uaAX2-0006KA-Vd
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 05:59:06 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1uaAX0-0004sg-C8
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 05:59:04 -0400
Received: from pps.filterd (m0127844.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56B8IvJe032537;
 Fri, 11 Jul 2025 02:59:00 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=CIhq3sEB2yI/CMMEkbdmSiHQ8G3kxB26U9Eq0zCx2
 +w=; b=2fguUYvl602CgtWK1hJORaiR/8gBo0aaRI3/15OzhGHEdqE7RfgHX8V2f
 gTdPe1x1N1n/3kk65NXqBzxbRcDhURwOB3IT0+XyKH4Frd9jZ/hpiYWMRx2AZAc5
 tcVKYcEYtAJ7FWdBuH4Mf2JvvEnT+bseNKAvW5u2rfWj5L10X157kZRam66c4qja
 zk4ZJaFZBpDFQdVhIcFWvfaecYSJmTze1fXulGmDIbbNnpL86c/q+cMy0ymuJV/E
 t933gIUdiJmgNBTLdKQm/7PnDgd3567HyBGaI3bxszvsGjPQmaPWtNPVEIMtS2OO
 eUMJ6RMtRiZlyQm9HFZYyIYo+nadA==
Received: from nam11-co1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2128.outbound.protection.outlook.com [40.107.220.128])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 47q3k38m3d-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 11 Jul 2025 02:59:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iJUYeH1T46fe+/8wJGPSXnLaBNHdmxOfgJEEPVdwMMgwAGPIvPUA76+m/a6mbdn74Qf/E5muYrB4mb+ITdLIgtNHpcD3v5u2BjeeL3nxNX5sdyjwvliNQgNji9quqv221g918r2XcJxrQRIhIJD7qcmfv3Iyaf0adS1fkGmhYp4WZ8wvUv/DY/Okip3QJJcirwWO7GSfg8iu00ndKXHMCsob0QxA/BwXkc1nZ4XtwiscPahrKkUWfLYiULDsmUeyfKS2KcZC5CvgQq+5uhvoL+109xyyqMXr9KiEy/p5DtwmYHfztB+n46cOm/gdEE81dN94nM3ejqDC6od2FCxutg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CIhq3sEB2yI/CMMEkbdmSiHQ8G3kxB26U9Eq0zCx2+w=;
 b=tRhcBE5U+YwO/JorqwzEKHG04uE8CgOt7kbe/URfzyV2XS9e9ENVH7Kh+k98XGgfLbHakK3y62+kC4nYW4PAd3GmjppjnxZ226MviJ7TRwhlY+ZaeMMcKJeO/qpqNkByhUBaJysvl3n++PZGYR6Y/wVyK1hcxtC1mbwbbul0BaxaSCzsXhnZnHCzyeyYZxPfgwCiNzpUWpwh4g8Th4phBqhJeF9x/9/X7iRdbJ7KyUxkQEDkLrR+D8DDSKZEtJiDLG0y8+cjU07iPvmqbxbKK6JF6r8nIcCw3MQNfSmcc2D2yMs246dkm0XKtN5kwjzHpRocg+IxT9NklP4+JHZj0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CIhq3sEB2yI/CMMEkbdmSiHQ8G3kxB26U9Eq0zCx2+w=;
 b=nqoZd/vrGdZnbFj+szGwtADFMEKh7LurnpEemBw5bVf+vJvyghPFEh7bYFtzYQxUR34aOVcyddo2mnYTh1AHFN/5ad9X9Y3vM4ol6VKegZ52ASqKPeTCID1WxFDNiUjtMoZnPZcGj/WnS64E2mG1OzUVCiWFLmpxAdad/Q72mGYRvfXziJVOGdKXi6djaznj1hO8At+jB4GHG9Zw+TnNKJl7kEM+zkywRpn0H9zGAsdexiTXsY6SbBoFj6pFzGE+gp8i+pz3N+fWe82jZRDeuKw1JLEerJRTRXnkMpSRUeYRZXfKi9h2Vn/9Rtu+08bGO9/xCAyLkQJvSMkrctB4UQ==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by BN0PR02MB7918.namprd02.prod.outlook.com (2603:10b6:408:161::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.25; Fri, 11 Jul
 2025 09:58:58 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88%5]) with mapi id 15.20.8901.028; Fri, 11 Jul 2025
 09:58:58 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: pbonzini@redhat.com, mst@redhat.com, marcel.apfelbaum@gmail.com,
 eduardo@habkost.net, imammedo@redhat.com, qemu-devel@nongnu.org
Subject: [PATCH v5 12/19] hw/i386/pc_piix.c: always initialise ISA IDE drives
 in pc_init_isa()
Date: Fri, 11 Jul 2025 10:57:14 +0100
Message-ID: <20250711095812.543857-13-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250711095812.543857-1-mark.caveayland@nutanix.com>
References: <20250711095812.543857-1-mark.caveayland@nutanix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0038.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:152::7) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|BN0PR02MB7918:EE_
X-MS-Office365-Filtering-Correlation-Id: c810561a-09a2-4f16-3050-08ddc0618dd8
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0; ARA:13230040|376014|1800799024|366016|10070799003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aU81eWhPQXQvSCtqYUpJR1JCSFdYUVJrOVV1cTNtc05jSHljdmFxRFlKYWdI?=
 =?utf-8?B?MGl2L0Q5cnNBZWRsODlpdy9jRHhoL0RLdGg4bjNINW1zUG5DcnhuVW5uM1Vl?=
 =?utf-8?B?RHJUdGhOeHIzeER1NVIvd2FodzdaUmt4eFU4bEFsUHNXUUtOa2F2YkF1UHIy?=
 =?utf-8?B?em5nZlYzcnV3MXdmYjBsMGFjZUs3bTFIVVppL1kxNDI3R3RYU01SaGdrblZM?=
 =?utf-8?B?U0k3cHpaN0RNVS9kUXZJREhEZ0VSQXZPWkVNVWovRHJHMEVTVEhRcEp4Y25n?=
 =?utf-8?B?Mmg0azVKTktKMnVETWRhcXlWK0hOcmtIc2dRSmMzRXBwc2xMeHovKzJMZFpD?=
 =?utf-8?B?WGJWb05EdzNpaFBOTlpBaEJlYjVDMmlPbTlkcUNRanFGZnBuVk9vWUoxNjFT?=
 =?utf-8?B?TlpKcVMrYmUxK3hCOTI4c284WVBrMVM1WUwrYWttV1NiTngrRzdQeDhNQy91?=
 =?utf-8?B?TWwwaGFFSmZCSm5KRmt4MzFLbU1DckpXdnRKN044ZktETUNZTGJWRXoyMVRl?=
 =?utf-8?B?TUNDdWJrNFFYREg5K3FFTUNPL0ZraFd4VUJzUkRaMW1PRlZXUWR4Y01Ialls?=
 =?utf-8?B?U2FCMDRnVkpxdU5JWnRsUDVLOWs2SXdCVFpjTGJLSm5SaC9vYzBpbVpRT0d6?=
 =?utf-8?B?RGN6MGJjdDYreHBqWHA5VTFjT0dLN1RGeGtVKytSdWNjRVZVdzZ3enJlb0ht?=
 =?utf-8?B?eEZjSElRUU9seVJ3aVpHN081TGdwblFINmlUb0VlbDRzVkszTUZOcEZSZ2sz?=
 =?utf-8?B?WWJmU2hGUlhvYk5vVldnMVY4NkN3b3NlbDVJRVJpZmtORDArUksyN21FNWFC?=
 =?utf-8?B?citlS0dTSTZwcEI4MHM0S0dpTGdXL2JRUkR4Z3V0RHptaGxabHJjWW96b2tw?=
 =?utf-8?B?R3AvQ0hNNmhyL2xhdjNsME53L3ZpN0tKQ09adWpnL3V4U21CQW0rYzFmYUJm?=
 =?utf-8?B?M0k5Zld1TjVGU3ZPSFc5b2htZHdXQVBTMWdvQ01uc0FkN3JsaHY0MHNrVEpO?=
 =?utf-8?B?QVpVcTFGQXhYUEJuN3JNV1hmOVF3blZkYmZZa0tsMzI1SHhWdTlkeXlkZ0pv?=
 =?utf-8?B?QnhrMDRUbnVHQWtoUVVSZExOelpWMjFHc0FKdy9ONUpLSCt3UlZaRGFhczBY?=
 =?utf-8?B?alhRQ2dYaDRhUWw1NnRjU1BOdzE4aFN4TE5wdTZsOVlncERXdWE5VlQ4UHJS?=
 =?utf-8?B?MmpDQ1RscWJOYUg2TU1STVAyVVp1VUlzOEQrRWdCU2ZUMUxqMDFVNWlhakpJ?=
 =?utf-8?B?M1hSR1JlLzNiYklhaFRqVTJzWGRHNEx5VG00TnpKaXFpMU5nSStZSGtwZUZi?=
 =?utf-8?B?UUQvUHJ6bmVhVHlSYllKc3ovNVh1K0VQelVKWGZZL3pDbmhoNFdNU1VpdlR3?=
 =?utf-8?B?dk52TGxnc256ZDd1MVZHVmdzUncwT3JGM2MwemtiOHZvdUQyYnlLS3Q5WHN6?=
 =?utf-8?B?NU1pTWRSbE0zNzJ0SC9xR2kxRG0ycHNFdG03a3FhYllna1lQZzJRYjJqeExo?=
 =?utf-8?B?UUI3VUU2WW02b00rZGY3WDdTSm94UkloSFhPYkp2YzhqSkczK0N5Z05CVTBI?=
 =?utf-8?B?NkUyT3UxVFlhSjJFUVRqVGMxTUpNR3FaUjNiamUyMEkxZDd6MTVHVWgyWGps?=
 =?utf-8?B?cnlMbi85bVUxVERYaXZISzBuaXNUNm1aTWpBeUhLMW5HbTkzWnlZVkxKOFV4?=
 =?utf-8?B?VWY2SFBDbFpGbldtWDh0QVRyY1JaYnhBSEhhQkxwRjdDUGZTa0JCMUxkeDNk?=
 =?utf-8?B?alpNNzlDMmVQa1BJNDloK0xvSnJQWFJETFhHT0ZieHQxSVFtTmp2ak9zaUJr?=
 =?utf-8?B?N2hqUE1RT0hESVpkWUpHUlBzZGk1ZG02aDJDZkEvdllkdTNUWkRkRVpSamVq?=
 =?utf-8?B?alN1NnhXTmlQZTdXOWUzcUF3RW9QMmhWd25MbjBPZWdaY2xYeGlncU9QdS9Q?=
 =?utf-8?Q?WYZBuF0t0sE=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(10070799003); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UC9qeG9RcWxMU1VONTVzdmdNSlZ3TTROTFhadFhTQVk5TEd0VUNmVE54R25i?=
 =?utf-8?B?NXl5NzdEWUY5OHRKQXoyb1MrM3JHYWV4UlIwa2gvbXFpZUZCdjZaVjYvSkVz?=
 =?utf-8?B?MlorYzhUYWtMYTYrbi92NXNiYzlSeFUrUFozcWdDTk11MzBvdzZ3Q0ZRd2xT?=
 =?utf-8?B?N3IrUUpPcVdwVnVRQ0hnREdRNkZZbnE2MW54T2dzTGsrSHVJMU9WeXkzSXdV?=
 =?utf-8?B?TnF1WmhXbUN6TlgzZW5kU3NjNmZkTGhHOHg2K2R6VlZyRWZKbmJBdzFHdjQ1?=
 =?utf-8?B?OWFSbnQrWFRTbmk5TDlKbHNzOHFVWXdRRWtKK3VuTDZvMjJJZi83SkN0QUo1?=
 =?utf-8?B?blhTbTZkRFQyaWVlN1JvdVVJOXN4TTZpRnBOYzVma0tTUitMZXVEbkJYQzl3?=
 =?utf-8?B?TUR0dkJsNXpwRjNuRlNmU3E0eERIeDFMeHlQR281QkREbTBsUFp0cVN0dTRh?=
 =?utf-8?B?cUlNV2xKMEtoS3JNaTZyUVpBU0NSS29CamlSVThDcHU4bnNZeFdObWRwb2R0?=
 =?utf-8?B?aWRYYURLWFlJVkFqMTNZZUpzQWQ3SFRxaEp6TmRzTmpPSGJ2Q1NNOCtaSnBt?=
 =?utf-8?B?YXN1TW9kRWxFcllvSFJ3dXQ5QVJiRmpjdnY0RkhjZ2s1MmxCL3lkOGdsR3Y2?=
 =?utf-8?B?Y1VUVmo1dVJzd1RBekRzbVRoU3o1Q29aZndrSlVsQURzN3NhSCtmdndTK1g1?=
 =?utf-8?B?Nk44SU83UExpLzhjcmhjSjJDNnZZcERuSWltMGVLVUtFRm0vUnZPOFZPODBp?=
 =?utf-8?B?QUVZV3lVVkhzS2RBSmdXREkwdy92c0FsOUlwNFVRak0zMHBWc0FFUk5mc2pT?=
 =?utf-8?B?eXA4SFAwdjdEN3NSLzdTNnN5ZmRVVzNtSzFqUlg4ODZUczVpVllGendVby8w?=
 =?utf-8?B?bURZQ1FxQUdnc21QSmhhek5kOEljZkJlc0dJb0JOZHVJU0JKMlJ3Um0yTXdw?=
 =?utf-8?B?R0RNNXB5WDJFZUoveXBhWFpSbVROTHR4cCtCUmlZY1RjMUtJWDllSFNZbmha?=
 =?utf-8?B?THM4OW1DaTZNdXFPUHpuamJoeWIyNitKUms1elhDR3JxMTNHMFBPaXk2M29T?=
 =?utf-8?B?ZmxKYUZkaDlZSmFjUmNvaTRteVlBVHpjN3p3Q2c2YUdBSFBZTGUvSXZ3M1Q0?=
 =?utf-8?B?d2FleU9VMXZ3bmQ4QmFHaklnWUVtVjR5Ky9OaVNWL0YvMDJoTXByK05idFJa?=
 =?utf-8?B?UXFjb01MQkV0aytuN3Z3K0Q0OVV3bnpybG9OcXU3WE1kUUUyU2xOSjVlbnBH?=
 =?utf-8?B?Y1BjZFJDRnpLWGlCcXFBQVM4UHB2RWpPTmxqS0JoYzdCK2loQSszaHl5VHNO?=
 =?utf-8?B?Y0RrN1NYREhySjFDdzN5KzRsK1BTTE1DTVVQNmdpaG5sbFFzL3dhb0l0ODd1?=
 =?utf-8?B?RTBxWUNrdXJyTzdvWU1PdTQyYU93c1ovdUV2Qlc4TDhwZkNMT1NVTmdBTjUz?=
 =?utf-8?B?S3JHTVlGdjNkT0hRajZ6Z3NJNDdrMS8yUkJzR0syUHU2Q0ZyVGVPVnJUOUlW?=
 =?utf-8?B?MmpoU3hmeE51UCtidzVuaTluOGlMd1ZHWTEwZnEra3hnMUF4Ynh3V0hXcktU?=
 =?utf-8?B?TWJ5cW0yNzkxK1d1RllrV1NqbkN1bTFTM1F0YTBqWmF4eTRURVNOVE1OaThk?=
 =?utf-8?B?MVZKQWozRmpSanNncEN3SURSbldYZjVDMjRITnZOWUtUVy8raW93KzQzdTBE?=
 =?utf-8?B?dFZZSUdBODROTWlQQjRzSHBoQzZUMHpCWWFSeGJRdGVjY2haTVpUc0VGNHZu?=
 =?utf-8?B?dU5DenhyK0lSdUZYeHQ4WmxnOHVNSTFjSzNJU1dDcktMdU50Z0JYS2Z4K3lR?=
 =?utf-8?B?VWROV0JrY0Q3b3BvRHNQNW02aSs3dnpkUTZVMDAyV21ac3hDajZtam9sbE41?=
 =?utf-8?B?aFZ4Y3N4TXJiOVJvWWE3UVBKMk5OMTNVSmk5eHBXdjhPZXI5WWJhd3k2bWNO?=
 =?utf-8?B?cUkvdkIxZ1RCekx2ZHFLbGpXTncwdXZvQVNTQTlaVEZNRGFtc0Exc1VtblVE?=
 =?utf-8?B?cGgydlI2T1hmeGZGQU0ybmhkSFA0blZlQ1pFYm5Tb2FpVjE3RDRVOUo5RWlz?=
 =?utf-8?B?VnUwT1BEQ0JZay9iazR4eWJ4QnJNcmwzK0gxUDNOR0grQUxWWVBSdnNTazVk?=
 =?utf-8?B?Yk9QaTFuU0hmTHRlYTRQVTVNWExWcm1FaFh1Y0Vvc3pqa1JKNzVlNHBUMVUz?=
 =?utf-8?B?Q0R0ZTlnNzlxNWFPanV4VXlmU21NVCtVMUJ4dVo0VE0rMlBSYk50SlkyRTE2?=
 =?utf-8?B?elN1WW8rUXVkQWJoOS9BVWVXNjhRPT0=?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c810561a-09a2-4f16-3050-08ddc0618dd8
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2025 09:58:58.1374 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BnWfbZvqP4Pj86CKwu39bPhjygntGTe8PIBx5pM34pu9ShAedQeLU28IraM+758FDnVgwdHR+l10dW5nzJPBqR7l9g0lBFmvlM1V7fs1i7E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR02MB7918
X-Authority-Analysis: v=2.4 cv=UNDdHDfy c=1 sm=1 tr=0 ts=6870e064 cx=c_pps
 a=JpZts7cEBrfcwmRlVwBwFQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=0kUYKlekyDsA:10
 a=64Cc0HZtAAAA:8 a=KKAkSRfTAAAA:8 a=qN5ve3sCTOSH2ZO3jx4A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: q-RV746e0NpZCZ0mZCUWUCDNVTir65Mk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzExMDA3MCBTYWx0ZWRfXzph6hWJLfpEQ
 c3yn7048soyU2D3G40Bk3ExhO4B3BW6Amb+ZWNJ/IA5p7mjifPkxUqrjqkszuhswOjEEO/iUtsJ
 Qdg7DSCmZ8YoNhIXVIbrANlWUUqTaNtIUKrtDcIbAhr3yc6vL4PMbmHa5WCAl3bQmATQTNFYmU6
 HEauCpt5ZQgKoGmjqQJ3j7IEy6jSh0hbRCcKlQFU5tCFu978yONNfwxibnHYF9nkLhneEbj3VpG
 JAjlXZDvGV0CB1ZtsQeKnT8nfXA1HpFRpEitTtt83iPd4zNQUTVRVFY0a8e2PF/VShM7wn9Ih/0
 WkWxIOClYsHceAXUei9Ml1eT3jIkZpvIvH6IaytTS/kF0kE+4iNONRqf0J5VQ1tT1IC4/EWK93h
 hChzCVQlSLtMyC1C0EOzTqEmwKk0Nhriq/VNvOblRV7e7vokBR2ueJs+4s7Un/MaaII4sYwX
X-Proofpoint-GUID: q-RV746e0NpZCZ0mZCUWUCDNVTir65Mk
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

By definition an isapc machine must always use ISA IDE drives so ensure that they
are always enabled. At the same time also remove the surrounding CONFIG_IDE_ISA
define since it will be enabled via the ISAPC Kconfig.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/i386/pc_piix.c | 35 +++++++++++++++--------------------
 1 file changed, 15 insertions(+), 20 deletions(-)

diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index 27dfdd5403..59c2949379 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -426,6 +426,8 @@ static void pc_init_isa(MachineState *machine)
     GSIState *gsi_state;
     MemoryRegion *ram_memory;
     MemoryRegion *rom_memory = system_memory;
+    DriveInfo *hd[MAX_IDE_BUS * MAX_IDE_DEVS];
+    int i;
 
     /*
      * There is no RAM split for the isapc machine
@@ -501,27 +503,20 @@ static void pc_init_isa(MachineState *machine)
 
     pc_nic_init(pcmc, isa_bus, pcms->pcibus);
 
-#ifdef CONFIG_IDE_ISA
-    if (!pcmc->pci_enabled) {
-        DriveInfo *hd[MAX_IDE_BUS * MAX_IDE_DEVS];
-        int i;
-
-        ide_drive_get(hd, ARRAY_SIZE(hd));
-        for (i = 0; i < MAX_IDE_BUS; i++) {
-            ISADevice *dev;
-            char busname[] = "ide.0";
-            dev = isa_ide_init(isa_bus, ide_iobase[i], ide_iobase2[i],
-                               ide_irq[i],
-                               hd[MAX_IDE_DEVS * i], hd[MAX_IDE_DEVS * i + 1]);
-            /*
-             * The ide bus name is ide.0 for the first bus and ide.1 for the
-             * second one.
-             */
-            busname[4] = '0' + i;
-            pcms->idebus[i] = qdev_get_child_bus(DEVICE(dev), busname);
-        }
+    ide_drive_get(hd, ARRAY_SIZE(hd));
+    for (i = 0; i < MAX_IDE_BUS; i++) {
+        ISADevice *dev;
+        char busname[] = "ide.0";
+        dev = isa_ide_init(isa_bus, ide_iobase[i], ide_iobase2[i],
+                            ide_irq[i],
+                            hd[MAX_IDE_DEVS * i], hd[MAX_IDE_DEVS * i + 1]);
+        /*
+         * The ide bus name is ide.0 for the first bus and ide.1 for the
+         * second one.
+         */
+        busname[4] = '0' + i;
+        pcms->idebus[i] = qdev_get_child_bus(DEVICE(dev), busname);
     }
-#endif
 }
 #endif
 
-- 
2.43.0


