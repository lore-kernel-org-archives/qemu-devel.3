Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACFFECD5BB1
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2026 10:57:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRSzZ-00018i-PE; Mon, 25 May 2026 06:57:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leonardi@redhat.com>)
 id 1wRSzX-00018X-Lo
 for qemu-devel@nongnu.org; Mon, 25 May 2026 06:57:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leonardi@redhat.com>)
 id 1wRSzU-0001o2-UA
 for qemu-devel@nongnu.org; Mon, 25 May 2026 06:57:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779706615;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=9G3yxj/xIjlAiQKdSsxyIVHKseU/uc5psYKqOP3LttM=;
 b=RoJmhWFLazVDBdr2ALaIiPnxD2MahvxFWedtWbvzRdRthq1LAAyERaDYHuGpBe3To33ZS5
 hB5n9jQOLfH02RnSCCx69dimrCRv4I94XNvltcgXBpNMtmVilVviyHko1QkhTXk3GXg3I3
 6VxjR9DCJhE3xHFWfRk8KxoCkSXms6A=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-6-ewD29dplMsKOn_8QIANssA-1; Mon, 25 May 2026 06:56:54 -0400
X-MC-Unique: ewD29dplMsKOn_8QIANssA-1
X-Mimecast-MFC-AGG-ID: ewD29dplMsKOn_8QIANssA_1779706613
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-490261c79fcso29641835e9.0
 for <qemu-devel@nongnu.org>; Mon, 25 May 2026 03:56:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1779706613; x=1780311413; darn=nongnu.org;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=9G3yxj/xIjlAiQKdSsxyIVHKseU/uc5psYKqOP3LttM=;
 b=soss+8UD3ssDosEHRk4e6sbWQge8Z3bpF1p/YYZuvATFbXOPHD+9qHmdp+gEAThTg3
 t0pRhCuMDvyDqMtbhCIlqaWXxHti2lXPH9JiRp42SsIMj6GMHz+/rbIk7ljLk285kwaR
 lA1VXVftcY+hPIvDmEypSWv090pwKpZpoyYJfAWkqEVwXCVvWzGJaTEoJ0rjynL72wfU
 77IKBlrPtI9ewFJIUYPLOE5lykGZTLq3I656dSLBnfvekvW2VeD1kM6HmU3vE2DagLvy
 gl15y55VTCsh5GcmKhyjOTWRBuH524tZ/fHf8CuXK0r1WSgCIC2fSP5tjJpe7mtdsimD
 EYCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779706613; x=1780311413;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9G3yxj/xIjlAiQKdSsxyIVHKseU/uc5psYKqOP3LttM=;
 b=bgrFflBJ8ZYlNbzS8a06S7DSk5MQTu9IWwk2RN58fNrUwppyCg4uJmX0IVl3rRhoAI
 Q/V3QOWJe1CAnEy8Q9gMb+zvRElsFc/HlcBZXs0m5Rw0o2CoBZhx+ptGkuZCNNJMfulu
 XrdQ+c2p2QueaUs9psIlMnhCjWhWlA3NtVOcEfF8ms45t6IY4+0zSCfL4tHWiQ8jLO9W
 FRbMGZpH9PoCtbyHRALtJk+MlzEHDa9hMvsrul1Rpq6y3dUPgoBv2o0b/UtX/qLM8J7f
 FGKbrMC7aw2dYi31po+L1yKygYURRg9Cxl9KSEYMfNclJ1mVUeciaENVVXsRBq/YWBH/
 MpKg==
X-Gm-Message-State: AOJu0YwAcrJfyB1Jk4tll3vMxbCmqNzEtF3fluiqd1y+SwzvQVxLvm0e
 BWc0YZJawIqYS3niMnB8F7RZHI4bDZiCvVEGg8s6Zy/sTyPlvIi47agDojYNOvrPAHTmGQ2HBmO
 Tja+oxUQ5Lad4Kk3H9WzDeHJ31F1UhgPhNgKz95ykYTBPl1kgv8ITuL+G
X-Gm-Gg: Acq92OF1GKlBl6AikFVm1ZoiTp/OfaW/MadWIzfLrjjtRoFzrWaSblSoHFXc1puOTir
 FX6ozyW+YjbGrtU0nQqXq/tFvAfzHHyMrTbJ3OuZaCo54SU04jg0/WeHrzcVZoBbQKE0/ceCGx7
 oD2bkWCMCp/N0GKsef1TgJk78folOgLy2WUI+cW9LP/EAYMy4pD1tFWwR2vfAyvcePEOmf8TKDr
 S2Nqjme2bmce3B+wGdTB4YWCNgF9LjSUblD2SgtjnfZ6tWPQ2T5/fSWzcFD3rl7TE4OC6sNMOyy
 hPd+bwUX1U+jrZ6gM7ny9Xt7KWDVQMQbnodGQQfoP5hOE6LOMn1twTe2a69czeRZx6x9NB1jcrd
 TKHorW2bZGdHKUEChvk3oRjOW7msm/VvSfYlwdnKTSIdBuPiPpz2ArpHTwbnbK1CQE4gQZUrUQ4
 7Rv0kw/6m06CkFFIjV
X-Received: by 2002:a05:600c:6992:b0:490:5000:917 with SMTP id
 5b1f17b1804b1-49050000ae6mr159737485e9.1.1779706612977; 
 Mon, 25 May 2026 03:56:52 -0700 (PDT)
X-Received: by 2002:a05:600c:6992:b0:490:5000:917 with SMTP id
 5b1f17b1804b1-49050000ae6mr159737085e9.1.1779706612530; 
 Mon, 25 May 2026 03:56:52 -0700 (PDT)
Received: from lleonard-thinkpadx1carbongen13.rmtit.csb ([176.206.19.176])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49045284855sm238901435e9.0.2026.05.25.03.56.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 May 2026 03:56:51 -0700 (PDT)
From: Luigi Leonardi <leonardi@redhat.com>
Date: Mon, 25 May 2026 12:56:51 +0200
Subject: [PATCH] igvm: fix handling of optional variable header types
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260525-igvm_optional-v1-1-28edc607acfd@redhat.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDUyNT3cz0stz4/IISoLrEHN3kRENTS6MkM0PjpFQloJ6CotS0zAqwedG
 xtbUA/4flRF8AAAA=
X-Change-ID: 20260525-igvm_optional-ca1592b613be
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>, Ani Sinha <anisinha@redhat.com>, 
 Luigi Leonardi <leonardi@redhat.com>
X-Mailer: b4 0.14.3
Received-SPF: pass client-ip=170.10.133.124; envelope-from=leonardi@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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

The IGVM spec defines bit 31 of the variable header type as an
optional flag: if set, a loader that does not recognize the header
type may safely skip it. If clear, the loader must reject the file.

Currently, all the types with the optional bit set are not
recognized as valid headers.

Implement optional header handling by masking bit 31 before matching
against the handler table, and skip with a warning any unrecognized
header that has the optional bit set.

Fixes: c1d466d267cf ("backends/igvm: Add IGVM loader and configuration")
Signed-off-by: Luigi Leonardi <leonardi@redhat.com>
---
 backends/igvm.c | 24 +++++++++++++++++++++---
 1 file changed, 21 insertions(+), 3 deletions(-)

diff --git a/backends/igvm.c b/backends/igvm.c
index c347d0c17e..408917f826 100644
--- a/backends/igvm.c
+++ b/backends/igvm.c
@@ -26,6 +26,7 @@
 #include <igvm/igvm.h>
 #include <igvm/igvm_defs.h>
 
+#define IGVM_VHT_OPTIONAL_BIT (1U << 31)
 
 /*
  * Some directives are specific to particular confidential computing platforms.
@@ -139,8 +140,16 @@ static int qigvm_handler(QIgvm *ctx, uint32_t type, Error **errp)
     const uint8_t *header_data;
     int result;
 
+    /*
+     * Bit 31 of the variable header type indicates that the header is
+     * optional and can be safely ignored by a loader that does not
+     * support it. If the bit is clear, the file cannot be loaded.
+     * https://docs.rs/igvm_defs/0.4.0/igvm_defs/struct.IgvmVariableHeaderType.html
+     */
+    IgvmVariableHeaderType base_type = type & ~IGVM_VHT_OPTIONAL_BIT;
+
     for (handler = 0; handler < G_N_ELEMENTS(handlers); handler++) {
-        if (handlers[handler].type != type) {
+        if (handlers[handler].type != base_type) {
             continue;
         }
         header_handle = igvm_get_header(ctx->file, handlers[handler].section,
@@ -166,6 +175,13 @@ static int qigvm_handler(QIgvm *ctx, uint32_t type, Error **errp)
         igvm_free_buffer(ctx->file, header_handle);
         return result;
     }
+
+    if (type & IGVM_VHT_OPTIONAL_BIT) {
+        warn_report("IGVM: Skipping unsupported optional header type 0x%"
+                    PRIX32, type);
+        return 0;
+    }
+
     error_setg(errp,
                "IGVM: Unknown header type encountered when processing file: "
                "(type 0x%X)",
@@ -787,7 +803,8 @@ static int qigvm_supported_platform_compat_mask(QIgvm *ctx, Error **errp)
          header_index++) {
         IgvmVariableHeaderType typ = igvm_get_header_type(
             ctx->file, IGVM_HEADER_SECTION_PLATFORM, header_index);
-        if (typ == IGVM_VHT_SUPPORTED_PLATFORM) {
+        IgvmVariableHeaderType base_type = typ & ~IGVM_VHT_OPTIONAL_BIT;
+        if (base_type == IGVM_VHT_SUPPORTED_PLATFORM) {
             header_handle = igvm_get_header(
                 ctx->file, IGVM_HEADER_SECTION_PLATFORM, header_index);
             if (header_handle < 0) {
@@ -947,7 +964,8 @@ int qigvm_process_file(IgvmCfg *cfg, MachineState *machine_state,
          ctx.current_header_index++) {
         IgvmVariableHeaderType type = igvm_get_header_type(
             ctx.file, IGVM_HEADER_SECTION_DIRECTIVE, ctx.current_header_index);
-        if (!onlyVpContext || (type == IGVM_VHT_VP_CONTEXT)) {
+        IgvmVariableHeaderType base_type = type & ~IGVM_VHT_OPTIONAL_BIT;
+        if (!onlyVpContext || base_type == IGVM_VHT_VP_CONTEXT) {
             if (qigvm_handler(&ctx, type, errp) < 0) {
                 goto cleanup_parameters;
             }

---
base-commit: cbf877d67a812be17a9ce404a589e1bdf722c1f6
change-id: 20260525-igvm_optional-ca1592b613be

Best regards,
-- 
Luigi Leonardi <leonardi@redhat.com>


