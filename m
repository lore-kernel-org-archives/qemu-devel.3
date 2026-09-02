Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6E3FC624D3
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2026 14:22:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1lr0-0002Mn-5x; Wed, 02 Sep 2026 10:22:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leonardi@redhat.com>)
 id 1x1lqy-0002MO-8u
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 10:22:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leonardi@redhat.com>)
 id 1x1lqw-0007ta-H3
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 10:22:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788358933;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OP1jnqi4mJJzRIl3OIYQpm6OFSO+ZwM3P7Nwbo9pGFQ=;
 b=TzcKTkUimcR8AvVvQZfBAIHKPzBx+sFasnb/ttdSrmxpCr3Nn2lxRo2qH3VDJsQrbiJKlE
 W2dyS04aUAJFA/IUKryXYY6ZWAB7HsLPAhUcSIY+1iVPCukR1R2MVMSDtQpOijSG1awxwt
 B4XadIaEa/ww0X1QQb2Oc66B6P/iL3M=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-656-W1SaiBy9ODeRQWxGUZL7aw-1; Wed, 02 Sep 2026 10:22:12 -0400
X-MC-Unique: W1SaiBy9ODeRQWxGUZL7aw-1
X-Mimecast-MFC-AGG-ID: W1SaiBy9ODeRQWxGUZL7aw_1788358931
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-493fa6e28a7so10725635e9.1
 for <qemu-devel@nongnu.org>; Wed, 02 Sep 2026 07:22:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1788358931; x=1788963731; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=OP1jnqi4mJJzRIl3OIYQpm6OFSO+ZwM3P7Nwbo9pGFQ=;
 b=tf2zkZNybQYsFyffq78RlYUAbwq/znyazJQp+R71JpFtmkzqT3vsYAsTAdnhqXuEDY
 emq2iKvxrIP8W/f8ZGyDsxvtq9QEX77dyI0JR11l4uD1J8BALiQk7y6lwh2nk1h6+iLq
 jFjP7kOrq53ytXTyBQO8fiSG3LFqfDU0SjtJray7+oJ5WKJ2uKxTuRVPhggUSVDhGT3q
 ZCeKZzZGHbHtTYd5T+MVV2AjAdPeIfy42i9aVQdtAHmMiMAN2DgLZbLFl2eYUwU5CLuk
 nRETYFziSsNfTF61HabNMZRZdlLT1WvI1ug8YEWSwVlZjNDQJZgcer3hk1IS04308z6u
 RhOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788358931; x=1788963731;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=OP1jnqi4mJJzRIl3OIYQpm6OFSO+ZwM3P7Nwbo9pGFQ=;
 b=n914bM90gZXZHGnaqKAf5aOlGVSeRxpXqjeDVU90Vi9mv7VGSen03D9oXewClmafiV
 NdqPLd/jxZiwAahO6B6/i2mp3z6AavajKWlQcb+qR2cAUmz/02y9rqz8ekUPl+V1wCJF
 CPaDjbq3NwQ2gZPzWSjja9iDQ+gguXrzsDfxAi1vsZB24x5HNYdXPWgsTT2pwRXOLtA8
 OUJNKMttqIirW9DBBqa/NC5inbM4NCpPxRrZNnllpy8Fpu9pk/Kar5D1oVIVhaJ7Tkci
 HkesEBMXNeGZoL2fTnRkV0jBD4+ELdcv0IQCf88ezXkV7UgwRnJt6bgkxUpk0x/PwjR2
 AgcQ==
X-Gm-Message-State: AFuF++mO5JaNUJuzIYadjK7DLoD2VP/c0otSqWZmp/WTCoUstU/kCaq+
 aXNLMIH1gykyhrbVjOxqO3+jv1JRS63vLra5Te9a7lpl4l4AQrUbD1l57eTx0t2HKsB/ANaUpG4
 J9Huxw/TOkubEv5QoqvPC3gf3DU4pOkCpCxTwtPP9mbAvRkwV+mb7PLofJi2ewElRYtw=
X-Gm-Gg: AR+sD12hxRLHRQGSiahR7pshoXfEsT1vzUZ3fPA/bq2P8HmWXxz+ehEw+j1hk0kEHC+
 1/sm2jMKiDZ5sFsXbtlO85viYRqfDmUPSst8U97dbm5ydPL6CBo5u9rcNXf8bgY+foh4SdZ7PC/
 iN9KC4nnM3eLtWdjw3GxvrZqSt95cSY48gvZuL1AGnNHc8QBnft2L/cUOW1Xik8ZR8Ltga0PckN
 8olmSulDR4K2X+0tU0fiXqwr8IN6IzXaDkcERZUZYXtp2FYK5dDIS6RdjzmLM7wx4YTPREmt8nt
 2HfJzS3g+QDuWV5GxB90pWR6TxwObDRS7er4+/8Vdu0ereMMTw6kilPXb1zGxFw1SvkRi07cBdZ
 /SByCnekazrd1xYfd5kjmecaQbXlv4nFu+hhTVu1PeIfUTnI5ADDIuYBRxXDlKNqT49RC
X-Received: by 2002:a05:600c:4592:b0:496:c1f3:e8f8 with SMTP id
 5b1f17b1804b1-49ce5828104mr81370965e9.7.1788358929798; 
 Wed, 02 Sep 2026 07:22:09 -0700 (PDT)
X-Received: by 2002:a05:600c:4592:b0:496:c1f3:e8f8 with SMTP id
 5b1f17b1804b1-49ce5828104mr81366565e9.7.1788358927080; 
 Wed, 02 Sep 2026 07:22:07 -0700 (PDT)
Received: from lleonard-thinkpadx1carbongen13.rmtit.csb ([151.29.41.106])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49ce4776131sm80871685e9.11.2026.09.02.07.22.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Sep 2026 07:22:06 -0700 (PDT)
From: Luigi Leonardi <leonardi@redhat.com>
Date: Wed, 02 Sep 2026 16:21:59 +0200
Subject: [PATCH 2/2] igvm: validate byte_offset before using it in
 parameter directives
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260902-fix_offset-v1-2-04b18f7595b2@redhat.com>
References: <20260902-fix_offset-v1-0-04b18f7595b2@redhat.com>
In-Reply-To: <20260902-fix_offset-v1-0-04b18f7595b2@redhat.com>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>, Ani Sinha <anisinha@redhat.com>, 
 Luigi Leonardi <leonardi@redhat.com>
X-Mailer: b4 0.14.3
Received-SPF: pass client-ip=170.10.133.124; envelope-from=leonardi@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

None of the directive handlers that place data at a byte_offset within
a parameter area validated that byte_offset actually falls within the
parameter area's size. A malformed IGVM file with byte_offset > size would
underflow the "size - byte_offset" computation used to determine
remaining space, wrapping to a huge value and defeating the size
check, then write out of bounds through param_entry->data +
byte_offset.

Add qigvm_param_offset_valid() to check byte_offset against the
parameter area size, and call it from each handler before doing any
arithmetic with byte_offset.

When possible, add an explicit check that fixed-size write fits
in the remaining space.

Signed-off-by: Luigi Leonardi <leonardi@redhat.com>
---
 backends/igvm.c                | 46 ++++++++++++++++++++++++++++++++++++++++++
 include/system/igvm-internal.h |  4 ++++
 target/i386/igvm.c             |  4 ++++
 3 files changed, 54 insertions(+)

diff --git a/backends/igvm.c b/backends/igvm.c
index a6e3a58022..5d2364bf70 100644
--- a/backends/igvm.c
+++ b/backends/igvm.c
@@ -101,6 +101,22 @@ qigvm_find_param_entry(QIgvm *igvm, uint32_t parameter_area_index,
     return NULL;
 }
 
+/*
+ * Check that byte_offset falls within the parameter area
+ */
+bool qigvm_param_offset_valid(const QIgvmParameterData *param_entry,
+                              const IGVM_VHS_PARAMETER *param,
+                              Error **errp)
+{
+    if (param->byte_offset > param_entry->size) {
+        error_setg(errp,
+                   "IGVM: byte_offset 0x%x exceeds parameter area size 0x%x",
+                   param->byte_offset, param_entry->size);
+        return false;
+    }
+    return true;
+}
+
 static int qigvm_directive_page_data(QIgvm *ctx, const uint8_t *header_data,
                                      Error **errp);
 static int qigvm_directive_vp_context(QIgvm *ctx, const uint8_t *header_data,
@@ -632,6 +648,10 @@ static int qigvm_directive_memory_map(QIgvm *ctx, const uint8_t *header_data,
         return -1;
     }
 
+    if (!qigvm_param_offset_valid(param_entry, param, errp)) {
+        return -1;
+    }
+
     max_entry_count = (param_entry->size - param->byte_offset) /
                       sizeof(IGVM_VHS_MEMORY_MAP_ENTRY);
     mm_entry = (IGVM_VHS_MEMORY_MAP_ENTRY *)(param_entry->data +
@@ -694,6 +714,17 @@ static int qigvm_directive_vp_count(QIgvm *ctx, const uint8_t *header_data,
         return -1;
     }
 
+    if (!qigvm_param_offset_valid(param_entry, param, errp)) {
+        return -1;
+    }
+
+    if (sizeof(*vp_count) > param_entry->size - param->byte_offset) {
+        error_setg(errp,
+                   "IGVM: vp-count parameter exceeds parameter area "
+                   "defined in IGVM file");
+        return -1;
+    }
+
     vp_count = (uint32_t *)(param_entry->data + param->byte_offset);
     *vp_count = 0;
     CPU_FOREACH(cpu)
@@ -718,6 +749,17 @@ static int qigvm_directive_environment_info(QIgvm *ctx,
         return -1;
     }
 
+    if (!qigvm_param_offset_valid(param_entry, param, errp)) {
+        return -1;
+    }
+
+    if (sizeof(*environmental_state) > param_entry->size - param->byte_offset) {
+        error_setg(errp,
+                   "IGVM: environment-info parameter exceeds parameter area "
+                   "defined in IGVM file");
+        return -1;
+    }
+
     environmental_state =
         (IgvmEnvironmentInfo *)(param_entry->data + param->byte_offset);
     environmental_state->memory_is_shared = 1;
@@ -825,6 +867,10 @@ static int qigvm_directive_device_tree(QIgvm *ctx, const uint8_t *header_data,
         return -1;
     }
 
+    if (!qigvm_param_offset_valid(param_entry, param, errp)) {
+        return -1;
+    }
+
     if (ctx->machine_state->fdt == NULL) {
         error_setg(errp, "IGVM: device tree not available");
         return -1;
diff --git a/include/system/igvm-internal.h b/include/system/igvm-internal.h
index 9e9fa1d9af..7e0d1512ae 100644
--- a/include/system/igvm-internal.h
+++ b/include/system/igvm-internal.h
@@ -81,4 +81,8 @@ QIgvmParameterData*
 qigvm_find_param_entry(QIgvm *igvm, uint32_t parameter_area_index,
                        Error **errp);
 
+bool qigvm_param_offset_valid(const QIgvmParameterData *param_entry,
+                              const IGVM_VHS_PARAMETER *param,
+                              Error **errp);
+
 #endif
diff --git a/target/i386/igvm.c b/target/i386/igvm.c
index 4d9d97385a..e758989d0d 100644
--- a/target/i386/igvm.c
+++ b/target/i386/igvm.c
@@ -197,6 +197,10 @@ int qigvm_directive_madt(QIgvm *ctx, const uint8_t *header_data, Error **errp)
         return -1;
     }
 
+    if (!qigvm_param_offset_valid(param_entry, param, errp)) {
+        return -1;
+    }
+
     GArray *madt = acpi_build_madt_standalone(ctx->machine_state);
 
     if (madt->len <= param_entry->size - param->byte_offset) {

-- 
2.55.0


