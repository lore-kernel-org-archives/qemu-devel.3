Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A51DDCE9D47
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Jan 2026 15:19:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vd8pu-0002BW-9Q; Tue, 06 Jan 2026 10:19:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1vd8ps-0002B0-0F
 for qemu-devel@nongnu.org; Tue, 06 Jan 2026 10:19:04 -0500
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1vd8pp-00049L-Mg
 for qemu-devel@nongnu.org; Tue, 06 Jan 2026 10:19:03 -0500
Received: from pps.filterd (m0127842.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 606AXcCK838756; Tue, 6 Jan 2026 07:18:58 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=LkAGPVg8W9mLpWhZ92px2q24xwccgxtjF+Y18qbjn
 7Q=; b=ioSUIHxXMEj6jpszJ3YdYuJieUcOBD9Az7EEPnbl84spMDTrZEOvihrg9
 Syrq7TnnyXXvE4p8Xbu4vtVwY00ykGaW1634TLkMmUmqhCz0iRiIAleavsmln5ok
 49KUhfs6mrAlYtX+76vAOrGIISLmalybDmlJ7cnqUnALtTAaiMgodIo+nwXx9PF+
 Tw/X5a5WNoCAUsjxnveQhB14joQ6sJvr9YHkzRIo33ragtoG2UwsHHiLH5rnA6Qe
 k21LshB47s6uJw7EdT6HWR0HmmstD/23cjXlkaQ09MlFKorAKPiyztX3gMO8HMVK
 91WFcRLY4BPIOe+68j5C4V7GvX4tQ==
Received: from byapr05cu005.outbound.protection.outlook.com
 (mail-westusazon11020095.outbound.protection.outlook.com [52.101.85.95])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4bgqg81trn-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 06 Jan 2026 07:18:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K9wcQoqhgULMWJTb+uAVgqW/wZ2yKoF1qY6q6JwfEmXRpUq+uRRCp1hHxqP2BCimRsOZbuLIhknIApPoXUesFjgzmWKBj7goWoLxQllJICEMDymLifx02eK6/+3QG1+Kev2iDrgrK8ybfADEtvYXDAG7XVFKR0I4+NL1o8/COxT2VtHvIVlZc1j8dQQXSUdXXXjZdFHHx8ioi2XGosKDOKbvSdDkTCWKN3u8DzwoyYnjmk9aWsyWZsJRgi7sCdElRwujtla7TxR01/0k5H/f4fDDfxH5zutxb92qZleFF9aOodNXNInDE+xv18+0MIagZMTtf/th3oJF63DCWmDmDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LkAGPVg8W9mLpWhZ92px2q24xwccgxtjF+Y18qbjn7Q=;
 b=nQoPgaDlnYbVvSjxiZl7R5Q/aVKEgjHcXfoJwz+HWU6M1kzfmAL4CzMBei4YRLAZ6EzChZLnXcTT7Dk7XurReL7NHdbuBEu1pbflecarsomUVAZMcnfxVC/FcJeI3RlkJa004ajMYUwZ+KNoRLXXR9osXEdnRFWhAKjzZryIs9Ioi9JYW9BODucw2tXAB4bCc+nap2++gx+TD/gj1mKZM3OqN2ijKxAHS6yTfGkffnBGojV8+PBIoZ+eePDIx89eWLyNPd7WD0sabKvVRKUsKxctw2YQlKJzaPYPcni8iSvBHY+AttkzdrpFahKPn3qDoF/bMjqri7HDwuDo9mOGbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LkAGPVg8W9mLpWhZ92px2q24xwccgxtjF+Y18qbjn7Q=;
 b=jlzAMVh8jvWdbzvBjQIuYPLJpJkHlkq/OpHvpDiuYNIKCwi/v5QeObhzGqWevu+hLmuafoXaG6F+VsbziYeYU49fu1Ip4Mp21LGHMzttMlHKPl2EwhK8r7IDul06BP9YDs9h2xsXU3cbO0M5eA/A5rc+CmNk14+59+YHcwHZNPWnepxxadD35dKaGYCSpAEwfs2YcdO7teWmxDieuspziHj0vjNlHZ0oEoNs6lDA1pcHgzr/t1AyaMWJ6MVwQJSNAaPkYrRX32PPSZ3SpfYTO49l49blWIKpmPFwBzyBzvt1j+RKk1YZV/5UkHf9MNi/Q0VtTD7NU4YUhVo+/7RJrQ==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by SA2PR02MB7578.namprd02.prod.outlook.com (2603:10b6:806:135::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Tue, 6 Jan
 2026 15:18:55 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%6]) with mapi id 15.20.9478.004; Tue, 6 Jan 2026
 15:18:55 +0000
Message-ID: <2ebaf5b2-1845-4af6-9da1-e4eb59fec0c3@nutanix.com>
Date: Tue, 6 Jan 2026 15:18:52 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/18] target/i386/tcg: update cc_op after PUSHF
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20251210131653.852163-1-pbonzini@redhat.com>
 <20251210131653.852163-4-pbonzini@redhat.com>
Content-Language: en-US
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
In-Reply-To: <20251210131653.852163-4-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR11CA0096.namprd11.prod.outlook.com
 (2603:10b6:806:d1::11) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|SA2PR02MB7578:EE_
X-MS-Office365-Filtering-Correlation-Id: c21b7c01-3208-497b-4915-08de4d36e833
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|376014|1800799024|366016|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Snc2eUlsRVNWa0RSOUlveFovZVFiSHNhZnBPendlbWhZSEJzdE1hWGxFTlo4?=
 =?utf-8?B?TmN6Q1lQaXNSWThiSFpuQmlFRExaamNiRUUyNTdPZCtNOTNiVk1pUTV4Z2Zj?=
 =?utf-8?B?S2crT0lzQ3Q3R2ZXVlpsdjRpTmRaZTdGSzdmV2RHQVBBbGN1QnVyN1VwSHpJ?=
 =?utf-8?B?eHVHOXRaN3dNbUUrdUlhWVBjS0hFMHZVeEtyVHJRMS9SK3FaRmRiZGNmVnh2?=
 =?utf-8?B?SzZabEhBaktqNmwzbXJlQ0ZxZlZiaVg0c0tEMlVUbXdINk95Vlg0YWdHUDNY?=
 =?utf-8?B?dlZyWU1mdzVMSkpmMVNGWDhNZC9lVEtVU2t0bTBxWnVSeCs1WStJd2w2VFNl?=
 =?utf-8?B?dzhVQ2V5NEFsdUFON0IrTkEzM3lYcFcwQUJiT1BqNWxaR3BEOWkyUHRJTGY1?=
 =?utf-8?B?QmYzSzdpd0JrdThnVVNwRmZkYmdvR3A3YUQ3ajBMeVU1TVVLd2Uvamd2d0pT?=
 =?utf-8?B?RnI0SHdLazdqR2czRm9Lc3NoNXFjVkFBT2FOYko3eDBuRjZpZVlRenc4U0VN?=
 =?utf-8?B?Rkxqa2JQWCtRZzV0UTFXRDdLUTBuSm9UTUJvcm9BdXMwbkEyOGxWNUtzcWsr?=
 =?utf-8?B?djI5NkRibDVKR0NHdWNsbTFWeTlEUHZVem1UazZvcXViWGZBRTJQWmFwN2Fw?=
 =?utf-8?B?RVpTYWo5NHVxRy9BQWFOdUVJLy9LUE1SVGN5SU5vL203TVRIRG0wMkFXMzdZ?=
 =?utf-8?B?ZklhclloZ2lURSt1R3lvSURPMDVFc1BBN2NWT0RqMitsUmNOTjgrVUhYRktD?=
 =?utf-8?B?c3Z2MkdIaFliU0Exc3pyNWJtTTlqRWoyRTdIM09GeWdQd2xDb3ZnSENTamlo?=
 =?utf-8?B?RmxEUXRoMFEvNW1LSHlWOXFNK0FDaC9SR2FvTHMvMlZhSDFSeVZ1Slp5SkVX?=
 =?utf-8?B?bURBOEdMbjNqNnk3ZHE4RjJMcjhKQUVxOEgxQldycGxDRytWMlQzMGw5ODN3?=
 =?utf-8?B?VzdzY0l1ZFRrc3pGeHVOK01memJVNVVxY2xQcDd4YmNNaU01aHN4OXQvZGph?=
 =?utf-8?B?RWpQVFJyaHFNQU9CVFhDQlg5eVRnSHB2RGllY2c3YlduTE9SQXBvRExFUXVY?=
 =?utf-8?B?WGJQYzhxNGFBN0U0U0FVWVZkRVlPZlhRN21iTmIzWWhBVjVoa3VaMXVOMjFY?=
 =?utf-8?B?ZzBQV1NxZkdoUUticGNrK3NuMVBWZTEySEVZTE9ZMlIwR2ZLSlRTdFMyQ0ZM?=
 =?utf-8?B?Mk4yY00zNEg2a0ZnU0JFRFEyMmgzdE5VYXA1a1luRWRLdFFMWm9JVG5WYVFw?=
 =?utf-8?B?bUNRbTUvdnJUV0RFdEdIZzh6UjN4NGJyYlFZekp2WFI1OXpuU0VGNHMyZHp1?=
 =?utf-8?B?Y1RWYnU3d1JJVHNlRS8xbXZnSmlzbXUzRHZwak5BR2s5ekdEVDBvTU5yZHpu?=
 =?utf-8?B?MnN1VVdIS3BPRVBTUmZGRzc3bXo2SmtEbFFXdXRzTjNnbjRMaFQzbkJ2NEIy?=
 =?utf-8?B?S0x3WEZUYVFrUXkwcVM4MWF0NmZmcnJjSUNNQTdpS2Y0RkdSN0l2S2dlMi9t?=
 =?utf-8?B?aHJueEF5L1JJUWs1cjdOYUNPcGdHNWdENkY1TDB4enVvNFJwWlNHbnE1eDdW?=
 =?utf-8?B?SE16eXNyNm1mcHhwNisyZWJHZTQ1N2sxSTNjUkFkNERQWmpHTWZBQmF3N0xL?=
 =?utf-8?B?ZHpIdDUxQkYrMDNOeVk5RUxZZ1A0cXE1TlpoOWxNcjBpcTB2OHM5a1lxOExn?=
 =?utf-8?B?WHZOenpIeEZOdXBkSDFOb1lMbjFMZlpmUndZbE1jR25QdFc4bVl5cVZCQUVG?=
 =?utf-8?B?RDZpUHR0Z0xxWWZaR3RMRjl2VU9yOTZybXFsb1BWWG45aHFydmVTWEdiWmhT?=
 =?utf-8?B?eHZ1b2VuMkQxTFRWNUcvUHRUSDF4b1MweG5EODJLdVIvL2kwVzA2RG90VGk1?=
 =?utf-8?B?a1EwNUxqVmticSt2d3laRjlOeFk3NnByZmpBbzlvcjE1UDRnRVFkeTgrL0t0?=
 =?utf-8?Q?MJRe+7HGS+wgcx0W2EcfAKqBFOUnj78Z?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(376014)(1800799024)(366016)(7053199007); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q09aNjZQVFZFVmNoZGFGWTh0TVNqeUJLL01tZ08rNDZ2MVhxeCtLY08rT0Js?=
 =?utf-8?B?TlRFdnR0Z25JdFkrV0NJWU0xTFk1NVhPa3dFUHJ1NlVRcnNDVURYRnJ1M0dW?=
 =?utf-8?B?aFpLMVZpbGJMczVwSTZsTEpnSWVYL2Jwd3ZHb3JjaDNDNDVkSm03TmhkakQy?=
 =?utf-8?B?bjk4Rkp3L3pmYUl2OS9HTzd6ekxTc0NKMm9WSm0yM3A1VWozTDlIVStzNFFB?=
 =?utf-8?B?Z1JkMWwwRnA1bTgrNzdoNnduK1IyY3NMd3Vid282ZFVDR3E2L3haRHFMZlYy?=
 =?utf-8?B?MnAybkZ6SExvL0xEaGZ4Y1pEZmlLMFowMHBYOUV3Z3g4aHdqRDhqTzFqd0tz?=
 =?utf-8?B?djY2Y1lxMjhNcnlKZEhIYXF4dXFwenRXNFFGRnpadHU4NWxGS2Y2VUtFSXlq?=
 =?utf-8?B?dzM1OW9WNkZVcmtXWFJYZHJVU2U1aFU2ang5RTNhdnFYZmhNcGZiYzFBQzFU?=
 =?utf-8?B?b3djQUh1ZVFkVnVaOFVCQVFPZ3dNbTUwdURwZjJ0SExYNWJCRU16cy9ON1ZJ?=
 =?utf-8?B?UGl0Z1d5T0tZaHNHYUNvQys5aFhuTkx0bncyWUdvT1JIZzZDK3VaZ1dRZnJC?=
 =?utf-8?B?cHp5cGVLMkFXVWttdm1yTzg4bHplVWQveE5IZlhoallWblNsUnNnQWFjZVJM?=
 =?utf-8?B?THl3MzJFNjN4MW8zZjdUTExuVE8vUHhjcDhBb1pKMm80UlR1dnFlNW5KcGV0?=
 =?utf-8?B?ajlyd1ZlRExKSFNHR01vNzBpLzNtQjBEQUlTZm1iczhYTnV5L2o0eEtrazNp?=
 =?utf-8?B?TGM0b0pnaEp0YmNmbkhIaGxiZURUUzZYWlZrbU5acU4ySDZuaFB3V0dZa1cy?=
 =?utf-8?B?VTNScm9zU0N4QWJGOEZZWEFIaTk5MmYva2FaekxlQ041SHp1OGMxMmZPZmpB?=
 =?utf-8?B?NHArRHhsN0dDZmNGVWtFOUNMUHJzM0hEMVV5N0tPb1B3UWVUOHJmdmRDWW16?=
 =?utf-8?B?L0E2TVozaHlUbzlLSjl2OW5CQytSWEIyV08zZld3alIzUHhYb20vNno3Y0lv?=
 =?utf-8?B?RktBeWlsZi9QVlBtTHVsYXIzMkRqYTJhLzFQeTRJRE96bkY3OHNUT01ya2lU?=
 =?utf-8?B?ZjMxbDlrTGNScVFyelIzNGQxUHZOTm1QV1NEb0xIemxYSllyajE2eVhZWTY0?=
 =?utf-8?B?NXQrYlBLZXNpS0RhRmNCMHZ6K3hpcEpuQWJpOWMvaDhRK3M2bC9vYW45UGN1?=
 =?utf-8?B?TUpvQjRmOGNNazJQWEppMVRxQng5aXpRRGZLcHZvT1Z4Y2dKSlJEdkZidThv?=
 =?utf-8?B?WG9DeW80SFpvMk0rRlRGNys5bjlVVVQwUG1UMnpHbWwrU3ZPckxLQnFra2hO?=
 =?utf-8?B?NU1TMGVDMko5dmF1YnUwOEEyY3BxbndUdzJDRzlqTy81RGx5K2xhTUV3ZlAz?=
 =?utf-8?B?TVo5bFNFZDh1QnMzQ0p0aE4yR1N2dlJabEpVT3pTeWtmbVF1VHNHSENERWt6?=
 =?utf-8?B?a2xDVDc3aXJIUGxubzZ1VkZoZzJ6NUtDWnFDTXZjVEhBZi93cDY2cXlsNERL?=
 =?utf-8?B?SWJLbURuM1I1Q0xIK2c2ZHVsY2NsTkFlaG5RdzNTUmlRWmdORWNCSE4wNDhM?=
 =?utf-8?B?aW5CS1oyMjMxWjljVmJvZW96Z1dMdUVCLythVEVxaWVQNVROeXJRblg4L1Bm?=
 =?utf-8?B?enFtMUdNMFpkT3o1MWRZamZSQ3Q2QXJaczlTYmJXVG5BMk5HK0pWYzhQNUkw?=
 =?utf-8?B?ZVByZGNZU0NRcVFSREwvWFBQeUFvUWd3SFVTR3BzdFZmcCthdWlLakZPQjA2?=
 =?utf-8?B?TVlqZFlEWDNYakQzbWJwOGFORVlBL3dHN2xCcFZkRzNBbnRkWUV1bjdjQktm?=
 =?utf-8?B?V2YwNTl6T1NpTTlXUjE3OXNrNFI1WU5nYW9zQXJyWHp4QnNYZTBXQjFhQzhY?=
 =?utf-8?B?bHd0Z3hMTkVBYVZQcXpEclRaelZjTFpyallLWS9Ud1J1Zll1aVZuKzg2OUZ2?=
 =?utf-8?B?ZlB0dENVRUFSamN3S1Ria3pGeHVhVU9uVFR2OVAyT0RnYXYvcTh6R2FJcGhF?=
 =?utf-8?B?NVRuUStlYUp4NDVBYWdPekJuQzdyTG11KzNiSEo0YTF1M0I3bFpXSHUwbVRF?=
 =?utf-8?B?MXlPbmtjcTdGbVRKMTl1QWRJYUpLMGVXbTM5dFordnBEeU9GRHdLOEJxb1Nq?=
 =?utf-8?B?eUd0MHIxdXNRUHBySHlpSnp2VGZLU24vQTliUFRTL0hMeCtsZkFOOS8yMjR6?=
 =?utf-8?B?UmVIMmdPODg1OU9uMUtTWVF3bEdxdFprU0JXNnJoVDhtYzNOYkQ3UE80SlJE?=
 =?utf-8?B?SFVGVDhtZ282cG1NWjVLK0E0b29HWG5LRVRaUU1jT253Q3dSeGhBeXpQMTVa?=
 =?utf-8?B?YnU0UjR5MURsTDV5c0FFNXRacVVyZW5scDE4WDUvMTVYaU9wUE5XQmpJTDBs?=
 =?utf-8?Q?OqgHewyKe4EpEGj9mSPJlZkis0XEz7ONzNmI5vRKryBlk?=
X-MS-Exchange-AntiSpam-MessageData-1: tExucWVm4J4nOfgazMw0h2i6mBIn5xQFHlw=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c21b7c01-3208-497b-4915-08de4d36e833
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2026 15:18:55.3920 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vapvYxf7s2Q9m/sU4Qc5IOf6/euieahA6hUaVz1+kvE0ddxkMqlc8DH2Quxp7XA0/0u4mV18GEGgZXGQXf9iJGeyNRy869LNcm1Bb8q04Hg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR02MB7578
X-Proofpoint-GUID: d1qs_dU90W7vREP-7vk2ObChLXaSJB43
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA2MDEzMyBTYWx0ZWRfX3YmMKA1/lCAm
 KdyPtYvO3f8RQKZdMqECWAFHquPACx3eHbN20mVfcaNQ2QETHgEuglPdZpCDWXD10oW7IzuJwLn
 8PLbw6lMJY95WsiGLifl95TsflxsGoEyBFp/6RQx/Obb/aOmqWsbTJ/ZxfuFPaPRlMmVagfGErM
 9Am05+YqCj8uy0x84Au2SL4O8m8k/6gfERYwSq/djBO7oK7z5lJR5o4j3eNFx6BexS9A6CO2E71
 xkGXNN9EnfINVVtgPaNrfNcT3uy75a8UzpZzNSkhon6ugKt4hMajirM9CW55l80dtXhaAPhnIje
 u59XLmGCFx4FCJkXcRSIYeQAr1pazNZLHhfeNJERJMSYkYpRrqu+9RPkHt4Dy1+Q9vHxsb1DwhV
 7CLyS0IS0IH06hTRW2EHzXP23Bixs6AS0MsLMfzzhvTX+mW5MeNdi7XpjAA3mWnhUzTVCQO893w
 I6cfVXbKAE24NjXorlg==
X-Authority-Analysis: v=2.4 cv=BaHVE7t2 c=1 sm=1 tr=0 ts=695d27e2 cx=c_pps
 a=ws69a72eWNNXWagsEosLDA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=20KFwNOVAAAA:8 a=Dm4J884ULPpXfFezsFYA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: d1qs_dU90W7vREP-7vk2ObChLXaSJB43
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-06_01,2026-01-06_01,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 10/12/2025 13:16, Paolo Bonzini wrote:

> PUSHF needs to compute the full eflags, set the cc_op to
> CC_OP_EFLAGS.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   target/i386/tcg/emit.c.inc | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/target/i386/tcg/emit.c.inc b/target/i386/tcg/emit.c.inc
> index 1a7fab9333a..22e53f5b000 100644
> --- a/target/i386/tcg/emit.c.inc
> +++ b/target/i386/tcg/emit.c.inc
> @@ -3250,6 +3250,8 @@ static void gen_PUSHF(DisasContext *s, X86DecodedInsn *decode)
>       gen_update_cc_op(s);
>       gen_helper_read_eflags(s->T0, tcg_env);
>       gen_push_v(s, s->T0);
> +    decode->cc_src = s->T0;
> +    decode->cc_op = CC_OP_EFLAGS;
>   }
>   
>   static MemOp gen_shift_count(DisasContext *s, X86DecodedInsn *decode,

Hi Paolo,

I noticed that my WFW 3.11 test image stopped working with master, and a 
quick session with git bisect pointed me towards this patch.

I'll see if I can dig further into it.


ATB,

Mark.


