Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 647EBCA0FFD
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Sep 2025 10:31:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ut1my-0003uF-3v; Mon, 01 Sep 2025 06:29:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1ut1mq-0003so-1g; Mon, 01 Sep 2025 06:29:21 -0400
Received: from mail-westeuropeazlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c201::3] helo=AS8PR04CU009.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1ut1mm-0005Km-2r; Mon, 01 Sep 2025 06:29:19 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zR+N/hjIP0smtTN2xTTyeGDZoToZ+UTKs7q9tUO1w6bY78LxxX7+6tSkKTt2Imi2bjrZbM7latW/Ki4QwKdXCsSwInheRMkzwmwwLMQhwfC+Dc1cxT8W5gUe3TMXBBQxY2UIo8BJICqs9IkOnpKETCvK/sjQX4/ti1MttoPJWF6igNtGE84qvefu3E8TpHdr3mKCFxM1DGKDbzaX8s1Fy5tWUxyMpFYDsytbcnVqi/cn4IL1NZ76XN10sguybGe1h/ABiQ/gt0jkcj+3jGhNeBlqbXjuhQdSco+EeEFpJxeun7ImxZbNCpB4O+L1ZRRidL/5O0o9lCfRB1bIgcGbjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4hDbVmK5YV+tU8017ESHn+j8s1upbJ49/bwh+xqp2jM=;
 b=PQj7zfCslxqeZFRdhsYdfdxl/8q4umO9F2pjWqPc7P4ackhl/6LZNyggGVLjhljkpEIAuiTIi5BKS2YD9xDHQqIGEgDk1/D1W6ywC/ggBspKH4TcbYhllw/32DdJ9Fs5J9Kmu2kItsj7mA6rDLiyjxUE1MO9nqsMXS9Pr/SwmmVQ5ffNd+ReCo0tWOeJGdKPZ1Sc/HrHqSoiIhFIsJh5+yuVtI5+cNMRdcyKD742fEuA5qDI44IY44ATHOShEGziHwWyqWb9ZUz4g0g8Gzp1R/UG0cC1CkxGQuGk+tBVmp6eTCrAArh1mrhFFT2p/+BYphGNChDjj5mFKrsJW2t+3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4hDbVmK5YV+tU8017ESHn+j8s1upbJ49/bwh+xqp2jM=;
 b=i62EZ2nHC/K5nsCCJACahjrtGs4rBh2RQoIUAEv0/c8ZeLlsgqRCV0bVVUp7xPSlwlCO8jJ+krlWN6CgQxTaf0mSs0DdyBYvESfbaguJVzikXJg+8A4TRUO4NwUcrMqOOPNiwyvQ9jfGYaoJdmUmto18qKjMh7CORN0OXOFqsW+6j6NHT8lxjT3ihEQd3i1D8szDe+croMKyX/MCBUAXPUAvVXZKiE2pZgwq9dWK1liqXDVMvMeSI4/m8ZSU8y5qEGwrM3vEopfcHf6sEuawkN6DhFCUJFc+nJZ7SkGbPArY6DQoan9UUuehob19YaydNsfQsWggCYGVFQT2R8e87Q==
Received: from AS4PR09MB6518.eurprd09.prod.outlook.com (2603:10a6:20b:4fb::5)
 by GVXPR09MB6894.eurprd09.prod.outlook.com (2603:10a6:150:122::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.28; Mon, 1 Sep
 2025 10:29:08 +0000
Received: from AS4PR09MB6518.eurprd09.prod.outlook.com
 ([fe80::ad50:891a:847c:580a]) by AS4PR09MB6518.eurprd09.prod.outlook.com
 ([fe80::ad50:891a:847c:580a%4]) with mapi id 15.20.9052.019; Mon, 1 Sep 2025
 10:29:08 +0000
From: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "cfu@mips.com"
 <cfu@mips.com>, "mst@redhat.com" <mst@redhat.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "dbarboza@ventanamicro.com" <dbarboza@ventanamicro.com>, "philmd@linaro.org"
 <philmd@linaro.org>, Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
Subject: [PATCH v7 09/14] hw/misc: Add RISC-V CPC device implementation
Thread-Topic: [PATCH v7 09/14] hw/misc: Add RISC-V CPC device implementation
Thread-Index: AQHcGys9DQ4p6SOopESdY733X0cl/A==
Date: Mon, 1 Sep 2025 10:29:05 +0000
Message-ID: <20250901102850.1172983-10-djordje.todorovic@htecgroup.com>
References: <20250901102850.1172983-1-djordje.todorovic@htecgroup.com>
In-Reply-To: <20250901102850.1172983-1-djordje.todorovic@htecgroup.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS4PR09MB6518:EE_|GVXPR09MB6894:EE_
x-ms-office365-filtering-correlation-id: 358b9d98-8c9b-4986-03a6-08dde9426237
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|13003099007|38070700018; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?QSCmbhK1WOsP1sbO9Jiqptl1+2zwgCzgCoJy6USvpR6Ps8kzKsjB449LB7?=
 =?iso-8859-1?Q?X3I4zytcqRmETXx+9PSEp6ATL2+Z1Mk8mjajQzacw8SNd96oYq4F+7iP+J?=
 =?iso-8859-1?Q?RZv90lUEYpA14xYdfb58Df8tVYFgjXDXYxv+8wiLpelI1tzKrU1o+8Fkg5?=
 =?iso-8859-1?Q?nwR4bMcbbMyw4ueNaiJj5wvFMqokSf8bRp3aQu3xqGGqYMfovTSJmnmUit?=
 =?iso-8859-1?Q?Fgfbvrg233UnwGqjDk9uQ08JKUg0B5m1BYpoVJdQyLzu2dVukc/gx8r8Zn?=
 =?iso-8859-1?Q?rU9JamtZiVj5hV5z1zhrx05+oTgBuT149Y18Fngq/vbo+Lug1XuD7y6OUe?=
 =?iso-8859-1?Q?Qr2WHesryOkclyrMs95Rhjkx5Xnf8wljtkZXG5/UtSAuCqCUrfiko4IFtm?=
 =?iso-8859-1?Q?BrZzcZPEPJ68o+vcoi5JCbCnjiCe2lPQcGWUBaWMDiJ3p/E3oW8cneakpc?=
 =?iso-8859-1?Q?eTdjqih647gZFXetoRp7jzX2V7shAvmqoDfc+XDUiyHee+DOfi/pZCKZDJ?=
 =?iso-8859-1?Q?dHo6fbFAqu1QHfaFjNh8YWxm3EMvXdfPIy6GE2lK4RYXUc/XQdM+GXs85c?=
 =?iso-8859-1?Q?zrVHHYZV5rU0eQSUDKrsYULgX5V6iuciXpEDlSFAFk8ZVKn9ABdaTg/LgT?=
 =?iso-8859-1?Q?p6lREtOXQvG3F5FWB49nwzkviz5XzPzCXM+m2FpzJYZbfZ/FOKhv2GYgnL?=
 =?iso-8859-1?Q?FjTh6g8z0YIVsSPhOJwgxUepLRdjR0oXHu36pXmDX7UuYuXGGK0OAII5Fk?=
 =?iso-8859-1?Q?BZbdg1Z3IQzQN+Npsy3wbB8qJ9xx/A+Hjg+AGFaN+yvDe+9cpBUub7rbfN?=
 =?iso-8859-1?Q?un68y9Ca8iTb8jDIaoNSDiXjju3EgE6uW1kEpI3isnyJb4QlLG0jg9gi+e?=
 =?iso-8859-1?Q?VYKUuy7P6Ck7VNW8QjvT9wx3h9mV8PKm8J8WK+u6QInil4Uh3s2tP6y/xd?=
 =?iso-8859-1?Q?4ftwlBO7q5Txtw4cZtUei/2giMNSVGJXxzqI/eWK4seEPt4lWO8pkYK2A+?=
 =?iso-8859-1?Q?+kacK9dfVge6K4BoPeODQmkobvlCqCgaBsPfGH22BV0WTtPFSl/vFUto3j?=
 =?iso-8859-1?Q?oPzNWzhXjfum3x2C+X2mzhdqpUQw/A8SwnG5+5ZnfPfDfeMNOr4lIQ7bMK?=
 =?iso-8859-1?Q?IxKTu2JKPPPtTBLX/RdopG5fc3My3seA54TIrhZtTg59r90UPx8T0ItnM3?=
 =?iso-8859-1?Q?dqMKvVvxbo+32noI0OIRrj0KYvdTTmzc27SV7dFS3mtaBcllkElukJKzx9?=
 =?iso-8859-1?Q?AExyKjdJR38hoWR1eRJZ4meaFqum9Ua+P49fKg17wplTSmv9X/OTQazPGb?=
 =?iso-8859-1?Q?yVdqVTQIS8wJJW3wi8qSf3IEzOsKTxGFh1Ym/jUd1W8uxguANrNFgargVm?=
 =?iso-8859-1?Q?E+bJ0TkUMxo03iuvAdo3w3KKtFampbXDt0hahfWZbrjCk5T2aA6wMVjuNo?=
 =?iso-8859-1?Q?FRyaqZI/xYwO2VT/ZiLvXD8eWEnNd5+dqW3C27Z0hI1FkeKXB2BfTXn20u?=
 =?iso-8859-1?Q?AIMchfWdZz1qVNbYh40uw4h+Ni9HQNjEBxBJCc0lw9C5ofRbClPRUSr2aD?=
 =?iso-8859-1?Q?m7c4RfI=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR09MB6518.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(13003099007)(38070700018); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?ZT/G1A6KWK1ihljzdo+AqavQA6MiA488NYkmbylo9POVOBiIFlI1my1so4?=
 =?iso-8859-1?Q?+yMtPcc5AcvZ6pQTJXUnDW0XqX/3olVahKHxM2bDHl0EW3h/IErqVdMlXQ?=
 =?iso-8859-1?Q?ivYuorb/TXUAeE+vTFgjuZNWFX2v2FEiODwjljbeL1p7Y/HYM7W02GRgWd?=
 =?iso-8859-1?Q?5yEdSxFhWmhPa410AXxAgPwiIJwPUe0zeBXmHbQOf2TqPrPxmlB0ExuIwl?=
 =?iso-8859-1?Q?t28Qn5KryuCftDm5jLUFg9tYHzFSCg/5H8zPzK2JQMMzAeanTKbNbsXr79?=
 =?iso-8859-1?Q?VVlMQEKMxR7A+enkYZL11liV2THHZGEbwyUAvK7wpocgzWBlByrKTtQozv?=
 =?iso-8859-1?Q?XIuolZnF39nWQ3TprG220oSU5E73QfTaK1IyQEiI6lmfGqHIDvCzoMdCkQ?=
 =?iso-8859-1?Q?BO/XLTaLXY9CwAV665UJLSTtkpxvubnbQTpRSBWx1F/jBiilJvzdpCmL0W?=
 =?iso-8859-1?Q?YgWx4BDVY74GJaUilR79eR6QCNwwtEgglp+pjjFbE8ZEBKSlE4E5oS4Y2r?=
 =?iso-8859-1?Q?vOVziS4bVBcW4Tyq1SExx6z27LFM0IUdu17QNZbXH8AQz1/r301x2QJtzS?=
 =?iso-8859-1?Q?zOlwSoglJFQKt3Zecy5QXmiyR0i+gBsGWUzRq0IiM36eiTLbOQtKu2/Gx3?=
 =?iso-8859-1?Q?LPA/siFTY7UTxZKs5oVLuoY7z/tW4+Yc857gusrWIreD/HJYwiLIU93Tbr?=
 =?iso-8859-1?Q?1BNaJZasNitTgaRltiRqhFmiMpZKuEDwGXElIyKEQtVHMPv+wExYWBXtCz?=
 =?iso-8859-1?Q?Ku52U6+HWowt59GWRUtE2LX9D9Snw1YBwR0u5wK6dJr3nbTpqcxkJuhAgN?=
 =?iso-8859-1?Q?YtQjMQQjekEedrz7VapIUbbezeq/vALyi0QLJX93YsqCGXPryizfdIOiZM?=
 =?iso-8859-1?Q?Csv7Nyq4IqzwXKcRJu0D61ImTS1kh/cJIlIWuWITpz2UF/gqbDE0+dDexu?=
 =?iso-8859-1?Q?BRnKd+L7T/n8V+7DXVM1ssEkOBsZNa/GsefJR8+flCv2CZkkMxujzdkkTB?=
 =?iso-8859-1?Q?cd5d3eWSELEgB4iJw27ZipnBBQmF3dPImajW3jCCLxzTfE2PK1mAdrD8XT?=
 =?iso-8859-1?Q?Ff7+O6TdvGrJSDk5cYDHFUUwTfbJqk3kTWGEsQ3cw+O45jym4vfK50xgZ6?=
 =?iso-8859-1?Q?5mHsnjTgC1APhGUQ7XNERqWnO4jBxnUYGm85RQAGPS+csXzyTQY5PtdnN/?=
 =?iso-8859-1?Q?xP6dewx+zXdZ790xS8mWiUGxgdjJM4E2In7x3ly7SDfw1ExxeV16Nm+ml/?=
 =?iso-8859-1?Q?6BMDwdr8xAu2pCOCG9Q+Ihg+lLo0j1diK/uNJHaky9LIkPpebd428Afdo+?=
 =?iso-8859-1?Q?pYgAwDtibXNNSYto7sNXmKL9Ap67Wc8znW8JfWBGFl1mKhRJSAp6uFFv+7?=
 =?iso-8859-1?Q?Uzyn7o1AxuZhCDNXP7oJiy/zg0+zfZCBaK2CIB6/NZ7+ugyY4CCgHKC11N?=
 =?iso-8859-1?Q?6w7RcPw8F9VWSAcEAvl0TJbzANyQ+GeD6V5Y8Lc2wTcJQZvh3uTBtN9vi1?=
 =?iso-8859-1?Q?GJSczaf4hY47XGLNXuAvpTLDFbyNXSER9kSj2ddLuEnk24S3LQEFB+Q6j2?=
 =?iso-8859-1?Q?GsEKTLb1OVV8awAIS5zZWzbcT9R+7jbyqINRz8cEhRgo9Ketkvt9pzUhQK?=
 =?iso-8859-1?Q?L9IlkSSxXuhU0BpNFuhYIen7RDGhdhVKNCIXRycbAdkFLI5WLkCqBYPqgD?=
 =?iso-8859-1?Q?a2haQuABrp7DlMERdOk=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS4PR09MB6518.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 358b9d98-8c9b-4986-03a6-08dde9426237
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Sep 2025 10:29:05.2485 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xXjA6Wo4P1krFihIocvHxXz/LHvcITBfX3UuLK1hCiuMmxTMdFjy1vKaPJLmwdABBRzWyYD3ZME48jr0ds2pdzEpfdemTB3GXKP3DCJnkMk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR09MB6894
Received-SPF: pass client-ip=2a01:111:f403:c201::3;
 envelope-from=Djordje.Todorovic@htecgroup.com;
 helo=AS8PR04CU009.outbound.protection.outlook.com
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

Add RISC-V implementation of the Cluster Power Controller (CPC) device.
It is based on the existing MIPS CPC implementations but adapted for
RISC-V systems.

The CPC device manages power control for CPU clusters in RISC-V
systems.

This is needed for the MIPS BOSTON AIA board.

Signed-off-by: Chao-ying Fu <cfu@mips.com>
Signed-off-by: Djordje Todorovic <djordje.todorovic@htecgroup.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 hw/misc/Kconfig             |   4 +
 hw/misc/meson.build         |   1 +
 hw/misc/riscv_cpc.c         | 271 ++++++++++++++++++++++++++++++++++++
 include/hw/misc/riscv_cpc.h |  75 ++++++++++
 4 files changed, 351 insertions(+)
 create mode 100644 hw/misc/riscv_cpc.c
 create mode 100644 include/hw/misc/riscv_cpc.h

diff --git a/hw/misc/Kconfig b/hw/misc/Kconfig
index c72927c3ff..1e35bcd443 100644
--- a/hw/misc/Kconfig
+++ b/hw/misc/Kconfig
@@ -124,11 +124,15 @@ config MIPS_ITU
 config RISCV_CMGCR
     bool
=20
+config RISCV_CPC
+    bool
+
 config MIPS_BOSTON_AIA
     bool
     default y
     depends on RISCV64
     select RISCV_CMGCR
+    select RISCV_CPC
=20
 config MPS2_FPGAIO
     bool
diff --git a/hw/misc/meson.build b/hw/misc/meson.build
index ef891e465b..1f9945755f 100644
--- a/hw/misc/meson.build
+++ b/hw/misc/meson.build
@@ -158,6 +158,7 @@ specific_ss.add(when: 'CONFIG_MIPS_CPS', if_true: files=
('mips_cmgcr.c', 'mips_cp
 specific_ss.add(when: 'CONFIG_MIPS_ITU', if_true: files('mips_itu.c'))
=20
 specific_ss.add(when: 'CONFIG_RISCV_CMGCR', if_true: files('riscv_cmgcr.c'=
))
+specific_ss.add(when: 'CONFIG_RISCV_CPC', if_true: files('riscv_cpc.c'))
=20
 system_ss.add(when: 'CONFIG_SBSA_REF', if_true: files('sbsa_ec.c'))
=20
diff --git a/hw/misc/riscv_cpc.c b/hw/misc/riscv_cpc.c
new file mode 100644
index 0000000000..6a6cf72d45
--- /dev/null
+++ b/hw/misc/riscv_cpc.c
@@ -0,0 +1,271 @@
+/*
+ * Cluster Power Controller emulation
+ *
+ * Copyright (c) 2016 Imagination Technologies
+ *
+ * Copyright (c) 2025 MIPS
+ *
+ * This library is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Lesser General Public
+ * License as published by the Free Software Foundation; either
+ * version 2.1 of the License, or (at your option) any later version.
+ *
+ * This library is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * Lesser General Public License for more details.
+ *
+ * You should have received a copy of the GNU Lesser General Public
+ * License along with this library; if not, see <http://www.gnu.org/licens=
es/>.
+ *
+ * SPDX-License-Identifier: LGPL-2.1-or-later
+ *
+ */
+
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "cpu.h"
+#include "qemu/log.h"
+#include "qemu/module.h"
+#include "qemu/timer.h"
+#include "qemu/bitops.h"
+#include "hw/sysbus.h"
+#include "migration/vmstate.h"
+
+#include "hw/misc/riscv_cpc.h"
+#include "hw/qdev-properties.h"
+#include "hw/intc/riscv_aclint.h"
+#include "hw/resettable.h"
+
+static inline uint64_t cpc_vp_run_mask(RISCVCPCState *cpc)
+{
+    return MAKE_64BIT_MASK(0, cpc->num_vp);
+}
+
+static void riscv_cpu_reset_async_work(CPUState *cs, run_on_cpu_data data)
+{
+    RISCVCPCState *cpc =3D (RISCVCPCState *) data.host_ptr;
+    int i;
+
+    cpu_reset(cs);
+    cs->halted =3D 0;
+
+    /* Find this CPU's index in the CPC's CPU array */
+    for (i =3D 0; i < cpc->num_vp; i++) {
+        if (cpc->cpus[i] =3D=3D cs) {
+            cpc->vps_running_mask |=3D BIT_ULL(i);
+            break;
+        }
+    }
+}
+
+static void cpc_run_vp(RISCVCPCState *cpc, uint64_t vps_run_mask)
+{
+    int vp;
+
+    for (vp =3D 0; vp < cpc->num_vp; vp++) {
+        CPUState *cs =3D cpc->cpus[vp];
+
+        if (!extract64(vps_run_mask, vp, 1)) {
+            continue;
+        }
+
+        if (extract64(cpc->vps_running_mask, vp, 1)) {
+            continue;
+        }
+
+        /*
+         * To avoid racing with a CPU we are just kicking off.
+         * We do the final bit of preparation for the work in
+         * the target CPUs context.
+         */
+        async_safe_run_on_cpu(cs, riscv_cpu_reset_async_work,
+                              RUN_ON_CPU_HOST_PTR(cpc));
+    }
+}
+
+static void cpc_stop_vp(RISCVCPCState *cpc, uint64_t vps_stop_mask)
+{
+    int vp;
+
+    for (vp =3D 0; vp < cpc->num_vp; vp++) {
+        CPUState *cs =3D cpc->cpus[vp];
+
+        if (!extract64(vps_stop_mask, vp, 1)) {
+            continue;
+        }
+
+        if (!extract64(cpc->vps_running_mask, vp, 1)) {
+            continue;
+        }
+
+        cpu_interrupt(cs, CPU_INTERRUPT_HALT);
+        cpc->vps_running_mask &=3D ~BIT_ULL(vp);
+    }
+}
+
+static void cpc_write(void *opaque, hwaddr offset, uint64_t data,
+                      unsigned size)
+{
+    RISCVCPCState *s =3D opaque;
+    int cpu_index, c;
+
+    for (c =3D 0; c < s->num_core; c++) {
+        cpu_index =3D c * s->num_hart +
+                    s->cluster_id * s->num_core * s->num_hart;
+        if (offset =3D=3D CPC_CL_BASE_OFS + CPC_VP_RUN_OFS + c * CPC_CORE_=
REG_STRIDE) {
+            cpc_run_vp(s, (data << cpu_index) & cpc_vp_run_mask(s));
+            return;
+        }
+        if (offset =3D=3D CPC_CL_BASE_OFS + CPC_VP_STOP_OFS + c * CPC_CORE=
_REG_STRIDE) {
+            cpc_stop_vp(s, (data << cpu_index) & cpc_vp_run_mask(s));
+            return;
+        }
+    }
+
+    switch (offset) {
+    default:
+        qemu_log_mask(LOG_UNIMP,
+                      "%s: Bad offset 0x%x\n",  __func__, (int)offset);
+        break;
+    }
+
+    return;
+}
+
+static uint64_t cpc_read(void *opaque, hwaddr offset, unsigned size)
+{
+    RISCVCPCState *s =3D opaque;
+    int c;
+
+    for (c =3D 0; c < s->num_core; c++) {
+        if (offset =3D=3D CPC_CL_BASE_OFS + CPC_STAT_CONF_OFS + c * CPC_CO=
RE_REG_STRIDE) {
+            /* Return the state as U6. */
+            return CPC_Cx_STAT_CONF_SEQ_STATE_U6;
+        }
+    }
+
+    switch (offset) {
+    case CPC_CM_STAT_CONF_OFS:
+        return CPC_Cx_STAT_CONF_SEQ_STATE_U5;
+    case CPC_MTIME_REG_OFS:
+        return muldiv64(qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL),
+                        RISCV_ACLINT_DEFAULT_TIMEBASE_FREQ,
+                        NANOSECONDS_PER_SECOND);
+        return 0;
+    default:
+        qemu_log_mask(LOG_UNIMP,
+                      "%s: Bad offset 0x%x\n",  __func__, (int)offset);
+        return 0;
+    }
+}
+
+static const MemoryRegionOps cpc_ops =3D {
+    .read =3D cpc_read,
+    .write =3D cpc_write,
+    .endianness =3D DEVICE_LITTLE_ENDIAN,
+    .impl =3D {
+        .min_access_size =3D 8,
+    },
+};
+
+static void riscv_cpc_init(Object *obj)
+{
+    SysBusDevice *sbd =3D SYS_BUS_DEVICE(obj);
+    RISCVCPCState *s =3D RISCV_CPC(obj);
+    int i;
+
+    memory_region_init_io(&s->mr, OBJECT(s), &cpc_ops, s, "xmips-cpc",
+                          CPC_ADDRSPACE_SZ);
+    sysbus_init_mmio(sbd, &s->mr);
+
+    /* Allocate CPU array */
+    s->cpus =3D g_new0(CPUState *, CPC_MAX_VPS);
+
+    /* Create link properties for each possible CPU slot */
+    for (i =3D 0; i < CPC_MAX_VPS; i++) {
+        char *propname =3D g_strdup_printf("cpu[%d]", i);
+        object_property_add_link(obj, propname, TYPE_CPU,
+                                 (Object **)&s->cpus[i],
+                                 qdev_prop_allow_set_link_before_realize,
+                                 OBJ_PROP_LINK_STRONG);
+        g_free(propname);
+    }
+}
+
+static void riscv_cpc_realize(DeviceState *dev, Error **errp)
+{
+    RISCVCPCState *s =3D RISCV_CPC(dev);
+    int i;
+
+    if (s->vps_start_running_mask & ~cpc_vp_run_mask(s)) {
+        error_setg(errp,
+                   "incorrect vps-start-running-mask 0x%" PRIx64 " for num=
_vp =3D %d",
+                   s->vps_start_running_mask, s->num_vp);
+        return;
+    }
+
+    /* Verify that required CPUs have been linked */
+    for (i =3D 0; i < s->num_vp; i++) {
+        if (!s->cpus[i]) {
+            error_setg(errp, "CPU %d has not been linked", i);
+            return;
+        }
+    }
+}
+
+static void riscv_cpc_reset_hold(Object *obj, ResetType type)
+{
+    RISCVCPCState *s =3D RISCV_CPC(obj);
+
+    /* Reflect the fact that all VPs are halted on reset */
+    s->vps_running_mask =3D 0;
+
+    /* Put selected VPs into run state */
+    cpc_run_vp(s, s->vps_start_running_mask);
+}
+
+static const VMStateDescription vmstate_riscv_cpc =3D {
+    .name =3D "xmips-cpc",
+    .version_id =3D 0,
+    .minimum_version_id =3D 0,
+    .fields =3D (VMStateField[]) {
+        VMSTATE_UINT64(vps_running_mask, RISCVCPCState),
+        VMSTATE_END_OF_LIST()
+    },
+};
+
+static const Property riscv_cpc_properties[] =3D {
+    DEFINE_PROP_UINT32("cluster-id", RISCVCPCState, cluster_id, 0x0),
+    DEFINE_PROP_UINT32("num-vp", RISCVCPCState, num_vp, 0x1),
+    DEFINE_PROP_UINT32("num-hart", RISCVCPCState, num_hart, 0x1),
+    DEFINE_PROP_UINT32("num-core", RISCVCPCState, num_core, 0x1),
+    DEFINE_PROP_UINT64("vps-start-running-mask", RISCVCPCState, vps_start_=
running_mask, 0x1),
+};
+
+static void riscv_cpc_class_init(ObjectClass *klass, const void *data)
+{
+    DeviceClass *dc =3D DEVICE_CLASS(klass);
+    ResettableClass *rc =3D RESETTABLE_CLASS(klass);
+
+    dc->realize =3D riscv_cpc_realize;
+    rc->phases.hold =3D riscv_cpc_reset_hold;
+    dc->vmsd =3D &vmstate_riscv_cpc;
+    device_class_set_props(dc, riscv_cpc_properties);
+    dc->user_creatable =3D false;
+}
+
+static const TypeInfo riscv_cpc_info =3D {
+    .name          =3D TYPE_RISCV_CPC,
+    .parent        =3D TYPE_SYS_BUS_DEVICE,
+    .instance_size =3D sizeof(RISCVCPCState),
+    .instance_init =3D riscv_cpc_init,
+    .class_init    =3D riscv_cpc_class_init,
+};
+
+static void riscv_cpc_register_types(void)
+{
+    type_register_static(&riscv_cpc_info);
+}
+
+type_init(riscv_cpc_register_types)
diff --git a/include/hw/misc/riscv_cpc.h b/include/hw/misc/riscv_cpc.h
new file mode 100644
index 0000000000..3e908f4f44
--- /dev/null
+++ b/include/hw/misc/riscv_cpc.h
@@ -0,0 +1,75 @@
+/*
+ * Cluster Power Controller emulation
+ *
+ * Copyright (c) 2016 Imagination Technologies
+ *
+ * Copyright (c) 2025 MIPS
+ *
+ * This library is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Lesser General Public
+ * License as published by the Free Software Foundation; either
+ * version 2.1 of the License, or (at your option) any later version.
+ *
+ * This library is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * Lesser General Public License for more details.
+ *
+ * You should have received a copy of the GNU Lesser General Public
+ * License along with this library; if not, see <http://www.gnu.org/licens=
es/>.
+ *
+ * SPDX-License-Identifier: LGPL-2.1-or-later
+ *
+ */
+
+#ifndef RISCV_CPC_H
+#define RISCV_CPC_H
+
+#include "hw/sysbus.h"
+#include "qom/object.h"
+
+#define CPC_ADDRSPACE_SZ    0x6000
+
+/* CPC global register offsets relative to base address */
+#define CPC_MTIME_REG_OFS   0x50
+
+#define CPC_CM_STAT_CONF_OFS   0x1008
+
+/* CPC blocks offsets relative to base address */
+#define CPC_CL_BASE_OFS     0x2000
+#define CPC_CORE_REG_STRIDE 0x100 /* Stride between core-specific register=
s */
+
+/* CPC register offsets relative to block offsets */
+#define CPC_STAT_CONF_OFS   0x08
+#define CPC_VP_STOP_OFS     0x20
+#define CPC_VP_RUN_OFS      0x28
+#define CPC_VP_RUNNING_OFS  0x30
+
+#define SEQ_STATE_BIT       19
+#define SEQ_STATE_U5        0x6
+#define SEQ_STATE_U6        0x7
+#define CPC_Cx_STAT_CONF_SEQ_STATE_U5      (SEQ_STATE_U5 << SEQ_STATE_BIT)
+#define CPC_Cx_STAT_CONF_SEQ_STATE_U6      (SEQ_STATE_U6 << SEQ_STATE_BIT)
+
+#define TYPE_RISCV_CPC "xmips-cpc"
+OBJECT_DECLARE_SIMPLE_TYPE(RISCVCPCState, RISCV_CPC)
+
+typedef struct RISCVCPCState {
+    SysBusDevice parent_obj;
+
+    uint32_t cluster_id;
+    uint32_t num_vp;
+    uint32_t num_hart;
+    uint32_t num_core;
+    uint64_t vps_start_running_mask; /* VPs running from restart mask */
+
+    MemoryRegion mr;
+    uint64_t vps_running_mask; /* Indicates which VPs are in the run state=
 mask */
+
+    /* Array of CPUs managed by this CPC */
+    CPUState **cpus;
+} RISCVCPCState;
+
+#define CPC_MAX_VPS 64  /* Maximum number of VPs supported */
+
+#endif /* RISCV_CPC_H */
--=20
2.34.1

