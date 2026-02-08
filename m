Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFCC8EF06E1
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Feb 2026 19:28:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpAS0-0000pQ-G2; Sun, 08 Feb 2026 14:28:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1vpARC-0000dt-F1
 for qemu-devel@nongnu.org; Sun, 08 Feb 2026 14:27:23 -0500
Received: from mail-oo1-xc31.google.com ([2607:f8b0:4864:20::c31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1vpAR7-00006j-Ri
 for qemu-devel@nongnu.org; Sun, 08 Feb 2026 14:27:16 -0500
Received: by mail-oo1-xc31.google.com with SMTP id
 006d021491bc7-662f65c7d8cso2025110eaf.2
 for <qemu-devel@nongnu.org>; Sun, 08 Feb 2026 11:26:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1770578808; x=1771183608;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ljONX2ar5rII3EFiqoZLf6I1mkPdZFg2Wj+97CVjdFQ=;
 b=FTAQ3I3GlVhwomjnrmVojH3cRIbxI4CMM4VwgpGWn7kL4R2YJuoifsGqHkER6tM6mv
 txAFlUzkFsYXbyf0H25RrXbPUpvH0tHk+cXsCvFAz4Yh0yxWbEkHjTBGny9o2IxyzivR
 lkj0hkgN3zpfsb8fOtcS64Zj+OeYah5amgQHynR1lKJ/soFw8nwSVMzHrSfyaAKBPswj
 k8hmsemiOZ5XWrTLT5+Cy8JPscRCGuPmi4fsBplxhLqYJkAswA6aw9mrAC727+nUUZOk
 +jDH3QsIs8Vfmey5YASJvCDi4G+1SMoi8T6YGTt7Icd90GmOu78TSLGlGqBGqzbAizyp
 3buA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770578808; x=1771183608;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=ljONX2ar5rII3EFiqoZLf6I1mkPdZFg2Wj+97CVjdFQ=;
 b=HbPqY5Ehc/p260kjWOyIXDxu9QiaJcOcKMDOZmF8O83/8ZKiIs1k5JfQGh9+jQMuWi
 a7fA5otMt2HtDY/i78bc13/o4NOoVm0NXA+B7TL96ciamisTduE6qUWIk7JgYbReYrz9
 9xclCtAo/K0Me4Xi8y2fZuboEs25d6bQELxgX2m0FeFyosGNrV1Q0/zkNfbkXaYAKtLk
 dXgh6lg19IiGUJngGg5/G5/4xykLybc+8Mg6h1A44ktPiGgdaSNMvLUhh1bnG2eLchEq
 Eu6srB7QFm3hc3tuzWwi2Cfys4NVF08jshOUz02xn6BYvi6XjrFJ96CMxzNN3At1odJR
 RRmQ==
X-Gm-Message-State: AOJu0YxFRfRSTPP0TmBbvD2zOPrTOencpt4yxCeLPn/IrmOgZfPaThZq
 J3rI3pIN0dgq5tK1UTndEVzg6hE4+5JRUuURRx2xXx6GyfasJEZN6ghxhrv289Q2SSw=
X-Gm-Gg: AZuq6aLl7kmOSb6WJJMfRXffOjIBliuOzMIrbtnTPIhsHHjkZW8IxiLgGizjxT9rmwC
 e90U9eh9Lu8uIbxRkxGoVPQoxn5+nxbxaYkJ3O/KSqHk7YpAh/uTzlqG5bgXH1rwsYbSTLjb+2Z
 /JD72X4xdEIWTlLwae41IrV22GVmUofkDSyOQzUBJKXEiAxc5eYdnML0z28tyeeeyjNd05SOJaA
 UeC/FdUPzlWV6m1OC59jVuN81U9tFw40c9dC+UhwSjPBbAn120VETE+/Avr4WUQhGS2H4M9cwyA
 /qHj6SdXUlKUjvHaA7ATIuLuKjvGbQWXkbWwU9mcl25C3MJVdhwrkRigSdst6RWYCKKkw+dt21O
 MYTxjYuGOZhXsOKLHk3D2+H+KrMVwQ/05DNLWR4aLEQIdQYDu+OSbm7ShXix3+guQBaXv2xUCqm
 zD8wuLFiDM
X-Received: by 2002:a4a:e84a:0:b0:661:1c57:1b3f with SMTP id
 006d021491bc7-66d0bcb9834mr4052700eaf.46.1770578808241; 
 Sun, 08 Feb 2026 11:26:48 -0800 (PST)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-66fdf303607sm1741301eaf.14.2026.02.08.11.26.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 08 Feb 2026 11:26:47 -0800 (PST)
From: Warner Losh <imp@bsdimp.com>
Date: Sun, 08 Feb 2026 12:26:26 -0700
Subject: [PATCH v2 17/24] bsd-user: Add do_bsd_semop implementation
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260208-bsd-user-claude-v2-17-58e5fcfdb84f@bsdimp.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1559; i=imp@bsdimp.com;
 h=from:subject:message-id; bh=nxMC1ALQtLcYfQvQkCZueSsGWPbPJJEx7nQ1XD4BbBo=;
 b=owEBbQKS/ZANAwAKAWwc0Sh9sBEAAcsmYgBpiONhG1xRsnNzCZ3qjIjEC1d/hrSmo2iMC5mwi
 zm1e5HQLo6JAjMEAAEKAB0WIQQgNfiUsAqjz3zN4bdsHNEofbARAAUCaYjjYQAKCRBsHNEofbAR
 ABvKEADqII7iUpw+UC88Bz8lGDON/giwB1yCj5J/XmfGYsWvgryBqfwvzZm9tK5XUlEI0/ywCYE
 3vMpWH+ITg0j/wf2omn79EPq/X3yLsNwQsOQeV5E+TcoxanwwgREORXp3gJGTakip6Xn7ZN0m4A
 5Fuj7w0B1RnlK/RyJ2g8avptD28SGY+2iFPYbkkQhWq9I3uWWBv3J9czLbOGL3ze8bW4DhImj2h
 fX60yPco+y7HToeGtnR59WW3IidNIrmt955H520qqjB9qKKu1GlXFW+P50h9WNCE8MCI4ooSzhQ
 k5sGQkSs9ZBgLA+wtsmC6mNRLBE1ZKJU+3H6QOH8xtzOMeFfB35SiEg/1H6Fr6+eYsy+qY7YdzL
 1lnysArNSTQvhbbg7ktfk/lP9SFc6jFZdKQhphJkEUOO0PW/t750BdZdnpSlPctcwIUuyE4BUuO
 YuMmIXdSVL9oP/2aoXwrptwPuEuktcXyedBNl2/vfm20EQ3Bm4eJtbOtUWyLfrKd8alRkR8JwoQ
 smJ50MmMvXSNXyAgfxEIQePdqOEMI4pWpjOVYsRzHmt191t+m/xyPUoAPNuxaWC8TrNbitCPF0R
 HNe++8S7oa1VDXxX85C3AAevv1fvDD7m1CLBC0Jek6Wk06DCyucJlYFOoXwhNBQZADS6c70fQHC
 ArA56pUjIlABjkA==
X-Developer-Key: i=imp@bsdimp.com; a=openpgp;
 fpr=2035F894B00AA3CF7CCDE1B76C1CD1287DB01100
Received-SPF: none client-ip=2607:f8b0:4864:20::c31;
 envelope-from=imp@bsdimp.com; helo=mail-oo1-xc31.google.com
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

Add implementation of semop(2) syscall to perform System V semaphore
operations. Converts target sembuf array to host format and executes
operations.

Signed-off-by: Stacey Son <sson@FreeBSD.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/bsd-misc.h | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/bsd-user/bsd-misc.h b/bsd-user/bsd-misc.h
index cc489ab13c..cba0b2ec92 100644
--- a/bsd-user/bsd-misc.h
+++ b/bsd-user/bsd-misc.h
@@ -84,6 +84,28 @@ static inline abi_long do_bsd_semget(abi_long key, int nsems,
                 target_to_host_bitmask(target_flags, ipc_flags_tbl)));
 }
 
+/* semop(2) */
+static inline abi_long do_bsd_semop(int semid, abi_long ptr, unsigned nsops)
+{
+    g_autofree struct sembuf *sops = g_malloc(nsops * sizeof(struct sembuf));
+    struct target_sembuf *target_sembuf;
+    int i;
+
+    target_sembuf = lock_user(VERIFY_READ, ptr,
+            nsops * sizeof(struct target_sembuf), 1);
+    if (target_sembuf == NULL) {
+        return -TARGET_EFAULT;
+    }
+    for (i = 0; i < nsops; i++) {
+        __get_user(sops[i].sem_num, &target_sembuf[i].sem_num);
+        __get_user(sops[i].sem_op, &target_sembuf[i].sem_op);
+        __get_user(sops[i].sem_flg, &target_sembuf[i].sem_flg);
+    }
+    unlock_user(target_sembuf, ptr, 0);
+
+    return semop(semid, sops, nsops);
+}
+
 /* getdtablesize(2) */
 static inline abi_long do_bsd_getdtablesize(void)
 {

-- 
2.52.0


