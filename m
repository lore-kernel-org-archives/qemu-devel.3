Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8866CD6E6B
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2026 13:34:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wV8Dc-0007x3-0h; Thu, 04 Jun 2026 09:34:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wV8DX-0007uM-2K
 for qemu-devel@nongnu.org; Thu, 04 Jun 2026 09:34:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wV8DV-0003cR-4M
 for qemu-devel@nongnu.org; Thu, 04 Jun 2026 09:34:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780580076;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=uh4IN7fW0iZNTG5gD7D/rzUpnRrAw74TjiSdkfRkhoE=;
 b=Ca0Qvr99j+23fSYfwrqGl2oxkUQ8FvHRqgEWQXj4NKLdo/yAHjoKdKFgzmkwdXEEp7pynz
 WsG/2KMUCAqZatqDlf10LlZbc5RsUBFRmYU2TWu+740UGYP9IQKm0SAmjUv3sSBicylppU
 b+myPBTlInYRClNF1kJgSDv7yHevZvA=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-594-IeiOqPwXMlm6N0D_6sFjBw-1; Thu, 04 Jun 2026 09:34:33 -0400
X-MC-Unique: IeiOqPwXMlm6N0D_6sFjBw-1
X-Mimecast-MFC-AGG-ID: IeiOqPwXMlm6N0D_6sFjBw_1780580073
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-5175bf22b1bso11674251cf.3
 for <qemu-devel@nongnu.org>; Thu, 04 Jun 2026 06:34:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1780580073; x=1781184873; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=uh4IN7fW0iZNTG5gD7D/rzUpnRrAw74TjiSdkfRkhoE=;
 b=hAle67wcuJ73r0R4J0omuxydAOuGhk59NuH1qyImWl3YEEztdlEV9GNIku8j7PK4SV
 c1SgY26ddskvtCmTacmqDsK9Of1Y/Py+BvALoN1pb1dFymyTp8GHncnZR5q0kbeDqgwM
 PlGJaqZ7nBoPH0bvyfSMSV2NcNyAUYj+S8NczBR6wEKG4QYLhIsxvQevg8hfjXOocTHh
 JvVs7mAybymWftg3qJjWG2y0jPFs0AEW8Wuv1UPwexGHxrxBNc1IbXHwCKlb3WaZirAe
 u8lwY6i+EeiBW8yK1ZiqBPDE4BLaqbAd55xsH1a2OJ+jacsIDwy3DtqDXJG5tT5OQXPv
 rAUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780580073; x=1781184873;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uh4IN7fW0iZNTG5gD7D/rzUpnRrAw74TjiSdkfRkhoE=;
 b=S3i5wZT4JgYWHC5o5Cm97QabynRRCHeEyTHojSsat0Z0LU72gbF+GN0sQSUF8yqcAq
 Buls+W833yWfOWj8SW/IAl61SKU7X+nNFrVOhtQNbWXEEqENcd8ZxbWGUgGqp8MGX2c9
 e1JwOTsEUJxVa88zs0qO6GgoJkVowJUT9azYkovKQ05WAvTbxgPP0+9dHwBHr1WJYaTL
 oNpFa8XnJc8OTIXncDViH+Dze88MJuwfyZOJ2Kt+eqrK2OlnyQSEy5gRF8vzXnHwXQf5
 cbqa40lxf0ve5RcAMXTh/RgemAqzsHB/iS3Eu08SWzD6cOtF9WDjm7uLD/Tt4ljFORnT
 822Q==
X-Gm-Message-State: AOJu0Yym1u4sR8Jnb9hAl+Jnfmrz6VRolxwZuIr2KZA95d/whenK123n
 z6xA0Tg0xCv+ay8HqCdydi0KTVQI2i3/4i5GvKmHo9YQJAmZWKJgh1Yw/WzxRPdGiCkAgfqkpBg
 NFfen7TdePv7eocUXRBTlpo8UvUc1GPvxWpj3tVBLA1pu/Z4Xi22dd6n09uJKkWB3OhbRZMqRvW
 b6vZgH52PU7Z2cherw7tejulGyw/0FZKIekqetxQ==
X-Gm-Gg: Acq92OE45o/NLUQqi86+5nVMy4HRpFkSM08Lspf8uwXv684G0ub9ghl+Zt7SFBQv+zu
 TwNeLNXA6hcKvKXa8/UWB+ExApwZfhx9L3iZYWwExcIjfXVsFC5CztJ9ZlhijOwi5doPsBb5kI9
 nhbC3xosoiyFh/DksINmlltGYfDiDpc1rDg3M6g5Kyt31BwRytaH8rvIfXniWlu/E6eQPAZdTwf
 LgDjQP2cApF1gE6zyi7Vh6fGonkX1H4mp1H+Pzzjb5VYey2w2V9+KnJl2pLEW6N2noxULewRThI
 Z6guiZKzI0d8TUy0KdeVBSRTvQvh4OmYeO1qLGjdJHo2nhof0zv11eQH+fkjPJZSbqep9Xf+8bb
 +eXaK+kZ2Nn9Qk0ZVlc4EI9c=
X-Received: by 2002:a05:622a:420f:b0:517:5ffc:4a11 with SMTP id
 d75a77b69052e-517786a9d2dmr105018611cf.36.1780580072469; 
 Thu, 04 Jun 2026 06:34:32 -0700 (PDT)
X-Received: by 2002:a05:622a:420f:b0:517:5ffc:4a11 with SMTP id
 d75a77b69052e-517786a9d2dmr105017781cf.36.1780580071564; 
 Thu, 04 Jun 2026 06:34:31 -0700 (PDT)
Received: from x1.com ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-517780e8169sm53217971cf.2.2026.06.04.06.34.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jun 2026 06:34:31 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Juraj Marcin <jmarcin@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Fabiano Rosas <farosas@suse.de>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Subject: [PATCH v2] memory/ramblock: Fix clear of mru_block on possible race
 condition
Date: Thu,  4 Jun 2026 09:34:29 -0400
Message-ID: <20260604133429.1268084-1-peterx@redhat.com>
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

Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Signed-off-by: Peter Xu <peterx@redhat.com>
---

Based-on: <5fd9e540-cf13-45f5-ba9a-c7faf364035b@rsg.ci.i.u-tokyo.ac.jp>

v2:
- Refine comments, remove the 1st reset of mru_block  [Akihiki]
---
 system/physmem.c | 46 ++++++++++++++++++++++++++++++----------------
 1 file changed, 30 insertions(+), 16 deletions(-)

diff --git a/system/physmem.c b/system/physmem.c
index 9e1ac13e82..c9e5696d6a 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -836,21 +836,14 @@ static RAMBlock *qemu_get_ram_block(ram_addr_t addr)
     abort();
 
 found:
-    /* It is safe to write mru_block outside the BQL.  This
-     * is what happens:
-     *
-     *     qatomic_set(&mru_block, xxx)
-     *     rcu_read_unlock()
-     *                                        xxx removed from list
-     *                  rcu_read_lock()
-     *                  read mru_block
-     *                                        qatomic_set(&mru_block, NULL);
-     *                                        call_rcu(reclaim_ramblock, xxx);
-     *                  rcu_read_unlock()
+    /*
+     * It is safe to write mru_block outside the BQL, the writer (e.g. when
+     * QEMU frees a ramblock) is designed to be thread-safe with readers
+     * updating this field concurrently.  See reclaim_ramblock_prepare().
      *
-     * qatomic_rcu_set is not needed here.  The block was already published
-     * when it was placed into the list.  Here we're just making an extra
-     * copy of the pointer.
+     * qatomic_rcu_set() is not needed here, because the block was already
+     * published when it was placed into the list.  Here we're just making
+     * an extra copy of the pointer.
      */
     qatomic_set(&ram_list.mru_block, block);
     return block;
@@ -2590,6 +2583,23 @@ static void reclaim_ramblock(RAMBlock *block)
     g_free(block);
 }
 
+static void reclaim_ramblock_prepare(RAMBlock *block)
+{
+    /*
+     * After one round of grace period, no more reader can see this
+     * ramblock via ram_list.  Reset this field making sure it will never
+     * point to the ramblock being freed.
+     */
+    qatomic_set(&ram_list.mru_block, NULL);
+    /*
+     * Wait for a second round of grace period to make sure whoever
+     * accessed the ramblock previously via mru_block has finished using
+     * it.  Note: this is an intended nested use of rcu_head.  If needed,
+     * we can provide two rcu_heads for ramblock.
+     */
+    call_rcu(block, reclaim_ramblock, rcu);
+}
+
 void qemu_ram_free(RAMBlock *block)
 {
     g_autofree char *name = NULL;
@@ -2607,10 +2617,14 @@ void qemu_ram_free(RAMBlock *block)
     name = cpr_name(block->mr);
     cpr_delete_fd(name, 0);
     QLIST_REMOVE_RCU(block, next);
-    qatomic_set(&ram_list.mru_block, NULL);
     /* Write list before version */
     qatomic_store_release(&ram_list.version, ram_list.version + 1);
-    call_rcu(block, reclaim_ramblock, rcu);
+    /*
+     * Wait for a grace period to make sure no reader can see this ramblock
+     * via ram_list anymore.  Note that readers can still see and access
+     * the ramblock via mru_block, so we can't free it yet.
+     */
+    call_rcu(block, reclaim_ramblock_prepare, rcu);
     qemu_mutex_unlock_ramlist();
 }
 
-- 
2.53.0


