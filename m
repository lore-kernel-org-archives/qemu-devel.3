Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD8ACD12D78
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Nov 2024 06:42:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tAO6r-0006nU-JC; Mon, 11 Nov 2024 01:41:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tAO6g-0006l8-6m
 for qemu-devel@nongnu.org; Mon, 11 Nov 2024 01:41:03 -0500
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tAO6e-0000fk-QD
 for qemu-devel@nongnu.org; Mon, 11 Nov 2024 01:41:01 -0500
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-20c7ee8fe6bso39391455ad.2
 for <qemu-devel@nongnu.org>; Sun, 10 Nov 2024 22:41:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1731307259; x=1731912059;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=OF0blgGURLI6/qj69njTogJlHYc2TMJS/oPKbo52yMk=;
 b=XepsltmPcHkjJ/IhVigx3qo49MpNfWHsoTCIjqK0fkk7kYo+StqfwySqNh5A9s9pLl
 Oa0uTrTu2aFuU2XBxrJMSPzN++07XeeZ60DOkE7mGKnJz/ftob1jcCRFYKrudMMcg3Vt
 FaBZpHlD8G0G0A6KssdIiqCGl3VIpWjMM/Qsz1SL+J4TzS+lCbwPhb8jQE5O9BEB5pU4
 m76pSYjJYB7Pmj7YiHD1UuB3wG3SFEwty+6+e7QEycyNNzxE5tgCh+r/+rJjfSh+J8B/
 h/8OwhWa0VY7WtDeefXab9cX+CYO99MPepJcs6IRhL0/e20yr5Dvgx50hKRkqDJgDPRR
 T8IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731307259; x=1731912059;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OF0blgGURLI6/qj69njTogJlHYc2TMJS/oPKbo52yMk=;
 b=YGz5UANsEbj1oFcEoL0uki2DtD93PvvpJ2Th790klvOHRqppeJSEtEKP5DtQzA4mEw
 HLJwlU31qrdUmFctvhJioXn4nb1VL93ToptkfY1KNp6jqgTbHZ987K6NuYfQuN0hgwaZ
 wVOJVf0wuV7iwB0mGgJWNrtDD8ZGEJF/27ltwxPPt3gkm14JEdaSrEK7BJdYg7UszeoD
 LCpRFRyuXCdymbC85hQRO3Rjc/EkXlYpbtivGdA9paOitjSlEJmMNNEOwlnuYDMgjFxW
 lQ87aP68hYiMQSyygbGG/ss9AfDC9LLZVkmTg4uveAnP+IV8nnER8DyjswiW6acpUeiQ
 RG5Q==
X-Gm-Message-State: AOJu0YyN2tQLXH/KuTafvBuiabCxKpcrG4BRZ0sip2dk7mylcPIYq1Gs
 F5xy9ht1MdpUjHhWTqn24To0XfO36yNO9k1doP8VVzCG2En9L1diESk6DfHQoq4=
X-Google-Smtp-Source: AGHT+IEwVLBpluVmTb51SVyrnEBNtvRdwK3/SBQEgV563QSLvoGy6Y71DGi2BoL/MT9yc2Ybu9yXjA==
X-Received: by 2002:a17:903:2304:b0:20c:8df8:5066 with SMTP id
 d9443c01a7336-21183e0c466mr160734935ad.45.1731307259429; 
 Sun, 10 Nov 2024 22:40:59 -0800 (PST)
Received: from localhost ([157.82.207.107])
 by smtp.gmail.com with UTF8SMTPSA id
 d9443c01a7336-21177dc9e30sm69107265ad.43.2024.11.10.22.40.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 10 Nov 2024 22:40:59 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Mon, 11 Nov 2024 15:40:22 +0900
Subject: [PATCH v2 5/6] virtio-net: Initialize hash reporting values
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241111-queue-v2-5-2f7883a1004f@daynix.com>
References: <20241111-queue-v2-0-2f7883a1004f@daynix.com>
In-Reply-To: <20241111-queue-v2-0-2f7883a1004f@daynix.com>
To: Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, devel@daynix.com, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14-dev-fd6e3
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x62c.google.com
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

The specification says hash_report should be set to
VIRTIO_NET_HASH_REPORT_NONE if VIRTIO_NET_F_HASH_REPORT is negotiated
but not configured with VIRTIO_NET_CTRL_MQ_RSS_CONFIG. However,
virtio_net_receive_rcu() instead wrote out the content of the extra_hdr
variable, which is not uninitialized in such a case.

Fix this by zeroing the extra_hdr.

Fixes: e22f0603fb2f ("virtio-net: reference implementation of hash report")
Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 hw/net/virtio-net.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index ea5faaf16422..e75a8bb1f27a 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -1906,6 +1906,8 @@ static ssize_t virtio_net_receive_rcu(NetClientState *nc, const uint8_t *buf,
     size_t offset, i, guest_offset, j;
     ssize_t err;
 
+    memset(&extra_hdr, 0, sizeof(extra_hdr));
+
     if (n->rss_data.enabled && n->rss_data.enabled_software_rss) {
         int index = virtio_net_process_rss(nc, buf, size, &extra_hdr);
         if (index >= 0) {

-- 
2.47.0


