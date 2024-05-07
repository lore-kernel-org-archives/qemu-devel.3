Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 572B9C10F1A
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2024 17:55:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4P0w-0000HY-Em; Tue, 07 May 2024 13:54:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s4P0u-0000Fs-Df
 for qemu-devel@nongnu.org; Tue, 07 May 2024 13:54:04 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s4P0p-0008Al-OS
 for qemu-devel@nongnu.org; Tue, 07 May 2024 13:54:04 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-1ee0132a6f3so21377085ad.0
 for <qemu-devel@nongnu.org>; Tue, 07 May 2024 10:53:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715104438; x=1715709238; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=yKQngX4spBK4x8VqO92tF1b6pgWyAKg0ZeJVwf/CSrc=;
 b=aZISIVvDk8HTJSC8pU5OSBFQzx/qMBw5P3pBFXRUQ4NxbuSs9Y/j6mGyVB27lD1prj
 /tv5gnapcBWrKUIGeT8fSSiQo4q5gO61VKGAXQskKyZvD+bQNBdwTT1TU8WOB0iHKcis
 YqbIGB7XeK07eQWvtJvMp4Jfnfwdm/YZRIudK4iW2KHp+7MXq8oeAhg2fUtX0EtOu7kX
 liE56WKPJnNo6DUdhRjesybBWStUSyfu/niMJ5NKWU0xS4+ZsdNatHK8mrUfS7GI1OAg
 2uU/wBEc8hf9QJlElLG0kk3sdmXN7KJ3ErD8MuWxCh5YCnUJKUK/TAA4TfQWaEafu1MG
 6XHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715104438; x=1715709238;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=yKQngX4spBK4x8VqO92tF1b6pgWyAKg0ZeJVwf/CSrc=;
 b=CPjpZPlFLSU+JX4Hq3yyzjuliiFrJwonR8zFXYn+NWu7hRH8KXt7ngd72oN0xxGhrp
 nUJSyL39deIjUOENPfFvacIENTVwiAxazGMQ5VG+fLehvd4GT8vKaNPFKmr883JJp62e
 moYxI+8kOX9BuEBRN58VAU96G24h/CnGd2BxJ6AHEZJ6f0vMYPbSbWXPgfFV/1j9NR9T
 VHNWbeFxhK4StH7SVqefxdl6D5gcqC4A2c8Q9BDTWwzD3kwcdbRQUew2yUdcTV8SS1Ag
 Yrzg+w/AW2z/n02/4lrr8Mvaz+KbJBGQuSrgXIU2sudzikP+qyzIL4pO2hKo0SpuI5Mu
 8H8w==
X-Gm-Message-State: AOJu0YxgQp3CJoGawnE9mPyLRQ8Oz11zP2YrRGT/WHMK/GtsZfC+T6du
 1UiAT6lKoIzLl+KnMkb8aR1bWO2EfetH7XmFnyIGKgaeL0lbVsiKwKUS41oWoX8urE935+DQd+6
 j
X-Google-Smtp-Source: AGHT+IGGG3bZBrBAoy2Ph1cdfmvVEZz+EzHMcrEJQfaagaqiTzZPUlOeWmNH+290DC+5n70QwRoZ1w==
X-Received: by 2002:a17:902:ced0:b0:1e5:3554:d9db with SMTP id
 d9443c01a7336-1eeb099620bmr3872085ad.64.1715104438265; 
 Tue, 07 May 2024 10:53:58 -0700 (PDT)
Received: from stoup.. (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 c4-20020a170903234400b001eb8fb27b59sm10314423plh.111.2024.05.07.10.53.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 May 2024 10:53:57 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com,
	thuth@redhat.com
Subject: [PATCH] gitlab: Update msys2-64bit runner tags
Date: Tue,  7 May 2024 10:53:56 -0700
Message-Id: <20240507175356.281618-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x631.google.com
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

Gitlab has deprecated and removed support for windows-1809
and shared-windows.  Update to saas-windows-medium-amd64 per

https://about.gitlab.com/blog/2024/01/22/windows-2022-support-for-gitlab-saas-runners/

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 .gitlab-ci.d/windows.yml | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/.gitlab-ci.d/windows.yml b/.gitlab-ci.d/windows.yml
index d26dbdd0c0..a83f23a786 100644
--- a/.gitlab-ci.d/windows.yml
+++ b/.gitlab-ci.d/windows.yml
@@ -1,9 +1,7 @@
 msys2-64bit:
   extends: .base_job_template
   tags:
-  - shared-windows
-  - windows
-  - windows-1809
+  - saas-windows-medium-amd64
   cache:
     key: "$CI_JOB_NAME"
     paths:
-- 
2.34.1


