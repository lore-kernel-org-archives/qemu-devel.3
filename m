Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A014ACA0ED3
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2024 07:58:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1slkto-0004pE-FR; Wed, 04 Sep 2024 03:57:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=6977069e45=ian.brockbank@cirrus.com>)
 id 1slktm-0004gR-0p; Wed, 04 Sep 2024 03:57:54 -0400
Received: from mx0b-001ae601.pphosted.com ([67.231.152.168])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=6977069e45=ian.brockbank@cirrus.com>)
 id 1slkti-0001zF-TY; Wed, 04 Sep 2024 03:57:53 -0400
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
 by mx0b-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4844fbG8002298;
 Wed, 4 Sep 2024 02:57:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 PODMain02222019; bh=keL40RyiKyWwncL6n3aEPebK1zebybk7AnSipqpHt/g=; b=
 Y24BtL1DyiaURzVz24rAdNREUnb87RUyaMgyKCa8fR50DI16M7F6T9BjS2W6LeWD
 lL6u9g0tffIIHvhPHtmJB4LotKenADHKcDnq34noT/ybXHuwTt2n8pGY2KwbjjRQ
 QLgr3HcgolPe/zKj17IMGm2uCqkG4v/aqGnX1kSTeVrKuKRbVKZpB0NEYRwa5I0a
 wHsls1DoSZyfTL5UD1Fp2/Da/4O4TWBp70hWAfFcR8Y1WxlDzAjOlmGlXqXEInPX
 nHoRR22M+oLVpcl7X/yiEPbrZzGmLErWN1bI2bYksjFSR8hl5tRedQe7VduQb+sH
 t/L3lYTevrZFIdYIsFpZ6Q==
Received: from nam10-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
 by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 41bykkc7g3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 04 Sep 2024 02:57:36 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YblNvDhvLpDMUiAQAsjKDEXuDjwL/nobHmCUzcIQaH7uGcYrVAky4pZeaAU0gzF0JTMD7DR7j/ZXk1Fi0b6NlcSAyXH08Krn0A0EgrjqlGzLfLirI0wr4jlZm5By4b/gB5eiIlrCTFmwdEni7x7iu5tU3uigcxmtSoG9e8SCwNVZJHPQeWu7HtDpsoqzBt71PjYyrKGxFYjypEzJidTg/TkP02gv57uwcV+8GqM9RUFqjM3QPz0yW97WUaXgu556PV7V0kZCcWwSUkNK2DHaMZbgcd4Th80c4rXY5gwvmtJ1MJZjayNPFWyTja9K9xfNvtxQSbtLOLIkkWB+TXKTNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=keL40RyiKyWwncL6n3aEPebK1zebybk7AnSipqpHt/g=;
 b=hpxF/AYb+mRpm4737g7lKX3GLO65Lj65QzBvfKEUr+fqc3GA7EvbIp8r/g5YfGerxhawHN+OUAncg+/Iik4h5TCEJCSFcCpxkFme4EpnaUoseTUV1OaVdMMrNh3LK8i56utceuyIlMSmsS6wdLuAmNQ45ICIEdYd6A1xF/K4byypkLGFp0DZKrH9Ie9/EBfphcgnOHyo2Lufqb4mraNnVLsLrZC2lHojZID/1fkkDJlfrNh2IJa6H6zzBYXs9XmOYizbf/7dIeAhpujkiqadPgbe9ye3/Qlxm9jPxP4IRLHl5QQ8SmnSuvE9V87QqEKD1vcOfoL8iDyUWIXbbWCL9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cirrus.com; dmarc=pass action=none header.from=cirrus.com;
 dkim=pass header.d=cirrus.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=keL40RyiKyWwncL6n3aEPebK1zebybk7AnSipqpHt/g=;
 b=rTHtZOV43zDDtKdVfHSc9bEPRtq+HZmGw09leG9sGPJ/TVCDP6jJibYTmlMC2+XowLU1O2chm+wwIBlIx04tOwbQ00Z08avEY9DQiGGrHAmCxl2Ys6Wi8ycQ8gQHakuRuNwH/brAjYIbgpYQR7m5kluHzikqfYAdes2QvQe+wNI=
Received: from PH0PR19MB5193.namprd19.prod.outlook.com (2603:10b6:510:96::22)
 by IA3PR19MB8764.namprd19.prod.outlook.com (2603:10b6:208:50d::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27; Wed, 4 Sep
 2024 07:57:33 +0000
Received: from PH0PR19MB5193.namprd19.prod.outlook.com
 ([fe80::7e57:c9bd:575b:48cf]) by PH0PR19MB5193.namprd19.prod.outlook.com
 ([fe80::7e57:c9bd:575b:48cf%5]) with mapi id 15.20.7918.020; Wed, 4 Sep 2024
 07:57:33 +0000
From: Ian Brockbank <Ian.Brockbank@cirrus.com>
To: Ian Brockbank <Ian.Brockbank@cirrus.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>
CC: Palmer Dabbelt <palmer@dabbelt.com>, Alistair Francis
 <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>, Weiwei Li
 <liwei1518@gmail.com>, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, "dan.smathers@seagate.com"
 <dan.smathers@seagate.com>, "jefro@linuxfoundation.org"
 <jefro@linuxfoundation.org>
Subject: RE: [PATCH 00/11 v2] RISC-V: support CLIC v0.9 specification
Thread-Topic: [PATCH 00/11 v2] RISC-V: support CLIC v0.9 specification
Thread-Index: AQHa8lH45zAlJuNth0K5eV40yxlqCrJHWUxg
Date: Wed, 4 Sep 2024 07:57:33 +0000
Message-ID: <PH0PR19MB5193900DA565F0D0D90D627B809C2@PH0PR19MB5193.namprd19.prod.outlook.com>
References: <https://lists.gnu.org/archive/html/qemu-riscv/2024-08/msg00234.html>
 <20240819160742.27586-1-Ian.Brockbank@cirrus.com>
In-Reply-To: <20240819160742.27586-1-Ian.Brockbank@cirrus.com>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR19MB5193:EE_|IA3PR19MB8764:EE_
x-ms-office365-filtering-correlation-id: 105daacd-3e4e-4b87-042d-08dcccb73ba7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7416014|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?JG/d5NyfnEY0VoK2VCQIJLNBZ6xv2/0KZetsmGYo1qPoswZQVmLSLRliURBF?=
 =?us-ascii?Q?LlD3iDlYoeKu5JuIdajo50pT0VJIWXr0T2QfnvXyIqkArfMPwv9o6UHPJHzB?=
 =?us-ascii?Q?xzJp1Pe2Lh3oXY2aGOD9xpcgUf++4JnYYYWG7EbQzNNnm45VlphhiM+BkOH1?=
 =?us-ascii?Q?2MA5/wjWMz3e48La1GQ6txh/BwTsGSFsyNWS8pCW8KV7jUZdXGiFvPokKduZ?=
 =?us-ascii?Q?xVeBKTrsgj0pKrpMq3Y7QDuky8SyOXjDcxkthdMz7+Jr9xbN2Uq+ZXorJiSI?=
 =?us-ascii?Q?wTd0zEGaq4qzSltRFIlTjww3Zv80XozHMchwdTDVnvKyYwlmw395fDwKOj6J?=
 =?us-ascii?Q?pyM6gG6GNCfEpRYAuNagRV8IyQWNXUMU1afcY2QnRQ1jYPlFHhiEhCJdCEca?=
 =?us-ascii?Q?fMcjWTaLw4SUw9BLSTiYhpp+ZY0TiXwLZBEcts8MS8153exTXG9EmCe6YJkL?=
 =?us-ascii?Q?4mcqvfeNEl0A7JmhFsmPR0RCG251g15Jk9xNn/0p7GkJGpqTzs1/ZboK9BZd?=
 =?us-ascii?Q?cRfT2c3jfYK/HTpGxv3faMDIZBLCkk3+UZOhGVCxRNWBFNzct+gZwlB4fsJA?=
 =?us-ascii?Q?jojDqIXIuGWN7Q70i64VoFlYcwKn6S3wd6IehpR6JXB60itACZY9C56K55o9?=
 =?us-ascii?Q?kiIwbsHl0Sp3KeQZ8SHJJyPqAq3z0kavFWXtsd35VCaBaF3EjmhELj1gXWWa?=
 =?us-ascii?Q?LhfxpTdec/wgW5AAqbD6+BlHXUalql0UzaQWJ2Vhcl6nrvcVZ3gJYrrcU1XR?=
 =?us-ascii?Q?HurRyIy2YrHjwODBLROEcpy2Jonh5bl5I9kTbRYxYiblnMqCMiW4MaWHSCiB?=
 =?us-ascii?Q?FekY+xU4CtyE8s18Ahe1jOsD9HR/nCi5/J3QivjHy7H5gbrQaFOJ9BoPFNBX?=
 =?us-ascii?Q?Kf6fKFCJ3cscRDmKi+vGTVCS0Z6S20js/9D4OOlvfFva7N2m6efsfuQoYP4a?=
 =?us-ascii?Q?0q3kQUajF8geblR8c1KCXnx6iSnU5ziLKaRV3AB/gOia3wxXzlKcHNe5fZP9?=
 =?us-ascii?Q?rm2l4+JtsUt7nJRbz2sRVPIoSx3yloZz+pGSIcIQLrAtT5MAEOqEJHHe8umY?=
 =?us-ascii?Q?GlLfv21f/yVG6StkTO5n1PvHRVrjodJ5WcDSe8HiW71xucUceEEDD9tE1OG3?=
 =?us-ascii?Q?x5FTnMW9qUXUrqKoFMqTGDtHFv+Q0IET+IBd39QXyJlaWAk6ARHwSK7MKRx1?=
 =?us-ascii?Q?+PqGFEy/aSJVuc+70tTp9W70obhUxdWeR9vY8QSvgSKEZj8FhUvtdI9x5pJc?=
 =?us-ascii?Q?MhCLSvsjiPd5TkF2RDI8juGyYS12SnM0x3HE9Jdp1ExeN58ffYEZvPUCWgDQ?=
 =?us-ascii?Q?XYMH79W5Hp1KixYtiQanV5tPzdQeO5fJWRaPNg/+6VROzihRiWzm6oo/lWd1?=
 =?us-ascii?Q?fNwiPTk=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR19MB5193.namprd19.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700018); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?JRn3fnRy4o+pfhHX9wGDtuINj9qv/W7xDA3NBS5GH9i5WdrvTAd6zkZa1Dld?=
 =?us-ascii?Q?QqhjQBCgPA+Fa+q9Ul+Ln78QhIbs1cvKr1n7W4s1jrN6lMpC+CMLcyTWD2hN?=
 =?us-ascii?Q?SdGs1tWTq0+hczE9RUH7f278wP3tkkiMcfc9wXIC9dEHEPTvSf78cq7XkLxb?=
 =?us-ascii?Q?zW7n/bpXaXt5ql2klSbEZre3pNhTOZVhqO3Y09UTwMOnuLbptOXimLuPEtLf?=
 =?us-ascii?Q?1TFIAdeInwY475pHX7J2o9Ov8B1uuQ336pcT47K1jLawl+iw2tvHFfMoX85R?=
 =?us-ascii?Q?P6Cffv86XPnsV5SIAJkNDKpT2m6eAev3d8+YIXmgucrUs+n2OvQUPpglVNAh?=
 =?us-ascii?Q?81r1Wo3hvqs6iIoFrtJ78i1P5EW7UoGBHnBOhUrKAyjn7PBwlpiUb+MqLWvU?=
 =?us-ascii?Q?BPU0B+4+cCyCh5MmxL4+Q7nTFfABVg2Lx2zFkNNK6NVEx2IuHldbd8xlVkCH?=
 =?us-ascii?Q?0drQQl46+TphSGjkLlT1i2B0cEO7EJFoQjmJ3kUSQOzvqFuXsNkE+VprnNrs?=
 =?us-ascii?Q?cOaxYpTGgAIO1T7Xd/7MutbyjtH4DTqTNt2JukXjOtz6ZkkKNdI5fzxi0/Hz?=
 =?us-ascii?Q?SsR2enjM4DjDnDIkkW2a7H/jOJyfGvRWbqhfVuA6aeOqb6ThukjeuzKxmYa5?=
 =?us-ascii?Q?mRq28tr1Nzhh8uFUzvX2SIRr6sY25qYiCuZ7lFlNce0hwQYdOF0g0Nq13vlz?=
 =?us-ascii?Q?E7b817dvT1AYz7ArZa2U//PElihIXkNStJXwCeb/cKQHqhYgcmR97RISIl0j?=
 =?us-ascii?Q?2py9CKq8zAgqb8X1QmtJhXcj3MnQmh/xJs8GIaqXvIxBaSJfIhkyapaoB1wg?=
 =?us-ascii?Q?eWuXygIK0jGwBwihjdT3Z5r53juSoo5eBCFO+RS+Cn1TitkbaTsILthGxJR/?=
 =?us-ascii?Q?9LSFz1fonCuZEZ/rhFPR/DtCCH1o3uVfj2lrOPJEU7aVnkXeFUq2+VyzuySo?=
 =?us-ascii?Q?0lKcy8PnttEw4HV3MlBcEXL2D5D/XQr7lNwt3hcXtscm+rj8i5pz1IMvAgcF?=
 =?us-ascii?Q?Hdl5N1RUNDgEw1y8T10Z1JO2r1WEadqd/ZQ7CD73N6kOaNQcuQ7mSrCrFWDi?=
 =?us-ascii?Q?8YdU1Mkt4+TYw3OnNM7lNTAhgCk4e1KwwZoXgZqrBSFnv+SFtlm3KAffLxqY?=
 =?us-ascii?Q?RwWRNv1KS1oyMo8NuRvr0cmPcNZ0C63wCKADOf4IOsZgvnNGyfLli1xilRv5?=
 =?us-ascii?Q?0TiLCh35m27mfdRXtvpHorAKPUnZy53U6/EbiOl3iUUReFmpeAUJiGD6Dkzz?=
 =?us-ascii?Q?qZpaeHMFnsisdcmileDZu3ZylriuD03FVwNjwkUMfzLTsiEPrZ9RtyJz5III?=
 =?us-ascii?Q?TSUZ1fVkB4Hc9Bpczb6+dZZifkKO+IyA+rCXDmGSSuFTTYRXle9F8S/memuT?=
 =?us-ascii?Q?pRd29ve4Q881QWu+h39NA+SuuwkrzpcrEqiMZcPzNiM93YrItduYqxdKtZSs?=
 =?us-ascii?Q?yWHyl+q6mIJTgnVFqNNxYXov3+tECOm+hephZ5kXmRJuc9tgzrduazjD6ZIM?=
 =?us-ascii?Q?kVD8NVb7p68tNjtQ+784cJUgGmozX6T+nBqRZsxwrorO2avMT8WLDhx8FA3/?=
 =?us-ascii?Q?eEKtCAl2Wgm0p6HPsR6iAm4zUhA1H6n42AjZHJDC?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cirrus.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR19MB5193.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 105daacd-3e4e-4b87-042d-08dcccb73ba7
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Sep 2024 07:57:33.1061 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PX43Vu/BA3zvTToRBNK4voYmVwVOFtFUwSK5JbqD8GjdhsOL3yFpDAunfhEOa5jAMuLlT5YHd/BsjEIgN+Pf0T2fubPxVLsmKceowOwApmY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR19MB8764
X-Proofpoint-GUID: Ud_3bRqoOAPozf1hQpJ0Y1fY1o0353mp
X-Proofpoint-ORIG-GUID: Ud_3bRqoOAPozf1hQpJ0Y1fY1o0353mp
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=67.231.152.168;
 envelope-from=prvs=6977069e45=ian.brockbank@cirrus.com;
 helo=mx0b-001ae601.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Hi All,

Has anyone had time to look at this patch set yet? Is there anything I can =
do to help?

This implements https://wiki.riscv.org/display/HOME/Fast+Interrupts+TG, bri=
nging the draft implementation listed on that page (almost) up to date with=
 v0.9-draft-20240314. The implementation has been verified to match the Cir=
rus Logic silicon (PRV_M only), which is based upon the Pulp implementation=
 [4] as of June 2023.

How can I help move this forward to get it merged into the mainline?

Thank you,

Ian Brockbank C.Eng.
Senior Staff Software Engineer
Cirrus Logic | cirrus.com | t: +44 131 272 7145 | m: +44 7554 008061 |@badg=
ertaming


> -----Original Message-----
> From: Ian Brockbank <Ian.Brockbank@cirrus.com>
> Sent: Monday, August 19, 2024 5:02 PM
> To: qemu-devel@nongnu.org; qemu-riscv@nongnu.org
> Cc: Palmer Dabbelt <palmer@dabbelt.com>; Alistair Francis
> <alistair.francis@wdc.com>; Bin Meng <bmeng.cn@gmail.com>; Weiwei Li
> <liwei1518@gmail.com>; Daniel Henrique Barboza
> <dbarboza@ventanamicro.com>; Liu Zhiwei <zhiwei_liu@linux.alibaba.com>;
> Ian Brockbank <Ian.Brockbank@cirrus.com>
> Subject: [PATCH 00/11 v2] RISC-V: support CLIC v0.9 specification
>
> [Resubmission now the merge is correct]
>
> This patch set gives an implementation of "RISC-V Core-Local Interrupt
> Controller(CLIC) Version 0.9-draft-20240314". It comes from [1], where
> you can find the pdf format or the source code.
>
> This is based on the implementation from 2021 by Liu Zhiwei [3], who took
> over the job from Michael Clark, who gave the first implementation of
> clic-v0.7 specification [2]. I believe this implementation addresses all
> the comments in Liu Zhiwei's RFC patch thread.
>
> This implementation follows the CLIC 0.9-stable draft at 14 March 2024,
> with the following exceptions and implementation details:
>  - the CLIC control registers are memory-mapped as per earlier drafts (in
>    particular version 0.9-draft, 20 June 2023)
>  - the indirect CSR control in 0.9-stable is not implemented
>  - the vector table can be either handler addresses (as per the spec)
>    or a jump table where each entry is processed as an instruction,
>    selectable with version number v0.9-jmp
>  - each hart is assigned its own CLIC block
>  - if PRV_S and/or PRV_M are supported, they are currently assumed to
> follow
>    the PRV_M registers; a subsequent update will address this
>  - support for PRV_S and PRV_M is selectable at CLIC instantiation
>  - PRV_S and PRV_U registers are currently separate from PRV_M; a
> subsequent
>    update will turn them into filtered views onto the PRV_M registers
>  - each hart is assigned its own CLIC block
>  - support for PRV_S and PRV_M is selectable at CLIC instantiation by
>    passing in a base address for the given modes; a base address of 0 is
>    treated as not supported
>  - PRV_S and PRV_U registers are mapped  onto the PRV_M controls with
>    appropriate filtering for the access mode
>  - the RISCV virt machine has been updated to allow CLIC emulation by
>    passing "machine=3Dvirt,clic=3Don" on the command line; various other
>    parameters have been added to allow finer control of the CLIC behavior
>
> The implementation (in jump-table mode) has been verified to match the
> Cirrus Logic silicon (PRV_M only), which is based upon the Pulp
> implementation [4] as of June 2023.
>
> The implementation also includes a selection of qtests designed to verify
> operation in all possible combinations of PRV_M, PRV_S and PRV_U.
>
> [1] specification website: https://github.com/riscv/riscv-fast-interrupt.
> [2] Michael Clark origin work:
> https://github.com/sifive/riscv-qemu/tree/sifive-clic.
> [3] RFC Patch submission by Liu Zhiwei:
> https://lists.gnu.org/archive/html/qemu-devel/2021-04/msg01417.html
> [4] Pulp implementation of CLIC: https://github.com/pulp-platform/clic
>
> Ian Brockbank (11):
>     target/riscv: Add CLIC CSR mintstatus
>     target/riscv: Update CSR xintthresh in CLIC mode
>     hw/intc: Add CLIC device
>     target/riscv: Update CSR xie in CLIC mode
>     target/riscv: Update CSR xip in CLIC mode
>     target/riscv: Update CSR xtvec in CLIC mode
>     target/riscv: Update CSR xnxti in CLIC mode
>     target/riscv: Update interrupt handling in CLIC mode
>     target/riscv: Update interrupt return in CLIC mode
>     hw/riscv: add CLIC into virt machine
>     tests: add riscv clic qtest case and a function in qtest

This message may contain privileged and/or confidential information. If it =
appears you received this message in error, please notify us by reply email=
 and then delete the message. Thank you.

Cirrus Logic International (UK) Ltd and Cirrus Logic International Semicond=
uctor Ltd are companies registered in Scotland, with registered numbers SC0=
89839 and SC495735 respectively. Our registered office is at 7B Nightingale=
 Way, Quartermile, Edinburgh, EH3 9EG, UK.

