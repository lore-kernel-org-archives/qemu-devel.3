Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA670C3DA61
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2024 09:44:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYjLR-00041z-4e; Tue, 30 Jul 2024 05:40:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sYjLO-0003rn-Pv
 for qemu-devel@nongnu.org; Tue, 30 Jul 2024 05:40:34 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sYjLN-0000dA-5B
 for qemu-devel@nongnu.org; Tue, 30 Jul 2024 05:40:34 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-368663d7f80so2042983f8f.3
 for <qemu-devel@nongnu.org>; Tue, 30 Jul 2024 02:40:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722332431; x=1722937231; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=kU9D23p+W3yoB6z9qvYF5ze3lbw4IbqA/FP/4T6R+9k=;
 b=mzn1ljL9ldqf2tn5wsodeTq+tXrBm8HuULVBDKqkxGZhq6uM77EQ9V/7PjXZrOzWCK
 eKigAHcQrIHm572u7/Z6ZEnIQE9iKbV45AmxMDZZtB1vrqWvRlzjTqlnG0Q89mUNywDG
 NFw6WEg9Ncng9jJZIu+1RIS9tf6VG40/S7UZ2S2qOi+lDnDQ2TX2zVSCfkYziq2wEtMa
 1U2UszD/o08olF4+/a4SlmIpTK3IYQh2iz9KaQQPu30MS+uJymLmeKkLCklAcUvGM2zH
 RSLagYNGBvCtu+BRrc/M7VYc2Jmd9cgl35XlmorjwZCd0VLxXhVz5CSJRTor/cH2/etT
 rUOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722332431; x=1722937231;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kU9D23p+W3yoB6z9qvYF5ze3lbw4IbqA/FP/4T6R+9k=;
 b=U14Jz07RmtAQEz5lXyuBvTH1cQyYGyuYxg0qqX8OP2O/Qlw0q6I8MBGDPEZDy//1nn
 AK207r7qexrtYmYQKsDpNvZyLgYxp2PS8ty9QrUVEaCV7vA+CI4y5bbTbBDOsZdxRp02
 NwW6zQ1YxVAxCbc0YEzNpfW7OG6a4nFWesVr/II3IjYOAlBwawdwJ2FS7M9HAvwqFcAb
 IUUG1cR19paUZNp7uOplCL5aXxeqWKEqsn4eEqqJjnKBHfOM+YCbQJZQjyS2Yb0rqiz8
 Oj5UgteGEaA+njoQeWPqNCcho/r7A7tsmMP425whHZf8hBLUsBMnWBJKy1Dbrug0bg5R
 i/dw==
X-Gm-Message-State: AOJu0YxI1Bt6aMakxP5NRLYQu+dEvuvSfv1WC7dFGYKFoz5CoL/fc/UO
 085A1XHPl6jXkndmyFbALq+MZTnnDaAvxz4NyuihyjJgvIT6FMNmwElkipxlS2Dom7/0oRoSREx
 J
X-Google-Smtp-Source: AGHT+IGg+F3J6w+eKYe8GjUEUA0r8uZjKZuKAsOEocrjEZ1wAXvfBgpQt/LwAPEkr8zYE9y4T7HgZw==
X-Received: by 2002:a5d:4e0d:0:b0:360:79d4:b098 with SMTP id
 ffacd0b85a97d-36b5d03ce06mr5650520f8f.29.1722332431397; 
 Tue, 30 Jul 2024 02:40:31 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36b36862549sm14194974f8f.106.2024.07.30.02.40.31
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jul 2024 02:40:31 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 17/21] target/xtensa: Make use of 'segment' in pptlb helper
 less confusing
Date: Tue, 30 Jul 2024 10:40:16 +0100
Message-Id: <20240730094020.2758637-18-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240730094020.2758637-1-peter.maydell@linaro.org>
References: <20240730094020.2758637-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x434.google.com
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

Coverity gets confused about the use of the 'segment' variable in the
pptlb helper function: it thinks that we can take a code path where
we first initialize it:
  unsigned segment = XTENSA_MPU_PROBE_B;  // 0x40000000
and then use that value as a shift count:
  } else if (nhits == 1 && (env->sregs[MPUENB] & (1u << segment))) {

In fact this isn't possible, beacuse xtensa_mpu_lookup() is passed
'&segment', and it uses that as an output value, which it will always
set if it returns nonzero.  But the way the code is currently written
is confusing to a human reader as well as to Coverity.

Instead of initializing 'segment' at the top of the function with a
value that's only used in the "nhits == 0" code path, use the
constant value directly in that code path, and don't initialize
segment.  This matches the way we use xtensa_mpu_lookup() in its
other callsites in get_physical_addr_mpu().

Resolves: Coverity CID 1547589

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Acked-by: Max Filippov <jcmvbkbc@gmail.com>
Message-id: 20240723151454.1396826-1-peter.maydell@linaro.org
---
 target/xtensa/mmu_helper.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/xtensa/mmu_helper.c b/target/xtensa/mmu_helper.c
index 997b21d3890..29b84d5dbf6 100644
--- a/target/xtensa/mmu_helper.c
+++ b/target/xtensa/mmu_helper.c
@@ -991,7 +991,7 @@ uint32_t HELPER(rptlb1)(CPUXtensaState *env, uint32_t s)
 uint32_t HELPER(pptlb)(CPUXtensaState *env, uint32_t v)
 {
     unsigned nhits;
-    unsigned segment = XTENSA_MPU_PROBE_B;
+    unsigned segment;
     unsigned bg_segment;
 
     nhits = xtensa_mpu_lookup(env->mpu_fg, env->config->n_mpu_fg_segments,
@@ -1005,7 +1005,7 @@ uint32_t HELPER(pptlb)(CPUXtensaState *env, uint32_t v)
         xtensa_mpu_lookup(env->config->mpu_bg,
                           env->config->n_mpu_bg_segments,
                           v, &bg_segment);
-        return env->config->mpu_bg[bg_segment].attr | segment;
+        return env->config->mpu_bg[bg_segment].attr | XTENSA_MPU_PROBE_B;
     }
 }
 
-- 
2.34.1


