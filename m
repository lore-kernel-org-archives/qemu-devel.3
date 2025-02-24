Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 468B7C021A4
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2025 23:08:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmhXa-0005t5-19; Mon, 24 Feb 2025 18:07:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sjg@chromium.org>) id 1tmhXX-0005sg-QU
 for qemu-devel@nongnu.org; Mon, 24 Feb 2025 18:07:07 -0500
Received: from mail-il1-x130.google.com ([2607:f8b0:4864:20::130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <sjg@chromium.org>) id 1tmhXS-0007Vc-My
 for qemu-devel@nongnu.org; Mon, 24 Feb 2025 18:07:07 -0500
Received: by mail-il1-x130.google.com with SMTP id
 e9e14a558f8ab-3d2f7257181so2878725ab.1
 for <qemu-devel@nongnu.org>; Mon, 24 Feb 2025 15:07:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1740438421; x=1741043221; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UBXnQzSJkDrutDwfAQ4rGuJkH23aeovCFlYOdDvXid8=;
 b=X0UKPus2/SYniXpwy5gL9PWcN31VSI4+TLyarsubPgqMck9XN+p4+wbU5rOT324VEJ
 3FcKmQdfoWB7m2a5Zq0jzVFBS8cDavKZg4Q64tNvP6TvJ8LTOsSUobnLmcpCKDgx9BLb
 qLMzpCjXIhL0i/qtEKbkIRCEWhI3029n7Ihm8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740438421; x=1741043221;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UBXnQzSJkDrutDwfAQ4rGuJkH23aeovCFlYOdDvXid8=;
 b=Eb/vBfSXyPnd3lRKga2vJie71EKQC9VgQjji1+kUbs96vSpUdXlHHSDXwOg8lsWUI/
 uljjxWbfC3bTuN9meFHdKnV52PGHMWUlPC4jYbguBsuFcZ1K4Oi1RQ0QgoUdmBz6SBUZ
 bnfoTEdkk0owohtYPfoL3Ob+3GMSP/ObZIG2y0uVejuCA1fvZNzvBOJHI8uYkBgEAvRr
 MiM8TdikzJnD8UoolhmvAqxksVcv182FQHHdVKr6IeE5Or+UhZVFdVz20OD/mWmzqFbg
 lIVqHS9vV0Nc/EhBDGigTqN4fpz38ZjEuQpGt1iqWmZz3E2YeHs24Z5qqzVvBrC12x1A
 VPqA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVNdhAb1Gk4b+WuNQljdg2MduhhicHWx06jgNzBfajdcUT3diFB+WNmY3J5LqzzXfQXYtAfbo+plaFN@nongnu.org
X-Gm-Message-State: AOJu0YxbZYFeiGg6inHtDOktV/jBoORXXhMaVmYicv1w6e1h0tGb+Ovj
 ndD5+V4JW5eHZYDQ3zka51TDIMUGMx5BGfIzwN8V4TDX6N35p5ngWVVzvRFcgg==
X-Gm-Gg: ASbGncvfml4oGx+xzjIUwtvx5Yr9jGNmg4S/bqr0I3ccXN6Wvc+firA/xMYcb0J83hf
 8sWEcPDyosD3a8m39xCUZsaD06Q/VymlOACZ+zZBYtUPWqmkK9aVBjahSc3HQNCD+WLT8WQaDyW
 3J2gAucj0jhPcI91JDEWH1t291BRVfLGKYygBGB0eNgPedsTGu7FR6639Np0ll4Zxuj4A99YJRT
 Jw46PIMYHl+Mk2S4J2PRHd7mgORhzqVnQYq1gGWibQ70VyaF4TR4jC+uGoT4zI1qTydZhV4gywP
 0LI9XRv+W4+Vsq5aG75qsFFtQy/MATH9idBtP5C4VfC9/8+fI39vKXhmi3Go/nY=
X-Google-Smtp-Source: AGHT+IFSb+pEHS3x7L/kHUkbhEPATcpEm/zxcvv7hUlNWHfESUt4vsg1VOOpXmfvLtMXm5ytGWqRzw==
X-Received: by 2002:a05:6e02:23c1:b0:3cf:fb97:c313 with SMTP id
 e9e14a558f8ab-3d2caf01835mr179643675ab.18.1740438420777; 
 Mon, 24 Feb 2025 15:07:00 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4f04752e026sm113941173.107.2025.02.24.15.06.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Feb 2025 15:07:00 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Bin Meng <bmeng.cn@gmail.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, qemu-devel@nongnu.org
Subject: [PATCH v3 03/44] x86: qemu: Enable dhrystone
Date: Mon, 24 Feb 2025 16:05:52 -0700
Message-ID: <20250224230640.2665206-4-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250224230640.2665206-1-sjg@chromium.org>
References: <20250224230640.2665206-1-sjg@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::130;
 envelope-from=sjg@chromium.org; helo=mail-il1-x130.google.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
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

Provide the 'dhry' command, which helps to check that kvm is being used
properly with QEMU.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 configs/qemu-x86_64_defconfig | 1 +
 configs/qemu-x86_defconfig    | 1 +
 2 files changed, 2 insertions(+)

diff --git a/configs/qemu-x86_64_defconfig b/configs/qemu-x86_64_defconfig
index ff2a192ee7d..84b7dc8e99f 100644
--- a/configs/qemu-x86_64_defconfig
+++ b/configs/qemu-x86_64_defconfig
@@ -89,4 +89,5 @@ CONFIG_CONSOLE_SCROLL_LINES=5
 CONFIG_SPL_VIDEO=y
 # CONFIG_SPL_USE_TINY_PRINTF is not set
 CONFIG_GENERATE_ACPI_TABLE=y
+CONFIG_CMD_DHRYSTONE=y
 # CONFIG_GZIP is not set
diff --git a/configs/qemu-x86_defconfig b/configs/qemu-x86_defconfig
index ee5b150e062..d52afa42955 100644
--- a/configs/qemu-x86_defconfig
+++ b/configs/qemu-x86_defconfig
@@ -66,4 +66,5 @@ CONFIG_VIDEO_BOCHS=y
 # CONFIG_VIDEO_VESA is not set
 CONFIG_CONSOLE_SCROLL_LINES=5
 CONFIG_GENERATE_ACPI_TABLE=y
+CONFIG_CMD_DHRYSTONE=y
 # CONFIG_GZIP is not set
-- 
2.43.0


