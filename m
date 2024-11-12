Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20733D42B84
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2024 14:00:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tArQn-0006SM-1U; Tue, 12 Nov 2024 08:59:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sjg@chromium.org>) id 1tArQl-0006NF-89
 for qemu-devel@nongnu.org; Tue, 12 Nov 2024 08:59:43 -0500
Received: from mail-io1-xd2a.google.com ([2607:f8b0:4864:20::d2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <sjg@chromium.org>) id 1tArQj-000426-OO
 for qemu-devel@nongnu.org; Tue, 12 Nov 2024 08:59:42 -0500
Received: by mail-io1-xd2a.google.com with SMTP id
 ca18e2360f4ac-83abf71f244so201798839f.1
 for <qemu-devel@nongnu.org>; Tue, 12 Nov 2024 05:59:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1731419977; x=1732024777; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=meZSkW/KpZC3yrnqAzdQzJHpxuq2GB8ec6FamATdohQ=;
 b=SfMTuCFEKhGPwStkjR7MEeMtddQ5mA6Z4th8lpPLMDcK8yjaCtnBUEBR23y5refJ93
 oksA7DhecmKsNOO9/QeUklUIARFVpZ1KUhKqBJM9BDcTPu0qp/QffmPX8L7LfpSyDQNf
 Z/3aMFNU0ssj8P/qyN36xdnFZv1fVl84eHzM0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731419977; x=1732024777;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=meZSkW/KpZC3yrnqAzdQzJHpxuq2GB8ec6FamATdohQ=;
 b=DiG7nuo4iF3/Zv7J/VrxNpYwBmsQRCWGC/LyL546I962xBlFWkVcREcnlkZdaGhsuA
 yi7x7N4KPYJu7i+nafxLXXceWVfUMSmFGthU+6o4LSpRsrAUhhAxKSzfvpE54SgzW89L
 LXjqvcvASXJFTJUdz6Djq7OJUPIKqEvrxK9TMS1Tv9+M8+nLYQnheN7CttimjQcxlqqE
 shKiB9Jmcjo839IEtQuoFY9uNwUApTTdVVmUuglSA9d7AUydJgE28n4pA0ysY+BSL809
 2k678+1DwBOUVZdYDuzRBM3LH+I4UZ4G986dCvadnzuRXSXffGqNfLjMkBCsfLBaVXa4
 uskQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXxI8hJhBj08ezLiLjVlVn74M6UnDIvpEms8Y9mbruaTTQdG5AlShs0OSwycse3IkXL0g7r9xCExRnl@nongnu.org
X-Gm-Message-State: AOJu0YyXCoE3o/s4FC8LCYaKDuiTsdH2FPUAK6R0Ab52K0WPUY9k+e8/
 PU5F1mfXKlhWm+PN6INgYy/Sc8w1QDy13r8QYUb6a5S2UvGJRgJTtUlaIzAAJw==
X-Google-Smtp-Source: AGHT+IGGnulNLd2O+ik74tJVc8S+m3d8DlVrueGb4U5VbLkVCda7IZb8VLCIneqkZOwTyIGB0IAFtw==
X-Received: by 2002:a05:6602:29c7:b0:803:5e55:ecb2 with SMTP id
 ca18e2360f4ac-83e03068fe6mr2057497739f.0.1731419977025; 
 Tue, 12 Nov 2024 05:59:37 -0800 (PST)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-83e132c01besm189203039f.30.2024.11.12.05.59.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Nov 2024 05:59:35 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Bin Meng <bmeng.cn@gmail.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, qemu-devel@nongnu.org
Subject: [PATCH 04/18] x86: qemu: Enable dhrystone
Date: Tue, 12 Nov 2024 06:58:57 -0700
Message-Id: <20241112135911.630586-5-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241112135911.630586-1-sjg@chromium.org>
References: <20241112135911.630586-1-sjg@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::d2a;
 envelope-from=sjg@chromium.org; helo=mail-io1-xd2a.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.122,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Provide the 'dhry' command, which helps to check that kvm is being used
properly with QEMU.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 configs/qemu-x86_64_defconfig | 1 +
 configs/qemu-x86_defconfig    | 1 +
 2 files changed, 2 insertions(+)

diff --git a/configs/qemu-x86_64_defconfig b/configs/qemu-x86_64_defconfig
index 1670c122002..151c5f3e0e7 100644
--- a/configs/qemu-x86_64_defconfig
+++ b/configs/qemu-x86_64_defconfig
@@ -87,4 +87,5 @@ CONFIG_CONSOLE_SCROLL_LINES=5
 CONFIG_SPL_VIDEO=y
 # CONFIG_SPL_USE_TINY_PRINTF is not set
 CONFIG_GENERATE_ACPI_TABLE=y
+CONFIG_CMD_DHRYSTONE=y
 # CONFIG_GZIP is not set
diff --git a/configs/qemu-x86_defconfig b/configs/qemu-x86_defconfig
index 40c2f1cd362..5c5cacd734c 100644
--- a/configs/qemu-x86_defconfig
+++ b/configs/qemu-x86_defconfig
@@ -62,4 +62,5 @@ CONFIG_VIDEO_BOCHS=y
 # CONFIG_VIDEO_VESA is not set
 CONFIG_CONSOLE_SCROLL_LINES=5
 CONFIG_GENERATE_ACPI_TABLE=y
+CONFIG_CMD_DHRYSTONE=y
 # CONFIG_GZIP is not set
-- 
2.34.1


