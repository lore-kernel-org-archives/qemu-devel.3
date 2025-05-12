Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BFF2C3ABC3
	for <qemu-devel@archiver.kernel.org>; Mon, 12 May 2025 18:16:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEXds-0005xk-J0; Mon, 12 May 2025 14:12:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uEXX5-0002Yq-3a
 for qemu-devel@nongnu.org; Mon, 12 May 2025 14:05:47 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uEXX0-00008d-Ja
 for qemu-devel@nongnu.org; Mon, 12 May 2025 14:05:42 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-22fa47d6578so48223815ad.2
 for <qemu-devel@nongnu.org>; Mon, 12 May 2025 11:05:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747073135; x=1747677935; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=j3Dpv/gYklKxQ6NcaNjklM8os0pkN4N34WBJsdRDY08=;
 b=zzGKGoSkEFQH3BVIaiD/vsJ4rHtXgc7s/3OPSVCrdNUorMvF2urf7qLnVLAMbS6DmO
 0UW+eHw5b8Yj664dKFjgMmVvJbs+i7cLMDelVwHRysXIsvOFimwzOJqwJ9b3hZcGGZVO
 +4paiy8lJvOlqiJnJVDwlvauFsLeoq0uM0GakO1nf5Y7yEy7FqXK6hmXiEfkROivG0rX
 XEUiz6VbT2kKgCL+iDttkeTtJDoyVimyCDOFsJuM0sF4tSjo0+6ONvyE9TeQXY3nMyUm
 4Yp3meaAAKzbguukypU88y68K7qUmTclq/eSv6KjjEMRjXVy5j1XWirGVbAHrhJaXuBR
 JLGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747073135; x=1747677935;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=j3Dpv/gYklKxQ6NcaNjklM8os0pkN4N34WBJsdRDY08=;
 b=H5rRBpjjQAR01N2bd8rop1KtR3aNfLHcksYXVWTMQMvStoohg2E6cWzJ1QIkaoP6M1
 gMOsU2I6FftktORWDwjI9oJblqMH+HwfFaSwI05hN0/p2JgiPb1gzBLVyWhgbxrYpi82
 Ea+2yOXqmFwVz6PfrR7iuAW5pU7/9ZjGOtworUt2VuJukJfz0iBDAl9GALl2SWbFhTZd
 W4Z/X//HuGYRA66GkEXcfLC/F7GMirZ8HXLQU2bFBCpZJ/eY44KqmXcmZ96aRI+TqzU9
 1SQRDDNafAWNJHDDYcl9efYXjLREdXKlcmwG5YtlTAO6fA/+N2PFroM28eCcRBha2Rwk
 kH6A==
X-Gm-Message-State: AOJu0Yxs28bRRDOWC7C7Hvty15j14U2ZjsO7grufMJ043X9CEsrErHx5
 fuJvzZzJgKsDtA3PVIAYHM7SfzS2dfEcaWYVYoV2Dy7q/csdo+DrB0H8L+hToAyGnxS0txG0k4d
 P
X-Gm-Gg: ASbGncveVujJV5zgpPTogojy4toGVCbU136CDoSBF2NcVVYTk4fqk2mWkmFepwgWSCB
 RmA3lGDOzQm5yJHh/JEi75jOMsT1zfiMvS8Ni+vHqu++9zKRh8uwN1KU972y3cpZZXQ08/umdN/
 adbcCq+yGYX0w87OQL5Aim4vPWzO/MNftXTxyLUTXsNKx2+kiLpH4jtdt7xThISSoYAXa1Cq7yW
 RvMOD9RwxIue0GPUz1Y3y8Mk6zx1mp9vxvYILPeliGFk4MxUpAsEUP1Gt33of8JpJpKmf9aEbYS
 gC7fdQZ94sAiTxRcnfq34yUEwUkZZuUP8ixZhJZBR8ODfz54zkU=
X-Google-Smtp-Source: AGHT+IFWkB6Mkaeg18gGVG6rVCrQjmce5SbsAO0IjrI+eadfe3VGrlqawH9YWYf9Z1SF5DVoMnYAtQ==
X-Received: by 2002:a17:902:ecc2:b0:223:4537:65b1 with SMTP id
 d9443c01a7336-22fc9185f13mr185461285ad.36.1747073135057; 
 Mon, 12 May 2025 11:05:35 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22fc82a2e4fsm65792005ad.232.2025.05.12.11.05.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 May 2025 11:05:34 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 kvm@vger.kernel.org, alex.bennee@linaro.org, anjo@rev.ng,
 qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v8 26/48] target/arm/arch_dump: compile file once (system)
Date: Mon, 12 May 2025 11:04:40 -0700
Message-ID: <20250512180502.2395029-27-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250512180502.2395029-1-pierrick.bouvier@linaro.org>
References: <20250512180502.2395029-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x629.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/arm/meson.build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/arm/meson.build b/target/arm/meson.build
index 06d479570e2..95a2b077dd6 100644
--- a/target/arm/meson.build
+++ b/target/arm/meson.build
@@ -15,7 +15,6 @@ arm_ss.add(when: 'TARGET_AARCH64', if_true: files(
 arm_system_ss = ss.source_set()
 arm_common_system_ss = ss.source_set()
 arm_system_ss.add(files(
-  'arch_dump.c',
   'arm-powerctl.c',
   'arm-qmp-cmds.c',
   'cortex-regs.c',
@@ -38,6 +37,7 @@ arm_common_system_ss.add(files('cpu.c'), capstone)
 arm_common_system_ss.add(when: 'TARGET_AARCH64', if_false: files(
   'cpu32-stubs.c'))
 arm_common_system_ss.add(files(
+  'arch_dump.c',
   'debug_helper.c',
   'helper.c',
   'vfp_fpscr.c',
-- 
2.47.2


