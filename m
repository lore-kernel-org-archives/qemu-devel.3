Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A223FCAC5BB
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Oct 2025 09:52:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3tTg-0004sB-PO; Wed, 01 Oct 2025 05:50:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1v3tT7-0004Sw-3I; Wed, 01 Oct 2025 05:49:53 -0400
Received: from mail-westeuropeazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c201::6] helo=AM0PR02CU008.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1v3tSu-0004yS-Bq; Wed, 01 Oct 2025 05:49:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xVBFDX2WzQOqHpq3rGpVl1+bVCW6cfNeHFmquU/82DT2jqCcOw19aTL3EcF6mb++6ErPreNwSb5zw87ECvIyyiHweepvirTttoKHHxEXijx9U6HS4vD4fOmxpAtmNx1wKRc1iwZ23Ag+cVMW7Bn7+W1X7R9HQ2Pi95RFG9QCVDKTEmoDhksBcbSODU42YpbRk7FB0zRvdvxKoTwpznH5myTX6KCuKfkH3qQGxOp/L2S1ZFc3nJBjUarOvvM8PBIpk0yWUsKHdxZ/68+v2UqTaY0ZEb9zO7djrH9c6Ao91CzooC303toO57Sqc0YtYg2BwAIf8OPl7oMlKUZjWMXsKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m1uJ1nZcMszuOEYS2dgtFT0UIQ3DHUQLHvvIi5VaMoM=;
 b=xsKoLiV0+EgVt1UE/JQ99JBlqr7t+/9oWu/33/VPofPrP/jgil4q7S/w1lEPYFYBE78gPPilVo3Y5wdckR2+QMFmncbarhroGqd905TcSTQeC7Pc6UCkfgqMtQxqigEwzcdkU3v9ewfrXo7X7ryi2Odi9vYViRIg4dHTHE5coAfvKWA/shVpICcv8DIlMYFgSrt5G4kQuA8sSp2Cl8H8ZfE4gYQVGcjUtz4xBJ9olTU3pSIUC1qTqJ40T/vZgGaHD5RGZoNquOgzYh6zLCgq9zQLElmGWhjUcxFgyhwi9qWiKyqWRsUTOUpjTbmjh1Rny5UJqpX+k8gIarsWLkJHrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m1uJ1nZcMszuOEYS2dgtFT0UIQ3DHUQLHvvIi5VaMoM=;
 b=O4T3tM3tPEtI2iRtPl6vfw4ZGUMRzAXZSyCw0a5x2+mwUGuV3b52UsCQCGU/Rt+0h36Srw93rxQ5w/Km8OkupK2mMezcs8R5yEMHQi0Ad5Ak/bnVP9kEhpfR9kKnlj5JUJuJc8KrqLTemK6WtgzlW4ZRLoAYAOl7R7+AOXi6lgULhi8tI+pMQmAztQIzBMchmBgIY5RUf2Cefx4mMcPNBY8nfgmBn3FQS2xeZ/hI2CpR9DVsaXjcioSKPrT/q08XCfX4IC/0123GtthbaJ0oPZnp76sjBQIHzIcOIYMPPjmg9vbi/6ZCu+fxjxAsJ04P8OtB69W9uOITG5tTNBYlFg==
Received: from AS4PR09MB6518.eurprd09.prod.outlook.com (2603:10a6:20b:4fb::5)
 by PA1PR09MB7820.eurprd09.prod.outlook.com (2603:10a6:102:44a::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.17; Wed, 1 Oct
 2025 09:49:13 +0000
Received: from AS4PR09MB6518.eurprd09.prod.outlook.com
 ([fe80::ad50:891a:847c:580a]) by AS4PR09MB6518.eurprd09.prod.outlook.com
 ([fe80::ad50:891a:847c:580a%4]) with mapi id 15.20.9160.017; Wed, 1 Oct 2025
 09:49:13 +0000
From: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "cfu@mips.com"
 <cfu@mips.com>, "mst@redhat.com" <mst@redhat.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "dbarboza@ventanamicro.com" <dbarboza@ventanamicro.com>, "philmd@linaro.org"
 <philmd@linaro.org>, "alistair23@gmail.com" <alistair23@gmail.com>, Djordje
 Todorovic <Djordje.Todorovic@htecgroup.com>
Subject: [PATCH v9 10/13] hw/riscv: Add support for RISCV CPS
Thread-Topic: [PATCH v9 10/13] hw/riscv: Add support for RISCV CPS
Thread-Index: AQHcMrikktk+H8f/P0OAG0PSDcJNRQ==
Date: Wed, 1 Oct 2025 09:49:13 +0000
Message-ID: <20251001094859.2030290-11-djordje.todorovic@htecgroup.com>
References: <20251001094859.2030290-1-djordje.todorovic@htecgroup.com>
In-Reply-To: <20251001094859.2030290-1-djordje.todorovic@htecgroup.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS4PR09MB6518:EE_|PA1PR09MB7820:EE_
x-ms-office365-filtering-correlation-id: 27e67f3b-9645-4a4e-2bbf-08de00cfc73b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700021;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?vgS5UVAhyACmNLIX/UWmOpM7TnU/YrdF/8Riiapzhr593jVXmu0iHWqpma?=
 =?iso-8859-1?Q?NNRXS5LeSZevad1jmLq8R+SZnZtUNzthUXJBFV93t1AHcEXgeC72V44VoO?=
 =?iso-8859-1?Q?d4flNAGWQp3ULaR2F+FIXyashpuxuF507bMiOo5Eco/9/fhFAUJly3a+0H?=
 =?iso-8859-1?Q?pFB3MaNEp2eKVIlPwgpLsR8rrQ5MqPStBG6qM/0q+ElMXT3hA1VAOC6FeN?=
 =?iso-8859-1?Q?hh+pqs9vw3jytQQ+zlU/F0iOt9kZiSuvlpd9zTfE3fas/LXlcQ14usYxww?=
 =?iso-8859-1?Q?F+tw6FEISER5YTLkpTRSWWrjOsw1Llc6/rg/aIxvxrI0osipq+DF9DCPid?=
 =?iso-8859-1?Q?t8p8VAcEjDPkRQZP1+NyYqUr0h62G2A583kIPiZzZbfVnEiGKSU1ZYBTTc?=
 =?iso-8859-1?Q?UKGz03OEkSJmlKSSEzoOZUUqwgTFunYQrQ+yZIyCf1oskId6J1bDbz4500?=
 =?iso-8859-1?Q?Jy0WlGFRGD5Y3V/CZmJ0NIeNley+O803/395PWkRavt8xHbSH2uImYZiIX?=
 =?iso-8859-1?Q?UIpnQIWF9rzpZ8qIN6PipZxqdDcRZjPASdJ7vZdlY8QBtA5uk+GnNQoeYP?=
 =?iso-8859-1?Q?1SVxeB8Mek1vsR9I9NU9bhMosryS2mRFzfQgvdKRHYaGyEbu7OWp5MA8ac?=
 =?iso-8859-1?Q?eZH/QslYpquOBlhvEoYY9I2puBRkJYgFb8UD8qX7dVtjwVR/y9+SzueGdU?=
 =?iso-8859-1?Q?uoEW07DEYqy/KlWs1mm5H/0tlKqBwKPT2o2WpdOQy5llobo9/nFsCHDiWS?=
 =?iso-8859-1?Q?yTcRfDWLEnNBH10ELhYIWfY6pvLb9GnDY+8D8Us/6Kl6W2b1Us7ilTqC3e?=
 =?iso-8859-1?Q?FVzkUrUwisLPGN8Yjnaa6vgzOlaBTIFgGsCe7WgL02Sc9SoeFL4fDbMPMO?=
 =?iso-8859-1?Q?DRyLTIPXamECLddwxeihdHoBVJK2huKkhJEQm2eseOhxQXn6YsE4P+VOUI?=
 =?iso-8859-1?Q?fsQmtI3pzX6Ut18966cY/yH1xmQWYtruzwMIoHyvuWqP4SyKUYdZLv9U8X?=
 =?iso-8859-1?Q?czSqK3/XcCwhDNEVV9ITzrivwn0IbMtHQ7gOZm7hCZI2PGwI5gwCeQE0XC?=
 =?iso-8859-1?Q?j6FuY1qUHlaXN2GwQmn2Yp+Ral7nx/wg2trwGDdcUgnoRiVuh6WO4xmIMs?=
 =?iso-8859-1?Q?HpTQndabz4BBVCDE8FsWXKdshbdKsbFlXty119AkwexjXIidS5k1QcBysc?=
 =?iso-8859-1?Q?xkUQQi09p1Bw2u0DrAz/sOsq2y7r1H2tf7KWpalmeCku9l/qYDgdWvN4UW?=
 =?iso-8859-1?Q?DZY7weCCiVr2t0v+e5UDrtme0tj7UEeRaY0rMDG2Iz1lkaW7EPoZReiDtA?=
 =?iso-8859-1?Q?kWOigPwLxMYLH42qyXXV6VgVEqKRe593nxofma67NISPa6r1sfaICE+IoG?=
 =?iso-8859-1?Q?8E1F3PMHrlPzHfosNeKoXEI8zdg1do6KOSovTwDd5Vg0s3QprmnZVW2Gyj?=
 =?iso-8859-1?Q?XjhZ0FoWBq0aVbClsvIta/rp3j9kuqV+WRTeO0MtFW8xzl5uh8HNIo7/Vl?=
 =?iso-8859-1?Q?9Xn2kja6FuGLBT4nQ6ERC3ETTbjgX247g1ffZftP+MSmXCY6WR+RoExM+Y?=
 =?iso-8859-1?Q?BktomJC5XLVkaHhZ7p8WIt5gfdnz?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR09MB6518.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700021); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?6C0CZQQJLrfATETEsKieYbSp1VWYizb+epQL1saOYUagJxQKhCEHft92tK?=
 =?iso-8859-1?Q?BmY9RJMatxvpGWqcDz9Lul1CzPzaiQGT9oQkv5cixQeTTWQc4fk6yfUF+8?=
 =?iso-8859-1?Q?H6frj9zNlsuXdx4SxiliqPtLUzuw57QI3+v64Dj9f1WCe00p4kz+EnuTWV?=
 =?iso-8859-1?Q?QXtw3VxnOEb8FdtmBJxbAAXnKteRapHcqNRT3hcJdFKDJJtnLytU2BBvd1?=
 =?iso-8859-1?Q?YjBBJCbDqh1njY4PKt9VbmZR3praWt10qAcw1KLjjvqgieoE9oJpwSWrJf?=
 =?iso-8859-1?Q?O7Aa6edVZy+rsUOSGIJ81V+GvgdC+F4MTrK7dZvjnit5KlByAcJLdkqCxw?=
 =?iso-8859-1?Q?bGcJOmfeE0HcljBT3r51k/lEkDmIt77xLotGMmY9SeifpshW+bBPJmj7Bn?=
 =?iso-8859-1?Q?e/jSJR4CFl5DCeQTU6xcF7AkeEkUquZwZLt2A7E8r9++OjPVzkFba+R4X6?=
 =?iso-8859-1?Q?NYZ85pxQBpgnTbk7BM2MS+Tt/gY9s9wkXgaqik4biczGmluQFyXMDaA2Is?=
 =?iso-8859-1?Q?MOf7v40WHX8qyhNKBJhn0CARwykwXr1ZcYMIzseyrOTHtneKoVI4yNazVg?=
 =?iso-8859-1?Q?7ocn1nS5D9iY3BssxYRWK/RFXkzKu9W+Kp7MiCe1IfsVPC8A/tqvXps7W2?=
 =?iso-8859-1?Q?9tfKQEQdZPlIh9g/nHHpssNbI6blGF+ykxnKRzJR/KZVAy3vhidYCHwIvj?=
 =?iso-8859-1?Q?BS1OITYdiSgwTApiodhdDNLff0uW4+uUDq3vRdvLhmUBvZJMFZ+pzQH0Xq?=
 =?iso-8859-1?Q?utlWy0Ik4ZwKzXKfl006vbHacupqiiiW/vV5I/ph3sppAu8s00f6vK5uKz?=
 =?iso-8859-1?Q?UeoihVXbRJLg9Od9LdcCYgUTQnmMkC+OEow12V+AthmqMUERJ5iAYN34br?=
 =?iso-8859-1?Q?dvr3rMyVrT6/eZr17RL4b9we0w4Q5jG4fRIYcBMwRYQ8wZ+NTu5eQ8Arua?=
 =?iso-8859-1?Q?lVzNyEoUpJM08ydVdwIpRD+V5GxBhzR5+CJ9OWL3rAYO5OoJYouII5DIj/?=
 =?iso-8859-1?Q?q0Msf9zeEPD8CpFUUQMBSzPVZ8Pwgcq2T/qPDywnNnQmaHFIK1Qqat6l+W?=
 =?iso-8859-1?Q?kvQmZ66j9xvTNpqX8TZSFSbsM0VIWN+Nj8IBNPzgKzfgsqSDyR3XaeBzeF?=
 =?iso-8859-1?Q?W6bXm8Y0LnDvFPLFerVhvj7IOK6b9kt6QbpEeJVznBhJVUZzfH5LgG0F4N?=
 =?iso-8859-1?Q?MzeDcTBwJveKiEU4KOIEAOZTbALSHNhKAmtB8JuR7JCuuZwck6sCVKEccW?=
 =?iso-8859-1?Q?s1S+N34j02d3hS3lwaM+XpnDsJOQfNGD4sey7e2VmOiQo1kCY6Pg4+hI2W?=
 =?iso-8859-1?Q?G/RFdbtlPWjZZqiUGHJq5f3DZTzCE1RbKhUuoecD4hJO+j0CJYHlAPfAP+?=
 =?iso-8859-1?Q?txdVqZkImW3ekxtCJZ1G0dTEni3vqw25T0G3U+5FbWRAGJhWsGzpxe8CGJ?=
 =?iso-8859-1?Q?q43dlJE9sKCdPLCxEcdeqlUzy2r2S3DcjAV2MTBFpEuLTFDbTdrV3AYoLA?=
 =?iso-8859-1?Q?1D1mgf2MeU8suPTmU0rYhol8lDqj76Zi65LsA8I1MmSTs+Ly+bDhYZjuPl?=
 =?iso-8859-1?Q?duEDeejnWXODY3jzmNjtAxvlSTLCQlPw2Es0DZ7MJWtByC0Q/d1tMoy+Vl?=
 =?iso-8859-1?Q?gSmVV5AHkZXlA6dio6rqLyVbfWPHW8AfGX7ei1h4lWU0tJTRiWTs8YDGu6?=
 =?iso-8859-1?Q?ssNWpdEN09UecuCINkA=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS4PR09MB6518.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27e67f3b-9645-4a4e-2bbf-08de00cfc73b
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2025 09:49:13.2241 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: O9DMTbbO7qdqQB6tsedU0UA8+gaIbqMzn7JntiFOLH5WRmCAhWNjRWdEahIp5ka6cmpmhCbtnl5oz6HHiWKor8URLkTeG/RVZ9flOX7EFwk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR09MB7820
Received-SPF: pass client-ip=2a01:111:f403:c201::6;
 envelope-from=Djordje.Todorovic@htecgroup.com;
 helo=AM0PR02CU008.outbound.protection.outlook.com
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

Add support for the Coherent Processing System for RISC-V.
This enables SMP support for RISC-V boards that require
cache-coherent multiprocessor systems.

Signed-off-by: Chao-ying Fu <cfu@mips.com>
Signed-off-by: Djordje Todorovic <djordje.todorovic@htecgroup.com>
Acked-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 hw/misc/Kconfig        |   4 +
 hw/riscv/cps.c         | 196 +++++++++++++++++++++++++++++++++++++++++
 hw/riscv/meson.build   |   2 +
 include/hw/riscv/cps.h |  66 ++++++++++++++
 4 files changed, 268 insertions(+)
 create mode 100644 hw/riscv/cps.c
 create mode 100644 include/hw/riscv/cps.h

diff --git a/hw/misc/Kconfig b/hw/misc/Kconfig
index 2b308ec9b0..a2726abccc 100644
--- a/hw/misc/Kconfig
+++ b/hw/misc/Kconfig
@@ -127,12 +127,16 @@ config RISCV_MIPS_CMGCR
 config RISCV_MIPS_CPC
     bool
=20
+config RISCV_MIPS_CPS
+    bool
+
 config MIPS_BOSTON_AIA
     bool
     default y
     depends on RISCV64
     select RISCV_MIPS_CMGCR
     select RISCV_MIPS_CPC
+    select RISCV_MIPS_CPS
=20
 config MPS2_FPGAIO
     bool
diff --git a/hw/riscv/cps.c b/hw/riscv/cps.c
new file mode 100644
index 0000000000..8642d87fbc
--- /dev/null
+++ b/hw/riscv/cps.c
@@ -0,0 +1,196 @@
+/*
+ * Coherent Processing System emulation.
+ *
+ * Copyright (c) 2016 Imagination Technologies
+ *
+ * Copyright (c) 2025 MIPS
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ */
+
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "qemu/module.h"
+#include "hw/riscv/cps.h"
+#include "hw/qdev-properties.h"
+#include "system/reset.h"
+#include "hw/intc/riscv_aclint.h"
+#include "hw/intc/riscv_aplic.h"
+#include "hw/intc/riscv_imsic.h"
+#include "hw/pci/msi.h"
+
+static void riscv_cps_init(Object *obj)
+{
+    SysBusDevice *sbd =3D SYS_BUS_DEVICE(obj);
+    RISCVCPSState *s =3D RISCV_CPS(obj);
+
+    /*
+     * Cover entire address space as there do not seem to be any
+     * constraints for the base address of CPC .
+     */
+    memory_region_init(&s->container, obj, "mips-cps-container", UINT64_MA=
X);
+    sysbus_init_mmio(sbd, &s->container);
+}
+
+static void main_cpu_reset(void *opaque)
+{
+    CPUState *cs =3D opaque;
+
+    cpu_reset(cs);
+}
+
+static void riscv_cps_realize(DeviceState *dev, Error **errp)
+{
+    RISCVCPSState *s =3D RISCV_CPS(dev);
+    RISCVCPU *cpu;
+    int i;
+
+    /* Validate num_vp */
+    if (s->num_vp =3D=3D 0) {
+        error_setg(errp, "num-vp must be at least 1");
+        return;
+    }
+    if (s->num_vp > MAX_HARTS) {
+        error_setg(errp, "num-vp cannot exceed %d", MAX_HARTS);
+        return;
+    }
+
+    /* Allocate CPU array */
+    s->cpus =3D g_new0(CPUState *, s->num_vp);
+
+    /* Set up cpu_index and mhartid for avaiable CPUs. */
+    int harts_in_cluster =3D s->num_hart * s->num_core;
+    int num_of_clusters =3D s->num_vp / harts_in_cluster;
+    for (i =3D 0; i < s->num_vp; i++) {
+        cpu =3D RISCV_CPU(object_new(s->cpu_type));
+
+        /* All VPs are halted on reset. Leave powering up to CPC. */
+        object_property_set_bool(OBJECT(cpu), "start-powered-off", true,
+                                 &error_abort);
+
+        if (!qdev_realize_and_unref(DEVICE(cpu), NULL, errp)) {
+            return;
+        }
+
+        /* Store CPU in array */
+        s->cpus[i] =3D CPU(cpu);
+
+        /* Set up mhartid */
+        int cluster_id =3D i / harts_in_cluster;
+        int hart_id =3D (i % harts_in_cluster) % s->num_hart;
+        int core_id =3D (i % harts_in_cluster) / s->num_hart;
+        int mhartid =3D (cluster_id << MHARTID_CLUSTER_SHIFT) +
+                      (core_id << MHARTID_CORE_SHIFT) +
+                      (hart_id << MHARTID_HART_SHIFT);
+        cpu->env.mhartid =3D mhartid;
+        qemu_register_reset(main_cpu_reset, s->cpus[i]);
+    }
+
+    /* Cluster Power Controller */
+    object_initialize_child(OBJECT(dev), "cpc", &s->cpc, TYPE_RISCV_CPC);
+    object_property_set_uint(OBJECT(&s->cpc), "cluster-id", 0,
+                            &error_abort);
+    object_property_set_uint(OBJECT(&s->cpc), "num-vp", s->num_vp,
+                            &error_abort);
+    object_property_set_uint(OBJECT(&s->cpc), "num-hart", s->num_hart,
+                            &error_abort);
+    object_property_set_uint(OBJECT(&s->cpc), "num-core", s->num_core,
+                            &error_abort);
+
+    /* Pass CPUs to CPC using link properties */
+    for (i =3D 0; i < s->num_vp; i++) {
+        char *propname =3D g_strdup_printf("cpu[%d]", i);
+        object_property_set_link(OBJECT(&s->cpc), propname,
+                                OBJECT(s->cpus[i]), &error_abort);
+        g_free(propname);
+    }
+
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->cpc), errp)) {
+        return;
+    }
+
+    memory_region_add_subregion(&s->container, 0,
+                            sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->cpc)=
, 0));
+
+    /* Global Configuration Registers */
+    object_initialize_child(OBJECT(dev), "gcr", &s->gcr, TYPE_RISCV_GCR);
+    object_property_set_uint(OBJECT(&s->gcr), "cluster-id", 0,
+                            &error_abort);
+    object_property_set_uint(OBJECT(&s->gcr), "num-vp", s->num_vp,
+                            &error_abort);
+    object_property_set_int(OBJECT(&s->gcr), "gcr-rev", 0xa00,
+                            &error_abort);
+    object_property_set_int(OBJECT(&s->gcr), "gcr-base", s->gcr_base,
+                            &error_abort);
+    object_property_set_link(OBJECT(&s->gcr), "cpc", OBJECT(&s->cpc.mr),
+                             &error_abort);
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->gcr), errp)) {
+        return;
+    }
+
+    memory_region_add_subregion(&s->container, s->gcr_base,
+                            sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->gcr)=
, 0));
+
+    for (i =3D 0; i < num_of_clusters; i++) {
+        uint64_t cm_base =3D GLOBAL_CM_BASE + (CM_SIZE * i);
+        uint32_t hartid_base =3D i << MHARTID_CLUSTER_SHIFT;
+        s->aplic =3D riscv_aplic_create(cm_base + AIA_PLIC_M_OFFSET,
+                                      AIA_PLIC_M_SIZE,
+                                      hartid_base, /* hartid_base */
+                                      MAX_HARTS, /* num_harts */
+                                      APLIC_NUM_SOURCES,
+                                      APLIC_NUM_PRIO_BITS,
+                                      false, true, NULL);
+        riscv_aplic_create(cm_base + AIA_PLIC_S_OFFSET,
+                           AIA_PLIC_S_SIZE,
+                           hartid_base, /* hartid_base */
+                           MAX_HARTS, /* num_harts */
+                           APLIC_NUM_SOURCES,
+                           APLIC_NUM_PRIO_BITS,
+                           false, false, s->aplic);
+        /* PLIC changes msi_nonbroken to ture. We revert the change. */
+        msi_nonbroken =3D false;
+        riscv_aclint_swi_create(cm_base + AIA_CLINT_OFFSET,
+                                hartid_base, MAX_HARTS, false);
+        riscv_aclint_mtimer_create(cm_base + AIA_CLINT_OFFSET +
+                                   RISCV_ACLINT_SWI_SIZE,
+                                   RISCV_ACLINT_DEFAULT_MTIMER_SIZE,
+                                   hartid_base,
+                                   MAX_HARTS,
+                                   RISCV_ACLINT_DEFAULT_MTIMECMP,
+                                   RISCV_ACLINT_DEFAULT_MTIME,
+                                   RISCV_ACLINT_DEFAULT_TIMEBASE_FREQ, fal=
se);
+    }
+}
+
+static const Property riscv_cps_properties[] =3D {
+    DEFINE_PROP_UINT32("num-vp", RISCVCPSState, num_vp, 1),
+    DEFINE_PROP_UINT32("num-hart", RISCVCPSState, num_hart, 1),
+    DEFINE_PROP_UINT32("num-core", RISCVCPSState, num_core, 1),
+    DEFINE_PROP_UINT64("gcr-base", RISCVCPSState, gcr_base, GCR_BASE_ADDR)=
,
+    DEFINE_PROP_STRING("cpu-type", RISCVCPSState, cpu_type),
+};
+
+static void riscv_cps_class_init(ObjectClass *klass, const void *data)
+{
+    DeviceClass *dc =3D DEVICE_CLASS(klass);
+
+    dc->realize =3D riscv_cps_realize;
+    device_class_set_props(dc, riscv_cps_properties);
+}
+
+static const TypeInfo riscv_cps_info =3D {
+    .name =3D TYPE_RISCV_CPS,
+    .parent =3D TYPE_SYS_BUS_DEVICE,
+    .instance_size =3D sizeof(RISCVCPSState),
+    .instance_init =3D riscv_cps_init,
+    .class_init =3D riscv_cps_class_init,
+};
+
+static void riscv_cps_register_types(void)
+{
+    type_register_static(&riscv_cps_info);
+}
+
+type_init(riscv_cps_register_types)
diff --git a/hw/riscv/meson.build b/hw/riscv/meson.build
index 2a8d5b136c..9023b80087 100644
--- a/hw/riscv/meson.build
+++ b/hw/riscv/meson.build
@@ -15,4 +15,6 @@ riscv_ss.add(when: 'CONFIG_RISCV_IOMMU', if_true: files(
 riscv_ss.add(when: 'CONFIG_MICROBLAZE_V', if_true: files('microblaze-v-gen=
eric.c'))
 riscv_ss.add(when: 'CONFIG_XIANGSHAN_KUNMINGHU', if_true: files('xiangshan=
_kmh.c'))
=20
+riscv_ss.add(when: 'CONFIG_RISCV_MIPS_CPS', if_true: files('cps.c'))
+
 hw_arch +=3D {'riscv': riscv_ss}
diff --git a/include/hw/riscv/cps.h b/include/hw/riscv/cps.h
new file mode 100644
index 0000000000..00f17112c1
--- /dev/null
+++ b/include/hw/riscv/cps.h
@@ -0,0 +1,66 @@
+/*
+ * Coherent Processing System emulation.
+ *
+ * Copyright (c) 2016 Imagination Technologies
+ *
+ * Copyright (c) 2025 MIPS
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ */
+
+#ifndef RISCV_CPS_H
+#define RISCV_CPS_H
+
+#include "hw/sysbus.h"
+#include "hw/misc/riscv_cmgcr.h"
+#include "hw/misc/riscv_cpc.h"
+#include "target/riscv/cpu.h"
+#include "qom/object.h"
+
+#define TYPE_RISCV_CPS "riscv-cps"
+OBJECT_DECLARE_SIMPLE_TYPE(RISCVCPSState, RISCV_CPS)
+
+/* The model supports up to 64 harts. */
+#define MAX_HARTS 64
+
+/* The global CM base for the boston-aia model. */
+#define GLOBAL_CM_BASE 0x16100000
+/* The CM block is 512 KiB. */
+#define CM_SIZE (1 << 19)
+
+/*
+ * The mhartid bits has cluster at bit 16, core at bit 4, and hart at
+ * bit 0.
+ */
+
+#define MHARTID_CLUSTER_SHIFT 16
+#define MHARTID_CORE_SHIFT 4
+#define MHARTID_HART_SHIFT 0
+
+#define APLIC_NUM_SOURCES 0x35 /* Arbitray maximum number of interrupts. *=
/
+#define APLIC_NUM_PRIO_BITS 3
+#define AIA_PLIC_M_OFFSET 0x40000
+#define AIA_PLIC_M_SIZE 0x8000
+#define AIA_PLIC_S_OFFSET 0x60000
+#define AIA_PLIC_S_SIZE 0x8000
+#define AIA_CLINT_OFFSET 0x50000
+
+typedef struct RISCVCPSState {
+    SysBusDevice parent_obj;
+
+    uint32_t num_vp;
+    uint32_t num_hart;
+    uint32_t num_core;
+    uint64_t gcr_base;
+    char *cpu_type;
+
+    MemoryRegion container;
+    RISCVGCRState gcr;
+    RISCVCPCState cpc;
+
+    DeviceState *aplic;
+    CPUState **cpus;
+} RISCVCPSState;
+
+#endif
--=20
2.34.1

