Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49A59EF06E1
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Feb 2026 19:29:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpASj-0001TN-GX; Sun, 08 Feb 2026 14:28:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1vpARA-0000dR-7Y
 for qemu-devel@nongnu.org; Sun, 08 Feb 2026 14:27:23 -0500
Received: from mail-oi1-x22e.google.com ([2607:f8b0:4864:20::22e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1vpAQs-00007U-T5
 for qemu-devel@nongnu.org; Sun, 08 Feb 2026 14:27:14 -0500
Received: by mail-oi1-x22e.google.com with SMTP id
 5614622812f47-45c8e85deffso738052b6e.1
 for <qemu-devel@nongnu.org>; Sun, 08 Feb 2026 11:26:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1770578813; x=1771183613;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=zHW6LQFaIzwSaKkoHeZZjH30Ksax78GgwX4zPL/ZVxM=;
 b=VEalQyKak4aiFX77FVQ94GfN1slti+l7a1iXFMlQ/imGyLwGQ6HMEsHmiikt6pdT+y
 w/NPtB6MsJgAazD0vdtbYP0MdlPR38BGbY4WtrX0B1OQA2Fff6ZQEdaQM9r9uGpFwapH
 pAuOjhVkqGo36pnZ37kZZGJp7ByIDbi0u5qEh82i/kVOOxpHjcEkdZv20byPko9Qu99J
 kKTnva1PTZ2MKpR2+p0ouFqNcpc6U8dCQviv0hnqybE93oLwzXifvEoXN/ZbqUOi3ItS
 GzQEKujnx9wdV44Zfgb6/qI620M9m45LlsCIJbkvYA/fFE7VijF/Mq7DVoP4O5TqDeiY
 gFxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770578813; x=1771183613;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=zHW6LQFaIzwSaKkoHeZZjH30Ksax78GgwX4zPL/ZVxM=;
 b=bxpC8Qpoy3pjUp0UXLzqtAuyBYmOcKT1oXk6SehVBnmhKDB+WgxYwnFNX5AN3Ot8vS
 9eZ6CgPfWrpxoBua3J6Iveff7NMKIR+JXdn4kOIM+2dEblUXFmibxwDZ8qfpL7I86RKV
 5RdZF8HECwXD+3Q7r671vLYkiSSDvPQRk3OwAWKwBZZbmaOzMxUpHtj4meHVbKHAJSpn
 ShVClcCL44FuGNwbWzWemWV9mzWsWxtGZ7gyktkF9mmHDG5l+iz7ZKF0EzrDJP5HfEIb
 18lvFQYOcH/4BFWsi7utLwYzUWC//3z4H3vb22Ny3WTFyCZywv7tMasvi4xwvDpCjqZF
 ZNog==
X-Gm-Message-State: AOJu0YzsdBuS6LOMoTimHYur4TTWd9Xkz8FkmBmdCF2s3b6M/TJEVYi3
 /xXEO44tUts9yBtSYOPa3JpCa/Aquf6Yfgy2ZTiwKjAljU9fcp/ZdSjuMC7H1idqEnU=
X-Gm-Gg: AZuq6aJ3GSUSJ4YB6G5t7Z+TDcSZX9MOidPymtIqQEVt79QRNevon4laOQJWJVvkye6
 yL9N0fZGzZ6TFNfpdgZ4LMZFOijq5cVFNbCbpFOYvSfAQ6fHDqZI+N7ME+TmfxfK52bMEJIAEDD
 Q/6Sj4XmlDto3/2RVa/viBGYt0I/Z5M+kSd+oobOzqquNCHbZrolAwte0hlHaLLkCf91xmI1IsM
 kcN0QGlxsiDlfdPNndJB8AaaZFjwsAj5hRmcvv9et+iSn+pZLfTvjaUSGCpZR7kl5aYP5hX6AlF
 D4ELyG+3bnvG1f0mfJ0PrcyUBxC9j6OY51LxdPTdsj3zn4HGWpL0MFYf6aWX2IkC2hGdJYPR+KS
 SscgHsk/pmB2B90TUM/AdwK4j+2/xTZUl0myoEB+ESQEkmqVNdDgtGUdA7dFDs5meKe4z09jXR2
 eWQW1MWhcd
X-Received: by 2002:a05:6820:2d42:b0:65c:f019:ccca with SMTP id
 006d021491bc7-66d0a37cedamr4599346eaf.21.1770578812650; 
 Sun, 08 Feb 2026 11:26:52 -0800 (PST)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-66fdf303607sm1741301eaf.14.2026.02.08.11.26.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 08 Feb 2026 11:26:51 -0800 (PST)
From: Warner Losh <imp@bsdimp.com>
Date: Sun, 08 Feb 2026 12:26:29 -0700
Subject: [PATCH v2 20/24] bsd-user: Add message queue implementations
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260208-bsd-user-claude-v2-20-58e5fcfdb84f@bsdimp.com>
References: <20260208-bsd-user-claude-v2-0-58e5fcfdb84f@bsdimp.com>
In-Reply-To: <20260208-bsd-user-claude-v2-0-58e5fcfdb84f@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Kyle Evans <kevans@freebsd.org>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Riku Voipio <riku.voipio@iki.fi>, Warner Losh <imp@bsdimp.com>, 
 Stacey Son <sson@FreeBSD.org>, 
 Richard Henderson <richard.henderson@linaro.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3717; i=imp@bsdimp.com;
 h=from:subject:message-id; bh=MFUKW2hCFFpmO24KyOwSzU6K7ikVw+umbnly3Xmf3hs=;
 b=owEBbQKS/ZANAwAKAWwc0Sh9sBEAAcsmYgBpiONhZmgirpDto1qpbJSzre480uHCeths7limQ
 o0FyjjJpE6JAjMEAAEKAB0WIQQgNfiUsAqjz3zN4bdsHNEofbARAAUCaYjjYQAKCRBsHNEofbAR
 AEXSEACp+tdnupBS+nkVZ9KW57DYRbsMdOtvZH2aIIHrAAkNcdSZyIK7j7ab73RcSDahy1QDZGn
 EkOPy4nTzl4zaaZQsV9GeQeT6dcB4rDEPPefu3xCm1bGu8lTx/8mmX+eBn4yW3RbNhxm0ELuKLP
 skt1tjldCRommb8yGPaVAKrx4HGKh5Cdn2SKN8MFyQoP0wCivhZrvfyoo/tRMu+praRZosrW0VY
 En5dygH586wH7axAGzffIMlk6DhpzRBnNEEo8BJ7jLtWdf7EYavJQmeCKKq9wwATGpQy7B8uXmJ
 yeP/br5etuII4+pNJZFFrlLbdkTWy4J/YZzBWZWufWkRrTwrdVJw05BgvpzbRsKuEFItAdOJfb7
 bamVNLT5UAIHbcr8Bwgmu3sbijZ92+Fu8PR4sqKd7ixA1SvnXdzu56PRd1A76wXLjT7QIBj3EOb
 Oo7tkgY3YFmtuCePDSbC/1XTc9Cd1IvZx7N/oWHVinY0qPlKgQkODcI+dFjiQAfwgkVWA8hkp4d
 IkaGGEQ25dodUM1IyOjdlPEt2XuCy9szavWkEUpQo69weOdstnw9nD7w8LUh2Bl2YVjdbMAflip
 mJjr9HnufBNVUUiNSGjtRuMzhnuthty86tQEHm+TnKlIKTFDI6b+VUrWaVY9sPwbbhTebhVQ93e
 mZyTpCKvo9rRcvw==
X-Developer-Key: i=imp@bsdimp.com; a=openpgp;
 fpr=2035F894B00AA3CF7CCDE1B76C1CD1287DB01100
Received-SPF: none client-ip=2607:f8b0:4864:20::22e;
 envelope-from=imp@bsdimp.com; helo=mail-oi1-x22e.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

From: Stacey Son <sson@FreeBSD.org>

Add implementations for:
- msgsnd(2): Send message to queue with size validation
- msgget(2): Get message queue identifier
- msgrcv(2): Receive message from queue with size validation

Signed-off-by: Stacey Son <sson@FreeBSD.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/bsd-misc.h | 97 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 97 insertions(+)

diff --git a/bsd-user/bsd-misc.h b/bsd-user/bsd-misc.h
index a45fe8edb5..ff27f94944 100644
--- a/bsd-user/bsd-misc.h
+++ b/bsd-user/bsd-misc.h
@@ -28,6 +28,8 @@
 
 #include "qemu-bsd.h"
 
+static int bsd_msgmax;
+
 /* quotactl(2) */
 static inline abi_long do_bsd_quotactl(abi_ulong path, abi_long cmd,
         __unused abi_ulong target_addr)
@@ -268,6 +270,101 @@ static inline abi_long do_bsd_msgctl(int msgid, int target_cmd, abi_long ptr)
     return ret;
 }
 
+struct kern_mymsg {
+    long mtype;
+    char mtext[1];
+};
+
+static inline abi_long bsd_validate_msgsz(abi_ulong msgsz)
+{
+    /* Fetch msgmax the first time we need it. */
+    if (bsd_msgmax == 0) {
+        size_t len = sizeof(bsd_msgmax);
+
+        if (sysctlbyname("kern.ipc.msgmax", &bsd_msgmax, &len, NULL, 0) == -1) {
+            return -TARGET_EINVAL;
+        }
+    }
+
+    if (msgsz > bsd_msgmax) {
+        return -TARGET_EINVAL;
+    }
+    return 0;
+}
+
+/* msgsnd(2) */
+static inline abi_long do_bsd_msgsnd(int msqid, abi_long msgp,
+        abi_ulong msgsz, int msgflg)
+{
+    struct target_msgbuf *target_mb;
+    struct kern_mymsg *host_mb;
+    abi_long ret;
+
+    ret = bsd_validate_msgsz(msgsz);
+    if (is_error(ret)) {
+        return ret;
+    }
+    if (!lock_user_struct(VERIFY_READ, target_mb, msgp, 0)) {
+        return -TARGET_EFAULT;
+    }
+    host_mb = g_malloc(msgsz + sizeof(long));
+    host_mb->mtype = (abi_long) tswapal(target_mb->mtype);
+    memcpy(host_mb->mtext, target_mb->mtext, msgsz);
+    ret = get_errno(msgsnd(msqid, host_mb, msgsz, msgflg));
+    g_free(host_mb);
+    unlock_user_struct(target_mb, msgp, 0);
+
+    return ret;
+}
+
+/* msgget(2) */
+static inline abi_long do_bsd_msgget(abi_long key, abi_long msgflag)
+{
+    abi_long ret;
+
+    ret = get_errno(msgget(key, msgflag));
+    return ret;
+}
+
+/* msgrcv(2) */
+static inline abi_long do_bsd_msgrcv(int msqid, abi_long msgp,
+        abi_ulong msgsz, abi_long msgtyp, int msgflg)
+{
+    struct target_msgbuf *target_mb = NULL;
+    char *target_mtext;
+    struct kern_mymsg *host_mb;
+    abi_long ret = 0;
+
+    ret = bsd_validate_msgsz(msgsz);
+    if (is_error(ret)) {
+        return ret;
+    }
+    if (!lock_user_struct(VERIFY_WRITE, target_mb, msgp, 0)) {
+        return -TARGET_EFAULT;
+    }
+    host_mb = g_malloc(msgsz + sizeof(long));
+    ret = get_errno(msgrcv(msqid, host_mb, msgsz, tswapal(msgtyp), msgflg));
+    if (ret > 0) {
+        abi_ulong target_mtext_addr = msgp + sizeof(abi_ulong);
+        target_mtext = lock_user(VERIFY_WRITE, target_mtext_addr, ret, 0);
+        if (target_mtext == NULL) {
+            ret = -TARGET_EFAULT;
+            goto end;
+        }
+        memcpy(target_mb->mtext, host_mb->mtext, ret);
+        unlock_user(target_mtext, target_mtext_addr, ret);
+    }
+    if (!is_error(ret)) {
+        target_mb->mtype = tswapal(host_mb->mtype);
+    }
+end:
+    if (target_mb != NULL) {
+        unlock_user_struct(target_mb, msgp, 1);
+    }
+    g_free(host_mb);
+    return ret;
+}
+
 /* getdtablesize(2) */
 static inline abi_long do_bsd_getdtablesize(void)
 {

-- 
2.52.0


