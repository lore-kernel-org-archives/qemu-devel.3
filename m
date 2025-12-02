Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3089BCFD2F6
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Dec 2025 10:43:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQNrK-0008GN-Ej; Tue, 02 Dec 2025 05:43:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1vQNrJ-0008Fq-HF
 for qemu-devel@nongnu.org; Tue, 02 Dec 2025 05:43:49 -0500
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1vQNrI-00030W-0r
 for qemu-devel@nongnu.org; Tue, 02 Dec 2025 05:43:49 -0500
Received: from pps.filterd (m0127841.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 5B244Sbm1715479; Tue, 2 Dec 2025 02:43:45 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=50PFwXmlEhhF436Tg/uQyt/5Ufgz4rL0KDHPUI0ur
 80=; b=KixkKuJPYE+Dk8BdpSWok/LmUl8rfhUAemnkNTl5ACGjSBmz83OQVdIce
 G8tnO+ECk6B1Ks3aVa5lARSGYqVeM0+kyH9CBRgm9nV4DaFqdDA5pZAkalRyuScd
 BFO2OdbzVZ7kfd24VZ7NCP86vdcl7ehuNw0VL9VNawmVW7aA9/zlxI8crr+RLYvu
 Up5txwnC0PpJTxPDetB1QyU5Z8ZlfHrXifoaqFRrE3QjXW5lk5YxiM4BSdaf/7un
 z/m3nRdAUnof1QGXxt5DthkxEiFVWwVYqdkNDiYzT3iRJymb+JbwT4BV5wfUaBjm
 KZO/ERskTa92HtNvszawV9RJcsPBA==
Received: from sj2pr03cu001.outbound.protection.outlook.com
 (mail-westusazon11022073.outbound.protection.outlook.com [52.101.43.73])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4asrrxrryt-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 02 Dec 2025 02:43:45 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IwQUsrzqZP8xkPqnyTeEZI/SwKg5MqnRwfrbFRgD4ifhFAwjmDPt+jPmZCnc3KHC742SahMpgZga4HTwqk3yTI+Y4QG18WpyxMQOKb7BsfvY7AXuecxaRD8IbiWQbc1VPb7VBEag0s+EaD83sVl51Bgta6oDVX5yit1VVmHlbRpUarRYBYk6irWATH/sC1UQXYtegDWT46I4hw4V4Gl47RURojY9h6AnS7v9WmGoEdJCzyHG7tr4QAsoTfGmAyeAqg3smJO/O/Wuk8LqXZ3CZOpNFe68jJJybNKDKAt6MnLfY22y0MXCAwIzZPUaOkALKT79j4Xckf9/HymcxqoiFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=50PFwXmlEhhF436Tg/uQyt/5Ufgz4rL0KDHPUI0ur80=;
 b=bzkChwt0+yEs4+IsbWkGea7JD8E3CP0zm9jU8kJJH9LtKJ5k6aHn6K0EDJf+87IZbE5THsldHowQSd9dd/481ydL5b2Ia4GQVPdxGnUFRUp1VbZRBW+o8pj66CwfZk4lc1yTxeLU9wAWkO5tIFxsEBe6LY5HlXGgjVhpaoCn5qgjHSn+RlVVlT1wVxXWG7mOFJ2+0nXsKbXD5FQna/P0wFDdcNEqz/s/J4BLdVLiMMnCc1yqHBgEj+guzARH46LJarfftE1EjxA4IrZlAQBRjs6yL3siHoO9+SZIuttMahwmTr9DGoeLlW9Wz49b6jvwgFMu9IScJqdpho97tPLb+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=50PFwXmlEhhF436Tg/uQyt/5Ufgz4rL0KDHPUI0ur80=;
 b=pKiaGGuQNyCyoWWmY73wgm0T9XRbR0se5M1WYxpRAfFlSHN9xi61MuygM5uWp+GTzgTUchNhrXYgR1z+l/q2i64L+uR4MQxtUlT+GOpc3XVFMRctHzSbYauprf1RJFAoPeJwn/CbPhyEtuNRNuAiktaw47qpbGngVH7rX+YIRYFBCuGYpF1aKTq585lPPr9lxLBn68/MRzyx9aB/6Lp/+bRGVdJtVplz+gwTjwmVtw8RYgY1LVEQVhs8JXr8L0mgUqnqt62gDIAeRhEYuT02WfKhWFtiM7ewMAkXRHYqHecRgA7iSw7EyfHPejNnJ+uhCUiwK4wSFMrsULTgxXmabA==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by MN2PR02MB7024.namprd02.prod.outlook.com (2603:10b6:208:205::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Tue, 2 Dec
 2025 10:43:43 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88%3]) with mapi id 15.20.9388.003; Tue, 2 Dec 2025
 10:43:43 +0000
Message-ID: <df4e2da1-f71a-4184-9d8d-1510d7064977@nutanix.com>
Date: Tue, 2 Dec 2025 10:43:39 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/5] vfio-user: clarify partial message handling
To: John Levon <john.levon@nutanix.com>, qemu-devel@nongnu.org
Cc: Thanos Makatos <thanos.makatos@nutanix.com>,
 Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@redhat.com>
References: <20251201095621.2786318-1-john.levon@nutanix.com>
 <20251201095621.2786318-3-john.levon@nutanix.com>
Content-Language: en-US
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
In-Reply-To: <20251201095621.2786318-3-john.levon@nutanix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0549.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:319::18) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|MN2PR02MB7024:EE_
X-MS-Office365-Filtering-Correlation-Id: e4a8d727-f382-4d39-e2bd-08de318fa9bd
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0; ARA:13230040|366016|10070799003|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?T2U4L20yY0FvV2pDV1g5NXFNdWtuclo2WGNZeUx4Z0RVWjJjU2YxaCtxZHcz?=
 =?utf-8?B?QnZ0VFNhZVo1cWNrK0xLM0NkNTlkNzdLbnQybWVwYWFEY29nYVpGODV0ci9V?=
 =?utf-8?B?UWVlNVJhbVorQzcySEFuMUVIRnBxanIwbzdXakhqblhYYVNNTU5sK1NvdGRz?=
 =?utf-8?B?SUMzVkp2TDJoNDJxQWNnM2pxRlRTNXh5dmVnSjhlUnhPQktCYmV3anJQaTF0?=
 =?utf-8?B?U21LS1VFZ2djT2xkaU5zTWZkUmhzT3MzMyswWW9ScFhyTU1KZzJYd0xCMVl5?=
 =?utf-8?B?NjZtV0M1UVhlN1NMcGZJMW1xZ2ppV3RwdUtHc1RxTEpBQW1zSkRZYkZpSFg2?=
 =?utf-8?B?UVFXeUlMWVp4Wld0MUpVZjE1YzBkRGx4Q25jSWIzeDc4bHBOMThwYTJ4Mk9P?=
 =?utf-8?B?U05SZnVnMGRiOVcxcTZTNGZ3Rk1VTTFSb2ZXMXJVSHc0L3pBbEs1MFYzTDZH?=
 =?utf-8?B?ZlNFd3lXMEdiZytlNnQ3Mm51S3dueFVhbXpaRWhIYjNBWW4rZ0dydmVFQ0hw?=
 =?utf-8?B?NENPVDhtTGpaa25ON2xwekJRUG9lS2FIRkRHOWtTREhpRGVxRGRDUURiNSs5?=
 =?utf-8?B?MmhLYzhmeTdQRVl1N0psYW8wWUxJMWhhb0drVlVaNWZQU0gzL1RRZ2tjb2hu?=
 =?utf-8?B?MDlIMlVKL25sN0RCYU9GbjNSU2lOWFpzRVBNQTF2ZTRDMXo5MFgxRHptTGxm?=
 =?utf-8?B?dG82SFlhUVBwenhaeWRxNTFqMWYzN3QwQTRBSlRHWVhGN0lOUHVQeEM1bXVu?=
 =?utf-8?B?N1NTTUNyMkwxcnc3eTJaTmx2SGhHTGdOcGc3Y2k2TFFGczFCUVMzbTlQUjZE?=
 =?utf-8?B?aUU0YkorRTE2S09XekUyZDNTNFJvbkVaUkdNS1A3YlNHa1JTOHFqclFsVXIr?=
 =?utf-8?B?MFFINy9DanFWclB5MC9naDR3OVRHUThqa3ZjMjFWcTl5YWpwbTZFTGRuZWs0?=
 =?utf-8?B?TWJJeDBpdFlkQnlGc3lvYjVmVFlZN2g3d0RGOEw3cmVyUENSL0ptOTZJMlZV?=
 =?utf-8?B?cDlNeTlqSGhuK2NLeVJRREZMNTBtYTZXU2l2UGRoRUI3aGRzTmg4aGh2ZlZt?=
 =?utf-8?B?UmFZQjJuaEVyNk1NeDZFblVKWTU0SExXVkdyM3NNQXBVUU1UMHVYUXVJVVlW?=
 =?utf-8?B?Y2VWcjJFSEd2ZTYzby9NdW9MckJSMWJwSktldjBHT1B5QXliNDJvTXo5dWRM?=
 =?utf-8?B?OG5vSlhVV1NSb3ZyV2J2dWlDK05pMWFYL0hsZTh0T2swaHQrSTJqMzNOYmN2?=
 =?utf-8?B?YlBKUjVkV1JtQkdRUk9Uc1NvZHk1NjRlbU9INy9pN3c3K2pyT1d0WWxRcnpE?=
 =?utf-8?B?NWZHcG4rUm9wdDRHWGNyNUhrczNpcjVucWMwaG9JOEVwMFZoTnFtcVlsZHNG?=
 =?utf-8?B?UlhzUk96TVdmM1VXeEhHcUpRRXZLVWhSd0ttbTNYTjFuRWsvSSthd1V0Q3Va?=
 =?utf-8?B?VHhaSm5oR3lvTWdTTUEwczhYaG05TWh0cXA2c3VKQitFRVY5bEYydXRtZ2Nv?=
 =?utf-8?B?TytCbUVOR2pxZ2pLamtONGVld21aamMyQjUwTDg0dEtJQjBOMndOa3FUTlhv?=
 =?utf-8?B?b1RBaTVMemJhWTQ2UXZuKzExeU9NVEZCOWh1NTVDak1PSTBBd1pqMTFIN25o?=
 =?utf-8?B?dlY4eGszc1doT0ZzckpQcDhJVjBxTjl3WmlwYlJxK0FrS0o4TDJRbEFUOHhK?=
 =?utf-8?B?bjFlOXpMdUU5NjlyN2d4ZURsL3J1VFExQXByMGtUM3hhRHdrclMxdjl3MU4y?=
 =?utf-8?B?dGJXNDgxTnBNbkNCOVJOcmJmSGNrN0FDQjhNK3BSa3pUMjFVdlJjZ2plYkRz?=
 =?utf-8?B?L2FzcmQ5R2V2USt3Z3NyS0owL3NLdkc3RllGM1UxaWZ0QkgrcmtZc3pwdlo2?=
 =?utf-8?B?eERTZEQ5am9MYVE3RTcyTmpYS051eis5MmlDdUtCcFpDK1BUM1h2UERPMTc4?=
 =?utf-8?Q?ec4jsvCbyItkUt4iDuBZQ/JIt04MIHAO?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(10070799003)(376014)(1800799024); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YS94OHVtTVpLWk5HVHFOU05lbHRqWG5ON2p2TkdpcnlWcGt4RlN1NTNaZDNC?=
 =?utf-8?B?RXZuMkFuRVNrcUhjZW95WkxSbVBSYUY1VHNOend2ZDdpTEswTHVHdGo5Z01C?=
 =?utf-8?B?dkUxb2g5KzJQalh1Z1llakNkVUNlRWJabDBTSWtkSW9pcCtHdkYxTlVhbnQ4?=
 =?utf-8?B?cmd2R2xoUm9weHRJNHNVbyszWTd4UFE3cTIzSGppeUFrZGNTU0s3Q3NvUjAr?=
 =?utf-8?B?UUh4TTNtOHdrdE01MG9aQ3k2SEVWUFlJNlBZUkJiMkVIUFBxV3djNS9KeEND?=
 =?utf-8?B?dmpReFZWRG54MzZTMTdacmRxRU1kbThpUVlFTUkxNzlQVXRuRmxEZEhSaDRM?=
 =?utf-8?B?dzJFaUVtWUZ3cUtZb2VFZ0hvYkh3S2N0bGJaenRFRVRZOStPS1YrVnJQMFR6?=
 =?utf-8?B?VXFucXd1elNxd1FsQ3NPSHJaUGlIWGNIempxWmhvMVRiVGRmMXh5eHFOcXQr?=
 =?utf-8?B?NFRYWjkzV25zVUJzcTlOZWl1UG5TSzZxeHJMQmJDMmRnQ1podCtLVXZUSnh2?=
 =?utf-8?B?R2h1eVZoY3RodW4yZEZHa0t1UkdqRmZwSkdsa1lSOUc2WElkUXdCNHhJT0w2?=
 =?utf-8?B?b2IwYk5GRnVCeWY0VkVrUnZXR2J4T09PSVdIK0RBOHJFSFRmeDlwTlBNdllq?=
 =?utf-8?B?N095SE4yNDRCZjVDS3BCRlpjcXYvS3dwaEJPZ3I1ZGFLVDl5Vm11RE04Y3dq?=
 =?utf-8?B?dHBZdHloRFVmQjZCOFNxc1pycjdCM3hkV2YzV0hPQkRBYXhGYkVyK3FVSDRi?=
 =?utf-8?B?Y0xpeEYvS3U3ZFFOckxRK1R6K3lBM1dweVdZYnpyZkxjOVg0ekhjS0FpWGtD?=
 =?utf-8?B?cUNnWHdkNlZrVHlkY1NwY0NXaTF2Z294MHVlQmpXM2ZaS0toZUpIcVNWSmNV?=
 =?utf-8?B?RG5iV1VoMm5UbGlaMktYbmJLbjlDWSt2elUyMnA1ZW4yVEtUWnVGMEhML2hv?=
 =?utf-8?B?RmgzWXI5MXVMVExBNHdLcmJRd29MZFBFREw4OXBoeTJNMWVnTnB3YVVDOE1m?=
 =?utf-8?B?U3dxKzhIbTVtOG5ZYlhBVGs2UzJyTzUzUDZMS1h1ODVldVdSRHVWdVMzd09W?=
 =?utf-8?B?QU1QMnBPMkR4cmExemF4T0tyR29BbTlGL0ZDOXpQWFB6TUFDY1hTSEE0dzJI?=
 =?utf-8?B?UnFsK1lWU2s3Y2l4cURFNHEwaVZaYmo2ZkZMZ3p4aVQ2ZC9MK1kvOXRiazVJ?=
 =?utf-8?B?cTFaM0Jud1JHY0s3OFhPc1o1QnhmZTA2Z09SeS9sc3FobitjRDVZeWRIT20y?=
 =?utf-8?B?LzdTOHZnWWdMSjBrS09rcnRnVkVOWnBFTktsWjUyM1hTYlpqNzVLRHdCeTE3?=
 =?utf-8?B?MjNraVVsQnJqNGcxQndXRHdyYUltV1AxcW5IRDdNQm93M3RMR1U4S2MxQTFP?=
 =?utf-8?B?UTNJdVAyTy9ZYmpHdE9PM3hpNGg1NGxXR1NpaVVaSVRUTHFabWVpd3RYMTB3?=
 =?utf-8?B?b1JGNjE3V2Z5THJUdG1xSnBlZFBvZCtlNTljR2MyUWRwKzJWck5XR25VajRi?=
 =?utf-8?B?MjY2SmpOMnBSb3pjR2EvM1dSTDNTNHNOdnkzazJLUXVNY2RlVzdXZmJlMXdF?=
 =?utf-8?B?eWgvbzFDQWxrY1dhSUI4U1pWU0R2ZHBESDQ4c2s2WGdVaDdsTTVDSk5DZmQ4?=
 =?utf-8?B?ZmpiKy9reDNDK2J5UWRUdkYwWXhKMlVvQWVOYzhrdGQwSzliRVNjcFllbFpv?=
 =?utf-8?B?REQ0aWFHd3lkYmdLRjlIbFZXL0F2YXEzbVd2Y01pd3MzS1FUT0tYWDRlWG5m?=
 =?utf-8?B?UlpLRzhMZWwvb1VVQThPYitOd1MzNzdZb09Vek95ODBzNGFQRUZIMkJBbm51?=
 =?utf-8?B?QTlPTmJHWkhURDd4NE8vL25qNkZVMnQ3dUQ5QjFQN2dyOTlsSEM1T1ZBMFJ0?=
 =?utf-8?B?S3NDeHEyWU5IdWNKQkRydFUwdkFIRmhaYlB5dlptV2xMbG9UbCttZSs1M0to?=
 =?utf-8?B?ZytwUGdSek5BdGhNUUhpNjVYaUVLQ1FTVGlUVmErMVVrZDNrbmg2R3JCSVdQ?=
 =?utf-8?B?V2VnMUNmdDFKSk5WalA5WDF5SWs3bGpkVVZJRzNDRFRWWmpvZ2NabmREQXB4?=
 =?utf-8?B?b0UvLzFHS20xSjA2eGlqUm1seVMyblFsOHdtVGRHbllKRlA3bU5CNGtoUVRZ?=
 =?utf-8?B?emVMSysrNWhtRVladG5vRy9raUZuRlA1enFWV3hUNVpqK2FvcDFmcloxRTFI?=
 =?utf-8?B?bDlaWFlPdzVpWkttbDRlV2RBZDlwT04vV2t3cVphblpqUXl4ZzRCYXFkMWZq?=
 =?utf-8?B?dnAzOGR6TnZqZ1RGV0JhV2czczhRPT0=?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4a8d727-f382-4d39-e2bd-08de318fa9bd
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2025 10:43:43.4424 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Tlnv0T97JtD+2EXp9N5DFKaW7YlGFNFemz7hqxSfChGm+H1IE1+YBXX+7wxJjEDJ9C20q8qw51qtXu/ikzt3cZLescFsIKSFWkMktRoCOEE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR02MB7024
X-Proofpoint-ORIG-GUID: Vf0ih0c8ZOW1Sh1FHSJAiC7F2ZIQNo21
X-Authority-Analysis: v=2.4 cv=HboZjyE8 c=1 sm=1 tr=0 ts=692ec2e1 cx=c_pps
 a=rss2Ezl/rPWt8HBHL2MHqw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=64Cc0HZtAAAA:8 a=oPxFyPRK1OEwC2H6ukwA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjAyMDA4NiBTYWx0ZWRfX7KGBiKtN2SSX
 sfSTvTBFq6x6k+1ti+T+iAACcj4bYskE++eKFpuvdJ/2gRlr8HV10ZOzPjQjNJOVJxbpQAthabm
 zeQPJ1xuLlIYjUxoq2lYrcyvjqfyN2d/VbSejYKxaIGdrphgbr0c7Mi1MPTFpxP5qEeU/QX8I8Y
 zkJ9iz5YYaeenIbCNK/AcF2SI5hpupmKolVCV1Dg9ShWVQ8m66FLZgKkxLnkl9CKraF95gJbaKO
 mhONHXxrhs8COaArdCChHBwZyOn3egFYZV9w6GLq8LQPHsTaeaWGJ1woPvH/SNqOiGRLHL960Es
 tYFhbSRjpgueoqLK7OaBL9BsE8G7D3Bq8YdQH60A1pJz8b5CS29HkQ0XHFtjiGuzcTgqjuGnB3o
 KsDhomg46TKK/HX/KoCJdIY6vmjw4w==
X-Proofpoint-GUID: Vf0ih0c8ZOW1Sh1FHSJAiC7F2ZIQNo21
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-01_01,2025-11-27_02,2025-10-01_01
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

On 01/12/2025 09:56, John Levon wrote:

> Improve a comment for this.
> 
> Signed-off-by: John Levon <john.levon@nutanix.com>
> ---
>   hw/vfio-user/proxy.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/vfio-user/proxy.c b/hw/vfio-user/proxy.c
> index 75845d7c89..82c76c6665 100644
> --- a/hw/vfio-user/proxy.c
> +++ b/hw/vfio-user/proxy.c
> @@ -362,7 +362,10 @@ static int vfio_user_recv_one(VFIOUserProxy *proxy, Error **errp)
>       while (msgleft > 0) {
>           ret = qio_channel_read(proxy->ioc, data, msgleft, errp);
>   
> -        /* prepare to complete read on next iternation */
> +        /*
> +         * We'll complete this read on the next go around; keep track of the
> +         * partial message until then.
> +         */
>           if (ret == QIO_CHANNEL_ERR_BLOCK) {
>               proxy->part_recv = msg;
>               proxy->recv_left = msgleft;

Reviewed-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>


ATB,

Mark.


