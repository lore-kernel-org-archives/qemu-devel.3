Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86849CA5FCE
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Oct 2026 10:30:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDJP8-0006Wg-Ig; Sun, 04 Oct 2026 06:25:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xDJOx-0005qN-Tw
 for qemu-devel@nongnu.org; Sun, 04 Oct 2026 06:25:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xDJOq-0002wk-1u
 for qemu-devel@nongnu.org; Sun, 04 Oct 2026 06:24:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791109495;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=y9so1LbOiaCZvsO8b8ZyqoYIU8juJ32h87Ted0NV0Y4=;
 b=P4UEc6mo1X9//7yvYst0iVjlyPmJlzoknKshHEVCjwR53drr1AtAA3AZIMCSnqkWmUxKGy
 rtab+n1PQ9FPMFrY3lVFODpSzcOTn76I9KDASgeHFPP9Igyz83uW1gOpdofGB0kRF5Xv63
 efkHPUFAIODRAbBL21eukpLbhQmj0p0=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-253-GF2A358kMEOqyqd802YedA-1; Sun,
 04 Oct 2026 06:24:53 -0400
X-MC-Unique: GF2A358kMEOqyqd802YedA-1
X-Mimecast-MFC-AGG-ID: GF2A358kMEOqyqd802YedA_1791109492
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 75988180066A; Sun,  4 Oct 2026 10:24:52 +0000 (UTC)
Received: from localhost (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 6323E19560AB; Sun,  4 Oct 2026 10:24:51 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Sun, 04 Oct 2026 14:23:35 +0400
Subject: [PATCH 21/63] chardev/char-ringbuf: use actual read length in
 qmp_ringbuf_read
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261004-issue-4560-v1-21-ccbef537cbeb@redhat.com>
References: <20261004-issue-4560-v1-0-ccbef537cbeb@redhat.com>
In-Reply-To: <20261004-issue-4560-v1-0-ccbef537cbeb@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Pavee Hui <phui@google.com>, Paolo Bonzini <pbonzini@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1837;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=844nPa9VijzgYzSdo+Yjc7DzFeIRYOx+I3BWYLa26qo=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqwikigMvCIBRV8lYiu0W2kLoww+y86PNBkUItK
 KibvgVzhIqJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCasIpIgAKCRDa6OEJdZac
 5Qs5D/9B3Kth6/ylPDvfTei/bgTC7aTNhDfuIckMEhTb4ToC3xBOCZ9WuIc/XjKDwXFU/zjBd5H
 XPXgxL/LewYhBVOzpYN0djFKvMGtAqn/l+BcQL7uPB5V8RMcuh/jgZsoFxlAZcS3SrnFXHLiIYp
 l2SLYns08ZSyb+FMVEr6UKGKAL+Czp+B+/azOMfKqEij9rHyV9C93UySf+nslWpM6o8WhL2VFvK
 v76lRRArsndIqSAabsccER9708WwzEeUzjIbFdpyvKwT7iLGlMfgq2xrt6vWzr0yrwI4VjHCIn8
 L3rkb8XnqY6ZmOjGOm/kY+Lt7++QChK0uvpprwC/voX7A6RIxCCi97hLUrBALjSns1LrKWwb9yJ
 N/c40/x9O5S2ngcUC8oCGe7DfjAYpvgOKhVeYxb5InGawkwOab+uZ7qZZqUCKwpt3+nYkTz27mt
 8OJMlJ/cFVbEh16y06L6JjhNeXGr1kYcefTe/CLe017J4lhbZJhgWiyRMysv/t1ZcF6stwkXIIO
 hSohDFKetuKr5a8rYB5FjV7LsyRGo4jqDp4rvS2QQd91W9/LfvV4Bh9RlQdJJF5XpYPUiEyHF9T
 WMVPteZpfz+Lj2SFGkObz0FlODwJoJp9oRG7572Zg1uxx5V5icDsSSl1KQHU0+5aYYTj/W17nYm
 4JeNUnqBBmWyTng==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.337,
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

qmp_ringbuf_read() used the requested size rather than the actual
number of bytes returned by ringbuf_chr_read() for base64 encoding
and null-termination. Since ringbuf_count() is called without the
lock, a concurrent writer can advance the consumer index, leaving
fewer bytes available by the time ringbuf_chr_read() runs. This
could encode uninitialized data or misplace the null terminator.

Reported-by: Pavee Hui <phui@google.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 chardev/char-ringbuf.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/chardev/char-ringbuf.c b/chardev/char-ringbuf.c
index a80519f8d65d..4d83663e9abc 100644
--- a/chardev/char-ringbuf.c
+++ b/chardev/char-ringbuf.c
@@ -167,6 +167,7 @@ char *qmp_ringbuf_read(const char *device, int64_t size,
     Chardev *chr;
     uint8_t *read_data;
     size_t count;
+    int actual;
     char *data;
 
     chr = qemu_chr_find(device);
@@ -189,10 +190,10 @@ char *qmp_ringbuf_read(const char *device, int64_t size,
     size = size > count ? count : size;
     read_data = g_malloc(size + 1);
 
-    ringbuf_chr_read(chr, read_data, size);
+    actual = ringbuf_chr_read(chr, read_data, size);
 
     if (has_format && (format == DATA_FORMAT_BASE64)) {
-        data = g_base64_encode(read_data, size);
+        data = g_base64_encode(read_data, actual);
         g_free(read_data);
     } else {
         /*
@@ -202,7 +203,7 @@ char *qmp_ringbuf_read(const char *device, int64_t size,
          * when) ring buffer lost characters since last read, initial
          * continuation characters should be dropped.
          */
-        read_data[size] = 0;
+        read_data[actual] = 0;
         data = (char *)read_data;
     }
 

-- 
2.56.0.rc0.29.g47ce80527c56


