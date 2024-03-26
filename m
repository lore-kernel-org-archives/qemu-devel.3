Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40207CD11DF
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Mar 2024 10:08:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rp3i1-0006Aj-W6; Tue, 26 Mar 2024 06:07:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rp3hz-0006AP-7L
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 06:07:07 -0400
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rp3hv-0000cV-TJ
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 06:07:06 -0400
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-2a04ac98cf7so1948753a91.0
 for <qemu-devel@nongnu.org>; Tue, 26 Mar 2024 03:07:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1711447622; x=1712052422;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=LE24uluRQ9KTcauWcR//b64EcOukqLmAzNLJotmbG6Q=;
 b=TaI7iYTiU1uhs/VeJTeDPt9kr76HaCD1azv5dhpEZE8NTu5SukNEaliGqLbBWAysdh
 kdSUGZHHiboz103govv+FyVGyXz/8P5mUbsk+LhkCyocpHZYuofx6YBeR2crNk7LN0K9
 eZZgwJjy6RSVcfN89stkTpxp7tQebtYqK9AQ4fFX7SOzH26N7OUodNfnh168BY4WcOrr
 0f6NVcU5S9ugQXWdqyAxzsCxzj/FWd6ewbVxmkf7LIuPkqEAEMJ96Q3DNpDKq6Ch17Qa
 8olDAEaIPY3wXkEMA550x9SWzd+UOX5y9EZadE47sO6Tl3n2/Cyb4cvY0x6yu6z1HQNx
 d4nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711447622; x=1712052422;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LE24uluRQ9KTcauWcR//b64EcOukqLmAzNLJotmbG6Q=;
 b=TU8pilyo4+O0cEWqJDcZIjivUD+ZmL/VWGs3hFFr/+VLWt9macjDDSFDnVXOFOuMMH
 hLLAVrwkSDVEqX7IY5QpAmSrtIENlAbigTBLZZ9SYn+ZpMcDf/yQDYL/wyDt6aVKB72Y
 BWTe43UltQfD5bXPKCLWJNXNQbI+W7kAURV4Qhc8YDzW7pPX/lMNTruXKgUYwp1B+iTZ
 Mn1q1Xlm0e/fpQbbRyUMk4O2ttRI2M46nFa8Eewo/9BBEVLuE/bLAP0mg4vSiaC+8pnn
 cgt8ypa8264lMP6TIegd1NztRxamL2AAwe+swMnKO7L6/9I93bNM3PCAReLMBqntITtK
 Y+4A==
X-Gm-Message-State: AOJu0YyhAqegtX6tqVY2BH4YVrDZWO8UHfDjEfnLVSHtn1B3Pg27UT51
 X2o2vr+bngCZvK3eAIGuJEzqyE0MRccZB1wr5g5yHCUSof6SeuVy/abph+eG18M=
X-Google-Smtp-Source: AGHT+IEqJUad4tXd2Iq/lYbsAx06V/hHG40TSop9hHEbZprXYvUfThD86Wfxl6vZFFW0uBNYrlGHRA==
X-Received: by 2002:a17:90a:2f01:b0:2a0:8d17:948d with SMTP id
 s1-20020a17090a2f0100b002a08d17948dmr883086pjd.1.1711447622326; 
 Tue, 26 Mar 2024 03:07:02 -0700 (PDT)
Received: from localhost ([157.82.202.248])
 by smtp.gmail.com with UTF8SMTPSA id
 l18-20020a17090a599200b0029beb0fc60fsm11348831pji.28.2024.03.26.03.07.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 26 Mar 2024 03:07:02 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Tue, 26 Mar 2024 19:06:29 +0900
Subject: [PATCH 1/2] virtio-net: Fix vhost virtqueue notifiers for RSS
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240326-vhost-v1-1-09bd85b1ba2c@daynix.com>
References: <20240326-vhost-v1-0-09bd85b1ba2c@daynix.com>
In-Reply-To: <20240326-vhost-v1-0-09bd85b1ba2c@daynix.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
 Andrew Melnychenko <andrew@daynix.com>, 
 Yuri Benditovich <yuri.benditovich@daynix.com>
Cc: qemu-devel@nongnu.org, Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.13.0
Received-SPF: none client-ip=2607:f8b0:4864:20::1030;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pj1-x1030.google.com
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

virtio_net_guest_notifier_pending() and virtio_net_guest_notifier_mask()
checked VIRTIO_NET_F_MQ to know there are multiple queues, but
VIRTIO_NET_F_RSS also enables multiple queues. Refer to n->multiqueue,
which is set to true either of VIRTIO_NET_F_MQ or VIRTIO_NET_F_RSS is
enabled.

Fixes: 68b0a6395f36 ("virtio-net: align ctrl_vq index for non-mq guest for vhost_vdpa")
Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 hw/net/virtio-net.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index 9959f1932b1b..a6ff000cd9d3 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -3426,7 +3426,7 @@ static bool virtio_net_guest_notifier_pending(VirtIODevice *vdev, int idx)
     VirtIONet *n = VIRTIO_NET(vdev);
     NetClientState *nc;
     assert(n->vhost_started);
-    if (!virtio_vdev_has_feature(vdev, VIRTIO_NET_F_MQ) && idx == 2) {
+    if (!n->multiqueue && idx == 2) {
         /* Must guard against invalid features and bogus queue index
          * from being set by malicious guest, or penetrated through
          * buggy migration stream.
@@ -3458,7 +3458,7 @@ static void virtio_net_guest_notifier_mask(VirtIODevice *vdev, int idx,
     VirtIONet *n = VIRTIO_NET(vdev);
     NetClientState *nc;
     assert(n->vhost_started);
-    if (!virtio_vdev_has_feature(vdev, VIRTIO_NET_F_MQ) && idx == 2) {
+    if (!n->multiqueue && idx == 2) {
         /* Must guard against invalid features and bogus queue index
          * from being set by malicious guest, or penetrated through
          * buggy migration stream.

-- 
2.44.0


