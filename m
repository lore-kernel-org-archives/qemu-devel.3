Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B7EDC28B28
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Mar 2025 07:24:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqoXd-0001Q4-Rz; Sat, 08 Mar 2025 02:24:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tqoXb-0001P0-IG
 for qemu-devel@nongnu.org; Sat, 08 Mar 2025 02:24:12 -0500
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tqoXZ-0008LR-W7
 for qemu-devel@nongnu.org; Sat, 08 Mar 2025 02:24:11 -0500
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-390e3b3d3f4so1289436f8f.2
 for <qemu-devel@nongnu.org>; Fri, 07 Mar 2025 23:24:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741418648; x=1742023448; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0ZK0fCYsleMzsa/JHC9c5molUW12aA2YIflz9M8WHro=;
 b=Xs/IWlWaHqMWvfxFhzzL75CcMcuPdm1ktOBD/qw2qJItI4Y1fOsAauHhEXoZ8zHySG
 RwRgjZx+z5NmWeRwxste04EKPbEoIbJ2GqhVoYD0HaWawZUbqKjez6StrJ1/LwuTYsxq
 /Cjm7EcvIpEMnD5XHbSpsSkdc/XLQYb5qp+czMMmA6Z7BVtg1gfWSiisBziU1H5Wf4Kj
 dZvnra/6KDNCETyqjYQz3MkIJ0IpOytgAwtZRMoMNLGRSckKuQl1gXygq7xRdDmXFRMe
 ExIpFXqyyf3iTfp8H1ts200g3p+Vh7OD0UTz/p5BOBAIQG+G5YDk4am5oklmxf/NgyPV
 vQ8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741418648; x=1742023448;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0ZK0fCYsleMzsa/JHC9c5molUW12aA2YIflz9M8WHro=;
 b=IsweabF2Pe2gioPVdbn+0xP68IAzFwDsiQfhLtHIrJ4bJd9OAwEjJVXj3X7D//tZT1
 SwtExux2XJLOLeK902WbYvQbsaP3cpq0C8eQ6vDROuICcGor4liKvqwC7JylV5iHOtXr
 ba1Ku0PEcD5WlC4lBsIRHKUdQ1AibHf46M8oFzAGGIKizT0TuKbg/QJS3EyoHGcKNWBG
 gc/Pj4e6c3nk68vLmqyInaMU8mKCU/s0mfDVLZTCcmzN0TObt9qI2nTnL0eWEzgoZDUy
 P3o7VHlJ2uIY9/Mg+9bXdpDlzVOa8ULqCtIB/cr2BpSEcRTqGkC5z7qwZC3NXOvB+64i
 Eu9A==
X-Gm-Message-State: AOJu0Yw4iHzax0xOW7rN0kErN5PQAbF2SLOxq9B1zYa6raBR1a2pyl4s
 Y6cKbgbpLX2aKRJowgtBM7iC7rSuBepudzTZkmxaHtEBWzm96uu98mBlNJWEsGBvDnZEH7yEK08
 0eW4=
X-Gm-Gg: ASbGncsZ68s4H3dOwQwlGIkH2cTRW/Ui6JiBDO1Bu6FwpVJUKJCkc4TpVBAvMWFC5/u
 aI04jGZtiiz0TiETQHf9g0iZZhKNh7HiEBxKHKyHdiWZ5HTrM+33s1MZULH88eWIywvxDADvV/9
 jcirXE4NNKDd7AxvxwHI75BlY2g17UKfkdsr5WONFwMqgznXO8KXTx/A5viLUQaU1zylYmlcRVD
 gBbOlxfWn7i6AmIiYgBtwIuSh6rumZDeZuSjgql3yg4zC/lFZbBGlkxDsD3VyLpRDY9HfMPz7H6
 8z7idOxksKYuQRM992M9NEs7s0OLTTLDWuxeU8skLkaepPeB+OMthQOg1uzMbrouL3anAFZLRbz
 auvsPg58Hnf1jRRlyd+qWV57Thblcxw==
X-Google-Smtp-Source: AGHT+IFU52KZdpIoYDXT+0zoK0soh+D7/NPAxiNhFiljiVjj4NIM6kzs9VvmZqUsKU6YG3M4GIlmtQ==
X-Received: by 2002:a5d:5889:0:b0:390:f45e:c851 with SMTP id
 ffacd0b85a97d-39132d8de73mr4857587f8f.21.1741418648332; 
 Fri, 07 Mar 2025 23:24:08 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43bdd8c3173sm77095155e9.11.2025.03.07.23.24.06
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 07 Mar 2025 23:24:06 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 17/18] accel/tcg: Build tcg-runtime.c once
Date: Sat,  8 Mar 2025 08:23:48 +0100
Message-ID: <20250308072348.65723-4-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250308072348.65723-1-philmd@linaro.org>
References: <20250308072348.65723-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x435.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 accel/tcg/tcg-runtime.c | 7 +------
 accel/tcg/meson.build   | 2 +-
 2 files changed, 2 insertions(+), 7 deletions(-)

diff --git a/accel/tcg/tcg-runtime.c b/accel/tcg/tcg-runtime.c
index 3d4651b4012..fa7ed9739c7 100644
--- a/accel/tcg/tcg-runtime.c
+++ b/accel/tcg/tcg-runtime.c
@@ -23,13 +23,8 @@
  */
 #include "qemu/osdep.h"
 #include "qemu/host-utils.h"
-#include "cpu.h"
+#include "exec/cpu-common.h"
 #include "exec/helper-proto-common.h"
-#include "exec/cpu_ldst.h"
-#include "exec/exec-all.h"
-#include "disas/disas.h"
-#include "exec/log.h"
-#include "tcg/tcg.h"
 #include "accel/tcg/getpc.h"
 
 #define HELPER_H  "accel/tcg/tcg-runtime.h"
diff --git a/accel/tcg/meson.build b/accel/tcg/meson.build
index 81fb25da5cc..411fe28deac 100644
--- a/accel/tcg/meson.build
+++ b/accel/tcg/meson.build
@@ -1,5 +1,6 @@
 common_ss.add(when: 'CONFIG_TCG', if_true: files(
   'cpu-exec-common.c',
+  'tcg-runtime.c',
 ))
 tcg_specific_ss = ss.source_set()
 tcg_specific_ss.add(files(
@@ -7,7 +8,6 @@ tcg_specific_ss.add(files(
   'cpu-exec.c',
   'tb-maint.c',
   'tcg-runtime-gvec.c',
-  'tcg-runtime.c',
   'translate-all.c',
   'translator.c',
 ))
-- 
2.47.1


