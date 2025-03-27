Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B155FC3600B
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Mar 2025 10:45:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1txkjS-0006Tr-M9; Thu, 27 Mar 2025 06:45:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hz1624917200@gmail.com>)
 id 1txkjP-0006Sc-Vz
 for qemu-devel@nongnu.org; Thu, 27 Mar 2025 06:45:04 -0400
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hz1624917200@gmail.com>)
 id 1txkjN-0008Ng-Rf
 for qemu-devel@nongnu.org; Thu, 27 Mar 2025 06:45:03 -0400
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-2ff69365e1dso985920a91.3
 for <qemu-devel@nongnu.org>; Thu, 27 Mar 2025 03:45:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1743072300; x=1743677100; darn=nongnu.org;
 h=content-transfer-encoding:to:subject:from:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=7jLladIlUr/9BE3wBxz9RQ/0MgwAqu7Zp2tJf38KPes=;
 b=nV8py48kPzzXccfjU+v4xuaMJLLhgzqBBv8V/rvqtTcUdin4Aw37GtX94DAr4BtLfe
 nnFXQyZyk93xsRKBGLT6PAjG4o6f8IZ6lIt9GcsPmHXThqWUSw+mgPJvuGOrVRGZ0y6i
 Y+nfM9YyvzECb5IRY1h3zWudqUOtTPMbeppN8TAgUQz2f+4W0pPdb+H/rYmosLaIky9F
 fMkf71C2mGpcJOIYTUjS5/LvnMFQyHKuQ3kqavoP6FXvo/U4js1kgOrISPhgoc7LaacH
 y2fwjntKsjLpFJ1EpsDtuEsxCsEaNxssGqpYDojO9So3OmMaCAZBf+LZaz2iOIEVbzA5
 ZamQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743072300; x=1743677100;
 h=content-transfer-encoding:to:subject:from:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7jLladIlUr/9BE3wBxz9RQ/0MgwAqu7Zp2tJf38KPes=;
 b=koXMUxbGo5O4THZJfUYialmYriCxuFq776ZN+PL9mLWvl+Tv9sjEWhCudocpdpvgXU
 mxnItr1j20QkenYftegpPd2OLPQpGLvyEI8XOCwsqWq/R88r01UVJaHnbVWR9znRx/yx
 eJ9oEf9TA+XzAFILZBR0abdCpu5o8Oxahtth0tsB2cMHkf+/8iIP6NQonNZ83O7KTuo8
 kOKgdFixsPoLM+PoPj/k67LePkGnMUwkkVo2Z9wRZMHNZQJbJKkURe1ZVE2bju1Hm7zU
 k1I4ISucyoJpgRvnja+43FkGXyn27kJzJv7y4M2v2sPoHMuQJSFrHwQXCAHsXDG5M7qo
 mQcA==
X-Gm-Message-State: AOJu0YxIc9tnU623TEz/I8nRRjb8QFdEjDCuUQUcnljD5uXr+gcsKji2
 B+xtYQA46k1+0e3G0Ey9TWIf1XenF4okrITe9YyRjboHLhXtidS56o/Q7Q==
X-Gm-Gg: ASbGncvMTj7lHGP7Op0LuPt+KQGD64enuTS1UUm2qNxYzIUBoQUoRlrI0cWG/rRSnpf
 5QgDqEFmJsRyGfQEeFirI7E2H/RWkuuaeN1so32LfMkO4lxw3iBKtvQbeUXky/1H5lG/yCiFMrs
 A+Fa7bdngdWWIjUXFPjrArZv01EsYwxwdgSmS5UknV5Wi5b/FjsIhrq7TGGKFxStalHZf0ux+ZP
 l8BKuMOv03XetXcuaqEdv3qFqDFYjeUgpRQDL7o1O2tiqNZbbSfiQeFVSaLQkFgGC18J/tEqrWw
 J64Hqq8zV1lIz5D6fMDIpT7iQJ8vqV0IWAHDdeRyrJPB8S90SHC93bCJb5qmwYrxLA==
X-Google-Smtp-Source: AGHT+IHKF2JErnq3d+jK1LHFQABdX8HhVoM+GyydtgsE4bJNsN4wTOIWL1tWcXr+mq+CuVUl7JLlEQ==
X-Received: by 2002:a17:90b:2c84:b0:2ee:e518:c1d8 with SMTP id
 98e67ed59e1d1-303a917ab9amr4465886a91.30.1743072299695; 
 Thu, 27 Mar 2025 03:44:59 -0700 (PDT)
Received: from [192.168.31.221] ([221.216.117.46])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22780f3b40esm125475135ad.12.2025.03.27.03.44.58
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 27 Mar 2025 03:44:59 -0700 (PDT)
Message-ID: <97f99f82-6a82-471e-aa22-65604fa5f509@gmail.com>
Date: Thu, 27 Mar 2025 18:44:57 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Zheng Huang <hz1624917200@gmail.com>
Subject: [PATCH] hw/net/virtio-net: fix memory leak in timer_del()
To: qemu-devel@nongnu.org
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1035;
 envelope-from=hz1624917200@gmail.com; helo=mail-pj1-x1035.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Hi,
This patch addresses a memory leak bug in the usages of `timer_del()`.
The issue arisesfrom the incorrect use of the ambiguous timer API 
`timer_del()`, which does not free the timer object. The leak sanitizer
report this issue during fuzzing. The correct API `timer_free()` freed
the timer object instead.

Also I'd like to ask for a way to fix all 100+ wrong usages. In my
opinion, the best way to fix this is to hide to `timer_del()` API and
eliminate all usages of it.

Signed-off-by: Zheng Huang <hz1624917200@outlook.com>

---
 hw/net/virtio-net.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index de87cfadff..ca403821e0 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -422,7 +422,7 @@ static void virtio_net_set_status(struct VirtIODevice *vdev, uint8_t status)
             }
         } else {
             if (q->tx_timer) {
-                timer_del(q->tx_timer);
+                timer_free(q->tx_timer);
             } else {
                 qemu_bh_cancel(q->tx_bh);
             }
@@ -2844,7 +2844,7 @@ static void virtio_net_handle_tx_timer(VirtIODevice *vdev, VirtQueue *vq)
 
     if (q->tx_waiting) {
         /* We already have queued packets, immediately flush */
-        timer_del(q->tx_timer);
+        timer_free(q->tx_timer);
         virtio_net_tx_timer(q);
     } else {
         /* re-arm timer to flush it (and more) on next tick */
@@ -3982,7 +3982,7 @@ static void virtio_net_reset(VirtIODevice *vdev)
     n->nobcast = 0;
     /* multiqueue is disabled by default */
     n->curr_queue_pairs = 1;
-    timer_del(n->announce_timer.tm);
+    timer_free(n->announce_timer.tm);
     n->announce_timer.round = 0;
     n->status &= ~VIRTIO_NET_S_ANNOUNCE;
 
-- 
2.34.1

