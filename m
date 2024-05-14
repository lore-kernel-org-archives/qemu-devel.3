Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 890AFC04FFE
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2024 08:36:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6ndf-0005Vu-2r; Tue, 14 May 2024 04:35:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1s6ndd-0005Vb-Q2
 for qemu-devel@nongnu.org; Tue, 14 May 2024 04:35:57 -0400
Received: from mgamail.intel.com ([198.175.65.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1s6nda-0003jX-Ly
 for qemu-devel@nongnu.org; Tue, 14 May 2024 04:35:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1715675754; x=1747211754;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=9QBdT9DJPI7/c+g4+8fl8C4HZrkBZ+ImLvIQMwEeKY8=;
 b=IcTspflALdqI/rmrzDVUoEALcNuc2pEIAoWfa7N9lE2WdC5eXOInmtAG
 8fASSNTeHi3CEvLd6chSFBK36qRhEnugCg7UGyN3fHRLeQxJXaJJ6Ds6k
 ZtVy0jDDQ7okYiPapDzbElYoJTikaSGLG1GAtreZWORZYedhZu4l9PHmo
 3DkmtYR2gpkBVBvOZGLtPp7VDf5UG85XNNENc55KlTfulvyeR4UsbZ1Z9
 9fgvpedQlIX8jqjJwdBseZ94a7jqbiO/1BjmGuQQ7QzgyjTobrGXA/ep+
 dLFv9mRN8ZncRxtLP4AEDmuu8xDxWkECSbSRJ7ILF2PwFuv2Qme7daJ5P A==;
X-CSE-ConnectionGUID: 87KB0fZnQOyEZs3mU0iCjA==
X-CSE-MsgGUID: +2Z8jqNSRuClSlCsb7w0TQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11072"; a="11497291"
X-IronPort-AV: E=Sophos;i="6.08,159,1712646000"; d="scan'208";a="11497291"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 May 2024 01:35:51 -0700
X-CSE-ConnectionGUID: 8Q1lgDUqSLGL7GlNkIQI0A==
X-CSE-MsgGUID: hHzIuUqxTzuGHwWq4ZQvBQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,159,1712646000"; d="scan'208";a="35063616"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
 by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 14 May 2024 01:35:50 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 14 May 2024 01:35:50 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 14 May 2024 01:35:50 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 14 May 2024 01:35:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GC8ZxZz4+UNn+LKAptX213s7zOARuVoyohQIJxuCdo2uf8HOrWZ3FxTmLwDTlCYSby6UmOT1PlRp7vOtS4o0utpx9aW7PS8WR4Mx5zrpxazY9kpJan9JEVo4AzmcIvAc9KCXwclf9CQCKm7TsEdeh2hJ/lJhKrwoRnOHRYLmI+QeHQRYWv2XX+Kk+rGobUJ6TtJSKQWDDKq+7LX54j+tG98ep2kOH2EAOFiPUUWb00SRT2VevfepUc2BT3aj6VXm3a1Q25/unRvd2DcYZuLRZ1wh74lKqtk66NbRfvinclTthajErPToUEpLdIX1lHJUQ4+qAWfeE8cwjK0Flwvblg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9QBdT9DJPI7/c+g4+8fl8C4HZrkBZ+ImLvIQMwEeKY8=;
 b=WbVV/Ayj+Y/G3gyOXBsa1XwA516p2w/BisENJoDNatjcCLUDu780sBO6/aCkAajdo9R+wuB9JYb8jbjhvw48uR27IOUtM14Mqf01z3sMt24vwlX2eY8ZweUX+r1JJONsXHLPO6wVOYsodD4hZqKPYi4JVjPNLCDb6Y8UMCiT33YoHR8JfIkFRwtu7jnnJvLmzB4evzX+4wwf7PpLz4S0HrWJXvHKzG5Q5brYxmqwWET5McUCmnhbhgfhp/UnkzRBmUBiIHJg6saxrdz52zsDHCEqnXTuta7KZVNrCY4HGZtq/yu9hRR0Br+S5+lt+cjw3Z9p9IxT5H4a/zCYW0EROw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by DM4PR11MB6285.namprd11.prod.outlook.com (2603:10b6:8:a8::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.26; Tue, 14 May
 2024 08:35:48 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::e4a3:76ce:879:9129]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::e4a3:76ce:879:9129%7]) with mapi id 15.20.7544.052; Tue, 14 May 2024
 08:35:48 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "jasowang@redhat.com" <jasowang@redhat.com>, "Tian, Kevin"
 <kevin.tian@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>, "peterx@redhat.com"
 <peterx@redhat.com>
Subject: RE: [PATCH ats_vtd v1 08/24] pcie: add helper to declare PASID
 capability for a pcie device
Thread-Topic: [PATCH ats_vtd v1 08/24] pcie: add helper to declare PASID
 capability for a pcie device
Thread-Index: AQHanKWLbx6rYBZ7ZkyygmA4Fh4+nrGWeHvw
Date: Tue, 14 May 2024 08:35:48 +0000
Message-ID: <SJ0PR11MB6744994A2F595F96621ABE5392E32@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20240502152810.187492-1-clement.mathieu--drif@eviden.com>
 <20240502152810.187492-9-clement.mathieu--drif@eviden.com>
In-Reply-To: <20240502152810.187492-9-clement.mathieu--drif@eviden.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|DM4PR11MB6285:EE_
x-ms-office365-filtering-correlation-id: 6fb7d5fc-cddb-48d8-d576-08dc73f0db13
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|1800799015|366007|376005|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?cW5CQzNZaGx5TFlJV1FHZVgrck5rbVpNTkJtbFlmc3hSTjFpOTQzcFJmWDdJ?=
 =?utf-8?B?ZFI5OUg1TldMNkY4RUpyNHJUajBjaytPazk4V045SGQ1Rm5LOE03ZjQ3SHhj?=
 =?utf-8?B?NDBFWFZ6STJmdEtRdTdIZXhOeTA1VHVyT0lJZGlxSDR6SHdTbVRweHNJWjZL?=
 =?utf-8?B?ZE1FOXlFVFc4a3lHK0JrVTRVT3RZeVdyWjVGOGxXK2ZnRGd2UlhxTTRGZUZj?=
 =?utf-8?B?Z0VNRWI3a1NhZTd0L1M3N1ZGbG9oT3Y4VHBZa2VUNW80L05JYVVaS0xUZFho?=
 =?utf-8?B?R2g4c2VCNkpOdUpyaDhrdkhBeUdDSDVRM3QrbjdGalo3cGpOem5zUXFYR0ps?=
 =?utf-8?B?eTBHKzE4ZC9STTRBb1BsK2ZmWkhMZWxGL1cxUkYyR3RHUTBCN1F3bGh5WHRz?=
 =?utf-8?B?Ri9XV2lPSUFXZlJ5TkR0M2Q3K1hQaGttUmNoanpiZU55UFF1aW02K0NNVjVx?=
 =?utf-8?B?d1R4ZDBJUnJYSk5sdm1wQ3h3WWU1M2dFUmpZcWZyOFowS2Y2b2hmYXFOVUFN?=
 =?utf-8?B?dVIyTnQ3MnhUZ1dwbUMvSFM5SDIxU1pjbDRrejk2WnZacVQ0NWpwU0lIc0xz?=
 =?utf-8?B?L1oxbW9xeGs2YUtRdVJ3V3ZJV2FlK2FlUVVoVWVwTFdWYlVSOXdLSXI3RHFF?=
 =?utf-8?B?VFZveUU2eHdVQTRVMEN4TFdQMFRSdmE2b1d0Q3daZkpzQmpIMVV1dmpDRGkx?=
 =?utf-8?B?TVlCTWU2YnNmWGpBNXdvNlVieWdGaVdTdVhKUVR3cSs2R0pEMEU1WStRNGIy?=
 =?utf-8?B?aDRuWGxVRWxiZlZ2dkoyV0VtSmt2b3dwUGtUZ2xybHUvT2tnVTZOOFVsdjVN?=
 =?utf-8?B?OFhBVnE3WWViRkcvdFNiRS9hOEtmU3QxaTA5aS9DMlBUNkN3YTl1UmZkSkxO?=
 =?utf-8?B?ZzJTbmJPSXZRWUw0N1d6L1BHT0ZreHJJZkZuM2R1TG9NODYyT3RzWTZxVjZT?=
 =?utf-8?B?NVdRV0RnMGRGWVhxRU1PWjB6aFFoRWpzNUREV3dGdGdrYTkvSk9VRlZwTm0y?=
 =?utf-8?B?YS9RM2FoeU0rSFowbWV3a1BoZjliZzhmdzVBTTR5WlRiNTlUdUVEdWZlTjdw?=
 =?utf-8?B?NmxZUlZxRm9HSGhzenk1TmMyNzlxRmNYT3dob0FlcWpab0k3QXk1c0QwUE5K?=
 =?utf-8?B?dEZrZXZqQWFmWENJamo5aDhlVFNHOWtkbEhoNm9ONzdZbTRsOG55VWJMU2gw?=
 =?utf-8?B?elVVcU1uTmxpT3lIUWtiRzc4d3ZqUTd4QlFQM1gzdGQvRFlUblBYRU1GRGlo?=
 =?utf-8?B?c0IyVDdHYVZNWVMyQkpwUlMxdi83L25FeWlPRGt0VzdMUWRCenhrUjlONCsx?=
 =?utf-8?B?TkNpVVpnVGp3dGNMWDJ2dXNyT29WWklCaUc0MjRvTmRJR1oxYS8rVXM3SHJ1?=
 =?utf-8?B?aXBpVFlRVTlEYzJjSHRCNTJSUWdmdEh3OTBDWnhrQnd6VjMvR20wdVljalVn?=
 =?utf-8?B?TDN1ODhZYmMyTmVVQkhLM2hvb3N6QktxeTRBUC82UHBObmREOENVVncyMkpm?=
 =?utf-8?B?bm0wRk1wVEpKYi9YcVV3R1V0NWJsS2RFZ0Y4UVJiblFmMW1wTHRJaEgwWXUv?=
 =?utf-8?B?Y21JZ0xOUUc4MklxdkN3dXBHeWdIK091K1ZuVmRSanl2TEc5R2F0cmxZMldy?=
 =?utf-8?B?UjVGU2hWN3Vzb09KQVZIMGc0ZTZBQmFmTFdGR3BiWm1zNXNjbUo5cXdSZmg0?=
 =?utf-8?B?MFpVd3gvTm9hQjE5NVhaWWRaRGpjRVNYRUo5UTZUYlRvNTh3MkhraFF3bWdl?=
 =?utf-8?B?YWhZNnRsbFFBSGFhSHZKaTlIMXZkQjNHYjNwWWdvMFQ4bUh6cStFelBBM1p2?=
 =?utf-8?B?N0F6NE15MEFIMkZ0VjI5dz09?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(366007)(376005)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TC8xZzZSQkJlMU04QWZuQW0waUliWTRiOUU0MWFRYWJwVWFTRmo1WHVyTDFO?=
 =?utf-8?B?dXlDRHlrWURBeWw2USs4MGkyNGpkVE9QdFFmVHlEeDJEWHIrbnd1cFJtYkZE?=
 =?utf-8?B?UlpNb3dwbDRHdllzaHB1bHV4MUx6amlIM0tpYmd1ZGVjb2c5NGs2MlZLSmto?=
 =?utf-8?B?ZkkvdW9MUDlMSVpDOHpCYS9yMXdEMWI0UVNGbmx3aXVmblVzbjByRG9RMGFu?=
 =?utf-8?B?NFFkZUZYekt3b3JQLzZhczRWZlZqRUFIbVQyUUc0OUNlNmx2S1VOY3hIbGNu?=
 =?utf-8?B?cjhFaFRpZHc4Sm4yTUo2NnJ5VHRkeHNiQ1d0UmNuOTNXbld3bnNSSHdYY3NW?=
 =?utf-8?B?L0ZOUTErOXRaL1c1T1FNSFR6ZGtZMTlkTy9QRjVXMTVRYmV1a2ozVExTeWIx?=
 =?utf-8?B?bGl1VDUyRFU5VFpYVWZJdVRiWERsU294QXVFdHE1WjAvMXlpQ01tbU5JRXBV?=
 =?utf-8?B?eDFGRy9pSHdBRU4rc1hIZ3pxRW9URHdhSDlKQ0pCM29rYU5yYzlNSWU5MkVk?=
 =?utf-8?B?MjBld0daWUU5ek1yV25tdDA4cE4rWXorU3JEQ08xTlZxT2lmUlNZK2Q5VC9K?=
 =?utf-8?B?SnBvRlNPVXlIeFJ6Q1dtR1VUSkRvd3dReXh2V1JkeUZHOFN6Q2E4Q25WR1dx?=
 =?utf-8?B?aHNockxMUEk5S1JScTgxUHFVcWwzT1M2NysySGZOSkErL3hhUDgwRzE4R3g4?=
 =?utf-8?B?RWxHQmZMaW9YVVp6OE9HMjNlK3ZWdzFJSFlSQmRqK3dBSEZYY2tHWXNXTWNC?=
 =?utf-8?B?TjBlaVprMlV2TklDL1A2ZVpoQk43V0VZQXFPYm9aQ1UrYVBtOXFwcmJkMDdU?=
 =?utf-8?B?YTViYk9ROU9LQ2hoRTh3bnlKVUpSTEdSS3h0TWhyVnBCT21jRTF1a3g4aTNs?=
 =?utf-8?B?ZXl4cUFBcDVFYjhXYk5OSUlhWTNSampwTzhCMkNQRG1oUTAyaFJWczZMd3R4?=
 =?utf-8?B?VFJveDl3cmtqdkxFa1RnQTd0bjV4TzZLbWhJM2F3c2ZnQ24xNkk4akd0aGVa?=
 =?utf-8?B?TU1LNFI4QU93d0RuTS9XOFVKMFVTOGxGVThMaU9nWU4yeCt2d3hMWUxETWlr?=
 =?utf-8?B?Ymo0dStnWGUwdU1hakdqeHFqQ3BjU0JSdDBvVnN6VnhSUy8zKzlITWs4Mk8v?=
 =?utf-8?B?eWMzTG5wN2RuWFFxd3g1bys0bTB6azBCdkE0SWI1cGdIQmplOE9Pa0s1VUtz?=
 =?utf-8?B?bitkWFZ0dERQdS9iM0FZWGFVeWxINTJjcWlkckk0ME82Vit5YkhUQkdTNlNW?=
 =?utf-8?B?QkQ5SXZZM3ZWRnZqdzJMdTM3UFVBak1EeUR0WTFKMnRiOGhhVUtKRVFyZ1JT?=
 =?utf-8?B?YzduYWFUa3JFQjhmZENKUEFTUlFBdisxcHhzMkJIanlqV3l4V0pFQmwrM1pk?=
 =?utf-8?B?bUplUFRPajcyYkFxMWdxNzJtb0owRTM0TVNKZkxwUUVvV0xIWFgvY2c1Vjhu?=
 =?utf-8?B?N3VXSE1FQ0V2ZmIrWGdiaVBkdDFWVU9ySzhkVEJOZWFKZ29EdFZNNGVEZ3FD?=
 =?utf-8?B?N3JxOHFSUWtpZzZkZ2ZlaVJMbmVnbFVmUjFETW54WE9wby9zSVlkTzA3Q1RN?=
 =?utf-8?B?eTZaUzdLdFg5cWx5U3BhZVA1QlJDMytPVm55VGRYUzk1Y3RUUFR2c0xWS1k4?=
 =?utf-8?B?NEdmR0ZIT21iY3BBWFlVUUIzOFlPZWFURHRWejZhcnNyd3JObjZydE5MZjJh?=
 =?utf-8?B?Z2xCV20yWU9YR3lLS2pkY2hOaVZ1czFKVlA1bm5IblFMZ1JrUzZBR2gwMGJn?=
 =?utf-8?B?azR5T1ZSdktLdWVDUXVGOG5vNzRYaGNSdTFNalpwZHVWVW4zdnBJTjhNMm5J?=
 =?utf-8?B?c1dIK0FlOEp5OG8zeEdLWnJmUHlWdm1qeUwwbThoaXFFVER1d1l3MWpnTE5l?=
 =?utf-8?B?OTBiRlZaaWZmYlN6b2xiZk1GOENLOEVOMDVHTVFvMmxnUC9XUHY2UndCMVl4?=
 =?utf-8?B?cDFvcnhjdTVRQlpReHZQYVMzOXZYSmdWWFdwUmVBVkplcVIvdU1BZ25iQVBn?=
 =?utf-8?B?Qmh4MmEyRzJLaGkxZEtsTm5ReVUrMmFHa09jRU1JRkxqNjBzOHFtbnZUb0px?=
 =?utf-8?B?MmpLeHh6SEx2RUszUDk2RjNUZkMvVmdzendSMmhoMkNscUNxTVR5OFh0ZU1i?=
 =?utf-8?Q?Af8ats3VbYjAJh+zooI17h4IH?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fb7d5fc-cddb-48d8-d576-08dc73f0db13
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 May 2024 08:35:48.4542 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zsT7RZRa8o9YyzzbLwQUmhKvyO+iBplU0CC+5t36bSh7avlVd0ECpzQQWhVVoP+KAlDv1DwHnX44iqrCzxqZQ7gatMDm95TTUL6TX3xRPI8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6285
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.19;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -53
X-Spam_score: -5.4
X-Spam_bar: -----
X-Spam_report: (-5.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.974,
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

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IENMRU1FTlQgTUFUSElFVS0t
RFJJRiA8Y2xlbWVudC5tYXRoaWV1LS1kcmlmQGV2aWRlbi5jb20+DQo+U3ViamVjdDogW1BBVENI
IGF0c192dGQgdjEgMDgvMjRdIHBjaWU6IGFkZCBoZWxwZXIgdG8gZGVjbGFyZSBQQVNJRA0KPmNh
cGFiaWxpdHkgZm9yIGEgcGNpZSBkZXZpY2UNCj4NCj5TaWduZWQtb2ZmLWJ5OiBDbMOpbWVudCBN
YXRoaWV1LS1EcmlmIDxjbGVtZW50Lm1hdGhpZXUtLWRyaWZAZXZpZGVuLmNvbT4NCj4tLS0NCj4g
aHcvcGNpL3BjaWUuYyAgICAgICAgICAgICAgfCAyNCArKysrKysrKysrKysrKysrKysrKysrKysN
Cj4gaW5jbHVkZS9ody9wY2kvcGNpZS5oICAgICAgfCAgNiArKysrKy0NCj4gaW5jbHVkZS9ody9w
Y2kvcGNpZV9yZWdzLmggfCAgMyArKysNCj4gMyBmaWxlcyBjaGFuZ2VkLCAzMiBpbnNlcnRpb25z
KCspLCAxIGRlbGV0aW9uKC0pDQo+DQo+ZGlmZiAtLWdpdCBhL2h3L3BjaS9wY2llLmMgYi9ody9w
Y2kvcGNpZS5jDQo+aW5kZXggNGIyZjA4MDVjNi4uYzhlOWQ0YzBmNyAxMDA2NDQNCj4tLS0gYS9o
dy9wY2kvcGNpZS5jDQo+KysrIGIvaHcvcGNpL3BjaWUuYw0KPkBAIC0xMTc3LDMgKzExNzcsMjcg
QEAgdm9pZCBwY2llX2Fjc19yZXNldChQQ0lEZXZpY2UgKmRldikNCj4gICAgICAgICBwY2lfc2V0
X3dvcmQoZGV2LT5jb25maWcgKyBkZXYtPmV4cC5hY3NfY2FwICsgUENJX0FDU19DVFJMLCAwKTsN
Cj4gICAgIH0NCj4gfQ0KPisNCj4rLyogUEFTSUQgKi8NCj4rdm9pZCBwY2llX3Bhc2lkX2luaXQo
UENJRGV2aWNlICpkZXYsIHVpbnQxNl90IG9mZnNldCwgdWludDhfdCBwYXNpZF93aWR0aCwNCj4r
ICAgICAgICAgICAgICAgICAgICAgYm9vbCBleGVjX3Blcm0sIGJvb2wgcHJpdl9tb2QpDQo+K3sN
Cj4rICAgIGFzc2VydChwYXNpZF93aWR0aCA8PSBQQ0lfRVhUX0NBUF9QQVNJRF9NQVhfV0lEVEgp
Ow0KPisgICAgc3RhdGljIGNvbnN0IHVpbnQxNl90IGNvbnRyb2xfcmVnX3J3X21hc2sgPSAweDA3
Ow0KPisgICAgdWludDE2X3QgY2FwYWJpbGl0eV9yZWcgPSBwYXNpZF93aWR0aDsNCj4rDQo+KyAg
ICBwY2llX2FkZF9jYXBhYmlsaXR5KGRldiwgUENJX0VYVF9DQVBfSURfUEFTSUQsIFBDSV9QQVNJ
RF9WRVIsIG9mZnNldCwNCj4rICAgICAgICAgICAgICAgICAgICAgICAgUENJX0VYVF9DQVBfUEFT
SURfU0laRU9GKTsNCj4rDQo+KyAgICBjYXBhYmlsaXR5X3JlZyA8PD0gUENJX0VYVF9DQVBfUEFT
SURfU0laRU9GOw0KDQpOb3QgdW5kZXJzdGFuZCB3aHkgUENJX0VYVF9DQVBfUEFTSURfU0laRU9G
IGlzIHVzZWQgZm9yIHNoaWZ0aW5nPw0KDQo+KyAgICBjYXBhYmlsaXR5X3JlZyB8PSBleGVjX3Bl
cm0gPyBQQ0lfUEFTSURfQ0FQX0VYRUMgOiAwOw0KPisgICAgY2FwYWJpbGl0eV9yZWcgfD0gcHJp
dl9tb2QgID8gUENJX1BBU0lEX0NBUF9QUklWIDogMDsNCj4rICAgIHBjaV9zZXRfd29yZChkZXYt
PmNvbmZpZyArIG9mZnNldCArIFBDSV9QQVNJRF9DQVAsIGNhcGFiaWxpdHlfcmVnKTsNCj4rDQo+
KyAgICAvKiBFdmVyeXRoaW5nIGlzIGRpc2FibGVkIGJ5IGRlZmF1bHQgKi8NCj4rICAgIHBjaV9z
ZXRfd29yZChkZXYtPmNvbmZpZyArIG9mZnNldCArIFBDSV9QQVNJRF9DVFJMLCAwKTsNCj4rDQo+
KyAgICBwY2lfc2V0X3dvcmQoZGV2LT53bWFzayArIG9mZnNldCArIFBDSV9QQVNJRF9DVFJMLA0K
PmNvbnRyb2xfcmVnX3J3X21hc2spOw0KPisNCj4rICAgIGRldi0+ZXhwLnBhc2lkX2NhcCA9IG9m
ZnNldDsNCj4rfQ0KPmRpZmYgLS1naXQgYS9pbmNsdWRlL2h3L3BjaS9wY2llLmggYi9pbmNsdWRl
L2h3L3BjaS9wY2llLmgNCj5pbmRleCAxMWY1YTkxYmJiLi5jNTk2MjdkNTU2IDEwMDY0NA0KPi0t
LSBhL2luY2x1ZGUvaHcvcGNpL3BjaWUuaA0KPisrKyBiL2luY2x1ZGUvaHcvcGNpL3BjaWUuaA0K
PkBAIC02OSw4ICs2OSw5IEBAIHN0cnVjdCBQQ0lFeHByZXNzRGV2aWNlIHsNCj4gICAgIHVpbnQx
Nl90IGFlcl9jYXA7DQo+ICAgICBQQ0lFQUVSTG9nIGFlcl9sb2c7DQo+DQo+LSAgICAvKiBPZmZz
ZXQgb2YgQVRTIGNhcGFiaWxpdHkgaW4gY29uZmlnIHNwYWNlICovDQo+KyAgICAvKiBPZmZzZXQg
b2YgQVRTIGFuZCBQQVNJRCBjYXBhYmlsaXRpZXMgaW4gY29uZmlnIHNwYWNlICovDQo+ICAgICB1
aW50MTZfdCBhdHNfY2FwOw0KPisgICAgdWludDE2X3QgcGFzaWRfY2FwOw0KPg0KPiAgICAgLyog
QUNTICovDQo+ICAgICB1aW50MTZfdCBhY3NfY2FwOw0KPkBAIC0xNDcsNCArMTQ4LDcgQEAgdm9p
ZCBwY2llX2NhcF9zbG90X3VucGx1Z19jYihIb3RwbHVnSGFuZGxlcg0KPipob3RwbHVnX2Rldiwg
RGV2aWNlU3RhdGUgKmRldiwNCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICBFcnJvciAq
KmVycnApOw0KPiB2b2lkIHBjaWVfY2FwX3Nsb3RfdW5wbHVnX3JlcXVlc3RfY2IoSG90cGx1Z0hh
bmRsZXIgKmhvdHBsdWdfZGV2LA0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgRGV2aWNlU3RhdGUgKmRldiwgRXJyb3IgKiplcnJwKTsNCj4rDQo+K3ZvaWQgcGNpZV9wYXNp
ZF9pbml0KFBDSURldmljZSAqZGV2LCB1aW50MTZfdCBvZmZzZXQsIHVpbnQ4X3QgcGFzaWRfd2lk
dGgsDQo+KyAgICAgICAgICAgICAgICAgICAgIGJvb2wgZXhlY19wZXJtLCBib29sIHByaXZfbW9k
KTsNCj4gI2VuZGlmIC8qIFFFTVVfUENJRV9IICovDQo+ZGlmZiAtLWdpdCBhL2luY2x1ZGUvaHcv
cGNpL3BjaWVfcmVncy5oIGIvaW5jbHVkZS9ody9wY2kvcGNpZV9yZWdzLmgNCj5pbmRleCA5ZDNi
Njg2OGRjLi4wYTg2NTk4ZjgwIDEwMDY0NA0KPi0tLSBhL2luY2x1ZGUvaHcvcGNpL3BjaWVfcmVn
cy5oDQo+KysrIGIvaW5jbHVkZS9ody9wY2kvcGNpZV9yZWdzLmgNCj5AQCAtODYsNiArODYsOSBA
QCB0eXBlZGVmIGVudW0gUENJRXhwTGlua1dpZHRoIHsNCj4gI2RlZmluZSBQQ0lfQVJJX1ZFUiAg
ICAgICAgICAgICAgICAgICAgIDENCj4gI2RlZmluZSBQQ0lfQVJJX1NJWkVPRiAgICAgICAgICAg
ICAgICAgIDgNCj4NCj4rLyogUEFTSUQgKi8NCj4rI2RlZmluZSBQQ0lfUEFTSURfVkVSICAgICAg
ICAgICAgICAgICAgIDENCj4rI2RlZmluZSBQQ0lfRVhUX0NBUF9QQVNJRF9NQVhfV0lEVEggICAg
IDIwDQo+IC8qIEFFUiAqLw0KPiAjZGVmaW5lIFBDSV9FUlJfVkVSICAgICAgICAgICAgICAgICAg
ICAgMg0KPiAjZGVmaW5lIFBDSV9FUlJfU0laRU9GICAgICAgICAgICAgICAgICAgMHg0OA0KPi0t
DQo+Mi40NC4wDQo=

