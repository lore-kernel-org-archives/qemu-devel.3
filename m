Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76633CD6E4A
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2026 13:47:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wV8Of-0002ua-BU; Thu, 04 Jun 2026 09:46:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wV8OF-0001k7-AV
 for qemu-devel@nongnu.org; Thu, 04 Jun 2026 09:45:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wV8OC-00019V-Lu
 for qemu-devel@nongnu.org; Thu, 04 Jun 2026 09:45:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780580739;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3CqFxIqjMMdGXqKKnL+tbt++sUy9MTe8z+qAn52XsHg=;
 b=fiz31SKDegD+fOqJ0/PzntGCF0GGX3FXbAajRagBAFCtYOog6TF3m7LmNOHpjQeemFp5zn
 E6NZqPomhnB4spEM77ZgidS/vgLBNgmK2TmacgBS8gZsfjD5fcp1dFk9jZY041BVbFAKf0
 9yYLpocCJq+MEEwEpAU3JDsCx2+P3sI=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-655-hIXEbtZ2Oea0dXoPKwf-Ow-1; Thu,
 04 Jun 2026 09:45:36 -0400
X-MC-Unique: hIXEbtZ2Oea0dXoPKwf-Ow-1
X-Mimecast-MFC-AGG-ID: hIXEbtZ2Oea0dXoPKwf-Ow_1780580734
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 58F601956089; Thu,  4 Jun 2026 13:45:34 +0000 (UTC)
Received: from localhost (unknown [10.44.24.6])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id AB63E1955BC0; Thu,  4 Jun 2026 13:45:32 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 04 Jun 2026 17:43:57 +0400
Subject: [PATCH v5 11/12] system/physmem: make ram_block_discard_range()
 handle guest_memfd
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260604-rdm5-v5-11-5768e6a0943d@redhat.com>
References: <20260604-rdm5-v5-0-5768e6a0943d@redhat.com>
In-Reply-To: <20260604-rdm5-v5-0-5768e6a0943d@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhenzhong Duan <zhenzhong.duan@intel.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, David Hildenbrand <david@kernel.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>, 
 qemu-rust@nongnu.org, Alex Williamson <alex@shazbot.org>, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>, 
 Fabiano Rosas <farosas@suse.de>, Mark Kanda <mark.kanda@oracle.com>, 
 Ben Chaney <bchaney@akamai.com>, Marcelo Tosatti <mtosatti@redhat.com>, 
 kvm@vger.kernel.org, "Dr. David Alan Gilbert" <dave@treblig.org>, 
 Zhao Liu <zhao1.liu@intel.com>, Eric Blake <eblake@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>, Xiaoyao Li <xiaoyao.li@intel.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=6549;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=BfzRj9+PxZBuWnruTJpFaGdqesXc0dlzBlWko+GiOlg=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqIYEyCdxsURB1AYlGa1B17jLxB6W6D7m5G2RE6
 ymjLAOxw0GJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaiGBMgAKCRDa6OEJdZac
 5YorD/90sr8de39/rv34Sc0bwAgHrajghrQW4um+atQdLhevyScbCk2Py7uBuN+8Q0DTwHaAIUp
 Nw8xKH6ECa8QVvDckPABb3h2R28R+Rze6X9UjJaHervUzFnq42+14pGBYANu0FoJ58Wn4CZaWAN
 cdoypI9gjaVmL+mCIDnigSCE16CncY4t21VUoo+5GP0BKA3KMZGdy5f0ZdNbkFBUbdfkbEqEQWG
 K89z9z2wdPQz++ikpN+Mhxw9MaVPrntmEYCFgxUGeBdx0Pfo0IPLecLUzGBQdZUNHcFlxG5Vxuj
 1kxDFITQSCgBGy5z6WfAgPsIt1SwRtloKxzBty/k0VQYLbpv5QXziDziqe1rek1QMyuXeHOFq/C
 YSGsTOOXh7/EiKigMWc7IzOdbeCzvHION07ftzeO7KQVXwSbYPKm4VNf9RUPA0kFYOMpHv3c9Gi
 UwoE65+qVYF8idk0iUTUxZBGySLpxX8wcIude6+Svu11qh9j6xcdvyBrjLNb6KYu8rdkC6mNEmD
 MBH7MPtT4uzBhZ412faz4qX+y/wmsLP6RD/pu4XzbLYlJE+auZTEqPkX2umeCzjCkNN57DIsuOd
 XKUs9YLkAdZIkGZGSJuiwXmxs6W0aHsa8F+qc7b/KL27Y1u+LAfQE6Gxj81rQZy9TAWIpQRhqac
 JPteGbOCY/PZV8A==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
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

Reviewed-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 include/system/ramblock.h |  3 ++-
 accel/kvm/kvm-all.c       |  2 +-
 system/physmem.c          | 25 +++++++++++++++++++++----
 target/i386/kvm/tdx.c     |  2 +-
 system/trace-events       |  2 +-
 5 files changed, 26 insertions(+), 8 deletions(-)

diff --git a/include/system/ramblock.h b/include/system/ramblock.h
index 2b38718fe5f..f0639287bf0 100644
--- a/include/system/ramblock.h
+++ b/include/system/ramblock.h
@@ -103,7 +103,8 @@ struct RamBlockAttributes {
 
 /* @offset: the offset within the RAMBlock */
 int ram_block_discard_range(RAMBlock *rb, uint64_t offset, size_t length);
-/* @offset: the offset within the RAMBlock */
+int ram_block_discard_shared_range(RAMBlock *rb, uint64_t offset,
+                                   size_t length);
 int ram_block_discard_guest_memfd_range(RAMBlock *rb, uint64_t offset,
                                         size_t length);
 
diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 96f90ebb240..dcfb99cdf74 100644
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
index ddb67ba2359..0ff80a74917 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -4095,7 +4095,7 @@ int qemu_ram_foreach_block(RAMBlockIterFunc func, void *opaque)
  * Returns: 0 on success, none-0 on failure
  *
  */
-int ram_block_discard_range(RAMBlock *rb, uint64_t offset, size_t length)
+int ram_block_discard_shared_range(RAMBlock *rb, uint64_t offset, size_t length)
 {
     int ret = -1;
 
@@ -4144,7 +4144,7 @@ int ram_block_discard_range(RAMBlock *rb, uint64_t offset, size_t length)
              * have a MAP_PRIVATE mapping, possibly messing with other
              * MAP_PRIVATE/MAP_SHARED mappings. There is no easy way to
              * change that behavior whithout violating the promised
-             * semantics of ram_block_discard_range().
+             * semantics of ram_block_discard_shared_range().
              *
              * Only warn, because it works as long as nobody else uses that
              * file.
@@ -4200,8 +4200,9 @@ int ram_block_discard_range(RAMBlock *rb, uint64_t offset, size_t length)
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
@@ -4211,6 +4212,22 @@ err:
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


