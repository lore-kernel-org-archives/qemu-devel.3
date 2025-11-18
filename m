Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D8AACEBF93
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Nov 2025 09:00:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vLHXd-000859-2S; Tue, 18 Nov 2025 03:58:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1vLHXa-00083g-Uv; Tue, 18 Nov 2025 03:58:23 -0500
Received: from mail-francecentralazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c20a::7] helo=PA4PR04CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1vLHXZ-0003VY-1c; Tue, 18 Nov 2025 03:58:22 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fSqU9FhN3Hw+4Pwb2dSOCB0h1QMNrlTp3XWh27cVaR4+NTl3hvF9+z4Ec/xbTOijhjZ7/yfu0SWkvKAwShZ0KTMK2TCEKDVDY80D46/wdxUOpWKgrMq5EGzduQFIFiHIwOIovNTUnSYVB6UmCZkB24dwPjaVyrD9JkBID1/Fyj73JIpS8qNuGovOTYp0S7enp/pEkLzPlfo4Eo1o69DWrC2h6B6llZtCXztNfOA1l38yMrmdYEneiuDGGjzoR97SPzEtlIXYwCWHTRk/ZgTuGpJffFLRLDZcJaamqM4wYdXykwNMDz8kZACMavWcfyMgHjCxVRoFglSz4nV6Mn+bmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2braOq5ecbz3Vm8ktPLzy3hIhWI8JevJoJP4vfqqmZ0=;
 b=tAzk/hfPwpJnI7T4NcxY/FSM0Kum+OUSXOYw7aSbSVaqcqW33o/bBzR0AGBgvoXcCBh1yq1qDt21cNncUHpeF9qvnxeaBA6+Px5LJF26J2K+KHy+fcfi5Rxix3ALQkZ5UfOg7wVQulbmuwabJrbq7UvThdfkxM4pUf3ZM5tZHW5ighwsZaCetI43mVg2ijgiA6I5xxxO34e1J7bCjhJpLXnU7USRd7/Hpel1OrFuE1OXIRJxaXzoD6SrWxo0S/m+bUrXmKbrPj8I5ZHFWQkXqZdSNUOcwdZ5MTLgf/A7gHQF6JW/7Om9QYS5f308sW+nFpFzt5YMWC8IqCYldvK5ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2braOq5ecbz3Vm8ktPLzy3hIhWI8JevJoJP4vfqqmZ0=;
 b=GX1AVxF4q7Dm+CzhCMTVKpT6xcrNlEGTh7mF2w7XnAKppHqbcbo2Mz6WAUyaI7Ohg0gXWKO6PTbDXmXzwne2TIbZW4cP/VB3XjmOI4PjCWahnbs7ALbzzWQBShOXHcInm8czZ977N3cxDtwghGfNHTl9+zOKX/zZ7RBbPJhvNXAr2cuO3i9t10enxx6zLgXxJ4SI+0dfWpnaq2i5a+tAqCkMz59bI6hhHNr4rf96z5c6QdqdeCjaEnAqqv2BhPXIHZshwxN+nnXBc89kpq3AVH7tKQQEnq52slYgyqAqat82nwJQChHkBrXpzqb339/6cAKwOPW4y58Vlnw9ZZ2Aog==
Received: from DB9PR09MB6506.eurprd09.prod.outlook.com (2603:10a6:10:303::20)
 by DB8PR09MB3612.eurprd09.prod.outlook.com (2603:10a6:10:112::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Tue, 18 Nov
 2025 08:58:07 +0000
Received: from DB9PR09MB6506.eurprd09.prod.outlook.com
 ([fe80::1eb3:5638:369d:24f2]) by DB9PR09MB6506.eurprd09.prod.outlook.com
 ([fe80::1eb3:5638:369d:24f2%4]) with mapi id 15.20.9320.021; Tue, 18 Nov 2025
 08:58:07 +0000
From: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "cfu@mips.com"
 <cfu@mips.com>, "mst@redhat.com" <mst@redhat.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "dbarboza@ventanamicro.com" <dbarboza@ventanamicro.com>, "philmd@linaro.org"
 <philmd@linaro.org>, "alistair23@gmail.com" <alistair23@gmail.com>,
 "thuth@redhat.com" <thuth@redhat.com>, Djordje Todorovic
 <Djordje.Todorovic@htecgroup.com>, Alistair Francis
 <alistair.francis@wdc.com>
Subject: [PATCH v14 05/14] target/riscv: Add mips.ccmov instruction
Thread-Topic: [PATCH v14 05/14] target/riscv: Add mips.ccmov instruction
Thread-Index: AQHcWGl1mLWvIFKqckeddw2NQ2ESjw==
Date: Tue, 18 Nov 2025 08:58:07 +0000
Message-ID: <20251118085758.3996513-6-djordje.todorovic@htecgroup.com>
References: <20251118085758.3996513-1-djordje.todorovic@htecgroup.com>
In-Reply-To: <20251118085758.3996513-1-djordje.todorovic@htecgroup.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB9PR09MB6506:EE_|DB8PR09MB3612:EE_
x-ms-office365-filtering-correlation-id: 03037c19-95e0-415b-defb-08de268097ae
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|7416014|1800799024|366016|13003099007|38070700021; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?RxHLoWLq4HzqK7bT8r46J+eELINQ5lF7J1K+Bf0iFWx6RP8XoIvoZHGxTK?=
 =?iso-8859-1?Q?EBfDAFsXgq0/86SLNz156cr5kf419noaNMwfbh08frR7XTQDtrN64duuq6?=
 =?iso-8859-1?Q?hP4K3z/8Nm0pCUicO9CIeGuboXY1dy/eEBrQmx1fWmQPY5Ht9l9FOhBZ37?=
 =?iso-8859-1?Q?/pcUzEfmkPMZO9c8WJguBhGrJTRRAv3baR2Ta5BK3q6QuYr42DrcRlobAH?=
 =?iso-8859-1?Q?nSMcZm+QgEPw44YUjWvo2yDxtpDwvczy94mkqZdWofqHW5OruPZdioNW5/?=
 =?iso-8859-1?Q?FEIGS2dEOAqJa88h6l5DFBoyfTRmqpW/OupeNFYSrlDzDjndCpOgbRV2ut?=
 =?iso-8859-1?Q?ZqyLqZKbkUD420tPxAPUxQCS62d4tJgT9xZOwZ8d4ASjtuMIofv4VZUPbh?=
 =?iso-8859-1?Q?NzKddHXejWjz7dU2fIRivUbNaXBqKoSwjciMCpQHKFwYkEEj7Yo5dATuTV?=
 =?iso-8859-1?Q?EO4EE4qIwF3GIYgrjyoaTDDNQKbJvz0rW2od/m4cT52aJAjI0QEeq56xRi?=
 =?iso-8859-1?Q?hOnIlGNxPoA949cDAFPlxXzqTr9sur7MVuPNPCKwzsPrss3/j6OZaal1UN?=
 =?iso-8859-1?Q?GDCpd5+BwF1ZKheZ3EVHK9RMklyraQAov0tab1jvsdEb6A9BTJyZKjLYD6?=
 =?iso-8859-1?Q?YQ53AR1qRMDYFuoZUpS7PtwSjpv9aYi37MOf9Z6MkWhjSB6F6IsS0TjZNj?=
 =?iso-8859-1?Q?luYpo4XYR0wlPAx+21Mz+flmTnvI0MMXquqtyxFFC0f5M7ib5EFXU5BpB+?=
 =?iso-8859-1?Q?3iunHCu93kLsR7letrXhfr2uAmaxQoF1KPkwyRi+I20Jo0Xnn0DjwnjdVl?=
 =?iso-8859-1?Q?XcQ9yF+AZfa73geA3xKKoTa64XahT+AATr6ySVvsYu10jjsmTUfUdAUx8e?=
 =?iso-8859-1?Q?PEGQX+kHV+wmuVNIFTkUBdV9/9iAsg/HEN/RPcqF/LfN2BBXt+HK6DE4Ai?=
 =?iso-8859-1?Q?yAUsSwAjplKz4AKj5sVN5JPmR7zFjsAoSfwwtylO3m1BGAwHj2bcJxsf3u?=
 =?iso-8859-1?Q?RSH5D6VXIZpbZVU0Y4IaE6Uhkg/SA+S1kkntmOQohFtExFX9u27Qpswhv0?=
 =?iso-8859-1?Q?pr2/po9cLw1rMtkVPkL3PvQktAg41y4MDYSKOZNQDCtXd/ZMt7q/zp7hr4?=
 =?iso-8859-1?Q?tmCQs3lNAndby2knZMrYWdvPuX8UjuK5qIoCOqRKqw+gm1t+X5cIlcH2Gc?=
 =?iso-8859-1?Q?SA58ma3LzL7niYJYK8Ig+MXoadY14073lUhRC4Je7rbvrQCf9GLAunEmDb?=
 =?iso-8859-1?Q?kywiivPN6RpAM4pppml5aGtfvQ5byH2S2Aad7xyoQIbcW/TBhz48qdCnoE?=
 =?iso-8859-1?Q?t05ZHN6s9iGWIJwkw6ZnGUPzpsB0ZI1FnPDimFbVNw4vafEESWso3LBmOr?=
 =?iso-8859-1?Q?e9Yh+y2Xisy/Sjl2rCUqFcafuw6CnDAFV+f/yWyzReDDL6O19BhZLwCK4M?=
 =?iso-8859-1?Q?qKIhc1VDKWLy03lqY7Ta9oudyk0q3Cak6CvX56HcCQEK5pVqoKgroW4D7u?=
 =?iso-8859-1?Q?FuyCjSLX88NKyxewfGRrUHvK66bOgSwgoCw2O9ks8EjiMGrQt422zqhpIj?=
 =?iso-8859-1?Q?wqPigIpVfg/ga8/TxNJcUFroQHIZ?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR09MB6506.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(366016)(13003099007)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?LQah59tHwUqteMHxuIedcqY3pwBUQmQqPryXhes8+Aa9LmfO/07RLRE5Jb?=
 =?iso-8859-1?Q?O+6D5ihIDhcq7V7mY9YDBU7q7LtJDzEUWFjjeRi73J5meQ/zXsiUYZzbPO?=
 =?iso-8859-1?Q?Q73HuJD7tZAQyr+0SjWurOlvSgeeCSW3V0Im4xLHNb6vo/Vez/yUu65mLm?=
 =?iso-8859-1?Q?dhcb8tmllktkkts+nRfscucUOPLa59w0FwQxKu4ZSif0inBFJPGE6EYotk?=
 =?iso-8859-1?Q?G1amvAYAr394AbmWelnUNrvBiZ0NSWJ2xemGQVy+Auczx6q1TBcY5BjyMY?=
 =?iso-8859-1?Q?WDcylutkPcN9oWllYpO8A8ayXq9NEpKH7jN7yf3HLXiy4iGKjQgEGAb7F1?=
 =?iso-8859-1?Q?SwZXM+W3uLz3Umt4Ez1AnF12poHKn1SMjy/flIU0gEhXkB3oqMELNzjFGi?=
 =?iso-8859-1?Q?g8424ME8aGuhSUH1EP4kM3Fc2dfItPbzo0opsPQ2QjEw6oAuOMAfmvANTR?=
 =?iso-8859-1?Q?iTa6hurr3dWaldi8MBPjsLyIqzG3VMjuArJKmuhZk2lhkvybsGe9sTS+qr?=
 =?iso-8859-1?Q?ATG78mexW26yYCLXUJu+UAsWR9b60TKk+qCf0dTsaCebssd+2BdsmITFtN?=
 =?iso-8859-1?Q?ZTXHe0lS/BQL3XlBhUTLA0k3mC1tI8G19H+KWnW6DbIjtoD5VltVU/rrH+?=
 =?iso-8859-1?Q?iJk7Tq+uR97hvMm6Cqkq0ZaU7sX6XDtdWuecP69Nloxb75bv3OA7N0M074?=
 =?iso-8859-1?Q?pOpnXdgD16yNra1qzFalkT+RiBEIEK9VEsUWCvItNI/OcT6sWpa3cknjto?=
 =?iso-8859-1?Q?tVe0rr4cQKqKee7/WnX8VvDXFujM4YNt2O8kcnQKPDgGhnXBALURiQGHJQ?=
 =?iso-8859-1?Q?ba8I9HKo3u3iK6C0VNeFbo58ZEWNgczzR6nnmN93cb89lTeY62kFiJeZps?=
 =?iso-8859-1?Q?U4KbsO0p4Ms+hMKaqFc64ChVCm2wmWfgZ7Q2d+/6Ckp6l0yib3kMaG4BMt?=
 =?iso-8859-1?Q?Exs2O2AaUmG05ALR6JVpHdY235qgIVg6/iiiWjS4MjAaKCafRM32FsmIpg?=
 =?iso-8859-1?Q?98nc7xyyJkoSrbXv8uTIl2d0glmMKQ7bt7RZqBsVin289npmvOayN389of?=
 =?iso-8859-1?Q?vdv0R+2jxBM6PpioEYnpc1EckVcdYETq6bR+myITrMmEaS33m94DSvIchV?=
 =?iso-8859-1?Q?DToa/KNbhe5yNg8YZD6hO/BAsSJwkht7U1Rp6v/LGm6qy32QFfBv0StUCb?=
 =?iso-8859-1?Q?+ozf3XQoHglg/vWFuiOspFASCubDubJB2Rc07AZEqkxL0TAJyRoRDWDZX+?=
 =?iso-8859-1?Q?HVqVr+mZTcfNIUoI80QFO0q130g9p/0nqUCJaxYQ/q74ZDsafPjAOAbIGu?=
 =?iso-8859-1?Q?gyoqomkEbPki7cxrEZEPDw07r9ij0v+v6qnlQPCfApTIp1SYC49TMNtb5Z?=
 =?iso-8859-1?Q?4YOdxYPI6s4i6AgW6JlmO6+MjPfkkdk31w640IWwyboe1PMLuJKboHx7f0?=
 =?iso-8859-1?Q?sYje2/sPCAhvfmNWalve1AyLnasAUoEO+LKyoaosZLOfigsQGpF59o2FF5?=
 =?iso-8859-1?Q?HfFBcMQcWbzLoIAvZChFA+KCw8PEavn1rMaFmUADX8v+NrAnUQmasQKIMX?=
 =?iso-8859-1?Q?zogtCovTwgPez2ylfpgQRYVkU06EaWuCK8KbPTxzt59QkvUQK5Mil/EpSZ?=
 =?iso-8859-1?Q?ewKegjFjFvOT9js1keJZfl1iC9ygV5RSEv/bohJR/EVQeZKN7l9hSHyey8?=
 =?iso-8859-1?Q?sGh27Iyp/k+vPNSwUk8=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9PR09MB6506.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03037c19-95e0-415b-defb-08de268097ae
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2025 08:58:07.4559 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kIzdteFG7ZsZ9JdIIDkpsARAf9qy1Z7xnw8s4Z2B6IpH+1N4H/vGJgtzDjWpFpJQJdjx1pdsbp7c9Keh1+bhekgSiXP/9P5Xi7hr+ilm6RY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR09MB3612
Received-SPF: pass client-ip=2a01:111:f403:c20a::7;
 envelope-from=Djordje.Todorovic@htecgroup.com;
 helo=PA4PR04CU001.outbound.protection.outlook.com
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

Add mips.ccmov defined by Xmipscmov.

Signed-off-by: Chao-ying Fu <cfu@mips.com>
Signed-off-by: Djordje Todorovic <djordje.todorovic@htecgroup.com>
Acked-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.c                        |  3 +++
 target/riscv/cpu_cfg.h                    |  5 ++++
 target/riscv/cpu_cfg_fields.h.inc         |  1 +
 target/riscv/insn_trans/trans_xmips.c.inc | 33 +++++++++++++++++++++++
 target/riscv/meson.build                  |  1 +
 target/riscv/translate.c                  |  3 +++
 target/riscv/xmips.decode                 | 11 ++++++++
 7 files changed, 57 insertions(+)
 create mode 100644 target/riscv/insn_trans/trans_xmips.c.inc
 create mode 100644 target/riscv/xmips.decode

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 2fd0ced25f..87cb367676 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -249,6 +249,7 @@ const RISCVIsaExtData isa_edata_arr[] =3D {
     ISA_EXT_DATA_ENTRY(svrsw60t59b, PRIV_VERSION_1_13_0, ext_svrsw60t59b),
     ISA_EXT_DATA_ENTRY(svukte, PRIV_VERSION_1_13_0, ext_svukte),
     ISA_EXT_DATA_ENTRY(svvptc, PRIV_VERSION_1_13_0, ext_svvptc),
+    ISA_EXT_DATA_ENTRY(xmipscmov, PRIV_VERSION_1_12_0, ext_xmipscmov),
     ISA_EXT_DATA_ENTRY(xtheadba, PRIV_VERSION_1_11_0, ext_xtheadba),
     ISA_EXT_DATA_ENTRY(xtheadbb, PRIV_VERSION_1_11_0, ext_xtheadbb),
     ISA_EXT_DATA_ENTRY(xtheadbs, PRIV_VERSION_1_11_0, ext_xtheadbs),
@@ -1381,6 +1382,7 @@ const RISCVCPUMultiExtConfig riscv_cpu_vendor_exts[] =
=3D {
     MULTI_EXT_CFG_BOOL("xtheadmempair", ext_xtheadmempair, false),
     MULTI_EXT_CFG_BOOL("xtheadsync", ext_xtheadsync, false),
     MULTI_EXT_CFG_BOOL("xventanacondops", ext_XVentanaCondOps, false),
+    MULTI_EXT_CFG_BOOL("xmipscmov", ext_xmipscmov, false),
=20
     { },
 };
@@ -3295,6 +3297,7 @@ static const TypeInfo riscv_cpu_type_infos[] =3D {
         .cfg.pmp =3D true,
         .cfg.ext_zba =3D true,
         .cfg.ext_zbb =3D true,
+        .cfg.ext_xmipscmov =3D true,
         .cfg.marchid =3D 0x8000000000000201,
         .cfg.mvendorid =3D MIPS_VENDOR_ID,
 #ifndef CONFIG_USER_ONLY
diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h
index aa28dc8d7e..2db471ad17 100644
--- a/target/riscv/cpu_cfg.h
+++ b/target/riscv/cpu_cfg.h
@@ -36,6 +36,11 @@ static inline bool always_true_p(const RISCVCPUConfig *c=
fg __attribute__((__unus
     return true;
 }
=20
+static inline bool has_xmips_p(const RISCVCPUConfig *cfg)
+{
+    return cfg->ext_xmipscmov;
+}
+
 static inline bool has_xthead_p(const RISCVCPUConfig *cfg)
 {
     return cfg->ext_xtheadba || cfg->ext_xtheadbb ||
diff --git a/target/riscv/cpu_cfg_fields.h.inc b/target/riscv/cpu_cfg_field=
s.h.inc
index e2d116f0df..a290303ee7 100644
--- a/target/riscv/cpu_cfg_fields.h.inc
+++ b/target/riscv/cpu_cfg_fields.h.inc
@@ -147,6 +147,7 @@ BOOL_FIELD(ext_xtheadmemidx)
 BOOL_FIELD(ext_xtheadmempair)
 BOOL_FIELD(ext_xtheadsync)
 BOOL_FIELD(ext_XVentanaCondOps)
+BOOL_FIELD(ext_xmipscmov)
=20
 BOOL_FIELD(mmu)
 BOOL_FIELD(pmp)
diff --git a/target/riscv/insn_trans/trans_xmips.c.inc b/target/riscv/insn_=
trans/trans_xmips.c.inc
new file mode 100644
index 0000000000..3202fd9cc0
--- /dev/null
+++ b/target/riscv/insn_trans/trans_xmips.c.inc
@@ -0,0 +1,33 @@
+/*
+ * RISC-V translation routines for the MIPS extensions (xmips*).
+ *
+ * Copyright (c) 2025 MIPS
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * Reference: MIPS P8700 instructions
+ *            (https://mips.com/products/hardware/p8700/)
+ */
+
+#define REQUIRE_XMIPSCMOV(ctx) do {              \
+    if (!ctx->cfg_ptr->ext_xmipscmov) {          \
+        return false;                            \
+    }                                            \
+} while (0)
+
+/* Conditional move by MIPS. */
+static bool trans_ccmov(DisasContext *ctx, arg_ccmov *a)
+{
+    REQUIRE_XMIPSCMOV(ctx);
+
+    TCGv zero, source1, source2, source3;
+    zero =3D tcg_constant_tl(0);
+    source1 =3D get_gpr(ctx, a->rs1, EXT_NONE);
+    source2 =3D get_gpr(ctx, a->rs2, EXT_NONE);
+    source3 =3D get_gpr(ctx, a->rs3, EXT_NONE);
+
+    tcg_gen_movcond_tl(TCG_COND_NE, cpu_gpr[a->rd],
+                       source2, zero, source1, source3);
+
+    return true;
+}
diff --git a/target/riscv/meson.build b/target/riscv/meson.build
index 25d59ef9f9..3842c7c1a8 100644
--- a/target/riscv/meson.build
+++ b/target/riscv/meson.build
@@ -4,6 +4,7 @@ gen =3D [
   decodetree.process('insn32.decode', extra_args: '--static-decode=3Ddecod=
e_insn32'),
   decodetree.process('xthead.decode', extra_args: '--static-decode=3Ddecod=
e_xthead'),
   decodetree.process('XVentanaCondOps.decode', extra_args: '--static-decod=
e=3Ddecode_XVentanaCodeOps'),
+  decodetree.process('xmips.decode', extra_args: '--static-decode=3Ddecode=
_xmips'),
 ]
=20
 riscv_ss =3D ss.source_set()
diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index 9ddef2d6e2..66d31b67d3 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -1194,8 +1194,10 @@ static uint32_t opcode_at(DisasContextBase *dcbase, =
target_ulong pc)
 #include "insn_trans/trans_svinval.c.inc"
 #include "insn_trans/trans_rvbf16.c.inc"
 #include "decode-xthead.c.inc"
+#include "decode-xmips.c.inc"
 #include "insn_trans/trans_xthead.c.inc"
 #include "insn_trans/trans_xventanacondops.c.inc"
+#include "insn_trans/trans_xmips.c.inc"
=20
 /* Include the auto-generated decoder for 16 bit insn */
 #include "decode-insn16.c.inc"
@@ -1211,6 +1213,7 @@ static uint32_t opcode_at(DisasContextBase *dcbase, t=
arget_ulong pc)
=20
 const RISCVDecoder decoder_table[] =3D {
     { always_true_p, decode_insn32 },
+    { has_xmips_p, decode_xmips},
     { has_xthead_p, decode_xthead},
     { has_XVentanaCondOps_p, decode_XVentanaCodeOps},
 };
diff --git a/target/riscv/xmips.decode b/target/riscv/xmips.decode
new file mode 100644
index 0000000000..fadcb78470
--- /dev/null
+++ b/target/riscv/xmips.decode
@@ -0,0 +1,11 @@
+#
+# RISC-V translation routines for the MIPS extension
+#
+# Copyright (c) 2025 MIPS
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+#
+# Reference: MIPS P8700 instructions
+#            (https://mips.com/products/hardware/p8700/)
+
+ccmov          rs3:5 11 rs2:5 rs1:5 011 rd:5 0001011
--=20
2.34.1

