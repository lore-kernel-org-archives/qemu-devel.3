Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09B82C531D0
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2026 19:24:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woQt7-00024T-Ei; Mon, 27 Jul 2026 15:21:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1woQsc-0000uP-0k
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 15:20:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1woQsa-0000hE-0M
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 15:20:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785180047;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XYF0DkjUHUea+23rjlBko6Uu+m8zVNRGqc1kXP54qOc=;
 b=C47koQP5zwCvwYsdPA7b3utyTvY4QjG+a29vaU4MjjfjolPPJR4Ycfysq7YogiIMVae3fn
 +5uMVFZsXOj9bbDcDZO4TRk4yPNNISL1fb5tjc92L78R/YcmVpzKQZLzOgiLH25e5yO1o9
 ImfSk+WADCeN92oI7WO/qyS9rnzt+E4=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-133-YJqvQHDYMIWRkw5t6DwmUQ-1; Mon, 27 Jul 2026 15:20:45 -0400
X-MC-Unique: YJqvQHDYMIWRkw5t6DwmUQ-1
X-Mimecast-MFC-AGG-ID: YJqvQHDYMIWRkw5t6DwmUQ_1785180044
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-495569acf8dso20983155e9.1
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2026 12:20:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1785180044; x=1785784844; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=XYF0DkjUHUea+23rjlBko6Uu+m8zVNRGqc1kXP54qOc=;
 b=tUl8R1PZTPs++8J43oxjgJxPOcMFM+w3x9cmJY0Bhh2D7DzfuzsuWN6xBel3ZzIgpb
 Rl3wnykyfLGtFE2t1hCjCfZnq00DSAIMn8g/QNM002ErrYPBekJ/QML51W6hhKpra8tn
 QgPsKNzwxTYMjNeUKcGfas6iyFrppr63LfW4IjF8bwivJfr1Du6N5Uj/VsJ5vMU+qpHP
 UUC337WDddvrz0KCwjiWeoXI0Cq5zhK+s8jcUR9k0CeMlWMiPnCT+WChic4Aj86YRpEz
 /q623YPLuB24/Qg5mCSkQOysPlyR/aeueFjWxP9J0C+V1uMujhlObw6t7Q3xPCfNeaR7
 tpWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785180044; x=1785784844;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=XYF0DkjUHUea+23rjlBko6Uu+m8zVNRGqc1kXP54qOc=;
 b=JL5tRIDH4vy+8dKW0YgPrh9OS6VarmkuSc/6hqP29Go7oHSE9M2pTTB4jsRVhhejEG
 y39paf7xXx2dimdr6y7obdsN0QtyAuV6eIGFiLSP1TDj4MmTV1HuAQeOItqKNB/B01cq
 6hdHCVdc8XVpKwAlCG3ZVIQ7btJUmztAsT9xhja5Z8eyE2gwA3QTqLhW+X+JYgCxIhOK
 Au71tyoDn0sigJMJN0116eRafMHOs3y+QJ0bxEtC+HY9jzPiRGoRdBojKmq+QN/maLv1
 ec+mEZxPk9FqT4TUse17sY1NuEP/w/pj/tjNdxwvE69hYzyfligjKo04CjOCM7jpBDTS
 cilg==
X-Gm-Message-State: AOJu0YxZIf2dtseSeONTvan4YNgLz7hfK1Qd/e4u9pNK3MKzePuAwmPo
 OP6xRC1H9MJXMRgY9N3IaKHCdfJCTJSt0rsi+PEtOgiqd9r/TstAf7uDj4tY3i7qCLaypjCySty
 cY5RJ2utydkl93H1/OeJPM4nzw2vBr1Y9TNn1xPjbTzQq3VbiEKLkygefx15TgC3vjO3fxk/Bjy
 7NAKJ1XBpl/stt9FLBHxhyDY+VFhN/nhr3/w==
X-Gm-Gg: AR+sD12THZ79AWEOW37VJ9fYP3I8V+5KSnZJcIN8VD2dvzx3ertegASpc/Co3XHZFRa
 aSOG56kMTk1Omgx6xqCcmZ2ELOmpREAQ1PuJmGZSYoQKXAshYXcWLlNr/6l+ZpaMabvsh3KzNcZ
 eqwDac9CLyK9TWB/fx6e3PAP14fX/H2wMW2f40LlopZQeSkMEI1XDh/FEaHXMfhfuLFm3YW+WSB
 tl45/xK/ZtGE+GBzOKlQERwqcjfYh9ujrn1wSw+RxUXck0ixGys2RM/y4WVCj5BKmJ42567IGqx
 DAiSainvKXSlxcS0jxwnf6KGOWufiUmP1EMkT97us5rHeaJ0m4RgnkX64EpM5eA39FmaoO5B5v/
 29+yieaLlF1r/GCuya9rI1g==
X-Received: by 2002:a05:600c:3595:b0:495:7379:17b1 with SMTP id
 5b1f17b1804b1-496c4fcc80fmr3941375e9.30.1785180044381; 
 Mon, 27 Jul 2026 12:20:44 -0700 (PDT)
X-Received: by 2002:a05:600c:3595:b0:495:7379:17b1 with SMTP id
 5b1f17b1804b1-496c4fcc80fmr3941115e9.30.1785180043838; 
 Mon, 27 Jul 2026 12:20:43 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-28-14.inter.net.il. [80.230.28.14])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-496c45b1c2asm15362255e9.5.2026.07.27.12.20.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jul 2026 12:20:43 -0700 (PDT)
Date: Mon, 27 Jul 2026 15:20:41 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Anatol Belski <anbelski@linux.microsoft.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PULL v2 30/30] virtio: avoid packed vring virtio_queue_empty()
 infinite loops (CVE-2026-16457)
Message-ID: <6682ea3391277e732a6d74c5758206ba834e1615.1785179875.git.mst@redhat.com>
References: <cover.1785179875.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1785179875.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.58,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Stefan Hajnoczi <stefanha@redhat.com>

Virtqueue handler functions in device emulation code often look
something like this:

  while (!virtio_queue_empty(vq)) {
      ...pop and process virtqueue element...
  }

virtio-blk, virtio-scsi, virtio-crypto, and vhost-shadow-virtqueue use
this pattern.

The device may break (i.e. hit an error that requires device reset)
during the loop. virtio_queue_empty() returns 1 for broken split vrings
but not for broken packed vrings, leading to an infinite loop.

Adjust the packed vring behavior to match split vrings and avoid
infinite loops.

Fixes: CVE-2026-16457
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3968
Reported-by: Anatol Belski <anbelski@linux.microsoft.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20260721134424.196337-1-stefanha@redhat.com>
---
 hw/virtio/virtio.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index 979c4065b7..daa5607338 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -763,6 +763,10 @@ static int virtio_queue_packed_empty_rcu(VirtQueue *vq)
     struct VRingPackedDesc desc;
     VRingMemoryRegionCaches *cache;
 
+    if (virtio_device_disabled(vq->vdev)) {
+        return 1;
+    }
+
     if (unlikely(!vq->vring.desc)) {
         return 1;
     }
-- 
MST


