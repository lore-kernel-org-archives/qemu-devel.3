Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5D39CD128A
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Apr 2024 11:12:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rryWs-0007Ss-NI; Wed, 03 Apr 2024 07:11:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rryWi-0007Rq-PO
 for qemu-devel@nongnu.org; Wed, 03 Apr 2024 07:11:32 -0400
Received: from mail-io1-xd2f.google.com ([2607:f8b0:4864:20::d2f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rryWb-0007Gz-3V
 for qemu-devel@nongnu.org; Wed, 03 Apr 2024 07:11:31 -0400
Received: by mail-io1-xd2f.google.com with SMTP id
 ca18e2360f4ac-7c7f3f66d17so208042139f.0
 for <qemu-devel@nongnu.org>; Wed, 03 Apr 2024 04:11:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1712142683; x=1712747483;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=GBdjBXNThvQx0/pnNoSh1VAmZe6PeAFaRuMnO+Fqs0c=;
 b=VllDsaO0I78eKKucuG/KLJkIirCN3ARRZWvtYh1O8/W0ysIWlOiPTJtgeg0ciRyhdE
 aR3r1j17HiVd/le/p9BJNq5RfKXRWFSoR/xNwyuO+eET5FXDXcF/Wo3x87psNLSq3uMr
 +LF4Vp7Ulm6nSW0PMPjxjCAKAlsR112sNMD2eXZ4uzUlJ5pbOREifELlUkZOYvJXQh4k
 +xpcVHMT827XC2n520OCmqmzVF3ZIlY/5vvzqR/JEOulp1j8BiSZgDQ7L4PhFvtRQ+g7
 EB7qgzzyuNV1E1FYPyTOvmO7sizjBj3zaI0oJyI7Ch5A5oYBzgpfDyTA77TrP53TIfWT
 Nukw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712142683; x=1712747483;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GBdjBXNThvQx0/pnNoSh1VAmZe6PeAFaRuMnO+Fqs0c=;
 b=AARrrwjt6Vy+RJex9u2orfNEgwik6VGeiANW+yX0wkaJNiG8jLn3Xw9ARDyivfFDAu
 7ILZnFmCW3wUNa1rhql8xIhd/rxNranOZ5TQY383wefhoQzvPpEN0FyJzHwYdl7Y0fhw
 HG9bPAtAnR3dde+WZ4Lgeor1ifcQD5hbFeyOAayiPaW0jvoOp/UHtKQJjQ+HcQE6xf67
 KnUISWFHJ+5B75VoAwFuuEo9tv1VE8IxbN5tFug7RT6d3/id5X+KajcnMYvUqVdPajH+
 EdxAKauXVOWDwyLS7fNJwFhzRJJEtplpi0hKXWvV4iEEtmlZMPrT1XPYBJqv5z3Wjj1g
 6PBQ==
X-Gm-Message-State: AOJu0Ywnpeq2tTlocG+2FEETW7NUYt8i2mNo8OnHeGx40BYttmGqiVVj
 l4nqcfWuQHBV/PP0kZ26ZwJucAiwRqjeyyoRubC+iSFA1Lz8jpAiWD445icqxLg=
X-Google-Smtp-Source: AGHT+IH8dNuFXYK7x6R9LAUYYR/W1ZV2jNM09zJef/wx9JiCriNqiUGfLnrjoP98dl+LsZJLdr4ppg==
X-Received: by 2002:a05:6e02:350c:b0:366:a7e1:7677 with SMTP id
 bu12-20020a056e02350c00b00366a7e17677mr18429284ilb.3.1712142683716; 
 Wed, 03 Apr 2024 04:11:23 -0700 (PDT)
Received: from localhost ([157.82.200.213])
 by smtp.gmail.com with UTF8SMTPSA id
 a185-20020a6366c2000000b005dc88b232a5sm11316911pgc.26.2024.04.03.04.11.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 03 Apr 2024 04:11:23 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Wed, 03 Apr 2024 20:10:55 +0900
Subject: [PATCH v9 07/20] virtio-net: Do not propagate ebpf-rss-fds errors
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240403-rss-v9-7-c6d87e69d38b@daynix.com>
References: <20240403-rss-v9-0-c6d87e69d38b@daynix.com>
In-Reply-To: <20240403-rss-v9-0-c6d87e69d38b@daynix.com>
To: Jason Wang <jasowang@redhat.com>, 
 Dmitry Fleytman <dmitry.fleytman@gmail.com>, 
 Sriram Yagnaraman <sriram.yagnaraman@est.tech>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Luigi Rizzo <rizzo@iet.unipi.it>, 
 Giuseppe Lettieri <g.lettieri@iet.unipi.it>, 
 Vincenzo Maffione <v.maffione@gmail.com>, 
 Andrew Melnychenko <andrew@daynix.com>, 
 Yuri Benditovich <yuri.benditovich@daynix.com>
Cc: qemu-devel@nongnu.org, Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14-dev
Received-SPF: none client-ip=2607:f8b0:4864:20::d2f;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-io1-xd2f.google.com
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

Propagating ebpf-rss-fds errors has several problems.

First, it makes device realization fail and disables the fallback to the
conventional eBPF loading.

Second, it leaks memory by making device realization fail without
freeing memory already allocated.

Third, the convention is to set an error when a function returns false,
but virtio_net_load_ebpf_fds() and virtio_net_load_ebpf() returns false
without setting an error, which is confusing.

Remove the propagation to fix these problems.

Fixes: 0524ea0510a3 ("ebpf: Added eBPF initialization by fds.")
Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 hw/net/virtio-net.c | 23 ++++++++++-------------
 1 file changed, 10 insertions(+), 13 deletions(-)

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index f6112c0ac97d..8ede38aadbbe 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -1329,24 +1329,22 @@ static void virtio_net_detach_epbf_rss(VirtIONet *n)
     virtio_net_attach_ebpf_to_backend(n->nic, -1);
 }
 
-static bool virtio_net_load_ebpf_fds(VirtIONet *n, Error **errp)
+static bool virtio_net_load_ebpf_fds(VirtIONet *n)
 {
     int fds[EBPF_RSS_MAX_FDS] = { [0 ... EBPF_RSS_MAX_FDS - 1] = -1};
     int ret = true;
     int i = 0;
 
-    ERRP_GUARD();
-
     if (n->nr_ebpf_rss_fds != EBPF_RSS_MAX_FDS) {
-        error_setg(errp,
-                  "Expected %d file descriptors but got %d",
-                  EBPF_RSS_MAX_FDS, n->nr_ebpf_rss_fds);
+        warn_report("Expected %d file descriptors but got %d",
+                    EBPF_RSS_MAX_FDS, n->nr_ebpf_rss_fds);
        return false;
    }
 
     for (i = 0; i < n->nr_ebpf_rss_fds; i++) {
-        fds[i] = monitor_fd_param(monitor_cur(), n->ebpf_rss_fds[i], errp);
-        if (*errp) {
+        fds[i] = monitor_fd_param(monitor_cur(), n->ebpf_rss_fds[i],
+                                  &error_warn);
+        if (fds[i] < 0) {
             ret = false;
             goto exit;
         }
@@ -1355,7 +1353,7 @@ static bool virtio_net_load_ebpf_fds(VirtIONet *n, Error **errp)
     ret = ebpf_rss_load_fds(&n->ebpf_rss, fds[0], fds[1], fds[2], fds[3]);
 
 exit:
-    if (!ret || *errp) {
+    if (!ret) {
         for (i = 0; i < n->nr_ebpf_rss_fds && fds[i] != -1; i++) {
             close(fds[i]);
         }
@@ -1364,13 +1362,12 @@ exit:
     return ret;
 }
 
-static bool virtio_net_load_ebpf(VirtIONet *n, Error **errp)
+static bool virtio_net_load_ebpf(VirtIONet *n)
 {
     bool ret = false;
 
     if (virtio_net_attach_ebpf_to_backend(n->nic, -1)) {
-        if (!(n->ebpf_rss_fds
-                && virtio_net_load_ebpf_fds(n, errp))) {
+        if (!(n->ebpf_rss_fds && virtio_net_load_ebpf_fds(n))) {
             ret = ebpf_rss_load(&n->ebpf_rss);
         }
     }
@@ -3825,7 +3822,7 @@ static void virtio_net_device_realize(DeviceState *dev, Error **errp)
     net_rx_pkt_init(&n->rx_pkt);
 
     if (virtio_has_feature(n->host_features, VIRTIO_NET_F_RSS)) {
-        virtio_net_load_ebpf(n, errp);
+        virtio_net_load_ebpf(n);
     }
 }
 

-- 
2.44.0


