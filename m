Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D29BC3ABC3
	for <qemu-devel@archiver.kernel.org>; Wed,  7 May 2025 23:50:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCoQG-0000pv-Pf; Wed, 07 May 2025 19:43:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uCoPw-0000Fm-Hl
 for qemu-devel@nongnu.org; Wed, 07 May 2025 19:43:12 -0400
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uCoPt-0002ZU-NR
 for qemu-devel@nongnu.org; Wed, 07 May 2025 19:43:11 -0400
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-30a8cbddca4so496687a91.3
 for <qemu-devel@nongnu.org>; Wed, 07 May 2025 16:43:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746661388; x=1747266188; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rVtP/RnhHG9awohdmhc7BZy6oUycGDI8ImSQa94LuXo=;
 b=cKfAruCUyj0qsYTfI2xzmTNclNRR2gK8InVw//KUXaO3NvXwuaqnsSmsgGveiqr6ZI
 2MT95BnWlY39iAAx+NTduGvGtwixZOT4rHjbXQ1sPvtOWyAJu8QSD1EHCDdbkUpBjCNC
 XFkkRaaJnMA5DIVO/y7E35xOk3fuqIMAyjNNhU3N/vNfVXqK+rQ4yTjsB/vl+xouJu8Y
 JmF1jnVmo3PPowLVbhXPSs7ZMfYJzB9DLoadailO65Iok64SKZeFmKyl77C+o6N8ZDgh
 CwE8Ade3khq2rjAWWW5NT1SkZ8xL8BxKJ5owUZgC/yo+5pXiTcJdR350YXRXvh1jpjdh
 7D7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746661388; x=1747266188;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rVtP/RnhHG9awohdmhc7BZy6oUycGDI8ImSQa94LuXo=;
 b=RFb7xRgX9U7cxni0LWtgmxtvtXUn98JfdzEfqO4YLle0+SkdxCS6LQDHg2QBV1N+b9
 t4sP2qFzIp67RnLzZSTPnHfbLYy5yGA4Qde5SQtaLNJ7wqkra97ZViKOBQ/7wifBvPpV
 cTEH++44tUEPcgw5LQO1a7I0GmOXpVNNAlHEfg0KHdkuElmGIS0PhoNNaTDdpXDo1t93
 dNtrh4O+Tbz1eW5v1A5alcL+OS/CNdCT/orLEcpODVxDEieq7n7jK5qzQ999K8meW9I1
 4HOpsjVchxHzu6rgt5+/AZWQ5qY9tCrpkf8adbsAcSprfUFmjt7LNoalpjUWGJEwDIkC
 QAqA==
X-Gm-Message-State: AOJu0YzAI3od6mF2J5KoyXVchJssjPmuZaomkZVdAJATZidoZ7twz00c
 lw29acRAzO0NBXRcExae6qa+vU3DqCGgY8Bo4fnFizvZa6SQJwQyU4+4VI3J2bxxiCygrd5a3Zb
 NIG5sDw==
X-Gm-Gg: ASbGncuaO39sGFvkQeH45rTNlytKIYJKoTBxCRf5jyprnGiSO3VlfabVUZN2z+els9t
 vBvKdGaEBZnhMT20DuxXUYgCIZ9ZKQt3tZ5ecvjG+ccgywOOdmNFCT3rTYgsEvOJ02pyOPqQX/8
 VaEAdfK5Y0wpoUcIY2sCqMKqdRS0Vma5sUuNj1aFYOeYaj2qEd1Cuet1nEdO2KAbSl6K8BJxJei
 PHHXFeSnB6cTCDY1C8bdTCvPlmoVgflKp3UXuH/NwNHaTgoyIwEdQNKcQiTx6R+nHiCq059Ykab
 0Fvxl968Ma3w7cSXbu8r97PubJPpSplcRLFHRoRD
X-Google-Smtp-Source: AGHT+IElhneOo62MjSKskYIQy7VHQ7smeSPm1m2Q80DLuetPyAssqqhuGAhjwKmYU5VfAYntwmXZvg==
X-Received: by 2002:a17:90b:3a8f:b0:301:6343:1626 with SMTP id
 98e67ed59e1d1-30b28ce15d3mr1418228a91.1.1746661388386; 
 Wed, 07 May 2025 16:43:08 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22e815806fdsm6491325ad.17.2025.05.07.16.43.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 May 2025 16:43:08 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, anjo@rev.ng, Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, alex.bennee@linaro.org,
 Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v7 29/49] target/arm/cortex-regs: compile file once (system)
Date: Wed,  7 May 2025 16:42:20 -0700
Message-ID: <20250507234241.957746-30-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250507234241.957746-1-pierrick.bouvier@linaro.org>
References: <20250507234241.957746-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1031;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x1031.google.com
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
 target/arm/meson.build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/arm/meson.build b/target/arm/meson.build
index 7db573f4a97..6e0327b6f5b 100644
--- a/target/arm/meson.build
+++ b/target/arm/meson.build
@@ -16,7 +16,6 @@ arm_system_ss = ss.source_set()
 arm_common_system_ss = ss.source_set()
 arm_system_ss.add(files(
   'arm-qmp-cmds.c',
-  'cortex-regs.c',
   'machine.c',
   'ptw.c',
 ))
@@ -38,6 +37,7 @@ arm_common_system_ss.add(when: 'TARGET_AARCH64', if_false: files(
 arm_common_system_ss.add(files(
   'arch_dump.c',
   'arm-powerctl.c',
+  'cortex-regs.c',
   'debug_helper.c',
   'helper.c',
   'vfp_fpscr.c',
-- 
2.47.2


