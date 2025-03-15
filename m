Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F5A5C28B30
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Mar 2025 14:28:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ttSUA-0005Q6-3o; Sat, 15 Mar 2025 10:27:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sjg@chromium.org>) id 1ttSU1-0005Nq-GG
 for qemu-devel@nongnu.org; Sat, 15 Mar 2025 10:27:27 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <sjg@chromium.org>) id 1ttSTy-0003ok-Cg
 for qemu-devel@nongnu.org; Sat, 15 Mar 2025 10:27:23 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-43d0618746bso4407415e9.2
 for <qemu-devel@nongnu.org>; Sat, 15 Mar 2025 07:27:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1742048840; x=1742653640; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UBXnQzSJkDrutDwfAQ4rGuJkH23aeovCFlYOdDvXid8=;
 b=SAdtfvxb+yWIaeSH8r6horw3QPxasI9m6TKNDkee1hQqXQO6TmrkZ6GcTMClt4d7xz
 Jd3VE0jcYnm0cL96/7+Waad0nb6wzmhG7b2xXwbbO4VSLBSzyP7c1vY3iy1oZ1yXeSPS
 Bmb6cpbQU5raXQwgbMtSIulg9YCqppjZxVFFw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742048840; x=1742653640;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UBXnQzSJkDrutDwfAQ4rGuJkH23aeovCFlYOdDvXid8=;
 b=JwF7J0HTYckf/MU/l/i8O5h1STKbPiT+jZ57bkNrxN8ImQ0e9rdc2gA+mJTGJ+P3fR
 BNp94oI6/IU05Az+9vabJWtwTBB8lth9Ta/A2TVXofSCUyK5vkcJpiMpI0MWhFQVlYrV
 VfcHdYfyraZVsCjd+tnOWxtHwNYc4XwAaOybQrCQ9/wbZcghr4kNNB6smrqtn8TQlgQ3
 9RC+GnPN2TXcwISQC8VoKnuzG0INdNDAbbDEPQxJDpOzlgTmvPdGd8NaF8LcS3Yl2Sjw
 aC3ldP63Z/dyCx2j9bS6Fz6FhRqt4zeqs/tuUL4cq0U1eV7x2AbT5tbfTn+4KsJecyPN
 PSyw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWgKqXL49i8OUH1T9Lspo7GSQjGSlUPY7RWrXZTDVBNlcLCoSexYjAOBOOOIfm0zx3Hoi5aaVwhh1fy@nongnu.org
X-Gm-Message-State: AOJu0Yz4jlmULKLFyxP5tvaGCCFfBI7ScvIG7+YtNrFBuiU02yIVirZs
 Frv5aiYFvJAaSduNndlF4gohjPnLpT7zNfC9HP50E78cwSJz3opOR2EVnyU6Zs4E5iRv4fMmoYw
 yew==
X-Gm-Gg: ASbGnctBRt9eIKAIiHsf3UK+q8PRdXsc0iBiNAH8mXZDFgMOtvGWicu12oNGaTtCVpj
 14w6g+M0bPW94ubhB9ICoiNBR+yGAMRu1JHik2BpSz5RzY0n+/G6w/SgS/TzsUwppQ4S4bU/rEF
 cE/W2D9/tETBpSAn8UoucYA9qcvUMNQgRdpGdXBV44zEqri0slot6L2PR/GAq3fZJwJJLb4dBeu
 7CBaVEYCJBAseRhC4jjJ7+XZP+RN9y0LkfrAyoZssaQBkuVo/MKPOqKjdXuhTGvf7y83v69rE0m
 c/8V6H4V8aDycJWTJZpVzbw9U8MhvofmTtuSD7qpcx1qSe6qMq2G
X-Google-Smtp-Source: AGHT+IH/HdP6BEy1WTT5a2X08eIirw3HQmbDV3BPB+Jy3jjVkY3LBdM6hR0iTikuybrv4UsVaxCdHQ==
X-Received: by 2002:a05:600c:41d3:b0:43c:f689:dd with SMTP id
 5b1f17b1804b1-43d20e467c7mr64663245e9.19.1742048840180; 
 Sat, 15 Mar 2025 07:27:20 -0700 (PDT)
Received: from chromium.org ([169.155.233.10])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d1fe29386sm52105055e9.17.2025.03.15.07.27.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 15 Mar 2025 07:27:19 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Bin Meng <bmeng.cn@gmail.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, qemu-devel@nongnu.org
Subject: [PATCH v5 05/46] x86: qemu: Enable dhrystone
Date: Sat, 15 Mar 2025 14:25:25 +0000
Message-ID: <20250315142643.2600605-6-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250315142643.2600605-1-sjg@chromium.org>
References: <20250315142643.2600605-1-sjg@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=sjg@chromium.org; helo=mail-wm1-x330.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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


