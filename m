Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60696C02190
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2025 20:15:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcry3-0002MV-Ou; Tue, 28 Jan 2025 15:13:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tcrxt-0002C1-Qr
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 15:13:43 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tcrxs-0001cg-1O
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 15:13:41 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4362f61757fso64273115e9.2
 for <qemu-devel@nongnu.org>; Tue, 28 Jan 2025 12:13:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738095219; x=1738700019; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=cbf1tfDlw8S/0zM70x0LxhBshJ/qOA+Av2skzPJK2pE=;
 b=ZBJ1VE8xh0j3gC1eReOdxe2grVqm/qaKTiiyVLVnqUZAWM7QEi2suK2+Vv4SsJwbXj
 gk5iZHDeI2QTkb2RwwhaaL6Wb5HACaJzmI4euU7joz569q8AnQfAiZRzHtqUUHCBP6JA
 YtkIhvjkFtM2oLk10k9TpZQ+zmqIYZ54+KGVs/ZF7NjDxjGob3gGIb7RR/lJQKnrSbGS
 sVuFe+c3rCYdP8nYwebFOejNjGQWM+SH59DBmEk6TkYSDhTM1fa/kPse4mZe+1xIXSpD
 ZetPBn9R6lIxPg1MW5dz9CozpPtGbj082OpJLlWi8/VSO8kvrOWqHZKIn+DsmNvKnD9u
 h2Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738095219; x=1738700019;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cbf1tfDlw8S/0zM70x0LxhBshJ/qOA+Av2skzPJK2pE=;
 b=LBdOxg4l0SFjE+xscGJbLvqQLB9rlswDlNa872FBMernFb/zQ9XKgU1nfbKrbpvMG3
 0pmfLnYiPM37JDpawPt+84spZBHpjHCBatyT8gOP0r86ZZhI1AFJzdX/H3JcuZH1tA/u
 dxPPLAYBQN97m+pmzU9/lnbVuMkjJe7DnNEbuEnXXIO25mxzAvXDBavvGVy/vGAYUvSW
 uHZZYtOZ0pkhsDcXwjn7LXw1SWlGQbWav1MLaYeb7kza+OjLF97AGILEqoBHPFxwAFpv
 tojQxIY39i667i4MjgZQAmWTMLr1+prw50nOfOB+Ym5MBQC2awonKadsi5U+z4K7siUI
 XCLQ==
X-Gm-Message-State: AOJu0Yyspt6YOJEU2VpA37ppmUOf0vjy9AHoIGbI7VNq12/RWZgG0a3L
 YrzhQM41LFCJ1sFTuNG4Qie/hDzNpV1NTqyqL+YuCqLUWs+nFn+qIXwmt5DePwBT8dN52i2BQfN
 G
X-Gm-Gg: ASbGnct0K0UW3bZ6tgYAPWQnRPbEgBWo2n1tAlsDQC6+8hgtIbSghhrGPoR+mPD9GbV
 LgtlnZxAOE4GboIKEacn2iTX0s7IbUN/seQeJ4cDx10H5TUzwxbojv596iElCMIPht7zDo+iGyc
 qXUoHph07QZjhMlh71hsiqA4VoGJmiqjqz+rTPUnAouNCEnXxns58E+cb6LxhBfBDb5ErIuFQMW
 18mrQGHIfAqZKLkhJLevGKaXn8nEzWgy7lJVWXXauI42Q8V9QIz/FLdr+voWaZe0tjqQOIfiur0
 9bQSjwx1iUD3cNAfDi+GJw==
X-Google-Smtp-Source: AGHT+IHjDUh0ppeM4y7MNxY+p7QbBNvVZAlrwTvBU2pGdHhmFc16kFSCqXxT7mUIVqNGntG/tmae1A==
X-Received: by 2002:a05:600c:19d2:b0:435:330d:de86 with SMTP id
 5b1f17b1804b1-438dc34b37bmr3010555e9.0.1738095218672; 
 Tue, 28 Jan 2025 12:13:38 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438bd4fa3efsm182524105e9.2.2025.01.28.12.13.37
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jan 2025 12:13:38 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 21/36] target/arm: Use fp_status_a32 in vfp_cmp helpers
Date: Tue, 28 Jan 2025 20:12:59 +0000
Message-Id: <20250128201314.44038-22-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250128201314.44038-1-peter.maydell@linaro.org>
References: <20250128201314.44038-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

The helpers vfp_cmps, vfp_cmpes, vfp_cmpd, vfp_cmped are used only from
the A32 decoder; the A64 decoder uses separate vfp_cmps_a64 etc helpers
(because for A64 we update the main NZCV flags and for A32 we update
the FPSCR NZCV flags). So we can make these helpers use the fp_status_a32
field instead of fp_status.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20250124162836.2332150-10-peter.maydell@linaro.org
---
 target/arm/vfp_helper.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/arm/vfp_helper.c b/target/arm/vfp_helper.c
index 0671ba3a88b..034f26e5daa 100644
--- a/target/arm/vfp_helper.c
+++ b/target/arm/vfp_helper.c
@@ -373,8 +373,8 @@ void VFP_HELPER(cmpe, P)(ARGTYPE a, ARGTYPE b, CPUARMState *env) \
         FLOATTYPE ## _compare(a, b, &env->vfp.FPST)); \
 }
 DO_VFP_cmp(h, float16, dh_ctype_f16, fp_status_f16)
-DO_VFP_cmp(s, float32, float32, fp_status)
-DO_VFP_cmp(d, float64, float64, fp_status)
+DO_VFP_cmp(s, float32, float32, fp_status_a32)
+DO_VFP_cmp(d, float64, float64, fp_status_a32)
 #undef DO_VFP_cmp
 
 /* Integer to float and float to integer conversions */
-- 
2.34.1


