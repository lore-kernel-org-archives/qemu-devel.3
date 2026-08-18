Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E822EC5DF7D
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 18:53:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwOvq-0004p1-8e; Tue, 18 Aug 2026 14:53:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dcook@microsoft.com>)
 id 1wwOvo-0004ih-N3
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 14:53:04 -0400
Received: from mail-westcentralusazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c112::7] helo=CY3PR05CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dcook@microsoft.com>)
 id 1wwOvl-0000h4-FJ
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 14:53:03 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=No+mLc5ZPNJNrUrmfAJeD8fDhhaJE+/K6FcDKf+fIpH8FXO+8FbqwtOQPWETdRmps18epZWZzM9MgZcx4KG4E1BsxruljqBm5nc3ePuL85e222425OTBP0GitT4Kcr//vZin5tmXfqHlKI488dD58Jhq4ahBjpaDIGQV3A29UwL63xsuGs5qJkIZq2bNHOwkP0F0cifT+h/CRH/nPeqf0BaBtj36Hef32zB9mCIcgW1f5MWDcoEIK8GJPEx3Ofh5R0G5A1L/yGkQeV2qQBBXDyeXAHhWIOs0Ba3JPU7VpWVXZPFZe6IpWKPLLdUozCDvRVrj+V+9uU7OjwDI5WcR9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5aCsDCvT/Usn+6RF6nrzb6WWpdygfWZvTrfNaPlgJ8A=;
 b=oFoyMZDK7fOLK9D3GPty4D/t4e38qktxhmp1HEapVnp0mqQJWaslqGoRABODcZj4CKhvJ3LXMnIC65mtwlpNkSI5uO+h2Kiu5NFL7bkNZ2uHFppwdT1S/lK7fWG32EAecE4qe7BgHXui96pLktotDeohCSsFLbXAQoUW3ldPFHvc55ORj4HRod95t1CQzU0UYHIUrzfj/ZWParL5+ZHQt/w4cfWDwIZIKmJqAjAtk3Vn7q0mi++METU2U+DOSvAEMHyutJQyLxXaoZ8FB+LhiTgS4G36lqnOVtxJHAmUuN72M50uQqBpFDrFSy3YdlvM0aeF+RWZAVOJ3Kokk7oHSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5aCsDCvT/Usn+6RF6nrzb6WWpdygfWZvTrfNaPlgJ8A=;
 b=LK+JZGaVjcQAcaF6dC/BbzhWt+grN8ur/WKUKa/QDRnVuW97VAVNCEKENduUrL9kt2MDadDdDKkJYcFZlWKR8PkdRyKCY74iK5rgB/QDhvgg726AzR6uH6XRp38Ypg+B4KUTES3wJ5+v4M6Y3xtNk3Rnwhm5qgV01n1Tf5JpG4Y=
Received: from LVXPR21MB7009.namprd21.prod.outlook.com (2603:10b6:408:37f::24)
 by LV5PR21MB5091.namprd21.prod.outlook.com (2603:10b6:408:2fd::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.0; Tue, 18 Aug
 2026 18:52:57 +0000
Received: from LVXPR21MB7009.namprd21.prod.outlook.com
 ([fe80::31c0:bc96:2ac3:64dc]) by LVXPR21MB7009.namprd21.prod.outlook.com
 ([fe80::31c0:bc96:2ac3:64dc%4]) with mapi id 15.21.0315.008; Tue, 18 Aug 2026
 18:52:57 +0000
From: "Doug Cook (WINDOWS)" <dcook@microsoft.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: Pedro d'Aquino Filocre F S Barbuda <pbarbuda@microsoft.com>, Mohamed
 Mediouni <mohamed@unpredictable.fr>
Subject: [PATCH] target/arm/whpx: fix whpx-arm reset hang
Thread-Topic: [PATCH] target/arm/whpx: fix whpx-arm reset hang
Thread-Index: Ad0vQr38yYpRE3OHS9q9z76IXmdvXQ==
Date: Tue, 18 Aug 2026 18:52:57 +0000
Message-ID: <LVXPR21MB7009095A64089AACFA91DB10ADA62@LVXPR21MB7009.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=d97517ab-f17a-4d9f-9fc7-809d2c45b44f;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2026-08-18T18:51:58Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LVXPR21MB7009:EE_|LV5PR21MB5091:EE_
x-ms-office365-filtering-correlation-id: cda09ba6-01d4-4d01-ed36-08defd59eb75
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|23010399003|18002099003|56012099006|38070700021|6133799003|5023799004|10067099003|11063799006|7146999003;
x-microsoft-antispam-message-info: kBcV0cqTLrGwn1Ohj+lunhkWwcUxyDLg9bOw1agT9cuzU7+LmksiM7cbHY4IH58tvMfxuHVCBpB5w0IDxD09WhXQNmyY9VzjrF27SAeP0n3CPW2VqlHcjlS4vbRMZRoakOz6UDJcxgnI1cKDDFfsbuXjaNT1SU5zEML6jPhMg9l1GynOLGFfpG1b9KnrNc4DpjwSuC3DPR198kH70zlkaMqmawBRr6davUHHI8GFfNiTul6ei1qqKYSDgsgZ4qspOksTwLZRVDXecQgrOWBObdcVwb7VrSak+nhV++Uxd5O0mFDU5b8lXyNdyI7lSESgpeIwbH4QkqMWo42EBobLHtH+8FZX7s9m4f4F6xrc198/hnImuqojhRkfjrGre1gBM+XT/KnlJsZgWFlGR7yV8C6DiOZ399LywT9/ihBvHbucXnao2sAlD0VaROJPxQ3T5Y6kD9++dOYsSlczakpAlaY0ZxITDZPvizEF3z++LTpqzTO0zW2NI244mLRxuNOZ8fB7hx+EtKqNQPPz9ZSDujvB8oETmTmynwqbYgW3jimmJMPgreOPYt5c4Ik3uAoBiKGKbjKGpaPn9bCBn00RGHHzfK+ygG9gd5rj+ZCXqBbEvGG9N5J2Hp2ZFTsUOEYeVHEc9RS/DsLDaSwRjFrikgpgNFH+ZfOJxjUAuf97ORd4mcdardQ2+p4kuCuU8nhMx+MQK681S847eF70yTvL6qVxI3Nl2Xf3HQ60HkADADI=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LVXPR21MB7009.namprd21.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(18002099003)(56012099006)(38070700021)(6133799003)(5023799004)(10067099003)(11063799006)(7146999003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Xga2URH3Ph9nI1C/L2v+3huXx/pX2Sijd5Dx8nEFj4IC41SY7J/m0JWTL2rC?=
 =?us-ascii?Q?UQynHadDPRFTsn3xNQXdCYkdqOxozbs3eudkwEjWjr6MaWxeTVA1gtHYEvXZ?=
 =?us-ascii?Q?r9bPj8jrevlsKK3lCg8tgWI55nOgqfzRfBx46ydLJZLvlxN9Pk7cQswwpNzz?=
 =?us-ascii?Q?0HRpNavGwfjE52woGfS4QeeA8flDnS+Sr7UN1okJSYGyunPoSE0rARduwJe2?=
 =?us-ascii?Q?nQRfP5EdJJVVeFfAinAEvSTNWajcjAxEcRCsr7iMcFRW53TxHEkToileMLIh?=
 =?us-ascii?Q?cuJt9LcRnUDIClCSsC8X+1jpLCHLiy9Oftz4M8Ti/Sje7swVzFeRjskXkGj0?=
 =?us-ascii?Q?xnbxdodnvZ9BF9YiiRYHzh4+zmbnAuOsbJHJxrml+vkAF/WYxMl6bYWy3o0J?=
 =?us-ascii?Q?ffIhDsJZG3SKo7dzZdHWfW5xXFWnMe35CFd3Rk2CBVN3LiP7OUoPFCOAySXL?=
 =?us-ascii?Q?M98cq44MZ+D9Rs0I7Ieo+JHNoE6Vh2/eHDBy2Lb0RV0GbVQPqsgIUlJi3I/e?=
 =?us-ascii?Q?zm2CDRsF+vgox19iomDJHR8Z1WUyElI6bnoaLrKPpB2BDAW8RvC3DFEwPg3+?=
 =?us-ascii?Q?1VeywQNIDftDBVTVYVbsSHNb3NAzIlgCqAT+EIuPP0+SofhGJlxa2ARzS+u6?=
 =?us-ascii?Q?04cCUkCvSWvekE59a1KUO7WVegYQyHT+sgHV1NP6t8vW8KySDZdA0tuzdV94?=
 =?us-ascii?Q?OaRAuuThv1elUPBxf6ESHBy0tP8gReeoNCypS54pgSFz/76CemA1riyclS90?=
 =?us-ascii?Q?39TzVQLj26U9xJL4SmxWAUliodX/PPO5aZcDgQJWjymzkiapl7xqY2zICL5K?=
 =?us-ascii?Q?SB6WKMzVIbHJ8w3B6vWxDj/F8gW9G7vKtsIwo+WXMl0FSz5qhFH8rBYl/5P/?=
 =?us-ascii?Q?so3zs2OIE2Src8Kl83HJU++yTM/QG8kUF/sDDF/VdiUHH28JTyOP24LbX4qD?=
 =?us-ascii?Q?SF4WKT8hEdQwJoLIzl2hDVZw+7dvgXukRjtEFZYrHV018xjnAZik5brMIEcy?=
 =?us-ascii?Q?4OSAUY+gq19Soh/sQrZIrsRrEd+fufrhl/EID1n1WAqzMHSwWzNUo/cwjS5P?=
 =?us-ascii?Q?LxE+Z6sdgSEDtHZHDLZnpV0+WCDQbVaG8GQJ50G8UALMlp7qzIJr3pjr82QG?=
 =?us-ascii?Q?rrBIPvGgqa1cQAW6WyNFNkJ7aoRcnP3DO0sCf3Lnx5Q8rEu77l/d41DizWOa?=
 =?us-ascii?Q?CkMKCXxPTHFhYuL9PSMwYO3aGp1b7geFSWLVF8ozMFjKgaLfBTzcYKe08082?=
 =?us-ascii?Q?nv56Fzf7ViE7pFqirasG0a6lvA1D9AYGe6YGMBfcON0wszfNsw5JjQcRD4SX?=
 =?us-ascii?Q?nNcKRZ+mdLGY7EDNAmzXln2CX70pDPKbCuX2nN4TGdCeN120m6KnHb+c9ZSE?=
 =?us-ascii?Q?ytgWAjd35yPaJAvqgKw38EPTwUACnhTHE/XAxOsliC/nG+YBmiOzWAGCyX0q?=
 =?us-ascii?Q?bK2IW+i1nUCvcjHb1ZsEErtYY8VyYkBiPLYxsKztQPCJwGhcygioGPowDr78?=
 =?us-ascii?Q?KziE7m2mk4E4daE/es2lij7nJxbJrGFkLMcN/cghP3Y9ET8p7b/i+mn7iipm?=
 =?us-ascii?Q?NlrKuUEbjEv2wVvq5/uJqjZDtb9j/AMfuFyDuUxKdD+0oZqRet0L633UpY4O?=
 =?us-ascii?Q?9WfmJmGSuKlA5iMCJVgdVGzot3CLGVZcTEx47Dr6760Hz4sRWjgK3xWTj2Fd?=
 =?us-ascii?Q?tiw2oRAoLcyKbo6GHqhKv6OyONIwPy7robVuMRw1lHLtVWW1?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LVXPR21MB7009.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cda09ba6-01d4-4d01-ed36-08defd59eb75
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Aug 2026 18:52:57.7026 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: r6bg1G2oRKVDpBrKQ6gUO8jc7Ymsha2PMJhHkCE4V6yWkpjIWV88RyVjafh/9rY2VBlRXFvPyDsQbrvxO/PZQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV5PR21MB5091
Received-SPF: pass client-ip=2a01:111:f403:c112::7;
 envelope-from=dcook@microsoft.com;
 helo=CY3PR05CU001.outbound.protection.outlook.com
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.343,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_NONE=0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Under whpx, arm reset results in hangs and crashes.

- Arguments out of order in ENCODE_AA64_CP_REG, so get_arm_cp_reginfo()
  fails, whpx_set_registers does nothing for reset, and SCTLR_EL1 retains
  guest state with MMU enabled after reset, resulting in fault and hang.
  Fix via wrapper macro to retain existing ordering convention.
- Fixing the ENCODE_AA64_CP_REG issue results in assertions while trying
  to write to ARM_CP_CONST registers. Skip them.
- Correct four entries in the breakpoint/watchpoint index 1 block that
  named index 0 registers.
- CPUs that are idle at time of reset remain in suspend after reset.
- CPUs are not in the correct StartupSuspend state after reset.

After this change, I am able to repeatedly reset an arm64 guest, using
shutdown-reset, external reset, and watchdog reset.

Signed-off-by: Doug Cook <dcook@microsoft.com>
---
 target/arm/whpx/whpx-all.c | 306 +++++++++++++++++++++----------------
 1 file changed, 177 insertions(+), 129 deletions(-)

diff --git a/target/arm/whpx/whpx-all.c b/target/arm/whpx/whpx-all.c
index 00a5de8cdc..f3e7caf794 100644
--- a/target/arm/whpx/whpx-all.c
+++ b/target/arm/whpx/whpx-all.c
@@ -134,143 +134,150 @@ struct whpx_sreg_match {
     uint32_t cp_idx;
 };
=20
+/*
+ * Adapt conventional order WHPX_SYSREG(crn, crm, op0, op1, op2) to
+ * ENCODE_AA64_CP_REG(op0, op1, crn, crm, op2).
+ */
+#define WHPX_SYSREG(crn, crm, op0, op1, op2) \
+    ENCODE_AA64_CP_REG(op0, op1, crn, crm, op2)
+
 static struct whpx_sreg_match whpx_sreg_match[] =3D {
-    { WHvArm64RegisterDbgbvr0El1, ENCODE_AA64_CP_REG(0, 0, 2, 0, 4) },
-    { WHvArm64RegisterDbgbcr0El1, ENCODE_AA64_CP_REG(0, 0, 2, 0, 5) },
-    { WHvArm64RegisterDbgwvr0El1, ENCODE_AA64_CP_REG(0, 0, 2, 0, 6) },
-    { WHvArm64RegisterDbgwcr0El1, ENCODE_AA64_CP_REG(0, 0, 2, 0, 7) },
-
-    { WHvArm64RegisterDbgbvr0El1, ENCODE_AA64_CP_REG(0, 1, 2, 0, 4) },
-    { WHvArm64RegisterDbgbcr0El1, ENCODE_AA64_CP_REG(0, 1, 2, 0, 5) },
-    { WHvArm64RegisterDbgwvr0El1, ENCODE_AA64_CP_REG(0, 1, 2, 0, 6) },
-    { WHvArm64RegisterDbgwcr0El1, ENCODE_AA64_CP_REG(0, 1, 2, 0, 7) },
-
-    { WHvArm64RegisterDbgbvr2El1, ENCODE_AA64_CP_REG(0, 2, 2, 0, 4) },
-    { WHvArm64RegisterDbgbcr2El1, ENCODE_AA64_CP_REG(0, 2, 2, 0, 5) },
-    { WHvArm64RegisterDbgwvr2El1, ENCODE_AA64_CP_REG(0, 2, 2, 0, 6) },
-    { WHvArm64RegisterDbgwcr2El1, ENCODE_AA64_CP_REG(0, 2, 2, 0, 7) },
-
-    { WHvArm64RegisterDbgbvr3El1, ENCODE_AA64_CP_REG(0, 3, 2, 0, 4) },
-    { WHvArm64RegisterDbgbcr3El1, ENCODE_AA64_CP_REG(0, 3, 2, 0, 5) },
-    { WHvArm64RegisterDbgwvr3El1, ENCODE_AA64_CP_REG(0, 3, 2, 0, 6) },
-    { WHvArm64RegisterDbgwcr3El1, ENCODE_AA64_CP_REG(0, 3, 2, 0, 7) },
-
-    { WHvArm64RegisterDbgbvr4El1, ENCODE_AA64_CP_REG(0, 4, 2, 0, 4) },
-    { WHvArm64RegisterDbgbcr4El1, ENCODE_AA64_CP_REG(0, 4, 2, 0, 5) },
-    { WHvArm64RegisterDbgwvr4El1, ENCODE_AA64_CP_REG(0, 4, 2, 0, 6) },
-    { WHvArm64RegisterDbgwcr4El1, ENCODE_AA64_CP_REG(0, 4, 2, 0, 7) },
-
-    { WHvArm64RegisterDbgbvr5El1, ENCODE_AA64_CP_REG(0, 5, 2, 0, 4) },
-    { WHvArm64RegisterDbgbcr5El1, ENCODE_AA64_CP_REG(0, 5, 2, 0, 5) },
-    { WHvArm64RegisterDbgwvr5El1, ENCODE_AA64_CP_REG(0, 5, 2, 0, 6) },
-    { WHvArm64RegisterDbgwcr5El1, ENCODE_AA64_CP_REG(0, 5, 2, 0, 7) },
-
-    { WHvArm64RegisterDbgbvr6El1, ENCODE_AA64_CP_REG(0, 6, 2, 0, 4) },
-    { WHvArm64RegisterDbgbcr6El1, ENCODE_AA64_CP_REG(0, 6, 2, 0, 5) },
-    { WHvArm64RegisterDbgwvr6El1, ENCODE_AA64_CP_REG(0, 6, 2, 0, 6) },
-    { WHvArm64RegisterDbgwcr6El1, ENCODE_AA64_CP_REG(0, 6, 2, 0, 7) },
-
-    { WHvArm64RegisterDbgbvr7El1, ENCODE_AA64_CP_REG(0, 7, 2, 0, 4) },
-    { WHvArm64RegisterDbgbcr7El1, ENCODE_AA64_CP_REG(0, 7, 2, 0, 5) },
-    { WHvArm64RegisterDbgwvr7El1, ENCODE_AA64_CP_REG(0, 7, 2, 0, 6) },
-    { WHvArm64RegisterDbgwcr7El1, ENCODE_AA64_CP_REG(0, 7, 2, 0, 7) },
-
-    { WHvArm64RegisterDbgbvr8El1, ENCODE_AA64_CP_REG(0, 8, 2, 0, 4) },
-    { WHvArm64RegisterDbgbcr8El1, ENCODE_AA64_CP_REG(0, 8, 2, 0, 5) },
-    { WHvArm64RegisterDbgwvr8El1, ENCODE_AA64_CP_REG(0, 8, 2, 0, 6) },
-    { WHvArm64RegisterDbgwcr8El1, ENCODE_AA64_CP_REG(0, 8, 2, 0, 7) },
-
-    { WHvArm64RegisterDbgbvr9El1, ENCODE_AA64_CP_REG(0, 9, 2, 0, 4) },
-    { WHvArm64RegisterDbgbcr9El1, ENCODE_AA64_CP_REG(0, 9, 2, 0, 5) },
-    { WHvArm64RegisterDbgwvr9El1, ENCODE_AA64_CP_REG(0, 9, 2, 0, 6) },
-    { WHvArm64RegisterDbgwcr9El1, ENCODE_AA64_CP_REG(0, 9, 2, 0, 7) },
-
-    { WHvArm64RegisterDbgbvr10El1, ENCODE_AA64_CP_REG(0, 10, 2, 0, 4) },
-    { WHvArm64RegisterDbgbcr10El1, ENCODE_AA64_CP_REG(0, 10, 2, 0, 5) },
-    { WHvArm64RegisterDbgwvr10El1, ENCODE_AA64_CP_REG(0, 10, 2, 0, 6) },
-    { WHvArm64RegisterDbgwcr10El1, ENCODE_AA64_CP_REG(0, 10, 2, 0, 7) },
-
-    { WHvArm64RegisterDbgbvr11El1, ENCODE_AA64_CP_REG(0, 11, 2, 0, 4) },
-    { WHvArm64RegisterDbgbcr11El1, ENCODE_AA64_CP_REG(0, 11, 2, 0, 5) },
-    { WHvArm64RegisterDbgwvr11El1, ENCODE_AA64_CP_REG(0, 11, 2, 0, 6) },
-    { WHvArm64RegisterDbgwcr11El1, ENCODE_AA64_CP_REG(0, 11, 2, 0, 7) },
-
-    { WHvArm64RegisterDbgbvr12El1, ENCODE_AA64_CP_REG(0, 12, 2, 0, 4) },
-    { WHvArm64RegisterDbgbcr12El1, ENCODE_AA64_CP_REG(0, 12, 2, 0, 5) },
-    { WHvArm64RegisterDbgwvr12El1, ENCODE_AA64_CP_REG(0, 12, 2, 0, 6) },
-    { WHvArm64RegisterDbgwcr12El1, ENCODE_AA64_CP_REG(0, 12, 2, 0, 7) },
-
-    { WHvArm64RegisterDbgbvr13El1, ENCODE_AA64_CP_REG(0, 13, 2, 0, 4) },
-    { WHvArm64RegisterDbgbcr13El1, ENCODE_AA64_CP_REG(0, 13, 2, 0, 5) },
-    { WHvArm64RegisterDbgwvr13El1, ENCODE_AA64_CP_REG(0, 13, 2, 0, 6) },
-    { WHvArm64RegisterDbgwcr13El1, ENCODE_AA64_CP_REG(0, 13, 2, 0, 7) },
-
-    { WHvArm64RegisterDbgbvr14El1, ENCODE_AA64_CP_REG(0, 14, 2, 0, 4) },
-    { WHvArm64RegisterDbgbcr14El1, ENCODE_AA64_CP_REG(0, 14, 2, 0, 5) },
-    { WHvArm64RegisterDbgwvr14El1, ENCODE_AA64_CP_REG(0, 14, 2, 0, 6) },
-    { WHvArm64RegisterDbgwcr14El1, ENCODE_AA64_CP_REG(0, 14, 2, 0, 7) },
-
-    { WHvArm64RegisterDbgbvr15El1, ENCODE_AA64_CP_REG(0, 15, 2, 0, 4) },
-    { WHvArm64RegisterDbgbcr15El1, ENCODE_AA64_CP_REG(0, 15, 2, 0, 5) },
-    { WHvArm64RegisterDbgwvr15El1, ENCODE_AA64_CP_REG(0, 15, 2, 0, 6) },
-    { WHvArm64RegisterDbgwcr15El1, ENCODE_AA64_CP_REG(0, 15, 2, 0, 7) },
+    { WHvArm64RegisterDbgbvr0El1, WHPX_SYSREG(0, 0, 2, 0, 4) },
+    { WHvArm64RegisterDbgbcr0El1, WHPX_SYSREG(0, 0, 2, 0, 5) },
+    { WHvArm64RegisterDbgwvr0El1, WHPX_SYSREG(0, 0, 2, 0, 6) },
+    { WHvArm64RegisterDbgwcr0El1, WHPX_SYSREG(0, 0, 2, 0, 7) },
+
+    { WHvArm64RegisterDbgbvr1El1, WHPX_SYSREG(0, 1, 2, 0, 4) },
+    { WHvArm64RegisterDbgbcr1El1, WHPX_SYSREG(0, 1, 2, 0, 5) },
+    { WHvArm64RegisterDbgwvr1El1, WHPX_SYSREG(0, 1, 2, 0, 6) },
+    { WHvArm64RegisterDbgwcr1El1, WHPX_SYSREG(0, 1, 2, 0, 7) },
+
+    { WHvArm64RegisterDbgbvr2El1, WHPX_SYSREG(0, 2, 2, 0, 4) },
+    { WHvArm64RegisterDbgbcr2El1, WHPX_SYSREG(0, 2, 2, 0, 5) },
+    { WHvArm64RegisterDbgwvr2El1, WHPX_SYSREG(0, 2, 2, 0, 6) },
+    { WHvArm64RegisterDbgwcr2El1, WHPX_SYSREG(0, 2, 2, 0, 7) },
+
+    { WHvArm64RegisterDbgbvr3El1, WHPX_SYSREG(0, 3, 2, 0, 4) },
+    { WHvArm64RegisterDbgbcr3El1, WHPX_SYSREG(0, 3, 2, 0, 5) },
+    { WHvArm64RegisterDbgwvr3El1, WHPX_SYSREG(0, 3, 2, 0, 6) },
+    { WHvArm64RegisterDbgwcr3El1, WHPX_SYSREG(0, 3, 2, 0, 7) },
+
+    { WHvArm64RegisterDbgbvr4El1, WHPX_SYSREG(0, 4, 2, 0, 4) },
+    { WHvArm64RegisterDbgbcr4El1, WHPX_SYSREG(0, 4, 2, 0, 5) },
+    { WHvArm64RegisterDbgwvr4El1, WHPX_SYSREG(0, 4, 2, 0, 6) },
+    { WHvArm64RegisterDbgwcr4El1, WHPX_SYSREG(0, 4, 2, 0, 7) },
+
+    { WHvArm64RegisterDbgbvr5El1, WHPX_SYSREG(0, 5, 2, 0, 4) },
+    { WHvArm64RegisterDbgbcr5El1, WHPX_SYSREG(0, 5, 2, 0, 5) },
+    { WHvArm64RegisterDbgwvr5El1, WHPX_SYSREG(0, 5, 2, 0, 6) },
+    { WHvArm64RegisterDbgwcr5El1, WHPX_SYSREG(0, 5, 2, 0, 7) },
+
+    { WHvArm64RegisterDbgbvr6El1, WHPX_SYSREG(0, 6, 2, 0, 4) },
+    { WHvArm64RegisterDbgbcr6El1, WHPX_SYSREG(0, 6, 2, 0, 5) },
+    { WHvArm64RegisterDbgwvr6El1, WHPX_SYSREG(0, 6, 2, 0, 6) },
+    { WHvArm64RegisterDbgwcr6El1, WHPX_SYSREG(0, 6, 2, 0, 7) },
+
+    { WHvArm64RegisterDbgbvr7El1, WHPX_SYSREG(0, 7, 2, 0, 4) },
+    { WHvArm64RegisterDbgbcr7El1, WHPX_SYSREG(0, 7, 2, 0, 5) },
+    { WHvArm64RegisterDbgwvr7El1, WHPX_SYSREG(0, 7, 2, 0, 6) },
+    { WHvArm64RegisterDbgwcr7El1, WHPX_SYSREG(0, 7, 2, 0, 7) },
+
+    { WHvArm64RegisterDbgbvr8El1, WHPX_SYSREG(0, 8, 2, 0, 4) },
+    { WHvArm64RegisterDbgbcr8El1, WHPX_SYSREG(0, 8, 2, 0, 5) },
+    { WHvArm64RegisterDbgwvr8El1, WHPX_SYSREG(0, 8, 2, 0, 6) },
+    { WHvArm64RegisterDbgwcr8El1, WHPX_SYSREG(0, 8, 2, 0, 7) },
+
+    { WHvArm64RegisterDbgbvr9El1, WHPX_SYSREG(0, 9, 2, 0, 4) },
+    { WHvArm64RegisterDbgbcr9El1, WHPX_SYSREG(0, 9, 2, 0, 5) },
+    { WHvArm64RegisterDbgwvr9El1, WHPX_SYSREG(0, 9, 2, 0, 6) },
+    { WHvArm64RegisterDbgwcr9El1, WHPX_SYSREG(0, 9, 2, 0, 7) },
+
+    { WHvArm64RegisterDbgbvr10El1, WHPX_SYSREG(0, 10, 2, 0, 4) },
+    { WHvArm64RegisterDbgbcr10El1, WHPX_SYSREG(0, 10, 2, 0, 5) },
+    { WHvArm64RegisterDbgwvr10El1, WHPX_SYSREG(0, 10, 2, 0, 6) },
+    { WHvArm64RegisterDbgwcr10El1, WHPX_SYSREG(0, 10, 2, 0, 7) },
+
+    { WHvArm64RegisterDbgbvr11El1, WHPX_SYSREG(0, 11, 2, 0, 4) },
+    { WHvArm64RegisterDbgbcr11El1, WHPX_SYSREG(0, 11, 2, 0, 5) },
+    { WHvArm64RegisterDbgwvr11El1, WHPX_SYSREG(0, 11, 2, 0, 6) },
+    { WHvArm64RegisterDbgwcr11El1, WHPX_SYSREG(0, 11, 2, 0, 7) },
+
+    { WHvArm64RegisterDbgbvr12El1, WHPX_SYSREG(0, 12, 2, 0, 4) },
+    { WHvArm64RegisterDbgbcr12El1, WHPX_SYSREG(0, 12, 2, 0, 5) },
+    { WHvArm64RegisterDbgwvr12El1, WHPX_SYSREG(0, 12, 2, 0, 6) },
+    { WHvArm64RegisterDbgwcr12El1, WHPX_SYSREG(0, 12, 2, 0, 7) },
+
+    { WHvArm64RegisterDbgbvr13El1, WHPX_SYSREG(0, 13, 2, 0, 4) },
+    { WHvArm64RegisterDbgbcr13El1, WHPX_SYSREG(0, 13, 2, 0, 5) },
+    { WHvArm64RegisterDbgwvr13El1, WHPX_SYSREG(0, 13, 2, 0, 6) },
+    { WHvArm64RegisterDbgwcr13El1, WHPX_SYSREG(0, 13, 2, 0, 7) },
+
+    { WHvArm64RegisterDbgbvr14El1, WHPX_SYSREG(0, 14, 2, 0, 4) },
+    { WHvArm64RegisterDbgbcr14El1, WHPX_SYSREG(0, 14, 2, 0, 5) },
+    { WHvArm64RegisterDbgwvr14El1, WHPX_SYSREG(0, 14, 2, 0, 6) },
+    { WHvArm64RegisterDbgwcr14El1, WHPX_SYSREG(0, 14, 2, 0, 7) },
+
+    { WHvArm64RegisterDbgbvr15El1, WHPX_SYSREG(0, 15, 2, 0, 4) },
+    { WHvArm64RegisterDbgbcr15El1, WHPX_SYSREG(0, 15, 2, 0, 5) },
+    { WHvArm64RegisterDbgwvr15El1, WHPX_SYSREG(0, 15, 2, 0, 6) },
+    { WHvArm64RegisterDbgwcr15El1, WHPX_SYSREG(0, 15, 2, 0, 7) },
 #ifdef SYNC_NO_RAW_REGS
     /*
      * The registers below are manually synced on init because they are
      * marked as NO_RAW. We still list them to make number space sync easi=
er.
      */
-    { WHvArm64RegisterMidrEl1, ENCODE_AA64_CP_REG(0, 0, 3, 0, 0) },
-    { WHvArm64RegisterMpidrEl1, ENCODE_AA64_CP_REG(0, 0, 3, 0, 5) },
-    { WHvArm64RegisterIdPfr0El1, ENCODE_AA64_CP_REG(0, 4, 3, 0, 0) },
+    { WHvArm64RegisterMidrEl1, WHPX_SYSREG(0, 0, 3, 0, 0) },
+    { WHvArm64RegisterMpidrEl1, WHPX_SYSREG(0, 0, 3, 0, 5) },
+    { WHvArm64RegisterIdPfr0El1, WHPX_SYSREG(0, 4, 3, 0, 0) },
 #endif
-    { WHvArm64RegisterIdAa64Pfr1El1, ENCODE_AA64_CP_REG(0, 4, 3, 0, 1), tr=
ue },
-    { WHvArm64RegisterIdAa64Dfr0El1, ENCODE_AA64_CP_REG(0, 5, 3, 0, 0), tr=
ue },
-    { WHvArm64RegisterIdAa64Dfr1El1, ENCODE_AA64_CP_REG(0, 5, 3, 0, 1), tr=
ue },
-    { WHvArm64RegisterIdAa64Isar0El1, ENCODE_AA64_CP_REG(0, 6, 3, 0, 0), t=
rue },
-    { WHvArm64RegisterIdAa64Isar1El1, ENCODE_AA64_CP_REG(0, 6, 3, 0, 1), t=
rue },
+    { WHvArm64RegisterIdAa64Pfr1El1, WHPX_SYSREG(0, 4, 3, 0, 1), true },
+    { WHvArm64RegisterIdAa64Dfr0El1, WHPX_SYSREG(0, 5, 3, 0, 0), true },
+    { WHvArm64RegisterIdAa64Dfr1El1, WHPX_SYSREG(0, 5, 3, 0, 1), true },
+    { WHvArm64RegisterIdAa64Isar0El1, WHPX_SYSREG(0, 6, 3, 0, 0), true },
+    { WHvArm64RegisterIdAa64Isar1El1, WHPX_SYSREG(0, 6, 3, 0, 1), true },
 #ifdef SYNC_NO_MMFR0
     /* We keep the hardware MMFR0 around. HW limits are there anyway */
-    { WHvArm64RegisterIdAa64Mmfr0El1, ENCODE_AA64_CP_REG(0, 7, 3, 0, 0) },
+    { WHvArm64RegisterIdAa64Mmfr0El1, WHPX_SYSREG(0, 7, 3, 0, 0) },
 #endif
-    { WHvArm64RegisterIdAa64Mmfr1El1, ENCODE_AA64_CP_REG(0, 7, 3, 0, 1), t=
rue },
-    { WHvArm64RegisterIdAa64Mmfr2El1, ENCODE_AA64_CP_REG(0, 7, 3, 0, 2), t=
rue },
-    { WHvArm64RegisterIdAa64Mmfr3El1, ENCODE_AA64_CP_REG(0, 7, 3, 0, 3), t=
rue },
-
-    { WHvArm64RegisterMdscrEl1, ENCODE_AA64_CP_REG(0, 2, 2, 0, 2) },
-    { WHvArm64RegisterSctlrEl1, ENCODE_AA64_CP_REG(1, 0, 3, 0, 0) },
-    { WHvArm64RegisterCpacrEl1, ENCODE_AA64_CP_REG(1, 0, 3, 0, 2) },
-    { WHvArm64RegisterTtbr0El1, ENCODE_AA64_CP_REG(2, 0, 3, 0, 0) },
-    { WHvArm64RegisterTtbr1El1, ENCODE_AA64_CP_REG(2, 0, 3, 0, 1) },
-    { WHvArm64RegisterTcrEl1, ENCODE_AA64_CP_REG(2, 0, 3, 0, 2) },
-
-    { WHvArm64RegisterApiAKeyLoEl1, ENCODE_AA64_CP_REG(2, 1, 3, 0, 0) },
-    { WHvArm64RegisterApiAKeyHiEl1, ENCODE_AA64_CP_REG(2, 1, 3, 0, 1) },
-    { WHvArm64RegisterApiBKeyLoEl1, ENCODE_AA64_CP_REG(2, 1, 3, 0, 2) },
-    { WHvArm64RegisterApiBKeyHiEl1, ENCODE_AA64_CP_REG(2, 1, 3, 0, 3) },
-    { WHvArm64RegisterApdAKeyLoEl1, ENCODE_AA64_CP_REG(2, 2, 3, 0, 0) },
-    { WHvArm64RegisterApdAKeyHiEl1, ENCODE_AA64_CP_REG(2, 2, 3, 0, 1) },
-    { WHvArm64RegisterApdBKeyLoEl1, ENCODE_AA64_CP_REG(2, 2, 3, 0, 2) },
-    { WHvArm64RegisterApdBKeyHiEl1, ENCODE_AA64_CP_REG(2, 2, 3, 0, 3) },
-    { WHvArm64RegisterApgAKeyLoEl1, ENCODE_AA64_CP_REG(2, 3, 3, 0, 0) },
-    { WHvArm64RegisterApgAKeyHiEl1, ENCODE_AA64_CP_REG(2, 3, 3, 0, 1) },
-
-    { WHvArm64RegisterSpsrEl1, ENCODE_AA64_CP_REG(4, 0, 3, 0, 0) },
-    { WHvArm64RegisterElrEl1, ENCODE_AA64_CP_REG(4, 0, 3, 0, 1) },
-    { WHvArm64RegisterSpEl1, ENCODE_AA64_CP_REG(4, 1, 3, 0, 0) },
-    { WHvArm64RegisterEsrEl1, ENCODE_AA64_CP_REG(5, 2, 3, 0, 0) },
-    { WHvArm64RegisterFarEl1, ENCODE_AA64_CP_REG(6, 0, 3, 0, 0) },
-    { WHvArm64RegisterParEl1, ENCODE_AA64_CP_REG(7, 4, 3, 0, 0) },
-    { WHvArm64RegisterMairEl1, ENCODE_AA64_CP_REG(10, 2, 3, 0, 0) },
-    { WHvArm64RegisterVbarEl1, ENCODE_AA64_CP_REG(12, 0, 3, 0, 0) },
-    { WHvArm64RegisterContextidrEl1, ENCODE_AA64_CP_REG(13, 0, 3, 0, 1) },
-    { WHvArm64RegisterTpidrEl1, ENCODE_AA64_CP_REG(13, 0, 3, 0, 4) },
-    { WHvArm64RegisterCntkctlEl1, ENCODE_AA64_CP_REG(14, 1, 3, 0, 0) },
-    { WHvArm64RegisterCsselrEl1, ENCODE_AA64_CP_REG(0, 0, 3, 2, 0) },
-    { WHvArm64RegisterTpidrEl0, ENCODE_AA64_CP_REG(13, 0, 3, 3, 2) },
-    { WHvArm64RegisterTpidrroEl0, ENCODE_AA64_CP_REG(13, 0, 3, 3, 3) },
-    { WHvArm64RegisterCntvCtlEl0, ENCODE_AA64_CP_REG(14, 3, 3, 3, 1) },
-    { WHvArm64RegisterCntvCvalEl0, ENCODE_AA64_CP_REG(14, 3, 3, 3, 2) },
-    { WHvArm64RegisterSpEl1, ENCODE_AA64_CP_REG(4, 1, 3, 4, 0) },
+    { WHvArm64RegisterIdAa64Mmfr1El1, WHPX_SYSREG(0, 7, 3, 0, 1), true },
+    { WHvArm64RegisterIdAa64Mmfr2El1, WHPX_SYSREG(0, 7, 3, 0, 2), true },
+    { WHvArm64RegisterIdAa64Mmfr3El1, WHPX_SYSREG(0, 7, 3, 0, 3), true },
+
+    { WHvArm64RegisterMdscrEl1, WHPX_SYSREG(0, 2, 2, 0, 2) },
+    { WHvArm64RegisterSctlrEl1, WHPX_SYSREG(1, 0, 3, 0, 0) },
+    { WHvArm64RegisterCpacrEl1, WHPX_SYSREG(1, 0, 3, 0, 2) },
+    { WHvArm64RegisterTtbr0El1, WHPX_SYSREG(2, 0, 3, 0, 0) },
+    { WHvArm64RegisterTtbr1El1, WHPX_SYSREG(2, 0, 3, 0, 1) },
+    { WHvArm64RegisterTcrEl1, WHPX_SYSREG(2, 0, 3, 0, 2) },
+
+    { WHvArm64RegisterApiAKeyLoEl1, WHPX_SYSREG(2, 1, 3, 0, 0) },
+    { WHvArm64RegisterApiAKeyHiEl1, WHPX_SYSREG(2, 1, 3, 0, 1) },
+    { WHvArm64RegisterApiBKeyLoEl1, WHPX_SYSREG(2, 1, 3, 0, 2) },
+    { WHvArm64RegisterApiBKeyHiEl1, WHPX_SYSREG(2, 1, 3, 0, 3) },
+    { WHvArm64RegisterApdAKeyLoEl1, WHPX_SYSREG(2, 2, 3, 0, 0) },
+    { WHvArm64RegisterApdAKeyHiEl1, WHPX_SYSREG(2, 2, 3, 0, 1) },
+    { WHvArm64RegisterApdBKeyLoEl1, WHPX_SYSREG(2, 2, 3, 0, 2) },
+    { WHvArm64RegisterApdBKeyHiEl1, WHPX_SYSREG(2, 2, 3, 0, 3) },
+    { WHvArm64RegisterApgAKeyLoEl1, WHPX_SYSREG(2, 3, 3, 0, 0) },
+    { WHvArm64RegisterApgAKeyHiEl1, WHPX_SYSREG(2, 3, 3, 0, 1) },
+
+    { WHvArm64RegisterSpsrEl1, WHPX_SYSREG(4, 0, 3, 0, 0) },
+    { WHvArm64RegisterElrEl1, WHPX_SYSREG(4, 0, 3, 0, 1) },
+    { WHvArm64RegisterSpEl1, WHPX_SYSREG(4, 1, 3, 0, 0) },
+    { WHvArm64RegisterEsrEl1, WHPX_SYSREG(5, 2, 3, 0, 0) },
+    { WHvArm64RegisterFarEl1, WHPX_SYSREG(6, 0, 3, 0, 0) },
+    { WHvArm64RegisterParEl1, WHPX_SYSREG(7, 4, 3, 0, 0) },
+    { WHvArm64RegisterMairEl1, WHPX_SYSREG(10, 2, 3, 0, 0) },
+    { WHvArm64RegisterVbarEl1, WHPX_SYSREG(12, 0, 3, 0, 0) },
+    { WHvArm64RegisterContextidrEl1, WHPX_SYSREG(13, 0, 3, 0, 1) },
+    { WHvArm64RegisterTpidrEl1, WHPX_SYSREG(13, 0, 3, 0, 4) },
+    { WHvArm64RegisterCntkctlEl1, WHPX_SYSREG(14, 1, 3, 0, 0) },
+    { WHvArm64RegisterCsselrEl1, WHPX_SYSREG(0, 0, 3, 2, 0) },
+    { WHvArm64RegisterTpidrEl0, WHPX_SYSREG(13, 0, 3, 3, 2) },
+    { WHvArm64RegisterTpidrroEl0, WHPX_SYSREG(13, 0, 3, 3, 3) },
+    { WHvArm64RegisterCntvCtlEl0, WHPX_SYSREG(14, 3, 3, 3, 1) },
+    { WHvArm64RegisterCntvCvalEl0, WHPX_SYSREG(14, 3, 3, 3, 2) },
+    { WHvArm64RegisterSpEl1, WHPX_SYSREG(4, 1, 3, 4, 0) },
 };
=20
 HRESULT whpx_set_exception_exit_bitmap(UINT64 exceptions)
@@ -610,6 +617,37 @@ void whpx_set_registers(CPUState *cpu, WHPXStateLevel =
level)
             whpx_set_reg(cpu, whpx_sreg_match[i].reg, val);
         }
     }
+
+    if (level =3D=3D WHPX_LEVEL_RESET_STATE) {
+        /*
+         * WHPX keeps the "vCPU is in a low-power wait" state (entered whe=
n the
+         * guest executes WFI/WFE) in WHvRegisterInternalActivityState, an=
d that
+         * state is not affected by writing the architectural registers ab=
ove.
+         * If the guest happened to be idle when the reset was requested, =
the
+         * vCPU would stay suspended forever.
+         *
+         * StartupSuspend is the bit WHP uses to hold a vCPU that has not =
been
+         * started yet, and it is how secondary vCPUs are parked until PSC=
I
+         * CPU_ON releases them.
+         */
+        WHV_REGISTER_NAME name =3D WHvRegisterInternalActivityState;
+        bool powered_off =3D arm_cpu->power_state =3D=3D PSCI_OFF;
+        WHV_REGISTER_VALUE ia;
+        HRESULT hr;
+
+        clean_whv_register_value(&ia);
+        hr =3D whp_dispatch.WHvGetVirtualProcessorRegisters(
+            whpx_global.partition, cpu->cpu_index, &name, 1, &ia);
+        if (SUCCEEDED(hr) &&
+            (ia.InternalActivity.IdleSuspend ||
+             ia.InternalActivity.HaltSuspend ||
+             ia.InternalActivity.StartupSuspend !=3D powered_off)) {
+            ia.InternalActivity.IdleSuspend =3D 0;
+            ia.InternalActivity.HaltSuspend =3D 0;
+            ia.InternalActivity.StartupSuspend =3D powered_off;
+            whpx_set_reg(cpu, WHvRegisterInternalActivityState, ia);
+        }
+    }
 }
=20
 static uint32_t max_vcpu_index;
@@ -789,8 +827,18 @@ int whpx_init_vcpu(CPUState *cpu)
         uint32_t key =3D whpx_sreg_match[i].key;
=20
         ri =3D get_arm_cp_reginfo(arm_cpu->cp_regs, key);
-        if (ri) {
-            assert(!(ri->type & ARM_CP_NO_RAW));
+        /*
+         * Only registers with raw backing store in CPUARMState can take p=
art
+         * in the cpreg list sync:
+         *
+         * - ARM_CP_NO_RAW registers have no state to sync at all;
+         *   write_cpustate_to_list() and write_list_to_cpustate() skip th=
em.
+         *
+         * - ARM_CP_CONST registers (the ID registers in the table above)
+         *   ignore raw writes and always read back the value the CPU mode=
l was
+         *   built with.
+         */
+        if (ri && !(ri->type & (ARM_CP_NO_RAW | ARM_CP_CONST))) {
             whpx_sreg_match[i].cp_idx =3D sregs_cnt;
             arm_cpu->cpreg_indexes[sregs_cnt++] =3D cpreg_to_kvm_id(key);
         } else {
--=20
2.55.0.vfs.0.3


