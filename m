Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90EB7CD3427
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2026 17:44:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wJxKD-00081l-CH; Mon, 04 May 2026 13:43:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1wJxK7-00081L-6w
 for qemu-devel@nongnu.org; Mon, 04 May 2026 13:43:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1wJxK4-0007gN-9M
 for qemu-devel@nongnu.org; Mon, 04 May 2026 13:43:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777916591;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mqQQa0sIdgZK6GVtiZnksrInbkePHvX9cE0LybQFiho=;
 b=OCEmFLXsmL6MR/S9qR7Xi+vyfo2Kf76+LJ3nNmXQl6q3e7952gVox3NSPTdhS9HqODrIZr
 sS5w9BY2yoPl+aKk79sfLl3Au8sV8whe7pcnmIzwVazialnjE0QPqIqgyc38q0l/UvLDQV
 3Hg/LqxvUqSuC42rxWo1c1KDIjcXE1I=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-34-8cRBGPhWPFCwSLkZ2JU_ZQ-1; Mon, 04 May 2026 13:43:10 -0400
X-MC-Unique: 8cRBGPhWPFCwSLkZ2JU_ZQ-1
X-Mimecast-MFC-AGG-ID: 8cRBGPhWPFCwSLkZ2JU_ZQ_1777916589
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2b258636d16so47070885ad.2
 for <qemu-devel@nongnu.org>; Mon, 04 May 2026 10:43:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1777916588; x=1778521388; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mqQQa0sIdgZK6GVtiZnksrInbkePHvX9cE0LybQFiho=;
 b=oElN9e0TLB1q6Y0Jor+HxpiakK45AHur0+CFsROUX9OD7LKj0oiJpX+u++S9uzs6ad
 efHji+LOsdO4prqK3mJ9ka04FQ9MUkGR70k83iGiXePa+NmBkAnvbkdzO+4J8PnFNj7M
 i73NyV0R2BHuWWzLbmqIUDvOoHsWS556ND+TRFpkF1DwjxUo7IjZwEAuMmZ6MkFKKdvv
 6btTb4AUF1Hb2f3IZELuEG/GqDcoa100Va/l4z0huQzjYy3paINadSgEa6tEVizuzfhq
 oBq0l5upvfnGYKZHKiVzqVzvhtXqdbAgBSAVjQNrYOf5mTBXt/VnWcN4ewNrEiURiRBS
 75sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777916588; x=1778521388;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=mqQQa0sIdgZK6GVtiZnksrInbkePHvX9cE0LybQFiho=;
 b=luYAybNe4AjNWvD3VsCb9r+CRC91H8Kge6oTtWE8nlgRbwbl9v/TjbkAEH3+z4zgIL
 a4piqUYWtZoQMxvpiu0CxsRHhtbWs3vIjY4SFxeOX+voxYubXTMTn3Ili9Gnaodzz1OX
 fAN9ZOqLACbE1zk5B0GQGJYiLKh6w3BqqWgU30thx1m5jYzeLL+nqIGNJXV74KIq21IP
 u9r4GxoVfjC7Q55NsHtofCI8u5K7djq27KbpNPI8vfYttcxxG0rsyKt8L4pFbV9x8c8/
 sWw6GHJ9RAFjj2TnCwQSQhSfG221KHJEp8WYIPa8cOnCLd4lnk5/lPMoUBtFl9M/Ghln
 Kk9A==
X-Gm-Message-State: AOJu0YysJme1E6sYQ9DtIwO63mTelpwbxUoIsKPcAv9mNYZLr3aKYY3p
 2aHTcZ2kHthMz7AjIo6i+tkZPKfB1cYYUmjNyo/2oSMvhcYIeZ2Mfy2mfzpSb6qEon23vcGzuRR
 IO0ocMnEwvVlBgxy3pRGQH/67QQGdpf8f1Rdg9WG8jGPzb+fD+AeXYMv0aC1bSrW7pATKniPFyD
 pEo5h1ofkP9z/1KJUXFHEiriaXBQ3EImZfxpHfths=
X-Gm-Gg: AeBDieuEbAg2ok6niouqXtq7TlboqagBhfsLGGqM5A5ep02ifehhJYef0Qh68fFDKbG
 1UlHscLwFLKPwVkMnJpbLn7H3gbEfnWcORE4IhJVc3AIlYa8DqpyfRRR0DrC/ucBOA3cXhZqo7D
 9l/oNxILpNSxWB78O+SjaJZtkuJ9lvBydFEoZcWKHUemINV5ADfT6CzTGnVHjXXgww/NCprP4U3
 Al+fGa3vWpH0gDUp2UbxhDU7D9buJ5xbB0gKgT6hVc+b6+Ziz54eVEbMTnjVoAWNX1JbW7vLrc7
 xRXz5KOcWmomPYuXPNWbCDdBo26NuBfJ5oCsEgap1TrqZfFlXk5g9dxMWoXcOANMgMvrHyACbW7
 hNeBdYd/k/HEiJbRVM7F6bpryqtuYQNMGkP35CxG6L7ZbsAJmoXUFArKSpdwsE5tSTUFY2DyY
X-Received: by 2002:a17:902:ebcd:b0:2b4:5d87:a1fd with SMTP id
 d9443c01a7336-2b9f25f7302mr103679065ad.27.1777916588491; 
 Mon, 04 May 2026 10:43:08 -0700 (PDT)
X-Received: by 2002:a17:902:ebcd:b0:2b4:5d87:a1fd with SMTP id
 d9443c01a7336-2b9f25f7302mr103678735ad.27.1777916587943; 
 Mon, 04 May 2026 10:43:07 -0700 (PDT)
Received: from fedora.armenon-thinkpadp16vgen1.bengluru.csb ([49.36.108.92])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b9caaaec82sm112765315ad.24.2026.05.04.10.43.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 May 2026 10:43:07 -0700 (PDT)
From: Arun Menon <armenon@redhat.com>
To: qemu-devel@nongnu.org
Cc: Ani Sinha <anisinha@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, marcandre.lureau@redhat.com,
 Zhao Liu <zhao1.liu@intel.com>, Igor Mammedov <imammedo@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Yanan Wang <wangyanan55@huawei.com>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Arun Menon <armenon@redhat.com>,
 Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH v6 3/6] hw/tpm: Add internal buffer state for chunking
Date: Mon,  4 May 2026 23:12:31 +0530
Message-ID: <20260504174234.13556-4-armenon@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260504174234.13556-1-armenon@redhat.com>
References: <20260504174234.13556-1-armenon@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armenon@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.444,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


