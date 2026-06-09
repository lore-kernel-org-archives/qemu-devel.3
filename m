Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C2C4CD8C92
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2026 12:30:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWvap-00011o-Ni; Tue, 09 Jun 2026 08:30:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leonardi@redhat.com>)
 id 1wWvan-000117-AD
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 08:30:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leonardi@redhat.com>)
 id 1wWval-0000Vf-Ez
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 08:30:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781008202;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=e08Hb0NhqzVfr2NiBmCrSbz1CaHSq1EY8Hq1JL6lqKs=;
 b=Wf1lfDxBtEkCJ9tWhME3jZNNBgY0OjEvIPnZzFroWw/bHBlO2zyaKrKNiNFtLhhxIOguDN
 sKRnLHkjixGoHviF5LLSwIgBMz/Rp9UISYFpSh7D0O4OPAMIvq4ts/vKC0y56H+GzEGe9a
 pWk0wUcED4BgfIBgMM2609goDhDNYwA=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-665-9spJaN80MfOP6dZXCb7ZDA-1; Tue, 09 Jun 2026 08:30:00 -0400
X-MC-Unique: 9spJaN80MfOP6dZXCb7ZDA-1
X-Mimecast-MFC-AGG-ID: 9spJaN80MfOP6dZXCb7ZDA_1781008200
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-490c56e2576so36138445e9.3
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2026 05:30:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1781008200; x=1781613000; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=e08Hb0NhqzVfr2NiBmCrSbz1CaHSq1EY8Hq1JL6lqKs=;
 b=EBDg7IO1OO0haC5Zxy7HDXhvqe2xeQt+rj4zcuIddISRtp6yxqNg+lUvIYCQuVZpAE
 zvnPDP3WijmwVYKr/6Z8w3qf0mnRSI0MYiEKs3NmUWhgPzbxBqo/6rB414UU9IBoCTla
 4BQ6/lYm8ztDUBoXB69miu9swkPW0NN1ePheZMBp/1GmXOh3A52wD/truUjYw0Iinaqr
 t0vVmbje4GuAGWJieIN7Pr6d3xru09vh2kJXEinib++ikUmXvCeB9ogJIJG7t+QR6u7/
 Ho0/UGeSfHSlTzn8M5RUlox2BnICSY3+EssF8jiWzX0zMdzEGcoRhpRXj7w23NPV8qJY
 KP7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781008200; x=1781613000;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=e08Hb0NhqzVfr2NiBmCrSbz1CaHSq1EY8Hq1JL6lqKs=;
 b=tMNeE+R2K+uTg0btOnpNW+rQzjAFdfvaZbeZ8gpQsOSCMyn+mxDOowzE/igPvoX03p
 QFRXoHSmEQm4JBHnEXTuQ+BZ+5Ep/wMcrJGYMWzdKCq0cAmGyh1C5zVedwv+BXnOaAEY
 05kgpcDwRzgIhJxZMZxTIgnfJ7nozZOkKPeHD/aAT2iSzwjcLS8P2alQdgxUbtSDyWYj
 ZgvSq+aK3Av/nA8Boi7zs4ZNC+uZ2+TwBmALsBzB5REBQCydR/Ihf8qO7Q4CxgFsfOsE
 jgzY77DKBbhqXgs86p9NQeH0RyXmipf1OkAbkhnWcw3EMsjZw5fGPDJ28iexGX6K5gcR
 b5ww==
X-Gm-Message-State: AOJu0YwmDqbGe7Uyc3j+JkioUU1nMKTfADF36Cy6Tv1k1wWd51H3ApRd
 PWzbWcJ2jZmn9rQdqxF/fLaPikKh9u+RQFi7XSbPdwp6Az9KJBKVCMlIA4iVIV/yhM+uRLZtv9z
 vzYUy0uTTJ7nkMIVm/fG0UPkQRHC8fTT/tmcASDoKedQTYoNBQM7mqo1J
X-Gm-Gg: Acq92OFm1LXGtAg/Oi5y51zEf0Xx56l9Up2O47jEKYbW9lZDIA4E0M8pw4diAyP7SEl
 rN/oTgLlupbZQHStyxR/wJP0OCqZ3FdSt2VG1tN1Excrd4vmX3b9i8yPH5j7Sc51Pn/6gjkVoJw
 en26miumizxRZl/FOXgj3xjNtvNIS5n1ffcy4f/0jnK3KHx+GuPQWqPajGdCLbPdXQPYewtnXWX
 L+r4qd/j3/UfZqZKWlxvvLKhAFljEA+PuZQB/mvyscMZO8g884YYZw36oLXL5cPYGfmlydeA5um
 gOS1Ue+JcOuSjWeA5GPFJCnsNMpHroj0Sx9Igyj/3+eBVZoS4ipgh500u7YgOOGoAtUux9VHZE8
 g3fuuo5xpC+Ntg9GI0sT9cOZlxZXm7mQ/v9rxZIPW/uspV5bQBflZu9s8DdjTO1m92UutVuz99D
 nQ7QeLpssKzH1QDOq31BiiEYquBTI=
X-Received: by 2002:a05:600c:34cb:b0:48e:6db3:ff3a with SMTP id
 5b1f17b1804b1-490c25b09a2mr336075975e9.16.1781008199685; 
 Tue, 09 Jun 2026 05:29:59 -0700 (PDT)
X-Received: by 2002:a05:600c:34cb:b0:48e:6db3:ff3a with SMTP id
 5b1f17b1804b1-490c25b09a2mr336075365e9.16.1781008199281; 
 Tue, 09 Jun 2026 05:29:59 -0700 (PDT)
Received: from lleonard-thinkpadx1carbongen13.rmtit.csb ([176.206.19.176])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490c2d2d11asm423031295e9.1.2026.06.09.05.29.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2026 05:29:58 -0700 (PDT)
From: Luigi Leonardi <leonardi@redhat.com>
Date: Tue, 09 Jun 2026 14:29:04 +0200
Subject: [PATCH v2 2/2] igvm: fix handling of optional variable header
 types
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260609-igvm_optional-v2-2-b1f1f08dc40e@redhat.com>
References: <20260609-igvm_optional-v2-0-b1f1f08dc40e@redhat.com>
In-Reply-To: <20260609-igvm_optional-v2-0-b1f1f08dc40e@redhat.com>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>, Ani Sinha <anisinha@redhat.com>, 
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

The IGVM spec defines bit 31 of the variable header type as an
optional flag: if set, a loader that does not recognize the header
type may safely skip it. If clear, the loader must reject the file.

Currently, the optional bit is not stripped before comparing header
types, so headers with the bit set fail to match any known type
and are rejected.

Mask bit 31 before comparing header types throughout the IGVM
loader, and skip with a warning any unrecognized header that has
the optional bit set.

Fixes: c1d466d267cf ("backends/igvm: Add IGVM loader and configuration")
Signed-off-by: Luigi Leonardi <leonardi@redhat.com>
---
 backends/igvm.c | 37 +++++++++++++++++++++++++++++++++----
 1 file changed, 33 insertions(+), 4 deletions(-)

diff --git a/backends/igvm.c b/backends/igvm.c
index 8bb5750768..71ef8bb97b 100644
--- a/backends/igvm.c
+++ b/backends/igvm.c
@@ -26,6 +26,25 @@
 #include <igvm/igvm.h>
 #include <igvm/igvm_defs.h>
 
+#ifndef IGVM_VHT_OPTIONAL_BIT
+#define IGVM_VHT_OPTIONAL_BIT (1U << 31)
+#endif
+
+/*
+ * Bit 31 of the variable header type indicates that the header is
+ * optional and can be safely ignored by a loader that does not
+ * support it. If the bit is clear, the file cannot be loaded.
+ * https://docs.rs/igvm_defs/0.4.0/igvm_defs/struct.IgvmVariableHeaderType.html
+ */
+static IgvmVariableHeaderType igvm_vht_type(IgvmVariableHeaderType type)
+{
+    return type & ~IGVM_VHT_OPTIONAL_BIT;
+}
+
+static bool igvm_vht_optional(IgvmVariableHeaderType type)
+{
+    return !!(type & IGVM_VHT_OPTIONAL_BIT);
+}
 
 /*
  * Some directives are specific to particular confidential computing platforms.
@@ -132,12 +151,14 @@ static struct QIGVMHandler handlers[] = {
       qigvm_directive_madt },
 };
 
-static int qigvm_handler(QIgvm *ctx, IgvmVariableHeaderType type, Error **errp)
+static int qigvm_handler(QIgvm *ctx, IgvmVariableHeaderType raw_type,
+                         Error **errp)
 {
     size_t handler;
     IgvmHandle header_handle;
     const uint8_t *header_data;
     int result;
+    IgvmVariableHeaderType type = igvm_vht_type(raw_type);
 
     for (handler = 0; handler < G_N_ELEMENTS(handlers); handler++) {
         if (handlers[handler].type != type) {
@@ -166,6 +187,13 @@ static int qigvm_handler(QIgvm *ctx, IgvmVariableHeaderType type, Error **errp)
         igvm_free_buffer(ctx->file, header_handle);
         return result;
     }
+
+    if (igvm_vht_optional(raw_type)) {
+        warn_report("IGVM: Skipping unsupported optional header type 0x%"
+                    PRIX32, type);
+        return 0;
+    }
+
     error_setg(errp,
                "IGVM: Unknown header type encountered when processing file: "
                "(type 0x%X)",
@@ -787,6 +815,7 @@ static int qigvm_supported_platform_compat_mask(QIgvm *ctx, Error **errp)
          header_index++) {
         IgvmVariableHeaderType typ = igvm_get_header_type(
             ctx->file, IGVM_HEADER_SECTION_PLATFORM, header_index);
+        typ = igvm_vht_type(typ);
         if (typ == IGVM_VHT_SUPPORTED_PLATFORM) {
             header_handle = igvm_get_header(
                 ctx->file, IGVM_HEADER_SECTION_PLATFORM, header_index);
@@ -945,10 +974,10 @@ int qigvm_process_file(IgvmCfg *cfg, MachineState *machine_state,
     for (ctx.current_header_index = 0;
          ctx.current_header_index < (unsigned)header_count;
          ctx.current_header_index++) {
-        IgvmVariableHeaderType type = igvm_get_header_type(
+        IgvmVariableHeaderType raw_type = igvm_get_header_type(
             ctx.file, IGVM_HEADER_SECTION_DIRECTIVE, ctx.current_header_index);
-        if (!onlyVpContext || (type == IGVM_VHT_VP_CONTEXT)) {
-            if (qigvm_handler(&ctx, type, errp) < 0) {
+        if (!onlyVpContext || igvm_vht_type(raw_type) == IGVM_VHT_VP_CONTEXT) {
+            if (qigvm_handler(&ctx, raw_type, errp) < 0) {
                 goto cleanup_parameters;
             }
         }

-- 
2.54.0


