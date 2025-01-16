Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2F51E77188
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2025 07:31:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYKL9-0003bF-Pp; Thu, 16 Jan 2025 02:30:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tYKL7-0003al-3K
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 02:30:53 -0500
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tYKL4-0003JL-5v
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 02:30:52 -0500
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-2163b0c09afso9359225ad.0
 for <qemu-devel@nongnu.org>; Wed, 15 Jan 2025 23:30:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1737012648; x=1737617448;
 darn=nongnu.org; 
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=jHxPvp+sEtOMIezkJ5q0V+wdRR85/+kI2ql9qQarF18=;
 b=3IeQmw3tidg18AaarOLMmbkbdI/RdOh0+NtRZVJOqnSpErzDicbBrcFp4NFfCgUDzp
 xZOSX+Vf/R3fF9pd+yDHKfLRmxvLt32k67dbEGgoVlAD0E8h6CtWyzoDEL9dmQZZoSUx
 gbdwPQk3DvOcwzaJhoVt5+b1E0lTo0fZCuTCzsC1wUKq/OOZ6Wqf8O1EPLL5A9kVs1+B
 i8f3UqXemQ3/45Km0kxXpWFERBszRoloNkjEKTuu3yCQymsNpelbyn52IDxIJgP85G6B
 ldslmbS38wOa9fLF8Q/CxPaBTi0fJg09w7afEP/JKiyjXRZBqpH9VuykZxjeDvmq04S2
 qNpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737012648; x=1737617448;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jHxPvp+sEtOMIezkJ5q0V+wdRR85/+kI2ql9qQarF18=;
 b=RKzWmvLffc9pHU57zS+pS+3TFeBALUuwLrNWw8xb3lZsftKW4Q1KKt4f2IAUP+Vcr0
 wla/lXust03bhQJIDFeZ5O2tX3a0TBiIas4euzUChnhFmbOPfr5hKkVjCZuwapVhhHgV
 EQpfB+ODKiRwnWNWEBmLbDSa3zgQ5ogyLcnOiCUaq3CnRrsWrgW2Ekmn6/q1EqVI6yuz
 2qaChw9Sg3qBn3O+lF4ILqDczenYi5oVXl7LKsMcmX6t+AW4l5lptpHHg1aRIQ76xFFp
 +JbnMrkEcCGRhxJyVLx6UcEvMGt1a05txmu7J12R/xyLPO3eG0cntZBByKfFPMqzlDms
 Znpw==
X-Gm-Message-State: AOJu0YxO9qhxeWmO/58IPn2beBThXp8eghMqr66Ly5LABCUDh+YSi6ly
 dQ8A6uHBfo7asoon5myovffpbOVvpnk6Hdr4Ss945C1jUyY49S7HGJneb7487Xe32UrS9ErDOqI
 xDTA=
X-Gm-Gg: ASbGncvcPJkKtvZdQFQbMX5aJzKxkYVXyMEZmR7qmnF6VrTI9Wex+iONIubdp+dmgqz
 X6Nx10onikxuhmH4dev01HrTCMcCnwKVu1NsMJLevVyVwPlGOAjoJmsMCJ6xFrGrI7QhUvm1bpY
 qwPUCgScexpPwIRowWQb9zZVjJ2pkGCSXglQ/15P1qZdyiH7Ket4Fd2Q7VhGgAqPsWF1FI70ySP
 Z3vsk/P5Iw+O1c+iOtuU9F5qaG04P4SPNtQkzqYr8Wn5R3byt4ufWyhyV8=
X-Google-Smtp-Source: AGHT+IE5j3BLZmlSfBxDkQVPdoKhcEKYgUntV0WOJ/IRJg2QEqRNRITy/7ze7zYiTNjYyJ1jX48SLA==
X-Received: by 2002:a05:6a21:2d09:b0:1e0:d1db:4d8a with SMTP id
 adf61e73a8af0-1e88d0edac9mr44700298637.10.1737012648250; 
 Wed, 15 Jan 2025 23:30:48 -0800 (PST)
Received: from localhost ([157.82.203.37]) by smtp.gmail.com with UTF8SMTPSA id
 d2e1a72fcca58-72d406a94d7sm10215681b3a.164.2025.01.15.23.30.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 Jan 2025 23:30:47 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Thu, 16 Jan 2025 16:30:43 +0900
Subject: [PATCH] hw/net: Fix NULL dereference with software RSS
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250116-software-v1-1-9e5161b534d8@daynix.com>
X-B4-Tracking: v=1; b=H4sIAKK1iGcC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDQ0Mz3eL8tJLyxKJUXSNLc6NEU2PLlNSUNCWg8oKi1LTMCrBR0bG1tQA
 +EOrGWgAAAA==
To: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>
Cc: qemu-devel@nongnu.org, devel@daynix.com, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14-dev-fd6e3
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x630.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

When an eBPF program cannot be attached, virtio_net_load_ebpf() returns
false, and virtio_net_device_realize() enters the code path to handle
errors because of this, but it causes NULL dereference because no error
is generated.

Change virtio_net_load_ebpf() to return false only when a fatal error
occurred.

Fixes: b5900dff14e5 ("hw/net: report errors from failing to use eBPF RSS FDs")
Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 hw/net/virtio-net.c | 43 +++++++++++++++++--------------------------
 1 file changed, 17 insertions(+), 26 deletions(-)

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index 06f096abf678..71fd6e9ea42d 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -1352,18 +1352,25 @@ exit:
 
 static bool virtio_net_load_ebpf(VirtIONet *n, Error **errp)
 {
-    bool ret = false;
+    if (!virtio_net_attach_ebpf_to_backend(n->nic, -1)) {
+        return true;
+    }
 
-    if (virtio_net_attach_ebpf_to_backend(n->nic, -1)) {
-        trace_virtio_net_rss_load(n, n->nr_ebpf_rss_fds, n->ebpf_rss_fds);
-        if (n->ebpf_rss_fds) {
-            ret = virtio_net_load_ebpf_fds(n, errp);
-        } else {
-            ret = ebpf_rss_load(&n->ebpf_rss, errp);
-        }
+    trace_virtio_net_rss_load(n, n->nr_ebpf_rss_fds, n->ebpf_rss_fds);
+
+    /*
+     * If user explicitly gave QEMU RSS FDs to use, then
+     * failing to use them must be considered a fatal
+     * error. If no RSS FDs were provided, QEMU is trying
+     * eBPF on a "best effort" basis only, so report a
+     * warning and allow fallback to software RSS.
+     */
+    if (n->ebpf_rss_fds) {
+        return virtio_net_load_ebpf_fds(n, errp);
     }
 
-    return ret;
+    ebpf_rss_load(&n->ebpf_rss, &error_warn);
+    return true;
 }
 
 static void virtio_net_unload_ebpf(VirtIONet *n)
@@ -3801,23 +3808,7 @@ static void virtio_net_device_realize(DeviceState *dev, Error **errp)
     net_rx_pkt_init(&n->rx_pkt);
 
     if (virtio_has_feature(n->host_features, VIRTIO_NET_F_RSS)) {
-        Error *err = NULL;
-        if (!virtio_net_load_ebpf(n, &err)) {
-            /*
-             * If user explicitly gave QEMU RSS FDs to use, then
-             * failing to use them must be considered a fatal
-             * error. If no RSS FDs were provided, QEMU is trying
-             * eBPF on a "best effort" basis only, so report a
-             * warning and allow fallback to software RSS.
-             */
-            if (n->ebpf_rss_fds) {
-                error_propagate(errp, err);
-            } else {
-                warn_report("unable to load eBPF RSS: %s",
-                            error_get_pretty(err));
-                error_free(err);
-            }
-        }
+        virtio_net_load_ebpf(n, errp);
     }
 }
 

---
base-commit: 38d0939b86e2eef6f6a622c6f1f7befda0146595
change-id: 20250116-software-2972a539dedf

Best regards,
-- 
Akihiko Odaki <akihiko.odaki@daynix.com>


