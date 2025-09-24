Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 466F0CAC5B2
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Sep 2025 09:21:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1LeH-0003fF-JT; Wed, 24 Sep 2025 05:18:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1v1Le2-0003e4-St; Wed, 24 Sep 2025 05:18:39 -0400
Received: from mail-northeuropeazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c200::5] helo=DUZPR83CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1v1Ldw-00030I-1v; Wed, 24 Sep 2025 05:18:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rRAa131dzY9v9BT/LHKBP7v+Wxwvj8O/HkKEKetHKBTRILUcT4jG2SzCRSGT+PR2yuX1/IcB4BYzatEMMwjZ3Rd8lJek+Bul7oINvpYIfZVCrfvXcYQP5Sq5bEpgxvSJmnVUbF/buEnevUp0qkbEpsXuzMXNvy/8K8hUUzlt6bvHKirJuJvDsELl3CqW6SlmfCVhGt9DSOpFKyqqPZDVlI0H4z07cLdh1JFXUMKolTcRson5FzcEt0rOJgl0r5is+SX4rxTO8PMLr+Z5pCyr5FcR/eXTeKioZ+PQPY++p6BuCjqutZrwTN55blJ2N+h7t7aT0P+xtwlYpDVB9arqhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TDMla8WoW0NwmKRN+kGf3rMM8y+TARjo8UCX0eB2ymc=;
 b=UScP7FJqvjEaBpD1Uohw5W7cDbO7LvWASnfskc8/XnFDn6ULFTReAufoyDMDtPlKFAoHp8tTaYz0QHAEMPZCI30Y7Ew1W1DlxD2/a9BdILAl7pi6jylvgIFWIwtXUBfYljgOwQ3mTYxfahU3hYT7PSQoTb4wBoHqMzfiVPfp8nQ8BtODwQJqgYC6P399q+xbP8TSj2jruQTEPzVsETB0nJQydoT5qNoIt61pwsycgijAfRb+xlZ3DGFawrkNyP8Sl2aj9uw9DN1L+xzTa5iLFZV424uHU0aJV21Rijc3qWorLKpte4hIWZE+VVCDMUOqi8HeMAlHbMHpePRm/aWNXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TDMla8WoW0NwmKRN+kGf3rMM8y+TARjo8UCX0eB2ymc=;
 b=RGdI/17U2ditVNeqxNOJed0bqZon1+40UiOoflrLNcdQqxdh6FnKtM9Bybh1tZmplIKAlyqwZ04xGjd9hmjVUfzxl/dnannKAvVCnkKkoNpqY/H/gpi2bg536hmrsaiSgJ+2UTsiwY3w19SU1UijzMdEAPdYeftnLR/C7hYG2cG3chXWEJnO60zvGLLwl5w8ZeUSu4KXDD0SmccyVZV9XzzKK7+E4IGuCxXVFbTxCGZQa6IMcRRqyJLSrE0wf8cGMAc9cstXYYMKYFuh9icNuqi6IVj5c02yjwn+du4NTwvjaodghOzxLsU0W0k0JZwPQ5ps1SlMOpkL+10ULlUgtQ==
Received: from AS4PR09MB6518.eurprd09.prod.outlook.com (2603:10a6:20b:4fb::5)
 by VI0PR09MB7826.eurprd09.prod.outlook.com (2603:10a6:800:21b::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.20; Wed, 24 Sep
 2025 09:18:16 +0000
Received: from AS4PR09MB6518.eurprd09.prod.outlook.com
 ([fe80::ad50:891a:847c:580a]) by AS4PR09MB6518.eurprd09.prod.outlook.com
 ([fe80::ad50:891a:847c:580a%4]) with mapi id 15.20.9160.008; Wed, 24 Sep 2025
 09:18:16 +0000
From: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "cfu@mips.com"
 <cfu@mips.com>, "mst@redhat.com" <mst@redhat.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "dbarboza@ventanamicro.com" <dbarboza@ventanamicro.com>, "philmd@linaro.org"
 <philmd@linaro.org>, Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
Subject: [PATCH v8 03/14] target/riscv: Add MIPS P8700 CPU
Thread-Topic: [PATCH v8 03/14] target/riscv: Add MIPS P8700 CPU
Thread-Index: AQHcLTQnDMs0CceT+0i5MPf8csFKiQ==
Date: Wed, 24 Sep 2025 09:18:14 +0000
Message-ID: <20250924091746.1882125-4-djordje.todorovic@htecgroup.com>
References: <20250924091746.1882125-1-djordje.todorovic@htecgroup.com>
In-Reply-To: <20250924091746.1882125-1-djordje.todorovic@htecgroup.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS4PR09MB6518:EE_|VI0PR09MB7826:EE_
x-ms-office365-filtering-correlation-id: f175ca09-2d1c-4208-6b6e-08ddfb4b4ba7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?I2/Bqhdrcy+L1nN7JmLrgHkp3eX1Ryu/X5S3q2Nu0T/iG1sdqIydvCXGrL?=
 =?iso-8859-1?Q?xr0V/PAqBDECoq+f5pg83Ph60Hk1cPXn4KYNbIoAPsuO9ey2edpz1ejGrk?=
 =?iso-8859-1?Q?UKOFdG8C7DCUGmXYMDZX+IeKySSdaaBD8QBZUiy2efZkl7eQcYh3Baoomc?=
 =?iso-8859-1?Q?pGOQTbkw8wE5kCSM3Xs4Rt72vpsN4JWXaiuOTCCJP6nApgQeGmkktDGr7l?=
 =?iso-8859-1?Q?YFlj+qVLilufbD2mfb+6v2NPvwvIeqE0aDe56w9jsh5y8jRqOyg4naL8hS?=
 =?iso-8859-1?Q?XuOzB1C9XrTx2W2npPvDfTOLBly69FJj9C7Ikl59xgYEYAdFYKwJN/BCDE?=
 =?iso-8859-1?Q?MJsWS3aAYsvVBEQF+eYANsOa6O1dsAR8kbf4Qe8UBCW6H5xc9ITswPxXAx?=
 =?iso-8859-1?Q?vte3Xp65orFsR5TK/jrc2C30nQMJQsLPfRiDU/DR+sAVrqCgqQLfU/4Tk6?=
 =?iso-8859-1?Q?QTlz+yWpx8SKDouz/wbOCaw4YeQcYI+GRZWaLZitEt4435AZSccPGRECb1?=
 =?iso-8859-1?Q?7o7GPpAlpwj01JYXHAMZsIU2bb8uEEqqzE6yhee5WYQTB36twiFLwI15A7?=
 =?iso-8859-1?Q?EAoW3HurK3ksQNK5vvo+3I/kZex+RN7A4Y8rsp4BBlli504XEywIKH4A8+?=
 =?iso-8859-1?Q?B5PvQZVGY7B1SyciF0esWxeCtOXNyLxjlNEFdjIVk0hPxdHUoCZ/vTrnD0?=
 =?iso-8859-1?Q?i2vZ8tXjkI35BzflVHWyTfln4IPk2VNmu1750p9xNIyvLX2GMeZY08DfNx?=
 =?iso-8859-1?Q?MV0eXzmwzol46S0O5y33LoXKyrrsVBVwljSMX2e+o73HxYsrTKHWB6hqGU?=
 =?iso-8859-1?Q?ubeyI47g6+mJWBBThOxJrIYXNelIldAwN2Qpjb0AZ1f5hIh2Pj0MJehnyd?=
 =?iso-8859-1?Q?84r1z4WT4N2aHcEjNhpvZhhp9xuQk8e7DSJFem0cy13gIupxuxx6PJa/U+?=
 =?iso-8859-1?Q?1uowIoUQo7tfNqloryy5p+kh1zxFCIlI4m7cLNHoI4L2rF47MwxSmVTSWI?=
 =?iso-8859-1?Q?mfuie8iNbcsIiEOhAU6k40xbYrFg1RdLjBvnGIeXUrCnK1KgcYLb935GBs?=
 =?iso-8859-1?Q?5irnk31rPb5/rnj2dwCPz0HP6kvgny8xqX/21Os9SgYB+oqBQZjzltot0S?=
 =?iso-8859-1?Q?pbtH3HAFHWlIv9OvIoGj+qhbGvWqwjgWRteLjjX2/swAdF/xRA89ZZ7PpM?=
 =?iso-8859-1?Q?KqGj7Md1Myrn3pL37kPYAEZND/LD3y/buaAhUwdCPMzD76elysA9QFtbtO?=
 =?iso-8859-1?Q?5LSZiDFWwGAqNr69rN/4KTSPP+GtfPxz0AQEy0wa4K4/96CG9wD4dhJVQv?=
 =?iso-8859-1?Q?gVVT7pRtGPAE/uUl/2C2PgyrMwz8h+vvkHIPXeTTKWbMiIIcQZZvJHbhE9?=
 =?iso-8859-1?Q?ga2zJr0ygVLtNVHhO1rD4TxAGhfHk8udG6dQkOQQVfvpOFAA2I+Sq1LQtb?=
 =?iso-8859-1?Q?q90gbP75OJeR9Lv8U6hArgLD+K6SgCVNOIUSP1y+EhetR/16jPmqhs4n9i?=
 =?iso-8859-1?Q?o=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR09MB6518.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700021); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?sVTC+L0q39htIiXPhwqZeRPYfDDqb4V5RfaYqiHAuLN/nOl5lvnzTj6vLB?=
 =?iso-8859-1?Q?wTB43JIygqSxf7F5VMVGMrKzo9IJl6LxWJ5dvsVtPhgMMG3L2KiBpUui1d?=
 =?iso-8859-1?Q?ukuOjpM58UYdSTeKfM8c3v4aeFHOq44KBsnaxsfgWIAQtWeOR0VWQiQ4HX?=
 =?iso-8859-1?Q?V08pTzQSBmhHQ2l4Guqf4mL2Tkp9bjRjzPP2mtTqd7KBJxxdyNnGM04U2x?=
 =?iso-8859-1?Q?IBVi72amqJcT/xJRKwNyBWTsQmt1HwkvE5AKxdiNQbBMZw2SXEzsVxbrXv?=
 =?iso-8859-1?Q?//FDgCVeS/a7kszIFZA1yl0ULOHKRkszeIC7RW6W0r+rsXmHBWNlr4Hots?=
 =?iso-8859-1?Q?l/4Zara90XvBLe/GpZLq+dwfiaAVaSHPI01jBk2JHZj8220wTeW2eZDRlB?=
 =?iso-8859-1?Q?5lkuco86ctYeF+yYWuNHj3m8hTswSwP6xQ/fX0ut3ye6U80Ei94jYhmX3P?=
 =?iso-8859-1?Q?xHsYnTrqhDBZZeZ0jegWDPR74cwb8UiOP5eRNVECw+5VEodDAXYwBZSs0n?=
 =?iso-8859-1?Q?NAotcq3A3jprLiyO8qqbI5hf1mAHicBm88JcIh9QNFnzbLOwGE03j1WNNy?=
 =?iso-8859-1?Q?kCILFwD9XdT4M2pm4K/P7/AE+mrYbBdvEJgHywLUwbPI/6V/fII5pJc7SH?=
 =?iso-8859-1?Q?tfyY6ssJnrzsaxPc/jKMsSgjZ+sHGcvL7SCQzYGz+HECXOQ31/2WebTwxC?=
 =?iso-8859-1?Q?A6LMAB8wpi9EXSNgnfdNj2HSL62em/3KO70maFDgENZlpDS1YuenNm4k5a?=
 =?iso-8859-1?Q?FbT1AJhJDY7xDDMZOf6d9qeMd9rD+Bsr1tNzoCEdz3fxQUsS7Kw5TuJRoU?=
 =?iso-8859-1?Q?RIHhX80rvupyiVE/Ii22qZsnlDepgNk0goUJXTi6vgtJ3fS9wQJNeFAN61?=
 =?iso-8859-1?Q?gsqjP/ekmr0rnSm76mx+XgwHAtmcK/1JSMzIEIK7dqytEHembsiGC5Pxk8?=
 =?iso-8859-1?Q?ybjwK3vngaLt+czJFYduJwP1l/IZSc7CdXf4BXfGwOrTbqwbfGcExxPGFW?=
 =?iso-8859-1?Q?wMNprqwRBm6KG7BIaLbbkwpIz/zlatz+moqr9ea2af3LBxGAYWYPuGVy0y?=
 =?iso-8859-1?Q?ES7m2sqSo1oOwzYAxhyQrIBa2EugC5AS/zaM0UCvTSWIVhzmg5HzYH78gm?=
 =?iso-8859-1?Q?PNgbyF63tpJjn0SlZSm9smsBM9nqP2bCt7ucD/07Fv0yz95JbfWVTXglSV?=
 =?iso-8859-1?Q?vgoCmqhzihfczSIxykNhaHC/DMZuCYerD5IY/oAijq0mcbgw8ZWV76O7yQ?=
 =?iso-8859-1?Q?47Zgm2q1vPLDW/TliWmoI9YFB+WuDfrrjqdFOlGUC43FsH+jVaLqJGZgxq?=
 =?iso-8859-1?Q?MILVru5BOEoJUYlBlQ5ngbS0aUGBfOz2P3RJl6L/B7OOdxa8Gyzc3R/qm6?=
 =?iso-8859-1?Q?SDPxLWqYIDXKKjYGdkktgS5Fvg+1t8dlX7DTqZOuUIkDLr1x2z8GvyPBq8?=
 =?iso-8859-1?Q?vAYt/JKGMRg3GAukaKFwZd1SgeaQS6hHMs7gDftOmuPXNQw3I/CmYAZN1y?=
 =?iso-8859-1?Q?igocsJhQMEKjTZcOQXgyyhVD1JbgdAKgMTLURZA699eOChN8F8WZvPGy2e?=
 =?iso-8859-1?Q?de/SVkC4RmBSd/Ie2bTbpcUkMg0B+SY61AkyelHQzsL+d06/i6uRRfENyB?=
 =?iso-8859-1?Q?T+uVoN0OXHAt6uuBNafeQTuQgzZd3ByDLdTC4JkyaaIGiMVE6bi5rt2L8G?=
 =?iso-8859-1?Q?+ZGDlq6WtCWSzeppWIE=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS4PR09MB6518.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f175ca09-2d1c-4208-6b6e-08ddfb4b4ba7
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2025 09:18:14.1987 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Dg6rsJrXe3/B8/GxNQmLK4oe/Wxac4HiYWwZWVi4a/2KzRPFtEcnTyUguOeZh9cT3VSocAycYJsiYQKF2Af2lf647u9aXSKlMYxtgaY3yII=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR09MB7826
Received-SPF: pass client-ip=2a01:111:f403:c200::5;
 envelope-from=Djordje.Todorovic@htecgroup.com;
 helo=DUZPR83CU001.outbound.protection.outlook.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FORGED_SPF_HELO=1,
 SPF_HELO_PASS=-0.001, T_SPF_TEMPERROR=0.01 autolearn=no autolearn_force=no
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
index 74728c5371..6e0bd6b798 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -3281,6 +3281,22 @@ static const TypeInfo riscv_cpu_type_infos[] =3D {
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

