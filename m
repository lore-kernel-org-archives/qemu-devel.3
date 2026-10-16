Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEB31CCF2C2
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2026 16:59:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHlGg-00085Q-RK; Fri, 16 Oct 2026 12:58:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wesley.hershberger@canonical.com>)
 id 1xHlGX-00083A-Lb
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 12:58:47 -0400
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wesley.hershberger@canonical.com>)
 id 1xHlGT-0005k6-Np
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 12:58:44 -0400
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 92DE13F982
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2026 16:58:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1792169920;
 bh=Uxep4lAMFTJMpmjQLfgum4WJqUhVTQg6C/p5qA8d+B0=;
 h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
 In-Reply-To:To:Cc;
 b=AJa5xkK1IfMQObbMZjP2gaTSitpYUtxtxFOzjfnOfe+mIPRwKTwkvqTmUbOyhKpEi
 RNEUa+KvtaKhHyCG6ojkePYmxPV78M7gEjPy2/LhW2wI2aLNfoU9hLvDGweVUOSx8k
 FmZ1vY2pIiMlFsV+FqxMxgYEU2mzsvQ4Oas3+s5TeHP/RD6qUf+gtlQaUxd/jw3/9b
 ODXV/cL00aD5uR6N8qtzW+dxZ9tTL4SCfzssCuIPUh18U6l9hq16sIbAxl0NRDNQEL
 CKcFUsRTR4d/cld0CNjz0ktCzRn5DXuWgI9o/qKLxRaV/W3hDTvhMRyAeYokjQZK0F
 ejFOgEGtZodzA31zE/gL55WVIW1Q6orG/dwXpFwfS3o7Hy5OKD5T+1eoszr4RKb5aW
 WpEui8wNVeMow5ZzkgchtEnbuGA5TK+InXRV2gKQPcHxTAd653fmsnHZMG4cnTM3Gv
 YsnQmWJiqMz9Syyqbje26m4c59YAcVhgVATkWXuT8wbTM+R5vYwpJZTKrRX6zyu4OF
 zl5vkPvyJvHtRa71RlSNCHCaDi+fDy7EvN6BoNWxp8FBpXAVxNWDRSoGiCesZut3jo
 3T9KYD8nnTs5PkXNAN9++gAfJJ6ZWUmMneOf8/D8rPQgxoOL/IpRdKUb0oXeC0NW0I
 iNXvNk4YxOutAb0c43zp6fmc=
Received: by mail-yw1-f197.google.com with SMTP id
 00721157ae682-8acc7fe346cso1336957b3.3
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2026 09:58:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792169919; x=1792774719;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Uxep4lAMFTJMpmjQLfgum4WJqUhVTQg6C/p5qA8d+B0=;
 b=GCXbufFn0GumY6y0fskY4mt2uouH1LMfnecmaBwqGRHMBSqVmXEQKVFfmXu78UVnay
 C7V6EWYv/PXY5f+4JYTraDDjKTsPkVhUf/4t9/NGyj+YrEzzQhhwwuUYdoIi689iWgsQ
 tBdqRPIt31E7G5esyroCzBbPDaW735eefcr5qhUFTmd2o7zTtcjrpS62fjenXuvxrIeb
 h0sNxEpjX5x2d5JBSVCvWDqhlryZbFtT4Ejr3pKqHITNjLIFetAQxQMm5+43gft/dSJf
 tmhozZGwhvuEjmr3GhR5yAkKyRyP+9aFEK23b2r30SMfVRwNznqhAfYb2yoQS67De1X/
 sgvQ==
X-Gm-Message-State: AFq9FYJjdpHH20Zi5g/n7ShePkvg82V92I5ereRIxngnsNeodTMqlKlL
 ZfZQHJgHzjyW8UAzDNd/KKtUef8rLsbAyd6jto4LeoTyQ2pA+ducl8/nQgi/Y337lC/gc6w8oKc
 S/HfkKmH6NWGiO3XhM/UGh020Ma4fu97w3SzD6C7NjNUWtcbuTUUea4IzHU0bkMElChNHrM7V
X-Gm-Gg: AYBFou0PMYNKXOyAlhiu/0pqmYTL97cCOqJcY1LvWSSl/NOk7Uj2RavlujR1I4DKbzZ
 hEIWspwnChA5BaEyghWu/OQGAbhuOmQz8RZIIvoOjimwi46QaEdoUX61Uzf9Iv3hQ1xwbdnKmMU
 0TXCkfcxDo4NtVEHQ8BPJ97/i/Z62N1XSdPXpGnXm1oaQmDzlzXs0V5TOdKcloI4df0Rj9spx36
 DX6WdClOKlqiE2hnsnWq8heee924FhGZyrhm9BwiTEzPFBNAx5kKMOVCY0oi1yZYe+AsAlaPBey
 cUFBFgrf9eq4OIM4T0MUV4AggfRtyZKfNIzutDgHhcNXaDi4WRXUBZRCYevsvwLphCF1vWylxnh
 4NLX8rK4LOock/cO7yu/ZN2uhUvEp7ATzhIBbzt2w1POlfAmKII2yGw==
X-Received: by 2002:a05:690c:6604:b0:88a:4770:c2e9 with SMTP id
 00721157ae682-8b0f214735dmr2952187b3.14.1792169919192; 
 Fri, 16 Oct 2026 09:58:39 -0700 (PDT)
X-Received: by 2002:a05:690c:6604:b0:88a:4770:c2e9 with SMTP id
 00721157ae682-8b0f214735dmr2952077b3.14.1792169918771; 
 Fri, 16 Oct 2026 09:58:38 -0700 (PDT)
Received: from [127.0.1.1] ([2600:6c45:3000:1420:26da:25ea:7a28:6e4d])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-8b0e58ad1b4sm12193167b3.18.2026.10.16.09.58.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Oct 2026 09:58:37 -0700 (PDT)
From: Wesley Hershberger <wesley.hershberger@canonical.com>
Date: Fri, 16 Oct 2026 11:57:52 -0500
Subject: [PATCH v5 2/2] util/coroutine: Reduce default idle pool max size
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261016-set-default-pool-size-v5-2-719e9e4d3f9c@canonical.com>
References: <20261016-set-default-pool-size-v5-0-719e9e4d3f9c@canonical.com>
In-Reply-To: <20261016-set-default-pool-size-v5-0-719e9e4d3f9c@canonical.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Kevin Wolf <kwolf@redhat.com>, Hector Cao <hector.cao@canonical.com>, 
 =?utf-8?q?Alex_Ram=C3=ADrez?= <alex.ramirez@canonical.com>, 
 Wesley Hershberger <wesley.hershberger@canonical.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=4042;
 i=wesley.hershberger@canonical.com; h=from:subject:message-id;
 bh=7S4rtSqSrMu1r94QRHzeGQHLhS2L8aSAcTCaxlCaCjM=;
 b=owEB7QES/pANAwAKAfkogKziOh25AcsmYgBq0le6TRvLrfeLPZLMIo4vdq+LzfsokrgbCPjmU
 1u3pol+PzGJAbMEAAEKAB0WIQQsIHxFLwpehxEbQ8r5KICs4joduQUCatJXugAKCRD5KICs4jod
 uUNxDACGkrxMRIY3zID/Sjo0NxBUGMjzZDqmhTQVIfyNxTf74pp42qHwmccvpF6O9o7plwCbkfz
 QwlUetUVo5VVVjKEmPs9EP+U2Csd3gH6yleqVYzJ78tYlcXkHsKYM3fDHK4rqxhufkwMP29zl88
 Qusxky+M0k2sO+p5iTcOpW/4eMXXFGi3rUVYY+TKGkRXOo1F82F0HsqbcZCtLBbKoL60IZDYp+0
 BQ2RSvvkQI7Yzhz32qCufX9pvETsQCWMABIv8FQDFjicr9WCV8VRGwDP+qUotUdeIPHO7ltH3rW
 Q/SyPrUSWmD2p2bkJ8IymwfD1/EdnH+HvhCAubpzmR2+51p0FfboAJUR0b9SlM9QamAyabXhUYy
 EYBNGKsQy6aoxqla373Wxcl0tqfH4iKXZumMpcfyNdvK/wh0utC8SH2CC9J3sxIrsthD1eEGzkq
 9TfQciiy3g4eaeuFnqINYC/TI3yvEGfEtGdgzTWjDIf05BXlcICOcrtjbkrXUBP6KpL0o=
X-Developer-Key: i=wesley.hershberger@canonical.com; a=openpgp;
 fpr=2C207C452F0A5E87111B43CAF92880ACE23A1DB9
Received-SPF: pass client-ip=185.125.188.123;
 envelope-from=wesley.hershberger@canonical.com;
 helo=smtp-relay-internal-1.canonical.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

If g_file_get_contents fails (AppArmor, etc), use a more conservative
default max size for the idle coroutine pool.

This avoids any possibility of the failure described in 86a637e48104
unless the host kernel is configured with a lower-than-default
vm.max_map_count.

This change is motivated by a discussion of backport risk:
https://bugs.launchpad.net/ubuntu/+source/qemu/+bug/2168803/comments/8

Fixes: 86a637e48104 ("coroutine: cap per-thread local pool size")
Suggested-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Wesley Hershberger <wesley.hershberger@canonical.com>
---
 util/qemu-coroutine.c | 73 ++++++++++++++++++++++++++++++++-------------------
 1 file changed, 46 insertions(+), 27 deletions(-)

diff --git a/util/qemu-coroutine.c b/util/qemu-coroutine.c
index 5af61995437..fc9ed66f475 100644
--- a/util/qemu-coroutine.c
+++ b/util/qemu-coroutine.c
@@ -361,42 +361,61 @@ void qemu_coroutine_dec_pool_size(unsigned int removing_pool_size)
     global_pool_max_size -= removing_pool_size;
 }
 
-static unsigned int get_global_pool_hard_max_size(void)
-{
 #ifdef __linux__
-    g_autofree char *contents = NULL;
-    int max_map_count;
+/*
+ * include/linux/mm.h
+ */
+#define DEFAULT_MAX_MAP_COUNT 65530
 
-    /*
-     * Linux processes can have up to max_map_count virtual memory areas
-     * (VMAs). mmap(2), mprotect(2), etc fail with ENOMEM beyond this limit. We
-     * must limit the coroutine pool to a safe size to avoid running out of
-     * VMAs.
-     */
-    if (g_file_get_contents("/proc/sys/vm/max_map_count", &contents, NULL,
-                            NULL)) {
+static unsigned int get_max_map_count(void)
+{
+    g_autofree char *contents = NULL;
+    unsigned int max_map_count = 0;
+    if (g_file_get_contents("/proc/sys/vm/max_map_count", &contents,
+                            NULL, NULL)) {
         /* contents has trailing newline, remove it before conversion */
         g_strchomp(contents);
-        if (qemu_strtoi(contents, NULL, 10, &max_map_count) != 0) {
-            return UINT_MAX;
-        }
-        /*
-         * This is an upper bound that avoids exceeding max_map_count. Leave a
-         * fixed amount for non-coroutine users like library dependencies,
-         * vhost-user, etc. Each coroutine takes up 2 VMAs so halve the
-         * remaining amount.
-         */
-        if (max_map_count > 5000) {
-            return (max_map_count - 5000) / 2;
-        } else {
-            /* Disable the global pool but threads still have local pools */
-            return 0;
+        if (qemu_strtoui(contents, NULL, 10, &max_map_count) == 0) {
+            return max_map_count;
         }
     }
-#endif
 
+    /*
+     * Read from /proc might fail due to mandatory access control (AppArmor,
+     * SELinux, etc). Use the kernel's default in that case.
+     */
+    return DEFAULT_MAX_MAP_COUNT;
+}
+
+/*
+ * Linux processes can have up to max_map_count virtual memory areas
+ * (VMAs). mmap(2), mprotect(2), etc fail with ENOMEM beyond this limit. We
+ * must limit the coroutine pool to a safe size to avoid running out of
+ * VMAs.
+ */
+static unsigned int get_global_pool_hard_max_size(void)
+{
+    unsigned int max_map_count = get_max_map_count();
+
+    /*
+     * This is an upper bound that avoids exceeding max_map_count. Leave a
+     * fixed amount for non-coroutine users like library dependencies,
+     * vhost-user, etc. Each coroutine takes up 2 VMAs so halve the
+     * remaining amount.
+     */
+    if (max_map_count > 5000) {
+        return (max_map_count - 5000) / 2;
+    } else {
+        /* Disable the global pool but threads still have local pools */
+        return 0;
+    }
+}
+#else
+static unsigned int get_global_pool_hard_max_size(void)
+{
     return UINT_MAX;
 }
+#endif
 
 static void __attribute__((constructor)) qemu_coroutine_init(void)
 {

-- 
2.53.0


