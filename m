Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27531C3271E
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jul 2024 07:39:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sQixQ-0002Oi-KL; Mon, 08 Jul 2024 03:38:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sQixO-0002HU-6J
 for qemu-devel@nongnu.org; Mon, 08 Jul 2024 03:38:42 -0400
Received: from mail-il1-x12b.google.com ([2607:f8b0:4864:20::12b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sQixM-00024G-N9
 for qemu-devel@nongnu.org; Mon, 08 Jul 2024 03:38:41 -0400
Received: by mail-il1-x12b.google.com with SMTP id
 e9e14a558f8ab-389ccd2f0abso88225ab.2
 for <qemu-devel@nongnu.org>; Mon, 08 Jul 2024 00:38:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1720424319; x=1721029119;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=iMISOcooxhdq/M4EEkPrjF33VD9e2Se2tW19e/nqD5A=;
 b=01OcDC/GH56aVsbwQoTZXOeMp7rHRFh5tp48FEsBiyniNDkSM1+8niFAJFT/JN9Mp/
 i037rbq4H15ID9viF9UpEavOBWvvHk0jl4s6Dq8lzYywpvRKGoCDeQ4j8MNFhJKtMZnB
 WTXWdpiJEKtE5PuWtR47kesZPVU/5GPukHKpGYoCRwU5nQmsk8W3M1ydpbiMnAVM+oqf
 f5T27N/y+VqKYPfxm5ivltZZJs4wbtHmGtzFvTTFPEcnX903AmfQLxzE7C9WtCjpKNzh
 DGjRnk5taiGTjGfD5DeWrl6kabiHHM+Vt3SPnQ5s8gkQ1zW0+RVY2EzvLm3yXlCX+J/G
 j14A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720424319; x=1721029119;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iMISOcooxhdq/M4EEkPrjF33VD9e2Se2tW19e/nqD5A=;
 b=O1VHhADxZX8QvrnK7ijdllkytN3SScm33F0rOS8nssFPvKmUuaBFMKTacw8KbbefVU
 vr6WAaA67kwJhuoZqnBpQFHpcCbzCunOvMUx+BFO/7y6Gee5S9/Vz0rTV2rVsRGdJj1t
 1FwufQPw33itkdnjodwcb8c/pqlDv1dovdya7A7hVanmsR7dBD9yBIvx4ln6mCwu1EeZ
 SCYkdvDeLqwTffYwzGjomPoiXWN4PTlXcAD0N7BS/c2nWEDH4LIhP5J6UW2LXrJac6+h
 By9fo+iL76xO3xC7kHhTxe64GERDTg01eLlm7qREXQ5jwYOlp6qASCVmjDNzP/rxGbKJ
 xlLQ==
X-Gm-Message-State: AOJu0YzDRXVA8shifaeaK0YLc+YyX8GA7xiL6S4czadKqykx86CKk9jK
 6pzSJomgSzY3cWLl4489hUUvGYR9i0mbOLh61Rsoz6HywyHsmuQBGANzrfskRVo=
X-Google-Smtp-Source: AGHT+IFm7NBhoNtqECj27U/6vBgOkLLfRC9sG3hc5gnG/V00uVQhzlpJdXd71UwM1sBZH4V6kjLudw==
X-Received: by 2002:a05:6e02:1d10:b0:382:b82b:6e48 with SMTP id
 e9e14a558f8ab-38398b02802mr131355105ab.9.1720424319664; 
 Mon, 08 Jul 2024 00:38:39 -0700 (PDT)
Received: from localhost ([157.82.204.135])
 by smtp.gmail.com with UTF8SMTPSA id
 41be03b00d2f7-766adeb08c9sm3739492a12.64.2024.07.08.00.38.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 08 Jul 2024 00:38:39 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Mon, 08 Jul 2024 16:38:08 +0900
Subject: [PATCH v2 3/4] virtio-net: Report RSS warning at device
 realization
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240708-auto-v2-3-f4908b953f05@daynix.com>
References: <20240708-auto-v2-0-f4908b953f05@daynix.com>
In-Reply-To: <20240708-auto-v2-0-f4908b953f05@daynix.com>
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
Received-SPF: none client-ip=2607:f8b0:4864:20::12b;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-il1-x12b.google.com
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

Warning about RSS fallback at device realization allows the user to
notice the configuration problem early.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 hw/net/virtio-net.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index bd285921d507..e779ba2df428 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -822,6 +822,10 @@ static uint64_t virtio_net_get_features(VirtIODevice *vdev, uint64_t features,
 
     if (!get_vhost_net(nc->peer)) {
         if (!ebpf_rss_is_loaded(&n->ebpf_rss)) {
+            if (on_off_auto_features.on_bits & VIRTIO_NET_F_RSS) {
+                warn_report("Can't load eBPF RSS - fallback to software RSS");
+            }
+
             virtio_clear_feature(&on_off_auto_features.auto_bits,
                                  VIRTIO_NET_F_RSS);
         }
@@ -1332,16 +1336,10 @@ static void virtio_net_detach_epbf_rss(VirtIONet *n)
 static void virtio_net_commit_rss_config(VirtIONet *n)
 {
     if (n->rss_data.enabled) {
-        n->rss_data.enabled_software_rss = n->rss_data.populate_hash;
+        n->rss_data.enabled_software_rss = n->rss_data.populate_hash ||
+                                           !virtio_net_attach_epbf_rss(n);
         if (n->rss_data.populate_hash) {
             virtio_net_detach_epbf_rss(n);
-        } else if (!virtio_net_attach_epbf_rss(n)) {
-            if (get_vhost_net(qemu_get_queue(n->nic)->peer)) {
-                warn_report("Can't load eBPF RSS for vhost");
-            } else {
-                warn_report("Can't load eBPF RSS - fallback to software RSS");
-                n->rss_data.enabled_software_rss = true;
-            }
         }
 
         trace_virtio_net_rss_enable(n->rss_data.hash_types,

-- 
2.45.2


