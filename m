Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFAC7C48286
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Feb 2024 18:49:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVc7m-0006uK-Rg; Thu, 01 Feb 2024 13:49:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongwon.kim@intel.com>)
 id 1rVc7f-0006qt-GS
 for qemu-devel@nongnu.org; Thu, 01 Feb 2024 13:49:15 -0500
Received: from mgamail.intel.com ([192.55.52.120])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongwon.kim@intel.com>)
 id 1rVc7W-0000Zi-OT
 for qemu-devel@nongnu.org; Thu, 01 Feb 2024 13:49:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1706813346; x=1738349346;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=HDdZL7jORQptJFES3NSJKyi4rQR/NIo6pSlb6JE3HMk=;
 b=H/2mZEEmZ7EUqFgc3pm5Pf6fIvoCyDr4z0wHWSvdBdUTuCstUReVVxFT
 pN/3M5c2LlG0l0Kos2GG3z+GTKDgy/8XfPl8kc5/a4QMUrY4Twf3J5Ylk
 b4/WyYY8+1PmWzd1nfGXnTQDb2hZWayOYzxQrqsBjn/Vvc7oztZXlHawv
 8Tyh9fnpIYknP3/7zPS4jWoctBWxhAzYWLznzWTAM79sI+CkDlmyNGPZ0
 ErZd0DuS2Gus6gRngcZCRPAJaXQSXJ9aSrBhj6ZuW0jyGy76KjfYaVWWM
 S5oIX2RJVbQg7zWDoSrzWhrRUAGS8ywf/SnviKB7FcDSTUQAnRlUU/oO2 A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10971"; a="402815055"
X-IronPort-AV: E=Sophos;i="6.05,236,1701158400"; d="scan'208";a="402815055"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Feb 2024 10:49:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,236,1701158400"; d="scan'208";a="30949671"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
 by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 01 Feb 2024 10:49:02 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 1 Feb 2024 10:49:00 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 1 Feb 2024 10:49:00 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 1 Feb 2024 10:49:00 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 1 Feb 2024 10:49:00 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YH8eDd7GQHEFbJszwRwONtGefJIpVCkm6JaabAwyOw2mk0kiAE+AK2RCgRHXwFqrTpI0aGc3x2uXIgbatl4muBuPsQVzCjJ0vvs0esNmCSpgR02Y+Rc9gFgy8hXuVk0xBLANwS2OouTlz0sGrcCBb6/kSTLrLb0GwUXQkYpA+E4oMCxythcDaUuHPPUX0nDGwBi3ekwxnwNXskthRFUAb7l0O6vk+GqyVmbnbSqi/CMrtYBqZOcEVZg4e3w6MprIyp82kPr/GPGrk8ggKmZzIv62tM6ubZ+CIeAg284jAFXWGdyvRh61blgugtVaHqQl31i5qvUix1m3Ea6FKwrI7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HDdZL7jORQptJFES3NSJKyi4rQR/NIo6pSlb6JE3HMk=;
 b=fh0objbPZuHtJ8C1bsIwCIM6zopUpTRfwRjq2h4d/dXvNJxB8PboJiOl4ABREyCCwZvyVQqfwkrogNWXJ6D4ufaBJN7p+5JrOPwokkcdrr8R8ZBt+qPMi632mwN3zKBOD6Mas2jUnHNj63l3N6GNn7I8h7dA3+YuRXU40DyYihG/To+SDrlXIMbVGn6CcG6NpvxQ0AC5XSIqJUK5m/+A5QjHGcEy9Alip3tB5Vdr5iEsXtUf5+UFKP+O8/2sFAJCDjOwKlJN28Z2Za0P5YbSJYXjEJLvnG+FTirv9P8JbWvZ4Ti85AhCzd3tp5FsUo5GWspdKl9Bv11f1yM8rNb7Sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH8PR11MB6879.namprd11.prod.outlook.com (2603:10b6:510:229::22)
 by SJ0PR11MB4909.namprd11.prod.outlook.com (2603:10b6:a03:2af::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.29; Thu, 1 Feb
 2024 18:48:58 +0000
Received: from PH8PR11MB6879.namprd11.prod.outlook.com
 ([fe80::1332:70db:38b7:437d]) by PH8PR11MB6879.namprd11.prod.outlook.com
 ([fe80::1332:70db:38b7:437d%6]) with mapi id 15.20.7249.017; Thu, 1 Feb 2024
 18:48:58 +0000
From: "Kim, Dongwon" <dongwon.kim@intel.com>
To: =?utf-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: RE: [PATCH 1/3] ui/gtk: skip drawing guest scanout when associated VC
 is invisible
Thread-Topic: [PATCH 1/3] ui/gtk: skip drawing guest scanout when associated
 VC is invisible
Thread-Index: AQHaU9fcRg8sk5PypUazkJHR2gMsqbDzgQeAgADEP6CAAMa/gIAAyKaA
Date: Thu, 1 Feb 2024 18:48:58 +0000
Message-ID: <PH8PR11MB6879AF46B1B0A31E68D146F9FA432@PH8PR11MB6879.namprd11.prod.outlook.com>
References: <20240130234840.53122-1-dongwon.kim@intel.com>
 <20240130234840.53122-2-dongwon.kim@intel.com>
 <CAJ+F1CLzVDfCdy9XUGxAf1DN=ert+9JDs3Sq1HYve4Bdy7mFHw@mail.gmail.com>
 <PH8PR11MB6879524941306A7B3FB17EE2FA7C2@PH8PR11MB6879.namprd11.prod.outlook.com>
 <CAJ+F1C+4f7=GAa8gOhH+=Qv5WAQrypa=83R-+RVEAo4JjknLSw@mail.gmail.com>
In-Reply-To: <CAJ+F1C+4f7=GAa8gOhH+=Qv5WAQrypa=83R-+RVEAo4JjknLSw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH8PR11MB6879:EE_|SJ0PR11MB4909:EE_
x-ms-office365-filtering-correlation-id: 967b64d9-f105-4371-6204-08dc23567317
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: V+3oPHz1mo5gBa9M/yP1qDDjeLFVbtPrxDkQ48xZcpS+FzAJbdmoQQ+iXiYuhVcUJluzJQyDsd9rX2CnWm+0VpYJVuTcxEjjciUj2VyfdpTXAR+m+Bi+Dyl005GWnbNGy2QdzML40eheRwxtkGewDWYOjMcbbmsb0egubIxXHvIJSUltNmd7RYAzVUvbefd8/g1DD5uAy5lIBQ+0NgTOM+9KSPU/JIXoSdZu9MzXYCVmCtE8/ZDvgADq/DLLFB643pgPoX829u2EgxLb3E/7NUCYDVk6VXQUxv6i5OMM2WehPbKQOSUFkMY2qRXxl1vTeaYzc4VFerzQ/Fsizi2kcZpZRKZo7IwAzZmTTZa51AvpBgLMG6p+07oYwiXldajS7gixTEJ51m250AoLUUyII6AqbyLOAsFj0oGath39e+LDXrWZ7udRCYuE9FlMs4cZUTuIUN4m5SVQCWm0cW86weMyVn5nIX40y3RQZ8oKQK5E2ka7QIxmdKjUCXNhv2hO1h8W6ots3X51ghJDrl09I+XL2jVIGWYJjzFgT1HwVG9/6RdLffUWKC+aXCbfCzKlR+e+PC8/9mJoJfDQTX7SqP/av/Rx8rdy2X/63SMqzlg=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH8PR11MB6879.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(346002)(396003)(376002)(39860400002)(136003)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(83380400001)(9686003)(122000001)(38100700002)(26005)(6506007)(5660300002)(66946007)(8676002)(8936002)(4326008)(71200400001)(53546011)(478600001)(7696005)(966005)(2906002)(76116006)(66476007)(66446008)(64756008)(52536014)(6916009)(316002)(66556008)(38070700009)(82960400001)(86362001)(41300700001)(33656002)(55016003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eUQyS2ZVV1FmeDZoT2JoMWRaRjJiK0l6TkZFWlRjL2Y0ZGFiQk45T0R4Y3N5?=
 =?utf-8?B?K2l1Y2RHeDhxbDJva3JtK3JIaE9pOWJ4N2RWZnQwUHZsWmpsbW5HSUpMV0Jk?=
 =?utf-8?B?dDR5Z0R3cnNKcFVwM21ITk5udGFaYURHUDNWNUdBa0RrOUlKdklLM1kyZTIw?=
 =?utf-8?B?NG1uMmtSeEhCUTEveU1icVFaVmhLQjZFQVEzVXgxdG9VQkhLaWRNY0tybG5Z?=
 =?utf-8?B?aXIwbjdOZlNmL0kwWEFpeUNYRWh4YjZRZzRMbDVaRitkZDVTZW9mOHZoS3dF?=
 =?utf-8?B?Mjl4aDJpVTFTQkpHM01BYWt0TzR3V2lSMlpNS1ZDQ2ppbW9mdUdHZGNDTXlt?=
 =?utf-8?B?V0ZkN0lNUG84NjNjYVlROUFkWGtuRVNLeFY5K0dMaWgxRk1qMVlVNDhuMEtM?=
 =?utf-8?B?WDlnK1pFbXJjd1puZkV2Sng1MUZKQVpXNWxVTUpwc3VGV2F4aVB1aHp0aUxP?=
 =?utf-8?B?dUI3eU9vSXBpMGJkVmJrOEROdmtWT1ZvSytQUjRMK1g4NWZnT1lYOUNISFZM?=
 =?utf-8?B?VEt2cTdiTG14TUkwM1lXOW50czk4c2V4anZUYVFlMnZNaWJIbEZZL09FVkla?=
 =?utf-8?B?S09pbFlSMDNzeWRUS0JNWlA5RzV4YjZJc2FLT3lZSjVnVHFBdnhWYUlIaUVU?=
 =?utf-8?B?OGtWaVZxMVFTcTZkWGJTSVZxTUVjVFQrbDNJYi9YM1lQSHNaS0tXc3JpbFV3?=
 =?utf-8?B?MVM5NWk4RUtaM3ZtcW1KSFNrU3VZSGFMdHQzWlFxZGN3engzUkU4UXpoQmxk?=
 =?utf-8?B?RTZjSm5CM2tDaTl4YkdIWHdrQ3FYNlBkN1V3YTJjRTdlNVBrUTlSMUkrRTR3?=
 =?utf-8?B?Wm5QQ2xGQjZtaEtSZ2g4MFF0MUV2ZUw5Q0lVY0NzNFplTk9EWXBCaGJmTTBK?=
 =?utf-8?B?dHNqYlFvdFVSZlcrWXZBdXMrQkx0MnpLejBYVUwxVmE2dy9CejE1SlExSWNV?=
 =?utf-8?B?YmlROXFHZnZqSkhjNjduc1hqVGRLNDE4ZUk1WlBmektIcXJkS1ZVek52dUhT?=
 =?utf-8?B?OGJVbFV6bDNIWUxud0d1WEJiSEVhSitZZGIvTU1CdzVHOVVyeG5uQ3Z4TVNp?=
 =?utf-8?B?aDdlTlpGWDQyc2pybWphRjV6d1hTM3dUOHRENWZWN3Z6WUZ3ODVYOURwMzla?=
 =?utf-8?B?RWgxeEl3U05uNlBObXlmYlozM1FUQUFCNUIzU3Y5NytDeWN2dExqZHJVbnZB?=
 =?utf-8?B?dzVhSjhORXhOcEk2bkUxWmx6QnYyZTVVVGZsOWFaN2FKaklCUHRKY1QrZ2ZI?=
 =?utf-8?B?YUExcWJ3eUlXbHpIenA5a2xkdUtoM1kwMGdsdTE5Z0hvRUhTSDV4VHltNmJm?=
 =?utf-8?B?QWlxVXVxb2xuamgwNUI4WUx3ays5SXRtc3BVM2Z2UVlIVVlGMWw1cVJ5R1I2?=
 =?utf-8?B?eTRZYmJqS2dkYk5Fa3JjWmtGV0FoNE1PTlFMRXJDeHBva2EyT0JBa3hoNVRH?=
 =?utf-8?B?dDB4b2lGYWVuY09hNEdZaWdDNHFUSGZGczJPTmFZZlJreGlNNTg0b3g0MlZU?=
 =?utf-8?B?eG9tNVBoOUUyaHZmOGxBbGZ6RCtwRVhqRk5ncmNmZ0M2ckQ1YytwNThqUG1J?=
 =?utf-8?B?TU1yR0QrcmhrQzUrMFptbWxqZzJOejFYTEt4cFJnSmRxeUgzMHlEZGNGMk40?=
 =?utf-8?B?VzZzWlBMazlrM1B6YkFGbExFbWVsam41cjJRaDZEazdlRnRrVFM1aUcwOXpJ?=
 =?utf-8?B?Yzl6ZFRzb25uQklua0MzV2M2M1pGQ3JaR3ZFM2d5dER3S0hBWGs3dXhVQVJk?=
 =?utf-8?B?c0RGaHJyY3NyQlg1NFJPQ0JkTS9ydGRnNmFEUlI2d0dtVGVmT3FRMHA2dFUv?=
 =?utf-8?B?M1U0SnVsbkhZTDVmdzc3WEp0N2JYRVpkVXlTRk8xNWtDaTRlUGRSSmNscnAv?=
 =?utf-8?B?bERyM0VuNXRrWmVKeDVFUmY0NFNRTWJaUVZRT0h6RzZEalZRNzNZbkpnNkxk?=
 =?utf-8?B?ckpaQ3pHSERDbFVGWVI5YTNUeTF6YU9DVWVPYXpEMXJGMVdBYUxUdEllampx?=
 =?utf-8?B?Nk5BcGZtT09VYTl2N2x3RmFnRnFCQ3kxWElZZ0lUV3JzNXN3eWNaeGtTaTRL?=
 =?utf-8?B?N0dqOExTSlFMSzVHVnorVkRncWxRTHNMNCswbEtqeDdyV2RiRzN4c0NpcHVJ?=
 =?utf-8?Q?UD7Kbw5Kvx1JB8yVM09CG+ULP?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6879.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 967b64d9-f105-4371-6204-08dc23567317
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Feb 2024 18:48:58.4218 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0S1c0FMU0K2NdazSq5TpqHUGmOF1hZC//Zyow9RMQXWYjVs4T2py1fsO53WjNwXQiuCfPTAkmpTF3Z8U1QoUfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4909
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.55.52.120; envelope-from=dongwon.kim@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -56
X-Spam_score: -5.7
X-Spam_bar: -----
X-Spam_report: (-5.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.292,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

SGkgTWFyYy1BbmRyw6ksDQoNClRoYW5rcyBmb3IgeW91ciBmZWVkYmFjay4gWWVzLCB5b3UgYXJl
IHJpZ2h0LCByZW5kZXJpbmcgZG9lc24ndCBzdG9wIG9uIFVidW50dSBzeXN0ZW0NCmFzIGl0IGhh
cyBwcmV2aWV3IGV2ZW4gYWZ0ZXIgdGhlIHdpbmRvdyBpcyBtaW5pbWl6ZWQuIEJ1dCB0aGlzIGlz
IG5vdCBhbHdheXMgdGhlIGNhc2UuDQpTb21lIHNpbXBsZSB3aW5kb3dzIG1hbmFnZXJzIGRvbid0
IGhhdmUgdGhpcyBwcmV2aWV3ICh0aHVtYm5haWwpDQpmZWF0dXJlIGFuZCB0aGlzIHZpc2libGUg
ZmxhZyBpcyBub3QgdG9nZ2xlZC4gQW5kIHRoZSByZW5kZXJpbmcgc3RvcHMgcmlnaHQgYXdheSB0
aGVyZSB3aGVuDQp0aGUgd2luZG93IGlzIG1pbmltaXplZC4NCg0KRGV0YWNoaW5nIHRoZW4gY2xv
c2luZyB0aGUgd2luZG93IHdoaWNoIG1ha2VzIGl0IGdvIGJhY2sgdG8gdGFicyBkb2VzIG5vdA0K
bWFrZSB0aGUgZmxhZyByZXNldCwgdG9vLiBUbyB1cywgaGF2aW5nIHRoaXMgZXh0cmEgZmxhZyBm
b3IgVkMgaXMgb25lIHNpbXBsZSBhbmQgaW50dWl0aXZlDQp3YXkgdG8gaGFuZGxlIHN1Y2ggc2l0
dWF0aW9ucyAoaW5jbHVkaW5nIHVwY29taW5nIGd1ZXN0IGRpc3BsYXkgaG90IHBsdWcgaW4gcGF0
Y2hlcykNCg0KVGhhbmtzIQ0KDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggMS8zXSB1aS9ndGs6IHNr
aXAgZHJhd2luZyBndWVzdCBzY2Fub3V0IHdoZW4gYXNzb2NpYXRlZA0KPiBWQyBpcyBpbnZpc2li
bGUNCj4gDQo+IEhpDQo+IA0KPiBPbiBXZWQsIEphbiAzMSwgMjAyNCBhdCAxMDo1NuKAr1BNIEtp
bSwgRG9uZ3dvbiA8ZG9uZ3dvbi5raW1AaW50ZWwuY29tPg0KPiB3cm90ZToNCj4gPg0KPiA+IEhp
IE1hcmMtQW5kcsOpLA0KPiA+DQo+ID4gPiBodHRwczovL2RvY3MuZ3RrLm9yZy9ndGszL21ldGhv
ZC5XaWRnZXQuaXNfdmlzaWJsZS5odG1sDQo+ID4NCj4gPiBUaGlzIGlzIHdoYXQgd2UgaGFkIHRy
aWVkIGZpcnN0IGJ1dCBpdCBkaWRuJ3Qgc2VlbSB0byB3b3JrIGZvciB0aGUgY2FzZSBvZg0KPiB3
aW5kb3cgbWluaW1pemF0aW9uLg0KPiA+IEkgc2VlIHRoZSB2aXNpYmxlIGZsYWcgZm9yIHRoZSBH
VEsgd2lkZ2V0IGRpZG4ndCBzZWVtIHRvIGJlIHRvZ2dsZWQNCj4gPiBmb3Igc29tZSByZWFzb24u
IEFuZCB3aGVuDQo+IA0KPiBSaWdodCwgYmVjYXVzZSBtaW5pbWl6ZSAhPSB2aXNpYmxlLiBZb3Ug
Y2FuIHN0aWxsIGdldCB3aW5kb3cgcHJldmlldyB3aXRoIGFsdC0NCj4gdGFiIGFuZCBvdGhlciBj
b21wb3NpdG9yIGRyYXdpbmdzLg0KPiANCj4gSW93LCBpdCBzaG91bGQga2VlcCByZW5kZXJpbmcg
ZXZlbiB3aGVuIG1pbmltaXplZC4NCj4gDQo+ID4gY2xvc2luZyB3aW5kb3csIHZjLT53aW5kb3cg
d2lkZ2V0IGlzIGRlc3Ryb3llZCBzbyBpdCBpcyBub3QgcG9zc2libGUNCj4gPiB0byBjaGVjayB0
aGUgZmxhZyB1c2luZyB0aGlzIEdUSyBmdW5jdGlvbi4gSGF2aW5nIGV4dHJhIGZsYWcgYm91bmQg
dG8NCj4gPiBWQyB3YXMgbW9zdCBpbnR1aXRpdmUgZm9yIHRoZSBsb2dpYyBJIHdhbnRlZCB0byBp
bXBsZW1lbnQuDQo+ID4NCj4gPiBUaGFua3MhIQ0KPiA+IERXDQo+ID4NCj4gPiA+IFN1YmplY3Q6
IFJlOiBbUEFUQ0ggMS8zXSB1aS9ndGs6IHNraXAgZHJhd2luZyBndWVzdCBzY2Fub3V0IHdoZW4N
Cj4gPiA+IGFzc29jaWF0ZWQgVkMgaXMgaW52aXNpYmxlDQo+ID4gPg0KPiA+ID4gSGkgRG9uZ3dv
bg0KPiA+ID4NCj4gPiA+IE9uIFdlZCwgSmFuIDMxLCAyMDI0IGF0IDM6NTDigK9BTSA8ZG9uZ3dv
bi5raW1AaW50ZWwuY29tPiB3cm90ZToNCj4gPiA+ID4NCj4gPiA+ID4gRnJvbTogRG9uZ3dvbiBL
aW0gPGRvbmd3b24ua2ltQGludGVsLmNvbT4NCj4gPiA+ID4NCj4gPiA+ID4gQSBuZXcgZmxhZyAi
dmlzaWJsZSIgaXMgYWRkZWQgdG8gc2hvdyB2aXNpYmlsaXR5IHN0YXR1cyBvZiB0aGUgZ2Z4IGNv
bnNvbGUuDQo+ID4gPiA+IFRoZSBmbGFnIGlzIHNldCB0byAndHJ1ZScgd2hlbiB0aGUgVkMgaXMg
dmlzaWJsZSBidXQgc2V0IHRvICdmYWxzZScNCj4gPiA+ID4gd2hlbiBpdCBpcyBoaWRkZW4gb3Ig
Y2xvc2VkLiBXaGVuIHRoZSBWQyBpcyBpbnZpc2libGUsIGRyYXdpbmcNCj4gPiA+ID4gZ3Vlc3Qg
ZnJhbWVzIHNob3VsZCBiZSBza2lwcGVkIGFzIGl0IHdpbGwgbmV2ZXIgYmUgY29tcGxldGVkIGFu
ZA0KPiA+ID4gPiBpdCB3b3VsZCBwb3RlbnRpYWxseSBsb2NrIHVwIHRoZSBndWVzdCBkaXNwbGF5
IGVzcGVjaWFsbHkgd2hlbiBibG9iDQo+IHNjYW5vdXQgaXMgdXNlZC4NCj4gPiA+DQo+ID4gPiBD
YW4ndCBpdCBza2lwIGRyYXdpbmcgd2hlbiB0aGUgd2lkZ2V0IGlzIG5vdCB2aXNpYmxlIGluc3Rl
YWQ/DQo+ID4gPiBodHRwczovL2RvY3MuZ3RrLm9yZy9ndGszL21ldGhvZC5XaWRnZXQuaXNfdmlz
aWJsZS5odG1sDQo+ID4gPg0KPiA+ID4gPg0KPiA+ID4gPiBDYzogTWFyYy1BbmRyw6kgTHVyZWF1
IDxtYXJjYW5kcmUubHVyZWF1QHJlZGhhdC5jb20+DQo+ID4gPiA+IENjOiBHZXJkIEhvZmZtYW5u
IDxrcmF4ZWxAcmVkaGF0LmNvbT4NCj4gPiA+ID4gQ2M6IFZpdmVrIEthc2lyZWRkeSA8dml2ZWsu
a2FzaXJlZGR5QGludGVsLmNvbT4NCj4gPiA+ID4NCj4gPiA+ID4gU2lnbmVkLW9mZi1ieTogRG9u
Z3dvbiBLaW0gPGRvbmd3b24ua2ltQGludGVsLmNvbT4NCj4gPiA+ID4gLS0tDQo+ID4gPiA+ICBp
bmNsdWRlL3VpL2d0ay5oIHwgIDEgKw0KPiA+ID4gPiAgdWkvZ3RrLWVnbC5jICAgICB8ICA4ICsr
KysrKysrDQo+ID4gPiA+ICB1aS9ndGstZ2wtYXJlYS5jIHwgIDggKysrKysrKysNCj4gPiA+ID4g
IHVpL2d0ay5jICAgICAgICAgfCAxMCArKysrKysrKystDQo+ID4gPiA+ICA0IGZpbGVzIGNoYW5n
ZWQsIDI2IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4gPiA+ID4NCj4gPiA+ID4gZGlm
ZiAtLWdpdCBhL2luY2x1ZGUvdWkvZ3RrLmggYi9pbmNsdWRlL3VpL2d0ay5oIGluZGV4DQo+ID4g
PiA+IGFhM2Q2MzcwMjkuLjJkZTM4ZTU3MjQgMTAwNjQ0DQo+ID4gPiA+IC0tLSBhL2luY2x1ZGUv
dWkvZ3RrLmgNCj4gPiA+ID4gKysrIGIvaW5jbHVkZS91aS9ndGsuaA0KPiA+ID4gPiBAQCAtNTcs
NiArNTcsNyBAQCB0eXBlZGVmIHN0cnVjdCBWaXJ0dWFsR2Z4Q29uc29sZSB7DQo+ID4gPiA+ICAg
ICAgYm9vbCB5MF90b3A7DQo+ID4gPiA+ICAgICAgYm9vbCBzY2Fub3V0X21vZGU7DQo+ID4gPiA+
ICAgICAgYm9vbCBoYXNfZG1hYnVmOw0KPiA+ID4gPiArICAgIGJvb2wgdmlzaWJsZTsNCj4gPiA+
ID4gICNlbmRpZg0KPiA+ID4gPiAgfSBWaXJ0dWFsR2Z4Q29uc29sZTsNCj4gPiA+ID4NCj4gPiA+
ID4gZGlmZiAtLWdpdCBhL3VpL2d0ay1lZ2wuYyBiL3VpL2d0ay1lZ2wuYyBpbmRleA0KPiA+ID4g
PiAzYWY1YWM1YmNmLi45OTNjMjgzMTkxDQo+ID4gPiA+IDEwMDY0NA0KPiA+ID4gPiAtLS0gYS91
aS9ndGstZWdsLmMNCj4gPiA+ID4gKysrIGIvdWkvZ3RrLWVnbC5jDQo+ID4gPiA+IEBAIC0yNjUs
NiArMjY1LDEwIEBAIHZvaWQNCj4gPiA+IGdkX2VnbF9zY2Fub3V0X2RtYWJ1ZihEaXNwbGF5Q2hh
bmdlTGlzdGVuZXINCj4gPiA+ID4gKmRjbCwgICNpZmRlZiBDT05GSUdfR0JNDQo+ID4gPiA+ICAg
ICAgVmlydHVhbENvbnNvbGUgKnZjID0gY29udGFpbmVyX29mKGRjbCwgVmlydHVhbENvbnNvbGUs
DQo+ID4gPiA+IGdmeC5kY2wpOw0KPiA+ID4gPg0KPiA+ID4gPiArICAgIGlmICghdmMtPmdmeC52
aXNpYmxlKSB7DQo+ID4gPiA+ICsgICAgICAgIHJldHVybjsNCj4gPiA+ID4gKyAgICB9DQo+ID4g
PiA+ICsNCj4gPiA+ID4gICAgICBlZ2xNYWtlQ3VycmVudChxZW11X2VnbF9kaXNwbGF5LCB2Yy0+
Z2Z4LmVzdXJmYWNlLA0KPiA+ID4gPiAgICAgICAgICAgICAgICAgICAgIHZjLT5nZnguZXN1cmZh
Y2UsIHZjLT5nZnguZWN0eCk7DQo+ID4gPiA+DQo+ID4gPiA+IEBAIC0zNjMsNiArMzY3LDEwIEBA
IHZvaWQgZ2RfZWdsX2ZsdXNoKERpc3BsYXlDaGFuZ2VMaXN0ZW5lciAqZGNsLA0KPiA+ID4gPiAg
ICAgIFZpcnR1YWxDb25zb2xlICp2YyA9IGNvbnRhaW5lcl9vZihkY2wsIFZpcnR1YWxDb25zb2xl
LCBnZnguZGNsKTsNCj4gPiA+ID4gICAgICBHdGtXaWRnZXQgKmFyZWEgPSB2Yy0+Z2Z4LmRyYXdp
bmdfYXJlYTsNCj4gPiA+ID4NCj4gPiA+ID4gKyAgICBpZiAoIXZjLT5nZngudmlzaWJsZSkgew0K
PiA+ID4gPiArICAgICAgICByZXR1cm47DQo+ID4gPiA+ICsgICAgfQ0KPiA+ID4gPiArDQo+ID4g
PiA+ICAgICAgaWYgKHZjLT5nZnguZ3Vlc3RfZmIuZG1hYnVmICYmICF2Yy0+Z2Z4Lmd1ZXN0X2Zi
LmRtYWJ1Zi0NCj4gPiA+ID5kcmF3X3N1Ym1pdHRlZCkgew0KPiA+ID4gPiAgICAgICAgICBncmFw
aGljX2h3X2dsX2Jsb2NrKHZjLT5nZnguZGNsLmNvbiwgdHJ1ZSk7DQo+ID4gPiA+ICAgICAgICAg
IHZjLT5nZnguZ3Vlc3RfZmIuZG1hYnVmLT5kcmF3X3N1Ym1pdHRlZCA9IHRydWU7IGRpZmYNCj4g
PiA+ID4tLWdpdCAgYS91aS9ndGstZ2wtYXJlYS5jIGIvdWkvZ3RrLWdsLWFyZWEuYyBpbmRleA0K
PiA+ID4gPjUyZGNhYzE2MWUuLjA0ZTA3YmQ3ZWUNCj4gPiA+ID4gMTAwNjQ0DQo+ID4gPiA+IC0t
LSBhL3VpL2d0ay1nbC1hcmVhLmMNCj4gPiA+ID4gKysrIGIvdWkvZ3RrLWdsLWFyZWEuYw0KPiA+
ID4gPiBAQCAtMjg1LDYgKzI4NSwxMCBAQCB2b2lkDQo+ID4gPiA+IGdkX2dsX2FyZWFfc2Nhbm91
dF9mbHVzaChEaXNwbGF5Q2hhbmdlTGlzdGVuZXIgKmRjbCwgIHsNCj4gPiA+ID4gICAgICBWaXJ0
dWFsQ29uc29sZSAqdmMgPSBjb250YWluZXJfb2YoZGNsLCBWaXJ0dWFsQ29uc29sZSwNCj4gPiA+
ID4gZ2Z4LmRjbCk7DQo+ID4gPiA+DQo+ID4gPiA+ICsgICAgaWYgKCF2Yy0+Z2Z4LnZpc2libGUp
IHsNCj4gPiA+ID4gKyAgICAgICAgcmV0dXJuOw0KPiA+ID4gPiArICAgIH0NCj4gPiA+ID4gKw0K
PiA+ID4gPiAgICAgIGlmICh2Yy0+Z2Z4Lmd1ZXN0X2ZiLmRtYWJ1ZiAmJiAhdmMtPmdmeC5ndWVz
dF9mYi5kbWFidWYtDQo+ID4gPiA+ZHJhd19zdWJtaXR0ZWQpIHsNCj4gPiA+ID4gICAgICAgICAg
Z3JhcGhpY19od19nbF9ibG9jayh2Yy0+Z2Z4LmRjbC5jb24sIHRydWUpOw0KPiA+ID4gPiAgICAg
ICAgICB2Yy0+Z2Z4Lmd1ZXN0X2ZiLmRtYWJ1Zi0+ZHJhd19zdWJtaXR0ZWQgPSB0cnVlOyBAQCAt
Mjk5LDYNCj4gPiA+ID4gKzMwMywxMCBAQCB2b2lkIGdkX2dsX2FyZWFfc2Nhbm91dF9kbWFidWYo
RGlzcGxheUNoYW5nZUxpc3RlbmVyDQo+ID4gPiA+ICsqZGNsLA0KPiA+ID4gPiAjaWZkZWYgQ09O
RklHX0dCTQ0KPiA+ID4gPiAgICAgIFZpcnR1YWxDb25zb2xlICp2YyA9IGNvbnRhaW5lcl9vZihk
Y2wsIFZpcnR1YWxDb25zb2xlLA0KPiA+ID4gPiBnZnguZGNsKTsNCj4gPiA+ID4NCj4gPiA+ID4g
KyAgICBpZiAoIXZjLT5nZngudmlzaWJsZSkgew0KPiA+ID4gPiArICAgICAgICByZXR1cm47DQo+
ID4gPiA+ICsgICAgfQ0KPiA+ID4gPiArDQo+ID4gPiA+ICAgICAgZ3RrX2dsX2FyZWFfbWFrZV9j
dXJyZW50KEdUS19HTF9BUkVBKHZjLT5nZnguZHJhd2luZ19hcmVhKSk7DQo+ID4gPiA+ICAgICAg
ZWdsX2RtYWJ1Zl9pbXBvcnRfdGV4dHVyZShkbWFidWYpOw0KPiA+ID4gPiAgICAgIGlmICghZG1h
YnVmLT50ZXh0dXJlKSB7DQo+ID4gPiA+IGRpZmYgLS1naXQgYS91aS9ndGsuYyBiL3VpL2d0ay5j
DQo+ID4gPiA+IGluZGV4IDgxMGQ3ZmM3OTYuLjAyZWI2NjdkOGEgMTAwNjQ0DQo+ID4gPiA+IC0t
LSBhL3VpL2d0ay5jDQo+ID4gPiA+ICsrKyBiL3VpL2d0ay5jDQo+ID4gPiA+IEBAIC0xMzEyLDE1
ICsxMzEyLDIwIEBAIHN0YXRpYyB2b2lkIGdkX21lbnVfcXVpdChHdGtNZW51SXRlbQ0KPiA+ID4g
PiAqaXRlbSwgdm9pZCAqb3BhcXVlKSAgc3RhdGljIHZvaWQgZ2RfbWVudV9zd2l0Y2hfdmMoR3Rr
TWVudUl0ZW0NCj4gPiA+ID4gKml0ZW0sIHZvaWQNCj4gPiA+ID4gKm9wYXF1ZSkgIHsNCj4gPiA+
ID4gICAgICBHdGtEaXNwbGF5U3RhdGUgKnMgPSBvcGFxdWU7DQo+ID4gPiA+IC0gICAgVmlydHVh
bENvbnNvbGUgKnZjID0gZ2RfdmNfZmluZF9ieV9tZW51KHMpOw0KPiA+ID4gPiArICAgIFZpcnR1
YWxDb25zb2xlICp2YzsNCj4gPiA+ID4gICAgICBHdGtOb3RlYm9vayAqbmIgPSBHVEtfTk9URUJP
T0socy0+bm90ZWJvb2spOw0KPiA+ID4gPiAgICAgIGdpbnQgcGFnZTsNCj4gPiA+ID4NCj4gPiA+
ID4gKyAgICB2YyA9IGdkX3ZjX2ZpbmRfY3VycmVudChzKTsNCj4gPiA+ID4gKyAgICB2Yy0+Z2Z4
LnZpc2libGUgPSBmYWxzZTsNCj4gPiA+ID4gKw0KPiA+ID4gPiArICAgIHZjID0gZ2RfdmNfZmlu
ZF9ieV9tZW51KHMpOw0KPiA+ID4gPiAgICAgIGd0a19yZWxlYXNlX21vZGlmaWVycyhzKTsNCj4g
PiA+ID4gICAgICBpZiAodmMpIHsNCj4gPiA+ID4gICAgICAgICAgcGFnZSA9IGd0a19ub3RlYm9v
a19wYWdlX251bShuYiwgdmMtPnRhYl9pdGVtKTsNCj4gPiA+ID4gICAgICAgICAgZ3RrX25vdGVi
b29rX3NldF9jdXJyZW50X3BhZ2UobmIsIHBhZ2UpOw0KPiA+ID4gPiAgICAgICAgICBndGtfd2lk
Z2V0X2dyYWJfZm9jdXModmMtPmZvY3VzKTsNCj4gPiA+ID4gKyAgICAgICAgdmMtPmdmeC52aXNp
YmxlID0gdHJ1ZTsNCj4gPiA+ID4gICAgICB9DQo+ID4gPiA+ICB9DQo+ID4gPiA+DQo+ID4gPiA+
IEBAIC0xMzUwLDYgKzEzNTUsNyBAQCBzdGF0aWMgZ2Jvb2xlYW4NCj4gPiA+ID4gZ2RfdGFiX3dp
bmRvd19jbG9zZShHdGtXaWRnZXQNCj4gPiA+ICp3aWRnZXQsIEdka0V2ZW50ICpldmVudCwNCj4g
PiA+ID4gICAgICBWaXJ0dWFsQ29uc29sZSAqdmMgPSBvcGFxdWU7DQo+ID4gPiA+ICAgICAgR3Rr
RGlzcGxheVN0YXRlICpzID0gdmMtPnM7DQo+ID4gPiA+DQo+ID4gPiA+ICsgICAgdmMtPmdmeC52
aXNpYmxlID0gZmFsc2U7DQo+ID4gPiA+ICAgICAgZ3RrX3dpZGdldF9zZXRfc2Vuc2l0aXZlKHZj
LT5tZW51X2l0ZW0sIHRydWUpOw0KPiA+ID4gPiAgICAgIGdkX3dpZGdldF9yZXBhcmVudCh2Yy0+
d2luZG93LCBzLT5ub3RlYm9vaywgdmMtPnRhYl9pdGVtKTsNCj4gPiA+ID4gICAgICBndGtfbm90
ZWJvb2tfc2V0X3RhYl9sYWJlbF90ZXh0KEdUS19OT1RFQk9PSyhzLT5ub3RlYm9vayksDQo+ID4g
PiA+IEBAIC0xNDIzLDYgKzE0MjksNyBAQCBzdGF0aWMgdm9pZCBnZF9tZW51X3VudGFiaWZ5KEd0
a01lbnVJdGVtDQo+ID4gPiA+ICppdGVtLA0KPiA+ID4gdm9pZCAqb3BhcXVlKQ0KPiA+ID4gPiAg
ICAgICAgICBnZF91cGRhdGVfZ2VvbWV0cnlfaGludHModmMpOw0KPiA+ID4gPiAgICAgICAgICBn
ZF91cGRhdGVfY2FwdGlvbihzKTsNCj4gPiA+ID4gICAgICB9DQo+ID4gPiA+ICsgICAgdmMtPmdm
eC52aXNpYmxlID0gdHJ1ZTsNCj4gPiA+ID4gIH0NCj4gPiA+ID4NCj4gPiA+ID4gIHN0YXRpYyB2
b2lkIGdkX21lbnVfc2hvd19tZW51YmFyKEd0a01lbnVJdGVtICppdGVtLCB2b2lkICpvcGFxdWUp
DQo+ID4gPiBAQA0KPiA+ID4gPiAtMjQ3MSw2ICsyNDc4LDcgQEAgc3RhdGljIHZvaWQgZ3RrX2Rp
c3BsYXlfaW5pdChEaXNwbGF5U3RhdGUgKmRzLA0KPiA+ID4gPiBEaXNwbGF5T3B0aW9ucyAqb3B0
cykgICNpZmRlZiBDT05GSUdfR1RLX0NMSVBCT0FSRA0KPiA+ID4gPiAgICAgIGdkX2NsaXBib2Fy
ZF9pbml0KHMpOw0KPiA+ID4gPiAgI2VuZGlmIC8qIENPTkZJR19HVEtfQ0xJUEJPQVJEICovDQo+
ID4gPiA+ICsgICAgdmMtPmdmeC52aXNpYmxlID0gdHJ1ZTsNCj4gPiA+ID4gIH0NCj4gPiA+ID4N
Cj4gPiA+ID4gIHN0YXRpYyB2b2lkIGVhcmx5X2d0a19kaXNwbGF5X2luaXQoRGlzcGxheU9wdGlv
bnMgKm9wdHMpDQo+ID4gPiA+IC0tDQo+ID4gPiA+IDIuMzQuMQ0KPiA+ID4gPg0KPiA+ID4gPg0K
PiA+ID4NCj4gPiA+DQo+ID4gPiAtLQ0KPiA+ID4gTWFyYy1BbmRyw6kgTHVyZWF1DQo+IA0KPiAN
Cj4gDQo+IC0tDQo+IE1hcmMtQW5kcsOpIEx1cmVhdQ0K

