Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76FA8C54788
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Feb 2024 13:10:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rd8pO-0000yQ-QO; Thu, 22 Feb 2024 08:09:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rd8pL-0000to-Px
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 08:09:27 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rd8pI-00085t-5w
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 08:09:27 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4125df3c40aso43918025e9.3
 for <qemu-devel@nongnu.org>; Thu, 22 Feb 2024 05:09:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708607362; x=1709212162; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TKaFyolY3zG3d8naOn5BbkD4wtYwG30E/pb0ZjpJNfY=;
 b=lLLVpnZtLHGLjH+KJGjy2U1suRa6NYNX/Q5HhY3FdiQspmp8LntkWVYKsGw/2+yICq
 xGpKK7FzIaOyjCs5ANKbxZc5NZp5U1mShzazkP9qErMdr+A57AJOauMsVc+VVYlwHXXg
 wrgFSL96h89H9X3MfYTC5wCtLwDlr1M8TxOkucRkP0b5U6KvmirGhTDTKgI3wOCiVBUe
 dy6Durpa/9Ms0reKHATzsLWdsn9Oo1lz8YteKsGx4Zao9xEjsmrjYLuXPP7oseV3zkl6
 6V1PbkpCTYINrioZLLXhbt1SZxYUjwSFvcvUeamF8IUqEeZ0JIqF2siVzfSgpFaa9XVF
 JRjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708607362; x=1709212162;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TKaFyolY3zG3d8naOn5BbkD4wtYwG30E/pb0ZjpJNfY=;
 b=kwctTiiK0xiO3cRF17pEd9i0nSbacPLAFZELBo0x0Fi+v2X3x3xm7BDc7n4dOp6is0
 ozAVg52ConxLX5iLbQkSBqaVORQmVn8eQfeYq2EonAAV8+nfd4WLLbdqP1fW+dEf0TRp
 +UfPn48G+bvjZQFWvPK+6NIV089eJ5NvVfYTjqw6J1uPT2lv4seZab6T7ZDxPauPSvb5
 Ere8hdKOL96gHuJBQKLW75XJPfEjKWE0xz+MX7C0qQIfsNYmz7h/+Hj0jbQhCRFwZpn2
 mkUmyYj5pZGLEhx/JSZ0/nfgItvsEG0PwOMn4Z3JrYonQkczgiWg/EJT7coVHJuJcxc8
 5ewA==
X-Gm-Message-State: AOJu0YxttgFsLaeka0DzezbkH3OFfSid3Jf8yNFHRfYUMSWwOalaiwt+
 mhuHRlD4yiaVPwmLgOx+277048zat6mGNRuVh1XclwH7yn90aXxdohnBMY9DzAOMuo1ce9ckd6f
 v
X-Google-Smtp-Source: AGHT+IEtKOsTFTP1cVzj0LJkCVIvRmVlcmvXSqbrNfR0zHDOZ5Snl6CGrMNhGxoeuBG2jdTkfKKjZw==
X-Received: by 2002:a7b:c4d8:0:b0:412:10a1:25e5 with SMTP id
 g24-20020a7bc4d8000000b0041210a125e5mr15378227wmk.36.1708607362666; 
 Thu, 22 Feb 2024 05:09:22 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 f19-20020a05600c155300b00411ff030f06sm22434458wmg.9.2024.02.22.05.09.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Feb 2024 05:09:21 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Yonggang Luo <luoyonggang@gmail.com>
Subject: [PATCH v2 1/3] docs: Document that 32-bit Windows is unsupported
Date: Thu, 22 Feb 2024 13:09:18 +0000
Message-Id: <20240222130920.362517-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240222130920.362517-1-peter.maydell@linaro.org>
References: <20240222130920.362517-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 docs/about/build-platforms.rst  |  2 ++
 docs/about/removed-features.rst | 15 +++++++++++++++
 2 files changed, 17 insertions(+)

diff --git a/docs/about/build-platforms.rst b/docs/about/build-platforms.rst
index f2a7aec56ff..8fd7da140a3 100644
--- a/docs/about/build-platforms.rst
+++ b/docs/about/build-platforms.rst
@@ -139,6 +139,8 @@ unprivileged accounts can create symlinks if Developer Mode is enabled.
 When Developer Mode is not available/enabled, the SeCreateSymbolicLinkPrivilege
 privilege is required, or the process must be run as an administrator.
 
+Only 64-bit Windows is supported.
+
 .. _Homebrew: https://brew.sh/
 .. _MacPorts: https://www.macports.org/
 .. _MSYS2: https://www.msys2.org/
diff --git a/docs/about/removed-features.rst b/docs/about/removed-features.rst
index 54081a6c196..417a0e4fa1d 100644
--- a/docs/about/removed-features.rst
+++ b/docs/about/removed-features.rst
@@ -659,6 +659,21 @@ This command didn't produce any output already. Removed with no replacement.
 The ``singlestep`` command has been replaced by the ``one-insn-per-tb``
 command, which has the same behaviour but a less misleading name.
 
+Host Architectures
+------------------
+
+System emulation on 32-bit Windows hosts (removed in 9.0)
+'''''''''''''''''''''''''''''''''''''''''''''''''''''''''
+
+Windows 11 has no support for 32-bit host installs, and Windows 10 did
+not support new 32-bit installs, only upgrades. 32-bit Windows support
+has now been dropped by the MSYS2 project. QEMU also is deprecating
+and dropping support for 32-bit x86 host deployments in
+general. 32-bit Windows is therefore no longer a supported host for
+QEMU.  Since all recent x86 hardware from the past >10 years is
+capable of the 64-bit x86 extensions, a corresponding 64-bit OS should
+be used instead.
+
 Guest Emulator ISAs
 -------------------
 
-- 
2.34.1


