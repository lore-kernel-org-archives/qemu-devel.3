Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4B85C3ABB6
	for <qemu-devel@archiver.kernel.org>; Mon,  5 May 2025 23:31:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uC576-0006MD-ST; Mon, 05 May 2025 19:20:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uC56x-0006DR-PY
 for qemu-devel@nongnu.org; Mon, 05 May 2025 19:20:35 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uC56v-0003Xp-79
 for qemu-devel@nongnu.org; Mon, 05 May 2025 19:20:35 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-22423adf751so58533505ad.2
 for <qemu-devel@nongnu.org>; Mon, 05 May 2025 16:20:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746487231; x=1747092031; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mduWzGcqrbCCMCYuVdtTD2ZBid0+LWN3eUl0cLQ5HO8=;
 b=ScJuS830Ua+u2mGBiqF+KU0GU5SvaN/OiwyW+DQqfRqI5jqMtfzAeJeFcLHgAsAWXH
 pyzOlorPnTEARvVPvjO7LQk7kIGyMBV/ZUe1YNwCOcEO9uJ5X9lDIDsCg46c1UV0/u8G
 yrD23BeAUyFsHkySa4KwX1Fv7RvYf3TA/t/GBZQY+L9SCXinXngYogLDK+xnSuqwtwqg
 BTn7XsYmaWtCEN8zgDIDKvyFEceyWcOcPxW498N1v1OLNl4I3K3Viu2Nu44nBVCVXO+S
 qt95MOrJRrNyIz2pwVfMsXXOfqtuTIkQZQ4bgRR8wZ2/P7FTL7JB3rx5CVN9eQN04air
 s34g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746487231; x=1747092031;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mduWzGcqrbCCMCYuVdtTD2ZBid0+LWN3eUl0cLQ5HO8=;
 b=bpMBVvtRZ5Q/N1Ow1NXase2rFVDWBssnzCajzQi41ePaK+VYC4pclwcdn5GfDIATbj
 q4kJR7RR4lUFFdH8fp6vv7MZTGtdClJWZ5QjSnYj1pDUCIFPRDfYK8JinXScj7I9W9oH
 IPD7mwxTG9n/w3+aiaJvId7184eFe9hhl/sE8he9PXPQetnqIcfzbn/2mjJAkMj59l4f
 Tlq7xGOcyPyPdktOBL90OG9HvQsCppUkBiXvMro0UhPt+mUGKm2WDr1MBb2A8RfrIayh
 CACuXRxLTMHC7V9JTuD+D/Il81AYkdYKMSkWAj4NrWZbA4/krPtwp0BBFU/MmYMXCeId
 qhIg==
X-Gm-Message-State: AOJu0Yx7eDFDe2j5aqNTyRY4OS0cJALenruZMy9yQbH8Wl42LNa8ZwhM
 U8bi+fWJMmNgmvcLP7gIUuLj36jyh8LEic2MZuwr3enVoLor1x/gx7eM1p8VX32v93pLRZcH1Ds
 0OjI=
X-Gm-Gg: ASbGncv9FNPJI/7mebWTit4NTWV926SScViK9s1TSW9cqh8vi2Td4mDZXqfOnBoTl+S
 HJv1WRXPTyFIli66TzNABV1DAMjUdiuwJrVJWarU3uQNFVPJjsEA/KZvYBs4/IFHfXOobQwhMiw
 cwXyGsI2edLbPutS2a4r9RdJspviJ8wHCcST4PB3HzJDR0FOgd+VEth/LSyX6MS/FM8P8Zcklqb
 uBZrfi+KnD95brGGaU5caxbEYbLxjg8WcPwy5NXLXiDc50+NpW6knSAAUXWYYXbjJuG10DKi7e6
 1qjsB67GMenrBDX8xZ3KZFAr9hsbKfbniT5SHbX3
X-Google-Smtp-Source: AGHT+IGJHQGPT70iQq1g5juc5YpCbtYrYWmQM67WZQCS90h22TJtC/LDouxcVdEq8FF9T4pmAb8ojg==
X-Received: by 2002:a17:902:cece:b0:223:4537:65b1 with SMTP id
 d9443c01a7336-22e103571bcmr236825665ad.36.1746487231323; 
 Mon, 05 May 2025 16:20:31 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22e1522917asm60981715ad.201.2025.05.05.16.20.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 May 2025 16:20:30 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, anjo@rev.ng,
 Peter Maydell <peter.maydell@linaro.org>, alex.bennee@linaro.org,
 kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-arm@nongnu.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v6 12/50] target/arm/cpu: compile file twice (user,
 system) only
Date: Mon,  5 May 2025 16:19:37 -0700
Message-ID: <20250505232015.130990-13-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250505232015.130990-1-pierrick.bouvier@linaro.org>
References: <20250505232015.130990-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62e.google.com
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
 target/arm/meson.build | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/target/arm/meson.build b/target/arm/meson.build
index c39ddc4427b..89e305eb56a 100644
--- a/target/arm/meson.build
+++ b/target/arm/meson.build
@@ -1,6 +1,6 @@
 arm_ss = ss.source_set()
+arm_common_ss = ss.source_set()
 arm_ss.add(files(
-  'cpu.c',
   'debug_helper.c',
   'gdbstub.c',
   'helper.c',
@@ -20,6 +20,7 @@ arm_ss.add(when: 'TARGET_AARCH64',
 )
 
 arm_system_ss = ss.source_set()
+arm_common_system_ss = ss.source_set()
 arm_system_ss.add(files(
   'arch_dump.c',
   'arm-powerctl.c',
@@ -30,6 +31,9 @@ arm_system_ss.add(files(
 ))
 
 arm_user_ss = ss.source_set()
+arm_user_ss.add(files('cpu.c'))
+
+arm_common_system_ss.add(files('cpu.c'), capstone)
 
 subdir('hvf')
 
@@ -42,3 +46,5 @@ endif
 target_arch += {'arm': arm_ss}
 target_system_arch += {'arm': arm_system_ss}
 target_user_arch += {'arm': arm_user_ss}
+target_common_arch += {'arm': arm_common_ss}
+target_common_system_arch += {'arm': arm_common_system_ss}
-- 
2.47.2


