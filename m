Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2241DC4451C
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2026 11:12:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wm8Nx-0000TG-0Y; Tue, 21 Jul 2026 07:11:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lvivier@redhat.com>)
 id 1wm8Nv-0000So-Iu
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 07:11:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lvivier@redhat.com>)
 id 1wm8Nu-0008Ut-8Y
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 07:11:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784632297;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HNTAABDOZtWY1Q1R8G5kMgHzvN7FJpupzAHEML/h8A4=;
 b=LFmgFOMhx18DkicG0um5JRLqkhfYPfpvOgIbC2VKjhH4ZR2Jb/lxFqgDbnKZF6tPhYf/rq
 4Gu9Xk7MFRj2mli5XCkiL0SGu+TSCRKy1MJyBn7/L6L5L7UfyN0v+YzpQOm7tF5da1O+UF
 dlAn3NGhl3ZHUEhMktir/9YNV1tzo7I=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-111-08e4cYRLOVuo-A-3HKyH4A-1; Tue,
 21 Jul 2026 07:11:36 -0400
X-MC-Unique: 08e4cYRLOVuo-A-3HKyH4A-1
X-Mimecast-MFC-AGG-ID: 08e4cYRLOVuo-A-3HKyH4A_1784632294
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C01A61809CA6; Tue, 21 Jul 2026 11:11:34 +0000 (UTC)
Received: from lenovo-t14s.redhat.corp
 (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id AD43F42B; Tue, 21 Jul 2026 11:11:32 +0000 (UTC)
From: Laurent Vivier <lvivier@redhat.com>
To: qemu-devel@nongnu.org
Cc: Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Jason Wang <jasowangio@gmail.com>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Laurent Vivier <lvivier@redhat.com>, qemu-stable@nongnu.org
Subject: [PATCH 2/2] hw/net/igb: recalculate rx_desc_len on migration load
Date: Tue, 21 Jul 2026 13:11:26 +0200
Message-ID: <20260721111126.3278244-3-lvivier@redhat.com>
In-Reply-To: <20260721111126.3278244-1-lvivier@redhat.com>
References: <20260721111126.3278244-1-lvivier@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: permerror client-ip=170.10.129.124;
 envelope-from=lvivier@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01, SPF_HELO_PASS=-0.001,
 T_SPF_PERMERROR=0.01 autolearn=ham autolearn_force=no
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

Same issue as e1000e: rx_desc_len is migrated from the stream but
can be computed from the register state. Recalculate it in post_load
to prevent a crafted migration stream from setting an invalid value.

Cc: qemu-stable@nongnu.org
Signed-off-by: Laurent Vivier <lvivier@redhat.com>
---
 hw/net/igb_core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/net/igb_core.c b/hw/net/igb_core.c
index 45d8fd795b84..2a4883907353 100644
--- a/hw/net/igb_core.c
+++ b/hw/net/igb_core.c
@@ -4548,5 +4548,7 @@ igb_core_post_load(IGBCore *core)
     igb_intrmgr_resume(core);
     igb_autoneg_resume(core);
 
+    igb_calc_rxdesclen(core);
+
     return 0;
 }
-- 
2.54.0


