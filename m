Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC820C71157
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Jun 2025 12:29:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uRrth-0006DO-Hn; Wed, 18 Jun 2025 08:28:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1uRrte-0006C3-5j; Wed, 18 Jun 2025 08:28:06 -0400
Received: from mail-northeuropeazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c200::1] helo=DB3PR0202CU003.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1uRrtc-0005VZ-1A; Wed, 18 Jun 2025 08:28:05 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vzyMApP3YRx0FT9qmpRzsvem1LsiYOJjYp+Zsg5QBj86iF/zJsaiBe9WLGULe672ZMR/LlpLh7EZTk/iZPtWE3jKZH667SXtlGJWk0QGrR/QrQ328qCVwGlhqcOG6tNDts0oA/ZHM9gpBiKhNpi4Z4dL9dJDT1o42h5nZljLKQ0BexyjOEynQMqhnkfFfjKdsRaLuMmxJZFZo8oPX9LU4C5QaxGf2h45MnRG9iQwRjqVu2IVBoo6V3Ear73CbO5xChCjc6khzK7t31gULzST37cfZGK8Q9cgi3miBwY8k0ucWjF3OkDBaBWV+Bhd5VKhHKEYKXAfIeFKAXnzX+D7+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bY8ZbSjJ+nRW4YA8seYSW5ZJi6NsujOXlFA+2p4Vek0=;
 b=ptbEzcH8ndnw8vJur9gbCXlic+q18RvaJjQUhXtwhh2RCCt5+HAosY/zyNS9i4RLgJz9na8iGW/wWxg0uVkkwxOwXXSpxAP7hdJyU0HnR3bga6VgKTJ12wsmNi5cQsyCzNNjphaBch8PGYhnPzN1dc5EDFpDGl4qC01FBHU9oClPwMlpgpPkDcrrN/ImpL1sbR3qLRfGPoe9OlnKiAr5xfcH4/3yPxf1CxYXytUftkY6XrxDobihcCND/CvFlE8DgEoENK5U875Vx8++gZ6oTV6jUmFoRmHzCkcAEYYbK1qliwk4GEpOaKTRISO4QecfmQXTy29aBRUfFAlbO52rDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bY8ZbSjJ+nRW4YA8seYSW5ZJi6NsujOXlFA+2p4Vek0=;
 b=I3mkX03u2zC30NBlabyFX+kpfmiDGS5tpQlyG0Hc5BuUyNcyiztsosyXI0Hclx8uTGNrmsFOH31Pi7XO9ZBEJIWtAQ/J2ZeQSa8S2kE59oNwYbtMQvVIFwlAS1OSnn9Vmh5J08lavSo3w7OR0C5oLDGq/kImhBOyWH4FksUuluql9ov65RdBM33dcd7t9I99A1SgHhnvxJ5ICBSAzJsE44Y0S8CELwG6mGOnM9gQKgQyAQQ8JU6gUKtICXGynQVoVY++AldUbtqdYFxkin3FWYqwF5cxkDUYqHm9xBoThCI7hC/Pef+0Se6rB28ulXpcJjjwjZqa6IRyCRLxc7TKPw==
Received: from AS4PR09MB6518.eurprd09.prod.outlook.com (2603:10a6:20b:4fb::5)
 by AS1PR09MB6509.eurprd09.prod.outlook.com (2603:10a6:20b:482::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.26; Wed, 18 Jun
 2025 12:27:49 +0000
Received: from AS4PR09MB6518.eurprd09.prod.outlook.com
 ([fe80::ad50:891a:847c:580a]) by AS4PR09MB6518.eurprd09.prod.outlook.com
 ([fe80::ad50:891a:847c:580a%3]) with mapi id 15.20.8857.016; Wed, 18 Jun 2025
 12:27:49 +0000
From: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "cfu@mips.com"
 <cfu@mips.com>, Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
Subject: [PATCH v3 07/10] target/riscv: Add Xmipslsp instructions
Thread-Topic: [PATCH v3 07/10] target/riscv: Add Xmipslsp instructions
Thread-Index: AQHb4ExnqNrFQphuzk6xviGxb0H+Kg==
Date: Wed, 18 Jun 2025 12:27:48 +0000
Message-ID: <20250618122715.1929966-8-djordje.todorovic@htecgroup.com>
References: <20250618122715.1929966-1-djordje.todorovic@htecgroup.com>
In-Reply-To: <20250618122715.1929966-1-djordje.todorovic@htecgroup.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS4PR09MB6518:EE_|AS1PR09MB6509:EE_
x-ms-office365-filtering-correlation-id: 16617a08-a656-4c88-ae75-08ddae6389cf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?Bpw1weklSVMxp6hotk8Et3zzwdc7LqOVr0FUdpPnC5SooZCTwFfVABaIbf?=
 =?iso-8859-1?Q?846CC4WFWhooelGg42to6epscts4d57e0lTkltbyd0IO/FGHwPrk5d3CZa?=
 =?iso-8859-1?Q?Sm+p5C4uAa4UjAQJVczHNmBTwlxg7eXwtiwQYXJuw1iZ4lLpKwfp1gHFb6?=
 =?iso-8859-1?Q?HQsoHLYJ90sz42Z8O1bVARNbgcuWEsl1JtJz4yBbJ/4eiPUOdsoIZybCej?=
 =?iso-8859-1?Q?u/V+TRWRCXjmQpyWfafCitaY+829+ZTX8xPtybrcKtjh4YEwiuLoQepUxB?=
 =?iso-8859-1?Q?YZCYgSXp7siZADw4v48OGdfhSec1jYIGB+A+kvCZAbNkbocgtxumZexJUx?=
 =?iso-8859-1?Q?/iD4Dv7JSXZhlpp24eFRH7QztIkiGdQHywi6bewpTNk3eUwiUFEbNZSA6x?=
 =?iso-8859-1?Q?JmIyuIXdUORxmtv9wrpVkaVkTOK8kGgj1W48eJb8uq9SJWM+YVwnVzAEyo?=
 =?iso-8859-1?Q?lLPOGqDlOSlyjy40D1+N2muLkbnn3u6w9BwntX7VBaOOBS5E0F4M7pyTqb?=
 =?iso-8859-1?Q?Lweri8cQkpvGpOLODf3fi2sVT7FSMVKkz50BmkDdeT+EAmOxrrnXrG03kH?=
 =?iso-8859-1?Q?PyU/9w8q3DqaciAjV43d0kK5p4qnDqZe/wBZW1cTbojlHXTmPwzYPcIGbA?=
 =?iso-8859-1?Q?xhgqr8zzCsoVcV9xndjQt7cHFHDNM4rMbijqBEYqIAG7ERKd+8uwfvsd91?=
 =?iso-8859-1?Q?6xZfPgMRNje+ltgmky9lC9Nxhcl8oIZijEdAykj/2vSbHFikdbDyTV/eKd?=
 =?iso-8859-1?Q?/+H4b1dNsps8TZWkhJSD7cZ/9jm46P9cuKaUObjwy7Kgxs4rt9KCcmMFLD?=
 =?iso-8859-1?Q?XkuXGvnvZo2lEbcBQcFeMbE+8UaM1y1FkdmaE9VURtv/rRpytxrZs8kQUJ?=
 =?iso-8859-1?Q?hmsQ+wnB5jpvnmFGqT8FTG4IPSwctdiZ88/WROBx1L4xnMse/HuMaciH8b?=
 =?iso-8859-1?Q?+c9EO0mfSQ1CwUbh7zd0SjuxAVPbEAaZ1emf2DJBKHGAYv5E5RtOWN4LPS?=
 =?iso-8859-1?Q?u5w6QXi9GzSZxuqCOEgBsqtKsv3VTuvv7p7EDL70T6AIzDMI4u7PYz1Qlx?=
 =?iso-8859-1?Q?toJa1QuSvZ7HN9sxZwF3CqT7esDxUvP24pOzjN/1K0nhSWrEL4BJ89WgqZ?=
 =?iso-8859-1?Q?JRW5XIb8CthSN4B2uRto8W6ibtrSsfDMNvMn7tCjz1YfVD7F1ESFDcDFvh?=
 =?iso-8859-1?Q?wCp18syEbxJFS3UYDe0Arr5OY4V0hyzMB1g1tWzNeMrr66u8P4wyDRACBg?=
 =?iso-8859-1?Q?ODTdWXC1WxPOfr1MEEjN/8ykDfHSNH7llXdRuYe5uwY/Qr6zolzuRqbJqj?=
 =?iso-8859-1?Q?KitsvkuHPe9qE7u62FEGyDBfxOvuOpazEFZee5avgGCoxyUfyhDn0umWpC?=
 =?iso-8859-1?Q?naL1dK52GmQ1Ffui7hj9h+NP8YU8IaBfPrnKioS7sapcVntc9siaESmq7u?=
 =?iso-8859-1?Q?tCnLHPx0VQKUsBlYObLGLW1+cQmfpF7tbWqaClSShfDY6Yrb6o4fd9f1M9?=
 =?iso-8859-1?Q?XpS+As4fQ6dfeDxCMoFk5TD+JTmpdewNhiL87BvZfpPGYbXzGT2KWiF/Ae?=
 =?iso-8859-1?Q?oWHFCgI=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR09MB6518.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?fyQ9lk3mUblxkcGotPyhE0UMrRru+3+nYZkwr/q8WxjbquYyrTTor4NnhT?=
 =?iso-8859-1?Q?drqdQn1q3XT7F1kqiAWn4zCndan1ZP5b19CKKWB+4xbmdGTnkzFNTQUFoe?=
 =?iso-8859-1?Q?m2gJB8g3NB/5L9VKeCZEt+t+Rd0i7maMWbDPTl8AlBIPPB/TQtxa0XJR8W?=
 =?iso-8859-1?Q?bXAU9koLV2NK7cyAoBDvDa7c6MDZeis2Rm5uzvQ0Z4+L+4PuCkYz+GmBEs?=
 =?iso-8859-1?Q?K30Yf3y7JV5MmAGPKCRhOIUrdQ5TsWNa78Lk94DVuScNu7Xq/+nH2fV71A?=
 =?iso-8859-1?Q?THPPSAT02K+8OmHiSGUkfj0g/mBwmOTY3wnfbsiGa5sm5+mCHEquF1I66f?=
 =?iso-8859-1?Q?NTwK+zkPFvQYsLB+vR457c4dMQfm//fgER6pwNTGoo3xkSnfqJU/BNtrS3?=
 =?iso-8859-1?Q?sTb5b5k/4WQJpKstVCVA4861jyO+j+rc9CR6Kge/SsprHvLadhjyAIBzDH?=
 =?iso-8859-1?Q?8zCn8Dc3qthU9agD9Is/mLqdNVCPXa/J0Os71ue6A2aPZuu4PqIxqNrLIh?=
 =?iso-8859-1?Q?XRo7sa8MDaVHplfTgss21Dz2gRaJgigtGjBma/BtOrc5OMbVcLFmBmAHtu?=
 =?iso-8859-1?Q?trmEgjxx63JtTbm9b9vRW7VSubT9/V5ioZcFRGMIaBR9BFJgAhpkbowtiw?=
 =?iso-8859-1?Q?jHXVELzQbHpGJHRhXbohSv1nxmsYf/duisf0ppEmNq0nmLwT3CPFwtqssw?=
 =?iso-8859-1?Q?FuZ7959j+QKT4NI2fWiQebE3koBgblbrlftYAVaz1OBjo50g1bNLqUqrsZ?=
 =?iso-8859-1?Q?jBj3qGib4Jkq29ibvtskUt8YJWjjogi8AsPt1lTz3Q9OB6LyNdbJ9fwtW4?=
 =?iso-8859-1?Q?44DmDTwc2hvXNyYmxJ57Vn8jvYa3guyG+vurkjiKg5Z1LbezJVFpA6tJBt?=
 =?iso-8859-1?Q?4tHa9sA4rRFsKBBPwzv4yrBk526+lr6/XK+FXAvJAIKhwPOpvh9JNuugap?=
 =?iso-8859-1?Q?KbAHxJxwM0A6Al9AdNA9Y8W+V1AKPEcH5eUdqW9JmyS79Z1KdMpwtlzjk5?=
 =?iso-8859-1?Q?D3C017pezCufvMWrS5+GvOZmY/heN+Na0uIol1+tDJ4l4/ZBkNtyytYFgh?=
 =?iso-8859-1?Q?hBGvPhd81SU08ncj0IDYuhmxgjUO+SRnC/apHpUz7/omU/u+ikpHVdIGn7?=
 =?iso-8859-1?Q?B7O4EYeULYRZFDncVasu1hH9lrpjWUX1P9SGnASbZh5cmrRAaxZABEe5BC?=
 =?iso-8859-1?Q?JqhySC8+1sjsLy2KIoyINARg5/eoRD5qPKzmy7dNUd2K+3h9BUoXmtc7KW?=
 =?iso-8859-1?Q?se2/M0rjVFFuraexU3HwqSVa75Uzu4sY8AvNqImU97oVFgDMbeVYUHuRUP?=
 =?iso-8859-1?Q?IS65rZ0FPqidmFRMftbIcT+nnLQhUDo7VOfLC9LK/jnClH43HvA8mbBI8p?=
 =?iso-8859-1?Q?Muz9niDVHSoLqx8lUvzmtVaXSgEuEETAn9yxfgiZqTwtAl8kZ/3qtMtWgS?=
 =?iso-8859-1?Q?AVE0Bvi1tU00uKuCtSYQjet+JQ0PNsA9orq3ykms1G4bOJwJTyzjfexOzs?=
 =?iso-8859-1?Q?nVvWjewyUbWrbZY//6EBlR1G/yhjve+L8W+Cbe3vRfhO5NgqssYTvg6Dza?=
 =?iso-8859-1?Q?qQ83fIr5rGTvdFEqoGNWRxwB5Z9wZ2y8Xdd/Gy3P54/ZRVX2CWcQsZvs5B?=
 =?iso-8859-1?Q?pfcVnXcvu5AxCws9O3zRz8a8H+c+05ggIUv1pfmN3yScSHQvSBpUqPzS6i?=
 =?iso-8859-1?Q?zTieKGObnDkx5yfBd9I=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS4PR09MB6518.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16617a08-a656-4c88-ae75-08ddae6389cf
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jun 2025 12:27:48.9807 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TPC1nt+pPXo2XymIimXReCn8hGFP3PROiF+KSFKzcxfxMjPZ3FAi7noXbTC2hk511hKJDAocFxUX0lPYfcUSEElO9pVyfnPApqH+tmd3PVo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR09MB6509
Received-SPF: pass client-ip=2a01:111:f403:c200::1;
 envelope-from=Djordje.Todorovic@htecgroup.com;
 helo=DB3PR0202CU003.outbound.protection.outlook.com
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

Add MIPS P8700 ldp, lwp, sdp, swp instructions.

Signed-off-by: Chao-ying Fu <cfu@mips.com>
Signed-off-by: Djordje Todorovic <djordje.todorovic@htecgroup.com>
---
 target/riscv/cpu.c                        |  3 +
 target/riscv/cpu_cfg.h                    |  3 +-
 target/riscv/cpu_cfg_fields.h.inc         |  1 +
 target/riscv/insn_trans/trans_xmips.c.inc | 84 +++++++++++++++++++++++
 target/riscv/xmips.decode                 | 23 +++++++
 5 files changed, 112 insertions(+), 2 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index c96bf08edd..ebfb20b2dc 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -244,6 +244,7 @@ const RISCVIsaExtData isa_edata_arr[] =3D {
     ISA_EXT_DATA_ENTRY(xventanacondops, PRIV_VERSION_1_12_0, ext_XVentanaC=
ondOps),
     ISA_EXT_DATA_ENTRY(xmipscbop, PRIV_VERSION_1_12_0, ext_xmipscbop),
     ISA_EXT_DATA_ENTRY(xmipscmov, PRIV_VERSION_1_12_0, ext_xmipscmov),
+    ISA_EXT_DATA_ENTRY(xmipslsp, PRIV_VERSION_1_12_0, ext_xmipslsp),
=20
     { },
 };
@@ -1364,6 +1365,7 @@ const RISCVCPUMultiExtConfig riscv_cpu_vendor_exts[] =
=3D {
     MULTI_EXT_CFG_BOOL("xventanacondops", ext_XVentanaCondOps, false),
     MULTI_EXT_CFG_BOOL("xmipscbop", ext_xmipscbop, false),
     MULTI_EXT_CFG_BOOL("xmipscmov", ext_xmipscmov, false),
+    MULTI_EXT_CFG_BOOL("xmipslsp", ext_xmipslsp, false),
=20
     { },
 };
@@ -3182,6 +3184,7 @@ static const TypeInfo riscv_cpu_type_infos[] =3D {
         .cfg.pmp =3D true,
         .cfg.ext_zba =3D true,
         .cfg.ext_zbb =3D true,
+        .cfg.ext_xmipslsp =3D true,
         .cfg.ext_xmipscbop =3D true,
         .cfg.ext_xmipscmov =3D true,
         .cfg.marchid =3D 0x8000000000000201,
diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h
index 9734963035..cd1cba797c 100644
--- a/target/riscv/cpu_cfg.h
+++ b/target/riscv/cpu_cfg.h
@@ -22,7 +22,6 @@
 #define RISCV_CPU_CFG_H
=20
 struct RISCVCPUConfig {
-
 #define BOOL_FIELD(x) bool x;
 #define TYPED_FIELD(type, x, default) type x;
 #include "cpu_cfg_fields.h.inc"
@@ -39,7 +38,7 @@ static inline bool always_true_p(const RISCVCPUConfig *cf=
g __attribute__((__unus
=20
 static inline bool has_xmips_p(const RISCVCPUConfig *cfg)
 {
-    return cfg->ext_xmipscbop || cfg->ext_xmipscmov;
+    return cfg->ext_xmipscbop || cfg->ext_xmipscmov || cfg->ext_xmipslsp;
 }
=20
 static inline bool has_xthead_p(const RISCVCPUConfig *cfg)
diff --git a/target/riscv/cpu_cfg_fields.h.inc b/target/riscv/cpu_cfg_field=
s.h.inc
index 9ee0a099bb..b5195959b2 100644
--- a/target/riscv/cpu_cfg_fields.h.inc
+++ b/target/riscv/cpu_cfg_fields.h.inc
@@ -147,6 +147,7 @@ BOOL_FIELD(ext_xtheadsync)
 BOOL_FIELD(ext_XVentanaCondOps)
 BOOL_FIELD(ext_xmipscbop)
 BOOL_FIELD(ext_xmipscmov)
+BOOL_FIELD(ext_xmipslsp)
=20
 BOOL_FIELD(mmu)
 BOOL_FIELD(pmp)
diff --git a/target/riscv/insn_trans/trans_xmips.c.inc b/target/riscv/insn_=
trans/trans_xmips.c.inc
index 6555a6062a..d2720a6770 100644
--- a/target/riscv/insn_trans/trans_xmips.c.inc
+++ b/target/riscv/insn_trans/trans_xmips.c.inc
@@ -31,6 +31,12 @@
     }                                            \
 } while (0)
=20
+#define REQUIRE_XMIPSLSP(ctx) do {               \
+    if (!ctx->cfg_ptr->ext_xmipslsp) {           \
+        return false;                            \
+    }                                            \
+} while (0)
+
 static bool trans_ccmov(DisasContext *ctx, arg_ccmov *a)
 {
     REQUIRE_XMIPSCMOV(ctx);
@@ -47,6 +53,84 @@ static bool trans_ccmov(DisasContext *ctx, arg_ccmov *a)
     return true;
 }
=20
+static bool trans_ldp(DisasContext *ctx, arg_ldp *a)
+{
+    REQUIRE_XMIPSLSP(ctx);
+    REQUIRE_64_OR_128BIT(ctx);
+
+    TCGv src =3D get_gpr(ctx, a->rs1, EXT_NONE);
+    TCGv dest0 =3D dest_gpr(ctx, a->rd);
+    TCGv dest1 =3D dest_gpr(ctx, a->rs3);
+    TCGv addr =3D tcg_temp_new();
+
+    tcg_gen_addi_tl(addr, src, a->imm_y);
+    tcg_gen_qemu_ld_tl(dest0, addr, ctx->mem_idx, MO_TESQ);
+    gen_set_gpr(ctx, a->rd, dest0);
+
+    tcg_gen_addi_tl(addr, addr, 8);
+    tcg_gen_qemu_ld_tl(dest1, addr, ctx->mem_idx, MO_TESQ);
+    gen_set_gpr(ctx, a->rs3, dest1);
+
+    return true;
+}
+
+static bool trans_lwp(DisasContext *ctx, arg_lwp *a)
+{
+    REQUIRE_XMIPSLSP(ctx);
+
+    TCGv src =3D get_gpr(ctx, a->rs1, EXT_NONE);
+    TCGv dest0 =3D dest_gpr(ctx, a->rd);
+    TCGv dest1 =3D dest_gpr(ctx, a->rs3);
+    TCGv addr =3D tcg_temp_new();
+
+    tcg_gen_addi_tl(addr, src, a->imm_x);
+    tcg_gen_qemu_ld_tl(dest0, addr, ctx->mem_idx, MO_TESL);
+    gen_set_gpr(ctx, a->rd, dest0);
+
+    tcg_gen_addi_tl(addr, addr, 4);
+    tcg_gen_qemu_ld_tl(dest1, addr, ctx->mem_idx, MO_TESL);
+    gen_set_gpr(ctx, a->rs3, dest1);
+
+    return true;
+}
+
+static bool trans_sdp(DisasContext *ctx, arg_sdp *a)
+{
+    REQUIRE_XMIPSLSP(ctx);
+    REQUIRE_64_OR_128BIT(ctx);
+
+    TCGv src =3D get_gpr(ctx, a->rs1, EXT_NONE);
+    TCGv data0 =3D get_gpr(ctx, a->rs2, EXT_NONE);
+    TCGv data1 =3D get_gpr(ctx, a->rs3, EXT_NONE);
+    TCGv addr =3D tcg_temp_new();
+
+    tcg_gen_addi_tl(addr, src, a->imm_w);
+    tcg_gen_qemu_st_tl(data0, addr, ctx->mem_idx, MO_TEUQ);
+
+    tcg_gen_addi_tl(addr, addr, 8);
+    tcg_gen_qemu_st_tl(data1, addr, ctx->mem_idx, MO_TEUQ);
+
+    return true;
+}
+
+static bool trans_swp(DisasContext *ctx, arg_swp *a)
+{
+    REQUIRE_XMIPSLSP(ctx);
+
+    TCGv src =3D get_gpr(ctx, a->rs1, EXT_NONE);
+    TCGv data0 =3D get_gpr(ctx, a->rs2, EXT_NONE);
+    TCGv data1 =3D get_gpr(ctx, a->rs3, EXT_NONE);
+    TCGv addr =3D tcg_temp_new();
+
+    tcg_gen_addi_tl(addr, src, a->imm_v);
+    tcg_gen_qemu_st_tl(data0, addr, ctx->mem_idx, MO_TESL);
+
+    tcg_gen_addi_tl(addr, addr, 4);
+    tcg_gen_qemu_st_tl(data1, addr, ctx->mem_idx, MO_TESL);
+
+    return true;
+}
+
 static bool trans_pref(DisasContext *ctx, arg_pref *a)
 {
     REQUIRE_XMIPSCBOP(ctx);
diff --git a/target/riscv/xmips.decode b/target/riscv/xmips.decode
index 697bf26c26..99c98d4084 100644
--- a/target/riscv/xmips.decode
+++ b/target/riscv/xmips.decode
@@ -8,5 +8,28 @@
 # Reference: MIPS P8700 instructions
 #            (https://mips.com/products/hardware/p8700/)
=20
+# Fields
+%rs3       27:5
+%rs2       20:5
+%rs1       15:5
+%rd        7:5
+%imm_9     20:9
+%imm_hint  7:5
+%imm_v     25:2 9:3               !function=3Dex_shift_2
+%imm_w     25:2 10:2              !function=3Dex_shift_3
+%imm_x     22:5                   !function=3Dex_shift_2
+%imm_y     23:4                   !function=3Dex_shift_3
+
+# Formats
+@r4_immv ..... .. ..... ..... ... ... .. ....... %rs2 %rs3 %imm_v %rs1
+@r4_immw ..... .. ..... ..... ... .. ... ....... %rs2 %rs3 %imm_w %rs1
+@r4_immx ..... .....  .. ..... ... ..... ....... %rs3 %imm_x %rs1 %rd
+@r4_immy ..... ....  ... ..... ... ..... ....... %rs3 %imm_y %rs1 %rd
+
+# *** RV64 MIPS Extension ***
 ccmov          rs3:5 11 rs2:5 rs1:5 011 rd:5 0001011
 pref        000 imm_9:9 rs1:5 000 imm_hint:5 0001011
+ldp         ..... .... 000 ..... 100 .....  0001011 @r4_immy
+lwp         ..... ..... 01 ..... 100 .....  0001011 @r4_immx
+sdp         ..... .. ..... ..... 101 ..  0000001011 @r4_immw
+swp         ..... .. ..... ..... 101 ...  010001011 @r4_immv
--=20
2.34.1

