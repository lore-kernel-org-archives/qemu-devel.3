Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A24BFC6197
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Sep 2024 06:14:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1spM2i-00086V-3K; Sat, 14 Sep 2024 02:14:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1spM2g-00081x-67
 for qemu-devel@nongnu.org; Sat, 14 Sep 2024 02:13:58 -0400
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1spM2d-0000uw-Lf
 for qemu-devel@nongnu.org; Sat, 14 Sep 2024 02:13:57 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id 8AA3AA40241;
 Sat, 14 Sep 2024 06:13:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB309C4CEC0;
 Sat, 14 Sep 2024 06:13:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1726294433;
 bh=WkMRajvi3DCu8ik/79aRicilu7jypqPMaL43Kk8gHHo=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=gT1T3Y9QqE/ne0QamJVQbVZjny6f5v709D8ZBo/G2u26VToEw/UL7zODVW935LUR+
 pYpzfYYqqVdeUe9UVPwe2l7DvaTZxgaf55lcqZE66v0bMBqWPupIdXfUp0wWH0oSmv
 DtSfqi09dFso25uc03k5Rnpf4Wk+6kAkEfj7U0cK2/PEtohx3cGWWLiOxtrWGkMv1d
 OwB6slwHmOB5wR/89Kft5jbSkqjRmzJ/B0wj554pWQgn3tWKGvIYPuTMgfavIi/gZu
 utngWJQ6UEq6xuMwk0XDKRxdDZuqowYIbUP9zmiPKghJ5sExx17QLkL6rNnuEeTH7s
 8qcZHw76Q1p5w==
Received: from mchehab by mail.kernel.org with local (Exim 4.98)
 (envelope-from <mchehab+huawei@kernel.org>)
 id 1spM2Z-00000003V5W-49AL; Sat, 14 Sep 2024 08:13:51 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Igor Mammedov <imammedo@redhat.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Shiju Jose <shiju.jose@huawei.com>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 linux-kernel@vger.kernel.org, qemu-devel@nongnu.org
Subject: [PATCH v10 02/21] acpi/generic_event_device: Update GHES migration to
 cover hest addr
Date: Sat, 14 Sep 2024 08:13:23 +0200
Message-ID: <bed4b2da51e0c894cc255f712b67e2e57295d826.1726293808.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <cover.1726293808.git.mchehab+huawei@kernel.org>
References: <cover.1726293808.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2604:1380:45d1:ec00::3;
 envelope-from=mchehab+huawei@kernel.org; helo=nyc.source.kernel.org
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.147,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The GHES migration logic at GED should now support HEST table
location too.

Increase migration version and change needed to check for both
ghes_addr_le and hest_addr_le.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 hw/acpi/generic_event_device.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/hw/acpi/generic_event_device.c b/hw/acpi/generic_event_device.c
index 15b4c3ebbf24..4e5e387ee2df 100644
--- a/hw/acpi/generic_event_device.c
+++ b/hw/acpi/generic_event_device.c
@@ -343,10 +343,11 @@ static const VMStateDescription vmstate_ged_state = {
 
 static const VMStateDescription vmstate_ghes = {
     .name = "acpi-ghes",
-    .version_id = 1,
-    .minimum_version_id = 1,
+    .version_id = 2,
+    .minimum_version_id = 2,
     .fields = (const VMStateField[]) {
         VMSTATE_UINT64(ghes_addr_le, AcpiGhesState),
+        VMSTATE_UINT64(hest_addr_le, AcpiGhesState),
         VMSTATE_END_OF_LIST()
     },
 };
@@ -354,13 +355,13 @@ static const VMStateDescription vmstate_ghes = {
 static bool ghes_needed(void *opaque)
 {
     AcpiGedState *s = opaque;
-    return s->ghes_state.ghes_addr_le;
+    return s->ghes_state.ghes_addr_le && s->ghes_state.hest_addr_le;
 }
 
 static const VMStateDescription vmstate_ghes_state = {
     .name = "acpi-ged/ghes",
-    .version_id = 1,
-    .minimum_version_id = 1,
+    .version_id = 2,
+    .minimum_version_id = 2,
     .needed = ghes_needed,
     .fields = (const VMStateField[]) {
         VMSTATE_STRUCT(ghes_state, AcpiGedState, 1,
-- 
2.46.0


