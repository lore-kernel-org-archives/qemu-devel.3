Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30AA0C3DA50
	for <qemu-devel@archiver.kernel.org>; Sun, 14 Jul 2024 05:12:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sSrWM-0007bz-11; Sun, 14 Jul 2024 01:11:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sSrWF-0007Nm-RO
 for qemu-devel@nongnu.org; Sun, 14 Jul 2024 01:11:33 -0400
Received: from mail-oi1-x22f.google.com ([2607:f8b0:4864:20::22f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sSrWE-00054Z-By
 for qemu-devel@nongnu.org; Sun, 14 Jul 2024 01:11:31 -0400
Received: by mail-oi1-x22f.google.com with SMTP id
 5614622812f47-3d9db222782so1970458b6e.3
 for <qemu-devel@nongnu.org>; Sat, 13 Jul 2024 22:11:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1720933889; x=1721538689;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=4cfAZs9gcmRBQAfP5MoBvIZbiyJezK58nIuVHbTQt3E=;
 b=nmN01QC+i2TmW50HmFRYof4EWvWf56TlnCfXuYO7DtLXGVwkJWyoDqWuA/fIbybfav
 LTTZn5mB5G4+ckrfypmk1OTkiBI5miS5nkjCiip0nuO+0o+xXs6XL+qh1ERGa2N0DOP6
 vxeC4eoMtcGexZsfSfxbtIyuydmdeNZPiSXOF/f1ZEi57N5/qdPnMNO8JEOgBLFML3iq
 2KfixsAy0TcFbujGV6tzn8rvkACmhhzSU0yXlKibU61z9+Nqy1543+okTX3wRR1fDwI+
 ZKOS7h3OGEXc4XlS3JtFKPHIdtFIMzT+KL6Y0KcEOYGjJpsE5Qd8dh1nRL+ryb2uTlBc
 LrnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720933889; x=1721538689;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4cfAZs9gcmRBQAfP5MoBvIZbiyJezK58nIuVHbTQt3E=;
 b=hYYI52yEK6Q3Te48THRDKKr9JCUeRO80HR3HsvLUM+1cvqGKN7VmF9vzcRNm3NeSHH
 AmpAl/1H8U+INuUZkZjcyh9WXF7nBAQZ1j6gQYYoTNV6ZoTkwsMJitG56F4XbwjJrnYN
 iZ9kTbK+5xl7VA3pPhaoXotEUO5exaCcadBt2L/ab4Yd9/g2OISr2FfSiHqHEQv+HeQz
 TPIlFtKeMzoTK4gCvf5LLfJ+FPp/gjRcVSGq+vUWHkWCuV5CNyzOtC8yTseBLjYd7BL+
 pipD4CnCraXnw7VsLlDDA7G/ljJQLPW5AaIh9pmHx+0r2a1daQ/ZE3KDSXuij6RwbVua
 CyXQ==
X-Gm-Message-State: AOJu0Yx+W5eeaXCRgwo41b2kIHw9Uz/Kf2/JH5zCPxAIKEeMIcrBcypC
 DeS+abXu6fPgeg1APLCuB1AXonqqRYZo/TkDXt/RGurRQmoZlR636Y1EG3ygyuM=
X-Google-Smtp-Source: AGHT+IFkXgADrSYg1RyLJr4YABin1ixkWJpJRXbaB90TFqgaot5y98YF1Mjin56f/JHbYT/0pGjqyg==
X-Received: by 2002:a05:6808:1311:b0:3d9:2562:7541 with SMTP id
 5614622812f47-3d93c01f75dmr20053472b6e.24.1720933889093; 
 Sat, 13 Jul 2024 22:11:29 -0700 (PDT)
Received: from localhost ([157.82.204.135])
 by smtp.gmail.com with UTF8SMTPSA id
 d2e1a72fcca58-70b7eca64b1sm2074373b3a.143.2024.07.13.22.11.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 13 Jul 2024 22:11:28 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Sun, 14 Jul 2024 14:11:05 +0900
Subject: [PATCH v3 5/5] virtio-net: Remove fallback from ebpf-rss-fds
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240714-auto-v3-5-e27401aabab3@daynix.com>
References: <20240714-auto-v3-0-e27401aabab3@daynix.com>
In-Reply-To: <20240714-auto-v3-0-e27401aabab3@daynix.com>
To: Jason Wang <jasowang@redhat.com>, 
 Dmitry Fleytman <dmitry.fleytman@gmail.com>, 
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Luigi Rizzo <rizzo@iet.unipi.it>, 
 Giuseppe Lettieri <g.lettieri@iet.unipi.it>, 
 Vincenzo Maffione <v.maffione@gmail.com>, 
 Andrew Melnychenko <andrew@daynix.com>, 
 Yuri Benditovich <yuri.benditovich@daynix.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>
Cc: qemu-devel@nongnu.org, Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14-dev-fd6e3
Received-SPF: none client-ip=2607:f8b0:4864:20::22f;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-oi1-x22f.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

If ebpf-rss-fds is specified but we fail to use, we should not fall
back to loading eBPF programs by ourselves as such makes the situation
complicated.

Suggested-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 hw/net/virtio-net.c | 24 +++++++++---------------
 1 file changed, 9 insertions(+), 15 deletions(-)

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index e779ba2df428..2f0a4f2aabf7 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -1361,21 +1361,21 @@ static void virtio_net_disable_rss(VirtIONet *n)
     virtio_net_commit_rss_config(n);
 }
 
-static bool virtio_net_load_ebpf_fds(VirtIONet *n)
+static bool virtio_net_load_ebpf_fds(VirtIONet *n, Error **errp)
 {
     int fds[EBPF_RSS_MAX_FDS] = { [0 ... EBPF_RSS_MAX_FDS - 1] = -1};
     int ret = true;
     int i = 0;
 
     if (n->nr_ebpf_rss_fds != EBPF_RSS_MAX_FDS) {
-        warn_report("Expected %d file descriptors but got %d",
-                    EBPF_RSS_MAX_FDS, n->nr_ebpf_rss_fds);
+        error_setg(errp, "Expected %d file descriptors but got %d",
+                   EBPF_RSS_MAX_FDS, n->nr_ebpf_rss_fds);
        return false;
    }
 
     for (i = 0; i < n->nr_ebpf_rss_fds; i++) {
         fds[i] = monitor_fd_param(monitor_cur(), n->ebpf_rss_fds[i],
-                                  &error_warn);
+                                  errp);
         if (fds[i] < 0) {
             ret = false;
             goto exit;
@@ -1394,17 +1394,11 @@ exit:
     return ret;
 }
 
-static bool virtio_net_load_ebpf(VirtIONet *n)
+static bool virtio_net_load_ebpf(VirtIONet *n, Error **errp)
 {
-    bool ret = false;
-
-    if (virtio_net_attach_ebpf_to_backend(n->nic, -1)) {
-        if (!(n->ebpf_rss_fds && virtio_net_load_ebpf_fds(n))) {
-            ret = ebpf_rss_load(&n->ebpf_rss);
-        }
-    }
-
-    return ret;
+    return virtio_net_attach_ebpf_to_backend(n->nic, -1) &&
+           (n->ebpf_rss_fds ? virtio_net_load_ebpf_fds(n, errp) :
+                              ebpf_rss_load(&n->ebpf_rss));
 }
 
 static void virtio_net_unload_ebpf(VirtIONet *n)
@@ -3805,7 +3799,7 @@ static void virtio_net_device_realize(DeviceState *dev, Error **errp)
     if (virtio_has_feature(n->host_features.on_bits |
                            n->host_features.auto_bits,
                            VIRTIO_NET_F_RSS)) {
-        virtio_net_load_ebpf(n);
+        virtio_net_load_ebpf(n, errp);
     }
 }
 

-- 
2.45.2


