Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACBB1C3ABD8
	for <qemu-devel@archiver.kernel.org>; Mon, 12 May 2025 18:20:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEXfK-000870-N5; Mon, 12 May 2025 14:14:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uEXaJ-0001pl-KH
 for qemu-devel@nongnu.org; Mon, 12 May 2025 14:09:05 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uEXaH-0000Uc-KY
 for qemu-devel@nongnu.org; Mon, 12 May 2025 14:09:03 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-74237a74f15so5157816b3a.0
 for <qemu-devel@nongnu.org>; Mon, 12 May 2025 11:09:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747073339; x=1747678139; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=h9+0A2smB/xfpAp/1FKWxfsvzCeqir2otJn6Vwgzfpo=;
 b=yGA9jhx5XRQvPnGnfiidyNcUHXkntxJPNn7oYhpZLj1IwwGa/dlDQ8cFlH/nUVv8QK
 +mDSDW1Be4XhRq9Kef4rbc7fUY4b11Sdc8n4sl4nO7CKvRFwgQ++n3Z3X4nHmV2f9i2v
 MHryNpaciRKtJ0DKJyeBda9bKy9sMugbh2gTMyR6vlJ02a1BbXSOHA2sGAcezuA/fzRq
 WJAmrqFIyJABi2YpFV/A/Yt7rNfelrKS2RpG33Wsah/87SoguHbvItkLQvjyWUagoIDI
 1TTGMb550VS8B2tRxE2RDFrefsL+97+0mDoHzwqJ3yOepFpd40ISaNa8bh0lnooXthtW
 3Bng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747073339; x=1747678139;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=h9+0A2smB/xfpAp/1FKWxfsvzCeqir2otJn6Vwgzfpo=;
 b=T6II1WM3JE0zVbWQvfswJp3l1NhuPDsPCFr92JNImIUeO2zcoaZ3NkmZ1/gicn+69t
 U4NNtLD44Mtg0T6kWmkKqfxCjZHZcRfNCXnISsGB308NYxLiB4D9z7OcH7lAMISlezVm
 hEp2zx2BN//RpMmL0Gt2IBC8S/Ce96eq/TkzHOUmaYUD0eyrxgWo8twBciNhucqEXYaU
 OxHCAWPyM6mf1I/egPT0RYjw01yUxBrk8LLkYVejkJOICxUjP7TgVLlL7RUNW5O3RbAk
 dqG48sk0En6hTkTjA5MNLDCeJ/KN2eNp0BP+pueTFuUvFlVi8d4gxQXojXit9BBkyRNN
 0CyQ==
X-Gm-Message-State: AOJu0YxUUPqtxuCZthGX3MO3NDh2ltuz0Qgqth4mCJf3QuhIkOfX2/s6
 sK+q6GWkdThjGls4pOJHOtgnBwhfq7iLm/eCJz4Boc6wwwWPn5KUH9B5+HCQKYT+FZ4gYRcnjih
 /
X-Gm-Gg: ASbGncus9LTd4W9b5q8eTipxioCVr9+6l2CIoruQDpSpNCnibPjCv8HLrnogWE1H89S
 PCSIvpyFHw5lsh3nidU54ghprfyFSDxqCYFbrV6kfNn+AWfOnn6cUwOqk2TTbp1r46ajkxrD45+
 5f8Q5K4hZ83n9KCRuh1gh+nzH44rY0bhLtIVLQWFAEAgdywg11GPHkFl8kb3TKT7a0PqrVghyIt
 /Yuk3JoE55Xzp6MR71yKqWjak9tFRoGayWTVxmeCG+EDNzxWBbPsZMDgHrUi/Np4/ywqHdMmn05
 U3KBzd0JG9+3Vcfpeu7tbY5wxZ8R8YfYdvRjN2jOMSKSDd4RzR0=
X-Google-Smtp-Source: AGHT+IFMxEYVPluGpO+aZ38G/jrGs/8RtCSp1027p4RYYJ/IZhfE7V8sbgUcy7m6CYbsJgYkfmCkQw==
X-Received: by 2002:a05:6a00:997:b0:73e:b65:bc47 with SMTP id
 d2e1a72fcca58-7423bfe4cf7mr18237636b3a.17.1747073339256; 
 Mon, 12 May 2025 11:08:59 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-74237705499sm6438580b3a.33.2025.05.12.11.08.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 May 2025 11:08:58 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 kvm@vger.kernel.org, alex.bennee@linaro.org, anjo@rev.ng,
 qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v8 48/48] target/arm/tcg/vfp_helper: compile file twice
 (system, user)
Date: Mon, 12 May 2025 11:05:02 -0700
Message-ID: <20250512180502.2395029-49-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250512180502.2395029-1-pierrick.bouvier@linaro.org>
References: <20250512180502.2395029-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42e.google.com
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
 target/arm/tcg/vfp_helper.c | 4 +++-
 target/arm/tcg/meson.build  | 3 ++-
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/target/arm/tcg/vfp_helper.c b/target/arm/tcg/vfp_helper.c
index b32e2f4e27c..b1324c5c0a6 100644
--- a/target/arm/tcg/vfp_helper.c
+++ b/target/arm/tcg/vfp_helper.c
@@ -19,12 +19,14 @@
 
 #include "qemu/osdep.h"
 #include "cpu.h"
-#include "exec/helper-proto.h"
 #include "internals.h"
 #include "cpu-features.h"
 #include "fpu/softfloat.h"
 #include "qemu/log.h"
 
+#define HELPER_H "tcg/helper.h"
+#include "exec/helper-proto.h.inc"
+
 /*
  * Set the float_status behaviour to match the Arm defaults:
  *  * tininess-before-rounding
diff --git a/target/arm/tcg/meson.build b/target/arm/tcg/meson.build
index 7502c5cded6..2d1502ba882 100644
--- a/target/arm/tcg/meson.build
+++ b/target/arm/tcg/meson.build
@@ -34,7 +34,6 @@ arm_ss.add(files(
   'mve_helper.c',
   'op_helper.c',
   'vec_helper.c',
-  'vfp_helper.c',
 ))
 
 arm_ss.add(when: 'TARGET_AARCH64', if_true: files(
@@ -68,10 +67,12 @@ arm_common_system_ss.add(files(
   'neon_helper.c',
   'tlb_helper.c',
   'tlb-insns.c',
+  'vfp_helper.c',
 ))
 arm_user_ss.add(files(
   'hflags.c',
   'iwmmxt_helper.c',
   'neon_helper.c',
   'tlb_helper.c',
+  'vfp_helper.c',
 ))
-- 
2.47.2


