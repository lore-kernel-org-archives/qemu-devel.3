Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FEDFC5DF81
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 00:31:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwqgd-0001Nm-UX; Wed, 19 Aug 2026 20:31:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dcook@microsoft.com>)
 id 1wwqgY-0001N9-07
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 20:31:10 -0400
Received: from mail-southcentralusazlp170130001.outbound.protection.outlook.com
 ([2a01:111:f403:c10c::1] helo=SA9PR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dcook@microsoft.com>)
 id 1wwqgW-0000HM-ED
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 20:31:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ut8aADJTnUWlUAHQzZAdgF3O1rNokSeu0g/EorGxLMowTIP3hdvsaZJ2qMKouenjDhTs77BB50Ez41lqHU9ZuQwVws8jmwWAOhdbFXmpIb74vVXKMpstawQIaqvA7j97kbv1iZ+DQjRGOuc6FfuJZ0vKMINohywN0lCRnzcyHgEcb18In12wkqOqfOqNzd1ZutpWcrFtQ4qlP+kSRI9bip6tsgDwo97oDhHVHApjROhGxPR9LU9m3UFodqJjaPEPQmwnzJeMhYg8wxBDmykvUjwpPkkHWuf5To41QRts2NqN38JBSEJcLuWbcbmSH5PUOAHdg346H/UjXF8roRNgLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pEwbrZ3XE8rTuG5fMJ6tBwDfY2sdiS19K3axfcoGhRM=;
 b=QjDMn4VKgEcOCWnCExIAsm7nCCFSk9QL2JTels68knDjWuCKIXEoF5/4CmomqtFpM4kjPvFaW3VIxkrh6Dal8UgkBJVi8CS05qSjIyY39EHCT7XomJtgcuJ4TmICnBd8Pzsa/weNbYyKVKuAh9sBPoN6jWvPwNYTxsONH1p92HAOCev1ekzLEh0EtcHlFXYq9ZruPk5fglfyfPHvzyEoFFR2xzGOQtqAh4aZXiOwcx+iXdjGlmqWeEXLGe3SkSc1lE0zIFEaZcBDiXsOc98RIbm9VouLW5N+3emRqBihiQWWsigTnzyYcCCMZeEV/gMMa9CfiSb2TybnQnyUbDpnRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pEwbrZ3XE8rTuG5fMJ6tBwDfY2sdiS19K3axfcoGhRM=;
 b=FTuHVw+bgUgnb58+TLEPAec4Hf3875Hme7AqFN9q1gnAN/gut5abQY1EIPItiMqsyPB24nl18YZGpudetsILLOdmQc8mAbc21qTkV/XsMVki5koSa2zPlGDBr2lY/FldKFfGubCsMRg3zWmROYZAnNHOGf2eDoKBb+789webDJ0=
Received: from LVXPR21MB7009.namprd21.prod.outlook.com (2603:10b6:408:37f::24)
 by LV5PR21MB4995.namprd21.prod.outlook.com (2603:10b6:408:2fb::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.0; Thu, 20 Aug
 2026 00:30:29 +0000
Received: from LVXPR21MB7009.namprd21.prod.outlook.com
 ([fe80::31c0:bc96:2ac3:64dc]) by LVXPR21MB7009.namprd21.prod.outlook.com
 ([fe80::31c0:bc96:2ac3:64dc%4]) with mapi id 15.21.0315.008; Thu, 20 Aug 2026
 00:30:29 +0000
From: "Doug Cook (WINDOWS)" <dcook@microsoft.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: Pedro d'Aquino Filocre F S Barbuda <pbarbuda@microsoft.com>,
 "mohamed@unpredictable.fr" <mohamed@unpredictable.fr>
Subject: [PATCH v2 1/3] target/arm/whpx: Don't try to sync ARM_CP_CONST
 registers
Thread-Topic: [PATCH v2 1/3] target/arm/whpx: Don't try to sync ARM_CP_CONST
 registers
Thread-Index: Ad0wOvX2qf7SkON1Qpqx4e66jheGCA==
Date: Thu, 20 Aug 2026 00:30:29 +0000
Message-ID: <LVXPR21MB7009C0007D22503C38FE053EADA42@LVXPR21MB7009.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=4c87db36-8898-4d5c-bfa6-b88494ebbafb;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2026-08-20T00:29:28Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LVXPR21MB7009:EE_|LV5PR21MB4995:EE_
x-ms-office365-filtering-correlation-id: aad5b25c-fb7d-4841-4b4e-08defe523d11
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|23010399003|38070700021|10067099003|7146999003|56012099006|11063799006|18002099003;
x-microsoft-antispam-message-info: gToJ87myTt4g2+3mUbBb39se5Bu0ttmFNmv8xQRvz9qrFCe9Tj9lzJmZLJEk7y/N4xwgWOU+ziwsfIoITQ+Equ0sH/R4ZhFzS8vRI6YVIkq/XrizR8ezV68ZIkVFwadPxHaVDqRoYgLmUbbL9ZPoxiUemUo6h7t+m6SgR5109ZeVOKnJLpe06qm42+tHZmv7DYVy6Ol6MNEdVvvKu12/ZEYxtHKyashsR4MIuY/qIVLG5cNr0hBbUl6tb5Gul9Vlmv+PEAGcQAJBMlykbTqO/IKDPpEFJFYPrzWnAic+7FbkilE/2vxRH1y/RiVoqGYQr99a/CxO9QJGb9+Ax2gjku/ZZdvMkeqlJR3cewRafMHveD4134jrq91Vcw8L/uSgworkj5kt0MXDLM+7w0+lu0lieg39ulU85WKqyqIUrhhgT+4dbPhHjTSC+CeB5TbrqcTA+jsuUh3TpLRV81hpfx73ZCymh9OpkWfO2zyxNY2Sv8m8/ruMRykG7HxyDlcUIJ29WGwtHluABrFNehGu44Olx0lLdNWG5rxVWg2QynwXxcq0RmFex43ai3+LL+LeXqWDzplvEb2K7gUhuI9cZU61y6/ceJe9wZ1x1HCvZ57Rwpjy/C5ON5xyRrt1keqNiR/wK7rQZn4jh+QubrVorGsbl0eTFE0V3a8q6mTZWthiEjVvVZw95TJo9jmA1AO0M5dshW8mrBHir0cdY9rzdmczRiISF4hVjD2B7Fvl53U=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LVXPR21MB7009.namprd21.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(38070700021)(10067099003)(7146999003)(56012099006)(11063799006)(18002099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?HFwnazT+hxv+fOp+lHSyqoFyF58N6MnDo9GjZPfNckUjyq5yjR4KhlrnHz7b?=
 =?us-ascii?Q?e7Ai1AyXhlm9k5vsA9+AFgscImtP0kOJxt6NzObGdbCJjrs1NxFminQFIo+T?=
 =?us-ascii?Q?b6ohtH2YbLUkGA88pINtmqNjpL5VJDNr0EfpEj8yIPL/Wg17wH2EQXoEXqoa?=
 =?us-ascii?Q?7rSqZTFGaR0KjjtMj0xINi+xulF+Bw71JsqRQ1mceJNQEdJFOT511MaEUB6v?=
 =?us-ascii?Q?PArJ3pM7IMwjTk6+San8y+72KwxprbBAb5TUSN8hkGCM+LY1FQq1VN4SHLDu?=
 =?us-ascii?Q?PrfiI3bcMMeqYFC40LNn/Exg00/Nse1PChTXltFzOeeEwPO8H/cTzp/94veq?=
 =?us-ascii?Q?ujyOkc1rTEV2ulcMsuOKMHUFX58ePoUNnjFIm44If2RdX1vb3PMFykfLxVAg?=
 =?us-ascii?Q?hO+BZ0JNAQqVf7TdPvuyhEk/H4AZJ0JGeCbMjfS/SrtF71xXM4tTfo/l7Yhv?=
 =?us-ascii?Q?BNAuzbUqIvGdJgiRF6ISlBVP8mA+8v5qpd8QGyEhLuPl6a0nRjqk4T+fSQ4W?=
 =?us-ascii?Q?Ripob0VLua3zL4KGgIKtujm3IeoMOh3Kxq22dvx4BhdBdjWgSRVFiDBu/5oX?=
 =?us-ascii?Q?8W7uPgGPDQXKyLKmVw8226m4Kxc6ZnwsZHlyopGsEihW/sMPSuXjmbJJGI56?=
 =?us-ascii?Q?6XcgXmIDuwhBbTPYWAce3xV1TQvBTar4ayaZFQzixTngBzyDlJdpXA/2Slj3?=
 =?us-ascii?Q?SuX6doAWEDl8WmUactalSBzzN4G6GI/rZKRaUSt6CqNtyt+R3y3c+CLYwYzs?=
 =?us-ascii?Q?QTHWcuQAgMAczDGaHWuAuLFPGB/o4Hz9AqtlM8K3k9Ddvb83ixz7hCsd76gH?=
 =?us-ascii?Q?ju0hKGdO4dCNZdvvl3cCgwp5LdurleEyb22EVtLVVLx+E6bTsW7bU4jXKEZ4?=
 =?us-ascii?Q?tG4FzS1kI80jPRKvHzT2+FhrYFY0E1mJF3k7PDwIfzsaiprTx2P6zBu+AwnA?=
 =?us-ascii?Q?AM2fjrzO7MXkcBUAoxiQ/tYkC7xPteZCSiUnuBf/WEJK2hldnuTfUtAhOq0W?=
 =?us-ascii?Q?XteMc7MQFz43G4wwy/EzxJIZE0lR4SNiRX71T+YfPiWxoXGSe9CkgSkltW7i?=
 =?us-ascii?Q?soHAk2XRppvG+VkQbcBzje8KfwvB3mSTZr12PQx8woGky06ZVvd5lG/kL+wW?=
 =?us-ascii?Q?TIsJsMYRRHGk/5+uk+vJUbkCGkDM6lFtS3YHQVz54WYy47g0X+zvup3FAeuL?=
 =?us-ascii?Q?ZZFvGglv4vkmKBCGtqDftQiHKAoRM73PDojaYZzYBHmPIoghyipPo7uO6uP3?=
 =?us-ascii?Q?0iL5U58f02LfGOnv5pC3PYKbnsDLdPWOUNYnjo8KoysIcK07roW81c4w5UJo?=
 =?us-ascii?Q?A6uLc5OSHGNdP9pruLeZ1OK5UljkHSts1Z/1Eg/iu2Is43oIakxDpeiWMZe3?=
 =?us-ascii?Q?85Df7AMirniE9L7BEjw1IyEsnEAJcYd/GEo07bv4v4IklXnSznJ+JFPaPIVg?=
 =?us-ascii?Q?u9jRkBB+a1EKJcGy6KvFW9lYWiVQQdTP/CwZRgOho60ydXbC//VMGM1536cN?=
 =?us-ascii?Q?zD6y8W+LEuYosybJ+DFLqhIthYbY+4sz0sh7Kw+hxn32N8QsYLJo0Jq5h3sT?=
 =?us-ascii?Q?K/KG3xFZ+5GYKAFajwwuK9eQc5APxAss8Tgq5dlFDN8ltReYave+0hbdVw0U?=
 =?us-ascii?Q?2bdwW54sYxE3dCsKOf8GmAfSnlst+6/ZYHuL07X3/Qo177Mquriv10Jq/5YT?=
 =?us-ascii?Q?AJ3xQphvvR+6jf9AR4xrw87XaTnz4TKrnsFPou2lSDk3Ge+M?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LVXPR21MB7009.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aad5b25c-fb7d-4841-4b4e-08defe523d11
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Aug 2026 00:30:29.8298 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Hl/XX6Pt/aUeMCg19Ix+AZUYk8oRZN2XeXa3MueMjnuvfnYPQBX4IHNry9IRO6ujA/v5DjDOMTUt1b8hl0SWZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV5PR21MB4995
Received-SPF: pass client-ip=2a01:111:f403:c10c::1;
 envelope-from=dcook@microsoft.com;
 helo=SA9PR02CU001.outbound.protection.outlook.com
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.341,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, SPF_HELO_PASS=-0.001,
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

ARM_CP_CONST registers ignore writes, so readback assertion fails.

Not asserting now because all entries in the whpx_sreg_match table are
invalid. Needs to be fixed now so that we can fix the table entries.

Signed-off-by: Doug Cook <dcook@microsoft.com>
---
 target/arm/whpx/whpx-all.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/target/arm/whpx/whpx-all.c b/target/arm/whpx/whpx-all.c
index 00a5de8cdc..9a5a575b5e 100644
--- a/target/arm/whpx/whpx-all.c
+++ b/target/arm/whpx/whpx-all.c
@@ -223,6 +223,8 @@ static struct whpx_sreg_match whpx_sreg_match[] =3D {
     { WHvArm64RegisterMpidrEl1, ENCODE_AA64_CP_REG(0, 0, 3, 0, 5) },
     { WHvArm64RegisterIdPfr0El1, ENCODE_AA64_CP_REG(0, 4, 3, 0, 0) },
 #endif
+#ifdef SYNC_CONST_ID_REGS
+    /* ID registers are ARM_CP_CONST (writes ignored).  */
     { WHvArm64RegisterIdAa64Pfr1El1, ENCODE_AA64_CP_REG(0, 4, 3, 0, 1), tr=
ue },
     { WHvArm64RegisterIdAa64Dfr0El1, ENCODE_AA64_CP_REG(0, 5, 3, 0, 0), tr=
ue },
     { WHvArm64RegisterIdAa64Dfr1El1, ENCODE_AA64_CP_REG(0, 5, 3, 0, 1), tr=
ue },
@@ -235,6 +237,7 @@ static struct whpx_sreg_match whpx_sreg_match[] =3D {
     { WHvArm64RegisterIdAa64Mmfr1El1, ENCODE_AA64_CP_REG(0, 7, 3, 0, 1), t=
rue },
     { WHvArm64RegisterIdAa64Mmfr2El1, ENCODE_AA64_CP_REG(0, 7, 3, 0, 2), t=
rue },
     { WHvArm64RegisterIdAa64Mmfr3El1, ENCODE_AA64_CP_REG(0, 7, 3, 0, 3), t=
rue },
+#endif
=20
     { WHvArm64RegisterMdscrEl1, ENCODE_AA64_CP_REG(0, 2, 2, 0, 2) },
     { WHvArm64RegisterSctlrEl1, ENCODE_AA64_CP_REG(1, 0, 3, 0, 0) },
@@ -790,7 +793,7 @@ int whpx_init_vcpu(CPUState *cpu)
=20
         ri =3D get_arm_cp_reginfo(arm_cpu->cp_regs, key);
         if (ri) {
-            assert(!(ri->type & ARM_CP_NO_RAW));
+            assert(!(ri->type & (ARM_CP_NO_RAW | ARM_CP_CONST)));
             whpx_sreg_match[i].cp_idx =3D sregs_cnt;
             arm_cpu->cpreg_indexes[sregs_cnt++] =3D cpreg_to_kvm_id(key);
         } else {
--=20
2.55.0.vfs.0.3

