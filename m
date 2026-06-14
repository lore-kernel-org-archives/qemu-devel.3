Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED54CCD98C5
	for <qemu-devel@archiver.kernel.org>; Sun, 14 Jun 2026 19:15:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wYqBT-0003H4-Md; Sun, 14 Jun 2026 15:07:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wYqBS-0003DZ-4A
 for qemu-devel@nongnu.org; Sun, 14 Jun 2026 15:07:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wYqBQ-00022i-Jt
 for qemu-devel@nongnu.org; Sun, 14 Jun 2026 15:07:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781464067;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TMJ+Jpgo2ce7J8yDlqHmRVXp1DveBeVU3H/kU+6+esk=;
 b=eEROd/n5SMxpwtpnQ5TH0Q4a1/D0j73zuig1q5/8MVOLevvCyudBswOwPDD+pySYBQyVD2
 ARZTTKNgqkLSl7uvP9l6A4oICVPmPywdV9x+AwxARYU5ry/ZcyOO6+fqbgZXMgGxFViRFB
 SiA1eCxQDS0q8MZu79frE5YCMWmtBRI=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-77-p-NfuPUoOl-xVVwNk9WCBw-1; Sun, 14 Jun 2026 15:07:46 -0400
X-MC-Unique: p-NfuPUoOl-xVVwNk9WCBw-1
X-Mimecast-MFC-AGG-ID: p-NfuPUoOl-xVVwNk9WCBw_1781464065
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-45eef10d5ebso1357939f8f.0
 for <qemu-devel@nongnu.org>; Sun, 14 Jun 2026 12:07:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1781464065; x=1782068865; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=TMJ+Jpgo2ce7J8yDlqHmRVXp1DveBeVU3H/kU+6+esk=;
 b=C4pcvBM4nlQXknItbrliDwRCItmQcvfJ8RloF+tpghl+ChuDR9kzrDomsn9SsqvOVw
 NjAHTo1wKbPRWm4Uow0KhE30JrR8Fd7VzrFTUQMHnCuVkUHPHIQHzMVQwSdEJTyWrvBK
 Zh6+2v1ScDNl/bXmVbtH/Wv84nyO/2+TvRlD3DI0ZJfMy5MCYLTBAKDerRdT5MrGe/G9
 LNTlms7BQE3tvULCsmEmh67kkAYfTN8xhfN5Dh4VPLb6pzDV7d4CAjAqQPwlLVvgKz9p
 LrNwyTON4IwlsUMuL7Nji9dIHVwlu1C921wSJQpgzxj+QXxZG0eQJ55G/wPDvMzZGYpz
 9ZPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781464065; x=1782068865;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=TMJ+Jpgo2ce7J8yDlqHmRVXp1DveBeVU3H/kU+6+esk=;
 b=FvKi67/vBUcAnYFT1kM+Ixw+YPlh/UAfjEO5Fh2RhmWw6+E/o8AXKBpJksIfl9hH75
 AOFdgifcJ5+HIJfRnm5q9Obl0rseQyDX44Q9gBYRWNmJo2gdwkHyzZCrYKLOw+mQ+5pg
 uffJyBGvf57pFMIp74BIvGlZYzOfqxJEQLWgnOWjI2sjeBXSJ53h1tYA73g69o/gemGs
 8lg7fGfjSsVTqwuIjDWVd9LFj1kHZU9hnEzapRFou5JPvLK2X3vqQ++cXWwxiWk6hGjc
 1MABCE+G+GctJZpLDKdQ5NnfTmTcGF1yahwpnBUa3k8urwaB8dSyvvwj8T+sfcXZVPkf
 MCdA==
X-Gm-Message-State: AOJu0YwQa3/I/IkFrVyf2T5GmycJEIOZx3FvChsfKNutOHv1qas7n4+H
 92GNQsm7mYckYfGspbgvnB6hx4XaftjB3BZDo4duUTPKlawdfFeu6qBVfbjuhEVjOWxbcTJxWvQ
 /ytuWD9dE7lEaj/gUw5xpD4K+tNALB8p2XO2SwSzLSWLApqdFHqct36Zc7RRc7Vwm8Ky9Eq/Ba7
 MNj5aUsPlQhOy4ppR+9Exs8nKWJH8KdmSTZA==
X-Gm-Gg: Acq92OG1+Vj+As5sXgP1Y76jqCG+QhgOBkmj7ZVxNy4feP18hQ2Ww77Y40Q9EnKWXC7
 2Y/y43dR0bvW0C1HgVX0uRZzc1AKaacphcGBcPIYf/aH9ouK+/PIWuQms+5mt750INWyAuYLALL
 Uufpv3nU059goH030+a9KRII0J60Ud5ydKPWjrqKt749bRLWpo1zxdmkpcVfYsl7/iRQqjA0Nu5
 idnQxBTEc8VA9I2oJL8GkZfYYBRuL189ZfuQqFQ+V40y8xBPuAC9y/vzh5rnjgJPPW6D3oQvwI8
 Dje6QvGu5ApdPLaqohC4EbQFagkUsOtZ9tfmzi+TAXekst4NMFPPvSP2bAbKXlqiSwTNOo/C0WD
 i5m/e9f/C9IEnWeGTQOTu4nptifMtfcyI3Zsh4E7RZ1M=
X-Received: by 2002:a05:6000:1889:b0:460:70ff:fe14 with SMTP id
 ffacd0b85a97d-4607ebf6dd0mr9601141f8f.42.1781464065476; 
 Sun, 14 Jun 2026 12:07:45 -0700 (PDT)
X-Received: by 2002:a05:6000:1889:b0:460:70ff:fe14 with SMTP id
 ffacd0b85a97d-4607ebf6dd0mr9601101f8f.42.1781464064965; 
 Sun, 14 Jun 2026 12:07:44 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-85-71.inter.net.il. [80.230.85.71])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4606f26393asm28062983f8f.5.2026.06.14.12.07.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 14 Jun 2026 12:07:44 -0700 (PDT)
Date: Sun, 14 Jun 2026 15:07:43 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Raphael Norwitz <raphael.s.norwitz@gmail.com>,
 Daniil Tatianin <d-tatianin@yandex-team.ru>, Lei Yang <leiyang@redhat.com>
Subject: [PULL 045/106] hw/virtio/virtio-bus: refactor
 virtio_bus_set_host_notifier()
Message-ID: <658660c838935836cb904d6c29f15767d952b256.1781463125.git.mst@redhat.com>
References: <cover.1781463125.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1781463125.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>

The logic kept as is. Refactor to simplify further changes.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Raphael Norwitz <raphael.s.norwitz@gmail.com>
Reviewed-by: Daniil Tatianin <d-tatianin@yandex-team.ru>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Tested-by: Lei Yang <leiyang@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-Id: <20260420200339.708640-20-vsementsov@yandex-team.ru>
---
 hw/virtio/virtio-bus.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/hw/virtio/virtio-bus.c b/hw/virtio/virtio-bus.c
index cef944e015..9b545acda3 100644
--- a/hw/virtio/virtio-bus.c
+++ b/hw/virtio/virtio-bus.c
@@ -298,20 +298,18 @@ int virtio_bus_set_host_notifier(VirtioBusState *bus, int n, bool assign)
                          __func__, strerror(-r), r);
             return r;
         }
-        r = k->ioeventfd_assign(proxy, notifier, n, true);
-        if (r < 0) {
-            error_report("%s: unable to assign ioeventfd: %d", __func__, r);
-            virtio_bus_cleanup_host_notifier(bus, n);
-        }
-    } else {
-        k->ioeventfd_assign(proxy, notifier, n, false);
     }
 
-    if (r == 0) {
-        virtio_queue_set_host_notifier_enabled(vq, assign);
+    r = k->ioeventfd_assign(proxy, notifier, n, assign);
+    if (r < 0 && assign) {
+        error_report("%s: unable to assign ioeventfd: %d", __func__, r);
+        virtio_bus_cleanup_host_notifier(bus, n);
+        return r;
     }
 
-    return r;
+    virtio_queue_set_host_notifier_enabled(vq, assign);
+
+    return 0;
 }
 
 void virtio_bus_cleanup_host_notifier(VirtioBusState *bus, int n)
-- 
MST


