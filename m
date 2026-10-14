Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CB35CC6B1A
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 08:49:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGuf5-0006EF-S6; Wed, 14 Oct 2026 04:48:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1xGueQ-0005dp-W4
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 04:47:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1xGueP-0004aU-5m
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 04:47:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791967672;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bBipUCO0pIVGluDuzY5tUM9V4yAIVJuvdld12lAMyio=;
 b=SSWD/IxxUy/oDfBfeBSPUZzctXHuyoK9Jg1Lf6zT6syKv5BFz2TAYOxzRneFk9y3ejWhI7
 dvl6Ou4AwqGjoKel1iENdltaBUxwfmVZqix2K6rqdZUOyDTyKGnEJPGv6DdbymX3hbF5AG
 k/Q8obvw1X9Ar15ZMXRWlTihwhFM0Kw=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-17-GWTiqPw4P46DtcwJntDVJA-1; Wed,
 14 Oct 2026 08:47:47 +0000
X-MC-Unique: GWTiqPw4P46DtcwJntDVJA-1
X-Mimecast-MFC-AGG-ID: GWTiqPw4P46DtcwJntDVJA_1791967666
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0717619560B3; Wed, 14 Oct 2026 08:47:46 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.48.67])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id CD6411800345; Wed, 14 Oct 2026 08:47:43 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Jason Wang <jasowangio@gmail.com>, Alex Williamson <alex@shazbot.org>,
 Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [RFC PATCH v3 14/17] igb: Re-raise pending VF interrupt causes on
 unquiesce
Date: Wed, 14 Oct 2026 10:46:52 +0200
Message-ID: <20261014084655.127254-15-clg@redhat.com>
In-Reply-To: <20261014084655.127254-1-clg@redhat.com>
References: <20261014084655.127254-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 10
X-Spam_score: 1.0
X-Spam_bar: +
X-Spam_report: (1.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

After restoring VFRE/VFTE, the VF's RX and TX rings may be stalled
because the guest driver is waiting for an interrupt that was pending
at the time of migration.

Add igb_core_vf_raise_causes() to re-inject pending EICR causes on
unquiesce, resuming interrupt delivery to the guest and kicking the
RX and TX rings.

AI-used-for: analysis, code (prototype)
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/net/igb_core.h      |  1 +
 hw/net/igb_core.c      | 14 ++++++++++++++
 hw/net/igb_migration.c |  5 +++++
 3 files changed, 20 insertions(+)

diff --git a/hw/net/igb_core.h b/hw/net/igb_core.h
index 5a15433da2c2..75780f68dffb 100644
--- a/hw/net/igb_core.h
+++ b/hw/net/igb_core.h
@@ -150,5 +150,6 @@ igb_start_recv(IGBCore *core);
 IGBCore *igb_pf_get_core(void *pf);
 
 void igb_core_vf_propagate_ivar(IGBCore *core, uint16_t vfn);
+void igb_core_vf_raise_causes(IGBCore *core, uint16_t vfn);
 
 #endif
diff --git a/hw/net/igb_core.c b/hw/net/igb_core.c
index 452bae06ee92..09e4e3926905 100644
--- a/hw/net/igb_core.c
+++ b/hw/net/igb_core.c
@@ -4603,3 +4603,17 @@ void igb_core_vf_propagate_ivar(IGBCore *core, uint16_t vfn)
         core->mac[IVAR0 + n / 4] &= ~mask;
     }
 }
+
+/*
+ * Raise pending VF interrupt causes without re-propagating masks.
+ */
+void igb_core_vf_raise_causes(IGBCore *core, uint16_t vfn)
+{
+    uint32_t shift = 22 - vfn * IGBVF_MSIX_VEC_NUM;
+    uint32_t pvt_idx = PVTEICR0 + vfn * 0x40;
+    uint32_t causes = (core->mac[pvt_idx] & 0x7) << shift;
+
+    if (causes) {
+        igb_set_eics(core, EICS, causes);
+    }
+}
diff --git a/hw/net/igb_migration.c b/hw/net/igb_migration.c
index 72f01beb2ad0..ab80dbb5c6c6 100644
--- a/hw/net/igb_migration.c
+++ b/hw/net/igb_migration.c
@@ -1291,6 +1291,11 @@ static void igb_core_vf_unquiesce(IgbVfState *s)
     igb_core_vf_restore_irqs(core, s->vfn,
                              ms->mig_saved_eims, ms->mig_saved_eiac,
                              ms->mig_saved_eiam);
+
+    /* Re-inject pending VF interrupt causes to resume RX/TX ring polling */
+    if (re || te) {
+        igb_core_vf_raise_causes(core, s->vfn);
+    }
 }
 
 static uint8_t igbvf_mig_set_state(IgbVfState *s, uint32_t new_state)
-- 
2.56.0


