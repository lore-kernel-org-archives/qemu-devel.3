Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7490BCCD182
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Oct 2025 10:47:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4dIU-0003NX-2i; Fri, 03 Oct 2025 06:45:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1v4dIL-0003Mo-RF; Fri, 03 Oct 2025 06:45:49 -0400
Received: from mail-francecentralazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c20a::7] helo=PA4PR04CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1v4dID-0007P0-Om; Fri, 03 Oct 2025 06:45:48 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wM+Symhzc0u9iTtz8D2VGWWLeE0069rVk8RjoOq+lphHpUt2Ydlastt3d84Mq2rEez25qQYh/xLhmzj0eAgXYTqCK/if4ip2S8CZwnLrF/8OHbEHONXWBAvElwzD/0ZEHBwtJObsUuYxQZ0y4Hr7tQut5RVG1Z2K39RC1Se+CzYGcqu4IJtqjCjI50K3qQJcizb71MvAXXkWsPuEWfqaq6aUlRpl9MVGJzPEKlUtD/HTrJ5belxrXr0EiRlcWxFFads5dNrbDMJGS3isdzOeNwx3F26SlnDqhlyji2E9LO+OGSTj7kMWHQzmJFa8aBkhGoYSbc8FFpxWenxYZwMNAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LiC+jPgNYmMGDNUwCy0KC3usUv4Zeuw5Qqp/XCpQWOA=;
 b=vSFoJMHPXSbGne3djWIJWLIl+mNDDWH/PXSj5zauB+gHUqWqfN6XvDSTveaNkhchZjo0QFpLm7UdAyIeMcR53/baLzz+i63tuG74DmRwcoN6kPTBUza8AMx6Zc7GdikgGuT8lMgGpEY23Jz0ijffpTViTEUhu1vybveKlPPf+T9XCwqtgi0nkDFUtXN0DOM0+08WrYgBIXRtKbSQBT9pAeWLZznXseXgK1eYi4r1yChvr57tUFk65TmsNG6wDjZzxW0F+VLUV+k8LZZEQa68LW0D7omWkWKytq4QQLHysAsD59hNquv2rLvYjivjiy40yh1dpEtYiu2Wp8IXJV4XVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LiC+jPgNYmMGDNUwCy0KC3usUv4Zeuw5Qqp/XCpQWOA=;
 b=H+ZXXq4XoxA9eawCZyX969/Xr37j3h02ntjOBUkSqLkR3X6aSDVPK3tCX4kDWDgfzZG+6POHRc2vhpJa/iY92usUTZNaSibrGZv/53xk5uV6SGaX5UlE1rfe7Ktc3KGJ4sGom6ltMwf8ciP3Cyl8/VCfj63OQFQw8C06U715SDYWsuUb3kqbOCXQhW9EEBR3ChKAjZiSMTyGvb12MnJanVj0CF/hmKBc+AtgQ3XqxqxDUFGhi5TmBIYjBsL8tCLjdhcaConHa5c9iw1gGidjhhPWyZ24H1mij8sWYosud++Gm150hyeCe1GuBX9YUB8cdVmW2bKi4SrtwiJ5zO1cfA==
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
 <Djordje.Todorovic@htecgroup.com>
Subject: [PATCH v10 02/13] target/riscv: Add cpu_set_exception_base
Thread-Topic: [PATCH v10 02/13] target/riscv: Add cpu_set_exception_base
Thread-Index: AQHcNFLQ933MpePiBkSQKtgNwVOzQg==
Date: Fri, 3 Oct 2025 10:45:20 +0000
Message-ID: <20251003104443.51501-3-djordje.todorovic@htecgroup.com>
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
x-ms-office365-filtering-correlation-id: 8c78dc43-796e-4ec2-3b95-08de0269f2e3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700021;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?TkeZJMA0Wu21qfWZtArFQRzbEwh4Qk/5kxlZkAkndd/hb2t6S8/Ap23wZ6?=
 =?iso-8859-1?Q?mjDuXgotQTFddyyHmVAb69ttNO2/cyYDyZnZwE3IamN8WN2LRg/njaMRHL?=
 =?iso-8859-1?Q?QRDvj+UphW04UiD2C0FoSXpY4l/z6VtCs3P/5MXZoeQ8K6iZixG6r0Wwa0?=
 =?iso-8859-1?Q?BHlwkKr3hz/UxIhyQ0dyPBcVzX4W773gZPe+GL91B4QBqK4R0zxPIknlVq?=
 =?iso-8859-1?Q?kvOzkGAmsVz0Hvbz3/47SS88lr2PAPdI1K9mdpPkXZ5+V1+Qe1tTP/kEGR?=
 =?iso-8859-1?Q?meDTGG8+LNY6UuObkokBaMwRfE8Kkh73ph8VI2hjIOPBlKCjJHSaJQ43+w?=
 =?iso-8859-1?Q?3hSzbEcna1hPiHGLm074Y3LuEFfmwxqBhIY4VdHzwVa0kwUwNCrNnpZ5vv?=
 =?iso-8859-1?Q?JsRyFeI1ehNeyUeFQMhBuRQi6uCfZ+W7Lf7rlLIAiCEGzjNSzT/l0UQo4a?=
 =?iso-8859-1?Q?UtBgzNRh09S1IINqxuErB5kinqsVqEne5sBI34Lw1ihNG3/5QH1olHJQUs?=
 =?iso-8859-1?Q?Kd4uACM1+hoyWVEv+PT0Po/z+lbF05ZGdIcG3BAsrp8JB3/s/QHVk/DOIS?=
 =?iso-8859-1?Q?508XTsVBodN+l2VzFhU/03fJ+aX/y3H0nfJJZxKziatXIZYMq712wNJaXs?=
 =?iso-8859-1?Q?ptj6JlTmOVUsmcQrJpbgcCctGENqlS+veCRg5BkM4MLxvZ52oIxvLUcW2O?=
 =?iso-8859-1?Q?Ymin7nqCu1uG0wPyMz1Xwi3dd0UXtWFNriDo8NU41RNvCJQnuAO68+fq42?=
 =?iso-8859-1?Q?uoRFzqflrRfrCpPpM86mUjgqOZhGFcZvKGb2dlV3D7XgxYHOGE6vuYB0k/?=
 =?iso-8859-1?Q?9ELFEecT/d6r2FRI+mG/MxbKy2TBRagHxGd3o8Mz/A9SSjApy1/eUtGW9P?=
 =?iso-8859-1?Q?4lKsBeialQDhiHTcZMo1rk7WFcmf8cBiBjHpTiAGBJoeuKBkQhEs/W7mcP?=
 =?iso-8859-1?Q?2R1y5jecgb4eX2Ik1MWEuSPl1mq7KBJq/xssV4nNQSYiqOVb+Twx1RuJiN?=
 =?iso-8859-1?Q?BqjdW2J/qh1aiueHBOFCR8MKnvKMMHLXuainpW/Sk4Qu9VQcekEl4ekZJd?=
 =?iso-8859-1?Q?OPzFB0bhupaX1TsyyH/3RN7TpCn55yzdouP8pFkykQ9W8nrvzRZjWpSgpj?=
 =?iso-8859-1?Q?8KX3VDBcJO9s8XtfFHGkfIBbHS9ApQ7GoFv/Y3rGiAyKizbkLLgdBS4kFt?=
 =?iso-8859-1?Q?g4O2QoCCPnz1Bs1MwGx6prKPGGMymF77wZrERCjDNZQRwfSV5mculWOCO/?=
 =?iso-8859-1?Q?RJ8wtqe3RhP5iyneFERbUoQoJqjRq76Z9K5Kaadco53jgJrbQxJ+/dto/V?=
 =?iso-8859-1?Q?rXKtyEqzwpLbw+mf9XZ2TBqLDRu2WS0ym13jY35iaBkWdVeMelSBIuMuGb?=
 =?iso-8859-1?Q?1EwhLBsCDGT2GJPY2eNl3mtmd2jf4Sd2rP3JZ55ksj1rTWxNRukVp2Rj27?=
 =?iso-8859-1?Q?vpobIF0YgBjQ0sqACwXExdNC9iZTsSToMQ8xqUiF9ZDz2ESgXeCg/A6tBu?=
 =?iso-8859-1?Q?a4kophbpOFKBf0dVRIyYas7HjTFFZqleEIXEK7K/VPxwtsB28SqkIyxthY?=
 =?iso-8859-1?Q?n6d2aR9MErgUcHEs2X421/ahUOqk?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR09MB6518.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700021); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?/1UlQY8Y9s4hbZTCpUZHlZQG851Hbkb/TJiZzU83Be8jHSZaZpe2yLQnsa?=
 =?iso-8859-1?Q?we3smA6+d+07WtW0LsW8D5bkU9f0KsqbFA6BxD7hKHyj36QoKCD2rGvwzZ?=
 =?iso-8859-1?Q?LjaWC68GdwlO2RNIzigGkBjiHReYbbXhbLzLqvu6nPGROIIPOb8yBi6n7C?=
 =?iso-8859-1?Q?M5vi45AVCu803WFFgnomzik8+Bo6m2rnZyDoGOG1NuKQmfrTTsvd6j5fte?=
 =?iso-8859-1?Q?4lv/NfDvipTjhL6IF/vYEtUhsBkBIF4PP14XN//8BeFxVTy0wYJs6yXc2T?=
 =?iso-8859-1?Q?ATngArZneQ53A5FgFCd9X7BZDYWxZUuWR9tttohjTsaykXHQIxlCngK902?=
 =?iso-8859-1?Q?gOhoiwQi12JX5z81gNn6Op7n4VYNjwANCYsItxdMxKIdHYwolkl/eyTCwM?=
 =?iso-8859-1?Q?nRkPo+BLrNDDa/QtayjYzQ/OHbTRX2vIvrP8OtpgXow85Q5FdcaksRYhMr?=
 =?iso-8859-1?Q?lQSMXWOKcOhVgzSt0N9QNVrujm8qnB0RG5ERt1CnNXk4LXwAiWv2wsuEki?=
 =?iso-8859-1?Q?rnw/TZeXu89JGFXrZO7f7W4v1yVstLxPcBCnmocp6Pw2HZA67UgT9/iTxI?=
 =?iso-8859-1?Q?9PGINFp3yuMBiPoLpx5C1mi7eSpsTLH1xk0hKJYvg/1R0Zp6kzq+Gyx/Oj?=
 =?iso-8859-1?Q?JYWKAXA/l+Zf7WregjXEWunz8NSI3BDTXhGLtQezOG7oMI2NRUNXtCTCsi?=
 =?iso-8859-1?Q?D1CuNpQAisBVcPbctQJI2VU/b3WfPEl46CcDzCDNy2QcuE1s8IT0sI/uGX?=
 =?iso-8859-1?Q?DtMHJOzsjs7fhxEKRsJ9BwENFKsDZL18xFphLwxUk7eta7gIi1muKJVvO3?=
 =?iso-8859-1?Q?TKrrufcPtVMQeu6A267CG6qKDPQCyS6eccA4c3LjME14UbrxMhfn+JD7kp?=
 =?iso-8859-1?Q?M2vAAYoGRbSOoESWnw5XZx15hbf7CLRw94Nign/ZwzqG83SwWvKkWiDOpT?=
 =?iso-8859-1?Q?O1uc6IVp1wBUYEqBouQdtz5hrByAk5ZEyq137ffKSpgdNKk0issCs1yJgW?=
 =?iso-8859-1?Q?E6pziZpl7HrW6yK9TR6i7lJQZLc9NOYNJGS5eeu7O1O5oZyyDA2aFSMX2F?=
 =?iso-8859-1?Q?V4aj3stmqh3mhvz+4M8LufgHO8KaSxu/goq7XnuV4pQL9hpWSx2aV1epI2?=
 =?iso-8859-1?Q?tIp33moBSrh0teYkbMMV9uObdGevF3VhM9Wh0+G7RMSa2otyEOoCNbuP8k?=
 =?iso-8859-1?Q?xrqAoTd1EJPUC8s0z3orYRXw8elZtM32TwmPZEB9A0AQj8Rcp6dV4VgjNK?=
 =?iso-8859-1?Q?XG0CuYKUFUp4sGeUZwD7IgKgSnHrNb48YYcD0KUuTFMpsOJM+VlappCJqD?=
 =?iso-8859-1?Q?w8PH5VX2NhyWYqiOiudiCL3+FqKGn5E2DWEGeaTj+PCAKyDICPWFcCEKpy?=
 =?iso-8859-1?Q?hYTtI4xVTINoBvAtTL8nJASdXwadrluy5IHhgdDZRsrRkVwuMQvmtEiI/F?=
 =?iso-8859-1?Q?I5oGMUlfvGjjtypEqmEjfXD/BvEPlKJogx5DnPdD8DbAeutHcCBzCewWsJ?=
 =?iso-8859-1?Q?DhpW/b9qMXYB876zVMz903cXekOmTvx2fv2SYfo1zBVeLY4YO7K47yFMIO?=
 =?iso-8859-1?Q?1Y/nhioOTpyVpP/2LLgiB2G+kotc+gJxsQ2UzwvUcMa/Bmovkh3famM1mz?=
 =?iso-8859-1?Q?xhU7CqAQOgU7q7idu6oyf3xs/mPlLzYmCTg0Gwimltv+d4blIHzhxufYKv?=
 =?iso-8859-1?Q?V18Hq6w18TEfI/7hDcY=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS4PR09MB6518.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c78dc43-796e-4ec2-3b95-08de0269f2e3
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Oct 2025 10:45:20.2469 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EOb1lI6+GEKJ1A8GpeliLxC9ZZisbISQCR4LmIzmiYxFEnmllF/gSPWi1EjZiwuXqOdwaXMvMeLQv+TR95g0evKNOJgOd8eA9PzrK/2n/Ow=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR09MB7850
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

Add a new function, so we can change reset vector from platforms
during runtime.

Signed-off-by: Chao-ying Fu <cfu@mips.com>
Signed-off-by: Djordje Todorovic <djordje.todorovic@htecgroup.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 target/riscv/cpu.c | 15 +++++++++++++++
 target/riscv/cpu.h |  4 ++++
 2 files changed, 19 insertions(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index d055ddf462..d42cf9d70e 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -73,6 +73,21 @@ bool riscv_cpu_option_set(const char *optname)
     return g_hash_table_contains(general_user_opts, optname);
 }
=20
+#ifndef CONFIG_USER_ONLY
+/* This is used in runtime only. */
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

