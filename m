Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFED5CD8CB9
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2026 09:45:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXFUC-0007hC-6t; Wed, 10 Jun 2026 05:44:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leonardi@redhat.com>)
 id 1wXFUA-0007fz-5M
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 05:44:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leonardi@redhat.com>)
 id 1wXFU8-0002zy-EO
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 05:44:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781084670;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=f0XyjkV+4pftUsJVnvIYp47/Q6T0AROHTUKZuonvPLY=;
 b=PP6uSKt4PMlCkwHTJFbvtqS+uQO0GEhqLCCChhcLD7ZQmRUBBxG+HwLZXyHkeTar3I6EWz
 GEWn1FXbd6DLVL/0s+xpKAIa5WswmVIGBL4QQMJV17qH2EqmU0UkSi4pgr8vOrbM7wNkWk
 CbTnkN0uq5OYTz2Lnb5ddxiMMhUvdPY=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-645-Ffs94SS0McqvwSYglE9uWQ-1; Wed, 10 Jun 2026 05:44:28 -0400
X-MC-Unique: Ffs94SS0McqvwSYglE9uWQ-1
X-Mimecast-MFC-AGG-ID: Ffs94SS0McqvwSYglE9uWQ_1781084668
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-490afe64f26so32694425e9.0
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2026 02:44:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1781084667; x=1781689467; darn=nongnu.org;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=f0XyjkV+4pftUsJVnvIYp47/Q6T0AROHTUKZuonvPLY=;
 b=DFTQ/gjtwxVAAj3VjMTNa5IZgDpYv89+46HeyLZ4kiqK9NlR/UAS3hMj3hgZ3+oPNy
 ReAs30Qnb0zlrDIp7ZMqGH0YCzvg4Dva52pvN1gS3e7i+MU8CU1/Tf3L/XndxIWImr7u
 7Yf7yqnJ2otTgehw7wUc0IAnwB4hoZqsZ4CGNGruoMJ+HN+18KGjl/VefX8a80p3mZ19
 YBvrsIGBm1Uqca7TQ6fuhsD+SosF9ILHyS3XDbb5iDAqHI6cbsD2IemNFZVBiuRPkzNM
 GkmkDSrEvuNZP1slp4ygNiyKlIFPFDw78fadIkdhCIm7kYlj+ZkoBSTxc+7NBo9BvudE
 54eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781084667; x=1781689467;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=f0XyjkV+4pftUsJVnvIYp47/Q6T0AROHTUKZuonvPLY=;
 b=qa8x3ssRtK/QyDk31ZnsN3dfNK8eAg04C7KCdwpw7WuHgWrIqQv63N8/w6dWzKXkUy
 3gMSU2bmU2plMQcC35B8e+13LxHz8nGEgTdGrPBvZ6JucRGuzmYuW17V57YnqcFXlHrK
 Sn/JCSAzYMgwh+g2yyjoGT6EYUbx1B3PyRgVLzdB67E55mhuFGbUOTQSTRYKcN+oGZxW
 0EOrRKuwPlc0EZS7uiFgPXA3wtRKHMfLxyQqhrF461jRXRzrurSw0LQ+S+Rgw05VCi7L
 zaZ4x9onTC3wdir1iqzuMM8owOfODaNqjudx5nY2XSEH0Pc9jGScHzTziFVcoTkI5tHx
 K47A==
X-Gm-Message-State: AOJu0YzyBEvHq9DHhU9E3x1P4Wz8DhjJM5mHTHg3iYRosBGi3EtCB8Vx
 GY/9MTpY4pmzA8kOZF2g0HiWVPQBvi0SrIR9GTsckmL3OiF8ra/vgIehGL+Wb4t5MFBKGS/brKP
 GA5QR9orAu2f60ncKVFMRBdqi8YWdzGcf5S+149B01bQyO1tYZtjLr4wU
X-Gm-Gg: Acq92OHd1/1IvnAICy2W1dXX8/ZzHIhLKsYEyJvGNiqEzRI0wTqASntcl/pXcVan5Uf
 kLtW76KTjtPD4/feULxBT3xojLrt6xklmB5hB+j/1kNCNx6Fbo2qc9nBOob51eLJVm+qPzsEgPN
 M+IsOQuzKFbVCn5TU0oG6S2EStv01RfQy62NbNh3Zdvgf937kIzeYOY+tO/z3bS2B4FlfiXCYG6
 1jUkzu28Etd5//TyHR/AvoKHyNrFQH0SYSE2EHQyiLxJcLr63ckq0ILNoi4FY1Q7CxvDIDeFvZN
 HRGHkBrwB3qLMrDjDMjBGXCDglFE+8dFZfatQzuYmtO6MY/cLlql6Z7BQepfzxGJ2YRdX0nKp33
 DRAWwcgSnBahLs3DbLXpQJ0Jx9/4Z64pk/Y5IuELIBF7DY27h0OkXrnVKiQ/itRDpPNYmrZp/y4
 BgR3RYuCxCvSwUfUHaj4QEFLN+P8c=
X-Received: by 2002:a05:600c:1986:b0:489:32b:ac0b with SMTP id
 5b1f17b1804b1-490c2cc27bdmr327074875e9.6.1781084667661; 
 Wed, 10 Jun 2026 02:44:27 -0700 (PDT)
X-Received: by 2002:a05:600c:1986:b0:489:32b:ac0b with SMTP id
 5b1f17b1804b1-490c2cc27bdmr327074545e9.6.1781084667320; 
 Wed, 10 Jun 2026 02:44:27 -0700 (PDT)
Received: from lleonard-thinkpadx1carbongen13.rmtit.csb ([176.206.19.176])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490bc3b59f0sm629416475e9.2.2026.06.10.02.44.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jun 2026 02:44:26 -0700 (PDT)
From: Luigi Leonardi <leonardi@redhat.com>
Date: Wed, 10 Jun 2026 11:44:21 +0200
Subject: [PATCH] igvm: Report error on missing parameter area in directive
 handlers
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260610-igvm_error-v1-1-59d133a69f2f@redhat.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3MQQqAIBBG4avErBPUhUlXiYiyP5tFGiNEEN09a
 fkt3nuoQBiF+uYhwcWFc6owbUNhn1OE4rWarLZOO6MVx+uYIJJFBXj4xWLrNKgGp2Dj+58N4/t
 +OPMyR1wAAAA=
X-Change-ID: 20260610-igvm_error-ce8e8b2ef70e
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>, Ani Sinha <anisinha@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>, 
 Oliver Steffen <osteffen@redhat.com>, Luigi Leonardi <leonardi@redhat.com>
X-Mailer: b4 0.14.3
Received-SPF: pass client-ip=170.10.129.124; envelope-from=leonardi@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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

Parameter areas are how an IGVM file tells QEMU to allocate buffers
for runtime information the guest needs — VP count, memory map,
MADT and so on. Usage directives reference a parameter area by index
to tell QEMU where to write each piece of data. If the index doesn't
match any declared parameter area, the data has nowhere to go and it
should be treated as an error.

The directive handlers that look up a parameter area all return 0
(success) when `qigvm_find_param_entry()` can't find it. Therefore,
the load succeeds but the guest never gets the expected parameters.

Note that the IGVM library already validates parameter area indices
when the file is loaded, so this path should only be reachable with
a malformed file that bypassed library validation. See it as a form
of defensive programming.

Report the error with error_setg() and return -1 instead.
Also remove the warn_report() from `qigvm_find_param_entry()`
to avoid double error reporting.

Signed-off-by: Luigi Leonardi <leonardi@redhat.com>
---
 backends/igvm.c    | 17 ++++++++++++-----
 target/i386/igvm.c |  4 +++-
 2 files changed, 15 insertions(+), 6 deletions(-)

diff --git a/backends/igvm.c b/backends/igvm.c
index c347d0c17e..2569c4a9f2 100644
--- a/backends/igvm.c
+++ b/backends/igvm.c
@@ -71,7 +71,6 @@ qigvm_find_param_entry(QIgvm *igvm, uint32_t parameter_area_index)
             return param_entry;
         }
     }
-    warn_report("IGVM: No parameter area for index %u", parameter_area_index);
     return NULL;
 }
 
@@ -502,7 +501,9 @@ static int qigvm_directive_parameter_insert(QIgvm *ctx,
 
     param_entry = qigvm_find_param_entry(ctx, param->parameter_area_index);
     if (param_entry == NULL) {
-        return 0;
+        error_setg(errp, "IGVM: parameter area index %u not found",
+                   param->parameter_area_index);
+        return -1;
     }
 
     region = qigvm_prepare_memory(ctx, param->gpa, param_entry->size,
@@ -575,7 +576,9 @@ static int qigvm_directive_memory_map(QIgvm *ctx, const uint8_t *header_data,
     /* Find the parameter area that should hold the memory map */
     param_entry = qigvm_find_param_entry(ctx, param->parameter_area_index);
     if (param_entry == NULL) {
-        return 0;
+        error_setg(errp, "IGVM: parameter area index %u not found",
+                   param->parameter_area_index);
+        return -1;
     }
 
     max_entry_count = param_entry->size / sizeof(IGVM_VHS_MEMORY_MAP_ENTRY);
@@ -634,7 +637,9 @@ static int qigvm_directive_vp_count(QIgvm *ctx, const uint8_t *header_data,
 
     param_entry = qigvm_find_param_entry(ctx, param->parameter_area_index);
     if (param_entry == NULL) {
-        return 0;
+        error_setg(errp, "IGVM: parameter area index %u not found",
+                   param->parameter_area_index);
+        return -1;
     }
 
     vp_count = (uint32_t *)(param_entry->data + param->byte_offset);
@@ -657,7 +662,9 @@ static int qigvm_directive_environment_info(QIgvm *ctx,
 
     param_entry = qigvm_find_param_entry(ctx, param->parameter_area_index);
     if (param_entry == NULL) {
-        return 0;
+        error_setg(errp, "IGVM: parameter area index %u not found",
+                   param->parameter_area_index);
+        return -1;
     }
 
     environmental_state =
diff --git a/target/i386/igvm.c b/target/i386/igvm.c
index f41b498b89..e59511a2aa 100644
--- a/target/i386/igvm.c
+++ b/target/i386/igvm.c
@@ -193,7 +193,9 @@ int qigvm_directive_madt(QIgvm *ctx, const uint8_t *header_data, Error **errp)
     /* Find the parameter area that should hold the MADT data */
     param_entry = qigvm_find_param_entry(ctx, param->parameter_area_index);
     if (param_entry == NULL) {
-        return 0;
+        error_setg(errp, "IGVM: parameter area index %u not found",
+                   param->parameter_area_index);
+        return -1;
     }
 
     GArray *madt = acpi_build_madt_standalone(ctx->machine_state);

---
base-commit: 29c042c6e9d4a09d4a0ac3fa54aeb7ee08ce0bdc
change-id: 20260610-igvm_error-ce8e8b2ef70e

Best regards,
-- 
Luigi Leonardi <leonardi@redhat.com>


