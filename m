Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 624B5CEACE8
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2024 16:41:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svfv6-0006TN-Jt; Tue, 01 Oct 2024 12:40:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1svfuf-0005bL-Pl
 for qemu-devel@nongnu.org; Tue, 01 Oct 2024 12:39:50 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1svfuY-00068C-Lt
 for qemu-devel@nongnu.org; Tue, 01 Oct 2024 12:39:49 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-37cd3419937so2850178f8f.0
 for <qemu-devel@nongnu.org>; Tue, 01 Oct 2024 09:39:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727800781; x=1728405581; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=bVlR7kii/ePNcpWm6jthZNiMpG/LXq1TJA5XSo6mGdo=;
 b=X/xIVGu8NvldygZ+E++z/Wt9d6rRLNRhZ3zUj23pBPYzJ/wMNFLOAEwjhsga8gau2y
 98COkKyxrGMuFGuPLVLaeUnaRaUObmbwl4sZyVaOOt5/gclleYZtWlzmYV9pFGDVlbr5
 +qo6Fha5L1oWfpjJPre+aC3rBqpBNN+LhtzGGiRq19wwj837wkbAs2z4krMSHgL6fIeJ
 XXdEd12DD5uS7e+gireIwwN1j5eAIC+XGr6IUdVGEGhJSeI5sbxP20QgxnHJ2YCg8U7l
 8iwNaaSfI9l5Kkfj29rwn9L8IQNMbo5poWnnhMjkrH6Ox0xV4V+ps37hfaGSadgEAhsc
 C1WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727800781; x=1728405581;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bVlR7kii/ePNcpWm6jthZNiMpG/LXq1TJA5XSo6mGdo=;
 b=rpt60i6w76Ojz7tTtlZhsilJwUGnqluCF44rHq3z/H1/imJRrERlh0DC6nXLiGkJeR
 OWC5DlD/BsBO0HWUdIf8SswfRnK/cSkXbfv34zZtCh5EKRHM7cJbpTw+tqCOtGRcQ5aD
 1nkZNT5WjYrxOfO6ZRxBJ1+1Kj3nfKECt4HMYM+dfZuKYtfzBp1YUipoU/gXi0XWtCjO
 ZzzhmZTh2WRSS4h7IAZWhuor2YS+in5pFnPJaAIv6W4MY7fufo9jSwclb6gK7Wm7BpvU
 7VpesfL653yBla/z5Ojz5z7tAhLdk3LdmLhlINC7gHHvmPVGI8MZRgokhJq/WPssmiUd
 yWJQ==
X-Gm-Message-State: AOJu0YxI2WuoBdBlS/ptLPQQPrPOA+OXWD2+vO1STnOPHzqLn0VXdhls
 nPu5YKzuPYCoqzxozqLE5BVR2AH7gQUOmKRFOxpMi8SJOdOf4b/jMFY7EPL3VNwejJCq3DFYHQ5
 a
X-Google-Smtp-Source: AGHT+IFnSFgvvsi7vF9YerRhkxXLECl9QAxvU6WgY0cCm6H0fQKlHnIF7ScD/zrL4xwNtU/vRr0iEg==
X-Received: by 2002:a05:6000:1244:b0:376:7a68:bc42 with SMTP id
 ffacd0b85a97d-37cfb9d440dmr116722f8f.27.1727800780944; 
 Tue, 01 Oct 2024 09:39:40 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37cd56e6547sm12243771f8f.58.2024.10.01.09.39.40
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Oct 2024 09:39:40 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 38/54] docs: Document removal of old Arm boards
Date: Tue,  1 Oct 2024 17:39:02 +0100
Message-Id: <20241001163918.1275441-39-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241001163918.1275441-1-peter.maydell@linaro.org>
References: <20241001163918.1275441-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42e.google.com
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

Now we have removed all the board types that it covers, we can move
the text about old Arm boards from deprecated.rst to
removed-features.rst, tweaking it appropriately.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20240903160751.4100218-37-peter.maydell@linaro.org
---
 docs/about/deprecated.rst       | 15 ---------------
 docs/about/removed-features.rst | 14 ++++++++++++++
 2 files changed, 14 insertions(+), 15 deletions(-)

diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
index c0aa52def58..1e21fbbf778 100644
--- a/docs/about/deprecated.rst
+++ b/docs/about/deprecated.rst
@@ -251,21 +251,6 @@ to correct issues, mostly regarding migration compatibility. These are
 no longer maintained and removing them will make the code easier to
 read and maintain. Use versions 3.0 and above as a replacement.
 
-Arm machines ``akita``, ``borzoi``, ``cheetah``, ``connex``, ``mainstone``, ``n800``, ``n810``, ``spitz``, ``terrier``, ``tosa``, ``verdex``, ``z2`` (since 9.0)
-''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
-
-QEMU includes models of some machine types where the QEMU code that
-emulates their SoCs is very old and unmaintained. This code is now
-blocking our ability to move forward with various changes across
-the codebase, and over many years nobody has been interested in
-trying to modernise it. We don't expect any of these machines to have
-a large number of users, because they're all modelling hardware that
-has now passed away into history. We are therefore dropping support
-for all machine types using the PXA2xx and OMAP2 SoCs. We are also
-dropping the ``cheetah`` OMAP1 board, because we don't have any
-test images for it and don't know of anybody who does; the ``sx1``
-and ``sx1-v1`` OMAP1 machines remain supported for now.
-
 PPC 405 ``ref405ep`` machine (since 9.1)
 ''''''''''''''''''''''''''''''''''''''''
 
diff --git a/docs/about/removed-features.rst b/docs/about/removed-features.rst
index 06f8cc1b739..6e96cd067fa 100644
--- a/docs/about/removed-features.rst
+++ b/docs/about/removed-features.rst
@@ -998,6 +998,20 @@ The Nios II architecture was orphan.
 
 The machine was unmaintained.
 
+Arm machines ``akita``, ``borzoi``, ``cheetah``, ``connex``, ``mainstone``, ``n800``, ``n810``, ``spitz``, ``terrier``, ``tosa``, ``verdex``, ``z2`` (removed in 9.2)
+'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
+
+QEMU included models of some machine types where the QEMU code that
+emulates their SoCs was very old and unmaintained. This code was
+blocking our ability to move forward with various changes across
+the codebase, and over many years nobody has been interested in
+trying to modernise it. We don't expect any of these machines to have
+a large number of users, because they're all modelling hardware that
+has now passed away into history. We are therefore dropping support
+for all machine types using the PXA2xx and OMAP2 SoCs. We are also
+dropping the ``cheetah`` OMAP1 board, because we don't have any
+test images for it and don't know of anybody who does.
+
 linux-user mode CPUs
 --------------------
 
-- 
2.34.1


