Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58D50CA9ED2
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2026 13:27:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGcXL-00059G-4H; Tue, 13 Oct 2026 09:27:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xGcVl-0003Pz-JS
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 09:25:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xGcVi-00052C-76
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 09:25:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791897941;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0O1slwMWOASqo5rVWqPA2E+/Z4OGxolZbzR3Ig2nsb4=;
 b=KFax1YzLUHuCKoY1k587vNLac/+DUvqRJ7FjaoVRoCxFWyqbjf8q7wOcldDmx5vMFfjBG2
 iKCksNEafCb7pH99iAIcMCYwNcV61rssWTCFnpQ3JMUhyhj+fQKzZYFf0cC1gk/LBjsrlg
 GNv/a/aS2nCJOF61JD9bxJA0KfF1ia4=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-643--MNzyQbvPuuSihqRr5Ghog-1; Tue,
 13 Oct 2026 13:25:40 +0000
X-MC-Unique: -MNzyQbvPuuSihqRr5Ghog-1
X-Mimecast-MFC-AGG-ID: -MNzyQbvPuuSihqRr5Ghog_1791897939
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5B9251801339; Tue, 13 Oct 2026 13:25:39 +0000 (UTC)
Received: from localhost (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 726941956041; Tue, 13 Oct 2026 13:25:38 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 13 Oct 2026 17:23:35 +0400
Subject: [GIT PULL 38/40] chardev/char-ringbuf: use actual read length in
 qmp_ringbuf_read
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261013-ui-v1-38-92da3082ad96@redhat.com>
References: <20261013-ui-v1-0-92da3082ad96@redhat.com>
In-Reply-To: <20261013-ui-v1-0-92da3082ad96@redhat.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1901;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=eaXFeCd1KwF0Ok8e2V0HZ9v/zjVbncbE1cHELSo/oQY=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqzjDEE6Rvf8f3snk9UWWYsVxN87Xa6l5Ks4Djr
 w0oKQzHCTOJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCas4wxAAKCRDa6OEJdZac
 5SztD/9yLRBPesp1re/EeO+W2ilIa3FgHhKOkUZAbyOOgKz93G6Ib9i94PiqW/2TtDTaihsIMWz
 OFstbnvd11F6GmYCtvSiXEmyU6Wba0EI4gYwGXtM/HxGxsEqYSGELE93DK+oizYUFKGjRn5g1wz
 j/5E5qkfo6iSoSCtXgjOPrlegnJu6l9RZF8nOhjTUXF2MlNoYoqj4ZKVqKT6DXlDAcZL+UkVnF2
 1vXp49nqE9NcdJkfIPj2m1h7tUjtkZ4UCk3iKW5u3bTGTFopT064zvyes7B00kig1fo52LAZsQQ
 JR/IILAwJQtBpcbZTxtUvrNFJyU1/sl1G5wKWpaJSW8jfM3ix51C71KhNVRZlfBlnltBOa0gOV0
 6M0CJZeRBAn7G4ufRnOGZfHtWLVJl1RjjOzHCU9b0u6OnqJX5bEkiosheIHG1CZbPNjVNkSM3jm
 VQIcEAVjTjaOR6DGdOAlvJ2Z3wi0cm8Mph+sGg0/6MpbRSWlg23EaQ3b/CK07CgzXE/m06QigNM
 7gJWuGr2clcm0eG63rnPWtLZx/gBiHGwZF+nYerHYzDcmfFF08hXf8bY/Em/gymaxTFjCuE6xqZ
 +QlES16wzA2vy9a/9p5PYEfIzxz/W82qd/Q6QGRo1Ge0ha/T0RcWREHrNPJT8lAgbt9EcE+e1r4
 pTAm+T7uxuEaAaQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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

Reported-by: Hui Peng <benquike@gmail.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-ID: <20261004-issue-4560-v1-21-ccbef537cbeb@redhat.com>
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
2.56.0.116.g6de20f6092dc


