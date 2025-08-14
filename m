Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4C1BCA0EE8
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Aug 2025 17:14:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1umbWM-0008Ok-A3; Thu, 14 Aug 2025 13:13:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1umbWJ-0008OC-1x
 for qemu-devel@nongnu.org; Thu, 14 Aug 2025 13:13:44 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1umbWC-0001p6-8l
 for qemu-devel@nongnu.org; Thu, 14 Aug 2025 13:13:42 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-45a1ac7c066so7359275e9.1
 for <qemu-devel@nongnu.org>; Thu, 14 Aug 2025 10:13:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1755191612; x=1755796412; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rlI6Xx/AE/ROAA0bt/artH10PKzBzGyh+zWmu1Dz8WI=;
 b=bSNdTOks2ITdmd71xAF6vWxp5vB56n6uf6tFxfG1yTjrpNyA0qlszAKREiFteZuAA+
 BzmLUyd1X3K1BQns6gHLFxtIePlQZITSXE1bfLVOYUoQC3IqFAnn3V1uZ3PyA6uCMAbL
 5kU8k9UfEFanUlvE0J8XIDJn54M8vnJTwnHTyfmFQsjBswnij/TFtcihNCEAVNo8Ji75
 LUNf9ii8G8MQhBFl286ReeSptQbk5j6jxPln70ewNZrsU1liGqP3MVe6YoeExWtrsoSq
 euTv8OIOU9KbIoNWQT4RCH1ww0l7l4jPdm8PSkLru92W0qkEQWY9BaAjHOBFzxsQBaiC
 72EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755191612; x=1755796412;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rlI6Xx/AE/ROAA0bt/artH10PKzBzGyh+zWmu1Dz8WI=;
 b=F3InX1s2tcQnr+9/Gxth3f+kplpiVqt592L0ZkLapwCE3EDiV1rrv0QVi2Sgf48mrF
 7g9mfQcP4ScM3mYINiYN3caBnRMwzJmWkxcrB7ksKkzzlOqvPXtNAOWkKknNKzvgl/XO
 nMMC7JUycqYAB1wM5II5KX9LXMXkfO8zKESC9EAy/qSLbUX2/qmxKJM9l3vymAY+s4lX
 CEsy+CdnszdHjWI/PheO1SCFC48El+AUGi3vWsh/baZgMlPzLLMr3HAbCP0fBgSjChZF
 k1E3nRdKH4jQq0AYsaoOUfv53ShmXoQ4QQwmXYOYpdxqwVW9uH/5Ur2mRB0GvKUVz9fd
 QxJA==
X-Gm-Message-State: AOJu0YwvHZI1TsviiRzL9f9ZWZpg0GSgCR1v2PNXGuGiCV65IUZhFOFt
 dygoyBXSvldxr8om7yHZ7qep5WwWjwzaHBjnaVW1s8qgWwCiTYbO9r5Y0MucKSsTEhXISrYBw6f
 d7BHV
X-Gm-Gg: ASbGncvHtEoyL8AvSAr9zGFGqzpJMMYY+O9F9kVwRa8PQyTheZYzsnCquRx0R0y4+E1
 DV1/dtY6OT3TloV0akFyt+otUW2I645kI/+jBz4y+eICOClR1I2POCK6Uk3P9pjkwLNAXKIzdWE
 wICIPVAT2uSYV7M5m3IqOd5/tC9BYHYSUFWX9Bdke0NLUmC8heWPB61WhaYjtvNno97KvPYB6Gt
 NHqYN3gWZCqqocnG1HWUdMGt+4cgF/8UzEZiMbBqPiIfISJ0GDNzIQIMGDLUi5950/xGC2wrZGo
 vY6ckqJNkOdiBAahhE2X5dBET8VwB1v346bMBQWVR1g/yCgtrZSCyJhyx651RYlWCipjulOEQpx
 X40Cxe9Bmm1yQhqVcT6QxhJasM7Pc
X-Google-Smtp-Source: AGHT+IG845PTqxgvwqGe6IMM51n0KWzVOQJ4nD4XyBW7YTpzsZaYAZs7kgzztHg6bKfr4pKsUDpZ+w==
X-Received: by 2002:a05:600c:8283:b0:459:d9d5:7f2b with SMTP id
 5b1f17b1804b1-45a1b7bf687mr34701265e9.16.1755191612252; 
 Thu, 14 Aug 2025 10:13:32 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45a1c76e9basm29489165e9.21.2025.08.14.10.13.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Aug 2025 10:13:31 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	John Snow <jsnow@redhat.com>
Subject: [PATCH for-10.2 6/8] scripts/kerneldoc: Switch to the Python
 kernel-doc script
Date: Thu, 14 Aug 2025 18:13:21 +0100
Message-ID: <20250814171324.1614516-7-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250814171324.1614516-1-peter.maydell@linaro.org>
References: <20250814171324.1614516-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x332.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

Change the Sphinx config to run the new Python kernel-doc script
instead of the Perl one.  The only difference between the two is that
the new script does not handle the -sphinx-version option, instead
assuming that Sphinx is always at least version 3: so we must
delete the code that passes that option to avoid the Python
script complaining about an unknown option.

QEMU's minimum Sphinx version is already 3.4.3, so this doesn't
change the set of versions we can handle.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
For quite a long time during development of this patchseries
I was still letting Sphinx invoke the new python script
by calling perl, which will read the #! line and invoke
env which then finds python3 and runs it...
---
 docs/conf.py             | 4 +++-
 docs/sphinx/kerneldoc.py | 5 -----
 2 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/docs/conf.py b/docs/conf.py
index f892a6e1da3..e09769e5f83 100644
--- a/docs/conf.py
+++ b/docs/conf.py
@@ -341,7 +341,9 @@
 # We use paths starting from qemu_docdir here so that you can run
 # sphinx-build from anywhere and the kerneldoc extension can still
 # find everything.
-kerneldoc_bin = ['perl', os.path.join(qemu_docdir, '../scripts/kernel-doc')]
+# Since kernel-doc is now a Python script, we should run it with whatever
+# Python this sphinx is using (rather than letting it find one via env)
+kerneldoc_bin = [sys.executable, os.path.join(qemu_docdir, '../scripts/kernel-doc.py')]
 kerneldoc_srctree = os.path.join(qemu_docdir, '..')
 hxtool_srctree = os.path.join(qemu_docdir, '..')
 qapidoc_srctree = os.path.join(qemu_docdir, '..')
diff --git a/docs/sphinx/kerneldoc.py b/docs/sphinx/kerneldoc.py
index 30bb3431983..9721072e476 100644
--- a/docs/sphinx/kerneldoc.py
+++ b/docs/sphinx/kerneldoc.py
@@ -63,11 +63,6 @@ def run(self):
         env = self.state.document.settings.env
         cmd = env.config.kerneldoc_bin + ['-rst', '-enable-lineno']
 
-        # Pass the version string to kernel-doc, as it needs to use a different
-        # dialect, depending what the C domain supports for each specific
-        # Sphinx versions
-        cmd += ['-sphinx-version', sphinx.__version__]
-
         # Pass through the warnings-as-errors flag
         if env.config.kerneldoc_werror:
             cmd += ['-Werror']
-- 
2.43.0


