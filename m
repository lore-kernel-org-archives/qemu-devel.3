Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51EF6E65298
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Feb 2026 00:28:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vmhn2-0005MU-WD; Sun, 01 Feb 2026 19:27:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <razvanghiorghe16@gmail.com>)
 id 1vmhn1-0005KZ-8Z
 for qemu-devel@nongnu.org; Sun, 01 Feb 2026 19:27:39 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <razvanghiorghe16@gmail.com>)
 id 1vmhmz-0006Hy-Ba
 for qemu-devel@nongnu.org; Sun, 01 Feb 2026 19:27:39 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-480706554beso42122695e9.1
 for <qemu-devel@nongnu.org>; Sun, 01 Feb 2026 16:27:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1769992054; x=1770596854; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=p1+LFFgediVqSbtW22vNmZU5Ty82hJ5bagPiF3+If3U=;
 b=bpSzeCyTkQonXNZ1/G6OI0QGJhCSvhmfiuEBSFWCDoOUeYQGIf1wl+VjmrVyZkCpn7
 FHh7+kGw5Ml5g9n0N/+lniDB3cB0VSUahlg+KzqxDMB2Lsa/Ta+E0BKQlz886fQsG3CT
 H+XESPxUmXZYYyFVqCWNQc5HljkhpkSixiyrYqQLqjekBJYi8KtvwZZ+e3eNrSP9y7xb
 cwSQwD7+9NBw/32oT0ew77pzMuVsky/4loXEV1UU7sz6jJ7oDXXjgbYUSNu/AcqsxNcN
 cfSTv2OCbi1yShxrdTBQ6YGFdAm8OLrBh3flHTFZgodHRuImHcfD1BLHXMKLVzsq6qAu
 WyLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769992054; x=1770596854;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=p1+LFFgediVqSbtW22vNmZU5Ty82hJ5bagPiF3+If3U=;
 b=gTB+vzSs8WleOI9m6p+A436/XvTqpB1i7cvZkocmYFcqTMrew9mnA3pBZB5ziZ3pTv
 1ky2dfMJeTzCnS3hqQVe9nHoyF/aAgr6W80GanSq9Y5PkF91rel9A5w3FLqk26ZxbW+R
 15cGk3CRqiLCs+I9nLclAAnaomk4n/hnYmErqFnuo8cygkKLARhJHpJuPMXH9Q7m2erm
 AmJSZdnHT25/a08I7D9gLt1B6RWAO1B3zuNIcKBFGh+EvnyFGApthHV1szyUhzqI5r+Q
 byLBihBuyaXjd3PxZNLM7+JdZG2RWo7ekplwvC3gOf2XxCmEFsY/M9Q7X8aHpuu8hu+G
 UmNw==
X-Gm-Message-State: AOJu0YwH3tpFqAmbd+bQHskzavR3B2my2n+oNs1mBX+SChHwRlxo1Wx5
 nre6eNv1J+bpGasa3rzoB8ZmlnLIRYY3z8HB9sbf/mSEUTXVQWKSBZJj0PPXuA==
X-Gm-Gg: AZuq6aJ+hdN2WTVK/fDqCEi0rleiTyyRpYJEVdKcrYDUVEtKCEGj10OFqpmikMLwoZD
 z8Yqfevh7Hynf+a+Zq497T6rxk/82t3Ko2s+U8wuUtj372tcJkpQWStQc6lQ0zDxlxePKJDEuPC
 RjtmAG0Bd6FFtnhKXwK2TNs1Ecv+8TlHRSMLoxPwfFij2s5+iHKfA6vbNphDbMeTj/ssLmrnj6j
 va5l8MSkKXAclrs033vZlRy8cVr1ZFQOhk5EMN3KMndfmG2GqjqStsoInkUVymYVySzJITFnGYl
 TA9dubvlflkMY9pyHNew8Dc0tyfPwfjdhYm48ETNW0+bn0m/8af5XNrj56DcbpGnLLdGm3AL3Sl
 SyLAZ9xEfMTya3E+hCZFgK9UN4AfBGFpFdgatnncATOOdn4L3weGqUX/xeWQoxfdy9yzfwGmFAs
 AANuhlHrfKj6tIWySdrKKwYNBT4YNc
X-Received: by 2002:a05:600c:474f:b0:47b:de05:aa28 with SMTP id
 5b1f17b1804b1-482db45927bmr139628955e9.2.1769992053660; 
 Sun, 01 Feb 2026 16:27:33 -0800 (PST)
Received: from localhost.localdomain ([92.180.8.65])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48066c40e04sm431791005e9.13.2026.02.01.16.27.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Feb 2026 16:27:33 -0800 (PST)
From: Razvan Ghiorghe <razvanghiorghe16@gmail.com>
To: qemu-devel@nongnu.org,
	laurent@vivier.eu,
	razvanghiorghe16@gmail.com
Subject: [PATCH] linux-user: Fix zero_bss for RX PT_LOAD segments
Date: Mon,  2 Feb 2026 02:24:46 +0200
Message-ID: <20260202002615.27441-1-razvanghiorghe16@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=razvanghiorghe16@gmail.com; helo=mail-wm1-x334.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

zero_bss() incorrectly assumed that any PT_LOAD containing .bss must be
writable, rejecting valid ELF binaries where .bss overlaps the tail of
an RX file-backed page.

Instead of failing, temporarily enable write access on the overlapping
page to zero the fractional bss range, then restore the original page
permissions once initialization is complete.

To validate the correctness of the modified zero_bss() implementation,
two targeted test cases were constructed, designed to exercise the edge cases where
the .bss segment overlaps a partially filled virtual memory page belonging to a
R_X region. The test binaries were intentionally built without a main() function
and instead defined a custom ELF entry-point via the _start symbol.
This approach bypasses CRT, dynamic loader, libc initialization etc. ensuring that
execution begins immediately after QEMU completes ELF loading and memory mapping.

The first binary defines a minimal _start routine and immediately terminates
via a system call, without ever referencing the .bss symbol. Although a .bss section
is present in the ELF, it is not accessed at runtime, and the resulting PT_LOAD
mapping can be established without triggering any writes to a file-backed RX page.
In this configuration, QEMU successfully loads the binary, and the loader reaches
the zero_bss() path, validating that the fractional .bss region is correctly zeroed
without violating the original segment permissions.

The second binary explicitly reads from the global .bss symbol (x) at program entry.
This forces the linker to materialize the .bss region within the same PT_LOAD
segment as the RX code, yielding a segment with p_filesz < p_memsz and flags R|X.
In this case, QEMU correctly fails during the initial file-backed mmap() of the PT_LOAD
segment, returning EINVAL. This behavior is consistent with the Linux kernel’s ELF
loader semantics, which prohibit mapping a file-backed segment as RX when it (logically)
contains writable memory. Consequently, this failure occurs before zero_bss()
is reached (behaviour expected and correct).

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3179
Signed-off-by: Razvan Ghiorghe <razvanghiorghe16@gmail.com>
---
 linux-user/elfload.c | 38 +++++++++++++++++++++++---------------
 1 file changed, 23 insertions(+), 15 deletions(-)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 35471c0c9a..fa3f7cda69 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -449,18 +449,11 @@ static bool zero_bss(abi_ulong start_bss, abi_ulong end_bss,
 {
     abi_ulong align_bss;
 
-    /* We only expect writable bss; the code segment shouldn't need this. */
-    if (!(prot & PROT_WRITE)) {
-        error_setg(errp, "PT_LOAD with non-writable bss");
-        return false;
-    }
-
     align_bss = TARGET_PAGE_ALIGN(start_bss);
     end_bss = TARGET_PAGE_ALIGN(end_bss);
 
     if (start_bss < align_bss) {
         int flags = page_get_flags(start_bss);
-
         if (!(flags & PAGE_RWX)) {
             /*
              * The whole address space of the executable was reserved
@@ -472,20 +465,35 @@ static bool zero_bss(abi_ulong start_bss, abi_ulong end_bss,
              */
             align_bss -= TARGET_PAGE_SIZE;
         } else {
+            abi_ulong start_page_aligned = start_bss & TARGET_PAGE_MASK;
             /*
-             * The start of the bss shares a page with something.
-             * The only thing that we expect is the data section,
-             * which would already be marked writable.
-             * Overlapping the RX code segment seems malformed.
+             * The logical OR between flags and PAGE_WRITE works because
+             * in include/exec/page-protection.h they are defined as PROT_*
+             * values, matching mprotect().
+             * Temporarily enable write access to zero the fractional bss.
+             * target_mprotect() handles TB invalidation if needed.
              */
             if (!(flags & PAGE_WRITE)) {
-                error_setg(errp, "PT_LOAD with bss overlapping "
-                           "non-writable page");
-                return false;
+                if (target_mprotect(start_page_aligned,
+                                    TARGET_PAGE_SIZE,
+                                    prot | PAGE_WRITE) == -1) {
+                    error_setg_errno(errp, errno,
+                                    "Error enabling write access for bss");
+                    return false;
+                }
             }
 
-            /* The page is already mapped and writable. */
+            /* The page is already mapped and now guaranteed writable. */
             memset(g2h_untagged(start_bss), 0, align_bss - start_bss);
+
+            if (!(flags & PAGE_WRITE)) {
+                if (target_mprotect(start_page_aligned,
+                                    TARGET_PAGE_SIZE, prot) == -1) {
+                    error_setg_errno(errp, errno,
+                                    "Error restoring bss first permissions");
+                    return false;
+                }
+            }
         }
     }
 
-- 
2.43.0


