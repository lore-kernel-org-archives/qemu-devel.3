Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B1DBC27C53
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2024 08:35:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJqmJ-0008W6-H7; Wed, 19 Jun 2024 04:34:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chen.zhang@intel.com>)
 id 1sJqmG-0008VU-MK
 for qemu-devel@nongnu.org; Wed, 19 Jun 2024 04:34:49 -0400
Received: from mgamail.intel.com ([192.198.163.8])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chen.zhang@intel.com>)
 id 1sJqmC-0005By-O1
 for qemu-devel@nongnu.org; Wed, 19 Jun 2024 04:34:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1718786084; x=1750322084;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=GIkdXqVbYlOV9IU7kfJ7Dx01ZXY48oHNDRRl06Wakg0=;
 b=TDWDoyeouPTwU7jOaLZXqnHGtnoYWn3fbi18R2mXgtZb7R4+aPv2gFve
 oS//f8yJFywejSs4sB5V6uAqOuHioCK/03r+SJ2id3TrCNzurrMdGY9rF
 dFwbz4n2bE+TL4K1dxShXT99vCgu4bWkx+eNQTTtiiVL381Y1CXDf58JU
 yTNqdN1QheB5WqTdXmLGYmr9gIAC0/Mbw8N1eRCxVTToDOMdGFl43wha7
 fh7gWuo6G2C82Sr+XpoOtu0PPeHLgFofKOPVATl2WtjXecE9L93XWiX91
 CD/9cxRHhS9Ftwsmxd6/3keDLlfH3lpFwLO/oHV7Fr61dSesDBfHdEyLR Q==;
X-CSE-ConnectionGUID: AN2F1pDOTfKBgEZM+hG/Vw==
X-CSE-MsgGUID: KvCU1fZBSAuf6FxGcpR2jA==
X-IronPort-AV: E=McAfee;i="6700,10204,11107"; a="33255468"
X-IronPort-AV: E=Sophos;i="6.08,249,1712646000"; d="scan'208";a="33255468"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Jun 2024 01:34:29 -0700
X-CSE-ConnectionGUID: OLsozyiBRTWrG5kuNozJGg==
X-CSE-MsgGUID: Www322ASQRGmyUqOwRkxxw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,249,1712646000"; d="scan'208";a="65084337"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
 by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 19 Jun 2024 01:34:29 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 19 Jun 2024 01:34:28 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 19 Jun 2024 01:34:28 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 19 Jun 2024 01:34:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S404pOXsE7IsvxIwtaEgVblLoK2c4IHCTWlmWHO/z3q+Fn0nrqPKzBq6+OY5qL5xFDocMVUF9h56G4t45smeqjQLdu+dn5MpwGAbYpSNVOHfV6GlwOHEGjnfaEG4dmUHJcqwUqrFxY9iQHu3Llt7RD7tJ8bQOwjoyomM9LHdm4S9ODn+iKVfQar//01G0968cUAyGX9hh60IXkBj4NdiB3glvUuXb0HzFw8DI1OkT9Er5J7ULJW6xMQ4UiqD/V3HxN6MBQAijalIgYoByaeLLaeE/j+is9yeF4umEN9xC61boKIsrhjR1Gp+uyHFFztlUPugy13+zj/MwadkgYOvxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GIkdXqVbYlOV9IU7kfJ7Dx01ZXY48oHNDRRl06Wakg0=;
 b=D06+o0sKMN70rn4MuO4JHmeIcOsivZZaIGjyO8I8BSfedV54wlN87WyIZ9M5pbZCLJ+7EDmVrS8lVb0hSGhXhpqOVteFJCdrEJYCrLD0aFvJQT0yjbTJ5hjd5hNmESEgj02MqrVMLWVfmlsjYvmvqwIUvjbuTBGPEtwqje8jFwLSx14tnsDWF1tOz1V1eaimBMRJr7wvvaqA70XGvQiXMYD6t+2ABQ9Q/cc7Fw4m2IaRrjm1nj44fINlSo8OunqwzFheCDqyABMVFm6iCYjRvx3D/UcK9ykAAF4DziEWFZMrtGFp4x7sQSRSSVcyJuP8jeWAItAUuQx0ShYJIFlqjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CYYPR11MB8432.namprd11.prod.outlook.com (2603:10b6:930:be::8)
 by DM4PR11MB7182.namprd11.prod.outlook.com (2603:10b6:8:112::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.29; Wed, 19 Jun
 2024 08:34:27 +0000
Received: from CYYPR11MB8432.namprd11.prod.outlook.com
 ([fe80::5c9c:bb71:47cb:f4f9]) by CYYPR11MB8432.namprd11.prod.outlook.com
 ([fe80::5c9c:bb71:47cb:f4f9%5]) with mapi id 15.20.7677.030; Wed, 19 Jun 2024
 08:34:27 +0000
From: "Zhang, Chen" <chen.zhang@intel.com>
To: Nabih Estefan <nabihestefan@google.com>, "peter.maydell@linaro.org"
 <peter.maydell@linaro.org>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "kfting@nuvoton.com"
 <kfting@nuvoton.com>, "wuhaotsh@google.com" <wuhaotsh@google.com>,
 "jasowang@redhat.org" <jasowang@redhat.org>
Subject: RE: [PATCH] hw/net: Fix Coverity Issue for npcm-gmac
Thread-Topic: [PATCH] hw/net: Fix Coverity Issue for npcm-gmac
Thread-Index: AQHawhGRCyQ2lgRZRUSqIL2G0R3IJ7HOwXmg
Date: Wed, 19 Jun 2024 08:34:27 +0000
Message-ID: <CYYPR11MB8432DA9C36BD21FF9E21216E9BCF2@CYYPR11MB8432.namprd11.prod.outlook.com>
References: <20240618172442.3449262-1-nabihestefan@google.com>
 <20240618172442.3449262-2-nabihestefan@google.com>
In-Reply-To: <20240618172442.3449262-2-nabihestefan@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CYYPR11MB8432:EE_|DM4PR11MB7182:EE_
x-ms-office365-filtering-correlation-id: e26bc7bd-6e57-4f2c-85ea-08dc903aa192
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230037|366013|1800799021|376011|38070700015;
x-microsoft-antispam-message-info: =?utf-8?B?clNzMytaSktSb3hnRHkzclkwZk15REc3b0JnQ2VFRXJTUnV1aktwNGlKamVS?=
 =?utf-8?B?eGZEeGxlVnc0d2FLY3l0VXorbHp2ekcvNWpKOU1tK01DdEtqWUQrZldtbHdW?=
 =?utf-8?B?d1dTem5jSGtnVHhjc1QzcVF0Vll1ZXNjYjczaW1qUStDSlZvUG5uVVBva1hn?=
 =?utf-8?B?ejFIN2tVMG5YcVJVNE14MlVqdDVhNEdwZHhhL04rbHBYdFdUK2tmZjROVEha?=
 =?utf-8?B?TTh3Tm5URVdsMmtsQVlQTnk2Ti9JdVZPcUIrcklrMFBPeTlxZCtoNmpiWldo?=
 =?utf-8?B?dnowaFNubUFXSVZZMGJzUFhoWFlPNEczK2p2bjBFdVM1SnBZYjZIYUlCeWVN?=
 =?utf-8?B?MVd0OE1MU3FTMVlJQlFmSnQ3RTZXSHN3QktLQ1JRSTgxUVhnbGpUeUJqL1JJ?=
 =?utf-8?B?a2JEWGNpcnhzcExvOEpwemRvUjQ5NWFBTHA4R2NPMnhQdXExTCttL3NrNW0y?=
 =?utf-8?B?ZFRBdzA0TE0yTkxIWEpWdG80RnpUNzZtRDR2c0cyNHN4U0ovNlowWXhlVG9i?=
 =?utf-8?B?RUVjSGtHYUJGSEFDcTY1SUpxdEh0SmVNcVR3akpBVDUveFRvdlJUQVN0am94?=
 =?utf-8?B?dFF5bStKQ3BxOWR2SkIvRm5RTkRtcktUWWh3OWdBMUxoYjF4cG9EVVB2UXMz?=
 =?utf-8?B?d3J5cTRpWm9Xd2c3b3Y4MVRSazFQeDVhU3B4RlEzNHJlSWJtVmIxcXBsUmV5?=
 =?utf-8?B?dm9VejJxN1l3K0Q1R1lJOURqUnFscXFURXJKTll0NVdHLzJ3V0ZjTkhhOVI5?=
 =?utf-8?B?dlpJSHRhbGlXZkVZT3VZdURFb1gxUm9Bd25hMjZMdmphSmFSR1FZZHdQZ3F1?=
 =?utf-8?B?NFBSMFFONStvTmtseUFCNytYSUNYTnIzZ3Q2dGk4cW5UQnM5NzFIOXd0d3JZ?=
 =?utf-8?B?bXI5U0t4ZzRXVDRkT29uWm40c3lDWGMwQ2NOMHYzSTdxVnlYeGdWTU5YSWgz?=
 =?utf-8?B?ZWFXOXdRRHFyMTJqb3h5OXl6c2JuMjdwbEpmckRJOGp3RmxCQzNXWVV1b2JT?=
 =?utf-8?B?WG44QVZSdW1jaVNWOE54L0lvOXlwcHh2SmJUNlo2cjJjZ2Y2ZmcwaE9RWTBz?=
 =?utf-8?B?YlVTMVJtZTRiNEhMN3NjbGdWNTBJSmxzOTdnUS94TlN1U0hGWmdZU3JXdEZ1?=
 =?utf-8?B?dmpteGlaZ3ZTNkVFM1pYazNMckl3a0RoWG0xTlNFdW1FRVQ5SVRscGY3U0xh?=
 =?utf-8?B?NUNYQitvRndYMzlqbWdlZFZsQVZXTTFqaUs2Y0Q0VUtjd2pLS3NwdnJqMEtD?=
 =?utf-8?B?KzRCbDdwU2FXdStxQnk2RFJhWDVRZmhvYmRsMk5ZbGxhNEZaL3FqTW8rbnVB?=
 =?utf-8?B?VFVZb09ZZ2ptQ2E5VG5YQllhL291RWlDMitrcmJCSVBHaUZiazgraWgyUUll?=
 =?utf-8?B?a2JxUXFrZSswZ0FGbURoKzNyK3U2MFdMaVhrbzZ1L2M2VXh4N3BPVCtNOTdw?=
 =?utf-8?B?RnRndGFTcEFWWlpiaDhialNLMzBMVmJLWFpzSlRuOU1uREpqSE54NTF1YktZ?=
 =?utf-8?B?aTBlR3BxTWpjMFhJSTlwMHk5UDkyV0E1d3BUSmM0Yjk0UldVREtGWXBKUGs0?=
 =?utf-8?B?MmJqb3Z4MG9UL0hqMjFWU2FaMEhEMk80QTR5VFgvaE1TaHBQSjFOTy9pTXhF?=
 =?utf-8?B?SS95a0NIOE5RUlhhRnRFcEJLVk40V29DckMxbkdNUHZITTZHRDhRUm0zcHFt?=
 =?utf-8?B?TUxML3FudVhpVEJCQnRibjhha1UvVDFUV1FudkQ0UnZqSFpkN00zQS9mWjg0?=
 =?utf-8?B?T2gzb3lXbktNc2l6U1RkVlE4YlBOcWxPRGpsclpOUU5DR2hEbUdHN2pmZytq?=
 =?utf-8?Q?hexZei+3vHEdoMeHVEXlfMYChbu4I2XfBy65c=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CYYPR11MB8432.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230037)(366013)(1800799021)(376011)(38070700015); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MFJHQlo0a3ZWWE5hbVIxU3VIVFUzdWRQQ0pmR1J6U2p0M3p3TzVOSDI5d1o3?=
 =?utf-8?B?dHErdzBxMG1yTyt1UFV3c09JUnpzbmZ1V3ZZRzRPVzQ3cWlvSkxLL3dxZE9M?=
 =?utf-8?B?TmhZSjBSZVhXU2o2bWJibWxPNk04eUpLWHZKZEkyTCtTdTMvTjZwNnlXUFJO?=
 =?utf-8?B?SnB6ellLb20wSkcvNUlUdzZsUFZBdTRNTnV1akFxZTVMZUFkaEVuZ3YxOStE?=
 =?utf-8?B?QWlTMUxxcmN6NFk3QnJ4bmU1OFhSL1ZnK3VUVkRJNjRWNnVkYW1TWnVYa2pp?=
 =?utf-8?B?dSt1aFd6VStkeTI2QktFdlRtNURlNCtoSGNLb3pQVDV6cWlybDlwM0xFUFlH?=
 =?utf-8?B?Q3p2R093QUZTaFRJWjVHdGgxNW1tTTdTZEZOWDkvQ2ZqMGI1WHJFb2xVek1R?=
 =?utf-8?B?L3d2N2RKdHU2dEdna1kzVVpuVkRTYUdYbUlaQmtYanJ2RzNNemh5UVdHTnlO?=
 =?utf-8?B?MTRLbjZ4dU1NWXBRTjQzUWpad1B6VFZGay9aaFNBSnp5R003WWVRV2VMSml1?=
 =?utf-8?B?MjFCU2lwR3A4N0k5akFzOXhsQzREOC80SlVpN2FUd1NkbHprVUl6dUtBZTNH?=
 =?utf-8?B?cCtoVlQyR2FSWGNRelhoMkFuNGdaUmNGM1JTbHRaeVo0VEVGQkRoRHRmR2hj?=
 =?utf-8?B?NmhIQitOWVdFajJWdXIwRkhaN0xSZ0ZMUDZnb3dZODdYczFJdkwyUDNETHVC?=
 =?utf-8?B?Ym80cjYreWwzNzlrUEtmTGt5OGNqOTZMamQ1NnliNm9IblMzWm1nRXBXOG9u?=
 =?utf-8?B?eEo5WUR3S2RCTHRyb05EZURnN3RRV2h4QXVJMFF2bkxtQzFIOWxqZkoya2R6?=
 =?utf-8?B?ZVRvL1A2bmxxc2Mvd2l5UElqc2JoL0gvNmo0YS9GOTlKTk9DODRPQk1GRUd3?=
 =?utf-8?B?QTVoOGh0MnNGRFBoTlhWNTVuZGdmYUdBQXo4U09CbmRjdmNvd0xQUXhMVk9M?=
 =?utf-8?B?MjZKcjZTWDNFTVRwdUJjcEVkekp2QVlRazJoa1h4aVQ1V21FTnFSVnY5OUJ0?=
 =?utf-8?B?RGowU2xDM0pLd2dUSi9rc3lIUzNHdUlLZ2hxV29DVy9oMU1rVEpCbjFvcjhP?=
 =?utf-8?B?aXdxWWZEY2dTeVRSMjN6TnVuMElrTEk5SlA2TVZvRlRhNHc2cmgrcXdVM3R0?=
 =?utf-8?B?TStDN0p4WjY0N1FMMzBudjV5ZkxKa2xoMG1GMlN0RHJLMUI3ZXA0Y2t5QXhK?=
 =?utf-8?B?TE5jdXdGQ2lzNUtRY3ZRTTNneFJ0MFJwTjd6cVo1OGdNYkM0a2IwV2UyN0FH?=
 =?utf-8?B?WkdGSWZ5QTdFY1ZGY1BWcmtpZExNL3pHd2RHYUlMenJpZnJxMTE1Q2pkY1Fk?=
 =?utf-8?B?eVhidGxIRm5ETDkybWtvTHVMdDBnOWhCWmU0Wm5BVnl3OVdYZ1NvZUk4UktK?=
 =?utf-8?B?d1o1QUdrc0NXV2FnaGtUL0ZMRWNiVEJqQlpVU0N5Tm5yaVE1elFqb0RLK0NB?=
 =?utf-8?B?YUlqY0hLQzFSRVg3SDNXeStjWFRjNWtrVFdkcERwSGh4aU5Xc01SMThkQTND?=
 =?utf-8?B?dUt2aGNqZ1Q5dkNzR1B6R3hINlFrL2FHTzRWZFB1U0FMN0Jlb0gvc1hreTRQ?=
 =?utf-8?B?OGNzTzF5KzA0N2pSZmxSczJjT1NJNS8zUzh0MVVlaC9NandvMW84aU9hK1Y3?=
 =?utf-8?B?Y1BraEVDSlJsK05jMXdMOFFyMXJzVWJGMjFsZjIvT1BGbVE2S3ZIdFlBQVpX?=
 =?utf-8?B?eHM1dzBxaXdKOUFTV3hJaWZUWStpaGtJOEcxa3ozSTJNMXBMcGViSzVHTWQ5?=
 =?utf-8?B?a0lFNzNUWHl4N2xMRUtyNWlIMGlvMVJkM29FNEdYcVdjTU5tWUlIejRTMWIz?=
 =?utf-8?B?ZHNrSHR3ZmZDZDBoNDJ0T2I5c05EYSs4Q3RVcW5IUzYwUVdIRjRyTmZ2RTk0?=
 =?utf-8?B?UXd1RlBtOVAyQkpFZmlhQ21ZK1IzN0ZodFlRVUZFV29BTXVwbTNrcmJ3VUVV?=
 =?utf-8?B?WHBBbVBaSEVVWFVOUVhwb0ZDSjd3MHIzeFlxVFRRSkoxS0dBMjRTeUNlby9D?=
 =?utf-8?B?bUk0U0MrenhOSC9sb0JKSVZ3OFp1dEtjV211YXI2L0x0dWZybnpBbEJ6OEc3?=
 =?utf-8?B?ZWlDcG8vK3BXcW1pOXBtaytndjZHNDRvbzlGQTBnZVdsRityeHZ2cXlkWnRN?=
 =?utf-8?Q?6BDni/SEo1cRzhdeAqjKxOaSr?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CYYPR11MB8432.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e26bc7bd-6e57-4f2c-85ea-08dc903aa192
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jun 2024 08:34:27.2758 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9M8JOyim66OiNCDp+8iM+3HTYXTqlGgEY8+N3f+kZl3rnsFINYO2EY9R2RNpO5MfVkBenkP1QoGm2ZZIPL2/Uw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB7182
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.8; envelope-from=chen.zhang@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.148,
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogcWVtdS1kZXZlbC1ib3Vu
Y2VzK2NoZW4uemhhbmc9aW50ZWwuY29tQG5vbmdudS5vcmcgPHFlbXUtDQo+IGRldmVsLWJvdW5j
ZXMrY2hlbi56aGFuZz1pbnRlbC5jb21Abm9uZ251Lm9yZz4gT24gQmVoYWxmIE9mIE5hYmloDQo+
IEVzdGVmYW4NCj4gU2VudDogV2VkbmVzZGF5LCBKdW5lIDE5LCAyMDI0IDE6MjUgQU0NCj4gVG86
IHBldGVyLm1heWRlbGxAbGluYXJvLm9yZw0KPiBDYzogcWVtdS1kZXZlbEBub25nbnUub3JnOyBr
ZnRpbmdAbnV2b3Rvbi5jb207IHd1aGFvdHNoQGdvb2dsZS5jb207DQo+IGphc293YW5nQHJlZGhh
dC5vcmc7IG5hYmloZXN0ZWZhbkBnb29nbGUuY29tDQo+IFN1YmplY3Q6IFtQQVRDSF0gaHcvbmV0
OiBGaXggQ292ZXJpdHkgSXNzdWUgZm9yIG5wY20tZ21hYw0KPiANCj4gVGhlcmUgaXMgYW4gZXh0
cmEgYGJ1Zj1gIHNldCB0aGF0IGlzIG5vdCB1c2VkIGJ5IG5wY20tZ21hYy4gUmVtb3ZlIGl0IGZv
cg0KPiBjb3Zlcml0eSB0byBiZSBoYXBweS4NCj4gDQoNCkxvb2tzIGdvb2QgdG8gbWUuDQpCeSB0
aGUgd2F5LCBJIHNlZSB0aGlzIGZ1bmN0aW9uIGNvbW1lbnRzIHRoZSBTdGVwcyAxLzIvMy4uLg0K
QnV0IEkgY2FuJ3QgZmluZCB0aGUgcGFnZSAzODQgb2YgZGF0YXNoZWV0LCBwbGVhc2UgYWRkIG1v
cmUgZGV0YWlscyBhYm91dCB0aGUgZGF0YXNoZWV0KHZlcnNpb25zIG9mIGRhdGFzaGVldCwgVVJM
Li4uLikuDQoNClJldmlld2VkLWJ5OiBaaGFuZyBDaGVuIDxjaGVuLnpoYW5nQGludGVsLmNvbT4N
Cg0KVGhhbmtzDQpDaGVuDQoNCj4gU2lnbmVkLW9mZi1ieTogTmFiaWggRXN0ZWZhbiA8bmFiaWhl
c3RlZmFuQGdvb2dsZS5jb20+DQo+IC0tLQ0KPiAgaHcvbmV0L25wY21fZ21hYy5jIHwgMSAtDQo+
ICAxIGZpbGUgY2hhbmdlZCwgMSBkZWxldGlvbigtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2h3L25l
dC9ucGNtX2dtYWMuYyBiL2h3L25ldC9ucGNtX2dtYWMuYyBpbmRleA0KPiAxYjcxZTI1MjZlLi5i
Mzk3ZmQ1MDY0IDEwMDY0NA0KPiAtLS0gYS9ody9uZXQvbnBjbV9nbWFjLmMNCj4gKysrIGIvaHcv
bmV0L25wY21fZ21hYy5jDQo+IEBAIC02MTQsNyArNjE0LDYgQEAgc3RhdGljIHZvaWQNCj4gZ21h
Y190cnlfc2VuZF9uZXh0X3BhY2tldChOUENNR01BQ1N0YXRlICpnbWFjKQ0KPiAgICAgICAgICAg
ICAgbmV0X2NoZWNrc3VtX2NhbGN1bGF0ZSh0eF9zZW5kX2J1ZmZlciwgbGVuZ3RoLCBjc3VtKTsN
Cj4gICAgICAgICAgICAgIHFlbXVfc2VuZF9wYWNrZXQocWVtdV9nZXRfcXVldWUoZ21hYy0+bmlj
KSwgdHhfc2VuZF9idWZmZXIsDQo+IGxlbmd0aCk7DQo+ICAgICAgICAgICAgICB0cmFjZV9ucGNt
X2dtYWNfcGFja2V0X3NlbnQoREVWSUNFKGdtYWMpLT5jYW5vbmljYWxfcGF0aCwNCj4gbGVuZ3Ro
KTsNCj4gLSAgICAgICAgICAgIGJ1ZiA9IHR4X3NlbmRfYnVmZmVyOw0KPiAgICAgICAgICAgICAg
bGVuZ3RoID0gMDsNCj4gICAgICAgICAgfQ0KPiANCj4gLS0NCj4gMi40NS4yLjYyNy5nN2EyYzRm
ZDQ2NC1nb29nDQo+IA0KDQo=

