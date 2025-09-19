Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A95A8CA1013
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Sep 2025 02:18:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uzQga-0007SM-Rt; Thu, 18 Sep 2025 22:17:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uzQgX-0007S5-0H
 for qemu-devel@nongnu.org; Thu, 18 Sep 2025 22:17:18 -0400
Received: from mgamail.intel.com ([198.175.65.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uzQgT-0002Og-Ch
 for qemu-devel@nongnu.org; Thu, 18 Sep 2025 22:17:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1758248234; x=1789784234;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=FA6tVQRUKSv+9CdWtrXi84FORLPW9ALXE/33v8pvcIU=;
 b=bb/BixZBa24uF8aDPLWuC2KDUxwCNY91gMA6jDZVi1etBCllB3i/0Qwp
 ImZj3hrRYznClkqIwauIzmEPNlRg9LOExsaT2mzpzZRnMe04Que/UMDpT
 DWHUdfSG9FxinxjTO2z1S9Ii/NCILmCl8tvJufBBJPyGlDxRmn42NWLPT
 S2MyvVjF/JFNyFOfHVXzNcj1ZHKzWaFO/IYstuYhXjxefJzX3f2mBwNvV
 CadoUbTVddduV+IX8YwPkbyh2+8ae0AY0aaOlWfrFUKz98fWRLhPTMt5Z
 ZOlLnP1ABRxYsUEdi8wAvMXa4a3OGsGWXK+m19ZvJEsc9cbgqSetelfcL A==;
X-CSE-ConnectionGUID: Yw3JCtXiSl2dhqH+CHo1vQ==
X-CSE-MsgGUID: 02lKmZEOT7qAkufjksZMKA==
X-IronPort-AV: E=McAfee;i="6800,10657,11557"; a="64229003"
X-IronPort-AV: E=Sophos;i="6.18,276,1751266800"; d="scan'208";a="64229003"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Sep 2025 19:17:09 -0700
X-CSE-ConnectionGUID: fy2yg1MmQNilH96tAv//kg==
X-CSE-MsgGUID: 5xtpboicRYGKVwFv6vfzlg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,276,1751266800"; d="scan'208";a="175261623"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Sep 2025 19:17:07 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 18 Sep 2025 19:17:06 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Thu, 18 Sep 2025 19:17:06 -0700
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.56) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 18 Sep 2025 19:17:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xBbOMlB6hiDZW4aP50kqgTG7n8Q6pvMCp6L2hkeLWY3BMETqB4RtRCxCXdP86pnCngDIFEErlDECUw2Vyg4DGrlK7ay9iTJz1PBVQDcAsUdROpBIlWoLWSA2swCvu/2QWDL4vNYpv9SexXq/qo360pkuJ1PFfyjOcbtwFcjK7FGOshuU2i3SttTeRj6RTfju792ZjiFHME0kFfc5ZhMf9KRED+oxTt0Dhxc8UbiDJB81HExbB6spu1tnm5ZrzsyPgmdBsKVCt000o0SD1bq/OiFgKzpDqfpVrQfE7OykTQLErJz2Y8JHpMYVaBmGZa2vl+xMz46d5FmY3vO34YcriA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FA6tVQRUKSv+9CdWtrXi84FORLPW9ALXE/33v8pvcIU=;
 b=xAhfDY0mDdwnDlGuTOCF/r9vciic44n9zwk0npxQklPyG2ZGWKMDKau13FWwS8JbVZXz0AFy8md/tjOifwgEZNh0RgCCcehUhKyxhj2bH7O0med2aNQ3iMITR6lS+tmHIE7X7tlfr778GhAVit47dc+Oxp5nv02qOGxN+lSg8U7AVPJ++D2WFSIlUpcxeDg9IVy1t5HsY45SIccx9Kkktasz3gmcg5FZWp82/eUwzWqdkTyhLJOJksVgjYehKxt7Lfadw9ns5ARe/C6+wXWeTo4a2+Zw/qaTaiAUJ5cd0Ko/ypzk5bNKXTRnzXwCI7ACpb+KhU6Ixkx+DrWq0rLKtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9136.namprd11.prod.outlook.com (2603:10b6:208:574::12)
 by IA4PR11MB9033.namprd11.prod.outlook.com (2603:10b6:208:566::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.19; Fri, 19 Sep
 2025 02:17:04 +0000
Received: from IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13]) by IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13%4]) with mapi id 15.20.9115.020; Fri, 19 Sep 2025
 02:17:04 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>, "mst@redhat.com"
 <mst@redhat.com>, "jasowang@redhat.com" <jasowang@redhat.com>,
 "peterx@redhat.com" <peterx@redhat.com>, "ddutile@redhat.com"
 <ddutile@redhat.com>, "jgg@nvidia.com" <jgg@nvidia.com>,
 "nicolinc@nvidia.com" <nicolinc@nvidia.com>, "skolothumtho@nvidia.com"
 <skolothumtho@nvidia.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "clement.mathieu--drif@eviden.com"
 <clement.mathieu--drif@eviden.com>, "Tian, Kevin" <kevin.tian@intel.com>,
 "Liu, Yi L" <yi.l.liu@intel.com>, "Peng, Chao P" <chao.p.peng@intel.com>
Subject: RE: [PATCH v6 22/22] docs/devel: Add IOMMUFD nesting documentation
Thread-Topic: [PATCH v6 22/22] docs/devel: Add IOMMUFD nesting documentation
Thread-Index: AQHcKHqiTAsGmw87aUirJFDgggci1rSYtRqAgAEQJQA=
Date: Fri, 19 Sep 2025 02:17:04 +0000
Message-ID: <IA3PR11MB9136B479E919DBFFE1EEA68E9211A@IA3PR11MB9136.namprd11.prod.outlook.com>
References: <20250918085803.796942-1-zhenzhong.duan@intel.com>
 <20250918085803.796942-23-zhenzhong.duan@intel.com>
 <4302fa85-9cd1-4eee-9577-19eaa736c639@redhat.com>
In-Reply-To: <4302fa85-9cd1-4eee-9577-19eaa736c639@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9136:EE_|IA4PR11MB9033:EE_
x-ms-office365-filtering-correlation-id: d71e9226-52b9-4990-33f0-08ddf722a007
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|7416014|376014|38070700021; 
x-microsoft-antispam-message-info: =?utf-8?B?U1ZUQkFCeVNTSjZOeVNQZjdnS0FVV1ZZbHlHM3J1cEZIYTRzMGFhekJTN2dN?=
 =?utf-8?B?Y1VZVWRKbmFhVk1LWVY4dUwxYXZSU1k2eCtoeVJPU0V4KzVVOGNCRCtzYklU?=
 =?utf-8?B?Nnpzc1I5dUQzbzZWVXdTb2hzemp4akt6by9mNlJyMmJVc0xENWE5ZFI0bU1t?=
 =?utf-8?B?amk0RDBtN2w2ZFNiWDNJQlFHSjZ3NENZdDdoTElOLzJRSGp2VVdQTFYzNXU0?=
 =?utf-8?B?SmFPNXhGb0wvY2tsTjNUVk9WOE8xTHBJZjZwRkl4dXdkUzY3L1BEWXhrUHg3?=
 =?utf-8?B?RjcyT05Ja1dkdFpxMUtncXdlTytWWkQ0Z0VjT0ZxWWY4T3JOVXF1ai94ZVhv?=
 =?utf-8?B?U3pucmJjaUpRQXdNb0ZlT1BmRHFQNk9UNFN0RnZuUndwaUNCVndoakY0VUdm?=
 =?utf-8?B?cHQwWnErRFg0bUpKSGh0Wm1mWU54YUFhRk5qYWd2YkN1SUYxYUo5alpKKzRa?=
 =?utf-8?B?VUFCWDRibDJyWkZaNklVeVJCY05CWXF4MEYwMzIrODJHOWFKcmdXempnNDRD?=
 =?utf-8?B?Tk45QlNSZURWc0M2MnVwZEJueUhqN0tkZjlIY0hDSHJPRXpScHFneXlBT1hN?=
 =?utf-8?B?Y0lUMUtmNWFTMGJRN0lZZU1kRjB3V1NWZGF5VGJSdVZmQlJpbU5YSU9UdmxS?=
 =?utf-8?B?cThYUDVVaElHVnJRekJQeXAxU1NKZ2ZNOVMyYXprSEZrTnlQT1FUajh3U0hV?=
 =?utf-8?B?VWp2YWNjbk5ScFZsOWthbVFnZmd5dXdoeG1xWjg0bmxySm5lZ2pJUGFGMmtk?=
 =?utf-8?B?OUZCd1ZISnRLTVBhZG9hNzhsUndnM2ppNDJURU5IcnJHa0VNSy9UOEVMSm1J?=
 =?utf-8?B?UWxocGlOb0NqMjBQanlNaytjZk5rakNKQnJUU0VGOUhYbDViZWlrQ1QzQ1Iv?=
 =?utf-8?B?eWdNdzhtNys0OFJ5TU9nTnIwOE1VaFBEQndOT1F4YTBQblltVXVlckZKQWh1?=
 =?utf-8?B?MDROamN2KzFhb28wemRhbVBrWWVRZGhrWG1JMEFjK2E5ejRpcTFuL1BqeWQv?=
 =?utf-8?B?K1dTMXlpcFlHZzhwUW1MMXZUa0F1T1V6YzNlaHF5NHI4L3NIUXh2WmgwcUxr?=
 =?utf-8?B?djN0RFFMZXJFeDRLQVZxM1E0dElEcWNCTHU1UnYzSm8xZmp1WWx1UG9kOEx3?=
 =?utf-8?B?TzFkSjhGZWFITndyQVhIYmpyRmJVS05nZ01YL3M3aVQ0d2xwRDdNYVppa1pw?=
 =?utf-8?B?TkZaZVNPcDFRb2diZUdRd1lKeCtZRHgvT3hBUU1pQi8wRlR0dFhIa00wTlBm?=
 =?utf-8?B?Y09GaDlLK2EvTmxYejhnaUQ5Qy84SndsZGxkaWs2T3o2NzYvWDdjaHQ4dnJ4?=
 =?utf-8?B?YkNRMTlpRGkzc1JIanFiSFFCajJaVG9Qck5XOHRzU1BNTEVqTUlOYk1MQjdn?=
 =?utf-8?B?cFJPUTBkNUJIVjhlMDB5Nk1PT2xXU0wrZTljOTJ5M1BzL2RBNElGUEZYVTY4?=
 =?utf-8?B?R1B2Nkc4N1ZpdWNxWWhNYW1SeTVNSENPa015Q1Erc21ZK2RRaURMWTRoS2tk?=
 =?utf-8?B?cklsejVDbUxWRFZxQzYyRlJqMkx2ckxlWjViSldpZ2tYcXNCZWV1NFN0cUI4?=
 =?utf-8?B?eHgvUTl3bFFMUzB4V2RwUWtvSW12akFFU3R2TFo3WHpOVXdEUnIzQk9RczFW?=
 =?utf-8?B?ajU1YUtwVmFiTFQwdGptYVl0OVp3Snl6WnFkcXN4b1czZ0pMR282SzQvak14?=
 =?utf-8?B?UG94bGlza0s2bEQ5a0N6VjdjTiswTjA1OTlqZ1ZnV1doYTlnbm5WOFFtL0Zu?=
 =?utf-8?B?eFMyT2NEeDRIdjNTSDR4MkRISjhxeXZyQll5Q0c2SDBDcmkvbkE0U1pSWk8z?=
 =?utf-8?B?cW42RXlpU3lzT21VVTQvTDdmUmNUTnJ6dXdSWjhydnczaXVyRGhRaWUyMFlu?=
 =?utf-8?B?RTZBL1VHNW1MVlcrMk9lOUVldmZTVEE5YjBYQzkzQXgzKzJQR0lqcHJkVlNI?=
 =?utf-8?B?U01VOW9qWXRuWHAzVXJHZWtONEFPUXgrNis2VUh0NExXWnVHQktUOTNQZ1Bo?=
 =?utf-8?B?RlJ3N0hKdUNRPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9136.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OEZnNHJCU3RpZVNtTGJuQ2VLVGdQUGttbnJWVktGQ1MzMmJUaUJwTnVSZklN?=
 =?utf-8?B?MzRPME9BejVrekNScWtiRWJOd2g3WjRrTkczeGVYdmNNZkxkek83QjVuNHhT?=
 =?utf-8?B?MVZKSmQ5SlJsSDFNdGhTTTJSMFF3TFIvWVFOYTdTbFE3Yk1TKzJoWVV6K0hy?=
 =?utf-8?B?NTdvVHdkTUpNRy80TUcxK040WUZ6OC8rSUM5WmdDZ0RVK2toalY3WThyS0c3?=
 =?utf-8?B?aFFVOC9mMStDaUFuL2xWeXhZV201aklNZ1IyanRtLytyY0lDemM3SHk0ZnA0?=
 =?utf-8?B?STVrQTR2Si9qU1FZeWY4eitidW1jTnUvam9QQVIyYUE5SHRkSURTcTRZWVRI?=
 =?utf-8?B?VnZsZVh5d0x5UFQyOUtaT2tlOTNjc0tNdnNpMDNIZDQweUZNK0lGNUNzeGlp?=
 =?utf-8?B?M0tObEF2anQ3ak9HTEw1YXkxdktTRmZGR1pwL2ZiaTE3WmRxdU43NHcyWEFF?=
 =?utf-8?B?OUUrQUkyR0lQcFdFR2MxNUhGMkZaVm14NmJnSUZFWHFqM2dKN1R6Z0xaLzdq?=
 =?utf-8?B?c29Zc2FXTkFZWU9vbnNNUUlYRWJ4UG40SnNsZkVVODl3ZUdsbGxNWjBXa2dS?=
 =?utf-8?B?dkZoakw5NktPZ3QrQWY4R1ptcGoxNVk2NS84M3l2dXBlSUoyR0xWdDBweHRG?=
 =?utf-8?B?V1FmZjNmVDNwN1hhK28raFM5WWduQzhVVWluV2RUODdqUEh0bm4wVDVCanU2?=
 =?utf-8?B?T29Yem9RbkplLzVnSkZ2UGdYNnhib3RUcDNWcUJZaFd0cytlYXVyQUpFTUNa?=
 =?utf-8?B?QWVkK01vZHhUSmp3VVprQklOTlQ3VXZES3VST3VmZytnY1V5MEp0N3ZCVFBT?=
 =?utf-8?B?T0Z5d3lvcCszT2IrT0VRQThsZm5GYlRTaEx2anEvQWdvVSthWSsrR1YxZjlz?=
 =?utf-8?B?cDdsNHVkKzk2Y21hWjlSQldNTlB4K21vUDNaVStlRHVjTVVWcHZIaURseEtO?=
 =?utf-8?B?dmdTUFNDUi9pbXV4ZkswQ2NOcWVRQ0lkcS82YkU5aU54b25WbEtCMXo5YUZV?=
 =?utf-8?B?emdOZWpCYlJQZi9DR0R0dVR4N2VzWG84UWJ4aGpmeURaYzZjelpGZnk2V2FD?=
 =?utf-8?B?M3hYak9DR2NGZ3FjWWoyakRzVTRtNE1mSWFiaW5DVUZyNExMWFlyU1Z2cE0r?=
 =?utf-8?B?bUwyUGNxWFdNckFLN0VvMllucFZLSHlRMTR2QnNlbkpXTStrZXluS1NaN1p2?=
 =?utf-8?B?Qy8zZU5TZDd6WnBrNWhYNmFrcXlaeTljcnlINThxN2h4L3ZENnVHWXJ0VXFt?=
 =?utf-8?B?SDZGZnZ2UHI2Q09mUHhxWHd3NTIzeU9TYjJTK0tGMkVwdTNVS2Fockp0K2U5?=
 =?utf-8?B?QWp5Vmh6dmkzTHZMTkxydGhHYklrSnUrMi9BcEVYNDdkalJJemxQWWg1NDZB?=
 =?utf-8?B?OXZBQTlZVnExWGRPRWZ0YWRtVGFDbk1QMXYyMEY4ZC9pd0FqRFJFcmlyTDFY?=
 =?utf-8?B?bXFsSGh2V05CVHZrNk1DcVg3d0J4YkRMU2RZTFQyeXh3dldVT3RWZUw5N041?=
 =?utf-8?B?Q2R0aGpKNDE2Y2tiaHNoZ09sMjAvU3VBNkhEN0NOS3U5dWlZM2ZVSzNNWk9a?=
 =?utf-8?B?VDhFd0hScHNsMmVIYVpBYUxUWVJoemRsWTlSWGlTaG5hTGkxNmdMcisramFx?=
 =?utf-8?B?UldiVFBQWC9PbWJ0MzhRaGJ1TUFqMFUzbTdWakdIbEE4b2o2V21hcCt2Wm5r?=
 =?utf-8?B?bkpYZXBiSnNEOVRlZ25CMkxwaDlnUGNhUmpwMFNaZDlkNG15VXBpUXFDa3B2?=
 =?utf-8?B?OVBDcERscDNmMXB2ckY3WlhuR1pIczg1d2VESnYwWm9xaXVNVmViUHlpWllF?=
 =?utf-8?B?YldNczdTZTNzMCtVMmxGeGh6VVEzVEdKcHp3MXZQTW95L3FKaUJtWHgvUnFr?=
 =?utf-8?B?YWZreXBQWXdPRExsR1lIVmprZFJYeFpWWWlJT3RXZEpmOFNXS1dZQzQxeVFV?=
 =?utf-8?B?akExQVRvZE9jYjJDRFJneXZ2dWpFT3JvMFVHazNlNC94bGxIaTNIdHhmTkE2?=
 =?utf-8?B?Ry9XdHBUdVE4NFJKeVRxaE1WNDJxVU1wTzJlRWtIYytGRlRDMXE0UHdjUG9P?=
 =?utf-8?B?RGpPMnh6a1Y0QytRZktUR0lMTHA3dzk5VzN1dWl1cXJzODQ0UXk3S2JCYlFF?=
 =?utf-8?Q?/XXYig2upBhoRbilZi+MHSfnc?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9136.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d71e9226-52b9-4990-33f0-08ddf722a007
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Sep 2025 02:17:04.1921 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lDmvX+7/YbISqOmOnOibH8bg8//kuRRXmOk45K5Wf/gW/mvUvpRMlPQFeu+sHf2wFAfJ4wreK0g47prtr3wFByXuSElsXZkUlUwkTKW/fQ8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR11MB9033
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.15;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.005,
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

SGkgQ8OpZHJpYywNCg0KPi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+RnJvbTogQ8OpZHJp
YyBMZSBHb2F0ZXIgPGNsZ0ByZWRoYXQuY29tPg0KPlN1YmplY3Q6IFJlOiBbUEFUQ0ggdjYgMjIv
MjJdIGRvY3MvZGV2ZWw6IEFkZCBJT01NVUZEIG5lc3RpbmcNCj5kb2N1bWVudGF0aW9uDQo+DQo+
SGVsbG8gWmhlbnpob25nDQo+DQo+T24gOS8xOC8yNSAxMDo1OCwgWmhlbnpob25nIER1YW4gd3Jv
dGU6DQo+PiBBZGQgZG9jdW1lbnRhdGlvbiBhYm91dCB1c2luZyBJT01NVUZEIGJhY2tlZCBWRklP
IGRldmljZSB3aXRoDQo+aW50ZWxfaW9tbXUgd2l0aA0KPj4geC1mbHRzPW9uLg0KPj4NCj4+IFN1
Z2dlc3RlZC1ieTogWWkgTGl1IDx5aS5sLmxpdUBpbnRlbC5jb20+DQo+PiBTaWduZWQtb2ZmLWJ5
OiBaaGVuemhvbmcgRHVhbiA8emhlbnpob25nLmR1YW5AaW50ZWwuY29tPg0KPj4gLS0tDQo+PiAg
IGRvY3MvZGV2ZWwvdmZpby1pb21tdWZkLnJzdCB8IDI0ICsrKysrKysrKysrKysrKysrKysrKysr
Kw0KPj4gICAxIGZpbGUgY2hhbmdlZCwgMjQgaW5zZXJ0aW9ucygrKQ0KPj4NCj4+IGRpZmYgLS1n
aXQgYS9kb2NzL2RldmVsL3ZmaW8taW9tbXVmZC5yc3QgYi9kb2NzL2RldmVsL3ZmaW8taW9tbXVm
ZC5yc3QNCj4+IGluZGV4IDNkMWMxMWYxNzUuLmQ5Y2I5ZTdmNWUgMTAwNjQ0DQo+PiAtLS0gYS9k
b2NzL2RldmVsL3ZmaW8taW9tbXVmZC5yc3QNCj4+ICsrKyBiL2RvY3MvZGV2ZWwvdmZpby1pb21t
dWZkLnJzdA0KPj4gQEAgLTE2NCwzICsxNjQsMjcgQEAgUkFNIGRpc2NhcmRpbmcgZm9yIG1kZXYu
DQo+Pg0KPj4gICBgYHZmaW8tYXBgYCBhbmQgYGB2ZmlvLWNjd2BgIGRldmljZXMgZG9uJ3QgaGF2
ZSBzYW1lIGlzc3VlIGFzIHRoZWlyDQo+YmFja2VuZA0KPj4gICBkZXZpY2VzIGFyZSBhbHdheXMg
bWRldiBhbmQgUkFNIGRpc2NhcmRpbmcgaXMgZm9yY2UgZW5hYmxlZC4NCj4+ICsNCj4+ICtVc2Fn
ZSB3aXRoIGludGVsX2lvbW11IHdpdGggeC1mbHRzPW9uDQo+PiArLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLQ0KPj4gKw0KPj4gK09ubHkgSU9NTVVGRCBiYWNrZWQgVkZJTyBk
ZXZpY2UgaXMgc3VwcG9ydGVkIHdoZW4gaW50ZWxfaW9tbXUgaXMNCj5jb25maWd1cmVkDQo+PiAr
d2l0aCB4LWZsdHM9b24sIGZvciBsZWdhY3kgY29udGFpbmVyIGJhY2tlZCBWRklPIGRldmljZSwg
YmVsb3cgZXJyb3INCj5zaG93czoNCj4+ICsNCj4+ICsuLiBjb2RlLWJsb2NrOjogbm9uZQ0KPj4g
Kw0KPj4gKyAgICBxZW11LXN5c3RlbS14ODZfNjQ6IC1kZXZpY2UgdmZpby1wY2ksaG9zdD0wMDAw
OjAyOjAwLjA6IHZmaW8NCj4wMDAwOjAyOjAwLjA6IEZhaWxlZCB0byBzZXQgdklPTU1VOiBOZWVk
IElPTU1VRkQgYmFja2VuZCB3aGVuDQo+eC1mbHRzPW9uDQo+PiArDQo+PiArVkZJTyBkZXZpY2Ug
dW5kZXIgUENJIGJyaWRnZSBpcyB1bnN1cHBvcnRlZCwgdXNlIFBDSUUgYnJpZGdlIGlmIG5lY2Vz
c2FyeSwNCj4+ICtvciBlbHNlIGJlbG93IGVycm9yIHNob3dzOg0KPj4gKw0KPj4gKy4uIGNvZGUt
YmxvY2s6OiBub25lDQo+PiArDQo+PiArICAgIHFlbXUtc3lzdGVtLXg4Nl82NDogLWRldmljZQ0K
PnZmaW8tcGNpLGhvc3Q9MDAwMDowMjowMC4wLGJ1cz1icmlkZ2UxLGlvbW11ZmQ9aW9tbXVmZDA6
IHZmaW8NCj4wMDAwOjAyOjAwLjA6IEZhaWxlZCB0byBzZXQgdklPTU1VOiBIb3N0IGRldmljZSB1
bmRlciBQQ0kgYnJpZGdlIGlzDQo+dW5zdXBwb3J0ZWQgd2hlbiB4LWZsdHM9b24NCj4+ICsNCj4+
ICtJZiBob3N0IElPTU1VIGhhcyBFUlJBVEFfNzcyNDE1X1NQUjE3LCBrZXhlYyBvciByZWJvb3Qg
ZnJvbQ0KPiJpbnRlbF9pb21tdT1vbixzbV9vbiINCj4+ICt0byAiaW50ZWxfaW9tbXU9b24sc21f
b2ZmIiBpbiBndWVzdCBpcyBhbHNvIHVuc3VwcG9ydGVkLiBDb25maWd1cmUNCj5zY2FsYWJsZSBt
b2RlDQo+PiArb2ZmIGFzIGJlbG93IGlmIGl0J3Mgbm90IG5lZWRlZCBieSBndWVzdC4NCj4+ICsN
Cj4+ICsuLiBjb2RlLWJsb2NrOjogYmFzaA0KPg0KPmFuIG5ldyBsaW5lIGxhY2tzIGFmdGVyIGNv
ZGUtYmxvY2suDQoNClRoYW5rcyBmb3IgcG9pbnRpbmcgb3V0LCB3aWxsIGZpeCwgSSBmb3Jnb3Qg
dG8gbWFrZSBkb2NzIG9uY2UgYWdhaW7imLkNCg0KQlJzLA0KWmhlbnpob25nDQo=

