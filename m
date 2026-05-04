Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27D47FF885A
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2026 12:32:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wJsSY-0002eW-It; Mon, 04 May 2026 08:31:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wJsSW-0002U8-SG
 for qemu-devel@nongnu.org; Mon, 04 May 2026 08:31:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wJsSV-0006t1-06
 for qemu-devel@nongnu.org; Mon, 04 May 2026 08:31:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777897894;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=l1UOkg8ESC2cbZuC7XiDgjgNj3cGfwEh12TtMSWs/XI=;
 b=PGcVyh8R3IOS2Dbeo+uOro5Di2Q5vYqCGBaalxEdeQWD57OHGKfelR3COREF51x48vl/yK
 /NmjUhif/0p/QCULHciWjfED/8i9XqWz+o557kEuEbWb2e/hv+oxpEFTMlIbfp+2Fykmm8
 2pl649udb3lvBIb7/nwFZ8hd9b8EmKo=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-684-fuseW46wMGyErAPgChfrWA-1; Mon,
 04 May 2026 08:31:33 -0400
X-MC-Unique: fuseW46wMGyErAPgChfrWA-1
X-Mimecast-MFC-AGG-ID: fuseW46wMGyErAPgChfrWA_1777897892
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 59F8E1800451
 for <qemu-devel@nongnu.org>; Mon,  4 May 2026 12:31:32 +0000 (UTC)
Received: from localhost (unknown [10.44.24.4])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 10CBA1955D84; Mon,  4 May 2026 12:31:30 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 04 May 2026 16:30:17 +0400
Subject: [PATCH v4 11/13] system/physmem: make ram_block_discard_range()
 handle guest_memfd
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260504-rdm5-v4-11-bdf61e57c1e1@redhat.com>
References: <20260504-rdm5-v4-0-bdf61e57c1e1@redhat.com>
In-Reply-To: <20260504-rdm5-v4-0-bdf61e57c1e1@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=6458;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=uwGh52PaHwUVU/L22Q3gB6uksURem1+1AtSYRT/Pzu4=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBp+JFZOpRT4X/H7Y2F44YUtQmSfjXTYqm07eZH5
 GP09fgEVruJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCafiRWQAKCRDa6OEJdZac
 5bSvD/9j5v15gPhd2pwuxhgkXJ4xg9RNuwzcvwSe44kOTNP2IESr3BcKFNZOHBV2DnFomunglP+
 /5QPGc+qcm8DcPb5ULKdh7zGfo3TzT0POqTIoCO1uMy0QuRQRV3eowWVxJ64pL2hnUqEIW9NnfA
 htc4ncawGj+V3AcwaFpj+hkyrQgEYDtaWODhq3WTz+fQw36ENywYlNEofx1RdOenPjQinb81eC2
 7QSkUVOAivfT9v2uzJIlmobya8WpUgw8tffbozQCJ/CzvRvjv1J2+LbW6YV0T6G6xDfACvGEVCb
 ZdHHA1haq662pYGpShlyiztDMlKNCeFFTMvmvQmk2NyW4QWx3vq0CyrzVdlXbtoXpsg9VAq09c0
 ZJ1cIwZmgsxyCsEALvPwm+h+twjrS4F7ZsqcO4vUxFDspa7OwuChSA3ffjzUoj9miqFcAX4Yddp
 fqGcKUzD7AXEpWx2qyJe6W9xM59Y0owk1XIWKEZfKG2cBjHKsjXr8PL+cfyZy5YeJKF7C72K/ji
 VNtT9bL8mD7qE5oR5Th6pV7xLAr+rjmgUG652lMjlp27Bb1PdfVOSnFM8ONl6nefdYlNXf5GfOH
 g6zwZt+qaiOKokbdDJYWcrTO0l2LPHQWou3zdcrG6lLkeqvfuBis3XzRCm1VJUQGY7w+euvlcBW
 OazZPPBDzQ2B2qg==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.444,
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

Most callers of ram_block_discard_range() want to discard both the
shared and guest_memfd backing. Only kvm_convert_memory() intentionally
discards a single plane during private/shared conversions.

Rename the current implementation to ram_block_discard_shared_range()
and make ram_block_discard_range() a composite that also discards
guest_memfd when present (rb->guest_memfd >= 0). This ensures callers
like virtio-mem, virtio-balloon, hv-balloon, migration.. reclaim
private pages on discard.

Update kvm_convert_memory() to use the plane-specific
ram_block_discard_shared_range() since it only needs to discard
the shared backing when converting to private.

Likewise, after TDVF image copy, use ram_block_discard_shared_range().

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 include/system/ramblock.h |  3 ++-
 accel/kvm/kvm-all.c       |  2 +-
 system/physmem.c          | 25 +++++++++++++++++++++----
 target/i386/kvm/tdx.c     |  2 +-
 system/trace-events       |  2 +-
 5 files changed, 26 insertions(+), 8 deletions(-)

diff --git a/include/system/ramblock.h b/include/system/ramblock.h
index f0b557af416..76a84fd9c88 100644
--- a/include/system/ramblock.h
+++ b/include/system/ramblock.h
@@ -104,7 +104,8 @@ struct RamBlockAttributes {
 /* @offset: the offset within the RAMBlock */
 
 int ram_block_discard_range(RAMBlock *rb, uint64_t offset, size_t length);
-/* @offset: the offset within the RAMBlock */
+int ram_block_discard_shared_range(RAMBlock *rb, uint64_t offset,
+                                   size_t length);
 int ram_block_discard_guest_memfd_range(RAMBlock *rb, uint64_t offset,
                                         size_t length);
 
diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 92af42503b1..97463a683f4 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -3426,7 +3426,7 @@ int kvm_convert_memory(hwaddr start, hwaddr size, bool to_private)
              */
             goto out_unref;
         }
-        ret = ram_block_discard_range(rb, offset, size);
+        ret = ram_block_discard_shared_range(rb, offset, size);
     } else {
         ret = ram_block_discard_guest_memfd_range(rb, offset, size);
     }
diff --git a/system/physmem.c b/system/physmem.c
index a8472c91dff..5af9d5ac1a8 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -4085,7 +4085,7 @@ int qemu_ram_foreach_block(RAMBlockIterFunc func, void *opaque)
  * Returns: 0 on success, none-0 on failure
  *
  */
-int ram_block_discard_range(RAMBlock *rb, uint64_t offset, size_t length)
+int ram_block_discard_shared_range(RAMBlock *rb, uint64_t offset, size_t length)
 {
     int ret = -1;
 
@@ -4134,7 +4134,7 @@ int ram_block_discard_range(RAMBlock *rb, uint64_t offset, size_t length)
              * have a MAP_PRIVATE mapping, possibly messing with other
              * MAP_PRIVATE/MAP_SHARED mappings. There is no easy way to
              * change that behavior whithout violating the promised
-             * semantics of ram_block_discard_range().
+             * semantics of ram_block_discard_shared_range().
              *
              * Only warn, because it works as long as nobody else uses that
              * file.
@@ -4190,8 +4190,9 @@ int ram_block_discard_range(RAMBlock *rb, uint64_t offset, size_t length)
             goto err;
 #endif
         }
-        trace_ram_block_discard_range(rb->idstr, host_startaddr, length,
-                                      need_madvise, need_fallocate, ret);
+        trace_ram_block_discard_shared_range(rb->idstr, host_startaddr, length,
+                                             need_madvise, need_fallocate,
+                                             ret);
     } else {
         error_report("%s: Overrun block '%s' (%" PRIu64 "/%zx/" RAM_ADDR_FMT")",
                      __func__, rb->idstr, offset, length, rb->max_length);
@@ -4201,6 +4202,22 @@ err:
     return ret;
 }
 
+int ram_block_discard_range(RAMBlock *rb, uint64_t offset, size_t length)
+{
+    int ret;
+
+    ret = ram_block_discard_shared_range(rb, offset, length);
+    if (ret) {
+        return ret;
+    }
+
+    if (rb->guest_memfd >= 0) {
+        ret = ram_block_discard_guest_memfd_range(rb, offset, length);
+    }
+
+    return ret;
+}
+
 int ram_block_discard_guest_memfd_range(RAMBlock *rb, uint64_t offset,
                                         size_t length)
 {
diff --git a/target/i386/kvm/tdx.c b/target/i386/kvm/tdx.c
index 4714c9d514e..fcb11aa67e4 100644
--- a/target/i386/kvm/tdx.c
+++ b/target/i386/kvm/tdx.c
@@ -385,7 +385,7 @@ static void tdx_finalize_vm(Notifier *notifier, void *unused)
      * KVM_MEMORY_MAPPING. It becomes useless.
      */
     ram_block = tdx_guest->tdvf_mr->ram_block;
-    ram_block_discard_range(ram_block, 0, ram_block->max_length);
+    ram_block_discard_shared_range(ram_block, 0, ram_block->max_length);
 
     tdx_vm_ioctl(KVM_TDX_FINALIZE_VM, 0, NULL, &error_fatal);
     CONFIDENTIAL_GUEST_SUPPORT(tdx_guest)->ready = true;
diff --git a/system/trace-events b/system/trace-events
index e6e1b612798..51b4a4679a2 100644
--- a/system/trace-events
+++ b/system/trace-events
@@ -32,7 +32,7 @@ global_dirty_changed(unsigned int bitmask) "bitmask 0x%"PRIx32
 address_space_map(void *as, uint64_t addr, uint64_t len, bool is_write, uint32_t attrs) "as:%p addr 0x%"PRIx64":%"PRIx64" write:%d attrs:0x%x"
 find_ram_offset(uint64_t size, uint64_t offset) "size: 0x%" PRIx64 " @ 0x%" PRIx64
 find_ram_offset_loop(uint64_t size, uint64_t candidate, uint64_t offset, uint64_t next, uint64_t mingap) "trying size: 0x%" PRIx64 " @ 0x%" PRIx64 ", offset: 0x%" PRIx64" next: 0x%" PRIx64 " mingap: 0x%" PRIx64
-ram_block_discard_range(const char *rbname, void *hva, size_t length, bool need_madvise, bool need_fallocate, int ret) "%s@%p + 0x%zx: madvise: %d fallocate: %d ret: %d"
+ram_block_discard_shared_range(const char *rbname, void *hva, size_t length, bool need_madvise, bool need_fallocate, int ret) "%s@%p + 0x%zx: madvise: %d fallocate: %d ret: %d"
 qemu_ram_alloc_shared(const char *name, size_t size, size_t max_size, int fd, void *host) "%s size %zu max_size %zu fd %d host %p"
 
 subpage_register(void *subpage, uint32_t start, uint32_t end, int idx, int eidx, uint16_t section) "subpage %p start 0x%08x end 0x%08x idx 0x%08x eidx 0x%08x section %u"

-- 
2.54.0


