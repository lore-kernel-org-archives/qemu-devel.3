Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3214C5B572
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 15:16:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuAgj-0008Mw-SI; Wed, 12 Aug 2026 11:16:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wuAgG-00083z-Tv
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 11:15:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wuAgF-0007Bi-48
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 11:15:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1786547746;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JcxukroejjvEu8ghEHMU38aY+6/s5Jxqaaa6rod+xLU=;
 b=SJQfw6vq/yRIPqjXzs51Z32Dr6+sjq7HK+n3mIVwcsDjlBy1LZYKc3k1lzrh9os7LK1ABf
 5TVqHHmwuUEKNo5Nt2BouCV3Tf2r+4ntEJ3MlPuBjKnJiR0ZTfgkhK762NBIfMC2pIoKLY
 VOycTRalHN/4PTXPUoJd5N5Wx2qo7Pw=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-22-vtVGVIIuPOa1Ya0FsfMbDQ-1; Wed, 12 Aug 2026 11:15:26 -0400
X-MC-Unique: vtVGVIIuPOa1Ya0FsfMbDQ-1
X-Mimecast-MFC-AGG-ID: vtVGVIIuPOa1Ya0FsfMbDQ_1786547725
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-51bf321d786so17315071cf.1
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 08:15:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1786547725; x=1787152525; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=JcxukroejjvEu8ghEHMU38aY+6/s5Jxqaaa6rod+xLU=;
 b=U6/hwy9eoUz++wqGpyPEMbIgNaeV0NYaP1Du9aHK9bXPXPKmT3wJicbrLhSdJDS7C8
 V0j4OiTX6r2/FnRqEiICSF3q6OKcTJkKHdobNrrZjvZ0Od9lwBxSBcs2B0uzPN4NvqJn
 MmCtghRJwd8b7ObgGOJsUzGxqsgqobPNg+H0Km8PtLPLRYyePJZMYEFHdtXwzfmb0VrY
 z6yQGlzNSK6XRi/toAJfamshbbAn4/LJ2nbMezsjZN69Ckq67AtDP0OP2la9QC14mjQY
 aIgUe6SF9QCaqryRx5pFNG5x2cbcKwOZLVYiPfuc9KISmpct3yiTIHfC7+WSdo1l9PIu
 iSEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786547725; x=1787152525;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=JcxukroejjvEu8ghEHMU38aY+6/s5Jxqaaa6rod+xLU=;
 b=US/6wgHt4QMpJwL/ROlpILdIlLioVFeq/0TN+YFPSLwb4Xib7KdpJf5EuygZ6k9p3k
 b1+cCwTHwOdUppSSdQXfF11hSXp1CpQhNSZtV9dQcBaOZZ//RoLH9ehTneeadRwZ6mhT
 TDRk8Tz53dzPctj2KmiXG7fbHHty1gk01iw8Rn25pih84RyBjkDEGA1bI2nqZYTo1DI1
 jreHBk0cJjSJLJQSm7DAhn8slQMr46BFHwiOXaBoxkm+ztIiIZSHXU8vWpb6h+4H+U6g
 r1UEIoLNHwdn2rJWk91AcjcZXae3/jpx/+ykw2r4P8073bRSU/HZQFF2hoaYNBz6Hc5K
 c7ZQ==
X-Gm-Message-State: AOJu0YynoGknEW6rZRyBYlqHsGV1BNl58O9C6Y9+0gEuHSFOl70DDFHb
 5K+rptOPj7Lj/tzfV+f9g2uTiipwL/BhvI/KilpXdEeJOuym997mGCBID7e/OPJEpjSncZg9Mu0
 RcHBNAVE2jddjDLs3qmTm1fMQOVUx3onZcP2fB2i5yCAaRg2i4p68g3laPZp7lkUdph7qC8Fxlf
 pDBHz9xtePZrAY368N3kntDEEAX0h78i95Cu0IFQ==
X-Gm-Gg: AR+sD11xZSDdC3OEdiICRNgKiTP+YJaujMgGx6IJLRsZ5+dXhZlB+h2r+9g5zCRDzaK
 JhM1h1Cb5ynZzXHZ7BcnxHVEaSiZkiraTK4cmR6QLkcZC2cHAY7Lj9h8RX+KLD/uWwIFYbt+NBh
 wMdWFEj4QDWFjMUKfnXnNDG9JtF99gDF3ztbzAzsC0gMopwx/U+4WUUKQPMIVKMGAR4sue3A8Sh
 aJeGBFbN1woQQ6VTCF0tJ+HddryWX0PC648C2jLW0crfjbszRm40Tqc9SDHj2w7PJXE2yYVwbdf
 IvZX+GXDXwxWHpG/UTGztuItd1qITA62zywELLTHNxVEckQfItl9fjjxrCXC7UDyYg==
X-Received: by 2002:a05:622a:4d91:b0:51c:1d18:2fe9 with SMTP id
 d75a77b69052e-52d6469cf4amr49008631cf.5.1786547725288; 
 Wed, 12 Aug 2026 08:15:25 -0700 (PDT)
X-Received: by 2002:a05:622a:4d91:b0:51c:1d18:2fe9 with SMTP id
 d75a77b69052e-52d6469cf4amr49007491cf.5.1786547724552; 
 Wed, 12 Aug 2026 08:15:24 -0700 (PDT)
Received: from x1.com ([174.91.117.74]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-52d61d948d6sm19552841cf.15.2026.08.12.08.15.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Aug 2026 08:15:18 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Paolo Bonzini <pbonzini@redhat.com>, Gavin Shan <gshan@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 03/10] system/memory: Use memmove() for directly accessible
 regions
Date: Wed, 12 Aug 2026 11:14:36 -0400
Message-ID: <20260812151444.2611689-4-peterx@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260812151444.2611689-1-peterx@redhat.com>
References: <20260812151444.2611689-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.104,
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

From: Gavin Shan <gshan@redhat.com>

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
Link: https://lore.kernel.org/r/20260728031731.286666-2-gshan@redhat.com
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/system/memory.h   | 2 +-
 hw/remote/vfio-user-obj.c | 4 ++--
 system/physmem.c          | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

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
2.54.0


