Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C1CCCA1002
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Sep 2025 13:28:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ut4Zu-0004en-EP; Mon, 01 Sep 2025 09:28:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1ut4Zl-0004b7-38
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 09:28:01 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1ut4Zi-0001VY-C5
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 09:28:00 -0400
Received: from pps.filterd (m0127837.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 581ANInm3259095; Mon, 1 Sep 2025 06:27:54 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=nEgRg/oUHvFvbf+IXv6vnDyGWugcCJr72/uRVlzol
 EU=; b=Hu62pKx181gvNoZcu6OR0/llO3P8ynPvNpMHR1UzhWVjNRVXjywH7ULPm
 Ubt1/+K2r36qlB3+EMfA2FKUw+scWRdNyHThdWTLE1Y4q6NXGwyVxK/XtuLWsTk6
 AmkLxfvxEgZ+jsKFyMY25hHeoeUFAhhmOgEyAAuLeWSBA2edmV+yEQ5s3YO/GtN2
 D2vp8XCAqh29tj6mGaEVPPKrkxiiRtcWvqO+k4zynqXdSfmEsu6mg2C5Y+5bvPFK
 EdX+BpY66Jy4gLAGnM1bRSH7k2V3q5VHxKAmh48kQOKcry758Gc/+XCIOdGzIGZ1
 F/u8apl0D0mzOddRpdmDzmRS1FN0A==
Received: from nam10-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2139.outbound.protection.outlook.com [40.107.93.139])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 48uw73bebu-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 01 Sep 2025 06:27:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WN96ZD85OTXHrYr+0l2wAOv8+aITDKiLE7nYpa67G72I2cxnBQNfgKWR6hJgqHI7PWCaGlfAskNvzDd5hfF9JIvOnxJ4JTjhT8+svS+WzLiqQP9cLC+M2NAjoBcO3hq9W6dG6z3j3q/0cEBe0F72yZg+QOCI2IRCqM/C6bVHTucUSdXNsPN+trRSy4dCLeavW8cbVj+T1I1Om3KAehVxt+GRyxp2ngxbmDUctdCQnZewHJXiAa9dEkQXlR6S+Yy3ncTzNNPCQOwCcnP/HNJMgjRp8/qEskD6laQNfPxH3VnSqH9ADFCY3Df/kfAw5o8JNwVCj+hHQP44hkLFsOs3ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nEgRg/oUHvFvbf+IXv6vnDyGWugcCJr72/uRVlzolEU=;
 b=W2301JXvSa/zk7P/OC8YWSowcQsuDzaCs8qTMl5cLNGjSCp2WPXPN2MBpoeXrYDU1hAeWxyijQP+x0UnUOuxHW4TC6bjnfRL0WEtHSSl79l7fgb7vYHAXo7MqjCUsR+CGgxjic2K/sH2NaZ9DE6MYRtZGrE99x86OJ3hSpaU7q+QAld1cCw4Uek828oth0UcLK9cRO3XMlnLKFQm0oMq4vpyy4jutMhwDPeSbywf6lp5BVBb8JPWsNl2nOQICeT0gv7zhWHIOuf1z3JuhEvyJwgqVeEQdrJ8NN+i3XldkXC1djUL0kuwssyqC/wxrhBgcXlOPSINg8gSd0lv657kgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nEgRg/oUHvFvbf+IXv6vnDyGWugcCJr72/uRVlzolEU=;
 b=TNSWjjFZhOSywqEFfNsSYetO6a3AOjBeg3uuD69lVuXuWExuJ0m7VIHxrxgOp1gnRUN+E/L8ssZIvVGwlEd5Of4LAUeqyQ5S1yep23ZA0/J8e1kHRMe4979VW4rBakpR4SzrnF3HvBoXrBjSM+qEUoQZMKWs6AcHgQZX4T2ltxG5MIFtKMZD4phHajsg/ktz/vhAJzeNOs/Os/w6Jm6iw6bHgcyL2SMU5mlNNrxeFRrIg/JxzUCYTxwd+HPBH+7VPjnhpcNAWqtqoC6DLL3bBT03MKtkN0Aj/k18Xhiz24l2WBCNdiWrzGgp179yp04ywdWEtEafFfh8Oj4JqONArA==
Received: from MW4PR02MB7153.namprd02.prod.outlook.com (2603:10b6:303:65::11)
 by LV8PR02MB10166.namprd02.prod.outlook.com (2603:10b6:408:186::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.28; Mon, 1 Sep
 2025 13:27:51 +0000
Received: from MW4PR02MB7153.namprd02.prod.outlook.com
 ([fe80::2d8:c73a:b2f9:f1dd]) by MW4PR02MB7153.namprd02.prod.outlook.com
 ([fe80::2d8:c73a:b2f9:f1dd%4]) with mapi id 15.20.9052.025; Mon, 1 Sep 2025
 13:27:51 +0000
Message-ID: <193d8893-7bd8-4fe9-97e6-501d186d4f9a@nutanix.com>
Date: Mon, 1 Sep 2025 14:27:47 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 15/28] hw/i386/pc_piix.c: assume pcmc->pci_enabled is
 always true in pc_init1()
To: Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Xiaoyao Li <xiaoyao.li@intel.com>
References: <20250829125935.1526984-1-pbonzini@redhat.com>
 <20250829125935.1526984-16-pbonzini@redhat.com>
 <CAFEAcA-xknGH8H-1M7xtkWwQHfb47+f7MdBqrt5UmKsh3As6OA@mail.gmail.com>
Content-Language: en-US
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
In-Reply-To: <CAFEAcA-xknGH8H-1M7xtkWwQHfb47+f7MdBqrt5UmKsh3As6OA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR01CA0161.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:aa::30) To MW4PR02MB7153.namprd02.prod.outlook.com
 (2603:10b6:303:65::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR02MB7153:EE_|LV8PR02MB10166:EE_
X-MS-Office365-Filtering-Correlation-Id: 8267c910-a515-43d2-3af8-08dde95b59de
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0; ARA:13230040|376014|366016|1800799024|10070799003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bjljSTQvMTZ0K2dsZER6dktUNkhhVGxza0xncVZ4VWF3V2pHTFhmYmNnbHRj?=
 =?utf-8?B?WU1md0dmcFRzS1F0K3I3aWVub3NrNUhYTC9SQXg0TXBXMk5zYU5UNEZlaTZG?=
 =?utf-8?B?QVQzOU1YUEFxV2pTck4zNTFUdFQ0VU5IM3dBOXBqOGh4U21GTGJ1MlNPM1d3?=
 =?utf-8?B?ZzJXV3BBOUhjWG9ZMzV1NEx6N2FaYkcvNEg2UUY1QVhnOEd4c0cySGtIaUZI?=
 =?utf-8?B?N3pselgydE02Q2orMHBncGRYc1JrYWI1NnRBTWhSSE54RExuQW55MDNVN251?=
 =?utf-8?B?am1XaGZKY2k1NlVrNHhmK2JTQmNibWJMWm1OczJQRHIrbnhGLzdMazdWWity?=
 =?utf-8?B?b08rZWNpdDlFem5rZGNWN3FtY2FZVDNpM0QyUDVPbjNyWGs4Y2JoRWhSRFJp?=
 =?utf-8?B?QnF2MVIzNSs3Ukhla08vWVg4aGpEeTQ0ZDFJREVFWGRMc2JVbXUvNDF0S2lM?=
 =?utf-8?B?cWxSUFlmOUJ6VFN6L1RpSjFwK0Zyb0xKazd4NWhsZnFtVHFIallSUXRVay90?=
 =?utf-8?B?RVJkZTBld1cvMlk3Y24zQXRqS05IT2VaMk42Ny9tZUR5NjlURHd6ZW5Xdm5F?=
 =?utf-8?B?eXA4YTJaeDBsNy9MdlZkdUVQNloyR2hIUnJ2YnhybDcrK0Fwb0cyckJDVlJh?=
 =?utf-8?B?cFAxVW94Slk2aHRzVG11VGlzV251SWR6Z2NxZWpiU1pyaGZHOWJzSW1BL0hZ?=
 =?utf-8?B?Zk12Vlp3TDQrYWEwcTVFWGJNbmZPbjB5SW9wTDBIMTZtajVzYjlqOXRFQzE3?=
 =?utf-8?B?ZnpwRVZ0UTJEbU9Ic0VURDdXRlJFb1djU3VjR0w2dDA2NU1zcU9jUDJuOHl6?=
 =?utf-8?B?dlJPMnFGV2NCMUtIK1Y2RG9vK3UzZkF3b1d1ZjE4dGlGWTZ1bzFiSEhQSUdu?=
 =?utf-8?B?Z25RNC9PV2dySGZuZUNKZEhUVy9RRDZzRjFHUHBlR3JwUXk4TFY3QUNDeDR2?=
 =?utf-8?B?MmU1Q29LRWNESlB4V2kzNkMvb2xEMlVBTmNxeE8rTXVxK09vSi9sbVRjYysx?=
 =?utf-8?B?VklCYzFhYzhwQTl1dTdTMGUydlFUbVRtcmozeFJ2ZUJBenlFWldvazl2MXh4?=
 =?utf-8?B?SmxhYjk1eFhUcGEzYWNjd3BhMnpxOTlod1hMUDg1ckgvMDJBczYvM2FzaFFZ?=
 =?utf-8?B?RWZpMW5ZZUQ0RURJNVl0NVlZMk8rVnVjZmU4QkJwaVR3QWpaU0p3TnB1WXR3?=
 =?utf-8?B?K2RDQ0Z3TzViSUNITExCcW9TWmRKUHlQeUhuUVRxbXA1bnBRdWp3VzhSZXc1?=
 =?utf-8?B?WGNyWk0vTFRUREtORnhGYXNNdUNEZjVOR1QzbFZBKytRYmlYK0MyaHN4NlB4?=
 =?utf-8?B?bExmeXg0Y1JyM3JQdkIvMmxac0U2Z1NObDJxbi9DWXp4bzBaaCtzTm9RckxP?=
 =?utf-8?B?aGtjRnpVRzVhblA1a29PVHp1MmpRZjVyOE1FUFNJR0ZVSXpkRWJhK2Jxb1ha?=
 =?utf-8?B?MmJVUXlhM1FwblVyeGI3UXhrZDhQMi9CY0RJTUEyRVd1cHlPN1BNNkprbi8x?=
 =?utf-8?B?NjNoS1RIeHhNNzY3MTlDdmlTeHk4MUdOQmRIeXJHUnprUitRL2VJS3FDbnRB?=
 =?utf-8?B?Wnd3b05sZ1BHeitHbnp3UVpQd2hvVTBFVjRVcGlMU2RzblZmMk9laE45T0pi?=
 =?utf-8?B?SDRNTU1HcDlRUHZZM1NCeVZKZmo3eERWV3FRUnRxai92YnpValpLR3VlcXJW?=
 =?utf-8?B?eGdjM0ZUd21EancwTDQxc3JMdVNLWU00QmF6N3B4SWYxV2QyQXc0V25xbHRn?=
 =?utf-8?B?dm1XREYxZzU5azYzemNjVlFqdTNEeTdraXAvclJPSldtdHZiRW5Fa2h5OHZT?=
 =?utf-8?B?eExSSmFJbVFEL2EySTQrVkw1YjN0TU40RkFxYUpkcWc0N3Q5cnZpMldWQ1FE?=
 =?utf-8?B?U2tCU0hvakMrRS9Va3p1YnY3TExBa1dyU0JBenkxL3V0clhzeWg2MWwrcXR1?=
 =?utf-8?Q?TJteRtq8Cx8=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR02MB7153.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(10070799003); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bGRCd2NSV0RXc2VpL0ttS0x4NTMwYWVNRk41a01NZ1NrdGo5WWNFcjQ5cWxE?=
 =?utf-8?B?YVgvOGVNb01lOEdjUWF2ckx0THRSUWxhS0pKUmZtbW0wU0ZDNEdNUkpNL2NM?=
 =?utf-8?B?Tkd0Tm9aWlFDTkkzLzRId0wvN2lHT0k5MUlMSThXQnpua2V3d2lKYzJxMHBu?=
 =?utf-8?B?SXFqVXRIWWtLaWM5ZVNLd0NBOTJMakMyTys5ZHVYZUR5K21oMzV6UENSMVdq?=
 =?utf-8?B?RC9McVMyZ0xoYnJacDNrc1Bjd3BYclA0TElPblpIQ3pqYXN0Nit1M3F0dURl?=
 =?utf-8?B?TlFMOEN2djBlTm9NN2NyWldJOXFKSFdmem5xbkdKWklvWlpEMDFyeU9mSEV3?=
 =?utf-8?B?bXBVNFpXWk1pZHFlNXlBMXBMckNIaUE0aE5IcVM2WkZRcktuVGlGek9hcjQv?=
 =?utf-8?B?M2dvc09ZSFdwVG83UHZURmNnMHUrU1hYTEo3cEFneFVDaTZzN29ZRHlrWFEr?=
 =?utf-8?B?eExOM3VNbHFjQk14V0h2S3psSVA4UGZUS1k0ZGlQUC84YnMrak9HZHpNSERh?=
 =?utf-8?B?Y3VZOWlFU3VWczFwQ3E2bEpoN21HOGlTWjd3cnFZbUVCQ1EzcUVDWHJwc2NT?=
 =?utf-8?B?blhmRys0cXllYzNWNmM2c0xiZDRhVElVVlAzQzVsY2orcUFRcVdJb0dYT3Va?=
 =?utf-8?B?M2xhczRVelhPejlEcThYcHE3Um0vNHpjNmV3RmE0OFFRNCtrdjlkbi9XcGZJ?=
 =?utf-8?B?Um1qMC91djhUcEdGM2VJUVpXbm9oNkJLSG5aamRDYXNQVWlrZFJDSDZ3b3NL?=
 =?utf-8?B?Z2NZSGdnYkFwdmNITE04eEkyT3ZMTllHNWxkS29jSy9XUjFjbWRFbi9mdEZM?=
 =?utf-8?B?elRtbkRleUNXMkw4T1phTTh6eDZvMHdRN2xoZWl1NmJTZWNzL3NMcVYyT25S?=
 =?utf-8?B?T05DeUF1amk1aW1IdUc0NUJDOUxNdldJMDNYNXZQZFpzRmpzTzNwbTJOMHE3?=
 =?utf-8?B?SUNmNktibGEwaVlNbVY0MGlEUlpZV1BSeXBSL2RCRTJMQjhVR2Zxa2ZHdmQx?=
 =?utf-8?B?YVB1U2FvbEVoZ2duU2ZJVCtETGlYZktxMnNod1NEME5wbkgzUWZDZHB2bjNu?=
 =?utf-8?B?SUJ4VjVSamN6bk51S2Y2ZHBNMWxFalh3bktSNkdBMWpmYlpvcW9HeEhYUGI1?=
 =?utf-8?B?RG9xR291K3RObzhEVDJxOUJCczlZYzF5dzcvQnNKeWY0UUdZdE81Zm4wczBL?=
 =?utf-8?B?TnlUaWwxVEVLQ0xnc25jZk1ONXFieXVqVElLUFhNUFk1a0tkdDZFZEFrdDN1?=
 =?utf-8?B?YUF6ZHhuL1NEQ2ZRcTJLSk9KTEMyQ21UQzZmdUNOU3pCd1lzemRDV0JEMk9s?=
 =?utf-8?B?OTFuUXo4MFpRTkNuaUV0SmRYZ3p1QnRaaTZUNExLdjdCdXk4RkFzanlzU1Vu?=
 =?utf-8?B?cXZPellTZ1hIK2FhcnNscG1hcVAvL0ZGOExsaGcwNTdvNVVNUTBSVkJvdWxP?=
 =?utf-8?B?bUZjNXBiWVp6WWx3bTMzRVlHbUdBeUtzTUtZQXhOa1pUeTZEREhpbk4ybURv?=
 =?utf-8?B?NEFhRjV4ZTE0NjNaSGJRanAzTzF6dmM3aXMyaWJYRXhHR2ZUNEdEQmxSRDhs?=
 =?utf-8?B?bE81NTdBQXpwY1RSV1NCWTA4V2JLcHUrRW5vWWR4Z2hQOHdIcUg2WUdEUkRD?=
 =?utf-8?B?Slk0S1pYNThIZWNCcGYyMGZGUEIydWZNVjJmSGFmUUVvdkdhK0hiWFhxcGRp?=
 =?utf-8?B?MTd0NWJjNzBmSi83Vkdmbm8zRzFuUEVyKzZLRDZDbStJSU5SenhLMFhZbXlY?=
 =?utf-8?B?K09oT1RHajZXeGtJSjRPQVh2RE9yY3R4S3M3dHJDMTlySXFycjRKNGpTQ0FB?=
 =?utf-8?B?YnZXVHpKRGV4TUVsRno0YnRFaHBwK0pUVG8rd01CNExCNnFwZzdGQUNIS0RW?=
 =?utf-8?B?MkVsbVZyTkZGSzFLamxjMWttWTRJMDI2V0o3RFVEbFRVYWM5bXFsQTFndlkx?=
 =?utf-8?B?bE9oa0YyVEk1Ynp5SGk2S3Y3MEFjSTdSS0xmZFZTNVg4SkdNZ1FSTTcxVVdD?=
 =?utf-8?B?MUVFNGZVVGgveXhjcXI3cmRaQU5WT0FLMmRyaDhnQkR2VEVZeVJiSVd2TXRt?=
 =?utf-8?B?Qlh3VTJ0eFRBcU5hSGQxUDBUbnVrK2RpOVpXanVWS21RekU2QkE4ZEtxaFQv?=
 =?utf-8?B?ZmxWYTRkelAydldGQnBrQXd5RW5nUkMvZjJWOFpQTVp5dnJ2UHZaS0NlZTBm?=
 =?utf-8?B?c2JVakFWYzBYTTFOUytvSmgwODN4N2Z2d1dPSmdLc2htSFJVSEtMY2RwNTdU?=
 =?utf-8?B?RTV5Q1JydW45dTAzL0NpNk5SYnNRPT0=?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8267c910-a515-43d2-3af8-08dde95b59de
X-MS-Exchange-CrossTenant-AuthSource: MW4PR02MB7153.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2025 13:27:51.7884 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wF5RtplMe/QqosLt3U9EDEh8tYpCjO939Qgbq5yH8FTqh4jfoCx9nF0GbmUhKQoPqTRy8yDvI86yxzZKm23iDgWOf5mNJEZv6kUdmhNW06w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR02MB10166
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTAxMDE0MiBTYWx0ZWRfX3Q9D+4hCK6sa
 W2uWW/Th1iPKMFPjkZss97+zBZt3RCRfzMTwaPLKm6ZqxyXQEP7NfAFa+ujEgVpjpJUn2S8BBWi
 qTKUU1ODetxxiDpr6l2hLx1UFWsJhToRdpHlSgkFOUzIJLaCahw4lfrFO0uNSt1iWA7RtSqaxmx
 uIJsL9sUFUT+raq+5WvfYdD8OPxfuV2r4T1S5y7G0lcS72DUKzsCgLhjXMaRRH/VQNGEXGOjsdg
 ov37YmxVvMr7Lu879qyRSrOMs4TRziw4SQBZYTid/L8Ju8/iH3WpNJ9MVxjpn3k9wsIqOWzIXHo
 bz9UuP5tfQC9zcuoFerY752cqq6+QvZ7OZzEPdHD0a1EQ3+ZFVmt4Cztl5yVwE=
X-Authority-Analysis: v=2.4 cv=e4cGSbp/ c=1 sm=1 tr=0 ts=68b59f59 cx=c_pps
 a=6wgRmHCTc6xn0E0miKewiQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=0kUYKlekyDsA:10
 a=VwQbUJbxAAAA:8 a=64Cc0HZtAAAA:8 a=20KFwNOVAAAA:8 a=KKAkSRfTAAAA:8
 a=QyXUC8HyAAAA:8 a=swgS3yEVU0j_gt56R38A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: eQkllBHie4UH1_xioagHFV6XlR9rYhxZ
X-Proofpoint-GUID: eQkllBHie4UH1_xioagHFV6XlR9rYhxZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-01_05,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On 01/09/2025 11:43, Peter Maydell wrote:

> On Sat, 30 Aug 2025 at 16:57, Paolo Bonzini <pbonzini@redhat.com> wrote:
>>
>> From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
>>
>> PCI is always enabled on the pc-i440fx machine so hardcode the relevant logic
>> in pc_init1(). Add an assert() to ensure that this is always the case at
>> runtime as already done in pc_q35_init().
>>
>> Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
>> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
>> Link: https://urldefense.proofpoint.com/v2/url?u=https-3A__lore.kernel.org_r_20250828111057.468712-2D16-2Dmark.caveayland-40nutanix.com&d=DwIFaQ&c=s883GpUCOChKOHiocYtGcg&r=c23RpsaH4D2MKyD3EPJTDa0BAxz6tV8aUJqVSoytEiY&m=j27iua4jCqP3vgs27zBndXoJkryZlZLXIKTEEzLwm_3CiXikGXPBG0bXR6OX5MxL&s=EzEQ_YRd0ipeIVCSEOqy2TMkBTRS59USrtlOTA35vC8&e=
>> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> 
> Hi; Coverity points out (CID 1620557) that this change means
> that an if() check later on in the function is no longer needed:
> 
>> @@ -195,38 +200,36 @@ static void pc_init1(MachineState *machine, const char *pci_type)
>>           kvmclock_create(pcmc->kvmclock_create_always);
>>       }
>>
>> -    if (pcmc->pci_enabled) {
>> -        pci_memory = g_new(MemoryRegion, 1);
>> -        memory_region_init(pci_memory, NULL, "pci", UINT64_MAX);
>> -        rom_memory = pci_memory;
>> +    pci_memory = g_new(MemoryRegion, 1);
>> +    memory_region_init(pci_memory, NULL, "pci", UINT64_MAX);
>> +    rom_memory = pci_memory;
>>
>> -        phb = OBJECT(qdev_new(TYPE_I440FX_PCI_HOST_BRIDGE));
>> -        object_property_add_child(OBJECT(machine), "i440fx", phb);
>> -        object_property_set_link(phb, PCI_HOST_PROP_RAM_MEM,
>> -                                 OBJECT(ram_memory), &error_fatal);
>> -        object_property_set_link(phb, PCI_HOST_PROP_PCI_MEM,
>> -                                 OBJECT(pci_memory), &error_fatal);
>> -        object_property_set_link(phb, PCI_HOST_PROP_SYSTEM_MEM,
>> -                                 OBJECT(system_memory), &error_fatal);
>> -        object_property_set_link(phb, PCI_HOST_PROP_IO_MEM,
>> -                                 OBJECT(system_io), &error_fatal);
>> -        object_property_set_uint(phb, PCI_HOST_BELOW_4G_MEM_SIZE,
>> -                                 x86ms->below_4g_mem_size, &error_fatal);
>> -        object_property_set_uint(phb, PCI_HOST_ABOVE_4G_MEM_SIZE,
>> -                                 x86ms->above_4g_mem_size, &error_fatal);
>> -        object_property_set_str(phb, I440FX_HOST_PROP_PCI_TYPE, pci_type,
>> -                                &error_fatal);
>> -        sysbus_realize_and_unref(SYS_BUS_DEVICE(phb), &error_fatal);
>> +    phb = OBJECT(qdev_new(TYPE_I440FX_PCI_HOST_BRIDGE));
> 
> phb is now guaranteed not to be NULL (when before it might have
> been NULL), so this bit of code near the bottom of pc_init1():
> 
>      if (phb) {
>          ioapic_init_gsi(gsi_state, phb);
>      }
> 
> can be simplified to unconditionally call ioapic_init_gsi().
> 
> Would you mind sending a followup patch to clean that up?
> 
> thanks
> -- PMM

Thanks Peter, I've just sent a patch to do this.


ATB,

Mark.


