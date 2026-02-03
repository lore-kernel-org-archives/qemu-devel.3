Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FEE1E8783D
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Feb 2026 15:24:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnIFj-0001ig-TW; Tue, 03 Feb 2026 10:23:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1vnIFb-0001gb-AX
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 10:23:35 -0500
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1vnIFY-0002s9-Cz
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 10:23:35 -0500
Received: from pps.filterd (m0127838.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 613CIVnt2643600; Tue, 3 Feb 2026 07:23:26 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=Y9XXcEo6QkpjmS97YDFCHOAUXpYCNzP2aPXBzGAX2
 1c=; b=g6/zgr/XY1KpUoLqukjpUISRUiBFa9AxnNfjsRETIU2Fg0ONXcBCCkY8/
 76eV5V5l3ZiFYIRs0x5NtpXcBQTYpG+61ANLKhnDI+AsLsc1+9Ap/HUeobo8RllP
 BnWVqYFaMf+fliNByYXjIGbVd7m961CxkZ1e1OzM/F/+DTf5a7VmEAToUVllm97q
 F1zj7WbXc7JCf7kkY/qh/arJ7xwjaceindkvOcCPAGXBf3ZawbDN6QVScbxe5RW7
 /Nc2+KluLuqQslxblDCHdmTfInYpURQWkRrftaYVVeQnFdM2Vhk5H8m+ii0c0yZ4
 8LJXoJzEz26Tm9sQJ244rFA4+JyEQ==
Received: from sj2pr03cu001.outbound.protection.outlook.com
 (mail-westusazon11022128.outbound.protection.outlook.com [52.101.43.128])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4c2ymptu4e-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 03 Feb 2026 07:23:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HQAdrVtEFCsSo9UMnlXPyLnl3L8xp8Ycf7SdnWmRXcw9RwenLK2ZQWY9T9xTdkk3c80nzcuh29hpV9K2Lb39MhUSllAHRrKlNSl6c7pPrSvDRyDZZCWwwZdO1u9kYiRiOIvzGzWPNepPInppwYaPJ87BGo1M/J0iLN3z5dc+Dzgox9ULV8Wn++3IjAHZ5skkvOoAUrI3MNHFYWcZvNmJUK8wWnun3qRpzmWwxplF8dj6hPPwRRIy3XGJPykZNm0GcyKhVMuynvsSfkGFWsocG1Hg/9d8Cxrc8cNb9ryEqycVSQ/Tb0GXjzJ+GWvMlKF427ZqjCywt54OJTxkpgwGXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y9XXcEo6QkpjmS97YDFCHOAUXpYCNzP2aPXBzGAX21c=;
 b=mrmA4+iZdUpngmQkGwILFNuHv43bbjfKUeMlUyc+uu1897suIotwMmUH88Rn+eyD3h9u4QRFRdrueO3pu+swQdFoDLWofnqRAlo6u+BTjbBOvC99owJCjzJkf2tETEfSlK9FmyI3Pquec+pzX8rHdFITc9JSF0/0FgNF16agwrASme8dLeu24gthf4OaQrbGeDAz7TqLEZfFCR8qxLcdgftOOzCIe2OMtnKudSKLv/k0FqNMxqA+6uy65hYpfORXboGS/zMJKEna98P1LCSRU+T/DtL6KkaeZC7xbIP+90dP7fNFm/yVm12wGKngSdtkMc2cONEGLOUjBRXGf7DO9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y9XXcEo6QkpjmS97YDFCHOAUXpYCNzP2aPXBzGAX21c=;
 b=MuLrZwMQ/wd29xlbMIWtxFxAsbEMSgLABxDwWxZy8pWTFwz1P7d5odje9nM/U5ShIOA8LMAJANg9vgSBa5x0TO2TfW/17KejbfNwmPZa8T/mAvngijBGxpALOZ5pmSTt751BTDFW/DW8hTDzHML+ygtfsB4Wx8F272hwtFVNWILVRTlb3OODe9ncLB5fdD6AiBsMNw4HJ+tfVEv4Fc4w/Q+UBX6riQjX3QEMb2c5H/SOL12jtjs7bO6N9pW+hkp3UK8xN/gfKmRnyzlaHQTnpEHbMS2hGQhCx18A4FUbL/EHFa8U4TzxKya3wm8eJlCsQJgqULiy2Wz82ZDkk56lPQ==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by SJ0PR02MB8386.namprd02.prod.outlook.com (2603:10b6:a03:3f1::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Tue, 3 Feb
 2026 15:23:25 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%6]) with mapi id 15.20.9564.016; Tue, 3 Feb 2026
 15:23:25 +0000
Message-ID: <166b22ef-655d-4a8d-94ce-cace8c03dd9f@nutanix.com>
Date: Tue, 3 Feb 2026 15:23:22 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/37] audio: remove obsolete/obscure functions
To: marcandre.lureau@redhat.com, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>, Eduardo Habkost <eduardo@habkost.net>
References: <20260123074945.2563196-1-marcandre.lureau@redhat.com>
 <20260123074945.2563196-2-marcandre.lureau@redhat.com>
Content-Language: en-US
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
In-Reply-To: <20260123074945.2563196-2-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA0PR11CA0178.namprd11.prod.outlook.com
 (2603:10b6:806:1bb::33) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|SJ0PR02MB8386:EE_
X-MS-Office365-Filtering-Correlation-Id: b71244de-d381-4bc1-38d5-08de63382c77
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?d00wK29VSllHSUNSbjdkUVg5S1hKeTZDV0puYzQ2Vm1mMUh2dm9kL0FoNzRR?=
 =?utf-8?B?RjR3VW9sc3dhNUJQOGlnTC9tSlZ2ZG00UGRlQi9IRlBLVEVFQ2xJZVV3N2hD?=
 =?utf-8?B?aVFISk5ob0x5TDBRSDBDUUtHVS9PUEM1UjIzbUlpdjNBZ1RqUk1aV1o2Ti9W?=
 =?utf-8?B?L3pBd1dZRnhuMUh2YnUxUVc2L2xGcGlScDRXMU9BalhLRFhjY2tYUnhxNk54?=
 =?utf-8?B?Z1F1R3ZoRHFUcFBmeDZVNVVVRHV4eTN3ckR1TExlUnV4Rlk4MUl3THNKMlNR?=
 =?utf-8?B?aThtbnJqZGFjeE1tSVF0aS9FaUhiZkVnRE0vYy95VkkwZnVxVVk5YVBFNlEx?=
 =?utf-8?B?cVZ2dDlOR08rRFhjWjFBZkx4WXVwbG9ORVc3MTBwTThqZ0tjdkdOYUtMTE43?=
 =?utf-8?B?N1oxbTZYb3UvWWxVRlE5SWtjLzcza0tDM0dEeWlNeWl3ZFpSaWw3SEQ4VUVS?=
 =?utf-8?B?VVhVa2pHbGs0ZkozcWJWcnJrZTEzQnZka3Yvb1cyVTZLclJnUStBZTZLQnJl?=
 =?utf-8?B?WGVoSzJtWUoxaFVNWDJUOXNVb1N1ejUvcnVXMjFWOTl0V3RjbWpJTk9xVXBX?=
 =?utf-8?B?cjdqVGE2d1BjTzNsMS9MZ2hDQXdqYlExcHZYdUF1S3JBRHcvb0dKaitLM0Er?=
 =?utf-8?B?OHZ6M3dmdlFJVDZycVJia1RZZHBTTGlwRXI3R1dEbTdMamxzYno5UGVyVjlN?=
 =?utf-8?B?M2FzKyswSVNaUUNyV3RSMzVCK0dFYzFMd2w4KzNvU08vWk5qY05BazkxMzRz?=
 =?utf-8?B?NTY4R1F6Z3RXUFhpTGFrQkhnNjNJVVdOUkZIU0NvYTdiUVlsUGIrVFRNT1ZK?=
 =?utf-8?B?RHgvL0F5L2prdnZUaStMcXo5c1RCL2VQN1hpelVRbEVmRkc0cWgyMHB2bklB?=
 =?utf-8?B?VHlrOVlnS0V5UFg0aVYyaU5PZmI4ODBjWEdhcjhScTZoK3NUb2ZnZWVWcFIy?=
 =?utf-8?B?dEhST2FzMk82ZXRiU1lzK0JZQm1oa2hFYkJOZWhhcWVSQlc4REhieE9QajlL?=
 =?utf-8?B?c0RCT1dBSmh4dVlkT3FUT3d6cEJkVlY2RDVRS0RHaEYyK2FpaW9JeVFDTnlU?=
 =?utf-8?B?RzEveU8yOG9DTENVR3c0NjJseENDS3lGYXE3dzNaOE52d3E3bjhVeWN4NTYy?=
 =?utf-8?B?L3ZtejJLQXMwaDBwU0VSVjJtOWJPYkJRZWI4K3ZyUkFKMnFZTXMxZlpEdjRF?=
 =?utf-8?B?bnhBNHpZTmEvN1p6cTd3R1Rlb2xCcndlYlNPRUI1TWd1L1V1TDRzMldSYXpL?=
 =?utf-8?B?L1RXZWdnZFJXZVNXQ1NCbnBkWUs3eE53ZDJobFlrb3NuQzh3ZE1KOE1DckVh?=
 =?utf-8?B?aGVaYkcwMDlHZER6Q05naFBmclRMWTFCN1pTNnFsRTNKUU5HSGpjalMxeitL?=
 =?utf-8?B?VXN0ZTNWeG9lZzMrOFo2eXFJZU1Oa21hd3BuQ0lKRVlRWGdySVA3VjV6Mlpl?=
 =?utf-8?B?QXpaRG5pLzJHNU9lcHcxQUlSNEJrbG1HeU5ibXFVcERIVUhGTklQSUxyWGFw?=
 =?utf-8?B?WUh1MVB2TncrMTVFcmhKR1FwZ2RHTzZxZVFma2JCMlFDSDVRZ05sTE5jZExB?=
 =?utf-8?B?N3JPVHIvZTVEQVdmeXc1WldmVkhaVWNqTDhlaXNmZ1dwaWhKK2RLS1kzM0Jv?=
 =?utf-8?B?S1FJZi9BSE50SDNFQThqdGFJMUxxaTlxMVY1S2RKQ0kxSjdUY0ltT09jQ0x4?=
 =?utf-8?B?V1F0Q3VHdDhOQkdtS2FYR01kRk9ZNDZjaktmV3F4eFY0UG9QdDdac2JvaXh1?=
 =?utf-8?B?MjNWelgvdEV3dGlhR2hSKzV0V002b0VYTXB4cGkrSjdDR2ZvZGNOeFJKSUdt?=
 =?utf-8?B?RFJPTjJaQmphL1pMZjJvWU5QNlJlSDhDTlBlQVY3cy84TzlINVM2RVlqVWpq?=
 =?utf-8?B?VlRNRXdWdjFYdXB4bkJaYXNFVkNaQWpsbVIvU2Q2VGpqRUlzaFNEa0RiREZ0?=
 =?utf-8?B?Mnl2MzREL3lJU3V2ZVhPeFVsclFzb2lLak1WU1RWbGVUeEFkMW9CTWRiTlJn?=
 =?utf-8?B?NUNIZUp4UlF1UXlYekhYNTZlVjE0V1YwTDV1YjlRbVMwL1dtRWFaaWNsOGVo?=
 =?utf-8?B?dnBOV0tCNkl0UmpRU3dRbWcrZWNQS3l2TVRpOCsrMVlLanJCZWxyWVhXRFRX?=
 =?utf-8?Q?fNhA=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R2psd25EdTZ2b0lRSmNFblR5TEtSTU5oWXdOTVlkbE1aYjNmRnZiZjFvZTJU?=
 =?utf-8?B?QmgyaXpwSGQwblFJWjBNc0ZaWWhkZnZFZlBxMkJETVNmWXpuQzhGdnpvVURX?=
 =?utf-8?B?TXpVdVo4MDFsd0dCSmRPRzFtU0JIZG94NmJZbVFCQnlTNVdJb2RXNUtOVEto?=
 =?utf-8?B?WkgxKzdlRVdPV09IK1VvSytCWnlUQzVTL1ViM2ZoZHpDMUJkcWxXOFBzRVBZ?=
 =?utf-8?B?OXkyWFZ6b0xIOWphRGFmWStvNjdDVFpZQzF3NkRsOFRlczgraCtQcWQ0bGg0?=
 =?utf-8?B?Yk5obkVtQWx4bldWQ1JGdzVjMjZRdzRERENYZWdMZ2l1eU0vZmJIY1Zqdy9Q?=
 =?utf-8?B?ZjVWM1FFK3M1OEJRY0YrWHk0YW5PTVpUY3NURUxrb05FMEd5NGZ1SDhHYUtJ?=
 =?utf-8?B?VW05OTJvaDNmNXJoMzV0N1I1ci9GQ3JHZ2c3eHltUTZHem5BejVnT2xsYXZr?=
 =?utf-8?B?Qmw3UktPUE0vV2NRekFURkt5M3lWVTN1bUF5bEpYUDdTMy95QVh6WFFCb3pI?=
 =?utf-8?B?dEpMWnlQQ2V2VU9YQzcrbkpiWktTelVBL1ZaWDdlNHk4V2kvelpOOXNQQ3M3?=
 =?utf-8?B?aVlPT3I0TTNyUkhBUDg0Yi9PR2FHY3BDcWFnZ0lnRDI2OVVBckpmVTl3S3dL?=
 =?utf-8?B?em9JRGFFZCtuWlV6TkJibTN1Zm82SlJBeHRMMCtSRE9ZWFIxRERDWThpUzRq?=
 =?utf-8?B?Umh6NTBFMzhmczJHVkRuU0xBSlQ0VlZTeitlN3JIRGxESHpUNmliYUM0YWVC?=
 =?utf-8?B?Nkd4a3pITm9zWU02dktnVDZKcVk3YXhyT2ZxaFZmUGdNSnpSZFlLZk9nM2R6?=
 =?utf-8?B?OHp4ZDNydzRFNVlFS0tLdmlBSWNlSTVENGpUYUdDWlZrdDB6ZlpRWHhZUlBP?=
 =?utf-8?B?T0JKVG8rdGZtUElHY0gyaklSUlh1U281bWdMbFZjcWpGQjVmeE5QcWhpMll3?=
 =?utf-8?B?VlpIdDFOTzFmV0VtTXJzdEZMRnVuVjVHU0JIN25LMDY0SFlWK1VrTk9DUjcr?=
 =?utf-8?B?elRGWFk2dHNneDdrdDlyQnhaT2xVMGFFamRsZUx6bE1PbUNIM3RWRkRmTHkv?=
 =?utf-8?B?a2k1TjN6ZVpYS1IramNUYUo2M1ZZZlhoeEJucFV3c05PRSsyUjNkbnRCSkNB?=
 =?utf-8?B?WEhlODFGMWRBWVJPUHJra3J6aXh2MHRYWVhTZHlYMm4rZE5kYWhqSUVtS1J3?=
 =?utf-8?B?TXlNazRGUldtb1FNbHp1cjhLdVY3VkNQUU10R1AzcnRVaGRyYjFGSEgvY3Ft?=
 =?utf-8?B?NzJxN01xREw5SDhjQVNNczRNaS9McEVCSHFqSDFzbld3bVNhdkdMdkg3ZXdj?=
 =?utf-8?B?bmhJZFBlTkZhN0NWbExMN1JMOFUyYkRuTm9xTXo0dUZyZmJMMWVRRnZsOUZE?=
 =?utf-8?B?UXBwdTUvcnpCOG43bzV1U1hUUjUyLzJRRC9JekxKNEFhaitsMmVUbGFlaXVl?=
 =?utf-8?B?NDEzRlRLNnFmR3MrckJGRGthMDNTTHZtMDlkdENqVEpTZlgyTmtyR3BnUkN5?=
 =?utf-8?B?cmNMNDFzRTZJd3dzNTM1YWkxK0o0RGQxR3IvcnhkUWJxUWRHQUx2TnpRRFI4?=
 =?utf-8?B?cHJaS3VXdFhQQVJmM3JuWWNaTk1pOWYwK0JKWkFnM2lVU3hxMjVGblRSeTdn?=
 =?utf-8?B?Y3pvNWpYcUIzTDJDTGhzRy9NSXpjZjdiTGdYNTFyNjFPMTBSaHFndjhmOGl6?=
 =?utf-8?B?QytpclA3UjFJMHVjSHBFT3A4UGk2aEl3TGY0aGVuOExiTjd6UGVsdjB1bzI2?=
 =?utf-8?B?YVc2aXNub0xvNE80dHJ0dTc4WmNkVVl0QVRNaHV1M1VGQ1BEK0F4L0l4cXE4?=
 =?utf-8?B?VzN3bjJ5cUs3R1FjdmovcUpWbWxhUFZaOGlQdnNHWkNmWjYyWGpnNGg0WjRT?=
 =?utf-8?B?RndvY21BaHcyZWJFMCtMSDg3NDNRYjRDVmVKTHlFVmlITHhmc2JzMFpBSkt2?=
 =?utf-8?B?L2k0L0l1YTlOWjBFdkZaNXd2dE9iRUUvOGhwVjdUMUpRQzRTNXpEQUgxWkVV?=
 =?utf-8?B?NEJIeVZxaVdLb2toK0tOcHB5VitFWlFDZFZyaURmcVo0RTU4dCtyc25OWUZN?=
 =?utf-8?B?bzVpL3NiRXJjbU8yZU1zWTRLTExiY05jK2EwNUkzdU5LWjVCNUNjU0pTanl6?=
 =?utf-8?B?Zjd4UlBQV0hrVGRoaEE5dEd6K3VUSlJKeDNIalB6UkxtcWhvTDdUcFJUTWVS?=
 =?utf-8?B?ZHEvNGE5QnB0V0dzREVJYTJqUWtnalAxeE9RUG53aGpuQXc5cW9rUkM3dW9V?=
 =?utf-8?B?K2hWRmR6RFBjS1RvcE9YcWg5SGs5aHpRYTZTWFpPR1h5d2xhaSs5eEpHQWtU?=
 =?utf-8?B?UlF2dFFHd1lZaFYzTXBBMFhCRmVkVGZDKzRiZ0FHNDl5N1pqMmRNcG52TWJ2?=
 =?utf-8?Q?N30D4j0758RDCR98=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b71244de-d381-4bc1-38d5-08de63382c77
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2026 15:23:25.2214 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C4PwkUYzWiw4CfUPTxXpHUSV2wfwgLBFSwN2osAS1h4yc01sGOacTWSoOECQ8Bwws6lLKCffrLgZO6jhMlcPlZS/Vy48IrbkJs6zh8DCPkM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR02MB8386
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjAzMDEyMiBTYWx0ZWRfX0RssycMvTQQe
 m5HpFQSvK3IVreIi4Y8yqmleyy8zujQ6jtEzK4xQ6lR5vWld5A9aggeF2YqR8bNO5VbA68isUYs
 8yyi9by7yBCIpKUwwlwykQySZdyJjbY/9JqzlFw7RDDUutnvLB53PA8Ai+KzkX0LcidB7frpzcC
 kAMjpOJCAmFZ65vYnhSu6zmRnFXgeSEtBE5b/+X4MstKTgVXZy85ker703hP1r7Rl5D7ryJRS5O
 eQFbs0D/mNvPJdKVlSzQ6umtFlWSseFAUVt//mvWbO526X6bXDxagvQI6QbXjAUZ491MX8ApFx+
 qVciREhWp5/pShWRPu01Lbp1qLiO5Ul/dww+6IWJUHvYp0qbedTuDGWtCa4N/SZCGaIzhF0HHpK
 3TxodLWObVQRH8T6DvxU2kkjUuQWaqgnpU/91fxvPHL2maWYh8NGKKcb0IyL+4BkgNl7er0oPoM
 vdm4pFGrZsWAokxStSQ==
X-Authority-Analysis: v=2.4 cv=RrDI7SmK c=1 sm=1 tr=0 ts=698212ee cx=c_pps
 a=1KZAvIgiCpDO1TOdvW9+aQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=20KFwNOVAAAA:8 a=64Cc0HZtAAAA:8
 a=HVzx33UpkAbp-tH-98kA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: RLCMhBY2BsPMKQUsIzEhHr5fDiI8VSWW
X-Proofpoint-ORIG-GUID: RLCMhBY2BsPMKQUsIzEhHr5fDiI8VSWW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-03_04,2026-02-02_01,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 23/01/2026 07:49, marcandre.lureau@redhat.com wrote:

> From: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> AUD_init_time_stamp_{in,out} and AUD_get_elapsed_usec_{in,out} are only
> used by the adlib device. The result isn't actually being used since
> ADLIB_KILL_TIMERS was set some 20y ago. Let's drop this dead code now.
> 
> Drop QEMUAudioTimeStamp as well as reported by Akihiko Odaki.
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   audio/audio_template.h                        | 34 -------------------
>   include/qemu/audio.h                          | 10 ------
>   hw/audio/adlib.c                              | 18 +---------
>   .../codeconverter/test_regexps.py             |  1 -
>   4 files changed, 1 insertion(+), 62 deletions(-)
> 
> diff --git a/audio/audio_template.h b/audio/audio_template.h
> index 7a8c431f2d7..1ab3c47fd76 100644
> --- a/audio/audio_template.h
> +++ b/audio/audio_template.h
> @@ -569,40 +569,6 @@ bool glue(AUD_is_active_, TYPE)(SW *sw)
>       return sw ? sw->active : 0;
>   }
>   
> -void glue (AUD_init_time_stamp_, TYPE) (SW *sw, QEMUAudioTimeStamp *ts)
> -{
> -    if (!sw) {
> -        return;
> -    }
> -
> -    ts->old_ts = sw->hw->ts_helper;
> -}
> -
> -uint64_t glue (AUD_get_elapsed_usec_, TYPE) (SW *sw, QEMUAudioTimeStamp *ts)
> -{
> -    uint64_t delta, cur_ts, old_ts;
> -
> -    if (!sw) {
> -        return 0;
> -    }
> -
> -    cur_ts = sw->hw->ts_helper;
> -    old_ts = ts->old_ts;
> -    /* dolog ("cur %" PRId64 " old %" PRId64 "\n", cur_ts, old_ts); */
> -
> -    if (cur_ts >= old_ts) {
> -        delta = cur_ts - old_ts;
> -    } else {
> -        delta = UINT64_MAX - old_ts + cur_ts;
> -    }
> -
> -    if (!delta) {
> -        return 0;
> -    }
> -
> -    return muldiv64 (delta, sw->hw->info.freq, 1000000);
> -}
> -
>   #undef TYPE
>   #undef HW
>   #undef SW
> diff --git a/include/qemu/audio.h b/include/qemu/audio.h
> index a92e0b70ef0..a1a64ad340d 100644
> --- a/include/qemu/audio.h
> +++ b/include/qemu/audio.h
> @@ -50,10 +50,6 @@ struct AudioBackendClass {
>   
>   typedef struct AudioBackend AudioBackend;
>   
> -typedef struct QEMUAudioTimeStamp {
> -    uint64_t old_ts;
> -} QEMUAudioTimeStamp;
> -
>   bool AUD_backend_check(AudioBackend **be, Error **errp);
>   
>   SWVoiceOut *AUD_open_out (
> @@ -71,9 +67,6 @@ int  AUD_get_buffer_size_out (SWVoiceOut *sw);
>   void AUD_set_active_out(SWVoiceOut *sw, bool on);
>   bool AUD_is_active_out(SWVoiceOut *sw);
>   
> -void     AUD_init_time_stamp_out (SWVoiceOut *sw, QEMUAudioTimeStamp *ts);
> -uint64_t AUD_get_elapsed_usec_out (SWVoiceOut *sw, QEMUAudioTimeStamp *ts);
> -
>   #define AUDIO_MAX_CHANNELS 16
>   typedef struct Volume {
>       bool mute;
> @@ -112,9 +105,6 @@ size_t AUD_read (SWVoiceIn *sw, void *pcm_buf, size_t size);
>   void AUD_set_active_in(SWVoiceIn *sw, bool on);
>   bool AUD_is_active_in(SWVoiceIn *sw);
>   
> -void     AUD_init_time_stamp_in (SWVoiceIn *sw, QEMUAudioTimeStamp *ts);
> -uint64_t AUD_get_elapsed_usec_in (SWVoiceIn *sw, QEMUAudioTimeStamp *ts);
> -
>   void audio_cleanup(void);
>   
>   typedef struct st_sample st_sample;
> diff --git a/hw/audio/adlib.c b/hw/audio/adlib.c
> index 8b9fe53e17b..efab5107a4c 100644
> --- a/hw/audio/adlib.c
> +++ b/hw/audio/adlib.c
> @@ -34,8 +34,6 @@
>   
>   #define DEBUG 0
>   
> -#define ADLIB_KILL_TIMERS 1
> -
>   #define ADLIB_DESC "Yamaha YM3812 (OPL2)"
>   
>   #if DEBUG
> @@ -71,7 +69,6 @@ struct AdlibState {
>       uint64_t dexp[2];
>       SWVoiceOut *voice;
>       int left, pos, samples;
> -    QEMUAudioTimeStamp ats;
>       FM_OPL *opl;
>       PortioList port_list;
>   };
> @@ -88,19 +85,7 @@ static void adlib_kill_timers (AdlibState *s)
>   
>       for (i = 0; i < 2; ++i) {
>           if (s->ticking[i]) {
> -            uint64_t delta;
> -
> -            delta = AUD_get_elapsed_usec_out (s->voice, &s->ats);
> -            ldebug (
> -                "delta = %f dexp = %f expired => %d",
> -                delta / 1000000.0,
> -                s->dexp[i] / 1000000.0,
> -                delta >= s->dexp[i]
> -                );
> -            if (ADLIB_KILL_TIMERS || delta >= s->dexp[i]) {
> -                adlib_stop_opl_timer (s, i);
> -                AUD_init_time_stamp_out (s->voice, &s->ats);
> -            }
> +            adlib_stop_opl_timer(s, i);
>           }
>       }
>   }
> @@ -149,7 +134,6 @@ static void timer_handler (void *opaque, int c, double interval_Sec)
>   #endif
>   
>       s->dexp[n] = interval_Sec * 1000000.0;
> -    AUD_init_time_stamp_out (s->voice, &s->ats);
>   }
>   
>   static int write_audio (AdlibState *s, int samples)
> diff --git a/scripts/codeconverter/codeconverter/test_regexps.py b/scripts/codeconverter/codeconverter/test_regexps.py
> index b00e9ef15b2..1ab3fa1699f 100644
> --- a/scripts/codeconverter/codeconverter/test_regexps.py
> +++ b/scripts/codeconverter/codeconverter/test_regexps.py
> @@ -202,7 +202,6 @@ def test_struct_re():
>       uint64_t dexp[2];
>       SWVoiceOut *voice;
>       int left, pos, samples;
> -    QEMUAudioTimeStamp ats;
>       FM_OPL *opl;
>       PortioList port_list;
>   } AdlibState;

Reviewed-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>


ATB,

Mark.


