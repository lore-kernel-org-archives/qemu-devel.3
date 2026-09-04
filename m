Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D7F4C79F82
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 12:55:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2TQQ-0001kv-QW; Fri, 04 Sep 2026 08:53:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x2TQM-0001iT-Vy
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 08:53:43 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x2TQK-0000jq-S7
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 08:53:42 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-4858c1c4b4eso342280f8f.2
 for <qemu-devel@nongnu.org>; Fri, 04 Sep 2026 05:53:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1788526419; x=1789131219; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=izyohgjy3lmdaKSbluKpCEMzPiSAWdPBGuJragEnhEY=;
 b=JW4/6MmWZLFJjKn21ZToGP4YNnoqKVMh5vYiqQyVa0JRgcnSXAhlvX4vY0zfZ7CXlT
 LxppyocxC7tMkV8W9Uw/k5CqHiDzlf3Kl8j6kmPDMpYpPdRjnAuW0wzdKYoY8+MfQJKX
 i5N6Q1x0ugBZwnYP0nuvB0ZzIgc9t8oW3vgbRln25rtqImZ9BTzoJ3SndQ36pwijj7IN
 tgP7HfNfMsHejQoC6IiTsn5LGfE0b00Edyg5iselBngEzPth5mdlvW6ibHiLv5pgHgsw
 Mm3S4b8ikgYoNxGqyMunjfN3d+gZWL2szQUUIFJqGfp3uanUeUSA0mkXb+/2E6Y+sHUW
 /g6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788526419; x=1789131219;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=izyohgjy3lmdaKSbluKpCEMzPiSAWdPBGuJragEnhEY=;
 b=qo1NOvS/FK9RUIobQ996SBHSo6jTH1jMYBV6BV9ETgykXskDygLJZRvfWvK7qNiBu8
 a72jzRFNkycUsYg3iqixu5tYzp66kGntrsfKEv0If35AqlyUS2iml5Wnks10p5ubMttr
 mARfOS+QCRj3+KoTZ3qddeXfWJ9qds6s5latB75Sx+cJFvZrKt30Fa1hWch7ptA8mYA0
 3NWT9bWtipoqn0uJAoqPfvSqjA10aAVxpJOB8EFXefjL8dwM+X6bmUBgVZMrYIZ5c84F
 eyOn9ZhoznMB9q0eB4grukP9PCnWYcYknDtr4QgvHeq+CwnIwA/k1R7ljuDGM+6Iv1Vl
 FygA==
X-Gm-Message-State: AFuF++mJWQG6PneFrxYZTKlqkYRyq7/EIsiYRqcZXrypKwq53/ZgBZHZ
 7mgMEm8l08czlAV1OqXGC5b1351neJ914vMSrFpvME9jdOQNWL9dvKfsO1+Wd9BOPwM=
X-Gm-Gg: AYBFou3g67LCJYeDRcLby3URVN4dcoY3fQMlZ84lsvCMVeFPiwNH+lZPiG6NWSZgBjN
 wSkvTTyq4MBrrGK3vIAPM2cpvAmCrGe3sQ2W/kJUwxmZmxIZPU1VG8oei1ZAKe7x62oo1Cin30G
 Z7G2gUu3PMnXASYiv6Tr6fFldLlJJCbU5DqoiQWwebhkaY7u3Uvwq2A1ow3b9EBuslzo4gmrgOK
 8Do420+8uyYkf7Rv89a2/DjHixLdWO6L2WOn14tAnGYYGB0gq09nuMTGSrUW0Y5ztWPOY1FoCNI
 2twbBEIYCoD8qrT0mc6+GTZ245GFJZYcL9T7oxt0/Ao7HwosDbsbMwnCXXbUeO0eLPb/exS7S8S
 bcotq0aBGM14wB1NW2qbIb3pEKMObQ863zjtO1PWomVUaht8OaYf/Az1VbdO68C96V0QrEFhEem
 YHurmLGKAaelPK+4sTfxTWhW+qRaCuyhA6+1ipWay+QcVUs8IFvrF5PGPM0RYs
X-Received: by 2002:a5d:52cb:0:b0:481:51b7:290b with SMTP id
 ffacd0b85a97d-485872a7feamr6131855f8f.14.1788526419421; 
 Fri, 04 Sep 2026 05:53:39 -0700 (PDT)
Received: from draig.lan ([185.124.0.156]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-485885b7bfasm6325247f8f.29.2026.09.04.05.53.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Sep 2026 05:53:38 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 7253561834;
 Fri, 04 Sep 2026 13:46:07 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Aniket Sahu <asahu1x@linux.ibm.com>
Subject: [PULL 032/105] tests/tcg/meson.build: add top-level 'tcg-tests' target
Date: Fri,  4 Sep 2026 13:44:46 +0100
Message-ID: <20260904124604.2207440-33-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260904124604.2207440-1-alex.bennee@linaro.org>
References: <20260904124604.2207440-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x434.google.com
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

From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

Add a target to rebuild all tcg-tests at once.

Tested-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Tested-by: Aniket Sahu <asahu1x@linux.ibm.com>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Message-ID: <20260827221506.91574-33-pierrick.bouvier@oss.qualcomm.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
index fe382638297..d16772d498d 100644
--- a/tests/tcg/meson.build
+++ b/tests/tcg/meson.build
@@ -89,6 +89,7 @@ test_plugins = {}
 subdir('plugins')
 
 image_targets = {}
+exe_targets = []
 # Finally, we can create all test executables and test targets
 foreach target, plan: tcg_tests
   # Detect duplicated executables/tests, and report an error to force user to
@@ -298,6 +299,7 @@ foreach target, plan: tcg_tests
                             depends: exe_depends,
                             depend_files: build_test_depend_files,
                             build_by_default: false)
+        exe_targets += exe
         built_tests += {exe_name: exe}
       endif
 
@@ -381,3 +383,8 @@ foreach target, plan: tcg_tests
     endforeach
   endforeach
 endforeach
+
+if exe_targets.length() > 0
+  # finally create a top level target to rebuild all tests
+  alias_target('tcg-tests', exe_targets)
+endif
-- 
2.47.3


