Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4292CC44536
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2026 12:47:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmWLc-0002KM-JV; Wed, 22 Jul 2026 08:46:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wmWLb-0002Ju-6G; Wed, 22 Jul 2026 08:46:51 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wmWLZ-0001ah-9o; Wed, 22 Jul 2026 08:46:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1784724390; bh=J2x9lFy4qpjv+XtsY0SIWJ+HGKzzblQrXkPL0y/onzs=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=O4A1rl/0lidZ7Ep/6B1GTzx38AGg3b6RTQl6rMygSBfJc9ScH9IGR+ukgLDZuefIC
 MuPgx8udh6nBGtokup9mxd3/bRIbsVEv9J/dX3+8zchU5CPqmfktOjceilgG7cgDLZ
 EmDGy7dNN2bUBpE6Zrf9VzSq3DX8sIliBkQtA22ijlR8Upo1J/ltLRoPl9CtCfsPsR
 D6RGBKSCmnDtfi6dSivWFb/8pX0yTyBAHu27EFeKVBWVaFgdH/3rmGsra0NU6gn9si
 awvx0xwvCEc9SQEwwtHJWASoNeV60oP7bbYyXbhwt11J0uoQeZ9tLBb/m/hqQfL03a
 vZBdLdQ7nIhAw==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 36DE11C3AF6;
 Wed, 22 Jul 2026 15:46:30 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 7C5C23F3750;
 Wed, 22 Jul 2026 15:46:47 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 3A27D17ED5; Wed, 22 Jul 2026 15:46:38 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Helge Deller <deller@gmx.de>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.12 v2 077/122] linux-user: Validate guest-passed
 dm_ioctl data_size
Date: Wed, 22 Jul 2026 15:45:26 +0300
Message-ID: <20260722124622.31034-2-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.12-20260722154425@cover.tls.msk.ru>
References: <qemu-stable-10.0.12-20260722154425@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
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

From: Peter Maydell <peter.maydell@linaro.org>

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
Reviewed-by: Helge Deller <deller@gmx.de>
Signed-off-by: Helge Deller <deller@gmx.de>
(cherry picked from commit a47e3c26b1a07292e18658e9d33425f61b4716d1)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index ca12dbf779a..5d7c37017a3 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -5092,6 +5092,9 @@ do_ioctl_usbdevfs_submiturb(const IOCTLEntry *ie, uint8_t *buf_temp,
 }
 #endif /* CONFIG_USBFS */
 
+#define DM_MAX_TARGETS                  1048576
+#define DM_MAX_TARGET_PARAMS            1024
+
 static abi_long do_ioctl_dm(const IOCTLEntry *ie, uint8_t *buf_temp, int fd,
                             int cmd, abi_long arg)
 {
@@ -5104,6 +5107,7 @@ static abi_long do_ioctl_dm(const IOCTLEntry *ie, uint8_t *buf_temp, int fd,
     abi_long ret;
     void *big_buf = NULL;
     char *host_data;
+    const size_t minimum_data_size = offsetof(struct dm_ioctl, data);
 
     arg_type++;
     target_size = thunk_type_size(arg_type, 0);
@@ -5115,9 +5119,26 @@ static abi_long do_ioctl_dm(const IOCTLEntry *ie, uint8_t *buf_temp, int fd,
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
 
@@ -5126,7 +5147,8 @@ static abi_long do_ioctl_dm(const IOCTLEntry *ie, uint8_t *buf_temp, int fd,
         ret = -TARGET_EINVAL;
         goto out;
     }
-    guest_data_size = host_dm->data_size - host_dm->data_start;
+    /* Adjust down to only the size of the payload */
+    guest_data_size -= host_dm->data_start;
     host_data = (char*)host_dm + host_dm->data_start;
 
     argptr = lock_user(VERIFY_READ, guest_data, guest_data_size, 1);
-- 
2.47.3


