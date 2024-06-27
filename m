Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FA84C30653
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2024 11:27:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMnGb-0008JR-1h; Thu, 27 Jun 2024 07:26:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1sMnGW-0008HP-9F; Thu, 27 Jun 2024 07:26:13 -0400
Received: from mgamail.intel.com ([192.198.163.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1sMnGK-0004l4-KE; Thu, 27 Jun 2024 07:26:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1719487561; x=1751023561;
 h=from:to:subject:date:message-id:references:in-reply-to:
 content-transfer-encoding:mime-version;
 bh=oLeQhiXby+eosu0oUH0cMuYhRowGamOtP11Nx9pcrn8=;
 b=XlMExDHS7awHuwQXOZE4QJoGktTo6kF2yPoG/VcQIB/gEhLD6Cj+N9c7
 mbbErz7pvPFiTMJwXJ2dMJRYtcm9wg0bOILKHdfFDSvP2RaidPAXplYoI
 FOgjP+XXDVYxKEDmrSPXQZWcTcR8V/2uqkmJhDnsi2DlMV+Ycq4JMeH96
 NKWuBktN1Xat6uqmojfMxQyD4eayUW1sHorHy2A0+/Yoki0NkxZT4+gl4
 1G4PDoG/vPPS4jy9xLsgZ/M4NJiKwLHVfNCeFT8Xq8CXLifvUV5xEQu7k
 A3I5abkY2WMuZTgXFMpr71oAiGioaT+yd54QbGlBXEe8R+n1B/iEoaHTP Q==;
X-CSE-ConnectionGUID: y4QGzhx4S2CdTdmnDZr/IA==
X-CSE-MsgGUID: GoQtBK1JRBSW4dxXxZ4cbw==
X-IronPort-AV: E=McAfee;i="6700,10204,11115"; a="28004058"
X-IronPort-AV: E=Sophos;i="6.09,270,1716274800"; d="scan'208";a="28004058"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Jun 2024 04:25:57 -0700
X-CSE-ConnectionGUID: SHGRqf4OQoGAdfeS66yotQ==
X-CSE-MsgGUID: T9EMq/AfT5K5zbvXKl8FGg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,270,1716274800"; d="scan'208";a="81895348"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
 by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 27 Jun 2024 04:25:57 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 27 Jun 2024 04:25:56 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 27 Jun 2024 04:25:56 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 27 Jun 2024 04:25:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FJ4HuQAZTzQS/7+WgcbMiebO3RVUiwI8qgCxFIYpMeNVArlK6zx0nfjqxdOFVj1+V1+JiaUfzjlACGN7DLXeLANh4liaJ2HyMpLe8L3t6srulpwq5BqRJwcYUL+7wSMmy6r21oR6wr3lqh8TiZl81gd1b2SD42vFnNbkQxBgBHygRSy4uD9RanJ8+U9yhgQi2pyW7j4jlOzcWoAo/ZJ2Wo9I90OhsQt4sRaaD2x0wNFsUI9ADNK0MWWcVcQkwNyj+BM6PXIWZKqIjSIS5sEJh8qqw3E3Zqoo8r376bJdy0a0aFK4PeoAOsdmrpH0EsR0qdso7AoG7fmdxMMkySy1Jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oLeQhiXby+eosu0oUH0cMuYhRowGamOtP11Nx9pcrn8=;
 b=jNosjVeDRDI9/Bqxr3lJkXOXvyqy0OVORU6KGQxkKZGbHmct+tNXJ6Xj7xP35jjl2X7PEzx+UwR8OSH7uXEBpnLK26+GXnBhi/upm5dhHuj3S/YK4FLdgUdWugyUkBGaIokmn5g2LQ5HI1bMO5UH5WDzWSD8B6kNl96ORnyazJnlp20K/CYm2KtsmM0yj2oWAqOOe9rERBD0yY2R/YQFkycQwrg7KLrsKTicSy978A5Jc46aT188jCLg5AScdostQhQvVM48xW+cchRfEGZ34T357KFCGnTsHRNvY8omgxAzrjxj+tZlFmM4kzUb7ufiiqZR/RNRMqSsJqj6Pkl5pQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by PH8PR11MB7144.namprd11.prod.outlook.com (2603:10b6:510:22c::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.29; Thu, 27 Jun
 2024 11:25:53 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091%7]) with mapi id 15.20.7698.025; Thu, 27 Jun 2024
 11:25:52 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "eric.auger.pro@gmail.com" <eric.auger.pro@gmail.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-arm@nongnu.org"
 <qemu-arm@nongnu.org>, "mst@redhat.com" <mst@redhat.com>,
 "jean-philippe@linaro.org" <jean-philippe@linaro.org>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>, "clg@redhat.com"
 <clg@redhat.com>, "yanghliu@redhat.com" <yanghliu@redhat.com>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>
Subject: RE: [PATCH 4/7] HostIOMMUDevice: Introduce get_page_size_mask()
 callback
Thread-Topic: [PATCH 4/7] HostIOMMUDevice: Introduce get_page_size_mask()
 callback
Thread-Index: AQHax6LGeEgfB5oLvkixcGLvIMJYjrHa7h7QgABjRQCAACguAA==
Date: Thu, 27 Jun 2024 11:25:52 +0000
Message-ID: <SJ0PR11MB6744F8040A93EA6D2F74F3EA92D72@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20240626082727.1278530-1-eric.auger@redhat.com>
 <20240626082727.1278530-5-eric.auger@redhat.com>
 <SJ0PR11MB6744E5DF82073F17F2FC31D192D72@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <ca01fa7e-4218-48b5-8c85-e8f7e9e353c9@redhat.com>
In-Reply-To: <ca01fa7e-4218-48b5-8c85-e8f7e9e353c9@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|PH8PR11MB7144:EE_
x-ms-office365-filtering-correlation-id: 011b00a8-6aad-4ac0-210c-08dc969be797
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|7416014|1800799024|921020|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?M3JsQjE5YU9JSlNLWVdROWxMdXRGWjBRUGEyRGVHc0ZDc3FEdkMwSTdsSXVq?=
 =?utf-8?B?NmdDSGQxQUJabGhKQ29zQUdaMVBIVWtmdkJzb0N0bEM5a2pWWkNuWC9PUHNQ?=
 =?utf-8?B?bm0vMVdDdE01dmtJT3hNRU9RTEdIRzZjR2MvRlBRcFpmWnFpeWZzbnNsMGVD?=
 =?utf-8?B?dkptcS8vMXNQVmwvaTJvSWUxaHU2RjBvK1YxYzhQTmEyNVF3MStGY1h0c1lC?=
 =?utf-8?B?VmZiTitwKzArakliVW5jZXJUQzFqWmdSenk3blFkbkFicUNZMW5uMUxtQVBB?=
 =?utf-8?B?dUo3QlNRUjRsNm1pbHhlQTBORkdhYzRKc05BSGQ2bVI3RHpRQWxmOWFJaEVM?=
 =?utf-8?B?Z1lwTTN2TGtodzNTNjVncEFmMHVudjQrL09OL0N0TEpjdFJpTzBacWVDZXhG?=
 =?utf-8?B?bUhLYWFOSTNzUFVJeUNISkFuV0JrUkVQUHl1dEVOWUtYTmJLNkFDakFCMSt1?=
 =?utf-8?B?ditYcm9hdFVLd3VRSW9UdEU5RFBPaWV6WGNub0dMZllvaFNKd0RSWG5waGdk?=
 =?utf-8?B?cXVwTUt0ckJWT0swQTMzUyt6bjlPanZ4UkwrOVVwd0ZDYmdVMzM4aVI0am1Z?=
 =?utf-8?B?Ti9ETGJBUlhGVCtNQXIzZG0wU0NLYnZSRUNHZm0xUEZQWDJib0hVK2g5eStY?=
 =?utf-8?B?d25LUG93dkdpdmJtR0wyK1IrcHpRY2JIS1RzRGo0NTNzaWlaZFZFaDRSenEz?=
 =?utf-8?B?U0JSUXhSWEhLb0dobkoxWU94cVlSbHdib2VieDFlWkhzQnhFY1ErS1hPT0NM?=
 =?utf-8?B?T2drSzI4UmNucWZPTmpLV2FKU3lxT1pqR1FHbWh1bWpkMHc2YTQwTktNSnpH?=
 =?utf-8?B?VXVWZEpXTVcyZG4zS0RlUkNPRlIxSmVOajV6TXBaemZUSi8vNTVPSFlYa3Rq?=
 =?utf-8?B?Rm5ua0g2YkJPaGNDbnh1SGo2VXpLYm5zdjNwVzY1WnJaelFCWmhXSEt2R2RJ?=
 =?utf-8?B?cHZ6UVgxU3NQdmp1TFdaUzN5QW0zK0gvNTVvTGFhUGpGSUhIMVRSUFFVemx1?=
 =?utf-8?B?YTNIWGl6U2RRVnExRHAva0l1ekJ3NzArcUJpSytyOE01b09nWVhWTTdoVE1Z?=
 =?utf-8?B?TmJDVjdaUkh1T3FKOXZuYllHQTRyWDFIbXFtenV5dlIzS1lRM0gwbU11S1p1?=
 =?utf-8?B?S3VaUXIyS1pFVEZoTU52ZzlwMFJWTlg3NmlYMEEzb2V3QkNuaXpFaXcvUWdx?=
 =?utf-8?B?WjZmZ0pKQjlkOXBRa2VMVG91TmQ3My9LWW1leHJlSGExYnA3V3pTL3ljd1pM?=
 =?utf-8?B?akprWVNBNkpyNEczTU8zSllyK0xVdXh4NUhoeVBhdGxhR0xIWGVUNW45Wnpn?=
 =?utf-8?B?OVUvVzBjTWVrOU1Nc1h3aENRTGhGUEtDMmg4T1phSmhOQXJEckVkNVh5d3o3?=
 =?utf-8?B?dTBSeW0xeC9WYVJXK3RRV2FmdTJ4TUlYSS9sRTFpc3JsZWFFUG5nRTlUaURz?=
 =?utf-8?B?NmxVMFdKM2hjU0poZ1g3U2lIN01FYXpMUit0Umd1ZWJCc1BtOGlaQTJ1WmRR?=
 =?utf-8?B?RzZpSTl0NkkvdjBBb0Y2VGlHYVdvckErNERaRlZDOTlGazVaMWtheUFWVG9E?=
 =?utf-8?B?bnpZZUl0cDF2Qkl2NDd0QTNPNWRxUXh3WVo2VGRvejNMVGJucGw2eXpqckxk?=
 =?utf-8?B?VU9wcmdoNWs5UmFOcW5DelpqUzJwZm9SbmtqN3lHWmQ5a0Z4TGx6WERvRjMw?=
 =?utf-8?B?QU5GNVFIV3A5NWlhbjdUTm40OTE2SE1CY29HZFVpM0FXZjQvUlZjRCtNYWx6?=
 =?utf-8?B?aDRKZW1KOWMvQm1VdERZZjVabk1iVnJCS3Awa3VvK0x5ZnBNdENWRFJKZlZs?=
 =?utf-8?B?WFplREdSaEhjbnpKMjY0eFlZbUdVdWpQVERkdllFKzFrZkhaWmU0eWpmRVlT?=
 =?utf-8?B?cEF4bkMyTzNKMXZ6V2VtWnI4Tm84MUV2YUFQL0x0NE4xNkJGb3JvNWtuNktp?=
 =?utf-8?Q?q0+cxLNPOKg=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(7416014)(1800799024)(921020)(38070700018);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NkFiMEMvRUlPL3p4bjhkNThwaHMzTFFubFpXeXFGS1JiYVd0UmtZRnpOeXRy?=
 =?utf-8?B?QUtxaTMwcGV0bENjcXVxQ2U1YVZKMEVnd1ExMkE4OXVhcmJvS3VQZy82TVd6?=
 =?utf-8?B?czhtS21EWVEzM0FxdHgzNTI4Qk85RzFXQ0hQSzFBWjBnTkJuZk5sekVMUGRu?=
 =?utf-8?B?TGdmREdEdzcyZEpVT0hYbDNlZmtJSVdNLzNsaTBrdk9yc25idGIvU1JKTFBi?=
 =?utf-8?B?MHhsWDR6N3NzSFJiRjZzZmRnUGhjOENFQ2xzN2IyS3JPZHlUN25yUFJ2bzVO?=
 =?utf-8?B?d21EZloxOG0vSVhrTFBRZndZUEQwbVUwTDU0Rk5oRDExTXp1cEZkV0RLdFAz?=
 =?utf-8?B?QVh1TjQ5ZVlYcjRvUDdEMklXWVJhZ3MvWFFONVZ1eDhCWUE1UEp5dTZWZjVJ?=
 =?utf-8?B?OTBQSStOR2ZQZy85aDZQNTlvL0VCMkJIMGhBU0VmSlZ2RFU0YVFEUUdtS25U?=
 =?utf-8?B?ejhJQ05vc1NhaTZSNlpWTzRndGgwcGg4czIyWk1KWWpBZTYwK09OanNUbjhn?=
 =?utf-8?B?cGplaGw2VzFoc2ZudnJTSG9Jb05QcFNPa1cxZGR6aTljVDhaQ3BLeU45bWs0?=
 =?utf-8?B?L0svZk9DYVdOSXFVZ2pwZVRzQUVCd0lrZ2x3REdhSC82Z0Y1WDdnRXZCb05l?=
 =?utf-8?B?MElyakdJbDVZL2QzalEzUTdFWkZFVlpXRWs0eFhvVVZ0b00yVnlwK2dzL1dP?=
 =?utf-8?B?SG5OTG5NclozWlptTEdseUR0M0dIdVNQN2U2OThJdXF3RnNSZEpzNnpQeUlv?=
 =?utf-8?B?TW10cHNCTzFQTmFrL0NTSjlyNVJ3NStUVFRpRXNPT1RnMlM4VDFKZFExa0No?=
 =?utf-8?B?aWV1ZHM2Uy80YWhCd2ttMm00S1RWdHh2MTg1SjZHd3V1QXI3TWcrVS9wUDBo?=
 =?utf-8?B?UzRHNGxTTTc0QnVIV092NUN5QVd6Rm1PRC84L0dQclhtaVFLeldBdVVUbjBO?=
 =?utf-8?B?b0Qxb1VadW1iY3J6VWlsU0VRS2hNbEpoOVluMy9QSEFCNzBtV0xCbGUvSXNt?=
 =?utf-8?B?UXZPQlpqUFNJWnZuakpTM1NSdnFNQjlXdHhJZXBtYWhCMWdyVG4vWVNWUnBt?=
 =?utf-8?B?T3poMmlyanJyMG41dThiUUF0amp6dytYa3YzN05rUzRROFExakM1WE9RdFZr?=
 =?utf-8?B?Q3puc0lCNFBydExVckRpVWNwb05RN0hYbjB6Q1p1Q1h4ckdZbVFLclZjTC9E?=
 =?utf-8?B?bmYvWEgxQWlQNjZkS1h6SnhPVm5zek1rWi85amRuM3A5SzAvVGk1TnFaVURa?=
 =?utf-8?B?ZWYxcHZNeGM1QzcybXJVUUFwaU9GRHptS2c3cG9Ka2JGMkNaNVhCNitUb3V5?=
 =?utf-8?B?RmExVTgrTzhIN2FIMW5nRVVoekV2aWN6YUg0U1NYdWhZMGUvUExlQ3NnMWZy?=
 =?utf-8?B?TWs0UUhMelkzQWk4U2kybjdSdlRiMjhZVStHVXJOdUlidnhheVR4MXMzQkl4?=
 =?utf-8?B?UzlweE5ydHkrbGlHa21mOVRGU2k4ekNEeWdXcFZlMUUyKy80a0xDYVVsd3RD?=
 =?utf-8?B?RFY3akZReHd6UjJ3VTgyZmlGYzdjY1dEL1kvcFU4RWYxajNwcis1ZDhhbDgv?=
 =?utf-8?B?ZmZJbEk3cjA0ckVVL05iRzdEMXAxcC9UcGs1SXRVVWxrMnEvZm9IeDdwMkha?=
 =?utf-8?B?cmZ5Qy9GK0ozcmdKN2lqTHpQUktWTlEzOUVXa0hibCtSMzFka1AvZ1U0N3dB?=
 =?utf-8?B?TUlPUWt2NkNYSm0xTGJLbVlJL3JnZGlGTE9QdlJZUm1nZ2xMUk9CMlNDOXR1?=
 =?utf-8?B?RmJES3YwbE83bE5XUlFtdy9xbHNaaFVDY2NQVi9JOFh0UG16ZExkd3RCWlgv?=
 =?utf-8?B?dE05SjRUZ3gwY2ZDL3lucFdFdVBJeWdpeE5RazFOTnJyYXVDK0xNUk1iVUNt?=
 =?utf-8?B?Q01ZWDlBdGRpTmUrcFRZOEd1TkxBbXA0aW8rellnSkIvc3NGRDZtSEtPTGQv?=
 =?utf-8?B?ZkNEUVpvVWlWNkI1dnlBd2tveEhYUktRZm4wczFDZHhxeURoSmdvM1k5QWY2?=
 =?utf-8?B?WjFEMUNzaXhyYU1icUZxWS9HN3VFSHZEUXVtUGFycGJoUUVnUHgweENZeXdk?=
 =?utf-8?B?NW95U3c0cDFRNjc0S1Y2U3I5NlhyZmJrSEFPUzcxUGN1S0kzY1hpcSt0Vmlh?=
 =?utf-8?Q?+aOGNH+HtGbiBAvZiBxxCOlcC?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 011b00a8-6aad-4ac0-210c-08dc969be797
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jun 2024 11:25:52.8938 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: J42ZV40Dl/TELvB4l72YL44rbpEmkF/zmPFOFutQOebtFCTmvwZ+voC5UF0QqHZBKFKq3at/mZISW4nYVBYbE8OwPyckv1ewPDoXkZbEgxI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB7144
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.10;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.212,
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

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IEVyaWMgQXVnZXIgPGVyaWMu
YXVnZXJAcmVkaGF0LmNvbT4NCj5TdWJqZWN0OiBSZTogW1BBVENIIDQvN10gSG9zdElPTU1VRGV2
aWNlOiBJbnRyb2R1Y2UNCj5nZXRfcGFnZV9zaXplX21hc2soKSBjYWxsYmFjaw0KPg0KPkhpIFpo
ZW56aG9uZywNCj4NCj5PbiA2LzI3LzI0IDA1OjA2LCBEdWFuLCBaaGVuemhvbmcgd3JvdGU6DQo+
PiBIaSBFcmljLA0KPj4NCj4+PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPj4+IEZyb206
IEVyaWMgQXVnZXIgPGVyaWMuYXVnZXJAcmVkaGF0LmNvbT4NCj4+PiBTdWJqZWN0OiBbUEFUQ0gg
NC83XSBIb3N0SU9NTVVEZXZpY2U6IEludHJvZHVjZSBnZXRfcGFnZV9zaXplX21hc2soKQ0KPj4+
IGNhbGxiYWNrDQo+Pj4NCj4+PiBUaGlzIGNhbGxiYWNrIHdpbGwgYmUgdXNlZCB0byByZXRyaWV2
ZSB0aGUgcGFnZSBzaXplIG1hc2sgc3VwcG9ydGVkDQo+Pj4gYWxvbmcgYSBnaXZlbiBIb3N0IElP
TU1VIGRldmljZS4NCj4+Pg0KPj4+IFNpZ25lZC1vZmYtYnk6IEVyaWMgQXVnZXIgPGVyaWMuYXVn
ZXJAcmVkaGF0LmNvbT4NCj4+PiAtLS0NCj4+PiBpbmNsdWRlL2h3L3ZmaW8vdmZpby1jb250YWlu
ZXItYmFzZS5oIHwgIDcgKysrKysrKw0KPj4+IGluY2x1ZGUvc3lzZW11L2hvc3RfaW9tbXVfZGV2
aWNlLmggICAgfCAgOCArKysrKysrKw0KPj4+IGh3L3ZmaW8vY29udGFpbmVyLmMgICAgICAgICAg
ICAgICAgICAgfCAxMCArKysrKysrKysrDQo+Pj4gaHcvdmZpby9pb21tdWZkLmMgICAgICAgICAg
ICAgICAgICAgICB8IDExICsrKysrKysrKysrDQo+Pj4gNCBmaWxlcyBjaGFuZ2VkLCAzNiBpbnNl
cnRpb25zKCspDQo+Pj4NCj4+PiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9ody92ZmlvL3ZmaW8tY29u
dGFpbmVyLWJhc2UuaCBiL2luY2x1ZGUvaHcvdmZpby92ZmlvLQ0KPj4+IGNvbnRhaW5lci1iYXNl
LmgNCj4+PiBpbmRleCA0NWQ3YzQwZmNlLi42MmE4YjYwZDg3IDEwMDY0NA0KPj4+IC0tLSBhL2lu
Y2x1ZGUvaHcvdmZpby92ZmlvLWNvbnRhaW5lci1iYXNlLmgNCj4+PiArKysgYi9pbmNsdWRlL2h3
L3ZmaW8vdmZpby1jb250YWluZXItYmFzZS5oDQo+Pj4gQEAgLTg4LDYgKzg4LDEzIEBAIGludCB2
ZmlvX2NvbnRhaW5lcl9xdWVyeV9kaXJ0eV9iaXRtYXAoY29uc3QNCj4+PiBWRklPQ29udGFpbmVy
QmFzZSAqYmNvbnRhaW5lciwNCj4+Pg0KPj4+IEdMaXN0ICp2ZmlvX2NvbnRhaW5lcl9nZXRfaW92
YV9yYW5nZXMoY29uc3QgVkZJT0NvbnRhaW5lckJhc2UNCj4+PiAqYmNvbnRhaW5lcik7DQo+Pj4N
Cj4+PiArc3RhdGljIGlubGluZSB1aW50NjRfdA0KPj4+ICt2ZmlvX2NvbnRhaW5lcl9nZXRfcGFn
ZV9zaXplX21hc2soY29uc3QgVkZJT0NvbnRhaW5lckJhc2UNCj4qYmNvbnRhaW5lcikNCj4+PiAr
ew0KPj4+ICsgICAgYXNzZXJ0KGJjb250YWluZXIpOw0KPj4+ICsgICAgcmV0dXJuIGJjb250YWlu
ZXItPnBnc2l6ZXM7DQo+Pj4gK30NCj4+PiArDQo+Pj4gI2RlZmluZSBUWVBFX1ZGSU9fSU9NTVUg
InZmaW8taW9tbXUiDQo+Pj4gI2RlZmluZSBUWVBFX1ZGSU9fSU9NTVVfTEVHQUNZIFRZUEVfVkZJ
T19JT01NVSAiLWxlZ2FjeSINCj4+PiAjZGVmaW5lIFRZUEVfVkZJT19JT01NVV9TUEFQUiBUWVBF
X1ZGSU9fSU9NTVUgIi1zcGFwciINCj4+PiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9zeXNlbXUvaG9z
dF9pb21tdV9kZXZpY2UuaA0KPj4+IGIvaW5jbHVkZS9zeXNlbXUvaG9zdF9pb21tdV9kZXZpY2Uu
aA0KPj4+IGluZGV4IDA1YzczMjRhMGQuLmMxYmY3NGFlMmMgMTAwNjQ0DQo+Pj4gLS0tIGEvaW5j
bHVkZS9zeXNlbXUvaG9zdF9pb21tdV9kZXZpY2UuaA0KPj4+ICsrKyBiL2luY2x1ZGUvc3lzZW11
L2hvc3RfaW9tbXVfZGV2aWNlLmgNCj4+PiBAQCAtODksNiArODksMTQgQEAgc3RydWN0IEhvc3RJ
T01NVURldmljZUNsYXNzIHsNCj4+PiAgICAgICogQGhpb2Q6IGhhbmRsZSB0byB0aGUgaG9zdCBJ
T01NVSBkZXZpY2UNCj4+PiAgICAgICovDQo+Pj4gICAgIEdMaXN0KiAoKmdldF9pb3ZhX3Jhbmdl
cykoSG9zdElPTU1VRGV2aWNlICpoaW9kKTsNCj4+PiArICAgIC8qKg0KPj4+ICsgICAgICoNCj4+
PiArICAgICAqIEBnZXRfcGFnZV9zaXplX21hc2s6IFJldHVybiB0aGUgcGFnZSBzaXplIG1hc2sg
c3VwcG9ydGVkIGFsb25nDQo+Pj4gdGhpcw0KPj4+ICsgICAgICogQGhpb2QgSG9zdCBJT01NVSBk
ZXZpY2UNCj4+PiArICAgICAqDQo+Pj4gKyAgICAgKiBAaGlvZDogaGFuZGxlIHRvIHRoZSBob3N0
IElPTU1VIGRldmljZQ0KPj4+ICsgICAgICovDQo+Pj4gKyAgICB1aW50NjRfdCAoKmdldF9wYWdl
X3NpemVfbWFzaykoSG9zdElPTU1VRGV2aWNlICpoaW9kKTsNCj4+IE5vdCBzdXJlIGlmIGl0J3Mg
c2ltcGxlciB0byB1dGlsaXplIGV4aXN0aW5nIC5nZXRfY2FwKCkgdG8gZ2V0IHBnc2l6ZXMuDQo+
SSBjaG9zZSB0byBpbnRyb2R1Y2UgYSBuZXcgY2FsbGJhY2sgYmVjYXVzZSB0aGUgcGFnZV9tYXNr
IGNhbiBiZQ0KPlU2NF9NQVgNCj5hbmQgZ2V0X2NhcCBpcyBsaWtlbHkgdG8gcmV0dXJuIGEgbmVn
YXRpdmUgdmFsdWUuIFNvIHdlIGNvdWxkIG5vdA0KPmRpc3Rpbmd1aXNoIGJldHdlZW4gYW4gZXJy
b3IgYW5kIGEgZnVsbCBtYXNrLg0KDQpJIHNlZSwgeW91IGFyZSByaWdodC4NCg0KVGhhbmtzDQpa
aGVuemhvbmcNCg0K

