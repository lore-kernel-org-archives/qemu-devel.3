Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FC82CCF9E2
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Oct 2025 14:32:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBwLb-00033H-2n; Thu, 23 Oct 2025 10:31:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vBwLV-0002pR-O7
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 10:31:17 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vBwLT-0001sz-Hm
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 10:31:17 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-4298a028de6so568450f8f.0
 for <qemu-devel@nongnu.org>; Thu, 23 Oct 2025 07:31:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761229873; x=1761834673; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Y/pnrcoc7cYS7GwGVqSI0sbh32hz5/hHl5ailiW8kns=;
 b=EsDjM/dYUM45rokp2gdyIcESbPlvuJPcqXQ62wMX1k/BMvH2Ek8BuQluFpAEddeJXM
 qKQpXFqf/ijupwVMmzQUYRMfTtYRaxhriVkimHeJZqTY45PzVdYJVB4Win01RiOnteBm
 Dvs9YcKn/bqDjwNXJqD+7o6+Og53huTNKLsVMxA+sEfDc+KMzJeUKV/1Mo7Nhe89L/jN
 Xt+seVhPT6bBCGd4VOF3i2RHgd4v6PPX3jXGrSilczzGNjmxvdKzvrHMmfLGnhDLJJ+I
 nres1bNI+ciWXUhHLLGt0vVOuoJWGjyDiOXVypCdxfuCxMKix7qKbW3F95WVtSQE5wcT
 Xwbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761229873; x=1761834673;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Y/pnrcoc7cYS7GwGVqSI0sbh32hz5/hHl5ailiW8kns=;
 b=MbINdYiicHpvW/Rd4g1/SUiS5qXEfv27e3VYI/ukN9CU5Siimg0AC8XLYkiasWOvf6
 BSJmv/SVXT7VtzMreIKTSqlBE3ifrAgbHQ17wW03t7LaUTSGRYjmoMnLaD5c+G73GGY0
 ixul8P9tEQCxGnsuz8l9ZJaxmAA56oGJiADKwoyEqJvZATV8o92zL8CmtC2rbiaE4g11
 00FLQ/V+WqDGyMyGduwSIJG1mofSJ8Y7B2G966bvrCC5fKbezABqHBkawXnBVE0IESDY
 01qxtoYAVXhl2kvOYkYxMAu0auvE99/3kkXQck0ltq6WQTEUEv/AAPOPRiPHyCjPwJzJ
 IiiA==
X-Gm-Message-State: AOJu0Yxszfiu08cZhr98T9PdQ0pVEaJw5x26Jn/FLPDbIxH5YTakGYEm
 dDAy4rq5wRtjCYTgdcr4Zr43/TFjCKgE5tnpT6m79+R9ptqVHCK5zTm1YLQL1KL3Mid7zkkz60r
 XSU4xahY=
X-Gm-Gg: ASbGncsOjA9W1o/GpDnlswqCfbY4UMRd2cGcv1lV6UHjVuiA5XfoD78VxLvvMd/ulNB
 IFPY1GCgfa7QYqI9uKSGuvWnkVivsOP0/KuQp7Qo/BQ9fvtTGGzGPRWSCrwpK7iZwC/lBFIJW00
 k4ZQS0kF2lxC2OGCnb91j4UEjL+YLkMNjJ1W3qlpFTruJ67CEw2m0ij1aMzEPl+AJLWuORkDzEZ
 h2eUNUgmCeCNPcElqDsYRR23PCvrCc4bOTC01Vuc7YNH1Hzrh4BD+9BdCgJMltg4YZq1EXgL9cQ
 6JS1njzTRMcj9VCaOb1UFC3+V5i3MN42AlGwf1GeBKLUZbbuKe14sdcFOYg81cCE7BuhLZATZIx
 7cR+gnT07sCbQZar0Umk7t5Q1dMRl5y7nGUm5Pt4vG7DYrE+XlDiVeNmKNhtqWv6ylBj4bCVJUu
 tJArs3hF/5UGDSZvOVIqTm5z7eWIjA2FmA632MNOMSnXw7s9BKpA==
X-Google-Smtp-Source: AGHT+IHkR8W1MvRpp609Gf74Z1yewPmxQUUgOJcQ3VVKK1u2vq1dtS5BzGk9WOf6s75DONZ03Q6q1A==
X-Received: by 2002:a05:6000:2c0f:b0:3ec:db87:ff53 with SMTP id
 ffacd0b85a97d-42853255d50mr6053232f8f.12.1761229873078; 
 Thu, 23 Oct 2025 07:31:13 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429898cc930sm5145512f8f.33.2025.10.23.07.31.12
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 23 Oct 2025 07:31:12 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mads Ynddal <mads@ynddal.dk>, Alexander Graf <agraf@csgraf.de>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Phil Dennis-Jordan <phil@philjordan.eu>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Roman Bolshakov <rbolshakov@ddn.com>, Peter Collingbourne <pcc@google.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Cameron Esfahani <dirty@apple.com>
Subject: [PATCH v2 24/58] accel/hvf: Restrict ARM specific fields of
 AccelCPUState
Date: Thu, 23 Oct 2025 16:30:45 +0200
Message-ID: <20251023143051.11195-5-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251023114638.5667-1-philmd@linaro.org>
References: <20251023114638.5667-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x430.google.com
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

Do not expose ARM specific fields to X86 implementation,
allowing to use the proper 'hv_vcpu_exit_t' type.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/system/hvf_int.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/system/hvf_int.h b/include/system/hvf_int.h
index 195d64dcf18..3d2be4092ef 100644
--- a/include/system/hvf_int.h
+++ b/include/system/hvf_int.h
@@ -59,10 +59,12 @@ extern HVFState *hvf_state;
 
 struct AccelCPUState {
     hvf_vcpuid fd;
-    void *exit;
+#ifdef __aarch64__
+    hv_vcpu_exit_t *exit;
     bool vtimer_masked;
     sigset_t unblock_ipi_mask;
     bool guest_debug_enabled;
+#endif
 };
 
 void assert_hvf_ok_impl(hv_return_t ret, const char *file, unsigned int line,
-- 
2.51.0


