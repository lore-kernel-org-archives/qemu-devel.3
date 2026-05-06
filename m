Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 865BDCD3424
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2026 07:58:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKX9Y-0004wW-IX; Wed, 06 May 2026 03:58:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1wKX9X-0004wN-Fd
 for qemu-devel@nongnu.org; Wed, 06 May 2026 03:58:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1wKX9V-0000eh-Tm
 for qemu-devel@nongnu.org; Wed, 06 May 2026 03:58:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778054321;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mqQQa0sIdgZK6GVtiZnksrInbkePHvX9cE0LybQFiho=;
 b=eclsfoytS0bgmsF8ZTxh1Qv+y40I0jICbDw3SNfcrFJaIvsh4Ggzzngaf3zdFyw+X0Ewa4
 pVU9fjkCOEPa+9r1cnDDXVH6dCEefankcizus1mVSLdhmIY8llqbiYO+heZSJNWh9XVnnB
 ttePAyzharUizE04sN3FmXUEkd/sihA=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-633-QF_NSvnBMyyjkh7MgOWMhQ-1; Wed, 06 May 2026 03:58:39 -0400
X-MC-Unique: QF_NSvnBMyyjkh7MgOWMhQ-1
X-Mimecast-MFC-AGG-ID: QF_NSvnBMyyjkh7MgOWMhQ_1778054319
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2b4654f9bb6so63616545ad.2
 for <qemu-devel@nongnu.org>; Wed, 06 May 2026 00:58:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1778054318; x=1778659118; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mqQQa0sIdgZK6GVtiZnksrInbkePHvX9cE0LybQFiho=;
 b=CP4xgpSgtHv0d6CJ137je5MkmzTKyKjQS3mPnlid5yPCZ1n8fVOkF10WHd/jajkRFs
 BkBJP7PHcpkObY7JBoFXkFa2l3FKTVnMI/h4U07uBI/4hGB6TXZ8HU2srb4tTT1WzrSY
 xzbD2K7WBhG0teLJeZ8hb5bkNE21o1S1UFymZzjJi/qnZ3R0eL8DiDRHWU3oZhgOJTA6
 vFqs7t6lcIaae3tPdcXQxtA30NtqADB3fkFurrpmpHrJ2Idg1ACxz/djce4dArlgoUVD
 HK9YIS/TnsFbqHXnPwXQFkpyF2YPr/4J+x5CQhROvxrY47qYb4n49+AjUhpRHjQn56BW
 0tjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778054318; x=1778659118;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=mqQQa0sIdgZK6GVtiZnksrInbkePHvX9cE0LybQFiho=;
 b=PknxQijkhnQ0l8hOI3nj8v9isJb0esD0pQwS/eo1kh5yl2DyWxQfgGJnZlCh+3mnnr
 7Z3a7W9jujYko773M22NNNpiBLWwj26QfARc56yS5Cjqq8QQKncydLybk+/AOKoUTnMd
 cMefdGrcpztq/pzszLXK9Fe2lvelvI+0TALzsB3bvUxmR78LNQnZ9+XK2UZNVfsyco+d
 27NSrmywS0d0p0WnkcTUeXALjcG6zwEJ4aI4EZHYGpX/UWvEeFJ9HqyBQsCSpyML2AFI
 04hCLfUU2PuGuFk98pP6GYlq9NSAEPP72JTG9qeXDBSUeoq7pVqAiJNT+NjE1ZZwfsYl
 ymDw==
X-Gm-Message-State: AOJu0Yx4FFTTlUjN98v6txdDRE1ueSyhT95FZtbYUiv9Yq3upHyFFOLM
 OYOsc34HSdLhRiS7ED+W3Z+aU71KDUI9qbhG6W3bJz/LZ7JIE50Ax//EPNfLDFQd3u6A1Prps+0
 Btuk4EIwawCuXdake8AwOg8tgD4c7rUeON2PKglphGVdsejWkmjc365e2Nopibb6JqtSNB7Shot
 DsLZsTKYV5UHLuH6F8eXwsEB8wjBqOmNFg7CW9d0U=
X-Gm-Gg: AeBDietgD2RDdk11bhxBuzZbH0XIsAVUfpNClVWsouPmUU7YEW4eqGTRGnZtHmxlffA
 JIpLzS3FTgdNTzViXfJey2eSwTblCWAb1dLM0ynkwpp2di0icPl+iz6GhtEEkyn5m5cv5Nn+d08
 F54GZ7pEjz4w+MYiiky1tWx99I2j9G1av7umj+VMf7BzOY/Uf3TnOIuF06fYSC5j3OiZl5Jt/GD
 qphfmxAS+uSGV51Tx0Go6J/dbKl0tKEVmgX0xd0AIa7EEaYJhZENAv51hw6Vc3cnwpF+GzSxHF9
 1YGrIGROpUoiMvAnrXZGIyQqZd/VUQLjx52lEU80N/TEY3OHRpGk/5AXgYCWyyAonniyQ0kudVL
 d0ydQjb5DRR9/pA185Gf6W9+uJjF17oBlO/qPhOGXPI/cFQcNVN4+eKftaj+vnK0Khu3WsN94
X-Received: by 2002:a17:903:90e:b0:2b2:4d36:7ba with SMTP id
 d9443c01a7336-2ba78831407mr24044745ad.0.1778054318407; 
 Wed, 06 May 2026 00:58:38 -0700 (PDT)
X-Received: by 2002:a17:903:90e:b0:2b2:4d36:7ba with SMTP id
 d9443c01a7336-2ba78831407mr24044425ad.0.1778054317739; 
 Wed, 06 May 2026 00:58:37 -0700 (PDT)
Received: from fedora.armenon-thinkpadp16vgen1.bengluru.csb ([49.36.106.26])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ba7ca29f9dsm15439865ad.78.2026.05.06.00.58.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 May 2026 00:58:37 -0700 (PDT)
From: Arun Menon <armenon@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Ani Sinha <anisinha@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 marcandre.lureau@redhat.com, Stefan Berger <stefanb@linux.vnet.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Arun Menon <armenon@redhat.com>,
 Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH v7 3/6] hw/tpm: Add internal buffer state for chunking
Date: Wed,  6 May 2026 13:28:10 +0530
Message-ID: <20260506075813.120781-4-armenon@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260506075813.120781-1-armenon@redhat.com>
References: <20260506075813.120781-1-armenon@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armenon@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.443,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Arun Menon <armenon@redhat.com>

- Introduce GByteArray buffers to hold the command request and response
  data during chunked TPM CRB transactions.
- Add helper function to clean them.

Signed-off-by: Arun Menon <armenon@redhat.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
---
 hw/tpm/tpm_crb.c | 33 +++++++++++++++++++++++++++++----
 1 file changed, 29 insertions(+), 4 deletions(-)

diff --git a/hw/tpm/tpm_crb.c b/hw/tpm/tpm_crb.c
index a0f472652e..1c944d7ef2 100644
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
+    uint32_t response_offset;
 
     TPMPPI ppi;
 
@@ -86,6 +89,13 @@ enum crb_cancel {
 
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
@@ -135,9 +145,11 @@ static void tpm_crb_mmio_write(void *opaque, hwaddr addr,
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
@@ -239,6 +251,7 @@ static void tpm_crb_reset(void *dev)
 
     tpm_ppi_reset(&s->ppi);
     tpm_backend_reset(s->tpmbe);
+    tpm_crb_clear_internal_buffers(s);
 
     memset(s->regs, 0, sizeof(s->regs));
 
@@ -305,6 +318,9 @@ static void tpm_crb_realize(DeviceState *dev, Error **errp)
     memory_region_add_subregion(get_system_memory(),
         TPM_CRB_ADDR_BASE + sizeof(s->regs), &s->cmdmem);
 
+    s->command_buffer = g_byte_array_new();
+    s->response_buffer = g_byte_array_new();
+
     tpm_ppi_init(&s->ppi, get_system_memory(),
                  TPM_PPI_ADDR_BASE, OBJECT(s));
 
@@ -315,12 +331,21 @@ static void tpm_crb_realize(DeviceState *dev, Error **errp)
     }
 }
 
+static void tpm_crb_unrealize(DeviceState *dev)
+{
+    CRBState *s = CRB(dev);
+
+    g_clear_pointer(&s->command_buffer, g_byte_array_unref);
+    g_clear_pointer(&s->response_buffer, g_byte_array_unref);
+}
+
 static void tpm_crb_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     TPMIfClass *tc = TPM_IF_CLASS(klass);
 
     dc->realize = tpm_crb_realize;
+    dc->unrealize = tpm_crb_unrealize;
     device_class_set_props(dc, tpm_crb_properties);
     dc->vmsd  = &vmstate_tpm_crb;
     dc->user_creatable = true;
-- 
2.54.0


