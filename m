Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CC17E9A03B
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Feb 2026 05:24:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vswVJ-0002tu-4I; Thu, 19 Feb 2026 00:23:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1vswVH-0002qF-BY
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 00:23:07 -0500
Received: from mail-oa1-x33.google.com ([2001:4860:4864:20::33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1vswVF-00025I-P3
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 00:23:07 -0500
Received: by mail-oa1-x33.google.com with SMTP id
 586e51a60fabf-40974bf7781so1198049fac.0
 for <qemu-devel@nongnu.org>; Wed, 18 Feb 2026 21:23:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1771478584; x=1772083384;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=7t1lbj/19tURG7IylL2GT+TzNhn9D96Ws9Y+o1fDcfM=;
 b=aqCqdrfuPFdBDCpqPe3xnWhvy6dz7d+Gwoh4cXzan+yAQEZA+GbMHnwn8KbqR+CwMW
 mjzipF/qNKivtKmx57ZWAfkDgfX36zvsJe+WpSbF+H5ZIMoukvixEf2jfaM4stg8hQXP
 OLHYTxsN8DH7wus1Efj6x9mf1jac7NIRd/V0Wc1gmgGGN7ycnkmiiOA7KbO32uGdxfSi
 fk9V7tR9UAqmB1l13ziOMlO6HGr9uJ2qsqYrN1C7TAnhOwaH6K5HgRxgv1smHLy8YR0a
 2UgIStGwJtOjVGLnrAjzBQbAnieSWHGgD0k6d5dq1m1EB+shK7dLJ9VdKCmeg2qrDJEz
 4KhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771478584; x=1772083384;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=7t1lbj/19tURG7IylL2GT+TzNhn9D96Ws9Y+o1fDcfM=;
 b=CVFARrMYXWWF7hmmuqdbj5I+1gEIWlP1wvXxxDQ1nLxi5wQrhIHaCg1QTMKmXeCPOP
 oofEC40bRPfy60I4cRqllizPbCUCV3TUTdrra5WFhsA9HW4TOehGsxftLAAh7RVe3VT0
 bCibTf0jLIOmLjNCOcb2ktRUi2UHKo9S4XGdaXPSLwVQ5AEccGjPul72or/a0P0HIxwg
 UCarZayW16XCR4z6vWBT2cQBfcUNP8qKQCTWvq9LF3OBPrexmidICwoY1k/5h5nNGyx2
 y06+DR77Z3xwS5tgx1sMKis9cFVhvYjGma7t54F9kKYxSYICl84wQ8I5w0yNQvow1I+G
 fl4w==
X-Gm-Message-State: AOJu0YwMGsgUvvdr1bOExFSVLcPHQk5eNRamfrLAYZeWD5k48J2E2EZO
 7pAhZys4FwzynJb3yJsHf917ehC9i7IHOeDRQ+oHzMsMP3QHbERjojmlxFeYhwW1/Jg=
X-Gm-Gg: AZuq6aLmiWKspakUKY2quO3q0Ddp6lxatfYYKndcgZ3yDYh0LlhwLQ2n8/6w5nTzxdQ
 TURPr+NhCTS3DPYZwIHPY5pHjVaxVsv077IOXrLHyktwR/UkyN7j2QW87VAeixmgQ0QPuy1YehE
 g1nbjPWnJm71g3xjiurD/w9DDIONVZFyQarcEeg2dda1QAv27rdbM5mKNE2hju1zc5CrkvO56Pu
 1vv492o2lN20ORW/+IizzqGYGhBpv7KfqlAbT1EJZqMb6KJKSSlX4mf4OvEBTNi3C6WYFh7uzXf
 YnK18Kn4mkl3Zneh06NYqE3Afw2KI5TzfejMCssS5tfi2WZogzzVW7mjnZjd4iDVh3voaj2PZ22
 S3vSrvQzDVwGvqR1GGmjr8m3Nq7tqWQEYJJyu0Pq4PyTPyX3rDDfD7suYPwrn91+TOhujRX00UW
 Jcw4L6q2bkSQ==
X-Received: by 2002:a05:6820:2207:b0:674:db9f:2e2a with SMTP id
 006d021491bc7-679b1016ed3mr480186eaf.35.1771478584565; 
 Wed, 18 Feb 2026 21:23:04 -0800 (PST)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-674758eb709sm14215326eaf.12.2026.02.18.21.23.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Feb 2026 21:23:03 -0800 (PST)
From: Warner Losh <imp@bsdimp.com>
Date: Wed, 18 Feb 2026 22:22:43 -0700
Subject: [PATCH v3 20/24] bsd-user: Add message queue implementations
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260218-bsd-user-claude-v3-20-0137b37b221e@bsdimp.com>
References: <20260218-bsd-user-claude-v3-0-0137b37b221e@bsdimp.com>
In-Reply-To: <20260218-bsd-user-claude-v3-0-0137b37b221e@bsdimp.com>
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
 h=from:subject:message-id; bh=afl0VBRiyNDawiuJsZs7VyEaZkBdCj8dDbjBLqtmfh0=;
 b=owEBbQKS/ZANAwAKAWwc0Sh9sBEAAcsmYgBplp4s0GsdVCDrbgW9p/Aw1DgwLFVwp3VtmH1Nj
 iw+x/7HGFWJAjMEAAEKAB0WIQQgNfiUsAqjz3zN4bdsHNEofbARAAUCaZaeLAAKCRBsHNEofbAR
 AIFIEACtHPV8dsvuoRYYSL+4hDy/UxYekD9ykKwu/jZLMmAjU6gjboJfyLrHYS7Jy0gmcFHCzLi
 TOEBmSBPIOjU4laiPxOSMn2wRJ+Re/CC7aD4zNXOgntxCEdLtWBL3y7SI/ih7X+YZpMEkOVTJgd
 KG7M6VA06UYP3aWWOFXDHgKq6d/9p9pdZRVeLoNqqD/3HUobwhTtSUAkvueIbLC9NcErFf8dkFV
 VSYmuQFL1rwTyGpMx02A4dQI60bKvorOIvue6ToFljZT/vJl31wrVeejzHDnJ8aN48LT6OvnPzH
 Aom4GuWJSuUJqgJRMbToyLu0s0p/SEixnzLIm9btW6GxGMTUy8ur2ykgiOAtKKdik5viKJGnJBn
 RhHmy8yr+yhjkKzEvIddoB6DxSezaz/A0L1U4oJLFaZhBQBcOB7ulMreXnufadTDsWMPu9Zoytk
 FB1tGgnleFOi7cGss/W+tldmixyj5kRCg2H/8DI9BKMOYgb9zqF1lqnqh0/iEZRJ1wuliFF4Mhh
 M5/rrkAg2Gouv1Ka6eleFonrVLyHT/u1rPbATZeGOYmcI3MQGd2q233yLBntHMgOKTv3tTuBEcd
 OdZLv2wE41vo4FQBa1B8tjzo1Q1y0hFsix9sbkj8z/UjwGuoJ8TytjW05BZQ3eGlf7mjYIRA0+k
 dqHy9oz5YdDxz4g==
X-Developer-Key: i=imp@bsdimp.com; a=openpgp;
 fpr=2035F894B00AA3CF7CCDE1B76C1CD1287DB01100
Received-SPF: none client-ip=2001:4860:4864:20::33;
 envelope-from=imp@bsdimp.com; helo=mail-oa1-x33.google.com
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
index 9837b9654c..fa8041fadc 100644
--- a/bsd-user/bsd-misc.h
+++ b/bsd-user/bsd-misc.h
@@ -17,6 +17,8 @@
 
 #include "qemu-bsd.h"
 
+static int bsd_msgmax;
+
 /* quotactl(2) */
 static inline abi_long do_bsd_quotactl(abi_ulong path, abi_long cmd,
         __unused abi_ulong target_addr)
@@ -262,6 +264,101 @@ static inline abi_long do_bsd_msgctl(int msgid, int target_cmd, abi_long ptr)
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


