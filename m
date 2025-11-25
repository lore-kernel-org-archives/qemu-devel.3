Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C364D0E6F5
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Nov 2025 16:21:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vNvmt-0001WP-LP; Tue, 25 Nov 2025 11:21:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thanos.makatos@nutanix.com>)
 id 1vNvmc-0001SA-6Y
 for qemu-devel@nongnu.org; Tue, 25 Nov 2025 11:20:53 -0500
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thanos.makatos@nutanix.com>)
 id 1vNvmZ-0005pz-To
 for qemu-devel@nongnu.org; Tue, 25 Nov 2025 11:20:49 -0500
Received: from pps.filterd (m0127844.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 5APFsGL03499621; Tue, 25 Nov 2025 08:20:44 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=p/cAd55FISUoP14S6P3fxMQPAgU0iGR3da4sbMoLE
 qk=; b=ARUFsFF8xaVXn79/EoU5PHEsdDlOKiLNjcycjpi/JMkIJawgivqjmnmbt
 /dm2RHMQSVSJJ1sycLB0rzOIS4D57E4ooaIs6oCCn9/VAqLJqWGoyh4mG71n7WSd
 KszgbSjmSsqNPmu2vvDh4oFMBKkp2JhP5BL7h5CuFCFbDbX6KlAnBPzK89GTPqfP
 wHOa5pLPbJA1WWQp+3HoTJXrJXuBSYH5bvsRBGxkJn+myWa1s0Dt3GEOD3S5Reo8
 SyPDw/CGEPrrJ03/giaDATPpgoxbRyZU8pBx6RXFgfbN93bLiTcQCDWd6lBsZ8S/
 GnBd5TvOXvcztWo9h072QvyVIgcYw==
Received: from sn4pr2101cu001.outbound.protection.outlook.com
 (mail-southcentralusazon11022080.outbound.protection.outlook.com
 [40.93.195.80])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4amu4jjkc5-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 25 Nov 2025 08:20:44 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lid3oEuojcSeI/52mxzdJl0ilH6HRegMSiPNDSq8DJENgOhcZ+WxQ/CRZ3zDWHBEJwcS9qPCK4Huyep7IAj9v/okjyVi+iFYCGJiEFsegizVjOXc7vwbeiJwtA/p7URrK3Lmmmgf2g0zgXdCegbwv44CwdmJ5OV7i7aYpSUUHEjjko16QIF1fv8XzKGtHGL/vUifrLM3AAoXOcqhflLp+ujSSfAu9yegduk9pJisj7/GJ/ArJShYLcflo/YT0P18ntkAIax+Sf4rebFfvCpzVVeB9uUJj6H5ZbnJoJikZZaIEv88/r+EYf8XyX/eIS1CnEsHxPxU0yldUsHYR/ipfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p/cAd55FISUoP14S6P3fxMQPAgU0iGR3da4sbMoLEqk=;
 b=JJJ6Alsq8wzYaTVl1pvWbW6sBETuYl4qiLvQI7uom0YQOWWyL9oIQLFVtlQIG8VqT+hzD9+SWaCHcnsDUBTZgJ0bEPTKM1Nb6j3Ucw7HsUWAVOK/XuLxOkppAYq+AYEdTQE0/gzEfAx3kRC6n3VUdiPLxZKjJlDd/g9t3yOwEgIqCOzHpCFRW5d2Hmg4qG4TO/7O4VrzlWHLZmPXTe+XDQkVKSooL/xnkKMHvOH0lGNUSzPciJysWbyiGD8bzAhiqvKcTVvRx3/b+JOfi/1FGAZMLozFGleMfKAQhpyIRXjPyQeneJSg8jM+3YRVeWxwCZKI1S6QUrVek52MN2vwFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p/cAd55FISUoP14S6P3fxMQPAgU0iGR3da4sbMoLEqk=;
 b=bR8cCQ7IRld6nrdBVKvP7gRP92vYAa06+eStCXKdIrzZiENyiaYoiuAJPzfu9hFthiSb2HIjVuVGpgBfHSPXHQHBw69fDQ93hNb2PNFB2NN1x8IV4knv9T9o4sXQf43fxxbWfJwoAh/HQCYT07/7EZOZuHIGTIjqRx8sKIWGCSLRVbx8fg9deo1wB4kxB9PwldSs3g00xqNk77SCKaHE6YCHv3W9uwmqx25WHqB1T2AZAJz32fJi6sZdah5zNH6QI1EGzFSPYJLpp9HFmiGqmHKCh69BtIp73kDjkAlpHtOpKRYpqNRoIkKQ5XTH1ZC0Ssl95hSvshrnYmh1hNqOgA==
Received: from DS0PR02MB9321.namprd02.prod.outlook.com (2603:10b6:8:143::21)
 by BL3PR02MB9036.namprd02.prod.outlook.com (2603:10b6:208:3bf::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.11; Tue, 25 Nov
 2025 16:20:41 +0000
Received: from DS0PR02MB9321.namprd02.prod.outlook.com
 ([fe80::16f2:466f:95b5:188f]) by DS0PR02MB9321.namprd02.prod.outlook.com
 ([fe80::16f2:466f:95b5:188f%3]) with mapi id 15.20.9343.016; Tue, 25 Nov 2025
 16:20:40 +0000
From: Thanos Makatos <thanos.makatos@nutanix.com>
To: John Levon <john.levon@nutanix.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>
Subject: RE: [PATCH v2 4/5] vfio-user: simplify vfio_user_recv_one()
Thread-Topic: [PATCH v2 4/5] vfio-user: simplify vfio_user_recv_one()
Thread-Index: AQHcV9rSr2W5ApqN9kq0Juc475mFBrUDnktg
Date: Tue, 25 Nov 2025 16:20:40 +0000
Message-ID: <DS0PR02MB932115EC3218C02AF5C0608A8BD1A@DS0PR02MB9321.namprd02.prod.outlook.com>
References: <20251117155656.2060336-1-john.levon@nutanix.com>
 <20251117155656.2060336-5-john.levon@nutanix.com>
In-Reply-To: <20251117155656.2060336-5-john.levon@nutanix.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR02MB9321:EE_|BL3PR02MB9036:EE_
x-ms-office365-filtering-correlation-id: b5f15d3d-04e9-47ba-5a06-08de2c3e9378
x-proofpoint-crosstenant: true
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|7053199007|38070700021; 
x-microsoft-antispam-message-info: =?utf-8?B?YTg3MTBjTWJvcGpoVHE2UVNqbEZQcDdmeW0yYzkweGYzazZZWmt0WGgwN3J6?=
 =?utf-8?B?VU91TVVKR1pzcWF5ZFR5bnZjL0k5ZmVoZzdiZitWczlMSXF3NFNzK3czSXZ5?=
 =?utf-8?B?TGlwUGZiS0U1YWtzUzVVcW95dW5BdnlFcUdtblErN0IzR1lOeFlIdi9lcnZS?=
 =?utf-8?B?Rm9NY2ZlZ0M2Rm8wNTFxeUJQOHZTcEJFS1ZoL3dKVzloUHRDaHY5SUE1TTRx?=
 =?utf-8?B?M25XZUp4VjZyUmpIckNLVVpJVENWK1FmaU5kUVRiWGdyamo0Wjhvam12UnlY?=
 =?utf-8?B?dHMzSTVBYkt4ZWhTMXZRYWRyMlNzZ0xmQmdHSHhqeGlZUks4MzV1YUthTHFl?=
 =?utf-8?B?ZFVkWG5BWEtCYVlraGE0WlRQZ21RQlVaUG52S3VWQkRtalNLQS9CRXU4Sm9O?=
 =?utf-8?B?WDkvYUltWEovNWpoMkkwNStQKzZkMlYyL1BJR0NoVlNFdUJEL0t0NmdPYWw3?=
 =?utf-8?B?OE45ejRGdFo4eHVmVUVaN1JPeEoxWHlhQzdEM2NTMXdUQ1BJUHZSeExyRG43?=
 =?utf-8?B?UDBnaDVIOEZSUkxmdTdsRVhQc05ybUVQNUEzSU1jUVlrcE1zMFVSTVhGbEs0?=
 =?utf-8?B?a0NpeE9RYk5aSTl6TFhHT3g5Tnp1Z2xBZ0R0S1VOQXNvanRXM3YxeG1kZ05K?=
 =?utf-8?B?cmI0aldpaGFhTW1CazVNTmJYMHdRd0M4RUxlKzQ2MkdBQ2ZaaDBUb0NRTFpu?=
 =?utf-8?B?aHpoUC9EUW5OUlpMS3BiaGh5VFY2Y2N3VzdJSmlISjFXQ2JIL3ZUYWVsdEx5?=
 =?utf-8?B?TWg5N2hDV3JwNUlybk0wRWVVcktlQXMzTllkczljM1hoVCtwb2RDQUhyL2pv?=
 =?utf-8?B?ck9hdjd4dkoxZjQ5eE8zQmxaelYzRTJsY1dsT21GRWUrTHlwTHJiSTZWVHRz?=
 =?utf-8?B?QXNLUFBHc2pEN3pSK1k3TjYrN0U0dWpKRC9hYUFkSUFlYWd5MXphdmgzWEdh?=
 =?utf-8?B?eit1UnM0K3R4aXZzeHlaTHhJUEsvMkhJdnpuNmEra1J6UnhiQ1ozMTRVNVVI?=
 =?utf-8?B?WVF5WFR2UDZZUUJNZjJZSkY4SjJpeGFKMGRRZnd5VXRBd2VlUGNHVlpmdjlM?=
 =?utf-8?B?NVFBemNGOUlFMzE2eVRYK3AxSzJwS09ublFFbFJJRjk1ZGNmVzR4anZzVjI0?=
 =?utf-8?B?YnorL2pNV1NkSWJMMy9EQWV3U1VxdXNRRCt2WmxhZXZBOEVwYVhXSCtZVVN2?=
 =?utf-8?B?RHJ0cU9VbldweTBiZXp5MUh5RU5PVlFZRllSUFB1MHBGQThUajZ6L3UxcmNL?=
 =?utf-8?B?QUdxRGcwZERMd3RrSkUzYlZrN1d1Z2thTzJOMG53WVB6UnRkb3dwZEtXUzky?=
 =?utf-8?B?MEdHNjRoNzFXQlFNeWQyeXU2VHJML09BQTV4RFpTS1BsaGo0cVdrdENNZU1L?=
 =?utf-8?B?SzRnQUJMRFk2VFJHVVFrdmoyb3lOYlJEMTUvWFdGOEhOUjA2eGNuNHMrSk1a?=
 =?utf-8?B?RFpWUWdEaVNyUTFWUmpWVzh6MG5iVFgzTUgrQUtkRndKS1NVaDJlZzR0UlIv?=
 =?utf-8?B?cVZGNnJEcnMzVnpud2ZlcmJsRDdZanFsN2tSNlpocUpZaW1GWU5TcVk1cWE1?=
 =?utf-8?B?M3dNUWpKRkNRUlhPRE1OUUZLRXRpQ0d0MVh1dUF2SnMrZ1lObE8yZTJXRUIy?=
 =?utf-8?B?UGFEckJGblN6b1dkMVR3U3FLOUQrTHcxQmVUVk14L1NSa1ExNU50ejk1YkpM?=
 =?utf-8?B?THF0STBObTg1dzV4cStaeW55QjRaWHBLczBnWFhQME1MZk9zVjlER0ZxdlZX?=
 =?utf-8?B?VnZSYUw1Q0daU3A1NEJWN2lpN0cyV3ZuN1VYL1VkdW9RalFIM2lYQlFFdG1H?=
 =?utf-8?B?aWRxVW9PbW1kRDJDNzFaeUFPSGhHUkNRZHU4cERpZHlKR2EyZ1VtRjR4eUZU?=
 =?utf-8?B?Umh5WVZYTTI1RkhNR0lCT3YzM2JJZHZjMlNlQWhqZUU1RnkvNWNJNE9abTJj?=
 =?utf-8?B?UTBVc0dKVUUxWWpMMUp2Zm1kRHp0M1Vvbmljay9xWHZsL0ZsMzdzTlR1TEd5?=
 =?utf-8?B?ZWZucWdRM3piajNIeXArNy9rSHhseldaNHFqYmNiZkRzbjNucFV5N0traXZz?=
 =?utf-8?Q?0Qdb9Y?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR02MB9321.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7053199007)(38070700021); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Z1VrVll2QWtmQ2o0WlZCYjRYV3FVNUxja2xyRm5zVlcrSHlMZFVMb25yNnB5?=
 =?utf-8?B?VkowYnZUUjlVUHFBZGpRcXJzWHM2OWhoLzFubHBOR0prQlY3ZVJJMFNOUWpu?=
 =?utf-8?B?eEV1cldyVjRLV3MzWXlIWFZZVmhjb2MrcFVQd3duQVlxS0R0UFVReUtoTVVI?=
 =?utf-8?B?SVFjZ0pYQWIxRzhEaHB0bFBFL2ZpWC84VFp2b0RMNEVMU21WVUE0Rkl3OXAx?=
 =?utf-8?B?ZHBOV0ZEYVk3a1VQTUdpNHlVZU5WQXJ6eVpnbVRzR0ppVGY4Z3NzMFdxdjZQ?=
 =?utf-8?B?YVZTWkx2QlBrUjRIVlRpM1pnTzU1cERLMmtBcWZVK1E2NmRYb1RkY21PajRo?=
 =?utf-8?B?emhKMzNUQzVENEFqanB3dmFESjhWeXA4MGlHeVRBSVBoSmc3YWQ2aU55clpJ?=
 =?utf-8?B?K1E2UHZDY1lBUkVrRjFyUjE1VTZxUHh3Z0hHNW1KNHluUWp1TytsK3R2dDVG?=
 =?utf-8?B?RThlRFptSHZIU3FGMGh3ZmRPbTBWenRkdUIwUkppWVhOOUc0cGt1aC9PR1U0?=
 =?utf-8?B?QlFsb1NrNmxnMlB0Sld0aGJ1cjY5L2xYU1doVVJDVDQ1QlZlNmJBUVBSSWJh?=
 =?utf-8?B?L24vSDZzd0RPL3ltM1QySGswVjVNKzA3aXZLbTRsNlRQR2QrNDJoTysyTFFN?=
 =?utf-8?B?bUZZNmlrdzhISDBxMzAwTlVNWURxV0twM3pQV3k1Mnk5M1BPR0VoYlF0ZHBv?=
 =?utf-8?B?T3lhakN0R2JxTiswN3BxeEpSdkN1TmZBc1hDaW1ZdExybVV3bEpGNkRkWmoy?=
 =?utf-8?B?dEd1bDA5THR4VzVBczNHczB2R08vbFZscytTYjZNSFp4YWsyYXBBR0J6WkNQ?=
 =?utf-8?B?di9PalV5MmhnZUh6VUl5MzVLMHU3QkhqVTJoYnNhRWxIN3l5eFh1WFd6OE4y?=
 =?utf-8?B?dzN4eExKck9lYnNJRm1wUkxzUDE3VlQwRWtuTHRZdFBRdEhmM3RPNXc4OTRq?=
 =?utf-8?B?aFFlRGdEc05rOEp0emNlWWhENVFaTnIxZWFnM1JEMm1SRUdkSUxrVXlsd05T?=
 =?utf-8?B?dVloYmxWb293cDlTTVg0cFhDa0FNRWRSRzlndXZPQnBFaG1ZUXV2d2Y5V2tR?=
 =?utf-8?B?MHdUMzZJbmZlVjNtVEFjMGM4NXI3aFY2aHZKWmVCSGg2WEJjaGRRdnNnbHhv?=
 =?utf-8?B?T3AwZDZabnNaWmh4M3kveGpaZ0l3UDlQUGNCMDByZzl6SWN1c1d6NmZkUEJ5?=
 =?utf-8?B?RUpCUUVLZTA2clNERnpuNzY0VEVhdE1UeVN0Z0x2T05qcTNyRDAvbnB4bkxp?=
 =?utf-8?B?bVVudGJ4TlRIdktGRkgzbTdjR29yRDZFeTJKNkVPaXBqOXZiTDRFa3dNenpr?=
 =?utf-8?B?d3JiZ3p1R1BlQ1BtRTFoYTRkMDRKWi90V1plSTFab2pXYUZOYURSb0ZMSEsv?=
 =?utf-8?B?WEZOUG9TKzlib01EWUJVMDJCTExWRUtOWWhlL2h5MUl6Rm40TkFpY29rY29J?=
 =?utf-8?B?Y3pHVktzV1BXZGdvS0RtbEFicno0SU9FN05ZZDdNeW9HazlSYXduYytzTFVQ?=
 =?utf-8?B?RElJVE9reFR0Snd4SEExYkRUaDBoZHVVdzZiVnliUDhjRkpxczJ1bU9iUDl3?=
 =?utf-8?B?KzRaOUtXSkpMV0JudU9SaFJVOHdTQUxKb1RlMU4rNjhpOVZkR0JUbWVYL0do?=
 =?utf-8?B?eEE5K2lWdzBaTWN6OXQ5S2ZtVUh1L2V1bmR0MFVHOXhtLy9FOVFmMHZHeUdo?=
 =?utf-8?B?RG9vT3c1WEJwZ1pxN0UvZHdJcUdPVTJ3R25udjB1UW5EMkZydUZOdkczWHFZ?=
 =?utf-8?B?OHRrYS9hVXptd2tNVHpPVmVnYnhoTGhkam8xVVJsbVUwWnBjdmdSSUFUeXpz?=
 =?utf-8?B?Y2VoTVVKTDJ1R2taV09YbVVhZmVpbjJ3YnJsaGJCQnVEUGtrT3JuSjhHWHdV?=
 =?utf-8?B?Ui9XL1V4Tk1wUFZZdkpxREIyUHNDOXlpMitsY292cnVGeHM1ZU1ubFJzOWo0?=
 =?utf-8?B?RU1NL1UxTHhGV2tQbUhFaXZwV3Z6UUVRMjdKd0ZsRWprOWhFcFBQaFM5RGh4?=
 =?utf-8?B?Qnc2QVRXZTdHc090YWRlbXdjM1Y1NEJsZURQUHBncU5qR29JUFMwNzliYTl1?=
 =?utf-8?B?aWdkVnNCZ0JMeXU5L2JlTnRXTlo2SThGS2pMbFVQUG9VRW90eVlqaDNRWUda?=
 =?utf-8?Q?ziQm6/YFHNiZLrbBd0q1aWi9A?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR02MB9321.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5f15d3d-04e9-47ba-5a06-08de2c3e9378
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Nov 2025 16:20:40.6774 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FG+t2EkcQPkB+g+6Ic+/wijSzz5Yd51Y3Ngqq82ApkXcaM9XzALWDG5j+iHD/uv17zge1suNfuXXdRKxLnSFAdnKq/du17Sff2tUNFbjoCM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR02MB9036
X-Proofpoint-GUID: u1iZXSvbUQvjThHzMUjy7-1JPAydkdvB
X-Authority-Analysis: v=2.4 cv=YOaSCBGx c=1 sm=1 tr=0 ts=6925d75c cx=c_pps
 a=mu652P9qVXFiHaHDVbjfEQ==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6UeiqGixMTsA:10 a=0kUYKlekyDsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=64Cc0HZtAAAA:8 a=69wJf7TsAAAA:8 a=20KFwNOVAAAA:8 a=KKAkSRfTAAAA:8
 a=d85z0veD1Rb4dzPWYKcA:9 a=QEXdDO2ut3YA:10 a=Fg1AiH1G6rFz08G2ETeA:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: u1iZXSvbUQvjThHzMUjy7-1JPAydkdvB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTI1MDEzNiBTYWx0ZWRfXz9K4T36LcrDM
 KTtRCjneinKjwjGdVNlHo+k4t/MJpWDfnOpLbk4i7Ew/f2zfYMhDC97RL+pPzIpKA4ZjxWcMdce
 bR5p0keOdaGatf7rO9PS7Al3GSP+gNtmjmHhmc7mfAgbPtzzeQ478ZY37dVCt+xyj7oD7yfohB9
 5MyElcY18dkkKWTBBbR8UEmZ28lJBkdWrj+JuGai/LrpMLVCqWI3zBtWqeB4I+KzHPbaO1iYBxt
 VeLjh5LqRIRaZXss4woxfTEFxQZQC/oeG2FQYghWKb1YcHNZ8s6BqryOnYUo1+X1IfI/CXCd9Zi
 SsCU9wDkDwgMHiI+3NXMWiivxK5eCHqtue3FMp77uDw2tTnQdSBwKleHMjczdYSYGZxYDO6j5lO
 saZrgk2Rd24hMiElC9BFYOGOfvCGTA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-25_02,2025-11-25_01,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=thanos.makatos@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.152,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
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

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBKb2huIExldm9uIDxqb2huLmxl
dm9uQG51dGFuaXguY29tPg0KPiBTZW50OiAxNyBOb3ZlbWJlciAyMDI1IDE1OjU3DQo+IFRvOiBx
ZW11LWRldmVsQG5vbmdudS5vcmcNCj4gQ2M6IEpvaG4gTGV2b24gPGpvaG4ubGV2b25AbnV0YW5p
eC5jb20+OyBUaGFub3MgTWFrYXRvcw0KPiA8dGhhbm9zLm1ha2F0b3NAbnV0YW5peC5jb20+OyBD
w6lkcmljIExlIEdvYXRlciA8Y2xnQHJlZGhhdC5jb20+OyBQZXRlcg0KPiBNYXlkZWxsIDxwZXRl
ci5tYXlkZWxsQGxpbmFyby5vcmc+DQo+IFN1YmplY3Q6IFtQQVRDSCB2MiA0LzVdIHZmaW8tdXNl
cjogc2ltcGxpZnkgdmZpb191c2VyX3JlY3Zfb25lKCkNCj4gDQo+IFRoaXMgZnVuY3Rpb24gd2Fz
IHVubmVjZXNzYXJpbHkgZGlmZmljdWx0IHRvIHVuZGVyc3RhbmQgZHVlIHRvIHRoZQ0KPiBzZXBh
cmF0ZSBoYW5kbGluZyBvZiByZXF1ZXN0IGFuZCByZXBseSBtZXNzYWdlcy4gVXNlIGNvbW1vbiBj
b2RlIGZvcg0KPiBib3RoIHdoZXJlIHdlIGNhbi4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEpvaG4g
TGV2b24gPGpvaG4ubGV2b25AbnV0YW5peC5jb20+DQo+IC0tLQ0KPiAgaHcvdmZpby11c2VyL3By
b3h5LmMgfCA2OCArKysrKysrKysrKysrKysrKysrLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0K
PiAgMSBmaWxlIGNoYW5nZWQsIDMwIGluc2VydGlvbnMoKyksIDM4IGRlbGV0aW9ucygtKQ0KPiAN
Cj4gZGlmZiAtLWdpdCBhL2h3L3ZmaW8tdXNlci9wcm94eS5jIGIvaHcvdmZpby11c2VyL3Byb3h5
LmMNCj4gaW5kZXggODdlNTA1MDFhZi4uYWE1Yjk3MWZiNiAxMDA2NDQNCj4gLS0tIGEvaHcvdmZp
by11c2VyL3Byb3h5LmMNCj4gKysrIGIvaHcvdmZpby11c2VyL3Byb3h5LmMNCj4gQEAgLTI4MSwx
NSArMjgxLDE0IEBAIHN0YXRpYyBpbnQgdmZpb191c2VyX3JlY3ZfaGRyKFZGSU9Vc2VyUHJveHkg
KnByb3h5LA0KPiBFcnJvciAqKmVycnAsDQo+ICAgKi8NCj4gIHN0YXRpYyBpbnQgdmZpb191c2Vy
X3JlY3Zfb25lKFZGSU9Vc2VyUHJveHkgKnByb3h5LCBFcnJvciAqKmVycnApDQo+ICB7DQo+IC0g
ICAgVkZJT1VzZXJNc2cgKm1zZyA9IE5VTEw7DQo+ICAgICAgZ19hdXRvZnJlZSBpbnQgKmZkcCA9
IE5VTEw7DQo+IC0gICAgVkZJT1VzZXJGRHMgKnJlcWZkczsNCj4gLSAgICBWRklPVXNlckhkciBo
ZHI7DQo+ICsgICAgVkZJT1VzZXJNc2cgKm1zZyA9IE5VTEw7DQo+ICAgICAgYm9vbCBpc3JlcGx5
ID0gZmFsc2U7DQo+IC0gICAgaW50IGksIHJldDsNCj4gLSAgICBzaXplX3QgbXNnbGVmdCwgbnVt
ZmRzID0gMDsNCj4gKyAgICBzaXplX3QgbXNnbGVmdCA9IDA7DQo+ICsgICAgc2l6ZV90IG51bWZk
cyA9IDA7DQo+ICAgICAgY2hhciAqZGF0YSA9IE5VTEw7DQo+IC0gICAgY2hhciAqYnVmID0gTlVM
TDsNCj4gKyAgICBWRklPVXNlckhkciBoZHI7DQo+ICsgICAgaW50IGksIHJldDsNCj4gDQo+ICAg
ICAgLyoNCj4gICAgICAgKiBDb21wbGV0ZSBhbnkgcGFydGlhbCByZWFkcw0KPiBAQCAtMzE3LDgg
KzMxNiw4IEBAIHN0YXRpYyBpbnQgdmZpb191c2VyX3JlY3Zfb25lKFZGSU9Vc2VyUHJveHkgKnBy
b3h5LA0KPiBFcnJvciAqKmVycnApDQo+ICAgICAgfQ0KPiANCj4gICAgICAvKg0KPiAtICAgICAq
IEZvciByZXBsaWVzLCBmaW5kIHRoZSBtYXRjaGluZyBwZW5kaW5nIHJlcXVlc3QuDQo+IC0gICAg
ICogRm9yIHJlcXVlc3RzLCByZWFwIGluY29taW5nIEZEcy4NCj4gKyAgICAgKiBGaW5kIHRoZSBt
YXRjaGluZyByZXF1ZXN0IGlmIHRoaXMgaXMgYSByZXBseSwgb3IgaW5pdGlhbGl6ZSBhIG5ldw0K
PiArICAgICAqIHNlcnZlci0+Y2xpZW50IHJlcXVlc3QuDQo+ICAgICAgICovDQo+ICAgICAgaWYg
KGlzcmVwbHkpIHsNCj4gICAgICAgICAgUVRBSUxRX0ZPUkVBQ0gobXNnLCAmcHJveHktPnBlbmRp
bmcsIG5leHQpIHsNCj4gQEAgLTMzMiw1MSArMzMxLDQ0IEBAIHN0YXRpYyBpbnQgdmZpb191c2Vy
X3JlY3Zfb25lKFZGSU9Vc2VyUHJveHkNCj4gKnByb3h5LCBFcnJvciAqKmVycnApDQo+ICAgICAg
ICAgIH0NCj4gICAgICAgICAgUVRBSUxRX1JFTU9WRSgmcHJveHktPnBlbmRpbmcsIG1zZywgbmV4
dCk7DQo+IA0KPiAtICAgICAgICAvKg0KPiAtICAgICAgICAgKiBQcm9jZXNzIGFueSByZWNlaXZl
ZCBGRHMNCj4gLSAgICAgICAgICovDQo+IC0gICAgICAgIGlmIChudW1mZHMgIT0gMCkgew0KPiAt
ICAgICAgICAgICAgaWYgKG1zZy0+ZmRzID09IE5VTEwgfHwgbXNnLT5mZHMtPnJlY3ZfZmRzIDwg
bnVtZmRzKSB7DQo+IC0gICAgICAgICAgICAgICAgZXJyb3Jfc2V0ZyhlcnJwLCAidW5leHBlY3Rl
ZCBGRHMiKTsNCj4gLSAgICAgICAgICAgICAgICBnb3RvIGVycjsNCj4gLSAgICAgICAgICAgIH0N
Cj4gLSAgICAgICAgICAgIG1zZy0+ZmRzLT5yZWN2X2ZkcyA9IG51bWZkczsNCj4gLSAgICAgICAg
ICAgIG1lbWNweShtc2ctPmZkcy0+ZmRzLCBmZHAsIG51bWZkcyAqIHNpemVvZihpbnQpKTsNCj4g
LSAgICAgICAgfQ0KPiAtICAgIH0gZWxzZSB7DQo+IC0gICAgICAgIGlmIChudW1mZHMgIT0gMCkg
ew0KPiAtICAgICAgICAgICAgcmVxZmRzID0gdmZpb191c2VyX2dldGZkcyhudW1mZHMpOw0KPiAt
ICAgICAgICAgICAgbWVtY3B5KHJlcWZkcy0+ZmRzLCBmZHAsIG51bWZkcyAqIHNpemVvZihpbnQp
KTsNCj4gLSAgICAgICAgfSBlbHNlIHsNCj4gLSAgICAgICAgICAgIHJlcWZkcyA9IE5VTEw7DQo+
IC0gICAgICAgIH0NCj4gLSAgICB9DQo+IC0NCj4gLSAgICAvKg0KPiAtICAgICAqIFB1dCB0aGUg
d2hvbGUgbWVzc2FnZSBpbnRvIGEgc2luZ2xlIGJ1ZmZlci4NCj4gLSAgICAgKi8NCj4gLSAgICBp
ZiAoaXNyZXBseSkgew0KPiAgICAgICAgICBpZiAoaGRyLnNpemUgPiBtc2ctPnJzaXplKSB7DQo+
ICAgICAgICAgICAgICBlcnJvcl9zZXRnKGVycnAsICJyZXBseSBsYXJnZXIgdGhhbiByZWN2IGJ1
ZmZlciIpOw0KPiAgICAgICAgICAgICAgZ290byBlcnI7DQo+ICAgICAgICAgIH0NCj4gLSAgICAg
ICAgKm1zZy0+aGRyID0gaGRyOw0KPiAtICAgICAgICBkYXRhID0gKGNoYXIgKiltc2ctPmhkciAr
IHNpemVvZihoZHIpOw0KPiAgICAgIH0gZWxzZSB7DQo+ICsgICAgICAgIHZvaWQgKmJ1ZjsNCj4g
Kw0KPiAgICAgICAgICBpZiAoaGRyLnNpemUgPiBwcm94eS0+bWF4X3hmZXJfc2l6ZSArIHNpemVv
ZihWRklPVXNlckRNQVJXKSkgew0KPiAgICAgICAgICAgICAgZXJyb3Jfc2V0ZyhlcnJwLCAidmZp
b191c2VyX3JlY3YgcmVxdWVzdCBsYXJnZXIgdGhhbiBtYXgiKTsNCj4gICAgICAgICAgICAgIGdv
dG8gZXJyOw0KPiAgICAgICAgICB9DQo+ICsNCj4gICAgICAgICAgYnVmID0gZ19tYWxsb2MwKGhk
ci5zaXplKTsNCj4gLSAgICAgICAgbWVtY3B5KGJ1ZiwgJmhkciwgc2l6ZW9mKGhkcikpOw0KPiAt
ICAgICAgICBkYXRhID0gYnVmICsgc2l6ZW9mKGhkcik7DQo+IC0gICAgICAgIG1zZyA9IHZmaW9f
dXNlcl9nZXRtc2cocHJveHksIChWRklPVXNlckhkciAqKWJ1ZiwgcmVxZmRzKTsNCj4gKyAgICAg
ICAgbXNnID0gdmZpb191c2VyX2dldG1zZyhwcm94eSwgYnVmLCBOVUxMKTsNCj4gICAgICAgICAg
bXNnLT50eXBlID0gVkZJT19NU0dfUkVROw0KPiAgICAgIH0NCj4gDQo+ICsgICAgKm1zZy0+aGRy
ID0gaGRyOw0KPiArICAgIGRhdGEgPSAoY2hhciAqKW1zZy0+aGRyICsgc2l6ZW9mKGhkcik7DQo+
ICsNCj4gKyAgICBpZiAobnVtZmRzICE9IDApIHsNCj4gKyAgICAgICAgaWYgKG1zZy0+dHlwZSA9
PSBWRklPX01TR19SRVEpIHsNCj4gKyAgICAgICAgICAgIG1zZy0+ZmRzID0gdmZpb191c2VyX2dl
dGZkcyhudW1mZHMpOw0KPiArICAgICAgICB9IGVsc2Ugew0KPiArICAgICAgICAgICAgaWYgKG1z
Zy0+ZmRzID09IE5VTEwgfHwgbXNnLT5mZHMtPnJlY3ZfZmRzIDwgbnVtZmRzKSB7DQo+ICsgICAg
ICAgICAgICAgICAgZXJyb3Jfc2V0ZyhlcnJwLCAidW5leHBlY3RlZCBGRHMiKTsNCg0Kbml0LCAi
dW5leHBlY3RlZCBGRHMgaW4gcmVzcG9uc2UiPw0KDQo+ICsgICAgICAgICAgICAgICAgZ290byBl
cnI7DQo+ICsgICAgICAgICAgICB9DQo+ICsgICAgICAgICAgICBtc2ctPmZkcy0+cmVjdl9mZHMg
PSBudW1mZHM7DQo+ICsgICAgICAgIH0NCj4gKw0KPiArICAgICAgICBtZW1jcHkobXNnLT5mZHMt
PmZkcywgZmRwLCBudW1mZHMgKiBzaXplb2YoaW50KSk7DQo+ICsgICAgfQ0KPiArDQo+ICAgICAg
LyoNCj4gLSAgICAgKiBSZWFkIHJlc3Qgb2YgbWVzc2FnZS4NCj4gKyAgICAgKiBSZWFkIHJlc3Qg
b2YgbWVzc2FnZSBpbnRvIHRoZSBkYXRhIGJ1ZmZlci4NCj4gICAgICAgKi8NCj4gKw0KPiAgICAg
IG1zZ2xlZnQgPSBoZHIuc2l6ZSAtIHNpemVvZihoZHIpOw0KPiAgICAgIHdoaWxlIChtc2dsZWZ0
ID4gMCkgew0KPiAgICAgICAgICByZXQgPSBxaW9fY2hhbm5lbF9yZWFkKHByb3h5LT5pb2MsIGRh
dGEsIG1zZ2xlZnQsIGVycnApOw0KPiAtLQ0KPiAyLjQzLjANCg0KUmV2aWV3ZWQtYnk6IFRoYW5v
cyBNYWthdG9zIDx0aGFub3MubWFrYXRvc0BudXRhbml4LmNvbT4NCg0K

