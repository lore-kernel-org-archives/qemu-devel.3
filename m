Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DA0EC3DA41
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2024 14:14:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRuYI-00027l-KV; Thu, 11 Jul 2024 10:13:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wei.w.wang@intel.com>)
 id 1sRuYG-00027B-QN
 for qemu-devel@nongnu.org; Thu, 11 Jul 2024 10:13:40 -0400
Received: from mgamail.intel.com ([192.198.163.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wei.w.wang@intel.com>)
 id 1sRuYE-0004fO-FE
 for qemu-devel@nongnu.org; Thu, 11 Jul 2024 10:13:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1720707218; x=1752243218;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=SsLDrHz7FXis4xpCmmIAvi2utVxmlrHpq42fDuVzX5M=;
 b=DoFGNrijo8TKmi8qu4guz/oqVhNQfr7vO3A4cEj3CdO5gFIOX3TPYWLE
 OL/spZ84sKi3kWrKzTEyS+n8NXQp/TXaLV8tKjk3v8RPdPcVe65cavSZq
 cm2BhXr9Z376DS3N9Ef84xgcR04vHrFBowempCSkmmtVzqVTlDz1rDluR
 s/bOhj+P9BnbM19tJaqp8VZhoW0kbNkJCpBHRAZcC7talrXWun3+9e6jk
 xLPjWGMB6NYenM6dWfJYsTFFLyoIWPNXrqKUK/HAWRrUj6sZm5u4reUUZ
 YGMwi7YTUnsSKiEWjGXcixjKjt27ac3iiDilBGRNloUptkevEFqzCtph9 Q==;
X-CSE-ConnectionGUID: UA1e0hr8QIKycx3AvK/jXQ==
X-CSE-MsgGUID: 8CQAHrk+TGSHW4GJEIjOeA==
X-IronPort-AV: E=McAfee;i="6700,10204,11130"; a="18295243"
X-IronPort-AV: E=Sophos;i="6.09,200,1716274800"; d="scan'208";a="18295243"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Jul 2024 07:13:35 -0700
X-CSE-ConnectionGUID: hlkyFiikQI2Q4XgIn734cQ==
X-CSE-MsgGUID: c3kA4s7SSxWAojw2kbwZAw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,200,1716274800"; d="scan'208";a="53162158"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
 by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 11 Jul 2024 07:13:35 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 11 Jul 2024 07:13:35 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 11 Jul 2024 07:13:34 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 11 Jul 2024 07:13:34 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.40) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 11 Jul 2024 07:13:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y7gflMreSkvk4EqYFaXypCNFVm6ocV2X7M7JFYTyILFo4yDW9S067ple5OC4/ILScG4jiD61NJuBTqikL1CXyNO0G16cqrJSBB3QeuHdLULXOZiNh/we8HanFdLIdHhT8y6+132eEUqfoVN5BUBfbl2lz1LZgIkHRrAPe1VhoHxDX5AvHlroNYQIiin+uubEGyVD3GyBuaJCA+p0KOL3pVupR2ujAJTGxK4ocbygKE8VHD4j4kkdA+bq1WjFuJrqAU2u4mKGtZqj+A2hXDceIdeizG5E0lV/+z7EE3xqjGhFpiDyl5XPe8F3zpmVk1e3uJL39VNy6uZi8T8lY8Werw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SsLDrHz7FXis4xpCmmIAvi2utVxmlrHpq42fDuVzX5M=;
 b=QGWShNdnerO9SlPEJheadcw+HoIPtci4MQ8EzaKsgNDICDfjg7yThavIFHREp+AVl/ecdWmCkzJgzccrzIkz27WP2gz93MesrgxK9hl3mA9Q1ODhiVootDacv2o0jkPtqP3dU3KRX/TJyK+mvBZ9U427CYwDTB2EHQK34VFLQu5xx8DZBqSAjvOPpZCTShppYXNETySBnq+bvRinfwiVTvj3dNJZg/1vZYMq8PPuaOeuM+axZbbSv2cZkXj6jBhsoTANAsegStSrvnNWAUuFbfjsYxQWUlJOCFecTbys+6D+j3pv2AfmOHmtroOukbyr05wKK9sQqrVyqmtZH9f6Qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS0PR11MB6373.namprd11.prod.outlook.com (2603:10b6:8:cb::20) by
 PH7PR11MB8480.namprd11.prod.outlook.com (2603:10b6:510:2fe::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7741.35; Thu, 11 Jul 2024 14:13:31 +0000
Received: from DS0PR11MB6373.namprd11.prod.outlook.com
 ([fe80::2dd5:1312:cd85:e1e]) by DS0PR11MB6373.namprd11.prod.outlook.com
 ([fe80::2dd5:1312:cd85:e1e%3]) with mapi id 15.20.7762.020; Thu, 11 Jul 2024
 14:13:31 +0000
From: "Wang, Wei W" <wei.w.wang@intel.com>
To: =?utf-8?B?RGFuaWVsIFAuIEJlcnJhbmfDqQ==?= <berrange@redhat.com>
CC: "pbonzini@redhat.com" <pbonzini@redhat.com>, "peterx@redhat.com"
 <peterx@redhat.com>, "mtosatti@redhat.com" <mtosatti@redhat.com>,
 "farosas@suse.de" <farosas@suse.de>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "Wang, Lei4" <lei4.wang@intel.com>
Subject: RE: [PATCH v1] target/i386: kvm: Block migration when enfore_cpuid is
 set to false
Thread-Topic: [PATCH v1] target/i386: kvm: Block migration when enfore_cpuid
 is set to false
Thread-Index: AQHazVg5C0RiDxJPOUeRPpagSbRqXrHxdZ6AgAACIHCAAAhAgIAAGvkw
Date: Thu, 11 Jul 2024 14:13:31 +0000
Message-ID: <DS0PR11MB63736018180E286CC7D36167DCA52@DS0PR11MB6373.namprd11.prod.outlook.com>
References: <20240703144912.130988-1-wei.w.wang@intel.com>
 <Zo_GZfR1sQH06TCp@redhat.com>
 <DS0PR11MB6373A148EDE4EB3125B6C42DDCA52@DS0PR11MB6373.namprd11.prod.outlook.com>
 <Zo_PGVjbRHMfe-Gf@redhat.com>
In-Reply-To: <Zo_PGVjbRHMfe-Gf@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR11MB6373:EE_|PH7PR11MB8480:EE_
x-ms-office365-filtering-correlation-id: 65df37b0-d5b7-4376-1b2b-08dca1b3a4cc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?ZmU5aURlSGZ5bllrdEZXTVZGU2NnaEMvRG41cFA4NWFtM0ZGMEMwcGF1c1pV?=
 =?utf-8?B?NnBXL25SelJtSG15ay8zcFZMU3d0MFc5Z285R0lkR3Q2NHVod2l1THFXeVF0?=
 =?utf-8?B?U0ZkcmUwaTNORWxKY3ZkV2hOMk51MmpCU0Z4bkxCOFBmVkt4WGNDTmpHb293?=
 =?utf-8?B?eDd4OEs1RlNVUTh5cDZDSzdPVHlwNmdSdEY2cHp0RFFMOXBtN3FmTkRINGNR?=
 =?utf-8?B?T0NnTExOTWNmN3Njc0U4YnVPeG5kTm5QSmJseGNkUUN4VzBhUnhJdkZxamww?=
 =?utf-8?B?cHEzallJL0FGeERTdlFQMnlnc3hPRW5QK1BGY1R5SU5OTkdXTmJWTVdmRUNO?=
 =?utf-8?B?QzNIcjYvNlpsREQ1NEZ3dnVnMVlJSnA2R3VrMFJMcS90UlZLVUlzWk56NG5D?=
 =?utf-8?B?bE1SWWE2eXBGQnR2d1ZSbmpvWUsvWHFCc2lUbndjbkgybzdRMGZ4MGszcHQw?=
 =?utf-8?B?VTNDY2svLzhsZzJNcWFjcC8rT2p6ZHpDdVIrelZQd3dnekkwVmE3VWpNVjJr?=
 =?utf-8?B?QXpwQTV1eGVVa2tZZktnck05V2c0aDAyQVhvd2ZheEZaZG1Ha3FmcUdLak9Z?=
 =?utf-8?B?VWNYbmpKNENOU1RIWEhkMDF1MVZqdUJUVUUrSFpvVlRtMVBjWUdsb2pGMmY0?=
 =?utf-8?B?d09Odk1rc3Zhem03Tkw1Q2lJVWZ2N0lIdlA5Qy9Yc0U5Unp6UDdRaHRmOHZi?=
 =?utf-8?B?Wncxb2orVWNGL3IvcEFOOVVod2h1VkgvdUZmM05oL2tpYUlxbUx1TzUvNXdQ?=
 =?utf-8?B?K1hDNU43UjFrN2k1czkwWmRid2oyUWtjSEdJZjhtaVVoM2xxOExUNnJETXAv?=
 =?utf-8?B?ZWFzSmdxMy9UMU1VR3ZPZzh0Y3BzMHRpSXdaem5Yd0V3a1dBMUtWeWwyUzJS?=
 =?utf-8?B?RXNrbnE0K1h1dkJQNGs3dVQ2MkFEYnhaVVFOeDlGSFI4VUpQamJRRUdocDEz?=
 =?utf-8?B?VlpXd1lEbUhpemFlVkVZYnJGWDd4SFE2TTZiT09XRk5xczQxcFhQalBsZHFP?=
 =?utf-8?B?K0V6L0VsQ29aODV0TytnZy9HdGowc3JMV0Zia3JPSlVIWnpHTDN2dlZrdzNG?=
 =?utf-8?B?emlydnpMdWZsMG9nSUx2UUw0YUVZcHk3ajhSYUsyWmc3YUVoQ0hpNHdHT21U?=
 =?utf-8?B?SFY5cjJ1TWxKZVZRUitkZC9pcFA5dzVicXcwU0N1WHVFek15SU15b2VnS2lU?=
 =?utf-8?B?emI2ZWpLUHVhdlVFbnBYcURldCtHSW8wQmhqcWtlMjR1N1FISnpCcE0xZGJC?=
 =?utf-8?B?WWtaRmoyMkJ1Y2o4a01tSDEyYndvc2htbzl3Q2IrU3RZcmZGVnd2eCtsWERh?=
 =?utf-8?B?U2N6OTU1U2RjeHZSY29VZGFPZlVFZ1EvWHR1R0hJNnF3WUpKVDY3bEx5Z2lo?=
 =?utf-8?B?elU4SG1BZFdIMEt3ZWdTVXQybVkvU0VtcjJ1THVOQm9sZW0vaENxcjNneGdi?=
 =?utf-8?B?MUpTZEsrZzR6UmhuL3VZVWk4ekJKemVVdGZSbmxvMmptZmEvbHZnOU1FL0tx?=
 =?utf-8?B?enpRalBhbFNSWmw1VFpSOEtoWDRjYStrWEhhY3psS2pGcjhPUG0zM0QySFVV?=
 =?utf-8?B?Ly84Qm5lRHpwVWZLR1RVcHRnSC95ZlgyNlZOUXAyenZiSnlJbytyemVIZVJ1?=
 =?utf-8?B?eDVsZHZWNnNJWjYvUUZaVTc1ZzNuV3BMbG1xNDZ2c3A2ZHJzUTMyREJ6YXI4?=
 =?utf-8?B?UFl5aEZxZzdCK2c0UHA1WkN5WkV2RG5hMEdyeGJNYWVsS0JUOWtyTFVVeVlJ?=
 =?utf-8?B?TmdZRCtQMXlZNFhMQklDc2d2SUV1Y241Wjl3RHBLZVNrMTgxZk9XaElORURM?=
 =?utf-8?B?aG5ReCtIQ0pWRXdWS0N2YnA3Y3h1RmZPRnhSUWllSElQKzEvdmpvWktibzFE?=
 =?utf-8?B?V2J0Q1hWa1grUHc1a0VpV1dOSGVkNGxJUmJTQ3Ztb2w3Smc9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB6373.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?REpVNlhHbnZHT0U3WEVZSzZySGhwMFkzQTdpNFNodnJYWTlPdkpjKzRBU0xu?=
 =?utf-8?B?SGxMVE9mRkU0YUszZFFKL1JEaG12QVNJMlV6NGtpZTkxbmhwT251Kzk5Z0VF?=
 =?utf-8?B?bUNPTEZ5enJ3R1QrNi9NVVV4WXZrV2FQTUkraWltQ1hueFJjSnJvV2JKTWR3?=
 =?utf-8?B?OW1QWHBVdUxJNEpJb2QzUkZ2VDIxSTVuU2xWMWhMaEhKY1FZNUowK1h3WTNr?=
 =?utf-8?B?NW0rWkc0c2xyQmcyWlQ4MWg0SGp0dFFzRlEzK09OS3dCdEIxZC9hUENISnZL?=
 =?utf-8?B?YWsvU3NNVGdyd091Wk5Tb0NRdTNMdDhGSEZ2MVVSZUV5d205T0g4Z01YNEN4?=
 =?utf-8?B?eWpRT0RBdEhTUEd5Sk1EZDNmT2JsVytORnB1RE0zSFZySWs1WFdLVTVVS0l2?=
 =?utf-8?B?WDFnQ1MrL2Y1Z3R1akkwbGpabkFnbHBqbitFQm1USjZUSzN3b0RnTDhlZVJ5?=
 =?utf-8?B?clZNQWV3MDVtYy9KbHVPdVRwVER3cjZESG5vQlZ5QXJmaWU1R2g0Q3Z6Q1Mz?=
 =?utf-8?B?cVk5cUFmS0RNeDl2OE1BQ055UnlNYzNaZ3VlK3kwYlRRem1lUGZrS2R0Yk5L?=
 =?utf-8?B?OEd1blJuRWZWSDk4TUFpcWVWU1hENHNMSjgxMmJ6ZG1kTjJvc29SbUkzRjVN?=
 =?utf-8?B?YzdJakZueTdHT1VYaW15Wk9tVlJjVDRRZXFHRmtraTBLREI3RTlUNU1XbzNC?=
 =?utf-8?B?bnd4bUU1dk95UG10NkpFcjE4K1NNRnk1OTA2N0crZmpMSjhvVXpvZG83bnk0?=
 =?utf-8?B?K0o5RHpmSnVhQXhKZ1Vjck9IWklEYjJXMHVJZ2piZWZQaVBwbkZaZVI3aHVP?=
 =?utf-8?B?elFZWHRndVUwOWZJOWVPeUVRRlFZUWNQZnpod2JqaDU5SnVIazV2ZzRGYnlD?=
 =?utf-8?B?K1Y0Y3FsN3JPcDRyTm0vN0NiNWRiUmVyN0IwcXhqdW1CVDRJQThRSWVwKzFz?=
 =?utf-8?B?K0Fuei96UytqWlJ0ci9LMTgvaTA4TVJoOFNKbkxFL1d0dFdrRFYxMUtqMkFz?=
 =?utf-8?B?bmFlY09QNk5HMEtYckxXdTNtaStZWVRQNncrdkpmOSsvRFZVMmd1VlF0OGs4?=
 =?utf-8?B?ZVNuY3FZMWExakRjcGU1SlQwQjhWMFpDUStjN01MRWV4ZjlMMkljNTdzNm9y?=
 =?utf-8?B?TUcxR2VsdHpsbGNuQk5KRUQ1NkhHRzFJMWFRK0VGMWVPNWRpdVFRdmR6Skdq?=
 =?utf-8?B?QmlDeTdERHpUbVBRVGJnbG9NajhFMXRDSU44eWg5andYeEhDN0l4Sm5CZ3Zt?=
 =?utf-8?B?WEowdjNpd3dTNnJVeFdzR2J6Q1Z6ZDRmcFdpb2E5M2xoUG4ySktVeGo5d3A1?=
 =?utf-8?B?WTBCN0EvbjBjRlB6M09lbDFsdHh6RnQvTFZLUDhyOE8zZmZZWWVCNTFsTVY3?=
 =?utf-8?B?VVpXOTBYSGFYU0F0dFB1c1dSdlp5K0x0aElVK0s2VFVPRE4yTVVzeExYMUx3?=
 =?utf-8?B?SXBMVmZZSFpOZGcrelJEYjBhS0M1WWtJc3NCY0tZZzlxeVF5Zzl0WlcvVERv?=
 =?utf-8?B?ZDg4VjRxU3Z0OFZibUx0TUhzdmIxUmZ1TUEzZExlN240d1g5Rnk5c0U3SHZW?=
 =?utf-8?B?eDFDbTZ6am9GUFhqTk9zcVJHQ0R6THQrQVgrTjRWSHhQaHhScUlHYmQyamVF?=
 =?utf-8?B?Z25ZdEZ6Q3ljdDk0WU4veFZTV2toRFY0QlFoTTB5ZzE5QjF5RDIwRnZXVkdZ?=
 =?utf-8?B?SUZYYUV6NDZJOUVZWkRHUnhrdjBoNkdPcG9hNVppdjAySzJTR1N6T2dzZkIx?=
 =?utf-8?B?eE96N1VpUkpPWFhLVlVLaTh5Z3F4U3NhTjV0WmtPK0hBVlVlYkhWQUFDL2p1?=
 =?utf-8?B?cDdVZVFteWhEemFUTzljYjZOZ21LVFVFU2hRWDFWcjVldlVuYzJTeHNlNW51?=
 =?utf-8?B?dmdhMVNIZFZDak55NDA2NytFaVlIY1hwVTUzejhORFljMUNVTzY0TWt5WjZw?=
 =?utf-8?B?c2pUVGhkRjVOSUNYRDNKQWlTeU1yMUQvYzI1R05HdWFXczdWZ0V4bUl4dW4v?=
 =?utf-8?B?Rjh5dXlOMEJTT3g3Y0VvZEw5MXRFZkpkR2hJZ0hFWGZCSzFyNzV4NkZ5SnFV?=
 =?utf-8?B?RkdlOTAwbDhoSWpxcTlHL1Z2T085VFJkNzZUc1drNFVTR3ozVmVlY0FVSVRU?=
 =?utf-8?Q?sGhj6rTMjuOHGQTUNmzohXlnU?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB6373.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65df37b0-d5b7-4376-1b2b-08dca1b3a4cc
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jul 2024 14:13:31.5581 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iWW0QIPbfr3dvTECjOtPXYR2vWOe66pXg7ULkOM1RJWOWXoGlbvpNnYFI3taMSNVvNpu3VcKPzJO7+fJWGhUMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB8480
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.14; envelope-from=wei.w.wang@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
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

T24gVGh1cnNkYXksIEp1bHkgMTEsIDIwMjQgODoyNSBQTSwgRGFuaWVsIFAuIEJlcnJhbmfDqSB3
cm90ZToNCj4gT24gVGh1LCBKdWwgMTEsIDIwMjQgYXQgMTI6MTA6MzRQTSArMDAwMCwgV2FuZywg
V2VpIFcgd3JvdGU6DQo+ID4gT24gVGh1cnNkYXksIEp1bHkgMTEsIDIwMjQgNzo0OCBQTSwgRGFu
aWVsIFAuIEJlcnJhbmfDqSB3cm90ZToNCj4gPiA+IE9uIFdlZCwgSnVsIDAzLCAyMDI0IGF0IDEw
OjQ5OjEyUE0gKzA4MDAsIFdlaSBXYW5nIHdyb3RlOg0KPiA+IEFGQUlLLCBtYW55IHVzZXJzIGFy
ZSBub3QgYXdhcmUgb2YgdGhpcywgYW5kIGFsc28gd2UgY291bGRuJ3QgYXNzdW1lDQo+ID4gZXZl
cnlib2R5IGtub3dzIGl0LiBUaGF0J3Mgd2h5IHdlIHdhbnQgdG8gYWRkIHRoZSBlbmZvcmNlbWVu
dC4NCj4gDQo+IFVzZXJzIHdobyBkaXJlY3RseSBsYXVuY2ggUUVNVSBhcmUgZXhwZWN0ZWQgdG8g
a25vdyBhYm91dCBRRU1VIGNvbmZpZw0KPiBkZXRhaWxzIGZvciBtaWdyYXRpb24uIElmIHRoZXkg
ZG9uJ3QsIHRoZW4gdGhleSBvdWdodCB0byBiZSB1c2luZyBhIGhpZ2hlciBsZXZlbA0KPiB0b29s
IGxpa2UgbGlidmlydCwgd2hpY2ggZW5zdXJlcyB0aGUgY29uZmlndXJhdGlvbiBpcyBtaWdyYXRp
b24gY29tcGF0aWJsZS4NCg0KQWdyZWUgdGhhdCBsaWJ2aXJ0IGhhcyB0aGlzIGFkdmFudGFnZSBh
bmQgaXMgbW9yZSB1c2VyIGZyaWVuZGx5LiBCdXQgaXQgZG9lc24ndCBzZWVtIHRvDQpzb2x2ZSB0
aGUgaXNzdWUgbWVudGlvbmVkIGJ5IHRoaXMgcGF0Y2ggLSBpZiB1c2VycyBkb24ndCBleHBsaWNp
dGx5IHNldCAiZW5mb3JjZT10cnVlIg0KaW4gbGlidmlydCBjb25maWdzIGZvciB0aGUgZ3Vlc3Qs
IHRoZW4gbWlncmF0aW5nIHRoZSBndWVzdCBhY3Jvc3MgaG9zdHMgd2l0aCBkaWZmZXJlbnQNCmZl
YXR1cmVzIGNvdWxkIHN0aWxsIGJlIHJpc2t5LiBVbmxlc3MgdGhlcmUgaXMgc2ltaWxhciBlbmZv
cmNlbWVudCBpbiBsaWJ2aXJ0IHRvIHJlcXVpcmUNCnVzZXJzIHRvIHNldCAiZW5mb3JjZT10cnVl
IiBmb3IgdGhlIGd1ZXN0IHRvIGJlIG1pZ3JhdGFibGUuDQo=

