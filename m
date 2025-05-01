Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B2C5C3ABA3
	for <qemu-devel@archiver.kernel.org>; Thu,  1 May 2025 05:48:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAMmA-00048Y-LD; Thu, 01 May 2025 01:48:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1uAMm8-00048A-8U
 for qemu-devel@nongnu.org; Thu, 01 May 2025 01:48:00 -0400
Received: from mgamail.intel.com ([192.198.163.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1uAMm6-0002JC-82
 for qemu-devel@nongnu.org; Thu, 01 May 2025 01:48:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1746078478; x=1777614478;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=YDPITxoYLRxx+r1X9Zcrpfiknsi2TzQ3omwotRmG8hI=;
 b=ePVvmeg24wC0XAUBrWFw4Iw3HkNL7gWjieyKP6MW/dipJPOJT/JQR3u9
 +lDl26ZmuATji7oea0+6JdPCsx88WNh1AlH0ymZxZGfnn+eET1v+IjiDK
 DOhleq+9dU5innVMThOTENYN0AVhyP9ZqT1Gi1a+mwwat5BlVtXbzDHDH
 IKc/560SGLJRQW+17/YGJhWpAe+o0SIGL4WYynZnpNFV7rZZtAO2T9Ghx
 fJfJ/1YuEMZYku0YCCFhUK5OAnIeYgfYw+L0kJaUk8MrshTBSwHPb/zYg
 LLaIo7TuhG7hU1xkT+MYaQiVUiDOWmHfsheJM4tl+CcrB2Io8hV+fT7pn w==;
X-CSE-ConnectionGUID: Y43BjfOcSZ2RUikvwCXJCg==
X-CSE-MsgGUID: IpFRNRnQTNiujaIJ16uj6A==
X-IronPort-AV: E=McAfee;i="6700,10204,11419"; a="58380789"
X-IronPort-AV: E=Sophos;i="6.15,253,1739865600"; d="scan'208";a="58380789"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Apr 2025 22:47:56 -0700
X-CSE-ConnectionGUID: RYc+JYaiTXu0WWE9V7fvvw==
X-CSE-MsgGUID: MubnEarlQ4qiXY7Our6UlQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,253,1739865600"; d="scan'208";a="157540839"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Apr 2025 22:47:56 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 30 Apr 2025 22:47:55 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 30 Apr 2025 22:47:55 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.176)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 30 Apr 2025 22:47:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LT1HfVeY0vsG1oo1SNkY+4tJRZVBLFqoSXCdugj6pk0ypk+8mngDqeJNjykaP7HQDIPFb1g5B5wRqq4JFkfD7D7UUuQ5erxHKTXSbpfhrLFaOHNm0A9dWpiCb/k31ufxUI/mq3I4u22hZ07g4hNYDMTi/KICwQzS2s8DzPKI6cxjFFb6PMd6rx9pf6YpacawvIjWA33LupzRk0PUG6CFlDJ4ORkbB+tYc/XtXLxXSVBEQtxrs73hDo9GmNzbODkmfFivXPuY0uefGWxcmZ3fHobhB31Mu/uSf4FnLtoQdLRh0/OU1ETsX6XuWsBFphcLX+qYFk/Z/ZH4ZJ0nrp7EeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YDPITxoYLRxx+r1X9Zcrpfiknsi2TzQ3omwotRmG8hI=;
 b=yKyyRdpiZODj6d3c2cyIalQ91qJxyS+3H0RPs3OJq6t31J/KZixp4V10rg2dNXD6akPGtkG4EMGqyEaT/km56q7G48+D1MOD1zIsrMQNcyBigxGxZnWXOKeqCH/kkfZA1JOaAyafmr0Lf/G6SUOPS4h4wYafo2SCUlzFWkpiY4xyyGyoAaeHjQPHarQQ39QW15gub+FXcJwTo0nG8sD6Lyh/b/s6ryqF6LD1n8L4W3frBGz9i+o/K8YiwNVIzfBfMCSUqAbvwQxRngsrx8vROLsdYyKoh863Ot+lYQrwNtaYom3nL0Hd7GyVhAyiY1lig2MDe2Tpka68gTuXrUAHTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA0PR11MB7185.namprd11.prod.outlook.com (2603:10b6:208:432::20)
 by IA1PR11MB7248.namprd11.prod.outlook.com (2603:10b6:208:42c::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.19; Thu, 1 May
 2025 05:47:53 +0000
Received: from IA0PR11MB7185.namprd11.prod.outlook.com
 ([fe80::dd3b:ce77:841a:722b]) by IA0PR11MB7185.namprd11.prod.outlook.com
 ([fe80::dd3b:ce77:841a:722b%4]) with mapi id 15.20.8678.028; Thu, 1 May 2025
 05:47:53 +0000
From: "Kasireddy, Vivek" <vivek.kasireddy@intel.com>
To: =?utf-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Gerd Hoffmann
 <kraxel@redhat.com>, Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Frediano Ziglio <freddy77@gmail.com>, "Kim, Dongwon" <dongwon.kim@intel.com>
Subject: RE: [PATCH v3 5/6] ui/spice: Create a new texture with linear layout
 when gl=on is enabled
Thread-Topic: [PATCH v3 5/6] ui/spice: Create a new texture with linear layout
 when gl=on is enabled
Thread-Index: AQHbuM2x0IhJktYtR0uoJJ8qSAS/gbO6RvIAgAEHiSA=
Date: Thu, 1 May 2025 05:47:52 +0000
Message-ID: <IA0PR11MB7185DE0C590C027FE8498C66F8822@IA0PR11MB7185.namprd11.prod.outlook.com>
References: <20250429060952.59508-1-vivek.kasireddy@intel.com>
 <20250429060952.59508-6-vivek.kasireddy@intel.com>
 <CAJ+F1CKxjHW773h1HaVH4o4SD2uWL=xnCBWutWN50FwxR-whGA@mail.gmail.com>
In-Reply-To: <CAJ+F1CKxjHW773h1HaVH4o4SD2uWL=xnCBWutWN50FwxR-whGA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA0PR11MB7185:EE_|IA1PR11MB7248:EE_
x-ms-office365-filtering-correlation-id: 85fca1a3-f56e-4862-845a-08dd8873b706
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?OEpYN0ExM1g5SWNuazA2VHpnZUZpL0ZZd3Z6ZjhyQy9IeWhLSFZCNzJXcVJT?=
 =?utf-8?B?Q2MydjF4b0NkWm9taUtBN2tUd2V1NmsyMGVxTko5MzhUcjE0Njg4akN4UGZG?=
 =?utf-8?B?c3FyTjBvYVZTU0VwQ3NocGpYMVlxd2R5aEx1SjFjMnNxRGg0WUJHaFZXelhk?=
 =?utf-8?B?STluNVhpYWEwak4xZ2Nsd3k4eTV6M3hKMW4zZi9jNUsxK215TmpqdnljYWV3?=
 =?utf-8?B?YTN1MDdsdGVuZk8vKzVkV25lSlhWcGV0R1Zyc0o0eUlJejdpWXJMQStkNGxr?=
 =?utf-8?B?dHNRV0xHU3FtMzVGY1pTOTdjdlpiRk9uLzVQU3ZJbjRtUUF2cm9Mckk2ZDFI?=
 =?utf-8?B?MVpPZk5CS2EzaDd1SHU2VkQvSDlqU00vL3JzdmlEcTZoYmNmYlNVZkFqelNX?=
 =?utf-8?B?aWdON1pZT1E2TlIveDVLQUY2Y3dWSmc2TVczTnQ1UzdpUFlZNFE5N3JPNEpn?=
 =?utf-8?B?Uk9HcU5LNXZxSWNaaytLUmd2Z25kd2R0RWVPMjZpOGdwN2JHNmhZMnI1T3Uv?=
 =?utf-8?B?SUZTbHdteThxaHRHRG9EeTQ3Z3RHbTI4RlBxa29PMW9OYUtvWk03cHBGNCto?=
 =?utf-8?B?TnJLd3JNODBLOVp4c2dlazhzdDRBbC96K0xxTXhYem9FcEZwZEg0bHRkeDBM?=
 =?utf-8?B?Ym9UNEQwU1JLcm54YUlNWWk4RVdJaW4vNHUrTU5oVndzcThVOTdNVkV0RlFM?=
 =?utf-8?B?dmZyZ3BsaHQvWkt6NVFQTlFRa0xJS211a3JCOEY5b0t6SlpTRTFJaHl6SEN6?=
 =?utf-8?B?U2VsdCt0R0MwM3F2VmIvMWN1TTRFUXVVbGxsaEc1ZlhocmZhNURIS3Z3VXZU?=
 =?utf-8?B?aDB4Y2w5NGNVUWpEeDdLdmg5bTJxWUZBWUM1M1BlV3hudE42b0wyT3JkR2NL?=
 =?utf-8?B?OTlHMWh6YlFrd0tZNjhzVE5GZDhyMFhCUE1ySHZUQmtpVVF3K2xNdTZYTDda?=
 =?utf-8?B?cDNhTi9UWEI0SXFQYmxmQ0F1b1Q0MjR4bERVb2IvNHNEUFRMQ1J2QjQ3Y29D?=
 =?utf-8?B?THJ6VzhORXJoNDd6U3VRN0FxRVN1OSs3V1kzTHkrbVNDK1VSWVpGZjlYZWFD?=
 =?utf-8?B?ellLTVdDbEZhUWkzaU9TRzlnNmhzdVpwKzdFS01ESGQ3eGwxOHZjU0JnTXM4?=
 =?utf-8?B?cktrZTZPK0Frb21YVElscTR0Mmx1cUlsaTBZc1ZpcnJOM0MyWjA3Z1EwNll0?=
 =?utf-8?B?QzYxSGxSYlQ3VkowN2Y5Njc1WWNsaGdsVXJCZDFvT3hiSzB2QXdzMzVVbVhC?=
 =?utf-8?B?cThEOWZsajlQRzdJRkRIZ3dOUUJLWEVncWdBeW1zZlVNVUk1TWdScGhOYXFH?=
 =?utf-8?B?QkZHTHpXK0RuQ3FwUXU2Ym5WV0U3OWRBOTBPaDFWRzdobFFyQkMrVUhVSFpS?=
 =?utf-8?B?UUswR0I1NGJGVG5UV3lubjQrMEFaNmtSNWZESU1rVXVjaHMvTkdDRTBZbzF2?=
 =?utf-8?B?cEpmOEJJT05nd3A0SUl4ZUN0QUlrRmZ4ekZnWndqeTdhVkgwOC90ZnA2RGFI?=
 =?utf-8?B?OXFhN292SytUcEZFY2svbEZ4VndTRGpZT0FINllYSDQ2RVRYT3JQVUUwYllD?=
 =?utf-8?B?Rld4TnM5OEdDWWQyMS9RMVRydEpRbGxYalhDMkZyZUdmcHhnbVBNb29Eekc5?=
 =?utf-8?B?S0ZrUk5wSkcwSmhURHJTT2VwN2N1Y21FcmFadXBpNlRZVEpoT0FLZzhuM1la?=
 =?utf-8?B?aXg2Sit3WmRBWFM0UE9RWG93dEhUTkpXWGswNEw2R2t1cGhvSjNhT0FjVWpV?=
 =?utf-8?B?Q1hScTFHaW0wT29ya2dBdER3WkNTUnBLcTY4RXhqajJ3eWdlTmI5bWIwZ21n?=
 =?utf-8?B?N25rRlhJSTBTSUgvSEJRdmpwbUpjb3dSUkcrTnIvc01zTnVIS0gyNGF1dzZP?=
 =?utf-8?B?SmMrWXJrVU5uangwaXU1RkJLR0pCM1VFZThGRndkckM5a3RoVEV3R3RPRzRI?=
 =?utf-8?B?ZzZUSldUZXhxbmUzUCtzZXFIY0hZSFhiVXBsOUtDdVNHcHNLTVY4dHVvYXZL?=
 =?utf-8?B?UVZ6bzJGczBBPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR11MB7185.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UDl4Ly9IbEFja3MyREx1TUJJNlFwK25XU3JlTnhJaGJWdThCVHg4dVZuUjNq?=
 =?utf-8?B?Nk4yb1RjZVd3U0FNMGVackJocmpvM3h3Z05nNlVXakpJTU8rMm1LSUdzSTBM?=
 =?utf-8?B?eDRWcDdIcWNmNGw0dGFpalV4cHBFMWJrMUs0eG9GNUwrcUlNU2orVmZnK3JC?=
 =?utf-8?B?U1hNSUZMYlBkZnAzeUJtK1VGeXl2T0YvZmRiSjdWM1Y1elBpS2x5bGRpem91?=
 =?utf-8?B?aUFUeG9Bd2F4VVZyOUZXQ0xmRk9GV05ydFdabzMxeXFRLy9JRDNrYmxoeFhy?=
 =?utf-8?B?TUlqUUxrRjJJRW84Q1I3dStUYURpMFFxaHZ0QXRPMGdWWGVmTnMvZnhvZkM3?=
 =?utf-8?B?UXlneWp3YkF5ZitUbmRZWnA0dlBpS2IySjNlVTdWREgrelhvb1h4TkhIWjll?=
 =?utf-8?B?VWoyZWJDNlYvYnpDUHlyeS91NTduNFMrQThJQndBWHdNa2pYVzh2N09UejBh?=
 =?utf-8?B?Q28wWEtPVk5JZEpnOHRkdFBoSjVpaHdjanhKaVh1azdENVJidkN2WFpVUlhM?=
 =?utf-8?B?SjFmQXkvRXZYZE5YSWxlR0xWMFhBQUlOTE03SVFyODY4ZXEzSkxiZGI2YTMz?=
 =?utf-8?B?dTNQZ3NlTmhOWVZHdEVjUm54VURzUnBuNW9PRGRqUWRNWW1oK3A5R0RxNVRw?=
 =?utf-8?B?aTMwSnRIVTFZRi9aVjhERVRscDVSak9rNU1xZEVObzYzdFpZSi82YXdVUWhY?=
 =?utf-8?B?R1QySnRYZ1NwNGNHK1N4ZVlZei9OQWk5ekl4bjNQLzh4WFh2TlhsSU14TWps?=
 =?utf-8?B?RDZIS3prM0V5TEd2bUU5VmoxVmZ6WmgwamdpeURnTzlIZ09jVE5jb2JyOTdJ?=
 =?utf-8?B?eFZhRTRFR1p1aDlDYjQ5UzhwZ0hKUS9jbVd0MDNINjNJVGlBVW5WYWhtWDQ4?=
 =?utf-8?B?d1ZHS1hUa0VneHVmSkptKzRKRnByS3FDSkJwVGYyKzUvYy9HUjNYdjRjaS9X?=
 =?utf-8?B?bVpkS2k0VXh4SERqdkRXOE5MZHJUQU9XZXBzK0lncU56eTFheU1uc05vT3Bt?=
 =?utf-8?B?YVF4aWU5ZVN1dTVEbnhXQTRKbWQrQ0gxeWkvVnAxdjVCdnFwamd6Qm9QdDlz?=
 =?utf-8?B?R09maG14aG55SExRTjN3ZG9MVUxCZW8xWEtuNGc1eTlTMzBHc1lzWnBFZUN3?=
 =?utf-8?B?M0Q2eXZEbzNoZDJ4SE05ZTVVTGR2ckVlQlJWRFlkeldveWlqWUdMN0FzM2hR?=
 =?utf-8?B?WDdkN0tCdzRKZTNaSEw1dXl4dTQrekY0TjcwWk9JdWlXbDRDNE1JTk5xZTZN?=
 =?utf-8?B?U0pVS0ZhcU14ZlpJc01CTThEV09XYTQyc1FoWUZ0NHF2aG5rSzBEdVhYYTVH?=
 =?utf-8?B?cG9POVZkVUx1RE8xWjNDcUsrekZtR01SeWVNNlZFVUtRRWc0NWNtMTEzM1lw?=
 =?utf-8?B?dUF0U1B3N2VDaXdKSW5NVE9aclBHZzd1dTZ6U1dpdjNxYWZmN0d6Wm45ck14?=
 =?utf-8?B?aklKb1g0d2x4SnlhZks2dHFRUnZudlZxdVJVV1Zqd3hPdWVvSHlLMElnSkRG?=
 =?utf-8?B?N3hKaUdFa2dPTGFVSk1uNTc2SHVDSEpQQVM0eHlVRkQ5V2wxZTg1Z3djRC9S?=
 =?utf-8?B?b0tPR0lRQ2pqcjBKcmgwL1FkTmhEZ2dXNEswWkdRZ3pDR1hHR0NKWEtOdXFt?=
 =?utf-8?B?L0k1QTBxYVZtNDJPYXd4ZHQ4U3c3U1kvaEdUbXdramJmdXZZSHhnNWovampt?=
 =?utf-8?B?aW4vSThPUlMvVW5HM2JrQ3RCQ0FiaHBqdUxJMVQ3QUNkWWNzSE5pYlV2QVhW?=
 =?utf-8?B?M2J2Y0E1djdRUDUvcExwcTVaMHVYUm9BaCtHbk9FMERoSXJwby9jb2hhcnhH?=
 =?utf-8?B?WWFkK3h5blZ2QzV3QTZOMXB4T1pFOVdLYU5hNnI2ak43TWVDZnloZi9USUJK?=
 =?utf-8?B?N3ZlblRBQ1hRUXpuS2xmaUp3M3F5N01JZXlUdzVaVVJSeHVNbHpsS29EODVD?=
 =?utf-8?B?Yjk3WDFtbk4zNFlMOTdJdXMzcFBhSGh0Qjl0YzJlTjZ1VE81ditLSEY1Y05z?=
 =?utf-8?B?UDdXaHFQbFBibmliVG5SZXNxMVBQc01Gb0RQRmppcVowUU5jaG8rZStHWnN6?=
 =?utf-8?B?WGt0YUl1aktoTU5KVDhiNVhDeHdTdDhIdE9nTzJtd054QnNZcG9paWVtRmJC?=
 =?utf-8?Q?JmfMj3ew4wxstim4PJnQhax6+?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA0PR11MB7185.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85fca1a3-f56e-4862-845a-08dd8873b706
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 May 2025 05:47:52.9541 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MJTyRs/z4vvRPNqeaOhgbtMbhMlrtOAXu5oSMU+peT4LZL2ibN80RBoyi+OOUQ7dFIG6Hoc5LnOb6b13Gb+uErxEX+ze8tFqyaohlSDMQjM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7248
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.11;
 envelope-from=vivek.kasireddy@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -48
X-Spam_score: -4.9
X-Spam_bar: ----
X-Spam_report: (-4.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.483,
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

SGkgTWFyYy1BbmRyZSwNCg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHYzIDUvNl0gdWkvc3BpY2U6
IENyZWF0ZSBhIG5ldyB0ZXh0dXJlIHdpdGggbGluZWFyIGxheW91dA0KPiB3aGVuIGdsPW9uIGlz
IGVuYWJsZWQNCj4gDQo+IEhpDQo+IA0KPiBPbiBUdWUsIEFwciAyOSwgMjAyNSBhdCAxMDoxM+KA
r0FNIFZpdmVrIEthc2lyZWRkeQ0KPiA8dml2ZWsua2FzaXJlZGR5QGludGVsLmNvbT4gd3JvdGU6
DQo+ID4NCj4gPiBTaW5jZSBtb3N0IGVuY29kZXJzL2RlY29kZXJzIChpbnZva2VkIGJ5IFNwaWNl
KSBtYXkgbm90IHdvcmsgd2l0aA0KPiA+IHRpbGVkIG1lbW9yeSBhc3NvY2lhdGVkIHdpdGggYSB0
ZXh0dXJlLCB3ZSBuZWVkIHRvIGNyZWF0ZSBhbm90aGVyDQo+ID4gdGV4dHVyZSB0aGF0IGhhcyBs
aW5lYXIgbWVtb3J5IGxheW91dCBhbmQgdXNlIHRoYXQgaW5zdGVhZC4NCj4gPg0KPiA+IE5vdGUg
dGhhdCwgdGhlcmUgZG9lcyBub3Qgc2VlbSB0byBiZSBhIGRpcmVjdCB3YXkgdG8gaW5kaWNhdGUg
dG8gdGhlDQo+ID4gR0wgaW1wbGVtZW50YXRpb24gdGhhdCBhIHRleHR1cmUncyBiYWNraW5nIG1l
bW9yeSBuZWVkcyB0byBiZSBsaW5lYXIuDQo+ID4gSW5zdGVhZCwgd2UgaGF2ZSB0byBkbyBpdCBp
biBhIHJvdW5kYWJvdXQgd2F5IHdoZXJlIHdlIG5lZWQgdG8gZmlyc3QNCj4gPiBjcmVhdGUgYSB0
aWxlZCB0ZXh0dXJlIGFuZCBpbXBvcnQgdGhhdCBhcyBhIG1lbW9yeSBvYmplY3QgdG8gY3JlYXRl
DQo+ID4gYSBuZXcgdGV4dHVyZSB0aGF0IGhhcyBhIGxpbmVhciBtZW1vcnkgbGF5b3V0Lg0KPiA+
DQo+ID4gQ2M6IEdlcmQgSG9mZm1hbm4gPGtyYXhlbEByZWRoYXQuY29tPg0KPiA+IENjOiBNYXJj
LUFuZHLDqSBMdXJlYXUgPG1hcmNhbmRyZS5sdXJlYXVAcmVkaGF0LmNvbT4NCj4gPiBDYzogRG1p
dHJ5IE9zaXBlbmtvIDxkbWl0cnkub3NpcGVua29AY29sbGFib3JhLmNvbT4NCj4gPiBDYzogRnJl
ZGlhbm8gWmlnbGlvIDxmcmVkZHk3N0BnbWFpbC5jb20+DQo+ID4gQ2M6IERvbmd3b24gS2ltIDxk
b25nd29uLmtpbUBpbnRlbC5jb20+DQo+ID4gU2lnbmVkLW9mZi1ieTogVml2ZWsgS2FzaXJlZGR5
IDx2aXZlay5rYXNpcmVkZHlAaW50ZWwuY29tPg0KPiA+IC0tLQ0KPiA+ICB1aS9zcGljZS1kaXNw
bGF5LmMgfCA2Mw0KPiArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KystDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCA2MiBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0p
DQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvdWkvc3BpY2UtZGlzcGxheS5jIGIvdWkvc3BpY2UtZGlz
cGxheS5jDQo+ID4gaW5kZXggMmM0ZGFhMDcwNy4uMDQ3ZDQ1M2EwYiAxMDA2NDQNCj4gPiAtLS0g
YS91aS9zcGljZS1kaXNwbGF5LmMNCj4gPiArKysgYi91aS9zcGljZS1kaXNwbGF5LmMNCj4gPiBA
QCAtMjYsNiArMjYsNyBAQA0KPiA+ICAjaW5jbHVkZSAidWkvY29uc29sZS5oIg0KPiA+ICAjaW5j
bHVkZSAidHJhY2UuaCINCj4gPg0KPiA+ICsjaW5jbHVkZSAic3RhbmRhcmQtaGVhZGVycy9kcm0v
ZHJtX2ZvdXJjYy5oIg0KPiA+ICAjaW5jbHVkZSAidWkvc3BpY2UtZGlzcGxheS5oIg0KPiA+DQo+
ID4gIGJvb2wgc3BpY2Vfb3BlbmdsOw0KPiA+IEBAIC04OTAsMTEgKzg5MSw2NSBAQCBzdGF0aWMg
dm9pZA0KPiBzcGljZV9nbF91cGRhdGUoRGlzcGxheUNoYW5nZUxpc3RlbmVyICpkY2wsDQo+ID4g
ICAgICBzc2QtPmdsX3VwZGF0ZXMrKzsNCj4gPiAgfQ0KPiA+DQo+ID4gK3N0YXRpYyBib29sIHNw
aWNlX2dsX3JlcGxhY2VfZmRfdGV4dHVyZShTaW1wbGVTcGljZURpc3BsYXkgKnNzZCwNCj4gPiAr
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIEVHTGludCAqc3RyaWRlLCBF
R0xpbnQgKmZvdXJjYywNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIEVHTHVpbnQ2NEtIUiAqbW9kaWZpZXIsDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICBpbnQgKmZkKQ0KPiA+ICt7DQo+ID4gKyAgICBHTHVpbnQgdGV4dHVy
ZSA9IDA7DQo+ID4gKw0KPiA+ICsgICAgaWYgKCFyZW1vdGVfY2xpZW50KSB7DQo+ID4gKyAgICAg
ICAgcmV0dXJuIHRydWU7DQo+ID4gKyAgICB9DQo+ID4gKw0KPiA+ICsgICAgaWYgKHN1cmZhY2Vf
Zm9ybWF0KHNzZC0+ZHMpID09IFBJWE1BTl9yNWc2YjUpIHsNCj4gPiArICAgICAgICByZXR1cm4g
dHJ1ZTsNCj4gPiArICAgIH0NCj4gDQo+IFBsZWFzZSBleHBsYWluIHdoeSB0aGlzIHBhcnRpY3Vs
YXIgZm9ybWF0IGlzIGhhbmRsZWQgZGlmZmVyZW50bHkgd2l0aCBhDQo+IGNvbW1lbnQuDQpJIGd1
ZXNzIEknbGwgcmVtb3ZlIHRoaXMgY2hlY2sgYXMgSSBkb24ndCByZW1lbWJlciB3aHkgSSBhZGRl
ZCBpdCBpbiB0aGUNCmZpcnN0IHBsYWNlLg0KDQo+IA0KPiA+ICsNCj4gPiArICAgIGlmICgqbW9k
aWZpZXIgPT0gRFJNX0ZPUk1BVF9NT0RfTElORUFSKSB7DQo+ID4gKyAgICAgICAgcmV0dXJuIHRy
dWU7DQo+ID4gKyAgICB9DQo+ID4gKw0KPiA+ICsgICAgLyoNCj4gPiArICAgICAqIFdlIHJlYWxs
eSB3YW50IHRvIGVuc3VyZSB0aGF0IHRoZSBtZW1vcnkgbGF5b3V0IG9mIHRoZSB0ZXh0dXJlDQo+
ID4gKyAgICAgKiBpcyBsaW5lYXI7IG90aGVyd2lzZSwgdGhlIGVuY29kZXIncyBvdXRwdXQgbWF5
IHNob3cgY29ycnVwdGlvbi4NCj4gPiArICAgICAqLw0KPiA+ICsgICAgc3VyZmFjZV9nbF9jcmVh
dGVfdGV4dHVyZV9mcm9tX2ZkKHNzZC0+ZHMsICpmZCwgJnRleHR1cmUpOw0KPiA+ICsNCj4gPiAr
ICAgIC8qDQo+ID4gKyAgICAgKiBBIHN1Y2Nlc3NmdWwgcmV0dXJuIGFmdGVyIGdsSW1wb3J0TWVt
b3J5RmRFWFQoKSBtZWFucyB0aGF0DQo+ID4gKyAgICAgKiB0aGUgb3duZXJzaGlwIG9mIGZkIGhh
cyBiZWVuIHBhc3NlZCB0byBHTC4gSW4gb3RoZXIgd29yZHMsDQo+ID4gKyAgICAgKiB0aGUgZmQg
d2UgZ290IGFib3ZlIHNob3VsZCBub3QgYmUgdXNlZCBhbnltb3JlLg0KPiA+ICsgICAgICovDQo+
ID4gKyAgICBpZiAodGV4dHVyZSA+IDApIHsNCj4gPiArICAgICAgICAqZmQgPSBlZ2xfZ2V0X2Zk
X2Zvcl90ZXh0dXJlKHRleHR1cmUsDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICBzdHJpZGUsIGZvdXJjYywNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIE5VTEwpOw0KPiA+ICsgICAgICAgIGlmICgqZmQgPCAwKSB7DQo+ID4gKyAgICAg
ICAgICAgIGdsRGVsZXRlVGV4dHVyZXMoMSwgJnRleHR1cmUpOw0KPiA+ICsgICAgICAgICAgICAq
ZmQgPSBlZ2xfZ2V0X2ZkX2Zvcl90ZXh0dXJlKHNzZC0+ZHMtPnRleHR1cmUsDQo+ID4gKyAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgc3RyaWRlLCBmb3VyY2MsDQo+ID4g
KyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgTlVMTCk7DQo+ID4gKyAg
ICAgICAgICAgIGlmICgqZmQgPCAwKSB7DQo+ID4gKyAgICAgICAgICAgICAgICBzdXJmYWNlX2ds
X2Rlc3Ryb3lfdGV4dHVyZShzc2QtPmdscywgc3NkLT5kcyk7DQo+ID4gKyAgICAgICAgICAgICAg
ICB3YXJuX3JlcG9ydCgic3BpY2U6IG5vIHRleHR1cmUgYXZhaWxhYmxlIHRvIGRpc3BsYXkiKTsN
Cj4gPiArICAgICAgICAgICAgICAgIHJldHVybiBmYWxzZTsNCj4gPiArICAgICAgICAgICAgfQ0K
PiA+ICsgICAgICAgIH0gZWxzZSB7DQo+ID4gKyAgICAgICAgICAgIHN1cmZhY2VfZ2xfZGVzdHJv
eV90ZXh0dXJlKHNzZC0+Z2xzLCBzc2QtPmRzKTsNCj4gPiArICAgICAgICAgICAgc3NkLT5kcy0+
dGV4dHVyZSA9IHRleHR1cmU7DQo+ID4gKyAgICAgICAgfQ0KPiA+ICsgICAgfQ0KPiANCj4gSWYg
aXQgZmFpbGVkLCBpdCBkb2VzIG5vdGhpbmcgYW5kIGNvbnRpbnVlcz8NCkFuIGVycm9yIGdldHMg
cHJpbnRlZCB3aGVuIGEgZmFpbHVyZSBpcyBlbmNvdW50ZXJlZCBpbiBkaWZmZXJlbnQgcGxhY2Vz
DQpidXQgcHJpbnRpbmcgb25lIGhlcmUgd291bGQgYWxzbyBiZSBvay4gDQoNClRoYW5rcywNClZp
dmVrDQoNCj4gDQo+IA0KPiA+ICsgICAgcmV0dXJuIHRydWU7DQo+ID4gK30NCj4gPiArDQo+ID4g
IHN0YXRpYyB2b2lkIHNwaWNlX2dsX3N3aXRjaChEaXNwbGF5Q2hhbmdlTGlzdGVuZXIgKmRjbCwN
Cj4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHN0cnVjdCBEaXNwbGF5U3VyZmFjZSAq
bmV3X3N1cmZhY2UpDQo+ID4gIHsNCj4gPiAgICAgIFNpbXBsZVNwaWNlRGlzcGxheSAqc3NkID0g
Y29udGFpbmVyX29mKGRjbCwgU2ltcGxlU3BpY2VEaXNwbGF5LCBkY2wpOw0KPiA+ICAgICAgRUdM
aW50IHN0cmlkZSwgZm91cmNjOw0KPiA+ICsgICAgRUdMdWludDY0S0hSIG1vZGlmaWVyOw0KPiA+
ICsgICAgYm9vbCByZXQ7DQo+ID4gICAgICBpbnQgZmQ7DQo+ID4NCj4gPiAgICAgIGlmIChzc2Qt
PmRzKSB7DQo+ID4gQEAgLTkwNSwxMiArOTYwLDE4IEBAIHN0YXRpYyB2b2lkIHNwaWNlX2dsX3N3
aXRjaChEaXNwbGF5Q2hhbmdlTGlzdGVuZXINCj4gKmRjbCwNCj4gPiAgICAgICAgICBzdXJmYWNl
X2dsX2NyZWF0ZV90ZXh0dXJlKHNzZC0+Z2xzLCBzc2QtPmRzKTsNCj4gPiAgICAgICAgICBmZCA9
IGVnbF9nZXRfZmRfZm9yX3RleHR1cmUoc3NkLT5kcy0+dGV4dHVyZSwNCj4gPiAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgJnN0cmlkZSwgJmZvdXJjYywNCj4gPiAtICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgTlVMTCk7DQo+ID4gKyAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICZtb2RpZmllcik7DQo+ID4gICAgICAgICAgaWYgKGZkIDwg
MCkgew0KPiA+ICAgICAgICAgICAgICBzdXJmYWNlX2dsX2Rlc3Ryb3lfdGV4dHVyZShzc2QtPmds
cywgc3NkLT5kcyk7DQo+ID4gICAgICAgICAgICAgIHJldHVybjsNCj4gPiAgICAgICAgICB9DQo+
ID4NCj4gPiArICAgICAgICByZXQgPSBzcGljZV9nbF9yZXBsYWNlX2ZkX3RleHR1cmUoc3NkLCAm
c3RyaWRlLCAmZm91cmNjLCAmbW9kaWZpZXIsDQo+ICZmZCk7DQo+ID4gKyAgICAgICAgaWYgKCFy
ZXQpIHsNCj4gPiArICAgICAgICAgICAgc3VyZmFjZV9nbF9kZXN0cm95X3RleHR1cmUoc3NkLT5n
bHMsIHNzZC0+ZHMpOw0KPiA+ICsgICAgICAgICAgICByZXR1cm47DQo+ID4gKyAgICAgICAgfQ0K
PiA+ICsNCj4gPiAgICAgICAgICB0cmFjZV9xZW11X3NwaWNlX2dsX3N1cmZhY2Uoc3NkLT5xeGwu
aWQsDQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHN1cmZhY2Vfd2lk
dGgoc3NkLT5kcyksDQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHN1
cmZhY2VfaGVpZ2h0KHNzZC0+ZHMpLA0KPiA+IC0tDQo+ID4gMi40OS4wDQo+ID4NCj4gPg0KPiAN
Cj4gDQo+IC0tDQo+IE1hcmMtQW5kcsOpIEx1cmVhdQ0K

