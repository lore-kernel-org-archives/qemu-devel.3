Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E67EC3DA70
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2024 16:24:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYpce-0008NP-F5; Tue, 30 Jul 2024 12:22:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sYpcc-0008Gj-Uo
 for qemu-devel@nongnu.org; Tue, 30 Jul 2024 12:22:46 -0400
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sYpca-0003XR-LU
 for qemu-devel@nongnu.org; Tue, 30 Jul 2024 12:22:46 -0400
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-5a2ffc34722so52163a12.0
 for <qemu-devel@nongnu.org>; Tue, 30 Jul 2024 09:22:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722356563; x=1722961363; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=keY6VpPVumnjGkrnimQUeQrjJ9wrFpao2IDVhIYi/0I=;
 b=FphgzqXrRP54NFsWF9APP55aWbD/5pwaqEErffH/smztR6oGQVuOOkp2O3xqy+1gzA
 apseVmMv60WkN+hbq7FVaJSWcslroJ3tfuwjJr037uBHamIO2MYuqlnBzCqW6324pREF
 a+jdPBqcrbcNxO5nEFxChoN33jf+fz+g1kQaDi6Xn+LOdT2b0jLVz7wmWnPWpGtfvrae
 ntj+SSXr3PLbZxDCBYHTw39LryHcO3rFLIvzqzeZnCJQS9dDbUPpXuVyXYn/4zMHV+1y
 gm0S/R9BYJlWIveVKUFASfglNJdhKiMARZlDRbx+CZxgmczesnv+Q8e6N/66y5xgtrop
 8gzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722356563; x=1722961363;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=keY6VpPVumnjGkrnimQUeQrjJ9wrFpao2IDVhIYi/0I=;
 b=WedtOMQHpxkF6uV+THZECynUQZTLpE+g4VLi4BfaNBxhqJLynwduJek7ycnu8H/8jU
 +7HltVim0y2rT8gE9awRTpw2GQGI5ykiRF0gBr0+xLwDBLyaNntxhzH0cZywcSoHeIwx
 sH+BgzFMo9GLPUal/0dEFLq5VIKa1myt+r4qg+FHaiYXsj1rWrOYuPJMSp4jANL5UwXG
 zY5jNJndVvqkAjy7FoeBypLIfxCFN94wyphldYXTxOT4RVA3au76WOY+MI9bv81JNj4k
 qKmZRERxkg6uSpjSaqt5WKNwy9gU/y3XqD1ovVNrt7Vrvr0Wcd/xdjFx+NqPAdsoO4lK
 bRcw==
X-Gm-Message-State: AOJu0Yw71WEiHwKRdAQOc+tpM1fNaFiCCmlEcuz9vUfpu9ia3JptBS/h
 q3G1QCj4lqDOv84klNpkHXwQja+e1wFKAQvSFu+u7SfegMiLy3HnwpN9wZyLwZ+9QDRbtgmSD3E
 O
X-Google-Smtp-Source: AGHT+IHfQ5zdpuKYoSSOqbu3rVxgU1IcF5SN4aknac49jKQyMvDylO1sDAOKyv46RZ5Z6YbTqrQmeg==
X-Received: by 2002:a50:931d:0:b0:5b4:cbba:902a with SMTP id
 4fb4d7f45d1cf-5b4cbc9e0aamr2080087a12.4.1722356562894; 
 Tue, 30 Jul 2024 09:22:42 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5af507c6e9bsm6119847a12.54.2024.07.30.09.22.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jul 2024 09:22:40 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 523095F93A;
 Tue, 30 Jul 2024 17:22:38 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 05/14] tests/tcg: update README
Date: Tue, 30 Jul 2024 17:22:28 +0100
Message-Id: <20240730162237.1425515-6-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240730162237.1425515-1-alex.bennee@linaro.org>
References: <20240730162237.1425515-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x531.google.com
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

Update the document with details about the layout of tests. Remove the
out of date cris comments. Refer to the developer guide for details
about how to run the tests.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20240729144414.830369-6-alex.bennee@linaro.org>

diff --git a/tests/tcg/README b/tests/tcg/README
index 706bb185b4..6d08ca50dc 100644
--- a/tests/tcg/README
+++ b/tests/tcg/README
@@ -1,9 +1,14 @@
-This directory contains various interesting guest programs for
-regression testing. Tests are either multi-arch, meaning they can be
-built for all guest architectures that support linux-user executable,
-or they are architecture specific.
-
-CRIS
-====
-The testsuite for CRIS is in tests/tcg/cris.  You can run it
-with "make test-cris".
+This directory contains various interesting guest binaries for
+regression testing the Tiny Code Generator doing system and user-mode
+emulation.
+
+The multiarch directory contains shared code for tests that can be
+built for all guest architectures. Architecture specific code can be
+found in their respective directories.
+
+System mode tests will be under the "system" subdirectories.
+
+GDB scripts for exercising the gdbstub on specific tests will be found
+under the "gdbstb" subdirectories.
+
+See the developer guide for more instructions on "make check-tcg"
-- 
2.39.2


