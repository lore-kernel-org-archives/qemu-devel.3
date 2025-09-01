Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82BC2CA0FFD
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Sep 2025 10:33:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ut1n8-00041v-OJ; Mon, 01 Sep 2025 06:29:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1ut1n6-0003zK-55; Mon, 01 Sep 2025 06:29:36 -0400
Received: from mail-northeuropeazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c200::1] helo=DB3PR0202CU003.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1ut1n2-0005M5-Th; Mon, 01 Sep 2025 06:29:35 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iIfz9sSwXTDNG6/lwvIf4CjZOxFr+6hGR130S426m9zEjrqLHLwfjaV/FMyzrl0GicPlAmwByb16IkIzGOFUVtBO0ED8YTVJbrOT/BaU8UzyuWMYWKucGxrewmlMSpMRRRNE83yE6tj3FjC+jdzoMD/FigR2nvgHgKidvocI1T2leCbtUgMdQLtEwxY2hX/V2OKYy2rP/9AURUj8yrweOGNN9xxO4ALcyfF+7KvX+YsU2YUjDXvmJEfDAWfcAe/ahW3B4WlQC/0m+6RSsLmNo39P1mUOAUrwcXwj+dLlguC861jLjrcySDiXmwbA11MCGrZWtt/GxWlv8KGB6K8C3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NqNMig6HVfssfosq1TSyKo4l8Atn+fKAgZEM9aORO24=;
 b=eX55qEosGFuZfu/7dfu2Qiun5oytH7CxKGQS/eMko/J9voPtnmg9SWwd5YsL/jBKsCWGRzQ5PU56klgz8m98xtYgZzeUhgaG7024rNzrSjwQf8HGYTLsllaRJN2cKqL6dtxbXOS4WD7P1F5gU3KCJbUbjXsuYS/wM3q2HNA/kvM8zGovIuV9bCHfqaq0edDrDMc/0C+opK6EMQAoV1/D4LrH7BdjO6zqgccwzeoAhmSj81igTUWmuu24xnBvGlKNu8QY6Myto0TC/EvXQPBOoWYpkRWSENVr7IaQTi5GU3gntJBj9Krf9KtPpzLwbv5RCQS+fP1wcmvJTviBW+5NEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NqNMig6HVfssfosq1TSyKo4l8Atn+fKAgZEM9aORO24=;
 b=hiYp2TKFqzQeiB7E0neEuI5vLH2769WLwjtbeLkyPWPAk/oO9VUrivbRJtqxUEETtux1XLFmw+/ecX2DNbFOsrFN7zogJs277UEtVNBf+bAoNIsf03XKHKWfHiZYPE65iF8Owe4h+MwFDlwb5+g2teBitbBgKI5IUXpqFJcMzPJZVVGKnemFMYivS2+8VNLy7mO0LQBvv1BGF1ZUylK7TFRMlo8+T1tqV4lkjt4rlofw32vKMnOsphiynSSrSocgATLhKHHFx9Gklc5taM62sslCVbrmmKUR4/apqLZX/5XZX2194VPpn9Y0ShZL7hSm24lj52ShACVWMbRc7V0XQg==
Received: from AS4PR09MB6518.eurprd09.prod.outlook.com (2603:10a6:20b:4fb::5)
 by GV2PR09MB5992.eurprd09.prod.outlook.com (2603:10a6:150:be::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.28; Mon, 1 Sep
 2025 10:29:00 +0000
Received: from AS4PR09MB6518.eurprd09.prod.outlook.com
 ([fe80::ad50:891a:847c:580a]) by AS4PR09MB6518.eurprd09.prod.outlook.com
 ([fe80::ad50:891a:847c:580a%4]) with mapi id 15.20.9052.019; Mon, 1 Sep 2025
 10:29:00 +0000
From: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "cfu@mips.com"
 <cfu@mips.com>, "mst@redhat.com" <mst@redhat.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "dbarboza@ventanamicro.com" <dbarboza@ventanamicro.com>, "philmd@linaro.org"
 <philmd@linaro.org>, Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
Subject: [PATCH v7 00/14] riscv: Add support for MIPS P8700 CPU
Thread-Topic: [PATCH v7 00/14] riscv: Add support for MIPS P8700 CPU
Thread-Index: AQHcGys7pGZwLMQhx0O/tcd8PFR2tg==
Date: Mon, 1 Sep 2025 10:29:00 +0000
Message-ID: <20250901102850.1172983-1-djordje.todorovic@htecgroup.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS4PR09MB6518:EE_|GV2PR09MB5992:EE_
x-ms-office365-filtering-correlation-id: 0ed86b73-d0ff-4f9f-37c8-08dde9425dcc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?AQ8eUPoIMhKXoMvshakenNhQD+cQMBLPddO3bywcQoz9PUWZbSxSX7QQFM?=
 =?iso-8859-1?Q?7v12oWfnlpFirWn47CWyjzO9ZtrqdqpWgq3iTmx65cjiskavp3p1KDTPIR?=
 =?iso-8859-1?Q?qtUxc0T9P5bR+QUsLOADV4fiTsWHPirSi7YYDhR+3aV72HWwSitXpuleZJ?=
 =?iso-8859-1?Q?gECcQg3Tp6DJKNO8hINw9Wz9/jLLumKVYiwucDbwP368wsAMlLWqhUKGm3?=
 =?iso-8859-1?Q?qIXJMyeKV6QeRj4eMjnhWR9ppUx9I6g19VlSvINvEjyBuXb59TRSy66sQu?=
 =?iso-8859-1?Q?tMXaw65dbCNwTykTUyHlCt0QAPOsN9buGq15fKE74duSG21zzp25JhvQbi?=
 =?iso-8859-1?Q?bKGXEQX0z3a8DlK0fzVzIoTIgpE4Rg1yD0URh8Ih2gea9b+hOLzl77oo4O?=
 =?iso-8859-1?Q?tHhPkLCzIoJ6txxNoWmMFdDdkG5wcIAatseN+0xxmwZXl8FPfGkP7rcJ7L?=
 =?iso-8859-1?Q?e5mi5Z7UDsTHucD2q7CayR0Zz79GYAdsE05a5vuQv+4DAeTj4NITXZn2Rc?=
 =?iso-8859-1?Q?J4GKlIYsg6sIQDzuapvBo0SjlFBOF1GZnt4bMg73X/33BABggxFs8yIL3T?=
 =?iso-8859-1?Q?mqGY00XIRnafdeRhHxyZyjLkeZZ9dstpOKJqmrM0xxeDg/D3O00YPZVlgX?=
 =?iso-8859-1?Q?OQKtiEE1he6WPpWP7CuUFkeE917sAL3emYalpfCj1qnt8DUU6n50Ag/vXr?=
 =?iso-8859-1?Q?ET0niHA/PS5eRUx7oJXyNVaGr+LUek6wUtRs+OfhATCmUywjmHmWqGovc+?=
 =?iso-8859-1?Q?Rs6HvLt1RdyBUlEz2rnlL+F/xoPkSBPwPBAjIlIq/JM8BssiFk9dIVuKEq?=
 =?iso-8859-1?Q?vhAGr3werEEKKE8XTZ+Rh1U6oT53ErxOAM/8kh33H6Mp24kj4f7db703Qz?=
 =?iso-8859-1?Q?zLKMQvEvwOaX13BcP9F9bW4g2UfqYNdkrHRBcr4n6cTCp168eVTXHcMdyw?=
 =?iso-8859-1?Q?BtVB7LmRlN/bMqsxrL8kaMpQEHBqa4TbJJgzAaWH+6R3HIawcUcjP+ddp6?=
 =?iso-8859-1?Q?S/YXkQhP8whD+QKmCPFOIUJumL1b0HVco9mVDWDz72W4FRhlokuXnjMm/l?=
 =?iso-8859-1?Q?EW6Xpo99Q0spFR9aL4L/XqC/6b3S60zrOKh8Bu2EkHvasU67zk+hBO/Ult?=
 =?iso-8859-1?Q?xraIgvETfcRAEfj24w6ErGbzfX/NgNocd/xujJc5Ti63xviN7cLmD0SFpJ?=
 =?iso-8859-1?Q?m2kpF4sofwJTu1b/kjb19kl5FBMTIpRCWsM/fmGVl1C4SYNU8lSCnKQykI?=
 =?iso-8859-1?Q?iFzaDgIgCZo9PF7raj7kAfUCjOweV/C1wkYkIncakYSNe4DjdKkkSaA7aQ?=
 =?iso-8859-1?Q?YQJrl4pWgvVa1muA/CbWO8XcR916qn3E+wl2xYSeFMqAgSQTON6ROrATB9?=
 =?iso-8859-1?Q?ILeKWIytIANiukmBVVVMQ8diAorQEuGrbVYcnKCUp6L87hNcPpawrVLXj7?=
 =?iso-8859-1?Q?kmb1rpf4xnF366/y8RN+X9URgJN7jn0R/CTHFWS2t7LzdmkXQBfeMgISif?=
 =?iso-8859-1?Q?Apb3D2vdfMrNvkmwNZrsSnH/OYiTA6quXHE24OrtpV9w=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR09MB6518.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?jvuD0RXqPwQeimBTAYpzlbANjNoBQ4EE79o6qFS3ih9UfRjRyqLnl2HpMk?=
 =?iso-8859-1?Q?cOMckbJuWC4NRfs4IDHeoaF2BUKkocsU/4WnkNbbgncNqTDp48etU5iHni?=
 =?iso-8859-1?Q?TeiZ0VWrloVLG3YmTAQxE9rzSiueiZ4Tbs1ynQSFSpZ6k9ssVKh5Ay3LIi?=
 =?iso-8859-1?Q?Sv4QD4u4g8tpPmSsVA9xcLrE76xFrzvIy0WGMV1NLYPMR7YodfVGv8Otst?=
 =?iso-8859-1?Q?tficBa8TgfTu9rARpeFs7J8k6TyvKzklRE18xM3qcN6AkHl3n+PuMPwrc9?=
 =?iso-8859-1?Q?LpoIkJjE2P5waPyL/kzdcfMMu1wCpBmeV/qTwU384WhRP0sosF49HQhYsm?=
 =?iso-8859-1?Q?4IAjat9U2MBRrcdMAY8qOuLyRCc3DEKljEnIoCh9wYvR6e2sRwOsJw5iIl?=
 =?iso-8859-1?Q?mZq1cz38UlA+CYt0Kln20vRw/zZms+pFWT6vPSa1XtLMJq7riylAgOfkLv?=
 =?iso-8859-1?Q?7YWPOq/Ipn35simvrQHvqRGzcyjUTZzzfS5VOroX54FUul86OyPgBCYbw7?=
 =?iso-8859-1?Q?qt2gcyhM9JciVqds3FAuM9tKlKXwaKMJG1hNHtR0lMZstfGd3wY+1HBzka?=
 =?iso-8859-1?Q?deo3XVOrnrYTLc7wcpdKSeBRUGOaOd3n2FmAaEjnxVNMPlYqgYi8B9xikI?=
 =?iso-8859-1?Q?Yt6eE3rpSfBkAz0Zha53iHEfKlX9wGx9+geztxWUO8LTXiLKh0h2MCZr8I?=
 =?iso-8859-1?Q?os3s4AM7voYfgWthQNp+BbrcM7HjhVdVSuK/F6BP7N4Z/8aypLQRx+3Hop?=
 =?iso-8859-1?Q?fePtRjD/MneovJhiCgiyeKZUvbPvz1Vitwvo8GH1nPvG6qApfd6HkhV2Gs?=
 =?iso-8859-1?Q?zHkxtFM3m+y2QR/SPk8XGFjcNtlz3XzMQWdSXZgCi1d1BzVS8d6IiJ+kM/?=
 =?iso-8859-1?Q?/KM8hK8uW4G4jZYhGmiN+d0ABCOpCiJKAMwTy82uRuIrPL0X0d490my5XW?=
 =?iso-8859-1?Q?/TqWHW5J2gpTU6EuZpI2M3EzWQ3g96jcxHtvzyPYLkLd0tF10N+WVHeJQJ?=
 =?iso-8859-1?Q?KdiFz/xyaS/iBREdiknqr7onwSXMz3HGKuk/f/5aegr0onlKjVBCYeN6og?=
 =?iso-8859-1?Q?WdCyApo6lAxjYmRiNlpihb0F3cGuTsWyBw/Tu7JB7XU7afoGPmuZFPhC3O?=
 =?iso-8859-1?Q?vrvyawX6Ey3Brcpr4MaID68OxyU/5Nypsw9qouQbjBnBUYWJGBUlGHWzEG?=
 =?iso-8859-1?Q?ThATVsYYWUZLI2HAkh0247yztruZLmo11pGGNq2gAbzAtP/x7EOuXYz7ZN?=
 =?iso-8859-1?Q?r/DQJbPFFI7zscDa3oXsffAQu8Ff+xOCHzUEZ8u8U9jwiDSsUV08iq6Wj3?=
 =?iso-8859-1?Q?H1SgCcfbXqvdTJe5K/cJqoeDzIIX76uQZws93OnFECT0Od7N5y4COYoVxc?=
 =?iso-8859-1?Q?Ej5KDBhsqtgS2e8FjJ/CThjrxZRrEums2hW84cdgAFZNeEhttd9Mdcdj7V?=
 =?iso-8859-1?Q?hFDcgCZYNMaC8yoPu/SDqjtnfjshZFXMVT8qLNOOVUdOPsIMagnM6GM4Az?=
 =?iso-8859-1?Q?Qx6MS6sBcYCiwUD5dfMp0KJNVfCgnTZ5756QJd9tdCgjnK7j85o4w3y+e/?=
 =?iso-8859-1?Q?tr9OATF6c4lDDasEAXMI6i4SZ2j+kxlGgYNCfepSLQ1QrRpPRgsxKwHX5o?=
 =?iso-8859-1?Q?SZb0RsZ0lHnVmDVW5U0JX+tdf1nq/I6rDfoqc7fFxWmn+hRXRRxZFO4pxu?=
 =?iso-8859-1?Q?gT20VrdVT4ePeJF5KuM=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS4PR09MB6518.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ed86b73-d0ff-4f9f-37c8-08dde9425dcc
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Sep 2025 10:29:00.6773 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yL6HgEgzTH3hfFwCDUjz49Gg0hxIa6JxKIXoa4CUTEp31S4NYR1EoKuIJ0IoxSdwLX1bw14fjRFOO+DHwHQAszjx9nnZMvTh5iBqjQeCAVY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR09MB5992
Received-SPF: pass client-ip=2a01:111:f403:c200::1;
 envelope-from=Djordje.Todorovic@htecgroup.com;
 helo=DB3PR0202CU003.outbound.protection.outlook.com
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

I addressed several comments in this version. Major
one is that the test we added now point to [0], where
we keep artefacts such as Linux/open-sbi binary that
contains XMIPS instructions as well as rootfs for
P8700 CPU.

I also added reviewed-by/acked-by tags for the commits
Daniel Henrique Barboza already checked.

[0] https://github.com/MIPS/linux-test-downloads

Djordje Todorovic (14):
  hw/intc: Allow gaps in hartids for aclint and aplic
  target/riscv: Add cpu_set_exception_base
  target/riscv: Add MIPS P8700 CPU
  target/riscv: Add MIPS P8700 CSRs
  target/riscv: Add mips.ccmov instruction
  target/riscv: Add mips.pref instruction
  target/riscv: Add Xmipslsp instructions
  hw/misc: Add RISC-V CMGCR device implementation
  hw/misc: Add RISC-V CPC device implementation
  hw/riscv: Add support for RISCV CPS
  hw/riscv: Add support for MIPS Boston-aia board mode
  hw/pci: Allow explicit function numbers in pci
  riscv/boston-aia: Add an e1000e NIC in slot 0 func 1
  test/functional: Add test for boston-aia board

 configs/devices/riscv64-softmmu/default.mak   |   1 +
 docs/system/riscv/mips.rst                    |  20 +
 docs/system/target-riscv.rst                  |   1 +
 hw/intc/riscv_aclint.c                        |  21 +-
 hw/intc/riscv_aplic.c                         |  11 +-
 hw/misc/Kconfig                               |  17 +
 hw/misc/meson.build                           |   3 +
 hw/misc/riscv_cmgcr.c                         | 244 +++++++++
 hw/misc/riscv_cpc.c                           | 271 ++++++++++
 hw/pci/pci.c                                  |  15 +-
 hw/riscv/Kconfig                              |   6 +
 hw/riscv/boston-aia.c                         | 489 ++++++++++++++++++
 hw/riscv/cps.c                                | 209 ++++++++
 hw/riscv/meson.build                          |   3 +
 include/hw/misc/riscv_cmgcr.h                 |  50 ++
 include/hw/misc/riscv_cpc.h                   |  75 +++
 include/hw/riscv/cps.h                        |  76 +++
 target/riscv/cpu-qom.h                        |   1 +
 target/riscv/cpu.c                            |  41 ++
 target/riscv/cpu.h                            |   7 +
 target/riscv/cpu_cfg.h                        |   6 +
 target/riscv/cpu_cfg_fields.h.inc             |   3 +
 target/riscv/cpu_vendorid.h                   |   1 +
 target/riscv/insn_trans/trans_xmips.c.inc     | 142 +++++
 target/riscv/meson.build                      |   2 +
 target/riscv/mips_csr.c                       | 228 ++++++++
 target/riscv/translate.c                      |   3 +
 target/riscv/xmips.decode                     |  35 ++
 tests/functional/riscv64/meson.build          |   1 +
 .../functional/riscv64/test_riscv64_boston.py |  71 +++
 30 files changed, 2042 insertions(+), 11 deletions(-)
 create mode 100644 docs/system/riscv/mips.rst
 create mode 100644 hw/misc/riscv_cmgcr.c
 create mode 100644 hw/misc/riscv_cpc.c
 create mode 100644 hw/riscv/boston-aia.c
 create mode 100644 hw/riscv/cps.c
 create mode 100644 include/hw/misc/riscv_cmgcr.h
 create mode 100644 include/hw/misc/riscv_cpc.h
 create mode 100644 include/hw/riscv/cps.h
 create mode 100644 target/riscv/insn_trans/trans_xmips.c.inc
 create mode 100644 target/riscv/mips_csr.c
 create mode 100644 target/riscv/xmips.decode
 create mode 100755 tests/functional/riscv64/test_riscv64_boston.py

--=20
2.34.1

