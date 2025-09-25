Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64CE0CAC5B0
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Sep 2025 11:38:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1kEo-00075m-W6; Thu, 25 Sep 2025 07:34:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1v1kDj-0006YY-TF; Thu, 25 Sep 2025 07:33:11 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1v1kDZ-0008Mc-7T; Thu, 25 Sep 2025 07:33:04 -0400
Received: from pps.filterd (m0127841.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 58P8WwfB157614; Thu, 25 Sep 2025 04:32:46 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=NWXud3PZzNSCijLe2peUhzVmLuoQJg1W7deUj6LN+
 Qc=; b=iJmQNGt+M2WnaRk++sV3/e0WuZFVom7wQqNnNsrQkt551NBweUqoVuN0X
 ufU0eUs9+pHM6HbZVgEKR6HkS2bEdC2Z/bYIR07DWEAJ7ir0LNF+6UnMULCroJud
 kjGxTgBoq/RyNZvfu3huEClCHhi5JRHrQlVutEBIcpd/SjTRofuFMnFTAatwmGC9
 Vxkckh65swpKiqlouG+klp5zWWNAd95pOf83wp7jrk7jYbB7HvFynbxLKZVMP9+p
 0Id6lZTg1NcsDtscbYuBgX0MeKiK0O7U/nYrmI1yBxd9dxU1Xq+zhPNj/86/H3x7
 lUOeQWroOv1NItpg+hfYWPbMvCHGA==
Received: from ph0pr06cu001.outbound.protection.outlook.com
 (mail-westus3azon11021136.outbound.protection.outlook.com [40.107.208.136])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 49d2aprcdu-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 25 Sep 2025 04:32:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Uy9ZprtnRMUZyqqYjlO2FZCGqSFwYJUUxv6kr7PR9+5Va0CYz3zJT3fIh+UUnIB6bNzIzbmCG1xqwJZr3VWZH1Oaenqu5ht+L65a+4AnvQgsupbcZ/Eu5WSvVRJgCqQgIRMBZJ2Majw+xVHh52+xFgIpmTb6UWpIYmkzMV5zl01zW9JJhQPWKCj4ZTVB2Ti+sMlaK6UdDMFxBbDk/zSrDQZwqSPgBHMi69Vy071VWfgq1atNhVuNFwWa3uP+3nR8j+ugS4OcrKvGri66O+OzXxiNKQHkTGDPQ/kzrift8sS+H4dORsTVgXDLRXFHAxtiElW8/WERoDDlJ+pdBneH7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NWXud3PZzNSCijLe2peUhzVmLuoQJg1W7deUj6LN+Qc=;
 b=ydo1MEMo3twTeQRoFtIrWuCHNNtWPaBh4kyQ3PqdL22nn4l3SFT4Grg3p5AtQbAwY3miPbDaqRJDHLp/iOnZ+0cYj+8WVftDv+W9nlyOQtoYdo7a3F2DkyGjUuPlrGuCeGyiXNHjEczZXdfU8cUd4zxjaswGqR6NtYfZURLCgNHi8ZRSoAsw6iONM8LgM68W3rKobnwARI740sJS+HZPY/Sr5gZYrNbtaq0s4c7vMDvwIEYIK7DJvru8t+iYR3pr3SdEYUGzFgmm1EnUllT/AO+4tH98KZd/0eSlW+dZaeJdUB+85MwJm0x/f5qLnV4Va5lodTI4poebd1GKheq2lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NWXud3PZzNSCijLe2peUhzVmLuoQJg1W7deUj6LN+Qc=;
 b=wsv8jQa8E0K8hQCsAtbcKyDHkGbFyTQz0WbCBHnnf7BOS5NG98ap1rmfRbztdWj91rfuYH2oFZaZWlO7y+Oojkz2Wq0QH+S+VENjt7sSZFHDCl0ORALoD2bem+xi3QQTxlCsv5G/a/ggh2zC6MWlO815Q9S28vTDOW+0N4yjx1NEgR1Yk0lvvlKU9IEXTyXMCLemruHa2JZBlFMzKwUbUj/te7EhXtWE0/go/nGAwETQ1EWz8ae3+KN+8UHoqnxX/pyob5kgCdJKRm3PnJP0V/UWHS7F4aOVFbOaZwq6jMEV7qJIWnYGMGOdXYsghXllwohyVB1qpVh5PSkQV59gDw==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by IA0PR02MB9854.namprd02.prod.outlook.com (2603:10b6:208:483::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.9; Thu, 25 Sep
 2025 11:32:44 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88%3]) with mapi id 15.20.9160.010; Thu, 25 Sep 2025
 11:32:44 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: npiggin@gmail.com, harshpb@linux.ibm.com, mjrosato@linux.ibm.com,
 farman@linux.ibm.com, pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 thuth@redhat.com, richard.henderson@linaro.org, david@redhat.com,
 iii@linux.ibm.com, john.levon@nutanix.com, thanos.makatos@nutanix.com,
 clg@redhat.com, alex.williamson@redhat.com, steven.sistare@oracle.com,
 qemu-ppc@nongnu.org, qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Subject: [PATCH v2 12/28] vfio/pci.c: rename vfio_instance_init() to
 vfio_pci_init()
Date: Thu, 25 Sep 2025 12:31:20 +0100
Message-ID: <20250925113159.1760317-13-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250925113159.1760317-1-mark.caveayland@nutanix.com>
References: <20250925113159.1760317-1-mark.caveayland@nutanix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P265CA0279.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:37a::18) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|IA0PR02MB9854:EE_
X-MS-Office365-Filtering-Correlation-Id: b1a91ef0-c1b7-419f-b2e4-08ddfc273eba
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|1800799024|366016|376014|10070799003|921020; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZXRPdEdjWGYwR1huMUFqZnJqczZkWVhDdVhzalpxbGZHMU5zRDk4dk4vNC9p?=
 =?utf-8?B?cTNWeUFneWlIZHZVSmJNalVONVIrSXlQZVV2eXpnUEVOT0FJVWVSdzRIbHA0?=
 =?utf-8?B?QkJ0K2R5RkZ5ZWNkbDBVc3BWbTNwSDVyMjhXS0x4alU3KzJKMHMzbTFuQll2?=
 =?utf-8?B?UEpLS3pXN2p4b2hXWkdITnk3SnhwL3JiR0FXZnMxemcxbU51dk9Rcmh4QURa?=
 =?utf-8?B?WUpaQWxqdEpRVXcwZGJGcWlDN0pUNWpHa1o3OVpaUlVuMFVCR01Yb1Q4Smdy?=
 =?utf-8?B?dWhXY2JhdElYVmxiZHVhZXVrMXpxSno1dkNQUTZGS0NNTUoxOHRpOW44Zk1z?=
 =?utf-8?B?VGVwckc2UFlZSEZxM1MrbDFGQTk3ZVFCM2xnOEtRc25HQ1ZMMjlSbDBuUTB4?=
 =?utf-8?B?R2d5TnQ5Y0svdDdnY0Z0NFRSSHV6N3lsKzA4OVdKQXRGdjBKZnE4UEk3U2wz?=
 =?utf-8?B?NXpmQTNoSXpYVTdSS05oUTNMdTIveHpVTzhKR0FleDM1UVByU0VDMUowbVV1?=
 =?utf-8?B?QUJmMndBVWhGZDk2VVRxL0hwWEI4b2pJcEp2UkM4alp4SmhBUER6dkRmRFk0?=
 =?utf-8?B?bjJLQXprNEk1dllhLzJLTVR2Q0lPYUhiUFM4RFBEZU5mVDc0TWFiWXlGOERi?=
 =?utf-8?B?RU9uMzNBYTNpYlJwMWl5c2lJWTZXSG5DQThkdVBkQy84anBjS2R1cDBRajhC?=
 =?utf-8?B?VXV3dnF3RTNGOE4wa25HY3BCcmdiTEpBTDNRNnFqd2NmTTFPN1dSMUk4QUZB?=
 =?utf-8?B?a0grNVdZN3psTVlNbXowNGlPQ0hiS2JOaUpHR0NXSFpTSkoxR1FYRXIyNjNB?=
 =?utf-8?B?bld1UjMxZUlUUzFkNk5HVGJ2T2tmdGtvY2VwUjRsSVJmaFNxczhqbXYwOCtu?=
 =?utf-8?B?Y0dIeUJDaU5aYm1wTVZON3kxUjdXTHlSaFE0eVQxK2g5SjNrYmNKeERBNU1U?=
 =?utf-8?B?Yk9oM0p5aGhlQytXekVTbFhxdExmUWYzN3FaTFhITHdhSG12SE15VXNwbE13?=
 =?utf-8?B?ZzVRSW12VzQzVDRwZTBHYkh0ekFPQXIwTm1XV0NJbkhremJURW5IRkFsR1Uy?=
 =?utf-8?B?anlBbW4rS0dxbGRVOWxTTGhraUVFSTBpb0NqbVNaZWhvdWxBM1pUZ0xPNXNE?=
 =?utf-8?B?eks4YXliVmY1VE5PdkcvVnZOY284ZVg3cmR4ZEVnTkpkQVFQWjEyQkc0MTNX?=
 =?utf-8?B?dVNDSEZEY05UUm9hWk1WQ1A4aU5kUEZXN0FNZCtNMVBtWjZ0MFRMRkU2NVZW?=
 =?utf-8?B?dzQrbGVhcmppUkNQTVZ5RUJGZGUwWlJESS9UNm90RGE5UnRPbUg5MWphT2Fu?=
 =?utf-8?B?RTFPMGZJWEhZb3JLM2U3ZXlkNDBwZ1c4aEQ1NlNFc3hCeG1Kd2xKbk94L1RJ?=
 =?utf-8?B?cVg0b0pLNHdyTWh0a25YU2ZTMW93cDZIbTdSZVFlcC9xY29CK2hBclFGcUE2?=
 =?utf-8?B?VkNxcUJ6V0F5eVRrd0p6V3dOOVVYTzZSUU9EZ080TXM0MWxHREplWmgxb0Rk?=
 =?utf-8?B?Qk1WcWw5TFFTYnhXNmp1VDBVdzBjNURaN05BU09XRmtMeEZFQmhiMEY5UVZw?=
 =?utf-8?B?Rll1K05ORFFQbEpvcE5SMnA5eW5CYkFhU0xmQ1VKNDkyaUg1VTdBcnBYSmNZ?=
 =?utf-8?B?eGFIU1k1UjFPMk9Hem9tR3BlZTgzcUt3THdjMGZmN2U3ZGVRSGhsanNaWjJm?=
 =?utf-8?B?VFk2UnBoa0Z6ZHFuMDhEVmNQcTFZMjNWUjRzalJrT2VHMnJnQkhLaCs5Z0F0?=
 =?utf-8?B?UFFtcFN1RkFoUjhvOEhqbEpicUVCbWFndlNLWkNaWW8ybzloZmx4clRMeEFn?=
 =?utf-8?B?TzVUci9DWkxyOEdIdFE2Q2lyWGY4bGVwU2E2K05sVmlGdUtFOEYwN2lqR1Nw?=
 =?utf-8?B?R1U3R2Nlb3NNNjN6U294WEFISTFVeTQ3YUtqOThEdXpsalQyWFNBNWFJUUFx?=
 =?utf-8?B?akNBaUlBRDRBUnlrZ2FrNXV1UGl6NHhFVW5vTkdwNEZIRytndDQ5Qnc2TXVG?=
 =?utf-8?Q?/n9yHx6tSSuchZfzo4MuC3wb2jjSys=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(1800799024)(366016)(376014)(10070799003)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aUgxK1ZKU3FTNE1MNmJSeTJCb0ZrcTF1YlFMR3F4U0EzUERhdmJPTnVWaHBE?=
 =?utf-8?B?TGVKTitRdjF3NVdUbGJDTDE0cExNU0NLYTNoRmc3MXpWVXYxRStkMVhMQTE1?=
 =?utf-8?B?anJ1MVNQZElEdy95NzRVNzhBTVdIRXBpRXdRTDVtS25Tc0RRUG9JVmdLa0Vl?=
 =?utf-8?B?MUVhM2ZQQ1RhaTdoUG9QaXRrUkJQeERIbzNMd0UxME5XYlp3bjN5MkZ6OFQ0?=
 =?utf-8?B?UnYydnZoNy80eS9VTVpoNmYzUXlEQlJUcmRIa2ZGZmdORGsxRzhwSld5bkdo?=
 =?utf-8?B?TmRWMGxjaVJ6WnlQWWx1ODFUNDdzRzlWdFRBVWtKU3M3a1JpWU9PenlLa0s0?=
 =?utf-8?B?em51YnhxU0NscURUWmtyWVZlNmlMU0J2RytjWGRFVXNNWmhlYmN1VDBBUEhQ?=
 =?utf-8?B?WHVnWmpWa3RJSnZ6cXk2WjBGOW5RNTVUd1dKVHAvRW1OSE9hcEw0WVRTeVoz?=
 =?utf-8?B?OTkvdVcwbUg2NHNjL210TFJ6V3Y3cWNZNjNGLzVtSXhIeVF6NkJXazhvNVd5?=
 =?utf-8?B?MHBGalQyTVYxZ2dPcm5QdlNzN2JabVhocTNycVl6Tzk3WHljMDE1WVVUOHJW?=
 =?utf-8?B?TDZVTnkvMG9IRC9XRDBZcDVOczl1MmVaaVFtZ3ROQVk5dWl3VDRpMGc1UjNJ?=
 =?utf-8?B?cnBlVDVCWnl5ck9FVExuMGdzSzNrRFU2c1M5c0Q4cEMrQjNlRXpCcTIzWHBx?=
 =?utf-8?B?NGJHRjBhazNOSWUzQS8waXdPUnlVZEdvYm5lZTNYNzRhalRXbWtxaUJjQ1g5?=
 =?utf-8?B?RjhmeHNNL2NBYW1RNUVxd2JzR2h2WUErMU9rTC9qc0dDMGRlQzNGSSthNlVV?=
 =?utf-8?B?OUlLZ0pGTGVMK1J0K0ZVZExHSXYxd2hYVFNHcUtselJycU54VUlvUGRUb2pK?=
 =?utf-8?B?Vi9sUTZSczR0c3l5Zm5LODRiVFl5dGNIQTdkaVBIU2xxUWkyWVNYc1hXQzBV?=
 =?utf-8?B?OXdNZmxWNGc2WXRhZ3M4cU95aUdyS2NUUGF4bWNUSW4wOFdFZkl4a3pSaFNZ?=
 =?utf-8?B?cVRKQm41dkVFbzNrQk01YkEyQ1ZtRHVkMjZreVp5bkRhV1dKZmE0SkU1TTc2?=
 =?utf-8?B?NFkzMzZxZkR6b2svRjEzeGZhb29YSVJtQVM1aWpaUTBnUzhDcFIzdlgySVJu?=
 =?utf-8?B?Z2NqSUNOMG5ZL2FPdU5PY3pMc1h1N2wreGZCYXBCK21vNjJUYlBhalIzTXpj?=
 =?utf-8?B?TEFrSWFEaCt5L1IrWnIrcHFqdUpKSHBTWSswYitTM1REV1NtRHZKNzJ1T1hD?=
 =?utf-8?B?bE5OVExtM1U5SXdiczIrSDNzUGFXdGE2S3hJaXRkdzdTbm9KdERITWRkZzZs?=
 =?utf-8?B?alZiUGZDUHJ1Zk9LWndOQkkzd0VuUEdMeEFWTytqQ0JCRi9LYmc0VDNUb3Vp?=
 =?utf-8?B?NEQwRVgzS2I5MjY1cE9jYisrRDVrQklsSnI5OHlLbU1qVXh6R0ZQN0Jqb2RC?=
 =?utf-8?B?NFExL0VwTHAzQVBlNDF6cmZRZWpTamkyUDZueGJTekdVcDc3UzlpY0lES1Bx?=
 =?utf-8?B?bWpqZ1hBUVlMZ2tvQWFYTUJOVTRpZTliYURqMXVieFRnTWJUYXNkV21RTXpi?=
 =?utf-8?B?UlhBbHl0TCsybVh2RVpiS1VmeFBuWFJHcEVpZHZRenpQSWpIQk9mdmNkNkVz?=
 =?utf-8?B?NHVXWENGa0U2Q1hacU5VTXlzWEJZQ0V2eERVUEFRd2dhMkJQaUtRaFdFcXI4?=
 =?utf-8?B?cUM5dFg1T2VJMnBnUXJDcHhNMmRxaUROVmgyL1MzWDNERmQwTElYalEzOTdU?=
 =?utf-8?B?czF3amRIaXpFMldXL1ZtYzg4bWVGN29ZM2poSmExa0JvVzNsMFFHVlVJdUg3?=
 =?utf-8?B?V3hySUtqYmxUNXQwSGx2ZzlGR2JVVjhta2NTU2lML1cvbkhPNnVpY3c3V2kr?=
 =?utf-8?B?aVJNSzMybXFFVktDdDA2dGg2cXJRcFpHejRFSC9aTkQxRlN4K1ptclpIdzE1?=
 =?utf-8?B?ZmJxUFlUT3I3bEJXZEdxSnVoOXNNZjVWYUdWV0MyNVRRQnFwN3ZkQnRlSlNs?=
 =?utf-8?B?UzduaGwzOVVsaTV3MEU0eFRpME9iQUQzZWk5WnpaQ3prSGo2WW9MZDlKVjRD?=
 =?utf-8?B?NjJWSm1JdVFJTUpaaUxSMTlaZTVndDFMcU4yenlVZlkxcEVoc3BDNjAwQTZq?=
 =?utf-8?B?aktLbTdoNUUrV1ZnY1VTS0dkUHZ6MTg1Nlc4RlFUSnN2SzNpcnl6L0xmTFpx?=
 =?utf-8?B?bDBKRXJ0ci9WWmx6dmJkZmU2bE9TVzhZNVJZcENIcjNVT0U4YjNPVVR6bTdZ?=
 =?utf-8?B?NVNDRTc5eDdRWEMzTVFMUnlYbGNBPT0=?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1a91ef0-c1b7-419f-b2e4-08ddfc273eba
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2025 11:32:44.3800 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2q4h4umFh7r4C/vo1t0CyWKoqf9chAF3rioCbu++IOylKR9AcprxIm0dYqukxeVwi8nry+IkSWAHezFhd+GLGjdSyGeBYwIO0IcjDas/ue8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR02MB9854
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI1MDEwOCBTYWx0ZWRfX8XBSy2Ts1oJt
 jlQVl/eay1+eZE85mhi/t/6alhMgNp9xmZEplYytO3SFD5QI6RZrnJUVyeKK0t/Nq/aVLnq42ZU
 lKNJXUQJS2uCMwNbKvcIpjVLrxTLMWY8X9SMvIDypXuGNYGJHi7DZRBEMHWKlQsVxlREcRIV/x4
 lOJ8h8jWRGhNkXRj6CnyO1tqe/ylFSuNRCnqXIGmeyaTmHb5LvgJsYeQ3t3X+g8GTKNARYGPrBl
 aGelIt+gwNtmFlZ772IxIoH3svGQRVnvuTkFSGpZZviqoGKAbjX+s1MG9SN4rxWMeEM5RrVfwUz
 wP4miRAnVheVkRMGhxz4yaZgFJy86TQKhzfjZwzuaFiWRXguTRn9KmTTUHrpbE=
X-Proofpoint-ORIG-GUID: 5ZwJ9xi9_ZRQxR9z3NwNEukrwP--zfR_
X-Authority-Analysis: v=2.4 cv=eJ4TjGp1 c=1 sm=1 tr=0 ts=68d5285e cx=c_pps
 a=peeJaRLe+dxo5n1sA3bZUg==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=0kUYKlekyDsA:10
 a=64Cc0HZtAAAA:8 a=20KFwNOVAAAA:8 a=-an67RP_g-7o1LT8KO4A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 5ZwJ9xi9_ZRQxR9z3NwNEukrwP--zfR_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-25_01,2025-09-24_01,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

This is the more typical naming convention for QOM init() functions, in
particular it changes the prefix to match the name of the QOM type.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
---
 hw/vfio/pci.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index bc0b4c4d56..493f9da45d 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -3625,7 +3625,7 @@ post_reset:
     vfio_pci_post_reset(vdev);
 }
 
-static void vfio_instance_init(Object *obj)
+static void vfio_pci_init(Object *obj)
 {
     PCIDevice *pci_dev = PCI_DEVICE(obj);
     VFIOPCIDevice *vdev = VFIO_PCI_BASE(obj);
@@ -3916,7 +3916,7 @@ static const TypeInfo vfio_pci_dev_info = {
     .name = TYPE_VFIO_PCI,
     .parent = TYPE_VFIO_PCI_BASE,
     .class_init = vfio_pci_dev_class_init,
-    .instance_init = vfio_instance_init,
+    .instance_init = vfio_pci_init,
     .instance_finalize = vfio_instance_finalize,
 };
 
-- 
2.43.0


