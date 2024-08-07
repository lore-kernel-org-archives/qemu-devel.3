Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11793C3DA7F
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2024 11:43:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbf2Z-00068b-Ay; Wed, 07 Aug 2024 07:41:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sbf2W-00062o-O9
 for qemu-devel@nongnu.org; Wed, 07 Aug 2024 07:41:13 -0400
Received: from mail-lf1-x136.google.com ([2a00:1450:4864:20::136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sbf2T-0003B4-IH
 for qemu-devel@nongnu.org; Wed, 07 Aug 2024 07:41:11 -0400
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-52f04150796so2583995e87.3
 for <qemu-devel@nongnu.org>; Wed, 07 Aug 2024 04:41:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723030868; x=1723635668; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pTfCk64r8q3pxcxN1PtSEYt96mHUVpiaIdaNgLQ6haU=;
 b=Ryj5yRA5w3eApM83TRw2Jo1I7tyqKMLoshIFyUoA0XyJjlrFgJSCWwvUqAc7VF9wcG
 kg6Igraogta1fNDYzIq7hjbvsjsMuPJd1H5HmsuRtpQVArvWIg+xFx90o7CT6nCeb7i5
 UIwbBB7rExRiptCxTiU747/ga2MV/kOkCHf12QCYRvqwvIVQiTOEy64pTRMPHr/MN6No
 oY7ghscLsljCU1SglW2vWm3j1xnjCd9pKq56Vy5qTPkB9iYoVV0dut8RDs3uxNMc/j14
 0MPP79jxtEbstKsND9cPTZjOfT3bXE/aF254FVKBrdgXkFlRXsbc5SkB0ZZ9iAwS3Kyn
 HOGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723030868; x=1723635668;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pTfCk64r8q3pxcxN1PtSEYt96mHUVpiaIdaNgLQ6haU=;
 b=AxoBrGkJZaiYL4X4glRtCPGcdHuv/DTtcmeCYX8Hg9xJHV6FLGQ4/6H0hlZRs6vkO2
 Qwa+AQ2b0EF9LRgdTCLu/GtwtGNRNMZpsPQOGdGlsC4OObEluEFv101lchiekoVl9GKk
 adJMRZ0/0rn2SYLO61MVNkGglnH5wFLVLBIPclUGLIa11HKo5SXNTbOyah6l4RBvK9oq
 fbUI1SvKfZpBQtC0ERGGJQva8TB4yEDB+eQVXpaip/Rxq+UgQMAH3/XyskUBGBgCznLf
 zlzHNJ5b3wRPWjrDuZFXlu/JnwkH/ufheojD3Qt+vHOlJ/7ZsLcfy8qmvhDYWzWHDHG0
 aBvg==
X-Gm-Message-State: AOJu0YyTwPAVWEhtcAnYgsAKIEmuIPgJugMJTFZNzRtEckxBfa7oA1UF
 /9wcOZuu9CD+2O02dVCXHF0eOR4uG4rmAIC9pbad5uaSSr/d3wGCLq0roGfZ8WE=
X-Google-Smtp-Source: AGHT+IECak3W7ZhApmMH6jRsCuYSU3oEitW7MAeF+7eSMLpbzH8qePAkgso1AIK8NYf6uG1Y39UYKg==
X-Received: by 2002:a05:6512:3f0d:b0:52c:e040:7d9 with SMTP id
 2adb3069b0e04-530bb3b4a15mr11695346e87.59.1723030867011; 
 Wed, 07 Aug 2024 04:41:07 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a7dc9d88650sm627436166b.152.2024.08.07.04.41.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Aug 2024 04:41:01 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 2CD175F935;
 Wed,  7 Aug 2024 12:41:00 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Wainer dos Santos Moschetta <wainersm@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Beraldo Leal <bleal@redhat.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 Gustavo Romero <gustavo.romero@linaro.org>
Subject: [PATCH 3/6] configure: Fix arch detection for GDB_HAS_MTE
Date: Wed,  7 Aug 2024 12:40:56 +0100
Message-Id: <20240807114059.2339021-4-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240807114059.2339021-1-alex.bennee@linaro.org>
References: <20240807114059.2339021-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::136;
 envelope-from=alex.bennee@linaro.org; helo=mail-lf1-x136.google.com
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

From: Gustavo Romero <gustavo.romero@linaro.org>

GDB_HAS_MTE must only be set if GDB supports the aarch64 arch, so the
test if "aarch64" string is present must be against GDB-related
'$gdb_arches' variable and not against '$arch' variable.

Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
Message-Id: <20240804161850.2646299-2-gustavo.romero@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 configure | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/configure b/configure
index 019fcbd0ef..a3aa257fd3 100755
--- a/configure
+++ b/configure
@@ -1673,7 +1673,7 @@ for target in $target_list; do
           echo "GDB=$gdb_bin" >> $config_target_mak
       fi
 
-      if test "${arch}" = "aarch64" && version_ge ${gdb_version##* } 15.0; then
+      if test "${gdb_arches#*aarch64}" != "$gdb_arches" && version_ge ${gdb_version##* } 15.0; then
           echo "GDB_HAS_MTE=y" >> $config_target_mak
       fi
 
-- 
2.39.2


