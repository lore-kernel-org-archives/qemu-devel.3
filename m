Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09231C3ABC3
	for <qemu-devel@archiver.kernel.org>; Mon, 12 May 2025 18:19:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEXaN-0001ot-Aw; Mon, 12 May 2025 14:09:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uEXX1-0002Ya-HN
 for qemu-devel@nongnu.org; Mon, 12 May 2025 14:05:47 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uEXWv-00007m-Ol
 for qemu-devel@nongnu.org; Mon, 12 May 2025 14:05:37 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-22e5df32197so49279835ad.0
 for <qemu-devel@nongnu.org>; Mon, 12 May 2025 11:05:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747073132; x=1747677932; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4DYtSZEbP1atLGb677pRK4UuiMz1CYlbqC5aWBJkLTc=;
 b=Dhcazb5n9QQlazbHgxBeb3Xik5stpxzGz0TutQg8DfJ1AYCU1IGw6AzCL1lGyoIB6c
 cDkD7kUkiD81Dxkrac5JWXX94BadTd77fY0NZt393PMeHtmMysT138kFKLUXYBVa86jz
 WuT4DNIw0qNDatacxbyxSCWRBMb/HBr1oRGVqMtntZPLEpoNbWAXEwkY1kvPFZc1eXtz
 D+6IHh0v0/B7Y0XMj3oLrQ5o4+Vtk1bU2sE2+2nFV//7dluh8Ks7fQiiI+TERjZCrm4u
 CyfTXYyM/1WPcM3E0jW1tZX3iNBk+FSf0/s8/lYY7XMBJTU1Qug+wRlDk+LbBqkLGKf2
 3wyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747073132; x=1747677932;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4DYtSZEbP1atLGb677pRK4UuiMz1CYlbqC5aWBJkLTc=;
 b=HK/MkG3zPLuB8pkuCGpxnSop66XzqpYs2NVh9iJIcRSld5RiRIX4K5anJTxHcTBXXL
 29SUrNqgnYsr0MEmGmbUQvzO5VzgDz81hsk8Fpy1GMMSBXvjMTe4A4+IJyUS4UTlzsMp
 PkxIl8YD0yOXPFLvhT3YHdBRdZuqMYYDDn62YF7PLAR4zl/JSzsROtbg5LCJ/zFolVOW
 D+P6xIe9hCjA0zBXgW3xMaKJbl3oz+4cJIhgTaXCZdTH+YxYclm+2m92wXp1Hlnfx/aB
 nVP9KypMAX0VDXBU3zRHvSsCxQ4sDrVhe9Nd5gdD+ev8kd9EevLoX0F8lUumMjn2/dyH
 2a/A==
X-Gm-Message-State: AOJu0YwZBtNPv8sWk97VUI8292ZTxOH7JtCCBIseQHS/sRxeXIV2gReI
 H6Z6KF+M5a8s8NxMvymyh0t9btfoXmjC3nJAta+eqglvShHo1kL+VSdvDumLvhz+UCJeO2Wq4Rz
 R
X-Gm-Gg: ASbGncvhX5oJPZ2Vd2ATQXSvplx+EZ4l6h82iiLTqScMMl2qWCHmjO859OBsIH+KFzg
 MZK7kZ4LCfX9cckRMANnODHLBS34Jf+EooDEbASIU0PBcWOdeQX3U8kSfHwyIdJezNYeWpa7xHG
 tP0uHvvMlamVNOf7GGTjJBSNKvhhL9UA6p58JXnF20DSle1689jTlaeZWFTFBgP4hZx5B9TTpXE
 8J4bbYqn/Jmu+GX5yKZtlNr/ZVPGpi1sIQXSlmnLayS2gsC5jvixqEHej984ar6LujTkWt3HfB4
 fqHULUsx3zDqDU8WJgRMugjnP/U9KZkgBSqWzieymkGoKivtcgY=
X-Google-Smtp-Source: AGHT+IEUchA3BCwBh+OJ1cNAY6I61vJmEW2d9AGpseNu/E7o6pb1DxCo2KJeldjr8AJ2t8R3hCpqEA==
X-Received: by 2002:a17:903:40ce:b0:22e:4a24:5781 with SMTP id
 d9443c01a7336-22fc8b79590mr203976175ad.30.1747073132481; 
 Mon, 12 May 2025 11:05:32 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22fc82a2e4fsm65792005ad.232.2025.05.12.11.05.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 May 2025 11:05:32 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 kvm@vger.kernel.org, alex.bennee@linaro.org, anjo@rev.ng,
 qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v8 23/48] target/arm/helper: compile file twice (user, system)
Date: Mon, 12 May 2025 11:04:37 -0700
Message-ID: <20250512180502.2395029-24-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250512180502.2395029-1-pierrick.bouvier@linaro.org>
References: <20250512180502.2395029-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x634.google.com
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


