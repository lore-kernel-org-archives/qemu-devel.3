Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAB9AC982CC
	for <qemu-devel@archiver.kernel.org>; Sun, 20 Sep 2026 05:22:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x89zJ-0006Te-UA; Sun, 20 Sep 2026 01:21:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1x89zI-0006TS-C6
 for qemu-devel@nongnu.org; Sun, 20 Sep 2026 01:21:16 -0400
Received: from mail-oo2-x2b.google.com ([2607:f8b0:4864:31::2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1x89zG-0002CM-O4
 for qemu-devel@nongnu.org; Sun, 20 Sep 2026 01:21:16 -0400
Received: by mail-oo2-x2b.google.com with SMTP id
 006d021491bc7-6beed321ad9so1067758eaf.3
 for <qemu-devel@nongnu.org>; Sat, 19 Sep 2026 22:21:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1789881673; x=1790486473;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=UdasQtNoOKc3OZ/6JBvZ09b4OlUon/Olq600+P6JA4I=;
 b=przTrOid5xEiCn16nceMVR/FFkToMQ1fpzuRKz06LUNVbvhjSpZkVsavEprf4H6IDh
 cprOmeL1D7Fj5Dl6JUtsT3x/odxef6qdiAceuzX9TXwPSRFYh0Qt2ycplF5D+UrnD/H7
 FjjMJsEtlAJQV1i9BprjJcLC6HnHqYXWe8P9AinS8dYecLW7Mj4m6V2ERHjR+f3ZKb37
 rVShAmSfqrVdNRFofHz4rTk3Ls/Y4I6xSg6XhqOhXSdnyfI67WNfvdUjRZMtX8bhRhL4
 RCmaL0I1/nc41As6JMO7a7ud73Xdtp37XL6s2j7A3sfo9dD9CfyYxND5qb2vlp32FwSH
 2RIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789881673; x=1790486473;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=UdasQtNoOKc3OZ/6JBvZ09b4OlUon/Olq600+P6JA4I=;
 b=A1afu0K+WsoKvH3h7yaM4JlCuGmRzaMSdt75qMWgdFOHIdaPBpY5KlWC23sNQOXF95
 O72VftdYc/nTBcOuW+P8Rp4FV6JpA1985rV3NtkrHEpqS9cafNx31Oyw7w5ZjfWkpWno
 WoE8/Y3TIUwzBVVxs5gmgXhAKQjfXE7BcuffOHIKP8aBLeVPptg2aen3qDclllYDEwiM
 13+AXTtQmO3U5+YFEbnS9/462kKIcLpChhdTIDvh3aUySTLNisl4LOFC3zjMN/Npe3Em
 x6UAe2d7ASZQQWwjCAUcc4/4hix/Mq3zH5lSBCMYDSL091FK22lmDjiZbcGw+jnJqgmj
 URnw==
X-Gm-Message-State: AFuF++k8udexczAYhs4eUUKgIA/Sww422U2nbvylLi3nvLGP+i/DATvl
 HmXgHjNWvKDJJGAmFgIzGTuhXV+Rlq5qxt+rtsBoMCBark0/Oe2ja/CgJUFPtfOykHAN57WRGVd
 Gq7Gb+i4=
X-Gm-Gg: AYBFou1bbd0WKfonBUiDLvU9HBhQiNwUhuOEWwJT3808g5MilNrPGq3zis++/jlPSEt
 bZSez1l0DYChOHIEPq15SpgovBfWb8istkzjHas8gDMdlnnYIdeHPJdJkjXz8IqPCslL8T8qrd0
 fCObSY4aNfIONPJxV4d20m80dmJmowM07J1I8Ka+0XrifBmMTfZrhiDMy5lmymZCeRy8bpXIpbf
 y5GMJ/6zOcN7k53YQUQHBaUceh/jxnbYVzGI1/Gibk3dWvkzqaWePjvaXYrxg0ASmRDkABb6b5b
 u1aUbsc7UYyaLCixWqQ7K+i7iEd1dd/O6Ns0FAeWLE89qeLQNRATGPrIujjVLPPPWIhyjlIGMjZ
 emC0+8cSLx+kLtdD5tE1qDHrDxrTtKmL9fcBHQAZW3JmGHASlWFksIKgO6uSQd4xWZcOpsP8PTM
 a4ysyJVgoGKofXMTonJCQfPnPQyJDN3RGmEXAFvHTewsU/+bynRGmlHxWhr1AZo5UroSgE
X-Received: by 2002:a05:6820:5712:20b0:6cd:3fcc:96dc with SMTP id
 006d021491bc7-6cd3fdbde23mr2431848eaf.90.1789881673357; 
 Sat, 19 Sep 2026 22:21:13 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-48821db3b4bsm3936865fac.17.2026.09.19.22.21.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 19 Sep 2026 22:21:12 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
Date: Sat, 19 Sep 2026 23:20:46 -0600
Subject: [PATCH 10/14] bsd-user: Implement sigfastblock
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260919-misc-2025q4-v1-10-ebfa61049bd7@bsdimp.com>
References: <20260919-misc-2025q4-v1-0-ebfa61049bd7@bsdimp.com>
In-Reply-To: <20260919-misc-2025q4-v1-0-ebfa61049bd7@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, Warner Losh <imp@bsdimp.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2090; i=imp@bsdimp.com;
 h=from:subject:message-id; bh=cNAuR3F2n8cWD9S7vpgOvRpGhMskF+qLUEBUGWIYaag=;
 b=owEBiQJ2/ZANAwAKAWwc0Sh9sBEAAcsmYgBqr20xC+hVpZKXWxDonVqjjxwdEukb80p3QbHdc
 7hiaudkZ82JAk8EAAEKADkWIQQgNfiUsAqjz3zN4bdsHNEofbARAAUCaq9tMRsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMiwyLDMACgkQbBzRKH2wEQBE8w//dnHyZoM5/bpsVJl5Z9LUYcwc3V+UaN1
 uioVXTiRMx5iBqkm8D5RxpllDN0Mg6KaYOgTh3TKsosrG+rwlRddFaFB6+W21d2VUFEHw8h78A7
 QYVG8aHVn//Rrs+kbI1NXg5h7wuPxG10pn/oAALbngUqDQY/l6Q5WP+FagORDv33iuwRlTRP2ao
 Z20J/0t6R66U5EZrS513lPg2cKgHdqKCmDlZTVQ36u/AAlB2dousBhO/IqL7qxcvJCQdOZf13Ok
 IVQXb5pjUGi45Ug40viZv0Xd/udOwAWqX51kLLyp5RGKJQ88fL32FNPoDIQXiQ2CXtLZgIVYTgs
 CYWSNNyIyKbOyGrkVdE0Mop2QtEpWONN28iIVsNlrA9lVxHzIhenj0Z046eaB3pKFiERQwyi49Y
 AZAxjVxnVS9+9wo4yEocNA91UE2cygBMNmJUEWbjVm73bofbaxBrvqGpeAeVK65POAm92bGkqh1
 w88T0q6H7+joLYIF3ATRWIcT1IrxV3t4KGPukkiERSDateMBhZIhJpGcBUaSL1XubbizIlSocum
 u5BISzGwq55MV7RE/YvtKpfO/QatpIYnVbYEE4JsujebBKYDVTHLmaJ1IhIWYqUgXGzUfPfLQlq
 YY1fsBUMpoHrBu4xUEXrgkm3US7zYnLJSiWhMOOhuDlUR8z+FX7M=
X-Developer-Key: i=imp@bsdimp.com; a=openpgp;
 fpr=2035F894B00AA3CF7CCDE1B76C1CD1287DB01100
Received-SPF: none client-ip=2607:f8b0:4864:31::2b;
 envelope-from=imp@bsdimp.com; helo=mail-oo2-x2b.google.com
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
 bsd-user/freebsd/os-syscall.c |  5 +++++
 bsd-user/freebsd/os-thread.h  | 11 +++++++++++
 2 files changed, 16 insertions(+)

diff --git a/bsd-user/freebsd/os-syscall.c b/bsd-user/freebsd/os-syscall.c
index eb510bcab9..f82fa381ce 100644
--- a/bsd-user/freebsd/os-syscall.c
+++ b/bsd-user/freebsd/os-syscall.c
@@ -97,6 +97,7 @@ safe_syscall3(ssize_t, sendmsg, int, s, const struct msghdr *, msg, int, flags);
 safe_syscall1(int, thr_suspend, struct timespec *, timeout);
 safe_syscall5(int, _umtx_op, void *, obj, int, op, unsigned long, val, void *,
     uaddr, void *, uaddr2);
+safe_syscall2(int, sigfastblock, int, cmd, void *, ptr);
 
 /* used in os-time */
 safe_syscall2(int, nanosleep, const struct timespec *, rqtp, struct timespec *,
@@ -1175,6 +1176,10 @@ static abi_long freebsd_syscall(CPUArchState *env, int num, abi_long arg1,
         ret = do_freebsd__umtx_op(arg1, arg2, arg3, arg4, arg5);
         break;
 
+    case TARGET_FREEBSD_NR_sigfastblock: /* internal */
+        ret = do_freebsd_sigfastblock(arg1, arg2);
+        break;
+
         /*
          * ioctl(2)
          */
diff --git a/bsd-user/freebsd/os-thread.h b/bsd-user/freebsd/os-thread.h
index 6552c60337..dfb22e7cc2 100644
--- a/bsd-user/freebsd/os-thread.h
+++ b/bsd-user/freebsd/os-thread.h
@@ -17,6 +17,7 @@
 
 int safe_thr_suspend(struct timespec *timeout);
 int safe__umtx_op(void *, int, unsigned long, void *, void *);
+int safe_sigfastblock(int, void *);
 
 #if HOST_BIG_ENDIAN == TARGET_BIG_ENDIAN && \
     (TARGET_ABI_BITS == HOST_LONG_BITS || defined(UMTX_OP__32BIT))
@@ -593,4 +594,14 @@ static inline abi_long do_freebsd__umtx_op(abi_ulong obj, int op, abi_ulong val,
     return ret;
 }
 
+static inline abi_long do_freebsd_sigfastblock(abi_long cmd, abi_long ptr)
+{
+    void *hostptr = g2h_untagged(ptr);
+
+    if (hostptr == NULL) {
+        return -TARGET_EFAULT;
+    }
+    return get_errno(safe_sigfastblock(cmd, hostptr));
+}
+
 #endif /* FREEBSD_OS_THREAD_H */

-- 
2.55.0


