Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FB60CFA456
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2024 10:04:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3uhb-0002W9-3l; Thu, 24 Oct 2024 06:04:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1t3uhW-0002V9-6m
 for qemu-devel@nongnu.org; Thu, 24 Oct 2024 06:04:19 -0400
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1t3uhT-0004he-PH
 for qemu-devel@nongnu.org; Thu, 24 Oct 2024 06:04:17 -0400
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-5c94b0b466cso872516a12.0
 for <qemu-devel@nongnu.org>; Thu, 24 Oct 2024 03:04:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729764254; x=1730369054; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0+jlZEC6qFazfkTWcWtzUB5SL3dgpYSY93VUraV/tM0=;
 b=QVCYemubPHJodtNNFIJ+mTyB6QGKIuZUyemcv8W6wuO5xpZYtRxpbiDjuuRNjyfwxQ
 vZb4tHjY+1iewpCBV46aLugOl6qlEtafkZynG9Dcv0//wDMTMR8uZ8SKi47vYllREvhD
 hjM/DnuwdmVB7LUs7xUnyNSNA6Wu/+/t44V+njZS1C+YCetLZa6RzvGiFmxjpi5g1YU+
 mYTEI4inUEB5zFC/ONjqkH21virIcFP5v7OUljCMWRECB/bZEKEJuHIlHGJ/+cvbCt6x
 lETR3ZOVa843KPx4ATJgb83E8ztTRKzaaXrUnHwEHVy6X4JtJpubk2gKH9gx4n0RPulN
 K7Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729764254; x=1730369054;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0+jlZEC6qFazfkTWcWtzUB5SL3dgpYSY93VUraV/tM0=;
 b=I6mqq0y22wJakgoTDRMMU0M0lsif3C4ZwQQEQAA6mDuzI3hF0gXmXJCLyyfhpnL1pc
 tTuFvHnQQ54ZPsG1QUrAsS0cEupF/XvXsjZ3ZXkCM3Km4FoR68bLLjYOetJy9vPpJiRk
 fhgj/PsV1ryhxZnz1Nnz1cB8A3Qwi3UyhhfyUyVELAbI4JW3Vp7krsTfdaa5ZoZADGNk
 DPsumrJt+Voix6sr4NsyRzNGdCKvvmJBXtxV4OJ1IA0/yKloqYWm2EN2prhFUgIQWspH
 EO5ZO2GOgVuZgLOJ+HNrT+uzzH1vvZ00lPG9iGJ/w1UGv7rHLhOYf5ls/97CyNMPvBLd
 hX0A==
X-Gm-Message-State: AOJu0Yz/Gi8JidqpYnNEfk1OsPcdRsTfYOuTFJma8ycVsFnB46lUhXOL
 WPGCDJwEpXwWCYWZJtX2KBYcMgUMZLLAkOlMh4RYQJXUfknuLPIRt87QnZcLHEY=
X-Google-Smtp-Source: AGHT+IFQFUjkvmTK19x6m02r/ToGWPoIeBmoPp4NHDXyd531jLKV1v5GOfPyButmRHchKGDlASnfPw==
X-Received: by 2002:a05:6402:520b:b0:5c9:3818:35e8 with SMTP id
 4fb4d7f45d1cf-5cba2492ebemr1017020a12.28.1729764254223; 
 Thu, 24 Oct 2024 03:04:14 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5cb66c6b163sm5717769a12.76.2024.10.24.03.04.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Oct 2024 03:04:13 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 144D95FA0B;
 Thu, 24 Oct 2024 10:56:05 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>
Subject: [PULL 12/17] config/targets: update aarch64_be-linux-user gdb XML list
Date: Thu, 24 Oct 2024 10:55:58 +0100
Message-Id: <20241024095603.1813285-13-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241024095603.1813285-1-alex.bennee@linaro.org>
References: <20241024095603.1813285-1-alex.bennee@linaro.org>
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

Attempting to run the binary asserts when it can't find the XML entry.
We can fix it so we don't although I suspect other stuff is broken.

Fixes: https://gitlab.com/qemu-project/qemu/-/issues/2580
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20241023113406.1284676-13-alex.bennee@linaro.org>

diff --git a/configs/targets/aarch64_be-linux-user.mak b/configs/targets/aarch64_be-linux-user.mak
index 778d22b2a9..dcef597a80 100644
--- a/configs/targets/aarch64_be-linux-user.mak
+++ b/configs/targets/aarch64_be-linux-user.mak
@@ -1,7 +1,7 @@
 TARGET_ARCH=aarch64
 TARGET_BASE_ARCH=arm
 TARGET_BIG_ENDIAN=y
-TARGET_XML_FILES= gdb-xml/aarch64-core.xml gdb-xml/aarch64-fpu.xml gdb-xml/aarch64-pauth.xml
+TARGET_XML_FILES= gdb-xml/aarch64-core.xml gdb-xml/aarch64-fpu.xml gdb-xml/aarch64-pauth.xml gdb-xml/aarch64-mte.xml
 TARGET_HAS_BFLT=y
 CONFIG_SEMIHOSTING=y
 CONFIG_ARM_COMPATIBLE_SEMIHOSTING=y
-- 
2.39.5


