Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D422BCD1284
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Apr 2024 03:07:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rsZum-0008GW-IF; Thu, 04 Apr 2024 23:06:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wei.w.wang@intel.com>)
 id 1rsZuk-0008GN-CO
 for qemu-devel@nongnu.org; Thu, 04 Apr 2024 23:06:50 -0400
Received: from mgamail.intel.com ([192.198.163.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wei.w.wang@intel.com>)
 id 1rsZuh-0005K5-EF
 for qemu-devel@nongnu.org; Thu, 04 Apr 2024 23:06:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1712286407; x=1743822407;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=su33LjBuFDYXTQOltnnanXbtVgDDBnNbcQH1jAKGGR8=;
 b=m4yshsL9/A6UjhxYmdBY2K/PRHW74siiDrVWnY6kM09IdwSV0v4MfUN6
 /rMdq2j0F3DuHl9wn5/wb9L2Mbw5vvLCOmtPyAX6gHvzsqwa0Q6YkF3xA
 kqzNnohpphsjEBQhI1cuPukBTBmkiY2J0SwVRxJje876x3r79i6MHap6G
 bDR6wuAOeRIhs6tN86FkyuQaSWrLcHcltI2BfSEVSKsqCkLMfU+bh9Qr1
 fAKLHakort7dk5IQqu9BqZ2PxIcCLdK21YEPNY3In/EzFA33lUg7o94Me
 OVJC8Uba69h4m6hRmqcLFP24V/MumhD+8zKZrLmY36RwcZFCi9Nb6i8+R g==;
X-CSE-ConnectionGUID: KjU8F8eeTxa5BU0alVfjyg==
X-CSE-MsgGUID: HQYm6WArQm+iz4iUQey7Ag==
X-IronPort-AV: E=McAfee;i="6600,9927,11034"; a="7465985"
X-IronPort-AV: E=Sophos;i="6.07,180,1708416000"; 
   d="scan'208";a="7465985"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Apr 2024 20:06:43 -0700
X-CSE-ConnectionGUID: BOa5A8qLRuC7L941gAhYkg==
X-CSE-MsgGUID: AsrCVoVVRC+VV60pgwd9Mg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,180,1708416000"; d="scan'208";a="23660224"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
 by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 04 Apr 2024 20:06:43 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 4 Apr 2024 20:06:41 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 4 Apr 2024 20:06:41 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 4 Apr 2024 20:06:41 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.40) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 4 Apr 2024 20:06:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BzRFX9AIfp5Fo5cGs0oxEiIEEnMBFqhKsDFHFa5gAS+N/ftDkdQRWJOhKGwDRMOISsFWdww2u7YZlxOnfSmMZr1GmaptNucU2TRLvDEGx37oA/gdXD3i9NJH6qHaMG/PRfPZgmlVvIsSv6ZIBw/nM/lTsXyd4e+G99Y7wuM+KKllyiOoRcxVTiCWxNz9Y2EtJMwZt6FK50Hac0xQ4wP7T/gFR6sv3NE+Cq3DeW+F6gt7lvKdrIhyeFrzFhw12fbkT6/qAqiUFjFCN0IPmWi5wpIT3r1opOKxQMOPdGOcY56ZklwvrjC2fjZTTnGy0cj5weXGJiECauF9KOyB5OcgIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=su33LjBuFDYXTQOltnnanXbtVgDDBnNbcQH1jAKGGR8=;
 b=aEbQ9Gn3P70Le6rbUwATadSYsx0Omrq1g3D6gLagezUwrK6cNPxfYlslnQFhuCR1ZMG4iiB+epY0WQNZRjw7w4ZEk4dqQlGQKDbxU5dwfFxEM/GEoH4Pd6LW+MgXVIYkJNc4wbtM7eHWwO9RYkUDimrjSVvBa3sBaKNdpgDZumiWD1sEHYl7Jevcexlv8RH7J7ByfrmVTY3XdLI/C/K9RY2O0JRwDAKx5Iy+Liqw2xMDYdpRpB3WH56nh++4SrlFuVhNMLXG1zeMXR12Bxomq5NnO0kiAunJaksZ/Xjz3mza3cfwh9iDj33AcQ84hGUjXeIwtAYv2Z/+YOR6m8fH8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS0PR11MB6373.namprd11.prod.outlook.com (2603:10b6:8:cb::20) by
 SN7PR11MB7667.namprd11.prod.outlook.com (2603:10b6:806:32a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.26; Fri, 5 Apr
 2024 03:06:39 +0000
Received: from DS0PR11MB6373.namprd11.prod.outlook.com
 ([fe80::55de:b95:2c83:7e6c]) by DS0PR11MB6373.namprd11.prod.outlook.com
 ([fe80::55de:b95:2c83:7e6c%7]) with mapi id 15.20.7452.019; Fri, 5 Apr 2024
 03:06:20 +0000
From: "Wang, Wei W" <wei.w.wang@intel.com>
To: Peter Xu <peterx@redhat.com>
CC: "Wang, Lei4" <lei4.wang@intel.com>, "farosas@suse.de" <farosas@suse.de>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: RE: [PATCH v1] migration/postcopy: ensure preempt channel is ready
 before loading states
Thread-Topic: [PATCH v1] migration/postcopy: ensure preempt channel is ready
 before loading states
Thread-Index: AQHahne59xUzBSmQ9kKgviWy8nsalrFYJxAAgAAU2RCAABbtgIAARWeAgAA7fiCAACJvgIAACNBQ
Date: Fri, 5 Apr 2024 03:06:20 +0000
Message-ID: <DS0PR11MB637381BB6861E425644429ACDC032@DS0PR11MB6373.namprd11.prod.outlook.com>
References: <20240404100550.17777-1-wei.w.wang@intel.com>
 <Zg61FnuPPAYAJs45@x1n>
 <DS0PR11MB6373FB3A707271E6E158258ADC3C2@DS0PR11MB6373.namprd11.prod.outlook.com>
 <757123c0-c4f9-4332-adb7-e6296ab8d54a@intel.com> <Zg8UB900V4NpTwNG@x1n>
 <DS0PR11MB637365DD124863C6C0DC995EDC032@DS0PR11MB6373.namprd11.prod.outlook.com>
 <Zg9i0e9YI3cwUnOB@x1n>
In-Reply-To: <Zg9i0e9YI3cwUnOB@x1n>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR11MB6373:EE_|SN7PR11MB7667:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Af9cozchfkJ11tAhrMx+hUek7Guh1Dbkl4Dm7Yjl33N3rJG/m0YEXV9ZPqNr1uarRX2WRE8liK8867eYevVaobmKWw+Vow2kUDqPKr4fIWfZFmXSTbTYOADkFti9LOG9qjvdyOp/IQ7YdT5vAJq7MWQeGCXDTs5LxWjrJDjRnhY0NuDSFzK2PQlJ3/8vVohSkbviTydP2PJNBwPIUYsp/ugy+MEpcgttQ0TgNdjIbyLwftxx8ixla+OToNl9IA1ltdEc73ElzKrKZeYXS/+0lpWKkjtxNdDYyX8U0i97Ym3+tfPSWoyyfEnBZVkonxFhnvcPnb2a4CcF5U6jzJJV+VyqLKLz5EYJ3boQQvZrOCcpk4xhra6DpxKd+z/yy/HO2XK5OBolovHxY1F18+S7uaHTCpUsFaWcaNhydkTtAth+AhosHMibm+JzySIBinsCzPvjEXwEuYh1RlhAg9NyfqFHyVJnIn1eFnUD7TTxwLoEzEM9qHcv4c13ArHdqYfZIHSmBv8GX1XbVL7tjq9yz9fJbzkJKHvmgl7LglAsD+FNGc171gY5lyqjsSP0WLPGkTtbzM9gkWIKteWBNZQIjgZL1eOfOAUhSA7d6WJOIBc=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB6373.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(366007); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WDdqTkZpOGpQaVZubjY4NTBlenNTSU5jSC8zUTFyNHpTc0tSRk9ma0FUTjlK?=
 =?utf-8?B?M2w1cFMzN3oxejFQOEJxSVlaRzVWdi9qaXgzeE1LcUJBZzdQTS9zSE0zN3lj?=
 =?utf-8?B?WDRzU0diRU9PVUhQYVAwMHV1NWZabVdnbzFQVldyM1E4dmtpQk9NMldCYU1W?=
 =?utf-8?B?bnFNcTRxVmtHTkMzaDR5cUtrcmREbnFCVldVSU5MQ0xOQ1R0NDFKT2RHVk1u?=
 =?utf-8?B?UGluRmVvekZVZ3RIK0F4UjlNSkZhYUMwM09QSFVyS3JIWFY3OTNjc01ZTnZx?=
 =?utf-8?B?SDkxT284YmExU1dFSUFac09MMFRtYmcza2NwUFFucjh1ck5mMWZSczNONnM2?=
 =?utf-8?B?elJqc01RZE1nck5vdmIwL0JtZm5BaTJIREIvZnRqVWt1d2phUmd0K2p2eFQx?=
 =?utf-8?B?QnZYTjdrVmFxY1Z2Z0s3a0JLdWlHQVlZcmVPcG96YnQzaWVvV08zWjNWdlNN?=
 =?utf-8?B?MGhLeHJ2TE4ySmNLU0pINS9WdTlzVWVYWFRWRC9xUFg0VEwwcGpZYkdUL1dJ?=
 =?utf-8?B?R3EveWM5SWZMLzE4TjhyOEtjQ09PUThSTm5uZGtRSG81UytlbWtaRnZjbmRE?=
 =?utf-8?B?cXljSkp1WDcwWEZqaWcyQWVEQ3FiL1BNOEt2U2h1ZnVKZElrVlR0Uk9Qdlo0?=
 =?utf-8?B?MHc5dzVvdmVWRlhZL2JCZGJiU1lsVlZ5bVhZSHl5YWh5aTV3bUJoa01wSy91?=
 =?utf-8?B?QmxDUTVBWE56bDlFbU53S3FwUHpRTm8rS3dyd1lmdjVKWndGT0RPZC9sTU52?=
 =?utf-8?B?ajBqeDZwMU1xRW85bitIYWxqZVlXMGxpK3V0SU12WGdnZ2RvTWlIb2Zma0U4?=
 =?utf-8?B?TFBrM2xXUXV1Ri9tMms3SkRyUkpKbkgyWXBsSzZlcnBCZTBON094bE51ek8w?=
 =?utf-8?B?Tk15NEVhUm9TN3dMREZjdnY4MkhhZUpuUXFheDN5Z1dZK1ZZU05Pc1ZmeEhz?=
 =?utf-8?B?RlZRVnJxd3ZCU2lCbUlZMlV1c0VGUURXT0J4WjFnV3NJNVBoQmJZWTJ3bnMw?=
 =?utf-8?B?NDJ6NW1KcGRXb2Z1U1F3SFNGbE1GeGtzcXlCaE1ISVNpY0ZPTzFaMWxkdjY0?=
 =?utf-8?B?SkJDRkV5ZEtvajc1RnVFaHlQWURkR0hRSlRJcFN5NHpmZzUxNUYvWUFVV1NH?=
 =?utf-8?B?WUhiczdWaFVaUUYyUzJyaEN6ZTFxVkt6OUVzS0x1SS9SRmRwdmFRZmlyekYx?=
 =?utf-8?B?VDRnOEZQTWxPZ29MbnF6NWtacFlhOEtzWHpGakRMbmo1MHdXQzQ2UnlvK0pl?=
 =?utf-8?B?Z2FiZjFOQlpIOFlDZms1enNldXZZc3hmeUVCbWc1QkFUVEkxTzhpYXBUYytR?=
 =?utf-8?B?NTFCb3JHSmRwM0hLeHlMNGFDNURKQkxuR3hSOUJJQldMMnBuQzRCRFBUS2Zr?=
 =?utf-8?B?dFVYdzU2SWJJSkFld3VJT2V1UjdsM1hQODFaSTgxOEVmdG1UMXgyQTdjdjh0?=
 =?utf-8?B?NmdzbWtjcEtEc01HRkNZaDFGbkljU3VreG8xcGZPVGhCSzJQNmFHUnlUcU84?=
 =?utf-8?B?K2I1R2g3Nmd4czgwNlNoUC9NUzFnZU43M09SNjJWYUxSdUZ5T3VENXdpTXk3?=
 =?utf-8?B?d2c0RlFEQ3BkZjIzT3FMRGxkK0FPV1k0UVVrWGJNTW9VUERYbTA4VWg4cWxP?=
 =?utf-8?B?bXhSK0E3cVREZzRSajcrd29xUWdqRjRVSEpYLy90dGlSM1VTZ3hPbU1QOUVJ?=
 =?utf-8?B?b1ZZaDlJcHUzOVh1Skx6QzFhVkhEazMyWTBuNmw1OEE2LzRMVkk3MExBbDZB?=
 =?utf-8?B?TGxNRGY2aC8vUVdRQ1NkY1FlVDh5ejlsN0g5TGY3dmZtT09mMkwxN2JuSTNG?=
 =?utf-8?B?d2hnWjZzbkdwZFI1dVoxWHgwQitmQVlNZkNFa0xPd0ZSeThkQ29sQ0RZc1FS?=
 =?utf-8?B?c0pxb0lGM3luMkdWK3hnbk1IdVZVbW5SVjBpQUxKZkkwZ2wrcnk0cXEyamdH?=
 =?utf-8?B?WWZDZnppTWFtK1pzK3YxbCtEckhLWVRDYk43MWlvZTN3ZkRWTjhBUEdaaG9B?=
 =?utf-8?B?a280NS8xV24wVHFnSjVaSkxvWHdEUFhTUDZOb2NTL3hRR1AwWWMwa0xtVGJP?=
 =?utf-8?B?SmlHcUhseThKZnlJNlpzL2xxeURwSysvb3lJdDA2RnlDOVVuMUt2cDVGWUNi?=
 =?utf-8?Q?ZUWX3yLh6IbP3zbMJt24Ux8Ea?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB6373.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f6f3357-dc17-466d-d552-08dc551d5e1c
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Apr 2024 03:06:20.0876 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YJlNfrPsK17/AJ0wdL4/JBheivfafoPPBchuKWVAmq3vphWh0dYaACpa1m2se5L61Yyt4n7vwlJsQwKz+OokiQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7667
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.19; envelope-from=wei.w.wang@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

T24gRnJpZGF5LCBBcHJpbCA1LCAyMDI0IDEwOjMzIEFNLCBQZXRlciBYdSB3cm90ZToNCj4gT24g
RnJpLCBBcHIgMDUsIDIwMjQgYXQgMDE6Mzg6MzFBTSArMDAwMCwgV2FuZywgV2VpIFcgd3JvdGU6
DQo+ID4gT24gRnJpZGF5LCBBcHJpbCA1LCAyMDI0IDQ6NTcgQU0sIFBldGVyIFh1IHdyb3RlOg0K
PiA+ID4gT24gRnJpLCBBcHIgMDUsIDIwMjQgYXQgMTI6NDg6MTVBTSArMDgwMCwgV2FuZywgTGVp
IHdyb3RlOg0KPiA+ID4gPiBPbiA0LzUvMjAyNCAwOjI1LCBXYW5nLCBXZWkgVyB3cm90ZTo+IE9u
IFRodXJzZGF5LCBBcHJpbCA0LCAyMDI0DQo+ID4gPiA+IDEwOjEyIFBNLCBQZXRlciBYdSB3cm90
ZToNCj4gPiA+ID4gPj4gT24gVGh1LCBBcHIgMDQsIDIwMjQgYXQgMDY6MDU6NTBQTSArMDgwMCwg
V2VpIFdhbmcgd3JvdGU6DQo+ID4gPiA+ID4+PiBCZWZvcmUgbG9hZGluZyB0aGUgZ3Vlc3Qgc3Rh
dGVzLCBlbnN1cmUgdGhhdCB0aGUgcHJlZW1wdA0KPiA+ID4gPiA+Pj4gY2hhbm5lbCBoYXMgYmVl
biByZWFkeSB0byB1c2UsIGFzIHNvbWUgb2YgdGhlIHN0YXRlcyAoZS5nLiB2aWENCj4gPiA+ID4g
Pj4+IHZpcnRpb19sb2FkKSBtaWdodCB0cmlnZ2VyIHBhZ2UgZmF1bHRzIHRoYXQgd2lsbCBiZSBo
YW5kbGVkDQo+ID4gPiA+ID4+PiB0aHJvdWdoIHRoZQ0KPiA+ID4gcHJlZW1wdCBjaGFubmVsLg0K
PiA+ID4gPiA+Pj4gU28geWllbGQgdG8gdGhlIG1haW4gdGhyZWFkIGluIHRoZSBjYXNlIHRoYXQg
dGhlIGNoYW5uZWwNCj4gPiA+ID4gPj4+IGNyZWF0ZSBldmVudCBoYXMgYmVlbiBkaXNwYXRjaGVk
Lg0KPiA+ID4gPiA+Pj4NCj4gPiA+ID4gPj4+IE9yaWdpbmFsbHktYnk6IExlaSBXYW5nIDxsZWk0
LndhbmdAaW50ZWwuY29tPg0KPiA+ID4gPiA+Pj4gTGluazoNCj4gPiA+ID4gPj4+IGh0dHBzOi8v
bG9yZS5rZXJuZWwub3JnL2FsbC85YWE1ZDFiZS03ODAxLTQwZGQtODNmZC1mN2UwNDFjZWQyDQo+
ID4gPiA+ID4+PiA0OUBpDQo+ID4gPiA+ID4+PiBudGVsDQo+ID4gPiA+ID4+PiAuY29tL1QvDQo+
ID4gPiA+ID4+PiBTdWdnZXN0ZWQtYnk6IFBldGVyIFh1IDxwZXRlcnhAcmVkaGF0LmNvbT4NCj4g
PiA+ID4gPj4+IFNpZ25lZC1vZmYtYnk6IExlaSBXYW5nIDxsZWk0LndhbmdAaW50ZWwuY29tPg0K
PiA+ID4gPiA+Pj4gU2lnbmVkLW9mZi1ieTogV2VpIFdhbmcgPHdlaS53LndhbmdAaW50ZWwuY29t
Pg0KPiA+ID4gPiA+Pj4gLS0tDQo+ID4gPiA+ID4+PiAgbWlncmF0aW9uL3NhdmV2bS5jIHwgMTcg
KysrKysrKysrKysrKysrKysNCj4gPiA+ID4gPj4+ICAxIGZpbGUgY2hhbmdlZCwgMTcgaW5zZXJ0
aW9ucygrKQ0KPiA+ID4gPiA+Pj4NCj4gPiA+ID4gPj4+IGRpZmYgLS1naXQgYS9taWdyYXRpb24v
c2F2ZXZtLmMgYi9taWdyYXRpb24vc2F2ZXZtLmMgaW5kZXgNCj4gPiA+ID4gPj4+IDM4OGQ3YWY3
Y2QuLmZiYzlmMmJkZDQgMTAwNjQ0DQo+ID4gPiA+ID4+PiAtLS0gYS9taWdyYXRpb24vc2F2ZXZt
LmMNCj4gPiA+ID4gPj4+ICsrKyBiL21pZ3JhdGlvbi9zYXZldm0uYw0KPiA+ID4gPiA+Pj4gQEAg
LTIzNDIsNiArMjM0MiwyMyBAQCBzdGF0aWMgaW50DQo+ID4gPiA+ID4+PiBsb2Fkdm1faGFuZGxl
X2NtZF9wYWNrYWdlZChNaWdyYXRpb25JbmNvbWluZ1N0YXRlICptaXMpDQo+ID4gPiA+ID4+Pg0K
PiA+ID4gPiA+Pj4gICAgICBRRU1VRmlsZSAqcGFja2YgPSBxZW11X2ZpbGVfbmV3X2lucHV0KFFJ
T19DSEFOTkVMKGJpb2MpKTsNCj4gPiA+ID4gPj4+DQo+ID4gPiA+ID4+PiArICAgIC8qDQo+ID4g
PiA+ID4+PiArICAgICAqIEJlZm9yZSBsb2FkaW5nIHRoZSBndWVzdCBzdGF0ZXMsIGVuc3VyZSB0
aGF0IHRoZQ0KPiA+ID4gPiA+Pj4gKyBwcmVlbXB0IGNoYW5uZWwNCj4gPiA+IGhhcw0KPiA+ID4g
PiA+Pj4gKyAgICAgKiBiZWVuIHJlYWR5IHRvIHVzZSwgYXMgc29tZSBvZiB0aGUgc3RhdGVzIChl
LmcuIHZpYSB2aXJ0aW9fbG9hZCkNCj4gbWlnaHQNCj4gPiA+ID4gPj4+ICsgICAgICogdHJpZ2dl
ciBwYWdlIGZhdWx0cyB0aGF0IHdpbGwgYmUgaGFuZGxlZCB0aHJvdWdoIHRoZQ0KPiA+ID4gPiA+
Pj4gKyBwcmVlbXB0DQo+ID4gPiBjaGFubmVsLg0KPiA+ID4gPiA+Pj4gKyAgICAgKiBTbyB5aWVs
ZCB0byB0aGUgbWFpbiB0aHJlYWQgaW4gdGhlIGNhc2UgdGhhdCB0aGUNCj4gPiA+ID4gPj4+ICsg
Y2hhbm5lbCBjcmVhdGUNCj4gPiA+IGV2ZW50DQo+ID4gPiA+ID4+PiArICAgICAqIGhhcyBiZWVu
IGRpc3BhdGNoZWQuDQo+ID4gPiA+ID4+PiArICAgICAqLw0KPiA+ID4gPiA+Pj4gKyAgICBkbyB7
DQo+ID4gPiA+ID4+PiArICAgICAgICBpZiAoIW1pZ3JhdGVfcG9zdGNvcHlfcHJlZW1wdCgpIHx8
ICFxZW11X2luX2Nvcm91dGluZSgpIHx8DQo+ID4gPiA+ID4+PiArICAgICAgICAgICAgbWlzLT5w
b3N0Y29weV9xZW11ZmlsZV9kc3QpIHsNCj4gPiA+ID4gPj4+ICsgICAgICAgICAgICBicmVhazsN
Cj4gPiA+ID4gPj4+ICsgICAgICAgIH0NCj4gPiA+ID4gPj4+ICsNCj4gPiA+ID4gPj4+ICsgICAg
ICAgIGFpb19jb19zY2hlZHVsZShxZW11X2dldF9jdXJyZW50X2Fpb19jb250ZXh0KCksDQo+ID4g
PiA+ID4+IHFlbXVfY29yb3V0aW5lX3NlbGYoKSk7DQo+ID4gPiA+ID4+PiArICAgICAgICBxZW11
X2Nvcm91dGluZV95aWVsZCgpOw0KPiA+ID4gPiA+Pj4gKyAgICB9IHdoaWxlDQo+ID4gPiA+ID4+
PiArICghcWVtdV9zZW1fdGltZWR3YWl0KCZtaXMtPnBvc3Rjb3B5X3FlbXVmaWxlX2RzdF9kb25l
LA0KPiA+ID4gPiA+Pj4gKyAxKSk7DQo+ID4gPiA+ID4+DQo+ID4gPiA+ID4+IEkgdGhpbmsgd2Ug
bmVlZCBzLyEvLyBoZXJlLCBzbyB0aGUgc2FtZSBtaXN0YWtlIEkgbWFkZT8gIEkNCj4gPiA+ID4g
Pj4gdGhpbmsgd2UgbmVlZCB0byByZXdvcmsgdGhlIHJldHZhbCBvZiBxZW11X3NlbV90aW1lZHdh
aXQoKSBhdCBzb21lDQo+IHBvaW50IGxhdGVyLi4NCj4gPiA+ID4gPg0KPiA+ID4gPiA+IE5vLiBx
ZW11X3NlbV90aW1lZHdhaXQgcmV0dXJucyBmYWxzZSB3aGVuIHRpbWVvdXQsIHdoaWNoIG1lYW5z
DQo+ID4gPiA+ID4gc2VtDQo+ID4gPiBpc27igJl0IHBvc3RlZCB5ZXQuDQo+ID4gPiA+ID4gU28g
aXQgbmVlZHMgdG8gZ28gYmFjayB0byB0aGUgbG9vcC4gKHRoZSBwYXRjaCB3YXMgdGVzdGVkKQ0K
PiA+ID4gPg0KPiA+ID4gPiBXaGVuIHRpbWVvdXQsIHFlbXVfc2VtX3RpbWVkd2FpdCgpIHdpbGwg
cmV0dXJuIC0xLiBJIHRoaW5rIHRoZQ0KPiA+ID4gPiBwYXRjaCB0ZXN0IHBhc3NlZCBtYXkgYmVj
YXVzZSB5b3Ugd2lsbCBhbHdheXMgaGF2ZSBhdCBsZWFzdCBvbmUNCj4gPiA+ID4geWllbGQgKHRo
ZSBmaXJzdCB5aWVsZCBpbiB0aGUgZG8gLi4ud2hpbGUgLi4uKSB3aGVuDQo+IGxvYWR2bV9oYW5k
bGVfY21kX3BhY2thZ2VkKCk/DQo+ID4gPg0KPiA+ID4gTXkgZ3Vlc3MgaXMgdGhhdCBoZXJlIHRo
ZSBraWNrIHdpbGwgd29yayBhbmQgcWVtdV9zZW1fdGltZWR3YWl0KCkNCj4gPiA+IGxhdGVyIHdp
bGwgRVRJTUVPVVQgLT4gcWVtdV9zZW1fdGltZWR3YWl0KCkgcmV0dXJucyAtMSwgdGhlbiB0aGUg
bG9vcA0KPiBqdXN0IGJyb2tlLg0KPiA+ID4gVGhhdCBhaW8gc2NoZWR1bGUgc2hvdWxkIG1ha2Ug
c3VyZSBhbnl3YXkgdGhhdCB0aGUgZmlsZSBpcyByZWFkeTsNCj4gPiA+IHRoZSBwcmVlbXB0IHRo
cmVhZCBtdXN0IHJ1biBiZWZvcmUgdGhpcyB0byBub3QgaGFuZyB0aGF0IHRocmVhZC4NCj4gPg0K
PiA+IFllcywgbWlzcmVhZCBvZiB0aGUgcmV0dXJuIHZhbHVlLiBJdCBzdGlsbCB3b3JrZWQgYmVj
YXVzZSB0aGUgbG9vcA0KPiA+IGJyb2tlIGF0IHRoZSAiaWYgKG1pcy0+cG9zdGNvcHlfcWVtdWZp
bGVfZHN0KSIgY2hlY2suDQo+ID4NCj4gPiBFdmVuIGJlbG93IHdpbGwgd29yazoNCj4gPiBkbyB7
DQo+ID4gICAgIGlmIChtaXMtPnBvc3Rjb3B5X3FlbXVmaWxlX2RzdCkgew0KPiA+ICAgICAgICAg
YnJlYWs7DQo+ID4gICAgICB9DQo+ID4gLi4uDQo+ID4gfSB3aGlsZSAoMSk7DQo+ID4NCj4gPiBJ
IHN0aWxsIGRvbuKAmXQgc2VlIHRoZSB2YWx1ZSBvZiB1c2luZyBwb3N0Y29weV9xZW11ZmlsZV9k
c3RfZG9uZSBzZW0gaW4NCj4gPiB0aGUgY29kZSB0aG91Z2ggSXQgc2ltcGxpZnkgYmxvY2tzIHRo
ZSBtYWluIHRocmVhZCBmcm9tIGNyZWF0aW5nIHRoZQ0KPiA+IHByZWVtcHQgY2hhbm5lbCBmb3Ig
MW1zIChyZWdhcmRsZXNzIG9mIHRoZSBwb3NzaWJpbGl0eSBhYm91dCB3aGV0aGVyDQo+ID4gdGhl
IHNlbSBoYXMgYmVlbiBiZSBwb3N0ZWQgb3Igbm90LiBXZSBhZGQgaXQgZm9yIHRoZSBjYXNlIGl0
IGlzIG5vdCBwb3N0ZWQNCj4gYW5kIG5lZWQgdG8gZ28gYmFjayB0byB0aGUgbG9vcCkuDQo+IA0K
PiBJIHRoaW5rIGl0IHVzZWQgdG8gb25seSB3YWl0KCkgaW4gdGhlIHByZWVtcHQgdGhyZWFkLCBz
byB0aGF0IGlzIG5lZWRlZC4NCj4gSXQncyBhbHNvIG5lZWRlZCB3aGVuIHBvc3Rjb3B5IGlzIGlu
dGVycnVwdGVkIGFuZCBuZWVkIGEgcmVjb3Zlciwgc2VlDQo+IGxvYWR2bV9wb3N0Y29weV9oYW5k
bGVfcmVzdW1lKCksIGluIHRoYXQgY2FzZSBpdCdzIHRoZSBwb3N0Y29weSByYW0gbG9hZA0KPiB0
aHJlYWQgdGhhdCB3YWl0cyBmb3IgaXQgcmF0aGVyIHRoYW4gdGhlIG1haW4gdGhyZWFkIG9yIHBy
ZWVtcHQgdGhyZWFkLg0KPiANCj4gSW5kZWVkIGlmIHdlIG1vdmUgY2hhbm5lbCBjcmVhdGlvbiBv
dXQgb2YgdGhlIHByZWVtcHQgdGhyZWFkIHRoZW4gaXQgc2VlbXMNCj4gd2UgZG9uJ3QgbmVlZCB0
aGUgc2VtIGluIHRoaXMgcGF0aC4gIEhvd2V2ZXIgdGhlIG90aGVyIHBhdGggd2lsbCBzdGlsbCBu
ZWVkIGl0LA0KPiB0aGVuIHdoZW4gdGhlIG5ldyBjaGFubmVsIGNyZWF0ZWQgKHBvc3Rjb3B5X3By
ZWVtcHRfbmV3X2NoYW5uZWwpIHdlJ2xsDQo+IG5lZWQgdG8gaWRlbnRpZnkgYSAic3dpdGNoIHRv
IHBvc3Rjb3B5IiBjYXNlIG9yICJwb3N0Y29weSByZWNvdmVyeSIgY2FzZSwgb25seQ0KPiBwb3N0
IHRoZSBzZW0gd2hlbiB0aGUgZm9ybWVyLiAgSSB0aGluayBpdCBtaWdodCBjb21wbGljYXRlIHRo
ZSBjb2RlLCBJJ2xsIHRoaW5rDQo+IGFnYWluIHRvbW9ycm93IGFmdGVyIGEgc2xlZXAgc28gbXkg
YnJhaW4gd2lsbCB3b3JrIGJldHRlciwgYnV0IEkgZG91YnQgdGhpcyBpcw0KPiB3aGF0IHdlIHdh
bnQgdG8gZG8gYXQgcmMzLg0KDQpZZXMsIGl0J3MgYSBiaXQgcnVzaGVkIChubyBuZWVkIHRvIHJl
bW92ZSBpdCBjb21wbGV0ZWx5IGF0IHJjMykuDQoNCj4gDQo+IElmIHlvdSBmZWVsIGNvbWZvcnRh
YmxlLCBwbGVhc2UgZmVlbCBmcmVlIHRvIHNlbmQgYSB2ZXJzaW9uIHRoYXQgeW91IHRoaW5rIGlz
IHRoZQ0KPiBtb3N0IGNvcnJlY3Qgc28gZmFyIChpZiB5b3UgcHJlZmVyIG5vIHRpbWVkd2FpdCBp
dCdzIGZpbmUpLCBhbmQgbWFrZSBzdXJlIHRoZSB0ZXN0DQo+IHdvcmtzIHRoZSBiZXN0IG9uIHlv
dXIgc2lkZS4gIFRoZW4gSSdsbCBzbW9rZSBpdCBhIGJpdCBkdXJpbmcgd2Vla2VuZHMuIFBsZWFz
ZQ0KPiBhbHdheXMga2VlcCB0aGF0IGluIG1pbmQgaWYgdGhhdCB3aWxsIGJlIGZvciByYzMgaXQg
c2hvdWxkIGJlIG5vbi1pbnRydXNpdmUNCj4gY2hhbmdlLCBvciB3ZSBrZWVwIGl0IHNsb3cgZm9y
IDkuMSBhbmQgd2UgZG9uJ3QgbmVlZCB0byBydXNoLg0KPiANClNvdW5kcyBnb29kLg0K

