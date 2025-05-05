Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAF81C3ABAC
	for <qemu-devel@archiver.kernel.org>; Mon,  5 May 2025 02:02:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uBl1E-0004TT-65; Sun, 04 May 2025 21:53:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uBl0o-0003wo-4s
 for qemu-devel@nongnu.org; Sun, 04 May 2025 21:52:58 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uBl0h-0002Y7-I2
 for qemu-devel@nongnu.org; Sun, 04 May 2025 21:52:53 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-74019695377so3122136b3a.3
 for <qemu-devel@nongnu.org>; Sun, 04 May 2025 18:52:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746409966; x=1747014766; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=u/RowU+G9lDkd5OLEKmfnzuDeOXrVzkwWk098+SYGJQ=;
 b=cPHZA8La8btZ4nkjaSSqjHTl71QzntOfg4aNmi2ojRB7lCgm5/atf161dnailMzRgK
 +BPsUS+1rC9zxIbdQcHE1p3kV0qFPEmwIuprjjUbdbK4zjtYCJCjYnTDZTLJGuTjbJwI
 On2/kxMmjtzA+riSnkk5Nr6l/O+i0DbJZ4VSV4LlZ+6TtfXb2uMknpsMjoqpQdQJ78A7
 1zlUdrENyPSZMLR5BMIi4RIXQi4kiE8Q7BPgBty2NiJphuDTmj0y2gr6AoAjG5q6OnsP
 Vdbj8dKlDuCpn5v0LDj4o2p+AsKF7hC0o1AShIllAqvnUCKnu4eyTxqcOFHZrSOvzguP
 cdHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746409966; x=1747014766;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=u/RowU+G9lDkd5OLEKmfnzuDeOXrVzkwWk098+SYGJQ=;
 b=O7vEl1hmcrKh0ZfodrqmkEg9HjS9ydACOUiIrpOER5NGrjipmEJbkBylHi4gRzljuj
 326k4VT9IzqlOlrR5rCPdhRYUt8YWXFpLENux/384Zz9fTX4QPNztiiToOYO8mruYCud
 HRmPlT66B56uPTGrm0Y01/bwfShoH+WgboH6bQ4Pcqe93oGJ7YJCF+fGkYnXFL0JsvNU
 VIJKKp0u26SfXdjwfkqLNEPeHVmDKTPEx8s/KTgUqcytaDK+Ir0DVRMr4kfclNN7akSB
 pMrjBRsXs6qQohTPlOwmIi2KXj6C7R4sP0ndm9i4FqZ77mvkj3oAwEv1M5eztHjALebH
 IxpQ==
X-Gm-Message-State: AOJu0YyL1mSkYR53Wop9KpVU3M+AXti7L0jrSJtkjXnBnYX70IkaFcCZ
 +OxBKlFsLyMNHxxFy4yDNKLMsE5QTuePBEOGGOYZdzRy+/4t+oKD0Tgy0pWte/ouLdwkzwH8OpG
 qoaA=
X-Gm-Gg: ASbGncvfmML5SM8rbLUgtjAEzCNsmmGBbeJKQiSciw5SFA5uSFGl0hLuDItGlxjADHF
 fQvcwmdMF7OEb7MB/RhGLgwDKF+As7ohU06gb1vc5a01SeY2sSkGKBInaXgeOs+35BAycLXtiN5
 fgf4Hheb3eiIATB3W86qbvo8xaKUEd3hOQ7Kp/H9uKq+5FDaTvTl1RyHq9/0N81UIyGXxzaWzHP
 gdaKeQIRl19atIkNs3ddAYQret91a3l8jtQMTIFWvaAkV9SBt1zDfpsiE38eAYKkhTbbPDO+FHu
 nO2jNShhzjChPCfweGlhQC/XsE2LvM3s//brnnSBSD48MQ5E9K4=
X-Google-Smtp-Source: AGHT+IHvKSJobjP6MasjBNHYZkgZFCidjZ93WTofXhQPX9cCEfH7oVgrZaz5xL9shO2OYO2rSBmRrg==
X-Received: by 2002:a05:6a20:c890:b0:1fe:5921:44f2 with SMTP id
 adf61e73a8af0-20e969e9676mr7298784637.20.1746409966282; 
 Sun, 04 May 2025 18:52:46 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b1fb3920074sm4462101a12.11.2025.05.04.18.52.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 04 May 2025 18:52:45 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 richard.henderson@linaro.org, alex.bennee@linaro.org, kvm@vger.kernel.org,
 Peter Maydell <peter.maydell@linaro.org>, anjo@rev.ng,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v5 20/48] target/arm/debug_helper: compile file twice (user,
 system)
Date: Sun,  4 May 2025 18:51:55 -0700
Message-ID: <20250505015223.3895275-21-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250505015223.3895275-1-pierrick.bouvier@linaro.org>
References: <20250505015223.3895275-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42f.google.com
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
 target/arm/meson.build | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/target/arm/meson.build b/target/arm/meson.build
index de214fe5d56..48a6bf59353 100644
--- a/target/arm/meson.build
+++ b/target/arm/meson.build
@@ -1,7 +1,6 @@
 arm_ss = ss.source_set()
 arm_common_ss = ss.source_set()
 arm_ss.add(files(
-  'debug_helper.c',
   'gdbstub.c',
   'helper.c',
   'vfp_fpscr.c',
@@ -29,11 +28,18 @@ arm_system_ss.add(files(
 arm_user_ss = ss.source_set()
 arm_user_ss.add(files('cpu.c'))
 arm_user_ss.add(when: 'TARGET_AARCH64', if_false: files(
-  'cpu32-stubs.c'))
+  'cpu32-stubs.c',
+))
+arm_user_ss.add(files(
+  'debug_helper.c',
+))
 
 arm_common_system_ss.add(files('cpu.c'), capstone)
 arm_common_system_ss.add(when: 'TARGET_AARCH64', if_false: files(
   'cpu32-stubs.c'))
+arm_common_system_ss.add(files(
+  'debug_helper.c',
+))
 
 subdir('hvf')
 
-- 
2.47.2


