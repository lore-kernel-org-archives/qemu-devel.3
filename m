Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F6FBC3ABD8
	for <qemu-devel@archiver.kernel.org>; Mon, 12 May 2025 18:15:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEXZv-0008NG-BV; Mon, 12 May 2025 14:08:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uEXX3-0002Yo-18
 for qemu-devel@nongnu.org; Mon, 12 May 2025 14:05:47 -0400
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uEXWz-00008j-7B
 for qemu-devel@nongnu.org; Mon, 12 May 2025 14:05:40 -0400
Received: by mail-pg1-x52d.google.com with SMTP id
 41be03b00d2f7-b200047a6a5so3621978a12.0
 for <qemu-devel@nongnu.org>; Mon, 12 May 2025 11:05:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747073136; x=1747677936; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SeLT1f95/cGbe62bYfKMrzmzjdSaQ72IuCLuyv7ztwQ=;
 b=T4prQYXj/2VylSZSo4OoB9f0Wj7c0+GE3B1lUsXWfLdhjRGvVDK5wn9hRwDbmuXrNS
 6lV7rEb0v2V7A3LAkj4W7wVCL23tmMWAJl3BjzC3QHI6eQpDaUcacvHd92IPqo0+pzzE
 EPSPJvVCvf4q0te3iKemXiB6h3BjUBSKv6w5vKcDJinnavSLRbIKDFiOkF7RzDAtQl7s
 Envl1ooTn9XrBJqSgyAOEaNO7r52cq0yzgcFm+l6LDrH6zlKHKF4pWDU+QaGXAsLfDIJ
 ZqB67bepBjbPaCghXNVDV7YRflFyHUd+5nDLqU/JGyQlFBZlsjZDRafiLz3b8Y754INi
 +2ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747073136; x=1747677936;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SeLT1f95/cGbe62bYfKMrzmzjdSaQ72IuCLuyv7ztwQ=;
 b=UeTK+RXsDqc78MtKUs5VvD2/hrL3KylzQ2znw19YItG7OdXCBhOWG1hJdGETjVtZSM
 kMpZ6wK+2BbD7G4TZx0gVQjWmlB7Hfp+8alq9XA7dAf04BMznqf88YerzGFN4Klwcy5x
 wHnVCTeR8Pv0llWuaVbGEFs9x0SIWf6eoaTL9mI5JjUyV8xXAFMRPLRTqiytB8yZq207
 bRD47v6anTJhGgYapQyNdAMwgGJrILOR/u2b0apz2aqPBOWCvk91qxdEcVzYy/nvUdRb
 OPimTRiUjtbH8bXn5p9wKcubhAWvrlAWeJsRerLmUlTs9/esrYQKl+sd4iZeJOALDJ5d
 WgWA==
X-Gm-Message-State: AOJu0YzYVEFdMPl1Ej846OK7sdoziYyL6mUPSZ9CiKBeXDZjzZWglKXt
 TuBF1J5rBqXi+HfdheRqlXs7667QLyw8w93c020KtH/02xotzs11af87F/o8C9W2yh8/nscU62e
 C
X-Gm-Gg: ASbGncsVPamwoXI+xsbjTzLfMvAINBqPZQRIIb9MKjiztHh4VOykuRQwsCS4/0pPB0o
 5sW2b8U7iiJIEWe6giB3mc66YHVWnjadTmMZeX9r0BTU/BJyFFKuHvW0Ll8EHUKB+pj1u2KXjxm
 qpEX7S2cbrl1GapCJQGYP1angduQJumsUjyASw/9P4wbg/8BPP6QxNT1H/Fdy9AGYury+x4/Dgd
 ZnObTijUb7XO96NTup4IV7FEDZEc3uVuPlYS0TmdXjDXugTuJCQBC0aGk0sz2JeBDHO344JguNP
 Vgf92OC1ehCs+hmIjN1DDYAzyDSUCPEK2v17JaeU43lbHV94QtI=
X-Google-Smtp-Source: AGHT+IHSO/yVDZ7/NBshpsajMoSJkN06Ia8fN4xI+DuSiw4RySVI3WeZmL19cuWAva/wblsZGxHmGw==
X-Received: by 2002:a17:903:984:b0:220:e91f:4408 with SMTP id
 d9443c01a7336-2317cb540f0mr5666115ad.22.1747073135905; 
 Mon, 12 May 2025 11:05:35 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22fc82a2e4fsm65792005ad.232.2025.05.12.11.05.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 May 2025 11:05:35 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 kvm@vger.kernel.org, alex.bennee@linaro.org, anjo@rev.ng,
 qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v8 27/48] target/arm/arm-powerctl: compile file once (system)
Date: Mon, 12 May 2025 11:04:41 -0700
Message-ID: <20250512180502.2395029-28-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250512180502.2395029-1-pierrick.bouvier@linaro.org>
References: <20250512180502.2395029-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52d;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x52d.google.com
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
index 95a2b077dd6..7db573f4a97 100644
--- a/target/arm/meson.build
+++ b/target/arm/meson.build
@@ -15,7 +15,6 @@ arm_ss.add(when: 'TARGET_AARCH64', if_true: files(
 arm_system_ss = ss.source_set()
 arm_common_system_ss = ss.source_set()
 arm_system_ss.add(files(
-  'arm-powerctl.c',
   'arm-qmp-cmds.c',
   'cortex-regs.c',
   'machine.c',
@@ -38,6 +37,7 @@ arm_common_system_ss.add(when: 'TARGET_AARCH64', if_false: files(
   'cpu32-stubs.c'))
 arm_common_system_ss.add(files(
   'arch_dump.c',
+  'arm-powerctl.c',
   'debug_helper.c',
   'helper.c',
   'vfp_fpscr.c',
-- 
2.47.2


