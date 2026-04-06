Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06FAAF46C48
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2026 14:18:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w9kmN-0003tu-Ev; Mon, 06 Apr 2026 10:18:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1w9kmM-0003te-5l
 for qemu-devel@nongnu.org; Mon, 06 Apr 2026 10:18:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1w9kmK-00053X-L5
 for qemu-devel@nongnu.org; Mon, 06 Apr 2026 10:18:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1775485092;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jLLYAnrleD9NK24SJY9DaTHQk/BqQZ5iTJMqFUtwcT0=;
 b=g3Q1LunXN/P19YzVOWYSUUY2Z4AkyzQ/TaKXNPrwhcIEFMKGkVi2qvh6/xNrghvSjCSd/5
 dqa0K9SS/c4Kizb2bCpvaiodBFc0YhLpuprXJUBd5qPvu0HtR/KxbsYbsjbb3FIrSvPt4/
 +sRrmy/izXzuv812L98APvKKgkOnbnI=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-84-B_zLYUWuONyMW_wZAikp8g-1; Mon, 06 Apr 2026 10:18:11 -0400
X-MC-Unique: B_zLYUWuONyMW_wZAikp8g-1
X-Mimecast-MFC-AGG-ID: B_zLYUWuONyMW_wZAikp8g_1775485090
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2adef9d486bso62579045ad.2
 for <qemu-devel@nongnu.org>; Mon, 06 Apr 2026 07:18:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1775485090; x=1776089890; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jLLYAnrleD9NK24SJY9DaTHQk/BqQZ5iTJMqFUtwcT0=;
 b=GnEd6UaeJV2bJWqEFxZtfv/u86u/kkeFE/1+YWj8yjeP72fHTuzpe6XSEHcm1YDNpK
 xkc7rN3USfHPV2WD25mPPPpu2rGBB4zE88akP7e5/MKFhHlnIvn6WsoV0PNa7baTNuYx
 a9xj8wnWrVDQazx8sN874Xz8fuDHt+SlW8d47GWRTiHchEktd0NBL5dVYEqzmqtUtg5q
 tCtvxh5DJsXlsXzjyFOsixpizpIqI6Zv1w6oB79u+54f3iXYJv2x2ZpzTbALTVLRFA4I
 wDYVeKlPfFPqiJglKeZcikLXXgPmk5uknJUb+LXX1uOTPdYRgPD+CgOnafoquSZigfY7
 q1Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775485090; x=1776089890;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=jLLYAnrleD9NK24SJY9DaTHQk/BqQZ5iTJMqFUtwcT0=;
 b=G63hV0+VW4jjc8ARNKKgrji7r9KJr+aGVln3THlhpHw/vLd25dWzh0hZq2PSqOoPW4
 AZoiTlmzKxABpYFvgDLakfsHcd955dRWCQkk+EAl+4jf+Uej/un9azn16/uTlAlWD1N1
 AopvkfYQMbNwd/349nkm9M9+fVyftziAk75M986E2ArVsQJ8JqxogzVypFV4f86lmxKE
 pjTey03FlsxzI5fkJZF388J8LDpUDn911dodyGCUWz5K3rv/jCKwkUVfDlWeWJFECK7S
 mLzWg+xyvm/KJiLVk3OiWzxOIQ3ngZs2A5wfdBNWX31BJoAz5Y37wikZO8kOy0kuH3AI
 Tibg==
X-Gm-Message-State: AOJu0YxUiY9f9rJJtLsCKZoDmHFJEDy/kucu20toNUtrqDSwiy5QJlcQ
 /LLH0Nf9t3FkbhyLZi7wrnoFrSo3nHzgI5FyKSl5p480ymRi2fs8M2c0cHgkBMMVW68bR10BHBi
 tbIMr9tqr6tB6FvGKa+dVRR7aKo5+Bp0Nlqr7gLnpX5i25/8/4yEwUVopbZaEMlTfG2jkswYPfO
 e5RMI7eMW/9GeE2ScddHpmIpyFBZ7l10siGxS3PaI=
X-Gm-Gg: AeBDieuRhRUL62/5jzaNOM16Kw8Trf1nEYAQFK5gFq9axaNVNSy46mcxEIoh4lsuTIP
 ywUWdCO+kgcLMpJxaPlNK4TVectV9f/679EVG/uIRdwjJBIEBLSvK+ws495edjqu2uDEGR5bdWl
 9hhiaAQL9K20DCjp3mPD5zpGCRCvnLGuVLIQoBBc3wMB8Ui5m9tp+lv7Te3lZXcqv27dXsCGTlt
 niuHrXS0bvODTxCHV0pqSzVC9Vx1gGMTP4D0LqS11ZI/Yan3JKf2cDdWw6x0oFvA8KtKFmCyKYj
 tjfeTEXqK2aqkdcsyoDd0KnF+icR190vGtUAWH40ttjiQp4eet0rH0CNMSHCJWfthWJwQNINPA/
 ZdCOy0J8yWqTgmxWzwrYDtFqScMDvz09/37IN7NyqygFILzAWTCoJfTEqDIzzQ+1KDvw=
X-Received: by 2002:a17:902:d50e:b0:2b0:5520:f497 with SMTP id
 d9443c01a7336-2b28164ceeemr137327305ad.9.1775485089463; 
 Mon, 06 Apr 2026 07:18:09 -0700 (PDT)
X-Received: by 2002:a17:902:d50e:b0:2b0:5520:f497 with SMTP id
 d9443c01a7336-2b28164ceeemr137326875ad.9.1775485088830; 
 Mon, 06 Apr 2026 07:18:08 -0700 (PDT)
Received: from fedora.armenon-thinkpadp16vgen1.bengluru.csb ([152.59.100.84])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b27478cb4fsm156732905ad.29.2026.04.06.07.18.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Apr 2026 07:18:08 -0700 (PDT)
From: Arun Menon <armenon@redhat.com>
To: qemu-devel@nongnu.org
Cc: Ani Sinha <anisinha@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, Stefan Berger <stefanb@linux.vnet.ibm.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 marcandre.lureau@redhat.com, "Michael S. Tsirkin" <mst@redhat.com>,
 Yanan Wang <wangyanan55@huawei.com>, Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Arun Menon <armenon@redhat.com>
Subject: [PATCH v3 03/10] hw/tpm: Add internal buffer state for chunking
Date: Mon,  6 Apr 2026 19:47:28 +0530
Message-ID: <20260406141735.25844-4-armenon@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260406141735.25844-1-armenon@redhat.com>
References: <20260406141735.25844-1-armenon@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armenon@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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
---
 hw/tpm/tpm_crb.c | 34 ++++++++++++++++++++++++++++++----
 1 file changed, 30 insertions(+), 4 deletions(-)

diff --git a/hw/tpm/tpm_crb.c b/hw/tpm/tpm_crb.c
index bc55908786..d65b3e2cc1 100644
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
@@ -318,12 +334,22 @@ static void tpm_crb_realize(DeviceState *dev, Error **errp)
     }
 }
 
+static void tpm_crb_unrealize(DeviceState *dev)
+{
+    CRBState *s = CRB(dev);
+
+    g_byte_array_unref(s->command_buffer);
+    g_byte_array_unref(s->response_buffer);
+
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
2.53.0


