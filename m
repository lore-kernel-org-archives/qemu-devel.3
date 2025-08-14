Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1F40CA0EE4
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Aug 2025 17:14:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1umbWG-0008NO-V1; Thu, 14 Aug 2025 13:13:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1umbWE-0008MU-Tc
 for qemu-devel@nongnu.org; Thu, 14 Aug 2025 13:13:39 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1umbW9-0001oY-0G
 for qemu-devel@nongnu.org; Thu, 14 Aug 2025 13:13:38 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-45a1b0c52f3so6097745e9.3
 for <qemu-devel@nongnu.org>; Thu, 14 Aug 2025 10:13:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1755191610; x=1755796410; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3W6DLhnZ6DCDdLnuWJ0zVGG8lRNh4APlwHPPG80n548=;
 b=hSmHbQqeIljwb+GNcoXsrIWdlNHX7Tqvxba/zyizWWte2GCZ8Zv7C5+PSjblP3HzSt
 PM41QnHJvZ9WuXkvO0Ijrf1PYuAtzJfqfnaNb976vp9D6qmaqXsjh4ZrQXic7Lx7Rz0O
 XYs3GroE8TiwJMMiMI/O5IcUmyn1WBTi3hyePBAO5JGOheWIPgglvYprvun0q084rAUU
 G/fuPfGy+on6sL0CvDA/AZ5Lu6cThc0jIinJpRePaFtttc6TPFOYqruDsQ+w5o9ChoAd
 pDDo+zG9VqDhyQFH0DkpeQs5wAoGn+QvnRFZD0Tkw65nYUuC9wll+jvfOCMIA9EwAMOz
 KweA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755191610; x=1755796410;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3W6DLhnZ6DCDdLnuWJ0zVGG8lRNh4APlwHPPG80n548=;
 b=WbGTt/P0qFWK/QEOY6+pJ4sejhPa/jYVxoLkza5fMxdvwwlfrAVBZbCY+yv5f4VEE6
 ybGeniUCBQFh9pTMqdWNT66Z9ChsSzB2xRBf9le+EvbHZs3bl7SzZ3uZONh5fsT6zoQA
 XUQgclir6HV2pRZzTgkM4DpbsrWUWvjTD+W4IZlgKP4oAZjuIW64eLDlSIKZtA9ayfxX
 Ff0JkV0XT6uHvFcpkGb9LOidbPEXsRBnhmOgWx90Lf1YLokbOyW1v/JdeSbt/t9PYcR1
 ILp9IA83LWiVoRWLXQnJQusDj0mZyOTALvL25wBheXNK5DBZNRX2fMl1Xp7eaRw4MKJ+
 9wSA==
X-Gm-Message-State: AOJu0YwfkKCMsj7s7/HG0oM5I1tor5cMVSEO8adEmR6N2AIzgK+D1500
 zaeMetHJ8FO8B8q+LYukBptVtUcjD5dcYPAhFS1hupoK6eyzfvLTtmyNOkXDKY6TcTvtyKHAoqB
 fHkVf
X-Gm-Gg: ASbGncuZk3o2ybok5Tf8UNTqMWcFP1mtyEX+4Y3aVTQyOw6ATMwFx3krIdVIMYTSIwP
 MMMIMs5CE7lXyQVe2SEMMbRV7sP2U7PVGdDSz7dfP3h8V4Q3kkRik2rqRaMUXEFTFQyeE+Hr91Q
 aavGVYrJFt4KC2k9x34aQf4xJMDEk0BNKKC2IYx7HBKcq0j5g0l2r5Q5XEqATVxbG9z+oU7HMUE
 Koc2JiT51IR6eLqBc9lpZnST8krBrYsOWNxGD27Ne8gN3W6p118dPyRWUoY9jC9F5QdgiYjsx7a
 eVGYIFWGBFhicknl/7pzKx2j+LHzyuVVC80I2Q4kdlYRjec06Nh2oBMGYdHSK+FqYX4/0p9UAy0
 FnkEvXWoqcOhFxrNQY1tHKMp8XQpA
X-Google-Smtp-Source: AGHT+IHZMpoFQHrWiDQUKxomba8lf62QhhPjOj+Oqx59tE8SLTqCXzAVMYHN6gOmZZDChH/6rfOpsQ==
X-Received: by 2002:a05:600c:3b1a:b0:458:c059:7db1 with SMTP id
 5b1f17b1804b1-45a1b668ac4mr41678285e9.30.1755191609430; 
 Thu, 14 Aug 2025 10:13:29 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45a1c76e9basm29489165e9.21.2025.08.14.10.13.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Aug 2025 10:13:28 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	John Snow <jsnow@redhat.com>
Subject: [PATCH for-10.2 3/8] scripts: Import Python kerneldoc from Linux
 kernel
Date: Thu, 14 Aug 2025 18:13:18 +0100
Message-ID: <20250814171324.1614516-4-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250814171324.1614516-1-peter.maydell@linaro.org>
References: <20250814171324.1614516-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x334.google.com
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

We last synced our copy of kerneldoc with Linux back in 2020.  In the
interim, upstream has entirely rewritten the script in Python, and
the new Python version is split into a main script plus some
libraries in the kernel's scripts/lib/kdoc.

Import all these files.  These are the versions as of kernel commit
0cc53520e68be, with no local changes.

We use the same lib/kdoc/ directory as the kernel does here, so we
can avoid having to edit the top-level script just to adjust a
pathname, even though it is probably not the naming we would have
picked if this was a purely QEMU script.

The Sphinx conf.py still points at the Perl version of the script,
so this Python code will not be invoked to build the docs yet.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 scripts/kernel-doc.py           |  325 ++++++
 scripts/lib/kdoc/kdoc_files.py  |  291 ++++++
 scripts/lib/kdoc/kdoc_item.py   |   42 +
 scripts/lib/kdoc/kdoc_output.py |  749 ++++++++++++++
 scripts/lib/kdoc/kdoc_parser.py | 1669 +++++++++++++++++++++++++++++++
 scripts/lib/kdoc/kdoc_re.py     |  270 +++++
 6 files changed, 3346 insertions(+)
 create mode 100755 scripts/kernel-doc.py
 create mode 100644 scripts/lib/kdoc/kdoc_files.py
 create mode 100644 scripts/lib/kdoc/kdoc_item.py
 create mode 100644 scripts/lib/kdoc/kdoc_output.py
 create mode 100644 scripts/lib/kdoc/kdoc_parser.py
 create mode 100644 scripts/lib/kdoc/kdoc_re.py

diff --git a/scripts/kernel-doc.py b/scripts/kernel-doc.py
new file mode 100755
index 00000000000..fc3d46ef519
--- /dev/null
+++ b/scripts/kernel-doc.py
@@ -0,0 +1,325 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0
+# Copyright(c) 2025: Mauro Carvalho Chehab <mchehab@kernel.org>.
+#
+# pylint: disable=C0103,R0915
+#
+# Converted from the kernel-doc script originally written in Perl
+# under GPLv2, copyrighted since 1998 by the following authors:
+#
+#    Aditya Srivastava <yashsri421@gmail.com>
+#    Akira Yokosawa <akiyks@gmail.com>
+#    Alexander A. Klimov <grandmaster@al2klimov.de>
+#    Alexander Lobakin <aleksander.lobakin@intel.com>
+#    André Almeida <andrealmeid@igalia.com>
+#    Andy Shevchenko <andriy.shevchenko@linux.intel.com>
+#    Anna-Maria Behnsen <anna-maria@linutronix.de>
+#    Armin Kuster <akuster@mvista.com>
+#    Bart Van Assche <bart.vanassche@sandisk.com>
+#    Ben Hutchings <ben@decadent.org.uk>
+#    Borislav Petkov <bbpetkov@yahoo.de>
+#    Chen-Yu Tsai <wenst@chromium.org>
+#    Coco Li <lixiaoyan@google.com>
+#    Conchúr Navid <conchur@web.de>
+#    Daniel Santos <daniel.santos@pobox.com>
+#    Danilo Cesar Lemes de Paula <danilo.cesar@collabora.co.uk>
+#    Dan Luedtke <mail@danrl.de>
+#    Donald Hunter <donald.hunter@gmail.com>
+#    Gabriel Krisman Bertazi <krisman@collabora.co.uk>
+#    Greg Kroah-Hartman <gregkh@linuxfoundation.org>
+#    Harvey Harrison <harvey.harrison@gmail.com>
+#    Horia Geanta <horia.geanta@freescale.com>
+#    Ilya Dryomov <idryomov@gmail.com>
+#    Jakub Kicinski <kuba@kernel.org>
+#    Jani Nikula <jani.nikula@intel.com>
+#    Jason Baron <jbaron@redhat.com>
+#    Jason Gunthorpe <jgg@nvidia.com>
+#    Jérémy Bobbio <lunar@debian.org>
+#    Johannes Berg <johannes.berg@intel.com>
+#    Johannes Weiner <hannes@cmpxchg.org>
+#    Jonathan Cameron <Jonathan.Cameron@huawei.com>
+#    Jonathan Corbet <corbet@lwn.net>
+#    Jonathan Neuschäfer <j.neuschaefer@gmx.net>
+#    Kamil Rytarowski <n54@gmx.com>
+#    Kees Cook <kees@kernel.org>
+#    Laurent Pinchart <laurent.pinchart@ideasonboard.com>
+#    Levin, Alexander (Sasha Levin) <alexander.levin@verizon.com>
+#    Linus Torvalds <torvalds@linux-foundation.org>
+#    Lucas De Marchi <lucas.demarchi@profusion.mobi>
+#    Mark Rutland <mark.rutland@arm.com>
+#    Markus Heiser <markus.heiser@darmarit.de>
+#    Martin Waitz <tali@admingilde.org>
+#    Masahiro Yamada <masahiroy@kernel.org>
+#    Matthew Wilcox <willy@infradead.org>
+#    Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
+#    Michal Wajdeczko <michal.wajdeczko@intel.com>
+#    Michael Zucchi
+#    Mike Rapoport <rppt@linux.ibm.com>
+#    Niklas Söderlund <niklas.soderlund@corigine.com>
+#    Nishanth Menon <nm@ti.com>
+#    Paolo Bonzini <pbonzini@redhat.com>
+#    Pavan Kumar Linga <pavan.kumar.linga@intel.com>
+#    Pavel Pisa <pisa@cmp.felk.cvut.cz>
+#    Peter Maydell <peter.maydell@linaro.org>
+#    Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
+#    Randy Dunlap <rdunlap@infradead.org>
+#    Richard Kennedy <richard@rsk.demon.co.uk>
+#    Rich Walker <rw@shadow.org.uk>
+#    Rolf Eike Beer <eike-kernel@sf-tec.de>
+#    Sakari Ailus <sakari.ailus@linux.intel.com>
+#    Silvio Fricke <silvio.fricke@gmail.com>
+#    Simon Huggins
+#    Tim Waugh <twaugh@redhat.com>
+#    Tomasz Warniełło <tomasz.warniello@gmail.com>
+#    Utkarsh Tripathi <utripathi2002@gmail.com>
+#    valdis.kletnieks@vt.edu <valdis.kletnieks@vt.edu>
+#    Vegard Nossum <vegard.nossum@oracle.com>
+#    Will Deacon <will.deacon@arm.com>
+#    Yacine Belkadi <yacine.belkadi.1@gmail.com>
+#    Yujie Liu <yujie.liu@intel.com>
+
+"""
+kernel_doc
+==========
+
+Print formatted kernel documentation to stdout
+
+Read C language source or header FILEs, extract embedded
+documentation comments, and print formatted documentation
+to standard output.
+
+The documentation comments are identified by the "/**"
+opening comment mark.
+
+See Documentation/doc-guide/kernel-doc.rst for the
+documentation comment syntax.
+"""
+
+import argparse
+import logging
+import os
+import sys
+
+# Import Python modules
+
+LIB_DIR = "lib/kdoc"
+SRC_DIR = os.path.dirname(os.path.realpath(__file__))
+
+sys.path.insert(0, os.path.join(SRC_DIR, LIB_DIR))
+
+from kdoc_files import KernelFiles                      # pylint: disable=C0413
+from kdoc_output import RestFormat, ManFormat           # pylint: disable=C0413
+
+DESC = """
+Read C language source or header FILEs, extract embedded documentation comments,
+and print formatted documentation to standard output.
+
+The documentation comments are identified by the "/**" opening comment mark.
+
+See Documentation/doc-guide/kernel-doc.rst for the documentation comment syntax.
+"""
+
+EXPORT_FILE_DESC = """
+Specify an additional FILE in which to look for EXPORT_SYMBOL information.
+
+May be used multiple times.
+"""
+
+EXPORT_DESC = """
+Only output documentation for the symbols that have been
+exported using EXPORT_SYMBOL() and related macros in any input
+FILE or -export-file FILE.
+"""
+
+INTERNAL_DESC = """
+Only output documentation for the symbols that have NOT been
+exported using EXPORT_SYMBOL() and related macros in any input
+FILE or -export-file FILE.
+"""
+
+FUNCTION_DESC = """
+Only output documentation for the given function or DOC: section
+title. All other functions and DOC: sections are ignored.
+
+May be used multiple times.
+"""
+
+NOSYMBOL_DESC = """
+Exclude the specified symbol from the output documentation.
+
+May be used multiple times.
+"""
+
+FILES_DESC = """
+Header and C source files to be parsed.
+"""
+
+WARN_CONTENTS_BEFORE_SECTIONS_DESC = """
+Warns if there are contents before sections (deprecated).
+
+This option is kept just for backward-compatibility, but it does nothing,
+neither here nor at the original Perl script.
+"""
+
+
+class MsgFormatter(logging.Formatter):
+    """Helper class to format warnings on a similar way to kernel-doc.pl"""
+
+    def format(self, record):
+        record.levelname = record.levelname.capitalize()
+        return logging.Formatter.format(self, record)
+
+def main():
+    """Main program"""
+
+    parser = argparse.ArgumentParser(formatter_class=argparse.RawTextHelpFormatter,
+                                     description=DESC)
+
+    # Normal arguments
+
+    parser.add_argument("-v", "-verbose", "--verbose", action="store_true",
+                        help="Verbose output, more warnings and other information.")
+
+    parser.add_argument("-d", "-debug", "--debug", action="store_true",
+                        help="Enable debug messages")
+
+    parser.add_argument("-M", "-modulename", "--modulename",
+                        default="Kernel API",
+                        help="Allow setting a module name at the output.")
+
+    parser.add_argument("-l", "-enable-lineno", "--enable_lineno",
+                        action="store_true",
+                        help="Enable line number output (only in ReST mode)")
+
+    # Arguments to control the warning behavior
+
+    parser.add_argument("-Wreturn", "--wreturn", action="store_true",
+                        help="Warns about the lack of a return markup on functions.")
+
+    parser.add_argument("-Wshort-desc", "-Wshort-description", "--wshort-desc",
+                        action="store_true",
+                        help="Warns if initial short description is missing")
+
+    parser.add_argument("-Wcontents-before-sections",
+                        "--wcontents-before-sections", action="store_true",
+                        help=WARN_CONTENTS_BEFORE_SECTIONS_DESC)
+
+    parser.add_argument("-Wall", "--wall", action="store_true",
+                        help="Enable all types of warnings")
+
+    parser.add_argument("-Werror", "--werror", action="store_true",
+                        help="Treat warnings as errors.")
+
+    parser.add_argument("-export-file", "--export-file", action='append',
+                        help=EXPORT_FILE_DESC)
+
+    # Output format mutually-exclusive group
+
+    out_group = parser.add_argument_group("Output format selection (mutually exclusive)")
+
+    out_fmt = out_group.add_mutually_exclusive_group()
+
+    out_fmt.add_argument("-m", "-man", "--man", action="store_true",
+                         help="Output troff manual page format.")
+    out_fmt.add_argument("-r", "-rst", "--rst", action="store_true",
+                         help="Output reStructuredText format (default).")
+    out_fmt.add_argument("-N", "-none", "--none", action="store_true",
+                         help="Do not output documentation, only warnings.")
+
+    # Output selection mutually-exclusive group
+
+    sel_group = parser.add_argument_group("Output selection (mutually exclusive)")
+    sel_mut = sel_group.add_mutually_exclusive_group()
+
+    sel_mut.add_argument("-e", "-export", "--export", action='store_true',
+                         help=EXPORT_DESC)
+
+    sel_mut.add_argument("-i", "-internal", "--internal", action='store_true',
+                         help=INTERNAL_DESC)
+
+    sel_mut.add_argument("-s", "-function", "--symbol", action='append',
+                         help=FUNCTION_DESC)
+
+    # Those are valid for all 3 types of filter
+    parser.add_argument("-n", "-nosymbol", "--nosymbol", action='append',
+                        help=NOSYMBOL_DESC)
+
+    parser.add_argument("-D", "-no-doc-sections", "--no-doc-sections",
+                        action='store_true', help="Don't outputt DOC sections")
+
+    parser.add_argument("files", metavar="FILE",
+                        nargs="+", help=FILES_DESC)
+
+    args = parser.parse_args()
+
+    if args.wall:
+        args.wreturn = True
+        args.wshort_desc = True
+        args.wcontents_before_sections = True
+
+    logger = logging.getLogger()
+
+    if not args.debug:
+        logger.setLevel(logging.INFO)
+    else:
+        logger.setLevel(logging.DEBUG)
+
+    formatter = MsgFormatter('%(levelname)s: %(message)s')
+
+    handler = logging.StreamHandler()
+    handler.setFormatter(formatter)
+
+    logger.addHandler(handler)
+
+    python_ver = sys.version_info[:2]
+    if python_ver < (3,6):
+        logger.warning("Python 3.6 or later is required by kernel-doc")
+
+        # Return 0 here to avoid breaking compilation
+        sys.exit(0)
+
+    if python_ver < (3,7):
+        logger.warning("Python 3.7 or later is required for correct results")
+
+    if args.man:
+        out_style = ManFormat(modulename=args.modulename)
+    elif args.none:
+        out_style = None
+    else:
+        out_style = RestFormat()
+
+    kfiles = KernelFiles(verbose=args.verbose,
+                         out_style=out_style, werror=args.werror,
+                         wreturn=args.wreturn, wshort_desc=args.wshort_desc,
+                         wcontents_before_sections=args.wcontents_before_sections)
+
+    kfiles.parse(args.files, export_file=args.export_file)
+
+    for t in kfiles.msg(enable_lineno=args.enable_lineno, export=args.export,
+                        internal=args.internal, symbol=args.symbol,
+                        nosymbol=args.nosymbol, export_file=args.export_file,
+                        no_doc_sections=args.no_doc_sections):
+        msg = t[1]
+        if msg:
+            print(msg)
+
+    error_count = kfiles.errors
+    if not error_count:
+        sys.exit(0)
+
+    if args.werror:
+        print(f"{error_count} warnings as errors")
+        sys.exit(error_count)
+
+    if args.verbose:
+        print(f"{error_count} errors")
+
+    if args.none:
+        sys.exit(0)
+
+    sys.exit(error_count)
+
+
+# Call main method
+if __name__ == "__main__":
+    main()
diff --git a/scripts/lib/kdoc/kdoc_files.py b/scripts/lib/kdoc/kdoc_files.py
new file mode 100644
index 00000000000..9e09b45b02f
--- /dev/null
+++ b/scripts/lib/kdoc/kdoc_files.py
@@ -0,0 +1,291 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0
+# Copyright(c) 2025: Mauro Carvalho Chehab <mchehab@kernel.org>.
+#
+# pylint: disable=R0903,R0913,R0914,R0917
+
+"""
+Parse lernel-doc tags on multiple kernel source files.
+"""
+
+import argparse
+import logging
+import os
+import re
+
+from kdoc_parser import KernelDoc
+from kdoc_output import OutputFormat
+
+
+class GlobSourceFiles:
+    """
+    Parse C source code file names and directories via an Interactor.
+    """
+
+    def __init__(self, srctree=None, valid_extensions=None):
+        """
+        Initialize valid extensions with a tuple.
+
+        If not defined, assume default C extensions (.c and .h)
+
+        It would be possible to use python's glob function, but it is
+        very slow, and it is not interactive. So, it would wait to read all
+        directories before actually do something.
+
+        So, let's use our own implementation.
+        """
+
+        if not valid_extensions:
+            self.extensions = (".c", ".h")
+        else:
+            self.extensions = valid_extensions
+
+        self.srctree = srctree
+
+    def _parse_dir(self, dirname):
+        """Internal function to parse files recursively"""
+
+        with os.scandir(dirname) as obj:
+            for entry in obj:
+                name = os.path.join(dirname, entry.name)
+
+                if entry.is_dir():
+                    yield from self._parse_dir(name)
+
+                if not entry.is_file():
+                    continue
+
+                basename = os.path.basename(name)
+
+                if not basename.endswith(self.extensions):
+                    continue
+
+                yield name
+
+    def parse_files(self, file_list, file_not_found_cb):
+        """
+        Define an interator to parse all source files from file_list,
+        handling directories if any
+        """
+
+        if not file_list:
+            return
+
+        for fname in file_list:
+            if self.srctree:
+                f = os.path.join(self.srctree, fname)
+            else:
+                f = fname
+
+            if os.path.isdir(f):
+                yield from self._parse_dir(f)
+            elif os.path.isfile(f):
+                yield f
+            elif file_not_found_cb:
+                file_not_found_cb(fname)
+
+
+class KernelFiles():
+    """
+    Parse kernel-doc tags on multiple kernel source files.
+
+    There are two type of parsers defined here:
+        - self.parse_file(): parses both kernel-doc markups and
+          EXPORT_SYMBOL* macros;
+        - self.process_export_file(): parses only EXPORT_SYMBOL* macros.
+    """
+
+    def warning(self, msg):
+        """Ancillary routine to output a warning and increment error count"""
+
+        self.config.log.warning(msg)
+        self.errors += 1
+
+    def error(self, msg):
+        """Ancillary routine to output an error and increment error count"""
+
+        self.config.log.error(msg)
+        self.errors += 1
+
+    def parse_file(self, fname):
+        """
+        Parse a single Kernel source.
+        """
+
+        # Prevent parsing the same file twice if results are cached
+        if fname in self.files:
+            return
+
+        doc = KernelDoc(self.config, fname)
+        export_table, entries = doc.parse_kdoc()
+
+        self.export_table[fname] = export_table
+
+        self.files.add(fname)
+        self.export_files.add(fname)      # parse_kdoc() already check exports
+
+        self.results[fname] = entries
+
+    def process_export_file(self, fname):
+        """
+        Parses EXPORT_SYMBOL* macros from a single Kernel source file.
+        """
+
+        # Prevent parsing the same file twice if results are cached
+        if fname in self.export_files:
+            return
+
+        doc = KernelDoc(self.config, fname)
+        export_table = doc.parse_export()
+
+        if not export_table:
+            self.error(f"Error: Cannot check EXPORT_SYMBOL* on {fname}")
+            export_table = set()
+
+        self.export_table[fname] = export_table
+        self.export_files.add(fname)
+
+    def file_not_found_cb(self, fname):
+        """
+        Callback to warn if a file was not found.
+        """
+
+        self.error(f"Cannot find file {fname}")
+
+    def __init__(self, verbose=False, out_style=None,
+                 werror=False, wreturn=False, wshort_desc=False,
+                 wcontents_before_sections=False,
+                 logger=None):
+        """
+        Initialize startup variables and parse all files
+        """
+
+        if not verbose:
+            verbose = bool(os.environ.get("KBUILD_VERBOSE", 0))
+
+        if out_style is None:
+            out_style = OutputFormat()
+
+        if not werror:
+            kcflags = os.environ.get("KCFLAGS", None)
+            if kcflags:
+                match = re.search(r"(\s|^)-Werror(\s|$)/", kcflags)
+                if match:
+                    werror = True
+
+            # reading this variable is for backwards compat just in case
+            # someone was calling it with the variable from outside the
+            # kernel's build system
+            kdoc_werror = os.environ.get("KDOC_WERROR", None)
+            if kdoc_werror:
+                werror = kdoc_werror
+
+        # Some variables are global to the parser logic as a whole as they are
+        # used to send control configuration to KernelDoc class. As such,
+        # those variables are read-only inside the KernelDoc.
+        self.config = argparse.Namespace
+
+        self.config.verbose = verbose
+        self.config.werror = werror
+        self.config.wreturn = wreturn
+        self.config.wshort_desc = wshort_desc
+        self.config.wcontents_before_sections = wcontents_before_sections
+
+        if not logger:
+            self.config.log = logging.getLogger("kernel-doc")
+        else:
+            self.config.log = logger
+
+        self.config.warning = self.warning
+
+        self.config.src_tree = os.environ.get("SRCTREE", None)
+
+        # Initialize variables that are internal to KernelFiles
+
+        self.out_style = out_style
+
+        self.errors = 0
+        self.results = {}
+
+        self.files = set()
+        self.export_files = set()
+        self.export_table = {}
+
+    def parse(self, file_list, export_file=None):
+        """
+        Parse all files
+        """
+
+        glob = GlobSourceFiles(srctree=self.config.src_tree)
+
+        for fname in glob.parse_files(file_list, self.file_not_found_cb):
+            self.parse_file(fname)
+
+        for fname in glob.parse_files(export_file, self.file_not_found_cb):
+            self.process_export_file(fname)
+
+    def out_msg(self, fname, name, arg):
+        """
+        Return output messages from a file name using the output style
+        filtering.
+
+        If output type was not handled by the syler, return None.
+        """
+
+        # NOTE: we can add rules here to filter out unwanted parts,
+        # although OutputFormat.msg already does that.
+
+        return self.out_style.msg(fname, name, arg)
+
+    def msg(self, enable_lineno=False, export=False, internal=False,
+            symbol=None, nosymbol=None, no_doc_sections=False,
+            filenames=None, export_file=None):
+        """
+        Interacts over the kernel-doc results and output messages,
+        returning kernel-doc markups on each interaction
+        """
+
+        self.out_style.set_config(self.config)
+
+        if not filenames:
+            filenames = sorted(self.results.keys())
+
+        glob = GlobSourceFiles(srctree=self.config.src_tree)
+
+        for fname in filenames:
+            function_table = set()
+
+            if internal or export:
+                if not export_file:
+                    export_file = [fname]
+
+                for f in glob.parse_files(export_file, self.file_not_found_cb):
+                    function_table |= self.export_table[f]
+
+            if symbol:
+                for s in symbol:
+                    function_table.add(s)
+
+            self.out_style.set_filter(export, internal, symbol, nosymbol,
+                                      function_table, enable_lineno,
+                                      no_doc_sections)
+
+            msg = ""
+            if fname not in self.results:
+                self.config.log.warning("No kernel-doc for file %s", fname)
+                continue
+
+            for arg in self.results[fname]:
+                m = self.out_msg(fname, arg.name, arg)
+
+                if m is None:
+                    ln = arg.get("ln", 0)
+                    dtype = arg.get('type', "")
+
+                    self.config.log.warning("%s:%d Can't handle %s",
+                                            fname, ln, dtype)
+                else:
+                    msg += m
+
+            if msg:
+                yield fname, msg
diff --git a/scripts/lib/kdoc/kdoc_item.py b/scripts/lib/kdoc/kdoc_item.py
new file mode 100644
index 00000000000..b3b22576455
--- /dev/null
+++ b/scripts/lib/kdoc/kdoc_item.py
@@ -0,0 +1,42 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# A class that will, eventually, encapsulate all of the parsed data that we
+# then pass into the output modules.
+#
+
+class KdocItem:
+    def __init__(self, name, type, start_line, **other_stuff):
+        self.name = name
+        self.type = type
+        self.declaration_start_line = start_line
+        self.sections = {}
+        self.sections_start_lines = {}
+        self.parameterlist = []
+        self.parameterdesc_start_lines = []
+        self.parameterdescs = {}
+        self.parametertypes = {}
+        #
+        # Just save everything else into our own dict so that the output
+        # side can grab it directly as before.  As we move things into more
+        # structured data, this will, hopefully, fade away.
+        #
+        self.other_stuff = other_stuff
+
+    def get(self, key, default = None):
+        return self.other_stuff.get(key, default)
+
+    def __getitem__(self, key):
+        return self.get(key)
+
+    #
+    # Tracking of section and parameter information.
+    #
+    def set_sections(self, sections, start_lines):
+        self.sections = sections
+        self.section_start_lines = start_lines
+
+    def set_params(self, names, descs, types, starts):
+        self.parameterlist = names
+        self.parameterdescs = descs
+        self.parametertypes = types
+        self.parameterdesc_start_lines = starts
diff --git a/scripts/lib/kdoc/kdoc_output.py b/scripts/lib/kdoc/kdoc_output.py
new file mode 100644
index 00000000000..ea8914537ba
--- /dev/null
+++ b/scripts/lib/kdoc/kdoc_output.py
@@ -0,0 +1,749 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0
+# Copyright(c) 2025: Mauro Carvalho Chehab <mchehab@kernel.org>.
+#
+# pylint: disable=C0301,R0902,R0911,R0912,R0913,R0914,R0915,R0917
+
+"""
+Implement output filters to print kernel-doc documentation.
+
+The implementation uses a virtual base class (OutputFormat) which
+contains a dispatches to virtual methods, and some code to filter
+out output messages.
+
+The actual implementation is done on one separate class per each type
+of output. Currently, there are output classes for ReST and man/troff.
+"""
+
+import os
+import re
+from datetime import datetime
+
+from kdoc_parser import KernelDoc, type_param
+from kdoc_re import KernRe
+
+
+function_pointer = KernRe(r"([^\(]*\(\*)\s*\)\s*\(([^\)]*)\)", cache=False)
+
+# match expressions used to find embedded type information
+type_constant = KernRe(r"\b``([^\`]+)``\b", cache=False)
+type_constant2 = KernRe(r"\%([-_*\w]+)", cache=False)
+type_func = KernRe(r"(\w+)\(\)", cache=False)
+type_param_ref = KernRe(r"([\!~\*]?)\@(\w*((\.\w+)|(->\w+))*(\.\.\.)?)", cache=False)
+
+# Special RST handling for func ptr params
+type_fp_param = KernRe(r"\@(\w+)\(\)", cache=False)
+
+# Special RST handling for structs with func ptr params
+type_fp_param2 = KernRe(r"\@(\w+->\S+)\(\)", cache=False)
+
+type_env = KernRe(r"(\$\w+)", cache=False)
+type_enum = KernRe(r"\&(enum\s*([_\w]+))", cache=False)
+type_struct = KernRe(r"\&(struct\s*([_\w]+))", cache=False)
+type_typedef = KernRe(r"\&(typedef\s*([_\w]+))", cache=False)
+type_union = KernRe(r"\&(union\s*([_\w]+))", cache=False)
+type_member = KernRe(r"\&([_\w]+)(\.|->)([_\w]+)", cache=False)
+type_fallback = KernRe(r"\&([_\w]+)", cache=False)
+type_member_func = type_member + KernRe(r"\(\)", cache=False)
+
+
+class OutputFormat:
+    """
+    Base class for OutputFormat. If used as-is, it means that only
+    warnings will be displayed.
+    """
+
+    # output mode.
+    OUTPUT_ALL          = 0 # output all symbols and doc sections
+    OUTPUT_INCLUDE      = 1 # output only specified symbols
+    OUTPUT_EXPORTED     = 2 # output exported symbols
+    OUTPUT_INTERNAL     = 3 # output non-exported symbols
+
+    # Virtual member to be overriden at the  inherited classes
+    highlights = []
+
+    def __init__(self):
+        """Declare internal vars and set mode to OUTPUT_ALL"""
+
+        self.out_mode = self.OUTPUT_ALL
+        self.enable_lineno = None
+        self.nosymbol = {}
+        self.symbol = None
+        self.function_table = None
+        self.config = None
+        self.no_doc_sections = False
+
+        self.data = ""
+
+    def set_config(self, config):
+        """
+        Setup global config variables used by both parser and output.
+        """
+
+        self.config = config
+
+    def set_filter(self, export, internal, symbol, nosymbol, function_table,
+                   enable_lineno, no_doc_sections):
+        """
+        Initialize filter variables according with the requested mode.
+
+        Only one choice is valid between export, internal and symbol.
+
+        The nosymbol filter can be used on all modes.
+        """
+
+        self.enable_lineno = enable_lineno
+        self.no_doc_sections = no_doc_sections
+        self.function_table = function_table
+
+        if symbol:
+            self.out_mode = self.OUTPUT_INCLUDE
+        elif export:
+            self.out_mode = self.OUTPUT_EXPORTED
+        elif internal:
+            self.out_mode = self.OUTPUT_INTERNAL
+        else:
+            self.out_mode = self.OUTPUT_ALL
+
+        if nosymbol:
+            self.nosymbol = set(nosymbol)
+
+
+    def highlight_block(self, block):
+        """
+        Apply the RST highlights to a sub-block of text.
+        """
+
+        for r, sub in self.highlights:
+            block = r.sub(sub, block)
+
+        return block
+
+    def out_warnings(self, args):
+        """
+        Output warnings for identifiers that will be displayed.
+        """
+
+        for log_msg in args.warnings:
+            self.config.warning(log_msg)
+
+    def check_doc(self, name, args):
+        """Check if DOC should be output"""
+
+        if self.no_doc_sections:
+            return False
+
+        if name in self.nosymbol:
+            return False
+
+        if self.out_mode == self.OUTPUT_ALL:
+            self.out_warnings(args)
+            return True
+
+        if self.out_mode == self.OUTPUT_INCLUDE:
+            if name in self.function_table:
+                self.out_warnings(args)
+                return True
+
+        return False
+
+    def check_declaration(self, dtype, name, args):
+        """
+        Checks if a declaration should be output or not based on the
+        filtering criteria.
+        """
+
+        if name in self.nosymbol:
+            return False
+
+        if self.out_mode == self.OUTPUT_ALL:
+            self.out_warnings(args)
+            return True
+
+        if self.out_mode in [self.OUTPUT_INCLUDE, self.OUTPUT_EXPORTED]:
+            if name in self.function_table:
+                return True
+
+        if self.out_mode == self.OUTPUT_INTERNAL:
+            if dtype != "function":
+                self.out_warnings(args)
+                return True
+
+            if name not in self.function_table:
+                self.out_warnings(args)
+                return True
+
+        return False
+
+    def msg(self, fname, name, args):
+        """
+        Handles a single entry from kernel-doc parser
+        """
+
+        self.data = ""
+
+        dtype = args.type
+
+        if dtype == "doc":
+            self.out_doc(fname, name, args)
+            return self.data
+
+        if not self.check_declaration(dtype, name, args):
+            return self.data
+
+        if dtype == "function":
+            self.out_function(fname, name, args)
+            return self.data
+
+        if dtype == "enum":
+            self.out_enum(fname, name, args)
+            return self.data
+
+        if dtype == "typedef":
+            self.out_typedef(fname, name, args)
+            return self.data
+
+        if dtype in ["struct", "union"]:
+            self.out_struct(fname, name, args)
+            return self.data
+
+        # Warn if some type requires an output logic
+        self.config.log.warning("doesn't now how to output '%s' block",
+                                dtype)
+
+        return None
+
+    # Virtual methods to be overridden by inherited classes
+    # At the base class, those do nothing.
+    def out_doc(self, fname, name, args):
+        """Outputs a DOC block"""
+
+    def out_function(self, fname, name, args):
+        """Outputs a function"""
+
+    def out_enum(self, fname, name, args):
+        """Outputs an enum"""
+
+    def out_typedef(self, fname, name, args):
+        """Outputs a typedef"""
+
+    def out_struct(self, fname, name, args):
+        """Outputs a struct"""
+
+
+class RestFormat(OutputFormat):
+    """Consts and functions used by ReST output"""
+
+    highlights = [
+        (type_constant, r"``\1``"),
+        (type_constant2, r"``\1``"),
+
+        # Note: need to escape () to avoid func matching later
+        (type_member_func, r":c:type:`\1\2\3\\(\\) <\1>`"),
+        (type_member, r":c:type:`\1\2\3 <\1>`"),
+        (type_fp_param, r"**\1\\(\\)**"),
+        (type_fp_param2, r"**\1\\(\\)**"),
+        (type_func, r"\1()"),
+        (type_enum, r":c:type:`\1 <\2>`"),
+        (type_struct, r":c:type:`\1 <\2>`"),
+        (type_typedef, r":c:type:`\1 <\2>`"),
+        (type_union, r":c:type:`\1 <\2>`"),
+
+        # in rst this can refer to any type
+        (type_fallback, r":c:type:`\1`"),
+        (type_param_ref, r"**\1\2**")
+    ]
+    blankline = "\n"
+
+    sphinx_literal = KernRe(r'^[^.].*::$', cache=False)
+    sphinx_cblock = KernRe(r'^\.\.\ +code-block::', cache=False)
+
+    def __init__(self):
+        """
+        Creates class variables.
+
+        Not really mandatory, but it is a good coding style and makes
+        pylint happy.
+        """
+
+        super().__init__()
+        self.lineprefix = ""
+
+    def print_lineno(self, ln):
+        """Outputs a line number"""
+
+        if self.enable_lineno and ln is not None:
+            ln += 1
+            self.data += f".. LINENO {ln}\n"
+
+    def output_highlight(self, args):
+        """
+        Outputs a C symbol that may require being converted to ReST using
+        the self.highlights variable
+        """
+
+        input_text = args
+        output = ""
+        in_literal = False
+        litprefix = ""
+        block = ""
+
+        for line in input_text.strip("\n").split("\n"):
+
+            # If we're in a literal block, see if we should drop out of it.
+            # Otherwise, pass the line straight through unmunged.
+            if in_literal:
+                if line.strip():  # If the line is not blank
+                    # If this is the first non-blank line in a literal block,
+                    # figure out the proper indent.
+                    if not litprefix:
+                        r = KernRe(r'^(\s*)')
+                        if r.match(line):
+                            litprefix = '^' + r.group(1)
+                        else:
+                            litprefix = ""
+
+                        output += line + "\n"
+                    elif not KernRe(litprefix).match(line):
+                        in_literal = False
+                    else:
+                        output += line + "\n"
+                else:
+                    output += line + "\n"
+
+            # Not in a literal block (or just dropped out)
+            if not in_literal:
+                block += line + "\n"
+                if self.sphinx_literal.match(line) or self.sphinx_cblock.match(line):
+                    in_literal = True
+                    litprefix = ""
+                    output += self.highlight_block(block)
+                    block = ""
+
+        # Handle any remaining block
+        if block:
+            output += self.highlight_block(block)
+
+        # Print the output with the line prefix
+        for line in output.strip("\n").split("\n"):
+            self.data += self.lineprefix + line + "\n"
+
+    def out_section(self, args, out_docblock=False):
+        """
+        Outputs a block section.
+
+        This could use some work; it's used to output the DOC: sections, and
+        starts by putting out the name of the doc section itself, but that
+        tends to duplicate a header already in the template file.
+        """
+        for section, text in args.sections.items():
+            # Skip sections that are in the nosymbol_table
+            if section in self.nosymbol:
+                continue
+
+            if out_docblock:
+                if not self.out_mode == self.OUTPUT_INCLUDE:
+                    self.data += f".. _{section}:\n\n"
+                    self.data += f'{self.lineprefix}**{section}**\n\n'
+            else:
+                self.data += f'{self.lineprefix}**{section}**\n\n'
+
+            self.print_lineno(args.section_start_lines.get(section, 0))
+            self.output_highlight(text)
+            self.data += "\n"
+        self.data += "\n"
+
+    def out_doc(self, fname, name, args):
+        if not self.check_doc(name, args):
+            return
+        self.out_section(args, out_docblock=True)
+
+    def out_function(self, fname, name, args):
+
+        oldprefix = self.lineprefix
+        signature = ""
+
+        func_macro = args.get('func_macro', False)
+        if func_macro:
+            signature = name
+        else:
+            if args.get('functiontype'):
+                signature = args['functiontype'] + " "
+            signature += name + " ("
+
+        ln = args.declaration_start_line
+        count = 0
+        for parameter in args.parameterlist:
+            if count != 0:
+                signature += ", "
+            count += 1
+            dtype = args.parametertypes.get(parameter, "")
+
+            if function_pointer.search(dtype):
+                signature += function_pointer.group(1) + parameter + function_pointer.group(3)
+            else:
+                signature += dtype
+
+        if not func_macro:
+            signature += ")"
+
+        self.print_lineno(ln)
+        if args.get('typedef') or not args.get('functiontype'):
+            self.data += f".. c:macro:: {name}\n\n"
+
+            if args.get('typedef'):
+                self.data += "   **Typedef**: "
+                self.lineprefix = ""
+                self.output_highlight(args.get('purpose', ""))
+                self.data += "\n\n**Syntax**\n\n"
+                self.data += f"  ``{signature}``\n\n"
+            else:
+                self.data += f"``{signature}``\n\n"
+        else:
+            self.data += f".. c:function:: {signature}\n\n"
+
+        if not args.get('typedef'):
+            self.print_lineno(ln)
+            self.lineprefix = "   "
+            self.output_highlight(args.get('purpose', ""))
+            self.data += "\n"
+
+        # Put descriptive text into a container (HTML <div>) to help set
+        # function prototypes apart
+        self.lineprefix = "  "
+
+        if args.parameterlist:
+            self.data += ".. container:: kernelindent\n\n"
+            self.data += f"{self.lineprefix}**Parameters**\n\n"
+
+        for parameter in args.parameterlist:
+            parameter_name = KernRe(r'\[.*').sub('', parameter)
+            dtype = args.parametertypes.get(parameter, "")
+
+            if dtype:
+                self.data += f"{self.lineprefix}``{dtype}``\n"
+            else:
+                self.data += f"{self.lineprefix}``{parameter}``\n"
+
+            self.print_lineno(args.parameterdesc_start_lines.get(parameter_name, 0))
+
+            self.lineprefix = "    "
+            if parameter_name in args.parameterdescs and \
+               args.parameterdescs[parameter_name] != KernelDoc.undescribed:
+
+                self.output_highlight(args.parameterdescs[parameter_name])
+                self.data += "\n"
+            else:
+                self.data += f"{self.lineprefix}*undescribed*\n\n"
+            self.lineprefix = "  "
+
+        self.out_section(args)
+        self.lineprefix = oldprefix
+
+    def out_enum(self, fname, name, args):
+
+        oldprefix = self.lineprefix
+        ln = args.declaration_start_line
+
+        self.data += f"\n\n.. c:enum:: {name}\n\n"
+
+        self.print_lineno(ln)
+        self.lineprefix = "  "
+        self.output_highlight(args.get('purpose', ''))
+        self.data += "\n"
+
+        self.data += ".. container:: kernelindent\n\n"
+        outer = self.lineprefix + "  "
+        self.lineprefix = outer + "  "
+        self.data += f"{outer}**Constants**\n\n"
+
+        for parameter in args.parameterlist:
+            self.data += f"{outer}``{parameter}``\n"
+
+            if args.parameterdescs.get(parameter, '') != KernelDoc.undescribed:
+                self.output_highlight(args.parameterdescs[parameter])
+            else:
+                self.data += f"{self.lineprefix}*undescribed*\n\n"
+            self.data += "\n"
+
+        self.lineprefix = oldprefix
+        self.out_section(args)
+
+    def out_typedef(self, fname, name, args):
+
+        oldprefix = self.lineprefix
+        ln = args.declaration_start_line
+
+        self.data += f"\n\n.. c:type:: {name}\n\n"
+
+        self.print_lineno(ln)
+        self.lineprefix = "   "
+
+        self.output_highlight(args.get('purpose', ''))
+
+        self.data += "\n"
+
+        self.lineprefix = oldprefix
+        self.out_section(args)
+
+    def out_struct(self, fname, name, args):
+
+        purpose = args.get('purpose', "")
+        declaration = args.get('definition', "")
+        dtype = args.type
+        ln = args.declaration_start_line
+
+        self.data += f"\n\n.. c:{dtype}:: {name}\n\n"
+
+        self.print_lineno(ln)
+
+        oldprefix = self.lineprefix
+        self.lineprefix += "  "
+
+        self.output_highlight(purpose)
+        self.data += "\n"
+
+        self.data += ".. container:: kernelindent\n\n"
+        self.data += f"{self.lineprefix}**Definition**::\n\n"
+
+        self.lineprefix = self.lineprefix + "  "
+
+        declaration = declaration.replace("\t", self.lineprefix)
+
+        self.data += f"{self.lineprefix}{dtype} {name}" + ' {' + "\n"
+        self.data += f"{declaration}{self.lineprefix}" + "};\n\n"
+
+        self.lineprefix = "  "
+        self.data += f"{self.lineprefix}**Members**\n\n"
+        for parameter in args.parameterlist:
+            if not parameter or parameter.startswith("#"):
+                continue
+
+            parameter_name = parameter.split("[", maxsplit=1)[0]
+
+            if args.parameterdescs.get(parameter_name) == KernelDoc.undescribed:
+                continue
+
+            self.print_lineno(args.parameterdesc_start_lines.get(parameter_name, 0))
+
+            self.data += f"{self.lineprefix}``{parameter}``\n"
+
+            self.lineprefix = "    "
+            self.output_highlight(args.parameterdescs[parameter_name])
+            self.lineprefix = "  "
+
+            self.data += "\n"
+
+        self.data += "\n"
+
+        self.lineprefix = oldprefix
+        self.out_section(args)
+
+
+class ManFormat(OutputFormat):
+    """Consts and functions used by man pages output"""
+
+    highlights = (
+        (type_constant, r"\1"),
+        (type_constant2, r"\1"),
+        (type_func, r"\\fB\1\\fP"),
+        (type_enum, r"\\fI\1\\fP"),
+        (type_struct, r"\\fI\1\\fP"),
+        (type_typedef, r"\\fI\1\\fP"),
+        (type_union, r"\\fI\1\\fP"),
+        (type_param, r"\\fI\1\\fP"),
+        (type_param_ref, r"\\fI\1\2\\fP"),
+        (type_member, r"\\fI\1\2\3\\fP"),
+        (type_fallback, r"\\fI\1\\fP")
+    )
+    blankline = ""
+
+    date_formats = [
+        "%a %b %d %H:%M:%S %Z %Y",
+        "%a %b %d %H:%M:%S %Y",
+        "%Y-%m-%d",
+        "%b %d %Y",
+        "%B %d %Y",
+        "%m %d %Y",
+    ]
+
+    def __init__(self, modulename):
+        """
+        Creates class variables.
+
+        Not really mandatory, but it is a good coding style and makes
+        pylint happy.
+        """
+
+        super().__init__()
+        self.modulename = modulename
+
+        dt = None
+        tstamp = os.environ.get("KBUILD_BUILD_TIMESTAMP")
+        if tstamp:
+            for fmt in self.date_formats:
+                try:
+                    dt = datetime.strptime(tstamp, fmt)
+                    break
+                except ValueError:
+                    pass
+
+        if not dt:
+            dt = datetime.now()
+
+        self.man_date = dt.strftime("%B %Y")
+
+    def output_highlight(self, block):
+        """
+        Outputs a C symbol that may require being highlighted with
+        self.highlights variable using troff syntax
+        """
+
+        contents = self.highlight_block(block)
+
+        if isinstance(contents, list):
+            contents = "\n".join(contents)
+
+        for line in contents.strip("\n").split("\n"):
+            line = KernRe(r"^\s*").sub("", line)
+            if not line:
+                continue
+
+            if line[0] == ".":
+                self.data += "\\&" + line + "\n"
+            else:
+                self.data += line + "\n"
+
+    def out_doc(self, fname, name, args):
+        if not self.check_doc(name, args):
+            return
+
+        self.data += f'.TH "{self.modulename}" 9 "{self.modulename}" "{self.man_date}" "API Manual" LINUX' + "\n"
+
+        for section, text in args.sections.items():
+            self.data += f'.SH "{section}"' + "\n"
+            self.output_highlight(text)
+
+    def out_function(self, fname, name, args):
+        """output function in man"""
+
+        self.data += f'.TH "{name}" 9 "{name}" "{self.man_date}" "Kernel Hacker\'s Manual" LINUX' + "\n"
+
+        self.data += ".SH NAME\n"
+        self.data += f"{name} \\- {args['purpose']}\n"
+
+        self.data += ".SH SYNOPSIS\n"
+        if args.get('functiontype', ''):
+            self.data += f'.B "{args["functiontype"]}" {name}' + "\n"
+        else:
+            self.data += f'.B "{name}' + "\n"
+
+        count = 0
+        parenth = "("
+        post = ","
+
+        for parameter in args.parameterlist:
+            if count == len(args.parameterlist) - 1:
+                post = ");"
+
+            dtype = args.parametertypes.get(parameter, "")
+            if function_pointer.match(dtype):
+                # Pointer-to-function
+                self.data += f'".BI "{parenth}{function_pointer.group(1)}" " ") ({function_pointer.group(2)}){post}"' + "\n"
+            else:
+                dtype = KernRe(r'([^\*])$').sub(r'\1 ', dtype)
+
+                self.data += f'.BI "{parenth}{dtype}"  "{post}"' + "\n"
+            count += 1
+            parenth = ""
+
+        if args.parameterlist:
+            self.data += ".SH ARGUMENTS\n"
+
+        for parameter in args.parameterlist:
+            parameter_name = re.sub(r'\[.*', '', parameter)
+
+            self.data += f'.IP "{parameter}" 12' + "\n"
+            self.output_highlight(args.parameterdescs.get(parameter_name, ""))
+
+        for section, text in args.sections.items():
+            self.data += f'.SH "{section.upper()}"' + "\n"
+            self.output_highlight(text)
+
+    def out_enum(self, fname, name, args):
+        self.data += f'.TH "{self.modulename}" 9 "enum {name}" "{self.man_date}" "API Manual" LINUX' + "\n"
+
+        self.data += ".SH NAME\n"
+        self.data += f"enum {name} \\- {args['purpose']}\n"
+
+        self.data += ".SH SYNOPSIS\n"
+        self.data += f"enum {name}" + " {\n"
+
+        count = 0
+        for parameter in args.parameterlist:
+            self.data += f'.br\n.BI "    {parameter}"' + "\n"
+            if count == len(args.parameterlist) - 1:
+                self.data += "\n};\n"
+            else:
+                self.data += ", \n.br\n"
+
+            count += 1
+
+        self.data += ".SH Constants\n"
+
+        for parameter in args.parameterlist:
+            parameter_name = KernRe(r'\[.*').sub('', parameter)
+            self.data += f'.IP "{parameter}" 12' + "\n"
+            self.output_highlight(args.parameterdescs.get(parameter_name, ""))
+
+        for section, text in args.sections.items():
+            self.data += f'.SH "{section}"' + "\n"
+            self.output_highlight(text)
+
+    def out_typedef(self, fname, name, args):
+        module = self.modulename
+        purpose = args.get('purpose')
+
+        self.data += f'.TH "{module}" 9 "{name}" "{self.man_date}" "API Manual" LINUX' + "\n"
+
+        self.data += ".SH NAME\n"
+        self.data += f"typedef {name} \\- {purpose}\n"
+
+        for section, text in args.sections.items():
+            self.data += f'.SH "{section}"' + "\n"
+            self.output_highlight(text)
+
+    def out_struct(self, fname, name, args):
+        module = self.modulename
+        purpose = args.get('purpose')
+        definition = args.get('definition')
+
+        self.data += f'.TH "{module}" 9 "{args.type} {name}" "{self.man_date}" "API Manual" LINUX' + "\n"
+
+        self.data += ".SH NAME\n"
+        self.data += f"{args.type} {name} \\- {purpose}\n"
+
+        # Replace tabs with two spaces and handle newlines
+        declaration = definition.replace("\t", "  ")
+        declaration = KernRe(r"\n").sub('"\n.br\n.BI "', declaration)
+
+        self.data += ".SH SYNOPSIS\n"
+        self.data += f"{args.type} {name} " + "{" + "\n.br\n"
+        self.data += f'.BI "{declaration}\n' + "};\n.br\n\n"
+
+        self.data += ".SH Members\n"
+        for parameter in args.parameterlist:
+            if parameter.startswith("#"):
+                continue
+
+            parameter_name = re.sub(r"\[.*", "", parameter)
+
+            if args.parameterdescs.get(parameter_name) == KernelDoc.undescribed:
+                continue
+
+            self.data += f'.IP "{parameter}" 12' + "\n"
+            self.output_highlight(args.parameterdescs.get(parameter_name))
+
+        for section, text in args.sections.items():
+            self.data += f'.SH "{section}"' + "\n"
+            self.output_highlight(text)
diff --git a/scripts/lib/kdoc/kdoc_parser.py b/scripts/lib/kdoc/kdoc_parser.py
new file mode 100644
index 00000000000..fe730099eca
--- /dev/null
+++ b/scripts/lib/kdoc/kdoc_parser.py
@@ -0,0 +1,1669 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0
+# Copyright(c) 2025: Mauro Carvalho Chehab <mchehab@kernel.org>.
+#
+# pylint: disable=C0301,C0302,R0904,R0912,R0913,R0914,R0915,R0917,R1702
+
+"""
+kdoc_parser
+===========
+
+Read a C language source or header FILE and extract embedded
+documentation comments
+"""
+
+import sys
+import re
+from pprint import pformat
+
+from kdoc_re import NestedMatch, KernRe
+from kdoc_item import KdocItem
+
+#
+# Regular expressions used to parse kernel-doc markups at KernelDoc class.
+#
+# Let's declare them in lowercase outside any class to make easier to
+# convert from the python script.
+#
+# As those are evaluated at the beginning, no need to cache them
+#
+
+# Allow whitespace at end of comment start.
+doc_start = KernRe(r'^/\*\*\s*$', cache=False)
+
+doc_end = KernRe(r'\*/', cache=False)
+doc_com = KernRe(r'\s*\*\s*', cache=False)
+doc_com_body = KernRe(r'\s*\* ?', cache=False)
+doc_decl = doc_com + KernRe(r'(\w+)', cache=False)
+
+# @params and a strictly limited set of supported section names
+# Specifically:
+#   Match @word:
+#         @...:
+#         @{section-name}:
+# while trying to not match literal block starts like "example::"
+#
+known_section_names = 'description|context|returns?|notes?|examples?'
+known_sections = KernRe(known_section_names, flags = re.I)
+doc_sect = doc_com + \
+    KernRe(r'\s*(\@[.\w]+|\@\.\.\.|' + known_section_names + r')\s*:([^:].*)?$',
+           flags=re.I, cache=False)
+
+doc_content = doc_com_body + KernRe(r'(.*)', cache=False)
+doc_inline_start = KernRe(r'^\s*/\*\*\s*$', cache=False)
+doc_inline_sect = KernRe(r'\s*\*\s*(@\s*[\w][\w\.]*\s*):(.*)', cache=False)
+doc_inline_end = KernRe(r'^\s*\*/\s*$', cache=False)
+doc_inline_oneline = KernRe(r'^\s*/\*\*\s*(@[\w\s]+):\s*(.*)\s*\*/\s*$', cache=False)
+attribute = KernRe(r"__attribute__\s*\(\([a-z0-9,_\*\s\(\)]*\)\)",
+               flags=re.I | re.S, cache=False)
+
+export_symbol = KernRe(r'^\s*EXPORT_SYMBOL(_GPL)?\s*\(\s*(\w+)\s*\)\s*', cache=False)
+export_symbol_ns = KernRe(r'^\s*EXPORT_SYMBOL_NS(_GPL)?\s*\(\s*(\w+)\s*,\s*"\S+"\)\s*', cache=False)
+
+type_param = KernRe(r"\@(\w*((\.\w+)|(->\w+))*(\.\.\.)?)", cache=False)
+
+#
+# Tests for the beginning of a kerneldoc block in its various forms.
+#
+doc_block = doc_com + KernRe(r'DOC:\s*(.*)?', cache=False)
+doc_begin_data = KernRe(r"^\s*\*?\s*(struct|union|enum|typedef)\b\s*(\w*)", cache = False)
+doc_begin_func = KernRe(str(doc_com) +			# initial " * '
+                        r"(?:\w+\s*\*\s*)?" + 		# type (not captured)
+                        r'(?:define\s+)?' + 		# possible "define" (not captured)
+                        r'(\w+)\s*(?:\(\w*\))?\s*' +	# name and optional "(...)"
+                        r'(?:[-:].*)?$',		# description (not captured)
+                        cache = False)
+
+#
+# A little helper to get rid of excess white space
+#
+multi_space = KernRe(r'\s\s+')
+def trim_whitespace(s):
+    return multi_space.sub(' ', s.strip())
+
+class state:
+    """
+    State machine enums
+    """
+
+    # Parser states
+    NORMAL        = 0        # normal code
+    NAME          = 1        # looking for function name
+    DECLARATION   = 2        # We have seen a declaration which might not be done
+    BODY          = 3        # the body of the comment
+    SPECIAL_SECTION = 4      # doc section ending with a blank line
+    PROTO         = 5        # scanning prototype
+    DOCBLOCK      = 6        # documentation block
+    INLINE_NAME   = 7        # gathering doc outside main block
+    INLINE_TEXT   = 8	     # reading the body of inline docs
+
+    name = [
+        "NORMAL",
+        "NAME",
+        "DECLARATION",
+        "BODY",
+        "SPECIAL_SECTION",
+        "PROTO",
+        "DOCBLOCK",
+        "INLINE_NAME",
+        "INLINE_TEXT",
+    ]
+
+
+SECTION_DEFAULT = "Description"  # default section
+
+class KernelEntry:
+
+    def __init__(self, config, ln):
+        self.config = config
+
+        self._contents = []
+        self.prototype = ""
+
+        self.warnings = []
+
+        self.parameterlist = []
+        self.parameterdescs = {}
+        self.parametertypes = {}
+        self.parameterdesc_start_lines = {}
+
+        self.section_start_lines = {}
+        self.sections = {}
+
+        self.anon_struct_union = False
+
+        self.leading_space = None
+
+        # State flags
+        self.brcount = 0
+        self.declaration_start_line = ln + 1
+
+    #
+    # Management of section contents
+    #
+    def add_text(self, text):
+        self._contents.append(text)
+
+    def contents(self):
+        return '\n'.join(self._contents) + '\n'
+
+    # TODO: rename to emit_message after removal of kernel-doc.pl
+    def emit_msg(self, log_msg, warning=True):
+        """Emit a message"""
+
+        if not warning:
+            self.config.log.info(log_msg)
+            return
+
+        # Delegate warning output to output logic, as this way it
+        # will report warnings/info only for symbols that are output
+
+        self.warnings.append(log_msg)
+        return
+
+    #
+    # Begin a new section.
+    #
+    def begin_section(self, line_no, title = SECTION_DEFAULT, dump = False):
+        if dump:
+            self.dump_section(start_new = True)
+        self.section = title
+        self.new_start_line = line_no
+
+    def dump_section(self, start_new=True):
+        """
+        Dumps section contents to arrays/hashes intended for that purpose.
+        """
+        #
+        # If we have accumulated no contents in the default ("description")
+        # section, don't bother.
+        #
+        if self.section == SECTION_DEFAULT and not self._contents:
+            return
+        name = self.section
+        contents = self.contents()
+
+        if type_param.match(name):
+            name = type_param.group(1)
+
+            self.parameterdescs[name] = contents
+            self.parameterdesc_start_lines[name] = self.new_start_line
+
+            self.new_start_line = 0
+
+        else:
+            if name in self.sections and self.sections[name] != "":
+                # Only warn on user-specified duplicate section names
+                if name != SECTION_DEFAULT:
+                    self.emit_msg(self.new_start_line,
+                                  f"duplicate section name '{name}'\n")
+                # Treat as a new paragraph - add a blank line
+                self.sections[name] += '\n' + contents
+            else:
+                self.sections[name] = contents
+                self.section_start_lines[name] = self.new_start_line
+                self.new_start_line = 0
+
+#        self.config.log.debug("Section: %s : %s", name, pformat(vars(self)))
+
+        if start_new:
+            self.section = SECTION_DEFAULT
+            self._contents = []
+
+
+class KernelDoc:
+    """
+    Read a C language source or header FILE and extract embedded
+    documentation comments.
+    """
+
+    # Section names
+
+    section_context = "Context"
+    section_return = "Return"
+
+    undescribed = "-- undescribed --"
+
+    def __init__(self, config, fname):
+        """Initialize internal variables"""
+
+        self.fname = fname
+        self.config = config
+
+        # Initial state for the state machines
+        self.state = state.NORMAL
+
+        # Store entry currently being processed
+        self.entry = None
+
+        # Place all potential outputs into an array
+        self.entries = []
+
+        #
+        # We need Python 3.7 for its "dicts remember the insertion
+        # order" guarantee
+        #
+        if sys.version_info.major == 3 and sys.version_info.minor < 7:
+            self.emit_msg(0,
+                          'Python 3.7 or later is required for correct results')
+
+    def emit_msg(self, ln, msg, warning=True):
+        """Emit a message"""
+
+        log_msg = f"{self.fname}:{ln} {msg}"
+
+        if self.entry:
+            self.entry.emit_msg(log_msg, warning)
+            return
+
+        if warning:
+            self.config.log.warning(log_msg)
+        else:
+            self.config.log.info(log_msg)
+
+    def dump_section(self, start_new=True):
+        """
+        Dumps section contents to arrays/hashes intended for that purpose.
+        """
+
+        if self.entry:
+            self.entry.dump_section(start_new)
+
+    # TODO: rename it to store_declaration after removal of kernel-doc.pl
+    def output_declaration(self, dtype, name, **args):
+        """
+        Stores the entry into an entry array.
+
+        The actual output and output filters will be handled elsewhere
+        """
+
+        item = KdocItem(name, dtype, self.entry.declaration_start_line, **args)
+        item.warnings = self.entry.warnings
+
+        # Drop empty sections
+        # TODO: improve empty sections logic to emit warnings
+        sections = self.entry.sections
+        for section in ["Description", "Return"]:
+            if section in sections and not sections[section].rstrip():
+                del sections[section]
+        item.set_sections(sections, self.entry.section_start_lines)
+        item.set_params(self.entry.parameterlist, self.entry.parameterdescs,
+                        self.entry.parametertypes,
+                        self.entry.parameterdesc_start_lines)
+        self.entries.append(item)
+
+        self.config.log.debug("Output: %s:%s = %s", dtype, name, pformat(args))
+
+    def reset_state(self, ln):
+        """
+        Ancillary routine to create a new entry. It initializes all
+        variables used by the state machine.
+        """
+
+        self.entry = KernelEntry(self.config, ln)
+
+        # State flags
+        self.state = state.NORMAL
+
+    def push_parameter(self, ln, decl_type, param, dtype,
+                       org_arg, declaration_name):
+        """
+        Store parameters and their descriptions at self.entry.
+        """
+
+        if self.entry.anon_struct_union and dtype == "" and param == "}":
+            return  # Ignore the ending }; from anonymous struct/union
+
+        self.entry.anon_struct_union = False
+
+        param = KernRe(r'[\[\)].*').sub('', param, count=1)
+
+        if dtype == "" and param.endswith("..."):
+            if KernRe(r'\w\.\.\.$').search(param):
+                # For named variable parameters of the form `x...`,
+                # remove the dots
+                param = param[:-3]
+            else:
+                # Handles unnamed variable parameters
+                param = "..."
+
+            if param not in self.entry.parameterdescs or \
+                not self.entry.parameterdescs[param]:
+
+                self.entry.parameterdescs[param] = "variable arguments"
+
+        elif dtype == "" and (not param or param == "void"):
+            param = "void"
+            self.entry.parameterdescs[param] = "no arguments"
+
+        elif dtype == "" and param in ["struct", "union"]:
+            # Handle unnamed (anonymous) union or struct
+            dtype = param
+            param = "{unnamed_" + param + "}"
+            self.entry.parameterdescs[param] = "anonymous\n"
+            self.entry.anon_struct_union = True
+
+        # Handle cache group enforcing variables: they do not need
+        # to be described in header files
+        elif "__cacheline_group" in param:
+            # Ignore __cacheline_group_begin and __cacheline_group_end
+            return
+
+        # Warn if parameter has no description
+        # (but ignore ones starting with # as these are not parameters
+        # but inline preprocessor statements)
+        if param not in self.entry.parameterdescs and not param.startswith("#"):
+            self.entry.parameterdescs[param] = self.undescribed
+
+            if "." not in param:
+                if decl_type == 'function':
+                    dname = f"{decl_type} parameter"
+                else:
+                    dname = f"{decl_type} member"
+
+                self.emit_msg(ln,
+                              f"{dname} '{param}' not described in '{declaration_name}'")
+
+        # Strip spaces from param so that it is one continuous string on
+        # parameterlist. This fixes a problem where check_sections()
+        # cannot find a parameter like "addr[6 + 2]" because it actually
+        # appears as "addr[6", "+", "2]" on the parameter list.
+        # However, it's better to maintain the param string unchanged for
+        # output, so just weaken the string compare in check_sections()
+        # to ignore "[blah" in a parameter string.
+
+        self.entry.parameterlist.append(param)
+        org_arg = KernRe(r'\s\s+').sub(' ', org_arg)
+        self.entry.parametertypes[param] = org_arg
+
+
+    def create_parameter_list(self, ln, decl_type, args,
+                              splitter, declaration_name):
+        """
+        Creates a list of parameters, storing them at self.entry.
+        """
+
+        # temporarily replace all commas inside function pointer definition
+        arg_expr = KernRe(r'(\([^\),]+),')
+        while arg_expr.search(args):
+            args = arg_expr.sub(r"\1#", args)
+
+        for arg in args.split(splitter):
+            # Strip comments
+            arg = KernRe(r'\/\*.*\*\/').sub('', arg)
+
+            # Ignore argument attributes
+            arg = KernRe(r'\sPOS0?\s').sub(' ', arg)
+
+            # Strip leading/trailing spaces
+            arg = arg.strip()
+            arg = KernRe(r'\s+').sub(' ', arg, count=1)
+
+            if arg.startswith('#'):
+                # Treat preprocessor directive as a typeless variable just to fill
+                # corresponding data structures "correctly". Catch it later in
+                # output_* subs.
+
+                # Treat preprocessor directive as a typeless variable
+                self.push_parameter(ln, decl_type, arg, "",
+                                    "", declaration_name)
+
+            elif KernRe(r'\(.+\)\s*\(').search(arg):
+                # Pointer-to-function
+
+                arg = arg.replace('#', ',')
+
+                r = KernRe(r'[^\(]+\(\*?\s*([\w\[\]\.]*)\s*\)')
+                if r.match(arg):
+                    param = r.group(1)
+                else:
+                    self.emit_msg(ln, f"Invalid param: {arg}")
+                    param = arg
+
+                dtype = KernRe(r'([^\(]+\(\*?)\s*' + re.escape(param)).sub(r'\1', arg)
+                self.push_parameter(ln, decl_type, param, dtype,
+                                    arg, declaration_name)
+
+            elif KernRe(r'\(.+\)\s*\[').search(arg):
+                # Array-of-pointers
+
+                arg = arg.replace('#', ',')
+                r = KernRe(r'[^\(]+\(\s*\*\s*([\w\[\]\.]*?)\s*(\s*\[\s*[\w]+\s*\]\s*)*\)')
+                if r.match(arg):
+                    param = r.group(1)
+                else:
+                    self.emit_msg(ln, f"Invalid param: {arg}")
+                    param = arg
+
+                dtype = KernRe(r'([^\(]+\(\*?)\s*' + re.escape(param)).sub(r'\1', arg)
+
+                self.push_parameter(ln, decl_type, param, dtype,
+                                    arg, declaration_name)
+
+            elif arg:
+                arg = KernRe(r'\s*:\s*').sub(":", arg)
+                arg = KernRe(r'\s*\[').sub('[', arg)
+
+                args = KernRe(r'\s*,\s*').split(arg)
+                if args[0] and '*' in args[0]:
+                    args[0] = re.sub(r'(\*+)\s*', r' \1', args[0])
+
+                first_arg = []
+                r = KernRe(r'^(.*\s+)(.*?\[.*\].*)$')
+                if args[0] and r.match(args[0]):
+                    args.pop(0)
+                    first_arg.extend(r.group(1))
+                    first_arg.append(r.group(2))
+                else:
+                    first_arg = KernRe(r'\s+').split(args.pop(0))
+
+                args.insert(0, first_arg.pop())
+                dtype = ' '.join(first_arg)
+
+                for param in args:
+                    if KernRe(r'^(\*+)\s*(.*)').match(param):
+                        r = KernRe(r'^(\*+)\s*(.*)')
+                        if not r.match(param):
+                            self.emit_msg(ln, f"Invalid param: {param}")
+                            continue
+
+                        param = r.group(1)
+
+                        self.push_parameter(ln, decl_type, r.group(2),
+                                            f"{dtype} {r.group(1)}",
+                                            arg, declaration_name)
+
+                    elif KernRe(r'(.*?):(\w+)').search(param):
+                        r = KernRe(r'(.*?):(\w+)')
+                        if not r.match(param):
+                            self.emit_msg(ln, f"Invalid param: {param}")
+                            continue
+
+                        if dtype != "":  # Skip unnamed bit-fields
+                            self.push_parameter(ln, decl_type, r.group(1),
+                                                f"{dtype}:{r.group(2)}",
+                                                arg, declaration_name)
+                    else:
+                        self.push_parameter(ln, decl_type, param, dtype,
+                                            arg, declaration_name)
+
+    def check_sections(self, ln, decl_name, decl_type):
+        """
+        Check for errors inside sections, emitting warnings if not found
+        parameters are described.
+        """
+        for section in self.entry.sections:
+            if section not in self.entry.parameterlist and \
+               not known_sections.search(section):
+                if decl_type == 'function':
+                    dname = f"{decl_type} parameter"
+                else:
+                    dname = f"{decl_type} member"
+                self.emit_msg(ln,
+                              f"Excess {dname} '{section}' description in '{decl_name}'")
+
+    def check_return_section(self, ln, declaration_name, return_type):
+        """
+        If the function doesn't return void, warns about the lack of a
+        return description.
+        """
+
+        if not self.config.wreturn:
+            return
+
+        # Ignore an empty return type (It's a macro)
+        # Ignore functions with a "void" return type (but not "void *")
+        if not return_type or KernRe(r'void\s*\w*\s*$').search(return_type):
+            return
+
+        if not self.entry.sections.get("Return", None):
+            self.emit_msg(ln,
+                          f"No description found for return value of '{declaration_name}'")
+
+    def dump_struct(self, ln, proto):
+        """
+        Store an entry for an struct or union
+        """
+
+        type_pattern = r'(struct|union)'
+
+        qualifiers = [
+            "__attribute__",
+            "__packed",
+            "__aligned",
+            "____cacheline_aligned_in_smp",
+            "____cacheline_aligned",
+        ]
+
+        definition_body = r'\{(.*)\}\s*' + "(?:" + '|'.join(qualifiers) + ")?"
+        struct_members = KernRe(type_pattern + r'([^\{\};]+)(\{)([^\{\}]*)(\})([^\{\}\;]*)(\;)')
+
+        # Extract struct/union definition
+        members = None
+        declaration_name = None
+        decl_type = None
+
+        r = KernRe(type_pattern + r'\s+(\w+)\s*' + definition_body)
+        if r.search(proto):
+            decl_type = r.group(1)
+            declaration_name = r.group(2)
+            members = r.group(3)
+        else:
+            r = KernRe(r'typedef\s+' + type_pattern + r'\s*' + definition_body + r'\s*(\w+)\s*;')
+
+            if r.search(proto):
+                decl_type = r.group(1)
+                declaration_name = r.group(3)
+                members = r.group(2)
+
+        if not members:
+            self.emit_msg(ln, f"{proto} error: Cannot parse struct or union!")
+            return
+
+        if self.entry.identifier != declaration_name:
+            self.emit_msg(ln,
+                          f"expecting prototype for {decl_type} {self.entry.identifier}. Prototype was for {decl_type} {declaration_name} instead\n")
+            return
+
+        args_pattern = r'([^,)]+)'
+
+        sub_prefixes = [
+            (KernRe(r'\/\*\s*private:.*?\/\*\s*public:.*?\*\/', re.S | re.I), ''),
+            (KernRe(r'\/\*\s*private:.*', re.S | re.I), ''),
+
+            # Strip comments
+            (KernRe(r'\/\*.*?\*\/', re.S), ''),
+
+            # Strip attributes
+            (attribute, ' '),
+            (KernRe(r'\s*__aligned\s*\([^;]*\)', re.S), ' '),
+            (KernRe(r'\s*__counted_by\s*\([^;]*\)', re.S), ' '),
+            (KernRe(r'\s*__counted_by_(le|be)\s*\([^;]*\)', re.S), ' '),
+            (KernRe(r'\s*__packed\s*', re.S), ' '),
+            (KernRe(r'\s*CRYPTO_MINALIGN_ATTR', re.S), ' '),
+            (KernRe(r'\s*____cacheline_aligned_in_smp', re.S), ' '),
+            (KernRe(r'\s*____cacheline_aligned', re.S), ' '),
+
+            # Unwrap struct_group macros based on this definition:
+            # __struct_group(TAG, NAME, ATTRS, MEMBERS...)
+            # which has variants like: struct_group(NAME, MEMBERS...)
+            # Only MEMBERS arguments require documentation.
+            #
+            # Parsing them happens on two steps:
+            #
+            # 1. drop struct group arguments that aren't at MEMBERS,
+            #    storing them as STRUCT_GROUP(MEMBERS)
+            #
+            # 2. remove STRUCT_GROUP() ancillary macro.
+            #
+            # The original logic used to remove STRUCT_GROUP() using an
+            # advanced regex:
+            #
+            #   \bSTRUCT_GROUP(\(((?:(?>[^)(]+)|(?1))*)\))[^;]*;
+            #
+            # with two patterns that are incompatible with
+            # Python re module, as it has:
+            #
+            #   - a recursive pattern: (?1)
+            #   - an atomic grouping: (?>...)
+            #
+            # I tried a simpler version: but it didn't work either:
+            #   \bSTRUCT_GROUP\(([^\)]+)\)[^;]*;
+            #
+            # As it doesn't properly match the end parenthesis on some cases.
+            #
+            # So, a better solution was crafted: there's now a NestedMatch
+            # class that ensures that delimiters after a search are properly
+            # matched. So, the implementation to drop STRUCT_GROUP() will be
+            # handled in separate.
+
+            (KernRe(r'\bstruct_group\s*\(([^,]*,)', re.S), r'STRUCT_GROUP('),
+            (KernRe(r'\bstruct_group_attr\s*\(([^,]*,){2}', re.S), r'STRUCT_GROUP('),
+            (KernRe(r'\bstruct_group_tagged\s*\(([^,]*),([^,]*),', re.S), r'struct \1 \2; STRUCT_GROUP('),
+            (KernRe(r'\b__struct_group\s*\(([^,]*,){3}', re.S), r'STRUCT_GROUP('),
+
+            # Replace macros
+            #
+            # TODO: use NestedMatch for FOO($1, $2, ...) matches
+            #
+            # it is better to also move those to the NestedMatch logic,
+            # to ensure that parenthesis will be properly matched.
+
+            (KernRe(r'__ETHTOOL_DECLARE_LINK_MODE_MASK\s*\(([^\)]+)\)', re.S), r'DECLARE_BITMAP(\1, __ETHTOOL_LINK_MODE_MASK_NBITS)'),
+            (KernRe(r'DECLARE_PHY_INTERFACE_MASK\s*\(([^\)]+)\)', re.S), r'DECLARE_BITMAP(\1, PHY_INTERFACE_MODE_MAX)'),
+            (KernRe(r'DECLARE_BITMAP\s*\(' + args_pattern + r',\s*' + args_pattern + r'\)', re.S), r'unsigned long \1[BITS_TO_LONGS(\2)]'),
+            (KernRe(r'DECLARE_HASHTABLE\s*\(' + args_pattern + r',\s*' + args_pattern + r'\)', re.S), r'unsigned long \1[1 << ((\2) - 1)]'),
+            (KernRe(r'DECLARE_KFIFO\s*\(' + args_pattern + r',\s*' + args_pattern + r',\s*' + args_pattern + r'\)', re.S), r'\2 *\1'),
+            (KernRe(r'DECLARE_KFIFO_PTR\s*\(' + args_pattern + r',\s*' + args_pattern + r'\)', re.S), r'\2 *\1'),
+            (KernRe(r'(?:__)?DECLARE_FLEX_ARRAY\s*\(' + args_pattern + r',\s*' + args_pattern + r'\)', re.S), r'\1 \2[]'),
+            (KernRe(r'DEFINE_DMA_UNMAP_ADDR\s*\(' + args_pattern + r'\)', re.S), r'dma_addr_t \1'),
+            (KernRe(r'DEFINE_DMA_UNMAP_LEN\s*\(' + args_pattern + r'\)', re.S), r'__u32 \1'),
+            (KernRe(r'VIRTIO_DECLARE_FEATURES\s*\(' + args_pattern + r'\)', re.S), r'u64 \1; u64 \1_array[VIRTIO_FEATURES_DWORDS]'),
+        ]
+
+        # Regexes here are guaranteed to have the end limiter matching
+        # the start delimiter. Yet, right now, only one replace group
+        # is allowed.
+
+        sub_nested_prefixes = [
+            (re.compile(r'\bSTRUCT_GROUP\('), r'\1'),
+        ]
+
+        for search, sub in sub_prefixes:
+            members = search.sub(sub, members)
+
+        nested = NestedMatch()
+
+        for search, sub in sub_nested_prefixes:
+            members = nested.sub(search, sub, members)
+
+        # Keeps the original declaration as-is
+        declaration = members
+
+        # Split nested struct/union elements
+        #
+        # This loop was simpler at the original kernel-doc perl version, as
+        #   while ($members =~ m/$struct_members/) { ... }
+        # reads 'members' string on each interaction.
+        #
+        # Python behavior is different: it parses 'members' only once,
+        # creating a list of tuples from the first interaction.
+        #
+        # On other words, this won't get nested structs.
+        #
+        # So, we need to have an extra loop on Python to override such
+        # re limitation.
+
+        while True:
+            tuples = struct_members.findall(members)
+            if not tuples:
+                break
+
+            for t in tuples:
+                newmember = ""
+                maintype = t[0]
+                s_ids = t[5]
+                content = t[3]
+
+                oldmember = "".join(t)
+
+                for s_id in s_ids.split(','):
+                    s_id = s_id.strip()
+
+                    newmember += f"{maintype} {s_id}; "
+                    s_id = KernRe(r'[:\[].*').sub('', s_id)
+                    s_id = KernRe(r'^\s*\**(\S+)\s*').sub(r'\1', s_id)
+
+                    for arg in content.split(';'):
+                        arg = arg.strip()
+
+                        if not arg:
+                            continue
+
+                        r = KernRe(r'^([^\(]+\(\*?\s*)([\w\.]*)(\s*\).*)')
+                        if r.match(arg):
+                            # Pointer-to-function
+                            dtype = r.group(1)
+                            name = r.group(2)
+                            extra = r.group(3)
+
+                            if not name:
+                                continue
+
+                            if not s_id:
+                                # Anonymous struct/union
+                                newmember += f"{dtype}{name}{extra}; "
+                            else:
+                                newmember += f"{dtype}{s_id}.{name}{extra}; "
+
+                        else:
+                            arg = arg.strip()
+                            # Handle bitmaps
+                            arg = KernRe(r':\s*\d+\s*').sub('', arg)
+
+                            # Handle arrays
+                            arg = KernRe(r'\[.*\]').sub('', arg)
+
+                            # Handle multiple IDs
+                            arg = KernRe(r'\s*,\s*').sub(',', arg)
+
+                            r = KernRe(r'(.*)\s+([\S+,]+)')
+
+                            if r.search(arg):
+                                dtype = r.group(1)
+                                names = r.group(2)
+                            else:
+                                newmember += f"{arg}; "
+                                continue
+
+                            for name in names.split(','):
+                                name = KernRe(r'^\s*\**(\S+)\s*').sub(r'\1', name).strip()
+
+                                if not name:
+                                    continue
+
+                                if not s_id:
+                                    # Anonymous struct/union
+                                    newmember += f"{dtype} {name}; "
+                                else:
+                                    newmember += f"{dtype} {s_id}.{name}; "
+
+                members = members.replace(oldmember, newmember)
+
+        # Ignore other nested elements, like enums
+        members = re.sub(r'(\{[^\{\}]*\})', '', members)
+
+        self.create_parameter_list(ln, decl_type, members, ';',
+                                   declaration_name)
+        self.check_sections(ln, declaration_name, decl_type)
+
+        # Adjust declaration for better display
+        declaration = KernRe(r'([\{;])').sub(r'\1\n', declaration)
+        declaration = KernRe(r'\}\s+;').sub('};', declaration)
+
+        # Better handle inlined enums
+        while True:
+            r = KernRe(r'(enum\s+\{[^\}]+),([^\n])')
+            if not r.search(declaration):
+                break
+
+            declaration = r.sub(r'\1,\n\2', declaration)
+
+        def_args = declaration.split('\n')
+        level = 1
+        declaration = ""
+        for clause in def_args:
+
+            clause = clause.strip()
+            clause = KernRe(r'\s+').sub(' ', clause, count=1)
+
+            if not clause:
+                continue
+
+            if '}' in clause and level > 1:
+                level -= 1
+
+            if not KernRe(r'^\s*#').match(clause):
+                declaration += "\t" * level
+
+            declaration += "\t" + clause + "\n"
+            if "{" in clause and "}" not in clause:
+                level += 1
+
+        self.output_declaration(decl_type, declaration_name,
+                                definition=declaration,
+                                purpose=self.entry.declaration_purpose)
+
+    def dump_enum(self, ln, proto):
+        """
+        Stores an enum inside self.entries array.
+        """
+
+        # Ignore members marked private
+        proto = KernRe(r'\/\*\s*private:.*?\/\*\s*public:.*?\*\/', flags=re.S).sub('', proto)
+        proto = KernRe(r'\/\*\s*private:.*}', flags=re.S).sub('}', proto)
+
+        # Strip comments
+        proto = KernRe(r'\/\*.*?\*\/', flags=re.S).sub('', proto)
+
+        # Strip #define macros inside enums
+        proto = KernRe(r'#\s*((define|ifdef|if)\s+|endif)[^;]*;', flags=re.S).sub('', proto)
+
+        #
+        # Parse out the name and members of the enum.  Typedef form first.
+        #
+        r = KernRe(r'typedef\s+enum\s*\{(.*)\}\s*(\w*)\s*;')
+        if r.search(proto):
+            declaration_name = r.group(2)
+            members = r.group(1).rstrip()
+        #
+        # Failing that, look for a straight enum
+        #
+        else:
+            r = KernRe(r'enum\s+(\w*)\s*\{(.*)\}')
+            if r.match(proto):
+                declaration_name = r.group(1)
+                members = r.group(2).rstrip()
+        #
+        # OK, this isn't going to work.
+        #
+            else:
+                self.emit_msg(ln, f"{proto}: error: Cannot parse enum!")
+                return
+        #
+        # Make sure we found what we were expecting.
+        #
+        if self.entry.identifier != declaration_name:
+            if self.entry.identifier == "":
+                self.emit_msg(ln,
+                              f"{proto}: wrong kernel-doc identifier on prototype")
+            else:
+                self.emit_msg(ln,
+                              f"expecting prototype for enum {self.entry.identifier}. "
+                              f"Prototype was for enum {declaration_name} instead")
+            return
+
+        if not declaration_name:
+            declaration_name = "(anonymous)"
+        #
+        # Parse out the name of each enum member, and verify that we
+        # have a description for it.
+        #
+        member_set = set()
+        members = KernRe(r'\([^;)]*\)').sub('', members)
+        for arg in members.split(','):
+            if not arg:
+                continue
+            arg = KernRe(r'^\s*(\w+).*').sub(r'\1', arg)
+            self.entry.parameterlist.append(arg)
+            if arg not in self.entry.parameterdescs:
+                self.entry.parameterdescs[arg] = self.undescribed
+                self.emit_msg(ln,
+                              f"Enum value '{arg}' not described in enum '{declaration_name}'")
+            member_set.add(arg)
+        #
+        # Ensure that every described member actually exists in the enum.
+        #
+        for k in self.entry.parameterdescs:
+            if k not in member_set:
+                self.emit_msg(ln,
+                              f"Excess enum value '%{k}' description in '{declaration_name}'")
+
+        self.output_declaration('enum', declaration_name,
+                                purpose=self.entry.declaration_purpose)
+
+    def dump_declaration(self, ln, prototype):
+        """
+        Stores a data declaration inside self.entries array.
+        """
+
+        if self.entry.decl_type == "enum":
+            self.dump_enum(ln, prototype)
+        elif self.entry.decl_type == "typedef":
+            self.dump_typedef(ln, prototype)
+        elif self.entry.decl_type in ["union", "struct"]:
+            self.dump_struct(ln, prototype)
+        else:
+            # This would be a bug
+            self.emit_message(ln, f'Unknown declaration type: {self.entry.decl_type}')
+
+    def dump_function(self, ln, prototype):
+        """
+        Stores a function of function macro inside self.entries array.
+        """
+
+        func_macro = False
+        return_type = ''
+        decl_type = 'function'
+
+        # Prefixes that would be removed
+        sub_prefixes = [
+            (r"^static +", "", 0),
+            (r"^extern +", "", 0),
+            (r"^asmlinkage +", "", 0),
+            (r"^inline +", "", 0),
+            (r"^__inline__ +", "", 0),
+            (r"^__inline +", "", 0),
+            (r"^__always_inline +", "", 0),
+            (r"^noinline +", "", 0),
+            (r"^__FORTIFY_INLINE +", "", 0),
+            (r"__init +", "", 0),
+            (r"__init_or_module +", "", 0),
+            (r"__deprecated +", "", 0),
+            (r"__flatten +", "", 0),
+            (r"__meminit +", "", 0),
+            (r"__must_check +", "", 0),
+            (r"__weak +", "", 0),
+            (r"__sched +", "", 0),
+            (r"_noprof", "", 0),
+            (r"__printf\s*\(\s*\d*\s*,\s*\d*\s*\) +", "", 0),
+            (r"__(?:re)?alloc_size\s*\(\s*\d+\s*(?:,\s*\d+\s*)?\) +", "", 0),
+            (r"__diagnose_as\s*\(\s*\S+\s*(?:,\s*\d+\s*)*\) +", "", 0),
+            (r"DECL_BUCKET_PARAMS\s*\(\s*(\S+)\s*,\s*(\S+)\s*\)", r"\1, \2", 0),
+            (r"__attribute_const__ +", "", 0),
+
+            # It seems that Python support for re.X is broken:
+            # At least for me (Python 3.13), this didn't work
+#            (r"""
+#              __attribute__\s*\(\(
+#                (?:
+#                    [\w\s]+          # attribute name
+#                    (?:\([^)]*\))?   # attribute arguments
+#                    \s*,?            # optional comma at the end
+#                )+
+#              \)\)\s+
+#             """, "", re.X),
+
+            # So, remove whitespaces and comments from it
+            (r"__attribute__\s*\(\((?:[\w\s]+(?:\([^)]*\))?\s*,?)+\)\)\s+", "", 0),
+        ]
+
+        for search, sub, flags in sub_prefixes:
+            prototype = KernRe(search, flags).sub(sub, prototype)
+
+        # Macros are a special case, as they change the prototype format
+        new_proto = KernRe(r"^#\s*define\s+").sub("", prototype)
+        if new_proto != prototype:
+            is_define_proto = True
+            prototype = new_proto
+        else:
+            is_define_proto = False
+
+        # Yes, this truly is vile.  We are looking for:
+        # 1. Return type (may be nothing if we're looking at a macro)
+        # 2. Function name
+        # 3. Function parameters.
+        #
+        # All the while we have to watch out for function pointer parameters
+        # (which IIRC is what the two sections are for), C types (these
+        # regexps don't even start to express all the possibilities), and
+        # so on.
+        #
+        # If you mess with these regexps, it's a good idea to check that
+        # the following functions' documentation still comes out right:
+        # - parport_register_device (function pointer parameters)
+        # - atomic_set (macro)
+        # - pci_match_device, __copy_to_user (long return type)
+
+        name = r'[a-zA-Z0-9_~:]+'
+        prototype_end1 = r'[^\(]*'
+        prototype_end2 = r'[^\{]*'
+        prototype_end = fr'\(({prototype_end1}|{prototype_end2})\)'
+
+        # Besides compiling, Perl qr{[\w\s]+} works as a non-capturing group.
+        # So, this needs to be mapped in Python with (?:...)? or (?:...)+
+
+        type1 = r'(?:[\w\s]+)?'
+        type2 = r'(?:[\w\s]+\*+)+'
+
+        found = False
+
+        if is_define_proto:
+            r = KernRe(r'^()(' + name + r')\s+')
+
+            if r.search(prototype):
+                return_type = ''
+                declaration_name = r.group(2)
+                func_macro = True
+
+                found = True
+
+        if not found:
+            patterns = [
+                rf'^()({name})\s*{prototype_end}',
+                rf'^({type1})\s+({name})\s*{prototype_end}',
+                rf'^({type2})\s*({name})\s*{prototype_end}',
+            ]
+
+            for p in patterns:
+                r = KernRe(p)
+
+                if r.match(prototype):
+
+                    return_type = r.group(1)
+                    declaration_name = r.group(2)
+                    args = r.group(3)
+
+                    self.create_parameter_list(ln, decl_type, args, ',',
+                                               declaration_name)
+
+                    found = True
+                    break
+        if not found:
+            self.emit_msg(ln,
+                          f"cannot understand function prototype: '{prototype}'")
+            return
+
+        if self.entry.identifier != declaration_name:
+            self.emit_msg(ln,
+                          f"expecting prototype for {self.entry.identifier}(). Prototype was for {declaration_name}() instead")
+            return
+
+        self.check_sections(ln, declaration_name, "function")
+
+        self.check_return_section(ln, declaration_name, return_type)
+
+        if 'typedef' in return_type:
+            self.output_declaration(decl_type, declaration_name,
+                                    typedef=True,
+                                    functiontype=return_type,
+                                    purpose=self.entry.declaration_purpose,
+                                    func_macro=func_macro)
+        else:
+            self.output_declaration(decl_type, declaration_name,
+                                    typedef=False,
+                                    functiontype=return_type,
+                                    purpose=self.entry.declaration_purpose,
+                                    func_macro=func_macro)
+
+    def dump_typedef(self, ln, proto):
+        """
+        Stores a typedef inside self.entries array.
+        """
+
+        typedef_type = r'((?:\s+[\w\*]+\b){0,7}\s+(?:\w+\b|\*+))\s*'
+        typedef_ident = r'\*?\s*(\w\S+)\s*'
+        typedef_args = r'\s*\((.*)\);'
+
+        typedef1 = KernRe(r'typedef' + typedef_type + r'\(' + typedef_ident + r'\)' + typedef_args)
+        typedef2 = KernRe(r'typedef' + typedef_type + typedef_ident + typedef_args)
+
+        # Strip comments
+        proto = KernRe(r'/\*.*?\*/', flags=re.S).sub('', proto)
+
+        # Parse function typedef prototypes
+        for r in [typedef1, typedef2]:
+            if not r.match(proto):
+                continue
+
+            return_type = r.group(1).strip()
+            declaration_name = r.group(2)
+            args = r.group(3)
+
+            if self.entry.identifier != declaration_name:
+                self.emit_msg(ln,
+                              f"expecting prototype for typedef {self.entry.identifier}. Prototype was for typedef {declaration_name} instead\n")
+                return
+
+            decl_type = 'function'
+            self.create_parameter_list(ln, decl_type, args, ',', declaration_name)
+
+            self.output_declaration(decl_type, declaration_name,
+                                    typedef=True,
+                                    functiontype=return_type,
+                                    purpose=self.entry.declaration_purpose)
+            return
+
+        # Handle nested parentheses or brackets
+        r = KernRe(r'(\(*.\)\s*|\[*.\]\s*);$')
+        while r.search(proto):
+            proto = r.sub('', proto)
+
+        # Parse simple typedefs
+        r = KernRe(r'typedef.*\s+(\w+)\s*;')
+        if r.match(proto):
+            declaration_name = r.group(1)
+
+            if self.entry.identifier != declaration_name:
+                self.emit_msg(ln,
+                              f"expecting prototype for typedef {self.entry.identifier}. Prototype was for typedef {declaration_name} instead\n")
+                return
+
+            self.output_declaration('typedef', declaration_name,
+                                    purpose=self.entry.declaration_purpose)
+            return
+
+        self.emit_msg(ln, "error: Cannot parse typedef!")
+
+    @staticmethod
+    def process_export(function_set, line):
+        """
+        process EXPORT_SYMBOL* tags
+
+        This method doesn't use any variable from the class, so declare it
+        with a staticmethod decorator.
+        """
+
+        # We support documenting some exported symbols with different
+        # names.  A horrible hack.
+        suffixes = [ '_noprof' ]
+
+        # Note: it accepts only one EXPORT_SYMBOL* per line, as having
+        # multiple export lines would violate Kernel coding style.
+
+        if export_symbol.search(line):
+            symbol = export_symbol.group(2)
+        elif export_symbol_ns.search(line):
+            symbol = export_symbol_ns.group(2)
+        else:
+            return False
+        #
+        # Found an export, trim out any special suffixes
+        #
+        for suffix in suffixes:
+            # Be backward compatible with Python < 3.9
+            if symbol.endswith(suffix):
+                symbol = symbol[:-len(suffix)]
+        function_set.add(symbol)
+        return True
+
+    def process_normal(self, ln, line):
+        """
+        STATE_NORMAL: looking for the /** to begin everything.
+        """
+
+        if not doc_start.match(line):
+            return
+
+        # start a new entry
+        self.reset_state(ln)
+
+        # next line is always the function name
+        self.state = state.NAME
+
+    def process_name(self, ln, line):
+        """
+        STATE_NAME: Looking for the "name - description" line
+        """
+        #
+        # Check for a DOC: block and handle them specially.
+        #
+        if doc_block.search(line):
+
+            if not doc_block.group(1):
+                self.entry.begin_section(ln, "Introduction")
+            else:
+                self.entry.begin_section(ln, doc_block.group(1))
+
+            self.entry.identifier = self.entry.section
+            self.state = state.DOCBLOCK
+        #
+        # Otherwise we're looking for a normal kerneldoc declaration line.
+        #
+        elif doc_decl.search(line):
+            self.entry.identifier = doc_decl.group(1)
+
+            # Test for data declaration
+            if doc_begin_data.search(line):
+                self.entry.decl_type = doc_begin_data.group(1)
+                self.entry.identifier = doc_begin_data.group(2)
+            #
+            # Look for a function description
+            #
+            elif doc_begin_func.search(line):
+                self.entry.identifier = doc_begin_func.group(1)
+                self.entry.decl_type = "function"
+            #
+            # We struck out.
+            #
+            else:
+                self.emit_msg(ln,
+                              f"This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst\n{line}")
+                self.state = state.NORMAL
+                return
+            #
+            # OK, set up for a new kerneldoc entry.
+            #
+            self.state = state.BODY
+            self.entry.identifier = self.entry.identifier.strip(" ")
+            # if there's no @param blocks need to set up default section here
+            self.entry.begin_section(ln + 1)
+            #
+            # Find the description portion, which *should* be there but
+            # isn't always.
+            # (We should be able to capture this from the previous parsing - someday)
+            #
+            r = KernRe("[-:](.*)")
+            if r.search(line):
+                self.entry.declaration_purpose = trim_whitespace(r.group(1))
+                self.state = state.DECLARATION
+            else:
+                self.entry.declaration_purpose = ""
+
+            if not self.entry.declaration_purpose and self.config.wshort_desc:
+                self.emit_msg(ln,
+                              f"missing initial short description on line:\n{line}")
+
+            if not self.entry.identifier and self.entry.decl_type != "enum":
+                self.emit_msg(ln,
+                              f"wrong kernel-doc identifier on line:\n{line}")
+                self.state = state.NORMAL
+
+            if self.config.verbose:
+                self.emit_msg(ln,
+                              f"Scanning doc for {self.entry.decl_type} {self.entry.identifier}",
+                                  warning=False)
+        #
+        # Failed to find an identifier. Emit a warning
+        #
+        else:
+            self.emit_msg(ln, f"Cannot find identifier on line:\n{line}")
+
+    #
+    # Helper function to determine if a new section is being started.
+    #
+    def is_new_section(self, ln, line):
+        if doc_sect.search(line):
+            self.state = state.BODY
+            #
+            # Pick out the name of our new section, tweaking it if need be.
+            #
+            newsection = doc_sect.group(1)
+            if newsection.lower() == 'description':
+                newsection = 'Description'
+            elif newsection.lower() == 'context':
+                newsection = 'Context'
+                self.state = state.SPECIAL_SECTION
+            elif newsection.lower() in ["@return", "@returns",
+                                        "return", "returns"]:
+                newsection = "Return"
+                self.state = state.SPECIAL_SECTION
+            elif newsection[0] == '@':
+                self.state = state.SPECIAL_SECTION
+            #
+            # Initialize the contents, and get the new section going.
+            #
+            newcontents = doc_sect.group(2)
+            if not newcontents:
+                newcontents = ""
+            self.dump_section()
+            self.entry.begin_section(ln, newsection)
+            self.entry.leading_space = None
+
+            self.entry.add_text(newcontents.lstrip())
+            return True
+        return False
+
+    #
+    # Helper function to detect (and effect) the end of a kerneldoc comment.
+    #
+    def is_comment_end(self, ln, line):
+        if doc_end.search(line):
+            self.dump_section()
+
+            # Look for doc_com + <text> + doc_end:
+            r = KernRe(r'\s*\*\s*[a-zA-Z_0-9:\.]+\*/')
+            if r.match(line):
+                self.emit_msg(ln, f"suspicious ending line: {line}")
+
+            self.entry.prototype = ""
+            self.entry.new_start_line = ln + 1
+
+            self.state = state.PROTO
+            return True
+        return False
+
+
+    def process_decl(self, ln, line):
+        """
+        STATE_DECLARATION: We've seen the beginning of a declaration
+        """
+        if self.is_new_section(ln, line) or self.is_comment_end(ln, line):
+            return
+        #
+        # Look for anything with the " * " line beginning.
+        #
+        if doc_content.search(line):
+            cont = doc_content.group(1)
+            #
+            # A blank line means that we have moved out of the declaration
+            # part of the comment (without any "special section" parameter
+            # descriptions).
+            #
+            if cont == "":
+                self.state = state.BODY
+            #
+            # Otherwise we have more of the declaration section to soak up.
+            #
+            else:
+                self.entry.declaration_purpose = \
+                    trim_whitespace(self.entry.declaration_purpose + ' ' + cont)
+        else:
+            # Unknown line, ignore
+            self.emit_msg(ln, f"bad line: {line}")
+
+
+    def process_special(self, ln, line):
+        """
+        STATE_SPECIAL_SECTION: a section ending with a blank line
+        """
+        #
+        # If we have hit a blank line (only the " * " marker), then this
+        # section is done.
+        #
+        if KernRe(r"\s*\*\s*$").match(line):
+            self.entry.begin_section(ln, dump = True)
+            self.state = state.BODY
+            return
+        #
+        # Not a blank line, look for the other ways to end the section.
+        #
+        if self.is_new_section(ln, line) or self.is_comment_end(ln, line):
+            return
+        #
+        # OK, we should have a continuation of the text for this section.
+        #
+        if doc_content.search(line):
+            cont = doc_content.group(1)
+            #
+            # If the lines of text after the first in a special section have
+            # leading white space, we need to trim it out or Sphinx will get
+            # confused.  For the second line (the None case), see what we
+            # find there and remember it.
+            #
+            if self.entry.leading_space is None:
+                r = KernRe(r'^(\s+)')
+                if r.match(cont):
+                    self.entry.leading_space = len(r.group(1))
+                else:
+                    self.entry.leading_space = 0
+            #
+            # Otherwise, before trimming any leading chars, be *sure*
+            # that they are white space.  We should maybe warn if this
+            # isn't the case.
+            #
+            for i in range(0, self.entry.leading_space):
+                if cont[i] != " ":
+                    self.entry.leading_space = i
+                    break
+            #
+            # Add the trimmed result to the section and we're done.
+            #
+            self.entry.add_text(cont[self.entry.leading_space:])
+        else:
+            # Unknown line, ignore
+            self.emit_msg(ln, f"bad line: {line}")
+
+    def process_body(self, ln, line):
+        """
+        STATE_BODY: the bulk of a kerneldoc comment.
+        """
+        if self.is_new_section(ln, line) or self.is_comment_end(ln, line):
+            return
+
+        if doc_content.search(line):
+            cont = doc_content.group(1)
+            self.entry.add_text(cont)
+        else:
+            # Unknown line, ignore
+            self.emit_msg(ln, f"bad line: {line}")
+
+    def process_inline_name(self, ln, line):
+        """STATE_INLINE_NAME: beginning of docbook comments within a prototype."""
+
+        if doc_inline_sect.search(line):
+            self.entry.begin_section(ln, doc_inline_sect.group(1))
+            self.entry.add_text(doc_inline_sect.group(2).lstrip())
+            self.state = state.INLINE_TEXT
+        elif doc_inline_end.search(line):
+            self.dump_section()
+            self.state = state.PROTO
+        elif doc_content.search(line):
+            self.emit_msg(ln, f"Incorrect use of kernel-doc format: {line}")
+            self.state = state.PROTO
+        # else ... ??
+
+    def process_inline_text(self, ln, line):
+        """STATE_INLINE_TEXT: docbook comments within a prototype."""
+
+        if doc_inline_end.search(line):
+            self.dump_section()
+            self.state = state.PROTO
+        elif doc_content.search(line):
+            self.entry.add_text(doc_content.group(1))
+        # else ... ??
+
+    def syscall_munge(self, ln, proto):         # pylint: disable=W0613
+        """
+        Handle syscall definitions
+        """
+
+        is_void = False
+
+        # Strip newlines/CR's
+        proto = re.sub(r'[\r\n]+', ' ', proto)
+
+        # Check if it's a SYSCALL_DEFINE0
+        if 'SYSCALL_DEFINE0' in proto:
+            is_void = True
+
+        # Replace SYSCALL_DEFINE with correct return type & function name
+        proto = KernRe(r'SYSCALL_DEFINE.*\(').sub('long sys_', proto)
+
+        r = KernRe(r'long\s+(sys_.*?),')
+        if r.search(proto):
+            proto = KernRe(',').sub('(', proto, count=1)
+        elif is_void:
+            proto = KernRe(r'\)').sub('(void)', proto, count=1)
+
+        # Now delete all of the odd-numbered commas in the proto
+        # so that argument types & names don't have a comma between them
+        count = 0
+        length = len(proto)
+
+        if is_void:
+            length = 0  # skip the loop if is_void
+
+        for ix in range(length):
+            if proto[ix] == ',':
+                count += 1
+                if count % 2 == 1:
+                    proto = proto[:ix] + ' ' + proto[ix + 1:]
+
+        return proto
+
+    def tracepoint_munge(self, ln, proto):
+        """
+        Handle tracepoint definitions
+        """
+
+        tracepointname = None
+        tracepointargs = None
+
+        # Match tracepoint name based on different patterns
+        r = KernRe(r'TRACE_EVENT\((.*?),')
+        if r.search(proto):
+            tracepointname = r.group(1)
+
+        r = KernRe(r'DEFINE_SINGLE_EVENT\((.*?),')
+        if r.search(proto):
+            tracepointname = r.group(1)
+
+        r = KernRe(r'DEFINE_EVENT\((.*?),(.*?),')
+        if r.search(proto):
+            tracepointname = r.group(2)
+
+        if tracepointname:
+            tracepointname = tracepointname.lstrip()
+
+        r = KernRe(r'TP_PROTO\((.*?)\)')
+        if r.search(proto):
+            tracepointargs = r.group(1)
+
+        if not tracepointname or not tracepointargs:
+            self.emit_msg(ln,
+                          f"Unrecognized tracepoint format:\n{proto}\n")
+        else:
+            proto = f"static inline void trace_{tracepointname}({tracepointargs})"
+            self.entry.identifier = f"trace_{self.entry.identifier}"
+
+        return proto
+
+    def process_proto_function(self, ln, line):
+        """Ancillary routine to process a function prototype"""
+
+        # strip C99-style comments to end of line
+        line = KernRe(r"\/\/.*$", re.S).sub('', line)
+        #
+        # Soak up the line's worth of prototype text, stopping at { or ; if present.
+        #
+        if KernRe(r'\s*#\s*define').match(line):
+            self.entry.prototype = line
+        elif not line.startswith('#'):   # skip other preprocessor stuff
+            r = KernRe(r'([^\{]*)')
+            if r.match(line):
+                self.entry.prototype += r.group(1) + " "
+        #
+        # If we now have the whole prototype, clean it up and declare victory.
+        #
+        if '{' in line or ';' in line or KernRe(r'\s*#\s*define').match(line):
+            # strip comments and surrounding spaces
+            self.entry.prototype = KernRe(r'/\*.*\*/').sub('', self.entry.prototype).strip()
+            #
+            # Handle self.entry.prototypes for function pointers like:
+            #       int (*pcs_config)(struct foo)
+            # by turning it into
+            #	    int pcs_config(struct foo)
+            #
+            r = KernRe(r'^(\S+\s+)\(\s*\*(\S+)\)')
+            self.entry.prototype = r.sub(r'\1\2', self.entry.prototype)
+            #
+            # Handle special declaration syntaxes
+            #
+            if 'SYSCALL_DEFINE' in self.entry.prototype:
+                self.entry.prototype = self.syscall_munge(ln,
+                                                          self.entry.prototype)
+            else:
+                r = KernRe(r'TRACE_EVENT|DEFINE_EVENT|DEFINE_SINGLE_EVENT')
+                if r.search(self.entry.prototype):
+                    self.entry.prototype = self.tracepoint_munge(ln,
+                                                                 self.entry.prototype)
+            #
+            # ... and we're done
+            #
+            self.dump_function(ln, self.entry.prototype)
+            self.reset_state(ln)
+
+    def process_proto_type(self, ln, line):
+        """Ancillary routine to process a type"""
+
+        # Strip C99-style comments and surrounding whitespace
+        line = KernRe(r"//.*$", re.S).sub('', line).strip()
+        if not line:
+            return # nothing to see here
+
+        # To distinguish preprocessor directive from regular declaration later.
+        if line.startswith('#'):
+            line += ";"
+        #
+        # Split the declaration on any of { } or ;, and accumulate pieces
+        # until we hit a semicolon while not inside {brackets}
+        #
+        r = KernRe(r'(.*?)([{};])')
+        for chunk in r.split(line):
+            if chunk:  # Ignore empty matches
+                self.entry.prototype += chunk
+                #
+                # This cries out for a match statement ... someday after we can
+                # drop Python 3.9 ...
+                #
+                if chunk == '{':
+                    self.entry.brcount += 1
+                elif chunk == '}':
+                    self.entry.brcount -= 1
+                elif chunk == ';' and self.entry.brcount <= 0:
+                    self.dump_declaration(ln, self.entry.prototype)
+                    self.reset_state(ln)
+                    return
+        #
+        # We hit the end of the line while still in the declaration; put
+        # in a space to represent the newline.
+        #
+        self.entry.prototype += ' '
+
+    def process_proto(self, ln, line):
+        """STATE_PROTO: reading a function/whatever prototype."""
+
+        if doc_inline_oneline.search(line):
+            self.entry.begin_section(ln, doc_inline_oneline.group(1))
+            self.entry.add_text(doc_inline_oneline.group(2))
+            self.dump_section()
+
+        elif doc_inline_start.search(line):
+            self.state = state.INLINE_NAME
+
+        elif self.entry.decl_type == 'function':
+            self.process_proto_function(ln, line)
+
+        else:
+            self.process_proto_type(ln, line)
+
+    def process_docblock(self, ln, line):
+        """STATE_DOCBLOCK: within a DOC: block."""
+
+        if doc_end.search(line):
+            self.dump_section()
+            self.output_declaration("doc", self.entry.identifier)
+            self.reset_state(ln)
+
+        elif doc_content.search(line):
+            self.entry.add_text(doc_content.group(1))
+
+    def parse_export(self):
+        """
+        Parses EXPORT_SYMBOL* macros from a single Kernel source file.
+        """
+
+        export_table = set()
+
+        try:
+            with open(self.fname, "r", encoding="utf8",
+                      errors="backslashreplace") as fp:
+
+                for line in fp:
+                    self.process_export(export_table, line)
+
+        except IOError:
+            return None
+
+        return export_table
+
+    #
+    # The state/action table telling us which function to invoke in
+    # each state.
+    #
+    state_actions = {
+        state.NORMAL:			process_normal,
+        state.NAME:			process_name,
+        state.BODY:			process_body,
+        state.DECLARATION:		process_decl,
+        state.SPECIAL_SECTION:		process_special,
+        state.INLINE_NAME:		process_inline_name,
+        state.INLINE_TEXT:		process_inline_text,
+        state.PROTO:			process_proto,
+        state.DOCBLOCK:			process_docblock,
+        }
+
+    def parse_kdoc(self):
+        """
+        Open and process each line of a C source file.
+        The parsing is controlled via a state machine, and the line is passed
+        to a different process function depending on the state. The process
+        function may update the state as needed.
+
+        Besides parsing kernel-doc tags, it also parses export symbols.
+        """
+
+        prev = ""
+        prev_ln = None
+        export_table = set()
+
+        try:
+            with open(self.fname, "r", encoding="utf8",
+                      errors="backslashreplace") as fp:
+                for ln, line in enumerate(fp):
+
+                    line = line.expandtabs().strip("\n")
+
+                    # Group continuation lines on prototypes
+                    if self.state == state.PROTO:
+                        if line.endswith("\\"):
+                            prev += line.rstrip("\\")
+                            if not prev_ln:
+                                prev_ln = ln
+                            continue
+
+                        if prev:
+                            ln = prev_ln
+                            line = prev + line
+                            prev = ""
+                            prev_ln = None
+
+                    self.config.log.debug("%d %s: %s",
+                                          ln, state.name[self.state],
+                                          line)
+
+                    # This is an optimization over the original script.
+                    # There, when export_file was used for the same file,
+                    # it was read twice. Here, we use the already-existing
+                    # loop to parse exported symbols as well.
+                    #
+                    if (self.state != state.NORMAL) or \
+                       not self.process_export(export_table, line):
+                        # Hand this line to the appropriate state handler
+                        self.state_actions[self.state](self, ln, line)
+
+        except OSError:
+            self.config.log.error(f"Error: Cannot open file {self.fname}")
+
+        return export_table, self.entries
diff --git a/scripts/lib/kdoc/kdoc_re.py b/scripts/lib/kdoc/kdoc_re.py
new file mode 100644
index 00000000000..612223e1e72
--- /dev/null
+++ b/scripts/lib/kdoc/kdoc_re.py
@@ -0,0 +1,270 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0
+# Copyright(c) 2025: Mauro Carvalho Chehab <mchehab@kernel.org>.
+
+"""
+Regular expression ancillary classes.
+
+Those help caching regular expressions and do matching for kernel-doc.
+"""
+
+import re
+
+# Local cache for regular expressions
+re_cache = {}
+
+
+class KernRe:
+    """
+    Helper class to simplify regex declaration and usage,
+
+    It calls re.compile for a given pattern. It also allows adding
+    regular expressions and define sub at class init time.
+
+    Regular expressions can be cached via an argument, helping to speedup
+    searches.
+    """
+
+    def _add_regex(self, string, flags):
+        """
+        Adds a new regex or re-use it from the cache.
+        """
+        self.regex = re_cache.get(string, None)
+        if not self.regex:
+            self.regex = re.compile(string, flags=flags)
+            if self.cache:
+                re_cache[string] = self.regex
+
+    def __init__(self, string, cache=True, flags=0):
+        """
+        Compile a regular expression and initialize internal vars.
+        """
+
+        self.cache = cache
+        self.last_match = None
+
+        self._add_regex(string, flags)
+
+    def __str__(self):
+        """
+        Return the regular expression pattern.
+        """
+        return self.regex.pattern
+
+    def __add__(self, other):
+        """
+        Allows adding two regular expressions into one.
+        """
+
+        return KernRe(str(self) + str(other), cache=self.cache or other.cache,
+                  flags=self.regex.flags | other.regex.flags)
+
+    def match(self, string):
+        """
+        Handles a re.match storing its results
+        """
+
+        self.last_match = self.regex.match(string)
+        return self.last_match
+
+    def search(self, string):
+        """
+        Handles a re.search storing its results
+        """
+
+        self.last_match = self.regex.search(string)
+        return self.last_match
+
+    def findall(self, string):
+        """
+        Alias to re.findall
+        """
+
+        return self.regex.findall(string)
+
+    def split(self, string):
+        """
+        Alias to re.split
+        """
+
+        return self.regex.split(string)
+
+    def sub(self, sub, string, count=0):
+        """
+        Alias to re.sub
+        """
+
+        return self.regex.sub(sub, string, count=count)
+
+    def group(self, num):
+        """
+        Returns the group results of the last match
+        """
+
+        return self.last_match.group(num)
+
+
+class NestedMatch:
+    """
+    Finding nested delimiters is hard with regular expressions. It is
+    even harder on Python with its normal re module, as there are several
+    advanced regular expressions that are missing.
+
+    This is the case of this pattern:
+
+            '\\bSTRUCT_GROUP(\\(((?:(?>[^)(]+)|(?1))*)\\))[^;]*;'
+
+    which is used to properly match open/close parenthesis of the
+    string search STRUCT_GROUP(),
+
+    Add a class that counts pairs of delimiters, using it to match and
+    replace nested expressions.
+
+    The original approach was suggested by:
+        https://stackoverflow.com/questions/5454322/python-how-to-match-nested-parentheses-with-regex
+
+    Although I re-implemented it to make it more generic and match 3 types
+    of delimiters. The logic checks if delimiters are paired. If not, it
+    will ignore the search string.
+    """
+
+    # TODO: make NestedMatch handle multiple match groups
+    #
+    # Right now, regular expressions to match it are defined only up to
+    #       the start delimiter, e.g.:
+    #
+    #       \bSTRUCT_GROUP\(
+    #
+    # is similar to: STRUCT_GROUP\((.*)\)
+    # except that the content inside the match group is delimiter's aligned.
+    #
+    # The content inside parenthesis are converted into a single replace
+    # group (e.g. r`\1').
+    #
+    # It would be nice to change such definition to support multiple
+    # match groups, allowing a regex equivalent to.
+    #
+    #   FOO\((.*), (.*), (.*)\)
+    #
+    # it is probably easier to define it not as a regular expression, but
+    # with some lexical definition like:
+    #
+    #   FOO(arg1, arg2, arg3)
+
+    DELIMITER_PAIRS = {
+        '{': '}',
+        '(': ')',
+        '[': ']',
+    }
+
+    RE_DELIM = re.compile(r'[\{\}\[\]\(\)]')
+
+    def _search(self, regex, line):
+        """
+        Finds paired blocks for a regex that ends with a delimiter.
+
+        The suggestion of using finditer to match pairs came from:
+        https://stackoverflow.com/questions/5454322/python-how-to-match-nested-parentheses-with-regex
+        but I ended using a different implementation to align all three types
+        of delimiters and seek for an initial regular expression.
+
+        The algorithm seeks for open/close paired delimiters and place them
+        into a stack, yielding a start/stop position of each match  when the
+        stack is zeroed.
+
+        The algorithm shoud work fine for properly paired lines, but will
+        silently ignore end delimiters that preceeds an start delimiter.
+        This should be OK for kernel-doc parser, as unaligned delimiters
+        would cause compilation errors. So, we don't need to rise exceptions
+        to cover such issues.
+        """
+
+        stack = []
+
+        for match_re in regex.finditer(line):
+            start = match_re.start()
+            offset = match_re.end()
+
+            d = line[offset - 1]
+            if d not in self.DELIMITER_PAIRS:
+                continue
+
+            end = self.DELIMITER_PAIRS[d]
+            stack.append(end)
+
+            for match in self.RE_DELIM.finditer(line[offset:]):
+                pos = match.start() + offset
+
+                d = line[pos]
+
+                if d in self.DELIMITER_PAIRS:
+                    end = self.DELIMITER_PAIRS[d]
+
+                    stack.append(end)
+                    continue
+
+                # Does the end delimiter match what it is expected?
+                if stack and d == stack[-1]:
+                    stack.pop()
+
+                    if not stack:
+                        yield start, offset, pos + 1
+                        break
+
+    def search(self, regex, line):
+        """
+        This is similar to re.search:
+
+        It matches a regex that it is followed by a delimiter,
+        returning occurrences only if all delimiters are paired.
+        """
+
+        for t in self._search(regex, line):
+
+            yield line[t[0]:t[2]]
+
+    def sub(self, regex, sub, line, count=0):
+        """
+        This is similar to re.sub:
+
+        It matches a regex that it is followed by a delimiter,
+        replacing occurrences only if all delimiters are paired.
+
+        if r'\1' is used, it works just like re: it places there the
+        matched paired data with the delimiter stripped.
+
+        If count is different than zero, it will replace at most count
+        items.
+        """
+        out = ""
+
+        cur_pos = 0
+        n = 0
+
+        for start, end, pos in self._search(regex, line):
+            out += line[cur_pos:start]
+
+            # Value, ignoring start/end delimiters
+            value = line[end:pos - 1]
+
+            # replaces \1 at the sub string, if \1 is used there
+            new_sub = sub
+            new_sub = new_sub.replace(r'\1', value)
+
+            out += new_sub
+
+            # Drop end ';' if any
+            if line[pos] == ';':
+                pos += 1
+
+            cur_pos = pos
+            n += 1
+
+            if count and count >= n:
+                break
+
+        # Append the remaining string
+        l = len(line)
+        out += line[cur_pos:l]
+
+        return out
-- 
2.43.0


