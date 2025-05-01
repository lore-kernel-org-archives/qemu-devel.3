Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F00BDC3ABAA
	for <qemu-devel@archiver.kernel.org>; Thu,  1 May 2025 21:32:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAbOv-0005ES-Dd; Thu, 01 May 2025 17:25:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uAbOp-0004iA-QY
 for qemu-devel@nongnu.org; Thu, 01 May 2025 17:24:55 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uAbOn-0002C5-K2
 for qemu-devel@nongnu.org; Thu, 01 May 2025 17:24:55 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-736dd9c4b40so2446764b3a.0
 for <qemu-devel@nongnu.org>; Thu, 01 May 2025 14:24:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746134692; x=1746739492; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UdM4Y9gYKdv124M5AuRleUua4qCDdrLmsMUhfkZBN+Y=;
 b=U+buhxOhqcKv4gIG4oMM3fHPaLj7TO0vQSQW+vObSlpUIOOPYraUdJKklcCNOkP65r
 rl9hGYOVYpDKdBroUY0BdLfgPSLnDIpOe4VOzHkvbYZ3W2Ae7DaUC9k6iwAg4QV4D6Fe
 iz7S54HynjyPy1wnk7bZuSEbyz0f68NxqkUIxor43RD+2PbqDZfHtf6wJ1D/dz+QBPRo
 HTFN+CuPjqpTSnyOX4tAigcWwcBb7s0ZA4g9Fm4aJ0IAjj/mQjeaZM7SU7YUeA9BFw4V
 I56E9DuCL3cr5yeZAlerN+spVesjiw0ydsTz1X6Sih8y9FEoId2wUr90urseuk7uq1/X
 t7xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746134692; x=1746739492;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UdM4Y9gYKdv124M5AuRleUua4qCDdrLmsMUhfkZBN+Y=;
 b=d8RluvNNmp9gNN18P7kmeNMoeS+P+yqha5BxWH+MtkxOEuBspc8ajpGMfS6/JRHRre
 JldX0zx9+oOKPzhFI72hbRd58OhujB0YFMgxc41bEx2HDx9nFFXCdCmCe/wGKMS/+0zV
 Vfrsbr9EY8FuPmIjcCJJ8MYda0raI2kL+XZVnCzkuyCky4Oqabh+bbH1PJDYvTF0awaq
 BlOeH6EYiuwyG54C3zOwBV5qXjEQrO5+v6mne461yE8rBx6sg75OfsUGb4C9uvVwuLJk
 ETVq/QYF4QSKTh35+gSISN3yrqpYPKia+GDRkSq9auGVejOQUoS5YfV0Vjmr/LK1FyeH
 ROPQ==
X-Gm-Message-State: AOJu0YzvQ/UDV7vvDYXkRu22S5TAQXcK4ql3uSDGhEgH6AoWj2SLIB6y
 3TzjXCgaqsGjwmN3kaauIuFSnyc4BaPmroN73BO/RRHNzusMQkbz9CZbR4N7iIUHGp8kI0XP2qS
 l
X-Gm-Gg: ASbGnct8/YzC0mP5i7spDZeOrApBlLVCGZxWzyxB4F3QRIag/iX1EznXVxBVcpQwvF4
 3h3kW8awvmXeVJIkEx0oG7gRbS4lqS9rxEGXoqzDr+6GV4Lg0dY/+gBqswO0aE7GEFFXRzpROvA
 Rg47W/3XwgajyC/AaNC7wVxcHB4DFa8tlQYEu2GR0RB84OIPOvEvk+DU3toP4ZM6AsPGR5gTPci
 1s/Xt85xVSyLsRVaD2yxdntMmPCjeQQGR5I/ADogc3s5FgoLFIN3DFOmqMfYFm0RbwF7ijvgT95
 R+AYtYWqAwe3lHDLJsBYFhKBj7pwUDA4Z5cVvCc8tW2Etmav65hRYa/GQDJUQaQ42uSlsMb42Is
 =
X-Google-Smtp-Source: AGHT+IH93323VBd4j5bUeNeWzT80VxNCabCWP+fdM7ziIO+FBqZM2PI9t8JTMFFzCl67s7/vJasl2w==
X-Received: by 2002:a05:6a20:cfa2:b0:1f3:1ba1:266a with SMTP id
 adf61e73a8af0-20cc905e61bmr1074870637.0.1746134691908; 
 Thu, 01 May 2025 14:24:51 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-740590610desm135897b3a.146.2025.05.01.14.24.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 May 2025 14:24:51 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 47/59] accel/tcg: Build tcg-all.c twice
Date: Thu,  1 May 2025 14:21:01 -0700
Message-ID: <20250501212113.2961531-48-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250501212113.2961531-1-richard.henderson@linaro.org>
References: <20250501212113.2961531-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42d.google.com
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

Remove some unused headers.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/tcg-all.c   | 6 +-----
 accel/tcg/meson.build | 4 +---
 2 files changed, 2 insertions(+), 8 deletions(-)

diff --git a/accel/tcg/tcg-all.c b/accel/tcg/tcg-all.c
index 0ce34ac912..6e5dc333d5 100644
--- a/accel/tcg/tcg-all.c
+++ b/accel/tcg/tcg-all.c
@@ -36,15 +36,11 @@
 #include "qapi/qapi-builtin-visit.h"
 #include "qemu/units.h"
 #include "qemu/target-info.h"
-#if defined(CONFIG_USER_ONLY)
-#include "hw/qdev-core.h"
-#else
+#ifndef CONFIG_USER_ONLY
 #include "hw/boards.h"
-#include "system/tcg.h"
 #endif
 #include "accel/tcg/cpu-ops.h"
 #include "internal-common.h"
-#include "cpu-param.h"
 
 
 struct TCGState {
diff --git a/accel/tcg/meson.build b/accel/tcg/meson.build
index 7eb4619aea..d6bd304add 100644
--- a/accel/tcg/meson.build
+++ b/accel/tcg/meson.build
@@ -10,6 +10,7 @@ tcg_ss.add(files(
   'tcg-runtime.c',
   'tcg-runtime-gvec.c',
   'tb-maint.c',
+  'tcg-all.c',
   'translate-all.c',
   'translator.c',
 ))
@@ -21,9 +22,6 @@ libuser_ss.add_all(tcg_ss)
 libsystem_ss.add_all(tcg_ss)
 
 tcg_specific_ss = ss.source_set()
-tcg_specific_ss.add(files(
-  'tcg-all.c',
-))
 tcg_specific_ss.add(when: 'CONFIG_USER_ONLY', if_true: files('user-exec.c'))
 specific_ss.add_all(when: 'CONFIG_TCG', if_true: tcg_specific_ss)
 
-- 
2.43.0


