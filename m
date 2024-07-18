Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F4210C3DA60
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2024 07:21:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sULR6-0003iD-5z; Thu, 18 Jul 2024 03:20:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1sULR2-0003fr-MG
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 03:20:17 -0400
Received: from mgamail.intel.com ([192.198.163.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1sULQv-0006Fl-OG
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 03:20:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1721287209; x=1752823209;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=gPJuBova5SYNXrwb8HvUM+J2AWBsUz4HX4ZTTSRZ9t4=;
 b=BQzmX6l6nH8+mZiuPHN62Z0y8WhgntggCi/n+h/64BS7SSnDfyp9Htg7
 xzGMBxb2EQGcGUOfs50jAQRFILWSyvmR5iogaamHtN2EID2LORHqrcYDN
 ZGGqGiq+/As0sbdXEMMRIbG04jAaUAmMp/rP1oAKEZ4qeamCuVo90WFwe
 9TmJWvQr27KDoy2EwILEO2Dde+OSPYHSHRs63Nlh76V5KnCvr2zzChZGr
 vUMzzxxPdFGPjkDRLkG8fz09Y2pVUczq0yOqBrGWhxk/fyzgcdZKDsohJ
 R0T4hm+w701YsSKf6YSMwd5BoEJVMp2AqR4ZdDY6VyVyxC2yDJizJSK8r A==;
X-CSE-ConnectionGUID: rfijKMgwTk6nzNaHGD5ucA==
X-CSE-MsgGUID: it2sRMy5Rfendz3mVQUwzA==
X-IronPort-AV: E=McAfee;i="6700,10204,11136"; a="18531459"
X-IronPort-AV: E=Sophos;i="6.09,217,1716274800"; d="scan'208";a="18531459"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Jul 2024 00:20:06 -0700
X-CSE-ConnectionGUID: A69bmTK0QommZDGEjoOlVQ==
X-CSE-MsgGUID: lfB+1go/RLuUMbm7/+mXrg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,217,1716274800"; d="scan'208";a="55180080"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
 by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 18 Jul 2024 00:20:06 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 18 Jul 2024 00:20:06 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 18 Jul 2024 00:20:05 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 18 Jul 2024 00:20:05 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.47) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 18 Jul 2024 00:20:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Tr0AsiNA9iHR+TZ4obwHIfASO/wCBDvdo59g8TRLrJ3d2MxPWlqK06mSHRcuzvxmvPDZtKMNWvuL82PH7HV9eRKmNAcXF2kAQYQmsoXPD3IRPXO5yLasUKx6ZAF6yQLoGrvAzsoM4b5zmeINR/RRsQBWhbvXt7DxvOeJ6YBW+T9vChcKIDwvokApKs69HRu6nUE4dKYtv+rTM9g9jksbeBeswqwKIYn9eN9nUT967qGqNGydSSGCxkQGgQMC9sRMhkxnCVOQcNagg47NUqphdWedH8BGWNjXHXNmz+Jy9dpsqlMI+jssILtZYp7kNTx4TemH/yVRGi1Un2Dls40G5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gPJuBova5SYNXrwb8HvUM+J2AWBsUz4HX4ZTTSRZ9t4=;
 b=lPvMTS+mvYcFwEJ0DMM/Uhfz8qgcMe/7SwfNZHdj6wmMKS4EYyU+CIXUvRmXtZlIefbHfcF5RTXVWnNfEnNMUcxS6oD+O3QP0M9NxpBdjAi4Q8sV5aFMWNpXH4L1RdPzKf+jVtk/89Pk7acQakurUxd/1ZKAlx39vCBMYlhgCbAbiZiCFr4WRxpzTXlmJKAlO3TKara/+i9qA51zPIbW6Wg6DJgly3V4YnxJpTCHEiE8iMFh/lHk2YTp4UCY2cNGcPcJnzF9X2jIEpnbjRdwWmSFV5T9Ux/dy4MGdHc+NV0IBtQO6J2MBF4DOqoOG3RcVgQu+CC7SgdCVplfYlXX7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by CH3PR11MB7769.namprd11.prod.outlook.com (2603:10b6:610:123::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.16; Thu, 18 Jul
 2024 07:20:03 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091%7]) with mapi id 15.20.7784.016; Thu, 18 Jul 2024
 07:20:03 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: Joao Martins <joao.m.martins@oracle.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "Liu, Yi L" <yi.l.liu@intel.com>, Eric Auger <eric.auger@redhat.com>,
 "Alex Williamson" <alex.williamson@redhat.com>, Cedric Le Goater
 <clg@redhat.com>, Jason Gunthorpe <jgg@nvidia.com>, Avihai Horon
 <avihaih@nvidia.com>
Subject: RE: [PATCH v4 11/12] vfio/migration: Don't block migration device
 dirty tracking is unsupported
Thread-Topic: [PATCH v4 11/12] vfio/migration: Don't block migration device
 dirty tracking is unsupported
Thread-Index: AQHa1FFf2/DG8eO1r0muhqTtcmW9tLH6O9CwgABwkwCAAXA0kA==
Date: Thu, 18 Jul 2024 07:20:03 +0000
Message-ID: <SJ0PR11MB67444526632E358E81C4F17792AC2@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20240712114704.8708-1-joao.m.martins@oracle.com>
 <20240712114704.8708-12-joao.m.martins@oracle.com>
 <SJ0PR11MB674456F8871EAC781732D0CD92A32@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <da65c43a-ddca-4d47-bfbf-274e8062c56b@oracle.com>
In-Reply-To: <da65c43a-ddca-4d47-bfbf-274e8062c56b@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|CH3PR11MB7769:EE_
x-ms-office365-filtering-correlation-id: 1535d082-6119-4688-fcbd-08dca6fa0abf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?UW9rZ2pmRC9ZWFFrc3NsdnBoVm9JSDZJckVRWnZjUFJyeTBKN3l0T2pEOGxM?=
 =?utf-8?B?eWE1b0RxWW5nVFA0RjM1bmFISEFpSHZ3UkFHdW0xb1ZrYlVKbG95K1NPZ0po?=
 =?utf-8?B?R2cydnFORW5SWnFocS9NTE84eFZOU05UdGR2Q3NBWnRobzl2WVJaSmRUWFVX?=
 =?utf-8?B?Z2NGSEpUa1F3U0grMjRrN0gxd09naVh4d2NLVDVpMFhRT01WVXV5eTYwaXFV?=
 =?utf-8?B?TFkyOHJXQXUzMlkwVmVoNjVyR2lkTXRNNHJEcXNvVFVPM2MybFB2bFNXUWpO?=
 =?utf-8?B?SWxQSFhxWjlPYUtpdk80VWRNTnhtVm5YNGYxV0ZmOE1jeHZWNjZRL21YNzVs?=
 =?utf-8?B?OXBjelBJaFgzbDdXN0ZsL09OdGRWZXBldXlod2xnQmtMME9sSlFhQ0RseGxS?=
 =?utf-8?B?eHZYaVpIdWZvKzdWZ0VJL2s4QU1ZRDFhQlB6K0NjYWhSTWRxazNzSTBnZWZ0?=
 =?utf-8?B?YXRsbjFtVGxqK0NHVWxiZGZYVXdFZStlbGpaTmMzU0RjdEZyQVJtc0hzeEhW?=
 =?utf-8?B?dzhxUCtRNGk2RlNBa2xsUnZrUkpWODlJNTQ5cXF1d1RXcWhrZk9sSWxXcTln?=
 =?utf-8?B?ZUxRV2xIaFc4azhwaXExRE1XRnJoWW5XWGpOZjRSVkdzVDQ2dmZNdkZyalZK?=
 =?utf-8?B?YytMVkJjRGVTd2xyZzJJUmxhVlZTSTlDNU84Tnd0dU8vMk8rSmxrTDQ0MHpV?=
 =?utf-8?B?bHRqTVdHNEo0VHN2YjEvUTJkZEc5VVU4MldwTGt3MDV4d1F5S3hDbm9hRUNW?=
 =?utf-8?B?R2U2bHp0QXl3UDJVSHgxbU1zMVlia0UxYXRuRnAwSElLdE5YYzQvakpwWjFM?=
 =?utf-8?B?dTlySnZUQ3luVUE2dFBCOG5UWDB2NXhvZGh5N1l3K2FieS9pdWVGK0QxMHRs?=
 =?utf-8?B?QjBvS3lwOWZ1aWJhZ3ZKZ1JPVC9ZcDNzbTZDOXFxYWU4QzNpakQ4NjRweUc2?=
 =?utf-8?B?dGRrTUpzWldpWC9lS3pNbWdLdUlVa3NacnhQMk52bGQ1UDFmMmZMVkNXZmtV?=
 =?utf-8?B?a2RhSG5VTDdFUFppZlRaalR6Z1FwMDRRNEU2UlhoU2NVNG1uVFpRTUZZRmp3?=
 =?utf-8?B?aEowSnY3SEt4a3AySml1T2tHVDJGazF0ZC91c2VVL3lZTGh2NFZpRE5objBG?=
 =?utf-8?B?R3VGcVVhdm40c2NZL3VXVS9SMUZQRGlSMk5YeGJvaGl3ajZKdFYvc1ZMOTR0?=
 =?utf-8?B?TnAzTEdWVEVBeXFaNUR2VnJNeDRkd3hjVktlN2xROVVZejRNUjlubk1XZzBw?=
 =?utf-8?B?RUdGQXpJU0xrY2o2ZzlNcExEZ0xDMDJ5V1ZKRGJob2ZTMXB3RitINERxaHRE?=
 =?utf-8?B?NzRHSkI1Y0JwLzE3Y2d4em5VbDRuT3l4aDJXdmJtWENLcVZvTTFncStkYWlB?=
 =?utf-8?B?N3YrZHRLTVQ2dHBDQmMydW40QUE1czFUSWhmUjFCVGE5R0oxU1l4aXhCZDZw?=
 =?utf-8?B?MHNFaEFUSXBQSWJrQ0RuQllXT2VqTUVZSFZFc2lmRzRxMDBlSUJSN2dsUldW?=
 =?utf-8?B?UVVpb3JBZ01XSWQ4S0ZYZFlYWTZ0ZGJBOEFMdkxTS21OQlVxa3E5RERVUkR3?=
 =?utf-8?B?Q1A4ZTdQOGtrME5ZRE8zRWxWY2ZJTXg4clluNi8vMmlRaER5T0ZPQWVqVFFl?=
 =?utf-8?B?RUZIUDhib3NHM2lYb1FWOGRCMm1VeTZkc05lOWFYQnBVZzJYeGdpK0dLOUN3?=
 =?utf-8?B?L0Q3ZDlqOWprTVN2VmRoUTBlSmVaNWpxOWhzM2pCTEw4NG5qK1J0L08rNWo3?=
 =?utf-8?B?T3d4elJ5L2dNMEhBcHdwUDlZRzRPV2h4YXZILzM2WVhDYzllY3pMZndEVzdB?=
 =?utf-8?B?aDkzcW5FRkdxeEJtWmRLYVlxa2l3bGV5TzBiNEZGcFgvMWp0UGxDdVFRQlFq?=
 =?utf-8?B?eTZjdEhHQzB1VE9xZEF4QnJPSzRvN01yWnFhS080d3JLUkE9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?anhXV1dHNElJWVlDQkhFWjFiUDkxZEJ2U0hvWHF0N0FOUnhQRXN5dmpEbVZ1?=
 =?utf-8?B?M1c4Y3dycng2OVcvYnVmejQ5SmZjT0djTnBZL0NMaDBsdzR2UjhVN2xYdkRo?=
 =?utf-8?B?V2R1N1dwNVVDWWMzM3hQMDB2bGJFdHcrem1PTGFBbkEzTHgyUFNhd0E4ejRU?=
 =?utf-8?B?OXJxOEFoS1ZxRndIUTZJa1lGcUJXK0U3SlF0Y3NOYkRieGY2TG1YSFZuaXQz?=
 =?utf-8?B?TEM4TVh2Sk40Uko3ZUh3MFlGQkFzSmk4Vmt6dVhabEZ0UkIxMmE2dlA3MGJH?=
 =?utf-8?B?TEx2OEgzSnpyVjlXeG1lNDRhckZFa0trOUtGRndCTENMS1c0dGR4Uy95V0E3?=
 =?utf-8?B?RFZmUTM1R21ZMWgzaWJvNWlxcFRmcnViMVN6Z1BiUjdRZ29ZTHpFOE1CenNM?=
 =?utf-8?B?TzZqMi9VeHNDbjZ6d0VmVER0ZGpqVHM3UW9lL1E3TG5jajhscllEY0kxTThP?=
 =?utf-8?B?Yk4yVXJWb1cvc3pZKy9OdXNQdERJR2JQV2EzNjEyNTAyQkYzdlRDVDhubHpw?=
 =?utf-8?B?cmVBNEVWTzM0Mko5WDkvbThmZ2c1c29TaEN5bTBzdmFDWnNNUVBYWG83U0hi?=
 =?utf-8?B?OHlwVE5udGZpa2ZpdTBRLzRod0IzMlp0cmd1OHpIVXJkRm14dWNxY1FxV2Yx?=
 =?utf-8?B?a2xPaVhPR0FtZ29GOFhvRXhKUWZ1bHBHbDJSY1RQMDZnYWJTSUphWjV3dUFZ?=
 =?utf-8?B?WS9mcW4vMXArY1N0YVp1ZG8vK3c0bzc3WHpVSStycFZGcERicHNjNzlObXFM?=
 =?utf-8?B?dERaK3I0cDFramd3WG5USFcvQWQ4RXc0OTZ6RUJlOE53SWg0Zi9sZHdSaGdi?=
 =?utf-8?B?UWtJemN2Rmh4Q05OdVZDQ3htRWtlUmhTZnd2c09uanM3TUlnRXRUelg0WFdG?=
 =?utf-8?B?K3NTY2hVQ2NSdTJWZ2hDajhWMmRuUDNvSzVaaVpFdnNKY3RVSittdXFJU2FW?=
 =?utf-8?B?cG1XWXg4Rmo2ZFFtSGprL3padCtKSXZtZko0dUIzdUNxb0s3TGVONklrUm41?=
 =?utf-8?B?UzErak8rVjRMVmQ0ODdZeS9zZmRhUDFVS1E5NFlQN2VNbE1CRDBYY0tsR3dk?=
 =?utf-8?B?bHQ4dkg1YSsvRzB2ekgrbURLL1V2bWJCTG9VMVpGSUFkVmx5T1lRcWFlcWZx?=
 =?utf-8?B?WkF0YkFpSWVJQS9UMk9VQ3JsVkhPeng4ZjY0VFhrQUZ5cVFlbGVIVERKMDdv?=
 =?utf-8?B?aWRQMFM1Q0g1dDlXUUdURkFNbzBuUGdSRnRybUJZSFlyNXRrNmFNOUo4Zytw?=
 =?utf-8?B?RW9uVzNGRVV2dlFhOHR4bkNBRVYrSzBKdUNkb0tCRVVlZlZuWGVWaFcrUjBj?=
 =?utf-8?B?Vm9hVXJ6Z1dBbTh2bEl1NnBaaUszR2grYXZZRFI5K2NLUy95RHdOV0lUOHJy?=
 =?utf-8?B?QnM4QVBMVFI2dnhHWFRYNkY2emJmWFpodkRXWmpNNzZnUG1oeGdqcnIyV1dU?=
 =?utf-8?B?WW1nYjY2eFMxRWdwU2gwMHFqNE10SUVTaFdhTHFJNFlYTWFlQjRJRXZzQjc4?=
 =?utf-8?B?UXBaVG15Ly9Za1BiMHdhV21oRVJKWm9QSkhKclNXY1lmVmljRHFsMkFGL3No?=
 =?utf-8?B?MHNHM29zMTlxY0dkQ1Z1WVY3cVNpQjR5U3VKZXQ4RStsZDYyRm5OdGNScmhG?=
 =?utf-8?B?UktCV1lqMDBad1EwR1U0UE1ZL2VuN1ZzMTNvbDJWdUpjbUxhZlEyR1pHYmND?=
 =?utf-8?B?MDhCWFhyVUFFZjJjMk45RTJid2JtcUdEdjFKcDJ2bWRkamw3bVQxRXpwMTk5?=
 =?utf-8?B?bzJSNGF2Z25zdWhhRUNEZ0xjbW0yaklpYmVjWUp4RHUvYXdkeUJlT25zU0pE?=
 =?utf-8?B?VFlpMHJuUnFSYnl3eWt2UEpSZXo0ZEYvbC9udk5iNmkrc25OWVlNa2JxSW9u?=
 =?utf-8?B?b2JrSUFzR2gyVHE2YTdQUWp5dU1NWFFQVCswRGxCQlVCQTVNMGNTNFJaMTdH?=
 =?utf-8?B?VzVNZ1lyNStmcDFCbTlOMDBYdFpmSzFsZXY4VFYwMTZLMytrdmVWSDZDZFhp?=
 =?utf-8?B?VFovYUtPdkJDcGxWYUhpZUlqelZPNDJUMUY3M1RZT2ZpOEM3Q0dmc0RqbWgv?=
 =?utf-8?B?ZERCclgvY0VKU0NQcWxUSUlmOTQ3aUwydmhYaHJ5M3ZJK09INUVlcVQ2eTBm?=
 =?utf-8?Q?JS4X+KcXJ0Isl8SeXH0i0gsov?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1535d082-6119-4688-fcbd-08dca6fa0abf
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jul 2024 07:20:03.1765 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: N7KfuK0gWlKizjOks9TBIXeCD3d3+KnrlhTuzXERauFO6FKPK4Cfkd1cCQuK+jlAAQPyI7xP1I8NBVsKGAZMkv31Rgle0yZIWnj8otR24z8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7769
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.19;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
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

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IEpvYW8gTWFydGlucyA8am9h
by5tLm1hcnRpbnNAb3JhY2xlLmNvbT4NCj5TdWJqZWN0OiBSZTogW1BBVENIIHY0IDExLzEyXSB2
ZmlvL21pZ3JhdGlvbjogRG9uJ3QgYmxvY2sgbWlncmF0aW9uIGRldmljZQ0KPmRpcnR5IHRyYWNr
aW5nIGlzIHVuc3VwcG9ydGVkDQo+DQo+T24gMTcvMDcvMjAyNCAwMzozOCwgRHVhbiwgWmhlbnpo
b25nIHdyb3RlOg0KPj4NCj4+DQo+Pj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4+PiBG
cm9tOiBKb2FvIE1hcnRpbnMgPGpvYW8ubS5tYXJ0aW5zQG9yYWNsZS5jb20+DQo+Pj4gU3ViamVj
dDogW1BBVENIIHY0IDExLzEyXSB2ZmlvL21pZ3JhdGlvbjogRG9uJ3QgYmxvY2sgbWlncmF0aW9u
IGRldmljZQ0KPmRpcnR5DQo+Pj4gdHJhY2tpbmcgaXMgdW5zdXBwb3J0ZWQNCj4+Pg0KPj4+IEJ5
IGRlZmF1bHQgVkZJTyBtaWdyYXRpb24gaXMgc2V0IHRvIGF1dG8sIHdoaWNoIHdpbGwgc3VwcG9y
dCBsaXZlDQo+Pj4gbWlncmF0aW9uIGlmIHRoZSBtaWdyYXRpb24gY2FwYWJpbGl0eSBpcyBzZXQg
KmFuZCogYWxzbyBkaXJ0eSBwYWdlDQo+Pj4gdHJhY2tpbmcgaXMgc3VwcG9ydGVkLg0KPj4+DQo+
Pj4gRm9yIHRlc3RpbmcgcHVycG9zZXMgb25lIGNhbiBmb3JjZSBlbmFibGUgd2l0aG91dCBkaXJ0
eSBwYWdlIHRyYWNraW5nDQo+Pj4gdmlhIGVuYWJsZS1taWdyYXRpb249b24sIGJ1dCB0aGF0IG9w
dGlvbiBpcyBnZW5lcmFsbHkgbGVmdCBmb3IgdGVzdGluZw0KPj4+IHB1cnBvc2VzLg0KPj4+DQo+
Pj4gU28gc3RhcnRpbmcgd2l0aCBJT01NVSBkaXJ0eSB0cmFja2luZyBpdCBjYW4gdXNlIHRvIGFj
b21vZGF0ZSB0aGUgbGFjayBvZg0KPj4+IFZGIGRpcnR5IHBhZ2UgdHJhY2tpbmcgYWxsb3dpbmcg
dXMgdG8gbWluaW1pemUgdGhlIFZGIHJlcXVpcmVtZW50cyBmb3INCj4+PiBtaWdyYXRpb24gYW5k
IHRodXMgZW5hYmxpbmcgbWlncmF0aW9uIGJ5IGRlZmF1bHQgZm9yIHRob3NlIHRvby4NCj4+Pg0K
Pj4+IFNpZ25lZC1vZmYtYnk6IEpvYW8gTWFydGlucyA8am9hby5tLm1hcnRpbnNAb3JhY2xlLmNv
bT4NCj4+PiAtLS0NCj4+PiBody92ZmlvL21pZ3JhdGlvbi5jIHwgMyArKy0NCj4+PiAxIGZpbGUg
Y2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+Pj4NCj4+PiBkaWZmIC0t
Z2l0IGEvaHcvdmZpby9taWdyYXRpb24uYyBiL2h3L3ZmaW8vbWlncmF0aW9uLmMNCj4+PiBpbmRl
eCAzNGQ0YmUyY2UxYjEuLmNlM2QxYjZlOWEyNSAxMDA2NDQNCj4+PiAtLS0gYS9ody92ZmlvL21p
Z3JhdGlvbi5jDQo+Pj4gKysrIGIvaHcvdmZpby9taWdyYXRpb24uYw0KPj4+IEBAIC0xMDM2LDcg
KzEwMzYsOCBAQCBib29sIHZmaW9fbWlncmF0aW9uX3JlYWxpemUoVkZJT0RldmljZQ0KPj4+ICp2
YmFzZWRldiwgRXJyb3IgKiplcnJwKQ0KPj4+ICAgICAgICAgcmV0dXJuICF2ZmlvX2Jsb2NrX21p
Z3JhdGlvbih2YmFzZWRldiwgZXJyLCBlcnJwKTsNCj4+PiAgICAgfQ0KPj4+DQo+Pj4gLSAgICBp
ZiAoIXZiYXNlZGV2LT5kaXJ0eV9wYWdlc19zdXBwb3J0ZWQpIHsNCj4+PiArICAgIGlmICghdmJh
c2VkZXYtPmRpcnR5X3BhZ2VzX3N1cHBvcnRlZCAmJg0KPj4+ICsgICAgICAgICF2YmFzZWRldi0+
YmNvbnRhaW5lci0+ZGlydHlfcGFnZXNfc3VwcG9ydGVkKSB7DQo+Pj4gICAgICAgICBpZiAodmJh
c2VkZXYtPmVuYWJsZV9taWdyYXRpb24gPT0gT05fT0ZGX0FVVE9fQVVUTykgew0KPj4+ICAgICAg
ICAgICAgIGVycm9yX3NldGcoJmVyciwNCj4+PiAgICAgICAgICAgICAgICAgICAgICAgICIlczog
VkZJTyBkZXZpY2UgZG9lc24ndCBzdXBwb3J0IGRldmljZSBkaXJ0eSB0cmFja2luZyIsDQo+Pg0K
Pj4gSSdtIG5vdCBzdXJlIGlmIHRoaXMgbWVzc2FnZSBuZWVkcyB0byBiZSB1cGRhdGVkLCAiIFZG
SU8gZGV2aWNlIGRvZXNuJ3QNCj5zdXBwb3J0IGRldmljZSBhbmQgSU9NTVUgZGlydHkgdHJhY2tp
bmciDQo+Pg0KPj4gU2FtZSBmb3IgdGhlIGJlbG93Og0KPj4NCj4+IHdhcm5fcmVwb3J0KCIlczog
VkZJTyBkZXZpY2UgZG9lc24ndCBzdXBwb3J0IGRldmljZSBkaXJ0eSB0cmFja2luZyINCj4NCj4N
Cj5BaCB5ZXMsIGdvb2QgY2F0Y2guIEFkZGl0aW9uYWxseSBJIHRoaW5rIEkgc2hvdWxkIGNoZWNr
IGRldmljZSBod3B0IHJhdGhlcg0KPnRoYW4NCj5jb250YWluZXI6OmRpcnR5X3BhZ2VzX3N1cHBv
cnRlZCBpLmUuDQo+DQo+aWYgKCF2YmFzZWRldi0+ZGlydHlfcGFnZXNfc3VwcG9ydGVkICYmDQo+
ICAgICh2YmFzZWRldi0+aHdwdCAmJiAhaW9tbXVmZF9od3B0X2RpcnR5X3RyYWNraW5nKHZiYXNl
ZGV2LT5od3B0KSkpDQo+DQo+VGhpcyBtYWtlcyBzdXJlIHRoYXQgbWlncmF0aW9uIGlzIGJsb2Nr
ZWQgd2l0aCBtb3JlIGFjY3VyYWN5DQoNClllcywgdGhpcyBpcyBiZXR0ZXIuIExvb2tzIGJjb250
YWluZXItPmRpcnR5X3BhZ2VzX3N1cHBvcnRlZCBpcyBub3QgYXMgYWNjdXJhdGUgYXMgaW4gbGVn
YWN5IFZGSU8gZGF5cy4NCg0KVGhhbmtzDQpaaGVuemhvbmcNCg==

