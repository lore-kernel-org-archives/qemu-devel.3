Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 251A9EA3F2E
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Feb 2026 09:12:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpjlq-0001L8-1G; Tue, 10 Feb 2026 04:10:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vpjlg-0001B7-HM; Tue, 10 Feb 2026 04:10:49 -0500
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vpjle-0004jF-S1; Tue, 10 Feb 2026 04:10:48 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=whCWFAEbVBbpZGJ36YU1XhqKPHzwXbPKsb+O1vEpE2xFN/JhAS+9yyAPQCepRxj8S3QQpaPZEIuXGpph8FyS0CX0P2n+671G2BrChcBLQomRvMzpRLvcKXQXNPIPLsFo/dfYIeVeg7eBmJboNAJknHBSSNVjR2xqCXVd2VcSqkadUV3V3o/bQOOXetu6tjDRP1sdRqwo7VkhORAJWqG+5FH09mDGoaFadubHjOeybDTIcSyg/yyiNwodasku15bH3N3SrYlhfGP+rKtykwa34OOSbTxg8Lzu0vetynfXPAPtosbwTAarZQxhS5Nfgpea17dD5KUBJdaqun4/9+Zk3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4slh2/7DVLiijt1mqgRjyW7jmJblU3Fxmk6kklj0BfU=;
 b=ckJ8egrVOixTG2XVnEmbwC4HbogjlXMMBUjFX54f8HUAQrBVwB25CU0DnAYzf6kHS2ri07Ql4scTC+1e3qjiJG4jzKHC/vowOGFc3ovsHkThJuJQA+27D4lzCE0Ii8wgqEyqqBmz8qHMszeugvPgEsVj0hw40as/PfVzRazdczwWL0E+RBHz/k2srAkYMdoy7W1iQJh64e+l6XDhV5hfUEdV6/Tk14wlW3tg1S/fcXEmtHka70p06SgrYpItEYkftFBoB8xuJV5VEFxTM735b4B0OpXvFjitz0CI312vAsUQ3VCJOXLwol5FSMMa3KCeIsOGO3/bckiIu91ifNUabQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4slh2/7DVLiijt1mqgRjyW7jmJblU3Fxmk6kklj0BfU=;
 b=Be+1Qr8aHsYjgmjkr8kfMneYmT5TGoOZpEhttEGBq3Z6oNlcmMp9uzMUNFVSq/N/1p/pUdAbxrMVoIzh215kunF1JwjJAZYLv48PMejH9lhDy6ZGVvtlGb6wLsEBFquTrtKVlTjK8EGeuZb6NWp9z1dLfmFK+53NPF7P4JI69UAlrsHiz1ptJ2G+pWCBAD6UTplsZi3BreLQ590lCFGfHOhOpfj1loBHQI5GurtI/+r2U64SftuFvm2Ouw1eAKy2D1GIqNuU2c5meBxC3xvuvyyKI6MZq6jDr0Y8/onIidRK2vQMZc97yECtTAMbCUms6xdk+Z2KWHu9ek6sflKg9w==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by KUZPR06MB8268.apcprd06.prod.outlook.com (2603:1096:d10:62::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.19; Tue, 10 Feb
 2026 09:10:28 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%3]) with mapi id 15.20.9587.017; Tue, 10 Feb 2026
 09:10:28 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, =?iso-8859-1?Q?C=E9dric_Le_Goater?=
 <clg@kaod.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, Joel
 Stanley <joel@jms.id.au>, =?iso-8859-1?Q?Marc-Andr=E9_Lureau?=
 <marcandre.lureau@redhat.com>, =?iso-8859-1?Q?Daniel_P=2E_Berrang=E9?=
 <berrange@redhat.com>, =?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?=
 <philmd@linaro.org>, "open list:All patches CC here" <qemu-devel@nongnu.org>, 
 "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>, 
 Kane Chen <kane_chen@aspeedtech.com>, "nabihestefan@google.com"
 <nabihestefan@google.com>, Joe Komlodi <komlodi@google.com>, Patrick Venture
 <venture@google.com>
Subject: [PATCH v5 06/21] hw/i3c/aspeed_i3c: Add more register fields
Thread-Topic: [PATCH v5 06/21] hw/i3c/aspeed_i3c: Add more register fields
Thread-Index: AQHcmm0ZEeY1VIXG20SvhzACsNeqfg==
Date: Tue, 10 Feb 2026 09:10:28 +0000
Message-ID: <20260210091018.1553489-7-jamin_lin@aspeedtech.com>
References: <20260210091018.1553489-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260210091018.1553489-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|KUZPR06MB8268:EE_
x-ms-office365-filtering-correlation-id: 4e4fbf4a-6813-4470-c470-08de68843c22
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|7416014|376014|1800799024|38070700021|921020; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?yX+76YE9mqzHnXary3mcVRB5rs9NJwlUdqWa6Ey+zBn12ko1zZUoxH9tNC?=
 =?iso-8859-1?Q?DMJPpbs6YhHbR3J3vcqRv2qJZyYxU/KvZm7CoHt+gEFmSOQzjRn+pR/dwG?=
 =?iso-8859-1?Q?K5Seb0RMY5yWDTcIc8O2gUh2RvSPm9K+++ZorazcEV/ZxhL2FHwyfjcJmp?=
 =?iso-8859-1?Q?43CgZpD2FnDzsOC9pWgBCWrlOkvUtKOB6dgt0SjoVAaBed7VZWCvyoHye4?=
 =?iso-8859-1?Q?8KVZRXM1NFwZedxCtR0UzbVRmFQMq8SpAnEWHhI0/s8BRdcobWCmeIsomv?=
 =?iso-8859-1?Q?u40tuoRL2YJAxKOZIsxYedpHz2ffyecY31KypXEFr77pzz60vbUtNxAZxK?=
 =?iso-8859-1?Q?YqBpAqlzA+c97ZOZRHWc4IprAQuWHWvDJodW/Q+WuR8ic3yvbcIH+Q9Y39?=
 =?iso-8859-1?Q?1VAaJa0rXW5hjm3Fp15QE2H19zhdEjnSOVsiI7NT4SIZv+yEex0sLhrCqz?=
 =?iso-8859-1?Q?JoeZng4oAob0DEDBTjfcxoeOlPud3cYAE8dm9Dpp7kAoXRMsAx1FzlFo9S?=
 =?iso-8859-1?Q?6MZMy4/q5/wG8UKVzf8s1drsCLHEHthmAmwMsHsUIiUX9J+2KWny01vr0L?=
 =?iso-8859-1?Q?RLWhZz2evtDoW+uFI/AQai1My0jwTf9kqMaBu/ZsVNXqj4Nsto0cz62bh6?=
 =?iso-8859-1?Q?BZWmEUivXhLiPbS1TSoaXIGtc24+3eHBRJFzkgdudE2OG5PXVXgq2mpYqW?=
 =?iso-8859-1?Q?AYE8F0BhoFg4RArHGhSST4kBPTXwMCORxrH7Mf8ekmU7ijzDyxWXWO6Ls8?=
 =?iso-8859-1?Q?7eXxjGeUGBttmwrLTdAcLPIXbQNpRv3abeRFHpMccYlTjj3RgukXg/Newz?=
 =?iso-8859-1?Q?BZZCfDMzvWl8j2Perqi/o5DRLCPEfMUeoAcxnfL0P+d/r+s3/1kB0i27vH?=
 =?iso-8859-1?Q?YUp42QPgBByz/v56TTJSnwYop+n9N2Nyb3wVErUDOesFu+cLEKMhYEQh66?=
 =?iso-8859-1?Q?JKXQyKWl0I9AfmTLey0TK2Cnd24Cd6+tFZtFwEpLIe9SwLXEIwxjmFbD+p?=
 =?iso-8859-1?Q?CEPVhBnKgEXM/6sbosLd9ED0EMpAaGm6F+96dd+qalkdoBIolbX01i0h5A?=
 =?iso-8859-1?Q?eijaiOHHStD3ocfsoHcYLPsJOqc22rDX4awGAOsELZwZ2gTwlgD/77oqPO?=
 =?iso-8859-1?Q?ae0aJeXWMOQiGT8SMk4qriDveR8mUhkHS722Hu3I7xXN6IoZkrCuPmxH5m?=
 =?iso-8859-1?Q?P3gwGvHHNwojWrcDgmRPg5gge4oPFkf4rN516Sg+bRO6rwaVXPcbM04nM7?=
 =?iso-8859-1?Q?HTjRT7ndzpceT6x6xITKV1YYTwuK45t/mFscY0crELcYUGAb1jLD8AKSGY?=
 =?iso-8859-1?Q?NH5NTlAh3Hk+ilLvmaK2+y9efRxb0a3PzskcXBZL5EPC/WRGHSGVNu4izc?=
 =?iso-8859-1?Q?lMfHLDB1Kn+6XFD5McBaFUHLb5lCD763S60VV/iKqOHHecoy8auRhwy5vH?=
 =?iso-8859-1?Q?HIVdQ87C4Z6Gtx2E3jZkJUGuiWASaN3TCxUHEXyXSUTOaZPOIWFQv5awG+?=
 =?iso-8859-1?Q?QTfkQ3EQAtEKwA6C9UXicgaBY1ta63te+iqBOaTDwziRQiimdROe8EBj2H?=
 =?iso-8859-1?Q?OiDNtBryymhsHmczJaNOvcMzirS672mPOnvFeaGS1DRewKhx9+H6ryDCve?=
 =?iso-8859-1?Q?CcyfPUFMRvA4QMEMNMTQD/GeXtLwp3bC/XezI2vexB6CjNwemiDKHY/HeS?=
 =?iso-8859-1?Q?j21HiL8CxXcFijAZ9xtaLc2/WaYDhFXCloM4mLIv?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(376014)(1800799024)(38070700021)(921020);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?t5IMq1ji72wm5MNLnPNMrQBb0BkcF4CXLNMLIXSwybZMZv9eieBsXx2Ta0?=
 =?iso-8859-1?Q?esR8ATCOUE6OD8FT9Q2F4WwbLEyzlMHxN7aOsH+QAlksxhGPscjq8nVnI5?=
 =?iso-8859-1?Q?W7GMeLZvW06JqW8Qkg90SWXGC7Rku+355asEYPF0lUjIQnzFBxQUDuDPNM?=
 =?iso-8859-1?Q?ZBeS2XeDavOYJTYP5aQCWDb7/WVpgFhPl8bTpfBg+ULhIP4CnIRQpvzyrT?=
 =?iso-8859-1?Q?7wmDbj3KPHvYdtK76APRmIQTpJOHLDdl76zDLNDmxzKZZIfl0LsE3ZL64u?=
 =?iso-8859-1?Q?6700ILrdQAHohbij8eTzfP8JF17e5pLlCumc+hqM4B3SDwy+KnOOcP0dNG?=
 =?iso-8859-1?Q?DlcTvcREvFtjZY+tFdGCY14JN2FtJdvEDk8+d4y+Qgzmyd571AedzxWpIX?=
 =?iso-8859-1?Q?OhJO30g+5dTNEAI+eoR+rf1irx8HBBsrzh0qmdJjbIZGI9B1ge6k/19vAR?=
 =?iso-8859-1?Q?7s0iKsz3ipZbAlHaHbjfz6NA7HhLx8AKsyC40sqioq4rbDaKIPcxBkhuT5?=
 =?iso-8859-1?Q?lCJRYabDqKfGUEFrttdE9aVhosg5UnZNnRbH+A5WGuVgrYA5uHfGRitFor?=
 =?iso-8859-1?Q?YtuJcCh21UAcA4A6W+JS8iqxerNAtFagz8+e28CyFQEZwSjT+R29LQ49+e?=
 =?iso-8859-1?Q?Bz1KVUzY42/rPyKP+WHwTe61M8/OPrMmJptZTarQ+8P0vkoV4bzCelN1HJ?=
 =?iso-8859-1?Q?WyBG09CrQhjlcBS6/IqHqCE+A5SoRcKtSGP9Line3ahQg4/jGN9lM4z7b2?=
 =?iso-8859-1?Q?reSpqmeoCCbMNuRZtRHobr0Q/77Q/YoDC0OUatrvs9VMx9xd3zgIADOA/7?=
 =?iso-8859-1?Q?GzyiXYwSY79nrfR885o03XZRI1OzJ0jetov1SbhP9wD1d+k6c1cjLXlEbC?=
 =?iso-8859-1?Q?z/BdsxyQ0zPiJpJy3mBVF61KZCOYFgbNPz60A077XD/GaMgmFnAIOuwsjt?=
 =?iso-8859-1?Q?A0dzu2WCX81mol5VB90GYbBjSt2TRNJ3MBL1kqHaJVOovaJ7AsATnSPJe6?=
 =?iso-8859-1?Q?VxU1wW1WOZfr+55v+Q3Oxs9gm1n1nHOAbeFuUt4n5wK5bJk13/fTDEr90G?=
 =?iso-8859-1?Q?O4tAKny3YAoomPD8xL3X9OrE0jhjGJwxs6UwaBuWz2+vgOCy2nBsX+DvqE?=
 =?iso-8859-1?Q?v2BBGSDsAaES6IO7fccr0PRW3f8S4IC5/sLLMi6XSx8NtkKeuPjeFNT+iI?=
 =?iso-8859-1?Q?0JBietZjb+vLIw/RvU1qGzJA/hqWSqD5SmHFAez5fQTFyhZzNgoWeka7Ri?=
 =?iso-8859-1?Q?gVqasUo19Daab7v8M4dxOnGJFWRrIeAVD4OmXiW9eTFc3RJPb4//jS7juj?=
 =?iso-8859-1?Q?yTS2rahGuSVvFFgB7355YijVrn4c3/W7aDGRssGcBKhw7KBiTHneyxdSt+?=
 =?iso-8859-1?Q?LZqUoRAmgpcS9mjv4VFqwvpBWmAZFYZH0Rfzar/8GkRJxOT/s0tGaDrWAB?=
 =?iso-8859-1?Q?qZiLU0CvRjewlT6ql4xqe7w6oY8kc87W3CGyYRLY13ztBXWoIr54FPR1dO?=
 =?iso-8859-1?Q?oy9g7013Y6Wx3MuGEh0LKBPr0Oc/YMGsN/h7prUJR8cGF/A4puVbj0eCRR?=
 =?iso-8859-1?Q?0UEfX2Y3Bgk7Rd6yt2GqNm8nTUtDaJC54J6vh9CkbxWCyRVqs6ibDuU3wI?=
 =?iso-8859-1?Q?3scvueYBrk+nc2R0Bzt4EdNyxcz7IAJp6r4pdFg2Fhk97vLDqE2EFc1wTO?=
 =?iso-8859-1?Q?p5ZOyv2JbIMAARsDAdfTRk6O1GwyvAu0flJG0z1OvpyvK/aDUfVQGRKweF?=
 =?iso-8859-1?Q?rlf2RFgsuSZ1+0M9X2w00hZUMhITAvh2XmS3HeCpO0S45O7EKn6duFQ8Dr?=
 =?iso-8859-1?Q?fWV9mINXog=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e4fbf4a-6813-4470-c470-08de68843c22
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Feb 2026 09:10:28.6552 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: l7YAYkbOuygb64bRY+Ij7H5hX1XxnpqgzkNLvtw1N2EigDcDZBgPDywOv4xgEuMrI44IoosECv0B3IiMPJhIjAZkiIWJbnD0ijQf9hhsklw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KUZPR06MB8268
Received-SPF: pass client-ip=2a01:111:f403:c406::3;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=OS8PR02CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, UPPERCASE_50_75=0.008 autolearn=no autolearn_force=no
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

Adds the rest of the Aspeed I3C controller register fields.=0A=
=0A=
Signed-off-by: Joe Komlodi <komlodi@google.com>=0A=
Reviewed-by: Patrick Venture <venture@google.com>=0A=
Reviewed-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 hw/i3c/aspeed_i3c.c | 54 +++++++++++++++++++++++++++++++++++----------=0A=
 1 file changed, 42 insertions(+), 12 deletions(-)=0A=
=0A=
diff --git a/hw/i3c/aspeed_i3c.c b/hw/i3c/aspeed_i3c.c=0A=
index 647074d181..a215700288 100644=0A=
--- a/hw/i3c/aspeed_i3c.c=0A=
+++ b/hw/i3c/aspeed_i3c.c=0A=
@@ -21,28 +21,58 @@=0A=
 /* I3C Controller Registers */=0A=
 REG32(I3C1_REG0, 0x10)=0A=
 REG32(I3C1_REG1, 0x14)=0A=
-    FIELD(I3C1_REG1, I2C_MODE,  0,  1)=0A=
-    FIELD(I3C1_REG1, SA_EN,     15, 1)=0A=
+    FIELD(I3C1_REG1, I2C_MODE,      0,  1)=0A=
+    FIELD(I3C1_REG1, SLV_TEST_MODE, 1,  1)=0A=
+    FIELD(I3C1_REG1, ACT_MODE,      2,  2)=0A=
+    FIELD(I3C1_REG1, PENDING_INT,   4,  4)=0A=
+    FIELD(I3C1_REG1, SA,            8,  7)=0A=
+    FIELD(I3C1_REG1, SA_EN,         15, 1)=0A=
+    FIELD(I3C1_REG1, INST_ID,       16, 4)=0A=
 REG32(I3C2_REG0, 0x20)=0A=
 REG32(I3C2_REG1, 0x24)=0A=
-    FIELD(I3C2_REG1, I2C_MODE,  0,  1)=0A=
-    FIELD(I3C2_REG1, SA_EN,     15, 1)=0A=
+    FIELD(I3C2_REG1, I2C_MODE,      0,  1)=0A=
+    FIELD(I3C2_REG1, SLV_TEST_MODE, 1,  1)=0A=
+    FIELD(I3C2_REG1, ACT_MODE,      2,  2)=0A=
+    FIELD(I3C2_REG1, PENDING_INT,   4,  4)=0A=
+    FIELD(I3C2_REG1, SA,            8,  7)=0A=
+    FIELD(I3C2_REG1, SA_EN,         15, 1)=0A=
+    FIELD(I3C2_REG1, INST_ID,       16, 4)=0A=
 REG32(I3C3_REG0, 0x30)=0A=
 REG32(I3C3_REG1, 0x34)=0A=
-    FIELD(I3C3_REG1, I2C_MODE,  0,  1)=0A=
-    FIELD(I3C3_REG1, SA_EN,     15, 1)=0A=
+    FIELD(I3C3_REG1, I2C_MODE,      0,  1)=0A=
+    FIELD(I3C3_REG1, SLV_TEST_MODE, 1,  1)=0A=
+    FIELD(I3C3_REG1, ACT_MODE,      2,  2)=0A=
+    FIELD(I3C3_REG1, PENDING_INT,   4,  4)=0A=
+    FIELD(I3C3_REG1, SA,            8,  7)=0A=
+    FIELD(I3C3_REG1, SA_EN,         15, 1)=0A=
+    FIELD(I3C3_REG1, INST_ID,       16, 4)=0A=
 REG32(I3C4_REG0, 0x40)=0A=
 REG32(I3C4_REG1, 0x44)=0A=
-    FIELD(I3C4_REG1, I2C_MODE,  0,  1)=0A=
-    FIELD(I3C4_REG1, SA_EN,     15, 1)=0A=
+    FIELD(I3C4_REG1, I2C_MODE,      0,  1)=0A=
+    FIELD(I3C4_REG1, SLV_TEST_MODE, 1,  1)=0A=
+    FIELD(I3C4_REG1, ACT_MODE,      2,  2)=0A=
+    FIELD(I3C4_REG1, PENDING_INT,   4,  4)=0A=
+    FIELD(I3C4_REG1, SA,            8,  7)=0A=
+    FIELD(I3C4_REG1, SA_EN,         15, 1)=0A=
+    FIELD(I3C4_REG1, INST_ID,       16, 4)=0A=
 REG32(I3C5_REG0, 0x50)=0A=
 REG32(I3C5_REG1, 0x54)=0A=
-    FIELD(I3C5_REG1, I2C_MODE,  0,  1)=0A=
-    FIELD(I3C5_REG1, SA_EN,     15, 1)=0A=
+    FIELD(I3C5_REG1, I2C_MODE,      0,  1)=0A=
+    FIELD(I3C5_REG1, SLV_TEST_MODE, 1,  1)=0A=
+    FIELD(I3C5_REG1, ACT_MODE,      2,  2)=0A=
+    FIELD(I3C5_REG1, PENDING_INT,   4,  4)=0A=
+    FIELD(I3C5_REG1, SA,            8,  7)=0A=
+    FIELD(I3C5_REG1, SA_EN,         15, 1)=0A=
+    FIELD(I3C5_REG1, INST_ID,       16, 4)=0A=
 REG32(I3C6_REG0, 0x60)=0A=
 REG32(I3C6_REG1, 0x64)=0A=
-    FIELD(I3C6_REG1, I2C_MODE,  0,  1)=0A=
-    FIELD(I3C6_REG1, SA_EN,     15, 1)=0A=
+    FIELD(I3C6_REG1, I2C_MODE,      0,  1)=0A=
+    FIELD(I3C6_REG1, SLV_TEST_MODE, 1,  1)=0A=
+    FIELD(I3C6_REG1, ACT_MODE,      2,  2)=0A=
+    FIELD(I3C6_REG1, PENDING_INT,   4,  4)=0A=
+    FIELD(I3C6_REG1, SA,            8,  7)=0A=
+    FIELD(I3C6_REG1, SA_EN,         15, 1)=0A=
+    FIELD(I3C6_REG1, INST_ID,       16, 4)=0A=
 =0A=
 static uint64_t aspeed_i3c_read(void *opaque, hwaddr addr, unsigned int si=
ze)=0A=
 {=0A=
-- =0A=
2.43.0=0A=

