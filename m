Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F35B3CC6B29
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 08:49:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGue6-0005RI-VT; Wed, 14 Oct 2026 04:47:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1xGue1-0005Nz-Lf
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 04:47:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1xGudy-0004YQ-KW
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 04:47:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791967645;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TfLjsqPCvOp1hw/c9bS1s68B+V5vmUAntXKrnqamUFY=;
 b=IvY04w1iiFnbqAzdDJYMN119yOuxacxKdQ2jhRlgiOtsmg2E7bkTh9kxYgJQV5yfsz1JuB
 FTW9JnxrK2B5xMImF/ZgJ/6GQwTCkHMA3bpR/kgMMZ9OH1gcVslEWJCEJT0tDZaaRW3RHG
 2HM+9jgcDJxs0fG3i0yH1NMhb/J2Xuk=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-401-8gnq-wtWMx6E3V2r1BdQCg-1; Wed,
 14 Oct 2026 08:47:23 +0000
X-MC-Unique: 8gnq-wtWMx6E3V2r1BdQCg-1
X-Mimecast-MFC-AGG-ID: 8gnq-wtWMx6E3V2r1BdQCg_1791967642
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A8B4D180034C; Wed, 14 Oct 2026 08:47:22 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.48.67])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id F42251800446; Wed, 14 Oct 2026 08:47:19 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Jason Wang <jasowangio@gmail.com>, Alex Williamson <alex@shazbot.org>,
 Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [RFC PATCH v3 06/17] igb: Add VF post-load fixups for live migration
Date: Wed, 14 Oct 2026 10:46:44 +0200
Message-ID: <20261014084655.127254-7-clg@redhat.com>
In-Reply-To: <20261014084655.127254-1-clg@redhat.com>
References: <20261014084655.127254-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

After restoring per-VF register state, propagate the VTIVAR interrupt
vector routing to the shared IVAR0 register, which controls the
actual hardware interrupt routing for VF queues.

igb_core_vf_propagate_ivar() clears the IVAR0 entry before writing,
unlike igb_set_vtivar() which only OR-s. The existing write handler
could be refactored to use this helper in a follow-up.

AI-used-for: analysis, code (prototype)
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/net/igb_core.h      |  2 ++
 hw/net/igb_core.c      | 37 +++++++++++++++++++++++++++++++++++++
 hw/net/igb_migration.c |  3 +++
 3 files changed, 42 insertions(+)

diff --git a/hw/net/igb_core.h b/hw/net/igb_core.h
index 60724e2824ab..e066b9e029fd 100644
--- a/hw/net/igb_core.h
+++ b/hw/net/igb_core.h
@@ -145,4 +145,6 @@ igb_start_recv(IGBCore *core);
 
 IGBCore *igb_pf_get_core(void *pf);
 
+void igb_core_vf_propagate_ivar(IGBCore *core, uint16_t vfn);
+
 #endif
diff --git a/hw/net/igb_core.c b/hw/net/igb_core.c
index 2a4883907353..ef941ecb86b4 100644
--- a/hw/net/igb_core.c
+++ b/hw/net/igb_core.c
@@ -4552,3 +4552,40 @@ igb_core_post_load(IGBCore *core)
 
     return 0;
 }
+
+/*
+ * Propagate VTIVAR to IVAR0, which controls the actual hardware
+ * interrupt routing for VF queues.
+ */
+void igb_core_vf_propagate_ivar(IGBCore *core, uint16_t vfn)
+{
+    uint32_t vtivar = core->mac[VTIVAR + vfn];
+    int n;
+    uint8_t ent;
+    uint32_t mask;
+
+    n = igb_ivar_entry_rx(vfn);
+    mask = 0xffU << (8 * (n % 4));
+    if (vtivar & E1000_IVAR_VALID) {
+        ent = E1000_IVAR_VALID |
+              (24 - vfn * IGBVF_MSIX_VEC_NUM - (2 - (vtivar & 0x7)));
+        core->mac[IVAR0 + n / 4] =
+            (core->mac[IVAR0 + n / 4] & ~mask) |
+            ((uint32_t)ent << (8 * (n % 4)));
+    } else {
+        core->mac[IVAR0 + n / 4] &= ~mask;
+    }
+
+    n = igb_ivar_entry_tx(vfn);
+    mask = 0xffU << (8 * (n % 4));
+    ent = vtivar >> 8;
+    if (ent & E1000_IVAR_VALID) {
+        ent = E1000_IVAR_VALID |
+              (24 - vfn * IGBVF_MSIX_VEC_NUM - (2 - (ent & 0x7)));
+        core->mac[IVAR0 + n / 4] =
+            (core->mac[IVAR0 + n / 4] & ~mask) |
+            ((uint32_t)ent << (8 * (n % 4)));
+    } else {
+        core->mac[IVAR0 + n / 4] &= ~mask;
+    }
+}
diff --git a/hw/net/igb_migration.c b/hw/net/igb_migration.c
index 0c21a5e45f32..831515639bd6 100644
--- a/hw/net/igb_migration.c
+++ b/hw/net/igb_migration.c
@@ -253,6 +253,9 @@ static int igb_core_vf_load_state(IgbVfState *s, const void *buf, size_t size)
         }
     }
 
+    /* Propagate VTIVAR to IVAR0, skipped by direct core->mac[] write */
+    igb_core_vf_propagate_ivar(core, s->vfn);
+
     trace_igbvf_mig_load_state(s->vfn, (uint32_t)size);
     return 0;
 }
-- 
2.56.0


