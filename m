Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB833C5DF81
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 16:54:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wx5zL-0006ns-0l; Thu, 20 Aug 2026 12:51:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wx5zC-0005oC-L4
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 12:51:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wx5zA-0005fi-EJ
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 12:51:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787244683;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=V8uegqHxKQ/1NXEPewm6GGy0naItBS1eOwztkv4A8yU=;
 b=HqB8plUAGXAaTBmG1NJ73rsYeMSOgtoXVu8OMWm/nrnaGzHxO9K4XUzKlIkq1QyH4Mn5bj
 3yVuMdk7DaRPxXpCEIoZlAhZH3JydfZUKYWgZJxEnMk6WVhPsWATH5BgEFxJpQcUeMlJmC
 32NpCV+rn/hMZc/p9L7a4N6MR8CpMMc=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-379-pZ28aLjvPgmIkM87DYdi8Q-1; Thu, 20 Aug 2026 12:51:21 -0400
X-MC-Unique: pZ28aLjvPgmIkM87DYdi8Q-1
X-Mimecast-MFC-AGG-ID: pZ28aLjvPgmIkM87DYdi8Q_1787244680
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-47f835ac1aeso66888f8f.3
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 09:51:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1787244680; x=1787849480; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=V8uegqHxKQ/1NXEPewm6GGy0naItBS1eOwztkv4A8yU=;
 b=Dftz57JgHdD07CHKXwNow1g9OyHUntvLt0jVfmto3Mp12gekLuNxZhiNSfEW9+0YSp
 tvCzHbsVyv/oL14WcTAU+WF5xbSrsuElCgHJFKV1qpDuJ3qjHgKIELYSjZFjmMF7uiQl
 t0cYdrW/32IkIu0Rp2FUG+kqFenIOag6dRYM90uOSrPjRcV/2+QPfu956onNS5uKJGbc
 miAE/F1Y3lOhHhZvsGQj0SckXZY+/7vKwbhYR/aDGKO+7wGIZSTZCvWI58ZEhdv90v4N
 tLqjZ22mmPEbNDBN84bYs25v3lWpcdjFa5hDP3+0XsSNcNM1dCdodkWqHlYNJSfkwtAs
 X9NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787244680; x=1787849480;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=V8uegqHxKQ/1NXEPewm6GGy0naItBS1eOwztkv4A8yU=;
 b=X+CuXcGLVsCVmK9RuKVV6wYigS6QXMvMVIi83YxJwUgL2EM0H3U58h3C3WFSEHWHA5
 UyBVqThcInZxKUh8NYvQ7UZBXieZrof2e8OJ1EKXak+GR1rz8ikLVf/X/74g9iojZhfw
 OuLqdCu7cVU6LVwwQ3v10ZHr9AEtvhDG15re6o7yR04NfZT3/+W6JjnGCbILRhgkuT06
 77c+GGxv0e6GhK6ReyAfIM3lpHsdoxqMpVO4KlMng7Cb+CphPnBN8R5NYPmlqKBqDwZP
 bjrHeTZPTQCFzKjcnIlALWrHrCC3m3xaQYNt12C4COpYghYe65LvgAmkJMBKI679YXIY
 8oBA==
X-Gm-Message-State: AFuF++nNe77xYEDFNTj+9kaNFyndBphIpSk8mR4aJiobwzPv4DfpwhF7
 U3BoSN1qXKe3P9Rq2H1hbLAwwIQJYkkga557M/PavUeiw5xDieYWtQoivD3sbzKhUTfiuSd/a9g
 RmnA5lSL1Z5Ib7uIRgr2EgTAhZMguTZGaa9/4fCdC7gFRYZvACUSizPEjinWAAV6r+uCm3wamGH
 +Gndfxk7UsuFeMnRmF9yCLnitTpHvpVN6Vo4AE+ePD
X-Gm-Gg: AR+sD10dQXzFA0FPE2YwOEHgWJs513RegJUi6nSMbqxRZuOacLovAR2TiaJnL1mUlMG
 THvAUstYJ8HPHzS9r7cae3f7q6csPuSBcBMcDW0Yz0juXG6y9HCDCLTctSl+i39YdKLdpbz5BU0
 KETPBizhyOmNB0alLGMoSDGIVdquzXN+hTQnQ0Taz+37NFauK7e1sw5ALR0Gd7KRGwrdOFz+79/
 nWemEoEbgF/+g10cpUQ9g7AOC+MXbqU2MAoSDBG3ISpc5zbSNJ3kbbZOFJgJE5idqzd6aTtZjl9
 1LdakCUAf17WeEn06y4wT2Kw6jQxxQMn88YheAxXH4mbScw4X1//UeDHipiyFwN+iMy+0lx3TIU
 mjDdED/ROecnbt/1hWirsBiVQf3fpgbYS0ph7OeQFs5zWmggz0V8iO7Vi4Z+HC9Q8tLTqKBh731
 X9K7Q=
X-Received: by 2002:a05:6000:4b1b:b0:482:bb55:8bda with SMTP id
 ffacd0b85a97d-482c0b5bf64mr18882f8f.5.1787244680204; 
 Thu, 20 Aug 2026 09:51:20 -0700 (PDT)
X-Received: by 2002:a05:6000:4b1b:b0:482:bb55:8bda with SMTP id
 ffacd0b85a97d-482c0b5bf64mr18752f8f.5.1787244679838; 
 Thu, 20 Aug 2026 09:51:19 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.34.92])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482bab42f8esm6390603f8f.28.2026.08.20.09.51.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Aug 2026 09:51:19 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: "Naveen N Rao (AMD)" <naveen@kernel.org>,
 Tom Lendacky <thomas.lendacky@amd.com>
Subject: [PULL 28/53] target/i386: SEV: Refactor check_sev_features()
Date: Thu, 20 Aug 2026 18:49:31 +0200
Message-ID: <20260820164957.1895963-29-pbonzini@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260820164957.1895963-1-pbonzini@redhat.com>
References: <20260820164957.1895963-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.346,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
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

From: "Naveen N Rao (AMD)" <naveen@kernel.org>

Refactor check_sev_features() to consolidate SEV-SNP checks to a single
if block. This is also helpful when adding checks for future SEV
features.  While at it, move the comment about the checks being done
outside of the function body and expand it to describe what this
function does. Update error_setg() invocations to use a consistent
format.

No functional change intended.

Suggested-by: Tom Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Naveen N Rao (AMD) <naveen@kernel.org>
Link: https://lore.kernel.org/r/cae04d88adfbcdc2997e518475f3b89091adf8a9.1779281646.git.naveen@kernel.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/sev.c | 67 +++++++++++++++++++++++++----------------------
 1 file changed, 36 insertions(+), 31 deletions(-)

diff --git a/target/i386/sev.c b/target/i386/sev.c
index ae9c85af131..8acbb01da22 100644
--- a/target/i386/sev.c
+++ b/target/i386/sev.c
@@ -507,40 +507,22 @@ static void sev_apply_cpu_context(CPUState *cpu)
     }
 }
 
+/*
+ * Ensure SEV_FEATURES is configured for correct SEV hardware and that
+ * the requested features are supported. In addition, ensure feature
+ * dependencies are satisfied (allow tsc-frequency only if secure-tsc
+ * is also enabled, as an example).
+ */
 static int check_sev_features(SevCommonState *sev_common, uint64_t sev_features,
                               Error **errp)
 {
-    /*
-     * Ensure SEV_FEATURES is configured for correct SEV hardware and that
-     * the requested features are supported. If SEV-SNP is enabled then
-     * that feature must be enabled, otherwise it must be cleared.
-     */
-    if (sev_snp_enabled() && !(sev_features & SVM_SEV_FEAT_SNP_ACTIVE)) {
-        error_setg(
-            errp,
-            "%s: SEV_SNP is enabled but is not enabled in VMSA sev_features",
-            __func__);
-        return -1;
-    } else if (!sev_snp_enabled() &&
-               (sev_features & SVM_SEV_FEAT_SNP_ACTIVE)) {
-        error_setg(
-            errp,
-            "%s: SEV_SNP is not enabled but is enabled in VMSA sev_features",
-            __func__);
-        return -1;
-    }
-    if (sev_features && sev_es_enabled() && !sev_snp_enabled()) {
-        error_setg(errp,
-                   "%s: SEV features are not supported with SEV-ES at this time",
-                   __func__);
-        return -1;
-    }
     if (sev_features && !sev_es_enabled()) {
         error_setg(errp,
                    "%s: SEV features require either SEV-ES or SEV-SNP to be enabled",
                    __func__);
         return -1;
     }
+
     if (sev_features & ~sev_common->supported_sev_features) {
         error_setg(errp,
                    "%s: VMSA contains unsupported sev_features: %lX, "
@@ -548,13 +530,36 @@ static int check_sev_features(SevCommonState *sev_common, uint64_t sev_features,
                    __func__, sev_features, sev_common->supported_sev_features);
         return -1;
     }
-    if (sev_snp_enabled() && SEV_SNP_GUEST(sev_common)->tsc_khz &&
-        !(sev_features & SVM_SEV_FEAT_SECURE_TSC)) {
-        error_setg(errp,
-                   "%s: TSC frequency can only be set if Secure TSC is enabled",
-                   __func__);
-        return -1;
+
+    if (sev_snp_enabled()) {
+        if (!(sev_features & SVM_SEV_FEAT_SNP_ACTIVE)) {
+            error_setg(errp,
+                       "%s: SEV_SNP is enabled but is not enabled in VMSA sev_features",
+                       __func__);
+            return -1;
+        }
+        if (SEV_SNP_GUEST(sev_common)->tsc_khz &&
+            !(sev_features & SVM_SEV_FEAT_SECURE_TSC)) {
+            error_setg(errp,
+                       "%s: TSC frequency can only be set if Secure TSC is enabled",
+                       __func__);
+            return -1;
+        }
+    } else {
+        if (sev_features && sev_es_enabled()) {
+            error_setg(errp,
+                       "%s: SEV features are not supported with SEV-ES at this time",
+                       __func__);
+            return -1;
+        }
+        if (sev_features & SVM_SEV_FEAT_SNP_ACTIVE) {
+            error_setg(errp,
+                       "%s: SEV_SNP is not enabled but is enabled in VMSA sev_features",
+                       __func__);
+            return -1;
+        }
     }
+
     return 0;
 }
 
-- 
2.55.0


