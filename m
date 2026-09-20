Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F26A2C982D8
	for <qemu-devel@archiver.kernel.org>; Sun, 20 Sep 2026 05:21:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x89zJ-0006Tb-SB; Sun, 20 Sep 2026 01:21:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1x89zH-0006T1-Cx
 for qemu-devel@nongnu.org; Sun, 20 Sep 2026 01:21:15 -0400
Received: from mail-oo2-x0c.google.com ([2607:f8b0:4864:31::c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1x89zF-0002C9-4o
 for qemu-devel@nongnu.org; Sun, 20 Sep 2026 01:21:14 -0400
Received: by mail-oo2-x0c.google.com with SMTP id
 006d021491bc7-6c72bd8a02fso1194268eaf.0
 for <qemu-devel@nongnu.org>; Sat, 19 Sep 2026 22:21:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1789881672; x=1790486472;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=mlQ7iIwJ/TgDzk8MhB4o1L3V17a8mX1EHREJtSeiQH0=;
 b=Fnfs8L61KrZ/kqSY9vy60GBSn0dq94tajDfJbApFCXX5TCafSKlGPXowmrvwzjBS3N
 FuSAUameOTFWxq4hnzaRAJLlXdhYB4rfmrgxb8dO7o4fK8qfLaCNf3H3lCCtMR9F0FVg
 oN4LEUFoeUVoq9SJsnKQptGSXCGg3CnyPgnE5UaBkEK+2DG8ecdXa2nX7Ze2Lpf01wlt
 lfSlfp+UPgzhMg1mJNqPfaby7Hjxhi2oBE2zAfnRFqP5ySSWCeifLQAhIaL37CApP/H4
 DfnaEIIFe+SW5jAnrNLF+wI+OOqNsYTPdrfoARA3fLWjQBN8Cn263ZRShSoLxSEKUjZB
 Ie8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789881672; x=1790486472;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=mlQ7iIwJ/TgDzk8MhB4o1L3V17a8mX1EHREJtSeiQH0=;
 b=TodT+XX1Gbdn/Fn0uxPtTYUTnmz5tSJod4Q00bBmtxZgnH8J/15aPiOY+OltvEf1Y9
 Xj+V7vNkvxYy/PhKnP/dT+ljrDJ6EqTIQfP9vBd/OX6TU1Xt7Gb3NNlXxBqPTfpbJ7BL
 r28YOcu5eyIZQ6OZgAsKFVwZIko/idL1cW24RDQC+wGgovOqtCvvYTzqFdJD4mpsOvq2
 coE3tMqBXnxQ/WCTE7Bk5tbpkkAGLc40+Dg6RIyVHIfvY9x1G3Ej0hMiPYcCqg0Y/k5c
 hs22jAt8fyUieWKNeHr/7dapahU3WqKF0GbkzXsYzoVDGEjffzAo9LxXKpQ/Weznp/Vs
 ANgw==
X-Gm-Message-State: AFuF++kbnBZ44OImMKNuDN81MPIaiFL9Bv88EoMedkEcLZvbO02taiZz
 lgnW9pcsiIy9xWqOk9ndEhjIl4ZXHgtGjYbUMyKPJJ1Y0UY/FTi9oZVmO3tNS+v7fnJWNROGbkN
 2/91bi8A=
X-Gm-Gg: AYBFou3ol6MyE90OLUj3Lrk9RJto8OR9Kr2XDTC/nnd2EP77BW7QfOOptsMCjVa/KjR
 wjdcznSQsanN6M5shnCX/IDiMU+TxOU7wm3/NazQf89R4+BdlSuV2wlrCRJpxMS4m6qMunpGSx1
 GQVRFopDT89tZ6G43RRX3VL8usxZMI5xgcipNDnOr27K6i6O8z2Kc1ee70KtlF1ak5qFt5GBpQ/
 N/oSett8FougQ6Ovo8seSqST8hpIj/d0FWNJZYwJqf215Suza7M2kV+IcsYkoCsopzbeiPG+i56
 PIA3UtpPOeyxsktgBW9aSLsxFvMk6dsRvjTptqin9MQYPSOe1z75Fwhyck9xM7Hv0ktcsHTI5o7
 xqwJoK2nfalvfJilCPmB7RbhFShdtL0szSqXmF0MW07RW0XxM/PR7UMRE4VG+Peue8cfX8cLTiu
 cP9ta+DgSS4OqRc2zEdOOTWtjunYv5Zge2+m4R60xoNiz5Dh8GRTA1XsHg2A==
X-Received: by 2002:a05:6820:2d0b:b0:6c9:80d8:a1fe with SMTP id
 006d021491bc7-6ca9d551849mr6488149eaf.59.1789881671943; 
 Sat, 19 Sep 2026 22:21:11 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-48821db3b4bsm3936865fac.17.2026.09.19.22.21.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 19 Sep 2026 22:21:11 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
Date: Sat, 19 Sep 2026 23:20:45 -0600
Subject: [PATCH 09/14] bsd-user: Implement exterrctl(2)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260919-misc-2025q4-v1-9-ebfa61049bd7@bsdimp.com>
References: <20260919-misc-2025q4-v1-0-ebfa61049bd7@bsdimp.com>
In-Reply-To: <20260919-misc-2025q4-v1-0-ebfa61049bd7@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, Warner Losh <imp@bsdimp.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1678; i=imp@bsdimp.com;
 h=from:subject:message-id; bh=lxqHcY18N/1JhdhWa1q5OTPbuDK2jmT1cP7uL20j3xk=;
 b=owEBiQJ2/ZANAwAKAWwc0Sh9sBEAAcsmYgBqr20xLDqAwWLAZbdQ1zs4nfeN4sHBNEm7xLvns
 S4AksYIPf+JAk8EAAEKADkWIQQgNfiUsAqjz3zN4bdsHNEofbARAAUCaq9tMRsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMiwyLDMACgkQbBzRKH2wEQDjFw/+Lv4S9ZuenHUP04h9OZs0OupQaH9dqBz
 m2vqt+UySiBMpJner9DsE+jEKV2L9kryOqVJueHibIElXP5gi0sta1Q+r6OpGF1iLfJwvApFWyo
 UbWja0ktyDf49ndSh18p3aibFi4zHTxfiW9GE8C9fFrdarLWSvzvIEKK2EgEvXyy47ymaIGkB+D
 rcx198hmqZQNDcp69wvnLuaRSx0+h9AoDSUQHnaTS644qtichwIBOXTHe2mIMnk95EL6RAvKy8h
 ONPB+RQgalLEKn5idRGnDWk/3aBd4zZ8/+grcGTz3jB8wGT5Q/IlzVVoG9MJIYzya4ohdbr7xKU
 0dEJiD5rqM8NQbEm7x70eY02grZthtboAqikpmLHEL5pxdsk8wasdHyA/cUIa7ZsfqJX6Iek6gz
 Otf6yRFbk+2TCyBbrbYmyArg1x0OTeWy4JOY+egU2i1wpBcemEQDnNsvWc7G47xDlRaKYleVfVM
 znjDtcpnNFnyBIsrsnnCS4dEp9FpfoWBZDVpAeKaNOjTGk8V73mRiKJIz/cSlUGvpRJfAiSaw+c
 Hw7w7mocUzZxYXFCnv+7unRXEH7XR9crHcvs1+GlgBcsKVIvubKasC53EiwMpSUxbZMQjTqy9r+
 NHGkPTLAzOqiUt5QTMOSsamOJ2N1K8lsHmOcN2niSefCmpfWSn1k=
X-Developer-Key: i=imp@bsdimp.com; a=openpgp;
 fpr=2035F894B00AA3CF7CCDE1B76C1CD1287DB01100
Received-SPF: none client-ip=2607:f8b0:4864:31::c; envelope-from=imp@bsdimp.com;
 helo=mail-oo2-x0c.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, SPF_HELO_NONE=0.001,
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

Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/freebsd/os-misc.h    | 16 ++++++++++++++++
 bsd-user/freebsd/os-syscall.c |  6 ++++++
 2 files changed, 22 insertions(+)

diff --git a/bsd-user/freebsd/os-misc.h b/bsd-user/freebsd/os-misc.h
index e9f9eed4b4..7e8c29fe84 100644
--- a/bsd-user/freebsd/os-misc.h
+++ b/bsd-user/freebsd/os-misc.h
@@ -9,6 +9,9 @@
 #define OS_MISC_H
 
 #include <sys/cpuset.h>
+#ifdef TARGET_FREEBSD_NR_exterrctl
+#include <sys/exterrvar.h>
+#endif
 #include <sys/random.h>
 #include <sched.h>
 #include <kenv.h>
@@ -541,4 +544,17 @@ static inline abi_long do_freebsd_kenv(abi_long action, abi_ulong name,
     return ret;
 }
 
+#ifdef TARGET_FREEBSD_NR_exterrctl
+static inline abi_long do_freebsd_exterrctl(abi_long op, abi_long flags, abi_long ptr)
+{
+    void *hostptr = 0;
+
+    if (op == EXTERRCTL_ENABLE) {
+        hostptr = g2h_untagged(ptr);
+    }
+
+    return get_errno(exterrctl(op, flags, hostptr));
+}
+#endif
+
 #endif /* OS_MISC_H */
diff --git a/bsd-user/freebsd/os-syscall.c b/bsd-user/freebsd/os-syscall.c
index 38dc87f745..eb510bcab9 100644
--- a/bsd-user/freebsd/os-syscall.c
+++ b/bsd-user/freebsd/os-syscall.c
@@ -1592,6 +1592,12 @@ static abi_long freebsd_syscall(CPUArchState *env, int num, abi_long arg1,
         ret = do_freebsd_kenv(arg1, arg2, arg3, arg4);
         break;
 
+#ifdef TARGET_FREEBSD_NR_exterrctl
+    case TARGET_FREEBSD_NR_exterrctl:
+        ret = do_freebsd_exterrctl(arg1, arg2, arg3);
+        break;
+#endif
+
     /* XXX */
     case TARGET_FREEBSD_NR_cap_rights_limit:
     case TARGET_FREEBSD_NR_cap_ioctls_limit:

-- 
2.55.0


