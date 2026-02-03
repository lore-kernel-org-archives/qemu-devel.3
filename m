Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCFC6E87834
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Feb 2026 15:50:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnIff-00083t-4a; Tue, 03 Feb 2026 10:50:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1vnIfd-00083Z-AY
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 10:50:29 -0500
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1vnIfb-0002cA-9O
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 10:50:29 -0500
Received: from pps.filterd (m0127843.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 613Dk3TU3943894; Tue, 3 Feb 2026 07:50:24 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=llf8n8dgeg2LnVyQyuLfcZ60RF2iZDKpFuTS+iboc
 9s=; b=atNutkaoGUfpRgprkQOCUsuNFdgqk4CyZyShAtWoEmVJeHFWzc17hUTNJ
 H1zrf+yW+dBeO2l5I0SJ+11tjw7Eu4zYDjcPD1xY11xePQdykuVX3AnngLytTgvd
 BPW968EevJnadY1YFAhWHx+5WE3HadQ6VOVYHcxLBol9bYfTGCO7TVlXW6ezUVNZ
 RGdJSBrupsGaScj8VwW5VVMF3+n1m2jP1rjT+EXzt4wdfU4wVIniRmz8OE/BkKg4
 9BR6Y7kyFr+DW0tW6RhSzoP509GJCWSaEQeKT6n7cRBlFIg/0Y0Vrl/14SknrHbw
 ph2ZNmPziVb/gDCAg4XUinjFhy/vw==
Received: from ph8pr06cu001.outbound.protection.outlook.com
 (mail-westus3azon11022093.outbound.protection.outlook.com [40.107.209.93])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4c1gqhf3tk-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 03 Feb 2026 07:50:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xP4eQ7RIWlin+heSQIe5uAKUuG8UGKGYgVvrEP6/A7vENuiBSRUyRaC9uGR1W088+cUtj5cE+NA4UalDC+gvBccHXiLar/BJZdbQQIwzGnPwTPOqwDMrofcPyPeXNo5a5+q9KwWU+q1xV8JqUOb94wCB8OqQaFZaJCNn1nHSSwsGtikTyIZq8fEO+ElwYJq6anFYV6vPJBJx1Oac9iqIAXS5YRbQJMjStaFoR5KnoUFQXqyeJIoVhBfQyyBhOBD38bigUwl8a3e65EDqKlxSd1n9r43E3vpcsezv/4u0/nEiWxRqpXr5kAG+gH/Bh5NrpR77UEo+lUr2cCTANcrxTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=llf8n8dgeg2LnVyQyuLfcZ60RF2iZDKpFuTS+iboc9s=;
 b=YLIsA6IhP123sgDg9/My/gbcN0aV1NdsqrRjVixXD41zzWF6szHWVLifKHRsZcZD/8adNXdUji92Sal18Nixz1y2bZIfQcckruFnQJ+E9V8X7k7Z8PjS2Uz51XVmvqSj6Arl19/MHilMkSolnh+f3tZg+nnFCXYGz1zTSm6YvVLU3rI1mPdwMGnFNIVMKLXoJ8jYCV9NdHA9pnZc0qFkZJCoHjzrgck//FBuvvgKkw6AC9OEC/aPUxwrb5P2w/RZOCFcCHUIXfLMdsVh/wEAi7/szsr348+jSYz4Q9rKDPqA5JNrqpTf7qdKOVCYqS1NwJsFCze3w5UcjiBvkPsK8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=llf8n8dgeg2LnVyQyuLfcZ60RF2iZDKpFuTS+iboc9s=;
 b=W5g8AsAhfMkVJ2ndmFVpkY9qnDmYLnPnFURmFILHSD6vJl/dBwidDuaN455/PFXmjeWSaG8t2bo3GGU0n1dlPze6tbxvxco/pUp+Wc/cXlkSeZcCE05UUHHoEYbi1tQ7bUxusG7XNm43tcs2GwIPEgJHEnzuvgF9xX5BFM2a563M5vWcNJDOdU1iyyFP/TB8YzbEdSahuffiGubHX8GBo/Hj4CN8WBWk4BTUCajH0LtugUD8bqJ4sYnd6Fxi1hM/rio4qOIq1s9U+C2nlJwyJVCYD8ciIVLS8sPb1IgPaz+WwrKZchIqjxw2fFzBJfv+5JG3Q30SyJO/LH5UJ8q9cg==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by DM6PR02MB6794.namprd02.prod.outlook.com (2603:10b6:5:214::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Tue, 3 Feb
 2026 15:50:20 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%6]) with mapi id 15.20.9564.016; Tue, 3 Feb 2026
 15:50:20 +0000
Message-ID: <0a93e369-c88b-458a-b0b9-f30fdf83c560@nutanix.com>
Date: Tue, 3 Feb 2026 15:50:16 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/37] audio: replace vm_running with runstate_is_running()
To: marcandre.lureau@redhat.com, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>
References: <20260123074945.2563196-1-marcandre.lureau@redhat.com>
 <20260123074945.2563196-7-marcandre.lureau@redhat.com>
Content-Language: en-US
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
In-Reply-To: <20260123074945.2563196-7-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA1PR05CA0001.namprd05.prod.outlook.com
 (2603:10b6:806:2d2::6) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|DM6PR02MB6794:EE_
X-MS-Office365-Filtering-Correlation-Id: dd78b290-0773-4e0f-a538-08de633beee5
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZGNXQmhpU1JENHhmTGFlNkJJNzZGOTNXalNrMG4yMi9jbTRBam9CTUNhVG5h?=
 =?utf-8?B?MTRlcDhpRWtwZmdJM3Fob2kzSjBNNUl2ZWJiZGh6MVhqblVWVGxPc0RUUnBv?=
 =?utf-8?B?UXFCOVhseUp3bHZVMHRKemtJYkU2TkJ4TUU1a3ZFRDBjVWQ2YkJHdkQ5RktT?=
 =?utf-8?B?YXpQbUdwY1hvMWNyU2NQZU0rWDNkRngzdFhoVW1aU2N6bjk0NFZKbTkxazV0?=
 =?utf-8?B?OHBlUGZFZll1VmJsQVQ5REVMMjVIbCtDN0ZNQTVHMmFoalRsazJUTnMvQWZM?=
 =?utf-8?B?ampicjRYS3V5N0ErdzFvazJEU1ZRRFZkVmJwTHB3aGkrRVNBUlgyVlh6Ympi?=
 =?utf-8?B?UVZyNEhMMHBxYlBGZ2RRNi8zdkRZM1JodUtCY01uclBTcmZ5MTltK2dqdG0y?=
 =?utf-8?B?cjBycEpuZlNLTHdzcFBPS0QwQXhha2hXZHdmbzJsSjFDVUpFdTZSK0tMWnJP?=
 =?utf-8?B?SmxEYlBVMEZkTWFvM0VHK2NROE50d0FGWkk2WmZVK21sSWF0Z2VRWWt5bDRn?=
 =?utf-8?B?dmFhd3NpaHBKMi9yOHpTTndqTWZGaGtETlFhOU4yT0xoTzUyc3FxR3NDRDEz?=
 =?utf-8?B?VllVRU5rVVB1azd6Nk82TTlLRS9qaTRiQXRCcFBDUkFkaDZGOUM4VzV1NTBo?=
 =?utf-8?B?ZUFYT091eVBCMDFrODZFRjlRZFpTUUhUUmFuNjl2YkxKQkQ5ZXR0bWJtTFVL?=
 =?utf-8?B?ZEpYa09RenloaCtVMWIwNFlCSFZ0QlRRTys5MTVLTmhDcEtUNTY2aXBJWWJF?=
 =?utf-8?B?V1hmMCtpSXdRMkQxWVkyY2tJbDdGZlpjR0F5TXVkdzhjQ0gyc2ZEZytYU3gv?=
 =?utf-8?B?MlM3NUNjUFlBY1hXOFpvY2dZaldnYjgxQnFqTTlVSEhxdFZFMlowalNxendF?=
 =?utf-8?B?NFNQOWl2ZkI2ajkyTTFjSTRiWElVSjA5YTFhM1dpdVBsUCtDbExUeHRQcVNK?=
 =?utf-8?B?UVVNQmpPc1JVTWZJQUMxOFV5L1pYcEx1S2dQdmhGV1ArSVpXZGtPNFFsV2M5?=
 =?utf-8?B?ZElNdGVJQkZCcWIzNDd5S0xHMUFudWJyKzhKblpXTjlrZ1JBTC9kd05EQ1Jq?=
 =?utf-8?B?VktZUm9GaThnNjRCZ1BYK29QUkRWVWVRZjU0alMzT0xvOXErZ2QrUm5zU3My?=
 =?utf-8?B?YkR5WUhLVnVKV1Y3OFpHc3FvZklmMFBiYU55L3hPRUJVY0orUkJUN2dvU241?=
 =?utf-8?B?TEszOEs5UFM5TUVoK2lNaTlqN3hjeVBSL0FzdGRYTjI2WUw1eVVqQ1VUQmVy?=
 =?utf-8?B?QkxPNXc2UVkwcVlQQndwRHhuVWhLYTRKNmlFeE9KYi9zbFVZaGc1Z05jTDZ5?=
 =?utf-8?B?V01tVHhvbHNUSjViYUk0R0w3VEw1SmtqSnc5SlhyYk5adFlPMnJaQlZzK0U2?=
 =?utf-8?B?QUp1YlZ1blA5eURIdWI3VEYvMzFJd3hEb1FUeGxjMEJENENBOUN4bXRwcE1z?=
 =?utf-8?B?c1R1MU9sVDlRRXdQUENwek9CWVlwYUFXa0Z4cnBJMGo3OG83Y3dyWXFYeFJm?=
 =?utf-8?B?R0JGWXhrTG15c2l5cC9na24xcE41MWhwUmJCOVdWVmQvME9Nd3FtTTQyRUts?=
 =?utf-8?B?dERpZ2pSTDAzQWcvSkp0Zko5WEZJUGZIcEZmVDBOdDhaMEFpaE5OQnNJSUow?=
 =?utf-8?B?clVXelFMYU8wc0piN3VSS2ZHODdGN0VSNGZjQnhmTVVOYlNoZE5obkZvaUU2?=
 =?utf-8?B?eVRMWjBQa0dSRlVRY0lFSHhLT1Z1cW1sWDFoYnZQSWFpL0pnQmwvOWR5d3JF?=
 =?utf-8?B?ZTZ0S1FudFp1RWJOU2hoZ0pTRlBCWmwzc3dKMkNlQmxLMHI3RlNuak4xNUxx?=
 =?utf-8?B?KzhQWUhCeXpsaFBKSzBMS0xjRzh6cE9KdkxrRFU5WWJEd0w5K0VrWEU4MGwy?=
 =?utf-8?B?L0srWEMybnN1WDJYSlVzbWo3UnFHN1R5bmRYYWxuWFhpMGl6OEVaR3kzWEVo?=
 =?utf-8?B?NEsrZWZZY0JIKzl3V2Y4MkZNSVc5aXNKdzFJcHZieVdrTmFxQXpGYnRnZ0tr?=
 =?utf-8?B?QlZQSFh5ZGlaMTZWa0JSWS9vc1czMEI3OGYvS0JEWUJTdzIvbUVYSHJCcWFw?=
 =?utf-8?B?QndxV1ZKSE9XcmtWQmFlTHdSa2VNRkdCUVROYlJWNWVjNEJuY0NSV3c0Y0cy?=
 =?utf-8?Q?9E1Q=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7053199007); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?LzhkZFRXbkRHbUp5bExMSnZQV2t1WXdUUS9VOTdvU1dEdmVmZWtKWjR2TS9h?=
 =?utf-8?B?YXRxQXowcGgvWTdrWXpFaytnTXJQejMxU3lkZG5ONGJkTFVIK3RGU3Vob29y?=
 =?utf-8?B?VHJ6eDlqblJXYTVVMkxOaWNqTWZ6OFBCbDN1WG9XQk9ZRWVUL3ZtL3Ivc2ov?=
 =?utf-8?B?TzRPUVB1TFZTanVIdlAxc2RvNzFncE1DTHU5c2thNWczVy9ISmhXL2VYRFMv?=
 =?utf-8?B?SEdJcHNBYnlWcitscHpTZTB3SlZ2T1dVMmM3SGtsN2VpeXViSldmcFlVa05s?=
 =?utf-8?B?ZzRaWS9KMTU4MGFyZXdCanZ3aXJnang3a2dJMFEvUU9qK0F2WnpDbHVKNzVS?=
 =?utf-8?B?Z1BvRC9OZ1VQcHVjRUNkNFdzMlE5a1JTYTRpWWprNy9KRVplMUNhQUpxZjRK?=
 =?utf-8?B?OVMxQjlMOTl6U256ZE9PS2RybjlqYW50dkErWWJBMXI5S0l6V2tPYTBJcUhu?=
 =?utf-8?B?WnVvcXNFdEk5VE95eWJ0MC8yMm9mb1E2VmllMEhOcVBWNkx2WWk2YlJGNGZO?=
 =?utf-8?B?K21oUWpxU2Q4ay9hODRoYTVHMGRlMzArRkVoL2pjKzdseVZhUXZ4TzVyWEh3?=
 =?utf-8?B?MlJvUTF2Y1VNOTl6UXVOUFVmM3o3UEFXem1IRkNYZStOTHZNMEpCenZSMFhR?=
 =?utf-8?B?dkxHQ3YxR0QvNWFDaVQ5YXFHWDNYWWlHWVdpRFJodVR5M3VZNVNzNVFLTDE0?=
 =?utf-8?B?Y2ZFSEx4bitIalFDWEJkNnRnNnlTWEJyMnBtWU9la3dsNnNSci8vaE9rL0hJ?=
 =?utf-8?B?WGNTUkU4Z0htY04zVzBtejREN05oWVAzS2RGRXY0V1pQaSsrUzllWDZybUNm?=
 =?utf-8?B?MDVTYmxBOGcrZmJ1L1I1SXlUZGo4VU1zTDhTV2JITjBiS2lxeXJ4MVJNVDBo?=
 =?utf-8?B?UCs4ODFwNUdWajlYdERSUldORit2MmxDaHl2c2JYYWp6bk8wdzUvM2paRkxN?=
 =?utf-8?B?dE5ucU1mRGkyanBQZ2VSTFYyQ0NTcERRUWE0VG5QWjk4MFNNdDVmQ29BL2ZC?=
 =?utf-8?B?bGpoMitMcUZRZHVqN25ZVXdML2JkaHFlZ3p5L1VHN0pPVys3dFFEbE13ZXcz?=
 =?utf-8?B?ek5wWE92VG10Vit4OTIvUzNGZkxBbXY1UEtpRXJqaUdMOHV6UXB3cDNHWWdy?=
 =?utf-8?B?eGFYZFk5QS9rWTZSZW9pV3hVMlQwOUhweUNyU2dBYWFtdWlBWmU0K2tyaEtO?=
 =?utf-8?B?dC85RHFpNjBHcGc1V3BKVk9hUmJwbjIxbk9rNjFoNS9HWlFMRnBxVC81TEVz?=
 =?utf-8?B?SFkyZ0FnY0MzbTNmZWdkWlgwQ2ZqeUVudzEvbHV5TmRwUVQycStWMWJqNmpj?=
 =?utf-8?B?SXlEaWxscHRmV09oWjlHSTFGWkxCbGJWYjQ2TCtXcXRIMGMzY0NvVnpBTlJn?=
 =?utf-8?B?a2F0anp5ZHZoNHR1OGYzT3dCM3NsdHNiMHphbnhjUlo0WVJuNjhxN2ZBMXZZ?=
 =?utf-8?B?cjQ2ODFCZ0dKYktqSVExV2FzcTRqVTk0NG55QWhmdWliZjdYejVOZzdNbGZ0?=
 =?utf-8?B?TnVDcFZYWUlaNnFiQWtDdFoyUzdPMkVvZUtsbHk2ajA1T1RqQnkxc3hGdG9O?=
 =?utf-8?B?Tkd1K2NJVVRkV3JnblFWd09iQXBlZjQvU1BmU2NqWkJGZVJkamFFKzdBeWV5?=
 =?utf-8?B?V2k3djR1cjZvVVZCY3duVS9xWHU3NzVQZGhuendzMFpEaGZxZTMvUkwzR1Fl?=
 =?utf-8?B?NGdyR1B3NVVCNUhBOGsrRWhvQzIrYjNTT2p2RytHV2hteVFycmF1UVB5ck5q?=
 =?utf-8?B?UWU5ZFY4QVhmYlFyM1B5ZmJuMWdRT3Y3RmErOU5kSnQ2alpzOHIyK2Q5QmZG?=
 =?utf-8?B?QXU5eTJYVUZiUFZ4Mm5vc1k3eXJuL0JOZXl2TWUxcW92OElEdlAyV0dJTzdR?=
 =?utf-8?B?dWdjdDc1Qm9aTmZvby9IczZPUHAzUVYrM2ZPaVhpMmFhVzJuZG52dTlsa2Jj?=
 =?utf-8?B?QnQwTmpyb1o2aDRDWmY5TytNNVhaSHFZUHZQZkJjZUdOU04vSS9aOWZJdXY1?=
 =?utf-8?B?eTNha1hHdUxPUUtzbDhlWG5OT0ZkYzhJY1dLWG9YbmdLOE5KMysyNGRPWFlZ?=
 =?utf-8?B?dEJSNCswaHoxQ1Ird29iWDh4dzhUVXVybzZRSlcrUGtFT2F4NVMxSlpta01m?=
 =?utf-8?B?NUdZbmUyN1hzdGk3YnhDd0htWGpBbWxIbEMxc0pza0lwMmUzQnZHVlIrSkNu?=
 =?utf-8?B?a3F0UzhjQ2cweWEzMGpHdGYzbG82TEx6UHBUR2wyMXlGVGlyOEdsVHJWTElY?=
 =?utf-8?B?K29qSW5rTWU2ejFXS3BZeFFJaDhWZmFWaDdUR0dVMkFaVkRwdjFOa21wMU5S?=
 =?utf-8?B?RW5CY1FDa2dkTng5eSswVWZYdFBQQi9tWjR6bVhXRXdqSjh4M2RPSnQvdEha?=
 =?utf-8?Q?FLzNmW/UOPjOmijk=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd78b290-0773-4e0f-a538-08de633beee5
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2026 15:50:20.1678 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YdKg7PPDFXT3eCTWgNaAFZf4G0lC2ioyliIkTdiYDF0vPWBx02vZsoPu1b8sNKUlfHnzl4wR1ig75/2lYGDtCGuDBsHEuo5K8OmLHGd0UY0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB6794
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjAzMDEyNiBTYWx0ZWRfX23HthNSNby3/
 be7kFtBGh6peQ62IsDUQEDUilaIW8xtnsFusBobZB3GJgbsNGDCrb0MODJJZ8NKBYzqME5BLXAw
 n4LhL/ju9nOT8yLaZvod7M+L+HKcnrGRXleju1Pq0xxeZ0FiImLVbaaZdYYZmVFy91kjyl0X2ic
 YPdUlaDocVuAOc+yQ2jiyf1XKSo9NvLJ8tTH49neCZhy/XYKyZjkBVBw9so6mUQv0qaMzoR0/i3
 d2GTn+cx/dEhivI0dgjcEMytz3ufn24ZqdDwJoBroY2amzlz6K7KxGxKa/Jh9JarwTETzfiYT2Q
 R+9qWFRPCrWLNrI2Vd9LUb/HCsSyNUCygy7CbwDSYQC3joQUqQmMRgD9dqVB1H/WQ/Fg8/kVLIk
 yJWb2qqNF3phSVSKDDTCiNxviSgzea9HuCFU9Y4053KJnbj7FMrWTxlM52+8K69al2Hold00PNz
 3lxp2/Tg6sks6uPaIDQ==
X-Proofpoint-GUID: Hsi3Sk_kqqmmyqj2UDOI6i1KONQ4JkxV
X-Authority-Analysis: v=2.4 cv=aNX9aL9m c=1 sm=1 tr=0 ts=69821940 cx=c_pps
 a=+aoWgcdf8QL7nCWWbKbTBg==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=20KFwNOVAAAA:8 a=64Cc0HZtAAAA:8
 a=C2h4wLsRbquofRvj964A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: Hsi3Sk_kqqmmyqj2UDOI6i1KONQ4JkxV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-03_05,2026-02-02_01,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0b-002c1b01.pphosted.com
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
> AudioBackend had a vm_running field which was set in
> audio_vm_change_state_handler().
> 
> The state change handler "bool running" argument is true when
> vm_prepare_start() calls it, and the VM runstate is either SUSPENDED or
> RUNNING.
> 
> Audio hw voices shouldn't be running when the VM is suspended, but only
> when running. Thus replacing the vm_running field with a call to
> runstate_is_running() is both simpler and more correct.
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   audio/audio_int.h | 1 -
>   audio/audio.c     | 5 ++---
>   2 files changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/audio/audio_int.h b/audio/audio_int.h
> index 20b4c87b0b6..25de0e3f9cf 100644
> --- a/audio/audio_int.h
> +++ b/audio/audio_int.h
> @@ -252,7 +252,6 @@ typedef struct AudioBackend {
>       QLIST_HEAD (cap_listhead, CaptureVoiceOut) cap_head;
>       int nb_hw_voices_out;
>       int nb_hw_voices_in;
> -    int vm_running;
>       int64_t period_ticks;
>   
>       bool timer_running;
> diff --git a/audio/audio.c b/audio/audio.c
> index 80e4ba83712..5b9d352f325 100644
> --- a/audio/audio.c
> +++ b/audio/audio.c
> @@ -932,7 +932,7 @@ void AUD_set_active_out(SWVoiceOut *sw, bool on)
>               hw->pending_disable = 0;
>               if (!hw->enabled) {
>                   hw->enabled = true;
> -                if (s->vm_running) {
> +                if (runstate_is_running()) {
>                       if (hw->pcm_ops->enable_out) {
>                           hw->pcm_ops->enable_out(hw, true);
>                       }
> @@ -978,7 +978,7 @@ void AUD_set_active_in(SWVoiceIn *sw, bool on)
>           if (on) {
>               if (!hw->enabled) {
>                   hw->enabled = true;
> -                if (s->vm_running) {
> +                if (runstate_is_running()) {
>                       if (hw->pcm_ops->enable_in) {
>                           hw->pcm_ops->enable_in(hw, true);
>                       }
> @@ -1597,7 +1597,6 @@ static void audio_vm_change_state_handler (void *opaque, bool running,
>       HWVoiceOut *hwo = NULL;
>       HWVoiceIn *hwi = NULL;
>   
> -    s->vm_running = running;
>       while ((hwo = audio_pcm_hw_find_any_enabled_out(s, hwo))) {
>           if (hwo->pcm_ops->enable_out) {
>               hwo->pcm_ops->enable_out(hwo, running);

Reviewed-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>


ATB,

Mark.


