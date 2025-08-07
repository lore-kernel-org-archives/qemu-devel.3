Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1C2DC87FCA
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Aug 2025 11:08:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ujyTx-0006Vc-Jw; Thu, 07 Aug 2025 07:08:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lvivier@redhat.com>)
 id 1ujyTs-0006U8-AO
 for qemu-devel@nongnu.org; Thu, 07 Aug 2025 07:08:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lvivier@redhat.com>)
 id 1ujyTq-0002l2-6P
 for qemu-devel@nongnu.org; Thu, 07 Aug 2025 07:08:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1754564896;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=OVQuqQkDCrAEtP1NUvF6Ft2auZYGJFgIG9AxiJ93gew=;
 b=CT1ozapiQDpQEEWVJveC5CHsl60Kw5ZV6ze/rQyDnJyLdQmjltMqfMIiHua+NMJE2eU9f6
 FCWF+pDBLtD1kYehUVRhQzESpKH/iQgLuQNtf5XTK1+nk0Oyuc7PsiD2KmzqLykCaW+os7
 4Ga3Agnmp6WyWCjnYIlXr4yJj5y45lk=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-282-HAB6_nBqPEWDbrfcjGg1PQ-1; Thu,
 07 Aug 2025 07:08:12 -0400
X-MC-Unique: HAB6_nBqPEWDbrfcjGg1PQ-1
X-Mimecast-MFC-AGG-ID: HAB6_nBqPEWDbrfcjGg1PQ_1754564891
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7656019560AF; Thu,  7 Aug 2025 11:08:11 +0000 (UTC)
Received: from lenovo-t14s.redhat.com (unknown [10.45.225.81])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A9E0F3001452; Thu,  7 Aug 2025 11:08:08 +0000 (UTC)
From: Laurent Vivier <lvivier@redhat.com>
To: qemu-devel@nongnu.org
Cc: Jason Wang <jasowang@redhat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Laurent Vivier <lvivier@redhat.com>
Subject: [PATCH v2] e1000e: Prevent crash from legacy interrupt firing after
 MSI-X enable
Date: Thu,  7 Aug 2025 13:08:06 +0200
Message-ID: <20250807110806.409065-1-lvivier@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=lvivier@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

A race condition between guest driver actions and QEMU timers can lead
to an assertion failure when the guest switches the e1000e from legacy
interrupt mode to MSI-X. If a legacy interrupt delay timer (TIDV or
RDTR) is active, but the guest enables MSI-X before the timer fires,
the pending interrupt cause can trigger an assert in
e1000e_intmgr_collect_delayed_causes().

This patch removes the assertion and executes the code that clears the
pending legacy causes. This change is safe and introduces no unintended
behavioral side effects, as it only alters a state that previously led
to termination.

- when core->delayed_causes == 0 the function was already a no-op and
  remains so.

- when core->delayed_causes != 0 the function would previously
  crash due to the assertion failure. The patch now defines a safe
  outcome by clearing the cause and returning. Since behavior after
  the assertion never existed, this simply corrects the crash.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1863
Suggested-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Signed-off-by: Laurent Vivier <lvivier@redhat.com>
---
 hw/net/e1000e_core.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/hw/net/e1000e_core.c b/hw/net/e1000e_core.c
index 24138587905b..06657bb3ac5c 100644
--- a/hw/net/e1000e_core.c
+++ b/hw/net/e1000e_core.c
@@ -341,11 +341,6 @@ e1000e_intmgr_collect_delayed_causes(E1000ECore *core)
 {
     uint32_t res;
 
-    if (msix_enabled(core->owner)) {
-        assert(core->delayed_causes == 0);
-        return 0;
-    }
-
     res = core->delayed_causes;
     core->delayed_causes = 0;
 
-- 
2.49.0


