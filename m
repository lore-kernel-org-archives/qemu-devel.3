Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6B58C77B7C
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 15:32:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWwt0-00013q-8N; Wed, 02 Jul 2025 08:48:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uWwnN-0000Ld-77
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 08:42:37 -0400
Received: from mail-ot1-x329.google.com ([2607:f8b0:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uWwn9-0003IH-Co
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 08:42:35 -0400
Received: by mail-ot1-x329.google.com with SMTP id
 46e09a7af769-72c13802133so1423955a34.3
 for <qemu-devel@nongnu.org>; Wed, 02 Jul 2025 05:42:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751460139; x=1752064939; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+pcEKhLD1jUxjhqTr1gUWbnGTIFkPwi63qGCrUKFPSI=;
 b=SHl1jUpczbfa54J/v3KlknItvUIGjdNKKoqOTM2uxQBYwtZQLILBQocLBk3NOHKJ0N
 d4gjiyRwkS4lcBDS3+O5uvUj+KQ0ay60G4T5VyyK8M3FTqblMItdUhoZmGbppjBlUcJH
 dcdJzK69tqVH7H/ORSxjF4kgYfYKMOladeduSn+djFt9yinS6CxJ0l8ig8yIXvQDGdIo
 q2UKA6bBDQxwtg6o5Bim3RUyuJU3srsj6aO8QjXCg6qONXFlbeCPsbZ+W4sBdBxcIcl1
 LW1IssQlbGLp2fUBq2HAQTtXljSacX1Q1BFExZ6Ff09LwxE7qXsMe94PA+aebOm1sl8H
 LzTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751460139; x=1752064939;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+pcEKhLD1jUxjhqTr1gUWbnGTIFkPwi63qGCrUKFPSI=;
 b=qX1317GhqVvqR+TN06b6GiTnE1vjAFjM9g7sWrwSfEieWCf3DmdHuLB62XtJjKBA+p
 Tx/4CCCQSb+5S6cuFqmUZbJan9rVdBcLVQoEbP0V0nsEa8S6usPAuQm5/VqxgLN1Eq1S
 6difDXmU+VAtF/b7Vr/ODqz626foxJHUt4nfkjE2e1jUq0mXhP586Ze9wK1jURh4AVsI
 1yKUGcvsmg59qJoEyrzCQrKzOJ6x/MuWh8s5TBvwgTiCroNsiMhlakw9Qh57N5hBKod2
 yUUgd6lDMCJQ9BJYq77M2/r7Fok1TQOwfSTXilwvI4+e2/+NzYHXijWjeCytNUfj2ujM
 aksQ==
X-Gm-Message-State: AOJu0Yx2NieTt7qYXxoCqf5nd8uwIpi13BIYSS1TJQNQsBFSyIadbN7a
 YYY/l5jtwqre6aZHtxbyPkl/bzR1cBDw7CZumVFOQrTlu8/eDne5oyumhHRUQHd0fj5/0szj67W
 6hptx2EY=
X-Gm-Gg: ASbGnctrdJV3DYZRbcVtxhyK3KUaXtTHQfjD3Sq8Ca6VAK+sSQGVX5JAYIgVd+8iq54
 jPs1k2K9wGKXihQ4IZegkqPtbfLtL6zfvnsj0th27lX5VSnZEFcYC2KvgPmbEA1XVeELIikeGrC
 EP7yuiBupgFey2KMZNDrO/usoxUUMntPsIcmApcKj2kagEQKUjbM61xhY8ThOLyifkEDA04hlE7
 8Md2fj6Yg39OtbJ3rfaGtskHY7SS3kObJTCbnGk6w8AzkRjWX84Tj4h9YIhpLmlefVNlCKeCpkC
 9q0d8CRC6aZFjyWE8SIrTe6NqN5fhP2IhJEnGdiNBgqDQqoILESPbpRQh2WaWAazzdSgZg==
X-Google-Smtp-Source: AGHT+IFqQ5XcP9FWlH0WxVxq48WhayUa27GzwXS8hjsgjbFNG0aqfmznMLNy0R5+VqSy36met1QEbQ==
X-Received: by 2002:a05:6830:498c:b0:73a:70a9:d5aa with SMTP id
 46e09a7af769-73b4cc08d6dmr2186220a34.16.1751460139362; 
 Wed, 02 Jul 2025 05:42:19 -0700 (PDT)
Received: from stoup.. ([187.210.107.185]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2efd50f7d89sm3907004fac.34.2025.07.02.05.42.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Jul 2025 05:42:18 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	peter.maydell@linaro.org
Subject: [PATCH v3 96/97] linux-user/aarch64: Set hwcap bits for SME2p1/SVE2p1
Date: Wed,  2 Jul 2025 06:34:09 -0600
Message-ID: <20250702123410.761208-97-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250702123410.761208-1-richard.henderson@linaro.org>
References: <20250702123410.761208-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::329;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x329.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/elfload.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 2add1665c7..ea214105ff 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -915,6 +915,14 @@ uint64_t get_elf_hwcap2(void)
     GET_FEATURE_ID(aa64_sme_fa64, ARM_HWCAP2_A64_SME_FA64);
     GET_FEATURE_ID(aa64_hbc, ARM_HWCAP2_A64_HBC);
     GET_FEATURE_ID(aa64_mops, ARM_HWCAP2_A64_MOPS);
+    GET_FEATURE_ID(aa64_sve2p1, ARM_HWCAP2_A64_SVE2P1);
+    GET_FEATURE_ID(aa64_sme2, (ARM_HWCAP2_A64_SME2 |
+                               ARM_HWCAP2_A64_SME_I16I32 |
+                               ARM_HWCAP2_A64_SME_BI32I32));
+    GET_FEATURE_ID(aa64_sme2p1, ARM_HWCAP2_A64_SME2P1);
+    GET_FEATURE_ID(aa64_sme_b16b16, ARM_HWCAP2_A64_SME_B16B16);
+    GET_FEATURE_ID(aa64_sme_f16f16, ARM_HWCAP2_A64_SME_F16F16);
+    GET_FEATURE_ID(aa64_sve_b16b16, ARM_HWCAP2_A64_SVE_B16B16);
 
     return hwcaps;
 }
-- 
2.43.0


