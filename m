Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91F62CD5BC8
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2026 20:04:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRxzN-0004fX-Ro; Tue, 26 May 2026 16:02:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>)
 id 1wRxzD-0004aQ-AR; Tue, 26 May 2026 16:02:48 -0400
Received: from tor.source.kernel.org ([172.105.4.254])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>)
 id 1wRxzB-0002uj-2X; Tue, 26 May 2026 16:02:46 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 85345600BB;
 Tue, 26 May 2026 20:02:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EF7D1F00A3A;
 Tue, 26 May 2026 20:02:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1779825763;
 bh=RzAg/z9ESTOIfX4D/3KjFmD6FehyVHYLgvenUfGbwos=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=bFVSGT0p3vp1zsu57dh1SnVsbg3pitv8OorYKKedhy0uyuJnAHrom2cCtWbbCaSyp
 T/eLNOdnQAYfcRCQyxfy48pPoiPzzYEChHgi8Q8mnLgPfCFY5tCL7gKIGpLiHNSntn
 FizcZ97uvORQGWlfYJYvfGqqEBIEF2GKkeTlyCQYLmGjrJyz02wl1Hy9icCcDcDGtF
 4igvePFvYumLl08JP6rWYNcC3PcUip19OmhE1YsQqmwf+vtF9sKUxG123TQBIDX/0+
 f0vQ1H2KZTuQ1WW/YrUnIaNee6AlT/AuFgrPoulxk2fK2iRPteyQh+2E+9zVEeGRr2
 XTEgVegP/xLzQ==
From: Helge Deller <deller@kernel.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 qemu-s390x@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Eric Farman <farman@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>, Helge Deller <deller@gmx.de>,
 Aleksandar Rikalo <arikalo@gmail.com>,
 David Hildenbrand <david@kernel.org>, Laurent Vivier <laurent@vivier.eu>,
 Cornelia Huck <cohuck@redhat.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Yoshinori Sato <yoshinori.sato@nifty.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Aurelien Jarno <aurelien@aurel32.net>
Subject: [PULL 08/12] linux-user: Implement finer grained madivse() syscall
Date: Tue, 26 May 2026 22:02:03 +0200
Message-ID: <20260526200207.79738-9-deller@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260526200207.79738-1-deller@kernel.org>
References: <20260526200207.79738-1-deller@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=172.105.4.254; envelope-from=deller@kernel.org;
 helo=tor.source.kernel.org
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Helge Deller <deller@gmx.de>

Although most madvise() values are hints, some are important and are
checked by userspace, especially by security-relevant applications like
BoringSLL.  So, return -EINVAL for those functions which we don't emulate.

Signed-off-by: Helge Deller <deller@gmx.de>
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3489
---
 linux-user/mmap.c | 32 +++++++++++++++++++++++++++++++-
 1 file changed, 31 insertions(+), 1 deletion(-)

diff --git a/linux-user/mmap.c b/linux-user/mmap.c
index b4b7b3e5cc..50916c29a5 100644
--- a/linux-user/mmap.c
+++ b/linux-user/mmap.c
@@ -1282,7 +1282,7 @@ abi_long target_madvise(abi_ulong start, abi_ulong len_in, int advice)
     case TARGET_MADV_KEEPONFORK:    /* parisc */
         advice = MADV_KEEPONFORK;
         break;
-    /* we do not care about the other MADV_xxx values yet */
+    /* all other MADV_xxx values are the same across architectures */
     }
 
     /*
@@ -1307,6 +1307,19 @@ abi_long target_madvise(abi_ulong start, abi_ulong len_in, int advice)
      */
     mmap_lock();
     switch (advice) {
+    case MADV_NORMAL:
+    case MADV_RANDOM:
+    case MADV_SEQUENTIAL:
+    case MADV_WILLNEED:
+    case MADV_DOFORK:
+    case MADV_FREE:
+    case MADV_COLD:
+    case MADV_PAGEOUT:
+        ret = 0; /* OK */
+        break;
+    case MADV_REMOVE:
+        ret = -EOPNOTSUPP;
+        break;
     case MADV_DONTDUMP:
         page_set_flags(start, start + len - 1, PAGE_DONTDUMP, 0);
         break;
@@ -1324,6 +1337,23 @@ abi_long target_madvise(abi_ulong start, abi_ulong len_in, int advice)
                 page_reset_target_data(start, start + len - 1);
             }
         }
+        break;
+    case MADV_DONTFORK:
+    case MADV_MERGEABLE:
+    case MADV_UNMERGEABLE:
+    case MADV_HWPOISON:
+    case MADV_HUGEPAGE:
+    case MADV_NOHUGEPAGE:
+    case MADV_COLLAPSE:
+    case MADV_POPULATE_READ:
+    case MADV_POPULATE_WRITE:
+    case -1:    /* BoringSSL uses -1 to check if the environment is broken */
+        ret = -EINVAL;
+        break;
+    default:
+        qemu_log_mask(LOG_UNIMP, "Unhandled madvise(%d) call.\n", advice);
+        ret = -EINVAL; /* not yet known advise */
+        break;
     }
     mmap_unlock();
 
-- 
2.54.0


