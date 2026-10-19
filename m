Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9A36CCF2D4
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2026 02:27:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xId6G-0007Zw-8R; Sun, 18 Oct 2026 22:27:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=7454c2a62=Alistair.Francis@wdc.com>)
 id 1xId6E-0007Za-N7
 for qemu-devel@nongnu.org; Sun, 18 Oct 2026 22:27:42 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=7454c2a62=Alistair.Francis@wdc.com>)
 id 1xId6D-0001oj-6b
 for qemu-devel@nongnu.org; Sun, 18 Oct 2026 22:27:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1792376861; x=1823912861;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=Km2jnBzeNtCuKxUSMA4n2013uV3ltKLpB16tQIkTUco=;
 b=RE89rnk6g0DD7ohro5AjuRCzafMfVsU0cs+NYF+SuzTEyEE7eIyQ5yJq
 kirm7yC9XOEamJMzzwy15Qsh5jj7txCW5eiXn+1jSNXHLF+vP/YpSHPOE
 kAwgzKKPZUAc3YKvedjXNa/MXE0spQSQNr/ZEQqvu4O5JpTUOU0MfNlUw
 bDGJj/jWM8Lgry6LD4f9Vb/gRWD/6jPXTeGpp59B13TWUxeqG9HxsmWya
 1MCyAnZqnIwD+d6zRSD/+Z9DZUSyzA1lehTlVMHf1xjowNj9S+RJj2Ivi
 accXH8YOYRH4qxhf/syTUInKYfiLZRpA5jTYG0vSV6DubVc1N1vIUlb+X Q==;
X-CSE-ConnectionGUID: blqLpUZrQE+rgcQY5hiSXA==
X-CSE-MsgGUID: 7uI4AvHmRzWmaxFo7zALKg==
X-IronPort-AV: E=Sophos;i="6.27,166,1786982400"; d="scan'208";a="158416887"
Received: from mail-westus3azon11010041.outbound.protection.outlook.com (HELO
 PH7PR06CU001.outbound.protection.outlook.com) ([52.101.201.41])
 by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 19 Oct 2026 10:27:39 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eU7AVy2p9jnnlXqLoEybLc3Lbe6SUEH/48JbHeFLqAOQWNgnZNJqA+5GD4K8V+UnTB/hwlV8mICnrzz43eJRBgrV85EpB5iG0iflG5R37w+Vdu9vTpD3iHGFEg0cwBgXoRMmmyocU6pkEwbFZqtXsSsS+UEIAzGLIXWOXGfaozlvFC08aoLLfLl3d0atoJCWU46VmF1Eqdlkq02zbx0m3LNTUS08kBxJgU1bWa7oElrLPI6HOw1e8rsPnROZt2dsdXWpRCNras9PcXYpm3fT+bB0RDpjLrNJg3ov0bDZstrGjrTjv6e7NnNvDdOLk3xVFrVA2ZWfww0u3//vZdxFLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Km2jnBzeNtCuKxUSMA4n2013uV3ltKLpB16tQIkTUco=;
 b=LCdhE6GG6Hw0EHLxhhe/HuZdWGhiGuTwDU2vSeQj5fOo82WGrkgUFUMiqUmZKOJt3vjTbPT0hWiEOdSgG+pw3NxRzmSq1x8+B8hYdZBUsHUQ9wlhNuCPFZ+0mA0w7B62rJzgTJVQizhrB0m5aq3FE9bm2ZsZo7xDawFml54h7pD9Gbd/zI/B+vhvgaDBT12lH77TvgpfE4PIA1o+izhOkGAeeQQDPhvUOeedAef2q38YR5LTemfMNZAW1QNBcQclVp3Ob5oI4b+omQQe4P39MR+/IpJCd5dNcDn/Bf8TMwFJYWvZVXmPBH0OAUXWZUzw0rqlsU9YK1GwjrPNi1r/fA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Km2jnBzeNtCuKxUSMA4n2013uV3ltKLpB16tQIkTUco=;
 b=zRaqoFujQEGBz5Fu2DT/J6YaWQH19eaHGsKwWe8HV4Rxp+uxrv9KaAXe4r6W3SDljBMAl6TcY9n0J79vn1PNxvE6fkCefauIJqhEYbB5QKGFgrd6cuRXO6vreFOI6HZozR9J+102VWuSgEPzvgMtv2ftPDKNOhLtMG6SHcTKVlk=
Received: from MN6PR04MB9359.namprd04.prod.outlook.com (2603:10b6:208:4f2::13)
 by MN6PR04MB9336.namprd04.prod.outlook.com (2603:10b6:208:4f1::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Mon, 19 Oct
 2026 02:27:38 +0000
Received: from MN6PR04MB9359.namprd04.prod.outlook.com
 ([fe80::e729:bbef:5a37:2e77]) by MN6PR04MB9359.namprd04.prod.outlook.com
 ([fe80::e729:bbef:5a37:2e77%4]) with mapi id 15.21.0522.017; Mon, 19 Oct 2026
 02:27:38 +0000
From: Alistair Francis <Alistair.Francis@wdc.com>
To: "pierrick.bouvier@oss.qualcomm.com" <pierrick.bouvier@oss.qualcomm.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "philmd@oss.qualcomm.com" <philmd@oss.qualcomm.com>,
 "daniel.barboza@oss.qualcomm.com" <daniel.barboza@oss.qualcomm.com>,
 "anjo@rev.ng" <anjo@rev.ng>
Subject: Re: [PATCH v2 8/9] meson.build: add riscv64-softmmu to multi-target
Thread-Topic: [PATCH v2 8/9] meson.build: add riscv64-softmmu to multi-target
Thread-Index: AQHdXcVYA+YbPrqms0mjbCXd8+nl2LcEJ0WA
Date: Mon, 19 Oct 2026 02:27:38 +0000
Message-ID: <5b537743bd6c08fbf8e0072099b3dc3a760bd01e.camel@wdc.com>
References: <20261016232304.1215119-1-pierrick.bouvier@oss.qualcomm.com>
 <20261016232304.1215119-9-pierrick.bouvier@oss.qualcomm.com>
In-Reply-To: <20261016232304.1215119-9-pierrick.bouvier@oss.qualcomm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.62.0 (by Flathub.org) 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN6PR04MB9359:EE_|MN6PR04MB9336:EE_
x-ms-office365-filtering-correlation-id: ca9894c3-5cb2-4994-f7ea-08df2d888b01
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|19092799006|366016|10070799003|23010399003|1800799024|261009223027099003|10067099003|56012099006|22082099003|18002099003|11063799006|4143699003|38070700021;
x-microsoft-antispam-message-info: XMj69mR3SxhigEZI4ZMHgfShaxl2orxaNKiaUlXfP3FkaGyY4W+6BSLpZZPo8ES/TqDozuzuS/mSbCtgHhOnHpw7rWM3fo95QUMGxE8mPPX/bjnR/D/O78EN+ImXrJQVtoqgTfu2SKD74B/RA3L0oY78386+3FgCuZKIvTyR1X4ajtkO9TiZ3iAh7mnRaERO/eZnY/83I8rszENsnl0RY0uvsp17XFt4zZRBS1ezsNB3bhLQW1izx6zsaPt+Em5oxQ8iE+ni6/bjDSE6CwSahMDw2P0Iq/ygV5KKj1tbUlVwhZZv7rHzYgMGoFrRmr7pJU6H7x4PjL3H6q1w0L7SQfCKx7mLdPMVw4UVGjG94D52aQvNfi5u79atKW3A4F9CoXZ3A+981UPgXP2iWXIbUy5KaTiTI2fYZk+burbRGaQRg1Enm1LwGvGIZgWzW1DUfVblGsQ7CSMwQDrBzURHnKWSP7bBJ8zZYCm5PtVKaK8/0wr/rPDLwA14TUwJWM38CqFa5dIw91rGB9IBdCf5+/HvRVQ7gNVBmDxxQr6xwQwNjtPZjRw7Q//Vf+16XV1QO5Rd7yLbyfPbMynhaf3mKW+2xff69Y+4ibsAGxg6gIObld34kgA9Fhznbq555V/JFTLK9iXBSsiyPDPXrcenMwSG9152WADIBhcCuwAMv1vchAXjinQxKVc/EN3yf/pMHXQpw4M1Z2jxkakwTPSBcJfKudcKtTdbgdP01k1qjWY=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN6PR04MB9359.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(19092799006)(366016)(10070799003)(23010399003)(1800799024)(261009223027099003)(10067099003)(56012099006)(22082099003)(18002099003)(11063799006)(4143699003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?S0dUUFFoQkhCTFR0M3ovckYvTWIwdmtUMFVueTB0dGpZUzhJaGpqeUFiUGd5?=
 =?utf-8?B?T2x2anBPV09oWldiRDIwN3pHeHVHUFJyeGlGejUxcFIvUWg0akhYTi9RSC90?=
 =?utf-8?B?Qnljc3dEQ21taXI5OHdrY1VxdFMzWHowSDBOb2U3QStVSzg0RW1SZ2lobFNu?=
 =?utf-8?B?eUpKd0FldW1IZGlxK3lMQk1oVGxEZzMvb3owMHI1aWRYOUkrYW9Gc2tFSFVv?=
 =?utf-8?B?b1pBZGs0bGNTNDRwdWQxYVdRRzVrOUIrbDIxTEREc1REajNYSXJaNk0xTE1r?=
 =?utf-8?B?c0lSMTBiT2o5aHlpYWd4TFdFSVFsK29aYkZuczkwZ0JIZnNDNmx4U1NmQXBC?=
 =?utf-8?B?bWwwK1BwcHpJZjB6dCtKbkVseTNNRDE4VCtVUDVNdU9iWWJkYzdremxadEM0?=
 =?utf-8?B?eGlzeUVNd242WDhmZEhFNzhDWlVjZENzY2dwWDNOdXJUQUpKdENoR1JrMVhv?=
 =?utf-8?B?MEp5eFYyeFo0QytQcUtZWWV1eFl3M0w4cHFTdW1GUW8zVWpaNWx1UlBRNnV5?=
 =?utf-8?B?V1FxMDlUQmpNMzltblpzL0dmek1JSE9ReUtLTXp2Y2ZqM3BhUzRCUlhqakRE?=
 =?utf-8?B?VStUcEZ3UytLTFIrOXVRekN5UXdFeUtGZkxseWVXRDRuK0o3Vmsrb3VaTW9V?=
 =?utf-8?B?emNhZVc2Wkpqb05TOHU0WC9IcWVzdUZrZUsyd1l3eWpSblJZb0YyOS82U0lC?=
 =?utf-8?B?WVhCTEpjajg3ekd3dXJoZUpHL1J6UUh3c1hBRVJTU1pkNWsvRjZRTDFOV3pF?=
 =?utf-8?B?QWNaWllSa2VySjZ2czl3a0M4ZVVBR1ZTUmJGWUhmK2lBdHc3aFBJMnF6eWtk?=
 =?utf-8?B?bUJWazVpcVliTzhwd3BTRTBnZUptSnFGdjVLTEg2SmQ1MGhUeEU5bW9JV0Z3?=
 =?utf-8?B?SWExaXEzUWVDVHRVVnJYcysvQWg3THpZcllPREp1L3BEeXA3di9RT1dyeW5z?=
 =?utf-8?B?WlN6UHhKaFA5VEJObnN5TlZNWXRKL2NSbC83ZGdHajUwQTJ1clczcEFYQTNJ?=
 =?utf-8?B?VlZTSi9IbEVhOGRwM0gwM1U1VGYwdXl5M0pTK1NCc2FleUZhY3UxZ0w5WHlp?=
 =?utf-8?B?TjZzZW5mR1FRWjJQRjNuZm9idUZ2bTR6K0lJUlVpYnNmbmU1S0dhcVhEdlZq?=
 =?utf-8?B?Y0hjeG9yWXNrTDdabU53UUozb05ORmpqemxVRGFBRDZ1bUYvQkFlcUJMU2JC?=
 =?utf-8?B?WS9GeHRJc1cwNElULzBDZFE2UFRyZTBSUVhYSXNQaE1WZWlFOTRjdi9obmc2?=
 =?utf-8?B?cDNZVi9UNWxGTHVocVk1MHNPQUkzSVlySFNrY3ZTK1RYR1NpVkJSdjJobW44?=
 =?utf-8?B?c1ZpdElGWFRVSmJJbzBvZHJrSXE0dXhPRThVMnlESmExUDFHeG9lV0d3T2ZW?=
 =?utf-8?B?dCsrejFEZUhabERUc1hoTjFsUVV2ZVpRRlRmaFhlcktSdVkwSmQxUDQ1MEcv?=
 =?utf-8?B?NkdKeHBvTHR5eVZtc2JtZ05uaG9xY3ZQemJ2ZkoxeFI3SGdBMXFrTkZsNCsz?=
 =?utf-8?B?Si95RE1NYWFHeUd4NHlzSEJTYkU4SnZYaCs5UTFTamdSZkJlcmNTZE9vQmxp?=
 =?utf-8?B?MisvcmVNNVYvLzNHQTJRNkZ5dkFha1BlWDBsUXhrUEJTVTJUN0QwNTVoOU5v?=
 =?utf-8?B?cnQveUs1NExYUWRoNG1hb3ZLcWlTOGo4OUc2S1Q1c3JoL0ZtRzgzb1htRVRC?=
 =?utf-8?B?aEpQVjBjS1lNTnBNZTBLVXRXV1hiVXlPSGM2RlkwYzRmZ2xUb1c3c1pld1lU?=
 =?utf-8?B?c3g2N3BjS0FEYUlXQ1ZLNVE3blRnYUpZM0JtT1lLVkNBbGVaRkh6RnIraFFF?=
 =?utf-8?B?cy9aRGVZcUIzZXl5QnlHRUFpYzFjRGlZZnE0bXVnSHpTWTJvRXhjaU4xeWtV?=
 =?utf-8?B?VWYxTUswTTlhTnpmaFpYdzUyeGRSYnJvNHpqVzJXbVVqTkVXUEVNb0FOdGpl?=
 =?utf-8?B?SkVXTTZ5bkhPd1FHQ2U3TitXbFJJT0xZWXZZZmFIUXhTOW1CaDAzVGovRFJ6?=
 =?utf-8?B?UVRJcE9XK0d1UWhSS1lhbm1sbjkyY2F3TldtWTJyYzJCdlNsOGxUUFlDK2tj?=
 =?utf-8?B?eTZHWStKTXExT0hOOW9IOHpXWU41K3lrRk9GY3pGQ2pmOURQM1NlYnFoR1Mw?=
 =?utf-8?B?bjRwVzQ3Y3N6TFl4MVcwa0NPdGwvUXRFeEtTRERmeHZlNS82MTF6VGRIbFB2?=
 =?utf-8?B?WWp3QTl6Y21wV0lBbjc0VkJUUk9QbXlaQnkyL0N5RHpZSjRuSFFxZStmNFZY?=
 =?utf-8?B?WnBidHQ0ZWRSTzhKL1ltZ3FPU083czlUb3JMbEhMdFRaTEw3anp3VUpFK3FZ?=
 =?utf-8?B?K3RHYW9Ld1NkTEVsdEVHdEFETjE1MGtDT0JLc1R6TTMvTlFlVUtLQUNBTmk3?=
 =?utf-8?Q?Ys0TLJTQMxQsLHgIbtlOZTW+soRt6YEzvNkBs1nF245LY?=
x-ms-exchange-antispam-messagedata-1: hVSBnuj0TulpPTCQgfMY5HcvX1H6ZqHptdQ=
Content-Type: text/plain; charset="utf-8"
Content-ID: <15E1AF97E6F6E14F843ED9AF32DBF015@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: Pn6iAS0Vcf1JFz7rADSc9ZEJCjeN+L6zeeJchNve9Z/e4TSCMfh5SDU4hS1y5TVE8KPOQUXwXyQPXLD0Kk9iHQri8jGChDvWMVjXdDFhCxIAMzTkvEOYVP2xWfzk02cBhPpJBqYY0ydWbYcFbVcvKy2lnPSgTAWy0pFDWUcvP2ppw8pjjw0Ktw7fr4PUKxlwMFPdzCO1kNW4ALR5B8vjvw9tKE3i5Jk9WGuWwsiUvX+1IByJOsKnnP2zDBZcc+zUeEXtnz/X6EEjw0tAz0QnlBPD1QVnkwgAD3/b0FiSbVShOr0KATFtNZtta1DZCThz6tVRgVgOkIzBd+/5L/JQwQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: uQg/wCpOr0mgoxRfN8Q0d2QoCPf+CJ6pONTqLKO9I6FMTJX8Hp2q4L0n8la4gBkmlBe789w0xBxBfsUzBmyUHDE0Bf1e3X2zv06+80F3mFlVUCVJBg/KaXNYoqV87gd6++r1GW+rXtLGb0rJ30R/+B4soXoXSMCX6cE/W9/S3ijy+CiHySWGRVy8ZfU15D0i8CqTqie6uEMSajSeUSfCnUqRLzMFyBH8RXq6ofI2s7aUuUaHHYzmBDbunb6E0g7YLychjLZLgXOhKeoTFBSgQ7V2yBJwpaPvz638b68Lxxmg9a771yupaxTDSilGwV5EE+A15yt0HRLhFJtOZPkdpNI2Pb1SfmQUrYHY/Ec5PXuBbP7cJ3j0xryDFaPr735tBQhwaBKI/nIb/3RheZKnsjcbwpYY5e+qrbtFMBunA07AHZWn3tfD1Gx0zLURVZzOQ2DN9DAopfszzvE4T+ki2eP3lCL82PCy8Wb7ts+29ecoMxj/9uECPSbDmtI5hwXx/Gi7rrxAOx10CaUsLbXXZZRWDhOqElOOHcr3vMwy8lw1zsLBTImMG0zJ6GFhCLvmG279e+HY0EHBhbo+diWYjRixGaBDi8o0l+imbsT1H+2QBKuj+GeTdO6K+EfT9vsa
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN6PR04MB9359.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca9894c3-5cb2-4994-f7ea-08df2d888b01
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Oct 2026 02:27:38.0286 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /JBaG77IVmeXzhKhQredJ83xWEXx7GEltDs9dw+PBK5WcdT0GhYjbzRjToto1wY6VPrd+XhXatwW76A9E8fVr6Kwu18c6MEbSZe8BaLh69o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR04MB9336
Received-SPF: pass client-ip=216.71.153.141;
 envelope-from=prvs=7454c2a62=Alistair.Francis@wdc.com;
 helo=esa3.hgst.iphmx.com
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

T24gRnJpLCAyMDI2LTEwLTE2IGF0IDE2OjIzIC0wNzAwLCBQaWVycmljayBCb3V2aWVyIHdyb3Rl
Og0KPiBTaWduZWQtb2ZmLWJ5OiBQaWVycmljayBCb3V2aWVyIDxwaWVycmljay5ib3V2aWVyQG9z
cy5xdWFsY29tbS5jb20+DQoNCkFja2VkLWJ5OiBBbGlzdGFpciBGcmFuY2lzIDxhbGlzdGFpci5m
cmFuY2lzQHdkYy5jb20+DQoNCkFsaXN0YWlyDQoNCj4gLS0tDQo+IMKgbWVzb24uYnVpbGQgfCAx
ICsNCj4gwqAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKykNCj4gDQo+IGRpZmYgLS1naXQg
YS9tZXNvbi5idWlsZCBiL21lc29uLmJ1aWxkDQo+IGluZGV4IGI2N2E5N2FiNDU4Li5jZTNlYjAw
ZjJkYSAxMDA2NDQNCj4gLS0tIGEvbWVzb24uYnVpbGQNCj4gKysrIGIvbWVzb24uYnVpbGQNCj4g
QEAgLTQyNzksNiArNDI3OSw3IEBAIG11bHRpX3RhcmdldF9zdXBwb3J0ZWRfdGFyZ2V0cyA9IFsN
Cj4gwqDCoCAnbTY4ay1zb2Z0bW11JywNCj4gwqDCoCAnbWljcm9ibGF6ZS1zb2Z0bW11JywNCj4g
wqDCoCAnb3Ixay1zb2Z0bW11JywNCj4gK8KgICdyaXNjdjY0LXNvZnRtbXUnLA0KPiDCoMKgICdy
eC1zb2Z0bW11JywNCj4gwqDCoCAndHJpY29yZS1zb2Z0bW11JywNCj4gwqBdDQo=

