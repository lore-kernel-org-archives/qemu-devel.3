Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CC67C5DF87
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 23:59:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwTgW-0001wO-9N; Tue, 18 Aug 2026 19:57:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wwTgV-0001vn-1C
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 19:57:35 -0400
Received: from mail-oa1-x30.google.com ([2001:4860:4864:20::30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wwTgT-0005Cs-Ax
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 19:57:34 -0400
Received: by mail-oa1-x30.google.com with SMTP id
 586e51a60fabf-448b0ff4a57so392058fac.2
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 16:57:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1787097451; x=1787702251;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=BTsKoaZTlO/6rt1Z9aAI2LxFAikp1OEAPGg7kdKUGAc=;
 b=kyDnOzDE1P82hEywc3OVZjMxIw+V1+OO+bMRx+KyyO1xW97HJCcGngY02LquO+f+A4
 +Z5VJWOiJRcH+jBUyCrQoGCNSZ3rFsjH5LkhkqFT8ocZIp/RyCispMUu2QdkWboDcMe0
 PqVT04r9KiF4ycH6BmTCcSWB+xmK1w5L28MKcbOmbykk+fR1VSIfHLI6L+n3FzHe90Pn
 n7Ey4gQZE4/cnVwu5ef+44niS3SorjK7/XY7pekhiEdCdozVmhGgsPhFm+ocZv2PEa8i
 W++4XbCtYnlB5fawO9LjjGi+QN8oCiiWHj1ELcPe6kV3ALhG0Poj8/I4pLtEZ2JTxbr0
 xnlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787097451; x=1787702251;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=BTsKoaZTlO/6rt1Z9aAI2LxFAikp1OEAPGg7kdKUGAc=;
 b=ig0qZWo/6GG2ni5ZUoGFd5y360z8HkqdQ5pEYXruIo3QRMtXXXAv67io64QIy/2/M8
 /guRx8zXuxsWJ+qDQ/iDUYCWCyNyBnENMQgfxqjhPcbeVwLE5dXbEfpLUJnT+6zot5EG
 gUTy2Pcuyu7Hyn9wAzrjm+iY3J3CgsdALvK90CPFljXVdfVZHOYrhJuhaNDL1DOvOrAx
 TKl+Zqir3mZWk1JsVCr7PhXSGZDZxzH4rhkPdA4l1wSB4+4obPpxCGOhVNv9SsT8oTK5
 KCzR2pS4HHOuZFb8W15vBMMcaA6QIC301YJUzNc1q7dnC2sSsGxiEdGRVs7EpcWVo2Fm
 L1nA==
X-Gm-Message-State: AOJu0Yw5u0vwMtWDCInoW9XycJ7mS3rFGa13B42EQq9AyXbL0v3AgDTY
 C1wDMPQt90Q2+bsoVG/J8T0XAqow+MIHI4yqcedLguFpLpMyJzD8eIciVpGLiCjiKoM=
X-Gm-Gg: AR+sD10SK4Gh3DGw8k+iUR0Vh7XygQSDRH8ajNqUuCGCEoeVtlkhAG9Hr71s7S/nr1z
 D0YlQ+uGA/k0gQhtTkzufJzai/fWZNFsJk5wKlZe/dcc8u/Utwkr9+HgFybZ1/4DuvPEaWRCEOE
 A5YWAnqFnLfyb4PZ/lSajuKDeUBZRlbHglE2Em0hn/Inc4gzSF7nOs8khHxYYljFhb2Nq84WcRU
 /yE7MHym1AqKNo4zKbqJXfhIXrXppNFdkJ28zPMOAgbFyDoF/jQbwB8jvPE49CdwYSWeJqN9SLQ
 ZgAy50fnXXf7KBGEGCURSviQ/0ycK8ZmryLj6SbiqnVPcKienotBhVBj/3opg3uyhUNHmkujpNY
 RdXGG1/LJjpNWe0UrzU05zz5ACztup6WgWjwZg2U2nXA860fQTN/mGRljfNuss3A8ogtNrZsJU/
 QdDN4UpM6yxE46112xosj3a1bbuCVM5YdyA/FFNgrD3DZNqGQ=
X-Received: by 2002:a05:6808:6d90:b0:4ab:230c:5faa with SMTP id
 5614622812f47-4b2bcb6030dmr379911b6e.18.1787097451606; 
 Tue, 18 Aug 2026 16:57:31 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-4b2906a3edesm4835341b6e.0.2026.08.18.16.57.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Aug 2026 16:57:30 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
Date: Tue, 18 Aug 2026 17:55:57 -0600
Subject: [PATCH v4 04/40] bsd-user: Add signal shims sigwait through kill
 and os-signal.h
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260818-misc-2026q2-v4-4-09bf5647c98e@bsdimp.com>
References: <20260818-misc-2026q2-v4-0-09bf5647c98e@bsdimp.com>
In-Reply-To: <20260818-misc-2026q2-v4-0-09bf5647c98e@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Warner Losh <imp@bsdimp.com>, Stacey Son <sson@FreeBSD.org>, 
 Kyle Evans <kevans@FreeBSD.org>, 
 Richard Henderson <richard.henderson@linaro.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=4033; i=imp@bsdimp.com;
 h=from:subject:message-id; bh=16GTAWWUMqRVCxpmojAL0LGraqQ+5bPNS/76sTj3JFY=;
 b=owEBiQJ2/ZANAwAKAWwc0Sh9sBEAAcsmYgBqhPEkxYVA4GLkL9DMkI6mreISclg60rAwBrxPc
 TU62Tz0CmOJAk8EAAEKADkWIQQgNfiUsAqjz3zN4bdsHNEofbARAAUCaoTxJBsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMiwyLDMACgkQbBzRKH2wEQBi6RAAzUdZVskmn95qHwT+m4EPIosUer9M1Lw
 HDxyXbjNovZVoLjPS8fUev/BdMX8cnPK3XJjP/qk5mvCG0ptLh9ztxhllZWfqei1b0gbGdV6ruV
 uaHOl5HchcWG5NucypzeiMet3Rn2Xii24aGyQOgXYPyBO594Y0VzjpCcFtvFaYCrxDVdK6X6v5j
 BJaLWvSTgKyZUGespv25pltQk84gQ2Hn1PU2du3ZOAopKHNvWW51UtXpxOLO534Rl5bhhTh4+LK
 K1+fQTVznzCM0IJEE2SOXvLmG5cDV+Nji3RnrbwTV71tjEwX09S67zzD9qKkTpeztfmAJ4v+LSG
 C47ZEErpaWCVM5C0xNgdnmjVowD2oqcmbVR0PVYxzy3hxJHFIv4XkLGhxNpoTTU/f/FEzD+2+qs
 jhZskSvvwK6W2JRGkcqpFIgDfRZxJ4PcCOEdbdg2cRMytMN3U5QlvrZx5qTyszr2RNmvbbdlg7E
 CwE0aZRkujT0G86/h6+dJ4E967bU8iO6rhE1XTGFNpNkileuxNtQ1LukBnEaLj66u8YVYd0x+uJ
 HVCs7yb+5FKxIg6md21TvU88Wlu/1ZsZNKNvJ55RI0BQNcG6Wr6JqD8mkBBuOGEb0FEbkJEe8R7
 DKzA8r4UGG5Ol/xzvxVQ5I8bQWeyevGItG7EdH/Z3k2SopEUZchI=
X-Developer-Key: i=imp@bsdimp.com; a=openpgp;
 fpr=2035F894B00AA3CF7CCDE1B76C1CD1287DB01100
Received-SPF: none client-ip=2001:4860:4864:20::30;
 envelope-from=imp@bsdimp.com; helo=mail-oa1-x30.google.com
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

Complete bsd-signal.h with sigwait, sigwaitinfo, sigqueue,
sigaltstack, kill, and killpg. Add FreeBSD-specific os-signal.h
with pdkill.

Signed-off-by: Stacey Son <sson@FreeBSD.org>
Signed-off-by: Kyle Evans <kevans@FreeBSD.org>
Assisted-by: Claude Opus 4.6 (1M context)
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Acked-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/bsd-signal.h        | 80 ++++++++++++++++++++++++++++++++++++++++++++
 bsd-user/freebsd/os-signal.h | 20 +++++++++++
 2 files changed, 100 insertions(+)

diff --git a/bsd-user/bsd-signal.h b/bsd-user/bsd-signal.h
index 49e58d7436..09c5b30913 100644
--- a/bsd-user/bsd-signal.h
+++ b/bsd-user/bsd-signal.h
@@ -148,4 +148,84 @@ static inline abi_long do_bsd_sigreturn(CPUArchState *env, abi_long arg1)
 /* sigsetmask(2) - not defined */
 /* sigstack(2) - not defined */
 
+/* sigwait(2) */
+static inline abi_long do_bsd_sigwait(abi_ulong arg1, abi_ulong arg2,
+                                      abi_long arg3)
+{
+    abi_long ret;
+    void *p;
+    sigset_t set;
+    int sig;
+
+    p = lock_user(VERIFY_READ, arg1, sizeof(target_sigset_t), 1);
+    if (p == NULL) {
+        return -TARGET_EFAULT;
+    }
+    target_to_host_sigset(&set, p);
+    unlock_user(p, arg1, 0);
+    ret = get_errno(sigwait(&set, &sig));
+    if (!is_error(ret) && arg2) {
+        ret = put_user_s32(sig, arg2);
+    }
+    return ret;
+}
+
+/* sigwaitinfo(2) */
+static inline abi_long do_bsd_sigwaitinfo(abi_ulong arg1, abi_ulong arg2)
+{
+    abi_long ret;
+    void *p;
+    sigset_t set;
+    siginfo_t uinfo;
+
+    p = lock_user(VERIFY_READ, arg1, sizeof(target_sigset_t), 1);
+    if (p == NULL) {
+        return -TARGET_EFAULT;
+    }
+    target_to_host_sigset(&set, p);
+    unlock_user(p, arg1, 0);
+    ret = get_errno(sigwaitinfo(&set, &uinfo));
+    if (!is_error(ret) && arg2) {
+        p = lock_user(VERIFY_WRITE, arg2, sizeof(target_siginfo_t), 0);
+        if (p == NULL) {
+            return -TARGET_EFAULT;
+        }
+        host_to_target_siginfo(p, &uinfo);
+        unlock_user(p, arg2, sizeof(target_siginfo_t));
+    }
+    return ret;
+}
+
+/* sigqueue(2) */
+static inline abi_long do_bsd_sigqueue(abi_long arg1, abi_long arg2,
+                                       abi_ulong arg3)
+{
+    union sigval value;
+    target_sigval_t *tvalue = (target_sigval_t *)&arg3;
+    abi_ulong sival_ptr;
+
+    __get_user(sival_ptr, &tvalue->sival_ptr);
+    value.sival_ptr = (void *)(uintptr_t)sival_ptr;
+    return get_errno(sigqueue(arg1, target_to_host_signal(arg2), value));
+}
+
+/* sigaltstck(2) */
+static inline abi_long do_bsd_sigaltstack(CPUArchState *env, abi_ulong arg1,
+                                          abi_ulong arg2)
+{
+    return do_sigaltstack(arg1, arg2, get_sp_from_cpustate(env));
+}
+
+/* kill(2) */
+static inline abi_long do_bsd_kill(abi_long pid, abi_long sig)
+{
+    return get_errno(kill(pid, target_to_host_signal(sig)));
+}
+
+/* killpg(2) */
+static inline abi_long do_bsd_killpg(abi_long pg, abi_long sig)
+{
+   return get_errno(killpg(pg, target_to_host_signal(sig)));
+}
+
 #endif /* BSD_SIGNAL_H */
diff --git a/bsd-user/freebsd/os-signal.h b/bsd-user/freebsd/os-signal.h
new file mode 100644
index 0000000000..fe102c33e4
--- /dev/null
+++ b/bsd-user/freebsd/os-signal.h
@@ -0,0 +1,20 @@
+/*
+ * FreeBSD signal system call shims
+ *
+ * Copyright (c) 2013 Stacey D. Son
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+#ifndef FREEBSD_OS_SIGNAL_H
+#define FREEBSD_OS_SIGNAL_H
+
+#include <sys/procdesc.h>
+
+/* pdkill(2) */
+static inline abi_long do_freebsd_pdkill(abi_long arg1, abi_long arg2)
+{
+
+    return get_errno(pdkill(arg1, target_to_host_signal(arg2)));
+}
+
+#endif /* FREEBSD_OS_SIGNAL_H */

-- 
2.55.0


