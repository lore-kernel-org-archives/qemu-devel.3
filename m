Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9124ACAC5BB
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Oct 2025 19:26:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v5UFh-0003q7-VC; Sun, 05 Oct 2025 15:18:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1v5UFK-0002ET-LE
 for qemu-devel@nongnu.org; Sun, 05 Oct 2025 15:18:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1v5UFA-0006aG-U9
 for qemu-devel@nongnu.org; Sun, 05 Oct 2025 15:18:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759691876;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=V41Pc7wPc/h125DbvUzzUxYHsFmka0IFpApuuOm1N4U=;
 b=V84VjRMCWozokdnWuuw6jdhR10KhsZUyVw/uVyxxNQ1vLxPGiB8dxNW7rKu8rHmjPaRWd1
 /mjQmtrYQUcG6+d53eDOIAVvuC2O3QxaG7U9C/5+at7XP8x5H44/dVddQkyh3X0tzUnanK
 3Ic5qzOvhMj4tIQCnDNC7Vpx1SUYFgg=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-496-ugGbudLiMTavVOHn-MuuXw-1; Sun, 05 Oct 2025 15:17:55 -0400
X-MC-Unique: ugGbudLiMTavVOHn-MuuXw-1
X-Mimecast-MFC-AGG-ID: ugGbudLiMTavVOHn-MuuXw_1759691874
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3e997eb7232so1744325f8f.3
 for <qemu-devel@nongnu.org>; Sun, 05 Oct 2025 12:17:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759691874; x=1760296674;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=V41Pc7wPc/h125DbvUzzUxYHsFmka0IFpApuuOm1N4U=;
 b=dpvW9XMRHML7Ykxbd2RkSUlDMAfw1KCWWysMy0Aaqg+5jBctm2ypqo0LnH/hvroDu1
 QODBq5lbbcvKjcgz/WlYk5J7kHePkhUpM8czfl4wSS0LTOfyevFvbrpjMbdpU/3lXXwl
 BnerLJw7Hxdy0CjBM3jwswpPRmCkpObStuyM06TBRzhRNhrmbnjcOtxJ0bVFagZiGWx/
 f/0zOTetZY2vSP35P73kwDWuFObIb1fz8Z4J9szZmvSHFRR0S2NnBI7yCta3YTnngTz+
 Q+iqqost0gfP2UvnTQKlUsy9Z9crLMZyjm7+XVUShk3dzaW1LrzL+Uv4QP4/xplxuV1Z
 DD8g==
X-Gm-Message-State: AOJu0YwzXOvHvwzoVle91XNfE2OXZBV2EFjSGEFLG6Y5/OO74WmQpiO2
 /0yRNBlLrrdEYLCFBsmifOhsFy2KDHenHey3mvxKzixmAmyHqAt8nnDPuIqmIyriHB7DEWPG1kF
 SMc99I1jE05zqhIQ8nlub9jgnETO5WHig6sv2KOcZaQ/RQRoQrIjhdfN2/GDPTqoOnxlxnwdBl8
 /+J7BZopdOE5bkIJEz3BqWh+dIYZGaBC4Tng==
X-Gm-Gg: ASbGncs/L6Z/mZIbk+WAbWx4/YLyDIBRqEOAzIiDKfKHd9vjyqD533KYyGuJmhezNDP
 tVMdCbs6a9iYiYZEH0VHrTHXA2MW7i4VJyxbkUTTY3GV+H6xdwp/a8ij+UjWk3z6w1EPvOAyD4J
 dgV0VPeYlC3BTiBMiaRQOARkDIZlR6rYH/x/hRFWLjorWc7fMbwBooic8FYZp+nYWOMz6PqjwI0
 TtHgpH/HQc39n1bJOA5w1vDble4A1o3OKvtG4cv701dSqliLkC98w12KV7A3SOjqUGGCZ9cS5Sm
 ULlqWpV6UrZQtLKPEb7BYVhcbr+xmrnORDsL3AY=
X-Received: by 2002:a05:600c:1d1c:b0:45b:8a0e:cda9 with SMTP id
 5b1f17b1804b1-46e71111c47mr59682655e9.2.1759691874025; 
 Sun, 05 Oct 2025 12:17:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFGzex29tHDkjGvIUtPCv211VFdOMqX8odJvw1GLdsqOdrJsVU0+KBCad2lbwWPJN2LkXXkPA==
X-Received: by 2002:a05:600c:1d1c:b0:45b:8a0e:cda9 with SMTP id
 5b1f17b1804b1-46e71111c47mr59682515e9.2.1759691873501; 
 Sun, 05 Oct 2025 12:17:53 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1518:6900:b69a:73e1:9698:9cd3])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e72374b8dsm137218675e9.19.2025.10.05.12.17.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Oct 2025 12:17:53 -0700 (PDT)
Date: Sun, 5 Oct 2025 15:17:51 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Alessandro Ratti <alessandro@0x65c.net>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 David Hildenbrand <david@redhat.com>
Subject: [PULL 49/75] virtio: Add function name to error messages
Message-ID: <a9324cdecb0d9f7ae7db7f4120251b50cc768d7c.1759691708.git.mst@redhat.com>
References: <cover.1759691708.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1759691708.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.43,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Alessandro Ratti <alessandro@0x65c.net>

Replace virtio_error() with a macro that automatically prepends the
calling function name to error messages. This provides better context
for debugging virtio issues by showing exactly which function
encountered the error.

Before: "Invalid queue size: 1024"
After:  "virtio_queue_set_num: Invalid queue size: 1024"

The implementation uses a macro to insert __func__ at compile time,
avoiding any runtime overhead while providing more specific error
context than a generic "virtio:" prefix.

Also remove manual __func__ usage in virtio-balloon to avoid duplicate
function names in error messages.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/230
Buglink: https://bugs.launchpad.net/qemu/+bug/1919021
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Alessandro Ratti <alessandro@0x65c.net>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20250915162643.44716-2-alessandro@0x65c.net>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/virtio/virtio.h | 4 +++-
 hw/virtio/virtio-balloon.c | 2 +-
 hw/virtio/virtio.c         | 3 ++-
 3 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
index d97529c3f1..695bb56186 100644
--- a/include/hw/virtio/virtio.h
+++ b/include/hw/virtio/virtio.h
@@ -253,7 +253,9 @@ void virtio_init(VirtIODevice *vdev, uint16_t device_id, size_t config_size);
 
 void virtio_cleanup(VirtIODevice *vdev);
 
-void virtio_error(VirtIODevice *vdev, const char *fmt, ...) G_GNUC_PRINTF(2, 3);
+#define virtio_error(vdev, fmt, ...) \
+    virtio_error_impl(vdev, "%s: " fmt, __func__, ##__VA_ARGS__)
+void virtio_error_impl(VirtIODevice *, const char *fmt, ...) G_GNUC_PRINTF(2, 3);
 
 /* Set the child bus name. */
 void virtio_device_set_child_bus_name(VirtIODevice *vdev, char *bus_name);
diff --git a/hw/virtio/virtio-balloon.c b/hw/virtio/virtio-balloon.c
index db787d00b3..e443f71c01 100644
--- a/hw/virtio/virtio-balloon.c
+++ b/hw/virtio/virtio-balloon.c
@@ -697,7 +697,7 @@ virtio_balloon_free_page_hint_notify(NotifierWithReturn *n, void *data,
     case PRECOPY_NOTIFY_COMPLETE:
         break;
     default:
-        virtio_error(vdev, "%s: %d reason unknown", __func__, pnd->reason);
+        virtio_error(vdev, "%d reason unknown", pnd->reason);
     }
 
     return 0;
diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index de89e8104a..0f33ca5d90 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -3968,7 +3968,8 @@ void virtio_device_set_child_bus_name(VirtIODevice *vdev, char *bus_name)
     vdev->bus_name = g_strdup(bus_name);
 }
 
-void G_GNUC_PRINTF(2, 3) virtio_error(VirtIODevice *vdev, const char *fmt, ...)
+void G_GNUC_PRINTF(2, 3)
+virtio_error_impl(VirtIODevice *vdev, const char *fmt, ...)
 {
     va_list ap;
 
-- 
MST


