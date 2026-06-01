Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B431CD6E55
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2026 20:59:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wU9j4-0001ng-Gk; Mon, 01 Jun 2026 16:59:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wU9j2-0001nV-LB
 for qemu-devel@nongnu.org; Mon, 01 Jun 2026 16:59:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wU9j0-0004zt-Vi
 for qemu-devel@nongnu.org; Mon, 01 Jun 2026 16:59:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780347545;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=IM5a/KeDxm3nVvcZ8LYZX+YAtYBxczLgt64FxNLfqiI=;
 b=ahnynGC+svF3qVya18mW7wIHO0MgGv0huX11i0WVqJKF8n/PNAPtTIOGJXNA/eMtXkozfI
 RiQRGNsF2bgfrT1gnlrMluKvVx5u+6AweBeqLpfF32IMi7xacr0fxIucDuvalQ8333YNq0
 PGx90nFyv5cZI2nwNk+G+VQXjEv8JSU=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-394-q7_1tQ-aOiuOfsUbA5QkPw-1; Mon, 01 Jun 2026 16:59:03 -0400
X-MC-Unique: q7_1tQ-aOiuOfsUbA5QkPw-1
X-Mimecast-MFC-AGG-ID: q7_1tQ-aOiuOfsUbA5QkPw_1780347543
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-914c8954923so1666643185a.1
 for <qemu-devel@nongnu.org>; Mon, 01 Jun 2026 13:59:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1780347543; x=1780952343; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=IM5a/KeDxm3nVvcZ8LYZX+YAtYBxczLgt64FxNLfqiI=;
 b=gTJ/94cZ3668B1sexOZt2sIgy0rNnfH2nz4hES1X09XUa2X03lGxyZGEi7A7LTP0qD
 VOaDfdDHtRyC7mPjeLyDCVwMXO8+vz5W/yfxcTshnrGvCJS0OvjmyvEjf8Szw0WT6tfE
 WdQ0ZtbSMMrPqinHPUEQU3gT/GW2zcV6Ra5qlaKnq6cW4wa+XOkQOJXinOXaCX8X5+Ie
 I3JsWXWiT8pkROjPzo/2eaQ4v7jn2b3Qs+fMoRpRs0FL3cnhY0vP3lZL/2jNg6vQ8WCy
 OlptCNFcC/Ne9U2Y41Xce+7NFxJ7Hbj0ycV3PLRvDaQZmPLXxX8pOH928aVwwlzAvzlm
 /kWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780347543; x=1780952343;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IM5a/KeDxm3nVvcZ8LYZX+YAtYBxczLgt64FxNLfqiI=;
 b=ZF2M2/Iu5B9TGAoLpmXeFEJ9sScrmFJUzdWIHDWuQeqLLvqSZY2C4TN/oMsioU/BkV
 u2K2YI9jdcsRwRgc+8DmmgJsv+lZSaTpZuk3nyo+PtOtzYRN1uZmN0dtGkVIzqqnKqPr
 BVBxshkS50gPN8DvIDyIYmnb6XRd6CyLV+1hGzXxtcOnHullYVpnvYIju/aXCmTQDdkF
 AdceSxoWQiQBMlt28zB0c9bFvbEixXEHIY3xeyoD9w0kIeJkqNQFU+jy4Sg2TLRLLCjM
 +KUCkp+HI9jMnHgx03VXUPoVZsKKcVLHMqcp4qnTsu4KRaadJqFiETp6r9VYR30vjLH0
 7opQ==
X-Gm-Message-State: AOJu0YyzDS7Md1E/pYOBoo6fOXS42qv0+wTBizR2WHgJB9M15y+a5fl8
 P/o4Qv5LRbSI9jhVgQoSvh0Vi/KlD8WAiArX0aq3jXTiC/gyqAf4t1ewz0byFOAMRK7vGetybyR
 jgtjYXcqGTrlakeDLWNdPi9WdakSIh0LD5A9ZhFGFI7ow9gTD6K5b7DAWQGyZHN6iW7hu055aa1
 grrrGxFEuNiNlsvhMM22svLG/yGGhcnS9Kkrm3xQ==
X-Gm-Gg: Acq92OEzk9ikKElbzHaE3EWFg2ukIN8HKAbBYskP7N2z1K3HZXt2TIb/XnA9BL7LUIT
 Re4uOkt8CDZ3IRiNGkaSPmXboY5GiYw4pLLg2wQcZJLU3K8Ycrf7obhFkbrIcMeABapvzVBd74b
 2ydcG4TtcDlkT6EK8QaHWEMjqoER0zWdZk16kBbvM5PI7etuJG2yTD+Vnmvh8lQpMUUBNH+T4dk
 WkUU3Pjv3q/hbYbAKiCkHYTEoWi2rS7YMbm5b0JP59RghAdybBmZVl39q/h1yq2iijorYb/WBVj
 ypXlF2jjoaqqDiQyDwic/0rHjmlIZ8VFhCdczT2X832E4PN7tX1kxgMUkmO2J/aqputYs9xY7t2
 DGosSs0qriYx2IUBV0jNE8e8=
X-Received: by 2002:a05:620a:2990:b0:908:e262:52c3 with SMTP id
 af79cd13be357-9153dc692damr1972879885a.46.1780347543316; 
 Mon, 01 Jun 2026 13:59:03 -0700 (PDT)
X-Received: by 2002:a05:620a:2990:b0:908:e262:52c3 with SMTP id
 af79cd13be357-9153dc692damr1972874785a.46.1780347542767; 
 Mon, 01 Jun 2026 13:59:02 -0700 (PDT)
Received: from x1.com ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-91566f4abf3sm271304885a.27.2026.06.01.13.59.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jun 2026 13:59:02 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Fabiano Rosas <farosas@suse.de>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Subject: [PATCH] memory/ramblock: Fix clear of mru_block on possible race
 condition
Date: Mon,  1 Jun 2026 16:59:00 -0400
Message-ID: <20260601205900.1067714-1-peterx@redhat.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The race condition was not reported in any real bug, but I found it while
reviewing some relevant chnages from Akihiko [1].  It's not clear if
there's any way to reproduce it, so far it's only theoretical.  Hence
there's also no Fixes tag attached.  There's also no need to copy stable
until we have a solid reproducer.

Currently, mru_block might still points to ramblocks that are removed if
below race condition happens:

  Reader A                              Writer
  --------                              ------
  rcu_read_lock()
  walk list, find block X
                                        QLIST_REMOVE_RCU(X)
                                        qatomic_set(&mru_block, NULL)
                                        call_rcu(X, reclaim_ramblock)
  qatomic_set(&mru_block, X)  <----------- overwrites NULL
  rcu_read_unlock()
                                        grace period ends, X freed

  Reader C
  --------
  rcu_read_lock()
  qatomic_rcu_read(&mru_block) -> X
  Read X's block->offset ...  <----------- UAF

To fix it, we can introduce a nested RCU free for reset of the mru_block
field, and only free the ramblock until the 2nd RCU call.

Since QEMU always: (1) dequeue the RCU node before invoking the
function, (2) reset all fields in rcu_head in the call_rcu1() call, nested
RCU will work all fine like what's used in this patch.

[1] https://lore.kernel.org/r/5fd9e540-cf13-45f5-ba9a-c7faf364035b@rsg.ci.i.u-tokyo.ac.jp

Cc: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Signed-off-by: Peter Xu <peterx@redhat.com>
---

Based-on: <5fd9e540-cf13-45f5-ba9a-c7faf364035b@rsg.ci.i.u-tokyo.ac.jp>

Since there's no reproducer, I didn't verify the problem as-is.  What I did
is I ran this through some high concurrency "make check -jN" (8 processes
with 4 cores pinned, hence 8*N make-check threads running concurrently on 4
physical cores), I didn't see any regression.
---
 system/physmem.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/system/physmem.c b/system/physmem.c
index 9e1ac13e82..1697568fa7 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -2590,6 +2590,21 @@ static void reclaim_ramblock(RAMBlock *block)
     g_free(block);
 }
 
+static void reclaim_ramblock_prepare(RAMBlock *block)
+{
+    /*
+     * 1st round rcu free guarantees the last reader that can access this
+     * ramblock is gone.  Reset this field making sure it will never point
+     * to the ramblock being freed.
+     */
+    qatomic_set(&ram_list.mru_block, NULL);
+    /*
+     * Note: this is an intended nested use of rcu_head.  If needed, we can
+     * provide two rcu_heads for ramblock.
+     */
+    call_rcu(block, reclaim_ramblock, rcu);
+}
+
 void qemu_ram_free(RAMBlock *block)
 {
     g_autofree char *name = NULL;
@@ -2607,10 +2622,11 @@ void qemu_ram_free(RAMBlock *block)
     name = cpr_name(block->mr);
     cpr_delete_fd(name, 0);
     QLIST_REMOVE_RCU(block, next);
+    /* First attempt of reset, see reclaim_ramblock_prepare() for the 2nd */
     qatomic_set(&ram_list.mru_block, NULL);
     /* Write list before version */
     qatomic_store_release(&ram_list.version, ram_list.version + 1);
-    call_rcu(block, reclaim_ramblock, rcu);
+    call_rcu(block, reclaim_ramblock_prepare, rcu);
     qemu_mutex_unlock_ramlist();
 }
 
-- 
2.53.0


