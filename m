Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BA3CC54E58
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 08:25:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjxR1-0008Mb-Ov; Tue, 12 Mar 2024 04:24:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rjxQj-00073f-Of
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 04:24:18 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rjxQe-0001Jr-03
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 04:24:13 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4132e548343so8268215e9.1
 for <qemu-devel@nongnu.org>; Tue, 12 Mar 2024 01:24:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710231846; x=1710836646; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fRVInX4y8Fynbgdt9Z+8X8kf5kplDmxUXnVvwmK5Gtw=;
 b=N9i8HuGZkXNEGHjItbgxRDdhWxckjjRcqMu4wHR15NuXt5uWOD0fw1C3x+hP0gpgsp
 kVPYStImkB2auRj8MPgPSpL0xisXKEuW1eGzv9caRJyE34oh319cHZ0QNoFrvCRO+2og
 NELFdSpKx106/mnjH3o0nGiDICNRGdzKGedApoBO2yZ+hf/aJ5OadaVJQrnNGyCNunua
 aJ6JJ4RhYmRRkxKl6+qhZhCZNvUTbvK+qSL9Tba54jnotTOXVhDPhTZ5ZYlSD2JwhzmF
 xjBBgU0HrLVbDolKwH+nxwY/j5v/+vCalXbyv0bbvLr7lQxmpaZJeVRHp7c+vgSe4bhm
 +cfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710231846; x=1710836646;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fRVInX4y8Fynbgdt9Z+8X8kf5kplDmxUXnVvwmK5Gtw=;
 b=J09HgxQ0NHF9ksbq2pKIymuUXuOLNK0qQPaBwJMGDzX3o+CUR+dMZlyIzhEk3WpkcO
 X3NhZEzcooUeg2Yt5+TxaiuQb9cglky9Whg6XcphvXFiVMQO7Z4myOGjKIO5RZHsK7r9
 6s1XUjuTB8ddQNYIYLuCTpojSZ2tHvWK/8PwucdDeXNAXJDXhDpDRMHdK9c/SuykxKUi
 L1w+O6V4Fge9gT0RbI1eS02E/kTDP0bdFkfEL5XJoxz3ysfLSIYDPvzYEkSmqEDMEuDO
 2JgnEoHIxxhXoDOrSpLSAkFqRfaZ7hJBvXmur5eB4kk7R926V6cixbnbErusdY3iCnit
 HJjA==
X-Gm-Message-State: AOJu0YwXihJmt+WeoG1lDSXGFISdfapI6Sox6rGysZUtwxnd6WIGHVk1
 3hFf5Lcyn0KTWqd2hDF7iq7CJer5ibdr3modUEx6htc0cq9rfs5vzx7x1NQ490yLFtVIvxYuTzp
 O
X-Google-Smtp-Source: AGHT+IHx0OY2tF7nRKlO0N7m57X7g11lE1rN9UvJzvw3qyBrIGrBcuYUvjn+D2+UiWWFRc9EiSXhnQ==
X-Received: by 2002:a05:600c:3108:b0:412:7489:c8c0 with SMTP id
 g8-20020a05600c310800b004127489c8c0mr6935572wmo.34.1710231846062; 
 Tue, 12 Mar 2024 01:24:06 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.206.139])
 by smtp.gmail.com with ESMTPSA id
 m15-20020a05600c3b0f00b00413218ca719sm10882749wms.4.2024.03.12.01.24.04
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 12 Mar 2024 01:24:05 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, qemu-arm@nongnu.org, qemu-block@nongnu.org,
 Zhao Liu <zhao1.liu@intel.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 devel@lists.libvirt.org
Subject: [PULL 13/13] docs/about/deprecated.rst: Move SMP configurations item
 to system emulator section
Date: Tue, 12 Mar 2024 09:22:38 +0100
Message-ID: <20240312082239.69696-14-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240312082239.69696-1-philmd@linaro.org>
References: <20240312082239.69696-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

From: Zhao Liu <zhao1.liu@intel.com>

In the commit 54c4ea8f3ae6 ("hw/core/machine-smp: Deprecate unsupported
'parameter=1' SMP configurations"), the SMP related item is put under
the section "User-mode emulator command line arguments" instead of
"System emulator command line arguments".

-smp is a system emulator command, so move SMP configurations item to
system emulator section.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-ID: <20240312071512.3283513-1-zhao1.liu@linux.intel.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 docs/about/deprecated.rst | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
index dfd681cd02..2f9277c915 100644
--- a/docs/about/deprecated.rst
+++ b/docs/about/deprecated.rst
@@ -47,16 +47,6 @@ as short-form boolean values, and passed to plugins as ``arg_name=on``.
 However, short-form booleans are deprecated and full explicit ``arg_name=on``
 form is preferred.
 
-User-mode emulator command line arguments
------------------------------------------
-
-``-p`` (since 9.0)
-''''''''''''''''''
-
-The ``-p`` option pretends to control the host page size.  However,
-it is not possible to change the host page size, and using the
-option only causes failures.
-
 ``-smp`` (Unsupported "parameter=1" SMP configurations) (since 9.0)
 '''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
 
@@ -71,6 +61,16 @@ configurations (e.g. -smp drawers=1,books=1,clusters=1 for x86 PC machine) is
 marked deprecated since 9.0, users have to ensure that all the topology members
 described with -smp are supported by the target machine.
 
+User-mode emulator command line arguments
+-----------------------------------------
+
+``-p`` (since 9.0)
+''''''''''''''''''
+
+The ``-p`` option pretends to control the host page size.  However,
+it is not possible to change the host page size, and using the
+option only causes failures.
+
 QEMU Machine Protocol (QMP) commands
 ------------------------------------
 
-- 
2.41.0


