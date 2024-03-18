Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 511D9C54E67
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Mar 2024 03:05:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rm3J7-0004ux-7z; Sun, 17 Mar 2024 23:05:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maxim.cournoyer@gmail.com>)
 id 1rm3J3-0004uV-4a
 for qemu-devel@nongnu.org; Sun, 17 Mar 2024 23:04:57 -0400
Received: from mail-qk1-x72c.google.com ([2607:f8b0:4864:20::72c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <maxim.cournoyer@gmail.com>)
 id 1rm3J1-0007FG-EH
 for qemu-devel@nongnu.org; Sun, 17 Mar 2024 23:04:56 -0400
Received: by mail-qk1-x72c.google.com with SMTP id
 af79cd13be357-789e70d7c07so154403285a.1
 for <qemu-devel@nongnu.org>; Sun, 17 Mar 2024 20:04:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1710731092; x=1711335892; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=cfL9cENqmsBlmvoSOl08CkdXFEA/4uL3lNvjfs+j+6o=;
 b=mCFVQZeGNGQlJuHbGf1onriKhDmuyjidnYoNyv/krIea1rTZfr9WzolkJFh0yakU5o
 LblAFh43fWKOlWrzRsTWUW+5NSrfaKj0bbi+sP41ESb90rEUzpQDMiEnpivIYeLPMv6/
 BxnEKTyj8TN0VAtUGlwtEw04SnugaV+yLa7s8ramng2HQcd0yTlspwoH36+oJh41lHOL
 o8SYKjvPJQuIo1jBRFQbxNl43Kj/O3oww1kdwe+pLZKeWs7VVRVmNMMpGm0/zOn4++ee
 z0zGtSBN0JYZGUcpX8iKczq8KH3FX8b+aEUY2BIdW+rht1OLZ/CUGfFutsFOGCf5CJ+d
 oSVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710731092; x=1711335892;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=cfL9cENqmsBlmvoSOl08CkdXFEA/4uL3lNvjfs+j+6o=;
 b=clgT/QaW2pezK2SU8utRJk1AZ/sqfF4oerJ1g5T5oFt7w0a2vzVK3p1DvXiQTV8/zV
 AET9IdVu4WuuRF7w6N95065JVom9Ntgi9DkmZFC0YKeYdJBSINiF9jEx8ZPZo2yD7uop
 34Z3D+Z/lfpLdWy8UOBX5D+wyHKQ0CiZzezvxbkuIcxQMVOviCmD4+d69id4vRerxR2r
 mguI7Q7NbMngwOMZLNcgxvtGLHLJCgSwO4VitkCxw9O/QCo0XAd5419yfDG3MUS6ygGE
 PCqk7hOwKyF7Lh61qS7mGQy4e6qHwmvCL8IZjoMYr+LKY1GxP1HZPFCHaVbKDKy6IUm8
 ePtw==
X-Gm-Message-State: AOJu0YzRkdsl6kar69tOMYayNQzCEVELSW+fKpA8nwGaFMa+umbZoFWr
 W6ZyGY2c5I/u4nWf6pIIB3UU3VGvKqykMXtSZVmnhcWuxTE/uPBFYGjonibUv08=
X-Google-Smtp-Source: AGHT+IHA49RE6uuHEpeP/8oUo5Px+asxcZ4g+iMpJ7K/j6dKHUfU8WB1TSV4EF4d2qX18d6FXdDwFg==
X-Received: by 2002:a05:620a:124d:b0:789:e26b:50c with SMTP id
 a13-20020a05620a124d00b00789e26b050cmr10295863qkl.77.1710731092340; 
 Sun, 17 Mar 2024 20:04:52 -0700 (PDT)
Received: from localhost.localdomain (dsl-10-148-142.b2b2c.ca. [72.10.148.142])
 by smtp.gmail.com with ESMTPSA id
 c27-20020a05620a11bb00b007882fe32acasm4143505qkk.3.2024.03.17.20.04.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 17 Mar 2024 20:04:51 -0700 (PDT)
From: Maxim Cournoyer <maxim.cournoyer@gmail.com>
To: qemu-devel@nongnu.org
Cc: Maxim Cournoyer <maxim.cournoyer@gmail.com>,
 Fabiano Rosas <farosas@suse.de>, John Snow <jsnow@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH] build: Re-introduce an 'info' target to build a Texinfo
 manual.
Date: Sun, 17 Mar 2024 23:03:24 -0400
Message-ID: <20240318030437.17503-1-maxim.cournoyer@gmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::72c;
 envelope-from=maxim.cournoyer@gmail.com; helo=mail-qk1-x72c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

This reinstates
<https://lists.gnu.org/archive/html/qemu-devel/2020-09/msg09228.html>,
which was committed at some point but reverted many years later in
cleanups that followed the migration from Texinfo sources to the
ReStructuredText (RST) format.  It's still nice to leave the option for
users to easily generate a QEMU manual in the Texinfo format, taking
advantage of the Sphinx texinfo backend.

The Texinfo format is structured and info readers provide advanced
navigation capabilities such as jumping to indexed topics or nodes and
is usable even in environments lacking a graphical session.

* docs/meson.build (texi, info): New targets.

Signed-off-by: Maxim Cournoyer <maxim.cournoyer@gmail.com>
---

 docs/meson.build | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/docs/meson.build b/docs/meson.build
index 9040f860ae..2ae7886fcb 100644
--- a/docs/meson.build
+++ b/docs/meson.build
@@ -98,4 +98,26 @@ if build_docs
   alias_target('sphinxdocs', sphinxdocs)
   alias_target('html', sphinxdocs)
   alias_target('man', sphinxmans)
+
+  # Add a target to build and install a Texinfo version of the QEMU
+  # manual, if 'makeinfo' is available.
+  makeinfo = find_program(['texi2any', 'makeinfo'])
+  if makeinfo.found()
+    sphinxtexi = custom_target(
+      'qemu.texi',
+      output: ['qemu.texi', 'sphinxtexi.stamp'],
+      depfile: 'sphinxtexi.d',
+      command: [SPHINX_ARGS, '-Ddepfile=@DEPFILE@',
+               '-Ddepfile_stamp=@OUTPUT1@', '-b', 'texinfo',
+               '-d', private_dir, input_dir, meson.current_build_dir()])
+    sphinxinfo = custom_target(
+      'qemu.info',
+      input: sphinxtexi,
+      output: 'qemu.info',
+      install: true,
+      install_dir: get_option('infodir'),
+      command: [makeinfo, '--no-split', '--output=@OUTPUT@', '@INPUT0@'])
+    alias_target('texi', sphinxtexi)
+    alias_target('info', sphinxinfo)
+  endif
 endif

base-commit: ba49d760eb04630e7b15f423ebecf6c871b8f77b
-- 
2.41.0


