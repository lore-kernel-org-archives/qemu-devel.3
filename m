Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F166CD5BD2
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2026 05:41:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSpx2-0001s0-Ko; Fri, 29 May 2026 01:40:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wSpwY-0001qV-AU
 for qemu-devel@nongnu.org; Fri, 29 May 2026 01:39:39 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wSpwW-00023Q-Mw
 for qemu-devel@nongnu.org; Fri, 29 May 2026 01:39:38 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-45ef1198766so162180f8f.0
 for <qemu-devel@nongnu.org>; Thu, 28 May 2026 22:39:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780033175; x=1780637975; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1l1tb6Up19hntMi5gc55FAeTHoVM4kotrtOzQ9GwQF8=;
 b=I6aQLS5FdYtNuMDzSSLDSC5ILdcs1tWYSUdn9CFW92tDzIfWIY7tmO5oz0Va8Tewyt
 zh9W5MDyK/hEzs6fmlQ64W5FbKPFH3fqUZ9aN4wWpD4AB5kGFbQNvKCC2QogLilUbPHw
 iTCrVe2V5U4Bzg5BGU9wUAFc/n5XzJlnrKou/M8b7sp8Rm+ug8LwiSs/anh+7o8Sr9ru
 aM4APx6u/ZyrpCbY+Wrr+RwOoT1XV5W7NSK0Xm1tFeqxNGTA5tlatXZdrGjpPx4ayuI8
 1Z+JE/Zgk269bp5j+005X9lvurx1XkkKG1PF2QVKvqhXBqDJbA4VotJvARYYSyV8c5LP
 YnZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780033175; x=1780637975;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=1l1tb6Up19hntMi5gc55FAeTHoVM4kotrtOzQ9GwQF8=;
 b=e5/2oxqRMFkOrgsFgWagM0yBywO0k2XQan+c8TcgC2nwnl0nSqm0HTi/SnVebUgR2e
 zUl5KK4AU2xPaWQrGcF+8tssBDIl2bTNxJt3p81mYcgCMNsNKtCpZorHuPHqkWu3E917
 Z9LBP+Rpq/dkdUn/yB9YN7MSDp/1FnGMm6CfgjX29ZQD2fzlyLXNa16OIPnaYHO2+uCz
 kbO+YX5Qm75qNh/RoN2hpKTrW33f9lH/TyGZ106meJWvQV7qD7mcd6v91fX1SR1bIWYJ
 LRWJGFTn+KU/cT5QyKfW0cBvX1rJGLPbGmChayseu5bVUuYYmVK/z8/p2JBA2Ftd1l2x
 bSEA==
X-Gm-Message-State: AOJu0YzocdmXTsocGntXcGYDCJaVTdHO19BMGNvmCm4uKOVV9G1tXA/z
 2E9jNIFXNrS0S753tGEk/xDJnRWZMTkAXCfLMV0U/oOoXx+eGekbCf4diYY21b3sKnE=
X-Gm-Gg: Acq92OHetSg17h64A4eAR3m7FbzD9q5+s7OZ8UjOSckrSfVR83BMWrc/V7VR3IdrBwv
 0scDnTyaeN9mzlLeuPBj3nd46ZwLo/HhGBCy5JK/GjtJW2xlhk1L9LUpbzVwdHv7KgWRDP4z03Q
 AF0ZXJlfGLF/7EE6/jAzdgJJoJilNj4aHLtWLRG4cyzNi2kxT1ngAPaeNxqmtpuXrRAmxyDylNz
 uaw2WkNUXHn0wSCcWGO73EmA1aZZ45PVWMLvDNmDg9dpXydJvJscb/vcyo0R/nEp+Q41JnTe3DO
 341f8y3ZHT7PhhWiqTB1EnZQG3bS3LqWxh5ORMVm/0mTgEqEN4ziSIOcYOj1QnLLieI05Knm1rs
 0WEx2Y/L3futg3SX7wBTaj6T5IQ1yg84EeqayK79XIOzrXlwFwwZ9er0LC6/xyR/5GHeOfJrDCD
 +brOIIcynZuCcYe/IvQowUTPVpgBvhcb2QGw==
X-Received: by 2002:a05:6000:1869:b0:45e:8ad3:86a9 with SMTP id
 ffacd0b85a97d-45ef13397a5mr1964452f8f.8.1780033174752; 
 Thu, 28 May 2026 22:39:34 -0700 (PDT)
Received: from draig.lan ([185.124.0.195]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45ef35601d7sm1205277f8f.28.2026.05.28.22.39.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 May 2026 22:39:32 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 096655FA53;
 Fri, 29 May 2026 06:39:32 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PULL 01/13] Makefile: include tests/Makefile.include before ninja
 calculation
Date: Fri, 29 May 2026 06:39:19 +0100
Message-ID: <20260529053931.283970-2-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260529053931.283970-1-alex.bennee@linaro.org>
References: <20260529053931.283970-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x436.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

As the tests Makefile sets .ninja-goals we need it to be included
before we do the calculations in the main Makefile.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Message-ID: <20260526110243.470002-2-alex.bennee@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/Makefile b/Makefile
index 54547a37b1a..829c51e364c 100644
--- a/Makefile
+++ b/Makefile
@@ -45,6 +45,8 @@ include config-host.mak
 include Makefile.prereqs
 Makefile.prereqs: config-host.mak
 
+include $(SRC_PATH)/tests/Makefile.include
+
 # 0. ensure the build tree is okay
 
 # Check that we're not trying to do an out-of-tree build from
@@ -180,8 +182,6 @@ endif # config-host.mak does not exist
 
 SUBDIR_MAKEFLAGS=$(if $(V),,--no-print-directory --quiet)
 
-include $(SRC_PATH)/tests/Makefile.include
-
 all: recurse-all
 
 SUBDIR_RULES=$(foreach t, all clean distclean, $(addsuffix /$(t), $(SUBDIRS)))
-- 
2.47.3


