Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 645A7CED62A
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2024 08:14:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1syRoe-0006b3-Gh; Wed, 09 Oct 2024 04:13:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.gao@intel.com>)
 id 1syRob-0006ab-SS
 for qemu-devel@nongnu.org; Wed, 09 Oct 2024 04:13:02 -0400
Received: from mgamail.intel.com ([198.175.65.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.gao@intel.com>)
 id 1syRoY-0006K6-0w
 for qemu-devel@nongnu.org; Wed, 09 Oct 2024 04:13:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1728461578; x=1759997578;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=1GtrOjr/NcE1F2yUSx/sOCpUTAWyalnejB2scRUKGy8=;
 b=NPb9cTrSmeVtjtQ2B/eRF2wJmgMkJOyyd8z/IDku2CSkFf9fg/H2qZmR
 kwwgAHRhhQl/GQaTCNqXIYPsjYrHZctDZJFCWLYfTEC7a4MgNbOjzpJ/d
 GEVQwmSJDrirXtWrDl8+YtJRIUYa8tCcjH+KJ0IJpUckbn/ExdNIcvwVv
 cctTXAnMS5kQqQvYABmrPNe8WnO4UVfAY94d1PgZSM68zuF+17EV4wsA1
 4KgWi1v5QTV3AuAH/lmjxTHOhLvjn5gHJCjsouhsQ48MJxpPXiGx8oi+6
 Vx+5etoONa4V4rRwZRUFfuKJMDUbMayY/xf/bYyAUxhV9tw3DrIEAjelD A==;
X-CSE-ConnectionGUID: FTKenkwXThK22nMYk04opA==
X-CSE-MsgGUID: ec8spS4BTOCsCRBAgILdyA==
X-IronPort-AV: E=McAfee;i="6700,10204,11219"; a="31445393"
X-IronPort-AV: E=Sophos;i="6.11,189,1725346800"; d="scan'208";a="31445393"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Oct 2024 01:12:52 -0700
X-CSE-ConnectionGUID: u7EqvlTtSai8si66NQQIUQ==
X-CSE-MsgGUID: jiL+lR7ySpmWxGsk4EHUdw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,189,1725346800"; d="scan'208";a="76487406"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
 by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 09 Oct 2024 01:12:51 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 9 Oct 2024 01:12:51 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 9 Oct 2024 01:12:51 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 9 Oct 2024 01:12:51 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.170)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 9 Oct 2024 01:12:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wGx3Qa8f9zn6lE35lLNRhxWtZa/HY9kiPU3DvhfH31/p9g4OVWgqDnh4K89EDHEwcKZ8UHob13o1Ds3HiaoKYQmEwhV7G5uzM26yAgqXexk/M+WKz5iy3vrxmdPcs3ZJFzvkAjDS94opg31oGoPacPvRYRfNofu1AsRaFwUvgT27gynVJ8LAfhkBO1X/xH/hz9enMMRokGixOidVBviwRYUGMGQqlVXyL6oo5O5JjFIQ97NXChp7IWqNF+cpMTjtGR4qLXmPxLeJuYiiMWwXoVACQW2Ode+Ip77U9pB6a3/p1Dmun065DGGdMDd6qKbcW3rM0S2wrfERsdwVX1jFhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=chCJo+kRnOCXDk7zPIQVoF09vtLc1XlOvOYmZVNm+co=;
 b=snIRK5Y25zrSKwA0MaOVGSLuDF5CQ9bb/GYfoiC0GdXwpGDMcNArpilfTuRnCppcGlrYxe/qjIku/ghX97jBCIf1l0sh5rHGQWPuQGcN+lx6nc/ZXvy6Eu2SX6YvN5h3Ei0skEL1Z7pNHYF9mocuBprHgLx4/56dRl/UeaAsbS1C/HeL4ka1pI1lpjSTWgsv0Y+B7/rHYKvq0OMEfz1t50pjDCPJmvkqwy+mIThyl+xSOa0jmfjWQ5R9ywikPmjBiE8faODOYR6pFQAoaRs1T2HTk59Gwoy4pbOxu9UglRZkkKAwoP4gXtfBhGBK5KkGV2HaGMxpXCAhPhgvVTaqFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CH3PR11MB8660.namprd11.prod.outlook.com (2603:10b6:610:1ce::13)
 by PH8PR11MB6683.namprd11.prod.outlook.com (2603:10b6:510:1c6::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.16; Wed, 9 Oct
 2024 08:12:48 +0000
Received: from CH3PR11MB8660.namprd11.prod.outlook.com
 ([fe80::cfad:add4:daad:fb9b]) by CH3PR11MB8660.namprd11.prod.outlook.com
 ([fe80::cfad:add4:daad:fb9b%4]) with mapi id 15.20.8048.013; Wed, 9 Oct 2024
 08:12:48 +0000
Date: Wed, 9 Oct 2024 16:12:38 +0800
From: Chao Gao <chao.gao@intel.com>
To: Zhao Liu <zhao1.liu@intel.com>
CC: <qemu-devel@nongnu.org>, <pbonzini@redhat.com>, <jmattson@google.com>,
 <pawan.kumar.gupta@linux.intel.com>, <jon@nutanix.com>, <kvm@vger.kernel.org>
Subject: Re: [PATCH] target/i386: Add more features enumerated by CPUID.7.2.EDX
Message-ID: <ZwY69phzk3GpGvsh@intel.com>
References: <20240919051011.118309-1-chao.gao@intel.com>
 <ZwY1AeJPlrniISB1@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZwY1AeJPlrniISB1@intel.com>
X-ClientProxiedBy: SG2PR04CA0200.apcprd04.prod.outlook.com
 (2603:1096:4:187::15) To CH3PR11MB8660.namprd11.prod.outlook.com
 (2603:10b6:610:1ce::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR11MB8660:EE_|PH8PR11MB6683:EE_
X-MS-Office365-Filtering-Correlation-Id: effffcee-7495-448b-6cb0-08dce83a2959
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?rgIzEOrijCGm8ZBJsOG0MbcPaq95jIUTf62YHJKNnEe95mhSHFDmtT80TfjT?=
 =?us-ascii?Q?k5hQ7Hhtd2zRuUFvU2RlOWdPoIyLSdE07HV3gWdww1Ti7+pycgX5ipUHKzrp?=
 =?us-ascii?Q?ZtWh3LexEPfxTGGMiasP7JiEcUJcbCRFYvOxruGXvFA2Yoh4glqABELLQRXy?=
 =?us-ascii?Q?CnBU9fXc4Mnh4L2t5rcN2Sy2YGrt7dSWCl6PBUkQao0r600q119h6ucUWiJr?=
 =?us-ascii?Q?R0TmIW6dWpYBQSFfOPpTl4HTU27Ebtf+7EiMWva5rk1R5nl4fxyRR1E65YQV?=
 =?us-ascii?Q?mwGxLTFFdMQHBDzu/dpF/0WwEjIVQBUSfvz2Jmj1oghGf3nK41ecLXSlRmFp?=
 =?us-ascii?Q?vU/K5n8pfVCKZmym/qMj3kBsnaw0AEQ4T6qYGVHblE3vFVyN4XiDZ+6GTb3h?=
 =?us-ascii?Q?wX9G+RdKyPIOKzQhpt3dlw2FvROMWxOagQfHko8YCnAKIc+49N7xDA8urzbT?=
 =?us-ascii?Q?PTtXDJ5esD8W3v2ahYfBiAPdF7jc97yqtuu5sW/bx+bMpDUARpfqNjvtYxDH?=
 =?us-ascii?Q?YcW7FGTUNCJogKNm/7sJb/1WkkJOeDZd9UXzavYbUtp6o4LarVrEIkJk5Uqj?=
 =?us-ascii?Q?tFAsevr++1iw/gTWd8JW7EuDU6MWPxIpAst4PNAI+n5hCELQBlWkrTnDUKV3?=
 =?us-ascii?Q?qaEcb4FUOu+aVpgKBl9jVXRSTVttp531r8bvXOs27rq/sQfpDybOC+2WQKNR?=
 =?us-ascii?Q?YOx9Ofd2zg5AWGmhiV8AbCL6wlG0oMEKnRmXVmrxcwm1tTtYLmZ7jRKdkUNo?=
 =?us-ascii?Q?H4uyJDsdvZdfn/cbtrRkWKEZjPWXSUm610hzTOoi1qjarW3ViUfoTmbcRnvA?=
 =?us-ascii?Q?KtaN7xbbsdX81sgq3OpGiYhMJcbYpaUipiL+XbI9ZWDRx6OdlyqZWiysfIHB?=
 =?us-ascii?Q?A7bOrJF4tAhZDsqr2MBtzzPTf5FGYEsVZrQxU3l+HdO3TleyJ3s6B5q6apf8?=
 =?us-ascii?Q?JJYxALEw0ftadYG7ugVex2UaoKlW1a7QaKIxL3LmsM3aaO+yBqfs7VhDyhmO?=
 =?us-ascii?Q?yOl7zH2Z4xu33wHF5rJX2yQPy0oP4XXCzK52r5xJmNLspq5TyG/fY4u4XPya?=
 =?us-ascii?Q?mz6T8aKFzcEcUxoBphHzoP82tqy1K83eTBSkVb6xBr01iFfbjo34iXUttVEh?=
 =?us-ascii?Q?ID1+FatMaMzEzzhYy6hdlySK6rgzNt2z0rBNPPmLQPL/1IrLQr04vr3sPwEG?=
 =?us-ascii?Q?OZ3bah3unHPvRkwsN86bPth02B/TykJpdTG3izoye/RFkPfcU+BwQZ1T7ohb?=
 =?us-ascii?Q?/DhwldepbILYvCkqnmk8VBYaG59x6Soh2WfGXBgcNQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR11MB8660.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mA0PwlHpOVWkrCoP06yJeG7Za4RBwI6a5v3/gW0TQKnP+pgXGJFqUNlZVByg?=
 =?us-ascii?Q?v8xVAzrPcSrn7mwB/5FCkRW7MKHg4+PjeIF9crZy49tssc9iEA5dNmvc3bSW?=
 =?us-ascii?Q?NoMx53jRV3owY/qYeYAake5c+JdFATWpmRpTGShjcPxMGa+plYIXv+dcKW/O?=
 =?us-ascii?Q?Kb9jS5/QeTrL2uYyhMAO5v1FBiVStVAMuoU4O+E5cXQfas5bYpN7AiPaSU60?=
 =?us-ascii?Q?G7bGkEOzWSYdAUhZNQ1VliMdFQXkbXd9qtMgt8znJSsIj6iuwy/1n9L1qbgv?=
 =?us-ascii?Q?Aj276WXYWgnZI0EZgIPcnuluaG5LEBXOZTVZNSEhCK6ACJ/+VMo5ijlcWess?=
 =?us-ascii?Q?NG5XNhkL9G0I8hblwBCS88z4lsVHgeBwnfDYIxJF7CPHW2ziBsAfFqPnyDiL?=
 =?us-ascii?Q?WzqtZbQNMgKShJw94SEwlYJyBpoBjoZ5H989orQ+hd61clwsX5VLMW0Oy9Jn?=
 =?us-ascii?Q?spfWzwpDU/Gb29kqXXi8/Vz4bjBPiQCHnfjzRpq7nYdv5BvKqabdGZOaz1/s?=
 =?us-ascii?Q?I4pghHXL3+Fx0NfwbcWcEhuxYi/yUFkRlTIstbeFjuPT2dJkcQzSpwaFeq6x?=
 =?us-ascii?Q?3Pz0CwE+U2zHI4WstHsVoD4O7TDQ1dmlp2A/Bl1KHU5ytC+DJwvRICdIGYFv?=
 =?us-ascii?Q?k+eJtM0i8T79G2jynO0v+SbO4BjU6ZN0WL/TIbjrVJMwDvIsOq3rP7rgb901?=
 =?us-ascii?Q?aTuxAtyMeYFEC0w3D+as1ji6f+aYULlOA5SaDz6X1fhOtanHPV7+CTJ3K0wT?=
 =?us-ascii?Q?aldRoMk96fSRG5OE1umzxGynBT3grvxVYtSqEduWtnu5WuqONJAYAwY6zeNc?=
 =?us-ascii?Q?3rhCwxzVcPSFF+yxogPS2Mky95AVwUWQzbwBf+TqDyt08uCdvV0X930DVwRx?=
 =?us-ascii?Q?j1nxbiMuqieJqu0MrUnBLuqjMIB/a+fatv/6RpnWj0sMllJWeTIQ/1842MmQ?=
 =?us-ascii?Q?0QwRSdErmlzXMpXBarMpzTqxsl4V4hgvFNm+nb7OmxDsD8BetMAkR9BXE2xI?=
 =?us-ascii?Q?zs4mQz0Xt9UxTvYFk9xrz5sWF/JyGZAWDsC2bBoWpzm6GsYu64eIGdDC7VUm?=
 =?us-ascii?Q?O15CsQITzDo9p0fTm9GM7EuSwgz59wG8386+PIFKjoGDd9M2bKaLrKvOEWpT?=
 =?us-ascii?Q?63/8CQ5N48neT5EtZdW32YfQL/kyACgMer8KgVOIr4OA6NxENqRvB8Kfb9+w?=
 =?us-ascii?Q?8/CFlL0yaec+lz3Ud/Wak74dowIT0bN9NFQMxA9qQXd+YOutI42QxMs4XKla?=
 =?us-ascii?Q?J82CxHoxN9I84hyU622QSsk4xW+56eKGIyq8ks0kAtSq7hn3HkuJRMTWFTqT?=
 =?us-ascii?Q?8zWMTlGsIFWAC3I6AtJ7llB5RvyiMP84m30n2FW+cnMvwBCwY7Wusnq++pAy?=
 =?us-ascii?Q?YCBu5gnZP5OQ4R0qO47KNqQVTrbmFyWnyqvdY/uM7/BldW8gsR4ZfgCRQlqr?=
 =?us-ascii?Q?sx3zTeAn+IChWkm6vu8n1CWXI6tKdrFiVBWUjgaQgu0KkpvEq76Aq7ofFM3J?=
 =?us-ascii?Q?76Cph0oYQbTuMAKbPqZY9xMq311qaR22jzFoa0eyTGgNENByJM/aQ6Z83BjM?=
 =?us-ascii?Q?0LIqxVESzrzdHgp36T+WgzqXHpamGv0IULsIaPLO?=
X-MS-Exchange-CrossTenant-Network-Message-Id: effffcee-7495-448b-6cb0-08dce83a2959
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB8660.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2024 08:12:48.0505 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GlNfEzbsZi8jLe0blUGmUle1bLvvjkAcHjUg0HCN4JuryNO6j51j5mEVj27WJHWPa21aP+u5MYY9UUxlgpyG3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6683
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.15; envelope-from=chao.gao@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.151,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

>> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
>> index 85ef7452c0..18ba958f46 100644
>> --- a/target/i386/cpu.c
>> +++ b/target/i386/cpu.c
>> @@ -1148,8 +1148,8 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
>>      [FEAT_7_2_EDX] = {
>>          .type = CPUID_FEATURE_WORD,
>>          .feat_names = {
>> -            NULL, NULL, NULL, NULL,
>> -            NULL, "mcdt-no", NULL, NULL,
>> +            "intel-psfd", "ipred-ctrl", "rrsba-ctrl", "ddpd-u",
>> +            "bhi-ctrl", "mcdt-no", NULL, NULL,
>
>IIUC, these bits depend on "spec-ctrl", which indicates the presence of
>IA32_SPEC_CTRL.
>
>Then I think we'd better add dependencies in feature_dependencies[].

(+ kvm mailing list)

Thanks for pointing that out. It seems that any of these bits imply the
presence of IA32_SPEC_CTRL. According to SDM vol4, chapter 2, table 2.2,
the 'Comment' column for the IA32_SPEC_CTRL MSR states:

  If any one of the enumeration conditions for defined bit field positions holds.

So, it might be more appropriate to fix KVM's handling of the
IA32_SPEC_CTRL MSR (i.e., guest_has_spec_ctrl_msr()).

what do you think?

>
>-Zhao
>
>>              NULL, NULL, NULL, NULL,
>>              NULL, NULL, NULL, NULL,
>>              NULL, NULL, NULL, NULL,
>> -- 
>> 2.46.1
>> 
>> 

