Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80846C48BC3
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Feb 2024 17:44:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcUAF-0003BO-Cl; Tue, 20 Feb 2024 12:44:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rcUAD-0003AQ-JY
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 12:44:17 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rcUAB-0005J7-ST
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 12:44:17 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4127188dd5cso3988165e9.0
 for <qemu-devel@nongnu.org>; Tue, 20 Feb 2024 09:44:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708451054; x=1709055854; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=W2K3Tqm8B14NRMR5SqLoegn/taEBzi71iE5TgmlRtzI=;
 b=NXi299p1g3C6PjQPRTOE7iHuZ3PLnOaTJcPDZsE3lsst4f4sf7f7Sc8cfsqZL82WYW
 z5qiK9r0E+V4RKWuCAG5h8rKxWF4yrbx7V7JI8uBC9v4GtL9Nli/eibrjiiPSJzD2hpA
 k9JmyHLCDaQ1tHr9yPxcKEGLIlZsk3au8dUyKNC3GCPYBNvfetKfJPAdC7+CydvwVBpD
 +2U7kX3aSzEFEnYZirNHw2rU3pHFQeB1CE9ejxMB/s8J+YZqminEgJnxDCVvBHAQwj6H
 lxoKU6WJQ9wACCjxIAZKyi/IJrmuhJlcXlwJPCxbYn0dcYz9EVrKfv171GM555l1xQus
 Lv/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708451054; x=1709055854;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=W2K3Tqm8B14NRMR5SqLoegn/taEBzi71iE5TgmlRtzI=;
 b=DIO35h0EFwPYxhjgFi6+vzqjKpi/AWBR3xnpftRcDhod+rPAkZjh5fEArb98J3e+8T
 l4rlIdeYKswcaB0Otj9KnRAHpQdemjxlMwjVfrDCAthQvVK/ZnTdUaRbuzAMoPvUJ2/3
 W7TBlG1WnO/jvOqpdiQb+VFI1bf1F3Yw0Zzx4ji7onCSlyQD8omNYT0yQmXmDdBBPwt2
 6FBdlfEoSWvg5V62mNPa+FHv1SysaVi2n+kwvvMU+fxA67qQrgWj/zTfypHRmi7PgYLX
 U5jg+CWYIrQLS/e3if+gOkmWzJZOB7VCJoHBJa+pe5cwnYmb8L+gRMxFyHSA6BF35QZx
 smVQ==
X-Gm-Message-State: AOJu0Yz3zbQaBLTxxso4qWSRLjqbRAW4srBtQAjuF4vbc54BL0mqAO4U
 d+gLpymChlN+aDaaLhZyxBdyRD0TDAvWC8TSUw7cKxTfofkKocCu6IxWBUPY2gWVp3/uHG1lU49
 6
X-Google-Smtp-Source: AGHT+IEJlhcc0UIFL0RuMXpQLwfiADwORH1oNrVco7Dwcu6rzwXhrYbt//ydhMz6bMXsfybj3KAyCA==
X-Received: by 2002:a05:600c:35d2:b0:410:8ab6:8c72 with SMTP id
 r18-20020a05600c35d200b004108ab68c72mr11087972wmq.31.1708451054530; 
 Tue, 20 Feb 2024 09:44:14 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 k5-20020adfe3c5000000b0033b66c2d61esm13988443wrm.48.2024.02.20.09.44.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Feb 2024 09:44:14 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Yonggang Luo <luoyonggang@gmail.com>
Subject: [PATCH 1/3] docs: Document that 32-bit Windows is unsupported
Date: Tue, 20 Feb 2024 17:44:10 +0000
Message-Id: <20240220174412.155885-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240220174412.155885-1-peter.maydell@linaro.org>
References: <20240220174412.155885-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x334.google.com
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


