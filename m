Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABDC5CD4F24
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2026 06:55:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wN3Ub-0002RU-Bg; Wed, 13 May 2026 02:54:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wN3Ua-0002R2-Br
 for qemu-devel@nongnu.org; Wed, 13 May 2026 02:54:52 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wN3UX-00039S-NM
 for qemu-devel@nongnu.org; Wed, 13 May 2026 02:54:52 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-48a563e4ef7so57995675e9.0
 for <qemu-devel@nongnu.org>; Tue, 12 May 2026 23:54:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778655288; x=1779260088; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lJhG/leGyEu4X7ZgF/toa9YsGjYWyYzU+Flph+7d1Hw=;
 b=YOAw3gF1EMOy6A+zxoIjHPyiMn6QIKJrPoYaZ5m4d1qITiHqZPLeoH1zTcfvwrxK/8
 11w1McfXUUY1oJc0ZAKRAp3fJYneKaksWkvcvrt9ek329yFureo050VG3d0b0nzX+CCF
 iEWHRLxj7LtekH/Xfg+lHXql5OF364Ry/NiZATOdbKvRoU4dycIcXJAumYzccjaGVk4u
 7lxNQE9t2WDNPtwupAXTEcYkGLZsJ9Pbxt8JznWZ2d/dQDh2kBeYsj1BH4SUpSSe0D8P
 9hnWB5GAqWZ7pAYt2JNXiKTRNTZqhuEPQB/fFBOXCFbvpODvNTD/Lb8R9p8oroHx9kaZ
 OE5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778655288; x=1779260088;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=lJhG/leGyEu4X7ZgF/toa9YsGjYWyYzU+Flph+7d1Hw=;
 b=RPu8Kr6BxRIeI8TcoGaPZFklqshyRf0MNI23ZdKMm+jWRNlCXbF3Utx+hniN5Sf1QB
 6iEWVSqhnP1Gu8c7nPVgxkdk0ywiv2FhTYEL/IlfoiKBeS8Io8Tp5U6C0zePSiDnQeLk
 R5Igw8tDDPM/vB5l2PBwDu3U2TXk1Bksns1LWop/Jzs/SB8QReKfMcF2+nz6twwFPlFw
 fYLN3/Zg4EVmib6To3XrpqvDW5by7MyGGw/C4iBki+7vH4gCBOr5wixiHljiAmos8/XE
 C1GBeGg0edVUBCRTOfvtdxbn5CBJ4bYFPB+jkk6YcHVheqgPEecrIo6mzVsijRu1LkJ9
 BREw==
X-Gm-Message-State: AOJu0YzlgEAzWaGTV+9G/y44np+QIt/b0Py/L/lAK6RifWYeTcT7SJDf
 nhBicj/WsJN+ryyRIu8ymx9bm6ZnvovAah6q0U+oix+KC/1UCX25MrZ6PVkKarMM6XKqddxIsIf
 qSDGL5qI=
X-Gm-Gg: Acq92OF1Ui/wwbCAC2KFNGbP37/gq6dcj2Sw31v9auEf/bdPFaUbhbwWr4tr+DS+LFp
 62/dfWenF4KFaSyEzpjhmVc3DE2WT9xFeF83nJr18Lk9kTHUscSbzQzURIokYGGXIAJ6r+ayG8U
 X/OurBGtKIi5pd2a8FZ9oK5NmCHr/rC6kqwTYp+YzjSBolcA9rhZj4BmnplUMvqK30rgf9zRPyf
 uZch/MbNoeOyL71HlGsMds2hhQZxPT+SRFJDHtIWhPPN2oJCVUPTV/EY+WEoy1i3SDc7VCCcvLN
 LCfQLZ30XUtNW2U6L0+m+ZguDxE2PRfKnCQLNtPs41JxGWzcIL53+/ecXfrOjH1K5tFzqqAx6Nx
 X77DyhsICk7QgnFeaJMj000f7XcH/eoV/nQlr6llnmUBLvkNKbJlVXIEx5Pl9wzjVNpIBEXFrHZ
 b9VvMRDXTsuL1GScDLp2REqDxI4Q0D2C3CUoOufy+6xIyYBY0rZg+yYX6JDjf0nYBmpuV3BDuG
X-Received: by 2002:a05:600c:4f14:b0:48a:5546:61a1 with SMTP id
 5b1f17b1804b1-48fc9a32cd8mr30903995e9.15.1778655287923; 
 Tue, 12 May 2026 23:54:47 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48fce37b308sm50275325e9.10.2026.05.12.23.54.46
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 12 May 2026 23:54:47 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Yoshinori Sato <yoshinori.sato@nifty.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-stable@nongnu.org, Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 1/3] target/sh4: Re-allow unaligned access on system emulation
Date: Wed, 13 May 2026 08:54:35 +0200
Message-ID: <20260513065438.8680-2-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260513065438.8680-1-philmd@linaro.org>
References: <20260513065438.8680-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

The change 0 -> MO_ALIGN in commit eb978e50e42 ("target/sh4: Use
MO_ALIGN for system UNALIGN()") would have been correct if it was
merged before commit 1fceff9c3ca ("tcg: Remove TARGET_ALIGNED_ONLY")
which defined MO_UNALN -> 0. What we really want here now is
MO_UNALN (MO_ALIGN is dealt with in commit 03a0d87e8dd "target/sh4:
Use MO_ALIGN where required").

Use the correct definition, otherwise we get when booting Linux:

  ok 14 bitfields
      KTAP version 1
      # Subtest: blackholedev
      # module: blackhole_dev_kunit
      1..1
  delay-slot-insn faulting in handle_unaligned_delayslot: 0000 [#1]
  Modules linked in:
  CPU: 0 UID: 0 PID: 298 Comm: kunit_try_catch Tainted: G                 N
  6.17.0-12907-g8765f467912f #1 NONE
  Tainted: [N]=TEST
  PC is at test_blackholedev+0xc6/0x1c8
  PR is at test_blackholedev+0xca/0x1c8
  PC  : 8c228d16 SP  : 8d40bed0 SR  : 40008001 TEA : 8cce4026
  R0  : 00000000 R1  : 00000000 R2  : 000000d2 R3  : 8cc77b80
  R4  : 8cc77b40 R5  : 0000000e R6  : 8c228cea R7  : 8cce400e
  R8  : 8cc77b40 R9  : 8cc77bbc R10 : 8cc77bbe R11 : 8c4b46b0
  R12 : 8c78310c R13 : 8cc29cf4 R14 : 8c6e3a88
  MACH: 0000d80d MACL: e554cb0f GBR : 00000000 PR  : 8c228d1a
  Call trace:
   [<8c05b378>] pick_next_task_fair+0x94/0x164
   [<8c5c2bce>] __schedule+0x306/0x6ec
   [<8c21fa68>] kunit_try_run_case+0x58/0x174
  ...

Cc: qemu-stable@nongnu.org
Fixes: eb978e50e42 ("target/sh4: Use MO_ALIGN for system UNALIGN()")
Reported-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/sh4/translate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/sh4/translate.c b/target/sh4/translate.c
index 5adf650744c..3ddd4f612e4 100644
--- a/target/sh4/translate.c
+++ b/target/sh4/translate.c
@@ -54,7 +54,7 @@ typedef struct DisasContext {
 #define UNALIGN(C)   (ctx->tbflags & TB_FLAG_UNALIGN ? MO_UNALN : MO_ALIGN)
 #else
 #define IS_USER(ctx) (!(ctx->tbflags & (1u << SR_MD)))
-#define UNALIGN(C)   MO_ALIGN
+#define UNALIGN(C)   MO_UNALN
 #endif
 
 /* Target-specific values for ctx->base.is_jmp.  */
-- 
2.53.0


