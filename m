Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89A62C41513
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2024 23:39:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sF0Ar-0004Re-9i; Wed, 05 Jun 2024 19:36:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sF0Ap-0004DC-6R
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 19:36:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sF0Al-0005c9-Kh
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 19:36:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717630560;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/tkdF9wBgRXJ0C7b2uR1oP4dL+2Be2HPdzcygUpss9I=;
 b=NMcLmDdoUVc6DsLKEoK1DpSnuMx7WjfIH25nGzEDbvuQWO4+k87I/JNcmm1QDILBCj13os
 Z4w4VQAMfXu1Dn+zHt6DZ7DjEufGPo7EL6H4bXOTqDctiyIxkUxuD3qa5FUp9OxDW73Ldo
 klUm2s/5TYbRKhQIE8+51rAzkJv4xoA=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-347-2MkWQdtnPyu4Ja6igi81wA-1; Wed, 05 Jun 2024 19:35:59 -0400
X-MC-Unique: 2MkWQdtnPyu4Ja6igi81wA-1
Received: by mail-ed1-f72.google.com with SMTP id
 4fb4d7f45d1cf-57a2fb28a23so174768a12.3
 for <qemu-devel@nongnu.org>; Wed, 05 Jun 2024 16:35:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717630557; x=1718235357;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/tkdF9wBgRXJ0C7b2uR1oP4dL+2Be2HPdzcygUpss9I=;
 b=PQJzShamGK1R+HAalNcbyRB66Jset9S8fAMr9i74X6yU5rxQIxPiWcRtnu8xzDVex/
 LohAMqZPS8GzgBGw4hAZhFRiPaPIFYzMEA2Ynwxp9bm7zZFeZ7TcGr3QYJo3HZHw1RQu
 P7+2YQ0xPc7wXtxwAPxdcAd+ayW8znPsREWqYBfbR2hSRHQmLIh5XHucF1pSeyQ088LI
 emaS7A42U+Pa5Y4Ajd15BNlUl/r1HUlREHEQuw3lARWz3bgFn69VqIYQZjYl7PtYMovp
 q4DqTckqSGCrP4+lV2xBHHRhtQs/yveTJfF3ohKSPvaVT1cJHw9KotxUWv/qpTwNMgXJ
 av2Q==
X-Gm-Message-State: AOJu0Yy5XlScDdC8Wbc6hFgANj0kgo/jhWN6meRZt+lq1YV87gq8pjTg
 0jyRJdsuBWPCmfUOk/7Q+ud757Gk8ghG3uBlsYEy8khh3EHsh2vajJh0G4G5qkmbrqhEVhjRihe
 I+258eBg97mxWF4X2CuEzRy6M2d2on0VqODGKnifikb3mp5nXEIBZkJcksbStb08sQhe+vlvEfN
 KvAIrkOxQ6esfvfRE+wyKgAVrPVdkxJA==
X-Received: by 2002:a50:ab59:0:b0:572:32e4:daca with SMTP id
 4fb4d7f45d1cf-57a8b708a5emr2618927a12.25.1717630557534; 
 Wed, 05 Jun 2024 16:35:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEE9AJGP7JnNu5WtiQf3A93qiRsEfgwgjRw5Cv4mlbrfpkNfgu9JdC403zDt2n9uae7Rg7SDA==
X-Received: by 2002:a50:ab59:0:b0:572:32e4:daca with SMTP id
 4fb4d7f45d1cf-57a8b708a5emr2618914a12.25.1717630557062; 
 Wed, 05 Jun 2024 16:35:57 -0700 (PDT)
Received: from redhat.com ([2.55.56.67]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-57aadcbf568sm114869a12.0.2024.06.05.16.35.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Jun 2024 16:35:56 -0700 (PDT)
Date: Wed, 5 Jun 2024 19:35:54 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Fan Ni <fan.ni@samsung.com>,
 Gregory Price <gregory.price@memverge.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PULL v3 20/41] include/hw/cxl/cxl_device: Rename mem_size as
 static_mem_size for type3 memory devices
Message-ID: <40f913501a753dcf140a51406d3b6ebf89962df7.1717630437.git.mst@redhat.com>
References: <cover.1717630437.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1717630437.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Fan Ni <fan.ni@samsung.com>

Rename mem_size as static_mem_size for type3 memdev to cover static RAM and
pmem capacity, preparing for the introduction of dynamic capacity to support
dynamic capacity devices.

Reviewed-by: Gregory Price <gregory.price@memverge.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Fan Ni <fan.ni@samsung.com>
Message-Id: <20240523174651.1089554-6-nifan.cxl@gmail.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/cxl/cxl_device.h | 2 +-
 hw/cxl/cxl-mailbox-utils.c  | 4 ++--
 hw/mem/cxl_type3.c          | 8 ++++----
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
index e839370266..f7f56b44e3 100644
--- a/include/hw/cxl/cxl_device.h
+++ b/include/hw/cxl/cxl_device.h
@@ -234,7 +234,7 @@ typedef struct cxl_device_state {
     } timestamp;
 
     /* memory region size, HDM */
-    uint64_t mem_size;
+    uint64_t static_mem_size;
     uint64_t pmem_size;
     uint64_t vmem_size;
 
diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index bede28e3c8..b592473587 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -803,7 +803,7 @@ static CXLRetCode cmd_identify_memory_device(const struct cxl_cmd *cmd,
     snprintf(id->fw_revision, 0x10, "BWFW VERSION %02d", 0);
 
     stq_le_p(&id->total_capacity,
-             cxl_dstate->mem_size / CXL_CAPACITY_MULTIPLIER);
+             cxl_dstate->static_mem_size / CXL_CAPACITY_MULTIPLIER);
     stq_le_p(&id->persistent_capacity,
              cxl_dstate->pmem_size / CXL_CAPACITY_MULTIPLIER);
     stq_le_p(&id->volatile_capacity,
@@ -1179,7 +1179,7 @@ static CXLRetCode cmd_media_clear_poison(const struct cxl_cmd *cmd,
     struct clear_poison_pl *in = (void *)payload_in;
 
     dpa = ldq_le_p(&in->dpa);
-    if (dpa + CXL_CACHE_LINE_SIZE > cxl_dstate->mem_size) {
+    if (dpa + CXL_CACHE_LINE_SIZE > cxl_dstate->static_mem_size) {
         return CXL_MBOX_INVALID_PA;
     }
 
diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index 3e42490b6c..7194c8f902 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -608,7 +608,7 @@ static bool cxl_setup_memory(CXLType3Dev *ct3d, Error **errp)
         }
         address_space_init(&ct3d->hostvmem_as, vmr, v_name);
         ct3d->cxl_dstate.vmem_size = memory_region_size(vmr);
-        ct3d->cxl_dstate.mem_size += memory_region_size(vmr);
+        ct3d->cxl_dstate.static_mem_size += memory_region_size(vmr);
         g_free(v_name);
     }
 
@@ -631,7 +631,7 @@ static bool cxl_setup_memory(CXLType3Dev *ct3d, Error **errp)
         }
         address_space_init(&ct3d->hostpmem_as, pmr, p_name);
         ct3d->cxl_dstate.pmem_size = memory_region_size(pmr);
-        ct3d->cxl_dstate.mem_size += memory_region_size(pmr);
+        ct3d->cxl_dstate.static_mem_size += memory_region_size(pmr);
         g_free(p_name);
     }
 
@@ -837,7 +837,7 @@ static int cxl_type3_hpa_to_as_and_dpa(CXLType3Dev *ct3d,
         return -EINVAL;
     }
 
-    if (*dpa_offset > ct3d->cxl_dstate.mem_size) {
+    if (*dpa_offset > ct3d->cxl_dstate.static_mem_size) {
         return -EINVAL;
     }
 
@@ -1010,7 +1010,7 @@ static bool set_cacheline(CXLType3Dev *ct3d, uint64_t dpa_offset, uint8_t *data)
         return false;
     }
 
-    if (dpa_offset + CXL_CACHE_LINE_SIZE > ct3d->cxl_dstate.mem_size) {
+    if (dpa_offset + CXL_CACHE_LINE_SIZE > ct3d->cxl_dstate.static_mem_size) {
         return false;
     }
 
-- 
MST


