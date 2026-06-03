Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE7C3CD6E55
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2026 17:36:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUpVc-0006VT-Vp; Wed, 03 Jun 2026 13:36:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wUpVb-0006Uy-Lk
 for qemu-devel@nongnu.org; Wed, 03 Jun 2026 13:36:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wUpVZ-000427-Cp
 for qemu-devel@nongnu.org; Wed, 03 Jun 2026 13:36:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780508159;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=I+ibRdpFYFzTK5fhN9MaBvTU5pp3AENTai6lzmzbH3o=;
 b=PrYplhl600I/UI1rrxmvNFG8Vy0rTRY53GuBOnKH8c5GFNsThWXJeig/Fusv9JqYeBf+QP
 TkmOdR0NWnVVQW4iMsE6FZLZMP5UxP0q4fzDeiSVMWpC69vcTDLAWwpuhaXKI+Lfpopq5+
 XOKbdTw/y9lNNrk+GtpHO3f0VUTw1sQ=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-501-2WDkGOlzMuabV9i-Aytu9g-1; Wed, 03 Jun 2026 13:35:58 -0400
X-MC-Unique: 2WDkGOlzMuabV9i-Aytu9g-1
X-Mimecast-MFC-AGG-ID: 2WDkGOlzMuabV9i-Aytu9g_1780508157
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-5174a236220so84939511cf.3
 for <qemu-devel@nongnu.org>; Wed, 03 Jun 2026 10:35:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1780508157; x=1781112957; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=I+ibRdpFYFzTK5fhN9MaBvTU5pp3AENTai6lzmzbH3o=;
 b=ISUD/ILiHAcw8Z4D+EXYjsIu/+mtemEh0jYBCqVOU0KMjieDyxpkg4tRzE9/4ISVPp
 95S2CQHowB6lX1cLdUZDmZe52JytUGz0vx2YCJtklpuX4Zopg37BEHSjRrUFOtVYhrJ7
 b3WCuF+nI1rqhFMitDotSUFKsfnGvevmo6UA+HpOcU3W4fOdVSGRyM6pKMbZIm42n1hP
 JxZU/Hm4Ylaq8vr2tefxCRedQ1+ffXpz8cd5CvHdPYVB0mD0Qh9VtS/vEhTJzHuqAqu3
 5DfieWJqkLRRcv8EMQGLReaEezKbqiNgT6KY2hSkIIyu53vnEuJrF01lw2S/x9BKunU6
 79qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780508157; x=1781112957;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=I+ibRdpFYFzTK5fhN9MaBvTU5pp3AENTai6lzmzbH3o=;
 b=E1sInEc2o5gGZZeQsGabd90/TbjPoKhCpdOCGdOWCN4RZuLqw3Gs7plazEDH80i2ZN
 HWY28La1YXC8CFbnuLdktMv6O8kKvKJdTSxAKlX2GeohQU4YVqXFgdf8Q6FULS0jfKJL
 tz+F7WbafZye2OKQHylG9H9wP0iIj2AovBjadNKqvbkCnkFU53RAndwdUo5gV4cQ0MjU
 7AA8tSNxc8/zO+2p2WSxPeD590+W2HP/EHd5HSXvRmtS0yvH7SYCz9T8zAvNiazvyL36
 Ekdaslwd4jdFHtMHmFsfueO6XiYJhj3PPEDxEr/22Y8ylJL5h96rY/w2e/vXJWfVx6OK
 YwtA==
X-Gm-Message-State: AOJu0YzlSNjAxz6fBRRZGcTEbG5ZiKWwIAsoD69I1lClKeD6M0AHA0kQ
 HPovisVEwizyXaGir5dex+QeQY5z3dhres7nPzhNMp+dL36ZYlwUd+kTWy4BO99rra3lvgqdmoC
 WqjgQBqIsZSv84mOnL1Af2PBj9I4AChn2LDIoS/ZugNI7Y2Rfu91ttc4V
X-Gm-Gg: Acq92OEuVGPCl9ZHOGQIa00T1J5R3zRFxgs+ITE7Kfu6DMRZNq9m44XK1j5pHgTMyb1
 WgcVcUvnQZvVJv5jlCHgYvVrRqpIY7AiN42XYR1vCOD17p/RkV93lsucKBFBGslhODt2ikA1ZJR
 VHjbPPf+c0NiLR1A5DiyN+xRN+sUdozgedKitSgA5oF34zUiYbLGOUu1J84VzJ4LA5bGoGEv5Ia
 A2U8Bxkgr1n2e2YegO0EzE4GCme3XG+GaD04rNxZu2z9fdQqSR9UvP+n5V1dtN/rIN2D3gHnEuG
 k2MOqkUXCozyHTQP92sksL1QA1qMITCLawK9+e6byi8DlU+0viD5nHc9YsuPtcShCXt46MDWGPi
 AXUL+V3Wyk1NQmiJjg5N3qV9CUg==
X-Received: by 2002:a05:622a:110a:b0:517:8242:5bc1 with SMTP id
 d75a77b69052e-517824265f6mr31181611cf.15.1780508157208; 
 Wed, 03 Jun 2026 10:35:57 -0700 (PDT)
X-Received: by 2002:a05:622a:110a:b0:517:8242:5bc1 with SMTP id
 d75a77b69052e-517824265f6mr31180961cf.15.1780508156531; 
 Wed, 03 Jun 2026 10:35:56 -0700 (PDT)
Received: from x1.local ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-51775c07c29sm30254101cf.1.2026.06.03.10.35.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jun 2026 10:35:55 -0700 (PDT)
Date: Wed, 3 Jun 2026 13:35:54 -0400
From: Peter Xu <peterx@redhat.com>
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Cc: qemu-devel@nongnu.org,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Fabiano Rosas <farosas@suse.de>, Paolo Bonzini <pbonzini@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: Re: [PATCH] memory/ramblock: Fix clear of mru_block on possible race
 condition
Message-ID: <aiBl-hXpmXc8ULSJ@x1.local>
References: <20260601205900.1067714-1-peterx@redhat.com>
 <36749195-2c49-4f9c-8445-2e67b2097676@rsg.ci.i.u-tokyo.ac.jp>
 <ah80T6aIns82fspH@x1.local>
 <622da0a8-8101-4816-bf20-b5c3c9547a5f@rsg.ci.i.u-tokyo.ac.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <622da0a8-8101-4816-bf20-b5c3c9547a5f@rsg.ci.i.u-tokyo.ac.jp>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, Jun 03, 2026 at 02:11:44PM +0900, Akihiko Odaki wrote:
> qemu_get_ram_block() may set mru_block during the grace period. Once
> mru_block is set, RCU readers can still access the ramblock, even if the
> block is no longer visible in ram_list.

True..

> 
> When enriching the comment in reclaim_ramblock_prepare(), I think the phrase
> “the last reader that can access this ramblock is gone” could be improved.
> What matters here is that the last reader that could find the block in
> ram_list is gone. The block is no longer visible in ram_list to any later
> reader, and clearing the cache at that point ensures that it is no longer
> visible through an mru_block cache hit either.

Yes that's ambiguous.

I updated comments in this patch, removed the 1st reset of mru_block, and
when at it also touched up the comment in qemu_get_ram_block(), let me know
if there's further comments before repost.

Thanks,

===8<===
From 18789a1136c753a6cdce1ea698cf4c1871121cc9 Mon Sep 17 00:00:00 2001
From: Peter Xu <peterx@redhat.com>
Date: Fri, 29 May 2026 12:05:15 -0400
Subject: [PATCH] memory/ramblock: Fix clear of mru_block on possible race
 condition

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


-- 
Peter Xu


