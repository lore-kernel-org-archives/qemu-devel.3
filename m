Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7A07C43458
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 10:41:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wh3FG-0004aV-2v; Tue, 07 Jul 2026 06:41:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wh3FE-0004YH-Cr
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 06:41:40 -0400
Received: from mail-wm2-x01.google.com ([2a00:1450:4864:31::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wh3FC-0003s5-JT
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 06:41:40 -0400
Received: by mail-wm2-x01.google.com with SMTP id
 5b1f17b1804b1-493b2bfaa94so3344485e9.0
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2026 03:41:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783420897; x=1784025697; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=nx+OQLXZkvO9m7d0dGtM3XJnydLExcs4r6HAAo2pjyk=;
 b=Cpp92ZIyMon2FDbcodMuM4hXrWT/TnDpgkK72vCne1O8ah+SwSAc0aYPM9wQQx4Btn
 6JkXD1tIs2aojPpSGdTed23qg3D755RcO+C5SzTiwaZMdf3Rdf8UhWVd3aczVxFTBHUB
 UtMAcgxNIcuKIQsQn7Wlu45b3v6x+pmGLRJSPHE/6fX2Utp1JN3E3boiBjcivFBWSa4O
 +9UVehnB4eql7BGvTjg7NCodcYzyFXhLkd3zzbzgUj2kiypaiAUy7fpz75AcNuBv4Bgh
 Qg+Xir7j0iSiSjyeogWWY2OiYlJgG3l2zenJIbmPJCU/987cu6oMWIebZKXg+gNPgAuT
 g5OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783420897; x=1784025697;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nx+OQLXZkvO9m7d0dGtM3XJnydLExcs4r6HAAo2pjyk=;
 b=DZuWjxTRuP/MxjlGpz5I4yKdaps6lC3zloTIl3NAAotk9kK4wTj6bhNgCz/7mSmE6R
 xrYL7hLKF0nVzFdfe+/oqx7l6l2jyeLnL8mPqyyKwnaJRgujNDViBZHnmd7VFnGnDIph
 VFNNKC82JbjpkVouVasSk4GuG9hJqRFMYjc/Iit7gq5f7BffYtE4En7kG0Kdqn/BLN/x
 ljnt+/7Fk9DCSbgsGXAXLB7D0FQaWbUtE7PCokNJ90Lb6RpDcSJKKT2EsW3Gve/l4vR2
 2vCQl//lsxUm5Bd8D0upvuj84+jUEhzUjabETGQIyNLMehSRtqioVxEC0s7WrtDR10Ho
 uhcw==
X-Gm-Message-State: AOJu0YwJ7huFZf2ngFLak3LS+VGR8rQufYD/Ys72WsGdfZ9omqpisYtF
 gzGAY6UuVfXxxeWyTsShDFusM3yxunmj57b0C/aHpnrLjYPK92Il1ff+FCjuyHe4CLl6ao0SDV+
 yJ9auw8RkVGYA
X-Gm-Gg: AfdE7clhnlOKVtWv0vMl2w8n3BHzcyxZbFu0R7kEZdzgSFAs81MtD5V8WqZftNtOkdD
 A7OrfTkkfY13HyKrW0azh/XlI/CyoyJdTq7rRpiTyNp4untqmoy5fNWK9jy8EmYBj1auRVtAoxe
 qbAXQgmgvyvJ8NClCedWEq0iaFVCsdtL7OdF3Ian8u4yUulxa+VGGwnnYnQKxpspder3h7NuRfJ
 k5QiTHRduP3SmvxhLVHXOQld8swrNQKveCZ6C/Xr3flR7oZRNWFcmCtwhZiYprO8jT2kHyKRZ56
 G6oHv1UQ2csbAJ3qMBpWJV2CQYNrruuQ+53dVZSJZQbrtrE9ffU5k8dwTot8ZdZyh9m0Ah5Fg6k
 2y2QzsAdb/NaM9xYF3nv+pa8NY/EgNHw5QmD0h7QeKajtpK/kbrNmIVob3jFGGIUhhaOck/myWs
 +v4lBJO742Za1mQTi+mRp3jbP0bTLAwX6aaPe95EI42BY2wuqrlES82GfNMx6JmMrXeY+IphT8T
 nWlb7hyr+Jo9V7BT54WcA==
X-Received: by 2002:a05:600c:3e0a:b0:493:df44:2342 with SMTP id
 5b1f17b1804b1-493e30e9363mr12174255e9.5.1783420896781; 
 Tue, 07 Jul 2026 03:41:36 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47a9e4d8410sm33272493f8f.15.2026.07.07.03.41.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jul 2026 03:41:35 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH] linux-user: Validate guest-passed dm_ioctl data_size
Date: Tue,  7 Jul 2026 11:41:35 +0100
Message-ID: <20260707104135.1234982-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:31::1;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm2-x01.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

In do_ioctl_dm() we work with a struct dm_ioctl from the guest.  This
has a fixed initial part, and then a variable data part; the guest
tells us how long that part is by setting the data_size field.  The
data_size is supposed to include the length of the fixed parts of the
struct dm_ioctl.  Currently we don't validate anything about the
guest-provided data_size, and we use it to allocate a buffer which we
then copy the fixed part of the dm_ioctl struct into.  This means
that if the guest passes a very small data_size the copy of the fixed
part will overrun the buffer.

Perform the same sanitizing of the minimum and maximum limits of the
data_size that the kernel does in drivers/md/dm-ioctl.c in the
copy_params() function.

Cc: qemu-stable@nongnu.org
Fixes: 56e904ecb2018 ("linux-user: implement device mapper ioctls")
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3736
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 linux-user/syscall.c | 30 ++++++++++++++++++++++++++----
 1 file changed, 26 insertions(+), 4 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index d257fb9ca9..3f060ee8b6 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -5088,6 +5088,9 @@ do_ioctl_usbdevfs_submiturb(const IOCTLEntry *ie, uint8_t *buf_temp,
 }
 #endif /* CONFIG_USBFS */
 
+#define DM_MAX_TARGETS                  1048576
+#define DM_MAX_TARGET_PARAMS            1024
+
 static abi_long do_ioctl_dm(const IOCTLEntry *ie, uint8_t *buf_temp, int fd,
                             int cmd, abi_long arg)
 {
@@ -5100,6 +5103,7 @@ static abi_long do_ioctl_dm(const IOCTLEntry *ie, uint8_t *buf_temp, int fd,
     abi_long ret;
     void *big_buf = NULL;
     char *host_data;
+    const size_t minimum_data_size = offsetof(struct dm_ioctl, data);
 
     arg_type++;
     target_size = thunk_type_size(arg_type, 0);
@@ -5111,9 +5115,26 @@ static abi_long do_ioctl_dm(const IOCTLEntry *ie, uint8_t *buf_temp, int fd,
     thunk_convert(buf_temp, argptr, arg_type, THUNK_HOST);
     unlock_user(argptr, arg, 0);
 
-    /* buf_temp is too small, so fetch things into a bigger buffer */
-    big_buf = g_malloc0(((struct dm_ioctl*)buf_temp)->data_size * 2);
-    memcpy(big_buf, buf_temp, target_size);
+    /* At this point this includes the size of the fixed dm_ioctl parts */
+    guest_data_size = ((struct dm_ioctl *)buf_temp)->data_size;
+
+    if (guest_data_size < minimum_data_size ||
+        guest_data_size > DM_MAX_TARGETS * DM_MAX_TARGET_PARAMS) {
+        ret = -TARGET_EINVAL;
+        goto out;
+    }
+
+    /*
+     * buf_temp is too small, so fetch things into a bigger buffer. Here
+     * we copy all of the fixed parts of struct dm_ioctl but not the
+     * data at the end (which in the struct is "char data[7]" but in
+     * reality is command-specific and might be nothing or might be
+     * much larger, as defined by data_size). We know struct dm_ioctl's
+     * size is not target specific so we don't need to distinguish between
+     * its minimum size for the host vs the target.
+     */
+    big_buf = g_malloc0(guest_data_size * 2);
+    memcpy(big_buf, buf_temp, minimum_data_size);
     buf_temp = big_buf;
     host_dm = big_buf;
 
@@ -5122,7 +5143,8 @@ static abi_long do_ioctl_dm(const IOCTLEntry *ie, uint8_t *buf_temp, int fd,
         ret = -TARGET_EINVAL;
         goto out;
     }
-    guest_data_size = host_dm->data_size - host_dm->data_start;
+    /* Adjust down to only the size of the payload */
+    guest_data_size -= host_dm->data_start;
     host_data = (char*)host_dm + host_dm->data_start;
 
     argptr = lock_user(VERIFY_READ, guest_data, guest_data_size, 1);
-- 
2.43.0


