Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D095AC2BD09
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 01:52:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOSgm-0001uW-Qw; Mon, 01 Jul 2024 21:52:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yaoxt.fnst@fujitsu.com>)
 id 1sOSgk-0001rn-Vl
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 21:52:11 -0400
Received: from esa18.fujitsucc.c3s2.iphmx.com ([216.71.158.38])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yaoxt.fnst@fujitsu.com>)
 id 1sOSgi-00006l-IU
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 21:52:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1719885129; x=1751421129;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=0ukK++9gwQ0DgOM05h5rf6E5QqrFI/TqHkfLsg9l3Kw=;
 b=YdLVL9qNWoUZ6SpD8llXPMXb4+bM2wco3pk0jauRZmSSoRnxJDHUV/a/
 avgrVo/1z7q+vJy4JssSIQVxeH51+Yl/rDXLnYjbNqBGyXUBe3/ZQDP8r
 u2spQQtiwOGfMJTKFfoPVpOa1w53mtavOfXTl5EYf4Y77mPyTj0w7QQWq
 k+jgwo31ljN7FoBhOR5XPswHRmK7WH7aRyUeo+9KYwg0jc6S44alM0zHM
 3d2FHa1TPPNMrQ9ndLCnvBVPd/RNZii9IbkU24wd6P5mS6SaItgI3xGMv
 TfqCybB/8zpfC1jwV2+DTe6/0VmDM69Wy8gieQfRDR6podU7W+uhyiodh w==;
X-IronPort-AV: E=McAfee;i="6700,10204,11120"; a="128819942"
X-IronPort-AV: E=Sophos;i="6.09,177,1716217200"; d="scan'208";a="128819942"
Received: from mail-tycjpn01lp2169.outbound.protection.outlook.com (HELO
 JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.169])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Jul 2024 10:52:04 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=echv4IE4fCCkXiWIpBTdorkTx2mGipggvjC/FKy/Mc4Xp4YikUkjfCgEcWSuUJ4SQPTWt7kLZQUhxwSy8aNFL4LeUnJ+Cq5s7Uemks3/lm4R0Ra7viovrPLrJZLSd3/Mb86gkSkY6RNpYWsDqk+JHijAKgzc3GKjMEhAWpKUTPgeSimnPZKB++CSOnD8QZbUyZDxf1PZYHkCPzwae81Ao9JiEXPh3AKSSwqCCU8NDdwtcVxha4zpkXNoR8WIC3n5e00XJ9uy40VEG5JI+gBvZNd4ecm++XUVpxxpZtmpj/2lRpo0aNY9qui6BrLJp5rf+boOA4QXHdqqUNbIh6H2Zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0ukK++9gwQ0DgOM05h5rf6E5QqrFI/TqHkfLsg9l3Kw=;
 b=TrgrdzBUJs6aDssCJPPy8zsmR8wC1PYYHaApCprW76NkexkSJhmmR9JmOnB234ZOJiXu7WiET7Z4RT5yPz7qLKLjPUs2TplX3rgMZobi9KcehVLD1/9tGhs/kr0tPR0R4cYbVgRmQH9htbBcd1Fa+uKnLs+EDK/KB9CQGkcTGh+A3s9Fr75yPJQpCLXpaPv5SJmqHQEPbmGNifVO7jopz+NVXJ9X3Lkois9B+PvGqOpMIRODfu6OqKRHfx+wYJJPUascm/RuLOgT49/vtM6O/YPcRQFWCAQshgyhQl5mdPQaYJpeGynNe8vs1UN90JAaPHKTTnWrQs0KnvMMlJHtYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OSZPR01MB6453.jpnprd01.prod.outlook.com (2603:1096:604:ed::14)
 by TYCPR01MB6608.jpnprd01.prod.outlook.com (2603:1096:400:ae::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.34; Tue, 2 Jul
 2024 01:52:00 +0000
Received: from OSZPR01MB6453.jpnprd01.prod.outlook.com
 ([fe80::9ef5:e83:9047:de11]) by OSZPR01MB6453.jpnprd01.prod.outlook.com
 ([fe80::9ef5:e83:9047:de11%6]) with mapi id 15.20.7719.029; Tue, 2 Jul 2024
 01:52:00 +0000
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: Eduardo Habkost <eduardo@habkost.net>, =?utf-8?B?QWxleCBCZW5uw6ll?=
 <alex.bennee@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>,
 =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>, Alexandre
 Iooss <erdnaxe@crans.org>, Richard Henderson <richard.henderson@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>
Subject: RE: [PATCH v3 1/7] plugins: fix mem callback array size
Thread-Topic: [PATCH v3 1/7] plugins: fix mem callback array size
Thread-Index: AQHazBy9qQxBjKAws0u10v/g9iq5RLHipvGQ
Date: Tue, 2 Jul 2024 01:52:00 +0000
Message-ID: <OSZPR01MB645339DE147F2832B76297718DDC2@OSZPR01MB6453.jpnprd01.prod.outlook.com>
References: <20240702011015.325609-1-pierrick.bouvier@linaro.org>
 <20240702011015.325609-2-pierrick.bouvier@linaro.org>
In-Reply-To: <20240702011015.325609-2-pierrick.bouvier@linaro.org>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: =?utf-8?B?TVNJUF9MYWJlbF8xZTkyZWY3My0wYWQxLTQwYzUtYWQ1NS00NmRlMzM5Njgw?=
 =?utf-8?B?MmZfQWN0aW9uSWQ9YTIwMWY4Y2UtMjgxMC00OTgyLWJjMTYtMjJiYWRlNzYz?=
 =?utf-8?B?ZjAxO01TSVBfTGFiZWxfMWU5MmVmNzMtMGFkMS00MGM1LWFkNTUtNDZkZTMz?=
 =?utf-8?B?OTY4MDJmX0NvbnRlbnRCaXRzPTA7TVNJUF9MYWJlbF8xZTkyZWY3My0wYWQx?=
 =?utf-8?B?LTQwYzUtYWQ1NS00NmRlMzM5NjgwMmZfRW5hYmxlZD10cnVlO01TSVBfTGFi?=
 =?utf-8?B?ZWxfMWU5MmVmNzMtMGFkMS00MGM1LWFkNTUtNDZkZTMzOTY4MDJmX01ldGhv?=
 =?utf-8?B?ZD1Qcml2aWxlZ2VkO01TSVBfTGFiZWxfMWU5MmVmNzMtMGFkMS00MGM1LWFk?=
 =?utf-8?B?NTUtNDZkZTMzOTY4MDJmX05hbWU9RlVKSVRTVS1QVUJMSUPigIs7TVNJUF9M?=
 =?utf-8?B?YWJlbF8xZTkyZWY3My0wYWQxLTQwYzUtYWQ1NS00NmRlMzM5NjgwMmZfU2V0?=
 =?utf-8?B?RGF0ZT0yMDI0LTA3LTAyVDAxOjMxOjQ0WjtNU0lQX0xhYmVsXzFlOTJlZjcz?=
 =?utf-8?B?LTBhZDEtNDBjNS1hZDU1LTQ2ZGUzMzk2ODAyZl9TaXRlSWQ9YTE5ZjEyMWQt?=
 =?utf-8?Q?81e1-4858-a9d8-736e267fd4c7;?=
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSZPR01MB6453:EE_|TYCPR01MB6608:EE_
x-ms-office365-filtering-correlation-id: ca55a4dc-f2b7-4e10-930a-08dc9a399065
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|38070700018|1580799027; 
x-microsoft-antispam-message-info: =?utf-8?B?RmRGT0RyOU5rMys1am5FWThyZWRwOGZRdUFFcUpxdVlaVUZtSllka2s3QU9z?=
 =?utf-8?B?NXJWSUd0d2d3Wi9tWlh2aTB3TzhVRENzZ1NwSTNQQVU0RCs1SVQvWjVCRkZB?=
 =?utf-8?B?Tkwzck5tOG1NeEp6UEF3dWpteVdSQUdCVmRGWWFFWEtvN3MwRlBFYmo5UzRJ?=
 =?utf-8?B?ZjM3U1plc2IwUk5ReTh5K3phaW5DRzd4RXcwUEE1c2ZzMWgrczFsdGRtMWhC?=
 =?utf-8?B?ZWR0U29sa3dBWEZSV3FxTXVsbDJTYkhkT1FOalNZYUJDUnZqcXJiRmVDTm11?=
 =?utf-8?B?Ym1JR1oxNXAxcVZvdEloanNlTDB2V1R0UmNMbFZNTkFMekpsWXV3bXNtVWQ5?=
 =?utf-8?B?am10aWlzZHc0TGxQdWVUUnBlM0c4aXovK0JiaDZRenNhOUxOZ1kzNmNSWUN4?=
 =?utf-8?B?YkN4N09EOUZ6ZldBVkJDTU9mN0c1RFp3Qms4V0dsNGhmSk9MVnUvUm0wYlZE?=
 =?utf-8?B?cXYzaGtUK005WWhMeGJvSkJYRmp4eUJ4R0p2TUI0YldkeWttQUMxb011aVp2?=
 =?utf-8?B?ajN1STJQQXlkVEpud3M4OXZCTTNLbXlRVWp3QUx3Z1VmanZjTzhoRERGMUM2?=
 =?utf-8?B?WVVYVlN5T0FYdHJRa1RndU9abGpaallRZ0t3cTNkL0JreEh4bFBJeERxUnNw?=
 =?utf-8?B?K3RkR0hEUFVKMi9qU2dwL1RqZ05rblZHeWFEbjlZN25sVmIwMWpDQ0psdncy?=
 =?utf-8?B?NkMwRmJNcmFLdlJvSFBGUmJmeFA5NE5QTkUrU1p4NFpkT3daZlgxdnpTT0Ix?=
 =?utf-8?B?c0RoU3loNFMxdUczMTdaUENzbHRLdnlTamhwSm5hV1hPQVFtaUtjTHJQY2xT?=
 =?utf-8?B?aGt5dDZsZ0tNeFNrdzB4RTlBRlloOWwrSDZkem9FU1RhTHdYUE95U0lxWldh?=
 =?utf-8?B?dDJiYk56eFdSMVdvM1JZbWRzOVhwNHV4Q21qYUNJODkwYkNVQjF5cFhwZG1S?=
 =?utf-8?B?L09LYWFkL3ZDOUljeXpRM3hGOTc1azZRYk5JQ2lmT3R3clJDUkV0WmNSS3Fr?=
 =?utf-8?B?dVQ5WnhMVi9Yd0I3ckU0amxmb1lrbHViWHhjZ1pKZS9PL1k3bjRpVUU3SHdv?=
 =?utf-8?B?ZjNvdWhSa0xGN21Pb3ltVzlaOGI2enNDQys4SWZnQWpseHBIVTk0YWFjODhR?=
 =?utf-8?B?d3p0T28vUjhoMzNXaE04aXpPWUpKcjZjNGlJVEZQR1hvQWUxc3NyL2JiMXJF?=
 =?utf-8?B?Sko0WlpUekpnaW1ESEV6M1NzQWk0VUxFbjJDaVR0RUYwYjJSU3A5ay9IUUhy?=
 =?utf-8?B?ZytuK0JsTWdINFJkOW1RNVpsSXVZRCt1NUFkcUh5emVKUFkrZDRVWlh4Ynow?=
 =?utf-8?B?eDl3UEJZZDJmVzJ4NGp6MndLMWRYVnNMWmxJaXFOazFpSjlUeWp3SU1KQ2NW?=
 =?utf-8?B?enZGdDUrQ2NuOGRqQ3NMaE84bGliY054a1VDK2FoRFppa09pKy9VS2RBWWtz?=
 =?utf-8?B?bU1CRi82N1J4c2tuaWhOWWU1NlpNYjJ3RTVLMWNHOE9hYm9jNCs2WkpNTDZ0?=
 =?utf-8?B?cWNaYU9XMnBSZCtvdGo4dTg5Uk5MQmtpeUtqclgvUzBqRzJPbHhKSzk5NlRl?=
 =?utf-8?B?bCtadU1XUmc4NUJkSHN6eTBvNzB1VXFERGlMMGZrb2RxRzk0TWkzS2tFcjZt?=
 =?utf-8?B?MDZOM1JzUVV5QmdIT2swSVgxWFd5R09WdzYvOTNYNEI2OGMzRUsvYTd4UEhL?=
 =?utf-8?B?bGt0d2MrWExwUG1iSXRDRlc5bFJkajlON25wY0syQWJ6dE1TM001ek9YeVg2?=
 =?utf-8?B?YTBkNlBZU3JVeC9XNnlNamtIOXNvMUFBZ3ZJeHBwcTlSWkR3MmpMeG5FZDlz?=
 =?utf-8?B?Q2IxVlFYZCtSWDlLdTZsbjZEZnlnZEFZRWZ5ZWxsbHlqb1pjZjdzMVBMOTY4?=
 =?utf-8?B?VEdld1ZGRHFCaFdtUnc5THZ0OGhqdGVqSlJ5VlViRzVad2MzRWlNN2lGWTdu?=
 =?utf-8?Q?4aQD+Y6Po4Y=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-cn; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:OSZPR01MB6453.jpnprd01.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(1800799024)(366016)(376014)(38070700018)(1580799027);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?U1RCN1R0UWFVaWtkY09lWFRWbzlMTm5QMXR2UDdjQzlzcnZUMXJ6ZTdwK1Jw?=
 =?utf-8?B?ZTRsbG5OS2ZqaWllRVFCWFJ0Q09NcWY5Z2lMVmpBbHlwaHZDZ3VNbk8vLzds?=
 =?utf-8?B?ZmJNUytkS3FjNytJZ3BNK2wxVkh4NFJ4VlhweVZEWDFaTVcvL0JXTVhYVUwx?=
 =?utf-8?B?bVpNVGJIc211MnJPdFFpMDlVUFR2eTV6RFRQRDNySGQzOHFsdndSRFpMQW5T?=
 =?utf-8?B?eHkzdDFiRFNrdVFqbERxN2l5aU1aZmJpLy9veUoyMGJiazNIem5UTEZkSDly?=
 =?utf-8?B?M1B1ay8zZlhFVFdvZG9QekpncUpCaUQxMTdPcXMwK2dqekk3UXc3OVdTT2ZS?=
 =?utf-8?B?QWg4dmNYTDlBcDBCaDR2TVFUYnBoTk1hbzV1eExnNU9CNGc2QXZRVHVGampF?=
 =?utf-8?B?cmh4UWVpODVpK2VaVytnQVJ1SlNQVHdZMDJPbE9vbDR6NG9RUHdjaU1pbXBr?=
 =?utf-8?B?T0FkL3I5ZnY5eXhYWmdEWEFYUlh3dVMvRENHNTBMMmJiS3pIcTJ3dzg2T2Vn?=
 =?utf-8?B?d1kwempPK201QWh1YXArQVVEakRYN2p4Qy82U2RGa1U4R2I2OXl5aTZCbUxy?=
 =?utf-8?B?RUExSmRIV0NVT0dtOHNDcEdQRTg2L29RUDR4aVlibC9pM1FubUx3N0E4cU94?=
 =?utf-8?B?QmduZ2NpTmM4QTdSaHRHbWR1M1pnNHAvV1U1RlJDSXZqK2ZZVjRQUW9BZ2Rt?=
 =?utf-8?B?TmhuZk83dlM2eHB4MkxnZHI1Z05UeXIxSjc4SUREekx0SVgza2hIS1dkM1l5?=
 =?utf-8?B?ZkJ6dGp0d0NiUVpJT2NKdWJzbUZRZzNodVJQNkxUbVpKaEJKRG9LQ05RY0VF?=
 =?utf-8?B?aTQvZ0gxcWdiSVJSdmw2Y09oYmc3bmhQZElSaWVaejRVeTVuZnZXRXR0a3dE?=
 =?utf-8?B?dzFPR1ZBdVJNbXh4QklLbXhwck5sSnRZY3ZVRUVuL3V3S1ZJUWdPVnUzbGdh?=
 =?utf-8?B?U29XcEhvYnh6MVo5d2daeDNmWHd6Y1E5M0JnQmhyNEtUUVVqQTJUdDIvTTNu?=
 =?utf-8?B?Tkw2Tm9DY2grbTIvalRDeTc1YmlCYW1JRXJDdGJvWW1VVlJhTlBUZUdzRXRi?=
 =?utf-8?B?dkxlMUtBTDhrWHg0d3hWZ2NSaXRyN3lHY3UzeTg1ampHemtDRXovTjVvd2lJ?=
 =?utf-8?B?bVlVcVlvTEorOWJMMHpKSFhVN2s4a1Z3R2hKRkd6MXBVVGRabVZGQVdGa2xn?=
 =?utf-8?B?NlVoZURRSE5uOXQ3UzBkU1ZjNFdmRFFTWFV0VkkrWHIrKzhyTzhvNlB2ZVNW?=
 =?utf-8?B?OUgxSEJveFAvWHlONExkYzdiZFNXTzVTS2tLRGFhUXRZWkxrVURXV2RFa3FZ?=
 =?utf-8?B?STBvR3pMVVFQMmM0bXEySHJzUnVsVEk0dGprZzFxY2FNNnNIZXYrejIxSTkv?=
 =?utf-8?B?YVM0QndmUWUzQllBd3JwWHh2NndjQjFtb3Y4Tmprdy8wYUx0WFN6elJBYmdP?=
 =?utf-8?B?eklaL1lPNUZpeXgweVNVbUhYakoybHYvbys4MkVYS3A1bkVZWGFwR1NneWk1?=
 =?utf-8?B?MzI4QnlwNWp4STd1bnRqRWNCNUhjTlFKVlphZFJBVlcxaXZuOHpxdWZpcmRK?=
 =?utf-8?B?cWtEOUNqY2E3U2pPb2d0SytvN3lxK0c0Mi9FdDE1cllMVFpPNkRLdloxWDdq?=
 =?utf-8?B?WldxZWhqTjl6a3hVRUgyckg4M0cxaGxNSDE2bndLTWxhbitRQyt4dGlVTThn?=
 =?utf-8?B?VGpoOWRVSmZjRmtVNUhZTTN0eEdacXduOXFibHNDVk1sOHE0cWgydnJreitC?=
 =?utf-8?B?ZkdIZk8vTlhZSzUrMHNmVTltMVF0ejhmRGpvdXRoeW9pK3J2cjN5RDYyWXB3?=
 =?utf-8?B?aEtpN3k5NXdycWV5ZlltSGEvWEtnUUtYVVg0OVNzZXl3KzlyRzZhamtDRWRw?=
 =?utf-8?B?WHFZeFZsMTAwZFhLd1kwWXE2Tk5TSXM4YzNhRlp1dk1TTWU5eEx6ZmIxcFk3?=
 =?utf-8?B?LzJXUHZjZHZ1eGZMYnpuZGJ0Tzd4dThLTDQzcFhDckFwK2NoYjNkNXBUTUt3?=
 =?utf-8?B?Vlh3WFNVSHJ1U0hsbW5MbmZTaFZFMHdNbWo4OGhBVUNNcVBReEM1d3JsazFO?=
 =?utf-8?B?cFh3SVNkQmh2WnpMSVgrL1BYTVZxWEtPaHh1dWk0SHE3bHRlMkpIMllzRlV3?=
 =?utf-8?Q?XZSroVFXI5NLNVbKotsl24CDl?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: AgsWDvRwPvtxjxWBU3FiJQOAheH0g9PCOW86BeUzWP47NV2kHnuf7tBTd745y/Fi0utt3dwbXSwL+1F1mqCgRVEK5tYGK2bjXYgBzBWYqzKegxFJiKJETgYTIZD4RyZTF9L0VCI1f3JhWOENIv+B6uHS0BIZ2nqTj/00KVsTKomQqsIxQSHUprY9hkRNnP2r6SZ6fuTEqPWkYNVT6oSvFraO6NYt2+qz3vb515tlHNAHFR+0XRegd0ipr8sKFAyvIjItXQSDNUCe6/QfjhgtZ2EVj0iTj7MDGfd4tFWIhhiNaeysvmeexv7iX3jYdTBZOS6B5Lur5broaxi1chm53/TvjasNO05NhOAv+EzVhBznCe7JbXfBq90vVNoKXVCa6gaPMfcyMxuaTxkiezMG15zoLkC7iMfjuEUPp6O0yttfhKRoQjaVQxLtZpaYFLnXE+j3RecnK8zVK4Jla9MaEE/sCzayt69EJ4/J4mfOagsgfwCQHSqsAV3+8UQ0aee3ssrNVOIoEYCWVh3zqjnnia/5AWM59Kf2tnLix4L8nYSLy4rB6pLt5O82FC573cKoh2TZjauVeJkGPeViON0Tcb0pK0fxkTjOB4/ORsuIwBxOk1+Nas5nyrIyHaVIqA7S
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSZPR01MB6453.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca55a4dc-f2b7-4e10-930a-08dc9a399065
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jul 2024 01:52:00.5698 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 17m4rtuGLIFjxJcbSSC+vAIx2biNA4AnWEMoVC7aY0PFMk6IDlg+43kxJMy+vSagFw5ZQ50oDAdSJsO85EfSeQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB6608
Received-SPF: pass client-ip=216.71.158.38;
 envelope-from=yaoxt.fnst@fujitsu.com; helo=esa18.fujitsucc.c3s2.iphmx.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-to:  "Xingtao Yao (Fujitsu)" <yaoxt.fnst@fujitsu.com>
From:  "Xingtao Yao (Fujitsu)" via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogcWVtdS1kZXZlbC1ib3Vu
Y2VzK3lhb3h0LmZuc3Q9ZnVqaXRzdS5jb21Abm9uZ251Lm9yZw0KPiA8cWVtdS1kZXZlbC1ib3Vu
Y2VzK3lhb3h0LmZuc3Q9ZnVqaXRzdS5jb21Abm9uZ251Lm9yZz4gT24gQmVoYWxmIE9mDQo+IFBp
ZXJyaWNrIEJvdXZpZXINCj4gU2VudDogVHVlc2RheSwgSnVseSAyLCAyMDI0IDk6MTAgQU0NCj4g
VG86IHFlbXUtZGV2ZWxAbm9uZ251Lm9yZw0KPiBDYzogRWR1YXJkbyBIYWJrb3N0IDxlZHVhcmRv
QGhhYmtvc3QubmV0PjsgQWxleCBCZW5uw6llDQo+IDxhbGV4LmJlbm5lZUBsaW5hcm8ub3JnPjsg
UGllcnJpY2sgQm91dmllciA8cGllcnJpY2suYm91dmllckBsaW5hcm8ub3JnPjsgUGFvbG8NCj4g
Qm9uemluaSA8cGJvbnppbmlAcmVkaGF0LmNvbT47IFBoaWxpcHBlIE1hdGhpZXUtRGF1ZMOpIDxw
aGlsbWRAbGluYXJvLm9yZz47DQo+IEFsZXhhbmRyZSBJb29zcyA8ZXJkbmF4ZUBjcmFucy5vcmc+
OyBSaWNoYXJkIEhlbmRlcnNvbg0KPiA8cmljaGFyZC5oZW5kZXJzb25AbGluYXJvLm9yZz47IE1h
aG1vdWQgTWFuZG91ciA8bWEubWFuZG91cnJAZ21haWwuY29tPg0KPiBTdWJqZWN0OiBbUEFUQ0gg
djMgMS83XSBwbHVnaW5zOiBmaXggbWVtIGNhbGxiYWNrIGFycmF5IHNpemUNCj4gDQo+IGRhdGEg
d2FzIGNvcnJlY3RseSBjb3BpZWQsIGJ1dCBzaXplIG9mIGFycmF5IHdhcyBub3Qgc2V0DQo+IChn
X2FycmF5X3NpemVkX25ldyBvbmx5IHJlc2VydmVzIG1lbW9yeSwgYnV0IGRvZXMgbm90IHNldCBz
aXplKS4NCj4gDQo+IEFzIGEgcmVzdWx0LCBjYWxsYmFja3Mgd2VyZSBub3QgY2FsbGVkIGZvciBj
b2RlIHBhdGggcmVseWluZyBvbg0KPiBwbHVnaW5fcmVnaXN0ZXJfdmNwdV9tZW1fY2IoKS4NCj4g
DQo+IEZvdW5kIHdoZW4gdHJ5aW5nIHRvIHRyaWdnZXIgbWVtIGFjY2VzcyBjYWxsYmFja3MgZm9y
IGF0b21pYw0KPiBpbnN0cnVjdGlvbnMuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBQaWVycmljayBC
b3V2aWVyIDxwaWVycmljay5ib3V2aWVyQGxpbmFyby5vcmc+DQo+IC0tLQ0KPiAgYWNjZWwvdGNn
L3BsdWdpbi1nZW4uYyB8IDMgKy0tDQo+ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyks
IDIgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvYWNjZWwvdGNnL3BsdWdpbi1nZW4u
YyBiL2FjY2VsL3RjZy9wbHVnaW4tZ2VuLmMNCj4gaW5kZXggYjZiYWUzMmI5OTcuLmVjODlhMDg1
YjQzIDEwMDY0NA0KPiAtLS0gYS9hY2NlbC90Y2cvcGx1Z2luLWdlbi5jDQo+ICsrKyBiL2FjY2Vs
L3RjZy9wbHVnaW4tZ2VuLmMNCj4gQEAgLTg1LDggKzg1LDcgQEAgc3RhdGljIHZvaWQgZ2VuX2Vu
YWJsZV9tZW1faGVscGVyKHN0cnVjdCBxZW11X3BsdWdpbl90Yg0KPiAqcHRiLA0KPiAgICAgIGxl
biA9IGluc24tPm1lbV9jYnMtPmxlbjsNCj4gICAgICBhcnIgPSBnX2FycmF5X3NpemVkX25ldyhm
YWxzZSwgZmFsc2UsDQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgc2l6ZW9mKHN0cnVj
dCBxZW11X3BsdWdpbl9keW5fY2IpLCBsZW4pOw0KPiAtICAgIG1lbWNweShhcnItPmRhdGEsIGlu
c24tPm1lbV9jYnMtPmRhdGEsDQo+IC0gICAgICAgICAgIGxlbiAqIHNpemVvZihzdHJ1Y3QgcWVt
dV9wbHVnaW5fZHluX2NiKSk7DQo+ICsgICAgZ19hcnJheV9hcHBlbmRfdmFscyhhcnIsIGluc24t
Pm1lbV9jYnMtPmRhdGEsIGxlbik7DQo+ICAgICAgcWVtdV9wbHVnaW5fYWRkX2R5bl9jYl9hcnIo
YXJyKTsNCj4gDQo+ICAgICAgdGNnX2dlbl9zdF9wdHIodGNnX2NvbnN0YW50X3B0cigoaW50cHRy
X3QpYXJyKSwgdGNnX2VudiwNCj4gLS0NCj4gMi4zOS4yDQo+IA0KDQpSZXZpZXdlZC1ieTogWGlu
Z3RhbyBZYW8gPHlhb3h0LmZuc3RAZnVqaXRzdS5jb20+DQoNCg==

