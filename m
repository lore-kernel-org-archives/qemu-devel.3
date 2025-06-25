Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 317A2C7EE2A
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Jun 2025 14:20:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uUQxH-0006wu-7d; Wed, 25 Jun 2025 10:18:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1uUQxF-0006wh-Lz; Wed, 25 Jun 2025 10:18:25 -0400
Received: from mail-westeuropeazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c201::5] helo=AS8PR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1uUQxD-00048J-D5; Wed, 25 Jun 2025 10:18:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TmituhhRCdEC2HN359PkkqzYLuhXMoCrMzrOoM/jj36URjlVrrYW64TE0g2GmC/NJejCiftCJ85hx397C7lbnKJ5rhNiJwilGbGjjhWSWsHeJ2yoM5Fyr8DO+Yurjw9EM2M9QB2CWm++oYztpJjR+QmI04oI+OjbMPPYZwxMKVq3x0bgQV9KX+Ged6qPJzWTBUyswaUVeTlb94rFEU8jWXbSUkC5C5+s9yAb8Zhw2eAYAYpzNimLItzh5OFj5rnzaDdBamrE7Vx3+wXAGTUjPSgIlmmRJvN8TyJhDoLjWADqN1eyACI5J1ZL18JMg5RRA5qMGWGnr43v6kA/a0hwpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ApR78qFgYI+bWgSptj1QK6xumy14qDSsrPVCZeLuV7U=;
 b=hX0/ZKtnzhPd4zdDO/aBgbpTwPwdG09NII2CGNiAAzSy1GWvZHXGO2yOPin5LcN7J8JLaM5MU5b6Pyg06woVln/l6wT0NWkf5Y8mfVm6Prg+KDvaiCKdlMq+rZDu6Gj4dAOTyjMxyD/x62HaC4/A1pePE/ji9CF9nYRJEgooFaoffVn7pw6xhyTmcx9ByWTQ3Bf98MR1+kGnNVGd6AAvRvtmApbejHnkl+sCjhrSpyNNyCcuKjQYKSDuYcT4dkT4LztLOH8LWPWLXNs2h5c4Mb5V9HknPyly5L5kovd7bNrNN9cgjuUWmYvdRkBntaxZk7m4TIG0bfz1rw6Pyo9RlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ApR78qFgYI+bWgSptj1QK6xumy14qDSsrPVCZeLuV7U=;
 b=DZlWz1qcji7b76OoBiZdivJ0/1EGz8fNHlWMlbpuwO2P9ZusaUer+CA81WBymkBUYJbHAm6526y6MZaWqL2syrGFOcqLEXy2CIDcatd5ovMMyXvHjcIRxdLR1WVpVZiRUJwRlBwP/105+jvtNjy6W5fWRzJy8v2KWU4M67RZPXeLJYEDqIFCFlord5D73SmD325JgXnxec+nsiSQvq79kRebkYF4mFNCK5zXHbIz01U1S53+1Ob0q8vhweYZo+nQy4Krh7cnt75N//ciFNf0OXKid6Ye5bNb3mvXEGjz8cmMJwGG/5K5i5AnkVCD71z6GmXnzvjb+CgdU2HvlcBkVw==
Received: from AS4PR09MB6518.eurprd09.prod.outlook.com (2603:10a6:20b:4fb::5)
 by AM0PR09MB3665.eurprd09.prod.outlook.com (2603:10a6:208:182::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.28; Wed, 25 Jun
 2025 14:18:17 +0000
Received: from AS4PR09MB6518.eurprd09.prod.outlook.com
 ([fe80::ad50:891a:847c:580a]) by AS4PR09MB6518.eurprd09.prod.outlook.com
 ([fe80::ad50:891a:847c:580a%3]) with mapi id 15.20.8857.026; Wed, 25 Jun 2025
 14:18:17 +0000
From: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "cfu@mips.com"
 <cfu@mips.com>, "mst@redhat.com" <mst@redhat.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "dbarboza@ventanamicro.com" <dbarboza@ventanamicro.com>, Djordje Todorovic
 <Djordje.Todorovic@htecgroup.com>
Subject: [PATCH v4 01/11] hw/intc: Allow gaps in hartids for aclint and aplic
Thread-Topic: [PATCH v4 01/11] hw/intc: Allow gaps in hartids for aclint and
 aplic
Thread-Index: AQHb5dv+O10O0b/FqU6T5MMxeAV31g==
Date: Wed, 25 Jun 2025 14:18:17 +0000
Message-ID: <20250625141732.59084-2-djordje.todorovic@htecgroup.com>
References: <20250625141732.59084-1-djordje.todorovic@htecgroup.com>
In-Reply-To: <20250625141732.59084-1-djordje.todorovic@htecgroup.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS4PR09MB6518:EE_|AM0PR09MB3665:EE_
x-ms-office365-filtering-correlation-id: b54a2b66-33dc-4c87-3989-08ddb3f3217f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?mxXgMno465wVUwdPKlOj726mRYvHN0pqnDaV4cH+QUlvUSMpAf4a8qzFhZ?=
 =?iso-8859-1?Q?cWVvvM6TZl/yJpLJgreldj9I7nYVKDqmQhx2CtxSHWGsQVFqcyCfZCMZWc?=
 =?iso-8859-1?Q?7kaQ6sh0BRb+Z6tny05EJkCGE9Puq/YtH15ETeHJ7Jdr/85SXAg7sN+Jeu?=
 =?iso-8859-1?Q?7ijIA00BJB+zci/3euOBHLRl5brRz3D5AEK/tkco8qcKiMaWanczjOofso?=
 =?iso-8859-1?Q?cgaZ4/+0wtfvi79+Zw7Mp9zRhxSdkH3iktSuoEcGvC0gNAkrSVy/3q6EVg?=
 =?iso-8859-1?Q?Pjag2xm4HjDSjvMbvog0Qr5NNVzTjyZGndvSNWpGKg9oJCs19D/yEc3VHQ?=
 =?iso-8859-1?Q?ZOCpYs12HpZDqYmoWaWzs1XTbqzSz3pCBNjyB881hY8kU/Kbkc2zbACn8P?=
 =?iso-8859-1?Q?unPGxM4/O3SYZX1nvMqy5sYBI2zQ2FvDtsL/jNRMZzsaXuaPM5R1JOLe7q?=
 =?iso-8859-1?Q?8LHGPl4T5EjjlgBIwxKXOCWfWURGUXmk5BkwXtgIppQV1oBxfrrbykmN+Y?=
 =?iso-8859-1?Q?USZyIOHwzbLLZmi1im+9xY463QgbEKYl41RINoMuJY8x3D1q1Q5VDyyyrI?=
 =?iso-8859-1?Q?yf2tWd4frLWb6Xn+Yc04Doyg6NTZIMRkhsOaKCYZ+E5AWqHT/Jk/5pgPo4?=
 =?iso-8859-1?Q?bb7qr2c39XGDMgPFfqf2uVapcvuF93J6MdLSaTOO9SEEemnWBDAakVEy9V?=
 =?iso-8859-1?Q?pmMZbiDj9J6BTXhhgdvQ/lgj2xXqxIYlY9UbiIFAofl1IOScvG/GAo+iWn?=
 =?iso-8859-1?Q?wpzAtssZSCVRWIKj5pWTBlCeJO8ECsYLCLD3uuDjIV3urzGW/s+F1U5yrA?=
 =?iso-8859-1?Q?GvGoyp/1CIQolyPemHFuIbkPvLxEl9d8Qa5WixUvIJcr4anzQtRy0U4qEC?=
 =?iso-8859-1?Q?mXcP50W4IND7s3IwRb7UC3H6CyzskwSE6YzRGMGTqAbuRJ/toI/4X6NpnL?=
 =?iso-8859-1?Q?zcLzLEU/TYTP15vEXn9sdY54DivLosW5VGYSGMKMt14Kfbyun7zvsW4C+G?=
 =?iso-8859-1?Q?YZ9WhiKlGR0lc7eGtNDeqKypPrFcaVsUIMjGUGuvReCIbv+QBErqlyDsHE?=
 =?iso-8859-1?Q?lAXkRbDCFcP9iaHSCXzslcBfEGYuoytXVXcFl0U7pO8qyrW3025lPWWJhM?=
 =?iso-8859-1?Q?7MqiU7XC/ZvUZYgBONUmH7Kg1goHvUMImgr6yvPUoWyN9lOJNKqSlj9/km?=
 =?iso-8859-1?Q?iF0lS7zELN7JFelIPM6/fNvYCTzkNwo7GfwixMZXsm273ogZRXiNz+NCuy?=
 =?iso-8859-1?Q?jGLlu2ww6uGfckY4j2r6XML7NwWV4uXXO3w9x0QRNReVS0/4+AzxCCx8ou?=
 =?iso-8859-1?Q?3bo5rsfuYT4tjSWsFYJdP32M250eGW6X6wbuqJuOWkyiCOSoyB8to9u9RP?=
 =?iso-8859-1?Q?5t1ZUG42vN6jikD1b4Qdjwu1ToeNfYU655UXv6VqxQP95V9Dy/Daqr31Vx?=
 =?iso-8859-1?Q?63e9YD3hwZFO4pO5/bS0DQt1KNI79UfiQpgnr8XtEbjamT83j82RBakE1E?=
 =?iso-8859-1?Q?72OswQqm2cjungCRI8l/QtIAtjaoSOBQ5SbAznFzLIHA=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR09MB6518.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?nZpfKVCxRn/Rey3sdbHujCqc3NaPDG3ScLo5AGawA1UW6M46io6Dx56Y7w?=
 =?iso-8859-1?Q?r1pei878fgSUO6Vlvn2PycYPXnROGGr8u9otMYrWU8m7ikMbC2iM3uDh/5?=
 =?iso-8859-1?Q?T3EItIy7ZThSJ7+aRsyRqULMevUc/vL5HqIvo3AgQ6VmCU/vTZCApuKrf+?=
 =?iso-8859-1?Q?6KK62Cbz8XhpgP3jRAUIUnDAorRV1CSlX5Nfay+wPaBr4dBD9t0Fbz/t3Z?=
 =?iso-8859-1?Q?DIDDnuWxI8opI3LV8BQTiO/+LMzsbwlXw6bYJfR6X8yBpAqgi3Qom1YogJ?=
 =?iso-8859-1?Q?BDZMZhg50yTvCAbxWO4zDVIJuQHtvn7ZvJZH20w2y/8O73+lkzZgW8Z7WL?=
 =?iso-8859-1?Q?3qKnGhdKx0Rg834LHRsAQtmu2eJAmqNRjIK/AM/8TolNqoTX0Le7EeJLT4?=
 =?iso-8859-1?Q?tcY6xPbPYZ29qBexu5+jzSh/5QEZt5kvldfxiABCoF1RGAdjPkBmLZmGUB?=
 =?iso-8859-1?Q?W3/ihj9y4Ax75GVGB+5YVS2R7BeEL/7a3uVzEO4GSbdbusHC5CLwhg5paM?=
 =?iso-8859-1?Q?NC2Mc2ZT9GfQqQ+epsUmhG66cP1jpR3gRx5voWNh36CsVlwbakpP+23vNk?=
 =?iso-8859-1?Q?W9HpBeduFiTyuN1ySrsyrCdr2QSapqTsiPRgyhviBjW7l+pwSTAHM5yqYv?=
 =?iso-8859-1?Q?1JHHS9Fgn2RxLYuDUThXqjTTMigZmPjPZdALLrIfCCztooCLI/7A/pVvx1?=
 =?iso-8859-1?Q?jeBwoha//LTo1YsG6JxNlXz35CblmgiGl7Qi4XXyqjGZ8pBqE3sPPLnDr0?=
 =?iso-8859-1?Q?EhgFAGPZvGoRy7QV24KXiELZ1g8Cr/CoOiPl9KSFEh52kvLz0us9g3HHy8?=
 =?iso-8859-1?Q?Mhq3r3iY7pzyYjhh3W9aFkcoC4SQ+pS5moIVRe9kX8zYVldfMTp7bGybm5?=
 =?iso-8859-1?Q?Kr0Haz/ScKBavoZ+J88blxfUEq6dREUflidjfG5X7ywpNYoeXAyqvWLY+V?=
 =?iso-8859-1?Q?pGa5OrDIVGYxcx5ZiWht7sm5S7mBk7cMOdRqi+cz1696kawQ9LKkBzg+f0?=
 =?iso-8859-1?Q?5jpRCB8y1gFO5TXziS9VPmzgPUpCQYtEjRZ9QaCUO5567s5hOxQt1cK8++?=
 =?iso-8859-1?Q?bjEJaZcerj+gGwnTqvZaUdJu/OsZVrTpvuy+Y24UixlI6yLJE5aA8Igw6r?=
 =?iso-8859-1?Q?zNHWV8SsH9EKI9I8kxOCPk3zE4Sx00PTiqkCYVHsVdED03NYEP/s3IuAsw?=
 =?iso-8859-1?Q?IsVaCHJe6qVZpI3h4oMDnlCG/WlCDJEcwIWMeO2SNI1vQCO/6susbckG4t?=
 =?iso-8859-1?Q?X1dBNOjpBtndFNhcV5yodRR5mqD1NbQKNqlXBfWepjzy9yOB88dhV5uVK/?=
 =?iso-8859-1?Q?xnnz3QDQTrtneZH54i6IUZjhH+STj4Iufyq9clz6LRQD0ID9n62tfrAsZ8?=
 =?iso-8859-1?Q?i1mwHREpSJyc0Kn1HfncY7ANgXDO3GJfDRcBzaJXJl9tYNd8gPRfZMtIp+?=
 =?iso-8859-1?Q?GCUIe6LLzR7Nw6PGwY3H21MFqwjmcl+Px0wQzVF1f6ZZTfR0OHiF7Nmsnv?=
 =?iso-8859-1?Q?9Xny0CRp4xUv7gGwpSDVCKlRe2XijbvyLPCLs4AO6o02ltRXKC5D6Hbbam?=
 =?iso-8859-1?Q?Ml9unDUPYkrW5azkF3n1r0dcJaE/X0E9iKnc6FPWEvVjPQt4TkADwozEsP?=
 =?iso-8859-1?Q?aC/8l2oTbBlHACw3LTg/Y99mUvsxFWAlMWXY3VuHgK3w6R1Gb/4fF3Kt4H?=
 =?iso-8859-1?Q?EZG5YGzvg8PvcH26q5o=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS4PR09MB6518.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b54a2b66-33dc-4c87-3989-08ddb3f3217f
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jun 2025 14:18:17.5196 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2s7lMsRrO9bQg8u1Lln5nNWmYjbJxi2FkxIjWrm3ZHdAfTKFQsRelhG7Td3af2oRLdWCVWGGTDx8G/OHtTz+i7Cq5nmEyt/QPrRrtP60Xko=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR09MB3665
Received-SPF: pass client-ip=2a01:111:f403:c201::5;
 envelope-from=Djordje.Todorovic@htecgroup.com;
 helo=AS8PR03CU001.outbound.protection.outlook.com
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

This is needed for riscv based CPUs by MIPS since those may have
sparse hart-ID layouts. ACLINT and APLIC still assume a dense
range, and if a hart is missing, this causes NULL derefs.

Signed-off-by: Chao-ying Fu <cfu@mips.com>
Signed-off-by: Djordje Todorovic <djordje.todorovic@htecgroup.com>
---
 hw/intc/riscv_aclint.c | 21 +++++++++++++++++++--
 hw/intc/riscv_aplic.c  | 10 +++++++---
 2 files changed, 26 insertions(+), 5 deletions(-)

diff --git a/hw/intc/riscv_aclint.c b/hw/intc/riscv_aclint.c
index b0139f03f5..22ac4133d5 100644
--- a/hw/intc/riscv_aclint.c
+++ b/hw/intc/riscv_aclint.c
@@ -292,7 +292,13 @@ static void riscv_aclint_mtimer_realize(DeviceState *d=
ev, Error **errp)
     s->timecmp =3D g_new0(uint64_t, s->num_harts);
     /* Claim timer interrupt bits */
     for (i =3D 0; i < s->num_harts; i++) {
-        RISCVCPU *cpu =3D RISCV_CPU(cpu_by_arch_id(s->hartid_base + i));
+        CPUState *cpu_by_hartid =3D cpu_by_arch_id(s->hartid_base + i);
+        if (cpu_by_hartid =3D=3D NULL) {
+            qemu_log_mask(LOG_GUEST_ERROR, "aclint-mtimer: invalid hartid:=
 %u",
+                          s->hartid_base + i);
+            continue;
+        }
+        RISCVCPU *cpu =3D RISCV_CPU(cpu_by_hartid);
         if (riscv_cpu_claim_interrupts(cpu, MIP_MTIP) < 0) {
             error_report("MTIP already claimed");
             exit(1);
@@ -481,7 +487,13 @@ static void riscv_aclint_swi_realize(DeviceState *dev,=
 Error **errp)
=20
     /* Claim software interrupt bits */
     for (i =3D 0; i < swi->num_harts; i++) {
-        RISCVCPU *cpu =3D RISCV_CPU(qemu_get_cpu(swi->hartid_base + i));
+        CPUState *cpu_by_hartid =3D cpu_by_arch_id(swi->hartid_base + i);
+        if (cpu_by_hartid =3D=3D NULL) {
+            qemu_log_mask(LOG_GUEST_ERROR, "aclint-swi: invalid hartid: %u=
",
+                          swi->hartid_base + i);
+            continue;
+        }
+        RISCVCPU *cpu =3D RISCV_CPU(cpu_by_hartid);
         /* We don't claim mip.SSIP because it is writable by software */
         if (riscv_cpu_claim_interrupts(cpu, swi->sswi ? 0 : MIP_MSIP) < 0)=
 {
             error_report("MSIP already claimed");
@@ -545,6 +557,11 @@ DeviceState *riscv_aclint_swi_create(hwaddr addr, uint=
32_t hartid_base,
=20
     for (i =3D 0; i < num_harts; i++) {
         CPUState *cpu =3D cpu_by_arch_id(hartid_base + i);
+        if (cpu =3D=3D NULL) {
+            qemu_log_mask(LOG_GUEST_ERROR, "aclint-swi: invalid hartid: %u=
",
+                          hartid_base + i);
+            continue;
+        }
         RISCVCPU *rvcpu =3D RISCV_CPU(cpu);
=20
         qdev_connect_gpio_out(dev, i,
diff --git a/hw/intc/riscv_aplic.c b/hw/intc/riscv_aplic.c
index 8bcd9f4697..360a3dc117 100644
--- a/hw/intc/riscv_aplic.c
+++ b/hw/intc/riscv_aplic.c
@@ -899,9 +899,11 @@ static void riscv_aplic_realize(DeviceState *dev, Erro=
r **errp)
         if (!aplic->msimode) {
             /* Claim the CPU interrupt to be triggered by this APLIC */
             for (i =3D 0; i < aplic->num_harts; i++) {
-                RISCVCPU *cpu;
-
-                cpu =3D RISCV_CPU(cpu_by_arch_id(aplic->hartid_base + i));
+                CPUState *temp =3D cpu_by_arch_id(aplic->hartid_base + i);
+                if (temp =3D=3D NULL) {
+                    continue;
+                }
+                RISCVCPU *cpu =3D RISCV_CPU(temp);
                 if (riscv_cpu_claim_interrupts(cpu,
                     (aplic->mmode) ? MIP_MEIP : MIP_SEIP) < 0) {
                     error_report("%s already claimed",
@@ -1076,6 +1078,8 @@ DeviceState *riscv_aplic_create(hwaddr addr, hwaddr s=
ize,
         if (!msimode) {
             for (i =3D 0; i < num_harts; i++) {
                 CPUState *cpu =3D cpu_by_arch_id(hartid_base + i);
+                if (cpu =3D=3D NULL)
+                    continue;
=20
                 qdev_connect_gpio_out_named(dev, NULL, i,
                                             qdev_get_gpio_in(DEVICE(cpu),
--=20
2.34.1

