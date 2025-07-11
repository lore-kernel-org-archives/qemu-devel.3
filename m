Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23BECC83F1A
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Jul 2025 14:12:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uaERf-0007Xe-OW; Fri, 11 Jul 2025 10:09:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1uaER1-00068S-TM
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 10:09:10 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1uaER0-0005w4-56
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 10:09:07 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-748feca4a61so1370651b3a.3
 for <qemu-devel@nongnu.org>; Fri, 11 Jul 2025 07:09:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752242944; x=1752847744; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RY41nwdLIUEuN4eMuL7z1ea26x9utqEVcrLHMdIyECQ=;
 b=oRrWV9PPCZT9Y9hZjfx42BSvBbmPPA+iIAnvcmpmsOscC9td7eY6/E/tkMynbtvPcJ
 2oL+ImDipTyQzusf6Qm2rCgje+UG453zgzHflSToThq56TM+fHXLcLs+RLhu3NV2rqzR
 f2V5eWpeTeY7d2xDCvqmS/NZ8j+z2vd73BlJ6MHlKWKwoAWaobum9BmPIFQnBwLil4cL
 laH4SdoF/0Kf6+ovUEHhg3cVnhdv+iJkAJNCtFh2AY8XB8ShMKlhjALf4heLYM/40OaZ
 TT5Ssh743en+aIaPlhLIvVCQQIn8a+ptzuXYMBHpKowOqH4010X2SxdbYEW+GH0vVJF7
 3NMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752242944; x=1752847744;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RY41nwdLIUEuN4eMuL7z1ea26x9utqEVcrLHMdIyECQ=;
 b=Zj1BfjSsZO+yxD3NnrzjwvH7HAe2WKWHMxCg8Bvpwky4LbZb/8dfXKTl15a5K0QJVD
 wCAwOlA2CG4/e8MPvvwhydoiER9k1aAIiwwbh4mNG1fzHeV7cHc8MXWQBYLMwhnBhd5l
 gUwRFLtQDTwTTK6kIVhgPVulxWqzei9iGgeRtsvdb9VtcpkP/3M4qog4Zd+lnLYKX2Y2
 RRMFe7b8ZiZ5AMJqIj9O11D2ej6GpjOniswwZg8bwQXThT3Aj43IcmfqKPU4jsuDl0E3
 0pKdz/CrboJHsK50Nn6Qmp70Gjpp555W6brSePhsKj3GggA1BN4IO0ukSDj+W49N8XYa
 36zQ==
X-Gm-Message-State: AOJu0Yw/x+to83CggtQrSsGmqowQVlZbEMPzqBPkY8/GUaajrZrKqcB3
 S34cyKNANzRnFTY/05acKgq7p//oYobgbjmoQh5ADPKKmBjtRcZR8Q6QtehStDB3vccr+nkft97
 V+3VtUfQ=
X-Gm-Gg: ASbGncvnAsb44xT8OM+vKL9/NnzZcFL1T1euiIRqrSVOBwvVktPUyhZYV/wkWzITvb+
 T3jgnI3lyXpkzNGlENFuAfbk7KmSdMrI6XHfLKmwH43MxRr9RjAl40Ziv//ff2CiKBj02gTc6zQ
 rPqVI2aKlmq2nv3W+oBXOx9KwYt75PHHQxZOBN/CQZUOogxKZi3jXYcRp5JvrKy1ZeauiEJjU6I
 OXKhy4fOfu9Ab60mUXKAEw6ZxiQprsxOY6urg9T8/RHEh4og8UaEJi0ODVS67SrmiuV0cuPUxdf
 FUc9WF0hsE30c0/ryRr2TwWEzTjTE00bkIfOh4ArFWYA88e4thSB5OgOAqvUUPlkL3uOi9CeDyL
 k+Z5j1IIZGg/wijkMIifLe/Kzi1NhSEdJeLccTXZn7mXFjwu92d4LowpS1W/yD68Lyo/u
X-Google-Smtp-Source: AGHT+IH8ZORpzA6lx/BWw3xA15jQEvZDgA2Iq3DUM/lnyPg7QWao4W1c2fUvzGzRxLzSs9gXxB1l7g==
X-Received: by 2002:a05:6a20:d489:b0:223:dc82:95db with SMTP id
 adf61e73a8af0-23136e6fa2fmr5498050637.32.1752242943986; 
 Fri, 11 Jul 2025 07:09:03 -0700 (PDT)
Received: from gromero0.. (189-47-46-41.dsl.telesp.net.br. [189.47.46.41])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-74eb9dd5d3esm5702280b3a.4.2025.07.11.07.09.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Jul 2025 07:09:03 -0700 (PDT)
From: Gustavo Romero <gustavo.romero@linaro.org>
To: qemu-arm@nongnu.org, richard.henderson@linaro.org, alex.bennee@linaro.org,
 peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org,
	gustavo.romero@linaro.org
Subject: [PATCH v7 6/6] target/arm: Advertise FEAT_MEC in cpu max
Date: Fri, 11 Jul 2025 14:08:28 +0000
Message-Id: <20250711140828.1714666-7-gustavo.romero@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250711140828.1714666-1-gustavo.romero@linaro.org>
References: <20250711140828.1714666-1-gustavo.romero@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=gustavo.romero@linaro.org; helo=mail-pf1-x42f.google.com
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

Advertise FEAT_MEC in AA64MMFR3 ID register for the Arm64 cpu max as a
first step to fully support FEAT_MEC.

The FEAT_MEC is an extension to FEAT_RME that implements multiple
Memory Encryption Contexts (MEC) so the memory in a realm can be
encrypted and accessing it from the wrong encryption context is not
possible. An encryption context allow the selection of a memory
encryption engine.

At this point, no real memory encryption is supported, but software
stacks that rely on FEAT_MEC to run should work properly.

Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 docs/system/arm/emulation.rst | 3 +++
 target/arm/tcg/cpu64.c        | 1 +
 2 files changed, 4 insertions(+)

diff --git a/docs/system/arm/emulation.rst b/docs/system/arm/emulation.rst
index 1c597d8673..d207a9f266 100644
--- a/docs/system/arm/emulation.rst
+++ b/docs/system/arm/emulation.rst
@@ -89,6 +89,9 @@ the following architecture extensions:
 - FEAT_LSE (Large System Extensions)
 - FEAT_LSE2 (Large System Extensions v2)
 - FEAT_LVA (Large Virtual Address space)
+- FEAT_MEC (Memory Encryption Contexts)
+
+  * This is a register-only implementation without encryption.
 - FEAT_MixedEnd (Mixed-endian support)
 - FEAT_MixedEndEL0 (Mixed-endian support at EL0)
 - FEAT_MOPS (Standardization of memory operations)
diff --git a/target/arm/tcg/cpu64.c b/target/arm/tcg/cpu64.c
index 4eb51420ef..c54aa528c6 100644
--- a/target/arm/tcg/cpu64.c
+++ b/target/arm/tcg/cpu64.c
@@ -1250,6 +1250,7 @@ void aarch64_max_tcg_initfn(Object *obj)
     t = GET_IDREG(isar, ID_AA64MMFR3);
     t = FIELD_DP64(t, ID_AA64MMFR3, TCRX, 1);       /* FEAT_TCR2 */
     t = FIELD_DP64(t, ID_AA64MMFR3, SCTLRX, 1);     /* FEAT_SCTLR2 */
+    t = FIELD_DP64(t, ID_AA64MMFR3, MEC, 1);        /* FEAT_MEC */
     t = FIELD_DP64(t, ID_AA64MMFR3, SPEC_FPACC, 1); /* FEAT_FPACC_SPEC */
     SET_IDREG(isar, ID_AA64MMFR3, t);
 
-- 
2.34.1


