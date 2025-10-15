Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D521ACCD193
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Oct 2025 21:41:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v99D8-0003ck-Ub; Wed, 15 Oct 2025 17:39:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v99Cu-0003ZW-Ea
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 17:38:54 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v99Cq-0004zD-EX
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 17:38:52 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-27eceb38eb1so633575ad.3
 for <qemu-devel@nongnu.org>; Wed, 15 Oct 2025 14:38:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760564325; x=1761169125; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=llxq6qfqlHF5luVrkm+L5VreeqcrRVzoabCRD01R3N4=;
 b=e0iYRleJNxZoECPsofpJ0XPw8yNJutQSy66jJXIgYt7bw9MNCumI54+c3fcIjSAuMQ
 4tY8Vt77T5Gxm21/iK04F413DQTxHnVJ3BK8jhpo9u0ov0Vru5dFwQEDzRx8+4dcuQV7
 YgII9oqau4tO5nF0X5K4FBsTnEbze9yTpKF2vmJZBZ21IV0nDUYb+uULh4dP9TTJyehU
 mA8vTKHB7gV2sAnBTjEBnjjg59Sx6VkUa4oy6sCYQXOSg2S/KqigBopAwz1Rh5jCxtq8
 Bvq+lbWWttRwq5sDvirwcwEYSrpL5T2nd7DpF+Yh4wi4xhsT2/K07C868x3YTtkkdAY5
 nshQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760564325; x=1761169125;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=llxq6qfqlHF5luVrkm+L5VreeqcrRVzoabCRD01R3N4=;
 b=Mj0T1oWprAH65bOncIxbIJcxbTFyW7Va1ztSOorF0EgBY11M9AYYG4n5HqAp5t0Tmb
 W5oNcHmtj4x+P7kkdMDAo/bqGa1V0oNQt35+C9g8vpY18YeYHiD1osidBFEvSFFRDvM9
 DcwxdZCNWsHjirxbC8iLvXuW7rzaglGJfEeJpkTeLmnLndglFNfCsQ3uS5ANAbXoWeoV
 ngcOXNwO5py7g5ILJvO5G8kmhVrOrZmFDEc4Cd1uNkwJm05KAW6Fero+VRMy1IE3GzDE
 cONf8gH/W++pNOzKNONeXQLTSsP3mqKEw+chckKgflGG4+TZwO1HEWllH9WAnHg8hiLc
 68eg==
X-Gm-Message-State: AOJu0Yx0wvDY6mX2jX6972iou76gco0hdafOtY52T0lkuC35Z9tBa5TR
 Z/+MKrRWt0oqpukxOTrFkUYUtBZhAC0L1NBKQNhyOfQ7CpOuY43ewxa6mdP23eZ1f2ZMZkWvQTs
 G5oGPB2E=
X-Gm-Gg: ASbGncu/MbEcO/g5xy12NA+ZBW74fpga9M5mHakJ31qBBgcOyFj/pugFaBIz9VgjdDR
 CnIegdRqmkYHRJuk1s6dodeFP+H9dgMFaI9TZJuYhomMMBqYVJNzc+75x4tuxeUP/DWqtqds3XD
 TSG0Ef5gncxbpJJi+v4oZIet7tLqAzcNM4GbrnIpsc0PDLZ4Q5YZtY2CziUDZh590pKpGdJT6UT
 I9LeZTYoQyVhL2ELzOS9Y0QWWtZPkHRhKCDHGiHwxlf8CGJ7kcocVrNxMrSZ82vma1Dww2STtm3
 uRJVQTtyGE7InL9k7t71FwF1eVi0ziuMlOvYv1m5gnmPYf0xp8oUalZgq4H3pD4l6s+qloixJGY
 +OMTL6lyElbEg8KU+ZjNhBrKOHbVjyp8i+xCXY0jpQZM/vPsWJCWVduqn7SZddFRQECdMfhF/NR
 0jD2kfjZi8ZTK4AhWJQwpqhlx0RwKbvmc=
X-Google-Smtp-Source: AGHT+IHxENMidfIyWY/Nv6MlN4r+o87tUrulry9aQWWy9LxXPGgnLMFnqTMgm1JD8OJ50eC4A0lIvw==
X-Received: by 2002:a17:903:1ae4:b0:26b:3aab:f6bf with SMTP id
 d9443c01a7336-290273ffe32mr340365455ad.42.1760564325094; 
 Wed, 15 Oct 2025 14:38:45 -0700 (PDT)
Received: from stoup.. ([71.212.157.132]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-29099a7d1bbsm6247085ad.65.2025.10.15.14.38.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Oct 2025 14:38:44 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org, alex.bennee@linaro.org, Thomas Huth <thuth@redhat.com>
Subject: [PATCH v2 1/9] gitlab: Stop cross-testing for 32-bit MIPS hosts
Date: Wed, 15 Oct 2025 14:38:35 -0700
Message-ID: <20251015213843.14277-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251015213843.14277-1-richard.henderson@linaro.org>
References: <20251015213843.14277-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62d.google.com
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

32-bit host support is deprecated since commit 6d701c9bac1
("meson: Deprecate 32-bit host support"). Next commits will
remove support for 32-bit MIPS hosts. Stop cross-building
QEMU on our CI.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20251009195210.33161-3-philmd@linaro.org>
---
 .gitlab-ci.d/container-cross.yml |  6 ------
 .gitlab-ci.d/crossbuilds.yml     | 14 --------------
 2 files changed, 20 deletions(-)

diff --git a/.gitlab-ci.d/container-cross.yml b/.gitlab-ci.d/container-cross.yml
index 8d3be53b75..0fd7341afa 100644
--- a/.gitlab-ci.d/container-cross.yml
+++ b/.gitlab-ci.d/container-cross.yml
@@ -52,12 +52,6 @@ mips64el-debian-cross-container:
   variables:
     NAME: debian-mips64el-cross
 
-mipsel-debian-cross-container:
-  extends: .container_job_template
-  stage: containers
-  variables:
-    NAME: debian-mipsel-cross
-
 ppc64el-debian-cross-container:
   extends: .container_job_template
   stage: containers
diff --git a/.gitlab-ci.d/crossbuilds.yml b/.gitlab-ci.d/crossbuilds.yml
index 8ff0c27f74..99dfa7eea6 100644
--- a/.gitlab-ci.d/crossbuilds.yml
+++ b/.gitlab-ci.d/crossbuilds.yml
@@ -68,20 +68,6 @@ cross-i686-tci:
     # would otherwise be using a parallelism of 9.
     MAKE_CHECK_ARGS: check check-tcg -j2
 
-cross-mipsel-system:
-  extends: .cross_system_build_job
-  needs:
-    - job: mipsel-debian-cross-container
-  variables:
-    IMAGE: debian-mipsel-cross
-
-cross-mipsel-user:
-  extends: .cross_user_build_job
-  needs:
-    - job: mipsel-debian-cross-container
-  variables:
-    IMAGE: debian-mipsel-cross
-
 cross-mips64el-system:
   extends: .cross_system_build_job
   needs:
-- 
2.43.0


