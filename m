Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50D3ECCA471
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Oct 2025 10:47:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4dIo-0003Yu-Tp; Fri, 03 Oct 2025 06:46:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1v4dIi-0003Py-4U; Fri, 03 Oct 2025 06:46:13 -0400
Received: from mail-northeuropeazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c200::5] helo=DUZPR83CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1v4dIQ-0007NV-Kv; Fri, 03 Oct 2025 06:46:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gADMpL89ZDlc7FkHxWNNtywOs8CEr2O6aTJ0UQQoyPQ4VfUQQCWLdJjzidgZ+H5z7cewEvfE+XrlCh9qDOBEeN5g7y9qepnskyynpzh0b9zMrL4CkiuMOWnD69yl7Pi5o7d9/kIl3CX/vFnA/lkCj7Heh43OlogaGAmXYBg9m3YvHwrPm85eJwQJ3jigVr88qZ6AJpVrJZabf0RpFk6ciqjs18gl+Mo3I9uZk22z+htYw20rho30HYYRSi4BHYS4eH0t3FM91lrVslVLOidfqGT975yhV2luQ2pzGZfETR3h4RDUSk+M1zASPbO5OIfN4Zmmt/KdCsflEmqLWmsi6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LhSCfa80JVpaBNZlJZFNQ3vpbn12Z9AfFz6VyhGXuOk=;
 b=FuICByK0dQ7g2I/E19DghVyuGQJS4nEq1f2F0/4NQaN5lZBGs2ZI2MM5j2VWXUbUMcm94mnnRRr5H9c69e8R+kOVy/YJs4xzGnlq3ifp+2i23OBQOvErparYn82D5U8MRStVSjiHCox/2KcoSSHT9/CMcYygF+wvzDXEcy699DJgQ0uXhapuQ7djntz+kp8NXIBmlJbfn8ks85hlozn7qlDVPle5cyPRuVjQ/Wo2j6fqb8SkPB/T9ztp81RcCkBlNJnxkwG92coU2bmdfMQFIBEPfza8Zp3Hq3yPt21y20dGIaRWQHzKaiijlXCh5jyDm16HtyrkrfwvwkIlv6FIow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LhSCfa80JVpaBNZlJZFNQ3vpbn12Z9AfFz6VyhGXuOk=;
 b=N1lqL/Ox3kmip71rqJxknGLPU9DHDu9tPgdylir4CRa/SXFLV83y12Qt0RTHq2lUIkguRSlE4PvJYbsHEkFphNEqYFBFFIxwl0pra3qw921hetPBDByZqnr9xQLal7/i30TkCpeR4MYzCnEPK6/2DwG1wMiCpprbD71nDk7F4qh7M7b65YzruxiTRGWv/q/tKFxZZv/kwhlx7KVZmX9rkaXYTYDTVmo9TvWrgzWxS8vxF3L26Irxgby26cLdEcpzTFbCcdlSzX+hz6CrsBa6LBfSE8BSTndt/REs2qll0O7Aurr1CaQNQ4y4ZYuaIrUpCdEeeYJFXYVMkfUDil8vfw==
Received: from AS4PR09MB6518.eurprd09.prod.outlook.com (2603:10a6:20b:4fb::5)
 by PA2PR09MB7850.eurprd09.prod.outlook.com (2603:10a6:102:418::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.16; Fri, 3 Oct
 2025 10:45:20 +0000
Received: from AS4PR09MB6518.eurprd09.prod.outlook.com
 ([fe80::ad50:891a:847c:580a]) by AS4PR09MB6518.eurprd09.prod.outlook.com
 ([fe80::ad50:891a:847c:580a%4]) with mapi id 15.20.9160.017; Fri, 3 Oct 2025
 10:45:20 +0000
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
Subject: [PATCH v10 03/13] target/riscv: Add MIPS P8700 CPU
Thread-Topic: [PATCH v10 03/13] target/riscv: Add MIPS P8700 CPU
Thread-Index: AQHcNFLQbl/D/T56WkOs2QTOhY+fKQ==
Date: Fri, 3 Oct 2025 10:45:20 +0000
Message-ID: <20251003104443.51501-4-djordje.todorovic@htecgroup.com>
References: <20251003104443.51501-1-djordje.todorovic@htecgroup.com>
In-Reply-To: <20251003104443.51501-1-djordje.todorovic@htecgroup.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS4PR09MB6518:EE_|PA2PR09MB7850:EE_
x-ms-office365-filtering-correlation-id: 9c880660-25cb-413d-ee5f-08de0269f312
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7416014|38070700021; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?ZphU16/cZ/HXVA7m1NnR4a48k5d/rE+zp1dGZ6HtbZMoBIsPFNsiaYsv2A?=
 =?iso-8859-1?Q?4hUnEbHxrbdIyNn+omon4M58exBmsjHxlKxVECBtlLFXT134E1DSsZZ5zM?=
 =?iso-8859-1?Q?XGUmYXJA4UdOsQSuW7wN793TPUzmxcJlbHm5vH5gsjtsJG1sXqfFeD83gn?=
 =?iso-8859-1?Q?14roYWMgoTGqZGBj0z5WRThOlRHDp6IkJ6lW2RNQqsCYm960axv3GLsAHx?=
 =?iso-8859-1?Q?yfOv7Ptrn6iN+bnwnek5xTxNCJIPFoSG+Ue1o5R15SLD3i6grwe7muo18S?=
 =?iso-8859-1?Q?e2G2fHGmSuYHYrVL8J9DiglkLSBzO+Y5YD7VIf8r6iko09fw/3LJOIb668?=
 =?iso-8859-1?Q?6NcEV5YKBAMggCEKiwbBvUIR4KvQ6D7NRd1yGpj4J+VEYYda3FogXIAuYH?=
 =?iso-8859-1?Q?qcakUT7fOfRSoh5i/xKrWdtXcbjeNeeXj7ZQWk0ddbzWDFilTN+BXydQ+8?=
 =?iso-8859-1?Q?aY9WcDOUIaMfq7CqqMFLwCgvyXXIHoo7bkq5EkCSGL9UHjvHMGU3h90sjD?=
 =?iso-8859-1?Q?RyHLQtx6KizkW99DSaj+Qv7h69Jarw5LWnSB5TWYkuYmcZmH0zruzSdSK7?=
 =?iso-8859-1?Q?+pShbmsWRw2oDCgo3lAQSF/MXk0AlMys5wZrgQcLKB+e821mSh+6lBQyP8?=
 =?iso-8859-1?Q?03G793WP/c7bvSvsrrnvH5UXABgxixsE+lN+VKRmjoSIMQDW1jjOcad5cL?=
 =?iso-8859-1?Q?GYZbD2BVGL4aXgOKouqgrD31bnEhgWbE959mxswuuJdZLXCwiU2PBk7Jgb?=
 =?iso-8859-1?Q?eyZ5Cxw6DacRShm+0hmyZEhIoN0cNVfva7knd8oTOKVX5/mHAcWzmezU3y?=
 =?iso-8859-1?Q?JnWxvPMsUULv4Z70wY9tTcj1S9C0RvZuiv2Hb8lumZ6w1L9Y76e20SYsnG?=
 =?iso-8859-1?Q?1e0CcBJW9248+dpgSZDdHMbRsSUxYvpmM71kZ6/DvhXsogcG2IIK2eOfRW?=
 =?iso-8859-1?Q?CVmA+6I9JrdyD/rhvvcylBR8NlwI/J6yhTg43loGOsta8OxE8cAz+AY4hf?=
 =?iso-8859-1?Q?C0qKfHM0USzlQApSlHaJeaxj06ZNpJWoBwXwI8Al3/1LdPFTirPImgq58V?=
 =?iso-8859-1?Q?1OUYUPESKxgRtSOCmwm2oSZuTYFxfBeh2HvtIWN+3xCxb/QS8HuPAkFX72?=
 =?iso-8859-1?Q?0S1pFVjZTbh5/wydRTgk6mgJL5eKM07FBPYRiK9Fc1Q9kHYDO3CnWfLnnu?=
 =?iso-8859-1?Q?/CoqmeB0ZVanciMG6SBTiGwGhSkIn7+pROUWLASgf+6Byyb5iCm9olIfBw?=
 =?iso-8859-1?Q?P0BmyiHO8wC2CuXdZDE+a0ju1wqXKhwOj011IssboJwRL1UrL+IfEwKws6?=
 =?iso-8859-1?Q?KsL7XD1BlZ77ZByk4YgBbvQjcnMgGNNofT6UkhiTtuEIU4giR0Ot0PFD8D?=
 =?iso-8859-1?Q?7s8JSic+lF4WNX2UlkEks2fs1P2TX1XXIGiGV1fiKKsABaFgux3+MQq0Yn?=
 =?iso-8859-1?Q?X90MF79cCZwYzTgEC9Ipz0qPHVUXopDYQr1PZnsaS/AlUjcxxQixTgwuoa?=
 =?iso-8859-1?Q?+DGd0E9UnSuuk98bp6Nl5ZjlNhIbus7A+4R+WRNH6+oQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR09MB6518.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700021); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?H6IwGMYy57w2A6dIA5f4TsjvIIbMtPUkunlvyyN5yKq9ttIo/Q5b3Y7nzN?=
 =?iso-8859-1?Q?Q6pwONnAJxMoV353PvZFSFBb2mV1qIrXovrkQhI8vSEw5JcuDc7bu4J6op?=
 =?iso-8859-1?Q?q0IhhNbs9NBnPscjUm1y4lmkZ6X4LhEU2W5792azkONwjfUen9uWHcAfCh?=
 =?iso-8859-1?Q?pYrQ4irzLneWXvrd6NZukpviCGJ6tW8eKf5MXJCSUjink/jcEne3fkeuQ1?=
 =?iso-8859-1?Q?SanehGZCjSZLZaW0PnL0neOvn0R4y2D1zVbzssrlxxWmHkAJqn+Hm3Hnj+?=
 =?iso-8859-1?Q?/585CsLZFyV9TP3R7xI0XQYnvDCfmm1wMr4a+POKkRcFAIOBawEK8xazRd?=
 =?iso-8859-1?Q?9RYDkspEO42XA1pwBgqH9ST46GHJV/B8wICEpX0i21f1DHZ21/XL08fggK?=
 =?iso-8859-1?Q?qog/3CCQcNtZb8tpbXvQEjtUUZOaLcT1Z6avpC7/c/ofsc9iq39ZuWNlko?=
 =?iso-8859-1?Q?wQ87DSJT3dALXS+LPJuyXxl/wBV5XOz8zTPIECZ+Rc1NeCR5GWwoht+sEB?=
 =?iso-8859-1?Q?pRviTVTTMIHrb5P1p+A0yZqLNaHXM1WKYEx30QAV0BCButaySyJqxmrz5k?=
 =?iso-8859-1?Q?RNptXuNaNOFmETu2pnYjc7n80mFGXfLmClwQO2HAQtrVoptZ6WtulHGDQu?=
 =?iso-8859-1?Q?pJlejiHYGFicb3HLI3yib2F4QyxWNatLb1kifagjFb0yHoi8aFdGN7J5EX?=
 =?iso-8859-1?Q?sEAZDJA29P2V7lJ2qelArJqHwH8meY1O1OuoZjCVy/jVXNW83Si6IQFp4U?=
 =?iso-8859-1?Q?0eMA0TBJ74859xdL+VqZWpY0hBTICPoZPNBjpqL7Rou7S2HMPU5aKGsSCn?=
 =?iso-8859-1?Q?nlEx43A4dRe7a0FYmD5WN/gRhY808m7PZVnLxnBUndkIYkzH76ebUKq4ie?=
 =?iso-8859-1?Q?zoCQfGROtyTli67Ssohn888m5uIuZBaCGR8CJd3y6uWnhU/8lK+bTn/Tpj?=
 =?iso-8859-1?Q?/OP0farebRUuqR7Bj7klB+3dQ33bkIT2zEPkTAJkzs+IfiuM77Es1NmrRk?=
 =?iso-8859-1?Q?YNlh3ucso9Z0+YkREPkRpEPKd55k9mplvVVgGiUOAqnE2t4L31pBJmutK+?=
 =?iso-8859-1?Q?7LSSoMxDuw9I702xTVAvtGeIafkVNgD6EeUKMej7+O+K/qDEkn0oaRBDcZ?=
 =?iso-8859-1?Q?XBQbF+mb2g4w3OrxTl7wlzqKzU9D9clqiezbojMrQSaczAoHejsbNbNj3l?=
 =?iso-8859-1?Q?i5P6/Zru2Ag4RamvVQcvOOMUu101Kg2+Oo3xVUibi5wNfpwmUd53DASZLJ?=
 =?iso-8859-1?Q?akTrpNtF7L6m0Yhq2/6+jm1eGniBxcmtF6USaWMeRD2D0MpeEpyQh9mP4j?=
 =?iso-8859-1?Q?wFYQ0pNcgSUw0pGRJlU0rx/T7G3Vln7bVkVh1/vHdcGkOTRJwrT9lNQ5SB?=
 =?iso-8859-1?Q?OnsAK1kZ2yW/SGux9BhZb7rGUMIV3SBtOrdXQmKaR0lKO5QwKP/PRX+DH0?=
 =?iso-8859-1?Q?OOYGxgmEaFyh+aaI0dx3OMClsEMLySJpkYO39s4dLz+wS7b41bqOCBUATo?=
 =?iso-8859-1?Q?WokEgTQ6lnwTR3vZbUKaQH7tkBkkGJYzrd7OAzpDiq0btLW7zRe54QoM9j?=
 =?iso-8859-1?Q?Q6bTBP+3KGg2okZT8f7Ke4ITp+FDsvfJmIPg6v/5uUzTJi9N/WqDV/jd/o?=
 =?iso-8859-1?Q?n+l6n8ixKbhkHRhv4gehKu4MP69QqNxTEDl/Fq3q9CKjSmW6g36JxQkX+s?=
 =?iso-8859-1?Q?QP3Kv06NJwHUbQg9uls=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS4PR09MB6518.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c880660-25cb-413d-ee5f-08de0269f312
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Oct 2025 10:45:20.5490 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2jUDIC8miyfZSgia3WwQ+faX7q3eINvmrh6y791NHsXJ/gzq141+DtYz3n6w0Q0Xva/PXV+T8m7SLQLa1VLBUjNd19DK5KN3vik3iePZTpE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR09MB7850
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
index d42cf9d70e..bf1b9e33be 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -3282,6 +3282,22 @@ static const TypeInfo riscv_cpu_type_infos[] =3D {
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
index 96b6b9c2cb..28f0ce9370 100644
--- a/target/riscv/cpu_vendorid.h
+++ b/target/riscv/cpu_vendorid.h
@@ -2,6 +2,7 @@
 #define TARGET_RISCV_CPU_VENDORID_H
=20
 #define THEAD_VENDOR_ID         0x5b7
+#define MIPS_VENDOR_ID          0x722
=20
 #define VEYRON_V1_MARCHID       0x8000000000010000
 #define VEYRON_V1_MIMPID        0x111
--=20
2.34.1

