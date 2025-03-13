Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DAB2C282DE
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Mar 2025 06:58:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tscV5-0007p1-H3; Thu, 13 Mar 2025 02:57:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tscUU-00074I-7i
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 02:56:28 -0400
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tscUS-0006Az-Cs
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 02:56:25 -0400
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-2ff64550991so1155115a91.0
 for <qemu-devel@nongnu.org>; Wed, 12 Mar 2025 23:56:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1741848983; x=1742453783;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=FMIoIr6/4bz4Br49nK8n48Lj1al7ccgCjDAUACVxZ3k=;
 b=irmfMljIyLw2DTqs4xxgBqb7w2wFWHsnjaoXRYAkduxfKiyDPx2iTQuq+wLLOW+sik
 PB55zZh0UgC7RiVQGJERcQK6zKXVv8sti6PHC442jXvP6Rqhzlh/ooCz+2pXf3Ybzlhq
 9pwzJCQP3I1ReDpKOAzFeEX6HMI3zeUyzrF5FELj6O65ob9jO5Y80EfNUr00vA2t69Hs
 eIQ59Y4BBV09j2+luUhJfrH0uK3Mfn9vT8tDKeJLnMcqAzdDE8MFWFbiyVhlYAInvMxi
 4oQVS2oAIkQQzN9hh/a2yfpRNrMnq8l2X2mCSVlNi4y96gAGC1oXWjtWf4dr4imlsreg
 oNeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741848983; x=1742453783;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FMIoIr6/4bz4Br49nK8n48Lj1al7ccgCjDAUACVxZ3k=;
 b=qO0ZxwGZsByR52N5Z/u3t9cJncozs0ic+jNZv3I1hoSTVJ9ZFrs6IatklDdE4JtwIA
 EpZXo3HTPU5xojaNhdZd4z0wEhXTazejMRa2XkkR3I/bzyGdW/diPnG87xc8zADoXmuQ
 rMSaUnaM/ZMjupLSOe7wjc72hna652+c6YZ63Mn8kLtnDhR8P+v4CyM+ysuiTDuS4UCN
 DwUNNCcjTTftrIiZR7em/YuM4Fm/7IhCgl/omCM2t81gXMZz1tntUQWvPvcpK6yR2k6A
 S/GkrFrTw/mOZ/OcNeMJY4nhX5k8ApEnwnf7xeFfmnXzFqF7rzR9cgHg+k7dn3hTj0fO
 yEXQ==
X-Gm-Message-State: AOJu0Yxv2uH7R42+SKb1zcdMcT3EF4UY0eT5A/Wl0m3z9aU2+X9fZEeW
 485oUtWM3/iM7Poi5180cbDrmBPbov8e9g04o2Kg2F8BW/vPNCaube5w6C70rmYK9GrSkoR1rBb
 iWvs=
X-Gm-Gg: ASbGnctDJ3yewnNjn/lkH7F/0rzvvjvh5H6PwG7tQd0btrdKW8va4vnDalc7x225dfK
 rh5xwqgtm6UNloz8tEYXurgcmzVbRbiW5t+qmspG6QEFBe2FjSbNlXsXN8QP/r+BBDiImsLI00r
 k3U+d2bCNwsBPAdCv/q8uCm8icYXmMXmvJKW2WGfa4eluHEsfaX66ONRhQMLRbpArnPgRpui2WY
 yGIQhvLvbgXIKzHoZkJxeaQ5AxjR/UlxUYgucTjVIJhWwMeZjD2U4zU0+ymAU/4v0strS8FMYYe
 rvLqpgehU9lnEV1eOlSwLViOHfTot2OG6Uw7/Wt8GU5FYOl1topJgM/0EAo=
X-Google-Smtp-Source: AGHT+IHTIevd5a5psY4w5trpr7wr2G/IPwvA1BcpwguiEM1U9FOPuZDRlLJgYPGaQxP8aEEWGEXZ3A==
X-Received: by 2002:a17:90b:3ecb:b0:2fe:6942:370e with SMTP id
 98e67ed59e1d1-2ff7ce70a09mr36244314a91.7.1741848982934; 
 Wed, 12 Mar 2025 23:56:22 -0700 (PDT)
Received: from localhost ([157.82.205.237])
 by smtp.gmail.com with UTF8SMTPSA id
 98e67ed59e1d1-3011821840dsm3078987a91.4.2025.03.12.23.56.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 12 Mar 2025 23:56:22 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Thu, 13 Mar 2025 15:55:37 +0900
Subject: [PATCH RFC v4 11/11] docs/devel/ebpf_rss.rst: Update for peer RSS
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250313-hash-v4-11-c75c494b495e@daynix.com>
References: <20250313-hash-v4-0-c75c494b495e@daynix.com>
In-Reply-To: <20250313-hash-v4-0-c75c494b495e@daynix.com>
To: qemu-devel@nongnu.org, Yuri Benditovich <yuri.benditovich@daynix.com>, 
 Andrew Melnychenko <andrew@daynix.com>, 
 "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
 devel@daynix.com
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.15-dev-edae6
Received-SPF: pass client-ip=2607:f8b0:4864:20::102a;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pj1-x102a.google.com
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

eBPF RSS virtio-net support was written in assumption that there is only
one alternative RSS implementation: 'in-qemu' RSS. It is no longer true,
and we now have yet another implementation; namely the peer RSS.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 docs/devel/ebpf_rss.rst | 23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

diff --git a/docs/devel/ebpf_rss.rst b/docs/devel/ebpf_rss.rst
index ed5d33767bd5..f128f0990905 100644
--- a/docs/devel/ebpf_rss.rst
+++ b/docs/devel/ebpf_rss.rst
@@ -7,9 +7,22 @@ eBPF RSS virtio-net support
 RSS(Receive Side Scaling) is used to distribute network packets to guest virtqueues
 by calculating packet hash. Usually every queue is processed then by a specific guest CPU core.
 
-For now there are 2 RSS implementations in qemu:
-- 'in-qemu' RSS (functions if qemu receives network packets, i.e. vhost=off)
-- eBPF RSS (can function with also with vhost=on)
+For now there are 3 RSS implementations in qemu:
+1. Peer RSS
+2. eBPF RSS
+3. 'In-QEMU' RSS
+
+'In-QEMU' RSS is incompatible with vhost since the packets are not routed to
+QEMU. eBPF RSS requires Linux 5.8+. Peer RSS requires the peer to implement RSS.
+Currently QEMU can use the RSS implementation of vDPA and Linux's TUN module
+with the following patch applied:
+https://lore.kernel.org/r/20240915-rss-v3-0-c630015db082@daynix.com/
+
+eBPF RSS does not support hash reporting. Peer RSS may support limited hash
+types.
+
+virtio-net automatically chooses the RSS implementation to use. Peer RSS is
+the most preferred, and 'in-QEMU' RSS is the least.
 
 eBPF support (CONFIG_EBPF) is enabled by 'configure' script.
 To enable eBPF RSS support use './configure --enable-bpf'.
@@ -49,9 +62,6 @@ eBPF RSS turned on by different combinations of vhost-net, vitrio-net and tap co
 
         tap,vhost=on & virtio-net-pci,rss=on,hash=on
 
-If CONFIG_EBPF is not set then only 'in-qemu' RSS is supported.
-Also 'in-qemu' RSS, as a fallback, is used if the eBPF program failed to load or set to TUN.
-
 RSS eBPF program
 ----------------
 
@@ -67,7 +77,6 @@ Prerequisites to recompile the eBPF program (regenerate ebpf/rss.bpf.skeleton.h)
         $ make -f Makefile.ebpf
 
 Current eBPF RSS implementation uses 'bounded loops' with 'backward jump instructions' which present in the last kernels.
-Overall eBPF RSS works on kernels 5.8+.
 
 eBPF RSS implementation
 -----------------------

-- 
2.48.1


