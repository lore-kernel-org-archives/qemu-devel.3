Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E66FC531D0
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 03:18:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woYKZ-0003IC-Dc; Mon, 27 Jul 2026 23:18:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1woYKX-0003Hu-7X
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 23:18:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1woYKV-0005Wa-OK
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 23:18:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785208686;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eAsvla5tQhA1spQqTDncWeqaXeCjHrIHBvdG7EtAFEQ=;
 b=M3u36zBUBRWMdNyzC1q0ZGUMyBpCSzy+sTSrRG2rE8NxNgDSTQLa8r1JDQgAcf8pMfp8fP
 TJLyHW3asmjvD8SDsQHKRFkuP2Y+UvvGZTXi0WnZMEcAnR4RDTBnUQuXvdCpWBibGFHUd3
 tIomcpluUo4182rJuqUE9PyEIo0wrS4=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-208-XGbrgoa0OiCCtA2aVfoXWA-1; Mon,
 27 Jul 2026 23:18:05 -0400
X-MC-Unique: XGbrgoa0OiCCtA2aVfoXWA-1
X-Mimecast-MFC-AGG-ID: XGbrgoa0OiCCtA2aVfoXWA_1785208683
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4055B18007EC; Tue, 28 Jul 2026 03:18:03 +0000 (UTC)
Received: from gshan-thinkpadx1nanogen2.rmtau.csb (unknown [10.64.136.50])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 21D855B2; Tue, 28 Jul 2026 03:17:54 +0000 (UTC)
From: Gavin Shan <gshan@redhat.com>
To: qemu-arm@nongnu.org
Cc: qemu-devel@nongnu.org, peterx@redhat.com, mst@redhat.com,
 philmd@oss.qualcomm.com, peter.maydell@linaro.org,
 richard.henderson@linaro.org, alex@shazbot.org, berrange@redhat.com,
 philmd@mailo.com, david@kernel.org, clg@redhat.com, pbonzini@redhat.com,
 phrdina@redhat.com, jugraham@redhat.com, liugang24219@sangfor.com.cn,
 dinghui@sangfor.com.cn, shan.gavin@gmail.com
Subject: [PATCH v5 1/3] system/memory: Use memmove() for directly accessible
 regions
Date: Tue, 28 Jul 2026 13:17:29 +1000
Message-ID: <20260728031731.286666-2-gshan@redhat.com>
In-Reply-To: <20260728031731.286666-1-gshan@redhat.com>
References: <20260728031731.286666-1-gshan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.133.124; envelope-from=gshan@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.58,
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

Similar to what's done in commit 4a73aee88140 ("softmmu: Use memmove in
flatview_write_continue"), there are more sites where the overlapping
source and destination buffer are allowed for the directly accessible
regions. Use memmove() in those sites, listed as below.

  hw/remote/vfio-user-obj.c::vfu_object_mr_rw
  include/system/memory.h::address_space_read
  system/physmem.c::flatview_read_continue_step

Signed-off-by: Gavin Shan <gshan@redhat.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Peter Xu <peterx@redhat.com>
---
 hw/remote/vfio-user-obj.c | 4 ++--
 include/system/memory.h   | 2 +-
 system/physmem.c          | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/remote/vfio-user-obj.c b/hw/remote/vfio-user-obj.c
index 87fa7b6572..ea50270628 100644
--- a/hw/remote/vfio-user-obj.c
+++ b/hw/remote/vfio-user-obj.c
@@ -375,9 +375,9 @@ static int vfu_object_mr_rw(MemoryRegion *mr, uint8_t *buf, hwaddr offset,
         ram_ptr = memory_region_get_ram_ptr(mr);
 
         if (is_write) {
-            memcpy((ram_ptr + offset), buf, size);
+            memmove((ram_ptr + offset), buf, size);
         } else {
-            memcpy(buf, (ram_ptr + offset), size);
+            memmove(buf, (ram_ptr + offset), size);
         }
 
         return 0;
diff --git a/include/system/memory.h b/include/system/memory.h
index 2192fc9bdc..336d4e84a6 100644
--- a/include/system/memory.h
+++ b/include/system/memory.h
@@ -2741,7 +2741,7 @@ MemTxResult address_space_read(const AddressSpace *as, hwaddr addr,
             mr = flatview_translate(fv, addr, &addr1, &l, false, attrs);
             if (len == l && memory_access_is_direct(mr, false, attrs)) {
                 ptr = qemu_map_ram_ptr(mr->ram_block, addr1);
-                memcpy(buf, ptr, len);
+                memmove(buf, ptr, len);
             } else {
                 result = flatview_read_continue(fv, addr, attrs, buf, len,
                                                 addr1, l, mr);
diff --git a/system/physmem.c b/system/physmem.c
index c21ea92915..2c42e365cb 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -3363,7 +3363,7 @@ static MemTxResult flatview_read_continue_step(MemTxAttrs attrs, uint8_t *buf,
         uint8_t *ram_ptr = qemu_ram_ptr_length(mr->ram_block, mr_addr, l,
                                                false, false);
 
-        memcpy(buf, ram_ptr, *l);
+        memmove(buf, ram_ptr, *l);
 
         return MEMTX_OK;
     }
-- 
2.55.0


