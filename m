Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 962EFE9A047
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Feb 2026 13:33:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vshfe-0004EG-3O; Wed, 18 Feb 2026 08:32:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1vshfQ-0003xd-Bu
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 08:32:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1vshfA-0005R3-Ir
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 08:32:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771421538;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/GpJAltRXiG3BftU38An+U5DT1j7yTwOzEMSCvYcGWQ=;
 b=JBSxTCCrVo/q/ifgCc9y+ootDlamQkUVvsLVCCoi7nZe+nPJmyJgz38hOKEThLQyMYT12r
 pzIK582Bblq4a6gyQZGDxWLHwEGpj1wiveWuE7+jy7t4ou89qmjVAPL02/UGNzjljqCbGA
 Kyzb/uKaOsJ4S1GLd1UyslGVrvTOQGM=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-256-d1ClUX85OmGkIDRkebFn7A-1; Wed, 18 Feb 2026 08:27:15 -0500
X-MC-Unique: d1ClUX85OmGkIDRkebFn7A-1
X-Mimecast-MFC-AGG-ID: d1ClUX85OmGkIDRkebFn7A_1771421234
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4837a718f41so18968675e9.2
 for <qemu-devel@nongnu.org>; Wed, 18 Feb 2026 05:27:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1771421234; x=1772026034; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/GpJAltRXiG3BftU38An+U5DT1j7yTwOzEMSCvYcGWQ=;
 b=Wuz/EEoZpsw6f46BaBB0BUZf+40AiNMuzJtdMoL07+bCAWWhQrUtznU39/nUvp13ZY
 KFkg65FEAQa0DzK9+delkGTZhKmYPVQDI+eF4G/PU5o5ciR8M121SmSXar4hqgYEgN5j
 4d9uVUdLvVAxYyGaXpME9mEXIEY6hcdMONh8A+GWLhiL5GqxTEOOaNnn2WII95R9wRFI
 L76bSSpbKykqgItj7TF/Cb4+n7n9Sn95z0JcUzadeIpdAsy9U3be7bBouEXB+7T86N8r
 Jdw22nHN7k0dznmth/zUAn3v5flDrKFp6bu9uHq6pS9pQEbV0x2ImyKwrvnqiWTRzB7t
 MbRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771421234; x=1772026034;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=/GpJAltRXiG3BftU38An+U5DT1j7yTwOzEMSCvYcGWQ=;
 b=iRSDHP030Z/hfnUTJGweod4nLDUYKMKCKD0Ym3cneBYYz6y5+WC5uwZsvMdcP5eowB
 skfdlOeUgg1EspsgsyWQVgKYROC1f0JYOyyHskk0pdQwEyPj7wGGPNBYyiv+Epzl26nj
 K4D5cOWrUZz0x6T7d6uc/63Lm6oJOjvA649m3UtBa0PRc+9zDO6Ed2qEF8y/x0dyqz95
 ZON9TrBcZ70+8+quZUUf5VjGK4Ls6lBhRxw7zbIrRnK/tzRb9PI5I77yG9bdyBxSA++6
 spENe9KU/I6YigkfQaVg+Nd6ifFXJiAizeISLxaSUAcGXc+oBzN9oTjNQp66IC0dn1sD
 pcCw==
X-Gm-Message-State: AOJu0Yw4F/1HVNvvtfFUmthVakkWzgMeMazsiMkkiOUusMur36esiLCb
 N30v6Lo7HBiWKry5/MzvCgPYisVKTREusCAa1MWhRzHMB6J9/hAgzrprMaqAGoDYpAnSOpBO/fx
 sg/U8831zpLZBiDdeFCBpuFtQQwmfejhBQRENffcnuXFgAB0pMka2uCiQeqpD9XV/
X-Gm-Gg: AZuq6aJL7ZzoEA+Xx0dI667HRclxYtA7zt4x/L4V1PREtxELYPn/oGv2HUe+1vHMUk9
 cNoE657EUodEjSiqOQ+K6hG3p8035FlZA0GY72Ht7QB2e+2dZkE7aq7fvijpJHK3NXaqipRiLVc
 0fFjiPdrBp1617UwnQHxlcWZ+CcoEKGm8ip36DzJZPhtEoiiDOKOqeiMATZr89qxud0yYmTuMAZ
 EJRWV+V4REfmbwmMzG98lI7b0LKFrSO0peGLvUSEimPPm2ohiZpNuhqxz1mNEnb+U0mpwUVZ1oX
 O6yzfS2CttDt2caYTwGFFUwC9/GHrwPXUQXp+az1WHRV8pe7gc3pfRnqSLkplXuutigS16BUKYx
 BNkNsOPo6RCUJ28UwW416mrSIMShAlS0apRCVrWhzGC8Grg+2u0EDgnreT3zmq7MquJ+yuebGxo
 z6WFEw
X-Received: by 2002:a05:600c:1c08:b0:47a:8cce:2940 with SMTP id
 5b1f17b1804b1-48379b991c6mr243244885e9.14.1771421233838; 
 Wed, 18 Feb 2026 05:27:13 -0800 (PST)
X-Received: by 2002:a05:600c:1c08:b0:47a:8cce:2940 with SMTP id
 5b1f17b1804b1-48379b991c6mr243244465e9.14.1771421233400; 
 Wed, 18 Feb 2026 05:27:13 -0800 (PST)
Received: from localhost
 (p200300cfd737d029edef7b8da7441ac2.dip0.t-ipconnect.de.
 [2003:cf:d737:d029:edef:7b8d:a744:1ac2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4834d5ebd1bsm649071375e9.6.2026.02.18.05.27.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Feb 2026 05:27:12 -0800 (PST)
From: Hanna Czenczek <hreitz@redhat.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Hanna Czenczek <hreitz@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Brian Song <hibriansong@gmail.com>
Subject: [PATCH v4 12/24] fuse: fuse_{read,write}: Rename length to blk_len
Date: Wed, 18 Feb 2026 14:26:21 +0100
Message-ID: <20260218132633.29748-13-hreitz@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260218132633.29748-1-hreitz@redhat.com>
References: <20260218132633.29748-1-hreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.043,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

The term "length" is ambiguous, use "blk_len" instead to be clear.

Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
---
 block/export/fuse.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/block/export/fuse.c b/block/export/fuse.c
index f6a5f4fa0a..d45c6b814f 100644
--- a/block/export/fuse.c
+++ b/block/export/fuse.c
@@ -637,7 +637,7 @@ static void fuse_read(fuse_req_t req, fuse_ino_t inode,
                       size_t size, off_t offset, struct fuse_file_info *fi)
 {
     FuseExport *exp = fuse_req_userdata(req);
-    int64_t length;
+    int64_t blk_len;
     void *buf;
     int ret;
 
@@ -651,14 +651,14 @@ static void fuse_read(fuse_req_t req, fuse_ino_t inode,
      * Clients will expect short reads at EOF, so we have to limit
      * offset+size to the image length.
      */
-    length = blk_getlength(exp->common.blk);
-    if (length < 0) {
-        fuse_reply_err(req, -length);
+    blk_len = blk_getlength(exp->common.blk);
+    if (blk_len < 0) {
+        fuse_reply_err(req, -blk_len);
         return;
     }
 
-    if (offset + size > length) {
-        size = length - offset;
+    if (offset + size > blk_len) {
+        size = blk_len - offset;
     }
 
     buf = qemu_try_blockalign(blk_bs(exp->common.blk), size);
@@ -685,7 +685,7 @@ static void fuse_write(fuse_req_t req, fuse_ino_t inode, const char *buf,
 {
     FuseExport *exp = fuse_req_userdata(req);
     QEMU_AUTO_VFREE void *copied = NULL;
-    int64_t length;
+    int64_t blk_len;
     int ret;
 
     /* Limited by max_write, should not happen */
@@ -711,13 +711,13 @@ static void fuse_write(fuse_req_t req, fuse_ino_t inode, const char *buf,
      * Clients will expect short writes at EOF, so we have to limit
      * offset+size to the image length.
      */
-    length = blk_getlength(exp->common.blk);
-    if (length < 0) {
-        fuse_reply_err(req, -length);
+    blk_len = blk_getlength(exp->common.blk);
+    if (blk_len < 0) {
+        fuse_reply_err(req, -blk_len);
         return;
     }
 
-    if (offset + size > length) {
+    if (offset + size > blk_len) {
         if (exp->growable) {
             ret = fuse_do_truncate(exp, offset + size, true, PREALLOC_MODE_OFF);
             if (ret < 0) {
@@ -725,7 +725,7 @@ static void fuse_write(fuse_req_t req, fuse_ino_t inode, const char *buf,
                 return;
             }
         } else {
-            size = length - offset;
+            size = blk_len - offset;
         }
     }
 
-- 
2.53.0


