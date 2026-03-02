Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECF0FD58E47
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2026 04:23:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vwunL-00016e-19; Sun, 01 Mar 2026 23:22:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1vwunK-00016V-5C
 for qemu-devel@nongnu.org; Sun, 01 Mar 2026 23:22:10 -0500
Received: from mail-ot1-x32b.google.com ([2607:f8b0:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1vwunI-0006tM-KJ
 for qemu-devel@nongnu.org; Sun, 01 Mar 2026 23:22:09 -0500
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-7d4c68f0e47so2639375a34.1
 for <qemu-devel@nongnu.org>; Sun, 01 Mar 2026 20:22:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1772425327; x=1773030127;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Q0DavvhmXzjPIlD8BiFgEKcZjLsSmJe6+EzHi56OkSY=;
 b=Vfj4Q90Egxbazpb5E3CT6dAgDzpxVcQ9rOOm03C6DYLQ73q9Y5bMYSEVnJoOXIThid
 XXpqsP2uzSF1AWDCvQq8iPRIqN7yBl53rRQXRIIVYILPjZy8N1fKXv+fdysgWqYQF8Rc
 w/VwfFB3IRq2VjKZl/w7QGNyBma2IvMB1m/jTSJLr55wuAt9qgKNDxqD6E7JnIupKzR1
 NpQQIo2Sl1ddPz9qwg+XMBnqIc841qmQWOi299oy1B5oUnEy2Cllpnx7O2mZCcyPvQkz
 6dFgP0OmGE/slQ8PqLesRh6WxhmeeI6i8+hdEX9LRNtUSSuZAegMX5Ts9zf/1n//E3sX
 DZLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772425327; x=1773030127;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Q0DavvhmXzjPIlD8BiFgEKcZjLsSmJe6+EzHi56OkSY=;
 b=Mu8v1Lmuru/5MD8czjhyeQ27zIJ4VfWRA3OoEpRWiNWoW4l5JaxUZ8WwXtph1WYLUk
 MQxfNTgrOff43s0huZzJ4wV+MXWebin4/+1gCf08nn0dBfia+Ra6PiqyaYM6TExveBTR
 0i3jEbsfjcZSPOOHwqetpMcrhxfjvPxy7p9Rqdpjh1A18Vkz8FSpYQd9RVTVV/HUs+rP
 A72UFrNRKlMFxBI3kTrjPoevVQkETluIO4yL4efYwX6kISvVH0TrMW7uGuMYzX5OCb90
 fqOOjEbFVaJGY2N0t+vm09IgE0IYsrU//xiQvV3kOffMMLQw8jTlM93NAOEQen+FD9gw
 sLaA==
X-Gm-Message-State: AOJu0Yz6aeXeorvsXzQ+LQZn0kn+mKYe7No9fUtNUY8fyMXNoBE5M2vq
 okVYMIuT5iXv3mu4dnKB73E/gZiZO+IwTpn59N4sneEvWc/JoONFqyZ87SVuPwfuXLqraKafgvu
 IDxwr1SI=
X-Gm-Gg: ATEYQzz78H/AiTG1TfwWTJzO2oNUMFsZ5P00Ca55T38SFX+3LbgacoHgA30ctAVzL7P
 3Dw7azjT4/+H3OgThVbQGxyDuesxFlA1SlHykoAq8Pbv4t2U+gf7xSxd3ey7u7bobf4ZapQQetJ
 1gAurlNjGbE12o5TQvq1GHrpv4DW7/wyVIGt64bxT6LpN/ikBwVUbGgkUOHXfZBkqx+jjGtuOc7
 SKp3y/qW8BhYyPcva0diRLYia112C/SsaZ+qTcBb8acfmo5oXLZfdPLMqRZJ12+oNG0BBpaSyJS
 8kUBkKQMYaDFT6Srl718novisFKcN0bDzRYYOxenkJ+zGpBiLlA9Fx4Ad5JpraAzHoNyS3axuWs
 j0yazKVt8kiClZvS+r0C1hU8mhNfkBKutAi2gEM9/VsGX/MlAALS3BEH3v4R302A4jMS4q9USJK
 HE2RpNVMPtOQ==
X-Received: by 2002:a05:6870:b0c3:b0:3ec:50d6:4461 with SMTP id
 586e51a60fabf-41627094f96mr5109221fac.39.1772425327105; 
 Sun, 01 Mar 2026 20:22:07 -0800 (PST)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-41668233c4bsm2236778fac.19.2026.03.01.20.22.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Mar 2026 20:22:06 -0800 (PST)
From: Warner Losh <imp@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Reinoud Zandijk <reinoud@netbsd.org>, Warner Losh <imp@bsdimp.com>,
 Ryo ONODERA <ryoon@netbsd.org>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Kyle Evans <kevans@freebsd.org>, Brad Smith <brad@comstyle.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Riku Voipio <riku.voipio@iki.fi>, Stacey Son <sson@FreeBSD.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 22/27] bsd-user: Add message queue implementations
Date: Sun,  1 Mar 2026 21:21:10 -0700
Message-ID: <20260302042115.83410-23-imp@bsdimp.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260302042115.83410-1-imp@bsdimp.com>
References: <20260302042115.83410-1-imp@bsdimp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::32b;
 envelope-from=imp@bsdimp.com; helo=mail-ot1-x32b.google.com
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
 bsd-user/bsd-misc.h | 97 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 97 insertions(+)

diff --git a/bsd-user/bsd-misc.h b/bsd-user/bsd-misc.h
index 4209ac61d0..13e40d9cde 100644
--- a/bsd-user/bsd-misc.h
+++ b/bsd-user/bsd-misc.h
@@ -17,6 +17,8 @@
 
 #include "qemu-bsd.h"
 
+static int bsd_msgmax;
+
 /* quotactl(2) */
 static inline abi_long do_bsd_quotactl(abi_ulong path, abi_long cmd,
         __unused abi_ulong target_addr)
@@ -260,6 +262,101 @@ static inline abi_long do_bsd_msgctl(int msgid, int target_cmd, abi_long ptr)
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


