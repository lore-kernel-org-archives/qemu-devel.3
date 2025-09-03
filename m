Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09993CA0FF2
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Sep 2025 07:52:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utiHo-0003vM-G8; Wed, 03 Sep 2025 03:52:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1utiHn-0003vA-57
 for qemu-devel@nongnu.org; Wed, 03 Sep 2025 03:52:07 -0400
Received: from mgamail.intel.com ([192.198.163.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1utiHk-0003zg-KX
 for qemu-devel@nongnu.org; Wed, 03 Sep 2025 03:52:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1756885924; x=1788421924;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=GyVXTyi1esvEhC7emWcrqmUjB2kYZ+GTs5mrs3Z+K/o=;
 b=bOrrM7r54Zw3CIDFN4p6QBhQjBLaVKfBSzRFGhfM+0L2agI3UdqsiSug
 iHEnOZtBRkKJmv/xgKNT/pgyIL5JNhPKWgC7zqpgjb8L3oAbjeMqgl/ta
 lQoTyFTo2w4z3rZ7oDFwnNfxloECZ2gcfyoeI3Fde4IuVmI2Uez5ukwsx
 ojTg+YZd4FuAOcIGq9lWGgiScJ4kUZZeWn8OZA0BTVF7kXN0Rd8ykTDet
 pRuhA7ruLFGoWSKhD/El2UhV6nvBfo2NqeEyBeNugUBl1FNm40p2We5uB
 kKD3XKQDNVU4uG3MbuvvZgea2M/LRE04FbZ8Hky0hRRbi0371dmHNAXm2 w==;
X-CSE-ConnectionGUID: LQsJG00BTDOVFsOtoznFqA==
X-CSE-MsgGUID: J8WaL5fTS+CtV8JTyRLWdg==
X-IronPort-AV: E=McAfee;i="6800,10657,11541"; a="59258789"
X-IronPort-AV: E=Sophos;i="6.18,233,1751266800"; d="scan'208";a="59258789"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Sep 2025 00:52:01 -0700
X-CSE-ConnectionGUID: nyYNxgX8Qq+VYDn0r5i3Dw==
X-CSE-MsgGUID: D+/iVqViQmeivRb6PwLkgw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,233,1751266800"; d="scan'208";a="202471483"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Sep 2025 00:52:01 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 3 Sep 2025 00:51:59 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Wed, 3 Sep 2025 00:51:59 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (40.107.237.56)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 3 Sep 2025 00:51:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dgpNi22EoQwAcKldIocDRzpdnoRez7JiOLlQ6543qUHG3kcZrYHJRQjAGzKWB4qecbECKHFDvEjuVu+pVUcwwxmkyiroAMDgAxIXdpWtJ1Rj/5T/YZV1i1qYcIQGL6Mf82QTiSRUpBn2b92xp51hblKFG12Mt6ZlzQ/BV2mP/DYYerbH6dem8DnYJMjlni7i/NCp0Bvi8tEGBEyhMFIN8XcrT5VreGuqOHatv4x9eLCtFModR7Y8SRK8uRrBqs+vbk55nFHsxJ44vpMVTIZMwBaHcaQjnZGx2WW6peFOv4cEMuteqV7IWsumH3cUwDewcllVpiDqj/9rheOAPlWvzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N2yWYITsRj+iMbbYk/R743g0wCB6v7CWZlSOggelwKE=;
 b=uzTqBdHvmGvhweiPlhYNBd2842Ei9+2FTz9ab45GPZjftR8rU5PTBDWpZtOAD+irtTVNaUJRF9Bkoy19aeiIuZy8fLsKDGN+7zQfc8iuybO+ws+nLLGtzenIM/R3oDIoWjNOVFA8XSEkuqJDB74C5r9YX8uLqNA/NunZFRxsLKMjrx8WhZVoDkbAP2+q+u3CuRnz4hitTqf87ywispqP4uS5lKTABXTXuwFN9+VqK9fsHZZdMDxrbZB53tq439IYUZLllBIO+rKuDLkz7LcH5z7IimcxO01WrBzOsnogP0P7AFUOduJSim9BbcMuLYRf2BKRcBABe6Qchzcb0AcXUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BY5PR11MB3974.namprd11.prod.outlook.com (2603:10b6:a03:183::29)
 by DS0PR11MB8017.namprd11.prod.outlook.com (2603:10b6:8:115::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Wed, 3 Sep
 2025 07:51:54 +0000
Received: from BY5PR11MB3974.namprd11.prod.outlook.com
 ([fe80::fe0b:26f7:75b4:396]) by BY5PR11MB3974.namprd11.prod.outlook.com
 ([fe80::fe0b:26f7:75b4:396%5]) with mapi id 15.20.9073.021; Wed, 3 Sep 2025
 07:51:54 +0000
Message-ID: <7435cb2a-929d-4565-848d-8a4520ade461@intel.com>
Date: Wed, 3 Sep 2025 15:58:23 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 11/21] intel_iommu: Handle PASID entry removal and
 update
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>, "eric.auger@redhat.com"
 <eric.auger@redhat.com>, "mst@redhat.com" <mst@redhat.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>, "peterx@redhat.com"
 <peterx@redhat.com>, "ddutile@redhat.com" <ddutile@redhat.com>,
 "jgg@nvidia.com" <jgg@nvidia.com>, "nicolinc@nvidia.com"
 <nicolinc@nvidia.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "clement.mathieu--drif@eviden.com"
 <clement.mathieu--drif@eviden.com>, "Tian, Kevin" <kevin.tian@intel.com>,
 "Peng, Chao P" <chao.p.peng@intel.com>, Yi Sun <yi.y.sun@linux.intel.com>
References: <20250822064101.123526-1-zhenzhong.duan@intel.com>
 <20250822064101.123526-12-zhenzhong.duan@intel.com>
 <5ccc7892-2024-409b-b107-4ffa02e31b71@intel.com>
 <IA3PR11MB9136FC723C303B92F4957C179207A@IA3PR11MB9136.namprd11.prod.outlook.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <IA3PR11MB9136FC723C303B92F4957C179207A@IA3PR11MB9136.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR04CA0204.apcprd04.prod.outlook.com
 (2603:1096:4:187::16) To BY5PR11MB3974.namprd11.prod.outlook.com
 (2603:10b6:a03:183::29)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR11MB3974:EE_|DS0PR11MB8017:EE_
X-MS-Office365-Filtering-Correlation-Id: bf9ca7e0-5ff2-437e-7ed4-08ddeabebf13
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7416014|42112799006; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?V2J6T0hTRkRjWTZlSVYwQjlyNDNjK1MzWXJmb2llNTRYaXBYL01sRnAxTTRY?=
 =?utf-8?B?ek5ZSUtpYzlxc0Y1akEzU2NRNll3ZEVDVlM5WHl5K0dWenllRzdUZUtva2NI?=
 =?utf-8?B?MDZwK29ZVGY3K25rWUdhV2svUmpEaVgvTCtLL1FQRE1kV2twWmFvU0ROU2ho?=
 =?utf-8?B?cmw0R1V3bkJod2xheTRFb0FMSmx6MUlSQkxMcUNYQXZPT2llbWQyY2NUdXB5?=
 =?utf-8?B?dW5OTGI4TzZnSVRGK1BSSFhqUzJhRFphZXNOQUFyNDVQY0UycEZnSEk4ejdX?=
 =?utf-8?B?NnBFbjQ2QUhIODk3M0ZhSW51bmtERnZXOXpvWmFqak83QXVmem1keVdQS0dw?=
 =?utf-8?B?WktMbW9RN0VOWFhNTS9wbTQrT0ppU1ArQlZzaktHbGFreE9ReVFka1VFeVNr?=
 =?utf-8?B?cVZKeVovdkcyajJ3dTc0L0JxcGpXcUZJV0tvYmg4L3ZWTktpS3QwSGpOejgx?=
 =?utf-8?B?WFlrRVl2SHE0Zk0zTCtERjNCNzArK0RHUFdQa3dLWUJETm1aNjkxODQzSk1i?=
 =?utf-8?B?QnBUWURCdG5pWFM4SENnMmIrRFZ5Y283dTUwU0JZZ1JBTFZNSWJTcVJ1V08v?=
 =?utf-8?B?Y0tvZ2dkYWNaVGdZN2ZxSVg1eHlNSk5nMWltWFdvcERMK296eTM1NzZpSHlW?=
 =?utf-8?B?WFV0V05RbXgyUUZTTlVOSHAwL3YzeXIvRkFKMHQ4eWxGUnMxdSswMkZvY1Bx?=
 =?utf-8?B?QzdqSkgyTTEvM3o0eVViQmllcThGbXl1OGxJbFNYOFUwL1NLQ1lteTFyYm01?=
 =?utf-8?B?ekxaaE54Uyswb2tDdk1BOGRIMTIxZUpQQWRnamN0QnZpZVV0ZWptU210WjZX?=
 =?utf-8?B?TC9QVnpIRDdmdWkwVW9xQzhjSmhRbGYzRlNiVHpEMzBVV0VnYXlxbmVzeXUx?=
 =?utf-8?B?c0hxbWpqenN3eUxWQ1NIVVZPL2NzL3BISG5xNXpMRmRYeURUWG1GS1FzVFBZ?=
 =?utf-8?B?cXdjMFRXbWJkMndBdnZIMFMvY0VqeCtBQWxHdDlVWXYvWllQZ2t6dEtDaGZo?=
 =?utf-8?B?MTBTZVI5OHhxSS9seEtINFVJSEl6QXVSRlJ6cHJ2T2ZRR3FyYVVBcVhzN1d2?=
 =?utf-8?B?MCs3eDdrR0p5SHAwVnNsUExpOEgxakdDbytSVjFYTDRna2V4dC9IK1dva1ZO?=
 =?utf-8?B?eURxRmttZERPZVJYaDlmcURhYzhpTnl2QllkWjY4RW9LaitoRFdrNWpPcDVY?=
 =?utf-8?B?bWh5bEVHeWFaeVRjUEhtU2JhTEtpTFBmN2FONmtYQkxxbE80bmJWVUhKaEFI?=
 =?utf-8?B?Zk5ha09VYk9iOE5GRWk0M2FEY3Qzb09vUlBnUXhMV1c4ZWk3S0lmeitWUVBG?=
 =?utf-8?B?eVphWGxtODNnSWx5ZkFEM0RzMnlqVXBLM05IWWVPam1oNXU1a0xISGVQWThX?=
 =?utf-8?B?TWN1Z2RiSzFWVlZmNDBEVTgxMHpZOU5GNSt0WUNJcVZZcHltZlhrMEQ3L0FM?=
 =?utf-8?B?aVFLRDQwa2orTU1ML25hclZLWGM0enJUQzNDMTAyejJUVUZJR2VNQ29hOTZi?=
 =?utf-8?B?TVpJcnNpTSsxOVRUd2U5emN2RCtsTXJHdGpxM0JOdFZHR3Z6TEJ4RUF1VW5q?=
 =?utf-8?B?Zjc1dXNuNlFGSDBiZU91bm5zSk9yZENPdTlsWDgreXgyRCtscHU5QUNBNjJu?=
 =?utf-8?B?YnFWUXp4STNySE9IYW5UOEFHc0hCSmR3MzFwUXROMmpHZE43ays5Ry9BZWRs?=
 =?utf-8?B?ckk3dnpNQXduR3V2MzVIREZOOVNDVXlRWENGZ0FRcTZxOFJDQ2FKeFJ2b2Ir?=
 =?utf-8?B?RzdRcHRudkxqNEM2QmxTS1JoeGZnRC9XYmlzU1BhclU2WnJtVnBWMTN6bDJs?=
 =?utf-8?B?OFg4VHNYNTJnUWlqa1ZTTVJHTUdGZUZvOGhPT3JVQzREM0YvMzFmeGJUVEN6?=
 =?utf-8?B?MXBqS0dPNm1hdmRZZmxBWHF4RHJYaklCbFgzbUhLZUFHU3dOL3FEOERZMG9m?=
 =?utf-8?Q?mEM8x3TiFEo=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR11MB3974.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014)(42112799006); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MFU3N3hONUlyS2xMMVhZUEdjazFaQ0pXaWpxRXhCSWJiWXA1WVdjemhFcldK?=
 =?utf-8?B?YkVzNFdyT1RMK2xvZC8rSGhibkNUbTMzaXI0eVJFQ2Z6SC9qZVRPMEprWGtH?=
 =?utf-8?B?UnBtOExOOHRNYzZBc0xVVUM5YVBTK2ROM2Y3bUE5YTFSS0JnUkp4eWtvK2Ro?=
 =?utf-8?B?OXFYY1N2S2Yva2hDREV5YzFuTGtiNG5LM3UrZlFVTmt4U1Z1Uk9mWHQyVnp5?=
 =?utf-8?B?VThSYUtNemhoNVdqS1BqWHpHUnAxNXZsbzZ5Q3NNdTYzQ0oyYkpaTURweDYw?=
 =?utf-8?B?OXFudnc4aDVSSzByaW9aNTBsWmRFdzh0cFJqYmwwd2hTdUl5d1FGRzNqMk5t?=
 =?utf-8?B?MVQzSTcwbGR1VWpnc3VGNkI0NVE1bmRNb1BYWDFlUncwdzE5UlNucm14QUZR?=
 =?utf-8?B?eFZKSDMweWNJcWpudUZmT1MyMWhLQWloK3ZLMHkvWWFxZzBoZ3ZZbENhbm4v?=
 =?utf-8?B?bFRsLzNXRlluajBjSlg4akJnYjZ2bVNsZWUyQ0R1OXZmRzJldTdVMEZLajZv?=
 =?utf-8?B?a21aamY4ZUdZVUpRUXc3UlpIMnhJMVBVbUN0TlJFdXVldGFQRStvWGwrYVNR?=
 =?utf-8?B?dzdZV1QzY0lpRnROMFQxZHZoY2ZnalFQWEl2aDJWMldydzFKTWxBUUU0MVRF?=
 =?utf-8?B?SThQek10ZU5QaVRUbzNOZWNxSFU2MjNOZGcxQmpWYng0eEI5ejgremlHN3dq?=
 =?utf-8?B?bElMUWJ0VnpFWFhrRENNQnZkaXZrWXF3bGJ5RlNYT01mV1QzNzg4TUZsY1U2?=
 =?utf-8?B?eDdqbmYrK3ZOWVZDZDMwaVovNEtKS1hxbFA4ZzIyT0E2MmdONEN3SWNXa21B?=
 =?utf-8?B?eTI1RlpNZDR5cGZxMEsrU2ZoK0lON2R0REVvUXB2T29FOW5IL041eUFnRVNL?=
 =?utf-8?B?TlhSTmhsb29vdTIraFRublVsTjEvUWJldXhORmdTeXZCS2kwY0J4Z3NBTW0x?=
 =?utf-8?B?Y1c0eUFiNkpXTWRGc0Z3SXRjRWZxZTdybzhXNzFxT1dCN2x1bHcyaXFJVVVr?=
 =?utf-8?B?aE5tdUVjQnVJdnFvNTJTM2FqSVIwaWZDVmJLV3pwQUJFa1JoR0tKU3NqcUlU?=
 =?utf-8?B?NHVFTTBSWHNqaFdyUjhrQ1A2dXMrdEwrMFZsUGFZWHJ5aks1OWVBbXdRNXpN?=
 =?utf-8?B?eitPQVFibHk2eGtLRnVCb2poKy8wN3UwVHNDVXcvVnVKQWdaSnErak5SRHNO?=
 =?utf-8?B?NC9GaFdmN1NEK2RUalpkUEpENXhpVTYrNVB2dERzSzEzYXRkaWtrMXVYSlJZ?=
 =?utf-8?B?TnRaWjVNM2wxR2pXOWtNMzFQWUt5ZFp1NENDQmpRWjVFNHhEZjEwcXFLZ0k3?=
 =?utf-8?B?TkE5cXovakNqaUxaZE83cVdBcVQxcDRMS1lIRHZPbmhleWtDZmEvNm00ZFl3?=
 =?utf-8?B?eVVWUGlxeXIwZzBVQVY1bEJsYVdlU3ZkSUVSK0IyY3NvUklwSG8rdzhDdEFY?=
 =?utf-8?B?QlhxcHl2RzhybHdHTnUvT0xsVXpqSFlOd0ZZemZ5b2F0OVkyajhHSEkvblc1?=
 =?utf-8?B?K24vSWZQNEgrZ2dUdloxNHB4RXhjd2I4VWtVcVJzWnhwNm9rbm9Za2VpSm5h?=
 =?utf-8?B?T1pFYVhUdEZ4WUpRbGIyTVVDYWs3dzQ4N3hrcDEvWndEeUpEUEVmeFlDbVJG?=
 =?utf-8?B?OGRMekhlYWxFRnFqejRFUml3TUJjRFJxNzZGVmMvcDJKRVA5OHprblJGUG5V?=
 =?utf-8?B?N1R5MEpteHFPNVp6RHI4YlZkeFFtOHdxd1Z5MzhNcE1POGFLKzMzWlBzNHd0?=
 =?utf-8?B?dlpESTF5dldLZiszZTNud21NZWxMek0yZ2hSSHZvWkZwd0ljZGJSZkFyNWx6?=
 =?utf-8?B?RDV0QVZUTUZ5UkU0QTdtbWhGc2RtcEw4Z1pzOVF6Tk0xTC9zaU1kenlZWUFV?=
 =?utf-8?B?bW9kM2I1a1ozWm1xRThnc2UvTUVKR0VidHA2VFlWZkU4Z2N0OThaUXhOcUR2?=
 =?utf-8?B?ZmprVllmQVNOczVTUmh6TWJmWDVMU3lPOVNvblF2N04wUFE5R2lKTDBSdmdi?=
 =?utf-8?B?OEJsLzFqSkp6MkJ6endJYzN4L3dSRWxHL3lKMWVJR3Y4ektoV1RyN2EyVVUx?=
 =?utf-8?B?LzFnc2hkZCsyNlA3WVNObU5hK2dOR1NSbnhORzFXb2NxUkFUYzQ3SzdzcUs4?=
 =?utf-8?Q?XpQKM+TKXDW2qcM2wtBYuZAif?=
X-MS-Exchange-CrossTenant-Network-Message-Id: bf9ca7e0-5ff2-437e-7ed4-08ddeabebf13
X-MS-Exchange-CrossTenant-AuthSource: BY5PR11MB3974.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2025 07:51:54.6107 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dN9yfX2zyzpmA/7Xlg13nT0NqAa2l+9b/zx3I28SssLsRz85DwGQdpMlDow+4+BlitFtIBSNxhs358xcvWsyvw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8017
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.14; envelope-from=yi.l.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
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

On 2025/9/1 11:31, Duan, Zhenzhong wrote:
> 
> 
>> -----Original Message-----
>> From: Liu, Yi L <yi.l.liu@intel.com>
>> Subject: Re: [PATCH v5 11/21] intel_iommu: Handle PASID entry removal and
>> update
>>
>> On 2025/8/22 14:40, Zhenzhong Duan wrote:
>>> This adds an new entry VTDPASIDCacheEntry in VTDAddressSpace to cache
>> the
>>> pasid entry and track PASID usage and future PASID tagged DMA address
>>> translation support in vIOMMU.
>>
>> Have you seen any extra code needed based on this series to support non
>> rid_pasid PASIDs? If no, may just relax the scope of this series.
>> otherwise, you may need to tweak the patch a little bit. e.g. factor
>> out setting x-flts and x-pasid-mode at the same time.
> 
> There are quite a few code are common for both non-rid_pasid and rid_pasid.
> So in this series, there are some infrastructure code that looks like it's for non-rid_pasid.
> 
> But to support non-rid_pasid, we need pasid_attach/detach() which is not implemented in this series.

I see. Besides that, the vIOMMU internal infrastructure should be ready
for non-rid_pasid after this series.

> Even if x-flts and x-pasid-mode both on, pasid isn't enabled since VFIO device doesn't > expose pasid capability to guest, so guest never use non-rid_pasid 
with this VFIO device.

ok. Given that 1st stage for emulated device has already sbeen upported,
it's fine to rely on the knob in device side.

>>>
>>> VTDAddressSpace of PCI_NO_PASID is allocated when device is plugged and
>>> never freed. For other pasid, VTDAddressSpace instance is
>> created/destroyed
>>> per the guest pasid entry set up/destroy.
>>
>>> When guest removes or updates a PASID entry, QEMU will capture the guest
>> pasid
>>> selective pasid cache invalidation, removes VTDAddressSpace or update
>> cached
>>> PASID entry.
>>>
>>> vIOMMU emulator could figure out the reason by fetching latest guest pasid
>> entry
>>> and compare it with cached PASID entry.
>>>
>>> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
>>> Signed-off-by: Yi Sun <yi.y.sun@linux.intel.com>
>>> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
>>> ---
>>>    hw/i386/intel_iommu_internal.h |  27 ++++-
>>>    include/hw/i386/intel_iommu.h  |   6 +
>>>    hw/i386/intel_iommu.c          | 196
>> +++++++++++++++++++++++++++++++--
>>>    hw/i386/trace-events           |   3 +
>>>    4 files changed, 220 insertions(+), 12 deletions(-)
>>>
>>> diff --git a/hw/i386/intel_iommu_internal.h
>> b/hw/i386/intel_iommu_internal.h
>>> index f7510861d1..b9b76dd996 100644
>>> --- a/hw/i386/intel_iommu_internal.h
>>> +++ b/hw/i386/intel_iommu_internal.h
>>> @@ -316,6 +316,7 @@ typedef enum VTDFaultReason {
>>>                                      * request while disabled */
>>>        VTD_FR_IR_SID_ERR = 0x26,   /* Invalid Source-ID */
>>>
>>> +    VTD_FR_RTADDR_INV_TTM = 0x31,  /* Invalid TTM in RTADDR */
>>>        /* PASID directory entry access failure */
>>>        VTD_FR_PASID_DIR_ACCESS_ERR = 0x50,
>>>        /* The Present(P) field of pasid directory entry is 0 */
>>> @@ -493,6 +494,15 @@ typedef union VTDInvDesc VTDInvDesc;
>>>    #define VTD_INV_DESC_PIOTLB_RSVD_VAL0
>> 0xfff000000000f1c0ULL
>>>    #define VTD_INV_DESC_PIOTLB_RSVD_VAL1     0xf80ULL
>>>
>>> +/* PASID-cache Invalidate Descriptor (pc_inv_dsc) fields */
>>> +#define VTD_INV_DESC_PASIDC_G(x)        extract64((x)->val[0], 4, 2)
>>> +#define VTD_INV_DESC_PASIDC_G_DSI       0
>>> +#define VTD_INV_DESC_PASIDC_G_PASID_SI  1
>>> +#define VTD_INV_DESC_PASIDC_G_GLOBAL    3
>>> +#define VTD_INV_DESC_PASIDC_DID(x)      extract64((x)->val[0], 16,
>> 16)
>>> +#define VTD_INV_DESC_PASIDC_PASID(x)    extract64((x)->val[0], 32,
>> 20)
>>> +#define VTD_INV_DESC_PASIDC_RSVD_VAL0   0xfff000000000f1c0ULL
>>> +
>>>    /* Information about page-selective IOTLB invalidate */
>>>    struct VTDIOTLBPageInvInfo {
>>>        uint16_t domain_id;
>>> @@ -553,6 +563,21 @@ typedef struct VTDRootEntry VTDRootEntry;
>>>    #define VTD_SM_CONTEXT_ENTRY_RSVD_VAL0(aw)  (0x1e0ULL |
>> ~VTD_HAW_MASK(aw))
>>>    #define VTD_SM_CONTEXT_ENTRY_RSVD_VAL1
>> 0xffffffffffe00000ULL
>>>
>>> +typedef enum VTDPCInvType {
>>> +    /* VTD spec defined PASID cache invalidation type */
>>> +    VTD_PASID_CACHE_DOMSI = VTD_INV_DESC_PASIDC_G_DSI,
>>> +    VTD_PASID_CACHE_PASIDSI = VTD_INV_DESC_PASIDC_G_PASID_SI,
>>> +    VTD_PASID_CACHE_GLOBAL_INV =
>> VTD_INV_DESC_PASIDC_G_GLOBAL,
>>> +} VTDPCInvType;
>>> +
>>> +typedef struct VTDPASIDCacheInfo {
>>> +    VTDPCInvType type;
>>> +    uint16_t did;
>>> +    uint32_t pasid;
>>> +    PCIBus *bus;
>>> +    uint16_t devfn;
>>> +} VTDPASIDCacheInfo;
>>> +
>>>    /* PASID Table Related Definitions */
>>>    #define VTD_PASID_DIR_BASE_ADDR_MASK  (~0xfffULL)
>>>    #define VTD_PASID_TABLE_BASE_ADDR_MASK (~0xfffULL)
>>> @@ -574,7 +599,7 @@ typedef struct VTDRootEntry VTDRootEntry;
>>>    #define VTD_SM_PASID_ENTRY_PT          (4ULL << 6)
>>>
>>>    #define VTD_SM_PASID_ENTRY_AW          7ULL /* Adjusted
>> guest-address-width */
>>> -#define VTD_SM_PASID_ENTRY_DID(val)    ((val) &
>> VTD_DOMAIN_ID_MASK)
>>> +#define VTD_SM_PASID_ENTRY_DID(x)      extract64((x)->val[1], 0, 16)
>>>
>>>    #define VTD_SM_PASID_ENTRY_FLPM          3ULL
>>>    #define VTD_SM_PASID_ENTRY_FLPTPTR       (~0xfffULL)
>>> diff --git a/include/hw/i386/intel_iommu.h
>> b/include/hw/i386/intel_iommu.h
>>> index 50f9b27a45..0e3826f6f0 100644
>>> --- a/include/hw/i386/intel_iommu.h
>>> +++ b/include/hw/i386/intel_iommu.h
>>> @@ -95,6 +95,11 @@ struct VTDPASIDEntry {
>>>        uint64_t val[8];
>>>    };
>>>
>>> +typedef struct VTDPASIDCacheEntry {
>>> +    struct VTDPASIDEntry pasid_entry;
>>> +    bool valid;
>>> +} VTDPASIDCacheEntry;
>>> +
>>>    struct VTDAddressSpace {
>>>        PCIBus *bus;
>>>        uint8_t devfn;
>>> @@ -107,6 +112,7 @@ struct VTDAddressSpace {
>>>        MemoryRegion iommu_ir_fault; /* Interrupt region for catching
>> fault */
>>>        IntelIOMMUState *iommu_state;
>>>        VTDContextCacheEntry context_cache_entry;
>>> +    VTDPASIDCacheEntry pasid_cache_entry;
>>>        QLIST_ENTRY(VTDAddressSpace) next;
>>>        /* Superset of notifier flags that this address space has */
>>>        IOMMUNotifierFlag notifier_flags;
>>> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
>>> index 1801f1cdf6..a2ee6d684e 100644
>>> --- a/hw/i386/intel_iommu.c
>>> +++ b/hw/i386/intel_iommu.c
>>> @@ -1675,7 +1675,7 @@ static uint16_t
>> vtd_get_domain_id(IntelIOMMUState *s,
>>>
>>>        if (s->root_scalable) {
>>>            vtd_ce_get_pasid_entry(s, ce, &pe, pasid);
>>> -        return VTD_SM_PASID_ENTRY_DID(pe.val[1]);
>>> +        return VTD_SM_PASID_ENTRY_DID(&pe);
>>>        }
>>>
>>>        return VTD_CONTEXT_ENTRY_DID(ce->hi);
>>> @@ -3112,6 +3112,183 @@ static bool
>> vtd_process_piotlb_desc(IntelIOMMUState *s,
>>>        return true;
>>>    }
>>>
>>> +static inline int vtd_dev_get_pe_from_pasid(VTDAddressSpace *vtd_as,
>>> +                                            uint32_t pasid,
>> VTDPASIDEntry *pe)
>>> +{
>>> +    IntelIOMMUState *s = vtd_as->iommu_state;
>>> +    VTDContextEntry ce;
>>> +    int ret;
>>> +
>>> +    if (!s->root_scalable) {
>>> +        return -VTD_FR_RTADDR_INV_TTM;
>>> +    }
>>> +
>>> +    ret = vtd_dev_to_context_entry(s, pci_bus_num(vtd_as->bus),
>> vtd_as->devfn,
>>> +                                   &ce);
>>> +    if (ret) {
>>> +        return ret;
>>> +    }
>>> +
>>> +    return vtd_ce_get_pasid_entry(s, &ce, pe, pasid);
>>> +}
>>> +
>>> +static bool vtd_pasid_entry_compare(VTDPASIDEntry *p1, VTDPASIDEntry
>> *p2)
>>> +{
>>> +    return !memcmp(p1, p2, sizeof(*p1));
>>> +}
>>> +
>>> +/*
>>> + * This function is a loop function which return value determines if
>>> + * vtd_as including cached pasid entry is removed.
>>> + *
>>> + * For PCI_NO_PASID, when corresponding cached pasid entry is cleared,
>>> + * it returns false so that vtd_as is reserved as it's owned by PCI
>>> + * sub-system. For other pasid, it returns true so vtd_as is removed.
>>
>> also, this helper will always return true if this series does not
>> support non-rid_pasid PASID.
> 
> Do you mean return false? I don't think it will return true.
> For non-rid_pasid, it may return false.

aha, yes. for rid_pasid, you need to keep the vtd_as instance.

Regards,
Yi Liu

