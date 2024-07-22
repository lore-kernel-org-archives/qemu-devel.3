Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7611C3DA5D
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2024 11:06:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sVqqE-00065c-SI; Mon, 22 Jul 2024 07:04:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sVqqC-0005vX-9b
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 07:04:28 -0400
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sVqqA-0002Ud-Kh
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 07:04:28 -0400
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-5a2a90243c9so3130754a12.0
 for <qemu-devel@nongnu.org>; Mon, 22 Jul 2024 04:04:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721646264; x=1722251064; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=N5Md4ulxL95o26Yk8COW88V0WI0Iz0p2W7Xea2hC5X0=;
 b=OUeccvxNIGQ43WKRmmtf+e8xP23rQBnyhroNgaUZB5j25of/PWHp2kf2w+7ayqutE6
 kzQ36iV67E/BFzbm3qDWBh5uh+WKqpkRWmBYxO3mZGFuNG6hIeJ5zOe9WO3TrwYIaaT4
 CX8hlK9NQpukDqhKSyP7ydvppmsh1y97RTeZIqq1CaU/gzhaOKeKFlk09xC+7LCPkIYB
 PJIYB5kwv7CuZ+OpONZOHEZQUaixyKtT+wKCsi2N1/zy2Ig+KCP2o8jSmb2o6jOSFHak
 F5sfu4BH7oc9QBef2FF4mOohNYrpT8AR9CDBPpY2fzMzpcfCNF4lYRAhAbCCCFooQMTl
 q9CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721646264; x=1722251064;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=N5Md4ulxL95o26Yk8COW88V0WI0Iz0p2W7Xea2hC5X0=;
 b=mOeZje39UJLDRqfGVM4Ic/b7bmddFCfk7zI6IwDOKaIV3pLNLruzIHf9Rct5sCZeer
 xgC07mwDDAYD6pRjbMpyBBOdE6DooXMURnPS0BgAsE804QTrPZtskA0lP1C78IQq9VNk
 F48LQxoFSolwcJ832+SbMMDDOZn6lrfNgQU2K12LNfeCLwBDpTdQ4WrLLvIhEwxIwstN
 Z7p6uf/AWy6ZFZQae/Lt6MkZlxYA2SIjBbHQOx/ePCDZHuZEfVAnZhn/VGWo+PZf57UK
 k2n0j7L3Hl/Y/SVZSG0d+DinjAtT5oPVzFxLjlPXn0bxuYJkm6l9S/4kUPuRTU3maqL0
 btUg==
X-Gm-Message-State: AOJu0Yx9AGamakjzgLfbln0+1MkMoYsGoGtA+xD35W0hAZ3ZvSATNiTX
 G2v3GNbL3PPMyJuOuwSY4vuWsJpok9dRnElc2wcewwZYE3q/z0SVY8eAYuUgQ0bXmqUnzw6Czp2
 v
X-Google-Smtp-Source: AGHT+IE5NPpPdmE8l4TzWUyD14yNKEkIzbpnjZjn0H04VScby9QjVy1BTM5FLyxZlsnVB3mcFm/M+g==
X-Received: by 2002:a05:6402:3486:b0:5a3:18a6:698a with SMTP id
 4fb4d7f45d1cf-5a47ac09492mr4527718a12.33.1721646264018; 
 Mon, 22 Jul 2024 04:04:24 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5a30c7d326csm5881186a12.86.2024.07.22.04.04.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jul 2024 04:04:20 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id B94B4620FD;
 Mon, 22 Jul 2024 12:04:14 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Anton Johansson <anjo@rev.ng>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>
Subject: [PULL 12/16] target/mips: Restrict semihosting to TCG
Date: Mon, 22 Jul 2024 12:04:09 +0100
Message-Id: <20240722110413.118418-13-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240722110413.118418-1-alex.bennee@linaro.org>
References: <20240722110413.118418-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x536.google.com
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Semihosting currently uses the TCG probe_access API. To prepare for
encoding the TCG dependency in Kconfig, do not enable it unless TCG
is available.

Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Anton Johansson <anjo@rev.ng>
Message-Id: <20240717105723.58965-6-philmd@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20240718094523.1198645-13-alex.bennee@linaro.org>

diff --git a/target/mips/Kconfig b/target/mips/Kconfig
index eb19c94c7d..876048b150 100644
--- a/target/mips/Kconfig
+++ b/target/mips/Kconfig
@@ -1,6 +1,6 @@
 config MIPS
     bool
-    select SEMIHOSTING
+    imply SEMIHOSTING if TCG
 
 config MIPS64
     bool
-- 
2.39.2


