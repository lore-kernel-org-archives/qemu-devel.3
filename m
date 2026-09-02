Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15A16C624D3
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2026 14:22:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1lqx-0002MI-Gs; Wed, 02 Sep 2026 10:22:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leonardi@redhat.com>)
 id 1x1lqv-0002LX-VE
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 10:22:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leonardi@redhat.com>)
 id 1x1lqu-0007sw-A4
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 10:22:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788358931;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tw8TwJDaX7Bk5mufpVz3qufCLpdhCKwiUCd0A049V2s=;
 b=MpdB3NtZwiy5iqMN751gxbbz1mhBRkmIaXfqXe20yBHehe7pZx1uLkj2AZx5GSnU/mzjJp
 oPVLlHVNg4yW3lrNCtXx0q57QCUDmfzJNyUUOobi50gPE7bqA5DUw7PUjgEeT2RbfAgHpk
 Hf8QOcfjs3hHrCsedQk3Cbbg3dw7ifw=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-99-c-DoPxO0OnGQNq0Fw3KPzQ-1; Wed, 02 Sep 2026 10:22:08 -0400
X-MC-Unique: c-DoPxO0OnGQNq0Fw3KPzQ-1
X-Mimecast-MFC-AGG-ID: c-DoPxO0OnGQNq0Fw3KPzQ_1788358927
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-49b8c651ac0so13109865e9.2
 for <qemu-devel@nongnu.org>; Wed, 02 Sep 2026 07:22:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1788358927; x=1788963727; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=tw8TwJDaX7Bk5mufpVz3qufCLpdhCKwiUCd0A049V2s=;
 b=iWtcRX4OWCls8ikO8WIsM1iNl30QEn5L7zaBxpkBDagRK3oZJBI4sK0sRuY0uOFqVe
 Ix75DOLCC9OiYbauoUNAXYdEtCf+u+HUQA9D/p2oE4zEnjPT3Ec8FYEuCnt1Sbdr0ywm
 MJKRv9RQto5y66PZkP7JJryI5wSHitmKiuvyAXMNIxiNkNZDIbkYzTrPOLSHt52NSwLj
 T9/M7Alzw6ejObzTLF5n8tOYgrQ6jZGhaopQOcretexzLb9+xY7jv55TUSooDFrYXcQn
 OdcnM5mEo0zgJNFmnpPj7kfMGXvwNRvD+rfkkz+w2RNiIKQ8vgaUtgC4wf/JYeJiYQ9Y
 jZ4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788358927; x=1788963727;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=tw8TwJDaX7Bk5mufpVz3qufCLpdhCKwiUCd0A049V2s=;
 b=TTdRRxnaR39BpIlmWsgOWIypccah94aUqiwCACo1kpmT9C91mw9OXbqAlA/R1uDsG1
 PB/Fb6DD19L8efT3zsmSa1TEhMlVIaMj5IazPRzD2bjjn9QDgMuHjAtLO/nqXdGGxlGq
 CagWa8DBQ6OTD3mAxlrAt8sPxX+6OnZzil1qtVqU7I6KWvrxz4Xb6OGXbhF1qxDperiv
 PZGsvVqyv8eN1yYLHYaKKi9jax0+PWrma+xNYwz4eZRXFGKzdyxTc/Qtx3VUmJv6jIoR
 PHJe1HHDPO39TrgWTq/ZeZEofesvE+EvOJcT33x7viB9TJ5jWDzzgp9HsL0oMTSy+EAg
 NPRQ==
X-Gm-Message-State: AFuF++lG3DVSCSAwwAigpsCnB4FhiPYBAAs6PQOpuQoMZ/J3hE3jA2n8
 VqkvaNuyhF9I1jJUag+S2pFzl4RxBtXXJWM52nY1PL6k+AJMPr0PFyVLZ6gO7KVFStdMi7wB4Fw
 8oKmrdK3uipXU5iRGpx8gaBlZZqOvjPkhHJsD9+wR+94AyKdn89fPPVeV
X-Gm-Gg: AR+sD12IMmjGQCz012nJI2ou5TFPLOgxRtvThHjGIFHWBELAXKubf9rS2aQmHevXwIT
 hEbxPq+4ETsTVvWmftFdGO8cL4JiohAE40sM091e0YWkclkcPfbIS1chNbIg0pUoD7MJnYYV+Xt
 /I7sHmEXWlYXbgzK1PL+3+R6wsbqvsfQJpH1AXq7RRqc1Bfs3U0YWSiq1ZD0M82z02j6mcaH1Vb
 9CZROnMrN/d6c3S0y4RU5XUr6RGbMtClXoBT3Vf0ZDG7YT+NMC2rpl2ryVTBiDgsvveHtHd7Svd
 EMmGHZS/HLGPISiujeFqthz3WZmXcK+B9Nm4rjNqhRnUGVo4ldIVh4WRb1QU8OSPa8oFV7VcV1/
 va/hULV52zJA+62rRwn7GqwOD9Hp2ZSS0GTyao4jL762CQ1gTfCXIOe4sbpPQZDsVK2IJ
X-Received: by 2002:a05:600c:3f06:b0:49c:ee1c:d582 with SMTP id
 5b1f17b1804b1-49cee1cd69emr1465765e9.14.1788358926636; 
 Wed, 02 Sep 2026 07:22:06 -0700 (PDT)
X-Received: by 2002:a05:600c:3f06:b0:49c:ee1c:d582 with SMTP id
 5b1f17b1804b1-49cee1cd69emr1464025e9.14.1788358926010; 
 Wed, 02 Sep 2026 07:22:06 -0700 (PDT)
Received: from lleonard-thinkpadx1carbongen13.rmtit.csb ([151.29.41.106])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49ce4776131sm80871685e9.11.2026.09.02.07.22.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Sep 2026 07:22:05 -0700 (PDT)
From: Luigi Leonardi <leonardi@redhat.com>
Date: Wed, 02 Sep 2026 16:21:58 +0200
Subject: [PATCH 1/2] igvm: honor byte_offset when writing memory map, MADT
 and device tree
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260902-fix_offset-v1-1-04b18f7595b2@redhat.com>
References: <20260902-fix_offset-v1-0-04b18f7595b2@redhat.com>
In-Reply-To: <20260902-fix_offset-v1-0-04b18f7595b2@redhat.com>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>, Ani Sinha <anisinha@redhat.com>, 
 Luigi Leonardi <leonardi@redhat.com>
X-Mailer: b4 0.14.3
Received-SPF: pass client-ip=170.10.129.124; envelope-from=leonardi@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
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

qigvm_directive_memory_map(), qigvm_directive_madt() and
qigvm_directive_device_tree() all wrote their data unconditionally at
the start of the parameter area's buffer, ignoring param->byte_offset
from the IGVM_VHS_PARAMETER header. This is harmless when a
directive's offset happens to be 0, but breaks for IGVM files that pack
multiple parameters into a single shared parameter area at different
offsets: a later directive would overwrite the data written by an earlier
one at the start of the buffer, corrupting it.

Use param_entry->data + param->byte_offset as the write location and
size the bounds checks against the remaining space in the buffer
rather than its full size.

Signed-off-by: Luigi Leonardi <leonardi@redhat.com>
---
 backends/igvm.c    | 10 ++++++----
 target/i386/igvm.c |  4 ++--
 2 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/backends/igvm.c b/backends/igvm.c
index 7b7bdc72b7..a6e3a58022 100644
--- a/backends/igvm.c
+++ b/backends/igvm.c
@@ -632,8 +632,10 @@ static int qigvm_directive_memory_map(QIgvm *ctx, const uint8_t *header_data,
         return -1;
     }
 
-    max_entry_count = param_entry->size / sizeof(IGVM_VHS_MEMORY_MAP_ENTRY);
-    mm_entry = (IGVM_VHS_MEMORY_MAP_ENTRY *)param_entry->data;
+    max_entry_count = (param_entry->size - param->byte_offset) /
+                      sizeof(IGVM_VHS_MEMORY_MAP_ENTRY);
+    mm_entry = (IGVM_VHS_MEMORY_MAP_ENTRY *)(param_entry->data +
+                                              param->byte_offset);
 
     retval = get_mem_map_entry(entry, &cgmm_entry, errp);
     while (retval == 0) {
@@ -837,14 +839,14 @@ static int qigvm_directive_device_tree(QIgvm *ctx, const uint8_t *header_data,
     }
 
     fdt_size = fdt_totalsize(fdt_packed);
-    if (fdt_size > param_entry->size) {
+    if (fdt_size > param_entry->size - param->byte_offset) {
         error_setg(errp,
                    "IGVM: device tree size exceeds parameter area"
                    " defined in IGVM file");
         return -1;
     }
 
-    memcpy(param_entry->data, fdt_packed, fdt_size);
+    memcpy(param_entry->data + param->byte_offset, fdt_packed, fdt_size);
 
     return 0;
 }
diff --git a/target/i386/igvm.c b/target/i386/igvm.c
index ad9bf87761..4d9d97385a 100644
--- a/target/i386/igvm.c
+++ b/target/i386/igvm.c
@@ -199,8 +199,8 @@ int qigvm_directive_madt(QIgvm *ctx, const uint8_t *header_data, Error **errp)
 
     GArray *madt = acpi_build_madt_standalone(ctx->machine_state);
 
-    if (madt->len <= param_entry->size) {
-        memcpy(param_entry->data, madt->data, madt->len);
+    if (madt->len <= param_entry->size - param->byte_offset) {
+        memcpy(param_entry->data + param->byte_offset, madt->data, madt->len);
     } else {
         error_setg(
             errp,

-- 
2.55.0


