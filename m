Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11F1CFED2C7
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2026 04:18:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0XU2-000072-9e; Thu, 12 Mar 2026 00:17:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1w0XU0-00006r-W5
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 00:17:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1w0XTz-0008Mr-BH
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 00:17:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773289030;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Nn9cnFzQCohdSXh/nDWLLWO6UQoCzNVf3KGkEpV9fas=;
 b=K/j5vU4HOcIoyD8NUb7R2LDUVAuRKLK/W/Zt/x79DpYTPANJK2ft10nSH3Z47VfnCE4lV9
 P0i8noavmhMlAQQh1ezV+QxHi3P3Tcgf4zuG5KV5d8d9oNbja9E3BdWInLCBPP1KbJO66j
 Wl5wm4VrctzpD5EA40taL+htqjI9x2U=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-542-Jk-85O8VPy2H5wDiuMwRdA-1; Thu, 12 Mar 2026 00:17:09 -0400
X-MC-Unique: Jk-85O8VPy2H5wDiuMwRdA-1
X-Mimecast-MFC-AGG-ID: Jk-85O8VPy2H5wDiuMwRdA_1773289028
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-b62da7602a0so495294a12.2
 for <qemu-devel@nongnu.org>; Wed, 11 Mar 2026 21:17:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1773289028; x=1773893828; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Nn9cnFzQCohdSXh/nDWLLWO6UQoCzNVf3KGkEpV9fas=;
 b=faSlKOk6OCj4ZFY23DuAEVX/nY3qZMRDAr+vXISrnXoJRgyBXAr1Oj4R+kH8qksALq
 52jmWrjqphamapOjNtvK5o+8fRloyf8nzDTj0zS3cOk22cVR4SGq4dyAPS9TCORC1cI1
 BdX5xnvrcl/MGf2CaYkaS8syl2hpOcxIpbLtUxZ0no0Glmo7z4oz1TFOqO+CSoOXDvgJ
 mh/p6ajaTz0D8c1knoYTVm7/EFUHY2FiX531VBQYmRq/w8K1JhN2JF1rha+rgUI0CBQi
 D0oI1REyaokusm4ojQLildWEkDd8WmLxYBEypPrJoCtWhUD748IrHpgT9Kea8IizZS/H
 ki5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773289028; x=1773893828;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Nn9cnFzQCohdSXh/nDWLLWO6UQoCzNVf3KGkEpV9fas=;
 b=ACyUZu4ko4mFTi1xzHfHJ6n/srU2XfLgWgvs07Fhr0iz3tbovfSmO2v+RqndHa6PVY
 gEraQI980ON0YfceRzY/X2oQSXl3ocwrbKgd8fCTlPru4PGLfL560Ahme/cYbWBBzJJ2
 TXk0I0orzFApMZbBXkLXPtdOi9fn/kdQEiTPmVeQv5zMBMXwzerWgTLo81RGW8StZbis
 /c7tYmI87kpm9Mdi5TCSJSgUD5QKgwDjS+arqspWjWDxaRRjstT2JX2gsMV5jRJvf6Ru
 sFbdsMYVS+yGCoEebHo0ZZAL8naFVhUo5hFh+WaxLCqb8yy2RYnsVW5YljNg0FVkGE4p
 O0Vw==
X-Gm-Message-State: AOJu0YxscjOqcU0oRbxqwVlDdQKarI0KQ+CqXKWB2rZAzWnNRcF/33Hc
 /aS1bsqselXIpxxCDDfzp67bJteXikD+6PTLSv5ecPXl8AFKPcTWhB6Vqs5U5RGMNFdK/zqxmCP
 qzPu1MwZB6W7z/Md1holYa4eglAdjuPC4XeHrpiQUFgSFT2vLZnMyD0OdHJ6DQn/+e6Ezu7Buo1
 Mcru0wTcnSuLZCWxbum7C3soLC/L+pn9Niw1CxK6A=
X-Gm-Gg: ATEYQzzi/URtpFr6JUNQd5XOu3do5kOovh8WA5CLm9r+P07CKmKLeIlloQq2dRGSu7u
 TgH01+MztUYLw4c9UH5UQRADqAR676X6vU4gpq1rIN2i9BEfod09eCr0RT3b4Ff6Ow/lwaF3B6t
 UojUe05Dcpiiq3ldu5K/gKAIFEU0gIW/3Rj4AsxcwwpUr2zDcggAnWY4pMfKaG72/z4iIRctiWp
 9aePjtQ9Yfrnq93cJBv3HGOAdnvHl8tD4C8afFH/ErKa+zB8BZRSV4vz+873GfvfEYLODN+0uaX
 cRaxiGecuyMlxUTPlEeb4gGXARzZbZctnr5VelKziVyuXK7dCP69vIe/SINyqQwjz5wcUe/ojog
 iVBN3z5SyM+OnV2TOfonL6T4wnEplfGc/2f3hGIiNNft6LnEqh1rJ7JyL7ucZPw==
X-Received: by 2002:a05:6a21:494:b0:38d:ee68:2c60 with SMTP id
 adf61e73a8af0-398c612ba54mr4868387637.52.1773289028034; 
 Wed, 11 Mar 2026 21:17:08 -0700 (PDT)
X-Received: by 2002:a05:6a21:494:b0:38d:ee68:2c60 with SMTP id
 adf61e73a8af0-398c612ba54mr4868350637.52.1773289027514; 
 Wed, 11 Mar 2026 21:17:07 -0700 (PDT)
Received: from fedora.armenon-thinkpadp16vgen1.bengluru.csb ([49.36.110.66])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c73cdf0e498sm3634490a12.3.2026.03.11.21.17.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Mar 2026 21:17:07 -0700 (PDT)
From: Arun Menon <armenon@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Berger <stefanb@linux.vnet.ibm.com>,
 Ani Sinha <anisinha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 marcandre.lureau@redhat.com, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Arun Menon <armenon@redhat.com>
Subject: [RFC 3/5] hw/tpm: Add internal buffer state for chunking
Date: Thu, 12 Mar 2026 09:46:48 +0530
Message-ID: <20260312041650.181411-4-armenon@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260312041650.181411-1-armenon@redhat.com>
References: <20260312041650.181411-1-armenon@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armenon@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

- Introduce GByteArray buffers to hold the command request and response
  data during chunked TPM CRB transactions.
- Add helper function to clean them.

Signed-off-by: Arun Menon <armenon@redhat.com>
---
 hw/tpm/tpm_crb.c | 24 ++++++++++++++++++++----
 1 file changed, 20 insertions(+), 4 deletions(-)

diff --git a/hw/tpm/tpm_crb.c b/hw/tpm/tpm_crb.c
index bc55908786..5ea1a4a970 100644
--- a/hw/tpm/tpm_crb.c
+++ b/hw/tpm/tpm_crb.c
@@ -38,10 +38,13 @@ struct CRBState {
     TPMBackend *tpmbe;
     TPMBackendCmd cmd;
     uint32_t regs[TPM_CRB_R_MAX];
+    size_t be_buffer_size;
     MemoryRegion mmio;
     MemoryRegion cmdmem;
 
-    size_t be_buffer_size;
+    GByteArray *command_buffer;
+    GByteArray *response_buffer;
+    size_t response_offset;
 
     bool ppi_enabled;
     TPMPPI ppi;
@@ -85,6 +88,13 @@ enum crb_cancel {
 
 #define TPM_CRB_NO_LOCALITY 0xff
 
+static void tpm_crb_clear_internal_buffers(CRBState *s)
+{
+    g_byte_array_set_size(s->response_buffer, 0);
+    g_byte_array_set_size(s->command_buffer, 0);
+    s->response_offset = 0;
+}
+
 static uint64_t tpm_crb_mmio_read(void *opaque, hwaddr addr,
                                   unsigned size)
 {
@@ -134,9 +144,11 @@ static void tpm_crb_mmio_write(void *opaque, hwaddr addr,
         }
         break;
     case A_CRB_CTRL_CANCEL:
-        if (val == CRB_CANCEL_INVOKE &&
-            s->regs[R_CRB_CTRL_START] & CRB_START_INVOKE) {
-            tpm_backend_cancel_cmd(s->tpmbe);
+        if (val == CRB_CANCEL_INVOKE) {
+            if (s->regs[R_CRB_CTRL_START] & CRB_START_INVOKE) {
+                tpm_backend_cancel_cmd(s->tpmbe);
+            }
+            tpm_crb_clear_internal_buffers(s);
         }
         break;
     case A_CRB_CTRL_START:
@@ -240,6 +252,7 @@ static void tpm_crb_reset(void *dev)
         tpm_ppi_reset(&s->ppi);
     }
     tpm_backend_reset(s->tpmbe);
+    tpm_crb_clear_internal_buffers(s);
 
     memset(s->regs, 0, sizeof(s->regs));
 
@@ -306,6 +319,9 @@ static void tpm_crb_realize(DeviceState *dev, Error **errp)
     memory_region_add_subregion(get_system_memory(),
         TPM_CRB_ADDR_BASE + sizeof(s->regs), &s->cmdmem);
 
+    s->command_buffer = g_byte_array_new();
+    s->response_buffer = g_byte_array_new();
+
     if (s->ppi_enabled) {
         tpm_ppi_init(&s->ppi, get_system_memory(),
                      TPM_PPI_ADDR_BASE, OBJECT(s));
-- 
2.53.0


