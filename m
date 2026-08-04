Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25D48C5518F
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2026 08:43:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wrAjy-0005hx-MX; Tue, 04 Aug 2026 04:43:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1wrAjx-0005ho-Vd
 for qemu-devel@nongnu.org; Tue, 04 Aug 2026 04:43:13 -0400
Received: from mgamail.intel.com ([192.198.163.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1wrAjw-0001Of-9X
 for qemu-devel@nongnu.org; Tue, 04 Aug 2026 04:43:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1785832992; x=1817368992;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=NnYQfn3P/ZTMdmajkeT0Mk7TGVw/de4EEA08b/Q+TOE=;
 b=QBr3txPX32vL6BE2FbszwC6YhTlnKo2pCKXXwlaKixrwUHqcNxxl5MtU
 U0HFB3jMkM+TnArgV3ZNbwR9Phh/7fsbDY5DD33HYPe1Gx1wLP1JCd7QQ
 4Z0OQyP0bLibzCzbbD8UvQSGle3DtMbMUOzGtDm0OzFY9vE0wP5kG0URp
 7qkpZRVpPxQEhGl8L2GXWNJNvywEH7ug+tYrDJjq+Xg3cl5CgKLE0Bcil
 LoHUqZYcYKmuhnG+Xpft21uzpfeh6qLtmzeO+9rIUyzwXR/0G0+cysoQf
 BMcEHXqmKeaeWv6jboZvhsw8gc+n5idNlggR29d4S6R1plhaMKSM3Y38A w==;
X-CSE-ConnectionGUID: /VMp3HrAR52Bvn5HBtxVVA==
X-CSE-MsgGUID: uvx5xPQ2SEalRln4sWliMA==
X-IronPort-AV: E=McAfee;i="6800,10657,11864"; a="85358175"
X-IronPort-AV: E=Sophos;i="6.25,204,1779174000"; d="scan'208";a="85358175"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Aug 2026 01:43:10 -0700
X-CSE-ConnectionGUID: XM5KDLxnSdiaiPY+NPCCfA==
X-CSE-MsgGUID: QZgHRII4SLm6VLu5oG5m8g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,204,1779174000"; d="scan'208";a="257564100"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Aug 2026 01:42:56 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Tue, 4 Aug 2026 01:42:56 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Tue, 4 Aug 2026 01:42:56 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.49) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Tue, 4 Aug 2026 01:42:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ve3HoQuYIQHr8Z+7zZEQ2d6AmI2ihrJrFTMjKGAwe7ZUALz+Ev8+Jfpj7NfIMDp0S+UkEnLsHGp16Nby6A5GK0qq1F7GBBeUpYXuk/7HQp3su5JY/jCG5FZn0ZlV4Selenc4IY6dsinDGQ10V0npqaf6cuCmAP3gPN0I3A82FVJn2AgvXLiNeuj0FkegBmuonSHC2Ysk0FonA9gRgn0kDRAb+FfCKNk4O8Xc9Ar4WrHNzlKHL5rmnewu8aSabB0g+yY6vMlp9UFFY0SaeQA5wlHYc6T8Wdsw9xfjHy5g69thiyb8kaqRShSjvytzw4gQj0s4xld3bpLMpayMUAz8xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mo52j7wtBtXdLrYI6Nl5ZDiblNgqVCmvypYuf2lQ1SU=;
 b=i5QoJVGc06YONHn3uAn84pSy1m3Y6SohF7WWCzFYN/HfgTkAikV5zgYZ/6mu4GBqyDu2vtDYewERAjJL/xA8BMcdntdbx1fk6EUfKqYil8+xm9wLvT7JGRHn+5pT1WDOCmaDHxQSJgqzfcegaG1HdpYnGyxiOYsZNpPRuaa/5SoN5jU7els46voxJf6iM4fPkeQDxchg4hn0N9vu4U0wifDhXDRvAmW2EIfYHDnlL/dt6qL6YfiBDl0MeguAgDV8qmfb82W39fDiJJcPrPSdlyqve0qse2TgowdR06PZV2zAL3XXFAlBejMT3mwhl+FaagNa1QZIGXoK4166Zw+hug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV8PR11MB8509.namprd11.prod.outlook.com (2603:10b6:408:1e6::15)
 by SA1PR11MB9616.namprd11.prod.outlook.com (2603:10b6:806:4c4::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.17; Tue, 4 Aug
 2026 08:42:49 +0000
Received: from LV8PR11MB8509.namprd11.prod.outlook.com
 ([fe80::f5bd:4dde:4f2f:20b7]) by LV8PR11MB8509.namprd11.prod.outlook.com
 ([fe80::f5bd:4dde:4f2f:20b7%5]) with mapi id 15.21.0270.017; Tue, 4 Aug 2026
 08:42:49 +0000
Message-ID: <50bad4d1-4171-43b0-83d0-2d83bdb41c0a@intel.com>
Date: Tue, 4 Aug 2026 16:51:17 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] intel_iommu: Expose SMPWC when SVM is enabled
To: "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?Q?Cl=C3=A9ment_MATHIEU--DRIF?= <clement.mathieu--drif@bull.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "pbonzini@redhat.com"
 <pbonzini@redhat.com>, "peterx@redhat.com" <peterx@redhat.com>,
 "jasowangio@gmail.com" <jasowangio@gmail.com>, "zhenzhong.duan@intel.com"
 <zhenzhong.duan@intel.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>
References: <20260802160408.645484-1-clement.mathieu--drif@bull.com>
 <20260802124718-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <20260802124718-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TP0P295CA0039.TWNP295.PROD.OUTLOOK.COM (2603:1096:910:4::8)
 To LV8PR11MB8509.namprd11.prod.outlook.com
 (2603:10b6:408:1e6::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR11MB8509:EE_|SA1PR11MB9616:EE_
X-MS-Office365-Filtering-Correlation-Id: 64b2db24-f5ef-443d-6596-08def2045d21
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|42112799006|23010399003|1800799024|6133799003|18002099003|22082099003|56012099006|10067099003|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info: bY6/4IvvV3uxdajCYSIsWc9VrEPNCWiPHuQBa3hXfFw3c0sXUQJbbJ9XrQbh5AHwsYOxPt5Nc+vUvwD+l0UB6lBwjOxfLoDQNofXA409P6b+uGbxBzZZCFpsKF8Vty/0Itgsfj5ESdBCuzty74nddk/vtAxMegIPb9sYA8zUcxyD9JrXi/iPp9hIhPWRsBiFkZsP2SQHLjhi6Opb1bc+moeNwjXpoERm0usfjrZzRqCWPsDdH6xb5/U3GRliBh3dBClf+fmwetmcBeLMTq9+spAYfLnmNOTfp91SWD/C3QAf9NLlsl51KRdU/SrcAA1RVYw9vg8uzZxriUCvrKo0DtLJ/hFqj4U36NXohaIm2e+VnCN6mycUZWfgcd1/lM03m8/UyyCU9l7L3HjOkhUupzDXJP/N9rzbqSiA7t4/JOh1Z3YFMMjDuEOxsDcWfgI1ahZTXOJfMwpd6CzbBtM81jLQLyepzXJNsvnL8pu1thp8U1oqdH8rp56/jxwPZvwO6KwRGFd/e1msxOv9yHyraVT71ukK5VfYy69531F/N6CzTwlbgBwmUH59nLZyf5Wpoe5Jk5txoTgXGLE6L9R6KO45RPTDr3gIK6NTda6/adNICYmnqyTOKozPB70MR7J7WWI2ORtS9ALHIk8W2rN8qNyosBXlX5aIMvEYPyqLn3o=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV8PR11MB8509.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(42112799006)(23010399003)(1800799024)(6133799003)(18002099003)(22082099003)(56012099006)(10067099003)(11063799006)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NTFYZ0FBMm1pZUNzYWVvT1V5SXYrc2liaDE4S25pZ2tCQncxWnpVaHB0Z3Bw?=
 =?utf-8?B?a0dmSHdsMWpidFViVDkzNmpvRWVKNmZaSWhidng2dFNuaVdmTG84R1J2aUVN?=
 =?utf-8?B?VUlFeVk1S0NtdDJEMDNzUEp5TWF0SEN2YnVKbjM1bDN1enBTN041eE9PSXRt?=
 =?utf-8?B?SWw3cUxDc1hqbmdNN3BmYjE3TC9xVXQ5NW42bldtOThJc3M1V000U3lHT3Z5?=
 =?utf-8?B?V0dlWFZHTklIdzJIdGx5TkJwYzdFMFJpWDFrMWd3ZGsyZUZ2UkdCaDhDbzN0?=
 =?utf-8?B?VncyTTRESUxlajl1aDB0bS9VK2ZuMkdzTUFhclppSFlCOU00S0N0Ymtldlhq?=
 =?utf-8?B?enJ3Q0lVMERPVVM0Mkd0TE9MYTQyZnN0NExUZEp6cVJXeUFyWm12S2ZPZitz?=
 =?utf-8?B?em1oQlRFQWw0a3lWcUd2cmpteTJDdWlGOC9hK3Y3VEF4LzQwUGFuc1J2L09y?=
 =?utf-8?B?dEFVanM1bFpwdzhlVDMySC80cjVWaElqaXg5SUgxa2FRVjltNE9yN1BSWTAv?=
 =?utf-8?B?TlNzZmNPMG1XQ2dKdm50ZEtTRmhyQ0xUVHlndGNoaWlPVFZuZEE5Zm9IeTAv?=
 =?utf-8?B?NzkyK1VRcmxyQkFPWURyYUdsb0cwZEtOTkJpZ3dOR1k5Qmo3eUxmVGdPQ0hF?=
 =?utf-8?B?ZEduZHo1Y0pSemt6UkF0UjBSUmZrSXFjWlZac3l1ZWdnVk1UeXM5WWI4U1l2?=
 =?utf-8?B?WTBHR1lHT0FXMDJEbVZuUFhpOHJhbnJzczZTdndIL1FOTEJLYk1ZYktnY0xI?=
 =?utf-8?B?L1JvSlVjUUFyN3dyenkyYnZBNHBHQW5PU0QvMVBKM2ZoUy8vNXF6SVFQdVNn?=
 =?utf-8?B?Z1JNV1Y5SEdxVFRmNXFaOU53OWNMRytubmx1bGtMOG0rRHNXdWU5dzhDT0FU?=
 =?utf-8?B?ajNHVFo3b0lTZEdiMXJVQmFkclpLUmhyMUlDOHI5Y05WczVKNE9SckxRRDg2?=
 =?utf-8?B?YkJkdjhJejBYYkVIUkJQaWNvbUZVa251My9QMkh6OE5adGdsdGxWcWZ0SWtN?=
 =?utf-8?B?VVg2YTRYQW0yaERacytWQmxNclQrVFY3ZitUVmE0Yll3by9YZVJucm1PWTkz?=
 =?utf-8?B?RjJ6cGNsZ2ZGbElManhqdlB3Y2M3K3RYWmw1TlpxMWdhaWJFNjRrTklaRERp?=
 =?utf-8?B?QW12VmZMT2FKN1Bwa3hrdFppcGJWZ0FxZ1YybDN1NCtXYjNES3N0amlESGJp?=
 =?utf-8?B?QnAzd3o3TUpZekpVc3E2Nis1VnRwT2pnbHMwNEg4eElaR1QwTkszVDRRR0wv?=
 =?utf-8?B?UmJmcW55U2NTZDJoOGx3anNZbWlSVkxuemxjd2h0c05COUk4MXhkZFhvcGg2?=
 =?utf-8?B?UXAwbjYvNFFUakhvTEhrNFVpWThwNlErOStzRlI5QVpBMEVPbDB4Z2VYN2t4?=
 =?utf-8?B?SDdpc3hPaDJVbVNHOFlUYUFGUGV1b0dZUHBmNFhLWVh6d2t1NmJoc09yRzBj?=
 =?utf-8?B?QmlBOGJPVWlsT0o2SWxmd2NGbW9BUmdKMzByQ2Vydm1oVVVjckxVTmFHVjcw?=
 =?utf-8?B?T2lTSFdDSThYZnJMZU45VWlWeHRGZW42a2hZR0Y0cGtGWllZTmxtTnZTVC9p?=
 =?utf-8?B?eXZxcVplZjVmY1J3d3VKNTI4bFRDZVRxWjNmeThsOFRIWUhFM1Q4MU9tVVJO?=
 =?utf-8?B?TkVPdEZ6Vk1lbkJLZlA4b0NySmVucnF3bTFEaXNKWTBSdituckxwK0w0YVZh?=
 =?utf-8?B?alBhME5TUVFhSWh2N2tOVmw0d3FtT1VKdDJvbHV5YThFZS9jWmUyTjFFS2sv?=
 =?utf-8?B?NE1xZ3dTbTJqWnIwSVBuVXFEUm9ERTBIbkY3MnE3Qk5BVHhMZUY4NUpmUU5y?=
 =?utf-8?B?MUs5RHFtRmxXZW5oWWpjbnREL081azdya25wOE5qSWxjZDlhRVVidExwNFZ2?=
 =?utf-8?B?NnJkOWJ4ZXc5TWNFM1FlK2NyUnFjTWNYRkYvUEN2d29BZENmdmphcUVzbVJ0?=
 =?utf-8?B?T1o4aFVpNytzN3hwUC9yYnVsa3l4OHNsTDJoaEZMMnI4ZVBWMnEvcnJXM1B2?=
 =?utf-8?B?MDdPejRGUnpYQnpCM1duT1hUdGxoa2pOZlJZc1I4VEZSM2d4WWgxdm5IMStY?=
 =?utf-8?B?Yko1OUNMdllwZHdpQlZxVFZkRVNJYjV3Uk1RdW1NTGN2M0JCUWx2cEI3T3FV?=
 =?utf-8?B?elcyQ3dFN2x5cUxDanVpb0hIbjhhOE1wYWtiSU5NbWRWL0FsYno0M1dWU2Rq?=
 =?utf-8?B?K0RWZW5Pb1NkUTlISkRORWdiWTJSU2F6RXpncjRuWnFyWXU5cnJHQlJjd0JN?=
 =?utf-8?B?NHU5NHNINHBRbm5JTFZIcHpwV0Z0eGN4YVFlNFVBcHh5Q0NNWm44bmtPMzhh?=
 =?utf-8?B?c3pkRkJ2d3IzVDJLblZzN3VTdjU5L2FuZ1JhTnlZcHYyYjNhUDRpUT09?=
X-Exchange-RoutingPolicyChecked: XPUqD7YZE8a+kdTHcvkvkyd/AWYEvcXKFDvYxzvi8RhXgzFpMIk1rhqAfT1CxbPOTmCEQl9cvIhXC+EfXZKtkUOm3Gxi/w+JLZds1mdzHv2KPh5nke2ohicej1NYpt23oN3PuzuUi8cvPh7zzejYnXjULRYLf8Iur45RQMv6RMsd6uOGbmq0pClTzjLXxRfY2dvzkERcItMPPRM+ptbn3b/lRtdYxsTUwK6ldx3n5OstnEC9DOrvSLTeSS2wf2jwpUdVW/HrPw9lVrC9RwkThQ5AsoxfHSfjmZNyrFs/19sikv5M+yRWlH6Z5wWc3PCc5CohiHcaoiBkJLpRbJQpsA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 64b2db24-f5ef-443d-6596-08def2045d21
X-MS-Exchange-CrossTenant-AuthSource: LV8PR11MB8509.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2026 08:42:49.2316 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p41o6zvoYs+JrcuUfR93o4xNXIohDoRTbiJcJbN6YhKq2Xl1b7Kct8MI7CMOZhO74ZL6Czec55o7JqgzXW6gpA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB9616
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.19; envelope-from=yi.l.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.811,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_NONE=0.001,
 TRACKER_ID=0.1 autolearn=ham autolearn_force=no
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

On 8/3/26 00:47, Michael S. Tsirkin wrote:
> On Sun, Aug 02, 2026 at 04:05:08PM +0000, Clément MATHIEU--DRIF wrote:
>> SVM in Linux requires SMPWC as of 780dfed68862. This is free in the
>> current implementation as it is already in line with the expected
>> behaviour.
>>
>> Signed-off-by: Clement Mathieu--Drif <clement.mathieu--drif@bull.com>
>> ---
>>   hw/i386/intel_iommu.c          | 3 ++-
>>   hw/i386/intel_iommu_internal.h | 1 +
>>   2 files changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
>> index 8245452d89..9f21622a4f 100644
>> --- a/hw/i386/intel_iommu.c
>> +++ b/hw/i386/intel_iommu.c
>> @@ -5108,7 +5108,8 @@ static void vtd_init(IntelIOMMUState *s)
>>       }
>>   
>>       if (s->svm) {
>> -        s->ecap |= VTD_ECAP_PRS | VTD_ECAP_PDS | VTD_ECAP_NWFS;
>> +        s->ecap |= VTD_ECAP_PRS | VTD_ECAP_PDS | VTD_ECAP_NWFS |
>> +                   VTD_ECAP_SMPWCS;
>>       }
>>   
>>       vtd_reset_caches(s);
>> diff --git a/hw/i386/intel_iommu_internal.h b/hw/i386/intel_iommu_internal.h
>> index 924e91cb8a..df7a0efa6e 100644
>> --- a/hw/i386/intel_iommu_internal.h
>> +++ b/hw/i386/intel_iommu_internal.h
>> @@ -202,6 +202,7 @@
>>   #define VTD_ECAP_SMTS               (1ULL << 43)
>>   #define VTD_ECAP_SSTS               (1ULL << 46)
>>   #define VTD_ECAP_FSTS               (1ULL << 47)
>> +#define VTD_ECAP_SMPWCS             (1ULL << 48)
>>   
>>   /* CAP_REG */
>>   /* (offset >> 4) << 24 */
> 
> Any cross version migration concerns with this one?

this bit is exposed when the svm flag is set. This flag was introduced
by the below commit and controlled by a 'svm' option. So looks like this
change is ok from the migration perspective?


952e1a6e90eb22a6deffa4e980277b135e9d077f

@@ -4186,6 +4188,7 @@ static const Property vtd_properties[] = {
      DEFINE_PROP_BOOL("x-flts", IntelIOMMUState, fsts, FALSE),
      DEFINE_PROP_BOOL("snoop-control", IntelIOMMUState, snoop_control, 
false),
      DEFINE_PROP_BOOL("x-pasid-mode", IntelIOMMUState, pasid, false),
+    DEFINE_PROP_BOOL("svm", IntelIOMMUState, svm, false),
      DEFINE_PROP_BOOL("dma-drain", IntelIOMMUState, dma_drain, true),
      DEFINE_PROP_BOOL("stale-tm", IntelIOMMUState, stale_tm, false),
      DEFINE_PROP_BOOL("fs1gp", IntelIOMMUState, fs1gp, true),


