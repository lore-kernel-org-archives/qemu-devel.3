Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C12C6CEBF92
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Nov 2025 08:59:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vLHXX-0007yQ-GC; Tue, 18 Nov 2025 03:58:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1vLHXW-0007xe-3G; Tue, 18 Nov 2025 03:58:18 -0500
Received: from mail-francecentralazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c20a::7] helo=PA4PR04CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1vLHXU-0003VY-AF; Tue, 18 Nov 2025 03:58:17 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IhyKNgT3KtEEEpYnjTrXq+HRgDPIdogbvZTDIQ288faBFfBe5v8whXSuaBsqj60I4wFi/xSbOQeV5KI1fh6MuJfTKGfd+RMcAa2u75J4Fn5ctrxpAXZb2t/FKF/sctSinF+OJCtwVw8AfQuJhjZjpXGta6mnjce6VtGyFs+ShEeIpahrtBrnI+QsW2ev69k9MiteAAhSZhgQkcpU/mB6UP3HXOIr5jMvndGep+m1NK/dS8VKLGUranuQH//+0B0QnZdEhUlQfrUaWlAEWmpA/IMU61p36NMLjPw8prMNbfvtpHMYJ0JOvYC17RTWCCWdh0ZIHfSmGbHObkwyK7Ohjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P5YELfkbig/YRKiatPU7cmkxMwFDsFcvLPZC6Augosg=;
 b=pnKXJSm0evWA3bM48DqWE16OHxMBjv1jojkIi8KxKA2qigvD8gklWhE33U1z9ge5zy0Xste7smCsvW+hNydJ4Ws7FrQLyawyFVI+chQb08CigEtVSDIlCmb/GkNif7kMZUKKeQwHF9y++LasAwihoeHolMPY0sckQczhuWrjseLMIwo+rfZ6ACxixi6lqe4HoC/8h+WCTKFq1Z3jTWFpypkDSnmKXIsTD1OaLI4byluFXdfgzShykBevL+NsaGAY4FY4cijauP3PjS8QYxkSGui4AcM8ui5azhLmw6af4LiMSCgAs0S3wzaZ8BUZ14ONhs6RGr7UTaVk0rFa/df0bQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P5YELfkbig/YRKiatPU7cmkxMwFDsFcvLPZC6Augosg=;
 b=eWcV7LH4hfWdDQoEqEUZhKksMrTFuGsyjs6A2KFT17iGJ3ZZGqBuYzVPOiw9z7kJfmcdhH83iM2vMRvL/Q12YigB1XqFiyBr5FNBF52rFAC7ZbQNhconjtuOInMGt9WvzGxQPdQ2dEkiL6qOSnpHlBEMtmm8/grE+WgL8ivhjRdZItG5D39k5/5tls1IltS77kQagUAhm3oB7Av8FDdwNYQpDgmm7CBUNQ2AcQj2xdfUj0ldF+kTZTFGK6BzoMgR3HRljaBQj2B4mQ16PG0R8/3kVUET8DwDT0Cw8gyfdPcXRYxbtWiiOs10F1xTjCGHWguNHzB2AezF7V+b4w9kVA==
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
Subject: [PATCH v14 03/14] target/riscv: Add MIPS P8700 CPU
Thread-Topic: [PATCH v14 03/14] target/riscv: Add MIPS P8700 CPU
Thread-Index: AQHcWGl0f2Gl+j/Dg0Kl7AGakMF7mw==
Date: Tue, 18 Nov 2025 08:58:06 +0000
Message-ID: <20251118085758.3996513-4-djordje.todorovic@htecgroup.com>
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
x-ms-office365-filtering-correlation-id: 5e565666-522a-44b8-98a9-08de2680975e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|7416014|1800799024|366016|38070700021; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?FVtJL1BCa0v96nTZ2JXsCXjKNgLiYd/2RJkIFvlaKDmFXJ4WFfyvfuqKxf?=
 =?iso-8859-1?Q?o1PRsF8JgSaOiQPP3bCJI4IPcMtgkV1tytKDbgTKB7FgAJTf1yTNcfH1g9?=
 =?iso-8859-1?Q?N/pWkTAKHOveVmVV8BzMjg527HSVYTalysEIcViLTAGrzpKjs/g6Y6Rcvi?=
 =?iso-8859-1?Q?1MZJrLgu7rVI+BDW/Jemkq07I32ywMr6ctrs4hLESYVFyCrk2cGb68nk10?=
 =?iso-8859-1?Q?nDdJd8wK4MmrpBrlWkLYgDG7PXeXQCqdtJkT2/6fuybZOQUBJVp960AXKd?=
 =?iso-8859-1?Q?63c/56ZnkXltwQ6aGHcy200jH94JZAXrNiatJsOLzSSx37XNKO3LSnwN1e?=
 =?iso-8859-1?Q?X+GMKqSL2i8JnKKD0h9gvLGnjLXd/XPOJbjQ8MzjL5W6nAAQJJcpJI6O7m?=
 =?iso-8859-1?Q?N2Hu/ACc/YSj33d/9upeeKmWQIzrTCBB6Yh7kPFiFC/n7L9lcihhp65ClS?=
 =?iso-8859-1?Q?hLssKt956zLmuZPdB5tvDfPiCu8/hs/SBqTpM1QpJbtafWt55L+6WzX0AV?=
 =?iso-8859-1?Q?VIwoXqq1L364jseV0p6L5dDq32IVRiBFt1e0bYID7xm38L7Bzn1w7+M084?=
 =?iso-8859-1?Q?IxsyzLgJyACU1nFKtINVE9lHl4VRJrf9uf+o9qQ/oF8meWsDWo3PzDkGdB?=
 =?iso-8859-1?Q?CCOGksaZMjb206q5x5TvyTGeMAJggZtlgnvIY1znUOFO0kHALOMfp71B6l?=
 =?iso-8859-1?Q?kppv14pZj1HdeZQT9Q2Gl0w7HEs0p3m/8ms1WKxz7bAryao3ogJ+Coac/q?=
 =?iso-8859-1?Q?7b+bIZiK+wyImpy0IOYGAfPhWBI6McSm0B7L1QFqZ74f9mCJYezR/UsYn6?=
 =?iso-8859-1?Q?AhrFeRaBVCFEKnkiI+Gd2YGYGT6huXhJ+G+XFN9yOyPiILTP26PNXPL57Y?=
 =?iso-8859-1?Q?HmE+2GlYfSwr7Z7VFPM71h5xntAvfER2x+evJQdLCIY1KjjskO/XIYz/yC?=
 =?iso-8859-1?Q?VVWAEJnDHZqyBzVJI31kc1SWDbK511djoBwCIsZaHlTmEgqZlwH3rfCQtI?=
 =?iso-8859-1?Q?cbe/toEX9Fi97+e+7pRCsFEJ3KmkVPICChlz8p+7SomryZwW9sD/M4bxsr?=
 =?iso-8859-1?Q?3Kt3MGyhFTq3dJP/Lp8uL8w+eiMfhcxaXMkW+IvBLp8C/u6/AwFiJ3cQhe?=
 =?iso-8859-1?Q?KqJNbEuWga7u+3Ae+0nLd3ZRyDLuo0eTJeISz7xyvTRJIpghcCLvh7bQxW?=
 =?iso-8859-1?Q?RqDCM9oKHthbGFB9OvaBJdJxBC52TxjWWdGdhOvSJ1FoinUY1G5XI5hbuy?=
 =?iso-8859-1?Q?m1dsBtbbJcQgK2uvo7NMgtPx2LRfZ9S56xJuJdk5v1RV7ij/m38VWTi+Cg?=
 =?iso-8859-1?Q?ejjAwIjWzgsn0hOOsEj5tbhOlDd21MoBGcmcmgR+pKMwuJx9K8EVjfPTZx?=
 =?iso-8859-1?Q?G+zRZx4iht2cpWkQraEyh3HqNUHDke9t1seNP8GTTo3qDMy37AHziputEj?=
 =?iso-8859-1?Q?sNhWcorb8BJSPbI9BCUrAid3taR5RzotG6QpioqkTEMqJ6fUta+SGpa1W0?=
 =?iso-8859-1?Q?WqfJCK+7vgR8o2RiTlP2QFBPzaKm1uwrDqc0xIGUEQuio1eLxT6yGB+m30?=
 =?iso-8859-1?Q?R0oaNmIReD6BEaxHs4As0wtQi5sF?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR09MB6506.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700021); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?wwPYKIxBOSpzkHc6jwAHGLl3/PZAyo1swY5xaoeea9ml07icW305yBZzhM?=
 =?iso-8859-1?Q?GHjiiwCy6G6JBCbMipq60U83xC03+LZM1OS/hhuHpCzxaVfaD7xCH+kl7p?=
 =?iso-8859-1?Q?zFmpdiZMfmDOxJhFxlB3gbeKwgaI8fBDHGmImL9XY2JnYjFvNgpwExgzk6?=
 =?iso-8859-1?Q?3kA2JW0F6BZYFRGOHzWtf0wd6G2iTad/rG7aAvHVcGpU0FYmNINTSN4eS7?=
 =?iso-8859-1?Q?m/5QVMn1Bh+pcv/cs/rhxT/2GBSBR7dSMb4L62ESu2wfbf1yoBimPMbly7?=
 =?iso-8859-1?Q?NgeeWgiN9p4woWlDsHuvx/18LC6Xn7blaItcibQgrpHrjbYdtvzSayaFOh?=
 =?iso-8859-1?Q?v8I7WbObDwcmCaYZAiGiqVmnQrQqXcfPm2y88R/V1A3CqXOwhW9CBlr93G?=
 =?iso-8859-1?Q?PMresBA1SnrYWhD2ZLFTLabKjWWR3F9Fj8LULda0ekOwapQqTNl+DkzEpb?=
 =?iso-8859-1?Q?XbH5lS3+n/mK/MjOnDsUWNpmBgKZhTHYo0KnikWGb5jF9PP/aQJoDBhsup?=
 =?iso-8859-1?Q?H40CmrtgKCMtlvEVTGksk1jcaqj7re7VTOGFqFNIZC8oWPURUG+/aaf6Zt?=
 =?iso-8859-1?Q?Mp1F+kxR18j1mdx6Oj2wqH79AYVzqXr/1nJ/Cs4OqgtEUInRlfsGzMu6vz?=
 =?iso-8859-1?Q?17rY7sN8U9NEqF/uFaMNadx6Q47AdNMI7NB2JpOF73EGnIfQnSK932zyyw?=
 =?iso-8859-1?Q?6Qm1ONpF6Ou7moLhoXw1P4tbwtTBIAfirW8Ww7HC+3oRxd08gH0ovFIBDA?=
 =?iso-8859-1?Q?HhWRHWOn0hC1PU0iUwSo2l8G254+DaPnmXBaajt+8Bnq4XzZXWJWukz0Ya?=
 =?iso-8859-1?Q?E8snKUiwH3Oyiq15st3im44iGQ3ywDpDMHYrxvMS3FY6V1+SIMG5sZJp74?=
 =?iso-8859-1?Q?YbeJ4ZX9LeD7EQxMYocKxs/vNgmQY69LN86Hfx9meJ8kLm3Se3qbhF3Vsl?=
 =?iso-8859-1?Q?IG8pJ5a5xdMIkk6FYHkanCJ+1MUhFgd8kkI/PxWtaKKpYSNcBq3xcNumlj?=
 =?iso-8859-1?Q?iLZua8uagJd9Bz9oe4xRVPZP+68wKzsbs6jW5XUKjNHRNi58rZoSuDYv7P?=
 =?iso-8859-1?Q?Y3EG2ExDewqBvuILmsuZcU4Ez4304n4x3PiRQROcjIDHuJ+PRIgZAN1Dhy?=
 =?iso-8859-1?Q?MNwyFR3i61Jw352DHI7m17dVGaiQFVbpiBPTgTYLd6h4eAjK6lpnScNKi8?=
 =?iso-8859-1?Q?YWhnqDbW8MpmgEFWBk6dYy9yp8KrENCcZMGgV0Td/zaVwdIYvraRpAN2XS?=
 =?iso-8859-1?Q?U8S6SMjdX6Or6hi4/75QDAwseFbH65z7TA5W9BdJqbSu+jHNQ7lXmGTTP8?=
 =?iso-8859-1?Q?CGvVmOFJ4JjoYInKP4o75lXJKXJgD2tsTGfCbPvitq8jIXz1nJhbPhynI2?=
 =?iso-8859-1?Q?IYzjfvTG25pbGVHDcdzLdmiCBv/FS1HODJps412WqysxGUZLWEOLZD3drD?=
 =?iso-8859-1?Q?JXeXTxdD5qXuTcrP9CYyMUwpUR1gpoQGRx4Wdk6NiIB7opLlV2zy2eLZIK?=
 =?iso-8859-1?Q?S6gWrgwWA6neZtP5ab6gmKl8JoqsjwZGnWL9XzR48TW1r0alqF6uQ4+Vic?=
 =?iso-8859-1?Q?2EUHCP5S4+eln6nTXckTU+qhXcy9yhdtNsP6kjnLnQsc1RGh4xvAeNImIe?=
 =?iso-8859-1?Q?BH+PJbKGqy4em49nK2JqtE1LYLOBJ8rcy4YN3kB3riTJD/wOp58Ytcns/Z?=
 =?iso-8859-1?Q?83s4RSXNstQthKDBKDY=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9PR09MB6506.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e565666-522a-44b8-98a9-08de2680975e
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2025 08:58:06.7906 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zNvVKF8bjeki3+ebiukz3WRxb+esFDbEk3RfzV972yuOZe9s7zLI2FDdCJnwmNgPFy+ReaE9IGbO1697oTewGOQTkk5SR+LW0E5NbNkzq+A=
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

Introduce P8700 CPU by MIPS.

Signed-off-by: Chao-ying Fu <cfu@mips.com>
Signed-off-by: Djordje Todorovic <djordje.todorovic@htecgroup.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu-qom.h      |  1 +
 target/riscv/cpu.c          | 16 ++++++++++++++++
 target/riscv/cpu_vendorid.h |  1 +
 3 files changed, 18 insertions(+)

diff --git a/target/riscv/cpu-qom.h b/target/riscv/cpu-qom.h
index 75f4e43408..30dcdcfaae 100644
--- a/target/riscv/cpu-qom.h
+++ b/target/riscv/cpu-qom.h
@@ -56,6 +56,7 @@
 #define TYPE_RISCV_CPU_TT_ASCALON       RISCV_CPU_TYPE_NAME("tt-ascalon")
 #define TYPE_RISCV_CPU_XIANGSHAN_NANHU  RISCV_CPU_TYPE_NAME("xiangshan-nan=
hu")
 #define TYPE_RISCV_CPU_XIANGSHAN_KMH    RISCV_CPU_TYPE_NAME("xiangshan-kun=
minghu")
+#define TYPE_RISCV_CPU_MIPS_P8700       RISCV_CPU_TYPE_NAME("mips-p8700")
 #define TYPE_RISCV_CPU_HOST             RISCV_CPU_TYPE_NAME("host")
=20
 OBJECT_DECLARE_CPU_TYPE(RISCVCPU, RISCVCPUClass, RISCV_CPU)
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 7932ba6873..cd4e442bdb 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -3283,6 +3283,22 @@ static const TypeInfo riscv_cpu_type_infos[] =3D {
         .cfg.max_satp_mode =3D VM_1_10_SV48,
     ),
=20
+    /* https://mips.com/products/hardware/p8700/ */
+    DEFINE_RISCV_CPU(TYPE_RISCV_CPU_MIPS_P8700, TYPE_RISCV_VENDOR_CPU,
+        .misa_mxl_max =3D MXL_RV64,
+        .misa_ext =3D RVI | RVM | RVA | RVF | RVD | RVC | RVS | RVU,
+        .priv_spec =3D PRIV_VERSION_1_12_0,
+        .cfg.max_satp_mode =3D VM_1_10_SV48,
+        .cfg.ext_zifencei =3D true,
+        .cfg.ext_zicsr =3D true,
+        .cfg.mmu =3D true,
+        .cfg.pmp =3D true,
+        .cfg.ext_zba =3D true,
+        .cfg.ext_zbb =3D true,
+        .cfg.marchid =3D 0x8000000000000201,
+        .cfg.mvendorid =3D MIPS_VENDOR_ID,
+    ),
+
 #if defined(CONFIG_TCG) && !defined(CONFIG_USER_ONLY)
     DEFINE_RISCV_CPU(TYPE_RISCV_CPU_BASE128, TYPE_RISCV_DYNAMIC_CPU,
         .cfg.max_satp_mode =3D VM_1_10_SV57,
diff --git a/target/riscv/cpu_vendorid.h b/target/riscv/cpu_vendorid.h
index 96b6b9c2cb..f1ffc66542 100644
--- a/target/riscv/cpu_vendorid.h
+++ b/target/riscv/cpu_vendorid.h
@@ -2,6 +2,7 @@
 #define TARGET_RISCV_CPU_VENDORID_H
=20
 #define THEAD_VENDOR_ID         0x5b7
+#define MIPS_VENDOR_ID          0x127
=20
 #define VEYRON_V1_MARCHID       0x8000000000010000
 #define VEYRON_V1_MIMPID        0x111
--=20
2.34.1

