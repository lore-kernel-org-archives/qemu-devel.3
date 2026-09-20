Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B176DC982D0
	for <qemu-devel@archiver.kernel.org>; Sun, 20 Sep 2026 05:21:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x89zF-0006Si-Q1; Sun, 20 Sep 2026 01:21:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1x89zC-0006Rg-Pc
 for qemu-devel@nongnu.org; Sun, 20 Sep 2026 01:21:10 -0400
Received: from mail-oa2-x17.google.com ([2607:f8b0:4864:30::17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1x89zB-0002Bc-7s
 for qemu-devel@nongnu.org; Sun, 20 Sep 2026 01:21:10 -0400
Received: by mail-oa2-x17.google.com with SMTP id
 586e51a60fabf-47bc923fe6aso1503815fac.3
 for <qemu-devel@nongnu.org>; Sat, 19 Sep 2026 22:21:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1789881668; x=1790486468;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=eKoOczTx/GrJqhRZH+vapGFj7+X2g4mqcYzMG7VH2fY=;
 b=ySayaiiwFkk7Q4BjmDofDcaTq+m396KbMrh2FkjZCgt7I0JNa/ytfZoTp8oOeUXAih
 cOilnxqSqzxQOlrNDNn1FXhGFlMRv5LMtNQTbjUQAmf8Z7DOcrRPcNjC5+8OfLD8UL7S
 jQQTgHuBHi7+ZnKCwd1AOuziKlbxOyhlRA6pM5rFfeH94+cdFQz3CG2nFA7arzIbHXJc
 Kb6/2GTp0yf7KfT265aG5IzeWAzWcDfZgKgf1y5CZncYxGsRuqm5t88WtE6B5DL6NGax
 jgwgoI5VPuoLFb0SXD+0qaEm6773TOVzfW7mvwrk8DkoKAQRte6LKsTIHeT98l34BxQ8
 +BdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789881668; x=1790486468;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=eKoOczTx/GrJqhRZH+vapGFj7+X2g4mqcYzMG7VH2fY=;
 b=yormO0F1ixrnOXYjUFPWchxQGlWkfB/AhPq5HdE9Ni1RbKSFbUaxjuYcs/eYGfWx4m
 hvrw5+Kip2236mBMkpwJoDLd7OuSOU7WCxyjHlHPC0rQhWAfXbYoFRMGf2irP7V6dvF0
 yf3wfIt/hOVQMvnlJpthsZhOGJ6UYumyPQfAAB0pCmcMWtpoX104TcGWlcQe3v4pdhxW
 d4b8Ga0ySHA0TwgRdDdPUOSuKr8UeeqUwTFSA0n0CH3VRQJwEYPDEgMbjnX01dmZWupE
 34Z/G4+qOwmcB1jBjb5kMDD9Vgq8ME8HqrOrYHcdgHXq7RcEUtBttYDIELrBdR7OJXe+
 QZQw==
X-Gm-Message-State: AFuF++nfffh8G3PIU5ORukJ8Zwh/PE5SMbeX48YNSF7qUI5m1yQHPDoJ
 A5/SVZhnaAA+b5LyRZQ+ewyJNDgA7ao6e6mTyas7z3kqjEKIEodz7ZGIX9s4A9cfqys=
X-Gm-Gg: AYBFou3fkSdbQBWyqVxvP2Z3EBCaNREqC+earkxEecU91ippVubsO5GP2/3UP85pAaE
 EQ6XZVLUvKeFsiUkNCrzNGPPn69eo71zTHurAIssuOLT/JaEje63xpf5oMOS7msNB4QrRyAMLkd
 hqAVjsUDJi9dXH97AWEs2E+dZ+I9lsFb50CBJWXeQJlhsupOonWY67Ki2sQCGs6D1fU1Y8R0Ih7
 kPZQYO1vTDpZElEdiHdPHBPk6LbH0+NoxFApjhJyEqEsRzb/Nzkm6n1bNzjMyiGqOMmSS9QnBW8
 HR6XGca4ERCBRWBsH3OySTG6yrE64GWCJKn751iqvaOY+1Rr76KMtNmGlznYiUEHMZTNm+7suUQ
 pGAw2m/dd+WNv7ni+FzStB2mkEqi3nrKlou2wkEyllDQBlSJFIFRp/yLIRgdLg7wp50J4oaFVuw
 9sq3ZZU2/quye0iLcny4VhxgXz7jY1QABa6OHq1fy+Ouh/SO51CngN1w5xHg==
X-Received: by 2002:a05:6870:212:b0:469:fb51:b351 with SMTP id
 586e51a60fabf-486e6392be7mr6828712fac.17.1789881668116; 
 Sat, 19 Sep 2026 22:21:08 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-48821db3b4bsm3936865fac.17.2026.09.19.22.21.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 19 Sep 2026 22:21:07 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
Date: Sat, 19 Sep 2026 23:20:42 -0600
Subject: [PATCH 06/14] bsd-user: Fix crazy bug with mmap
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260919-misc-2025q4-v1-6-ebfa61049bd7@bsdimp.com>
References: <20260919-misc-2025q4-v1-0-ebfa61049bd7@bsdimp.com>
In-Reply-To: <20260919-misc-2025q4-v1-0-ebfa61049bd7@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, Warner Losh <imp@bsdimp.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2416; i=imp@bsdimp.com;
 h=from:subject:message-id; bh=pLQUpu/k5A2SSgAi+2VpiqxQtxTxHRs0T2cFe2WQH2Q=;
 b=owEBiQJ2/ZANAwAKAWwc0Sh9sBEAAcsmYgBqr20wZzl60+0ybg1x627gULZT+7x800ngQw1sJ
 i1jY70kYSGJAk8EAAEKADkWIQQgNfiUsAqjz3zN4bdsHNEofbARAAUCaq9tMBsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMiwyLDMACgkQbBzRKH2wEQAHoA//VORamT2fXWo856Ma6pOWvxMndUJ9TF9
 E8TxUE96HZ9dTa7l3SHB+rtmHjdQX1Inyfe9iVj2MW5ud1fdhDjLs/SogvmgCg55AMrAte6aczE
 j/1ZHVly9oStijrT8nVc368cYvx2B1iuE+UWujWLC063maNg6es7HTLSF+mZcA/XF9FUmo+/KUA
 q8zoAp7MTXo5ejCqEXkuM+6SzDS9r7LgR/4CKjWk91jEIVPUpGiO6fk7xFao5IjeRGPOr90JJty
 slV4wM/XgI2sDp75KgX3HUqT/Zi/4oh/31NoGiOUuNB9PQLQ8WCGR6DpDwdGM0aszx9KV4PedDS
 99Iya4YBmWuVSDmrit+7Ga8tqgTtjkm4/8YjFRoxOLcE3EzNXkg1GCGvf2S6g05JuhhqLM6haGz
 fD3rI7ELaTwPhmeGZB1LZ48MFLHqgGy16fZpk00znB2Z52e8271qXgDTktfbx9yIy4TBMzJyOVO
 eF4myx+arxkNg/YiV9SMv1TcHKAq+e1b2p/8XgT9zU00jrZpYErvkVt4PifbHSjldc7uXEWc7M8
 jvJnbDnmbvi5llh7WjUp1kgdDRfxR+hBfO4P/hDIr0/YrAkJoZvzcnvQfeoZsS7L5eKl+tnk91j
 XJLjJfYNkeAul8HjtK5+riiM5bhESjo3G46XO8qzaGb5yxXBuhSs=
X-Developer-Key: i=imp@bsdimp.com; a=openpgp;
 fpr=2035F894B00AA3CF7CCDE1B76C1CD1287DB01100
Received-SPF: none client-ip=2607:f8b0:4864:30::17;
 envelope-from=imp@bsdimp.com; helo=mail-oa2-x17.google.com
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

Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/mmap.c         | 16 ++++++++++------
 bsd-user/syscall_defs.h |  2 +-
 2 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/bsd-user/mmap.c b/bsd-user/mmap.c
index 548b4824df..76ac0340cb 100644
--- a/bsd-user/mmap.c
+++ b/bsd-user/mmap.c
@@ -215,10 +215,13 @@ static int mmap_frag(abi_ulong real_start,
 
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
+            && (prot & PROT_WRITE))
             return -1;
 
         /* adjust protection to be able to read */
@@ -586,8 +589,9 @@ abi_long target_mmap(abi_ulong start, abi_ulong len, int prot,
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
index 9fa16e0863..506aea3e27 100644
--- a/bsd-user/syscall_defs.h
+++ b/bsd-user/syscall_defs.h
@@ -121,7 +121,7 @@ struct target_msgbuf {
 /*
  *  sys/mman.h
  */
-#define TARGET_BSD_MAP_FLAGMASK         0x3ff7
+#define MAP_TYPE                        0xf
 
 /*
  * sys/time.h

-- 
2.55.0


