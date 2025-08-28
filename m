Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34497CA0FF2
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Aug 2025 11:39:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urauH-0003Ye-8N; Thu, 28 Aug 2025 07:35:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1urauB-0003Ro-Uv
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 07:35:00 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1urau9-0005oY-Ku
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 07:34:59 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-45b4d8921f2so7129035e9.2
 for <qemu-devel@nongnu.org>; Thu, 28 Aug 2025 04:34:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756380896; x=1756985696; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=tlYbhB8nOl5JrIUdyBD4JxZnpHrBbp0zUqXwmx5QSWY=;
 b=hMA02QDoH5v24jm5vqGt5q7BDaIO4hJqC82VnzO9ULxRyrnLihVIZAuuvmxhn4Wxby
 d9ETzBgUEbZVNux6BQ6B2LX2fo0BMatQq6KdexpwiT2GkUclA6+j6VFnHIeEoePN6hzj
 LhPwy+zR7RpUFsQmMME85waEotBGAt8c7mFPXxlMnzqbmWSReKpEkBDodyfFVPFTsoHm
 bCgZ8YNC9/cX1JXYImxg6OKecN41GkM+R14I8Tlpin/Apc3XjmxPPPltyH/MtcfzTXIc
 Fzik+AgnoOeeCr6lMBqOTz7fRNeRfwMlynUSsQPQqfouu6P3fBx33xiv9dGNtFcLanWL
 8Teg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756380896; x=1756985696;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tlYbhB8nOl5JrIUdyBD4JxZnpHrBbp0zUqXwmx5QSWY=;
 b=nMdIQNzm4OUA/JBRHrub9Wg4YLcAlV0zUi5EaHovOLfsAiasCJFgBr+GWySvQzrI0M
 Po0/pnzpwyarc60Qlt1lX+zncqLFnf/qgl7zmQknMPaTjRXROJFhEEszyIJtne3WKo+N
 ifWJC2qTgXAThhCUlCLBXwxEtIMsImK7N/AOJVJoR6zjkm3Jzq40YbJS0K+o7+NdZMCW
 Ym30K8caTN5JepnSbLXscDs7/bHozG9/a0rc5tRcXcyGiTLsd4vmeFlG2KNsRAKcsVk7
 DMpg5rh1XIOh2p+FMEjXs1jAzECo1X2MRReX034Cl/w1rxKDKm54ORvML3OXX/KzRb8e
 TGPA==
X-Gm-Message-State: AOJu0YxRvhbE+o17zE2AuCyik7MHHYQA8rtbuUBFmSZBBjwzUAa9F27X
 3VWb5LfX+fe6jTq9L8HyE267Ft3X187pQDn7FHuM8enz86DFN0InUVUwfs71dZQjr6cR4+W7kPH
 E1eqF
X-Gm-Gg: ASbGncvMaGDIjG1ctu9I3XKAfZJHE7kmqoENR5WEG1stSZ1DDTKR+PoVdwjfln3vlai
 E2ywIyFEoDh0ZrY0zOcGrameJbLvBG7haeqEKfTgnp/LuLmPmw56/sGXpzZPTlLL7I315UswPfZ
 z4+i6Vt16/qJiJNBJK5vZFTnGY2qRMc4oaluvIZVTY4rUnTmUrE15nXSJuVC9dsZfur+KsxLxwv
 q5qYweuvI4TP08YA97jxO/FO9QlUD9NROlnrvlkuI+YnFqsnTLfuBk5knDJQvQWuJ5f6Odv4CWm
 NwTCrJ9Nj1DjWmIW9Op2Cc5xqE+GKTUVFUa+Y61YF+shm85svfw1C79xRB0rWaB22B8ZsA29jE8
 /NzpFu9sqsoObk/oOgmUvL42QdHwLex66nncC0rg=
X-Google-Smtp-Source: AGHT+IEhekCwFl8XcyS5kuEn7i/XrhEWqFauR65JKRCYM/uZ11wsK0bzisdeXxfyZAXN5MBiFJ1vDA==
X-Received: by 2002:a05:600c:4f41:b0:459:d3ce:2cbd with SMTP id
 5b1f17b1804b1-45b517ad602mr194774255e9.13.1756380895875; 
 Thu, 28 Aug 2025 04:34:55 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b79799c33sm28691015e9.5.2025.08.28.04.34.54
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Aug 2025 04:34:55 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 21/32] scripts/kerneldoc: Switch to the Python kernel-doc script
Date: Thu, 28 Aug 2025 12:34:18 +0100
Message-ID: <20250828113430.3214314-22-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250828113430.3214314-1-peter.maydell@linaro.org>
References: <20250828113430.3214314-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32d.google.com
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

Change the Sphinx config to run the new Python kernel-doc script
instead of the Perl one.  The only difference between the two is that
the new script does not handle the -sphinx-version option, instead
assuming that Sphinx is always at least version 3: so we must
delete the code that passes that option to avoid the Python
script complaining about an unknown option.

QEMU's minimum Sphinx version is already 3.4.3, so this doesn't
change the set of versions we can handle.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Message-id: 20250814171324.1614516-7-peter.maydell@linaro.org
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


