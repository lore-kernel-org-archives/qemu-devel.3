Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 046EFC98302
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2026 19:22:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x964B-0000bL-Bu; Tue, 22 Sep 2026 15:22:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1x963e-0000Y6-Jk
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 15:21:40 -0400
Received: from mail-oa2-x0f.google.com ([2607:f8b0:4864:30::f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1x963a-0002OY-U7
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 15:21:36 -0400
Received: by mail-oa2-x0f.google.com with SMTP id
 586e51a60fabf-4906fabf6deso213964fac.1
 for <qemu-devel@nongnu.org>; Tue, 22 Sep 2026 12:21:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1790104894; x=1790709694;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=704xuYPyiwsoafO937XvJT++dS2Ej1acSlls9slbXsg=;
 b=0YW+Ub5drr+es/bFAubeAn1XqrkLawTe5qPPPbUkM8S79oC08Hp6EpBWWPH0dbaeFk
 2WNDR6AzQU4YlbAehHKs4+hxMPimNa6vfEt7sLEtkgbqYPgGwBnvGX07VKRuQBm3x1Kb
 93NeaBCMmYRpBsJf5qcBmJbX4WzQxn1gDe1PL+WI56xs+ntq27AVYfdqdCFPOOIk0/Bs
 DtTlyRwCjAUwP0HDGShwpvKmI05F8Rpn4/IHdFr0XSuekGAq4aMGAsfDfFlZst3SGa2u
 qxAt7MeUvpyk4lFjjcbzblhG4jLxD4zLJt4dwP0hgH29v8GyTN4P8ZE00uWg3u1HsjMY
 iZoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790104894; x=1790709694;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=704xuYPyiwsoafO937XvJT++dS2Ej1acSlls9slbXsg=;
 b=f4+oXiWUMBrkHf5XMp6mxI0ff4SJXS26Mr1uuULNmPli4YRcWa+DaWQs63CYmuWQh8
 oGNBVlHI7DMqfwIc2Sdcvq+PqquZ4IADgcK2edyeOS6BvwAVrrt1dwOUbrsY/luiMMZ5
 p1eP+rnSbqWJtB/joWtRt15qjkEtJOczJSa0dqUBjgMcoAReEPYwXCAfWbDOctbMfT3M
 tQiIhefyjjRvJs5JZ9wxGLecUD2+bug9oxBlBt/jtjKoEYx182hANoIt4bCqQZBtZnHP
 RZDTHIPOiyJeFXYBjnyKBd3XO6s30FUyDNULWPpv4Y62e0SzRua6ZMw9BEIkthPcdqGx
 m2EA==
X-Gm-Message-State: AFuF++kbZpWCJBQxIHo7Xipt54cfyfhr75u5wHkhGZrJyuhpx0IQFfe2
 SNbExkPFDLWDBuzr04/6rH8IND0KPVR3Yvr8cwOcQiPj0qMZSB83HTQADNqozdY2xemHQKA0Jl/
 HJ49lK9w=
X-Gm-Gg: AYBFou2cG2zIIthiHOOWmVB8LmsXbCiMCyQ8QIHD9upCBihWLaCbwcovIayjNtlUbAH
 0+ZI8qa4hfoYzfxfd1RQTYJG2efTRKIreH29lmos7WZsyxxq1U3wcBC5rhfvzURisU74UnqIb5O
 qT9TPHXQA2YyEco8V+KWjlq+LuMgU7pXT532cHW7FH00kEXhXgM0eWWN8WhSfa2fghY0Cqk8xUe
 Jt0S20/rDvxuNGaGzJCEpjsG2E72I1JKAJKIpJ01n296i3HjW6AdxH7eFIAu9p/SG+gjI+gb9SB
 yda83NKC/1waBw7ri0iTKU1e4qpEJm7sRpMPC8V2q/m2BEcyULlWyOrJ8/KkwHLpuCGtqj2RuoD
 n7k2rq4uKtRwTJ+h9LwEX5E9I++zfftwPXQvOq0MuX5slK8n8eft93dipCozxVVVWqQp0adB5eC
 q+fzzltC1Av2uBwgx9SGL3z9x78PwEfP+55f5jnr6iEHTo5Jdxyk70JiinJhVe21ONQpEr
X-Received: by 2002:a05:6820:809:b0:6cd:3fec:de79 with SMTP id
 006d021491bc7-6d2d3702994mr301504eaf.79.1790104893577; 
 Tue, 22 Sep 2026 12:21:33 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6d2ce763f72sm646776eaf.7.2026.09.22.12.21.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Sep 2026 12:21:32 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Warner Losh <imp@bsdimp.com>, Kyle Evans <kevans@freebsd.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 05/11] bsd-user: Fix crazy bug with mmap
Date: Tue, 22 Sep 2026 13:21:03 -0600
Message-ID: <20260922192109.98467-6-imp@bsdimp.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260922192109.98467-1-imp@bsdimp.com>
References: <20260922192109.98467-1-imp@bsdimp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:30::f; envelope-from=imp@bsdimp.com;
 helo=mail-oa2-x0f.google.com
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

So, for some crazy reason, we checked that only the SHARED bit was set
out of all these bits. The only ones that were live was MAP_ANON and
MAP_FIXED. We never called mmap with MAP_FIXED and MAP_SHARED. And the
equivalent from linux-user tested that MAP_ANON was off, but MAP_SHARED
was on. So incorporate the more direct approach from linux-user for
testing this condition. Many of these bits haven't been actually used in
FreeBSD since the very early days....

Also fix MAP_TYPE definition. The 0xf I think was copied from the Linux
headers a long time ago, since BSD doesn't define this. In FreeBSD,
there's only two bits of this low nibble that are used for the sharing
type (linux has 2 more types encoded in these low bits). The kernel
rejects bogus flags (0xc part of 0xf mask), so it's better to have just
these two bits here.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/mmap.c         | 17 +++++++++++------
 bsd-user/syscall_defs.h |  9 ++++++++-
 2 files changed, 19 insertions(+), 7 deletions(-)

diff --git a/bsd-user/mmap.c b/bsd-user/mmap.c
index 548b4824df..5068e5c3b7 100644
--- a/bsd-user/mmap.c
+++ b/bsd-user/mmap.c
@@ -215,11 +215,15 @@ static int mmap_frag(abi_ulong real_start,
 
     prot_new = prot | prot1;
     if (fd != -1) {
-        /* msync() won't work here, so we return an error if write is
-           possible while it is a shared mapping */
-        if ((flags & TARGET_BSD_MAP_FLAGMASK) == MAP_SHARED &&
-            (prot & PROT_WRITE))
+        /*
+         * msync() won't work here, so we return an error if write is
+         * possible while it is a shared mapping
+         */
+        if (!(flags & MAP_ANON)
+            && (flags & MAP_TYPE) == MAP_SHARED
+            && (prot & PROT_WRITE)) {
             return -1;
+        }
 
         /* adjust protection to be able to read */
         if (!(prot1 & PROT_WRITE))
@@ -586,8 +590,9 @@ abi_long target_mmap(abi_ulong start, abi_ulong len, int prot,
              * msync() won't work here, so we return an error if write is
              * possible while it is a shared mapping
              */
-            if ((flags & TARGET_BSD_MAP_FLAGMASK) == MAP_SHARED &&
-                (prot & PROT_WRITE)) {
+            if (!(flags & MAP_ANON)
+                && (flags & MAP_TYPE) == MAP_SHARED
+                && (prot & PROT_WRITE)) {
                 errno = EINVAL;
                 goto fail;
             }
diff --git a/bsd-user/syscall_defs.h b/bsd-user/syscall_defs.h
index 9fa16e0863..c4fd5f5589 100644
--- a/bsd-user/syscall_defs.h
+++ b/bsd-user/syscall_defs.h
@@ -121,7 +121,14 @@ struct target_msgbuf {
 /*
  *  sys/mman.h
  */
-#define TARGET_BSD_MAP_FLAGMASK         0x3ff7
+/*
+ * FreeBSD doesn't define this, but Linux does. In Linux, it's only MAP_PRIVATE
+ * and MAP_SHARED and a few Linux-specific types (0xf). FreeBSD allows other
+ * types of mapping with MAP_ANON, MAP_GUARD, and MAP_STACK. The mask on Linux
+ * excludes these: They don't have MAP_GUARD, and MAP_STACK and MAP_ANON have
+ * similar flags with different names that aren't in it's 0xf MAP_TYPE.
+ */
+#define MAP_TYPE (MAP_PRIVATE | MAP_SHARED)
 
 /*
  * sys/time.h
-- 
2.55.0


