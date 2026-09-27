Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 026C0C9830E
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Sep 2026 10:49:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xAmRy-0006TC-NC; Sun, 27 Sep 2026 06:49:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xAmRM-0005xY-HE; Sun, 27 Sep 2026 06:49:13 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xAmRJ-00011R-Kj; Sun, 27 Sep 2026 06:49:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1790506130; bh=I5VJpGs6HPqC0k8PnGZ2I1M/ZnWMOaTXiQ71nKaGbDY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=c80HTsWheliVCxjlzQb9woExdq05C3xtek1AdJfhFp7KtiPEqrXrBwlVV8gQ4vSU2
 NCrVvLlmeoGRLWmI7IsnG2tmqBkgrUDg9vboKW2qyZs091gjkBBNlmF9JdDA2iWw/j
 o4jioJy2SxqDnDGb+85NBOXkHqBDeMWVo/oeAwunQRaQyYuoMpYY3Ikoeo/3K1sOnw
 ZXbNh/AQ7EbtTps5cD9fw8SvhAsVHLXGBmleEZJCj42TP5atITBUd0d6FT4JQ4tQ5Y
 UkJKBxq0uxR0QNxOjlLAIWeM817oqPFnw2q/46zVWZTNta/BrAWsGu4WIoevNp47qs
 tHKEK/XxDAnRQ==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 7A3A61D8B5D;
 Sun, 27 Sep 2026 13:48:50 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 7780C432164;
 Sun, 27 Sep 2026 13:48:50 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 52D235E772; Sun, 27 Sep 2026 13:48:50 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Cam Miller <cam@linux.ibm.com>,
 Boris Fiuczynski <fiuczy@linux.ibm.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Peter Xu <peterx@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.1.2 v2 62/92] system/ram-discard-manager: fix
 offset_within_address_space in replay_by_populated_state()
Date: Sun, 27 Sep 2026 13:47:38 +0300
Message-ID: <20260927104821.196183-6-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.1.2-20260927121932@cover.tls.msk.ru>
References: <qemu-stable-11.1.2-20260927121932@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
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

From: Cam Miller <cam@linux.ibm.com>

Fix bug inside replay_by_populated_state() that forgets to initialize
MemoryRegionSection field offset_within_address_space. Follow the
established pattern of calling memory_region_section_intersect_range()
to accomplish this task.

Prior to commit cc9c77f4ddf0 ("system/memory: implement
RamDiscardManager multi-source aggregation"),
replay_by_populated_state() had called
memory_region_section_intersect_range() in order to initialize
interdependent fields offset_within_address_space, offset_within_region,
and size together, as shown below.

    s->offset_within_address_space += start - s->offset_within_region;
    s->offset_within_region = start;
    s->size = int128_sub(end, int128_make64(start));

cc9c77f4ddf0 reimplements replay_by_populated_state() initializing the
fields of the given MemoryRegionSection instance by hand instead of via
memory_region_section_intersect_range(). In doing so, it leaves
offset_within_address_space uninitialized for some reason, as you can
see below.

    MemoryRegionSection subsection = {
        .mr = section->mr,
        .offset_within_region = offset,
        .size = int128_make64(MIN(granularity, end_offset - offset)),
    };

Consequently offset_within_address_space defaults to GPA 0x0, which is
incorrect. For example, on s390x, base RAM begins at GPA 0x0 and it is
problematic to report that a virtio-iommu MR section lives there
instead.

cc9c77f4ddf0 deliberately calls memory_region_section_intersect_range()
from other related code paths inside the same file, namely
replay_source_by_state() and rdl_populate_cb()/rdl_discard_cb(). It is
unclear why the new replay_by_populated_state() implementation does not
conform to this same pattern.

The effects of the bug include qemu crashes on multiple architectures.
The following assertion failure occurs when driving the
guest_phys_blocks_append() code path, for guests with virtio-mem device
that has some memory plugged.

    DBG: guest_phys_block_add_section: predecessor->target_end=280000000 target_start=0
    **
    ERROR:../system/memory_mapping.c:222:guest_phys_block_add_section: assertion failed: (predecessor->target_end <= target_start)
    Bail out! ERROR:../system/memory_mapping.c:222:guest_phys_block_add_section: assertion failed: (predecessor->target_end <= target_start)
    2026-09-11 16:03:57.405+0000: shutting down, reason=crashed

This crash can be triggered on x86 via the dump-guest-memory QMP
command. The same crash can be triggered on s390x by restoring VM State
that has been migrated to a local file. (I used libvirt to manage this
migration restore operation, namely command virsh managedsave then virsh
start.) Applying the fix resolved the crash on both platforms.

Cc: qemu-stable <qemu-stable@nongnu.org>
Fixes: cc9c77f4ddf0 ("system/memory: implement RamDiscardManager multi-source aggregation")
Reported-by: Boris Fiuczynski <fiuczy@linux.ibm.com>
Signed-off-by: Cam Miller <cam@linux.ibm.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Link: https://lore.kernel.org/r/20260914-vmem_fix-v1-1-f69ef04a07b0@linux.ibm.com
Signed-off-by: Peter Xu <peterx@redhat.com>
(cherry picked from commit 666dd3c9b10a70eea4aae3c09b0f945175a7cb8e)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/system/ram-discard-manager.c b/system/ram-discard-manager.c
index 4e8816e5a2f..e9a609e5cd5 100644
--- a/system/ram-discard-manager.c
+++ b/system/ram-discard-manager.c
@@ -238,14 +238,15 @@ static int replay_by_populated_state(const RamDiscardManager *rdm,
             }
         } else {
             if (in_run) {
-                MemoryRegionSection run_section = {
-                    .mr = section->mr,
-                    .offset_within_region = run_start,
-                    .size = int128_make64(offset - run_start),
-                };
-                ret = replay_fn(&run_section, user_opaque);
-                if (ret) {
-                    return ret;
+                MemoryRegionSection run_section = *section;
+
+                if (memory_region_section_intersect_range(&run_section,
+                                                          run_start,
+                                                          offset - run_start)) {
+                    ret = replay_fn(&run_section, user_opaque);
+                    if (ret) {
+                        return ret;
+                    }
                 }
                 in_run = false;
             }
@@ -257,12 +258,12 @@ static int replay_by_populated_state(const RamDiscardManager *rdm,
     }
 
     if (in_run) {
-        MemoryRegionSection run_section = {
-            .mr = section->mr,
-            .offset_within_region = run_start,
-            .size = int128_make64(end_offset - run_start),
-        };
-        ret = replay_fn(&run_section, user_opaque);
+        MemoryRegionSection run_section = *section;
+
+        if (memory_region_section_intersect_range(&run_section, run_start,
+                                                  end_offset - run_start)) {
+            ret = replay_fn(&run_section, user_opaque);
+        }
     }
 
     return ret;
-- 
2.47.3


