Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E798ACA1002
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Sep 2025 10:31:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ut1n8-00041f-7K; Mon, 01 Sep 2025 06:29:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1ut1mt-0003tB-66; Mon, 01 Sep 2025 06:29:23 -0400
Received: from mail-northeuropeazlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c200::3] helo=DU2PR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1ut1mk-0005KU-Q5; Mon, 01 Sep 2025 06:29:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OKFstCWda++TWz71cQwbBb9dcfBForR6K77etNqdqc6/cYqeztqyIzRTkzSlGrMJx07go4bv2D+DVMe0dJh9WAHQuTIKc28/iu8kHUZ+qrwfZZUKjuRMDJ2OmLImIvXqmPcC2c31UUp5zMpshoQPo5LGVz97Xj47RjHqeTr1MYnelCqODB6fgUW/og4l3Z+jFFnOQUPrgMhI5Q0i7NxtXmTilha1+gBE11qUkVzsru39WI6YLeecZApz1HHgyVymkEGdmlorpHlLBOEsgXYyg4IbFkYknZQOF6WFosAP9PWIy9sYi6J7e84AMgYiENAXMj2z3aJOKOCnjKFmiLcpoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SB4+vqIBi4y7DXG/m4aDeDopRJJ0PV1u6N2F2DI3TVQ=;
 b=NePVSZjhP5+DxIp+VMY2C0ZJqyIa4IWK3HOGO8+4oGLsO8tTcI9HclAbgyoZtw2GFJsIfzWp+BmtCdVcUJFWCtJMHQrF8XhXpqQCUeGkFeJefz+4fyCxkQwWrq234RDJKvGXrSrG7UwnXubq81pvG0U0KEjCZyEQ+LFHTiDwMkmlwkNkjMuWoCYxMPKbzjnvcsY4kRkiZ+4qRH2FNiKBvoaimEeBoUEn1VFpxeY8xybxnHIYdfLC8rF6A6rkokYAVaekhIr8CpOlyZLo/mfheF9KYIkhjmUl2qu8BQTSh/hAzv1khwakOYgcpmcy7N3okvX2qD97topOOl2n9W5JRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SB4+vqIBi4y7DXG/m4aDeDopRJJ0PV1u6N2F2DI3TVQ=;
 b=Y3HyUan9MunMJ62yWFhguhgh6XRiLQ19PY64Yg8R4PX2ZDMpDN4InF1gq406icIOXUQR3Z+yWtffzk1NT5ghYZ8Zm88VTUdNaoQaaLLyZsmfZFHvn37K3jciEJX1iQ3FeA4uw3WJGOZYVKWmcVp+UdzCb3k6UGnHC/LkGxKKNxJ5tZjJ/7lPOxyj/AiUkk16FYonxzsVdMe+u31Wj6Iv+pZ8AU6nUVrujo+8jncVh71p2tPTtYJWR4H6ueVCjJBjebF5SoTADGBIpnjLaL5FF5OryEwuwf8tNik5grykJLj7ztgAjlf+2Hg6aH8k36P/ZyZrossv+uzZuVzLczSpbw==
Received: from AS4PR09MB6518.eurprd09.prod.outlook.com (2603:10a6:20b:4fb::5)
 by GV2PR09MB5992.eurprd09.prod.outlook.com (2603:10a6:150:be::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.28; Mon, 1 Sep
 2025 10:29:03 +0000
Received: from AS4PR09MB6518.eurprd09.prod.outlook.com
 ([fe80::ad50:891a:847c:580a]) by AS4PR09MB6518.eurprd09.prod.outlook.com
 ([fe80::ad50:891a:847c:580a%4]) with mapi id 15.20.9052.019; Mon, 1 Sep 2025
 10:29:02 +0000
From: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "cfu@mips.com"
 <cfu@mips.com>, "mst@redhat.com" <mst@redhat.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "dbarboza@ventanamicro.com" <dbarboza@ventanamicro.com>, "philmd@linaro.org"
 <philmd@linaro.org>, Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
Subject: [PATCH v7 02/14] target/riscv: Add cpu_set_exception_base
Thread-Topic: [PATCH v7 02/14] target/riscv: Add cpu_set_exception_base
Thread-Index: AQHcGys77s+4rHZKO0WiPsUIGey1kg==
Date: Mon, 1 Sep 2025 10:29:01 +0000
Message-ID: <20250901102850.1172983-3-djordje.todorovic@htecgroup.com>
References: <20250901102850.1172983-1-djordje.todorovic@htecgroup.com>
In-Reply-To: <20250901102850.1172983-1-djordje.todorovic@htecgroup.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS4PR09MB6518:EE_|GV2PR09MB5992:EE_
x-ms-office365-filtering-correlation-id: 813f240d-e9f9-41e1-ec0e-08dde9425eca
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?vBTFXA+D4896ocVvCMnIabPCcYd2xAoytJf89DsOnCm3A+d7y7ry7uE7GL?=
 =?iso-8859-1?Q?dBKtMR8r9d5bbXb/KHvjYWE79/iMDg9IXLZomu4fp5VAx6+QU+kpG2q68v?=
 =?iso-8859-1?Q?a7jWEi7XuEZ+hR3ov4pYCnrn3ihqwdQOPsQKyK4K26tC6x9/xw/EAejfLA?=
 =?iso-8859-1?Q?9F9pbieQIhAihac5GnG/EUEKBps1ey/nM+NiZiaPS+8X59ZnUHo8D+PqNU?=
 =?iso-8859-1?Q?YsbN6f1inWC8pxII+qlg87gREQdTF2ueDm9+a7VfuHsA9rrxV8bcgZ37bt?=
 =?iso-8859-1?Q?vqnW0q49U05cpVa3qCygMxFWiLD/02tTrE8nvtRElXFlOMzDbmCo7+TyKg?=
 =?iso-8859-1?Q?mVU79lFz98+6bbAGVSlntXGZDFX+ianwtbPkWS6sV9vLkZLL+FHegMRL04?=
 =?iso-8859-1?Q?RTSYdYi9/AfQJWwiG07Mt3VgsZTaEg2vFwPtDfRVEVzElFogWHk2gwSrM8?=
 =?iso-8859-1?Q?SsbXiRMv1XxOIkcJKgkDGSGgvzgPWXgHKAWGjo8YLncYmrAybOwjRWSwiD?=
 =?iso-8859-1?Q?yccegBOCPS8PWKuGTm3qH2Lp1cfQnoElKOiool7uM0BgOXU7T56CMeMQ6I?=
 =?iso-8859-1?Q?pM/zU3yaI1eGoeq3Gr6Db9spN++2cEmPeDJn2iBZk0Wx4Xp/oc7zj/Ps8z?=
 =?iso-8859-1?Q?L4Klbu38YfozqrHUgxP4AcqOvJ3CZfQPEbyUz0KyEdu3jVaFLLRsklu3Q5?=
 =?iso-8859-1?Q?qbWxg5V6N+zA5jtIewhcCPa3LedFvIqAzzoxI/i+tbOMJuL8EXpcdmhvfI?=
 =?iso-8859-1?Q?hEVoJg5fbMUMYrGGDE6g6twkWvIarSMPMq1C2nm6jN1bpWBVOok1YTvkAg?=
 =?iso-8859-1?Q?1Prr95o/ls4oV6OxSDKIZrV9X4i9FwZad7HGquGkMCby/CFdTUmQNMLyJ0?=
 =?iso-8859-1?Q?yCLpuLnkpbylpz6cVd68/lpYm0RuMc64/Ti5qubaCzUqgMqM7sMOvC8CUq?=
 =?iso-8859-1?Q?Z+a4jU/HYbLBVJnZoyMUJPmBM7RzfE/uutNq6fgs8GMxb5uubBmcsIja7S?=
 =?iso-8859-1?Q?YuoYGLomy4dbGU9fwQkRkh8c0LyJpxHjZ3XpgxyjczVLBMtoPLVn4rr9Xk?=
 =?iso-8859-1?Q?C8RJMWTH/bNVGi8Nfe7XS1gXOJbMP83CucQxTy3upR8wQq3rDGznbkua5D?=
 =?iso-8859-1?Q?lxKe5VC/ab0bojUbZf6yx/+/yrRqMnW0mzeBpso7qIIp6hDiT1LHPDeqwQ?=
 =?iso-8859-1?Q?V8gnr/leWPmaAa9PF+AW6gxG+nRfsgupZv47ytJWEebK0RtKsqnOkvzQgJ?=
 =?iso-8859-1?Q?Tf1PFNGRLcItt9m9n8nRLX4vyUUDKXb5x9B3CVnL6bzGBntZjePCa+WWh5?=
 =?iso-8859-1?Q?+TYY2UzTeKQS0HYIwwULG0QNd4jGfsVv3zha+CTqKXfRA5ndJWApw/y+Id?=
 =?iso-8859-1?Q?88xeEpnlGDRLXub+RIE0esDbXD1oH+VcCuKHuIRI957HbpVePdlndzx4DF?=
 =?iso-8859-1?Q?B1wyxcXCCFjWkUATT94nSYYJsS2sZhoG/uuNNrWQm6flzIRu2jop6SD7WC?=
 =?iso-8859-1?Q?tQ71fLi3SC/zII1kCKkC0bgIJHSCIdICsi9ZbbPtZ2yQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR09MB6518.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?rZXRJJIX8RR4nkt5poZET5pLO/uFAnD7hxfCTBkTP7GPAdkCELtlPQL5A+?=
 =?iso-8859-1?Q?L6SWTPD8oCraDx0d1Gd07EnFJfW6t6XJmxwybzWzqyGRudQCuYi15z9WdR?=
 =?iso-8859-1?Q?RkEwlJyTwO3SRojNfMyOFWU3jqFDacP4FvsERfe6FquFdATOdmD9/mgsXR?=
 =?iso-8859-1?Q?ya+xvWks4TC9WlDwCf7n/AU4Qt9lu1VMTtQdWHv5xNm4ALPud0kOOUWNQA?=
 =?iso-8859-1?Q?sDqdRg0cDH/SK+e0zmrDaMCMK9zjUft+QtGIz3cHJ+iyyIJFAT2A+UHv7X?=
 =?iso-8859-1?Q?imy/aZz8E9oyjfQ4s8G5xc3kQSpxZvLcArAc4SwzLeJBBrjsT/xuPkCfsP?=
 =?iso-8859-1?Q?bW1CHsotg7A6bCqdiPZxxAdwZ5SKbtQE2deq7aqt9H9sUXawd3Ewu0S0Tb?=
 =?iso-8859-1?Q?Plstt+y7jMaGyX/T5HmUeXzt1Wtix5DgcRsPzL2TT7zF3w2sV1wG4UHyRL?=
 =?iso-8859-1?Q?uWilt1ri9ByUHQVioBNfPLKrtkHeaX27lI8FDdo0kRkKggYs+yNjjerCDk?=
 =?iso-8859-1?Q?P9WmiU4xjaQ0kMFYuvC1UYpmYI505L2ascuyy8/fPQulMe8aRfhLEigiUZ?=
 =?iso-8859-1?Q?fbO0rvTLOTPGyv4Bu7PU3Nf09LTf4Xla4klyuzu8r5gWzTEKTC3pPGZC7A?=
 =?iso-8859-1?Q?apeSxWn45ZrR3TMrs15cjosbzhZnzxUnrvVQRSu5DJcSJTnYOtntdcfkj4?=
 =?iso-8859-1?Q?i59l7urbFWSoaVUiw16FVYviJQ8/WQnUZO0MW/u3GCUrCo3YjGWzRz6D/8?=
 =?iso-8859-1?Q?F8T+lrvEk6sEmoXNCgmpfZDH+ySEpd+uiodBSOAZ7tPBpJ5I1TbT70hQEV?=
 =?iso-8859-1?Q?0Dl8Uhf3FUI2ZoyL2c5yc5oDbK3p9iwqpfBmhs1OFYBXvAj21UFNFi/3Jo?=
 =?iso-8859-1?Q?INQBTRSCSZgWnvYy8eZaEYLPxN0JSuhOes1Ceurvi1NEdgGYRMzx2V+moQ?=
 =?iso-8859-1?Q?CYqR+wuuPC6y33AT4L+VckuZQBNenV8BaGMEdIXb+fhoyotrfPP6XiWuPV?=
 =?iso-8859-1?Q?ihkJJ7mx7cI5/+lAovbbDn7NY4pkkYEQ9UziuVeCttcEsz1FHpxD7NxoC2?=
 =?iso-8859-1?Q?WbgPRw+4I335Ak6juGK2dRXdxrxTitRanAnYiCeQWnwI0DSfFe9SUXi8W2?=
 =?iso-8859-1?Q?jHXeOubqxs/IC5fZUVxB0VNgnsJJ8p1IPdkOUxY0tUkl1he0np2toz7HNt?=
 =?iso-8859-1?Q?fMH9CYfchHndFZXgiyYeM97Tx2PkKcXzgeDHonorlDQ+O9qZuFM0XOy0Er?=
 =?iso-8859-1?Q?u/t1B8GKklVctxbNX0w7m0+xocVIa84pU2Hm/dgQHbA3LP92UlOHJuVrFJ?=
 =?iso-8859-1?Q?jPxYsRD+vRqcpj9H99cds9LN+CErexVZOR0jmaz/dLfQQPd2vqbg3wKXp7?=
 =?iso-8859-1?Q?Nfdx+VwYzwU5sYkU/Gj/8thU0+1OqHl+Zpd3oLokchpZBhGrZwbArTUL9P?=
 =?iso-8859-1?Q?p9ck2IrvRRjuPt5Px+SOYg/jyygi9s4FQnw8o1Efzx9kB82cQ7mrs6YSyZ?=
 =?iso-8859-1?Q?9riDkKnGo4aiqHgTuEvFMDX8S10ReIGzwP8kBiTpwZlfaklVMIMUzmDmVh?=
 =?iso-8859-1?Q?AhsP33VxYsg2jap/jR9IlHZZAE9plDsTkSeCGhGJY1I8nRnxvu9kdYYtyH?=
 =?iso-8859-1?Q?ERMoMxA2bCkn/832gDplt0WmqbAsgDY8QCcyNWpHxEo7h/14dnheCZyxjj?=
 =?iso-8859-1?Q?J9mlUu+OMrmsEhFnGOQ=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS4PR09MB6518.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 813f240d-e9f9-41e1-ec0e-08dde9425eca
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Sep 2025 10:29:01.6698 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QoFT/8QJEln5PdHUdBhbCO6nxnDOoOQG8AEDGHzwHfcjb9xZdEe70W3gST4p3T0m+P/clKL0SPRsvVJ5w+S7V4xr8bm21iHb+sP/lGK+f/I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR09MB5992
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
 target/riscv/cpu.c | 13 +++++++++++++
 target/riscv/cpu.h |  4 ++++
 2 files changed, 17 insertions(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index d055ddf462..5f610a894f 100644
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

