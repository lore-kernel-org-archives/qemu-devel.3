Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34A02CCFA04
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Nov 2025 15:08:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vGIdh-0002Ws-EX; Tue, 04 Nov 2025 10:08:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1vGIdd-0002WL-J5; Tue, 04 Nov 2025 10:08:02 -0500
Received: from mail-northeuropeazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c200::5] helo=DUZPR83CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1vGIdX-0004gv-1W; Tue, 04 Nov 2025 10:07:59 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ByM05elUUcKwhFGkTcqD8MOivIw9wxREaPMg8pZZFlZh94L6QOaiRlfWckk/st9E/fyEdkNWeH6voJ1Q3wZoOGTn2L51WSj+48MAymPDWFHB2xY8pMh85VdX/K8+StNzxvkO9dZQ5Tqq97pfKg8G9ks/KjQ+5HJmonIeH9jJR33Ni1o0pFqSkhl2ILfvq7+YtHybFi2mN3epBWKDtwCOIDMR+81eQ3WOHXVBH0wrEoTxNnSeO6pFOBUEmMYAxsc5ZwUO6WwtQSe7i7w5I+1HG9FK/ezjm17ufexTnov5TShDyycrBbfCoR1oUVjGkgnO5qoFObt31BIpA/aBoHBXsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/ZvmQX0D5Bt+iZaIyZvoy8kCu3FFkRb804lqU+fuqks=;
 b=Wyw9UH3t8DOWeXUGsZfDXsrCMEibIchM5+CymTQaadi3t19UigYx7UqZzLWXFSvuEzmOWQlieqjSJGBZGHL6bsfkd+gj1FRMUz0uwCe2Hc3h61IKWRnf4DHNn8TVca5k/c4JuvW0AvWzAeSwn8QpIWaHpOI8SvKyggLc4SHGrWku0iKz6XHxvUr5a+OwwFX8BDGlRAnSm7A+J6/SIREdjIHYzd+ULTA7FZrJu1CVJf9VyC29tUh6RS2wo0x8l7S3cowW3uGWVCakF6gG97GTswrSItj3/MTb4OTD3b1naTKIVeAPCheftFJVaS4XkC3HQUAR7bjy0H84edAtQWveYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/ZvmQX0D5Bt+iZaIyZvoy8kCu3FFkRb804lqU+fuqks=;
 b=s9iqUEQ+aJC/UywhjUbowJW7LcqqUG9vndHPLikeLIKoxsGvwqHoYtlzXl/Ioe/faCubMYh036OUmQYFUyEFbpdV+VKLXjAnH4OZLIocL1ciyhOHtCfBdZJvdITxyJ9TUzTdk2anwEAcTs1zV+jKvXw3KUttHotAF/lqiezqi+uByAZQn/6Ju3u9YRQ6vOAbZH/rE00kjofDLamICfhFVX2pgiaje4S1Ejh8KOpVXoHNocpY5O6GQCtGxdDyKXFpOvRrtQM+a4QwBSSkfVuwRER9GRkq2ySFVVlrqEYUUgt+7Cxp4JltbBvBbsKmRx+XNAH8oaAZLknC6GqvVnHYpg==
Received: from AS4PR09MB6518.eurprd09.prod.outlook.com (2603:10a6:20b:4fb::5)
 by DB8PR09MB4155.eurprd09.prod.outlook.com (2603:10a6:10:fe::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Tue, 4 Nov
 2025 15:07:16 +0000
Received: from AS4PR09MB6518.eurprd09.prod.outlook.com
 ([fe80::ad50:891a:847c:580a]) by AS4PR09MB6518.eurprd09.prod.outlook.com
 ([fe80::ad50:891a:847c:580a%4]) with mapi id 15.20.9275.015; Tue, 4 Nov 2025
 15:07:16 +0000
From: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "cfu@mips.com"
 <cfu@mips.com>, "mst@redhat.com" <mst@redhat.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "dbarboza@ventanamicro.com" <dbarboza@ventanamicro.com>, "philmd@linaro.org"
 <philmd@linaro.org>, "alistair23@gmail.com" <alistair23@gmail.com>,
 "thuth@redhat.com" <thuth@redhat.com>, Djordje Todorovic
 <Djordje.Todorovic@htecgroup.com>
Subject: [PATCH v1 0/1] riscv: Update MIPS vendor id
Thread-Topic: [PATCH v1 0/1] riscv: Update MIPS vendor id
Thread-Index: AQHcTZy0WB//FmK49UaNRcS3d/Iv/A==
Date: Tue, 4 Nov 2025 15:07:15 +0000
Message-ID: <20251104150708.3345289-1-djordje.todorovic@htecgroup.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS4PR09MB6518:EE_|DB8PR09MB4155:EE_
x-ms-office365-filtering-correlation-id: 036f0212-97d4-4cd1-642d-08de1bb3d77c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?weDSSxZUF8/K7zANObDhpetGQmKrQpJr+zNkW6s0GNrAMVkdgiaF21Rpmh?=
 =?iso-8859-1?Q?NEoNLpIGZ/0ihXWNLnG5svkA4sTtmxM5GKFDTD5fJLYRP4XiOVnQ3wAEoO?=
 =?iso-8859-1?Q?fp+299ShFej/ep6x85NIjLOfb+j4Osr9B1fDEzyGXhLKfGLI+0ODmzosK4?=
 =?iso-8859-1?Q?hf2Rnx9ex1dTUIGiP+z9N64QUZm7MFUgcuLAutuDs6bG6ibgsxPBPdcfAo?=
 =?iso-8859-1?Q?cCzIC5KJJOPhH9CvrXNAxxV7Rlq9ulBSIPZmLndllD2dl5x4+UqC4g+ZIu?=
 =?iso-8859-1?Q?2L5osNndLYIrif3TSVOJ9l4iWjHp2v2Aq/Hh3b0fprIoZDsH4kDDgjCJoA?=
 =?iso-8859-1?Q?AXmpyeUTZ3YxRaeiCeUOUY4IoAhvQnFRmDT+K5rzrft8+s0G48nuABSGAP?=
 =?iso-8859-1?Q?vWbidZRJXwEuE2y2HjS3xXQkxRH4nAu4wqus83XXysJPKjlKfELYY4GLmk?=
 =?iso-8859-1?Q?0hSwiAkg1n/gcyIb8xl4qkRLXEZk+cw86hDW+IB1co0ZYek6VBR5Fq9WeL?=
 =?iso-8859-1?Q?v4g4C++88Gqs1yctRN/77TVxKOA0beExapF7KpoON37Y/Rhz4dz3OpPUyL?=
 =?iso-8859-1?Q?mdFNhbGO9n/LOQeCiLB9W1Sx3Ch3/xOM4rx7qW4Hk3VRRU1xkKkEYwBTGE?=
 =?iso-8859-1?Q?NUUyXRjFUdTU9ahcHS7FgIdoeT+TxudDlxpfS1ilpSWOgBN8+goT5usAvG?=
 =?iso-8859-1?Q?g67fxFOSDWI9YyVvFihG/fRTvXWULJPir/amIANG6AH1zoIIW2JKPGo2xY?=
 =?iso-8859-1?Q?HeWGmOqEs4iKgJggFiQs+dwNCQrra/gc10zokeP+CpqMoHgdOMnhSk5KMW?=
 =?iso-8859-1?Q?NSboh16b2SsfhcojS6Mq13lSqGiVHGFejfNBhbLqdUVEHlZG2PvVUoxA/K?=
 =?iso-8859-1?Q?HMkiHzvnlmDabrAi1ASUG8lsj7cnO2vJ/uUDRiaceiqVbUIU+YUv/qPH/X?=
 =?iso-8859-1?Q?M/dz+E+Cw8n6cDKHRujtBspjTqW19h5ur9i44IFEECtSh0Yufh14susd4S?=
 =?iso-8859-1?Q?T7QTWosjNEt4/TdtQZJ7kCDJYNu4mIS5Q3hT3668OLAzq0UmcQZxLX+0jD?=
 =?iso-8859-1?Q?7y+QSQYGmVrJJ2J/6DcxWVZle0fc7z8EAve2G4n7ZwmVf8iYK/bcLi+q1a?=
 =?iso-8859-1?Q?6KKdswhUbHF/oo9PkCGlx214y1gx9RJUfNw0VWMKBKWn9Om94b04Wafgmo?=
 =?iso-8859-1?Q?xK+ec3fC7whtE6GqgmrhPqLeqnWELgtmwxxosiVQWVS/FDiGBhcKg5ghkS?=
 =?iso-8859-1?Q?zBLimzHayEvVE3/jr1E3W6xmLC1DEAgT5eAxiGuJpkVuGPP6n2XIbGsLKf?=
 =?iso-8859-1?Q?ysGF1xM90pgPF2wBiD/sHqguMVo/QTOF8cjP4cDNS+kIJKpnsjLZkZuTWo?=
 =?iso-8859-1?Q?9PlAcviyDNonFxXaoQpS8ozRLQBLDQGSPbN9+GLkf68lcQelKuJaYoLKgI?=
 =?iso-8859-1?Q?DZ1tC3LN3SjzANuOKyrnBUiZ/QAB6Z9pz2pqSk6IIAh+BxcYNFEo/TC6AO?=
 =?iso-8859-1?Q?XxEbd+KUfQ/LsaoFTGMP2Ko//TsKiDCRN3h0Uacdi1zQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR09MB6518.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700021); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?M1ax1pxazAvW2ryGhSyErQKClHf74cGhByF2wA02YUgi0eyp4nsJRcLAAr?=
 =?iso-8859-1?Q?4Y+EwN2W4lDvzEibzgcgaAulbH/oTjyJc1OPKqFCOEEPsYc+pLd8zqgCX5?=
 =?iso-8859-1?Q?Y2NfE1CPzBUPPc/6HuL/OIgxeKkbI3H1itCAirbxEjY9/b9rDTQH0HJFXS?=
 =?iso-8859-1?Q?ZgCCO0oZ7P8at7kKkD/bR5AnikTqwUgYZIcBxy1lOMrQKR6l4c6LDWS7LR?=
 =?iso-8859-1?Q?38bworC6tJqWXN0F1XgVeuMu1U8i5RyVQwJnuzYuWPujk0ZzeaOFTCsUHo?=
 =?iso-8859-1?Q?88UqD/fj+PPcfe7oCISVzgv6CbfWBymf3S3l1/JaAT/9fDGu1Hl83PXZFa?=
 =?iso-8859-1?Q?ZWgrJLMheDglXuHdv+M64UcH1o+2/gOvCTgzdiE6mKu4H5C6zE0lbLWpx3?=
 =?iso-8859-1?Q?y7kpVc1dKYKhDBCgDj6P5p9hCfyKjBtrIoZ/MMTFyXkK/zAmQthKwLdyHI?=
 =?iso-8859-1?Q?zMqa2MREB8zQCt4uJoKIDKpZHUOnt5mT5+8aLHLpx7kOy8s0PRkLAaZTOU?=
 =?iso-8859-1?Q?1HoxlFIhVdPj3E3kRozePbBhoQfQ9hLR0+O9SNU5ZE13DH2qZHWuYUKJSm?=
 =?iso-8859-1?Q?AsRlei49Gt+mRiSv6+Pe7SFrddaSB/xC+9ZfG/wjhKzAuhUIB8WbmOFTH3?=
 =?iso-8859-1?Q?nTK/eWZ93T6/uEvgie+X0vWSVQe3Zk0dClWxejbyPYISKmMOBgDl9w13jg?=
 =?iso-8859-1?Q?l2pcf9ETLRDvJvLHXKojE6lxY2kIBQbqyWvP/l43phHZuXbYo9CVvn73GQ?=
 =?iso-8859-1?Q?zGrEbdyAnngU/zyVdnl7pfRd5NQrFDmBrykfdIxAGult+KfKz6fCZ0UU9F?=
 =?iso-8859-1?Q?mu5pc8wRoA9/xtwFf2JxI5ToMVNW15772mfO2qhQn7sZ454E0gS22MAh1P?=
 =?iso-8859-1?Q?Ryotfwwi/7UB/B1pv5lAa1bGf+Hws1j1afN6FnxmrVez0NfnxLNhbFOLUl?=
 =?iso-8859-1?Q?NuUKuPMIZYVykAkuUwFmgXnA0f8WiXa7pFDAkne3SbqvVpcF82ls+op1WQ?=
 =?iso-8859-1?Q?pFgS3jCxrA+yfaQy2nt0VF4obAy1kOFM0PuARmLlBV5eUUAJK9Ft4FAuw7?=
 =?iso-8859-1?Q?om+mWtXZN22bTzmYw0+LCu1JYI4R389XWaz4UM/DvRU3kn8WuJhXwXPV25?=
 =?iso-8859-1?Q?DfH9DzvYLneoQ0XTd22LPEa/TEHfEKiC2rC7LlKxpSRkH/Q1WMZEqRorm7?=
 =?iso-8859-1?Q?VK+sWBviEkIxu5nn6q39pKRUBjvMVu7lXLIrb2ybYbR9VAOhMYuM73+5Zl?=
 =?iso-8859-1?Q?ADaQ9M3COD3owmH/W7CTrnLdv4SuJNL9R290Fv3LmbiuCQW/uE5/d3S2ZA?=
 =?iso-8859-1?Q?DrwhMD4K9EsqdlOyRNSTcrvP05oZou8qzxeD3bs7MQL4dnMn1HSqc9K8S0?=
 =?iso-8859-1?Q?GyCcVbBSDtHy5J9fVzaOymxHhuEh/fS1m5yzeRdvPQCOq6TqJ/xCn/sr3s?=
 =?iso-8859-1?Q?9tQiiJrbfgRr/fILUTK78KYBky5kVTANCoNb26FpKhfLkFwnomtdGD/g9g?=
 =?iso-8859-1?Q?u36RnPamJk8ubtOEkJC/v3QtSpVwBzTF42XuwkiuNbcSpnjCObcbMIBXNI?=
 =?iso-8859-1?Q?CEAqN3vzhVG+gxY3UJEg7q1NrhJtHyWkev1PzD+HDuI3gYPU7F5lH6AtCe?=
 =?iso-8859-1?Q?Bo3nbpbQiFSPXpspKwBI8HzOB8lsin/wmK8ziXitpCcTDusNHc7heFV5lw?=
 =?iso-8859-1?Q?4hAVd1/eYtG9ADjJx7Y=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS4PR09MB6518.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 036f0212-97d4-4cd1-642d-08de1bb3d77c
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Nov 2025 15:07:16.0961 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: i4S5bF1sCyHnjqVLATBbVyiXN8lwpb336TJnVdiFWPbC7IUGnbHpGTsijtwBiOiKdhoZ5JYAAiTYmzeF1UMf9PRbJnkxGCLjuJv3X9UTWf4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR09MB4155
Received-SPF: pass client-ip=2a01:111:f403:c200::5;
 envelope-from=Djordje.Todorovic@htecgroup.com;
 helo=DUZPR83CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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

We have already sent patch set for introducing MIPS's
p8700 CPU in qemu at:

  https://patchew.org/QEMU/20251018154522.745788-1-djordje.todorovic@htecgr=
oup.com/

So, this is a bugfix that should go on top of it.

Djordje Todorovic (1):
  riscv: Update MIPS vendor id

 target/riscv/cpu_vendorid.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--=20
2.34.1

