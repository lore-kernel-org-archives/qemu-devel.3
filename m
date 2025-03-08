Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DC23C282EC
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Mar 2025 23:01:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tr39d-0005o3-Vx; Sat, 08 Mar 2025 18:00:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tr38c-0004f6-5P
 for qemu-devel@nongnu.org; Sat, 08 Mar 2025 17:59:23 -0500
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tr38a-0005OX-OB
 for qemu-devel@nongnu.org; Sat, 08 Mar 2025 17:59:21 -0500
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-22403cbb47fso57529405ad.0
 for <qemu-devel@nongnu.org>; Sat, 08 Mar 2025 14:59:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741474759; x=1742079559; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BLwMcb0zSejyoUnF+TqOrWomvomMdGG2ZB4pBKcbmfs=;
 b=he4HFnKluaoZtTpSrPJO+nmc8SNICN6PpBTlSP83GvWuNoPidshfjag8JghApwamHR
 XQCk925TyMIVltaTHwFeYVROI7YAZi0IYNsOUH4VfcR9V7cEAId63XwSIqayaKXIfX2e
 F2L3KN/MEX85zHkGA3zpDUoonTckVcFmfwx/4wCphET111xlmwB6hbfkP743phuPwtQj
 4MUmaOf3Nzp2uXoiziyc6StJ1ch516JCxo6ifAHwpssxmvy69S14nL8y9Ts1MIOPuvgX
 3f441UP+qW0NN/sywG/7dUJxh+C2bg6HZ3SIyP5TfvPwRPYw7oSeVmwBaFHg1TN7RxDl
 0WNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741474759; x=1742079559;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BLwMcb0zSejyoUnF+TqOrWomvomMdGG2ZB4pBKcbmfs=;
 b=MwRTmEQVHOF8ORP20OlmYXRNl6gV4iJeluP7QGrrtgHamWUY+aLIFuSwjTx7DDpysv
 BynuLKkVSm8x3XOBTfLjByHGLKRu8sDzP+L4yhWJGJ1QgjtEIIaQKAEBB4hP7SSbiOAK
 RR5+PVksjiv4TJef2n4XIlXdh45cdXaogS1uTH6g618Ev7prueyEWq17ou3tPN9Ll9Gw
 bZanqDf43pLxgBv6aqpjXBix56AOX3ahD7eNiep3Fx6B1BgQeRE8vVPONAVku3i3Yp2y
 6PpQYqIgew+B17wsBrp9yiFPnUNv04KSMxHzZ0J9I7VSEmoLh9UVu7/lFDYl4weSrYuc
 DmzA==
X-Gm-Message-State: AOJu0YxP/a9Kl3LIz2cz+d8K0eew2rR+dj0x/UKL9qBcM6LliMkC/yB1
 eaAx159/jOMFUdx9lFigKDUUqCW4fIuN5lrKAzGXPvJA++u79ScueqJtlY8lQdp0/18UjsJmRLI
 X
X-Gm-Gg: ASbGncvtdJ2lZ3M09viAVdsAoQgX0HMgaAog8fOgyT2uwJL/V8fHsmNeWoPAkTYrHbp
 e9HnF+n7RWIuSE+qoeXr3y+qDdUe4Bh4kwqy1H0opaUeYmLpaPj8kJfS+jPcSCgD+cV1QgpUD2N
 /627bcZhTqo0zEDKF5JM4mirTKYdc9GS8YP/DpCf/0kCPSCXjBLQ4r6+H8gxcvofkviv1GA3CK/
 Kuuy3VIwu8FKZjOVpcRoFABi9yso0WjU04mPasRFle1nujIaggASzQtFPX9j3amr9YrhESzmrnm
 yyPHLAVD5hEcGzEHbbqGl6t5FyfUEDewUsos619LBLRirlc95uOmxvCcDUKmMw1yB0bufOzbfeW
 dpK0YIxPytzM=
X-Google-Smtp-Source: AGHT+IFg0C7bXCUXMpHNuNg+BEkVTsFhAgkpCGRR4BJPY3p6cobmItXD4OFdOxyF9IV7Jk+R6KFXRQ==
X-Received: by 2002:a17:902:cf0d:b0:224:a74:28cd with SMTP id
 d9443c01a7336-22428a9d1admr155717015ad.31.1741474759345; 
 Sat, 08 Mar 2025 14:59:19 -0800 (PST)
Received: from stoup.. (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22410a908a0sm51831175ad.162.2025.03.08.14.59.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Mar 2025 14:59:19 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 23/23] accel/tcg: Build tcg-runtime-gvec.c once
Date: Sat,  8 Mar 2025 14:59:02 -0800
Message-ID: <20250308225902.1208237-25-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250308225902.1208237-1-richard.henderson@linaro.org>
References: <20250308225902.1208237-1-richard.henderson@linaro.org>
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

Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/tcg-runtime-gvec.c | 1 -
 accel/tcg/meson.build        | 2 +-
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/accel/tcg/tcg-runtime-gvec.c b/accel/tcg/tcg-runtime-gvec.c
index afca89baa1..ff927c5dd8 100644
--- a/accel/tcg/tcg-runtime-gvec.c
+++ b/accel/tcg/tcg-runtime-gvec.c
@@ -19,7 +19,6 @@
 
 #include "qemu/osdep.h"
 #include "qemu/host-utils.h"
-#include "cpu.h"
 #include "exec/helper-proto-common.h"
 #include "tcg/tcg-gvec-desc.h"
 
diff --git a/accel/tcg/meson.build b/accel/tcg/meson.build
index 411fe28dea..38ff227eb0 100644
--- a/accel/tcg/meson.build
+++ b/accel/tcg/meson.build
@@ -1,13 +1,13 @@
 common_ss.add(when: 'CONFIG_TCG', if_true: files(
   'cpu-exec-common.c',
   'tcg-runtime.c',
+  'tcg-runtime-gvec.c',
 ))
 tcg_specific_ss = ss.source_set()
 tcg_specific_ss.add(files(
   'tcg-all.c',
   'cpu-exec.c',
   'tb-maint.c',
-  'tcg-runtime-gvec.c',
   'translate-all.c',
   'translator.c',
 ))
-- 
2.43.0


