Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EA43C6369F
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Feb 2026 14:31:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuASJ-00088I-4m; Sun, 22 Feb 2026 09:29:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vuARk-0007yh-C3
 for qemu-devel@nongnu.org; Sun, 22 Feb 2026 09:28:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vuARi-0006fR-Qc
 for qemu-devel@nongnu.org; Sun, 22 Feb 2026 09:28:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771770509;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bmD4zIj27NuwPp8hAQ0/t6jv8rHwYFNnHQEC52ejfsU=;
 b=iij5QhH577HUQpabKcf50WFFdzmv+VxBMXVLl9is7OPywrnW2eeEoNnuqYxQ+ato0KHVVC
 zikg0+uwzwcfU+wFqRl/UZ02Ys2bvewE5RbYRAWmN9iCUueA3ba9jXH16Sk+kSwXwm1WLk
 gQGTHeXu3c26ZWTVMHaWWiKjQcsPazc=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-464-2lRfI8KkMMS2Tv9PeeJAxA-1; Sun, 22 Feb 2026 09:28:28 -0500
X-MC-Unique: 2lRfI8KkMMS2Tv9PeeJAxA-1
X-Mimecast-MFC-AGG-ID: 2lRfI8KkMMS2Tv9PeeJAxA_1771770507
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4837bfcfe0dso38799505e9.1
 for <qemu-devel@nongnu.org>; Sun, 22 Feb 2026 06:28:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1771770507; x=1772375307; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=bmD4zIj27NuwPp8hAQ0/t6jv8rHwYFNnHQEC52ejfsU=;
 b=VY0AcvHacECcotHY8Z2q2IpLQfdXAV5dDmCQURDjSrFgciCTzP3HXX32b2Ke+2hIDI
 upOYN2Q4aIj/9dysfNgfhCBeUIGuzDPvC7mRfDrkMonGeZGOPYnLWKWbUbzfc14gUTJn
 aWGWKB6XHAjbEq8+1xltF5ybRDR1buVN6sLDGDuY/lj4xMorYcY9zwFE4ZU1BOtv/dHz
 6X6+rkckXIz38iSkStpZInYMKrDnqrC3GB9w+jyywlDMrNrtmVDxihDCTO/2b0HsLMQJ
 AmmOZQobMiCmJaJcD4gFJvRYLSSJtXW1HEUsInr6cXY+bbc2vF+83ko0S4BMx1svZWia
 wYEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771770507; x=1772375307;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bmD4zIj27NuwPp8hAQ0/t6jv8rHwYFNnHQEC52ejfsU=;
 b=NGR64HJxL4dQkWde6B8ztpHB607299GwsOfbizs9lEPP9EUlA60Plm4n7fkFPuH9/u
 F5TUPbBRw8tt2xPiGT7r5jk3PXSLRX6IId6/suEjU+DNplq7HDqsVpdkvakFOQ89UfjF
 Wf2Z7BqXjw8ImWmgGeRxLh4bWMXVHUvPJxbQJvkuarHacBKSK3nS38F3iY/+5ujwHNgM
 BGVjT/MzdLAl26CsSlGUwNCpvCXMxMqFRGUKyXFrF+ePPzZ96afadYb6Ag1z6f2BHc+C
 cvNch5lLGaLTP5K6jCdvxnMdMgwQuGCTI8Gn5SZpfv3uLm9QE/lBqxthml6M8zpIXHDK
 6GAw==
X-Gm-Message-State: AOJu0YxAOT02WhRk4/Ojr6XaDy/MXqhgtl0kCCkeGwuTjVvqxbJHO4ug
 aO9cZwpqCOys8HDfdW0GzRAGF7aCCDKzbCZ4c99/aEUGDvLlTGvyA9MMQLhlqeb0f5L5t6tVo6P
 BNmvXPS1PsLtbWhRL1iiqB9laTjIS5i59ovDOmi85derpKq/Ra6rlgm67IeNjX1ebTo5oB0aXz2
 8TMVrhsxDKXEly9nNt6RVA4Tm8tmF/D3p8Vg==
X-Gm-Gg: AZuq6aImFCrpXD5FbZK0Qto8iUzaDHwTBDKS4vf4c8v4KytqV1qS7pBnQ+kOzphhQV3
 jSaRHMWnnF0HrYLtW2zKbnvsuKNab+K/5VrqeeLYylvflcVJXesYsLIyeVc7KzTH7hkhIUyTfKo
 gio9x/dJCljSwED5GKN8gG0S+z62KHwRvUV63iRCjs9wJgjWWnwZO474hbZfMcI3ZzMw/2y/jVE
 Nf9em32EADeJMChJi5YPAqAx1Z+HQv1C7nhiM67WcXAbfIV3/XEG/jSVY81f+QhGVkaIgPSZpFv
 MnFR+WS4cnKwyqCwDH9dvp3aKSjVxV1rDBn3dApe+rrWmanu74e+vvfIVGz/VEIEtSyq98bJpnk
 dZZosdTjCtZ362CPY1BVnQeKikIUVcHYsOU3oL6KxEo+XZA==
X-Received: by 2002:a05:600c:828c:b0:47e:e48b:506d with SMTP id
 5b1f17b1804b1-483a962e003mr109282575e9.16.1771770506671; 
 Sun, 22 Feb 2026 06:28:26 -0800 (PST)
X-Received: by 2002:a05:600c:828c:b0:47e:e48b:506d with SMTP id
 5b1f17b1804b1-483a962e003mr109281965e9.16.1771770506081; 
 Sun, 22 Feb 2026 06:28:26 -0800 (PST)
Received: from redhat.com (IGLD-80-230-79-166.inter.net.il. [80.230.79.166])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483a31c56d8sm305619905e9.8.2026.02.22.06.28.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Feb 2026 06:28:25 -0800 (PST)
Date: Sun, 22 Feb 2026 09:28:24 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Yanfeng Liu <yfliu2008@qq.com>,
 Yanfeng Liu <p-liuyanfeng9@xiaomi.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>
Subject: [PULL 04/33] audio/virtio-snd: fix latency calc
Message-ID: <27b370829294dcc4d1e9052e42bcd2b7cdd5c072.1771770471.git.mst@redhat.com>
References: <cover.1771770471.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1771770471.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.798, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.79,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Yanfeng Liu <yfliu2008@qq.com>

Media players needs meaningful latency_bytes update but it is
zero now most of the time. This adds stream-wise latency_bytes
calculation so that to improve the situation.

Signed-off-by: Yanfeng Liu <p-liuyanfeng9@xiaomi.com>
Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-Id: <tencent_66E8C146EA79CD00E966DEDAEF8CACD97D05@qq.com>
---
 hw/audio/virtio-snd.c         | 12 +++++++++++-
 include/hw/audio/virtio-snd.h |  1 +
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/hw/audio/virtio-snd.c b/hw/audio/virtio-snd.c
index 9101560f38..ed0422b45a 100644
--- a/hw/audio/virtio-snd.c
+++ b/hw/audio/virtio-snd.c
@@ -431,6 +431,7 @@ static uint32_t virtio_snd_pcm_prepare(VirtIOSound *s, uint32_t stream_id)
         stream->id = stream_id;
         stream->pcm = s->pcm;
         stream->s = s;
+        stream->latency_bytes = 0;
         qemu_mutex_init(&stream->queue_mutex);
         QSIMPLEQ_INIT(&stream->queue);
 
@@ -899,6 +900,7 @@ static void virtio_snd_handle_tx_xfer(VirtIODevice *vdev, VirtQueue *vq)
             buffer->vq = vq;
             buffer->size = size;
             buffer->offset = 0;
+            stream->latency_bytes += size;
 
             QSIMPLEQ_INSERT_TAIL(&stream->queue, buffer, entry);
         }
@@ -1112,12 +1114,19 @@ error_cleanup:
     virtio_snd_unrealize(dev);
 }
 
+static inline void update_latency(VirtIOSoundPCMStream *s, size_t used)
+{
+    s->latency_bytes = s->latency_bytes > used ?
+                       s->latency_bytes - used : 0;
+}
+
 static inline void return_tx_buffer(VirtIOSoundPCMStream *stream,
                                     VirtIOSoundPCMBuffer *buffer)
 {
     virtio_snd_pcm_status resp = { 0 };
     resp.status = cpu_to_le32(VIRTIO_SND_S_OK);
-    resp.latency_bytes = cpu_to_le32((uint32_t)buffer->size);
+    update_latency(stream, buffer->size);
+    resp.latency_bytes = cpu_to_le32(stream->latency_bytes);
     iov_from_buf(buffer->elem->in_sg,
                  buffer->elem->in_num,
                  0,
@@ -1178,6 +1187,7 @@ static void virtio_snd_pcm_out_cb(void *data, int available)
                 buffer->size -= size;
                 buffer->offset += size;
                 available -= size;
+                update_latency(stream, size);
                 if (buffer->size < 1) {
                     return_tx_buffer(stream, buffer);
                     break;
diff --git a/include/hw/audio/virtio-snd.h b/include/hw/audio/virtio-snd.h
index c176066584..9560bac8b1 100644
--- a/include/hw/audio/virtio-snd.h
+++ b/include/hw/audio/virtio-snd.h
@@ -150,6 +150,7 @@ struct VirtIOSoundPCMStream {
     } voice;
     QemuMutex queue_mutex;
     bool active;
+    uint32_t latency_bytes;
     QSIMPLEQ_HEAD(, VirtIOSoundPCMBuffer) queue;
 };
 
-- 
MST


