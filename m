Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD1EFCAC592
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Sep 2025 13:41:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v0gmc-0005Dd-CU; Mon, 22 Sep 2025 09:40:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1v0gmX-0005D9-NM
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 09:40:42 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1v0gmO-00009F-78
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 09:40:41 -0400
Received: from pps.filterd (m0127844.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 58MBDBEZ1614443; Mon, 22 Sep 2025 06:40:24 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=d/AUuii+ub3Wr8B3zEWyICQDtpN53shEsqp4Y3v/i
 tU=; b=UWsxt7qb2EJs9hM6tyzRoFs056jH9pu3JKKiilyxLO6zFXaXpX40Ew6oJ
 BQmKSSaJ++AvCtOGX3wHQTGgnPNNG+uvCJl4z3Ltr9m8W3r2ac3ooe9bTapLUei2
 72+ZcPNbUVdH6VDp5gGCxGXKOpaMejJyeAehHGssRtzuxrNoVY0vY2BzKCA97qF+
 wBOwaFHnhvifc8InE/9MoMW9aqWDH6mAwvRC3s56Rnf1brYORFsO4DmecfA3stdh
 khkJFbMk831RbSUNFjPaI0oxTyvAwLbm+p/JJJFrhYpgGqFbcSgXZgXdGlxK7LQU
 KTy8p+9Y1Uw8xLq+LdXhYEieW4gcA==
Received: from bn8pr05cu002.outbound.protection.outlook.com
 (mail-eastus2azon11021102.outbound.protection.outlook.com [52.101.57.102])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 499usyk414-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 22 Sep 2025 06:40:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BIrtdXwdCQ5PAfDVmTmQ6KfL7bkY60NqbaZplvWV16eJhcS04lWcZNELmRqEXR7A6vvcBLte9vDWZ9y69gSopUk5M1Q3nDvnntxnNldgm8gG8fTIO03Ft96dFIykHCvad+LLA5N76TAV03pMrq73JEJToFKxxwW3sBec4l6UKiqk2Rw+AzJJEaXIo/u+xaX2HNke5hMKP65WPmkBoVI9qXY1zq9NNSeJndBNpsQIBu41TgX3Z6qoeAsij1VEX2rI2X+M7ELjWpxqyZ89BdXQwGopYOxr+7u0P1lRXI1QD8bNgK9oCQ38gldgTsOjcz5uMsXgEKjjIE3D1QeRcVHflg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d/AUuii+ub3Wr8B3zEWyICQDtpN53shEsqp4Y3v/itU=;
 b=qcziRCXpGc+cPNPqRrtPk1yOGy1xSk5D3wVnVe1BDehk+0AZ5X8zHh64YdIn3nXAa3xAmrGESsUSA3bZIoOcbcmiLQEWmu5mZ+s742879euhh5L8tyuoPDNyhoqB/PoEiy15whaK9hrXWtuYfmS6xYCDwj0D+rZWRkPB+pQKhIZC666KFQ0Q0N2GlkGfNsv6MlUFFcIfRJQt3hyBHNCMCku0sA2Cqx/TdJoFJ0OzTo6Kxhq4O0Dp512QTWJpUs95EF6yyqsyz0j2V0gXdlenTNRqWl0+Z8amN5YAFOnAeqrLLHd8re3aDiMR52dRQrj//lYpHIv9JJ/JiGtFLTc1Ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d/AUuii+ub3Wr8B3zEWyICQDtpN53shEsqp4Y3v/itU=;
 b=FjTnobmECK9CCxsItX23Y5df9f9Z0OuL1yQ7w4ZNs8pJkp378qjTWt+6e7ZCGMqrH2FIVIcpYKLVRc8cY3xbStIPmjm8i3WXWikmyL4kn/3vWyLfTkvi1v7EeuTRB8delhRNiNfRPDEnMLTNgOcEQUXDmTNy0fzVCfNfLu5c4atrGE74b4D62szGcK88kw9GUktqrNMeDHivVD6O7zNwfILJNzseCUm9ci7XaGAVz7bw6s3ZqBf2NOqxxWJpynpuv+DOi/itdsVXdnyxOHS1NQQcBS2Jt9cdkL2VJM8uPDyrPor63QZt29tpjG2YUEaEsNcCFD9mxB7gxCW4NhRYVg==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by CH2PR02MB6776.namprd02.prod.outlook.com (2603:10b6:610:7d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.14; Mon, 22 Sep
 2025 13:40:21 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88%3]) with mapi id 15.20.9137.018; Mon, 22 Sep 2025
 13:40:21 +0000
Message-ID: <47bafa95-2d4b-441f-b686-fdd418de48e7@nutanix.com>
Date: Mon, 22 Sep 2025 14:40:16 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 01/19] hw/i386/pc_piix.c: restrict isapc machine to
 32-bit CPUs
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Xiaoyao Li <xiaoyao.li@intel.com>, pbonzini@redhat.com, mst@redhat.com,
 marcel.apfelbaum@gmail.com, eduardo@habkost.net, imammedo@redhat.com,
 qemu-devel@nongnu.org
References: <20250822121342.894223-1-mark.caveayland@nutanix.com>
 <20250822121342.894223-2-mark.caveayland@nutanix.com>
 <3c2e9fbc-db80-4dd6-a1a5-deeabb8c0194@intel.com>
 <58c515a4-292e-4aec-b57e-73be89b9c322@nutanix.com>
 <a37565e6-77fc-4bf2-8c6b-6f1b22f6c01f@intel.com>
 <1e005bf5-4c02-4906-bed8-7d7a55681dd1@nutanix.com>
 <95370c12-4bce-41cb-a514-a41ee4595d5c@linaro.org>
Content-Language: en-US
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
In-Reply-To: <95370c12-4bce-41cb-a514-a41ee4595d5c@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM8P189CA0018.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:218::23) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|CH2PR02MB6776:EE_
X-MS-Office365-Filtering-Correlation-Id: 521d8955-4f56-474f-ccf0-08ddf9dd9341
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|10070799003|366016|1800799024|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?V1B3ZGNlbFRIK291eU1lZzhQL2N2MjNTNUZiazJudWpRaTEzTHhsNzdnNUk3?=
 =?utf-8?B?SXRyQkdRSjQ3cWpFWXJJK3lHem93MW9XT3lHOFFLTG9qNVZuM3FWRXpvanRp?=
 =?utf-8?B?NFgvUHJNWEo0VW9sSkhtZFozSGdlaVdMckpiU1JuTnlNY3BBOWJMQ3BLNTRT?=
 =?utf-8?B?NTFPMkMrNmRlbVRVOXM2SDR5U1YrQ3MwL3JhV1IvUERUbEJVWXFUdUw2dit2?=
 =?utf-8?B?UXFtakYrRVJyaWVkOU5OMnZYbnEwMVppVFkrR3VEY1ZGRVVjZnFmbXhlQUFT?=
 =?utf-8?B?emljMStjdDVJSWpmcTZTcDMrdXdWZWlyYjRreW5jYld4N3ZocmZ1SzVJQ0hl?=
 =?utf-8?B?Y0dVYm5QM3dHNXVLcm1wT0ppQUlGQVhEcXFiSWJOdTBQc3lteXlHZjFCL0J6?=
 =?utf-8?B?cVRocERJZUdpcWZZS3BwdmU5NnlQTDJUYXlNQURTK25uVnlneWk3Rzkyb3k3?=
 =?utf-8?B?Vy9EY1Y2ZFFId3lQMkdHbEIrbXpkZm1ER0kzazByVUd5WjVSVkVMMGR3UW1W?=
 =?utf-8?B?UlZPeUVRaXhwMTUrSU50TVJoT0tOUm0xT1Z4OHdBdUN3dy80YXorMkgyaDdm?=
 =?utf-8?B?aXpNeUU0dncwSWFSMDVXT0YrL0dwNmx6d1I3TXJ6RW54c1dNN1BRVmw5VzNy?=
 =?utf-8?B?aVNBaGZNdWdnZWRSNUkrR1VzRFN2VWpPUFJZVEthQmVwcEdlcGg4bGp2OS9C?=
 =?utf-8?B?YXJBdzdvRkg1WWFpTDRxRG1CVytENG1MUVJZWGdJYUtjdE1GWE9DSGZyOUEw?=
 =?utf-8?B?Z2JYUHhUU0dXaUhlTVhUdVkwZFI3R1A5bHoxVHYxYTVKQ00xemJDcEZpMUYv?=
 =?utf-8?B?WjBnbENhL3VlUDk4VzRqVTIvMkNjMVRCR3JJczRpSGxqRzcwWVlCTDZzTmZO?=
 =?utf-8?B?TmNTTUx5N3Y2Uk5OTC9BSUNXTDlGRjh5RzRLemJjTVpsRkQ1NTlibS9pRW5O?=
 =?utf-8?B?K3MvRHByWkFGdERWNWh6VFdnanNpQzVmREtFNEszSUdEUDdaOWFmUTZtSXlJ?=
 =?utf-8?B?YjkrT2VyU0k4N3FqSzFZTWF2ZVBzc1Jsa1ZHbWNPRWlNcVdGV3lKb0ZHYWJE?=
 =?utf-8?B?ZThaTnp1N3JhWGc2clFPTTVpT2JFQ05FVGxHS2FsalUyalRMUDZrMldEa2M2?=
 =?utf-8?B?bjVGeVVxZmoyQitoNXpCM01LMmNZdUtkdEF3cmhZdE12N1BuNktEZitKbUhx?=
 =?utf-8?B?NVlseFN5SjhTdWtXcWx0QXU4NWRaQVNoOGtPcTdYbHVtZ2liT0xBVmVHc2ZO?=
 =?utf-8?B?RzZlaWEzd2VROTN2K0xqWklIWWVsQVVISy9kMXBWSW53V2RTRitkbUJ0VHRr?=
 =?utf-8?B?aU0zL3V1MlVXUzlSOWZlV1Q4clhiSnlBMmhiVkdSK0c2bmsybEtTcXJUT2hy?=
 =?utf-8?B?ZVFNLzNEVmFTS2VzWkYwbHRIZFpiOWFYeXB3NTF4WHNYL3prRGhmUHNmQTVn?=
 =?utf-8?B?S3ZYUk9mbjNKS21CRVlQYU5iWlAwL1dPL1paY0pPZkdqQW1DdG9INWdreHNq?=
 =?utf-8?B?MEJDN05MM0NnSklvM2xObVZMYTNpMzhmTXZpYjBPdTdCdkpDM0c5Mlo1cVJQ?=
 =?utf-8?B?YnQ1ZGZaVFY1RWFSYTNFVXJnYmtocU55OTNUbFRLM3ZBQzdNaTJ1dk1adlBw?=
 =?utf-8?B?Y1k4TWw0dnloVUtPY0M0WEtUSEJwdFVKdFYxVDVBV21HN09hZlJ6TUdnZUo5?=
 =?utf-8?B?d3VveE1mY1NYc3pUN1ZSVngyZy9aa1FydUdyclFXRWJld1J5ZlU0Y1VUOWw3?=
 =?utf-8?B?OGkzT1BDNSs5Y3hPQ2xJTDBMTDF1THdlWHpZbFJrNmFrS1Z6VEEraHNHbnJY?=
 =?utf-8?B?RERrRnFXRm95eVhYZGF0UlF6YVJKSVQ3K0I3Vlh1ZWVKaDFHQlpMeC80Rm8x?=
 =?utf-8?B?UUlFbG1XZVQxWDRDclRITnR5OSs3dzZ3Z0FBSGFMNzMzeFcyd205VUNCWTFS?=
 =?utf-8?Q?HQ1KtcTpFeE=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(10070799003)(366016)(1800799024)(7053199007); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TExzUTN0WE5PWGFzV1ZiM0tPMzBFcVYra29yTmdvRktnb3NiQ2pYMDk4WmhC?=
 =?utf-8?B?Z2R1STMwaDFpQnAwMmdVdlFXYWtpeXJSRTdmZXRteEt0U3krV014eDBGS09i?=
 =?utf-8?B?OUdraU5ZSkJkOXNZWThDaEM3OEJROS92aHhxa3RFazIwTitlcGtqR0R6V0dD?=
 =?utf-8?B?RHhrb0VPM2pZN0V0SVBXNjRYblUyQWdIZnZRZ0lRd2hqN1BYbVorWUVuVGE3?=
 =?utf-8?B?V1VoZVNpTC82Mis3RUpWeE1Od1IyL09ldUZKN1gwUUowclRJTDRDeFQ1VEY3?=
 =?utf-8?B?YVRFTUY5UDhZdndnVDdHOSs5d3ljRHNzNGVscnRmWmEwb2lhVmNTblIxd1gx?=
 =?utf-8?B?V2MzSnpxcEkzVDFBRnlSVzNUZTA5SGNLNlpDN0hYZGVKYUp0eXRTcW1IandQ?=
 =?utf-8?B?SGFyYS8vczc3dUFiMnd2aUFkZW1DejJ1UjdhOHhiSWl0eTFOTjJjVUJZUEJL?=
 =?utf-8?B?Z0JkZi9BMkxJdS9GbllmRVVuRWRQUHBWZ0NWUUNVSm5vWm03WlpjWklIQzJp?=
 =?utf-8?B?Y3JnbmVnb2lHVzlHakgyZFhEdlBzelJBTWJEdjZtWkUzU2FTWmUvQmtXRE1Z?=
 =?utf-8?B?WHU5VE51dW9nNVg2VG1YS2dZRGdUTFRxTUM5bitnK0ovWG0wTHdlRkx4RnNE?=
 =?utf-8?B?RC9kclgvRm9xNTUrVjNycW95MHBBb2duUjdQdyttanpYQVJjRjUvM0FyeExK?=
 =?utf-8?B?T1BTRjZwaFE3OG1reWlvcXkzTnNlOHpYRXMvNVV5ZDdsdUFrOFpxdWYyTjh3?=
 =?utf-8?B?dE00WHhpSTFyTmRrQkh3MmlZOG5GQkpNUy92K1lmTWhjSzlGTmRJTm5qR01Q?=
 =?utf-8?B?WXR3V2lhT0xveElwOWNNd0pJY29EaHdUQjM4a2RJNGVmUG5leGVFSWQvME0w?=
 =?utf-8?B?dS9WSjVGQXQvWHlvcFIzL1JhY29uV1hwRmU3ekFCSnZYcml2RGxXNldPVUZw?=
 =?utf-8?B?MnYxSWw1SUlIY1dVMGl5MG5CVldsZzgxQ1padUVHQmo0b3BheWRrUFp1Q25E?=
 =?utf-8?B?TkNMMWp3OHY0NjdYS0UvYzl2K25PZjN6R0I0OHcxUlJJYndBZ3RObU9wVW9m?=
 =?utf-8?B?UGFOVEloZVdLQ3BtdWJpTU1sTXdzZVk4MWh1Yk04QzBvN0RSaXBsN2VVYXN2?=
 =?utf-8?B?a1o2Nlo0NVc4S3Fpb3pSeVR4RVJPV1A4V0k5Z2VPSmhrdTNySThwSmFlQlh2?=
 =?utf-8?B?UGxoWDVBRUYrM2xTM3JIZ2Q2S21DY3BOYlJpVE9DbHByeXU2UFlzMWdpOW9G?=
 =?utf-8?B?b3NlbituaU5NVDR0ejVQL1ZMNlFvdXFGUzhwQlVwTjB1Ynk1bDR1dTh6clhN?=
 =?utf-8?B?KzV6NmFqbk40cnVNcG1OU2FGaFljYnU2MzZ1Tk4raGt6WXlBdmlQN3pwMEJE?=
 =?utf-8?B?Z2t2am44TlczRGxoWm5MbGVPK0xCL1EwQmFqekU1SnVoV1V2eU8zTzZXakFJ?=
 =?utf-8?B?ZnVncGNrMm1SRzEzcHMzWjdpSit4Vk5KMjR5SVVjK3F2WEtiSTJkSWdraktq?=
 =?utf-8?B?eGZwU2F6MFNoMFU3dCtqMm1lTS9tZWtCSlcwVXRrelhCYkY2QitiRnBEZURh?=
 =?utf-8?B?Z0pkdWpmZC8yQUR3Q3hMYjlPL2tPb096VTYvNXU1a2MwN3Q0TDlmWWU5RVVY?=
 =?utf-8?B?RUJZdHBZWjJZQkdnUzUvNXdmODNBQTZscWRETVlqT1VVVDRUQjBkTm00ZmQx?=
 =?utf-8?B?MjNrQkJvcXBTNHVyMUNNTTg1VTMyc2hzd0N1dUp3dWE0N25wVEFGU3Vtd3dP?=
 =?utf-8?B?MkNRUURSNXo3T1pkTThSQlpsZWxQTEdmZStDOCs3aEo3SmhxbHhsSGY5b3ps?=
 =?utf-8?B?cjFsZFpWUGJCYmdjelJGQTNPckxycEdxQ1BQdmg0WVNkemdOMlROdVFzeDJ6?=
 =?utf-8?B?Q1NtbEp2VnFka080eVowZG9IVHZMVEx4SGVlVjRlbGhqRUFMc1NjSi9sbDZa?=
 =?utf-8?B?dEErNUlVWUpDU3FYR2lyMVZaR3pxNkwwL1FuTWVUR3hRUXkrdUNhME9rbllx?=
 =?utf-8?B?dzZPMmxhVnJhazJHNEhtQTNTMkpZVU0rcithMGs5OUV1cWVvaVZldHIralRO?=
 =?utf-8?B?K2QvZzFpMjlxZmVWZzJaMDJFSmhPT3lkdTNpOVFLeXZuQjZqc0VZMWV5bHVZ?=
 =?utf-8?B?ZFFqNndZcFpVdFRQS1lIQm1DVVJ6VWdYeFFCMVROdytEblhJRGZsTGJwVmRC?=
 =?utf-8?B?c3VQZGJoL3MyYXFEbTdjSGRQbXJCVS82eTRCZGVTejl3b2dLWW1IMG1MZXM1?=
 =?utf-8?B?L3NmaDdhbGVKd0c5L3ZveElheXdnPT0=?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 521d8955-4f56-474f-ccf0-08ddf9dd9341
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2025 13:40:21.2538 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U5UC/xm7voOB/2PH7aY4+PiRw+49ZdCsD2c/c3L/DDN7w85Vb/2bQXdm0tc2tQpQImtH3D9UoCpQvPximIxIF+k91wc8RCytnrCH8unhuEU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR02MB6776
X-Proofpoint-GUID: KCCZJs2GBMHy_WCPH2DFkAJhVy2441n9
X-Authority-Analysis: v=2.4 cv=L7sdQ/T8 c=1 sm=1 tr=0 ts=68d151c7 cx=c_pps
 a=FCTj0ZxOUpDcrOysB+wcjA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=0kUYKlekyDsA:10
 a=64Cc0HZtAAAA:8 a=KKAkSRfTAAAA:8 a=x3kyCDXIpjXiOS-LhesA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: KCCZJs2GBMHy_WCPH2DFkAJhVy2441n9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIyMDEzMyBTYWx0ZWRfX0QfxMcp8movA
 sCL2L1qaaa0J57xGuINmvRvMr8B11arq9n+B+oSOuvF7OEe+2HvVpVcvsbSyaVhA5junkRFXJdv
 LVGmbJbuAmQzTcQMkgvQJ86nqwfUGgqDNtGKpCyoZVYMBZpwz6SV97OK+dj1h2/U7Zu3bgOCZJ1
 zpDgiVWwmqSSY197jd25fCEhgm9MpfvEU5K5rCjA3CbsIQEyNrZPsEZx7StIUl5zbWWUemOHDfT
 uNR1L2/lpCPv9isMMMPgZeVjEZj4lZlaS5OowsaCGcPpvt+dSOFv8ko9vEulFEyowmUzU0TQK3v
 kKf8Dh0hLvFaV+wryr2Tx7ezmup7Hxm7SIUKakhlgo5611gTGS7O3aEl5QUgBY=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-22_01,2025-09-22_01,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 22/09/2025 13:01, Philippe Mathieu-Daudé wrote:

> On 28/8/25 12:42, Mark Cave-Ayland wrote:
>> On 27/08/2025 12:50, Xiaoyao Li wrote:
>>
>>> On 8/27/2025 7:10 PM, Mark Cave-Ayland wrote:
>>>> On 26/08/2025 08:25, Xiaoyao Li wrote:
>>>>
>>>>> On 8/22/2025 8:11 PM, Mark Cave-Ayland wrote:
>>>>>> The isapc machine represents a legacy ISA PC with a 486 CPU. 
>>>>>> Whilst it is
>>>>>> possible to specify any CPU via -cpu on the command line, it makes no
>>>>>> sense to allow modern 64-bit CPUs to be used.
>>>>>>
>>>>>> Restrict the isapc machine to the available 32-bit CPUs, taking 
>>>>>> care to
>>>>>> handle the case where if a user inadvertently uses -cpu max then 
>>>>>> the "best"
>>>>>> 32-bit CPU is used (in this case the pentium3).
>>>>>>
>>>>>> Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
>>>>>> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>>>>> ---
>>>>>>   hw/i386/pc_piix.c | 26 ++++++++++++++++++++++++++
>>>>>>   1 file changed, 26 insertions(+)
>>>>>>
>>>>>> diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
>>>>>> index c03324281b..5720b6b556 100644
>>>>>> --- a/hw/i386/pc_piix.c
>>>>>> +++ b/hw/i386/pc_piix.c
>>>>>> @@ -436,6 +436,19 @@ static void pc_set_south_bridge(Object *obj, 
>>>>>> int value, Error **errp)
>>>>>>   #ifdef CONFIG_ISAPC
>>>>>>   static void pc_init_isa(MachineState *machine)
>>>>>>   {
>>>>>> +    /*
>>>>>> +     * There is a small chance that someone unintentionally 
>>>>>> passes "- cpu max"
>>>>>> +     * for the isapc machine, which will provide a much more 
>>>>>> modern 32-bit
>>>>>> +     * CPU than would be expected for an ISA-era PC. If the "max" 
>>>>>> cpu type has
>>>>>> +     * been specified, choose the "best" 32-bit cpu possible 
>>>>>> which we consider
>>>>>> +     * be the pentium3 (deliberately choosing an Intel CPU given 
>>>>>> that the
>>>>>> +     * default 486 CPU for the isapc machine is also an Intel CPU).
>>>>>> +     */
>>>>>> +    if (!strcmp(machine->cpu_type, X86_CPU_TYPE_NAME("max"))) {
>>>>>> +        machine->cpu_type = X86_CPU_TYPE_NAME("pentium3");
>>>>>> +        warn_report("-cpu max is invalid for isapc machine, using 
>>>>>> pentium3");
>>>>>> +    }
>>>>>
>>>>> Do we need to handle the case of "-cpu host"?
> 
> "host" is not in valid_cpu_types[].

Not in v6, but I added it for v7.

>>>>
>>>> I don't believe so. I wasn't originally planning to support "-cpu 
>>>> max" for isapc, however Daniel mentioned that it could possibly be 
>>>> generated from libvirt so it makes sense to add the above check to 
>>>> warn in this case and then continue.
>>>
>>> "host" cpu type is the child of "max", so "-cpu host" will pass in 
>>> the is_cpu_type_supported(), the same as "max".
>>>
>>> While we are changing "max" to "pentium3", I think it needs to do the 
>>> same for "host". Otherwise, "-cpu host" won't get any warning and 
>>> expose the native features to the VMs that are mostly not supposed to 
>>> exist for isapc, e.g., the LM CUPID bit.
>>
>> That makes sense given that for compatibility we would want to hide 
>> more modern features from the guest, particularly if running legacy OSs.
>>
>> I'll make this change and likely post a v7 soon as there are quite a 
>> lot of changes here already, and wait for any further input from Jiri 
>> or Daniel.


ATB,

Mark.


