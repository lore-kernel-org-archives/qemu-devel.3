Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BA8ACA0EE6
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Aug 2025 17:15:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1umbWC-0008LE-Jw; Thu, 14 Aug 2025 13:13:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1umbWB-0008Kv-Co
 for qemu-devel@nongnu.org; Thu, 14 Aug 2025 13:13:35 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1umbW6-0001no-Ql
 for qemu-devel@nongnu.org; Thu, 14 Aug 2025 13:13:35 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-45a1b0becf5so5666335e9.2
 for <qemu-devel@nongnu.org>; Thu, 14 Aug 2025 10:13:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1755191606; x=1755796406; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Qddu1LKlEVM418ztePcYYkApchal3wbvTLvSqsnx7wU=;
 b=O4eY4d6YPzc85Tm0s2mSiceiZtk/fiFw1dxx9aua1Ah/VYydt85BejHpItJ/EyPaUw
 7al4IX7t9HSIQJnbALP8XtXFk3PqG24CWoSbpanK6JQR42w/huRE2hi5CUu9lL+0C1p0
 jwYNhaaZ3TdEdPy2r/WRedwL7cNHGmUzEEbyUEvQAtr4YGbVb9I+wXOBxEAXfN37e7q2
 SQ4iUU7sOIKT6kU2vEM8LicB9YTqP8nn6VbnaLlWyO1f85f+on7lPF6dK2rc+ktIwOe2
 RhQr+aMSGKO6lkh9BNZBXvfTAKSBmmR+egkXUG0m3cfcqyCPLixhhEoib7U6MFyHdE92
 5QFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755191606; x=1755796406;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Qddu1LKlEVM418ztePcYYkApchal3wbvTLvSqsnx7wU=;
 b=LWPUzycATUdi1DgS5qR2Cw/ZZO4wgCOpB8vNCVKb5LJzX1PJHgQWZoxYojU33/T8LR
 PewnW4EKFncYCnPp3+A3ZadVBqYApmYpQ4UymOq5UPOw+H7HY3gUCibEQMNo2D9oDxbK
 DvrakWTmbEJ4mypmJhjyDvj3ke5eRPOlYJysci9oWCPI34OPM4OnXPiSHyc8rWBMig9/
 rceqX08V3QPbAi59Q3W3IZMIwKAez4/fp0rTOY6O0kFmuR8hAgi1KdscFpY+tGiGg2hi
 G8bMgefE1OZMfapWm+K9MtoCbtNKiTkXeAXdNh/aRk3fzu/pf2wJGrBBV8By+DmG5dhp
 t4Fg==
X-Gm-Message-State: AOJu0Yx4yK1log2HWQKFjymzX8j5MyJzBnPflwCK3Y9jtLPZ/wLdrFkk
 eEMIaxbiEdI3kwBmblA6bCauNX8SxZHSUddYc0L6SoFke7NsGnJokvrD6NiFd4U7gGzRJnok7Bz
 U6u5I
X-Gm-Gg: ASbGncuERYmzugeIpHDa7yTlh0/AlF4vJX+DjYYgDO/5u0N0+u/j0gqB5kZBjHAAzir
 w61NIdW7Ko228d2gNejvcfvtcmyj4St76WkVAc64OWK3lntCkQbGSy0y1ddkZami074JS2ehlvG
 MvgNVBqihwBWB8QIZchd8ETvvVahShJiC30gqVhGOOWMzCX58yFS2ci4qBNqEGHdNINreyTFr/o
 7VbEkLaPGY9I7TGedmZgVhO6OC6Rk+rF1dtjx31ho8+9Fuco9z9SUTTlCca4vTa3VxPNp6uFzGc
 YKecvcj3LNuQZVGQjDwIEN4QbsjVV/qZ8RRL/DTf+yszYqWiMXaA5gDcCCUiCqFtDSd/MbEl64X
 adY+LjVFrHnF8F532Ft+ltc6H+jfu
X-Google-Smtp-Source: AGHT+IFdJ7xiyROoUBnhQQoVHI8mYgN7rTvAKdSNIBL1ahO5K02mYf4NDq/d09LnI+2TJZZz5ugPIA==
X-Received: by 2002:a05:600c:4746:b0:459:e025:8c5a with SMTP id
 5b1f17b1804b1-45a1b688350mr25942815e9.33.1755191606280; 
 Thu, 14 Aug 2025 10:13:26 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45a1c76e9basm29489165e9.21.2025.08.14.10.13.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Aug 2025 10:13:25 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	John Snow <jsnow@redhat.com>
Subject: [PATCH for-10.2 0/8] docs: Update our kernel-doc script to the
 kernel's new Python one
Date: Thu, 14 Aug 2025 18:13:15 +0100
Message-ID: <20250814171324.1614516-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x333.google.com
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
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Earlier this year, the Linux kernel's kernel-doc script was rewritten
from the old Perl version into a shiny and hopefully more maintainable
Python version. This commit series updates our copy of this script
to the latest kernel version. I have tested it by comparing the
generated HTML documentation and checking that there are no
unexpected changes.

Luckily we are carrying very few local modifications to the Perl
script, so this is fairly straightforward. The structure of the
patchset is:
 * a minor update to the kerneldoc.py Sphinx extension so it
   will work with both old and new kernel-doc script output
 * a fix to a doc comment markup error that I noticed while comparing
   the HTML output from the two versions of the script
 * import the new Python script, unmodified from the kernel's version
   (conveniently the kernel calls it kernel-doc.py, so it doesn't
   clash with the existing script)
 * make the changes to that library code that correspond to the
   two local QEMU-specific changes we carry
 * tell sphinx to use the Python version
 * delete the Perl script (I have put a diff of our local mods
   to the Perl script in the commit message of this commit, for
   posterity)

The diffstat looks big, but almost all of it is "import the
kernel's new script that we trust and don't need to review in
detail" and "delete the old script".

My immediate motivation for doing this update is that I noticed
that the submitter of https://gitlab.com/qemu-project/qemu/-/issues/3077
is using a Perl that complains about a construct in the perl script,
which prompted me to check if the kernel folks had already fixed
it, which it turned out that they had, by rewriting the whole thing :-)
More generally, if we don't do this update, then we're effectively
going to drift down the same path we did with checkpatch.pl, where
we have our own version that diverges from the kernel's version
and we have to maintain it ourselves.

We should also update the Sphinx plugin itself (i.e.
docs/sphinx/kerneldoc.py), but because I did not need to do
that to update the main kernel-doc script, I have left that as
a separate todo item.

Testing
-------

I looked at the HTML output of the old kernel-doc script versus the
new one, using the following diff command which mechanically excludes
a couple of "same minor change" everywhere diffs, and eyeballing the
resulting ~150 lines of diff.

diff -w  -I '^<div class="kernelindent docutils container">$' -I '^</div>$' -I '^<p><strong>Definition</strong>' -r -u -x searchindex.js build/x86/docs-old-kerneldoc/manual build/x86/docs/manual

The HTML changes are:

(1) some paras now have ID tags, eg:
-<p><strong>Functions operating on arrays of bits</strong></p>
+<p id="functions-operating-on-arrays-of-bits"><strong>Functions operating on arrays of bits</strong></p>

(2) Some extra named <div>s, eg:
+<div class="kernelindent docutils container">
 <p><strong>Parameters</strong></p>
 <dl class="simple">
 <dt><code class="docutils literal notranslate"><span class="pre">long</span> <span class="pre">nr</span></code></dt><dd><p>the bit to set</p>
@@ -144,12 +145,14 @@
 <dt><code class="docutils literal notranslate"><span class="pre">unsigned</span> <span class="pre">long</span> <span class="pre">*addr</span></code></dt><dd><p>the address to start counting from</p>
 </dd>
 </dl>
+</div>

(3) The new version correctly parses the multi-line Return: block for
the memory_translate_iotlb() doc comment. You can see that the
old HTML here had dt/dd markup, and it mis-renders in the HTML at
https://www.qemu.org/docs/master/devel/memory.html#c.memory_translate_iotlb

 <p><strong>Return</strong></p>
-<dl class="simple">
-<dt>On success, return the MemoryRegion containing the <strong>iotlb</strong> translated</dt><dd><p>addr.  The MemoryRegion must not be
 accessed after rcu_read_unlock.
+<p>On success, return the MemoryRegion containing the <strong>iotlb</strong> translated
+addr.  The MemoryRegion must not be accessed after rcu_read_unlock.
 On failure, return NULL, setting <strong>errp</strong> with error.</p>
-</dd>
-</dl>
+</div>

"Definition" sections now get output with a trailing colon:

-<p><strong>Definition</strong></p>
+<div class="kernelindent docutils container">
+<p><strong>Definition</strong>:</p>

This seems like it might be a bug in kernel-doc since the Parameters,
Return, etc sections don't get the trailing colon. I don't think it's
important enough to worry about.

thanks
-- PMM

Peter Maydell (8):
  docs/sphinx/kerneldoc.py: Handle new LINENO syntax
  tests/qtest/libqtest.h: Remove stray space from doc comment
  scripts: Import Python kerneldoc from Linux kernel
  scripts/kernel-doc: strip QEMU_ from function definitions
  scripts/kernel-doc: tweak for QEMU coding standards
  scripts/kerneldoc: Switch to the Python kernel-doc script
  scripts/kernel-doc: Delete the old Perl kernel-doc script
  MAINTAINERS: Put kernel-doc under the "docs build machinery" section

 MAINTAINERS                     |    2 +
 docs/conf.py                    |    4 +-
 docs/sphinx/kerneldoc.py        |    7 +-
 tests/qtest/libqtest.h          |    2 +-
 .editorconfig                   |    2 +-
 scripts/kernel-doc              | 2442 -------------------------------
 scripts/kernel-doc.py           |  325 ++++
 scripts/lib/kdoc/kdoc_files.py  |  291 ++++
 scripts/lib/kdoc/kdoc_item.py   |   42 +
 scripts/lib/kdoc/kdoc_output.py |  749 ++++++++++
 scripts/lib/kdoc/kdoc_parser.py | 1670 +++++++++++++++++++++
 scripts/lib/kdoc/kdoc_re.py     |  270 ++++
 12 files changed, 3355 insertions(+), 2451 deletions(-)
 delete mode 100755 scripts/kernel-doc
 create mode 100755 scripts/kernel-doc.py
 create mode 100644 scripts/lib/kdoc/kdoc_files.py
 create mode 100644 scripts/lib/kdoc/kdoc_item.py
 create mode 100644 scripts/lib/kdoc/kdoc_output.py
 create mode 100644 scripts/lib/kdoc/kdoc_parser.py
 create mode 100644 scripts/lib/kdoc/kdoc_re.py

-- 
2.43.0


