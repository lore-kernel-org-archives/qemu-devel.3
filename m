Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BD14109022B
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2026 13:54:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3Dp3-0005pu-5e; Thu, 19 Mar 2026 09:54:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1w3Dom-0005d7-FC
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 09:53:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1w3Dok-00010i-DU
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 09:53:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773928421;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Nn9cnFzQCohdSXh/nDWLLWO6UQoCzNVf3KGkEpV9fas=;
 b=DWL9MzO55FSxJrGmoKCE3dieLR4DZ7lrHcnQgsAunuEaTMaTdI/6UVIAEiKm2YPxzaOHXo
 5vqrky9GC4Cix6em2Mi5beD50B6FG+AKm7Iepnqq1f+aJQnguFDneBsGQtn2n9I6WS51PO
 m+515/VASvisbL/rWmDFA5mQkiug3OQ=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-139-16uOYFV4N3qCej-GzOE_Xw-1; Thu, 19 Mar 2026 09:53:40 -0400
X-MC-Unique: 16uOYFV4N3qCej-GzOE_Xw-1
X-Mimecast-MFC-AGG-ID: 16uOYFV4N3qCej-GzOE_Xw_1773928419
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2b059511554so66493815ad.0
 for <qemu-devel@nongnu.org>; Thu, 19 Mar 2026 06:53:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1773928418; x=1774533218; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Nn9cnFzQCohdSXh/nDWLLWO6UQoCzNVf3KGkEpV9fas=;
 b=XEsYE5ci5S3VKiXocNaVplDpN/ZsPhpkL/Y1aQsXHZ1ePPOisu99FHdBLo37sdkA0c
 pTvlnZo5vEuFmVqmNQq7PD3WdLP5qlR0tNDrFcGc3qFgF9/8asQYtfoDP5LI9H3JJQD8
 9JVLMsD0P12SEa1XY3sQpap93sdLL8dZJ7YBkAfBmjEWr/pUBcmmQlA+qy9WyN5u0XVU
 +RHXs2wz7aBFGzbwEJDFO3aREb7xepb24O66duvJxdVLkI8YLvvP7AP25Wg2NlIUuHxu
 Gukx4qacIFk8KTRhPiak2q8YFVhaLNOnFDZCSdrJbq0jWzSbF54p76EBY3o8XnbZhiCj
 u2BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773928418; x=1774533218;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Nn9cnFzQCohdSXh/nDWLLWO6UQoCzNVf3KGkEpV9fas=;
 b=nh9/0jIi691t+IK/GD5fSj0tROlhR9FT6pqkKrwA50NgW1FvdQr+ZObbgF6WhDc/Bu
 jHRgDdj7/+VZYfPK038FdcKfB7G4PAWncvtYTAMv0ypZ8UXDY7FgTSBHJpb2mPo/iJ+5
 waY/KIKkqC1U6ahFK5kAK3CTQDTZugjsDaB2MtjX3i9P6D8nqWEzc1cCHn431cEX2SMT
 pgMGOBAS9Ja3kdJIU+CzlAccTJf0eLJdzKjpsCdcw6hXWhH1hBjdsux67qg/1a4tDU+/
 HecYE5BrNVQXrVkrQW3BBEd3IagiX4XpOz4ggvnlkumiaxslQbArtdpc0dIqxVCvOlYo
 Qgdw==
X-Gm-Message-State: AOJu0YxMCQjYtp/2MRdyqHQe1GBCTOIzWyI7jMbP1lkTohkuteZZ5SeY
 qltGyITQxKf+rGic2Ykkis+KfLkQ1819jsLPb0R2gGhy/ore+CLvLMTMe1IXgb+x26S4LODOclu
 Zp6j0tEr4w3pfToCxOJ+MWpMQwzbF6MqqOYBpD+RGzDKCPtIQiBlxRCH6E8bkoN0VFtpo/GpLPw
 VBh2wxBqstyaXQM4BK1qkc4qfBrU/sxpebTVW58R0=
X-Gm-Gg: ATEYQzyO2yLKA4kLdzBAYObuW4HdHMXIdtHrthf/g7YujVXjppoju7+OkB/hsCNDqwd
 3Hh6ojiufHudntuyrvVJas1lIqgu7B86+bcleAnbAlfSCKp6Zl9+kFfjjaoBZXpoNaOfbr0k8dJ
 Lbwo3jH1hfwYCwcrxLtBChBGF7BKsSPVbDJx+Tc2Tm88SWfZere6IlfKn9OGR1HxKkr3S7vLZfq
 1T2/QwRV8FfwQd4wL5L9qcaCfizBJ8oxk3lPeeBrDEW+8bDAfDgby0r0Cz+vm0F9q5zPaqczH6N
 0Kt9+nmQMpA8iODS/0/MyCAwY26hH+dzUI4LaStXAnlGqpWTqu/wo4MQ3Z9+a2+w99MxHKWPjWi
 xMwpKD8N5GuZQhtbZY4mCMPlCHF7Gri007hj5auNGbOZyAqMDi2QsNrzh/9BGIQ==
X-Received: by 2002:a17:903:1a0e:b0:2ae:59d3:27f8 with SMTP id
 d9443c01a7336-2b06e364b30mr72596275ad.19.1773928418632; 
 Thu, 19 Mar 2026 06:53:38 -0700 (PDT)
X-Received: by 2002:a17:903:1a0e:b0:2ae:59d3:27f8 with SMTP id
 d9443c01a7336-2b06e364b30mr72595915ad.19.1773928418109; 
 Thu, 19 Mar 2026 06:53:38 -0700 (PDT)
Received: from fedora.armenon-thinkpadp16vgen1.bengluru.csb ([49.36.104.12])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b06e6216c5sm77287025ad.73.2026.03.19.06.53.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Mar 2026 06:53:37 -0700 (PDT)
From: Arun Menon <armenon@redhat.com>
To: qemu-devel@nongnu.org
Cc: Ani Sinha <anisinha@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Laurent Vivier <lvivier@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>, marcandre.lureau@redhat.com,
 Fabiano Rosas <farosas@suse.de>, Paolo Bonzini <pbonzini@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Arun Menon <armenon@redhat.com>
Subject: [RFC v2 3/7] hw/tpm: Add internal buffer state for chunking
Date: Thu, 19 Mar 2026 19:23:12 +0530
Message-ID: <20260319135316.37412-4-armenon@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260319135316.37412-1-armenon@redhat.com>
References: <20260319135316.37412-1-armenon@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armenon@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


