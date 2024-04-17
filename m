Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82888C05023
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Apr 2024 18:31:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rxA27-0001dB-03; Wed, 17 Apr 2024 14:29:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rxA25-0001SU-0Z
 for qemu-devel@nongnu.org; Wed, 17 Apr 2024 14:29:21 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rxA23-0003Ux-9w
 for qemu-devel@nongnu.org; Wed, 17 Apr 2024 14:29:20 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-349bf9d46acso9458f8f.0
 for <qemu-devel@nongnu.org>; Wed, 17 Apr 2024 11:29:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713378557; x=1713983357; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BDiTP7Q6dFZYOkY6r7oVGOIMgGCIl+1MkIYW9OY8XIA=;
 b=Mdk9NDTJe5ZbwsNZdy2qbPNLf3k1exmlldwxWzD+qbnGOavgjw8xRvA1Y+/01NOfbV
 yXELn2DNLTDLkzr2H51bRn4YqjkyAARQnhGYfzRev0ZTAcaOpn76/U2Fs8Lrri/n+MLW
 5tl0QbPVpaKYVM5XT7L0WTNHm9HC96IGddZfsHtiqD/ESw5cuFYSUP8cAtmfHHKpbpVq
 njl6tyAjM/N6HIZCdyo87o1Oe8yzW45WWjh4TRDWmui6FMlzDHsckNfS3r86LD0NARQP
 qxvHn1D2rllhc6GR5c6Z5rXoXBM+6e+R0PN0lAzzimaKrGf2UlMUyY71Z7AiZpKCYkE/
 HZug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713378557; x=1713983357;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BDiTP7Q6dFZYOkY6r7oVGOIMgGCIl+1MkIYW9OY8XIA=;
 b=lfY1Aiv3/JBGpiXnS+7ROyg3uCBuis3EU8Km8UzRxgpKcWKiG9ygWO/KsrAEgOZewg
 dHJXYhNNtHf6EuXRnpNNJoHNPtnSKhbC/GDduAiYGARqyMp8i+c4uLaFLV/3GpTwve6J
 6Cq/RmEjJftGE5ZxFvyZMUCM/hP9V+rfMqjmjHVMAE/+b0qDqqmrqXbuxF1lNrvlb8z9
 mxSfHVSsv3UQ16LUrixVNixHmzdD+uoie4zYHgfvitFZ1CW94ovIyGEg9/j/02dE1+M1
 rehIjaG+/JyoBDLXndUSfHM6oWgYiEYCFYsuwAepkn+BsiTXKtoe1dkT313WRpywZm9z
 bAcQ==
X-Gm-Message-State: AOJu0YxoOnIWqRucVyV8ZaLOCm+TFXLMwFDO1oMsiCZWpWEOznl8qJGD
 /Ft8cPbPQ4f0mB3jKzpEVl4ZhwCyp7CB3hli1YoOqbIMHEEtTLV6Wz3DJIcIbt9CH0Vu0q9/QiS
 y
X-Google-Smtp-Source: AGHT+IFkIjallhak8M77d6SMHOZVlfBgkxUnprEAraIcG9nxgOvsZfPmYn2S7YxiZaCtOHhhyYM6og==
X-Received: by 2002:a5d:684c:0:b0:345:f08b:a7cb with SMTP id
 o12-20020a5d684c000000b00345f08ba7cbmr109034wrw.4.1713378557303; 
 Wed, 17 Apr 2024 11:29:17 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.201.23])
 by smtp.gmail.com with ESMTPSA id
 d15-20020adffbcf000000b0034720354152sm14559964wrs.117.2024.04.17.11.29.16
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 17 Apr 2024 11:29:16 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Nicholas Piggin <npiggin@gmail.com>, Thomas Huth <thuth@redhat.com>
Subject: [PATCH 12/21] target/ppc/excp_helper: Avoid 'abi_ptr' in system
 emulation
Date: Wed, 17 Apr 2024 20:27:57 +0200
Message-ID: <20240417182806.69446-13-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240417182806.69446-1-philmd@linaro.org>
References: <20240417182806.69446-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42c.google.com
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

'abi_ptr' is a user specific type. The system emulation
equivalent is 'target_ulong'. Use it in ppc_ldl_code()
to emphasis this is not an user emulation function.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Acked-by: Nicholas Piggin <npiggin@gmail.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20231211212003.21686-18-philmd@linaro.org>
---
 target/ppc/excp_helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
index 674c05a2ce..0712098cf7 100644
--- a/target/ppc/excp_helper.c
+++ b/target/ppc/excp_helper.c
@@ -142,7 +142,7 @@ static inline bool insn_need_byteswap(CPUArchState *env)
     return !!(env->msr & ((target_ulong)1 << MSR_LE));
 }
 
-static uint32_t ppc_ldl_code(CPUArchState *env, abi_ptr addr)
+static uint32_t ppc_ldl_code(CPUArchState *env, target_ulong addr)
 {
     uint32_t insn = cpu_ldl_code(env, addr);
 
-- 
2.41.0


