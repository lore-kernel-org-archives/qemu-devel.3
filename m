Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D39F8CCA476
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Oct 2025 14:13:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v68Pk-0005YJ-P3; Tue, 07 Oct 2025 10:11:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v68Pj-0005Xe-5x
 for qemu-devel@nongnu.org; Tue, 07 Oct 2025 10:11:39 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v68PZ-00026D-Jp
 for qemu-devel@nongnu.org; Tue, 07 Oct 2025 10:11:37 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-3ee64bc6b85so4910281f8f.3
 for <qemu-devel@nongnu.org>; Tue, 07 Oct 2025 07:11:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759846287; x=1760451087; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=7zJ9Hjqexkc3PQ97BESrWYieFpkrh4kVSJJTaYltMT4=;
 b=Xk4o0RzHe4t+IghTsUUpOxyun6IuJzo7EPs64WTVKJ99rjywWxIhAyZ3gya/odDAAO
 0iJbo+9b+BG6wZpXgGvt4t/cjNkB7pdxGUzArjlVAgLWVjwvRRQvy6tkWsczvrT62dsk
 MlOxSOG4uVU5kuuQREWLsPZB9G3tVc73PniMAGo5m7WjsIkjZSed1JcX7tHLdO100Pwr
 0Hn4yqY+eP6zd5dflhArKTVE0kJeVSHI7a0xlMq/rfx0+Snar7u9vxS/6CgkXC0jOClj
 zSaxZCi/L/z46jM6frOxhOuw7KLhyPR9wEpxGO3VmvDa6KAGnBhepJR34lWztcfeuyo6
 /dZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759846287; x=1760451087;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7zJ9Hjqexkc3PQ97BESrWYieFpkrh4kVSJJTaYltMT4=;
 b=Yzs/nutJ2rS1nCe4t4GLhFy8YriJfBl3l+EomXTVo2DW41Blxbhzch6mFenxZY4+IH
 yS/57WKyz5awKLZL++KE3kJnTsUKVSFQcOgO7zbnqT1s3Q7biUcy6S1qJ9QXHyXe/ag1
 9Pby+SXDMO3VaRZ+I3tqFkK3Mj3fAbQp36LfCdTg8Gm+y+On6j1aZA6UCMrN181V2aKj
 0sG7M7g8eYykGROQNdglqnrXT4YmzYPGNj9OjOtwpBSLhg4ldwbpD5KndId/0C9UEk+B
 jMwMmvHtuvT/IjDavc5FzSH+S6Ol3cIbc0MpTlZqmLRRyEvbfrcg87uukljU8bK03Nik
 5mFA==
X-Gm-Message-State: AOJu0Yz4asDaxfQ+AhgpX0EAc5OfkzW59kq8al+RDQ4MuF/XWIIN+y48
 bx7OrTrscZx3K3pXh3Zxl3025VG1yN0ZR2LkA6o44ikCG8W4+/h88HTFUv1dSKJFqfjFLiFCwXr
 Xqh4k
X-Gm-Gg: ASbGncv6SpNVqs17C/g9bMPsbQ3jT11oUfaixTAbxOMjVPOs/TRTS8pVA6IL8NRnJNZ
 cukJf27zvv6lcqcQaJtwI1PEuYyj67PQhmU8+IfUkg7sSB9GyJL1gm5MczbAylQsvZiUp5G8RlP
 3Jo59EcbNlucjVEoyTh8HILq2yhJrAdUzKJ8yazS23ZZEm2IHsNy3sR+4YdM0kND4xCOaTkSwQN
 PZ98T+YAC7+unJ14ixQHawapLfVh2uHel6FadSzaVXrFpn8ylQ66ehElqMkOZJJfdH1WcY1BU+l
 jtkIk7zaD0pL3F4mH/NaaHTtQ3ZCZvKDLy51+8LMVt+g2zFwNhiQSLyziBIvkgVo8F4o5zvhxMH
 lhdQO+M5js1w0osT1ka5hm42TYxR0N88C/kVJhfA7OmVkk88IQpQ6ldNHHkFZcRp6nuo=
X-Google-Smtp-Source: AGHT+IE+tQLHRS57fSmzAgzshH4ytNxuKQPIJOnZcp6B0UP6bGlhfe7yBgC/UbBubxzf9rG/rwKqfQ==
X-Received: by 2002:a05:6000:310a:b0:425:7f11:3159 with SMTP id
 ffacd0b85a97d-4257f113337mr4455839f8f.63.1759846286671; 
 Tue, 07 Oct 2025 07:11:26 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e78c5d290sm167037135e9.0.2025.10.07.07.11.25
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Oct 2025 07:11:25 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 01/62] target/arm: Don't set HCR.RW for AArch32 only CPUs
Date: Tue,  7 Oct 2025 15:10:21 +0100
Message-ID: <20251007141123.3239867-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251007141123.3239867-1-peter.maydell@linaro.org>
References: <20251007141123.3239867-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42c.google.com
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

In commit 39ec3fc0301 we fixed a bug where we were not implementing
HCR_EL2.RW as RAO/WI for CPUs where EL1 doesn't support AArch32.
However, we got the condition wrong, so we now set this bit even on
CPUs which have no AArch64 support at all.  This is wrong because the
AArch32 HCR register defines this bit as RES0.

Correct the condition we use for forcing HCR_RW to be set.

Cc: qemu-stable@nongnu.org
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3128
Fixes: 39ec3fc0301 ("target/arm: HCR_EL2.RW should be RAO/WI if EL1 doesn't support AArch32")
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20250925115723.1293233-1-peter.maydell@linaro.org
---
 target/arm/helper.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index aa730addf2f..792a47a9c50 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -3742,7 +3742,8 @@ static void do_hcr_write(CPUARMState *env, uint64_t value, uint64_t valid_mask)
     value &= valid_mask;
 
     /* RW is RAO/WI if EL1 is AArch64 only */
-    if (!cpu_isar_feature(aa64_aa32_el1, cpu)) {
+    if (arm_feature(env, ARM_FEATURE_AARCH64) &&
+        !cpu_isar_feature(aa64_aa32_el1, cpu)) {
         value |= HCR_RW;
     }
 
-- 
2.43.0


