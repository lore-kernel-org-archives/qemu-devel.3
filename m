Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C1EAC3ABB6
	for <qemu-devel@archiver.kernel.org>; Mon,  5 May 2025 23:27:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uC57Q-0006gn-SZ; Mon, 05 May 2025 19:21:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uC579-0006Oi-Qg
 for qemu-devel@nongnu.org; Mon, 05 May 2025 19:20:47 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uC576-0003cA-5Q
 for qemu-devel@nongnu.org; Mon, 05 May 2025 19:20:47 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-223f4c06e9fso45718135ad.1
 for <qemu-devel@nongnu.org>; Mon, 05 May 2025 16:20:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746487243; x=1747092043; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4DYtSZEbP1atLGb677pRK4UuiMz1CYlbqC5aWBJkLTc=;
 b=C6oDEsgO/mx1J/cDfBpNN9UEKDHlZNm94FK5NGCaNMx6cVP+6A9z+Fh2E9BdM0gKC0
 e95wriAWGr8yPzGB/iQd791w51a31IdK9Y9YUkpv9pOBiqsi97hMyEODRN7lvDNid7HU
 04ezrVYNCCQhR79xetON8l1wtA4XV0SdEwxEkM2N0Qha9hUn27Ae8XUpC25WCUBbHdWF
 Z7VoSD8i8tGrFo8djeYsZwSgnncbPjeGqDOz+dps9+CAM/MOx0S6849ybsXCC8Q20D+C
 6akNS+0uMXFx3awxflmP5FCLdnOgrEvhjtosTgqf8351WHX/t6Yv0C+wVDTNh/ixXk9X
 YZaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746487243; x=1747092043;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4DYtSZEbP1atLGb677pRK4UuiMz1CYlbqC5aWBJkLTc=;
 b=I+5aZdIAc8o06Kr62FHMd1VD0/88vUiSkPJg5o8Lj8SGZVQ8xLGbSnaCb05PcZMjLx
 Xs8EhPfdCZqzB3vSqS7TrGfW22YZOMEyt+fKViLHkMBg+/3KEwEqV0cWiQ09SowoCKHm
 HDvnL1xttjdNcwZBXCLeNnod4RNpRzR3wVismX+fO1xJCwnPNLBdoKzJv6rT1gSuFaaA
 7LlCl27RJw69gnuqVQ/XJ5POqOKPlT3EAKtyj6Ktk2pGm9u2wB25/W+jdVhjl1qiq3Cn
 6WuSwf3ImEXFcdnlqAQisr6qcfASO0k/VPTIEvJM6XU4px+eOkGyFWQJan/lMsa7m66X
 QsLw==
X-Gm-Message-State: AOJu0YyZwdKUO7EjBCmZUFqkgprQpBs4O/46AGFlD+PX+6Ll1sZGehJF
 dN8whepjV38ruW0ZePAaYZcNL7VBHqT0+ZoQwcGSrlZURVKw4zBqun+7P/f1RR9L9kHIwSP8JwF
 mbaI=
X-Gm-Gg: ASbGncuOrmHweYGXFXR7G6NJvBWL5Yg5s1Nu6xow6HSyt48eYp8bCuMVV4G1+AXXp1n
 VAR3uydfBt6Ei84EYWUXum2yuJlWVLB308ovRhGhxCA/HSCdbhBokQcvRLZpgG/1a/jCvT1xuqm
 PTn1U6c63i/PBQRCxbeAEivCqX0qw9H0vY0ltuPKnMRc+Rgkk9N1+/NSR9Ic0iGyHxhv0q0NA2U
 eyYxIzeZHjJKgZfoS/EQzyUSGxQHVmCrF1y+gV7O82qk0ZgTvfHHM1fmIv2e/dKUrfBS+cnPDhh
 RY59u7vjINDIbBVzVkz0J+7nO9cEjKMcw4eQRgKL
X-Google-Smtp-Source: AGHT+IH5Uw7g4LrrMeNQldUBujYpCP1weLdfAKQARAwCGSAFxHYIUIR+BJ+7kpydaxwme0QVMesEtg==
X-Received: by 2002:a17:902:f64b:b0:221:8568:c00f with SMTP id
 d9443c01a7336-22e31e0e9c2mr19933785ad.0.1746487242699; 
 Mon, 05 May 2025 16:20:42 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22e1522917asm60981715ad.201.2025.05.05.16.20.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 May 2025 16:20:42 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, anjo@rev.ng,
 Peter Maydell <peter.maydell@linaro.org>, alex.bennee@linaro.org,
 kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-arm@nongnu.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v6 25/50] target/arm/helper: compile file twice (user, system)
Date: Mon,  5 May 2025 16:19:50 -0700
Message-ID: <20250505232015.130990-26-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250505232015.130990-1-pierrick.bouvier@linaro.org>
References: <20250505232015.130990-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x636.google.com
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
 target/arm/meson.build | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/target/arm/meson.build b/target/arm/meson.build
index 48a6bf59353..c8c80c3f969 100644
--- a/target/arm/meson.build
+++ b/target/arm/meson.build
@@ -2,7 +2,6 @@ arm_ss = ss.source_set()
 arm_common_ss = ss.source_set()
 arm_ss.add(files(
   'gdbstub.c',
-  'helper.c',
   'vfp_fpscr.c',
 ))
 arm_ss.add(zlib)
@@ -32,6 +31,7 @@ arm_user_ss.add(when: 'TARGET_AARCH64', if_false: files(
 ))
 arm_user_ss.add(files(
   'debug_helper.c',
+  'helper.c',
 ))
 
 arm_common_system_ss.add(files('cpu.c'), capstone)
@@ -39,6 +39,7 @@ arm_common_system_ss.add(when: 'TARGET_AARCH64', if_false: files(
   'cpu32-stubs.c'))
 arm_common_system_ss.add(files(
   'debug_helper.c',
+  'helper.c',
 ))
 
 subdir('hvf')
-- 
2.47.2


