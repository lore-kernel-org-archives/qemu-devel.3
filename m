Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A52A4CCD18E
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Oct 2025 12:02:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v909W-0007U6-8i; Wed, 15 Oct 2025 07:58:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1v909U-0007TC-Ai; Wed, 15 Oct 2025 07:58:44 -0400
Received: from mail-westeuropeazlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c201::3] helo=AS8PR04CU009.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1v909L-0007oZ-Fp; Wed, 15 Oct 2025 07:58:43 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LSKbchC3W0jn3cw+aSw3Tq44vBO1HBlk0swMM0tKStpiWGJeJPlyVlgpwSh9AQb4BnyLe7yimDjTO4vh9cVaDlKd9x+Ur2oLh3I3pUbz0SxpB4sSkkMd7MOK9fq1cxfQA/8wRnglxd/3/PCUiDxc6cnxR5O3I/cZ92olkpQC3zV6i+4C2A0cgOfKvx3mNVOet+ZFkR2q60QN3K2k9bHeO2qCMb0NOi3Mvvx4ZX1HhjCGNHWDPAEMj++7xSX3HV/EL/IHlgIpmrwmOhffPu4j71ZhTLe1ihDyqosp/GZ0cN8qTpYlAHnOkf0ruq53Kq57jzAK+Qr8jEPkufwhPDWixw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q/TwECIyTxKnGlLSNCUXAIqcqKwuX3S1AablrYXs1eE=;
 b=YffhjUwXWcpR9NUYpnjgLcx17JcH0Myd2K+uN/2rYAQLpwcTneG2Hk/0cwJidkf8tCsXXR2Kc/lRGoauCisCdj2IQwfT8skTiL6SN5uj6EkhtKvxwn6ca7LBOf7wH+bLZYJ1+JdF2FUAwK21bQ/wRwxW7CTnQMEybFD2Bta623Jb5ZC8sZl3vSfcFfjgd9cw0jJFq+vq58s0JKRLbdBImZ3LUF/7VkjaXMOyET1G8zY0dbj13MIgr7p+aMva8VILXMIBgd8RTyv95QV3zDCPmvbpgxo3VezsCiUK1Uavm9eOX4MPosWtTHSNlkmM8pZ2GVsEP6hqye2xk/d8mxhwBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q/TwECIyTxKnGlLSNCUXAIqcqKwuX3S1AablrYXs1eE=;
 b=OBT7IvufzFBEsS4uSbrL/RGUJGuP4qMA03LOoW0XWVf6ec3oZNyZxgzh+/gjb+HkWonWB9eZf94AIa+rmsB9mz7jiyRFyM1n1+mnpz0pWnnK00Q6iLxo9FTPgBQFsZf5PgW0FS8IR5YJl+lcCnZw8IC0k8Fp9yPpEWbl5XwgagNdRwVyCgheGS3NDJdkR66GTCzW9OoFpQHmnbJVDJD4tdSe45lkEjcr+Xyp70sPGbU6zALKSe4jHBb22LkZyv/+ilS9vXfpbNxxaA5huXidEaNbVgOB5woxIAEhwXhEh/mNjOxCUl8JSxxNVDeydksIuqm8Ke9HjWAH7JEq0fcMOA==
Received: from AS4PR09MB6518.eurprd09.prod.outlook.com (2603:10a6:20b:4fb::5)
 by AS1PR09MB5739.eurprd09.prod.outlook.com (2603:10a6:20b:477::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.13; Wed, 15 Oct
 2025 11:58:16 +0000
Received: from AS4PR09MB6518.eurprd09.prod.outlook.com
 ([fe80::ad50:891a:847c:580a]) by AS4PR09MB6518.eurprd09.prod.outlook.com
 ([fe80::ad50:891a:847c:580a%4]) with mapi id 15.20.9203.009; Wed, 15 Oct 2025
 11:58:15 +0000
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
Subject: [PATCH v11 01/13] hw/intc: Allow gaps in hartids for aclint and aplic
Thread-Topic: [PATCH v11 01/13] hw/intc: Allow gaps in hartids for aclint and
 aplic
Thread-Index: AQHcPcr8fxdgRpuUU0e16YtNm7saCQ==
Date: Wed, 15 Oct 2025 11:58:15 +0000
Message-ID: <20251015115743.487361-2-djordje.todorovic@htecgroup.com>
References: <20251015115743.487361-1-djordje.todorovic@htecgroup.com>
In-Reply-To: <20251015115743.487361-1-djordje.todorovic@htecgroup.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS4PR09MB6518:EE_|AS1PR09MB5739:EE_
x-ms-office365-filtering-correlation-id: 0cdc492d-6abf-4a44-2194-08de0be21fe7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|7416014|376014|1800799024|366016|38070700021; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?jqAaRhK4X6LqcLu330HFPRRDJc6YUvhJXu4xv8RTyQtkPFjqVJQBMzuIPL?=
 =?iso-8859-1?Q?lkJg4LxwqndtiF7F1DLKAk821eVEjs4CFSvGPxejUYUKpCTJWbgUGz337g?=
 =?iso-8859-1?Q?uyxg7KnfAnYgHAFHhxEuVi6oetoAtxtX8vHcYyUWbXcqUAqi7tqHYdcsIk?=
 =?iso-8859-1?Q?7G3SG15MLklwJr09Q1XOEYY1NsFITMCI/f6yiaKTibO81RFr3pDUpANAov?=
 =?iso-8859-1?Q?kB2FdVEkHMZg9c6U+cHe5wN6vc/xHnY66+bnLqU5Eg6tbDIQnRxaKma4dW?=
 =?iso-8859-1?Q?vyLX0PaGfhWQIb4ZK45QWMj13kQsdfcnEc/1EkdUs2VptQaHubtcIhMZM2?=
 =?iso-8859-1?Q?CPv3HjB5QE4yQlkXQH4/YTXAT75lIwQZ1LphDjNq9/uMHWaSNtvoy0pxPM?=
 =?iso-8859-1?Q?5i+DKtdds8J9TARxmRaZTZY3xgMIrPTkNMx87Hpu4JxlIReFsCqt1upuBB?=
 =?iso-8859-1?Q?oVPnEON0CJebMcrA/EI0SBXF3vj6Pmn3W98X+Cu1qrA4ChX5zuAe+bWGqP?=
 =?iso-8859-1?Q?iNiizJ1P90nWPvNbYDU6N3Sic8kzTgsyDtwgO76GQiP8u7zvNG+9y9o0To?=
 =?iso-8859-1?Q?4PA8IjrvKP293lwCDYd83FYoEskfopRhY0ss4OkfW4QznNAF5JrwC6GsFs?=
 =?iso-8859-1?Q?cvnnpHdQ2GmGlCT2PkZ0ZhiVX7UL4gj/4HEBtPb1AgcYYBVdDdkzNH89LX?=
 =?iso-8859-1?Q?argfUM4VPtTcA+Qug3BiDy0yPV61xHKL4huo9/f2ATrd4ej1LeX9ou0gPM?=
 =?iso-8859-1?Q?2uEIMlmG4DLZ3WNRbpVU5HFpzInU4NiiupNsg4mF3jQXA8cd7oIu2dDBci?=
 =?iso-8859-1?Q?Tl4T6hgemRFv3D2Gud9fY4nOCsIQPOtDBBuEkL7vZYrW5wBEeV35lKuocN?=
 =?iso-8859-1?Q?wUmprC2/l5GYYze3V5ulGJg2EOiT9tjSS8uqe6WgJyyRclC+YRHIumDqy4?=
 =?iso-8859-1?Q?5Bw8XS1qYDr+kCVBjz8QFnk5w/zYopIqWjndJYxXuRMPEWfeyB+uo5G0GJ?=
 =?iso-8859-1?Q?d0sfPRVnr4+LlP/DHFG7zW+O8izanKmp5IdpM0oZygZPDFNaTJUyERkx+B?=
 =?iso-8859-1?Q?IL1ANm1qqwT/A+ukedv6q08Z2FgIf/o0c5HAY0KUKb3Jy7tbhUeMBUQBb+?=
 =?iso-8859-1?Q?5Fzzoc64W04TBO4ZC9xzU/YonI/hr0eoTebS41hRUTj9C0fP7aIE+6QcJu?=
 =?iso-8859-1?Q?v4ru5yUuUw1V8nVAkf8qwCO72gIA5QzOj1HRr24cLU2WpDvPHjTmQEvcGM?=
 =?iso-8859-1?Q?lNzB5ivrngLM0LpZQeVsBthc21GhK4/NOyDfKIVPMe5yOV+Z9DSPpn560I?=
 =?iso-8859-1?Q?Ko8vju6Q7+Adv2ZozntAW+Z+OlY1KaswfYXf6KtACUMYA2ryHqmNg06/dT?=
 =?iso-8859-1?Q?2k2Y+zJhVwvtnY1S5OnerxdvdzGcdPnP8aGXoN48I2k8G9UtvtaAvLi9Rr?=
 =?iso-8859-1?Q?9ToRakA0b3Y3qxtt9cRuDQ4Sfw4ywVZ92devpIcGaEOfwGwxfeq29Di6DU?=
 =?iso-8859-1?Q?5mxuXLjM77Si1Pa8PDrUW3hHtlucfqHW59Tn1xzLmkxbLSVu7QiBoH6pBq?=
 =?iso-8859-1?Q?HdKrvqi9Fy18fPcUmwBeAS4v/Oev?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR09MB6518.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700021); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?95VixQQnLZXRN/iqUEXqITqpeWLsTeh8siEF2tsftRFv4+vVeJcQggVs5D?=
 =?iso-8859-1?Q?SYhl77SdKKOj468wBVnfO4DylwkI5gj5bysSejnjdYz4Wok8aRSKaAFhKw?=
 =?iso-8859-1?Q?bHXDgBw5vnEZr126Ac5hy37Z2XGCYG7TvY8+bKu6+gusTZO+AAuJIyVyPU?=
 =?iso-8859-1?Q?oDMTaCgaKhvbuODB/NxMfCW/sQ+VNwikUIPROCkOXg7WN91Wa/zFYqpKV1?=
 =?iso-8859-1?Q?fangIEAGQbkpZLd2MCgHV/iGDsErgAn5Db9Nk634WwluctNl6DPcJoBsTw?=
 =?iso-8859-1?Q?W1NbIli//6UewqsL0LTn1bFoMOijpecK//FBnd+tF58VodyIrPpKyTiFuB?=
 =?iso-8859-1?Q?q5S0Z3zrkRHYwvoXoikFTGPPO0xnwksXsl3yUInYa/226NhYBXjfwvb5vz?=
 =?iso-8859-1?Q?aaHN0gUwjs54SNV9hxWwXLP3hSDFvWrx4Q91me7/u4GbJuCxckByXKUgti?=
 =?iso-8859-1?Q?L5Zk8Yf0Z3MRINlTKpkVD3Vhp2A3WeiBcgyN3rder5OONzWvwsJbhZZNGE?=
 =?iso-8859-1?Q?7kw3PA4FvpU1622LfKhcnL9tbaAAA1sOk5CBW3FqAyAGWryITycluAgiwE?=
 =?iso-8859-1?Q?jtWSnQmBdY8RioEvXuLZMpXtWZ2D/KRPb6l9/eYcBGcUPg8oILkLbYaURk?=
 =?iso-8859-1?Q?LIfCA5pE4lRBz/uHlrwuKQEq2DnKh3PDKze/vOjsQkvZ4XxZavSb+1l1gT?=
 =?iso-8859-1?Q?tlnTr7G2w2ajCzIGgPI0Wtq5PDb4W1lYi0sMSAdWnQToRsL0v9DjR2nL0M?=
 =?iso-8859-1?Q?8fJf0+DLhQQZzSeRlivDa0R6VfG9Krv6182EA3Rb2N66DBNBXyBy25Wno/?=
 =?iso-8859-1?Q?bh2yeCeNJC3BSwUTkDSp4WNGKeavS+JxsMypHYIFsrbmtnbl2CW/OgGWB7?=
 =?iso-8859-1?Q?vjqOOVA3FfpxYsVXZcr2AC4QnC1om2kc60Q2AfUouvClExdV6j1f/d1vaS?=
 =?iso-8859-1?Q?eM2L02aokvmlhj53NWxoAc4N1IMpiIqSH9KHHengo4goksxGBFXBynJg75?=
 =?iso-8859-1?Q?xHmEJ8TBMR5I35YQNt10MzQHx9aetfBeB981H6cHClFOQr7f/QEcgm0i5n?=
 =?iso-8859-1?Q?nflcAXEfRGYNsXvH2SHpwN9qvUkg/OBRNE1rkYcG+3vIvfUrgmYMrmApdp?=
 =?iso-8859-1?Q?c84nNpZnR6BtVdX2tfNuPVQxPixO0qHDlQzsw7Cq3p4EoQx9+F8VBhKeBt?=
 =?iso-8859-1?Q?Gb0jNNtMxL5ejauq0Kawqo5MBkJnSUmDx35U2/lI2GK4vFbEq9SzPp0vu4?=
 =?iso-8859-1?Q?D+5XI/q0BmQU/ddfe3BFZFvNs4UlTufySq5hVN0BNNECK60UtkBLiwln9U?=
 =?iso-8859-1?Q?ukhPK805Awv2d06z5yObTy3Jy0aS2utzF6hw/Dfc+M3qvbRy/6caBFQL6Y?=
 =?iso-8859-1?Q?VGDFC/D9jU70QZWayW0p4WpkxryFC9I8R3lKWOWx9o6nV1eE4N/XGndYEt?=
 =?iso-8859-1?Q?q/XtpqLCU1PJRlbgmNrBiLjR11UZxyC/ok+i6XUUuVOe3XVFvjvtI2Pqcd?=
 =?iso-8859-1?Q?k6i4q9EgZmbX/VFiEWXNcm8lD3++v7q73ANPiofLEAbzL7szpiNj24gFgo?=
 =?iso-8859-1?Q?Z9PhdpaJrNHLo7EWDlZy4QlTXiM8JtvizVB+RP6TiZaZQYWbJRTPdqpEtG?=
 =?iso-8859-1?Q?h2NMUWlnXIXrWmV0YrVmX2mPdbaB+7mBpUDJa+WkL4/ec/OLHZSwTzB309?=
 =?iso-8859-1?Q?7UOwsFmI3Em0rrX1X6I=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS4PR09MB6518.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0cdc492d-6abf-4a44-2194-08de0be21fe7
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Oct 2025 11:58:15.0467 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MFGsF6Ajvi8kkG7v7HXB+mZub3dm3q+g2ZKrA4fxzefMg11Ela3OuawSH6oOqUyASsldl0nWEpO8++dea9v5C4UVa7XovSVI5EaKi0yjVlY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR09MB5739
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

This is needed for riscv based CPUs by MIPS since those may have
sparse hart-ID layouts. ACLINT and APLIC still assume a dense
range, and if a hart is missing, this causes NULL derefs.

Signed-off-by: Chao-ying Fu <cfu@mips.com>
Signed-off-by: Djordje Todorovic <djordje.todorovic@htecgroup.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/intc/riscv_aclint.c | 18 ++++++++++++++++--
 hw/intc/riscv_aplic.c  | 13 ++++++++++---
 2 files changed, 26 insertions(+), 5 deletions(-)

diff --git a/hw/intc/riscv_aclint.c b/hw/intc/riscv_aclint.c
index 4623cfa029..e3e019e605 100644
--- a/hw/intc/riscv_aclint.c
+++ b/hw/intc/riscv_aclint.c
@@ -297,7 +297,12 @@ static void riscv_aclint_mtimer_realize(DeviceState *d=
ev, Error **errp)
     s->timecmp =3D g_new0(uint64_t, s->num_harts);
     /* Claim timer interrupt bits */
     for (i =3D 0; i < s->num_harts; i++) {
-        RISCVCPU *cpu =3D RISCV_CPU(cpu_by_arch_id(s->hartid_base + i));
+        CPUState *cpu_by_hartid =3D cpu_by_arch_id(s->hartid_base + i);
+        if (cpu_by_hartid =3D=3D NULL) {
+            /* Valid for sparse hart layouts - skip this hart ID */
+            continue;
+        }
+        RISCVCPU *cpu =3D RISCV_CPU(cpu_by_hartid);
         if (riscv_cpu_claim_interrupts(cpu, MIP_MTIP) < 0) {
             error_report("MTIP already claimed");
             exit(1);
@@ -486,7 +491,12 @@ static void riscv_aclint_swi_realize(DeviceState *dev,=
 Error **errp)
=20
     /* Claim software interrupt bits */
     for (i =3D 0; i < swi->num_harts; i++) {
-        RISCVCPU *cpu =3D RISCV_CPU(qemu_get_cpu(swi->hartid_base + i));
+        CPUState *cpu_by_hartid =3D cpu_by_arch_id(swi->hartid_base + i);
+        if (cpu_by_hartid =3D=3D NULL) {
+            /* Valid for sparse hart layouts - skip this hart ID */
+            continue;
+        }
+        RISCVCPU *cpu =3D RISCV_CPU(cpu_by_hartid);
         /* We don't claim mip.SSIP because it is writable by software */
         if (riscv_cpu_claim_interrupts(cpu, swi->sswi ? 0 : MIP_MSIP) < 0)=
 {
             error_report("MSIP already claimed");
@@ -550,6 +560,10 @@ DeviceState *riscv_aclint_swi_create(hwaddr addr, uint=
32_t hartid_base,
=20
     for (i =3D 0; i < num_harts; i++) {
         CPUState *cpu =3D cpu_by_arch_id(hartid_base + i);
+        if (cpu =3D=3D NULL) {
+            /* Valid for sparse hart layouts - skip this hart ID */
+            continue;
+        }
         RISCVCPU *rvcpu =3D RISCV_CPU(cpu);
=20
         qdev_connect_gpio_out(dev, i,
diff --git a/hw/intc/riscv_aplic.c b/hw/intc/riscv_aplic.c
index a1d9fa5085..77cec8ece9 100644
--- a/hw/intc/riscv_aplic.c
+++ b/hw/intc/riscv_aplic.c
@@ -903,9 +903,12 @@ static void riscv_aplic_realize(DeviceState *dev, Erro=
r **errp)
         if (!aplic->msimode) {
             /* Claim the CPU interrupt to be triggered by this APLIC */
             for (i =3D 0; i < aplic->num_harts; i++) {
-                RISCVCPU *cpu;
-
-                cpu =3D RISCV_CPU(cpu_by_arch_id(aplic->hartid_base + i));
+                CPUState *temp =3D cpu_by_arch_id(aplic->hartid_base + i);
+                if (temp =3D=3D NULL) {
+                    /* Valid for sparse hart layouts - skip this hart ID *=
/
+                    continue;
+                }
+                RISCVCPU *cpu =3D RISCV_CPU(temp);
                 if (riscv_cpu_claim_interrupts(cpu,
                     (aplic->mmode) ? MIP_MEIP : MIP_SEIP) < 0) {
                     error_report("%s already claimed",
@@ -1088,6 +1091,10 @@ DeviceState *riscv_aplic_create(hwaddr addr, hwaddr =
size,
         if (!msimode) {
             for (i =3D 0; i < num_harts; i++) {
                 CPUState *cpu =3D cpu_by_arch_id(hartid_base + i);
+                if (cpu =3D=3D NULL) {
+                    /* Valid for sparse hart layouts - skip this hart ID *=
/
+                    continue;
+                }
=20
                 qdev_connect_gpio_out_named(dev, NULL, i,
                                             qdev_get_gpio_in(DEVICE(cpu),
--=20
2.34.1

