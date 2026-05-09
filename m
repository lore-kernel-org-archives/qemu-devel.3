Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C07BCD3447
	for <qemu-devel@archiver.kernel.org>; Sat,  9 May 2026 02:47:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wLXi0-0007tF-Dg; Fri, 08 May 2026 22:46:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <guobin@linux.alibaba.com>)
 id 1wLXhj-0007sT-8O
 for qemu-devel@nongnu.org; Fri, 08 May 2026 22:46:16 -0400
Received: from out30-112.freemail.mail.aliyun.com ([115.124.30.112])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <guobin@linux.alibaba.com>)
 id 1wLXhg-0003BE-LX
 for qemu-devel@nongnu.org; Fri, 08 May 2026 22:46:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1778294755; h=From:To:Subject:Date:Message-ID:MIME-Version;
 bh=6sbYWlJN+z4hkTQrsoN7IxSNEeSI4CJC1PosPUP5cnY=;
 b=ca/Dp5AaFaqk+Hhadttqx0NBoSLBGzJXAoCUOC76sSZTOE0R7JItXoZJq+0rDecG4zVpLxVvRoECV189BxUQLieUDt11AvIwnswd3/2i8xaaGCt8HI/YPgjn3ENhXUoqIGlUdRGDiEVkNk/RASVVjYTNCsRLyfMD8bSWsZ0+2Rc=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R161e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=maildocker-contentspam033037026112;
 MF=guobin@linux.alibaba.com; NM=1; PH=DS; RN=3; SR=0;
 TI=SMTPD_---0X2ZCFg-_1778294749; 
Received: from localhost(mailfrom:guobin@linux.alibaba.com
 fp:SMTPD_---0X2ZCFg-_1778294749 cluster:ay36) by smtp.aliyun-inc.com;
 Sat, 09 May 2026 10:45:54 +0800
From: Bin Guo <guobin@linux.alibaba.com>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com,
	kvm@vger.kernel.org
Subject: [PATCH 1/2] kvm: remove redundant check in kvm_close
Date: Sat,  9 May 2026 10:45:38 +0800
Message-ID: <20260509024539.90998-2-guobin@linux.alibaba.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260509024539.90998-1-guobin@linux.alibaba.com>
References: <20260509024539.90998-1-guobin@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=115.124.30.112;
 envelope-from=guobin@linux.alibaba.com;
 helo=out30-112.freemail.mail.aliyun.com
X-Spam_score_int: -174
X-Spam_score: -17.5
X-Spam_bar: -----------------
X-Spam_report: (-17.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, ENV_AND_HDR_SPF_MATCH=-0.5,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=ham autolearn_force=no
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

In kvm_close(), the condition `!kvm_state || kvm_state->fd == -1` is
checked at the function entry, causing an early return if either is
true. Later in the function, the same condition is redundantly checked
again before closing vmfd and fd.

Remove the redundant second check since it can never be true at that
point.

Signed-off-by: Bin Guo <guobin@linux.alibaba.com>
---
 accel/kvm/kvm-all.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 92af42503b..70bc2c86a2 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -769,12 +769,11 @@ void kvm_close(void)
         cpu->kvm_vcpu_stats_fd = -1;
     }
 
-    if (kvm_state && kvm_state->fd != -1) {
-        close(kvm_state->vmfd);
-        kvm_state->vmfd = -1;
-        close(kvm_state->fd);
-        kvm_state->fd = -1;
-    }
+    close(kvm_state->vmfd);
+    kvm_state->vmfd = -1;
+    close(kvm_state->fd);
+    kvm_state->fd = -1;
+
     kvm_state = NULL;
 }
 
-- 
2.50.1 (Apple Git-155)


