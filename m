Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02D9DCCD19F
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Oct 2025 16:33:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9nNN-0004oO-Vx; Fri, 17 Oct 2025 12:32:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v9nNJ-0004m6-HJ
 for qemu-devel@nongnu.org; Fri, 17 Oct 2025 12:32:17 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v9nNF-0001Be-QZ
 for qemu-devel@nongnu.org; Fri, 17 Oct 2025 12:32:17 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-290d14e5c9aso13851175ad.3
 for <qemu-devel@nongnu.org>; Fri, 17 Oct 2025 09:32:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760718729; x=1761323529; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=llxq6qfqlHF5luVrkm+L5VreeqcrRVzoabCRD01R3N4=;
 b=EDzwvSJQGeygXbAA+K2hXaWqvnXVb9D7eKv2w9bmsCQusoxJPSyT7QbxYyiGhQO1Hq
 4LBKUulCFTZUvWoC7jFReEQIvECB4KFqsmq+bm8R0WabixdFH0XoiCNUqlfiUpHmsIws
 y5dP30i1A97S46VH3DhUQ0aiMPXrcSMpjtlR9z500SSMWFoI2kSTsBKl63c5svxpgBxq
 1WeRrrhoIXEt23H48hCE9NX+ofNghSu3Q5aHASMxkCsvStSxA6jaxkUTEuP0/4FLM2sy
 EKBNxHnPg0SdXAfcvocbu6ckPGKagEf15R1cOU/wA9BOjxw2xotki+xjp7NgYCMVmZ3t
 NKmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760718729; x=1761323529;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=llxq6qfqlHF5luVrkm+L5VreeqcrRVzoabCRD01R3N4=;
 b=uTZ2ixKLmDvHIChvIa7Y2ToazH2yH5FOgcQprOUg2xSgvifdCRFlOhItkOh7uMmFTC
 /CLobSYTzD7uCZBS9NGQKdFtdx5LjPNFHOisQKGZtmr1I1gidzFIDmK76UwapMHiyEU9
 nYCTlk2uu7YHh7oZ8GPDKD9nJsRUmpF1QWqNG3j4GUDE0HzGHKJ4vq5+F2A3RRP3uhG4
 lQ+iqxB0scwrU8VEk3OQtDL0WKYaHiu4YvjeL3HNKyooVLmKlu9v3F5ZX+AjuPZbaOk4
 agRXKIhkwTakHS6yJTYyyM0hNoZhntKkddG8vAx3poNclJGDqY5Tmed6gm93K/Ps9iS7
 JVbA==
X-Gm-Message-State: AOJu0YycXjoQcLkMTJDRRk4wykxB4m3vT6ayV2WtzVU/PfALCn2IqNGE
 xN6MUIQIvk9WHa7Emi6o27p0FIKOS7ilHnwjLsQv8BD+2Lf81DyEDQm0weAe9lZxOqcOL5/lT17
 +yDjzVIs=
X-Gm-Gg: ASbGncuVzMMJElMmEn96dT096F0MSDtV0FzHn+f8O/Khca6nzCN2v7COwiQptBsV+Z9
 elGN0PvT4tUNm8TGXs1UofHa9mUZ8leynCWDUvkuaaIU7WtPehVfnAaH+gvAtSgWEl4PQ6hi8pl
 vZn1lmUhCp8ZO2KSjYz3aJROzQpZIUsOUf1651NcLxu5qYmVEDrwGaOEsGFwZbWcBvdbZvQrOOd
 QQUipUxQFyf3KuRr5BBRNd++6zx62RRjhzhjlHUN/2Y2m/JhLnQRSqg64pbk7wXZmQfFDofNRFJ
 5rVShHQKXSZjpOS+gmqdE5P/so/tuEy0wurOU+nldMgDq1MWmecZPfAyS0zJUYy2mHXG6gakenL
 3sL5nHW+zyNzuvcRfKZ6qHG2FbTpgUynXDltHsFIN0rMESgr8ymkodHTq4Xx70qX3cJFbsRjKtJ
 CBqg6c2rfF9Z8gN93I
X-Google-Smtp-Source: AGHT+IEddZ7IMALJHGmel1ZMGcv0lihxdp8yIcVy5jsxxbYPQjiyoAwnKRNE3YI9g/x/EGzD/mMM+w==
X-Received: by 2002:a17:903:19e5:b0:265:89c:251b with SMTP id
 d9443c01a7336-290caf8519dmr51275065ad.29.1760718728603; 
 Fri, 17 Oct 2025 09:32:08 -0700 (PDT)
Received: from stoup.. ([71.212.157.132]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-29099a7d1bbsm68667715ad.65.2025.10.17.09.32.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Oct 2025 09:32:08 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>
Subject: [PATCH v3 1/9] gitlab: Stop cross-testing for 32-bit MIPS hosts
Date: Fri, 17 Oct 2025 09:31:58 -0700
Message-ID: <20251017163206.344542-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251017163206.344542-1-richard.henderson@linaro.org>
References: <20251017163206.344542-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62c.google.com
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


