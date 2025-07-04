Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4F71C83F09
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 14:03:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXgzM-0003pF-Ns; Fri, 04 Jul 2025 10:02:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1uXgyu-0003mz-Jy
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 10:01:41 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1uXgyq-0008Oz-6E
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 10:01:36 -0400
Received: from pps.filterd (m0127844.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 564BuqKR009935;
 Fri, 4 Jul 2025 07:00:56 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=AVd55O44SJT9CJk3tm34wf5nGWp/Q+xR0CSETCybB
 XA=; b=ut5K+KdOb5tPJKFGUatdLLJY6nyd78BlqU+XkIfUTxrgOr1nXSxv3namD
 53BEbXKVmwTNW0kdY6v9UAc4EEEGR7cuj2Ncm7UOuLwJgJP2G2jmeqr3rWPOJC0W
 2jZESQfcUia157DxhrSGVNesVun1kORma9C92A3oU6RvhwXMU29tqnvlRevPDpKG
 CJ7vXb66SDIgYpKp8J8SLDyGob2ntEDllQ1e5ALswdtvnNRVxSm9Z9sJckzrhjru
 jZpQw0pvMsNHUgYAzNymLGGlcxKNggBMZVEP0usVnhvi9LBtcIVTq3HOqqKPP1+v
 Il3mYev7OTF9Gk4POys+wHJRphoig==
Received: from nam12-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2105.outbound.protection.outlook.com [40.107.244.105])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 47jfx10fpe-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 04 Jul 2025 07:00:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hSAZKJ7+uD8KQ9au1VA55h3pepmv1cgqPaGBW4xtlnrL5oF7g4VeAreSW7m8Gmh6LnrNckMWkSqhjewvw1+BFk6B1tEjqdLLPBdkXtf1jFMNinBhXmFMATlZoWjhKljCwVBSIVNDFnYmANAcd+CEj35bBWinfInuAwfSHNoAwuAztmXeJMEO6KMwzIuIjYg4J0+krlSBef65DENAfnCfjSbmO5dFNMi4skEano4jxNiQ+mLz8Nu8Vw9fHdmLLNLYuFpGK0Wb0XoY6C2ngT/0YLDQ3dJ/ybWtAPlPVrDwLWxet6KoyNVE/nL5DDopE4gpIcHtriN0Vrnxvdu1sFRfVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AVd55O44SJT9CJk3tm34wf5nGWp/Q+xR0CSETCybBXA=;
 b=tlRsl2YQKtVoYgnTGOYSkLihsXbNq9lkw89Yh+t878Lv6RNhIAfFZikv4wztUbp9/Tmh4D46iLqIY7HcwE9OnQWM3cdxfrYOvrf0NtB79ixau8dmHGv+YV1SlPV79OyoaAj6ujdKeiE3ru129ZKD4A77o+0B0V6elE4pCvsJSBfP8+SI/vioDWcLJORBTFFqzg4rpLIlATHspAOcbOe+NucqKUHW1OAbEq5XJH46FUrib+uoScm1Vz9ymz0SPgIh3Esx5JS2ETWk12XHOYngd9f3S3XXXysDhg90iJDBR24HuSOJfVbOmg7WhF9b/+oKR6wA+9cH8JgVdzCS/kSz+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AVd55O44SJT9CJk3tm34wf5nGWp/Q+xR0CSETCybBXA=;
 b=p5ELWzm/T4Bl93x1S6GCn1tDYeQNDhby2VxO/d0yACTYtraG2gNupyGXsbYc7RYEg6V+u+aYBLL+7DUtP1ROrxJCMLNvbHptMfsUYn0aT4hIrZXD/uLcKooTfM23niHhG8An6Iste7mmpL3hKrXGtz/E9KKVTHKD4yY7uH5cu6UDtU6T9UYuWnrZM6FTCMaHBAyHx7thR6dEEi/h439WkBGPjVtbVPF8vvDzj+cJFjNt0kSgRAlZANaSosX5ynCv02Q3nI5Txn5pvXKqdOI59J7HxqxxO8gDUH+1yQtgxPAtZXd+euLjyGxM55Ir83WoxcHCIGfbTp8XWJkwgrY17g==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by MW4PR02MB7395.namprd02.prod.outlook.com (2603:10b6:303:65::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.22; Fri, 4 Jul
 2025 14:00:53 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88%3]) with mapi id 15.20.8901.018; Fri, 4 Jul 2025
 14:00:53 +0000
Message-ID: <0aaf6d06-228e-49b2-a9c8-867b816421e0@nutanix.com>
Date: Fri, 4 Jul 2025 15:00:49 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 10/12] hw/i386/pc_piix.c: assume pcmc->pci_enabled is
 always false in pc_init_isa()
To: Bernhard Beschow <shentey@gmail.com>, qemu-devel@nongnu.org,
 pbonzini@redhat.com, mst@redhat.com, marcel.apfelbaum@gmail.com,
 eduardo@habkost.net, imammedo@redhat.com
References: <20250618112828.235087-1-mark.caveayland@nutanix.com>
 <20250618112828.235087-11-mark.caveayland@nutanix.com>
 <04FE3431-DAB9-4FDA-99C9-648A63C1D00B@gmail.com>
Content-Language: en-US
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
In-Reply-To: <04FE3431-DAB9-4FDA-99C9-648A63C1D00B@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS4P190CA0006.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:5de::9) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|MW4PR02MB7395:EE_
X-MS-Office365-Filtering-Correlation-Id: 78f04fb3-7d34-4926-f533-08ddbb03307f
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0; ARA:13230040|1800799024|10070799003|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RGVOYURlbFVsNFdwKzVGcHM2VGJ6T2dMZlpKSURHam1td2FIMUpUbjZGRm5u?=
 =?utf-8?B?Q1o0V21IOGdUaWlCV2FKSHlhQ2VZRjM4SXRHczdxZDhXRmhSZjNaeCtOWnVY?=
 =?utf-8?B?Y3NhKzFVRkVGSHdZM2FKSXJxR3RRR3FuMy9OUTlEZUY3SWwxcC9WV2NBb0pF?=
 =?utf-8?B?bXBBMUxzdVZyWkpGRTlIRGRySDR4VFgzdTk4WkFSYzc2OFozSlUwWENUejBD?=
 =?utf-8?B?YVFSeHRuMXlZT3hzc0pyQzhvZUk4U2Y5MWFOZlJsam1WUmVKSFVIVng1R1Rl?=
 =?utf-8?B?Ym13RGxtb2VtSVIwdXg1WUJCUlJ3aG84dU4zNVBPZFJFajFncDh5S1RtQVZa?=
 =?utf-8?B?TW9PNW9iRjAzZFcvWmhTSkVRRDg5Q0pwQlZXMCtNNm5DWStKYkc2Zk9xT0Rm?=
 =?utf-8?B?WXc3TXV2R2V3L1ZvREljYXNTT3hiUTVSVXA4d0VyYW8vU084b1pKVGlsbVFJ?=
 =?utf-8?B?Q0NkVWNUbHQyYU0wa29DZ2ErN3lYMjkxV0hzcXcwTEUrd3p6Q3ZCaTZKaXUw?=
 =?utf-8?B?UWZHVXEzUU1STm03UUxkR1NRaXArSStMWFphcGFYczgweU9icWhEMG1PYlYy?=
 =?utf-8?B?SDRIM1hQQUF3cFhVS2QyMFcxQzJxRTNhM25POStkeEpNbXZrdy9sQjRvYTY3?=
 =?utf-8?B?cUhjQ083YXR4MUM3dU9zbkJwTXVHSmJDTzdxczVaVjduSGlPTk13alg5RlFU?=
 =?utf-8?B?czVHWVNQT2Zqb0pvNHJPS2lHYUZoTENCcTExNXNlc1YxNG42cDR6Um03d0pW?=
 =?utf-8?B?d25HUDVVZDYzemluVXdVcEQyU0RMeHVQTnRMaTJPZEFETi9VT3lzRmV6Y1ll?=
 =?utf-8?B?bkpxMFU2VDlqbktGeFpJeHZhVm1wby9tOVJNRis5WkRadEgwbzZYbS80TS9v?=
 =?utf-8?B?d0cyUG1aTDZuL1JmeVpIVWFDYWI3bU05TXNKV1J0OHNlNStEUHFVN2ZiaGhr?=
 =?utf-8?B?ODFOa2Z4dVZHcSt0cE1KRGNsRU82WEo4bUtLYzYzOWM4WVNNQzJsbGsyaWV2?=
 =?utf-8?B?endOa21DTUpNT2Nqc3h1TTMwQnl4SHExUVZJWWpHN09EQTEzSlNKWFpLUGlE?=
 =?utf-8?B?TTM5WWoycXlxcDNpd2lRc1YzK3dRK1FyVkM5RnVGS0pHcU85azVnVEtHdFMy?=
 =?utf-8?B?TlBJekpTZzdtem5CSU5JR3dMZ3BPSHh5TGVYajh4MjFDcU45RlQ4SmNJTnZ5?=
 =?utf-8?B?TVQyQmxIeFYrTjRoQlhVVFNPN1V6Y2k4VlRIaWxsOWFEa25wNGl6MWx0b0hr?=
 =?utf-8?B?M3BFaXN3bVgvdk1pY1F0VlpIQUVYYzNYZDhLVi9VMTB3NjYxZTNWSWRua3lw?=
 =?utf-8?B?L3hQQ1JwcnZtVEtZazZHV01FM0FuM1A4YVBCNTd4eXZxdHN2d2YzOEtYT0g3?=
 =?utf-8?B?SEpuSUxoVDl2OHQ4cVZhVWtVMEFzUHpTNHl0MUJaU2Y3YmhITzdIbmNKME44?=
 =?utf-8?B?UWxPbUtYaEtZU3Jia0c0SEsxc3MvV0FEbllZN1QxR3RhNll0WnBWMlJpcXRt?=
 =?utf-8?B?ZXA3SjhUU3FPaXJjRmpydXFuQUZjUU14VGhybCt1b1F5YVAwSGtFSXhxb0tk?=
 =?utf-8?B?UXF0UVQ3SFVyTGc3NzdMWTg4Z2hZNks5WGFCRXF6Q3RFVXBQWFArb0R6MU9z?=
 =?utf-8?B?dThBdGhFMVZpcTk3cG5LTlFjNjJ0cUYwc3J4UWlQaDVUV0lSMEQ3K05EVnF3?=
 =?utf-8?B?cENSeE9ZRldRR3V0VXZIcDJIWWErZlJqaUE5M1VTSTFJaFhJaDNPRFR6S1Nn?=
 =?utf-8?B?NmRhazk5QXRmRnhqR2d0OVhUSEVJcTJFVThqZmRvK0xnc1ZsL1EwUHkvV2ZQ?=
 =?utf-8?B?eHB2TG56V0hwSndSaVJPcGg0eHJxMzR1WXlCR2dhOVRpZWJickF3dmQ5Sk93?=
 =?utf-8?B?WTRwT0gvV1R2VEZ0NUlCajQ2NTI0T1lBaExheG1xSVpQVWRKR2lOZ1AzYjFH?=
 =?utf-8?Q?BLpRfzbJ4DA=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(10070799003)(376014)(366016); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U2RPTnZ3Z3VybkY3QS82eXZSeFkyQmJyd1NDdi9oZnY0Y3EvdTRiSjhFdDE4?=
 =?utf-8?B?SUI3Zk9FcTJuRmhja0o0MnhHTXd1b3RscWtUaHUyemszRG42Nlpzb1FBTUVH?=
 =?utf-8?B?OU84aHo3dnlEelR6cElDdThQWEZLWDVTODRmbmZtT0gzRTZKY0hVNkJPcEQ1?=
 =?utf-8?B?Z0V0SkpsVkxGeUpubHdxM005Q0RiVXlXUFRuTitnZFVzQjJqK2djUXd1aDc3?=
 =?utf-8?B?MFdNU29qTHVnVTBzSmxZVSt3c0Z6NSt3YXBVYW0zOFpWazhwSk5tZnd3NUVR?=
 =?utf-8?B?enVDTFVYQ2czRUJEYVJ5S2pxMEZyd1pKUHI2bmJSS1BScm9nTkRlK2tnR0hj?=
 =?utf-8?B?cGtZUUswNTFCQzVWVlZiUmRzdUdjR2tTUG1MNThIWEkrTlIzRnJwclBidWNQ?=
 =?utf-8?B?L0cxTnBLMmFvazdrOHhaNnZpTkRoU1Bna2tWUWFhcjBFRENEWkdlc0xtRGlL?=
 =?utf-8?B?TmxUekJSQnBVWUJpNFRTamsrakREZVU2WEdXUVRFK0thR1doZHBPWFpDQWlC?=
 =?utf-8?B?YllQNzNReXJXaGlsRjIvTUprVmVkdUxaODVNTDZXNzdDNjZlMDZjYk5GSnVT?=
 =?utf-8?B?cFdFVW00NUljSWdTM2JZaDc4dVFxMEg0SVQ3LzcyNzJ4TVBTdHVXMVJTSm94?=
 =?utf-8?B?SG1zdnFHNlpseExFN1VlRDNpVElGTnp4UVhYZ2ovS1lIekNtcU45clh5ZFdk?=
 =?utf-8?B?S25DZnRXTXJDR1JvdzNjUE00dUF1bWVQSDBoYkpWWjdnckVoQzhCVEZBLzBq?=
 =?utf-8?B?b2thcUcyRE0rcFBXNUtyUG5VUnV3TXlKaXloSGpqek1EbVZqRm9PZXVic2pU?=
 =?utf-8?B?dUN2dlRmUXBxa0tkbG0yR1VhY3Z5SHIwNi9lU2NzRzNyK1poc3NNRzN3VVFX?=
 =?utf-8?B?OERRTjhUZ2wzbkFHUXg0U0VhMHJJWWNoM29EQ2VoMVl0cURjdWVucjJIaFFa?=
 =?utf-8?B?S3NIMFA5a1dFRXEvL1FuWGJNNlZuOTRQL2xyOHo0WWFvbmtDUkM2S3B5K1lo?=
 =?utf-8?B?dUJWNXJyM1JTS2Y1aFo2ZGFuRDBzV0x3MlcyS1JUYmxZdGhyU2RhMzZpdnVY?=
 =?utf-8?B?bERubXNJNHExNDBxS0ZSY2J1bERYek82bjAxc0hqekVpbzBVaWd3TTdMYksz?=
 =?utf-8?B?WnRPQlo5S2ZxRUVQRHZFbk9NTzRRRXJYZ0JJQzNNS25JcW8vdEcxSWhQelJj?=
 =?utf-8?B?eG9MQVJ4ZGEyUmV3UlBLVTNUK1JsQUNkMmN2ZmYwSWg4Q2pSOGdPMmYxb1Uz?=
 =?utf-8?B?czJNelpENzNlZ3JzZ2NNNFhrb3RXV1ZHY2ZFVDR5YVFIOU9jNUdnejNRdHds?=
 =?utf-8?B?cXlDTHZwbm1qM3dDM2dsK3ZIcjFIUXRRMFFBek43aHhYR25OT3lJSmgyUGRU?=
 =?utf-8?B?bFFRdGo3MS9kVTNNSkxRVzNjVEhDaVltSzY4K0RzQWpFcE1UaGp4MEU5aDFN?=
 =?utf-8?B?N1JFQVQ3Zm1HZVgyNjZnQUJJWlU2NjNBNFpGKzc3djQ3d294aGtFVzV1SU9H?=
 =?utf-8?B?RnN2OVovelhMVU5Zdy93MTRxZEpGTTRlalJ5MEFtUXZHeEFUOHBrUVZ3ckFw?=
 =?utf-8?B?TkI2RjgxMjA2Q3pVZndEaWt1ZC9SMHU1bEhSYkhZaSt3Zk1YakF6UHU2QXEw?=
 =?utf-8?B?MFVTZGNpL3M0ZVAvYUpXTWpraHFwbmZsQkFRejBQOE91U1hKZTFkNk9Tdkx4?=
 =?utf-8?B?TWJFSVo2bVZnQVV5T3ZscFh2Ny9PZy85empHSHJuR1hTMDczNWJ3Y2Z4UE9S?=
 =?utf-8?B?L2VXQklMQVV5Zi9IZlBTRU9KQVphdUp2VEdhN0xYVVNQbkxMUFVuSDNqRDNX?=
 =?utf-8?B?ZzQxKzhvWmI2MjR5aWlYN1NrVjFPQjRVekV6Q1hacjlWNm1NUmx6ZlZsV2g0?=
 =?utf-8?B?YlUzYmxPN3Q4SkpqbkRvN3haS0VwWXd3SVdZVDRCWjZFT3phZFlmdHJVMHBu?=
 =?utf-8?B?Q3RZQ3VVYmlZS0VUOHNFQXh1Z3FtSUVEdWNScFM4SXY3Sys0VHo0MW5FN25q?=
 =?utf-8?B?WlFxbUw0WGM4WFJHbUVpSUdRb3FBNTFVL1k5Ty9HOUxNT3l3aUtwUmlva3dy?=
 =?utf-8?B?ZXZOeXNzUnJXVmdhWFBIREE1MGN5ZEJGQzMvZE94ODdzOTRQbjlOQnZmMWlK?=
 =?utf-8?B?Y1JLVFlpZnlKVElmYW9qeEtGbmV2RVZkUjZxMzdZUmMxV2Zsa0JpZWdFYmFH?=
 =?utf-8?B?MmROelFuZzh0S2hwZXVzazB1UzdLcG1YQk5TSERhNUpuUG0vL2dxbmpVam1Q?=
 =?utf-8?B?LzdEYVZyQWd1aUhHU3lNK0Rjb0ZBPT0=?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78f04fb3-7d34-4926-f533-08ddbb03307f
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2025 14:00:53.1458 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QVe71ElH/gyO7BQhbqFe52+x7FFaTud3d1us7KFSKK/ItJ6WLIkB+R+PFajgEoxAm06EX6OpWCiIcoa84AY1OZ+rkcyOKK/TAliRmeXTJLQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR02MB7395
X-Proofpoint-ORIG-GUID: rzFE7zRWyMoytLJ9nLQNdH0jlc2RZeO8
X-Proofpoint-GUID: rzFE7zRWyMoytLJ9nLQNdH0jlc2RZeO8
X-Authority-Analysis: v=2.4 cv=c4qrQQ9l c=1 sm=1 tr=0 ts=6867de98 cx=c_pps
 a=W7ZfpJ52Y0I/iYNgY30rAw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=0kUYKlekyDsA:10
 a=64Cc0HZtAAAA:8 a=IHeUmjsirvMQvikQTaEA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA0MDEwNiBTYWx0ZWRfX5mq6h1qWnMlP
 I89XnmaTK5ZwlV1gI0fTLtkKbKCdm8yOFQem6iULCofP9NT/JJldbax2p76VEogLEOg6IUcE9Ca
 IKKa3njjeVnXARcaDW0I8wx1+/3mQFdibFTjdM2eecp8zAfdFajebktTfk16NSaQP9ynDj7R/zb
 OFUNxo7mEWNlnzcwRMShleYQTJTk62qGkCAJJUjhwPQI3jM9D7fee5IVLSzOlfzSQ4fCbw9zSXB
 MqpMnQVyfG2TtM0HZ4Yl15YsQP6ADCbQRGkf/r+k4pIGEtRB1tIi2RFOX6WLoE2hbKwYVYa0h3d
 scvPmfTNwgeTdw7ClFhUY0ZMllydjjaKS/FQ/1fJ/vQbzGZbzRp1s0FzyiLNtMor69owI5rJ8jY
 cHbtkNJLEXOYUAF0demG+jKcEa51H2u9oi55nIAQDCfAsy2SwguyWnt86iij/Rxc5RpQ77zb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-04_05,2025-07-04_01,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.218,
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

On 23/06/2025 11:51, Bernhard Beschow wrote:

> Am 18. Juni 2025 11:27:15 UTC schrieb Mark Cave-Ayland <mark.caveayland@nutanix.com>:
>> By definition PCI can never be enabled on an isapc machine so hardcode the relevant values
>> set via pcmc->pci_enabled.
> 
> The inverse should be true now for pc-i440fx, so a similar patch is needed there as well.
> 
> Best regards,
> Bernhard

Good point. I've added a new patch that does this in v3 (soon to be 
posted). It certainly seems like a nice cleanup, and I think that 
further tidy-ups are possible in future if you can assume that PCI is 
always present.


ATB,

Mark.


