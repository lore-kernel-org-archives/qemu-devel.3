Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE524C021AA
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2025 19:33:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tk6pn-0002vm-OC; Mon, 17 Feb 2025 14:31:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tk6pA-0001zN-UX
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 14:30:44 -0500
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tk6p6-0008Qq-CN
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 14:30:36 -0500
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-2fc32756139so4467831a91.1
 for <qemu-devel@nongnu.org>; Mon, 17 Feb 2025 11:30:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739820630; x=1740425430; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fAxPDj0myQVPp6aikkb7gZtJzw/Id1WCci49i4T0v4I=;
 b=GeXO26s8uJhbbhZSp3x+v8iU+EBwRbUQSZmng7epZ/3OgIKmYymvrcT+QPuvZdg08z
 WSI0saCze5buXYI6CtAJewLhKQ+0GCj+WJLLk70hr+ODfDaQmNgZiexY0mStOkT/5Hlr
 mWZpYcOsE8pDaasFT32VKHxqsrbv1/YMjBXzyy7y1VuNJR6pFI9UgioRBIMngDvhIFZS
 8xlKmbKbKtaiIL4WDDumvLp56o/kI/9lX520VIgamzwszPTmgLymzF9PeqGpRmpij23x
 qSB9JrwIErW0jyuypmQPUG9ZAnElt6kMSqW58eYvsa1V4rPoOGKCRY8EJ30O+DbpdCzF
 RISA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739820630; x=1740425430;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fAxPDj0myQVPp6aikkb7gZtJzw/Id1WCci49i4T0v4I=;
 b=sOf5sw8xbwCu6bKqjqXLzujPqZxEHc4gMhyOz6tYL9eJLZfHZYHNZ/WbPWGMqg4rVn
 bMEhKiVoVHISPbfwWSJyre1gARjUrNI4lss6UjUB4QDhF3rZnnzH0NI6OTr9gkvJtmTx
 vDpPI7c5gYw6yZpGnGFsHBC7EYmOh+iFrDQJ7qk8YHQRtPOsUembT8xRrN/G8tuD+Dxb
 cMqZ/UR5Z+ih/rRE6DfFlcjzgYnMdLwqnj/vCvTX8FkmSy2nL7B1ps001ngewoq/0G00
 EuuLmnqtz7try9oBq03hnriP2ENG7eqocUJgD2i+4O030xx8Zns4+K9RD26y5CCOg8Ny
 xPIw==
X-Gm-Message-State: AOJu0Yx/ZToo4bGetZTnfkKQQeD0NZxX6GBxWT9AOVwgwakFhYeYzbX/
 0291r4YzBIEIOI8chjY/RwXw5OOe2jnPGgIIeFFx6mjfdzII5S4pNKT5AY70V1x+Q3uY2HVmDsN
 +
X-Gm-Gg: ASbGncuUiFfHM187zlSdpXDxs/trNNgz84tQ9iCR5DzxUK/u8XzjjVKOHipqPDgFu1Z
 EQ+7s61F5bke8IH6wy0PR1yO7M/aaSzzaXN23tzAXx9l5icH132QaO7m5itzHY1dOPodjrHfoAk
 H4h1kjrlERyfy4tQ6W+M3qJhsR4Pi1Z3dJgJWI0EfkJ9n/R5hWp2uyj5d1utpEljG7e9ZfC9NNn
 wcoPsZBwQZGenJ3dcvFL5rcDeBudeU9niUQ3szyuPnUoDdXT1RM/3tMAh2cYzN0FRIz7/9t8DNo
 7azUH0lhsHPS63fIxn/HjTxYMJtQjk6/9blr/1lJdoEVHSE=
X-Google-Smtp-Source: AGHT+IFOJme4EDaf3qGSdffzK2Gk/xlW8pCGzRgLsNWPNc4qdtPVhp58YS3Okv4G852zwheljegutQ==
X-Received: by 2002:a05:6a00:139d:b0:730:87b2:e839 with SMTP id
 d2e1a72fcca58-732618f564cmr18316945b3a.21.1739820629737; 
 Mon, 17 Feb 2025 11:30:29 -0800 (PST)
Received: from stoup.. (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7326a38ff76sm4347164b3a.160.2025.02.17.11.30.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Feb 2025 11:30:29 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mikael Szreder <git@miszr.win>, qemu-stable@nongnu.org,
 Artyom Tarasenko <atar4qemu@gmail.com>
Subject: [PULL v2 23/27] target/sparc: Fix register selection for all F*TOx
 and FxTO* instructions
Date: Mon, 17 Feb 2025 11:30:04 -0800
Message-ID: <20250217193009.2873875-24-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250217193009.2873875-1-richard.henderson@linaro.org>
References: <20250217193009.2873875-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1034;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1034.google.com
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

From: Mikael Szreder <git@miszr.win>

A bug was introduced in commit 0bba7572d40d which causes the fdtox
and fqtox instructions to incorrectly select the destination registers.
More information and a test program can be found in issue #2802.

Cc: qemu-stable@nongnu.org
Fixes: 0bba7572d40d ("target/sparc: Perform DFPREG/QFPREG in decodetree")
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2802
Signed-off-by: Mikael Szreder <git@miszr.win>
Acked-by: Artyom Tarasenko <atar4qemu@gmail.com>
[rth: Squash patches together, since the second fixes a typo in the first.]
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20250205090333.19626-3-git@miszr.win>
---
 target/sparc/insns.decode | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/target/sparc/insns.decode b/target/sparc/insns.decode
index 989c20b44a..cfcdf6690e 100644
--- a/target/sparc/insns.decode
+++ b/target/sparc/insns.decode
@@ -321,12 +321,12 @@ FdMULq      10 ..... 110100 ..... 0 0110 1110 .....        @q_d_d
 FNHADDs     10 ..... 110100 ..... 0 0111 0001 .....        @r_r_r
 FNHADDd     10 ..... 110100 ..... 0 0111 0010 .....        @d_d_d
 FNsMULd     10 ..... 110100 ..... 0 0111 1001 .....        @d_r_r
-FsTOx       10 ..... 110100 00000 0 1000 0001 .....        @r_r2
-FdTOx       10 ..... 110100 00000 0 1000 0010 .....        @r_d2
-FqTOx       10 ..... 110100 00000 0 1000 0011 .....        @r_q2
-FxTOs       10 ..... 110100 00000 0 1000 0100 .....        @r_r2
-FxTOd       10 ..... 110100 00000 0 1000 1000 .....        @d_r2
-FxTOq       10 ..... 110100 00000 0 1000 1100 .....        @q_r2
+FsTOx       10 ..... 110100 00000 0 1000 0001 .....        @d_r2
+FdTOx       10 ..... 110100 00000 0 1000 0010 .....        @d_d2
+FqTOx       10 ..... 110100 00000 0 1000 0011 .....        @d_q2
+FxTOs       10 ..... 110100 00000 0 1000 0100 .....        @r_d2
+FxTOd       10 ..... 110100 00000 0 1000 1000 .....        @d_d2
+FxTOq       10 ..... 110100 00000 0 1000 1100 .....        @q_d2
 FiTOs       10 ..... 110100 00000 0 1100 0100 .....        @r_r2
 FdTOs       10 ..... 110100 00000 0 1100 0110 .....        @r_d2
 FqTOs       10 ..... 110100 00000 0 1100 0111 .....        @r_q2
-- 
2.43.0


