Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 131ADC5DF82
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 17:59:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwO4s-0006df-Do; Tue, 18 Aug 2026 13:58:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dcook@microsoft.com>)
 id 1wwO4q-0006dF-S5
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 13:58:20 -0400
Received: from mail-southcentralusazlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c10d::3] helo=SN4PR0501CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dcook@microsoft.com>)
 id 1wwO4m-0004Iu-Pu
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 13:58:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L870oitevwxK4lDQEDPH+jZbckarAkfZyefOCwTQUqqyUkX638CReDICE4p2/1mU8noNYgSYYAGUTvsUo8irBiz8y1PF/zZew6lCJtTvQLI5ko0evLMyPAJ3ODztCQqMyTG7b7vIWwqyp6SGEuyTfAU5wrmTvpGssoKZd+P9il4qHGVmiWKTg4AQnhwiYVcTXdA2zexVI4IC83eyYjbx2OJIf0M4tOu4YEo2ORAa1lHnhYjG1+sS4XGKcO4uJKt7WKfe8Z3+YL2HlyAehm3MkTdoy/aRGrWn5YXmatoetvtivnMlUBZo4t8+x2TX50XVOpCGgdFfICWgBELM8l27lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=suMpn+cE8EhwnQxL13lqZofHUmVDhH3N541EskG8+Ck=;
 b=jcAqAZIYm/88nyi1t3evG8zG9JJ4eEOfXV1RB9d/BDPDk30trMuZjYtolqNcFCisC6o8vQIpzJTPaBhhyvU7uini/SPHqcnYI90KwWs5LJQHjXsFEKu37sUAiuPINrF2mDFIumSZplCYt3y0PfSqy/G4MqmhD4tOEEYvfQAZAjhtzdX8JZts4TCN5syXb+GOUesHF/bmGbIdeCvFQkh3NH97nklAoBwGfvyNEvvslqD5yFFI9e8x+rOPk7UNzy5AAq3c/CnEA4xIuYOnI1I43whZXGOWdDw5+WBchudLdBJ0ED7zJXjiDWQt03JITooKUgfdJ0DgxpAtgMWOqhCqGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=suMpn+cE8EhwnQxL13lqZofHUmVDhH3N541EskG8+Ck=;
 b=fTj3I6+NDkxY5+m9MV1x8U/ADhdTdSXdF5XOacONh7Wj6oJ82u7AkPYtPgkPl/ivv7m24/uRFh8WoRDee89M+vwx/CLK3JvU2NwxEBJVc+43B8779OGRS1ttzxQX2IPMRhcdEsjqIBcMOMVyMZl0SfcQBSOOBq3SXjADB7vAeiI=
Received: from LVXPR21MB7009.namprd21.prod.outlook.com (2603:10b6:408:37f::24)
 by LV4PR21MB6078.namprd21.prod.outlook.com (2603:10b6:408:357::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.1; Tue, 18 Aug
 2026 17:58:13 +0000
Received: from LVXPR21MB7009.namprd21.prod.outlook.com
 ([fe80::31c0:bc96:2ac3:64dc]) by LVXPR21MB7009.namprd21.prod.outlook.com
 ([fe80::31c0:bc96:2ac3:64dc%4]) with mapi id 15.21.0315.008; Tue, 18 Aug 2026
 17:58:13 +0000
From: "Doug Cook (WINDOWS)" <dcook@microsoft.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: Pedro d'Aquino Filocre F S Barbuda <pbarbuda@microsoft.com>, Mohamed
 Mediouni <mohamed@unpredictable.fr>
Subject: [PATCH] target/i386/whpx: handle processor reset
Thread-Topic: [PATCH] target/i386/whpx: handle processor reset
Thread-Index: Ad0vOwQLvQ2b1KrLT1yE4QXThu+Stw==
Date: Tue, 18 Aug 2026 17:58:12 +0000
Message-ID: <LVXPR21MB70093ED095A01CADE104F3A8ADA62@LVXPR21MB7009.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=13f2f15b-ef53-4dc6-b54f-0bedf9c41cdb;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2026-08-18T17:55:51Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LVXPR21MB7009:EE_|LV4PR21MB6078:EE_
x-ms-office365-filtering-correlation-id: 457962f2-7c47-4ddf-3044-08defd52459c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|38070700021|56012099006|6133799003|7146999003|11063799006|10067099003|18002099003;
x-microsoft-antispam-message-info: cRuuGTRNx3IBFxqmryZdkRgxHfmGwi5wDiV5dIs3COdJGs8gsCzk2mGV/aS+952q97c0vLld+4YbI/r3CAeGdSgN5GFvpbwLFhzDcrZo/Dx/AZXfY5FQi9DCvPOAhVfUawenlEnsREZqkH8oh+oTBqVA/5x8ozky+Mzs7h/jgN7AeinGlrwbLtgrnEmJgwaJqaHQaAsT/XPLuhwb8VLSU1ReQFB1I4iVEYoamViaTCNk0BEnP8ZH3VVsoILvp064NYd/zs1Q1+8JdUrZWK9Nry65OrRxQ1rylWLN8QJwDhNopwbLIkdHjIdIy+14l96+MpupCdhLSFyoXntHz/2aDduGUmdQrtdGk8s04Dtjvf8dmhSw0rgu6GVQaR+7N7p/w8wdmHsCNeZVp+lZrrpHhMkhlXFjISrNhewH7E+2/DwhuAidv0Wq2Z3yEGqicOHTe6rhj6iHCBO39PHXFRNMyuLTMdVC2qBrbdRQooqHlExQy23t4GyK5wrBhbpZUURgOaOVCBnT7N/NFfGMjgPxH++LNLwi+CJ384UBGKlGqYc/2iIIGz4sEy997UqDOQp8K14yBgGvQPZko3BcTJbWJl+LepUXFKnoA2IXSm+/6D+yZzE7vutpS86vKW1dKis4nFl4CnM+XrapXnnCiTBss/sIZLESyNczbDkuIieBRVXASjXWHV9G02MNh7PAbOr3smTeNaVec4tA4xSy7yrKAKgPrMZeziOFXQc50hD197c=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LVXPR21MB7009.namprd21.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(38070700021)(56012099006)(6133799003)(7146999003)(11063799006)(10067099003)(18002099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?nh330s/ql939In6x3D2FsEpBdq8w1U+zBDtxg+LzUeN1qdW862yBBF8ZZBaS?=
 =?us-ascii?Q?+dOvZ3wwTfRnekggmVInx6vkptQRUvoUhpJCq+T6ApzMQ6ENvOvrrfH3/8mF?=
 =?us-ascii?Q?HEJ8dd3UcrHrZC1OgjIgq/5p6AUnEaJtH8ihvRFalOpLvy0o9VX8JbQYnj1S?=
 =?us-ascii?Q?MA/IV7QMdFBtkZF8aanAD1fQ+RyU4lUdYFY5uttZG3qtf8WzP8WQe5anuf+J?=
 =?us-ascii?Q?MtahVpmWzAkj9L/8LU+z5C2wR0f4VKKp5aDyOt//d0F2FknhOj6Dn4x0SDSc?=
 =?us-ascii?Q?wassake/hUWPnw/sSNRk6Djt9GOiHfnUaP29NXtDbwbBwE/+aY7Cq5NGLWhK?=
 =?us-ascii?Q?zF9dJlFGA0XCbpNeWtarXpdufIk5au6z6+BZPnNmsSouqbc8PjqEBKXvRCD+?=
 =?us-ascii?Q?Vy8qv8CnUP+jGWYrQPQ/DVtwuzRl2u5/baRA256QV/mnMJYGizv8YAWxo7Ra?=
 =?us-ascii?Q?s+1S1E231y25YC25RENk59Zrhx1t6GdYnQDSAoyo37KjIj/4/+IFxys3wc7V?=
 =?us-ascii?Q?s4n0F+QaFV1HgyMQXbgwNd/uqQSsuCi5X+PYZaUTuIRn7yeVJQiNezHsXZwv?=
 =?us-ascii?Q?FEBFE2r8dAfXV0m27Ft2TXJgtdrGxXhJrc+XhEE2k5cgpCco9c6muQCmw3L4?=
 =?us-ascii?Q?mDZi4rFwZP7DP4VrUYLFD3rpnPm5E38jyOgg6fya5H7ZteOSufgcadmhiz4g?=
 =?us-ascii?Q?01H486noc+viLKGc7ePKTJZHnMu7grPLVos9kq8Cvyl4Eq6CFxuf7NWl/eZc?=
 =?us-ascii?Q?5bE8DXY6B+Lei6hZ5in5IG2qGsvX4d93xj9tk4l+ZFuEyYSh4RRVSUl3L++m?=
 =?us-ascii?Q?CPXJW4ogVdfPQbBoq4G1+YUNfeFC8HJoCOecCEHJMbuAGkGj46Xff37jk8pB?=
 =?us-ascii?Q?4ZXcrcKIgCx7qiOuPJ7yMw1ZgWsOwEy0wLB3wanml9gADMvExXGSPWkmazB8?=
 =?us-ascii?Q?+Lb3duWuKYx3IulPCNwK3Csb/8rL3q0XF6qkWKsVlkfSFAlTW6O78Z9KgEvM?=
 =?us-ascii?Q?M8ojbPFjBOegHcPR+Ted4vo29u42uYrv5VO2cIXKPy9GbC8E/A/hn4ZftZWn?=
 =?us-ascii?Q?dUK5Mt3f77V6xZQAiMIFCYDXX89vRURoSnIJgpID0DyK4v+PUOx3i86OblPG?=
 =?us-ascii?Q?H6JRzawKlBCNNWi6Irhmtc6lU2GHw5OVwLDAFziO/m7EgjoL3jNTiAdE6gPG?=
 =?us-ascii?Q?UL/duaKdkg7FLeVZVsoCbCG6Y4AIIzkwTzU28dWR8RUJdeA4PV2QYKzsk7Ss?=
 =?us-ascii?Q?b/wugQz7n7r0bTnWS6VvxHUtQv9W93cw/wH7W77TPPR93BekBUy1wdlKDwFp?=
 =?us-ascii?Q?XVf+KG75INm3HQF1cu/s6hDQjcR/h3MzkIKy4jy1dCfDuCTk5otSmNuTuGl1?=
 =?us-ascii?Q?s++jFNmlaoe8eoSJGV60IT6QExdLe8fcp4yPvM0QbwZQ/mAsOgLWcyOm36pM?=
 =?us-ascii?Q?eDUyIITKv9wvrRhIvudTe2VqrKcZlQ/fiRa5Dmvf/ygQAmMNAO0lbYJvVuD8?=
 =?us-ascii?Q?1rd0t4hbovkc+Q8OqZVCicf1WEJfQNRFZNfLrcJtIVuAetuDCLYHWCuKHCau?=
 =?us-ascii?Q?gnQ1mZQCig+bmwYTPKAKwQ6qEJKBI2FVba1ln9tDJDPTeKOlpmQ820R7qYgT?=
 =?us-ascii?Q?UeXlwx3Od48uE0vEpb5paNkkfejTq2oJAdVsGw3pnGHjNP8ITp0tMglBP5vV?=
 =?us-ascii?Q?N34FQJAYr5xCgEIziN7/pnGks5wCE9MzyjSmbkEbS7ij9iKn?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LVXPR21MB7009.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 457962f2-7c47-4ddf-3044-08defd52459c
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Aug 2026 17:58:13.0086 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7v355/TS4W/SO057uF9wU0k59+graXBha9xhtrt8v42dvvsMGha6EDvgUFfVUeIppB5zILPW7MI+ZNNSw9V4CQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV4PR21MB6078
Received-SPF: pass client-ip=2a01:111:f403:c10d::3;
 envelope-from=dcook@microsoft.com;
 helo=SN4PR0501CU005.outbound.protection.outlook.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.343,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

WHPX is not properly handling processor reset:

- Does not reset partition, so several registers (e.g. Hypercall,
  GuestOsId) carry values forward as "Locked" into the next session.
- Does not clear hypervisor-managed TSC deadline (live-lock).
- Does not re-arm the wait-for-SIPI trigger, so all CPUs start running
  immediately after reset.

Some firmware may tolerate this, but OVMF does not. Typical result is
that boot hangs or ends in triple-fault, e.g.

  qemu-system-x86_64: WHPX: Unexpected VP exit code 4

After this patch, I am able to boot to Windows desktop, reset, and boot
back to Windows desktop. Tried many times in sequence with no problems.
Used several different reset mechanisms (OS shutdown menu, external
"reset", watchdog reset) with no problems.

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/2402
Signed-off-by: Doug Cook <dcook@microsoft.com>
---
 target/i386/whpx/whpx-all.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
index 634d542821..54f9b50536 100644
--- a/target/i386/whpx/whpx-all.c
+++ b/target/i386/whpx/whpx-all.c
@@ -528,6 +528,35 @@ void whpx_set_registers(CPUState *cpu, WHPXStateLevel =
level)
=20
     assert(cpu_is_stopped(cpu) || qemu_cpu_is_self(cpu));
=20
+    /* Assumes that cpu_synchronize_all_post_reset() runs cpu 0 first. */
+    if (level =3D=3D WHPX_LEVEL_RESET_STATE && cpu->cpu_index =3D=3D 0) {
+        hr =3D whp_dispatch.WHvResetPartition(whpx->partition);
+        if (FAILED(hr)) {
+            error_report("WHPX: Failed to reset partition, hr=3D%08lx", hr=
);
+        }
+    }
+
+    /* Reset hypervisor-owned TSC deadline. */
+    if (level =3D=3D WHPX_LEVEL_RESET_STATE) {
+        WHV_REGISTER_VALUE tsc_deadline =3D {};
+
+        whpx_set_reg(cpu, WHvX64RegisterTscDeadline, tsc_deadline);
+    }
+
+    /*
+     * Re-arm partition's wait-for-SIPI state.
+     * whpx_vcpu_run() ignores cpu->halted, depends on SIPI for this.
+     * This must follow WHvResetPartition.
+     */
+    if (level =3D=3D WHPX_LEVEL_RESET_STATE && whpx_irqchip_in_kernel()) {
+        WHV_REGISTER_VALUE activity =3D {};
+
+        whpx_get_reg(cpu, WHvRegisterInternalActivityState, &activity);
+        activity.InternalActivity.StartupSuspend =3D !cpu_is_bsp(x86_cpu);
+        activity.InternalActivity.HaltSuspend =3D 0;
+        whpx_set_reg(cpu, WHvRegisterInternalActivityState, activity);
+    }
+
     /*
      * Following MSRs have side effects on the guest or are too heavy for
      * runtime. Limit them to full state update.
--=20
2.55.0.vfs.0.3


