Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 896EDCDB479
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2026 12:49:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wc0Yg-0004br-LG; Tue, 23 Jun 2026 08:48:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wc0Ye-0004bD-81
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 08:48:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wc0Yc-00074E-BG
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 08:48:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782218929;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BUCTGAMfUlfjvkSgaEmGOjoXM8k4zTSG2Wny9ifuO80=;
 b=MNg8U5vhFj3VdgoRfrljYLGl3F1VEBn9IrJA5JEY4LvBHSgLub0Fa6b8n3FbMrE0SWeeHm
 agjPHWIL8hNc/aQ0qnhaUVhVrGXnK4MFXtYcYB2b8ELtwnS171WAU8QNmlud/Br14wP6Hw
 jKKfClZqi/0qSMznbNegB3IWS9lH0SQ=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-163-WUlwqUWAOJWavE_hE5FcEw-1; Tue, 23 Jun 2026 08:48:48 -0400
X-MC-Unique: WUlwqUWAOJWavE_hE5FcEw-1
X-Mimecast-MFC-AGG-ID: WUlwqUWAOJWavE_hE5FcEw_1782218928
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-51a5212cf77so15995311cf.2
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2026 05:48:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1782218928; x=1782823728; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BUCTGAMfUlfjvkSgaEmGOjoXM8k4zTSG2Wny9ifuO80=;
 b=LkZH2n2ycC4yuNekqDBmiuf7euGicvjDohmfChq6dAn8QeNbuhfA8cmujuq1zmqSQe
 mjUa1LPKFUf3LT6ySLN2fl5zC2vsEeIqN30rnbMjEnyaKiIZXXD/bkU0HSQmuuOxdfEx
 XhN/gYBu1zjlPAnsAxGGl6Ssz3wnpRwheFKlrvtxnPvQcuACgLL2xfB34IukfTEiXM6Q
 +ywjqORhpCqvYRNCnDyGgCA1qYj/yzHRY6foYK6Gem4spymZUlvD9SuRghDq6W1z4VId
 2trXohT6YIpZvXk9H8IQcdClpfxf0ld6H/xyMchsRCbDTzgQtzKe7lCxf8cvhkqOHpMr
 HNKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782218928; x=1782823728;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=BUCTGAMfUlfjvkSgaEmGOjoXM8k4zTSG2Wny9ifuO80=;
 b=UKy4fXg37zmGRSV8kPmTsOeXqdcy62KrupnPpyzxj6pV/ms5zFObgbXvHeS4SRIaNl
 uwg48HxdiNrx23ua1CwFy6beXfTmPaHp4mRZ546E/gB0hImFhwfl7J2K5d5UeEy/XInu
 Zlq+e4AdLtabuYJbtd6dRsy3LiB+WLhbr2REOQ79Wwm85t088j0pFfpTyJcjuT094DgQ
 0rdYXBFOoR8z8Z9yFRAdYyo/P/9u0VD1zjqcu45DAaxXc0O2A/cNteYAo6brtt+UxauC
 0ARZRed5sFwC1kPsih+vVYyA6MJk8fr4TcHfSIM7jdhumvyJ0CN2tLS5drIbLacHOXZx
 5kPQ==
X-Gm-Message-State: AOJu0Yx9BhClLKx+H0ZeXRuag+7ZXMSH6qAWLR5Q7MvAV9xdytd/BvP1
 K24OvggXtBVBPJgLuER8iBC+DFp5g39W/dFwdKcvtaQ5S/0c4FnIb43P2z6dgV2P6ayWMwQJ+pO
 QpVCFxHPqz60a/JjEMf8ZPQs9vRBgf4nhHUrz0mdK7Yak140LxT7XtXvmFmbv02MRklezgDZIRE
 XUCXoUKJIhd8m3Mat8QXsneL3zncTKeFDCyk1snw==
X-Gm-Gg: AfdE7clvRuLoQ5P4VQgAO4Ydu1iMbnaAoivrqkQPuAlYD3TEaFkT/W6YrUgb0Te2jhd
 Lax+6PX+OjfQfAgnggvRPPqPPbGwF0gw2yi8TJgAoutgHDuvAHljSfKdDxLYw0XZ3++jF9MDk+k
 bLnghaiGg8zzUAPtvaJWaRSAbmrQcBSBgv9GNonWP7Wovkdj+fPqu16Hfa7XgvUH5pl0nBb09yn
 OuHNflRfnSDLZVVbg6GfCHEx8xKN5JLjE5GK36d6iyuYoBRHl6MXvXjt41HdDdsoYnF8w+BHL51
 v0CJUPOk5poth3OjFBhrzKGOye39FFbSnagkanfibGaPq/RRltqw5H5D7fIpfVfVpzVNso33Y99
 61g==
X-Received: by 2002:a05:622a:228a:b0:519:5680:1b5 with SMTP id
 d75a77b69052e-519e4a55277mr288279471cf.21.1782218927495; 
 Tue, 23 Jun 2026 05:48:47 -0700 (PDT)
X-Received: by 2002:a05:622a:228a:b0:519:5680:1b5 with SMTP id
 d75a77b69052e-519e4a55277mr288278991cf.21.1782218926853; 
 Tue, 23 Jun 2026 05:48:46 -0700 (PDT)
Received: from x1.com ([174.91.117.157]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-51a51106a09sm22288351cf.0.2026.06.23.05.48.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jun 2026 05:48:46 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Xiaoyao Li <xiaoyao.li@intel.com>
Subject: [PULL 18/18] system/physmem: make ram_block_discard_range() handle
 guest_memfd
Date: Tue, 23 Jun 2026 08:47:59 -0400
Message-ID: <20260623124759.125399-19-peterx@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260623124759.125399-1-peterx@redhat.com>
References: <20260623124759.125399-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

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
Link: https://lore.kernel.org/r/20260604-rdm5-v5-11-5768e6a0943d@redhat.com
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/system/ramblock.h |  3 ++-
 accel/kvm/kvm-all.c       |  2 +-
 system/physmem.c          | 25 +++++++++++++++++++++----
 target/i386/kvm/tdx.c     |  2 +-
 system/trace-events       |  2 +-
 5 files changed, 26 insertions(+), 8 deletions(-)

diff --git a/include/system/ramblock.h b/include/system/ramblock.h
index 2b38718fe5..f0639287bf 100644
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
index f4f0e64fbd..8ddfbaff46 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -3422,7 +3422,7 @@ int kvm_convert_memory(hwaddr start, hwaddr size, bool to_private)
              */
             goto out_unref;
         }
-        ret = ram_block_discard_range(rb, offset, size);
+        ret = ram_block_discard_shared_range(rb, offset, size);
     } else {
         ret = ram_block_discard_guest_memfd_range(rb, offset, size);
     }
diff --git a/system/physmem.c b/system/physmem.c
index c4bfb57625..c21ea92915 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -4093,7 +4093,7 @@ int qemu_ram_foreach_block(RAMBlockIterFunc func, void *opaque)
  * Returns: 0 on success, none-0 on failure
  *
  */
-int ram_block_discard_range(RAMBlock *rb, uint64_t offset, size_t length)
+int ram_block_discard_shared_range(RAMBlock *rb, uint64_t offset, size_t length)
 {
     int ret = -1;
 
@@ -4142,7 +4142,7 @@ int ram_block_discard_range(RAMBlock *rb, uint64_t offset, size_t length)
              * have a MAP_PRIVATE mapping, possibly messing with other
              * MAP_PRIVATE/MAP_SHARED mappings. There is no easy way to
              * change that behavior whithout violating the promised
-             * semantics of ram_block_discard_range().
+             * semantics of ram_block_discard_shared_range().
              *
              * Only warn, because it works as long as nobody else uses that
              * file.
@@ -4198,8 +4198,9 @@ int ram_block_discard_range(RAMBlock *rb, uint64_t offset, size_t length)
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
@@ -4209,6 +4210,22 @@ err:
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
index df46fce769..dfad469112 100644
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
index e6e1b61279..51b4a4679a 100644
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


