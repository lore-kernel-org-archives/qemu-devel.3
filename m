Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FFBAC83F1A
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Jul 2025 10:00:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ucLLp-0002Hx-2M; Thu, 17 Jul 2025 05:56:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1ucL5G-0006yJ-Ov; Thu, 17 Jul 2025 05:39:22 -0400
Received: from mail-northeuropeazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c200::5] helo=DUZPR83CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1ucL5C-0002Sj-8x; Thu, 17 Jul 2025 05:39:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x+BMKBNkD6XymhZaI4yo4KzihdE6HR6XOJ8C8RxjpORvHUQ+pXiRYxoMa3azdrbS2Ypse1PFew6r8An+9r+brTWFWL1RpWwoJe8Cg89H2E5/biTh4RIxyZ4Z8RNMhrOV0NX2jPm4eytTH7YY3NmLt04Nb6QuXpwhyn6evBVAop/RxbjK5be7L3jTRZKjPvCMEjcGEfnjnjtckGhgesBVzXlBAxZSYUHkAeWG5QmPA4va0X7WewgjFCQ6OosVkmwHry9EuLu3nYKUFAMnao2+KFM737e2uxA1k5WSjeCEteCVBtrJFbM1AlwqF1WyGN8O8/N/7UYyqsxAHa76wO8KXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1q3rJBWImDAq4luB3RlZQ0coO+pP6l5EZ0FDzOxm4B8=;
 b=lkSwVDiL8xf2HiGHaFlJ1rKUS7blQvatYJzCGNv/JDolkxo0waNm0zM45IzpFzm65XBn2vt08uM/9mmnq7KeqqG5Ftpig/RhykpXHGTUUz7a+QUke0iT9OTPOAnBPevQ7e/nMFXa6anJBWZKnyi7wTln86QnbQJUy4v5JVXf23vg+LzPoJEgcOm79YwaHhfK2W+qFPfR7l2Qh3XRG2tCrksjsc8d1mhkUNzK21CRPlbjBHTGdI4TYfRB16nmlWChfmSqbYxFijTWCPwM3pwMWJJJoD8zTGuPDzpeH76sG1XoG2j5mapdiKPM9GZEeUvUK1wEP3twT7IK0Uy1mIpJgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1q3rJBWImDAq4luB3RlZQ0coO+pP6l5EZ0FDzOxm4B8=;
 b=cXfezJHd2xJMOECO7d/r7TdlMUHJ2+1SSoXvMvCMj5LItLwGglamTvrD61N5Y632i+SM9+0WonW3BdTnGWPYRxrIU+4NzK8qIygRJGFQZSm1G7TvyMPs7qn16cFE4WWUcAv1m+tN3zFFSTPSzP1gDBmRVV+E5drnE8VdCgmMXMHNLzC2rjdgPEkayc07Abv/9CvPPuF76MClfR9ilvi1n/5Po5QQ7/jL/nuoQrmCYDce4qVktt37UvYsXYQsswISghBV9jTZ+rGISXQKqiuOVGMZZpp1TVmrySUdtExWli/ef/EUuiu2vxIErxuEquMMPrMvuYfXfJESeZGJRUxBPA==
Received: from AS4PR09MB6518.eurprd09.prod.outlook.com (2603:10a6:20b:4fb::5)
 by VI1PR09MB4318.eurprd09.prod.outlook.com (2603:10a6:800:155::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.39; Thu, 17 Jul
 2025 09:38:44 +0000
Received: from AS4PR09MB6518.eurprd09.prod.outlook.com
 ([fe80::ad50:891a:847c:580a]) by AS4PR09MB6518.eurprd09.prod.outlook.com
 ([fe80::ad50:891a:847c:580a%3]) with mapi id 15.20.8857.026; Thu, 17 Jul 2025
 09:38:44 +0000
From: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "cfu@mips.com"
 <cfu@mips.com>, "mst@redhat.com" <mst@redhat.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "dbarboza@ventanamicro.com" <dbarboza@ventanamicro.com>, "philmd@linaro.org"
 <philmd@linaro.org>, Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
Subject: [PATCH v6 02/14] target/riscv: Add cpu_set_exception_base
Thread-Topic: [PATCH v6 02/14] target/riscv: Add cpu_set_exception_base
Thread-Index: AQHb9v6VZFghKsUyc0GtJV8y7Pp9kA==
Date: Thu, 17 Jul 2025 09:38:42 +0000
Message-ID: <20250717093833.402237-3-djordje.todorovic@htecgroup.com>
References: <20250717093833.402237-1-djordje.todorovic@htecgroup.com>
In-Reply-To: <20250717093833.402237-1-djordje.todorovic@htecgroup.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS4PR09MB6518:EE_|VI1PR09MB4318:EE_
x-ms-office365-filtering-correlation-id: f9b2b595-59d9-4f86-6c1e-08ddc515b8c9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?1owFxx+a39ohxNzCJlqBkUQ3l9Kc2srHsHOdbHEFYhpccWPtLLLH0oJYo6?=
 =?iso-8859-1?Q?bHRf24beAZ0wDvm+he4VoI0nmskH2w2Rek9zaSevA4QtwMwbJXOC1YpHjr?=
 =?iso-8859-1?Q?T8rKkWHdUxqoraTbk8jnY36qI0xzCptC24e3o+z/zt3BJuk+ufBhNkcWG9?=
 =?iso-8859-1?Q?f+iBlt4/LWzcy33BsmQw4WGPAI8jVCi5fXFIGWjfdgWtOO1vdf7XwibYKC?=
 =?iso-8859-1?Q?QkjIocACpioms9v9SX/7o+RHEU3f5sZw7ODTdWeqDmJEXGCLySliSyVymB?=
 =?iso-8859-1?Q?wyoe9Jggo2b58/jpLDezcJIDxqpT4oGdo9s93YahUEVxS0LyKi9H7FuByi?=
 =?iso-8859-1?Q?q7BMoxuG71TVxlZm6fvOA/k7Cuf8EE4Q6JspdpuCUH6CBZ5Yf6YJ0PFPyK?=
 =?iso-8859-1?Q?ZvSM/NTbaWhmrIO2gDb35EXgmrbRCbFXTpkpJ9J3gdGZK70KKDbdhHbXoK?=
 =?iso-8859-1?Q?0RiqOaAdVbpZrNVG+Ij1Znd0zjazqb0MDGqfVP+HS3t22BOwONS+dRWHUz?=
 =?iso-8859-1?Q?FvqN5Oip/W3vHNuEzvl/BNjA2htTYVtQYyYxbX8IchN5TTJn8XlJlotVYX?=
 =?iso-8859-1?Q?gwwO/wSTQ/pGmvyTEMlJDVniX5/bggTjMphHBh5HLei3tymhAIOHvaWr+g?=
 =?iso-8859-1?Q?I9RXcTKPCUk1JaY0NlkFRDabkjFGDiEIqfohNQxbyTNJibpatlGKH9BmHU?=
 =?iso-8859-1?Q?SmMgMOkPNyaiGZwPoPAdPnF514R6d3OUtWTjLERYnpoyHZJV+Xzejg1A/T?=
 =?iso-8859-1?Q?gJOx+uh9yBM7JlB3bpVW/0CNRBN1KWeDUg7uXBWSzz8dwiLGoSwOytfPfp?=
 =?iso-8859-1?Q?oOR1tEVAUT61op7/5ltiLaCPBvI2n9fZghR05M2B/ghrP56i5IZ6cCJP2E?=
 =?iso-8859-1?Q?znOTlnzN+7Qfc20Vk4sZT2TXvzzq/xw2AWO7lB+QPhlOyi8lEaMSWq/88+?=
 =?iso-8859-1?Q?1VlFQO62AS/3WiTqp9kBLP/52SKTQidH4M6Cs79SHcAYGLq247lvFkH4A0?=
 =?iso-8859-1?Q?osBJSUkEGKSp1KKWuE+uRCG6qShycqBYzJf0pf4QmbTUHylLWGOpIKh3gu?=
 =?iso-8859-1?Q?je02f96G9/b9evVU7W+UjwT6LgmdatBJcjVHl9oIexe2twv8Kaoq4M3nnF?=
 =?iso-8859-1?Q?SuYlPwH+JurgBN5D2UGs3h61iwYekVuixoYgMim6DQnxZE1zJQC3vEzwFx?=
 =?iso-8859-1?Q?x7kAZjx0iKBYnhtEdBC4VXOT/sjyVXaEDbNiyiHuvPJQGZc0Vnu0m9Tn/B?=
 =?iso-8859-1?Q?thYi1UGwdwAsV9/JF0MKBSDT61SkZuxajn//vPGJNFBjQ/fFNS8YT5zoEY?=
 =?iso-8859-1?Q?ZnBJJPQ6CIfg2QLurc2CPqqGn7tbhMSuQwULr3FauiZ1gBwKch+7Md69ym?=
 =?iso-8859-1?Q?/03DRg0+3g8iqam1jPPK4Osrtuf/yTEIZHSGOlXEJYN2sDK+pFcVPeXbFY?=
 =?iso-8859-1?Q?UaV9YmxvjLoSBnrtHV5z9hE38Pe79hfiRUyBP5NJOM+qUUXgWYPAcbtGic?=
 =?iso-8859-1?Q?R1rlnyI0EuT1M079URvRL2yIoTDRgwNnXjNunEGGD9YA=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR09MB6518.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?cleUjthnJ60oxL9Levd2LguSV8ZrBcWbtc4V3c/1GBDCdWDVwSbedy7OrQ?=
 =?iso-8859-1?Q?Zn5GF9nHXiea3KlADqEso9SvA2rvI6S9tERO0xCRuiaUApEhIAxg32Bpk8?=
 =?iso-8859-1?Q?CmBIfpy6Lj7ssqhyxnfht4ThpnQrT/y12pEBbpMwUj4T6tZFRsg6lvnsbx?=
 =?iso-8859-1?Q?QLpJwheATiNmAgBJyOUPfn9gr5t00fI68Jv7qlCAESTBBy6/IoNMSv7Xm8?=
 =?iso-8859-1?Q?t7nrlmzxU4ypHXsHVEsaJOU6W0Tc8rNzZdcvggzmKtyxCgngaYqnfXv1u4?=
 =?iso-8859-1?Q?i/vtMrCDUHAH2o6K1cwAj7a9TSp8EZ3PabEYSfKCoPlClxSHoMaslnVBF/?=
 =?iso-8859-1?Q?cekaHQ2JPMZccp0anbPl0a72gAqDzl8+ymJ3PDPEVxJawfnwbigC3uUefp?=
 =?iso-8859-1?Q?+wM6RkYIwXfMx9SYXO8mSCVHUA4yaFF88lMw+4pTAWhyxu9yF2dyzjKntA?=
 =?iso-8859-1?Q?i/NSPxYSYaP3+yJ/NIHj/ygggeQZrHms694+m034Q6NARDbnJzxVww0shc?=
 =?iso-8859-1?Q?l2uHLoG80l/+jeJAUscw0dms0PDhxfHa+gp8j05FDK6vLBZ2BO5sVh908m?=
 =?iso-8859-1?Q?DYpHC6mbu3i+F7pqRDWtnfq2O60JB9qha6T7z4IhDjkBAjUmyVD4ZZB+Ei?=
 =?iso-8859-1?Q?rLdMdhATHJAGI3PWmG0SnnYwsz195M2MaXTCVnVGRtIuMyDBHxVJF/HBIU?=
 =?iso-8859-1?Q?QhIuMJOHlxVDt7FlCaWImH/G7/HoaEhXFZQ/oX1HIexsZWPn4fIdduAU06?=
 =?iso-8859-1?Q?Wh2y2Fd7YBn8w4f3aeI1NuAsmZE9AMPUzzibwGEv5ujKxVooK49qkHliFH?=
 =?iso-8859-1?Q?Y/L8w35d9dsIDvTFlNE/KiroQlCNiyN6dHDP3VjiLPuQiGrPDZmbbraZr/?=
 =?iso-8859-1?Q?3IZTcjjm7ghTp6+jPr5669EjL6ad8rTXYIzv5w2RGvkNVh+u6qtRil6XOJ?=
 =?iso-8859-1?Q?AwbXpi8xUNPv2HoRrB8vrJK+te9GtDjGhwfZJfWzkBC8E0bt0Fo5afF1Lt?=
 =?iso-8859-1?Q?qtaQW8pddCu8n+dZJ2xo65NlbK3kpu0CdU8GYJRv4gxgb+GNy8nAsVyL5U?=
 =?iso-8859-1?Q?ImXIoa/5I8Dd9NGcfbgvHx/I+YIviJUbxx7pbZorWX0Kd1wR1o4eAVRs+Q?=
 =?iso-8859-1?Q?D8WvnBe9Fw9pbXl1FvaKms0DXp1mip0Uin70nQjxEP9gA6Emzfd5+N4cH5?=
 =?iso-8859-1?Q?ErLYwz3ue/5W+RZ06VyXAwPW1wbHqu+mwRsigodNRMNhdW9iRqlwUfvqye?=
 =?iso-8859-1?Q?bMk7QmFid5bX91sDAbV8PgcktMBIf+yhOVbfnp9HOfxcBhO4vQxkJHhrMP?=
 =?iso-8859-1?Q?aYrKu5ffpHQMdGxfZlwabVCQS3BlfezHs1tvIqGyDdwW+dWY5cmnqK17L8?=
 =?iso-8859-1?Q?48ribmH11TN5wWKwZq9A+jK9LY/ewNH1FqiEw95Ny3Xv7cXfeXtY8+//DC?=
 =?iso-8859-1?Q?f33jLtIfdoQxJeGD4+7z6hI0R8e0Z1iOQSNA94goR3kNXWqnXesMWmfD5k?=
 =?iso-8859-1?Q?EGkhn1I2jO6nJJ6CDNF0fU3N72o3hj4dyT0CQDn8uOReqagsfRsE1AzdEH?=
 =?iso-8859-1?Q?ErdG9ptEo2eXUoAxkcKhUP5tvtIhuC8bdo3qC8iD04zihw/uER36ShGEm2?=
 =?iso-8859-1?Q?PotCWrUr5yatucxs37bxvZx06P+hZ2tjRNoHrcWF1YeLCdDretXxEadYHA?=
 =?iso-8859-1?Q?pQVVYgv5vsVOsWImUQQ=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS4PR09MB6518.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9b2b595-59d9-4f86-6c1e-08ddc515b8c9
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jul 2025 09:38:42.3481 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9UPtHlrAGJzjJhYuu6p+QAhoesyTBS6wsXv34tvWn7SwLUdcJgETvRWuQ8S2BwmZxhooFxR1p3tTw7MCDVJ7+lbgJC2aJHCk6YvHXROl5TI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR09MB4318
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

Add a new function, so we can change reset vector from platforms
during runtime.

Signed-off-by: Chao-ying Fu <cfu@mips.com>
Signed-off-by: Djordje Todorovic <djordje.todorovic@htecgroup.com>
---
 target/riscv/cpu.c | 13 +++++++++++++
 target/riscv/cpu.h |  4 ++++
 2 files changed, 17 insertions(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 629ac37501..e584bdc5ac 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -73,6 +73,19 @@ bool riscv_cpu_option_set(const char *optname)
     return g_hash_table_contains(general_user_opts, optname);
 }
=20
+#ifndef CONFIG_USER_ONLY
+void cpu_set_exception_base(int vp_index, target_ulong address)
+{
+    CPUState *cpu_state =3D qemu_get_cpu(vp_index);
+    if (cpu_state =3D=3D NULL) {
+        qemu_log_mask(LOG_GUEST_ERROR, "cpu_set_exception_base: invalid vp=
_index: %u",
+                      vp_index);
+    }
+    RISCVCPU *vp =3D RISCV_CPU(cpu_state);
+    vp->env.resetvec =3D address;
+}
+#endif
+
 static void riscv_cpu_cfg_merge(RISCVCPUConfig *dest, const RISCVCPUConfig=
 *src)
 {
 #define BOOL_FIELD(x) dest->x |=3D src->x;
diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 229ade9ed9..fba0b0506b 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -656,6 +656,10 @@ G_NORETURN void riscv_raise_exception(CPURISCVState *e=
nv,
 target_ulong riscv_cpu_get_fflags(CPURISCVState *env);
 void riscv_cpu_set_fflags(CPURISCVState *env, target_ulong);
=20
+#ifndef CONFIG_USER_ONLY
+void cpu_set_exception_base(int vp_index, target_ulong address);
+#endif
+
 FIELD(TB_FLAGS, MEM_IDX, 0, 3)
 FIELD(TB_FLAGS, FS, 3, 2)
 /* Vector flags */
--=20
2.34.1

