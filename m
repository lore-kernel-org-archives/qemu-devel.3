Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21A6AE65D26
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2024 05:04:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tELpL-0005m3-1i; Fri, 22 Nov 2024 00:03:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tELpE-0005cQ-Ut
 for qemu-devel@nongnu.org; Fri, 22 Nov 2024 00:03:25 -0500
Received: from mail-oa1-x2a.google.com ([2001:4860:4864:20::2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tELpD-0006SP-Be
 for qemu-devel@nongnu.org; Fri, 22 Nov 2024 00:03:24 -0500
Received: by mail-oa1-x2a.google.com with SMTP id
 586e51a60fabf-296b0d23303so958542fac.2
 for <qemu-devel@nongnu.org>; Thu, 21 Nov 2024 21:03:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1732251801; x=1732856601;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=RFrNi2VVoowoqBy/v/ykZ3Me3c8V3mgQT6KledOV830=;
 b=N5ePF+LvCRJQOtuvvh7ndzqXvKOc05HcFlOuxg9YKZinZeQm2y3OcRzRZavSelfxx0
 Zo7CeVGPFpRyAOg4y6+GcPiKN1BjH6Kv37hLo9C7sjavLWSmZoImksSaE7Z90dzTvZ62
 GJHQjGaQAS5CaTcWrX58nWdR3iqxI8JvdOYHtvgvluuT3mmpCMEY6evdtlRAmJX9aoDX
 PA4bVk4fdXHdOeNZseVR7Cxdsb7c6knb/X4Xe/INPxnExicvCcsFhlkMxz31E/RkXTfk
 FCZjFfKf8X94XGXrDXtbQBd4Uncu7Sr3fDtxzBEveLkHzLS6GID+QZUQkwUy0XXTa/AB
 sTLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732251801; x=1732856601;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RFrNi2VVoowoqBy/v/ykZ3Me3c8V3mgQT6KledOV830=;
 b=grAAGAQCaIMYbrLOoHXUhiVslJaRR4t6TYZeD8ON7zu+vcHTb3NCUrthLT8RuBLGUa
 YvirgzaHVLa3jmgeIJRCJRwI+2gr5z6AmGmeCXJuX8MWKE2t3Zh4xhs/LZXiO148jL6N
 +fMBhZnvTvCF0fsB21K8J2qac+o8wLjiuwkYnkhzZsyZm0gren/ZF9rQhOV1waQPD6el
 yfq8x5WllvEIikFLoeu5mDkpmIYaS8U1dk72bpkennBT/IrZRCmY2IycYwQwfwkgl9Tr
 P34QbqsPYpC8zwgWzjiH6ewe5RQcTGV1aUT7UTOCKywqvsOQ+73nZadqUwI4sqKmy7KG
 xWcw==
X-Gm-Message-State: AOJu0YxnrR8ZBl3kWHlkLSc1U09QoLwzu9zKjniffzcwzYxnxrjwiJo+
 xfVirEOo2/vj6vSoZUwcp4RoihKdv3Rg3re22vXoACXoVNE1XvVFyuOKhlibVhFaeVfvrgpyhqa
 7c/o=
X-Gm-Gg: ASbGncuvoiBvC72Tegs+5KkDIJ02LgxHIBzd5VOk6lTq3i4lPojn81ryDqRkJV5dgLI
 4wyHD8S3s+uBbdVtf5IjlSobiVQD2cp+JYVfpurh9TalUnhUVwMhXzj39XZ+4y3H+VctpA7B99H
 Pzn0LA1THIDEq+mVHLJNA8Oo/etadXWY8AU0nhE1xyrrqMhdLTxuo24xv6XSXBCJ8OUH5Mk4HYl
 y/oNE7USYVpt9I1X4UaDf2IGR6PMgHKoYmUj6T4aZdT1jmSbvNP5Q==
X-Google-Smtp-Source: AGHT+IEFtOrZjtB0E6GXqF4mxiPc7RfgQoajBAuBGF8sqsqPv9vj+dZkPy72h2JqZLtQIMsfUy+vDw==
X-Received: by 2002:a05:6870:9e47:b0:297:291c:ad88 with SMTP id
 586e51a60fabf-297291d0d9amr732788fac.28.1732251801164; 
 Thu, 21 Nov 2024 21:03:21 -0800 (PST)
Received: from localhost ([157.82.207.167])
 by smtp.gmail.com with UTF8SMTPSA id
 586e51a60fabf-2971d882c3dsm378121fac.44.2024.11.21.21.03.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 21 Nov 2024 21:03:20 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Fri, 22 Nov 2024 14:03:09 +0900
Subject: [PATCH v3 3/6] virtio-net: Do not check for the queue before RSS
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241122-queue-v3-3-f2ff03b8dbfd@daynix.com>
References: <20241122-queue-v3-0-f2ff03b8dbfd@daynix.com>
In-Reply-To: <20241122-queue-v3-0-f2ff03b8dbfd@daynix.com>
To: Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, devel@daynix.com, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14-dev-fd6e3
Received-SPF: pass client-ip=2001:4860:4864:20::2a;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-oa1-x2a.google.com
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

virtio_net_can_receive() checks if the queue is ready, but RSS will
change the queue to use so, strictly speaking, we may still be able to
receive the packet even if the queue initially provided is not ready.
Perform RSS before virtio_net_can_receive() to cover such a case.

Fixes: 4474e37a5b3a ("virtio-net: implement RX RSS processing")
Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 hw/net/virtio-net.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index a2a8d6b07bcc..d4aaf362b70f 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -1911,10 +1911,6 @@ static ssize_t virtio_net_receive_rcu(NetClientState *nc, const uint8_t *buf,
     size_t offset, i, guest_offset, j;
     ssize_t err;
 
-    if (!virtio_net_can_receive(nc)) {
-        return -1;
-    }
-
     if (!no_rss && n->rss_data.enabled && n->rss_data.enabled_software_rss) {
         int index = virtio_net_process_rss(nc, buf, size, &extra_hdr);
         if (index >= 0) {
@@ -1924,6 +1920,10 @@ static ssize_t virtio_net_receive_rcu(NetClientState *nc, const uint8_t *buf,
         }
     }
 
+    if (!virtio_net_can_receive(nc)) {
+        return -1;
+    }
+
     /* hdr_len refers to the header we supply to the guest */
     if (!virtio_net_has_buffers(q, size + n->guest_hdr_len - n->host_hdr_len)) {
         return 0;

-- 
2.47.0


