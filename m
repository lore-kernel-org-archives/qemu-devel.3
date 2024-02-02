Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49B2CC48291
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Feb 2024 15:37:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVvb2-0000Kr-R5; Fri, 02 Feb 2024 10:36:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rVvb1-0000Jy-0O
 for qemu-devel@nongnu.org; Fri, 02 Feb 2024 10:36:51 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rVvav-0004Sh-Rl
 for qemu-devel@nongnu.org; Fri, 02 Feb 2024 10:36:50 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-40fafae5532so19305655e9.1
 for <qemu-devel@nongnu.org>; Fri, 02 Feb 2024 07:36:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706888204; x=1707493004; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=nCqjBY1O075hml0hoLAI8QgIMrH8pjs6AsQwwZz+6WI=;
 b=nCLyTWnIsyjV0cheIj1FvsDJsf+3TB27/J8OmfO40uLPSpmzTc6/1cWlqkagG1auA1
 xdMaDotmy+6lF2w5YVw//DRD7oYpN0Y9xz3fm829aYf0SYOpspKcPEjjoY8bXoekXOoD
 xHL8l8ghBLOytZdCW4Yag+FQy4aLVO22yrRpQ5Tn9coRTtNVc2Dza8VrGIK/UR8cSxgj
 AL4T0e0aJhZhQ7xtAhD+TS/Lv9BIADssWdYlChN08ruYRZFPKxevXgWOTmgJGoWcCznh
 BYF6AvJWJ0Xp6LUpjlNcfB0FMrmsxK+9DnIS9ICmA1IFcew6+j8llzYQREbDxxh7/mfh
 5wsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706888204; x=1707493004;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nCqjBY1O075hml0hoLAI8QgIMrH8pjs6AsQwwZz+6WI=;
 b=EOdOZiVh8/yXNfsbYsvuXU3TbxnqUNdUpnBNHVzCq4749wooZ2Tcp1hxSo+w2hnMGb
 tX+e5oRPneuEotG96IYgsVgfdpxyerCnwCjz6p6TGiJq0yY+sXvR+zJAQgKwICEqKsFY
 ftnK2AmjIZZptEreRTFCzQ4u65kjKRgd0c5DKX8UU1UPWTY7n47Esp+xjhbVY/JMeu2x
 +B6+cXOIZT1RewTz1O+/I7yLqml4XBisWtM3j0jPGOKyx5vJbSjpZeR4MplumVKmo9OO
 h/GmBzbS4ClAPl0Z6KiMSg67i+Qf5kI/tyewpSLDcybH/+SeGTZp5qPbqyDjt/HMNir/
 Mgpg==
X-Gm-Message-State: AOJu0YxtRtpprdTJxjyYdrsCAqvbjkfheH3IlFNnGorgelbW2Ku63e4L
 GXps5DiO+liookl/D2tKAouyKpkA6oPauAATC0vXgYPpXCwja76XasZINauAajHXNIpLH6EVgKi
 6
X-Google-Smtp-Source: AGHT+IGKdtrxEmf6dWADf9kCAsAGz08n7WkZf5jDMSDiv3MvJ5x41uJUcUR+IONTuV/2f10hMdLIbQ==
X-Received: by 2002:a5d:4c90:0:b0:33b:1bed:a315 with SMTP id
 z16-20020a5d4c90000000b0033b1beda315mr2414170wrs.25.1706888204443; 
 Fri, 02 Feb 2024 07:36:44 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 k2-20020a05600c1c8200b0040fafd84095sm214735wms.41.2024.02.02.07.36.44
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Feb 2024 07:36:44 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 12/36] doc/sphinx/hxtool.py: add optional label argument to
 SRST directive
Date: Fri,  2 Feb 2024 15:36:13 +0000
Message-Id: <20240202153637.3710444-13-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240202153637.3710444-1-peter.maydell@linaro.org>
References: <20240202153637.3710444-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x332.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

From: David Woodhouse <dwmw@amazon.co.uk>

We can't just embed labels directly into files like qemu-options.hx which
are included from multiple top-level rST files, because Sphinx sees the
labels as duplicate: https://github.com/sphinx-doc/sphinx/issues/9707

So add an optional argument to the SRST directive which causes a label
of the form '.. _DOCNAME-HXFILE-LABEL:' to be emitted, where 'DOCNAME'
is the name of the top level rST file, 'HXFILE' is the filename of the
.hx file, and 'LABEL' is the text provided within the 'SRST()' directive.
Using the DOCNAME of the top-level rST document means that it is unique
even when the .hx file is included from two different documents, as is
the case for qemu-options.hx

Now where the Xen PV documentation refers to the documentation for the
-initrd command line option, it can emit a link directly to it as
'<system/invocation-qemu-options-initrd>'.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Reviewed-by: Paul Durrant <paul@xen.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20240130190348.682912-1-dwmw2@infradead.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 docs/devel/docs.rst      | 12 ++++++++++--
 docs/sphinx/hxtool.py    | 16 ++++++++++++++++
 docs/system/i386/xen.rst |  3 ++-
 qemu-options.hx          |  2 +-
 4 files changed, 29 insertions(+), 4 deletions(-)

diff --git a/docs/devel/docs.rst b/docs/devel/docs.rst
index 7da067905b8..50ff0d67f84 100644
--- a/docs/devel/docs.rst
+++ b/docs/devel/docs.rst
@@ -30,6 +30,13 @@ nor the documentation output.
 
 ``SRST`` starts a reStructuredText section. Following lines
 are put into the documentation verbatim, and discarded from the C output.
+The alternative form ``SRST()`` is used to define a label which can be
+referenced from elsewhere in the rST documentation. The label will take
+the form ``<DOCNAME-HXFILE-LABEL>``, where ``DOCNAME`` is the name of the
+top level rST file, ``HXFILE`` is the filename of the .hx file without
+the ``.hx`` extension, and ``LABEL`` is the text provided within the
+``SRST()`` directive. For example,
+``<system/invocation-qemu-options-initrd>``.
 
 ``ERST`` ends the documentation section started with ``SRST``,
 and switches back to a C code section.
@@ -53,8 +60,9 @@ text, but in ``hmp-commands.hx`` the C code sections are elements
 of an array of structs of type ``HMPCommand`` which define the
 name, behaviour and help text for each monitor command.
 
-In the file ``qemu-options.hx``, do not try to define a
+In the file ``qemu-options.hx``, do not try to explicitly define a
 reStructuredText label within a documentation section. This file
 is included into two separate Sphinx documents, and some
 versions of Sphinx will complain about the duplicate label
-that results.
+that results. Use the ``SRST()`` directive documented above, to
+emit an unambiguous label.
diff --git a/docs/sphinx/hxtool.py b/docs/sphinx/hxtool.py
index 9f6b9d87dcc..3729084a36c 100644
--- a/docs/sphinx/hxtool.py
+++ b/docs/sphinx/hxtool.py
@@ -78,6 +78,14 @@ def parse_archheading(file, lnum, line):
         serror(file, lnum, "Invalid ARCHHEADING line")
     return match.group(1)
 
+def parse_srst(file, lnum, line):
+    """Handle an SRST directive"""
+    # The input should be either "SRST", or "SRST(label)".
+    match = re.match(r'SRST(\((.*?)\))?', line)
+    if match is None:
+        serror(file, lnum, "Invalid SRST line")
+    return match.group(2)
+
 class HxtoolDocDirective(Directive):
     """Extract rST fragments from the specified .hx file"""
     required_argument = 1
@@ -113,6 +121,14 @@ def run(self):
                         serror(hxfile, lnum, 'expected ERST, found SRST')
                     else:
                         state = HxState.RST
+                        label = parse_srst(hxfile, lnum, line)
+                        if label:
+                            rstlist.append("", hxfile, lnum - 1)
+                            # Build label as _DOCNAME-HXNAME-LABEL
+                            hx = os.path.splitext(os.path.basename(hxfile))[0]
+                            refline = ".. _" + env.docname + "-" + hx + \
+                                "-" + label + ":"
+                            rstlist.append(refline, hxfile, lnum - 1)
                 elif directive == 'ERST':
                     if state == HxState.CTEXT:
                         serror(hxfile, lnum, 'expected SRST, found ERST')
diff --git a/docs/system/i386/xen.rst b/docs/system/i386/xen.rst
index 81898768baa..46db5f34c1d 100644
--- a/docs/system/i386/xen.rst
+++ b/docs/system/i386/xen.rst
@@ -132,7 +132,8 @@ The example above provides the guest kernel command line after a separator
 (" ``--`` ") on the Xen command line, and does not provide the guest kernel
 with an actual initramfs, which would need to listed as a second multiboot
 module. For more complicated alternatives, see the command line
-documentation for the ``-initrd`` option.
+:ref:`documentation <system/invocation-qemu-options-initrd>` for the
+``-initrd`` option.
 
 Host OS requirements
 --------------------
diff --git a/qemu-options.hx b/qemu-options.hx
index 40e938c4877..5adbed11013 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -3994,7 +3994,7 @@ ERST
 
 DEF("initrd", HAS_ARG, QEMU_OPTION_initrd, \
            "-initrd file    use 'file' as initial ram disk\n", QEMU_ARCH_ALL)
-SRST
+SRST(initrd)
 
 ``-initrd file``
     Use file as initial ram disk.
-- 
2.34.1


