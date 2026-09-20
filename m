Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDB0EC982CC
	for <qemu-devel@archiver.kernel.org>; Sun, 20 Sep 2026 05:22:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x89z8-0006QO-V8; Sun, 20 Sep 2026 01:21:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1x89z6-0006Pr-HV
 for qemu-devel@nongnu.org; Sun, 20 Sep 2026 01:21:04 -0400
Received: from mail-oa2-x10.google.com ([2607:f8b0:4864:30::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1x89z4-0002Ak-NE
 for qemu-devel@nongnu.org; Sun, 20 Sep 2026 01:21:04 -0400
Received: by mail-oa2-x10.google.com with SMTP id
 586e51a60fabf-466cc9b2f1dso1272869fac.0
 for <qemu-devel@nongnu.org>; Sat, 19 Sep 2026 22:21:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1789881661; x=1790486461;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Y4s15zV/+JO91jM9fuwDSCSTQoCNaCwG+JfJ8pyW33s=;
 b=yT8vwooo7CYlTinZAy4RvQFA+XPvcQNWlAToUPbIbbwHv9hJWNtFOxIOId8IF2y2+w
 L6OJyL7Upd9zZ3ygydBXahJrq2mHOWZy5ybNaGM6C1sPi8fm4sbJKQuvcQ0rQ1/yVAWw
 ZBIYGu6r71ngR+wYnc4e+scc+BF20wUXy+yHc1DexUjMR3YiAy8l4dNtyZlghgducIs7
 9Xw+fiqy/T9QP9qVRl7+L2SiVAh0Tkr0593sqaBOxif+yVH4fztsXCC9bWp/6VRar7BM
 Ak4BNtjQgwgcxX0W2DQ31CVIBg3UxKsg2y8sgntMRERZ9U6OcuV2w8WQsJXxFDCXnXZ1
 8GEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789881661; x=1790486461;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Y4s15zV/+JO91jM9fuwDSCSTQoCNaCwG+JfJ8pyW33s=;
 b=dQYqPiv9LPeK8Bo72SVQr9EQWCGu39eiFg5ns+xmaSKSLByPKHz3UB6B3c9VTFeXYi
 kAnCYhzXvD2fjcqlAgBKJBlZRix1q4SgXfgcvtn7OqXb2XbgIN77je8pfQiE3cVsjrNF
 FeUjZedUVKL6j/6VgzHCRF/v+XqnTHAQ0wNRD36gwzhuuQXOa/qHgendoPznh719xF3E
 B4cjDQ1kjCST5bXJDTAb18f0jkekNr/efvyZWiS9yRZt5sHTejxPDPM0FMmnxt9+HKsx
 HFQxa7VGVBW0SM1ns1VJR4VyM14a19Cd7bIp3DXOadnzBfFsmcp+j1hwVEfvUBF50NzB
 EUCw==
X-Gm-Message-State: AFuF++mzZB95CxbehCY65x8McTTaz2KgHkPTj0yGZB5U6QmkQpe7+qLD
 7jJ44E9I4t56+C1cZ1lyNX75N2+pJRa/syhGDacoe8wZa08RSwLNVxB2pFELeYFsB9U=
X-Gm-Gg: AYBFou152LJd5g1ZXkEbuNLF8MgDUQ0eVcipi2XgSycLgLPEfmOzTRcZzFcNSaQHmHb
 nzcT+Kxxb6oQ2+qM1TjvQWwPf2AIUKuBPAF/Cd8lRvOU8BQ6oKsNVHK0o0XnHpCiburbPl1q88X
 nfiQq7c1+zjnQwc9HIETpUxHN7bXljMAGJvuV3EmG+YI2QdSIuJQlgayQbD4kranHLf7Or7WSvN
 6uSpBKV61V+PInnVpQvrt9Rg2d9/hvnz7sE2EkAnC5L6dk39potru8ttY5Nv5Conc+5QVDsqGZ0
 N1/KWYjwZRF8MCYrxX/DK5ea+IoZwQjD+IKOZBhtdLaNFRWZxdmuJEYwxn52eT1Fx6YZY6noE9M
 uIcdbV7lTfw09gKuorieUwySpyh24xEYQl2uEh4F2FQqk/Q18DNmh6Ltis1RqJsRYDygvSRWXDJ
 046nN4PrCCVwnwxmK56xHZTehOZj3km/qOW0r6zdqabqHSTwNoMlLgvZCPANA=
X-Received: by 2002:a05:6870:37d0:b0:470:e96b:43e4 with SMTP id
 586e51a60fabf-486defc6f16mr6216581fac.16.1789881661440; 
 Sat, 19 Sep 2026 22:21:01 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-48821db3b4bsm3936865fac.17.2026.09.19.22.20.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 19 Sep 2026 22:21:00 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
Date: Sat, 19 Sep 2026 23:20:37 -0600
Subject: [PATCH 01/14] bsd-user: HOST_BIG_ENDIAN and TARGET_BIG_ENDIAN are
 always
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260919-misc-2025q4-v1-1-ebfa61049bd7@bsdimp.com>
References: <20260919-misc-2025q4-v1-0-ebfa61049bd7@bsdimp.com>
In-Reply-To: <20260919-misc-2025q4-v1-0-ebfa61049bd7@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, Warner Losh <imp@bsdimp.com>, 
 Rick Richard <rick@sloservers.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2092; i=imp@bsdimp.com;
 h=from:subject:message-id; bh=Cm5gcTZaB3Gq79rKYmURf5LcdRNQnr/YYVjeItEOB3s=;
 b=owEBiQJ2/ZANAwAKAWwc0Sh9sBEAAcsmYgBqr20wYDvo3raUbzwRVYUDQ+lS/LixZ2N9RwmTj
 d5abwDUWIuJAk8EAAEKADkWIQQgNfiUsAqjz3zN4bdsHNEofbARAAUCaq9tMBsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMiwyLDMACgkQbBzRKH2wEQBimA/+PAyqcfUGo6E8H3frMyxGYFkYLFpHQ/B
 nSiwPJPV4tfnRfYrTAOBPAilxgmqy1sgQTaajYD785dCtqI4fKIMxYx9AdOezHVAUQPDLhS/QrB
 5dMMQQ6fsYEiZE82RNOp1E+DnYPdR25eNu03KOTwqNKlXTeKAHQdKOGs8QCqEVIwUQe0KjuMfBM
 CkCMEzuux5HebyLbBrWrkxwe73wHvdx2/kjjhPEeUc/KxW75hW3RtNM4Q1TIFuuFu9/57vmqLDV
 ZLH6dDkJBBGoZZATUnip8kWFfNMHi9DXAhBA4QU9PCgb/5Ah5F9RjQUg8Nj3zJrhuasrhRdgRZx
 W2SPmrcABYVY8ekRueLcPLvT2AxbFPE/1GMge5PDayt7MGXxWPOTfpf4eYVL16rIIeRUr+DqsIp
 kdS5Ql7GgsBrwSeYHJdyWVeUqC1U0DBitrXHvKSY+fqvCHWMoY8IP9NfkML4sKb+QmuYJ3qSP/7
 uN8lmaGxFtKBuj/WJrYhKeQs1hX5S2ebubcHIEwa2yiKvTzEvl2JrC2cev24MILNaWPYLpuyvEh
 rp0pp1612UqltTqiIkqjbyFpB9qfxn2Odu1y6tiJ5nhlcHQQrRe6t/KhyWvuRvdH41+5KjcGCn6
 fDrt81vu66S3v3jRYx7Ei/eY3SujTgVIssAxMptlzFVNySuY90gM=
X-Developer-Key: i=imp@bsdimp.com; a=openpgp;
 fpr=2035F894B00AA3CF7CCDE1B76C1CD1287DB01100
Received-SPF: none client-ip=2607:f8b0:4864:30::10;
 envelope-from=imp@bsdimp.com; helo=mail-oa2-x10.google.com
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

From: Rick Richard <rick@sloservers.com>

TARGET_BIG_ENDIAN and HOST_BIG_ENDIAN are always defined.

lseek and target_offset64() transpose upper and lower halves
on 32-bit ABIs, -strace prints wrong off_t.

Signed-off-by: Rick Richard <rick@sloservers.com>
[ fixed defined() too ]
Reviewed-by: Warner Losh <imp@bsdimp.com>
Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/bsd-file.h          | 2 +-
 bsd-user/freebsd/os-misc.h   | 2 +-
 bsd-user/freebsd/os-thread.h | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/bsd-user/bsd-file.h b/bsd-user/bsd-file.h
index 0fefc07232..a2c2e38e50 100644
--- a/bsd-user/bsd-file.h
+++ b/bsd-user/bsd-file.h
@@ -986,7 +986,7 @@ static abi_long do_bsd_lseek(CPUArchState *env, abi_long arg1, abi_long arg2,
         ret = get_errno(res);
         set_second_rval(env, 0xFFFFFFFF);
     } else {
-#ifdef TARGET_BIG_ENDIAN
+#if TARGET_BIG_ENDIAN
         ret = ((res >> 32) & 0xFFFFFFFF);
         set_second_rval(env, res & 0xFFFFFFFF);
 #else
diff --git a/bsd-user/freebsd/os-misc.h b/bsd-user/freebsd/os-misc.h
index 0f87b21cc8..e9f9eed4b4 100644
--- a/bsd-user/freebsd/os-misc.h
+++ b/bsd-user/freebsd/os-misc.h
@@ -336,7 +336,7 @@ static inline abi_long do_freebsd_kldsym(abi_long fileid, abi_long cmd,
 #if TARGET_ABI_BITS == 32
 static inline uint64_t target_offset64(uint32_t word0, uint32_t word1)
 {
-#ifdef TARGET_BIG_ENDIAN
+#if TARGET_BIG_ENDIAN
     return ((uint64_t)word0 << 32) | word1;
 #else
     return ((uint64_t)word1 << 32) | word0;
diff --git a/bsd-user/freebsd/os-thread.h b/bsd-user/freebsd/os-thread.h
index 4258b24095..6552c60337 100644
--- a/bsd-user/freebsd/os-thread.h
+++ b/bsd-user/freebsd/os-thread.h
@@ -18,7 +18,7 @@
 int safe_thr_suspend(struct timespec *timeout);
 int safe__umtx_op(void *, int, unsigned long, void *, void *);
 
-#if defined(HOST_BIG_ENDIAN) == defined(TARGET_BIG_ENDIAN) && \
+#if HOST_BIG_ENDIAN == TARGET_BIG_ENDIAN && \
     (TARGET_ABI_BITS == HOST_LONG_BITS || defined(UMTX_OP__32BIT))
 #define _UMTX_OPTIMIZED
 #if defined(TARGET_ABI32)

-- 
2.55.0


