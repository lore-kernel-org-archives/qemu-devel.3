Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1A76C35FE0
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Sep 2024 01:07:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1spdjA-0001SZ-De; Sat, 14 Sep 2024 21:07:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1spdj8-0001OF-O3
 for qemu-devel@nongnu.org; Sat, 14 Sep 2024 21:06:58 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1spdj7-0004AY-6k
 for qemu-devel@nongnu.org; Sat, 14 Sep 2024 21:06:58 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-2053616fa36so39680675ad.0
 for <qemu-devel@nongnu.org>; Sat, 14 Sep 2024 18:06:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1726362415; x=1726967215;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=TJXuPeXYKPTzK6yFSg9nQc+Qxxmfh9dt2HenYTLinZ0=;
 b=y7Z3cg/CIqa7R0/Mnd7YndKuES9zJUG7tWzsIEqdhG0I427G51olZd8VYQtjpY59tX
 sBOyN/nOrChbGn5Rx6KSR8FhWnGZyN3yGk4pSpVtOrOFPTeWDnEOeQO6cm1g5OcQMkrg
 tmIHU4iOS0IyRtYz/+YX4IK5IUG0ncpn1UNMREI16f+KatAPh+UcP5PqTNt9qS6PpCkE
 ah5+s4ZebJr78ItB9Xjuc6F4Ck8LUEvUZkxDA7HQHdunvd//eT0ChPaq8wNQYz4E7Tsn
 I+ETFgHjfF8hTxOsCuqvBmrMF/X+lud6LeYkC/CYFLx0Z48T+7/7z33JUC+Mq6ggVhhP
 BzJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726362415; x=1726967215;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TJXuPeXYKPTzK6yFSg9nQc+Qxxmfh9dt2HenYTLinZ0=;
 b=k7GAXjHPVETT2kfQd68/N2QhWBpKE/AGWGeNRldgtmOqwDITK2w6KOYTyr3XNgXBc5
 io8YyDEVzAy2/vNms5SnPIZ9N9KgeNyzlzB84yH9NgZHjcTfuaNyuZTXSBFX5wdWGzJX
 WYc0JB0TpOUUvntfDoIyMPHHlgGXRjMFPNwFT2vQWipjh1k5tDJdEC3pcqOujetkDNFd
 BMLVR+xR2Q1eUTV/KJkgwD0UEEMSq3kOoBZY2jYjQDGA1pggMfX4PbtiwKXA/m/2zvXi
 ycVYZ9NrfNmo0gzm6TylzVO08hlExeGc8Tnp0yrjhsPPMxPZMnn2/GDPm6AJemGCFu2k
 OGVg==
X-Gm-Message-State: AOJu0YwEmQbWjlG5KDMHHqJz7LA6C5usViilQyM6pk/Yaq9I0IkOBvQs
 X1pwlf/P9evATC6vk5r/WLMyQ7dfiIDNK+AXRht4aP/uoCGPp/rCfhZuz7aGSv0=
X-Google-Smtp-Source: AGHT+IHDdM6RtsDG5q1aX0+PPggEv7aJ/0jn74p+B27R3RskGtns6eCBBZZYcR+W+yA+2Yj8ozu0LQ==
X-Received: by 2002:a17:902:e5c3:b0:205:709e:1949 with SMTP id
 d9443c01a7336-2076e421fd0mr180808305ad.57.1726362415315; 
 Sat, 14 Sep 2024 18:06:55 -0700 (PDT)
Received: from localhost ([210.160.217.68])
 by smtp.gmail.com with UTF8SMTPSA id
 d9443c01a7336-207945da8d4sm14765615ad.59.2024.09.14.18.06.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 14 Sep 2024 18:06:55 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Sun, 15 Sep 2024 10:06:41 +0900
Subject: [PATCH 3/7] virtio-net: Do not check for the queue before RSS
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240915-queue-v1-3-b49bd49b926d@daynix.com>
References: <20240915-queue-v1-0-b49bd49b926d@daynix.com>
In-Reply-To: <20240915-queue-v1-0-b49bd49b926d@daynix.com>
To: Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14-dev-fd6e3
Received-SPF: none client-ip=2607:f8b0:4864:20::62e;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x62e.google.com
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
index 755530c035e4..3ee1ebd88daa 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -1901,10 +1901,6 @@ static ssize_t virtio_net_receive_rcu(NetClientState *nc, const uint8_t *buf,
     size_t offset, i, guest_offset, j;
     ssize_t err;
 
-    if (!virtio_net_can_receive(nc)) {
-        return -1;
-    }
-
     if (!no_rss && n->rss_data.enabled && n->rss_data.enabled_software_rss) {
         int index = virtio_net_process_rss(nc, buf, size, &extra_hdr);
         if (index >= 0) {
@@ -1913,6 +1909,10 @@ static ssize_t virtio_net_receive_rcu(NetClientState *nc, const uint8_t *buf,
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
2.46.0


