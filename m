Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8C57C3ABAC
	for <qemu-devel@archiver.kernel.org>; Fri,  2 May 2025 09:15:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAmUE-0005gC-HZ; Fri, 02 May 2025 05:15:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1uAmUC-0005fs-Gc
 for qemu-devel@nongnu.org; Fri, 02 May 2025 05:15:12 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1uAmU9-0001po-VR
 for qemu-devel@nongnu.org; Fri, 02 May 2025 05:15:12 -0400
Received: from pps.filterd (m0127837.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5421lMpN008190;
 Fri, 2 May 2025 02:14:52 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=g2j+YcJWsAjdfMdgYhPC1y1n9fIUR8u5is46Nt9GW
 g4=; b=buexpfGkplDy7QMmYICbbNIenn0abrQ2gzDjpDMy7edqLyfooSM6P28G7
 2lKp2RPAy9JYZrT49pdOpZnSK2kUgvYRHzjiQJBVvCMxE3UD8iPOe2CDbalraROX
 Sb3OoMTv1hjSe9e8nj5aB4MQ3xe6SFROuyufRjuxoffE7T2xAstHj/tZAqCRTe/E
 H49NLzRLogBv8eIFzVRH4y9KK7IHHDy3FR5Zpc/e3my3eqHio6IZgMU0o90Zcg4g
 kdE+H9xREKtsSAzdqHkFVYAk+meXKSUjVY+/aD3UNWPf3hGv+I/Pr1gisQMIjZw8
 cgX0U8XLZ3cIkAsLKYEzM2sJnmYIA==
Received: from nam12-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam12lp2174.outbound.protection.outlook.com [104.47.59.174])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 468ud8nekm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 02 May 2025 02:14:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=klw15JzOGfKjo54y80EbEWqSMsFxN4vUz5IW5JE07bR/QbrbUn6ByD0ToDTBp42UUvsNdPIMVsi0LI+ycjANsoSLGIzTTPPUCmNRNRsSsFQYea7Bel2sLCRndyhK6xbKixLhBYbiXz3aPxsQZPIa5d/kkKdz62it01JgIv1IYnyO0at6W6UHqd4OXQgNLdqPZhIXKWYhrH6pFXA8KySezvQ5riyLW43azAtPa3NRc491d6Hp1bZe0ufq9BYEUpoHvTnjRzR+xZV9aiXDIWqJ5nSOuanzCF/rKYO4HdTYAsE18iqtSP/ZeETM6b3CBooiWmq+M1GIZOghHPKnRWfoaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g2j+YcJWsAjdfMdgYhPC1y1n9fIUR8u5is46Nt9GWg4=;
 b=rrMXCyLQWatQcvuIOaK9VVtJHyx12unObr6qWWmlgiske7E2B3fQPtdyBjZK89dgKzmMoAUBD7KaPjSK1BG41ve0deeBZrUcO7ShEawcD1HzFIg81ukZQIktBdIC6Vne1c4OcoYgYg/SAhD5tCd66JnxcdoWn0i9uka+MBISoana7Orp6xIjazkva5pDv/4VEyrtVFPQHP+zGKHCy4ODJlrCYbuEeUpq07+XvsXYOFoU6hhHRyHJU7M/ETVwHrCrvxNvW7mCLfx5fnSSKjBzAK4OOCfgJOapj7pLB3zbZRR3yWGl9gF/XCMsDghcleP0vJBDFYyRLLuN64foltWPew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g2j+YcJWsAjdfMdgYhPC1y1n9fIUR8u5is46Nt9GWg4=;
 b=h7uZEay+8Lf6uVcsh6HOMGE+Vb/5z2d268c5cXR/Q6pqpLUjIdxEXSZ7zWxr2RI5+QLo2Avhv5s7WO0pF/UxtxBjLCW67VtT/7eNeyDlnrjuB8WmP7lp7lxgQ9Fpth6xfo9sg/Do6NezeUeYlPzypL25VEuMvUkhY1laWg1LtuT0+5CY2jxebPjC/RcZDfsY1Eset1mH+IcDmAZNfftn+/lHms9TbIyltV5FrFH9SJXePG9qmyVtCLZIs5jKbnoRrc3wqvQJoYv2GajM4sXadjEz+Wpb+muUUdQy6KZvvDjh4LsyQGN3V889pc3pzwBq2l/5ORTHWIEaFlAmealyWQ==
Received: from DM5PR02MB3356.namprd02.prod.outlook.com (2603:10b6:4:61::16) by
 CY5PR02MB8893.namprd02.prod.outlook.com (2603:10b6:930:3f::22) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8699.22; Fri, 2 May 2025 09:14:49 +0000
Received: from DM5PR02MB3356.namprd02.prod.outlook.com
 ([fe80::72bd:6790:f9e7:f241]) by DM5PR02MB3356.namprd02.prod.outlook.com
 ([fe80::72bd:6790:f9e7:f241%3]) with mapi id 15.20.8699.012; Fri, 2 May 2025
 09:14:49 +0000
Message-ID: <5c1c0533-190b-44b7-8dba-39ffc2041cfc@nutanix.com>
Date: Fri, 2 May 2025 10:14:44 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 05/16] hw/intc/apic: Remove
 APICCommonState::legacy_instance_id field
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Igor Mammedov <imammedo@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?Q?Cl=C3=A9ment_Mathieu--Drif?= <clement.mathieu--drif@eviden.com>,
 Yi Liu <yi.l.liu@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Amit Shah <amit@kernel.org>, Zhao Liu <zhao1.liu@intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Sergio Lopez <slp@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Yanan Wang <wangyanan55@huawei.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Ani Sinha <anisinha@redhat.com>, Thomas Huth <thuth@redhat.com>
References: <20250501183628.87479-1-philmd@linaro.org>
 <20250501183628.87479-6-philmd@linaro.org>
Content-Language: en-US
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
In-Reply-To: <20250501183628.87479-6-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS4P190CA0021.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d0::6) To DM5PR02MB3356.namprd02.prod.outlook.com
 (2603:10b6:4:61::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR02MB3356:EE_|CY5PR02MB8893:EE_
X-MS-Office365-Filtering-Correlation-Id: edeb866d-7a99-4153-8692-08dd8959ca0c
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|10070799003|1800799024|366016|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?K2Q3N3J0Ym93NFFscVdtNyszWkVMNXQycC9BallWQVdLdmI4Rjh5dHRBK2Qw?=
 =?utf-8?B?cXZaYkxIWk1GeVMzaXpqVmFtUzcrR2JmZGhjbWJwWG9YTFZWRHEyazZmVzVF?=
 =?utf-8?B?M09sRlVRN2g1OWVvWUI2UUdLMUhWODlLVDhiMXJHeXRFUTg5VTVJWDUwVUQw?=
 =?utf-8?B?SkZWQjRlZ1NFeWNSVG44ZkRmMGJGMGp3NEt4dTUwMmZ6djRqUml0RUJ1Y2NI?=
 =?utf-8?B?TnVqZWEvQXdjbCtHZEFYVkFNdjlUK25uWHlEbVd1SHhwWitjUHZqVG1wakkx?=
 =?utf-8?B?MURHSUhxcVhwbGlDSmFPQzluWU82ck81aFR5NUJkSG8yR0Ztb3lxRCs4RHpF?=
 =?utf-8?B?TUV2eFQ5TU9mZ3QyaEpjbGVucUdXak9UazJYZWFwZTZEOE44WElaSnBwNGY3?=
 =?utf-8?B?ZFB3YmxidDcyMjdFZ1NSZ2d6blNsNUwxRWovcU80SXVlWWVzdTZ0aUw4dVhw?=
 =?utf-8?B?TVJwUU04NzRxaXdzY2hiODd1bnh0TFZQQ05xR0lxQTlNQUNFbGt1NEVveDlJ?=
 =?utf-8?B?dzZvc1RTL1ZaRmRuaDFNbHVkTS9wV2F6blU4cWtpZys0N3hiaUx4d2dpVHQ4?=
 =?utf-8?B?ODYwRWFhNkkvdGZEWEQrSDNjWDFUVzUxcEppTW9aZEVGM29sZGpoOG82a2RX?=
 =?utf-8?B?R1ZibmNiQzlYMkN6aHpCMW5LTG1vZXdXdDRsK0FYbFNkTjV2SzluZklKRWtj?=
 =?utf-8?B?aHMxamsxalJzWVJZbjJLaCtTenBLVHVPSUtGZ3NIVzN0bndOckh3bXFRRkpF?=
 =?utf-8?B?TDlzQk9wWkRsbmkzWkp6WmdWcThEL08vczBaSzNpLzdEZEpydCthdTJWU3cw?=
 =?utf-8?B?Q0ZINDhtMkZhbDNnQXhBdUNpSE9hb3hjenBFR3VLY29OVnNsR1Y3UXBOZHJ4?=
 =?utf-8?B?dzJlMThTZENMMmRGOFQyZlBiNU5Sa0RWVEQxdXh2YnRBK2tBQ29OQWRmVDEr?=
 =?utf-8?B?WVllaFN6OVVLbkMvckFweGhvb2h4dlBaTGlKRkprZjVWaG1ubTNqOXNwNy8w?=
 =?utf-8?B?TjFBazU2eXovcjhHT3ZzS1BCdXhZUlBPRFl4bmZFSnltYm5qZ1N4Y2JtanlO?=
 =?utf-8?B?VmtTODNpWTBSV21XcEVIVEFVZlg2ay8velRaNjh5bEJpTDRtM25aSVBnT3lZ?=
 =?utf-8?B?WUwyc3Z2SXREUWVlSnk1R1M1ZUJlOW1xMXZJN1VTN1NCVWRxZ1FHRDV0bDY4?=
 =?utf-8?B?RCtJZGthaURCdm5QNHkzTmF0dXpldEEzc3I4ZVVzbVJJRGc5L0pDUThRV3VE?=
 =?utf-8?B?Uk5qZlU0VkRoc0pHajlJUHRzVkR5VVZyay91VDVKQ2JrNmxsbTV5bSs5QXFj?=
 =?utf-8?B?V2Q5ajhZOVBDTUk5U2psQVlhZGRRZXRYMlQxY1doSHFnalJYalNTZFdPaThJ?=
 =?utf-8?B?RnVEdTM4SE5Xem9VSlp2QlZvREVzRG5OYnc1QWo2QXg1V1lPcmorTnVldENQ?=
 =?utf-8?B?SExxeXpWeUl6clBMdTRRSWJhanhDbnRlY0NWVmgxaUtNMHRrQjJST2Z5ZCt3?=
 =?utf-8?B?Tzc0c3M2VDhjbW9rVGk4WkUxMlZET2FmczBDY1hZa3FoTGZidFdoYU5mZXZU?=
 =?utf-8?B?RFNtTERYLzVTemFwVGs3U0xOOUdoR01BVmwvSENYaWJkOVpnSS9kSDVmOUxo?=
 =?utf-8?B?d3M4WXhJenBieUhTcHAzRTQxVHZFbHhINVZKNk9QTmJ2emkwcDJQNVA4M1F2?=
 =?utf-8?B?SEVQbFA5REhuM3l1MEN0Ynd6djlzRnA4WDE4bkhUWWQ1Mzg1WkswaW5XYit5?=
 =?utf-8?B?ZCsyeEZFYVg3Umh4V0U4QkhpZ0VxQkp2dTRZR1JXbEJmZitHbHY1NVVWeGY5?=
 =?utf-8?B?OWVpajUwZjJzQWRVdEd4RGcrOGZvUEczV1k4WExjUzRvVXZ6S3FSUE1BNDF5?=
 =?utf-8?B?L0U1U2cxWHczQ3dlWm5RaVUzQmdrNTBESy9iVGc1a29vdkRIYmQ1bk9QTkZT?=
 =?utf-8?Q?VrONin48hFM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR02MB3356.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(10070799003)(1800799024)(366016)(7053199007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?LzlJN3NOZTlyaXM1QUpEYUl6THRTc3BJa0o4VHp3amNyQnFHL3NZK3BwZjJW?=
 =?utf-8?B?TnF3eWxGUTVlcWtJZjQrOUdQUFFmVDZQYkFVWkEzeVVHaTJVSld1aFI2T081?=
 =?utf-8?B?R1NiNGxJa1hCYXhBRncwOFZ2VkdhcEkzUTY5Q0wxVWhrdlU5aC9raEJwOWJE?=
 =?utf-8?B?dFkyZWJheE83R2hsV1Z1Tm9KWEZWNEFRYUxnOU13RzI2YzhRQWlEUUtrKzh3?=
 =?utf-8?B?V0hoaUtuS2huOWVSRUNkeWhweElkc1lHT0wvRkUxaVRjMUxaYzhpR0VoSkNJ?=
 =?utf-8?B?WG5TV0pvd3lXYkRDYUJESjNmd1BlaFFvakpmVmN4UmhKaG1JOGJvUHY4WitL?=
 =?utf-8?B?WlJZVkFYSTBicUQ5eVVhR0Rka3FVQWRNOXBJbEN2OXkzYU9XMDJIdlIwWGNQ?=
 =?utf-8?B?VmNCNXBLTVdZODkyOG5Yc3BJT0xEbURMSEZDSTlVWjVTSXpZZHpLY1Y1cEM3?=
 =?utf-8?B?OHVSOXFTa1RQSzFKTGEzbU5teVByWkNGeEF1dmRXTlRrK1BKUzNycmM5cC9i?=
 =?utf-8?B?YVpjMUJhYUpzamVtQjloeTZCMkRKWFBiQlBuQ1JwckdCWWZ1eDcwM3MwN1pU?=
 =?utf-8?B?QjdwK3hlQWxpcmZ5UXZWODZGa3dHY3BLRERmYWEzMWhkKzJSbTI0LzV2L2tH?=
 =?utf-8?B?a1NQZGVrVXlhb3pEakthUjdiV0t4dHpIZng2TUJkY3l6Y0FIdVdwTGEyZldq?=
 =?utf-8?B?UlhjQUxTMDVkR2JBVi9WbENPRFhEYTc4eXFnWjRwTzVHalhCSHB5VW5NQjJU?=
 =?utf-8?B?bGdiS3J2VUFVYklxZVI3bFY2cWZ4cGhyZXBHUTJXWnVqdmh1SzgxZ0Q2OUl3?=
 =?utf-8?B?cXdUOFY3OHUvcEJYUXkxNVNkTG9IVGZ3UnI4SFB5eGpkbDhpQkNZcVRob2Jn?=
 =?utf-8?B?Sys4N2E0THV3d003dmdCMCtiMHUxLzZrZW4rWnF4aEFvbmpjdjBPMlE3VzhC?=
 =?utf-8?B?UUxGaURpL3prUkRPOXVncWkzcmVxK2EyZ3FlM0hTbk9DRTZhTTVSZmdoakVN?=
 =?utf-8?B?NjBFUkh5MHd0aFM5d0t2K3g0UElpZGpuTHFmZjdJZkVnbVJNb3M5eXpDL21o?=
 =?utf-8?B?SnJtL1JiQ3BRNmVkL2VsVzVZZ2p3dGc2aVduV1lWaklscncxNytRbk9IL1ZQ?=
 =?utf-8?B?MG9kS1lYSVkwaFhyenFBQ1YrWEFSaDRMMXBDaUEzSEtqQ1VSWTVGUmZmZHZt?=
 =?utf-8?B?YzEwRTJMeXo5NVZiNUZ2eitBNzVIR3lqcG4weGdobm1IZU16V3NHQkZpTTlG?=
 =?utf-8?B?eXpVZ0czV2d5WjNNSTdRZjJkZ2JtQ0pjdTU1dE5DNDk2N0V6VUdEbDVMZ1ZE?=
 =?utf-8?B?bFNxSHBoQUNpTGp4R1UzMzdkSUpORExwS291YVpEQllvZWtZemVCbXJhSW5l?=
 =?utf-8?B?YlVIdXR0ZVg4a3loWnUyMDRmOEs3WUg5YjhsdVFHM25GcXpwVzRVN09sNld4?=
 =?utf-8?B?Z3VRR0ZnM2tLQzhNc0dFSVFQd3FFbm84R2dSdHZ3T2ZZaEFBZHZHazRwSG5a?=
 =?utf-8?B?ZDJBYmlDa2x1cytnaFZSUUw0Z1Q5eHhzTmxHWmlQSDhXbkN4T1JXS3FxWTV5?=
 =?utf-8?B?WFRaV1ZGNEg3N2NtUXBESFZDMTdDOXdybkpRMnBPYWk1Rk5acW9ab0tJMDZY?=
 =?utf-8?B?L0JrTUR0SVRZcjRiYVpGR1k4dnF4YTNadFltT1FpdGhiQWFUK3VsZmpLR1Q4?=
 =?utf-8?B?T0VNTHViU1diMlB1TFFuams5aGdRazZTMDljaUxjWlRCY2pHdE91ZzREWXpD?=
 =?utf-8?B?aldTT1RHcGV4TXJNY2hJRVpwZ1lxYUVIamtvMmxXZE81TVBaZTBITWUvbHpE?=
 =?utf-8?B?S2xKaHR5K3VwaVVvZ0w3enpmNng1TE5FcWRJdTF0MXpoeis5ckVQWlQ1dWsv?=
 =?utf-8?B?VHE3ZGtRdThlVzEzSTRUa3ZVUzc4bTZUUUNNSytKWVBzdVFWS2dKcHFMZUhG?=
 =?utf-8?B?WlBVaWxtcm4wQnNHRUt5RW1KVzc2MlJIZkdtT3BzMGpWbVA1ZE8zN2RSdG9S?=
 =?utf-8?B?T2dMd0dBeWtib0JFT0pFRm03Q24zVjVzNWZPTzMrZjZQaVJLa1hsZUY1blpI?=
 =?utf-8?B?M2kvWDdCaFdYclRFVUZiazNyVWNGaHJ1V3pYemtNYWNwVkpaSUVLQ2tYaDZm?=
 =?utf-8?B?WmtXbnZ2ak43aVl4aHlRc1R6SmdnTlBKNC9OKzZYYWtYUXN5VUk5WDZGM1J2?=
 =?utf-8?B?UGwxN3htNXhIWjJjcE16dFNTZTdpeDREeTVDelZuWXpleUZLeGt0aFBLNkVK?=
 =?utf-8?B?NERhcElFY3V6M2NtdDFRRFdOYWx3PT0=?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: edeb866d-7a99-4153-8692-08dd8959ca0c
X-MS-Exchange-CrossTenant-AuthSource: DM5PR02MB3356.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2025 09:14:49.3549 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nJAtp6fL4IkOJgRWKBLpOiPqaGpEuNhbLUD4OIGUBpLqbXTvgrYxB5jyEpa4Fls1hIpsYhj5O1FtNp4Vxie9rxyeH7EUEbBMWKKQkySzquE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR02MB8893
X-Proofpoint-GUID: HuIAZqnJIphHrC9jaaLICdgK8rNU8HQ5
X-Authority-Analysis: v=2.4 cv=IugecK/g c=1 sm=1 tr=0 ts=68148d0b cx=c_pps
 a=pa2+2WWV+ihErLhOOf7pAQ==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=dt9VzEwgFbYA:10 a=0kUYKlekyDsA:10 a=KKAkSRfTAAAA:8 a=64Cc0HZtAAAA:8
 a=g3TAJRprlfc6rA_DJccA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTAyMDA3MSBTYWx0ZWRfX4jfSF+gbb6U1
 6SbIeeRA1A+x1eryD6A3eXYsvZiJRb8BjD4b8qkiM299nN6wgFof+iTSM09pnl7I+HgCYSy+9jh
 uP3V6t6CUj5ihYmtk0NWmNQVr0ZQlQz9BE3NxK1Q1tnyLE9wMPRENm7qCwH+BXe8XYBie+Bkhg8
 ACV5ygCaSKisistK0TmGpEj3PNkT5eNKjUK8bxGxcdTsci3ny22yFy3T1L7dA4YJneT+LfN6Qe4
 jPNBzw8l/3BU8DHDbrLEzDQGmhE0xWdVwrQb3QKqyY3puRSpuF3W9N2Bh+GwNBR30kxDyaliH7l
 q9Vc6h/aM4QFQI3GFWPOUsnG8rg8UDD+ZLa5hpH/GaK9kotoSQXQdcLJDjdRMLqe0YjzmURyxgs
 SEIuAEfAWENgkgQHJEqy2ElMwty68Da+pSYEKlRg5AhVle/9uHejhVXdYIxF2TK/8PuKwAtF
X-Proofpoint-ORIG-GUID: HuIAZqnJIphHrC9jaaLICdgK8rNU8HQ5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-01_06,2025-04-30_01,2025-02-21_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.644,
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

On 01/05/2025 19:36, Philippe Mathieu-Daudé wrote:

> The APICCommonState::legacy_instance_id boolean was only set
> in the pc_compat_2_6[] array, via the 'legacy-instance-id=on'
> property. We removed all machines using that array, lets remove
> that property, simplifying apic_common_realize().
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   include/hw/i386/apic_internal.h | 1 -
>   hw/intc/apic_common.c           | 5 -----
>   2 files changed, 6 deletions(-)
> 
> diff --git a/include/hw/i386/apic_internal.h b/include/hw/i386/apic_internal.h
> index 429278da618..db6a9101530 100644
> --- a/include/hw/i386/apic_internal.h
> +++ b/include/hw/i386/apic_internal.h
> @@ -188,7 +188,6 @@ struct APICCommonState {
>       uint32_t vapic_control;
>       DeviceState *vapic;
>       hwaddr vapic_paddr; /* note: persistence via kvmvapic */
> -    bool legacy_instance_id;
>       uint32_t extended_log_dest;
>   };
>   
> diff --git a/hw/intc/apic_common.c b/hw/intc/apic_common.c
> index 37a7a7019d3..1d259b97e63 100644
> --- a/hw/intc/apic_common.c
> +++ b/hw/intc/apic_common.c
> @@ -294,9 +294,6 @@ static void apic_common_realize(DeviceState *dev, Error **errp)
>           info->enable_tpr_reporting(s, true);
>       }
>   
> -    if (s->legacy_instance_id) {
> -        instance_id = VMSTATE_INSTANCE_ID_ANY;
> -    }
>       vmstate_register_with_alias_id(NULL, instance_id, &vmstate_apic_common,
>                                      s, -1, 0, NULL);

With the legacy_instance_id removed, is it now also possible to register 
vmstate_apic_common directly via dc->vmsd instead?

> @@ -412,8 +409,6 @@ static const Property apic_properties_common[] = {
>       DEFINE_PROP_UINT8("version", APICCommonState, version, 0x14),
>       DEFINE_PROP_BIT("vapic", APICCommonState, vapic_control, VAPIC_ENABLE_BIT,
>                       true),
> -    DEFINE_PROP_BOOL("legacy-instance-id", APICCommonState, legacy_instance_id,
> -                     false),
>   };
>   
>   static void apic_common_get_id(Object *obj, Visitor *v, const char *name,

Anyhow:

Reviewed-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>


ATB,

Mark.


