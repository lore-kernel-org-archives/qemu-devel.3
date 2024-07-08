Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD06FC3271E
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jul 2024 07:17:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sQicW-0006nP-C3; Mon, 08 Jul 2024 03:17:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1sQicS-0006m3-FA
 for qemu-devel@nongnu.org; Mon, 08 Jul 2024 03:17:04 -0400
Received: from mgamail.intel.com ([198.175.65.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1sQicP-0006J0-Qt
 for qemu-devel@nongnu.org; Mon, 08 Jul 2024 03:17:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1720423022; x=1751959022;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=552dP1XRwZn4nlYl38RF8IcxQ8u+0F49LX4qgLM+pqs=;
 b=n5lei+IVLq5HzCzPmURNg4gC3VOiuqWwfafWv5Krjbm3574pAcDREnn4
 eEWB5W6OOitFs0sl7JGk7clyVGZmyaWJ6+gvp3wbFLA1mmlfo2VBr0CA0
 jw119BXtK1F//DpEYz/I4xFwss6Dgyh3xdSCvCE5we9SQwz6fHElgPx4u
 47DPO76vG0oCGjj4J4FCBxo2UeSKiJ+lVKGgi3hGXqPLeo05BTJOy/DmF
 IGnMQVjZ0kLBFqzDRHBtgf+kTnWHHcspJOk0tB/RYcg8gSaZ1j49SXi3r
 /9qlPsxS78i+pIPQtVP/MCtCQzFPOpCatE+K0P5oL5Yjjfmv82fDqFZT5 Q==;
X-CSE-ConnectionGUID: pJe8HydxRZa9rWgW3vg/tQ==
X-CSE-MsgGUID: U9wV1h2pTEKlMpXXLocI9Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11126"; a="17751699"
X-IronPort-AV: E=Sophos;i="6.09,191,1716274800"; d="scan'208";a="17751699"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Jul 2024 00:16:55 -0700
X-CSE-ConnectionGUID: fF/PxlbERa+hs917RO1NGg==
X-CSE-MsgGUID: 1tYJpiIBRou8IsUSxOnELg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,191,1716274800"; d="scan'208";a="70623230"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
 by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 08 Jul 2024 00:16:54 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 8 Jul 2024 00:16:53 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 8 Jul 2024 00:16:53 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 8 Jul 2024 00:16:53 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.44) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 8 Jul 2024 00:16:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ieLmHGjp2WFPz9ZNbtXxl4eVDMW+HGatDPk5SaXDX0nRz2Gq3I/XUeL9CMchfgiXEU+9z4/+KnOFDqGlbmPxkgRh3gX7yTj/zoJ6LwR4GgFbQrhFU1Lwajzf3t/D6dmD+S/V5VeC+AaPElqo+6tMh232N+uE/vScjbXlueBqLz4oznsFNm1cswo8WlpcZdAuhr8t9vqQ7zvsZ058IUSrcAxC4DdG2IrU1W1BFEqign/udgTH4sjAJeb3mrKRT0QDS+JqmkRfh1n8DiLmTcGKF0P+zZd15EpfvRMHMK8+b03o9kG/yy8004bfqjNOVfVjdmNO1FZ1xS841pBBwUHCeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2HLM672REZ7CC49d90PIxMJuUPg7aHMnIz92968ds0A=;
 b=Gb6kks2wOLeuoaP6Tk5cc5oVqtmlap19wP/43HSk4AfJQb10cjaypZ66RrFNi8lMzli9+FjVXai5UB8N9ZCtWA2M9ITrZgv3Ojpz5BTO4H+9MtInNSIQkshQlciW9KVHrNdc1hDbq4Eq0LbR1nLs61VDFNK4wK1MUF1f/XeWxOWtUQxtQwpV3HBa5xyIVHid2WikGiT5DniIZk6TwgltKyn2xeR3YJvvCag0Y2wBqk+SoXm48U5K4TtkoIPWEIGSQxSfUt+nppANZjAu7zpTLYDxdzLfUB10+euF+eK/wBl8emOUFvckeXMqaGOtq1x0NJamr36bSLFE5G/xEsqNOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by PH0PR11MB5902.namprd11.prod.outlook.com (2603:10b6:510:14d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.34; Mon, 8 Jul
 2024 07:16:49 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a%3]) with mapi id 15.20.7741.033; Mon, 8 Jul 2024
 07:16:49 +0000
Message-ID: <c592cd1f-f007-42e3-9961-750122e7a6fc@intel.com>
Date: Mon, 8 Jul 2024 15:20:45 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/4] intel_iommu: make types match
To: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "jasowang@redhat.com" <jasowang@redhat.com>, "zhenzhong.duan@intel.com"
 <zhenzhong.duan@intel.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>, "peterx@redhat.com"
 <peterx@redhat.com>, "mst@redhat.com" <mst@redhat.com>
References: <20240705105937.1630829-1-clement.mathieu--drif@eviden.com>
 <20240705105937.1630829-5-clement.mathieu--drif@eviden.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <20240705105937.1630829-5-clement.mathieu--drif@eviden.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR03CA0130.apcprd03.prod.outlook.com
 (2603:1096:4:91::34) To DS0PR11MB7529.namprd11.prod.outlook.com
 (2603:10b6:8:141::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|PH0PR11MB5902:EE_
X-MS-Office365-Filtering-Correlation-Id: 686521f3-6b7d-456b-b9a3-08dc9f1deeef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dHpYWFFhNFFXRXBSRTZZZjZOcW41ZTVEVnVOeFkxQmhsa2RiWld5Y2lQRjZl?=
 =?utf-8?B?My9XeWNsRU91cHRuTlloamlqYW9KNVJTclMyTnNvMWFKU2Y1M1pDeTMvZkhP?=
 =?utf-8?B?cHBualY2ZUQzYUdCWUxRLzltU29sYmM2K0VUOW0xNnFLVGVPQWJYdDVHNUM1?=
 =?utf-8?B?QUlKam1JNzFCN3dCQ3QwS213VWdYWFRGbmpUazQzK1ZrNUZkSjFXN0xYWTZJ?=
 =?utf-8?B?WHo2SEdiUG9nQVM3ZXo3Sy91QUdSejRsNVNCWFdNalBCcmZ6bFMwUFNDWUZB?=
 =?utf-8?B?dm1mdXRjSU1nY21qSTdMdkFBN3ZPaHJXVnV1bUo3eURySVIwWTJ1RHFKZTN6?=
 =?utf-8?B?UFJBWDhUM2M1ZXpvSHE0OVB4MUFzWUNIZmFDWjVrbjIvMmZHTHo5ekkzcFVl?=
 =?utf-8?B?d3MrNXZuVGlqNHJNc1EwU1VSZUUyNnNkZGVpaEZ1a0FNeThVTUk1d1J4U2xG?=
 =?utf-8?B?dVd4N1QrVUdpcGFzLzNvV0V2NlZDUGZJZXBDdkJlMXpBMG5uRXQ1a24xMm1m?=
 =?utf-8?B?N1FYb1hCQkF4SG5YTmhUM09VSEkwN1k4MlgvUUtNQ0ZjeWlXdzNVZmcrTUpK?=
 =?utf-8?B?SGV0ZXlyY2RDSjE0OEZYd21PdlhnOERLSEZSY2pPb1VPdHZkak12cll3YUFY?=
 =?utf-8?B?blhZOUM4bm5MNkYwaXRWVEVKYVU1RmdINDhEbG1Ca2xneTd3ako2WFVTRnpx?=
 =?utf-8?B?dUEwVlhUR1hMc25LK0hhL2duSVhQR2ZrU3h4WDJBNUFlWnlPZHVrT3dkOWVF?=
 =?utf-8?B?QmcyNUJSL2VoTllYOWhwYk43K0NHaGJXUHYzRXd5Q2Vtd0c0cWtqKytrYXl1?=
 =?utf-8?B?SHdFenpnMFo1Sys0TGZiWk14ZnEvb3FhT09Qa3JMWmpXa1gvcmNuMkk5WlMv?=
 =?utf-8?B?cHVib21iT2tJZ2F4RHJEWmM5TDdTTksxenRYd0ViTjFjaFR1WnJqbEh4emlu?=
 =?utf-8?B?Z3dleFgxTmxBdEhMa1FCYU96WHliUWNNZEtqanpSaUQySjdrWG5GTkc2SDFW?=
 =?utf-8?B?d2VQeDZ3eHI5UUpHN0xZVkpObDF4YkNtR29oamdyOEdMVVliMlVXdWxlVVlv?=
 =?utf-8?B?YzhZWUhhSE56eitvbmFGaHRBNHBsYjNtemZpUzg5azNxWEZOdVJoeGZsbzBq?=
 =?utf-8?B?RnJ1VzdOMXJwUXlDMzEzMjc0M1c0QkppVDNwWkdmRFF2cHVtRzdlbFd3cm1h?=
 =?utf-8?B?VXMwaTMybEJOZDJWb3NZTXFNNlNXV0EwZEtXVnhTSnlHR1A1Q3kxOFVaTUx2?=
 =?utf-8?B?cVI0TlA0M1I5MUk1NHUwVU5OUzJUV3YzQTdsdys0YzNQSlNsemhLcFdNQWhO?=
 =?utf-8?B?QncweEY3OXdUNC9Zd3NqdkRuZTlDcVFZNlpYMUhxNzM4SE9CMTRmaTgrbFVh?=
 =?utf-8?B?cS92Q2lKS2dEVDJnZ2ZpMlBpY1gyQ1VzZGp6SjBmUWJEeThDK3JWaVNzYkVL?=
 =?utf-8?B?eElla1ErZmJ4NFN4eTZabUFEa1ZCelFtem54dWtxVWJuWThLMytvNlpxTTN6?=
 =?utf-8?B?WUxXOGkxTEdYOTJhaHVSMzNKWlZEZC9BcjZ1MHRZdkJHNEV1bjk4NFVEYmxL?=
 =?utf-8?B?eExPSDlSTGlrdHpGR25uTENIblA2SHRoeU5nKzVGSmhOKzFlb0g1RjhkSWhI?=
 =?utf-8?B?OTJ2ZDgwWFFoOWRSZ2VyWmRQQXh4WEptWjVMYzYwYVZaeFlWald5Sktaa29j?=
 =?utf-8?B?UUN4QTlaQlJiYzd6d1llOC9QS2gvaTlsclFKWEJwZCtGdnI4KzN3d3NtZXFj?=
 =?utf-8?B?QndiVGRER01VakYwdjZKQ2NNNDdreWhlUE5qT1hDaFJSaWQ4aTJGZ2NTNnNz?=
 =?utf-8?B?aHdYOWtCdFpxMUdtQ21Ldz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7529.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QnBYTitDb0JVdk8reitGV2QrSjdObk9sZEFCK3BWWE5JU28vTkJobnBLa25w?=
 =?utf-8?B?WHNaakJ3MGFSL0x4VS9yUy95bHR3WDhhWi82QXVYc3NHTzZ6ZGQxUzFhbEVk?=
 =?utf-8?B?anRQZ1lSczBTZUU4bkNMeXhjZ2J6ejBiOERrait0TTRPN29ZWHdpLzBvS2ls?=
 =?utf-8?B?UDZWT3h1dmw2NS9VZXNYRy8rZThyNzEwY0RvU2pSbmVPcEEraXI0RnhQR2tu?=
 =?utf-8?B?WDBjMThoUml3NmVxMlpIS2lQV2tSdllZODBIL2ZRZHRkdk1uSzl5bzFjbmpm?=
 =?utf-8?B?STNubHppd0Z0ZXhYNGV6MjZhZTJmc0RWVXByQXc3VnhlQnAvcVlzN0FEMVFT?=
 =?utf-8?B?NGp0VGVNM2NxVkVNS21MUkhZYVEzZjBHOTJSM0RpWHR6dGI1U244TGROdnhu?=
 =?utf-8?B?NThCS3h4WDJmSnZiM2hEZlpDdWhhWFZvMTR0RlByRDRobEM2emNiZHM5ZXJE?=
 =?utf-8?B?Z0piakdTOG0zM0RuZ1hQOWMxdnZiKyt2ZUs0WlFIa1hKS3BRczZndDRCbkV6?=
 =?utf-8?B?d0N0TmJ5b3hKWkxwbWlkbDMxZER6a3lxMDJxcDg2ZGhuYzE3ckY4eFFZYk1k?=
 =?utf-8?B?MEt3R253Rkp1OVpLR0k1RGZuZzlrVGozSmJEV0drckdOUEJSN0UyZ25XbnlI?=
 =?utf-8?B?QTN1clNtRVN5L0N1bGxiYi93RHhwcjZWOEtGWFFXS3JRVUJscXA1cGF2Wksw?=
 =?utf-8?B?cCtTRHVKQlVKU3lXcGlUaDREdncweEI1ZGsxT0Q0WlFWbjhtYTFCZXhocXZV?=
 =?utf-8?B?STNmaVJNd3JvSkJpcmpGSDJnSk4vMkxaSjdwcS96NHd3SWZKMTNoQWpWaDcy?=
 =?utf-8?B?eUFhTkJVL1ZKNWZpWjlkYjM0d2t3SEN5M1hkODF2SVhyb1hXQXMrK0xjdmdT?=
 =?utf-8?B?V05WMzVTOTFadityYnNIalVNVUtSeVZaZWJtRjNydHJiODBRVnZ2VjRwK3ho?=
 =?utf-8?B?c2JUK080cngzR1BiYkIvNkJ5ck53cXVWUmU2bzZJcE0rYVVzWVRRcHZ6Mm9o?=
 =?utf-8?B?WTZ1M2VMRDVKZ2Nib2dEQ1JSVlQ4SEoxWHBWY1hvTzZROFkza0FmSm9VNVgz?=
 =?utf-8?B?VklHTkdDNDRtSThpYXN0ZTF6dEN0cVBRYVFBK1hSWkZWdFFDdmNISFR3dStn?=
 =?utf-8?B?RFZhdlN0dTlTT0Y0MHRPZmtoOUpXKzlGb0pBMXZXdm5RZk5ZWEZnYjRDWlZO?=
 =?utf-8?B?VllLYzJIOVBTMzFoSkErd2dkbk10MFZNSU9hZ0YvcXJZYk1SS1BpQUhSa3l5?=
 =?utf-8?B?NkZlNTFaTDFQZEFQN0JWYzdxUnhWVDZncTNJSjZmRDFBb3lldFhwUFpsRnE0?=
 =?utf-8?B?bUIwZ05MaEpUWE1CVk9kUTZTVUp4V091LzU4NmZvekhwWk9yOHZWTytjbHVt?=
 =?utf-8?B?SS9ObE9oUzY0SFA4RVRGb0JLRWZoQXE2RnZKeTBjS3pEU0hmOVR6b3RTUlZR?=
 =?utf-8?B?L3VOT2REK0wzcGgvQzZuUEdUWVJXTWp2elBXK2NzRXZ2Vytxc2FtVnpBRzJp?=
 =?utf-8?B?L25zSzQ0Nkc2c1YwSlZOSVllUTdvUks1YWw0QXI4ZTJjM3RJbDlqdFZOMWlu?=
 =?utf-8?B?UEFhK01DUlU1QjRiTGo1YjQ5SFBBRUN3UGNnU2h1Z09EWEdGZDBQWHpFMjRB?=
 =?utf-8?B?aTYwUDFkUGE5MmpkUDNoSG9tRGpnWWpxWWRmcXlCWkppcWpvYXNEQi80TjlP?=
 =?utf-8?B?TFRLL0h4MmtUOTZpb1ZnR1M2UlFJTnVvT05XSGkxeitGMUdnTXkyeklPSENO?=
 =?utf-8?B?bjZKTGhva2JFVmRLSDhrMmpxRGFzYXdIeXByTFFiYzNrblFQYXI0bkJ6ZWhM?=
 =?utf-8?B?d0RjMXpIeHBpajVDNEgwYmlIZnBGQ0N4NkdTbGhkaElabWkvUmM3Tnd5Wmp6?=
 =?utf-8?B?ellyTHZxNlo2WXhhd1JOZ2ZUNU5taXJRQ2ZVZG9Fb1hEQ21SVXBIWjFrdmVN?=
 =?utf-8?B?cUo4UGw2UXM1aEg1bk1Rd0M2SllHMStZQmR5bWE1c0xYODEvbTVneUlwOG5W?=
 =?utf-8?B?OFA3azhIVTV2L1dSZlpIc2U4K2JLckt5YkZVMGRvcFAzWFphZXpmY0lqSG80?=
 =?utf-8?B?QTZtaENIN3duN25DUlV3RWxrMFlZVTJmSHltUGR4YVkwRWhxQzI0QjdMRzNP?=
 =?utf-8?Q?p6fAlPkOFRiyWUz0cpjFM3hy+?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 686521f3-6b7d-456b-b9a3-08dc9f1deeef
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2024 07:16:49.4449 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xjQ2A72zFLNq3kJI967/ee8l9YNNzYHf+O1C1lhMCAqXekISqh2hJ9UQX/IStAsY/f2O5eJ8X3y4CUO8kWT0Yg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5902
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.18; envelope-from=yi.l.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

On 2024/7/5 19:01, CLEMENT MATHIEU--DRIF wrote:
> From: Clément Mathieu--Drif <clement.mathieu--drif@eviden.com>
> 
> The 'level' field in vtd_iotlb_key is an unsigned integer.
> We don't need to store level as an int in vtd_lookup_iotlb.
> 
> This is not an issue by itself, but using unsigned here seems cleaner.

a nit to the subject. s/"make types match"/"make type match"/

> Signed-off-by: Clément Mathieu--Drif <clement.mathieu--drif@eviden.com>
> ---
>   hw/i386/intel_iommu.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> index 37c21a0aec..be0cb39b5c 100644
> --- a/hw/i386/intel_iommu.c
> +++ b/hw/i386/intel_iommu.c
> @@ -358,7 +358,7 @@ static VTDIOTLBEntry *vtd_lookup_iotlb(IntelIOMMUState *s, uint16_t source_id,
>   {
>       struct vtd_iotlb_key key;
>       VTDIOTLBEntry *entry;
> -    int level;
> +    unsigned level;
>   
>       for (level = VTD_SL_PT_LEVEL; level < VTD_SL_PML4_LEVEL; level++) {
>           key.gfn = vtd_get_iotlb_gfn(addr, level);

-- 
Regards,
Yi Liu

