Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1327CDD1AF
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2024 13:26:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1suAzB-0005Za-RY; Fri, 27 Sep 2024 09:26:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.rakic@htecgroup.com>)
 id 1su9ln-0007GT-CN
 for qemu-devel@nongnu.org; Fri, 27 Sep 2024 08:08:23 -0400
Received: from mail-vi1eur05on20703.outbound.protection.outlook.com
 ([2a01:111:f403:2613::703]
 helo=EUR05-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.rakic@htecgroup.com>)
 id 1su9ll-0000xi-Em
 for qemu-devel@nongnu.org; Fri, 27 Sep 2024 08:08:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jZXRDpZWK170D/sobWvBv2BARU/noylwTVSwG/aV1J8ZLDvv0B/tvZxwWomns3Uae8Tzl468+5Idkvi/XyZn14fzBKAf7ByV1yDwPEr/QJlSJ+YaXzyG9BYuWJ6mOPagu+CMCz7JyRvN28QtQNEDBpSZx6KecqTOHiB31QqWiG5TFUa2gnnfu1cVYYbBi02FTR9wnNY1ARNPv/Q8Trrxy9VOQmwgsf8dcJ3qOxLKPwHSeQisvdFLpoa6aGE3JuWJF7yUGzWZdDNncEaSRGxpXDwLigssqe7VEVKnA8n6GM9TIrWKy6aQkn0ACfD0XeQO5PhGorKHfz0VIw0/hvO4mA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oix4ktFz28oJS4wTslPC77IM527tC46OX1WJw+8DhjE=;
 b=Xytg2s2oAXfNunaBSgaXhVhzkq8aVNGDWBsgphPsh46ZV7ZENaejCoFqJ8h5W3TYZlIE0Dy+DaFPwYO4uIU7tGvxOd1TfRDfsZ93lGS0e8UYwpUynGrqGGxXNiVV2nY+Ahv+P0Nu3Ugfg8BRUzmXqiQfxxJ1/qJ0GD8kh16wilFknz32hrasOqV93zXX51UnbqpeOizgd6CdYO8zrkCx3GD11Cxp0BScVkr1oN8xMxBsbmPm73bnjar87xoWOjql01G4CoR1+cvphN1M8Tuv5R4GGIIrgMQ7XLQYQcAWus8Z1979b1vKk0DKnf5XMDgcKoqqF128Qr9ooPul6Vja4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oix4ktFz28oJS4wTslPC77IM527tC46OX1WJw+8DhjE=;
 b=LOMrMlwsYc9e75aJxm7O4Olc5Ie7UjqLapyP6kvYjhv6v1u9dUlLkFTYwbfD2IEdClzXvHiOqtPWtNwX2kXqPfs6B8QojmVKJn28ZwiTgivRFni2swtviMw8SytVODB5UuryDX5EF6wHVR7Ho56d2hGhsVK8vlScHeIHpCvGMzmcGV3BqtNKyuFb+Ev2KAapGnW2CIDrHjCLE3bsXpUsV1hhpcJeWiYJnmFHPflN/+PTf5oWlQWi0MPZ6u6KQOr9U6RGAsf5zkgTm3E9Vvkov3vo4jHQ2Hf6zRn2Xcd6x8SGI0uoUmP3nSOATFqcbOa+ojPpe7ZmnJK65k15hMLVag==
Received: from PA4PR09MB4864.eurprd09.prod.outlook.com (2603:10a6:102:ed::17)
 by VI1PR09MB3967.eurprd09.prod.outlook.com (2603:10a6:800:12f::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.20; Fri, 27 Sep
 2024 12:08:14 +0000
Received: from PA4PR09MB4864.eurprd09.prod.outlook.com
 ([fe80::a02b:9d5c:eca5:e024]) by PA4PR09MB4864.eurprd09.prod.outlook.com
 ([fe80::a02b:9d5c:eca5:e024%7]) with mapi id 15.20.8005.021; Fri, 27 Sep 2024
 12:08:14 +0000
From: Aleksandar Rakic <aleksandar.rakic@htecgroup.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>, "cfu@mips.com"
 <cfu@mips.com>
Subject: [PATCH 5/8] Add micromips to P5600
Thread-Topic: [PATCH 5/8] Add micromips to P5600
Thread-Index: AQHbENWzTt4WtNCu6kmK9g9QryLdpQ==
Date: Fri, 27 Sep 2024 12:08:14 +0000
Message-ID: <PA4PR09MB4864F7B726C9BA323BB307A1846B2@PA4PR09MB4864.eurprd09.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA4PR09MB4864:EE_|VI1PR09MB3967:EE_
x-ms-office365-filtering-correlation-id: fc083216-50c9-404d-6432-08dcdeed109c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?PJTWLqXlKUVTljql37n6Xbk41ayPSCe+BK0BRv2bMJw4FUm0iDHlwSmgfX?=
 =?iso-8859-1?Q?SpUTtOVktkgUya49HKjVQ5VEACjHFTyNsHltrMlY5AHmPbs5IqWmlXYw7E?=
 =?iso-8859-1?Q?F9eMO7IF4mJ6uUVQNk4qzUuQcHMLP0BAtM6ocve9LHG8gwLhtttRSBTbzm?=
 =?iso-8859-1?Q?+oCFFC2dV5K8aRmlMI8lVeoviZC6Vd/h14mxGG5u/1ELUr8sk8ydUTVDzI?=
 =?iso-8859-1?Q?qjrXkHzxsaE9D4WRzfziSpztOMNa+LblAbPB5QglvK6V9wag1vwfRiaVK0?=
 =?iso-8859-1?Q?IiqiX2ha30u1v09UwB4BwisK2Chr10djE55r5Uc3vIIfaV3RZjVb8BAUE5?=
 =?iso-8859-1?Q?RtfhKF3iAa+RikOuMT2XY3sekykVDxX1E4L/Xqu7ApwV1iA6q9M5huAEya?=
 =?iso-8859-1?Q?PhSsBUIuF6o6d89+yN1n5RstJR+hMaCKRzMeH68frzH8htUJ3HqkW6NoJv?=
 =?iso-8859-1?Q?EhKShwItYXZsed52Qc7C0ABNpmY+wmBFJ+CDiJEpw3NxwVII4g0MLcQBs0?=
 =?iso-8859-1?Q?bMjjJaT2jwOXiRPcwKzOTckGaRVtxb4wj2Oef68ORWYHPh0TcJiO6bUbo9?=
 =?iso-8859-1?Q?NnCxDLqr02yo21Z550mwvn92G7eFxNaMD5O+UjKH7kovGrmpqKqTllhRDi?=
 =?iso-8859-1?Q?Gvz4QqHwMNeBWT3eYrq7E/+F1vb1ejhxH6toU6eFRLnayGFIUQFdoTCm3W?=
 =?iso-8859-1?Q?MecpQZwOEIp2wiAstTz2J/bnDH5oTsR5LLKa1kwOM7cJz4dq22TWvnW302?=
 =?iso-8859-1?Q?PccyXZZRGAEgaoNmy5nQaxWH1SCdbLBJ2QY7vPYsnjDm1mMmMeC/Gg8+bN?=
 =?iso-8859-1?Q?EG5+qOZWINnkGfvdHFAGvnWrA8KlyaTZUXrm4Y/jt++7LFzcYhZMgoo/vE?=
 =?iso-8859-1?Q?SJcuLERpblqmwGOHTqxLg/mTtM0DiweQUslHGDlhhMMq6egO8i7H8S0Glr?=
 =?iso-8859-1?Q?QFvvMBFVkrFpDaNgc/5xENmCmSYpb0c8V5obETssiIj4f6mwrQLUEkNQpX?=
 =?iso-8859-1?Q?2h5I3UYZx1Yckrixwb/C8WYO+JtOnvVJojtnN24Uz1uFiHGWdvymx9K8N4?=
 =?iso-8859-1?Q?IxKhJQ7GnrC0tiUPnDw2SVb3wIikyimrAMQf4nO8TclZQ3+cZjDXEq/r15?=
 =?iso-8859-1?Q?3lE14snC+qDlI50uRW3xGCm8f2pgkWAnKEpc/BCx33SHsVUbFLt6EJiafx?=
 =?iso-8859-1?Q?5YwdydDC4mPDYU2usDnpkXM3Zg0ta7/WqST3Y/V3zWOFPEAFpz1JMGpneb?=
 =?iso-8859-1?Q?odGpJGPNkZfyULKT4UhyBo0AOuosYjcUNPEYx2xS4blWRyTbejFjBwh0zS?=
 =?iso-8859-1?Q?WK/iCgRbQ/4xQxVhCO2KuqOIlTC7UHNqeKd9YHbSoXmVheRR6j/wyLbfkl?=
 =?iso-8859-1?Q?iYQbI7UD92wVAyAy2xoNa9OZsMRKXq/MgBUDslo2keKD2Uifchn42BFjbn?=
 =?iso-8859-1?Q?LRuqGtLX1nQuOumE9FWvnKAhCX/mixLhZZB9jQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA4PR09MB4864.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?tm/0/P0aC/R7adMBthkkRnbBEcnYVF0rwiDFZy0Kt55gFgpp0iT88PCxVI?=
 =?iso-8859-1?Q?JfRJgDAIj7CXOoHanQ2IJAoKr0Zgp3bvKy8bmQFsj1V3QlQirWote75S63?=
 =?iso-8859-1?Q?r8B8dpFBO8OPaNLY/ZAGrZ0ZbBX9vnNjYQ8vcxJElRnvfGHU+MpgaCurQQ?=
 =?iso-8859-1?Q?4kkexSunS2ZRu+3FjqIOihc1CX5gZF0z5J+dztS27evWgah+/7H0YZxVm+?=
 =?iso-8859-1?Q?OwhNtHHzccn49+F8F2ZAUztFoJSLveocKeHze6diNzEHmJobUV6LrH8mhg?=
 =?iso-8859-1?Q?qdxQONom9pQgY2NYjf/YP8NgniMimHcL5HilhRN70mptMqvgsquKhKcV+Q?=
 =?iso-8859-1?Q?qWQzaaI7Tez9J/rfx95ZcirAmdSQ2afKpvWR7V71SCH2PCvVeP69QS116F?=
 =?iso-8859-1?Q?h55pTmt4QmRu3yJQZNcafF24glL/ldRyTx0X9EqRH5d9J+wMn6oR+FAMcv?=
 =?iso-8859-1?Q?eUJhKdH+pbuaCuJN/sW6cSz/shEjzdHGq+d9gRlx1nCl6XQyZAnTUWASEL?=
 =?iso-8859-1?Q?OpnKyixUPFi1AOvL1Y8pD83SHMWerhrYzdCyBDsyDEFIpAtj+v5Nsz6v2Q?=
 =?iso-8859-1?Q?pod1VD3yNHmjVo6/HYUDU2jmRnkZgP9/sbh0zQaSg4+ejlR1BPuFjP4JQ1?=
 =?iso-8859-1?Q?3jkpjgIaoU8K/hzDjB4elSfzeJofaD/WSEJRj8u/eW6YUy86QwZbVG9TS1?=
 =?iso-8859-1?Q?p7iAzRAq8UrQG9u3Hq1SO8CcR7B35aqy2LWOCc23zie3zRZYw6qFmNsx67?=
 =?iso-8859-1?Q?kLOnNEBWmL6yazZdZVsPt1w80kIjfw4OE46S13IR3KTcHmAlLZtXtc8K91?=
 =?iso-8859-1?Q?fLuV9pHSdbRaLbOSogeCvW20KpZufL451o9NXTWYYaXsuLvDvDzGT7zuN2?=
 =?iso-8859-1?Q?Sc8wWiAGGa5+yaXx2P6FMiTpRAdlk8htFhC140AohGOIro7lEvfvqjwGuu?=
 =?iso-8859-1?Q?4ihm4V8++Wg8498+4f2gySw8IJABLS1guCPvSVukQshzqY4AVNycIPV5Nu?=
 =?iso-8859-1?Q?ERlC7MWiw8CCdHCy412W6EwtlrLMgWqKLnkAJEqX/scMHNAX3v+HVVD5HN?=
 =?iso-8859-1?Q?Xi0qUgvowPLKu9dv6ruLqdQHhbT7/aqIx3+uDg62jlMzTcgM1skOe0fpJd?=
 =?iso-8859-1?Q?+0DHSyP9Vi0QU7OmrVl5XEYPtyyAsvqf1TXswZ2nXDsi9Xwz/nldiR2HQ9?=
 =?iso-8859-1?Q?sFaLJLLPsCO+2pSTGhp6SxUIUTpr3wNeCGT0txwj2x5bcqEY+RDuvM+hul?=
 =?iso-8859-1?Q?iC7l9gkUkIdB7qmfRPrKMN8SvwuFNgEp2/eoUe0B452XbAERL4qK+Lkq1E?=
 =?iso-8859-1?Q?W/iywPwnyRxtuNG7uKSP8lpgKtqhwfR9x7C2I+b1h+rz7aPCbw3g3mGvZI?=
 =?iso-8859-1?Q?RJga/QTSGCIWE3krVCloErc6dLRlaALo6NNRFZtSUC5BfcElnkKpzHEdgR?=
 =?iso-8859-1?Q?REhrSuQaZnJLFVMwA5v6ujfiNx2zIQnaAHZPIzAVlRHpIQJ3nXRfkFBrC4?=
 =?iso-8859-1?Q?RSbsStY6wdCJRXLwBH9DZix/C7sUFBiYExiv62/UNfdTFCg1wRmkWQtH4g?=
 =?iso-8859-1?Q?YTNbyRGuHMFU1CLUiryRAfI3hsx0IaYVyGlARDTod4x9fw18/GzdgQvwoX?=
 =?iso-8859-1?Q?Wv0jxEWtxIeIGxtMIkO/FswqNpQsohHeHNi2Zq6K1B5eJfVhxFH0ZkdQ?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA4PR09MB4864.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc083216-50c9-404d-6432-08dcdeed109c
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Sep 2024 12:08:14.6613 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7UaYZAe55QTBsgPctOBGQvmc5i6SkkPij2ZQ69w2wVY0Z019uiOi6NKbFiDWcJ0TJWBVKCf6Ur8h+k5o/6RFjthA43r0XoJuAJVDXYB+X80=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR09MB3967
Received-SPF: pass client-ip=2a01:111:f403:2613::703;
 envelope-from=aleksandar.rakic@htecgroup.com;
 helo=EUR05-VI1-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 27 Sep 2024 09:25:47 -0400
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

Add micromips to P5600.=0A=
=0A=
Cherry-picked d7bf2c2f7f2e03b55c6e9c57eec5c3e6207005a0=0A=
from https://github.com/MIPS/gnutools-qemu=0A=
=0A=
Signed-off-by: Faraz Shahbazker <fshahbazker@wavecomp.com>=0A=
Signed-off-by: Matthew Fortune <matthew.fortune@imgtec.com>=0A=
Signed-off-by: Aleksandar Rakic <aleksandar.rakic@htecgroup.com>=0A=
---=0A=
 target/mips/cpu-defs.c.inc | 2 +-=0A=
 1 file changed, 1 insertion(+), 1 deletion(-)=0A=
=0A=
diff --git a/target/mips/cpu-defs.c.inc b/target/mips/cpu-defs.c.inc=0A=
index fbf787d8ce..9428ece220 100644=0A=
--- a/target/mips/cpu-defs.c.inc=0A=
+++ b/target/mips/cpu-defs.c.inc=0A=
@@ -462,7 +462,7 @@ const mips_def_t mips_defs[] =3D=0A=
         .CP1_fcr31_rw_bitmask =3D 0xFF83FFFF,=0A=
         .SEGBITS =3D 32,=0A=
         .PABITS =3D 40,=0A=
-        .insn_flags =3D CPU_MIPS32R5,=0A=
+        .insn_flags =3D CPU_MIPS32R5 | ASE_MICROMIPS,=0A=
         .mmu_type =3D MMU_TYPE_R4000,=0A=
     },=0A=
     {=0A=
-- =0A=
2.34.1=0A=

