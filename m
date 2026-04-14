Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C257EED7B87
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2026 08:30:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCZAJ-0007hK-9P; Tue, 14 Apr 2026 04:30:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1wCZA7-0007fX-12
 for qemu-devel@nongnu.org; Tue, 14 Apr 2026 04:30:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1wCZA5-00040N-06
 for qemu-devel@nongnu.org; Tue, 14 Apr 2026 04:30:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776155420;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6ZlI7ZJ5l97a8qYb33N5MiMsq0vmJ/gwOXd4mdNCCoE=;
 b=KP8QBFHcBkgAg+lpGHh6Z61g+kLx6mWUdr0c1W9nQ21Xq4w3a68Jj9ZMRSFprU8H58+fFK
 R3C1XOd6w4yGZSpcwttO4gXyv0WlsnB3Fpaq+UWweV0JcxyKZdd+K8/dfHdCm6prfoc2Ye
 Xbw6RyZO+TKbbsFdtXK3qMoGLBq+8k8=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-149-WWBfrX90OgmJr2P4ANiTgg-1; Tue, 14 Apr 2026 04:30:18 -0400
X-MC-Unique: WWBfrX90OgmJr2P4ANiTgg-1
X-Mimecast-MFC-AGG-ID: WWBfrX90OgmJr2P4ANiTgg_1776155418
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2b24a00d12cso55058305ad.1
 for <qemu-devel@nongnu.org>; Tue, 14 Apr 2026 01:30:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1776155417; x=1776760217; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6ZlI7ZJ5l97a8qYb33N5MiMsq0vmJ/gwOXd4mdNCCoE=;
 b=V91NdXNDxNtXqmkjJF+/EWLblz8ubYO28zlaTjb4+IXBoovO36h4te5L9DHnluPOZT
 sEii/26FBCtT8izVYM7GsWpunH1tmC1l/uv+ABZ/4ynMK6ZePqec+rrcWNeXvoLxTb77
 t4RPE1IACpX5mrVXTIhU2AcWsYmDPgDTXmN+Z7ur2PFv+AwkHPIb+PqlJ/T312xEZQ9O
 ocJwxx7tudhZ70t9rX5V9tK6m7xTKTVW1L8McXR0E19WRKiQPe3c/O0Q3yp6rFtkzsEN
 GjnjE92FIsNA3dbbYQcISTbl6qI3SP8Maw0+wQ6FIN7j62u5yAitFmdkw6a1T3Jl46qA
 hdlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776155417; x=1776760217;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=6ZlI7ZJ5l97a8qYb33N5MiMsq0vmJ/gwOXd4mdNCCoE=;
 b=fh5Q0Xpt3Pn8kVPCZGE76y3cLGYzW8pdg8TF5I1+RWibDgHeSu3rfpW6UOhAw77xeX
 OluRUcJodKyAp4UmN8+ZLzM3441DgAWdCtX3lthMsHGbrxg2EciOE6n2wntNujGwxzMQ
 d7sIMHhk1xTVVzF/CGAlkJeLo8eaX/jUUXOcFhPXtP9VK5GvG/FG3801jC1mpPdG6GDC
 MJ0mWW3rFAwtl5SNNaArl2nt1z0kzcs9rKEmoIBzN5WAXPiY6quriXiQ8ZHq7OhZZ34R
 ZoYceL415WLKO/+oq1agpdzIm+7o6h9kNgOE/fNhyGKyjnKp/xAYkS3d6DBkGCFdBUGA
 UBeg==
X-Gm-Message-State: AOJu0Yz6swUb9+k3t0DY1KmSxTHkwzc1FEUbhkTnIRKsilkCkF/nr6Mw
 R3e/feDUllRMJlksSXFSpjolKHA0cZSzNb2UN/ydNjLh2Lsv64oF+xPVWNjjsySNSfQ5GXw799M
 aiPj43Y9sPaXdcC/S03qlRzCwjWBRikznQZRDZE7Vzgwv44vnPY92VtwXW7TNk1MXPAX0Zo+qP6
 Da3XtW4x+SHkiWMSmA8lqpQ7LwT/KNzFqGBgkurrQ=
X-Gm-Gg: AeBDiesLknAkreOEvDu92UHgp1j5HQ1qIFy++H/Tof2ntCZlE4mwXiRKdjIyl6t5PeU
 G+A802z7Y6PpfY3n6Rq+4f7Go22rrWJDmoD94fdNpKlY8DlaMJJ1xRdNM1WQff3CTRdzHdAR82b
 pWQq5YPXhueH9Indpq+j/LNS+XE6oVF5/CdHr2ysfqn0hAtm3kuHnsTHRWZeb3s7K2hdtWRTIsC
 2i1H/J7jwUYQligVbabNQDpfZvNUlsbaqkdisIMxi7hbUsij6CPOGbm580PF2h3vJ8aZEIBTipQ
 UPP6F9y14yZU0is9FdpydfnXoKQMAWU2+R98bNe8fF7t8BwmcAbv3DToJ7bCMptt8xcr00Axro6
 JTbCQqACyHb4xs/HrQyxIfoh6DWFRJosXXblCQQ203xvgJ83b9/prd+1wmM3WfHI=
X-Received: by 2002:a17:903:289:b0:2b4:5e65:5d0e with SMTP id
 d9443c01a7336-2b45e655efamr77399095ad.10.1776155417493; 
 Tue, 14 Apr 2026 01:30:17 -0700 (PDT)
X-Received: by 2002:a17:903:289:b0:2b4:5e65:5d0e with SMTP id
 d9443c01a7336-2b45e655efamr77394665ad.10.1776155411684; 
 Tue, 14 Apr 2026 01:30:11 -0700 (PDT)
Received: from fedora.armenon-thinkpadp16vgen1.bengluru.csb ([49.36.110.202])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b2d4e0f909sm181493785ad.35.2026.04.14.01.30.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Apr 2026 01:30:11 -0700 (PDT)
From: Arun Menon <armenon@redhat.com>
To: qemu-devel@nongnu.org
Cc: Yanan Wang <wangyanan55@huawei.com>, Ani Sinha <anisinha@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Zhao Liu <zhao1.liu@intel.com>, marcandre.lureau@redhat.com,
 Igor Mammedov <imammedo@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Arun Menon <armenon@redhat.com>
Subject: [PATCH v4 03/10] hw/tpm: Add internal buffer state for chunking
Date: Tue, 14 Apr 2026 13:59:08 +0530
Message-ID: <20260414082915.112122-4-armenon@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260414082915.112122-1-armenon@redhat.com>
References: <20260414082915.112122-1-armenon@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armenon@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/tpm/tpm_crb.c | 33 +++++++++++++++++++++++++++++----
 1 file changed, 29 insertions(+), 4 deletions(-)

diff --git a/hw/tpm/tpm_crb.c b/hw/tpm/tpm_crb.c
index 8e6ec44711..89f4113c97 100644
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
@@ -318,12 +334,21 @@ static void tpm_crb_realize(DeviceState *dev, Error **errp)
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
2.53.0


