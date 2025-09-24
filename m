Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E35BCAC5B2
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Sep 2025 09:21:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1LeU-0003jY-T4; Wed, 24 Sep 2025 05:19:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1v1Le7-0003ep-Mb; Wed, 24 Sep 2025 05:18:47 -0400
Received: from mail-northeuropeazlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c200::3] helo=DU2PR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1v1Le0-0002yg-KH; Wed, 24 Sep 2025 05:18:41 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uVIzpryp7MIbZZGUy8SI1mx/XnRKnq63+aHjR9ycbLfpk5FYNmzsN0VjKeswrpHmV4OcRmUllA1pgreVScK62x1H3gMDLbHjC6wSbT/H2QCSi0pFytYu8WpDtDpZliC96foTcoJ25Gpw34zCZZFV+i/y7BtBb+nFXE6sK8ATzLUrRoUFEK7hXvBm5E0hnlOwbSv73DSkffa4A704CL9zCkIOSPxlBhealiLggEp+yAoPqrQJOIk6689PFry5LcxbS1j7tyA3EPoEFfYAqxgFG17BtS3aPFbt5YOvoscKlm7PPAU74y1tx2brkNHzP2mktBHnLecySoZb8YMGGzn8OA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JB9+MWhu0JXelnCpKrizX2qJyRui3/4sI6qBobEVaCQ=;
 b=DEtkj1xHx+UnOtU7Rt+76zLoRVcwZ64mCtgzPlbQmjXIe2bzV/RWFpJnJfO9tbXqFh9htnrAyKW6/3RiHoVxYFQz48YWbfHJerFPN+T7IYLJOqv9MGVjD91tcHhhI5F4ceF95hL3hx88r8AnN/3PCHO03EUvu4kBxOHJ/sCuaB23VNyeaunLe5flHyMK0nANdllCjNLJ9RS85X8EBsKnK2svspnQf/T2eiBz5W5CJdUxLu80hyHYZdhJI0/921W7M/SDfNa63o/sgnjhPY6NGgkxLLLgPT76Vmzcb+8t+TDZgWZunqQMlNAQuRGbzX241PCyzrD9DEesguIohlMf+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JB9+MWhu0JXelnCpKrizX2qJyRui3/4sI6qBobEVaCQ=;
 b=CiNCeQc+IjucVROMKgdkS4lBhmCNV9zsl/pfwkCJoDhthXukgcUZILZm39QsoS7YDSGlNa57dZRUTeRQ6TD7zBeWgK2ygQgFl6GhMu/3qbm4d9jWkoPu5fNketeYertFAjLGlnULpgvzASqH++aMHRPSlgTCzmCj5LW8FY1ldHysb4DLJMqikoJsu9CnyuCbCZ09DqPzVpCInkTm5BAHmR7auKR/KEAdOjfvqydYFJf6IEZOKjddP1zWFCISneLmq96OwJj8vL6N5QG6alIRYGVzBXtUoEQ3apLDkbqRZ5GYPNMr5c1nWhPmTMBOeTliwoN7rtujZHevCImi8qxRjw==
Received: from AS4PR09MB6518.eurprd09.prod.outlook.com (2603:10a6:20b:4fb::5)
 by VI0PR09MB7826.eurprd09.prod.outlook.com (2603:10a6:800:21b::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.20; Wed, 24 Sep
 2025 09:18:16 +0000
Received: from AS4PR09MB6518.eurprd09.prod.outlook.com
 ([fe80::ad50:891a:847c:580a]) by AS4PR09MB6518.eurprd09.prod.outlook.com
 ([fe80::ad50:891a:847c:580a%4]) with mapi id 15.20.9160.008; Wed, 24 Sep 2025
 09:18:15 +0000
From: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "cfu@mips.com"
 <cfu@mips.com>, "mst@redhat.com" <mst@redhat.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "dbarboza@ventanamicro.com" <dbarboza@ventanamicro.com>, "philmd@linaro.org"
 <philmd@linaro.org>, Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
Subject: [PATCH v8 02/14] target/riscv: Add cpu_set_exception_base
Thread-Topic: [PATCH v8 02/14] target/riscv: Add cpu_set_exception_base
Thread-Index: AQHcLTQnBBo2/HUoiUKPvlIyg82HWA==
Date: Wed, 24 Sep 2025 09:18:13 +0000
Message-ID: <20250924091746.1882125-3-djordje.todorovic@htecgroup.com>
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
x-ms-office365-filtering-correlation-id: 043cfb5d-d2a8-49df-fe16-08ddfb4b4aaa
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?QviHsvx2UJqTEiOmta5oIQxMJBJ7/FAUc9YCdiUzPyqWWCSlY8ED9X1FFs?=
 =?iso-8859-1?Q?xGmeuIXZVowKPnuo7x/cmnjND4dXVpPU0leaf9Yc3Dl4E1GIPIQZ3DGZOl?=
 =?iso-8859-1?Q?JFuurNFdMlJRgIA0xmOgWBkw3BHrQWK5JxXJnag1RVDBhl4eQ1a+7uI8J6?=
 =?iso-8859-1?Q?lRj/+ED90YrURpf5+Qjr8SfLib2INfvKJt6cpKZx0/Sx+M/vf8ZLad1845?=
 =?iso-8859-1?Q?f0UYynS66PzWBENdKX5FFBIxDotQh+g7UwhYLAaBepVzc2Vf7roCU4cX+o?=
 =?iso-8859-1?Q?v0TOIxh/Tf92GZSY96gtWPtHvWwtxsIISooBUKe2PE9rPLO9Udog4PkYbh?=
 =?iso-8859-1?Q?iABxClXeyWhl3PzhgAzJkuvk8DF5WK9Joqg6JvXG/4Df7H+S+3XEIw3yED?=
 =?iso-8859-1?Q?hTCP0c+F3tFLNyTxa2poh3lEPk6Cal4qFmVxUTPoxa0e3Uh5qocf2i7Y3I?=
 =?iso-8859-1?Q?f7p8bd//tR0xSBbAsiAm9IcCthMRsdIRekUTb9Jdi3QONWj/TTUcjhOhAg?=
 =?iso-8859-1?Q?PmIs8G16GwJKt1cDoHbg13tOcJRBdImRjcVpRZ1ytuG63vYZ8yAT9b8JCV?=
 =?iso-8859-1?Q?giPLDBgHczmMqVDVnsADODJWadPBKQ6Y3IhcVN7QV5Udw3D5JJQ/SqDpET?=
 =?iso-8859-1?Q?V99jsvK+BeW1nX+SFachxdViKhPmDkS7MThRDiXiZJraO0giT1W/rOXZf9?=
 =?iso-8859-1?Q?zB+n3dcju6MtJOZi0tJwGmCtyhx3juKYBn46+GiHg//lRXeic1mOZkOoyc?=
 =?iso-8859-1?Q?2Wb5HDYK6X5Tv4VHamHm7ZpuFZLXRtHRZG65DfGQu1Jy6ZWAFgJB7ovN2b?=
 =?iso-8859-1?Q?JFhHbc7KB7TCukYcf4FG+ReShmUU0RIvJcbdEoXGyERCmCmALSo6I2jlEs?=
 =?iso-8859-1?Q?wWu9z4FUdj6b/PyCoUf+smeqDJvcuQjqBJaKi0iCsGdNiApxwq6KkwXif0?=
 =?iso-8859-1?Q?e5HwF6osz/DU+bCbzvypWU69Yd2RLRQYYqLPjkB8YCnBV6Bb/ky03NjIMX?=
 =?iso-8859-1?Q?7md58GPmK9useA7aMcUDmy9K0I2+LB1MFWRH1RjzyJQ6vfTy7y1yFjhUd7?=
 =?iso-8859-1?Q?3r9mfU6qyL//m38UwNBCqjdkiJjqdWv1jYED1riF3ydFgRLYbcRPpYJDdw?=
 =?iso-8859-1?Q?9k9bGcJwF3cSpNk8FV3Z5nE5G7iMju1dpkyJg+shQVCXMG/Dnw6kXWJ7y5?=
 =?iso-8859-1?Q?70HkGw5TeHC4rWeww7SSJSnlSdSziJbb0HrK7rJLfuvgwCkVOlvS08sviR?=
 =?iso-8859-1?Q?l+1PAZU4+3yrD3ub6KrvoK2EuX8xTYLONXIbWU6CjHU1fnLqDP4bgXr7VW?=
 =?iso-8859-1?Q?M8m/P2SLLAcrAJIvHY787ft8aNo3v2LtpReAMdZQag6gP3gRGaFwV+mti9?=
 =?iso-8859-1?Q?4aHqdLUnclw7cxzd1lQM+eqFicoijVdptOWtMW3oIqKoyWNZxGimOvMoza?=
 =?iso-8859-1?Q?sDxkkvpw/f3/VikcKpcW/8Ra4HFoWjDXa35RbHMi6nzppxmp6f1cvu7MN8?=
 =?iso-8859-1?Q?fWDlzl+X/kklEJm01JlXbrSKTZDT/84lR2I8+NIFr4tw=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR09MB6518.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700021); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?v8YUSxyKfzO7Y66eluQ9fcvpw0h2QCWx3Horz7/tRnrDvEr/+DRy0nzp/L?=
 =?iso-8859-1?Q?VbqxsSm45H1Fs/5ApB4HTChE9KBYJg8rzVBHEWqMvWQt+gryGEwzjxkoGC?=
 =?iso-8859-1?Q?Cdj15SEmCIJ8LEzkO2NxI0/UlKdmaGHydd/uU1mY1xTtHc5Bl5PcsWT1Hf?=
 =?iso-8859-1?Q?i67YHUUR9SFniTon5eX0PzQXXp84G5QuNQtCfeIXdv8PEnwxQQ8KsBLuUH?=
 =?iso-8859-1?Q?ZmrFogCf30Ubm95BUDeVzO8z4O/PG9JcinZ8+6Uw7HN7cvLe9g+J/C1+mj?=
 =?iso-8859-1?Q?PmHU0h3PAPZ7D0N+CtraCeugl/nHTGKGz9gstDuucor2rPRql87XUr9mjD?=
 =?iso-8859-1?Q?7V4wxYDGx7Ei2I9VtXckZluxcyx8XNzop5GNF2kXK624zzXVW2nd4WJiUX?=
 =?iso-8859-1?Q?td0RR6xepOV4IhGvYlmSb00fBh3I5cvDdKWQ/cFIt+Bo5Dv9454ksJLSCs?=
 =?iso-8859-1?Q?OwI5UNU88slvAXW0qWjuoCJQL5nUvg+xqwSYpeSdf7KoAPAsOkcPksdjge?=
 =?iso-8859-1?Q?/e9B0g+4Y9mTQjyIHZUO9WlqRTPeRox3CkmJzvtyJMnBaV8BjftDizWFHQ?=
 =?iso-8859-1?Q?S8VtTvu2H4umfmeToR5K1SNwbOpdv/+5K5RBGVgxGGsxhQ4Z54r1HnzZ7m?=
 =?iso-8859-1?Q?NUvgHNxFETyMq2V92oW3BvJBvqV5p2V+kUmPRE7flJnvj/HZd3Gj6Hn2tY?=
 =?iso-8859-1?Q?9YYUXHCfU/S4+sX3CXFHmWdn3mlgjNlfTXjpCoIhdYOLCHUZGDotbqSIFQ?=
 =?iso-8859-1?Q?mDaIrzRNoIFUJLoQdnc9+AC7zdVWU1sBJtKqcJrMKsPgipzIRdoD08l7vF?=
 =?iso-8859-1?Q?Hjt7ELZvHkbW/egOT07SE1HsI43j5JM958ctX7OMpFRD1y71l2jM7lPyEp?=
 =?iso-8859-1?Q?yLrOZHsLzsIXYxKiychGik3D3sRDwV/6fkt89q2lQnjdTLJFt+6xI13hpT?=
 =?iso-8859-1?Q?rr5nDiddHDsUYKkpkONG2c10Lnt6p+fGfN/PCwD+zh34mstZmZPbDoQcN9?=
 =?iso-8859-1?Q?2XRckVwJjwr0dO1MM0HTqme0amKhsJoM/udo4RP/glRO45ym4ez073BV4l?=
 =?iso-8859-1?Q?MmbeDkd+XeFXC3zLG4TT4PYmzZCRFBzl0yMfB4Etnp/0hcd8nZBihGg3ox?=
 =?iso-8859-1?Q?OCHIf7F/QVeHu23Dr9g4U+/zuDwL7gm8mvtkofmfAYXvtZUvs56ApXxjo3?=
 =?iso-8859-1?Q?BJQa2NlGm5NWR6pXRZHZWZIE6lVEBBF9rj0phsRPO96izwQfzEmqXoOxVG?=
 =?iso-8859-1?Q?tayyJoecrqQ+ZZxzBlQs2rykd9eG7kjUc4yGsYeznd/pytGDcM5SW1dkfI?=
 =?iso-8859-1?Q?jHWzYHnkjYzfjgUjjWXIABXTs4IAlali2QVZMWFGiLHJASgk8XJ6wnuOPt?=
 =?iso-8859-1?Q?8l/UeRKjEbukhWIwydaugoIaqXKD2dJhcZ34CYt0nZnnEbBI5kepv9rxpg?=
 =?iso-8859-1?Q?yLaKhbv6a15RsJVXUNLENuUbHeZe+hqmdWsNcFEglSb95epTmhyemlEXkq?=
 =?iso-8859-1?Q?DtO7dPbC6HaHKC+/wegUrGxP8PnnbEvP+S21NGxp5vrhISxXAFbYvXvLkV?=
 =?iso-8859-1?Q?wy8m59YZ8XacRVQi9qm3j/pTMtZeKQVjwKhU3YKOgJhDMw1p3oge7/V2Nn?=
 =?iso-8859-1?Q?j9hwQLTVDlb2jDgk9mYM7E3fhCYc+nCsqNFhK9sGitYvblKhEOcWMLciQ4?=
 =?iso-8859-1?Q?mKFtKIITqLyUW4evuKE=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS4PR09MB6518.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 043cfb5d-d2a8-49df-fe16-08ddfb4b4aaa
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2025 09:18:13.8226 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vTi6ms0wDNl2YVhK5Z6DCcOoMSZO8guhym8ciVZAKXk3mnUdX4Zn98sRqT+d8DX5DKd7IJ97faWASNDzH6fZeKqPR60Yt7iR5DIUHWh/IsE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR09MB7826
Received-SPF: pass client-ip=2a01:111:f403:c200::3;
 envelope-from=Djordje.Todorovic@htecgroup.com;
 helo=DU2PR03CU002.outbound.protection.outlook.com
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
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 target/riscv/cpu.c | 14 ++++++++++++++
 target/riscv/cpu.h |  4 ++++
 2 files changed, 18 insertions(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index d055ddf462..74728c5371 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -73,6 +73,20 @@ bool riscv_cpu_option_set(const char *optname)
     return g_hash_table_contains(general_user_opts, optname);
 }
=20
+#ifndef CONFIG_USER_ONLY
+void cpu_set_exception_base(int vp_index, target_ulong address)
+{
+    CPUState *cpu_state =3D qemu_get_cpu(vp_index);
+    if (cpu_state =3D=3D NULL) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "cpu_set_exception_base: invalid vp_index: %u",
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
index 4a862da615..34751bd414 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -672,6 +672,10 @@ G_NORETURN void riscv_raise_exception(CPURISCVState *e=
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

