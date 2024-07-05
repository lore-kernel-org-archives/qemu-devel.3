Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2228AC3271E
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2024 18:26:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPncP-0007vU-40; Fri, 05 Jul 2024 14:25:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongwon.kim@intel.com>)
 id 1sPncI-0007uz-U5
 for qemu-devel@nongnu.org; Fri, 05 Jul 2024 14:25:06 -0400
Received: from mgamail.intel.com ([192.198.163.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongwon.kim@intel.com>)
 id 1sPncG-0005YJ-Ek
 for qemu-devel@nongnu.org; Fri, 05 Jul 2024 14:25:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1720203905; x=1751739905;
 h=message-id:date:from:subject:to:cc:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=1EaVsW5uWxdcECWnmSyHSEb2vbSCqWtcriYn9L6D9s4=;
 b=KVOPDObxyogdd++l6jtIBJ9ZmMSq9/p/UdFpMIyS+TcIkvL26tams6DE
 F/jj175dmUgs0csIFzGhg76pxILUJJOaKKDGLgDflaEo/jUlp160127th
 HMpwqUL0B1+cSJO0ntCFQoPFtAu36ezs++QKtj/7mtVnoQDI8a9dmP7VO
 mytNIYe3y41hiukl+RGTrAF0aRWN4zVAa2nhpzCgk9bSOW41PHwA7qQeW
 DbFW9YL7RwH1xehj8Y938qPVOccNbaPFX9T2PlO2s3a07qoYLTHv+59mV
 rpUGuDVJpSVdiV92mJY9P8dlZmMFyL9rLIJOM1L4JVDN2n8hG2nk7KVYO w==;
X-CSE-ConnectionGUID: vFs2iOSNSmuAGu4F1NgfaQ==
X-CSE-MsgGUID: BEUxhUKkQz2AYdTdHQzETw==
X-IronPort-AV: E=McAfee;i="6700,10204,11123"; a="28172414"
X-IronPort-AV: E=Sophos;i="6.09,185,1716274800"; d="scan'208";a="28172414"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Jul 2024 11:25:02 -0700
X-CSE-ConnectionGUID: QXGdrJ5qSquOQ4hYUBYOXQ==
X-CSE-MsgGUID: j6v7oDM2SwGlYJf2+18V+A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,185,1716274800"; d="scan'208";a="51886492"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
 by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 05 Jul 2024 11:25:02 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 5 Jul 2024 11:25:01 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 5 Jul 2024 11:25:01 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 5 Jul 2024 11:25:01 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 5 Jul 2024 11:25:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XUGdu8I+9QTpMWiF6SzglbIIPybaUXPfb/hEmEV8vx5WLBYM9TXNJfDw1hRboe3yB5fggnx2L4S0v76z8PAr8erUiGbKhG/DEqHblZG+3nQRe2LIjP1UrtXADb/8ctGa+gup7VEHff3Uc4NN8qQBKR6sw/8nz3N2fpvmC0X9ogYq5W/tFrCe98ndPakVB2gMj4+s4u2zMFFT/Q3xWGoS9ZGgmEroFLAeZJup3mqSQX5ATZkitnore1om63uUw7TdgXHjCcqQKtaATKmm5CHDJnoVTxVNwYtZaX78x6/ao+cCMhHogGJSvE4C8XaVS1e8uQuD0b/+E5G1ScvxuRDVuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7QN8K7+rFC9oZ2t01G1cnAC1M4RPVYjyMKXfRc8ZbkE=;
 b=SeplTBAfA/IRbzLafFKa84DRHC+Yy1H9/MtmE4JBeseviuW3saKpct4U+kiGMxc2Jtlai0mmoH6dYEp24Vp8S+UOjO10dd9Eo/lbrHwCXQAlPbka8OcV3G0TO5ykBbZdXWi+lRc2VQpcaD1F3afqNUYTk6/2sKdgg/zexxELkA2xKJDZvF2s07DQuUMaTzKttCCtvjTU6ftCJiYZhWP18Zu7571lvxlbzgsZ4LhgMjSLaSsAtMwedfriArY4CNnl/ExvsGZi72SSaBRB1eqd5cTgTere8w5NFfz+G3Q+5BJuMyPgji6nSItYyYLrPdedOn25ek2rzD3UuGWYfE8+jA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB6879.namprd11.prod.outlook.com (2603:10b6:510:229::22)
 by IA1PR11MB7942.namprd11.prod.outlook.com (2603:10b6:208:3fa::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.29; Fri, 5 Jul
 2024 18:24:59 +0000
Received: from PH8PR11MB6879.namprd11.prod.outlook.com
 ([fe80::bd3d:59f2:9d29:346]) by PH8PR11MB6879.namprd11.prod.outlook.com
 ([fe80::bd3d:59f2:9d29:346%5]) with mapi id 15.20.7719.029; Fri, 5 Jul 2024
 18:24:58 +0000
Message-ID: <d238020b-af06-40fd-8063-6563ccb6309c@intel.com>
Date: Fri, 5 Jul 2024 11:24:55 -0700
User-Agent: Mozilla Thunderbird
From: "Kim, Dongwon" <dongwon.kim@intel.com>
Subject: Re: [RFC PATCH 0/4] hw/display/virtio-gpu: Introducing asynchronous
 guest display render
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@gmail.com>
CC: Gerd Hoffmann <kraxel@redhat.com>, <qemu-devel@nongnu.org>
References: <20240620231727.235841-1-dongwon.kim@intel.com>
 <CAJ+F1CKRau8FGHMv0aBb_ocitavCzivrzpB2YtfNa22N7uVsWw@mail.gmail.com>
 <71ea0f44-fea9-45ca-8ce0-064e8581c7cf@intel.com>
 <CAJ+F1C+QPJAf1KbZSySmQYd7CF07Gk2qU89nxajdy90QRs4v3A@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CAJ+F1C+QPJAf1KbZSySmQYd7CF07Gk2qU89nxajdy90QRs4v3A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR13CA0013.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::18) To PH8PR11MB6879.namprd11.prod.outlook.com
 (2603:10b6:510:229::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB6879:EE_|IA1PR11MB7942:EE_
X-MS-Office365-Filtering-Correlation-Id: 356abe6d-ec28-4152-fe1f-08dc9d1fc6f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZjQrNVVmUWdra3ExMFkySXE2aXp4S0NOdk9LV2NKSnhxeWRDZlpDOWNDc2p4?=
 =?utf-8?B?dTR1V3NlMEVGMUNkbm1JbUtUb1V2bVNNVzlrWldJZVFZbGxTcUN4b3MrMWVn?=
 =?utf-8?B?VklraEZjRkNvOGlvVXRscERaR3k0NE1iQThpdWlZRjlMVlhlS2FDbXprbWJJ?=
 =?utf-8?B?VGtTYVRKSUo3ZFRrMXpqMGlnMzFVZzVzQjF4T0ZFa21ZYjhzMXVzaWg3Q1p6?=
 =?utf-8?B?czNYNWlaTlZKUEhYZFV0QURsTUVVZU42MUNTdDlJOGhIY2toaEhlQUpRRlVL?=
 =?utf-8?B?YmNWalV2V28yM1lWbDI0YzZlY0lxWTdzNCtOaUxicDk0VzdvM2ZLQ2ovK2dO?=
 =?utf-8?B?MUo2bHEwSEJZc0ZVZzNpRmNacy9qVGIyNmRPYm41WnMxeW1VOEZDM2R2RzQx?=
 =?utf-8?B?eXBrZ3MyNy9MVWR3ajhXQkMvRE5hRXNsVVVSTmh4Q3huNktnNzJEYzJscnJ5?=
 =?utf-8?B?NVFta0M0TkdQT0JLem5vOTBuT0QwcTBpa092WE9nV2padTZsVE5ER25nK09V?=
 =?utf-8?B?Y2d5Tkprams2REhQT0VmUWxxQ2tpekIwWFB6cSt0MWtTT2d4c2RJRWI1VVBv?=
 =?utf-8?B?bG1OU21HYnVIbnFGU1E4NUgvSUJIWXA5TFZVVmFwek95WlQxQzhMZlgzYWFR?=
 =?utf-8?B?aGhENUllNXV6M01rSEN1d25BbnNtZUhueDJjR2hEVEZzd2I1Mmx1bTNJcFZ6?=
 =?utf-8?B?MXpsUzEwNVYxOTlkZEdaNnk3T1hjMFdNeVZwOWUrbVBoTzEwN1VLbk44b0sz?=
 =?utf-8?B?T1hiZWRoS0ZzMk82ZU82ZEJjcVNoRUd0ZE1mRmNSOU96Rk85NW5Sc1VQdlBp?=
 =?utf-8?B?VzRWcDJ3dkdlNDZicW9ucGpXMlRjMXV3Zlp4cStGbGg1WEtoVVA3c1pTRit1?=
 =?utf-8?B?YWlISXZoa1BvaFM0YWRFeDJNTnZsSllRcTRmWmU1eGs3Zkh6d3RHdFd0MUZq?=
 =?utf-8?B?eHBwQWQzMzd5UkQ0VTBremluWUkzNDFKWjV5LzVQMWY1SHJqUlRhQ3RrQ2w5?=
 =?utf-8?B?T1E2SkIxZEF2VXk5NVBCM25KeFlOdnFTQmY1aHRWa1NFRm5pSWhPTnpnZGJC?=
 =?utf-8?B?cm56NnRDNlB6ZjJLT0oyZi9TOWVMOEdIbDh2a3AvMDQ4NXYyaHpZMExDc0Qr?=
 =?utf-8?B?VGFyWmVqVlRzdWt4QU4rYlF3R2hqM2ZHVEVNNmUxTHkwanhibUw3OThMUDh4?=
 =?utf-8?B?bE10K2xXUWRwb1R5VUIvc1VLM1QwTDZ1MFFtZzhIYzN6am8wc0dsdVFsbE9B?=
 =?utf-8?B?U2hmZ1dxNGRhSWNraHNCakVjV0Z0NERGTVNNVnR4R0hzeGF5a1o4ajBpRC9E?=
 =?utf-8?B?akd5akI3UUIxTWtiK0dvWUZGRkM0K3JCRzBNVGxtaVJGejltTW8ySVl0aFJu?=
 =?utf-8?B?dVA3dGpML3ZhVFRKaFFPYzlDcTVQOEx5cjlPTXlJakFzbmtkQ1BOMXNMMm5C?=
 =?utf-8?B?dnU3bkFSQzhhcmswbmkwb0pnTXM0MXVuNmVuQ29Lc1JCRm5PbWdUYU9FWndY?=
 =?utf-8?B?TmJYV0s0dG04M3M3VWhiM0NqZzNIeXFwYlVvK3l6TXNuVzJOSHlMTGtGYlM1?=
 =?utf-8?B?TnM3dS8xRitKOUxnS0NldGNlRCtDK2V5Z0J4ckhvSjZvUU1GQlZiYWFkeTc3?=
 =?utf-8?B?MjVVYjFkbk9CVEpKQzNrdkVlaGpXNHMvUHIrMDBPOHdJMlJrQUdyK05JV3NI?=
 =?utf-8?B?SmtoQ1dkOVZMZng3aU5Wb0VRSEtkMkgxSGI5cFMwUXZFQVZ6V2NSRVo2dVFX?=
 =?utf-8?B?cVBUZWZzOVNSMmFES1hydVBWend6aXEzYVhRcUdmZ0YxSVhwOXdzT1BVR3RL?=
 =?utf-8?B?ZkhJNTJrOG9FMnBRV1NGQT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH8PR11MB6879.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bHRXdVlvZk9iR1o5bC9MTmJza0xidVdkQllLRS83RUZYWkg4MExoRUZNT0FK?=
 =?utf-8?B?bFJLeSsxT2tkVGVHQzJtTHBvYktRUWxEQWh4NENVd0I4TlNxTUFMTlIrbFdF?=
 =?utf-8?B?UjZhVWhRRXJvb1Y3Q3p6UmR0eCsybmtoT2dtd2ZVeUdVcTdDRHZKK1dHbTNT?=
 =?utf-8?B?R3JyVmxNWGRuSzNnQWVqWFBtUUIwbW1yOHpzQU9ZRy8vY1VxZFNEdzFKNmk4?=
 =?utf-8?B?RjhZYnhzWGlJaER0TmFtM0FBK0M2R0ZzNk9vZ1ZZVE5tQXc1NEx6RVlNZGFo?=
 =?utf-8?B?RUQ2WjhDa0JvTjY2VEVPSFpoejY4cldaV0dBcFZpQlhsaWNHMkJaSDJmL2p3?=
 =?utf-8?B?cWRPbFp0NndUSHhaSjFPald2M3ZyM2JLV2Y1OWxteXg0REdkR2RKaGM3ZEk3?=
 =?utf-8?B?SzZZVC9pdWsyM0dRYWxmbWtQcHlXOFFMVExXNDZBSmJRNWxJVGxPQm9qaEQy?=
 =?utf-8?B?bm5ETS9WcXZPS05qc3M5UjMvYjZIaG4vbXB6VDVFcFBNMkw0MGpkczQ3djB6?=
 =?utf-8?B?MjdocnhJQTN2LzdNNmhqa0ZUdmd5dWI1OURMbUhDakdhcjE1R0F3MUduYjAz?=
 =?utf-8?B?WW1nVk1XdW9idXRsR2UwaHJYZWdUaXZmQVRSNDIzcUlHWGcyNXErYVp1azBy?=
 =?utf-8?B?aDUrTWMrZmwzMm9sMUtkL3NFSW1JcmJ4djdQQ1dJdXJHckRMUk1BS0VZM0JZ?=
 =?utf-8?B?d28zMmtYRnZPNWZwcSs3TWNseVR5MzJFZUllQXFmZzdvcGFpb1poQ05rWkY1?=
 =?utf-8?B?dWV5NDdVYmFIdVpGRHE0UEJMMXVOQ0Jrc1JrNDBPaUpGK2JEMm9FcUo4MG9p?=
 =?utf-8?B?QWhRcTd2RHF6NEpvSmtJODQyY1c4VCtQM2xPcVpjeUxZUnJxZnJzelVSb2Vy?=
 =?utf-8?B?V3hqay9iSjNMSkJ1S3NHVElZVkpsdnpNWGU2cjN2U3VQVUlWdGI3cTZlSmJ1?=
 =?utf-8?B?OWlzZ3N5U0xxZXEvNGFHb2pKL3VKZFpnQVMzeTJBTDBQWlZlb2FnTUpEMjlt?=
 =?utf-8?B?dUE2aXgweENsVDZldUxYTmZYbWxMMXF5aDY5VXZ6NEQwck41T1ZCOWhuTDMy?=
 =?utf-8?B?N3piM1BJVk1HbUJRWU40ekV3M1lIUkxVMFNpenNjNVd1WFBjYndFT3R2NS94?=
 =?utf-8?B?dXBuK2xFV2thcVEzZ1dJZUczRUd6WDNMMWxuMERvQ3N2T2dWdVFyaFNmRUhR?=
 =?utf-8?B?OFVVN0JoalBWT2M1TmhQQVdoRzViTUNTMFVQVnp4MDVublpzZXN6Q1VTQjha?=
 =?utf-8?B?dmxGV041Q2NHNlZlSDBsT1BoM2J6bDdJRnZsb0NjZEhyQWlXQ2J6a3JXWDVO?=
 =?utf-8?B?Q0VtazBQTGhPWkZrR3ZGTFFzWmo0eVlQVDJHNHZLSGVMWFRUTTZRSjdZaVVL?=
 =?utf-8?B?K0M2VWdvSlJlMFMxT2dFMmhzQ2ZkZDZHdXFDb1lKOTF1QmlNMWtDN2JFRlp1?=
 =?utf-8?B?Slo4TzJ2dmttemxxbGh0d2lIcDdBWWw2OWw4R0duUVJXR3F3cHVGSTVkbE5v?=
 =?utf-8?B?TmVuSXRMN2FndlE2NVg1RldqTVJ3THM5TU44Rkk5N2ZiQXViMUdCVkUxQmo3?=
 =?utf-8?B?elEyZFhTM2Rhc041a1U4cDRlbVZjbmRkeFNRNXpqc2J6T3FndVpKMHNOekpk?=
 =?utf-8?B?bUFGUTFXdHJGZ0EzZmRuZHhaVFJuV09MTmZlYmp6QTgrSlhWeHN5VHR6VzJn?=
 =?utf-8?B?YkhXVTFhRDQ0WjJjQm4xWTFZd2hUSEs2NUkzdnNyRE5BVG9pMUxnMHRCNWY4?=
 =?utf-8?B?Qzg0anpXRzFVTWtzN2tqTStMdkJ0bm95akEyeEtxS0I1TlE3VysydmJoR1Z2?=
 =?utf-8?B?K085QVVuNlZIeGpmNVJTaVdaRmtHZ1dCQ0piQ0xVQkkyTVZ1WHZ4L1JZYVBE?=
 =?utf-8?B?M2svOUY5cmU2bVpjUDdPaGx5WXhIOERDdXVzYnRxenpIU3BYYVdNbGJzQzl5?=
 =?utf-8?B?ME1WY0kvTjR3TkxFR2l2M0IrcWlGbkVXVXZ4UDA5bzFwemhDUnh0TzFRbStR?=
 =?utf-8?B?WE1nOFRTWnNMM244Z3E3RFNDYk5EdXdvOGl1MjFxL00wT3d5bkNCVnM3Rm1a?=
 =?utf-8?B?a2Uwd3BJNG9zbURaQUVZVnNTUVFwTkRKQVM3Q2Y2dDVvQlczak5SN04yUVNQ?=
 =?utf-8?Q?JtwlDi16XiJ9mum8KaCUiJPJi?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 356abe6d-ec28-4152-fe1f-08dc9d1fc6f1
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6879.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2024 18:24:58.8426 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DCMSg3dO7bTcB4LUurmABLpy75NzQqX3cVC+d8k9RjuBSodftnBJi1PE3RcRweltJoFGVO5JSC+Gb2GqgBMYLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7942
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.9; envelope-from=dongwon.kim@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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

On 7/2/2024 11:26 PM, Marc-André Lureau wrote:
> Hi
> 
> On Tue, Jul 2, 2024 at 10:11 PM Kim, Dongwon <dongwon.kim@intel.com 
> <mailto:dongwon.kim@intel.com>> wrote:
> 
>     Hi Marc-André,
> 
>     On 7/2/2024 3:29 AM, Marc-André Lureau wrote:
>      > Hi
>      >
>      > On Fri, Jun 21, 2024 at 3:20 AM <dongwon.kim@intel.com
>     <mailto:dongwon.kim@intel.com>
>      > <mailto:dongwon.kim@intel.com <mailto:dongwon.kim@intel.com>>> wrote:
>      >
>      >     From: Dongwon Kim <dongwon.kim@intel.com
>     <mailto:dongwon.kim@intel.com> <mailto:dongwon.kim@intel.com
>     <mailto:dongwon.kim@intel.com>>>
>      >
>      >     Introducing new virtio-gpu param, 'render_sync' when guest
>     scanout blob
>      >     is used (blob=true). The new param is used to specify when to
>     start
>      >     rendering a guest scanout frame.
>      >
>      >     By default (and so far) rendering of the guest frame is
>     started in
>      >     the draw event to make sure guest display update is
>     sychronized with
>      >     host's vsync. But this method inevitably brings some extra
>     wait because
>      >     most of time, the draw event is not happening right after the
>     guest
>      >     scanout frame is flushed.
>      >
>      >
>      >     This delay often makes the guest stuck at certain frame for
>     too long and
>      >     causes general performance degradation of graphic workloads
>     on the
>      >     guest's
>      >     side especially when the display update rate is high. This
>     unwanted perf
>      >     drop can be reduced if the guest scanout frame is rendered as
>     soon
>      >     as it is
>      >     flushed through 'VIRTIO_GPU_CMD_RESOURCE_FLUSH' msg. The gl
>     display
>      >     pipeline can be unblocked a lot earlier in this case so that
>     guest can
>      >     move to the next display frame right away.
>      >
>      >     However, this "asynchrounous" render mode may cause some waste of
>      >     resources
>      >     as the guest could produce more frames than what are actually
>     displayed
>      >     on the host display. This is similar as running rendering
>     apps with
>      >     no vblank
>      >     or vsync option. This is why this feature should stay as
>     optional.
>      >
>      >
>      > Indeed, I don't see much point in doing so, it's pure waste. If
>     you want
>      > to benchmark something perhaps. But then, why not simply run a
>     benchmark
>      > offscreen?
> 
>     Benchmark score is not the primary reason. The problem we want to avoid
>     is the laggy display update due to too many asynchronous plane updates
>     happening in the guest in certain situations like when moving SW mouse
>     cursor rigorously on the guest. This is because the fence (as well as
>     response for the resource-flush cmd) is signaled in the draw event.
> 
> 
> Presumably, you won't get more frames displayed (perhaps even less due 
> to extra load), so why is it laggy? Is it because the guest is doing too 
> much buffering? 

Yes, I believe so. Virtio-gpu driver can't issue another resource flush 
as the previous frame is still on hold by the host. But there are many 
plane-update requests due to frame buffer updates because of the 
movement of SW mouse cursor in between. BTW, we currently use dirtyFB 
update on the guest running Xorg. Maybe using pageflip would make things 
better but we haven't tried it yet.

Because the mouse event queue isn't being drained
> between scanouts?



> 
>      >
>      >
>      >     The param 'render_sync' is set to 'true' by default and this
>     is in line
>      >     with traditional way while setting it to 'false' is basically
>     enabling
>      >     this asynchronouse mode.
>      >
>      >
>      > As it stands now, the option should actually be on the display
>     backend
>      > (gtk/gtk-egl), it's not implemented for other backends.
> 
>     We can help to deploy this concept to other backends if needed.
> 
> 
> Why not make it a gtk display option instead?

That is possible but I made it virtio-gpu option as this is specific to 
virtio-gpu backend. We can consider moving it to gtk layer if it makes 
more sense.

> 
> 
>      >
>      > I am not convinced this is generally useful to be an extra option
>     though.
> 
>     I initially thought this should be the default because the virtio-gpu
>     guest should not be hold by the host for too long in any cases. And
>     this
>     new approach is comparable to the default mode with blob=false where
>     the
>     guest is released as soon as the resource flush is done. Only
>     difference
>     is the resource synchronization using the fence.
> 
> 
> virgl should be blocking rendering too
> 
> Could you detail your testing setup ?

We use ubuntu linux as a guest OS but it's modified for our GFX SRIOV
setup. I am not sure if this is the details you are looking for but here 
is it: we virtualize our GPU using SRIOV. So individual linux guest have 
their dedicated portion of GPU device that is detected and worked as 
"render-only" device. And since it is render-only, we pair it with 
virtio-gpu device/driver that provides display feature. Scanouts on the 
guest are allocated by virtio-gpu then imported by Mesa driver then used 
as a main framebuffer. On every plane update done by compositor will get
virtio-gpu driver to issue resource-flush (followed by set scanout) to 
host. Host (QEMU) gets this scanout data as blob (scatter-gather list) 
then creates its own dmabuf using udmabuf driver. At every resource 
flush, we block the render pipeline as well as the guest until the 
rendering if finished for scanout synchronization as you know.

We do not use virgl (instead, the normal HW driver for SRIOV-Virtual 
device is used).

So this idea of having render_sync=false is based on

1. glBlitFrameBuffer can be done anytime after resource-flush is received.
2. the guest can be unblocked whenever the blob is used (cloned by 
glBlitFrameBuffer).

> 
> thanks
> 
> 
>      >
>      >     Dongwon Kim (4):
>      >        hw/display/virtio-gpu: Introducing render_sync param
>      >        ui/egl-helpers: Consolidates create-sync and create-fence
>      >        ui/gtk-egl: Start rendering of guest blob scanout if
>     render_sync is
>      >          off
>      >        ui/gtk-gl-draw: Start rendering of guest blob scanout if
>     render_sync
>      >          is off
>      >
>      >       include/hw/virtio/virtio-gpu.h  |  3 ++
>      >       include/ui/dmabuf.h             |  4 +-
>      >       include/ui/egl-helpers.h        |  3 +-
>      >       hw/display/vhost-user-gpu.c     |  3 +-
>      >       hw/display/virtio-gpu-udmabuf.c |  3 +-
>      >       hw/display/virtio-gpu.c         |  2 +
>      >       hw/vfio/display.c               |  3 +-
>      >       ui/dbus-listener.c              |  2 +-
>      >       ui/dmabuf.c                     | 11 +++-
>      >       ui/egl-helpers.c                | 27 ++++------
>      >       ui/gtk-egl.c                    | 93
>     ++++++++++++++++++---------------
>      >       ui/gtk-gl-area.c                | 90
>     +++++++++++++++++++------------
>      >       12 files changed, 146 insertions(+), 98 deletions(-)
>      >
>      >     --
>      >     2.34.1
>      >
>      >
>      >
>      >
>      > --
>      > Marc-André Lureau
> 
> 
> 
> -- 
> Marc-André Lureau


