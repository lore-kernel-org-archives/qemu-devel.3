Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86F7DC61DD6
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 13:25:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2TtK-0005XZ-Qi; Fri, 04 Sep 2026 09:23:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x2TtF-0005Tv-IA
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 09:23:33 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x2TtC-0008Hj-Nd
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 09:23:33 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-495590dde14so13881775e9.0
 for <qemu-devel@nongnu.org>; Fri, 04 Sep 2026 06:23:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1788528209; x=1789133009; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=8ZFr5zENPAKypAJEL02dWAYi3o/gkBVQ8dSHQ70VAF4=;
 b=QH5eLU6AT70QXSdM/ECr37vHE50g+cYVmMxoisjEqL8p++fZ8H++HpV9HFu6XD0Waf
 eZWmgSO5kUFvzw7SB57GCQVmhF2nMEP5t0Wv65amt9HtFdqrf8EH2FajcDVATDgAqMKV
 szQ4n+pgVVfgkz/uOYOsjBy9N3xv0b8Nz6GUV0b3i/pcyLOumvxQQpqCGphfAqifZU1s
 wJK8qQ6kwKk17hlS352cV4oZK5YySIHQUdVDHrApgucnKsZonD5mjkYT6N+sTq63Vz7P
 3sIq2QuwwETfYoiSCBtbTRHS7jjvqSXgtdXaa96rGOBNMfxr8gNHZOLiO0kuWMQ9dD27
 6m3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788528209; x=1789133009;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=8ZFr5zENPAKypAJEL02dWAYi3o/gkBVQ8dSHQ70VAF4=;
 b=TJM90ruJWu+X6o1J3Qx0C76AMTDG/TIxqqG8oKIZ5u9tOpCduGV8lXugpSW0xzcpxP
 BWCnI3SBk+vj6eA2ev9t0XNWAIEQcuNwRMowvmePIjaPXrehDv+WEIOxzLgJactlgZLv
 quv46jaOg+9YLMCftzR7aXCRfPATCzikV+9+fL5PTnCoMbHiM8rxDLBOZSUlYEEfUTOL
 A6pqbzbxR1QdEmXclajqGjhHflE9gAusd/WbUKU0A+62aV+kHt9vjIr8OjY1V6qhPylH
 8HZDmUxMMm9A+S+ljVxo9kWDZQ81BzZSP9ydqbQhLNGJ8vUas9bIyEw6/9m6ktux9Fhi
 Dbpw==
X-Gm-Message-State: AFuF++mPFJnW3k4mTAo4bD+MC7LuEQvv1oq6wATa/XQwdPYPpogu/T11
 O+ZtX/eTAV4pUrzYdUhTaiDQQsiDpzbdRgBf5K0cbzsqTwulUIKtvHATVe0bS0PO3bE/EYee2gA
 FFe/GCIM=
X-Gm-Gg: AYBFou1s/+RtFO1Mzvz0UtYfYoZRwW9vHYjWzCI0mUJDV8ArtwCEPqKUuUlX8YnlZk6
 TESeWZXsuTlRvBP0XFxsAcbL6+f/yLAwRsmVGfh5Jn4gQ2MYZqE7wiU6A26W63hiVMANBJS71sp
 oulGZK5LYugkpXL75Ovc9ZojdXQA8rmmOXABtFdnkZV0LYWA41NJbzD9GxvhMpMVCC3H8iDokaO
 FEjwaNzaGh5ao0R0bDUTUu22Q1CRlIA7uARPBBaohWn6KlABwy7fycgkm4IZ49P7Fac96Q/vYla
 KCS6HD9xEq++VANcNkMVyQbOZ7dpRUiQMhpKjNmFv5LgCRcsYmAMCRkqyhq7zMX0kL6GLGcK6Rb
 UHKSD6CtUzGvWcGNow8NEsIpbaoMj3Hilfn23mgT0iDwsctCcjaiblLjZcJGwjr3ge660vJ6bow
 TRBrfaoOe8iXzoimSvjbL0cNK9niphNlcNCSIuGsqIgQzNgSg9BLiLzb8z3/88
X-Received: by 2002:a05:6000:2312:b0:485:8d27:dbe7 with SMTP id
 ffacd0b85a97d-4858d27dccbmr4486169f8f.10.1788528208241; 
 Fri, 04 Sep 2026 06:23:28 -0700 (PDT)
Received: from draig.lan ([185.124.0.156]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4858ab73c2bsm4907379f8f.22.2026.09.04.06.23.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Sep 2026 06:23:27 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id B75216183C;
 Fri, 04 Sep 2026 13:46:07 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Aniket Sahu <asahu1x@linux.ibm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PULL 035/105] tests/tcg/multiarch/gdbstub/prot-none.py: detect if
 /proc/self/mem can be used to access PROT_NONE pages
Date: Fri,  4 Sep 2026 13:44:49 +0100
Message-ID: <20260904124604.2207440-36-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260904124604.2207440-1-alex.bennee@linaro.org>
References: <20260904124604.2207440-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x333.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

Recently (July 2026), this issue became reproducible on debian stable
with kernel (7.1.3) from backports. I suspect it's a default hardening
of kernel related to recent CVEs.

By tracking error reported, we can see that /proc/self/mem pread from
cpu_memory_rw_debug in accel/tcg/user-exec.c returns an error
(Input/Output error).

Detect this situation directly from our gdb python script, by trying the
same thing from current process. If this operation fails, we can
gracefully skip the test.

Tested-by: Aniket Sahu <asahu1x@linux.ibm.com>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Message-ID: <20260827221506.91574-36-pierrick.bouvier@oss.qualcomm.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/tests/tcg/multiarch/gdbstub/prot-none.py b/tests/tcg/multiarch/gdbstub/prot-none.py
index e653bc697f6..e59ba58af86 100644
--- a/tests/tcg/multiarch/gdbstub/prot-none.py
+++ b/tests/tcg/multiarch/gdbstub/prot-none.py
@@ -5,6 +5,8 @@
 SPDX-License-Identifier: GPL-2.0-or-later
 """
 import ctypes
+import ctypes.util
+import mmap
 import os
 from test_gdbstub import gdb_exit, main, report
 
@@ -18,6 +20,36 @@ def probe_proc_self_mem():
     except OSError:
         return False
 
+def probe_proc_self_mem_access_prot_none():
+    libc = ctypes.CDLL(ctypes.util.find_library("c"), use_errno=True)
+    libc.mmap.restype = ctypes.c_void_p
+    libc.mmap.argtypes = [ctypes.c_void_p, ctypes.c_size_t, ctypes.c_int,
+                          ctypes.c_int, ctypes.c_int, ctypes.c_long]
+    size = os.sysconf("SC_PAGESIZE")
+    # mmap a PROT_NONE page
+    PROT_NONE = 0
+    addr = libc.mmap(None, size, PROT_NONE,
+                     mmap.MAP_PRIVATE | mmap.MAP_ANONYMOUS, -1, 0)
+    assert addr != ctypes.c_void_p(-1).value
+    fd = os.open("/proc/self/mem", os.O_RDWR)
+    try:
+        # read it through /proc/self/mem
+        # this is the fallback in cpu_memory_rw_debug
+        data = os.pread(fd, size, addr)
+    except Exception as e:
+        print("/proc/self/mem pread error: " + str(e))
+        return False
+
+    try:
+        # write it through /proc/self/mem
+        # this is the fallback in cpu_memory_rw_debug
+        os.pwrite(fd, data, addr)
+    except Exception as e:
+        print("/proc/self/mem pwrite error: " + str(e))
+        return False
+
+    return True
+
 
 def run_test():
     """Run through the tests one by one"""
@@ -26,10 +58,9 @@ def run_test():
         print("SKIP: /proc/self/mem is not usable")
         print("----------------------------------")
         gdb_exit(77)
-    if "GITLAB_CI" in os.environ:
+    if not probe_proc_self_mem_access_prot_none():
         print("----------------------------------")
-        print("SKIP: fail on gitlab - " +
-              "https://gitlab.com/qemu-project/qemu/-/issues/3329")
+        print("SKIP: /proc/self/mem can't be used to access PROT_NONE page")
         print("----------------------------------")
         gdb_exit(77)
     gdb.Breakpoint("break_here")
-- 
2.47.3


