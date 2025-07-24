Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A0F9C83F26
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Jul 2025 11:02:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uetfx-0007Jc-Fg; Thu, 24 Jul 2025 06:59:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uetfu-0007De-MQ
 for qemu-devel@nongnu.org; Thu, 24 Jul 2025 06:59:46 -0400
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uetfr-0007xA-Su
 for qemu-devel@nongnu.org; Thu, 24 Jul 2025 06:59:46 -0400
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-60c60f7eeaaso1562195a12.0
 for <qemu-devel@nongnu.org>; Thu, 24 Jul 2025 03:59:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753354782; x=1753959582; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ijkn9pfZaP3ygSP4S1IDLeY5/FVKNxWO7uVgQKZFQBw=;
 b=alcjktwU4hWhGYBnCa7GFK8hPfftxOgqI2pvVRzq6vYS09H9J3NijeSasJEK/RUUqA
 Cn8DUhU+WpmwWvVVoNPS6LJx/VcIRnFzgYFY0D6mHPl4g99ee1eTexIEMCYcKZ3iWEyI
 oNH9zHtb9e4cnv303Y3UYdOaApmVHt9P2laJGlbzOoYp78J5Y9aN4UpSNeTRh/ldMicr
 OTRQi2WjV/JqGyHGpn6nCmX+1gZ3w922js0F/aSKqCp6llssBNRTtRNpIXT5bTfsbbN2
 s00H/jU+G9IpiagKfGkv0LSLsjsi8RuuHt8TE063Fu8xa1DemhHS0Q5oKFgiiTyAcXeZ
 h4Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753354782; x=1753959582;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ijkn9pfZaP3ygSP4S1IDLeY5/FVKNxWO7uVgQKZFQBw=;
 b=TDZ1UUSf2HttkdtnnTc0L/e+8wBFevqrUrc6lBj7kWJzUzoQuX/0locoexLoAJ4TJw
 3xUHKSXn4qbDLiJFcZkHmHhNcuzabjlAvOqx3iPNnHB2QjrkEriXj9tpRBEXzqKK0lFf
 KM6iClGvMbhlsvjnRYHhrP4EBLl71GNuWbuqLc7M0/3Ol65VAUPyikcPVQZvFEe8ymXg
 4pXDpHSWpQFpkxW+xDBKuaPo5yPQQCkBoIyL3o6z4x2YpVtaXnA/3D5+MtkmSSl1Ch7j
 ViqCanXsui1pFhk12CLomkGyriIqku/v5bUhmdMHFiwkpDNyUDq69I+GoNKracpK8V1x
 bxVA==
X-Gm-Message-State: AOJu0Yy0yam0NO3kZsreXZYj26UHaorcRvet+ccLo3SNbfuq7SJ5b7fN
 dy1prqNTq95GeAYruFcO3vdYBlLvMajfkjV3jbKU7B6KhVjg4sGsCs7sHOBtL6j30t4=
X-Gm-Gg: ASbGncuJRRvut9vhWm32pnXxrA2FxURJQTXDPaN7eHdhT6nAldzbjgUqiwSx5QDAJqy
 Mld8YtfMJt1VeLo7WICtueTbjROnj7pLfAz4qdkxtLEpFdeTW73Q7XyFrYlxwIk1Q8sGq0ddWY4
 KWPluFBMHk4js+LN819cWEHdP3aiKc/YsFkdfxeyQFt2sORo8MMAyhX2PSqz47GBUmoAVqzdVPa
 dPvngQREI7cgBxW3I9BPVrJ1/nljOO1D6d1ZJutIm7/aIoFk0iwHbFauN4ygdXYZ2c6nfOD5cFV
 UqumUg/rzyk2XP+8HC+a73xDonx+dEE9jwF5FeJrvgq+Zm2oKoHme3UOeztfNZYi2ypRRVn5HQd
 ffyjF0GO9UhAmr9QH0o98PDP0XEX3TYE6Yg==
X-Google-Smtp-Source: AGHT+IGEuRTnqeGpBU7JUIvkB4jwuYb3REEMWYtxG+cc7YuXFN6qU0diwya5c9Eo1GECqLD6NF66UA==
X-Received: by 2002:a17:907:97d3:b0:ae3:bb4a:91fc with SMTP id
 a640c23a62f3a-af2f6b021a7mr598251266b.22.1753354782258; 
 Thu, 24 Jul 2025 03:59:42 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-af47f44f1absm95829366b.65.2025.07.24.03.59.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Jul 2025 03:59:40 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 1CF875F89A;
 Thu, 24 Jul 2025 11:59:40 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>
Subject: [PATCH for 10.1 02/13] docs/system: reword the TAP notes to remove
 tarball ref
Date: Thu, 24 Jul 2025 11:59:28 +0100
Message-ID: <20250724105939.2393230-3-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250724105939.2393230-1-alex.bennee@linaro.org>
References: <20250724105939.2393230-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x530.google.com
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

We don't ship the tarball and users should generally look to the
distribution specific packaging.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/560
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 docs/system/devices/net.rst | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/docs/system/devices/net.rst b/docs/system/devices/net.rst
index 4d787c3aeb0..7d76fe88c45 100644
--- a/docs/system/devices/net.rst
+++ b/docs/system/devices/net.rst
@@ -21,11 +21,17 @@ configure it as if it was a real ethernet card.
 Linux host
 ^^^^^^^^^^
 
-As an example, you can download the ``linux-test-xxx.tar.gz`` archive
-and copy the script ``qemu-ifup`` in ``/etc`` and configure properly
-``sudo`` so that the command ``ifconfig`` contained in ``qemu-ifup`` can
-be executed as root. You must verify that your host kernel supports the
-TAP network interfaces: the device ``/dev/net/tun`` must be present.
+A distribution will generally provide specific helper scripts when it
+packages QEMU. By default these are found at ``/etc/qemu-ifup`` and
+``/etc/qemu-ifdown`` and are called appropriately when QEMU wants to
+change the network state.
+
+If QEMU is being run as a non-privileged user you may need properly
+configure ``sudo`` so that network commands in the scripts can be
+executed as root.
+
+You must verify that your host kernel supports the TAP network
+interfaces: the device ``/dev/net/tun`` must be present.
 
 See :ref:`sec_005finvocation` to have examples of command
 lines using the TAP network interfaces.
-- 
2.47.2


