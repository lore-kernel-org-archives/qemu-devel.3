Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 781BAC982F1
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2026 05:40:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x8tEX-0000lH-C1; Tue, 22 Sep 2026 01:40:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=718ae7c5e=Alistair.Francis@wdc.com>)
 id 1x8tEL-0000kI-1b; Tue, 22 Sep 2026 01:39:49 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=718ae7c5e=Alistair.Francis@wdc.com>)
 id 1x8tEI-0008AJ-2f; Tue, 22 Sep 2026 01:39:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1790055585; x=1821591585;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=Auhwij/xfp/+44jfEnULl6y0jz7+sTsomrodux88MNA=;
 b=rzoiGAbMkY/INYcRQDq69R/F/2kU8oHvxpMCwQgLA86F9GjGT4S8iq8V
 zExTejxWTNSaYyQdGoVYzeaPWQ/2ZPezKOROPas9OhD6RSu90k4PAZjIZ
 roMkT1jDY5rqh02jOhrR3EcIowoj6SLPT/HYxc3BBIFTQp7zi8h062bqO
 +qnLDvBP6lnhtbxuxTchjOP9dsJ+wUMFzsDaFllIh3Fhkbg1Pb/LM03e3
 3xPM2iAMM5/bjJUn577BBzeyURPyDXuGRl97djV8D4jCDln6EurqBfZkz
 5VDB94+iHem1Hm+Ql8Gr6AMkODjzeYAduqwIhKckBLyNcAOMPgpk5+IaA Q==;
X-CSE-ConnectionGUID: x15Fy0M2T/Omrlu1Ylw6Zg==
X-CSE-MsgGUID: 1phSKLHcRsyTluqd/p17yw==
X-IronPort-AV: E=Sophos;i="6.27,115,1786982400"; d="scan'208";a="155283281"
Received: from mail-westus3azon11010044.outbound.protection.outlook.com (HELO
 PH7PR06CU001.outbound.protection.outlook.com) ([52.101.201.44])
 by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 22 Sep 2026 13:39:42 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OJM3wf4WpBtHPAEZvHSGDGA8lv/1l0L2qOflD6a6i5p0lXWvvOy3zLjRtIdz+Cs8cuoXWqZGFearNnTV1H0wzJMy8Cgl4kj1cSdvagvm7T91reXusyaXDKUy93M2V1iSUt+DnbwCrSITVhyuzVANrkjBqHlBlB2xv15pC4bPBlIWFl2K/sH6/DwsWsSj4huM1/LQn9rVg9WIsTbdCPnhSw7f9N7vXFDn4e8BW9jkZfPDRm3YoofFkcVu/rdoImO68jU80tpSVC/MoxzSP71oOCLgkFS3yrwKpwxrwNGUHLguFxgnTbwYTQFV0gOfzvdErDZsYbZIke7kB04AKOylnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Auhwij/xfp/+44jfEnULl6y0jz7+sTsomrodux88MNA=;
 b=eQ4D1Xb7iUKzFwkvBOxr+NKd9SeGZ2B+JfJBARpl++7XUYKZC0Hr5V+zPNO3N0YOPLTGPCJYJXsTu6Pfw196ngPWSwR74jtDY5BaTzM6cqaZpjWzkaXpGS6fdMRiwwMQo0bOju0cf16wkSMiphPfsoAHSygs47TMn8eIs2fPRCw+RoCVQv+NZx7h7Fivf1UULovZoB7/VcFl5y9ENmjqyCEGdCLkDJlcxmiEny3TO9+JK2pqpDdyr+GKOsarr9w5cj/q+5EJZJW/aqP2ei53AVaaQp95mgBVukAsUg4ALD1HttxKXkak9poT0MuNDv30mVVbcExfauH5mDPqs1moIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Auhwij/xfp/+44jfEnULl6y0jz7+sTsomrodux88MNA=;
 b=fmtxMrnE2QuOjcw6kC0kpPKhHjHVMkSFVJMncBl2mVptC8P6FliK+++76L/E7qm/OEXblA8Ml8bvcAjbbCdyvDIpelnrOEfEOsFVULUfYeYDbnRkBzCSa7yckFZgZPMlWgLK8n9qaJUFBZaDMyvDW/Fdk89gLPa8fz9/ly9sT5c=
Received: from BY1PR04MB9561.namprd04.prod.outlook.com (2603:10b6:a03:5b6::11)
 by DS0PR04MB9318.namprd04.prod.outlook.com (2603:10b6:8:1ff::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.14; Tue, 22 Sep
 2026 05:39:38 +0000
Received: from BY1PR04MB9561.namprd04.prod.outlook.com
 ([fe80::3869:e494:2fa8:9888]) by BY1PR04MB9561.namprd04.prod.outlook.com
 ([fe80::3869:e494:2fa8:9888%6]) with mapi id 15.21.0428.015; Tue, 22 Sep 2026
 05:39:37 +0000
From: Alistair Francis <Alistair.Francis@wdc.com>
To: "alex.bennee@linaro.org" <alex.bennee@linaro.org>,
 "daniel.barboza@oss.qualcomm.com" <daniel.barboza@oss.qualcomm.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>, "joel@jms.id.au"
 <joel@jms.id.au>
CC: "npiggin@gmail.com" <npiggin@gmail.com>, "mpe@kernel.org"
 <mpe@kernel.org>, "portias@oss.tenstorrent.com"
 <portias@oss.tenstorrent.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "chao.liu@processmission.com" <chao.liu@processmission.com>,
 "asrinivasan@oss.tenstorrent.com" <asrinivasan@oss.tenstorrent.com>,
 "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>,
 "zhiwei_liu@linux.alibaba.com" <zhiwei_liu@linux.alibaba.com>,
 "liwei1518@gmail.com" <liwei1518@gmail.com>
Subject: Re: [PATCH 08/12] tests/tcg/aarch64: Don't leak memory-sve CFLAGS
Thread-Topic: [PATCH 08/12] tests/tcg/aarch64: Don't leak memory-sve CFLAGS
Thread-Index: AQHdNeJ4p2E9/GM4FEu/vUOykmE+x7baPbwA
Date: Tue, 22 Sep 2026 05:39:37 +0000
Message-ID: <2dbbffe16851e7ab4e511f904267674f430efd9e.camel@wdc.com>
References: <20260827050953.67184-1-joel@jms.id.au>
 <20260827050953.67184-9-joel@jms.id.au>
In-Reply-To: <20260827050953.67184-9-joel@jms.id.au>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.60.2 (by Flathub.org) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY1PR04MB9561:EE_|DS0PR04MB9318:EE_
x-ms-office365-filtering-correlation-id: 1c7e3632-9b06-4d69-e622-08df186be436
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|7416014|23010399003|10070799003|19092799006|366016|1800799024|38070700021|4143699003|56012099006|11063799006|10067099003|22082099003|18002099003|3023799007;
x-microsoft-antispam-message-info: Q2ZI8JRRea+Pje5qxQOIAAdV20aV5yCaL/+myHmdnEn3EPAJAXMY6ZEkTl+nbvGizbPrI8wE6I/8Yr4dMKAcDVSFghnxkI3SjGOWwKmNwagSJj/89Hsuy8yWM9d2KV+o931tpzH9o1yCLltnSWRmcd1W3Z1kPnvImicG0t8UndfwF+bbDQqYJkpC7F9+UqLTJjYJpZLBUKGv/xV6kS4S8JUDTsRLE9L5fNe9IFi4QMTgYtcAnmDg405nFVt/rePmjR2HTVi2nW9yqNhp1J+Q1bJDjClbcxHpkh0F375gmyJL1O9SE1IQXX4h5NNLKMHvtMgJB+aDcDtYiAULRf1lu8quFK3ixYn7V8QTYJNkFLsNhobXtyBJrG+HMRElI1wRRZNsN2fTSL011h248sOQQxUZAcj4ZaGx6jm/nFncLs/UNZi+WjE3aXIAzFutmi0ZJG65TaseK6zZoiTwbiAkayPOpZIGb9UEzYp03aguIYTrXKVXD0TWcJWFDNwJR92087YEkJ4kSv0Qbbl2JuGpvSbzaCBX5fUCtb0Xojv7opTQkc1cop6ArAjqmG5Mvx8XxHBdqA38KlPVlBOoGNpEkb63NneqqhaaqNoSZefeOzvOuww8wVxgXOZWx8AiDAMZdiMQTrhxCr4L1g24IXje2SLANd4oZKzbRfzmnMMo5bu1FbzHotEMgBzwOzXHEJzY/Vwy8aUV8UaJaSIzz6Pg77FJrSF01gVmH6zc2hWrVzo=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY1PR04MB9561.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(23010399003)(10070799003)(19092799006)(366016)(1800799024)(38070700021)(4143699003)(56012099006)(11063799006)(10067099003)(22082099003)(18002099003)(3023799007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?L01TMWUySy8yRFdlOVkzWHJxcXYzWnhsMTNNRGpXdnJVMTdhcHVzVVUxYlZ0?=
 =?utf-8?B?TmlqNWxQVm5KQkEwKzRxMW5RM3I1bGV5RDFOSnpZUXBqZDFsV25VSm05WDNr?=
 =?utf-8?B?Z3FseE8zV05KQjcrL2J5UExhOUdzWVB6NkEyS3p5NHMyWTVmWW1XZVl3bVV4?=
 =?utf-8?B?U3R0VWh2WnRtN1ViWjNXRzgvdDdKeWdKeVVwRWJ0QWc0RkdlU3ZMVSswdjY1?=
 =?utf-8?B?WS9POEVBajFqRzJ1R0phYjgzOTc1Q0dPaSt1emlhSzR6T2xzMENHWnNXcUV5?=
 =?utf-8?B?bG1YejhrK2cyVGxPakRvc1FXTjUzWkozKzVSUmZNeUF5UHUxbjR6eldGOVNp?=
 =?utf-8?B?eHpKN3R6Zm90VExoVXpWZVAvaDVnNlN0UFhSTy9WUVdxbHVXTStvdTBFdVhF?=
 =?utf-8?B?VHdPYTllc0p4cWVodlRYb2pPSFFYaUV2cGY3ZHk5YnR5QkRURTh1UlJYTVpP?=
 =?utf-8?B?VU5uTGdMSGw3YThEazBaRTlQUzF6NFRwNndPOEpsNVRTVkRXTTZQS25KUXFm?=
 =?utf-8?B?R0FNNElibmdCQ0kzb3ZFcDlqR0FrblJ3K0wvNUxtWGhBL25seVNvRTBPTTJQ?=
 =?utf-8?B?bC9GaWZMc1lBOGdSSnJheUJ6N25ucDJKYlJ3bStJbnZyM1pNVktwcWtjQTlR?=
 =?utf-8?B?N3hpUU1aMSs1T2VjY1RVWkZMa2JUdU9YNmRGbkpZUGZZL0MrZnNxZEJveUo3?=
 =?utf-8?B?N2haL2t4ZjlKQW9ONGhKZlN1d0YzODY0N2Z2MWNEVkQwdi9YTVJBdE1uTHpq?=
 =?utf-8?B?b0xlUkl2RlR2VUVIbEcwWnBucks4TFZsVXlqblFja0ZRWjV4U1JTdmhobTVz?=
 =?utf-8?B?VG5Va0dvRkpSUG5WZlMvVWF4RG13RCtWSTFsTU5QSXdZVjgyNDFxRHRNbVdE?=
 =?utf-8?B?QkZjYXA4M0o2MGNXZmh3UmV6VlROMjdwWFFYSFNDTnQ1QkJWQW4wMVRwcmwr?=
 =?utf-8?B?THlrNnErSzYwSXd6SUh0R0c3VVU3NEVWT25aT2VXZEdXSGtMV3EyNWRVdmEr?=
 =?utf-8?B?c0Uzek5GdExUL1hSS0wrOGhVejMxWGNIQW5VbFlKWDJQem82SUNaNTNrWHBS?=
 =?utf-8?B?Mnh3ckdBeGc5ZWJPRzRReUtvaEczZldQa2VaSVZJM3p5MXVyMDhRNkdEcE5H?=
 =?utf-8?B?cThRNU0xZUdqY3hKdTd1M1lHamNUWkdtZFJ0bVNaemFONHlkTDhvNVJhR1VG?=
 =?utf-8?B?d25xdVp2b0N0NU1FRmFyWDZRTlpMS3BGdzFOUnNiMGxJZXEzR3ovL3VmUHk3?=
 =?utf-8?B?c0xJQ3VDVDA5Rmd6SURNYWp5SHp2VnEvQ0c4K0kwNDNkb3AwQmVReDFqWVdi?=
 =?utf-8?B?dlM5Uy9xUVhpZFl3bjJCbFBqc0o0Nkh0NFFmTWhUT1ZNaEdoVHdRbWdSR3No?=
 =?utf-8?B?ZkU3ZXMyOXlYYWhlMk4vcHA2TTBiRjZpVHlCQ0Y1dnFQYVdQNm5SSzF6S3hk?=
 =?utf-8?B?M0twUm9wYStJbXU3c29xRytqb1ZGMmRoMzdnemxvNHNCME9icjVHVlN2cU1W?=
 =?utf-8?B?bndZYzNOa3JkbTkyOUl0TjM2a2NabWNrb1M2SnFuOVc3Wnlwb2FTazVHRTNl?=
 =?utf-8?B?TlUrVHFtUkpWcmJWMDh1SVJVUjREc29jU3c3NjRZZ3VrZVovcXRqMDIxVVdF?=
 =?utf-8?B?QVRSLzJnOXh6MnZHb3N5QTVyS0hyREUwYTV3TWFHbVRZcE9DbE9zd1lybVVO?=
 =?utf-8?B?V1ZhbDlXUHE1eWZmSDV0WFZCRnFlNWpkUUdaODVBYlpqWTR5V1hEb3Zsa1Fr?=
 =?utf-8?B?NVpmcW9pZ0pLWDRObDZpZklIUiswUjIvaXVKQm5sTUZZMGwwaE04SUlkWGhC?=
 =?utf-8?B?cnF2R1UwL3NlN0hJL0QxZ0RoR1VWcGc1U2R2ZU51Y2tUZURWZVVCY1pzSUlz?=
 =?utf-8?B?Z3ZYNnJkdXd6ck1UTjRQaUFkN2hMdXNDcXpORU1tMUoyUmMxT04rR2tQZXFO?=
 =?utf-8?B?aVI0bFEyc1hGTkVWeGJPdUJFai84cFU2N3htTjFCMjhiek1FRUdrSWZsa2Jp?=
 =?utf-8?B?T1VKYXZOL3lMTWtKRElsUUsvUGNBdTc1a01BVituQlkwUUQ0ZTMzNi8xdHVR?=
 =?utf-8?B?SVNnakZuSW1td25xU0ZFbHkvQldsMXNzT0RMWmRqSGFFTjFDcTZrU29oQTZl?=
 =?utf-8?B?Y3pHeVpQQXNWTzZ2eHdpQXN1cXJvc2o2ZzBPYzB5UUx4a296U1VENTllQWxN?=
 =?utf-8?B?YlcyOG1LSFJhVm42SG9BcUhaNHhCTm1RenRDdzFIY3NGeC9wOXBBQ0JvQm0z?=
 =?utf-8?B?UHpPMHBiT0hmdTlya2pPVTRvS3ZmeUtOSUowOFZJS1hxdFlnNnk4UkhOaElX?=
 =?utf-8?B?Z1FoazhLRCtZZ0t4M1V6elhLQytoMVhnK210dnZTYmtMeHBteXdRNlUyZWda?=
 =?utf-8?Q?h750w0++X9XlG3lkxMbQkRBCgk5slEOOfOOsVGwptWP2h?=
x-ms-exchange-antispam-messagedata-1: 8Zvnvgh323z/Lazbixb3aZ0z9q3SRluK0AM=
Content-Type: text/plain; charset="utf-8"
Content-ID: <79C30DF362A7974C8AFD7EB9358803AB@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: YYtiEe74ZEkZWLXagaaVOALidhjBigs1m8a0oL3oC5Dp/ustEylHjO9GqP7harAHCvnVEnnUQMfYJ7Wip3rqzokK/KTcvPuO3n2Y8BqNwFyKnMuvaz0Shoi8Vt/cSOdOCpS6wEPBPWF+XEcSkrmXctyHq6eVLn47BhXXoKGTFVKjMMMyNCovQvJdR5CaHyk85x3p2Nse1VWdhsaeTLhsGW5ehAA78VKeqAYs6gzMReAlpBpkF4xl/2WTVS/f1McX+78FzLhMcMFUb5fBrAhzxkz1Pl0txPsmy1rUM9WsRAKqdAfCjIKeBP4WuhY4ogr58BRWZtYli8Ksv5g8EhjVJw==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: swi6TEaqFbz3Jn+Kp/mLnuWhiwomlH5WcMY7o8OAQhaZNoUIkX/Xxm1szIVZkbFS/Bo6z+RQcZUU0oB+yZSO4uNfqHd4w6y8YdVOoPloDVsRz2MMmf7xkIMwPDeBeBMUs5ijA6ebJrx1DhmXBS0G8h1RMCyj7qpC2lzPyoYRdVhBzDU4AHz8cxrnwvWaDir9cuB3bV5Cep9wChtnL0hoc9C0GJxZPihc5s92tPgYdPD7rDrkbBoCb9rSu3ym9F1EH2kWDrcgXiRaPgjTmt7YRmhZ9RLHHxZ0VxYE2EODz54mQQskpcQJgijL4/xwJTSbf51NfsKYPyCVhPiKGYXQ0PIj0aMFfPqKX5dY3YCUDF0YDzcBzPiCF767BQqKZDmUczmPCdNIT2N/3Aw2cmV6qcKml6XCi8PMblSC997Ge4q9DsJqcliwin9MU0xoeXJPFZZG7aXnvqOwWH80AtlI5UNhQEJUXA95AkcMcNTNJKGU5TGa7R5dyRBkfLGXr/TJFYXKXFVDECC5SHV0rjouEu2nM6hmi//fowzpzQLXseZFgpmaCdgOedbo8BexxMPH7eY+zKnlWfXQseARxgHVC/b1jvJVtlDiTxuZYBAKb860p1be1I7IWVCdPFIhYNkD
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY1PR04MB9561.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c7e3632-9b06-4d69-e622-08df186be436
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Sep 2026 05:39:37.8748 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8WLui/yZQzEB55a+VelNYzJR8nJ3OSHb87UXCqr00ehQCJDMXO2johEBqpfO0fFJK4Nh+AnbA65yfCYA7oPkk/3pSBzaTDqAXjZgwQmjhPk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR04MB9318
Received-SPF: pass client-ip=216.71.153.144;
 envelope-from=prvs=718ae7c5e=Alistair.Francis@wdc.com;
 helo=esa5.hgst.iphmx.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

T24gVGh1LCAyMDI2LTA4LTI3IGF0IDE0OjM5ICswOTMwLCBKb2VsIFN0YW5sZXkgd3JvdGU6DQo+
IFRoZSBDRkxBR1MgYXJlIGFkZGVkIHRvIHByZXJlcXVpc2l0ZXMsIHNvIGlmIG1lbW9yeS1zdmUg
Y2F1c2VzIGENCj4gYnVpbGQNCj4gb2YgcHJpbnRmLm8gYW5kIGJvb3QubywgdGhleSB3aWxsIGJl
IGNvbXBpbGVkIHdpdGggLW1hcmNoPWFybXY4LjEtDQo+IGErc3ZlDQo+IC1PMywgYW5kIHRoZSBl
eGVjdXRhYmxlcyB0aGF0IGxpbmsgcHJpbnRmLm8gYW5kIGJvb3QubyBhZnRlciB0aGF0DQo+IHdp
bGwNCj4gYWxzbyBnZXQgU1ZFIGluc3RydWN0aW9ucy4NCj4gDQo+IGh0dHBzOi8vd3d3LmdudS5v
cmcvc29mdHdhcmUvbWFrZS9tYW51YWwvaHRtbF9ub2RlL1N1cHByZXNzaW5nLUluaGVyaXRhbmNl
Lmh0bWwNCj4gDQo+IEJ5IG1hcmtpbmcgdGhlIHJ1bGUgJ3ByaXZhdGUnIHByaW50Zi5vIGFuZCBi
b290Lm8gd29uJ3QgYmUgYnVpbHQgd2l0aA0KPiBTVkUsIHdoaWNoIGF2b2lkcyBTVkUgZm9yIG90
aGVyIGJpbmFyaWVzLCBhbmQgaXMgb2theSBmb3IgdGhlIG1lbW9yeS0NCj4gc3ZlDQo+IGNhc2Uu
DQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBKb2VsIFN0YW5sZXkgPGpvZWxAam1zLmlkLmF1Pg0KDQpB
Y2tlZC1ieTogQWxpc3RhaXIgRnJhbmNpcyA8YWxpc3RhaXIuZnJhbmNpc0B3ZGMuY29tPg0KDQpB
bGlzdGFpcg0KDQo+IC0tLQ0KPiDCoHRlc3RzL3RjZy9hYXJjaDY0L01ha2VmaWxlLnNvZnRtbXUt
dGFyZ2V0IHwgMiArLQ0KPiDCoDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxl
dGlvbigtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL3Rlc3RzL3RjZy9hYXJjaDY0L01ha2VmaWxlLnNv
ZnRtbXUtdGFyZ2V0DQo+IGIvdGVzdHMvdGNnL2FhcmNoNjQvTWFrZWZpbGUuc29mdG1tdS10YXJn
ZXQNCj4gaW5kZXggM2YzMGJlNmM1ZDYzLi4xOTZhMmFmYTUwZWUgMTAwNjQ0DQo+IC0tLSBhL3Rl
c3RzL3RjZy9hYXJjaDY0L01ha2VmaWxlLnNvZnRtbXUtdGFyZ2V0DQo+ICsrKyBiL3Rlc3RzL3Rj
Zy9hYXJjaDY0L01ha2VmaWxlLnNvZnRtbXUtdGFyZ2V0DQo+IEBAIC01MSw3ICs1MSw3IEBAIG1l
bW9yeTogQ0ZMQUdTKz0tRENIRUNLX1VOQUxJR05FRD0xDQo+IMKgbWVtb3J5LXN2ZTogbWVtb3J5
LmMgJChMSU5LX1NDUklQVCkgJChDUlRfT0JKUykgJChNSU5JTElCX09CSlMpDQo+IMKgCSQoQ0Mp
ICQoQ0ZMQUdTKSAkKEVYVFJBX0NGTEFHUykgJDwgLW8gJEAgJChMREZMQUdTKSBib290Lm8NCj4g
wqANCj4gLW1lbW9yeS1zdmU6IENGTEFHUys9LURDSEVDS19VTkFMSUdORUQ9MSAtbWFyY2g9YXJt
djguMS1hK3N2ZSAtTzMNCj4gK21lbW9yeS1zdmU6IHByaXZhdGUgQ0ZMQUdTKz0tRENIRUNLX1VO
QUxJR05FRD0xIC1tYXJjaD1hcm12OC4xLWErc3ZlDQo+IC1PMw0KPiDCoA0KPiDCoGdwYy10ZXN0
OiBncGMtdGVzdC5jICQoTElOS19TQ1JJUFQpIHZlY3Rvcl9sb2dfYm9vdC5vDQo+ICQoTUlOSUxJ
Ql9PQkpTKQ0KPiDCoAkkKENDKSAkKENGTEFHUykgJChFWFRSQV9DRkxBR1MpICQ8IC1vICRAICQo
TERGTEFHUykNCj4gdmVjdG9yX2xvZ19ib290Lm8NCg==

