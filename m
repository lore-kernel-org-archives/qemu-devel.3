Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4CCBC3DA44
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2024 15:32:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPktz-0005gw-A3; Fri, 05 Jul 2024 11:31:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sPktv-0005dC-CX
 for qemu-devel@nongnu.org; Fri, 05 Jul 2024 11:31:07 -0400
Received: from mail-lf1-x12d.google.com ([2a00:1450:4864:20::12d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sPktq-0000O6-Vi
 for qemu-devel@nongnu.org; Fri, 05 Jul 2024 11:31:07 -0400
Received: by mail-lf1-x12d.google.com with SMTP id
 2adb3069b0e04-52ea5dc3c66so1501632e87.3
 for <qemu-devel@nongnu.org>; Fri, 05 Jul 2024 08:31:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720193461; x=1720798261; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mWUoJ8jMYHKZK6JbWNGMObF6aodq8m6nBv1ts3bfECs=;
 b=Sg2UBWVl7UkQNaW0vv0qf0dJ4Jw9egmEwa+LkZInYeT9numwHEfcGhoHWGVZ7DliYZ
 lmQFvXLPwqaCPevX4+5ESVBcHjqofLY7/IwSf1J2OA1ipPkaqYORdpS3xqPrcdC5f56T
 9wJUQfjlyoQpS4Wz+DNwQuJzrbFrIA71mNl4/nV7x0hGlB7KIXsX1mWDDuU7zImYcMXK
 +3ncEoOtfjELiQXEQGJ0S2vZ587sqSAw0SaFQsE4WtjXonTKnCSQkLkYVNcWDqlCUBjb
 vtbffZiJQXgqKXxjd0xvUFdgJzr4g9j7R747ogopJ2chwgmZsyFTIvR2vdLccFeyBEDh
 4bxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720193461; x=1720798261;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mWUoJ8jMYHKZK6JbWNGMObF6aodq8m6nBv1ts3bfECs=;
 b=HdlBeNr2BcWdYOu/WMT3XcKr6fcO2uyg1A+KTkqqAjli+7rx6leaPSrmuter1MUkfx
 37Pn0I3Egk+8IMiOoqwiShQjVvLae9LzZQ5yR+qLLD01vvh4pnxVA/ucrEuUSD90I0l2
 1TnDbPPeRolBzfNWRfYCxP7d/R6riFRKl8doK2LHdiMHe2hay+sZT3/FvwiqWd7T60we
 zRJb3gEJ/U6FZ6666eGXau3ebVKQtOroXVWLJJPAotPbawa/rXubIsX0pMcZbPRA5d8I
 iexomt7+Aa2kdsZnpjAQtBw9+E9v/NlCitsSZDmktktcLxb7tI2IMcoB+QULFSKX8l4u
 3yWw==
X-Gm-Message-State: AOJu0Yzjhv/d6ocD2hD7ByqqgFSbvSmkTWHFCcMm7h8WdnUqdz1h3l2d
 opktlS8XztUnIswOp+9pJw/oxPGzDRrRumUusJAvEZfVEmoZO4oKDbJsVMA0VyCbdCf+ZB8/+hd
 s
X-Google-Smtp-Source: AGHT+IG0SSWEJpdw2cBbq/3YXwpEo0ihf9pl6B/13VyKeqvdIa58uYBQExqWIflSxlPgNT2fdf27+g==
X-Received: by 2002:a05:6512:32a6:b0:52d:3ada:4b6b with SMTP id
 2adb3069b0e04-52ea060dc75mr4337366e87.1.1720193460674; 
 Fri, 05 Jul 2024 08:31:00 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a77a18c7123sm236694766b.58.2024.07.05.08.30.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Jul 2024 08:30:57 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 21C23620FD;
 Fri,  5 Jul 2024 16:30:54 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 qemu-arm@nongnu.org (open list:ARM TCG CPUs)
Subject: [PULL 12/40] tests/tcg/aarch64: Add -fno-integrated-as for sme
Date: Fri,  5 Jul 2024 16:30:24 +0100
Message-Id: <20240705153052.1219696-13-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240705153052.1219696-1-alex.bennee@linaro.org>
References: <20240705153052.1219696-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12d;
 envelope-from=alex.bennee@linaro.org; helo=mail-lf1-x12d.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

The only use of SME is inline assembly.  Both gcc and clang only
support SME with very recent releases; by deferring detection to
the assembler we get better test coverage.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Message-Id: <20240630190050.160642-8-richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20240705084047.857176-13-alex.bennee@linaro.org>

diff --git a/tests/tcg/aarch64/Makefile.target b/tests/tcg/aarch64/Makefile.target
index 11ccde5579..ad1774c2ce 100644
--- a/tests/tcg/aarch64/Makefile.target
+++ b/tests/tcg/aarch64/Makefile.target
@@ -20,6 +20,7 @@ run-fcvt: fcvt
 
 config-cc.mak: Makefile
 	$(quiet-@)( \
+	    fnia=`$(call cc-test,-fno-integrated-as) && echo -fno-integrated-as`; \
 	    $(call cc-option,-march=armv8.1-a+sve,          CROSS_CC_HAS_SVE); \
 	    $(call cc-option,-march=armv8.1-a+sve2,         CROSS_CC_HAS_SVE2); \
 	    $(call cc-option,-march=armv8.2-a,              CROSS_CC_HAS_ARMV8_2); \
@@ -27,7 +28,7 @@ config-cc.mak: Makefile
 	    $(call cc-option,-march=armv8.5-a,              CROSS_CC_HAS_ARMV8_5); \
 	    $(call cc-option,-mbranch-protection=standard,  CROSS_CC_HAS_ARMV8_BTI); \
 	    $(call cc-option,-march=armv8.5-a+memtag,       CROSS_CC_HAS_ARMV8_MTE); \
-	    $(call cc-option,-Wa$(COMMA)-march=armv9-a+sme, CROSS_AS_HAS_ARMV9_SME)) 3> config-cc.mak
+	    $(call cc-option,-Wa$(COMMA)-march=armv9-a+sme $$fnia, CROSS_AS_HAS_ARMV9_SME)) 3> config-cc.mak
 -include config-cc.mak
 
 ifneq ($(CROSS_CC_HAS_ARMV8_2),)
-- 
2.39.2


