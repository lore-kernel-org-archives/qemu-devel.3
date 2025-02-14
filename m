Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0E8FC02198
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2025 11:17:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1titgR-0000V8-PL; Fri, 14 Feb 2025 06:16:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1titgP-0000Uw-Cx
 for qemu-devel@nongnu.org; Fri, 14 Feb 2025 06:16:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1titgN-0000JU-Cc
 for qemu-devel@nongnu.org; Fri, 14 Feb 2025 06:16:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739531789;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Qq/85eNfuF/SFBYBdN6Exlh+AgbqJ4Jg34k6AMEcN2o=;
 b=IaORxRHXVVZrEt7uLqmfs1iP2PjVlnyjPb/4h0BgOqIyCAQA71J0VK/ieNYT3qeUboOogG
 FeGgCqbp5ByAWJP4YrYQ2Gmz+JbLY5E3oeNFYpAIfY3YHKXIFFirsFKovImtQvMdFrYDOG
 30mbNDaCBHugEXeFGK7MqwSdh+K5w8A=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-297-vxRlNaFsMYGfGqrO0czlTQ-1; Fri,
 14 Feb 2025 06:16:25 -0500
X-MC-Unique: vxRlNaFsMYGfGqrO0czlTQ-1
X-Mimecast-MFC-AGG-ID: vxRlNaFsMYGfGqrO0czlTQ_1739531784
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A17A71800373; Fri, 14 Feb 2025 11:16:23 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.45.224.69])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B01E11800570; Fri, 14 Feb 2025 11:16:22 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 4A5A21800097; Fri, 14 Feb 2025 12:16:20 +0100 (CET)
Date: Fri, 14 Feb 2025 12:16:20 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
To: Alexander Graf <graf@amazon.com>
Cc: qemu-devel@nongnu.org, Eric Blake <eblake@redhat.com>, 
 Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, 
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, 
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 qemu-arm@nongnu.org, Michael Roth <michael.roth@amd.com>, 
 Markus Armbruster <armbru@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Ard Biesheuvel <ardb@kernel.org>
Subject: Re: [PATCH v3 09/23] hw/uefi: add var-service-core.c
Message-ID: <imob6duupjhtdqrmxdvnopqeqgdtw7vjgjzixej7vy6yragzck@o7kcfbdbqedv>
References: <kk4f5e3olb26qfjveqefkuzrjc45djikkk7uspz4yj7iesdmbj@zointitbvhdp>
 <73fe41f7-dff0-4506-8769-1997323c0a76@amazon.com>
 <4bwjwcs2k4hbrj6mokc57a5dy57jjssfxnvd4qm5257dgnid3x@yqdx7e47o2mf>
 <2c06a98c-f286-4632-a352-8b47dc4cc43c@amazon.com>
 <2vgc4scgezmb3med6dypykcym7te7gzlx7wp3vm5ehtfmxj3xr@kswpu35wt5ns>
 <f59bb48f-051d-4681-a702-6aed3420c2f7@amazon.com>
 <jnxvyw6q4vkng7jztu7q5rabgeohhpoxojdn4wt6xckc6pzmqz@ateji77pl5j7>
 <342a1bd9-52e9-4a6d-8a2a-63d2b478d896@amazon.com>
 <5whdvrcqkpted5wl53yo5qbq2g4bf4j57vrzvbsebho56xfz4w@mjpktoiarmto>
 <a39a1cfb-7d98-485e-98aa-9c03300f4be2@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a39a1cfb-7d98-485e-98aa-9c03300f4be2@amazon.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.495,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Fri, Feb 14, 2025 at 10:51:17AM +0100, Alexander Graf wrote:

> I also like to have dedicated register spaces per component. So even if you
> choose to make it a hard split, I think we're better off with 4k at
> 0xfef10000 for control and 64k at 0xfef20000 for the buffer for example.

Well, if we go for PIO transfer mode instead of device memory we don't
need map the buffer any more.

The control registers for the x86 variant are in io address space right
now (0x520, next to fw_cfg).  We could place them in a mmio page @
0xfef10000 instead.  Any preference, and if so, why?

First sketch below, on top of this series.  No edk2 counterpart yet, so
untested beyond compiling the code.

take care,
  Gerd

--------------------- cut here ------------------------
diff --git a/include/hw/uefi/var-service-api.h b/include/hw/uefi/var-service-api.h
index 6765925d9ed0..99911e904652 100644
--- a/include/hw/uefi/var-service-api.h
+++ b/include/hw/uefi/var-service-api.h
@@ -21,16 +21,21 @@
 #define UEFI_VARS_REG_MAGIC                  0x00  /* 16 bit */
 #define UEFI_VARS_REG_CMD_STS                0x02  /* 16 bit */
 #define UEFI_VARS_REG_BUFFER_SIZE            0x04  /* 32 bit */
-#define UEFI_VARS_REG_BUFFER_ADDR_LO         0x08  /* 32 bit */
-#define UEFI_VARS_REG_BUFFER_ADDR_HI         0x0c  /* 32 bit */
-#define UEFI_VARS_REGS_SIZE                  0x10
+#define UEFI_VARS_REG_DMA_BUFFER_ADDR_LO     0x08  /* 32 bit */
+#define UEFI_VARS_REG_DMA_BUFFER_ADDR_HI     0x0c  /* 32 bit */
+#define UEFI_VARS_REG_PIO_BUFFER_TRANSFER    0x10  /* 8-64 bit */
+#define UEFI_VARS_REG_PIO_BUFFER_CRC32C      0x18  /* 32 bit (read-only) */
+#define UEFI_VARS_REG_RESERVED               0x1c  /* 32 bit */
+#define UEFI_VARS_REGS_SIZE                  0x20
 
 /* magic value */
 #define UEFI_VARS_MAGIC_VALUE               0xef1
 
 /* command values */
 #define UEFI_VARS_CMD_RESET                  0x01
-#define UEFI_VARS_CMD_MM                     0x02
+#define UEFI_VARS_CMD_DMA_MM                 0x02
+#define UEFI_VARS_CMD_PIO_MM                 0x03
+#define UEFI_VARS_CMD_PIO_ZERO_OFFSET        0x04
 
 /* status values */
 #define UEFI_VARS_STS_SUCCESS                0x00
diff --git a/include/hw/uefi/var-service.h b/include/hw/uefi/var-service.h
index e078d2b0e68f..7dbede659a8f 100644
--- a/include/hw/uefi/var-service.h
+++ b/include/hw/uefi/var-service.h
@@ -56,6 +56,10 @@ struct uefi_vars_state {
     QTAILQ_HEAD(, uefi_variable)      variables;
     QTAILQ_HEAD(, uefi_var_policy)    var_policies;
 
+    /* pio transfer buffer */
+    uint32_t                          pio_xfer_offset;
+    uint8_t                           *pio_xfer_buffer;
+
     /* boot phases */
     bool                              end_of_dxe;
     bool                              ready_to_boot;
diff --git a/hw/uefi/var-service-core.c b/hw/uefi/var-service-core.c
index 78a668e68fa2..a96b66934769 100644
--- a/hw/uefi/var-service-core.c
+++ b/hw/uefi/var-service-core.c
@@ -4,6 +4,7 @@
  * uefi vars device
  */
 #include "qemu/osdep.h"
+#include "qemu/crc32c.h"
 #include "system/dma.h"
 #include "migration/vmstate.h"
 
@@ -41,6 +42,7 @@ const VMStateDescription vmstate_uefi_vars = {
         VMSTATE_UINT32(buf_size, uefi_vars_state),
         VMSTATE_UINT32(buf_addr_lo, uefi_vars_state),
         VMSTATE_UINT32(buf_addr_hi, uefi_vars_state),
+        /* TODO: pio xfer offset + buffer */
         VMSTATE_BOOL(end_of_dxe, uefi_vars_state),
         VMSTATE_BOOL(ready_to_boot, uefi_vars_state),
         VMSTATE_BOOL(exit_boot_service, uefi_vars_state),
@@ -54,7 +56,7 @@ const VMStateDescription vmstate_uefi_vars = {
     },
 };
 
-static uint32_t uefi_vars_cmd_mm(uefi_vars_state *uv)
+static uint32_t uefi_vars_cmd_mm(uefi_vars_state *uv, bool dma_mode)
 {
     hwaddr    dma;
     mm_header *mhdr;
@@ -69,9 +71,13 @@ static uint32_t uefi_vars_cmd_mm(uefi_vars_state *uv)
     }
 
     /* read header */
-    dma_memory_read(&address_space_memory, dma,
-                    uv->buffer, sizeof(*mhdr),
-                    MEMTXATTRS_UNSPECIFIED);
+    if (dma_mode) {
+        dma_memory_read(&address_space_memory, dma,
+                        uv->buffer, sizeof(*mhdr),
+                        MEMTXATTRS_UNSPECIFIED);
+    } else {
+        memcpy(uv->buffer, uv->pio_xfer_buffer, sizeof(*mhdr));
+    }
 
     if (uadd64_overflow(sizeof(*mhdr), mhdr->length, &size)) {
         return UEFI_VARS_STS_ERR_BAD_BUFFER_SIZE;
@@ -81,9 +87,15 @@ static uint32_t uefi_vars_cmd_mm(uefi_vars_state *uv)
     }
 
     /* read buffer (excl header) */
-    dma_memory_read(&address_space_memory, dma + sizeof(*mhdr),
-                    uv->buffer + sizeof(*mhdr), mhdr->length,
-                    MEMTXATTRS_UNSPECIFIED);
+    if (dma_mode) {
+        dma_memory_read(&address_space_memory, dma + sizeof(*mhdr),
+                        uv->buffer + sizeof(*mhdr), mhdr->length,
+                        MEMTXATTRS_UNSPECIFIED);
+    } else {
+        memcpy(uv->buffer + sizeof(*mhdr),
+               uv->pio_xfer_buffer + sizeof(*mhdr),
+               mhdr->length);
+    }
     memset(uv->buffer + size, 0, uv->buf_size - size);
 
     /* dispatch */
@@ -113,9 +125,15 @@ static uint32_t uefi_vars_cmd_mm(uefi_vars_state *uv)
     }
 
     /* write buffer */
-    dma_memory_write(&address_space_memory, dma,
-                     uv->buffer, sizeof(*mhdr) + mhdr->length,
-                     MEMTXATTRS_UNSPECIFIED);
+    if (dma_mode) {
+        dma_memory_write(&address_space_memory, dma,
+                         uv->buffer, sizeof(*mhdr) + mhdr->length,
+                         MEMTXATTRS_UNSPECIFIED);
+    } else {
+        memcpy(uv->pio_xfer_buffer + sizeof(*mhdr),
+               uv->buffer + sizeof(*mhdr),
+               sizeof(*mhdr) + mhdr->length);
+    }
 
     return retval;
 }
@@ -150,8 +168,13 @@ static uint32_t uefi_vars_cmd(uefi_vars_state *uv, uint32_t cmd)
     case UEFI_VARS_CMD_RESET:
         uefi_vars_soft_reset(uv);
         return UEFI_VARS_STS_SUCCESS;
-    case UEFI_VARS_CMD_MM:
-        return uefi_vars_cmd_mm(uv);
+    case UEFI_VARS_CMD_DMA_MM:
+        return uefi_vars_cmd_mm(uv, true);
+    case UEFI_VARS_CMD_PIO_MM:
+        return uefi_vars_cmd_mm(uv, false);
+    case UEFI_VARS_CMD_PIO_ZERO_OFFSET:
+        uv->pio_xfer_offset = 0;
+        return UEFI_VARS_STS_SUCCESS;
     default:
         return UEFI_VARS_STS_ERR_NOT_SUPPORTED;
     }
@@ -161,6 +184,7 @@ static uint64_t uefi_vars_read(void *opaque, hwaddr addr, unsigned size)
 {
     uefi_vars_state *uv = opaque;
     uint64_t retval = -1;
+    void *xfer_ptr;
 
     trace_uefi_reg_read(addr, size);
 
@@ -174,12 +198,37 @@ static uint64_t uefi_vars_read(void *opaque, hwaddr addr, unsigned size)
     case UEFI_VARS_REG_BUFFER_SIZE:
         retval = uv->buf_size;
         break;
-    case UEFI_VARS_REG_BUFFER_ADDR_LO:
+    case UEFI_VARS_REG_DMA_BUFFER_ADDR_LO:
         retval = uv->buf_addr_lo;
         break;
-    case UEFI_VARS_REG_BUFFER_ADDR_HI:
+    case UEFI_VARS_REG_DMA_BUFFER_ADDR_HI:
         retval = uv->buf_addr_hi;
         break;
+    case UEFI_VARS_REG_PIO_BUFFER_TRANSFER:
+        if (uv->pio_xfer_offset + size > uv->buf_size) {
+            retval = 0;
+            break;
+        }
+        xfer_ptr = uv->pio_xfer_buffer + uv->pio_xfer_offset;
+        switch (size) {
+        case 1:
+            retval = *(uint8_t *)xfer_ptr;
+            break;
+        case 2:
+            retval = *(uint16_t *)xfer_ptr;
+            break;
+        case 4:
+            retval = *(uint32_t *)xfer_ptr;
+            break;
+        case 8:
+            retval = *(uint64_t *)xfer_ptr;
+            break;
+        }
+        uv->pio_xfer_offset += size;
+        break;
+    case UEFI_VARS_REG_PIO_BUFFER_CRC32C:
+        retval = crc32c(0xffffffff, uv->pio_xfer_buffer, uv->pio_xfer_offset);
+        break;
     }
     return retval;
 }
@@ -187,6 +236,7 @@ static uint64_t uefi_vars_read(void *opaque, hwaddr addr, unsigned size)
 static void uefi_vars_write(void *opaque, hwaddr addr, uint64_t val, unsigned size)
 {
     uefi_vars_state *uv = opaque;
+    void *xfer_ptr;
 
     trace_uefi_reg_write(addr, val, size);
 
@@ -200,14 +250,40 @@ static void uefi_vars_write(void *opaque, hwaddr addr, uint64_t val, unsigned si
         }
         uv->buf_size = val;
         g_free(uv->buffer);
+        g_free(uv->pio_xfer_buffer);
         uv->buffer = g_malloc(uv->buf_size);
+        uv->pio_xfer_buffer = g_malloc(uv->buf_size);
         break;
-    case UEFI_VARS_REG_BUFFER_ADDR_LO:
+    case UEFI_VARS_REG_DMA_BUFFER_ADDR_LO:
         uv->buf_addr_lo = val;
         break;
-    case UEFI_VARS_REG_BUFFER_ADDR_HI:
+    case UEFI_VARS_REG_DMA_BUFFER_ADDR_HI:
         uv->buf_addr_hi = val;
         break;
+    case UEFI_VARS_REG_PIO_BUFFER_TRANSFER:
+        if (uv->pio_xfer_offset + size > uv->buf_size) {
+            break;
+        }
+        xfer_ptr = uv->pio_xfer_buffer + uv->pio_xfer_offset;
+        switch (size) {
+        case 1:
+            *(uint8_t *)xfer_ptr = val;
+            break;
+        case 2:
+            *(uint16_t *)xfer_ptr = val;
+            break;
+        case 4:
+            *(uint32_t *)xfer_ptr = val;
+            break;
+        case 8:
+            *(uint64_t *)xfer_ptr = val;
+            break;
+        }
+        uv->pio_xfer_offset += size;
+        break;
+    case UEFI_VARS_REG_PIO_BUFFER_CRC32C:
+    default:
+        break;
     }
 }
 


