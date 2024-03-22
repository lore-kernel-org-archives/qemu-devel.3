Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53397C47DD9
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Mar 2024 14:48:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rngAr-0005BA-5g; Fri, 22 Mar 2024 10:47:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yuan1.liu@intel.com>)
 id 1rngAq-0005B1-1H
 for qemu-devel@nongnu.org; Fri, 22 Mar 2024 10:47:12 -0400
Received: from mgamail.intel.com ([192.198.163.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yuan1.liu@intel.com>)
 id 1rngAm-00042N-Lo
 for qemu-devel@nongnu.org; Fri, 22 Mar 2024 10:47:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1711118827; x=1742654827;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=vHoYYYiA1a+60SKbenykgvZE6XnvwfE8O73B1VTg59k=;
 b=MwUO9H7fmmAMKcX0sejaKR9wtKkHPRkg55ss13M0uwhayHYV+lgF8Yqi
 RFfT+KvnEwBGyRDDtmxBxSn9cKFlK0uselw6svylZ6WfW5bC3KAMaDYUW
 lk4Yejdlu7Ko6/pY4gvxEqpy7fniDLgcKVzVs66YaqEUPDaEU8IxPAkfw
 9zNa/jkOh21/+PllJdJH7Ij6kiSSu306gb/LZE9BusXwl2+cmUDuMKsck
 t5X43Hx6bkH1HJJbY2OPWxlj/7qsaF+nZ1a3T3Fj2QZpipvPFiQWd2StP
 wqHhqVfXEBnGQpt35gppDgvVdR9kK7/KkZmICybMNxNfpW7SXqWWUAnFx g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11020"; a="6354845"
X-IronPort-AV: E=Sophos;i="6.07,146,1708416000"; 
   d="scan'208";a="6354845"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Mar 2024 07:47:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,146,1708416000"; d="scan'208";a="19493383"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
 by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 22 Mar 2024 07:47:06 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 22 Mar 2024 07:47:05 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 22 Mar 2024 07:47:04 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 22 Mar 2024 07:47:04 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 22 Mar 2024 07:47:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JV+B1z2eriPP/VrVcGj5QXB+Yvk90F99S1r7xwBHgcHfk4/bSsDwFrdFhIbIIxMOesVwEjvBeSsYlMgLiJ+9PItiN+2HdRsCxgZ1bNIL5hhkoiqCO1XZdOS+csyWl8MLRd0X6YLBItB7ipLdI6QZyZB+UtjlUX+FVGsWjmlRNlFacfFPUhCgu3HDAE7/Bc3DKLpF8W6mQC8I3uMMgHDfNaEyG1e+5sNw+r+5aSnACi32hrkVSLPGXou5yQpkNH7GgCNKMcd/YfBByoSGl5Aekx/e+KQaVUrKSFV9jJbcRxMvXIA7Sn/D3VupLpZhsr5TxcFks48YoRhVRzhOAQyULQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vHoYYYiA1a+60SKbenykgvZE6XnvwfE8O73B1VTg59k=;
 b=Q0J3PYZidjiMYqnZt2q0Waa87ZJAitYeqYZrZWVwGSpc6n3Fky6WODm8Z46whTlq998Hk1O49PhCGJtiBa9uZUySdMqIMnrpgVtCeX1JBvy/f7ng+TrgZli0pUH+pAUQw5ULlKiwJ/VBrTiuEb48rePz5DdyeyRPN5WeHPnvOujDBBS/Iyz/dVqVRtTEQ0AKliU2aSMDallVOJYFAF/JX8U/7y56a/Gvg1IUZH/Nx+vyiM1C0Fn/pysYeoVyKBRopcGZ+KaVyF4jY4sKvq1Cpyqv6hTUHYHVudlvUMp1br3zk+RAjz1KHMgGTPxUh1WpCAFFsCtmJyGQS9GrFFMrSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB5941.namprd11.prod.outlook.com (2603:10b6:510:13d::20)
 by DS7PR11MB7784.namprd11.prod.outlook.com (2603:10b6:8:e1::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.24; Fri, 22 Mar
 2024 14:47:02 +0000
Received: from PH7PR11MB5941.namprd11.prod.outlook.com
 ([fe80::f926:1804:73ce:ca52]) by PH7PR11MB5941.namprd11.prod.outlook.com
 ([fe80::f926:1804:73ce:ca52%4]) with mapi id 15.20.7409.010; Fri, 22 Mar 2024
 14:47:02 +0000
From: "Liu, Yuan1" <yuan1.liu@intel.com>
To: Peter Xu <peterx@redhat.com>
CC: =?utf-8?B?RGFuaWVsIFAuIEJlcnJhbmfDqQ==?= <berrange@redhat.com>,
 "farosas@suse.de" <farosas@suse.de>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "hao.xiang@bytedance.com" <hao.xiang@bytedance.com>, 
 "bryan.zhang@bytedance.com" <bryan.zhang@bytedance.com>, "Zou, Nanhai"
 <nanhai.zou@intel.com>
Subject: RE: [PATCH v5 5/7] migration/multifd: implement initialization of qpl
 compression
Thread-Topic: [PATCH v5 5/7] migration/multifd: implement initialization of
 qpl compression
Thread-Index: AQHaeqFFcriI4s02jkWbmxh5d6Bh27FAcVgAgABDk6CAAA4OAIAACKEggABKaQCAAFH34IAA63wAgACmUnCAANqGYA==
Date: Fri, 22 Mar 2024 14:47:02 +0000
Message-ID: <PH7PR11MB5941B5EB0C21FBFB6C8FFA16A3312@PH7PR11MB5941.namprd11.prod.outlook.com>
References: <20240319164527.1873891-1-yuan1.liu@intel.com>
 <20240319164527.1873891-6-yuan1.liu@intel.com> <Zfq9lBXZWcy3Alhw@redhat.com>
 <PH7PR11MB59410E02C6C7CECD7E30AA4FA3332@PH7PR11MB5941.namprd11.prod.outlook.com>
 <ZfsCDhnYYmjxLTRW@x1n>
 <PH7PR11MB5941F8AE52DBD0F197798103A3332@PH7PR11MB5941.namprd11.prod.outlook.com>
 <ZftHtgpxOPNA8AYE@x1n>
 <PH7PR11MB5941186DCF12ED13130CBF5FA3322@PH7PR11MB5941.namprd11.prod.outlook.com>
 <ZfxSAgJECCOqtGRh@x1n>
 <PH7PR11MB594128C3B1C9ED66482DFEDEA3312@PH7PR11MB5941.namprd11.prod.outlook.com>
In-Reply-To: <PH7PR11MB594128C3B1C9ED66482DFEDEA3312@PH7PR11MB5941.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB5941:EE_|DS7PR11MB7784:EE_
x-ms-office365-filtering-correlation-id: ba27ac4f-73c4-44ed-3c9d-08dc4a7eef4c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mQW3ccq2jhQnqNdQMzYufzMMfMQ9uLYp7EyBmEQt+0CHxdz6XtUiDMNSEC7r/znCVd+GULf/2sE4GseTwWAlCjPnyWi/B1o0rXVBYlRmnHvrXKhdtW1gaBR3PbRt4o/5qmla2aSladbKeyameYr5BadNfnaylwEP10MfvPCv06mMcuHBBBmHdxboYzpnGe/M8Iz0UYJky34uZqFyGyeYzNoLakXcVTOKZrqRs/pXQX7GjBYKGXBK21gRvnIVjfCsXY3hXmEfIm7L8o8V05gDrKX8In9O/tYS9U0HvZpr4aEb0RcoriUVv178hwj9YF12Fd4XpJSAEXJkC2NDgOcBnra2kyEZASyR4ujc8Z/UykpcqRE08MVEYa388GreNGHg798U4zgLJSlSSe3GqC3DvfNfwW3eFhpfXS6N+tFKsao545gic/+tNughdUJOj1CqgfESXdzIoWjv1IbxnmmFW4qaCbOFSk4hHTtOF1m/wgTfRRCa8XBlCuw8/8X13R+C3IwOj+lUSiFtXM1s4I2CVUIW47/Dku9gGGZQch45jAAsaRZyeq1ObCXs/Ls9jA/9OhLbTj5TqIldg+vDLKfJwt/cC/ogZeyJZxXWHeXKaZKXt903fzhqMs9MMChfcsfxUTZedsT37MrHJUTIw3n6MvfKM/Mg9Jw7rpBTLZ4v6YWf54NqF/LLMrp6XoTjAqk38DkyP70jePe1uX8MW7VJ6BqXuCWLF8tFvq+iVtlgOsM=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR11MB5941.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(366007)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RVhSQi9wSWM0SXlsTmxwenhpT0lUSUZLai9hUUY1clpPU2RxM0xtOTFnR29J?=
 =?utf-8?B?bVBHM0hTM1N2ZFJ2bDFmU3hsUHhXSWNWRmEyaXAzK0ZYa0VZeDJzVnF0MS80?=
 =?utf-8?B?TENpeTJzOGlzaVFTU0twUnNscUtBQTBWUnFlM1dSNWFDbTdqN1ArMGhVS25s?=
 =?utf-8?B?NXdQeVFkZFU1WjNxWDF6R0t4S3BBMW10cmhHZVBKVmx3aXgzR2JqbG9xOXpz?=
 =?utf-8?B?ZVdYWnJ3YVFvemhJY0tCeXVwblhaWGlkRml4R1hzVHlRUm5xdUNEdEVjcS9a?=
 =?utf-8?B?cUlQZ1dxR0VuakxmNDdxVG82VVhxdlFLUXNDa3BIcUtPMUNxQzQ4UHhOc2tY?=
 =?utf-8?B?WFZIK1pMUndXSDFFNWZmbVNaY1hsRVgxY1pMVSs2OEE0WXp3dTdGWHphMEU0?=
 =?utf-8?B?UGlkSEEyVXljNEpNUXRYTW91ODN1dWJZdHZvMnhxKzFxWlVER0NnZHNOaThM?=
 =?utf-8?B?NUlnOVlZVEpYdXVDdVl0R1dGQ0JhbXZ1VUN3UFNkWmxWV2NDMU9EYnJFVHJp?=
 =?utf-8?B?bTVwd2c5cEs1bXhZdTdqUVJVNDVFcHhnUzArVC9XUGFUVWdQdnE1ZEhCc3p6?=
 =?utf-8?B?RWhJRURPanRMVjZxbUxyM1JrQTlkK1FFMEhyR1lwM3dGNDgzUEhGWlo4cjl6?=
 =?utf-8?B?NTJ4bW1sSXFHOE53VzBsUHdYSE9YM2Vnd2p1SnBJTit6RzN4a1d0amtIdGtM?=
 =?utf-8?B?cUlVQUxzekh5aFNYMXNtcU9UeWluTTlFaDZpNmp4ZjJtS3hYdTEwdjdsYXJn?=
 =?utf-8?B?MHBmVTRUYjB4Nk13MHBrYVZrKzFpUzIycG85dmUxVzN6d0p2SUpVRmdMK0VP?=
 =?utf-8?B?cGsvYjQzL0Nvd0txaW51dkdweGtuMWVnc3BMUUVpbERGM2dBRXNjOUg3elN5?=
 =?utf-8?B?WVpHUDdtU1hlUmU0bWhNVkZueTJBZmVmcVBmNmcraU1DSUsvejRqOCtTV2hV?=
 =?utf-8?B?c0F0UllRbE14NlErdlRqdnNGTUF5WGlkYjVQSzBqUWliKzhQUDI0N2NYeExC?=
 =?utf-8?B?MmlmRW1uLzB1enp6ZEsxWVFmUVFTN0s0WUptM0dwWk1ZTzlMRk5DblZwVDU4?=
 =?utf-8?B?a3hkVTBTbnFqakN1L3hnYjEwUzNZSWEwelZMME1qY3RGdUJzdVJ2R3NWZWpJ?=
 =?utf-8?B?TCtRcFk0Y1h0V3RrZ053MnZTejI1ZERhZWtIWTZaRjJUQUFKOHlEcWs0VDNE?=
 =?utf-8?B?V1BxemZVTWtiaFJkaGZkZ1JOQ0t4L01TYmZBRnJNYytJWjFmekVJM1FxRExI?=
 =?utf-8?B?L0dTZnZkelVOZWwyNmZIUzVwNlo3dkc5cVhSek0xQ1h5ZFpKcnF1a0ozYTNa?=
 =?utf-8?B?V05udGxySzl5OEhlVXJ2bXZmZ3Y3WEQrZENkenhhWDdjWnpWYllpSDAxQU1y?=
 =?utf-8?B?akg5d3BOamJFcDU5QVM5dUUrL295aTA3a3NGcjJlY1JERmhqOEtsWWZvMDB2?=
 =?utf-8?B?MDFTc2VzY3ljb3ZWWktybXNVb0lMKy9oMEJnNWZ4ZHJaL1o0b2NPSGo5T3ZP?=
 =?utf-8?B?ZGpSaFdmazlwekw1MG91QlVBMEliazNBb1VmTjhDemVlU2pRMHZVdXVhUSta?=
 =?utf-8?B?eW9rY2dvRy8wTnBLOVFuZ3cvc0xsUHp6YXJZNnQ5Y21vUUFpVVZ4bGRDZi9n?=
 =?utf-8?B?NUJTaTlUWUZ2TjJteS82bTliYkIvRncvQ3g4L1dJYjB2TlAxLzA3Lzh6b2xw?=
 =?utf-8?B?K2hUaW1BS25YVUxaVTh4dkdNd1NTQzgwcmRnZXM4T3JVTVN4TWpuTXRGRWlq?=
 =?utf-8?B?a1JqUTVqVWx2OStBTDhCbTJ1VzBSa0ZIdlZ1ZHZoOHczVjA1VER6RnJQUWo4?=
 =?utf-8?B?Z0YrTDBGdG1FTzBNc2pJQzdjRmROQzdBV2JielZNcFVENmVBemxjM1c5R3I2?=
 =?utf-8?B?bjU5QVc3d2I4aGxrSVBQQ3VxOXJMenV1bWZqK2ZkVjZUODR4YWV5MEVKYllk?=
 =?utf-8?B?ZzdsNVhOUU9HZ2U3Qkk3Ukl2SU80VHhEazlEZGVDeXRTanoxZ0pRVkg4NzVz?=
 =?utf-8?B?T1lPZm9nSzJkNlpDczEvb2FzOEh5OGtzRmZxNUwrUG9rMHZVTytxTm5LbHR5?=
 =?utf-8?B?akRPQ2l4ejNyNUcxTC9tWWhyUzV5TUkwVXVNb1o2TVlWcGExSGo4UFBwUlIr?=
 =?utf-8?Q?VOMHKFLIig0PsMDWh7LDPg5II?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5941.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba27ac4f-73c4-44ed-3c9d-08dc4a7eef4c
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Mar 2024 14:47:02.0622 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: W1aF8QvmFZTOOEHmQgl/kChKrIhFAvTtMOpqfM9BtpDSeih7ttOvnjXk1o3RptOgR+hACuYSEaI5j6cDgMl+xw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB7784
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.15; envelope-from=yuan1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.222,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBMaXUsIFl1YW4xDQo+IFNlbnQ6
IEZyaWRheSwgTWFyY2ggMjIsIDIwMjQgMTA6MDcgQU0NCj4gVG86IFBldGVyIFh1IDxwZXRlcnhA
cmVkaGF0LmNvbT4NCj4gQ2M6IERhbmllbCBQLiBCZXJyYW5nw6kgPGJlcnJhbmdlQHJlZGhhdC5j
b20+OyBmYXJvc2FzQHN1c2UuZGU7IHFlbXUtDQo+IGRldmVsQG5vbmdudS5vcmc7IGhhby54aWFu
Z0BieXRlZGFuY2UuY29tOyBicnlhbi56aGFuZ0BieXRlZGFuY2UuY29tOyBab3UsDQo+IE5hbmhh
aSA8bmFuaGFpLnpvdUBpbnRlbC5jb20+DQo+IFN1YmplY3Q6IFJFOiBbUEFUQ0ggdjUgNS83XSBt
aWdyYXRpb24vbXVsdGlmZDogaW1wbGVtZW50IGluaXRpYWxpemF0aW9uIG9mDQo+IHFwbCBjb21w
cmVzc2lvbg0KPiANCj4gPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+IEZyb206IFBl
dGVyIFh1IDxwZXRlcnhAcmVkaGF0LmNvbT4NCj4gPiBTZW50OiBUaHVyc2RheSwgTWFyY2ggMjEs
IDIwMjQgMTE6MjggUE0NCj4gPiBUbzogTGl1LCBZdWFuMSA8eXVhbjEubGl1QGludGVsLmNvbT4N
Cj4gPiBDYzogRGFuaWVsIFAuIEJlcnJhbmfDqSA8YmVycmFuZ2VAcmVkaGF0LmNvbT47IGZhcm9z
YXNAc3VzZS5kZTsgcWVtdS0NCj4gPiBkZXZlbEBub25nbnUub3JnOyBoYW8ueGlhbmdAYnl0ZWRh
bmNlLmNvbTsgYnJ5YW4uemhhbmdAYnl0ZWRhbmNlLmNvbTsNCj4gWm91LA0KPiA+IE5hbmhhaSA8
bmFuaGFpLnpvdUBpbnRlbC5jb20+DQo+ID4gU3ViamVjdDogUmU6IFtQQVRDSCB2NSA1LzddIG1p
Z3JhdGlvbi9tdWx0aWZkOiBpbXBsZW1lbnQgaW5pdGlhbGl6YXRpb24NCj4gb2YNCj4gPiBxcGwg
Y29tcHJlc3Npb24NCj4gPg0KPiA+IE9uIFRodSwgTWFyIDIxLCAyMDI0IGF0IDAxOjM3OjM2QU0g
KzAwMDAsIExpdSwgWXVhbjEgd3JvdGU6DQo+ID4gPiA+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0t
LS0tDQo+ID4gPiA+IEZyb206IFBldGVyIFh1IDxwZXRlcnhAcmVkaGF0LmNvbT4NCj4gPiA+ID4g
U2VudDogVGh1cnNkYXksIE1hcmNoIDIxLCAyMDI0IDQ6MzIgQU0NCj4gPiA+ID4gVG86IExpdSwg
WXVhbjEgPHl1YW4xLmxpdUBpbnRlbC5jb20+DQo+ID4gPiA+IENjOiBEYW5pZWwgUC4gQmVycmFu
Z8OpIDxiZXJyYW5nZUByZWRoYXQuY29tPjsgZmFyb3Nhc0BzdXNlLmRlOyBxZW11LQ0KPiA+ID4g
PiBkZXZlbEBub25nbnUub3JnOyBoYW8ueGlhbmdAYnl0ZWRhbmNlLmNvbTsNCj4gYnJ5YW4uemhh
bmdAYnl0ZWRhbmNlLmNvbTsNCj4gPiBab3UsDQo+ID4gPiA+IE5hbmhhaSA8bmFuaGFpLnpvdUBp
bnRlbC5jb20+DQo+ID4gPiA+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjUgNS83XSBtaWdyYXRpb24v
bXVsdGlmZDogaW1wbGVtZW50DQo+ID4gaW5pdGlhbGl6YXRpb24gb2YNCj4gPiA+ID4gcXBsIGNv
bXByZXNzaW9uDQo+ID4gPiA+DQo+ID4gPiA+IE9uIFdlZCwgTWFyIDIwLCAyMDI0IGF0IDA0OjIz
OjAxUE0gKzAwMDAsIExpdSwgWXVhbjEgd3JvdGU6DQo+ID4gPiA+ID4gbGV0IG1lIGV4cGxhaW4g
aGVyZSwgZHVyaW5nIHRoZSBkZWNvbXByZXNzaW9uIG9wZXJhdGlvbiBvZiBJQUEsDQo+IHRoZQ0K
PiA+ID4gPiA+IGRlY29tcHJlc3NlZCBkYXRhIGNhbiBiZSBkaXJlY3RseSBvdXRwdXQgdG8gdGhl
IHZpcnR1YWwgYWRkcmVzcyBvZg0KPiA+IHRoZQ0KPiA+ID4gPiA+IGd1ZXN0IG1lbW9yeSBieSBJ
QUEgaGFyZHdhcmUuICBJdCBjYW4gYXZvaWQgY29weWluZyB0aGUNCj4gZGVjb21wcmVzc2VkDQo+
ID4gPiA+IGRhdGENCj4gPiA+ID4gPiB0byBndWVzdCBtZW1vcnkgYnkgQ1BVLg0KPiA+ID4gPg0K
PiA+ID4gPiBJIHNlZS4NCj4gPiA+ID4NCj4gPiA+ID4gPiBXaXRob3V0IC1tZW0tcHJlYWxsb2Ms
IGFsbCB0aGUgZ3Vlc3QgbWVtb3J5IGlzIG5vdCBwb3B1bGF0ZWQsIGFuZA0KPiA+IElBQQ0KPiA+
ID4gPiA+IGhhcmR3YXJlIG5lZWRzIHRvIHRyaWdnZXIgSS9PIHBhZ2UgZmF1bHQgZmlyc3QgYW5k
IHRoZW4gb3V0cHV0IHRoZQ0KPiA+ID4gPiA+IGRlY29tcHJlc3NlZCBkYXRhIHRvIHRoZSBndWVz
dCBtZW1vcnkgcmVnaW9uLiAgQmVzaWRlcyB0aGF0LCBDUFUNCj4gPiBwYWdlDQo+ID4gPiA+ID4g
ZmF1bHRzIHdpbGwgYWxzbyB0cmlnZ2VyIElPVExCIGZsdXNoIG9wZXJhdGlvbiB3aGVuIElBQSBk
ZXZpY2VzDQo+IHVzZQ0KPiA+IFNWTS4NCj4gPiA+ID4NCj4gPiA+ID4gT2ggc28gdGhlIElBQSBo
YXJkd2FyZSBhbHJlYWR5IGNhbiB1c2UgQ1BVIHBndGFibGVzPyAgTmljZS4uDQo+ID4gPiA+DQo+
ID4gPiA+IFdoeSBJT1RMQiBmbHVzaCBpcyBuZWVkZWQ/ICBBRkFJVSB3ZSdyZSBvbmx5IGluc3Rh
bGxpbmcgbmV3IHBhZ2VzLA0KPiB0aGUNCj4gPiA+ID4gcmVxdWVzdCBjYW4gZWl0aGVyIGNvbWUg
ZnJvbSBhIENQVSBhY2Nlc3Mgb3IgYSBETUEuICBJbiBhbGwgY2FzZXMNCj4gPiB0aGVyZQ0KPiA+
ID4gPiBzaG91bGQgaGF2ZSBubyB0ZWFyaW5nIGRvd24gb2YgYW4gb2xkIHBhZ2UuICBJc24ndCBh
biBpb3RsYiBmbHVzaA0KPiBvbmx5DQo+ID4gPiA+IG5lZWRlZCBpZiBhIHRlYXIgZG93biBoYXBw
ZW5zPw0KPiA+ID4NCj4gPiA+IEFzIGZhciBhcyBJIGtub3csIElBQSBoYXJkd2FyZSB1c2VzIFNW
TSB0ZWNobm9sb2d5IHRvIHVzZSB0aGUgQ1BVJ3MNCj4gcGFnZQ0KPiA+IHRhYmxlDQo+ID4gPiBm
b3IgYWRkcmVzcyB0cmFuc2xhdGlvbiAoSU9NTVUgc2NhbGFibGUgbW9kZSBkaXJlY3RseSBhY2Nl
c3NlcyB0aGUgQ1BVDQo+ID4gcGFnZSB0YWJsZSkuDQo+ID4gPiBUaGVyZWZvcmUsIHdoZW4gdGhl
IENQVSBwYWdlIHRhYmxlIGNoYW5nZXMsIHRoZSBkZXZpY2UncyBJbnZhbGlkYXRpb24NCj4gPiBv
cGVyYXRpb24gbmVlZHMNCj4gPiA+IHRvIGJlIHRyaWdnZXJlZCB0byB1cGRhdGUgdGhlIElPTU1V
IGFuZCB0aGUgZGV2aWNlJ3MgY2FjaGUuDQo+ID4gPg0KPiA+ID4gTXkgY3VycmVudCBrZXJuZWwg
dmVyc2lvbiBpcyBtYWlubGluZSA2LjIuIFRoZSBpc3N1ZSBJIHNlZSBpcyBhcw0KPiA+IGZvbGxv
d3M6DQo+ID4gPiAtLUhhbmRsZV9tbV9mYXVsdA0KPiA+ID4gIHwNCj4gPiA+ICAgLS0gd3BfcGFn
ZV9jb3B5DQo+ID4NCj4gPiBUaGlzIGlzIHRoZSBDb1cgcGF0aC4gIE5vdCB1c3VhbCBhdCBhbGwu
Lg0KPiA+DQo+ID4gSSBhc3N1bWUgdGhpcyBpc3N1ZSBzaG91bGQgb25seSBwcmVzZW50IG9uIGRl
c3RpbmF0aW9uLiAgVGhlbiB0aGUgZ3Vlc3QNCj4gPiBwYWdlcyBzaG91bGQgYmUgdGhlIGRlc3Rp
bmF0aW9uIG9mIHN1Y2ggRE1BcyB0byBoYXBwZW4sIHdoaWNoIG1lYW5zDQo+IHRoZXNlDQo+ID4g
c2hvdWxkIGJlIHdyaXRlIGZhdWx0cywgYW5kIGFzIHdlIHNlZSBoZXJlIGl0IGlzLCBvdGhlcndp
c2UgaXQgd29uJ3QNCj4gPiB0cmlnZ2VyIGEgQ29XLg0KPiA+DQo+ID4gSG93ZXZlciBpdCdzIG5v
dCBjbGVhciB0byBtZSB3aHkgYSBwcmUtaW5zdGFsbGVkIHplcm8gcGFnZSBleGlzdGVkLiAgSXQN
Cj4gPiBtZWFucyBzb21lb25lIHJlYWQgdGhlIGd1ZXN0IHBhZ2VzIGZpcnN0Lg0KPiA+DQo+ID4g
SXQgbWlnaHQgYmUgaW50ZXJlc3RpbmcgdG8ga25vdyBfd2h5XyBzb21lb25lIHJlYWRzIHRoZSBn
dWVzdCBwYWdlcywNCj4gZXZlbg0KPiA+IGlmIHdlIGtub3cgdGhleSdyZSBhbGwgemVyb3MuICBJ
ZiB3ZSBjYW4gYXZvaWQgc3VjaCByZWFkcyB0aGVuIGl0J2xsIGJlDQo+IGENCj4gPiBob2xlIHJh
dGhlciB0aGFuIGEgcHJlZmF1bHRlZCByZWFkIG9uIHplcm8gcGFnZSwgdGhlbiBpbnZhbGlkYXRp
b25zIGFyZQ0KPiA+IG5vdA0KPiA+IG5lZWRlZCwgYW5kIEkgZXhwZWN0IHRoYXQgc2hvdWxkIGZp
eCB0aGUgaW90bGIgc3Rvcm0gaXNzdWUuDQo+IA0KPiBUaGUgcmVjZWl2ZWQgcGFnZXMgd2lsbCBi
ZSByZWFkIGZvciB6ZXJvIHBhZ2VzIGNoZWNrIGZpcnN0LiBBbHRob3VnaA0KPiB0aGVzZSBwYWdl
cyBhcmUgemVybyBwYWdlcywgYW5kIElBQSBoYXJkd2FyZSB3aWxsIG5vdCBhY2Nlc3MgdGhlbSwg
dGhlDQo+IENPVyBoYXBwZW5zIGFuZCBjYXVzZXMgZm9sbG93aW5nIElPVExCIGZsdXNoIG9wZXJh
dGlvbi4gQXMgZmFyIGFzIEkga25vdywNCj4gSU9NTVUgcXVpY2tseSBkZXRlY3RzIHdoZXRoZXIg
dGhlIGFkZHJlc3MgcmFuZ2UgaGFzIGJlZW4gdXNlZCBieSB0aGUNCj4gZGV2aWNlLA0KPiBhbmQg
ZG9lcyBub3QgaW52YWxpZGF0ZSB0aGUgYWRkcmVzcyB0aGF0IGlzIG5vdCB1c2VkIGJ5IHRoZSBk
ZXZpY2UsIHRoaXMNCj4gaGFzDQo+IG5vdCB5ZXQgYmVlbiByZXNvbHZlZCBpbiBMaW51eCBrZXJu
ZWwgNi4yLiBJIHdpbGwgY2hlY2sgdGhlIGxhdGVzdCBzdGF0dXMNCj4gZm9yDQo+IHRoaXMuDQoN
CkkgY2hlY2tlZCB0aGUgTGludXggbWFpbmxpbmUgNi44IGNvZGUsIHRoZXJlIGFyZSBubyBiaWcg
Y2hhbmdlcyBmb3IgdGhpcy4NCkluIHZlcnNpb24gNi44LCBpZiB0aGUgcHJvY2VzcyBuZWVkcyB0
byBmbHVzaCBNTVUgVExCLCB0aGVuIEkvTyBUTEIgZmx1c2gNCndpbGwgYmUgYWxzbyB0cmlnZ2Vy
ZWQgd2hlbiB0aGUgcHJvY2VzcyBoYXMgU1ZNIGRldmljZXMuIEkgaGF2ZW4ndCBmb3VuZA0KdGhl
IGNvZGUgdG8gY2hlY2sgaWYgcGFnZXMgaGF2ZSBiZWVuIHNldCBFQSAoRXh0ZW5kZWQtQWNjZXNz
ZWQpIGJpdCBiZWZvcmUNCnN1Ym1pdHRpbmcgaW52YWxpZGF0aW9uIG9wZXJhdGlvbnMsIHRoaXMg
aXMgc2FtZSB3aXRoIHZlcnNpb24gNi4yLg0KDQpWVC1kIDMuNi4yDQpJZiB0aGUgRXh0ZW5kZWQt
QWNjZXNzZWQtRmxhZy1FbmFibGUgKEVBRkUpIGlzIDEgaW4gYSBzY2FsYWJsZS1tb2RlIFBBU0lE
LXRhYmxlDQplbnRyeSB0aGF0IHJlZmVyZW5jZXMgYSBmaXJzdC1zdGFnZSBwYWdpbmctc3RydWN0
dXJlIGVudHJ5IHVzZWQgYnkgdGhlIHJlbWFwcGluZw0KaGFyZHdhcmUsIGl0IGF0b21pY2FsbHkg
c2V0cyB0aGUgRUEgZmllbGQgaW4gdGhhdCBlbnRyeS4gV2hlbmV2ZXIgRUEgZmllbGQgaXMgDQph
dG9taWNhbGx5IHNldCwgdGhlIEEgZmllbGQgaXMgYWxzbyBzZXQgaW4gdGhlIHNhbWUgYXRvbWlj
IG9wZXJhdGlvbi4gRm9yIHNvZnR3YXJlDQp1c2FnZXMgd2hlcmUgdGhlIGZpcnN0LXN0YWdlIHBh
Z2luZyBzdHJ1Y3R1cmVzIGFyZSBzaGFyZWQgYWNyb3NzIGhldGVyb2dlbmVvdXMgYWdlbnRzDQoo
ZS5nLiwgQ1BVcyBhbmQgYWNjZWxlcmF0b3IgZGV2aWNlcyBzdWNoIGFzIEdQVXMpLCB0aGUgRUEg
ZmxhZyBtYXkgYmUgdXNlZCBieSBzb2Z0d2FyZQ0KdG8gaWRlbnRpZnkgcGFnZXMgYWNjZXNzZWQg
Ynkgbm9uLUNQVSBhZ2VudChzKSAoYXMgb3Bwb3NlZCB0byB0aGUgQSBmbGFnIHdoaWNoIGluZGlj
YXRlcw0KYWNjZXNzIGJ5IGFueSBhZ2VudCBzaGFyaW5nIHRoZSBwYWdpbmcgc3RydWN0dXJlcyku
DQoNCj4gdm9pZCBtdWx0aWZkX3JlY3ZfemVyb19wYWdlX3Byb2Nlc3MoTXVsdGlGRFJlY3ZQYXJh
bXMgKnApDQo+IHsNCj4gICAgIGZvciAoaW50IGkgPSAwOyBpIDwgcC0+emVyb19udW07IGkrKykg
ew0KPiAgICAgICAgIHZvaWQgKnBhZ2UgPSBwLT5ob3N0ICsgcC0+emVyb1tpXTsNCj4gICAgICAg
ICBpZiAoIWJ1ZmZlcl9pc196ZXJvKHBhZ2UsIHAtPnBhZ2Vfc2l6ZSkpIHsNCj4gICAgICAgICAg
ICAgbWVtc2V0KHBhZ2UsIDAsIHAtPnBhZ2Vfc2l6ZSk7DQo+ICAgICAgICAgfQ0KPiAgICAgfQ0K
PiB9DQo+IA0KPiANCj4gPiBJdCdsbCBzdGlsbCBiZSBnb29kIHdlIGNhbiBmaXggdGhpcyBmaXJz
dCB0byBub3QgbWFrZSBxcGwgc3BlY2lhbCBmcm9tDQo+ID4gdGhpcw0KPiA+IHJlZ2FyZCwgc28g
dGhhdCB0aGUgaG9wZSBpcyBtaWdyYXRpb24gc3VibW9kdWxlIHNob3VsZG4ndCByZWx5IG9uIGFu
eQ0KPiA+IHByZS1jb25maWcgKC1tZW0tcHJlYWxsb2MpIG9uIGd1ZXN0IG1lbW9yeSBiZWhhdmlv
cnMgdG8gd29yayBwcm9wZXJseS4NCj4gDQo+IEV2ZW4gaWYgdGhlIElPVExCIHByb2JsZW0gY2Fu
IGJlIGF2b2lkZWQsIHRoZSBJL08gcGFnZSBmYXVsdCBwcm9ibGVtDQo+IChub3JtYWwNCj4gcGFn
ZXMgYXJlIGxvYWRlZCBieSB0aGUgSUFBIGRldmljZSBhbmQgc29sdmluZyBub3JtYWwgcGFnZSBm
YXVsdHMgdGhyb3VnaA0KPiBJT01NVSwNCj4gdGhlIHBlcmZvcm1hbmNlIGlzIG5vdCBnb29kKQ0K
PiANCj4gSXQgY2FuIGxldCB0aGUgZGVjb21wcmVzc2VkIGRhdGEgb2YgdGhlIElBQSBkZXZpY2Ug
YmUgb3V0cHV0IHRvIGEgcHJlLQ0KPiBwb3B1bGF0ZWQNCj4gbWVtb3J5IGluc3RlYWQgb2YgZGly
ZWN0bHkgb3V0cHV0dGluZyB0byB0aGUgZ3Vlc3QgYWRkcmVzcywgYnV0IHRoZW4gZWFjaA0KPiBt
dWx0aWZkDQo+IHRocmVhZCBuZWVkcyB0d28gbWVtb3J5IGNvcGllcywgb25lIGNvcHkgZnJvbSB0
aGUgbmV0d29yayB0byB0aGUgSUFBIGlucHV0DQo+IG1lbW9yeShwcmUtcG9wdWxhdGVkKSwgYW5k
IGFub3RoZXIgY29weSBmcm9tIHRoZSBJQUEgb3V0cHV0IG1lbW9yeShwcmUtDQo+IHBvcHVsYXRl
ZCkNCj4gdG8gdGhlIGd1ZXN0IGFkZHJlc3MsIHdoaWNoIG1heSBiZWNvbWUgYSBwZXJmb3JtYW5j
ZSBib3R0bGVuZWNrIGF0IHRoZQ0KPiBkZXN0aW5hdGlvbg0KPiBkdXJpbmcgdGhlIGxpdmUgbWln
cmF0aW9uIHByb2Nlc3MuDQo+IA0KPiBTbyBJIHRoaW5rIGl0IGlzIHN0aWxsIG5lY2Vzc2FyeSB0
byB1c2UgdGhlIC1tZW0tcHJlYWxsb2Mgb3B0aW9uDQo+IA0KPiA+ID4gICAgIC0tIG1tdV9ub3Rp
Zmllcl9pbnZhbGlkYXRlX3JhbmdlDQo+ID4gPiAgICAgICB8DQo+ID4gPiAgICAgICAtLSBpbnRl
bF9pbnZhbGlkYXRlX3JhZ2UNCj4gPiA+ICAgICAgICAgfA0KPiA+ID4gICAgICAgICAtLSBxaV9m
bHVzaF9waW90bGINCj4gPiA+ICAgICAgICAgLS0gcWlfZmx1c2hfZGV2X2lvdGxiX3Bhc2lkDQo+
ID4NCj4gPiAtLQ0KPiA+IFBldGVyIFh1DQoNCg==

