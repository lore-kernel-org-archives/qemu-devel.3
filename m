Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EC23C87FD2
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Aug 2025 16:09:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhsJ9-0002Zl-UQ; Fri, 01 Aug 2025 12:08:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1uhrOd-0002o2-28
 for qemu-devel@nongnu.org; Fri, 01 Aug 2025 11:10:11 -0400
Received: from mgamail.intel.com ([192.198.163.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1uhrOZ-00020x-Gl
 for qemu-devel@nongnu.org; Fri, 01 Aug 2025 11:10:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1754061008; x=1785597008;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=tN/mqyyEHXDLkUnDOsNyP20Mgwf02BGmXLzvOge1L/c=;
 b=SDk8OqvGsdr7o6dX+URFahrmkU8wL+zCwHK+06c6RLmZeJ4qhK1dV+hb
 3mqivWbkiWYMr2Wg7jbBMTYgP8udY8kdO8ouPYa43fCaWbOyX3lTQzO0i
 Sd6srmyZYd2bXGtXt/GsHs1y5EUkfSKMQhZl/9m2bRtqtVP850YvI+5Xc
 SJ4JTbVsdXjy9KfZL3NOfLXdEJYzNePCzgd2NtvmP8D0muFYdFpIhMJlo
 Nm1UlC8skjXUYv8zKTLiWNub0ZvDNs2BWOM8VXFrH1PCAzfirCOJYzzA4
 +9wHBE1mmv6h9R8I2hNbwAu4b2fiBtc+16P4Xn7z1pGiBjsufrwS+oAZA A==;
X-CSE-ConnectionGUID: m9dbnytBTNCxlZcSc04gQA==
X-CSE-MsgGUID: QjgN73pkTAObEY/ZoW7PRw==
X-IronPort-AV: E=McAfee;i="6800,10657,11508"; a="60228378"
X-IronPort-AV: E=Sophos;i="6.17,255,1747724400"; d="scan'208";a="60228378"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Aug 2025 08:10:03 -0700
X-CSE-ConnectionGUID: 7iXf+H3/QqSTbYuqzUbapA==
X-CSE-MsgGUID: T+tnPvznTPWKqPWVd9X9BA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,255,1747724400"; d="scan'208";a="162852890"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Aug 2025 08:10:03 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Fri, 1 Aug 2025 08:10:02 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Fri, 1 Aug 2025 08:10:02 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (40.107.92.64) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Fri, 1 Aug 2025 08:10:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KD4kJGNTHDPMnyyAjhcO6CVDmLWPXrDhutwMvZof6189f3Bci6u88TYduCitgFMk42Cb7eAXQ/M4W64zUD04aP+81FhzQ9oh7g9P1/WoR6a4hobkTRN1ROJlMSjbRcwJaRWB7cCh+bgEo8QKg6q47qfg29WjlvjSyrBT8FGO0z4Ck9b9N5ZiwN0PpD3xV5Ei9+gsLCJQvjtXJSlmNuJuCH3dAxwesnQC/+JYpt6W8UGNGvFzj5MijCqNgokWIn/si2NfYng5IpW41m9hQqYxmGVITPaD376JpEOAjBZRp9YzTn5GtudcqyK6kNIyJKz21gMslxw9rhK2CHDcMoQt3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tN/mqyyEHXDLkUnDOsNyP20Mgwf02BGmXLzvOge1L/c=;
 b=pjM6LBxXmeRun+PNUPzBJPBwa0c0UWQFuFdIQu3xgm79xkmq6SpTa1RtMG2nNNUmofzx78+om63f6x6HNX6QBQ+WalFyIWkh/KBJHQxDUZSe6r/81wsCMuscxDni0Gh7Stu1V5EdkVjf3zMiqlCzbP29vHGCdbKLk/3IrOl2f8J0KVAhwXsWUqsiKqSwz59fOn5Pw60gSrJlBYdQkpvairTMAlJhxaNbaRzmAQ1Px/GAHma506Q0O8hAYKGP78LlWTTLYOb+VFw/JWQOD7kPulEjhIHyIDH+wydy029pycAlfBZe+mXMht04R09i+E2f5bsf5bG9/wHrGfRKGNbP6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BY5PR11MB3974.namprd11.prod.outlook.com (2603:10b6:a03:183::29)
 by BL1PR11MB5288.namprd11.prod.outlook.com (2603:10b6:208:316::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.13; Fri, 1 Aug
 2025 15:09:59 +0000
Received: from BY5PR11MB3974.namprd11.prod.outlook.com
 ([fe80::fe0b:26f7:75b4:396]) by BY5PR11MB3974.namprd11.prod.outlook.com
 ([fe80::fe0b:26f7:75b4:396%5]) with mapi id 15.20.8989.015; Fri, 1 Aug 2025
 15:09:59 +0000
From: "Liu, Yi L" <yi.l.liu@intel.com>
To: David Woodhouse <dwmw2@infradead.org>, CLEMENT MATHIEU--DRIF
 <clement.mathieu--drif@eviden.com>, Konstantin Belousov <kib@kib.kiev.ua>
CC: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Le Tan <tamlokveer@gmail.com>, "jhb@freebsd.org" <jhb@freebsd.org>, "Marcel
 Apfelbaum" <marcel.apfelbaum@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>, Eduardo Habkost
 <eduardo@habkost.net>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: RE: [PATCH v2] intel_iommu: Allow both Status Write and Interrupt
 Flag in QI wait
Thread-Topic: [PATCH v2] intel_iommu: Allow both Status Write and Interrupt
 Flag in QI wait
Thread-Index: AQHb9JWAqjX5UHEB3UqrbXGeZAwF+rQxrd+AgAAlOQCAAE5sgIAAlAaAgABrToCACvd/AIAP6mUw
Date: Fri, 1 Aug 2025 15:09:58 +0000
Message-ID: <BY5PR11MB397427D45C1283AD0E5D0B59C326A@BY5PR11MB3974.namprd11.prod.outlook.com>
References: <0122cbabc0adcc3cf878f5fd7834d8f258c7a2f2.camel@infradead.org>
 <9ce8b7e6-ad15-4d2e-a430-3896eccc7519@intel.com>
 <4FE9A8E3-5BA5-46D3-A1FA-EA1B7C85C058@infradead.org>
 <aHV0-wDJImAjRPPp@kib.kiev.ua>
 <afe3881b-1193-4d89-b0d0-6c316e54684f@eviden.com>
 <8fe80210-7cf0-4fec-94d4-79b41216a620@intel.com>
 <60537d9a2f87c36160b26a5154a1839df3e90b58.camel@infradead.org>
In-Reply-To: <60537d9a2f87c36160b26a5154a1839df3e90b58.camel@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR11MB3974:EE_|BL1PR11MB5288:EE_
x-ms-office365-filtering-correlation-id: 23f011e1-4bb0-409e-f1bd-08ddd10d7b50
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|7416014|1800799024|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?UkN0YkdmTkQ1T1lpOGovTFo3Z2RNOVdrNUxhSkN3ZUpXV1JCSnowYXdhQ3Y0?=
 =?utf-8?B?SkRLVy9OeE1KNVNxZTZ3dzBNdEVnMzhCMTkyUmVwNjB6TWlwbjhtTkpsN3J5?=
 =?utf-8?B?M1FVUGZCaWxDRHVKRmpkRlZXUlhxUGpKTll1SjlXbHVIaExFLytoM3MzMmps?=
 =?utf-8?B?MnNXRFRYUmpJSW5rNjFwM0Q5Z2h3K0FiajRNbHRPRitCUDdLSzNqUElLTU5w?=
 =?utf-8?B?WFRURkRCK0JEQU4xRExoT3pvUTBGMktqdGNIeFVkWEt0M0VLdzczNk1DS3hL?=
 =?utf-8?B?ODZqNC9KQjBSZFcyTDY0SXl2OFdNSmJFS3g3TGpnRVN0ejRXVTREMy8yaGs4?=
 =?utf-8?B?YUpVQWlWcitVdURnQVBiMHZHN0JHbGFLaWNNUDcwNWM1L2c4YmpDUEFjUE1p?=
 =?utf-8?B?QU1BUFJGZnZ6dmpYeWt4c2pDby8zVzhlNmRocTRNV0NpeUJENUtWWFJNcW9I?=
 =?utf-8?B?cVlBZUI4UEFRSzl1Qmlxb0lvalJ6Y0xBSzdSZE96VzZ3VGNIZktxZTg2bkdQ?=
 =?utf-8?B?ckg5OHhtcGdwZENsTTRraVF1KzdKamtFa1hhVDlUbXdWeTJ2MXV3Ynd6dk5L?=
 =?utf-8?B?VDBpWmdNa2hTVm9QZjJsVklGNThxQWtReUtmd1JFd29sbDV0bzIrdU1uY2Yv?=
 =?utf-8?B?aTB0c2JPRG1EZllxcTcwcFQveW5SRVdidUY4cWhTYWc2S1pDMGVnRU9icTZ6?=
 =?utf-8?B?b2VWUTJrV1RDVGxiZnMvN0RjYUpLbXhOMFd3OTZQMmtjdmdLN3NJSVVoblZ6?=
 =?utf-8?B?NXBaR2VJcXRPK0pIcVNHVEVPaFYvamxHaUo3Z0dsaDB4OXFXVStnN3E3a0Ry?=
 =?utf-8?B?a0J2VHRQL1pSVmFHejlFcngvSEZjaGU3K1k5OHRZQXRFTnNRMmluVHh3T1FX?=
 =?utf-8?B?SWNQd2RuWHhYS1owU0Y4anZ6elVPQlphd25CMUpmMUcybi92d0k1RzlSSHE3?=
 =?utf-8?B?K2ZtYjRESUM4SHZ0NVNjdVNVUXI2cDEvWVpvNFlCSTZ6Y2FMSTNHSlpNc0RZ?=
 =?utf-8?B?ck1tSE1BMUpRQW9JWVhLTHRyeUFNcks2T0Z1UVRkR3R0OFFoTzI2WlNpZlBz?=
 =?utf-8?B?R1pLM296SVFvOHdhUjU5UWE3YjErb25udllPbWpGSUhzY0EyY2IrV3ZORndp?=
 =?utf-8?B?ajltKzNVeFNSMVptU1JPZkt4K0UrWUhvRU9aZkw2QmNMSzF0MFlnK0x4cUtj?=
 =?utf-8?B?WVFiT3A2TmxENWcvZjB1RkVreUJKOXJmQ0hKVW0yZUUzZWhvNXRkanpWTFdS?=
 =?utf-8?B?RzNHcjVwU040Yjh2ZWFyaDhnZTlyRVM5cVIvSlgrU3lKRTJiQS9FZkV2LzVo?=
 =?utf-8?B?dE8xTGhBOTJsb3VvU3IyaVEzTFplVDlobytkVCtaNjBIeUJUeXdydVJ4cStn?=
 =?utf-8?B?akJLbHBPcnhLcDl6Skc4VEhNSWxPQnU0eWVJdEROS2pkZ3JPWlJFeHN3WlVu?=
 =?utf-8?B?RGluOGRlalc2K1JZTjdaTUxENy9abERkNVlra3hiU2M4MkFkaGh6cDMxM2hX?=
 =?utf-8?B?UUNVbC9XM0xmdU51RmJreWkzdmF4N29SR2hIK1hrUkRHSTRnb1k3by9tZnFO?=
 =?utf-8?B?dmxhdmNXODFQVWsrK2E4dTQ4TnVWcXdscVluak9VemZnV2dYVUF1TUpVcmg1?=
 =?utf-8?B?Q0RlMDlQSlhxem9PN21sSXdtRHVkcmlkb1lTUm5JZ1lWMndBdGZ2L1Jod0dZ?=
 =?utf-8?B?VlljakV1aVQvMWJtNjlKYnZseERGZks2a1YzUGwybGIyd2FkT1g5YTMvckpV?=
 =?utf-8?B?alZJRmJqRXlTYkpsQngrZVJSYjlLR1MrNmJ0YTJ1VDUvNnlBS0IySGdIM3Y1?=
 =?utf-8?B?aGMxeHVaOGdGeUwrMkNTWjhLT01ETzNaMU5oOVNZcGFML1Zrb1hOV2ZNNklp?=
 =?utf-8?B?S2xwaWREd1IwTHZFRjNoUy9QVjlXNjRicUpXODZYN3liQ2RwTUJmY0hZYUlM?=
 =?utf-8?B?YVdDY05tL09CWkg2cGNyUE1EVkpSbnhOeUlSUml6YXU3Z2k0RU81ZTE5WFBI?=
 =?utf-8?Q?4Rv4slLU3zw/0oWccpyXxFf3NgtgCQ=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR11MB3974.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(7416014)(1800799024)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TlVMbUpoaHZRZjF1MkhiVnhIVGpmU1M1YzBWNkREcU9Cc0NMMFdkUEFmcGdQ?=
 =?utf-8?B?cmhuWCt1VmNmRlJaKzdqK3pFdk5jRTBYenY3YlhveG9RVVZyL2RlTEJoSXdK?=
 =?utf-8?B?TjRxQzNubll0b2Y3Y2ROdURXNEtqcnhHSGJSQkRNYlluVVZtZ2pSc0N0MHh4?=
 =?utf-8?B?YlQyVXBMV01kbUpoeURHNkphL25YOHJPRndGRWdlTmNqVXlQb3REbnRIdU9H?=
 =?utf-8?B?SkxlQVEzbWJjaWU1dXZFNjZYOXlGaGxrdGlmc2xZYWRFdzdWdFVodkpuRC92?=
 =?utf-8?B?OXl1TVUzK0hSek1SbWJNODd5RTdUTzJzMVpFRWc5RzhDVW9mdlBJMTRXZHZm?=
 =?utf-8?B?N29VVHpSQ0QzRjE3VkFkbmRZenlSN2pTN04rdjhmaFJ5ZHQ1TDVmSDNkYnFZ?=
 =?utf-8?B?bUJLaUFERnpyUnc1TU1xbEVOLzdzdXZSZUxlS1BNSzV6T25CWTlkM2o2YkFU?=
 =?utf-8?B?bEFpWlkrOFJIRG5uSkhtQWUrZ2gzaWFMMXYzd3V2aUxrcWJwcHBhMHFqQVds?=
 =?utf-8?B?MGhOZ0dSRU04QXp1T0wxTEJGMjQxV1BIRmtTUWlWZ2NaNkpsd1Q4emZBbzN3?=
 =?utf-8?B?Y05NK0ZFT1BOUElCNmhTZXlvUHFEa2dERFVnc0RVUVZmajNDZnpyYjdjbHVO?=
 =?utf-8?B?RThYNWR6MHBwK3JLWlkwTFRVY2V1azJneEpiRVpBQXB4ckxETUtXN2lWdXJv?=
 =?utf-8?B?a21xdHphdm12aW0vcXJsUTFsTDc5V2NveU1NQ0Nic0dYVkJJMXVObzFpZEh1?=
 =?utf-8?B?SjVuT0VQbW02MndETTVQZ0ducVg5M2l3Qkh6UUFEdWc5Sm5ET0QzQXZlc2h0?=
 =?utf-8?B?TTYxTHJSYUhYek0rdGFlSG81MUZEaFM2VWFqTDd5YlZTeTY5KytQa1RvcWJo?=
 =?utf-8?B?WGpDTlI5anRBaTF2dzA2RHpZSE94cFNnS1ZmckV2bzU1UTVRNThkSUsvVDVY?=
 =?utf-8?B?dmk0czN5c0tMRU1LWDl4bXB3MzhDdEJTcEo4WHYrd0hJem5RRzdmRkJDaTla?=
 =?utf-8?B?Q2trOSszWVp4RFpNZlQrbDNuTE1PTG03a2NSS2NZT2FEblNBR1lVaWZuTVJV?=
 =?utf-8?B?R1dSQlp0R25OaWk4ejh2ditsZ3l5QmMxNHRua0p4YTUxekZJSTU1cHZielFX?=
 =?utf-8?B?SjkxSUMxRnJEWDZxOGh4dWFHaFZkRjJ5ZWRKV0g2SzlZYjFnOWUrUFMxdnJQ?=
 =?utf-8?B?ZG9IbGtHVVlUODdLTkZxMzE5MTZxTU90MCtNdGN4VEU4NGhRMWxYUkUrMFYy?=
 =?utf-8?B?dFc5ZzZpanhDODNkd3E2VnpSdk55ZDJPZ0JXK2RQUWhiZGJUbW9vNnZTUGRE?=
 =?utf-8?B?Q0ZyMTY0VHhNUnFuVklTTVMvaE5PdGhob3grRkZLd0VFRG5oMnk1MkZuOGsv?=
 =?utf-8?B?QTIySzA4c0JLV0dOQnJJbXROUk1TRm92aXZCT2RkL1laTVpJRzYxeTY3Q1h1?=
 =?utf-8?B?S1BOK292RHRFYXJqbjNXVnlpQWc5NDFDK3lwaDdIaEdnYjM5L3pxaHhrb2JT?=
 =?utf-8?B?R2pDODZtaXpkMk9OV3pzQnFUN2xCZUVYa2xSbllMT0JKemtuMFRSc2pnOUxt?=
 =?utf-8?B?ZkRGUFEvTDNhRmNESTBRMHl3RG1QYXJONkM3cFQ2M1N2OVc4Qnh3NWNTQ1M5?=
 =?utf-8?B?blpEYWtadXNKVTc2dC9mbGdiMm5PYjhrRkxyM1FRVExQWEdGQ3RKYWZNN2FH?=
 =?utf-8?B?Q0locFZRclBuK05Gd2ZMamt2MzJyWDFNWWI2c09KZkpDS1JXQlFPTkQ0V0ZW?=
 =?utf-8?B?R09wRG9BejdtcnZ6bnBsSnJDMGwrbmFKZUJWWEdNVmk0QTZVUFcwK0lFR2VR?=
 =?utf-8?B?KzdIVWhZTDF0ZjhaYW5wM1MzaXBqc3JaOXBSMDNZM2dUTUtSVGV3clNFNElv?=
 =?utf-8?B?anVzc0t6eU9QQ3hwSFV2UHJyaE1QcGw0RjZxakR5QXE3M3FPS1Z1d3JDOUNq?=
 =?utf-8?B?TlQvYXN0MGJTT0x2eThKc0h5bmpJYWFqYmc0Mzl3aU04Yk5BRjZ5YzMwWDZI?=
 =?utf-8?B?ZTl2MHFER3VJa3VxQ0hqNnUxekhWOWR2QVF6c1lSeW1KSTNuZFR0SFNZSDdM?=
 =?utf-8?B?cmcwek5obzJxbGM5T0ZDNFpKU1FOaC9ieDFvMEs5ZWtycDJGSTlRV2d5VUhJ?=
 =?utf-8?Q?3mYE3YuLZ9CFeaz43lwoecsIH?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR11MB3974.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23f011e1-4bb0-409e-f1bd-08ddd10d7b50
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Aug 2025 15:09:58.9725 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UdLO0sShiCPTbM+lN9K9/NdTiS72+U/BDalmjSSn5P9IjbieLoCk2oaDniGaRGYdW4I8P5xvEhLaBwzb2KDRUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5288
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.12; envelope-from=yi.l.liu@intel.com;
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

PiBGcm9tOiBEYXZpZCBXb29kaG91c2UgPGR3bXcyQGluZnJhZGVhZC5vcmc+DQo+IFNlbnQ6IFR1
ZXNkYXksIEp1bHkgMjIsIDIwMjUgODowNCBQTQ0KPiANCj4gT24gVHVlLCAyMDI1LTA3LTE1IGF0
IDIwOjM1ICswODAwLCBZaSBMaXUgd3JvdGU6DQo+ID4NCj4gPiBEYXZpZCBpcyB0YWxraW5nIGFi
b3V0IHRoZSBJRiBhbmQgU1cgZmxhZ3MuIEFuZCBoZSBpcyBjb3JyZWN0LiBTcGVjIGhhcw0KPiA+
IGJlbG93IHNlbnRlbmNlLiBJdCBtZWFucyBhIHdhaXQgZGVzY3JpcHRvciBjYW4gaGF2ZSBib3Ro
IElGIGFuZCBTVyBzZXQNCj4gPiBhbmQgaW5kZWVkIGNvbXBsZXRpb24gaW50ZXJydXB0IGhhcHBl
bnMgbGF0ZXIgdGhhbiBzdGF0dXMgd3JpdGUuwqAgTGV0J3MNCj4gPiBnbyBvbiByZWZpbmUgdGhl
IHBhdGNoLiA6KQ0KPiANCj4gQXJlIHRoZXJlIGFueSByZWZpbmVtZW50cyB5b3UgYmVsaWV2ZSBh
cmUgbmVjZXNzYXJ5Pw0KDQpObyBleHRyYSBjaGFuZ2UgSSBzdXBwb3NlLiBJIHdhcyBqdXN0IHdh
aXRpbmcgZm9yIGEgcmVzcG9uZCBmcm9tIFZULWQgYXJjaC4gSSd2ZSBub3cNCmdvdCBhIGNsZWFy
IGFuc3dlci4gSXQncyBvayB0byBnZW5lcmF0ZSB0aGUgaW50ZXJydXB0IG5vIG1hdHRlciB0aGUg
c3RhdHVzIHdyaXRlIGZhaWxlZA0Kb3Igbm90IGlmIElGIGlzIHNldC4gU29ycnkgZm9yIHRoZSBk
ZWxheWVkIHJlc3BvbmQuDQoNCj4gaHR0cHM6Ly9naXRsYWIuY29tL2R3bXcyL3FlbXUvLS9waXBl
bGluZXMvMTk0MTMyNDY3NCBsb29rcyBsaWtlIGl0J3MNCj4gZ29pbmcgdG8gYmUgY2xlYW4sIGFu
ZCBJIHRoaW5rIHdlIHJlc29sdmVkIGV2ZXJ5dGhpbmcgd2UgdGFsa2VkIGFib3V0Lg0KDQpSZXZp
ZXdlZC1ieTogWWkgTGl1IDx5aS5sLmxpdUBpbnRlbC5jb20+DQoNClRoYW5rcywNCllpIExpdQ0K

