Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 978D4CC6B15
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2026 22:05:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGkcD-0001LG-VM; Tue, 13 Oct 2026 18:04:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wesley.hershberger@canonical.com>)
 id 1xGkcA-0001Kl-7T
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 18:04:54 -0400
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wesley.hershberger@canonical.com>)
 id 1xGkc8-000619-3n
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 18:04:53 -0400
Received: from mail-yx1-f71.google.com (mail-yx1-f71.google.com
 [74.125.224.71])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id CC2623F2CE
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2026 22:04:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1791929090;
 bh=TcmpB3djd3TuyPIv4GWkpVa9SlH1CKtA5W8vUnZGjTo=;
 h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
 In-Reply-To:To:Cc;
 b=HmgQeY1rmAkL+haEpvH51rTJk/Sn5NBf2YU1SeCXI6acnEH/RqR0NpY5IdTKPpYEU
 dyV3UoBNziX82yLqvMnh/Muo1jrD9vm/KXknZX+cEkVMo3H6VbhOeoVEvaQ1dTopOF
 I+GqyVaSL5QvjOaOtYNxdyiRpTxYLpWm3rGBqF9iy5ECvKc2VfoVcv6ivfWZDQpCJu
 jC1xcbpi2K9ZRvy5fOWEgBp3MDR1havFxCooGhVfcM5ga+2GVde8JWRbFsvGVA25vq
 dO4r5hfX6vx44vPW/Hn4p4o1n9xhWgrLl9Fwf6Kri0JuxtdnwsRMjwYLuoFWJeOwee
 5hDd1SjamNzQCV2bqQuMK9hH+F4WCp+sXBtje5c6ygleR9z4xRfNfGd7D/zIRrchb2
 RIvP/i9QORwEUmBKEMAtUEyp1fkywnubx6BXOaTxaVn9XtcBrF3HHiBZ6LPDN6OD8z
 0jRwuBFbETYagCCSQi4cZ+gn/zMqbTUg07Ha41kNXi1ZhbuHIBG9z3yzBkxwZkmH+1
 +gxFXunGVFQM2QZZf/Cs0CSjHYdhVpa3jZYLHeWp1SHHBGRLSAqwpLofFdKpSqQkJV
 wJVH2ZQk+xGEyek7wObpUKxTPydUycVgs9nKcvBmGh7UA4Rhi+E66hNeOHoxaWtPRe
 zA6LGztAgDeD6Ta3P1J9vDxs=
Received: by mail-yx1-f71.google.com with SMTP id
 956f58d0204a3-67694007c9cso4570452d50.3
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2026 15:04:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791929090; x=1792533890;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=TcmpB3djd3TuyPIv4GWkpVa9SlH1CKtA5W8vUnZGjTo=;
 b=TIkkNEzHEz3uf3nhOBobr1PjLwdcsWQpdUg81p4KeNpLbAq0U8EyR0gMGOt2xcUfsi
 rkEaRE7zuUWwrrHchdIKOaOdsE/+V9pFotVRFpRHdj9u+wWrJyqKjTPjA5GbdTw6G6Dx
 ADN/wTZdrmcUqbJA709lLa+zNFZSETHey7RU+RckFP5Xz6yURM9jg1s69fP8B97mFOyk
 G56avWnX3WV1aQ8EQBwCkgoRkjZxz54mRTFSqL2PeGkY0BSMrZ8ILqPB0VrI2MrP0Ua+
 OdulzFp1+0Eb06obZ+g8gDKwoZao+iWg1d5v5PnAoYoN4kFzwe6hGeHccoRCGbbWmDrW
 5Z5A==
X-Gm-Message-State: AFq9FYKhXkiinJgaKCe3QRY6mSUbBxwm0luCvhcM1VsOZS7LLJrXtYPk
 hgY342btVBqdrylbC3h0+iLFpglwHxv2YvtgMJYpYN1c97BjERMJ9v0tFlfA1tb0UQFH55mDcn+
 f29GeoFflU+O/YlKltlCPXAKjpBudiW/EMFeTpJCz7WHFopKR0FrsnbFCnTurjhkn6KQlTfUt
X-Gm-Gg: AYBFou2iprHbnYXoEcegd2Vw5q9yhoZKI1DPXRHzTEP7CLwI8jrBztxb8EI/5fUZKjG
 ufybOwHwf2q+LSL2rOKwi9pLB4EisYel6fwECdIgPKIKLsaAnNN8Pddo2MuwLclnTCFWNfpqTsC
 A8Tauj6VpUoEJV08N9YPYELY07Y/58AgAU7FIcvku/yyupz9EMR3hQg0IwEjVSML0+YE0XMjmrZ
 ahPJU9VOgcUhn8urs1R126fOZe7BIPnehudsfrRFj4+2W5VbFSXI2aX+IaExr8UyuxWkYcTdpjg
 hnFBmhnLELWgYgGxFJzEXeI+o3RZgW+mn4tigusF6EZI/73ae8RxVhgwwhJAb430AeBpT8eGvZD
 8uWvLtfD8gL7EGV8iuKLR0OJ89audlWRmJWN+3t8rpAEqgA==
X-Received: by 2002:a05:690e:4813:b0:677:c63c:ed3f with SMTP id
 956f58d0204a3-67936a45e25mr3607945d50.69.1791929089697; 
 Tue, 13 Oct 2026 15:04:49 -0700 (PDT)
X-Received: by 2002:a05:690e:4813:b0:677:c63c:ed3f with SMTP id
 956f58d0204a3-67936a45e25mr3607935d50.69.1791929089315; 
 Tue, 13 Oct 2026 15:04:49 -0700 (PDT)
Received: from [127.0.1.1] ([97.87.60.46]) by smtp.gmail.com with ESMTPSA id
 956f58d0204a3-67986a679ecsm336019d50.13.2026.10.13.15.04.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2026 15:04:48 -0700 (PDT)
From: Wesley Hershberger <wesley.hershberger@canonical.com>
Date: Tue, 13 Oct 2026 17:01:01 -0500
Subject: [PATCH v3 2/2] util/coroutine: Reduce default idle pool max size
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261013-set-default-pool-size-v3-2-d36e8c31f9a6@canonical.com>
References: <20261013-set-default-pool-size-v3-0-d36e8c31f9a6@canonical.com>
In-Reply-To: <20261013-set-default-pool-size-v3-0-d36e8c31f9a6@canonical.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>, 
 Hector Cao <hector.cao@canonical.com>, 
 Wesley Hershberger <wesley.hershberger@canonical.com>, 
 alex.ramirez@canonical.com, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=4033;
 i=wesley.hershberger@canonical.com; h=from:subject:message-id;
 bh=qgH2fFPgXnJ2Uv+d8V0RX+OGVuxaot78rOkEJ9WODuY=;
 b=owEB7QES/pANAwAKAfkogKziOh25AcsmYgBqzqr9/xyoU+/Gtc7D5LxbAFwyDhqCAvps/5XOr
 kGGgmGxlpSJAbMEAAEKAB0WIQQsIHxFLwpehxEbQ8r5KICs4joduQUCas6q/QAKCRD5KICs4jod
 uU65C/4zoiwZYD+yMgjyEffjkVxMlm/VkjEeF85qao+NDpoUzqb+h2ppetf7yjJgqZnmlY+ruzg
 gPL1Le4d283ialExtOedo0Hs/vP5kYokmUIV1/WjbDTavTF7O8S38Tx03dY+dtlrssgt39mUzcf
 eUlgv6n45PUvvj94LGwcrpcfkMCfR7S64kDEfTEU28hZzPLb0AqP7Qmrk59ZZlWzGEjlVGRicYp
 hFITNvLGT7YyBgzmd41MERm9xH5S7F6vm/E++V0Q/0uUg2sAUwjBsGBjAaW+GNmLdstueeAo//y
 WTtx14THYPGlolzTm0Lp84pjY0doy+9YkLhd/TrPzq0+wJ7PHX1asNblpJtpEy6lwID8YboyNnH
 eFHeSpTeocymBjrBa51Sio0xWNyCp+AuDSaebFSf9bC8wTa6L2VOuu2IcCsJVy++N+u/ST9V+9Q
 vwbUx7hKAqPSIxSVI4++UOnPgOyPLPGr4ucV56iYjEA9lUC0f/0qQOWKX/E+ENfyF4dDc=
X-Developer-Key: i=wesley.hershberger@canonical.com; a=openpgp;
 fpr=2C207C452F0A5E87111B43CAF92880ACE23A1DB9
Received-SPF: pass client-ip=185.125.188.123;
 envelope-from=wesley.hershberger@canonical.com;
 helo=smtp-relay-internal-1.canonical.com
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_BL_SPAMCOP_NET=1.347, RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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
Signed-off-by: Wesley Hershberger <wesley.hershberger@canonical.com>
---
 util/qemu-coroutine.c | 75 ++++++++++++++++++++++++++++++++-------------------
 1 file changed, 48 insertions(+), 27 deletions(-)

diff --git a/util/qemu-coroutine.c b/util/qemu-coroutine.c
index 5af61995437..8ced93144fa 100644
--- a/util/qemu-coroutine.c
+++ b/util/qemu-coroutine.c
@@ -361,42 +361,63 @@ void qemu_coroutine_dec_pool_size(unsigned int removing_pool_size)
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
+    int max_map_count = 0;
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
+        if (qemu_strtoi(contents, NULL, 10, &max_map_count) == 0) {
+            return max_map_count;
         }
     }
-#endif
+    return 0;
+}
 
+/*
+ * Linux processes can have up to max_map_count virtual memory areas
+ * (VMAs). mmap(2), mprotect(2), etc fail with ENOMEM beyond this limit. We
+ * must limit the coroutine pool to a safe size to avoid running out of
+ * VMAs.
+ */
+static unsigned int get_global_pool_hard_max_size(void)
+{
+    /*
+     * Read from /proc might fail due to mandatory access control (AppArmor,
+     * SELinux, etc). Use the kernel's default in that case.
+     */
+    int max_map_count = get_max_map_count();
+    if (!max_map_count) {
+        max_map_count = DEFAULT_MAX_MAP_COUNT;
+    }
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


