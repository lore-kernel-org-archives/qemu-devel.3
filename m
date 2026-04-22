Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14E85F9B60C
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2026 10:31:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFUrH-0006jy-Po; Wed, 22 Apr 2026 06:31:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1wFUr9-0006hn-Bq
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 06:30:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1wFUr5-0006su-Gl
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 06:30:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776853850;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=w09VoMzg1fFTcUiwTiAFUejpcn+BNU/liKIHZSDNJDE=;
 b=AmNTwlOObbs3q584/dH/u4pO0nI/aKEelLdvNVI8OvPgRskviUY3qzn6UwCBYCjt6dd7JE
 u60YaOEvApQpMtuf4t5rkbbNw7o5+g3zqziW/NypaGnGT/0M94c+2q+2fhoNyN6tVCZ0o9
 m6WyPbNW5mkL3bmb/UaMh9wxX20Ll4w=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-680-b4992YsMNvCueeRxW_62hg-1; Wed, 22 Apr 2026 06:30:49 -0400
X-MC-Unique: b4992YsMNvCueeRxW_62hg-1
X-Mimecast-MFC-AGG-ID: b4992YsMNvCueeRxW_62hg_1776853848
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-35d9467e85aso5543008a91.0
 for <qemu-devel@nongnu.org>; Wed, 22 Apr 2026 03:30:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1776853848; x=1777458648; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=w09VoMzg1fFTcUiwTiAFUejpcn+BNU/liKIHZSDNJDE=;
 b=MLGbtikxvdG8WH0il0Z5pDfxomNao80kt++/wBOdKz6aQn76TmvBvSPMn4jfc3knoq
 xO5lbLW22S/BPlD+9GQK74J5j36s8yyDRjN/uuXBv5c2OBISjPOxXSTDu3jlGF+EbONy
 zc3FE1FX0wJ4ln97e8s/kWRTgkRIgM9fjwAZu+fnijhsoVg6YOaDGYLnA6WXusSnWAbA
 sdlnIshzvVifIS5C+3g7O9miAfauJ/Bsiq8SdHNUq72A7sEn2aVGkVMJYpWQVZcEodsv
 QAsNSrv2IDmWqVxCyj8NApWrs5QrZ/BzEhzXKZTR0xYJhuP51UBOMoYyGtZhXPi8ZrO2
 jH/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776853848; x=1777458648;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=w09VoMzg1fFTcUiwTiAFUejpcn+BNU/liKIHZSDNJDE=;
 b=quoUlT+AvwKm3GYKJ1Iv45YTVaCIwAd+1JLC4uPIhgI0S7x+DAY9JWKNhzr7NRIV3+
 dqVLd5KyAjOE4igK4J0X91mPcCrD7jxapWN6t6XR9nbO9p3PXQM4f1mzJjbcE4fvpnU+
 XYdbMCBoaw0C/NOISjIQLqRNJg+Ma/AjtSfzAMaZcVHvK+Jh3YqBoHNWBux7EmRC+YYX
 L3u2M5TvCbC4O/N7nUGbgUEehbbck48xEwVwjK2Ol1oRxwLqeKlfK0W1haEK01psZON1
 3+kKaUbzCQtSRnC+o2Oa8dOuC/S9M89SYIqgRmb5Y+H5DU33Am1lbSwGzCyjmzLheyLm
 APvg==
X-Gm-Message-State: AOJu0YxsluLlctdke4DrVPOGMrtV7BODFk73ofhsjvegbOW67rcTAJyl
 PgwWvbwlFWlpQ3KNIvaFn+QLhsd2rhS86mnK4vYDbOPRf97MicWKSsmEcuATD0MTdR4+u9lSSBg
 2FRcJcZb9mMnI8q0rE9pOOMlT8b692VZ3eXhEuygCRTvunHQLDmFAjjk7lym3QOmHPg1UvRscEf
 GPDQLHuPX+K6lXm7GFAfQ/XWTPNwxeezQFbTH/+V0=
X-Gm-Gg: AeBDietFiBEKVjkvI4Bocg7kAGKDvzMC0u4XSczzv64EdKhZlk/mX0DnRnhyXum23/B
 iFbBE74TCrCYTd92Za+zerVpWityNuUIcBgSHBL9EqY6jzKlRhHrEth+JtlDYOMLogJr7SyKxzX
 SJ/gxi0tJ4Rp/Alv1g/VP7ATkbOk2toYXq5PgV1S4JU88AGIZ7KvrBLTwwgK5djBAkBU5eqodHe
 xnueckkA4MomL+lb/49E6SZLIOiYUbAKrid4gNOZzmkeyrm9+qaD2Nu4n8c5fMRBOHzdGHRQ0U8
 iBXUAV2gYc6817KO5NWnq0k4a63kjI9rWd0fYTL5yByZjykxNR6BKfVzoNnh+h9mR+r051kKN7Y
 caeClwfDfyyvjddF5V1b/x5N3JkRu4YjfLdTVAPY2/NwW3gR0uq8Tdxyq8Ws/aREsTAPBQ7ie5g
 ==
X-Received: by 2002:a05:6a20:3d85:b0:398:7912:cb05 with SMTP id
 adf61e73a8af0-3a08d8a3841mr25864897637.38.1776853847745; 
 Wed, 22 Apr 2026 03:30:47 -0700 (PDT)
X-Received: by 2002:a05:6a20:3d85:b0:398:7912:cb05 with SMTP id
 adf61e73a8af0-3a08d8a3841mr25864819637.38.1776853847044; 
 Wed, 22 Apr 2026 03:30:47 -0700 (PDT)
Received: from fedora.armenon-thinkpadp16vgen1.bengluru.csb ([49.36.110.202])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c7976f920e1sm12589666a12.2.2026.04.22.03.30.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Apr 2026 03:30:46 -0700 (PDT)
From: Arun Menon <armenon@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>, Stefan Berger <stefanb@linux.vnet.ibm.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Igor Mammedov <imammedo@redhat.com>,
 marcandre.lureau@redhat.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Yanan Wang <wangyanan55@huawei.com>,
 Ani Sinha <anisinha@redhat.com>, Arun Menon <armenon@redhat.com>
Subject: [PATCH v5 03/10] hw/tpm: Add internal buffer state for chunking
Date: Wed, 22 Apr 2026 16:00:11 +0530
Message-ID: <20260422103018.123608-4-armenon@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260422103018.123608-1-armenon@redhat.com>
References: <20260422103018.123608-1-armenon@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armenon@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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
index 7edfbf8f8a..e7ec9d0679 100644
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
@@ -87,6 +90,13 @@ enum crb_cancel {
 
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
@@ -136,9 +146,11 @@ static void tpm_crb_mmio_write(void *opaque, hwaddr addr,
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
@@ -243,6 +255,7 @@ static void tpm_crb_reset(void *dev)
         tpm_ppi_reset(&s->ppi);
     }
     tpm_backend_reset(s->tpmbe);
+    tpm_crb_clear_internal_buffers(s);
 
     memset(s->regs, 0, sizeof(s->regs));
 
@@ -309,6 +322,9 @@ static void tpm_crb_realize(DeviceState *dev, Error **errp)
     memory_region_add_subregion(get_system_memory(),
         TPM_CRB_ADDR_BASE + sizeof(s->regs), &s->cmdmem);
 
+    s->command_buffer = g_byte_array_new();
+    s->response_buffer = g_byte_array_new();
+
     if (s->ppi_enabled) {
         tpm_ppi_init(&s->ppi, get_system_memory(),
                      TPM_PPI_ADDR_BASE, OBJECT(s));
@@ -321,12 +337,21 @@ static void tpm_crb_realize(DeviceState *dev, Error **errp)
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


