Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57FD3E776EB
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Dec 2025 16:32:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vYRm9-0004RN-7H; Wed, 24 Dec 2025 11:31:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vYRla-0004Bv-Se
 for qemu-devel@nongnu.org; Wed, 24 Dec 2025 11:31:21 -0500
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vYRlX-0004uV-BF
 for qemu-devel@nongnu.org; Wed, 24 Dec 2025 11:31:14 -0500
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-64baaa754c6so6058938a12.3
 for <qemu-devel@nongnu.org>; Wed, 24 Dec 2025 08:31:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1766593866; x=1767198666; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kzv9bh9JtBfvNZpJCTUL7ZNNaQS0S4XpbiUJ0R1ZbZU=;
 b=MKbXIc4SAWItdc9/AOjeYmqIjVzTCFPfA3Ksc/E+YSRNtFRzzpaJZiAplVGk3IxtpC
 9Qtjyw8N8zYDVZuVdPIBZfnfPx+9dEuVIYye37yxqet+nZE24/BAZPD/y6dP53PaS5NF
 R3rAZak7t80f4vUkUiKogK0mDfp50hilPlUEugLORyXiPvySNPYQWFB273e/nWPoXhcm
 /h0J85KN5vCPwEWvpZ7++Hazv7SJQtr+7ojhlynwcb2wJ+eWdFb/5McN7kX9HNgR6P5i
 tj3twUlETruHa45ZZn8J2W/bJgu5XI3nX9pRTb7dia7w0EosEyzasipT2V9RXXEc783i
 ZhUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766593866; x=1767198666;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=kzv9bh9JtBfvNZpJCTUL7ZNNaQS0S4XpbiUJ0R1ZbZU=;
 b=XlkIpWct68jlZsxoKaImUmaxNAYsrreNA38PHDpLck8BEQOSKQ3wMQDXjKRL9axaRV
 XE6MOUN0f8N8nIJc4LSI53Vo0l7zVnUaXDW1Qp2hDl/Bgbu7uWb7dNkNke7kE3s22dZh
 YRiYEYaeDsI1iSWeU2/LXEkXmWIL1FFaXm+IgZY/uCo7YL1r67nDxXQU9nLE3gWAkFLf
 pfk9iJKJsG8N2l32MLE93Wh+0NdCmenZKdSYxIGyKMn0t94HeZdMvHZXTGTM+dOcVGNj
 OvNpUeGYj88CO3nSIRbomaS2O6XCdmpzdUYfx4+UIByn86kNFBWmNBX5mnjjy4X6PNy9
 NACw==
X-Gm-Message-State: AOJu0Yz40MzugaDWNX/u/WOHOaUNjsaKo0jMYMjHhoeOD+BICi/2PYAV
 R89HnBLRLrcaXgRnYmd7FcuJ8BeGrrLnjJ7lPUhRYTmpAVSUsLD60bdzARqSSJTlNN5JV+AuMVm
 TFfYR0vM=
X-Gm-Gg: AY/fxX6KtVnBIoSPrdjIRtVfWDtRplMU3qHXotd3/I67/b5AnnKuEcmBHAD1NpGSNyN
 9FpL2Qt5YMGnFAes7TF6M420mGArldQ1GV5p/drMpLnA6cG55ZGxWhbeODkddqAXuG2koKI/Sjk
 OaFsxKIHfMHDbPKgQrhYvIhSmcWlod8gnMPMyN0XRGaMUTHnER3FCMKtGpSVUDfk2hvf+SLmBF5
 NiCdIdzC6veYMnvDOqzNomYmbn0qcPLeXzNoRta9QuzHsRj9SgTfeI+2lBY+UTslgMUyFjeVnwJ
 Vk5rfr9kXX8/7SjmJrM/8G637Df97jzzctWv9wiSHA9QuDFGCC5iWLO5+l+GCxRQzCikqdv/Uh+
 kyVw0Mdy2icXNJGk14CBPRcX8/M+mQokNpxHuf5lxFJTyjA5Q8MrfozKjt665EptVKdVBWvFEup
 xbP9/8zFTL0OQY7mp7zEXSa19hGr9Cs3ZNNjXnEKc7KRQ3Gt3mgujP7Vs=
X-Google-Smtp-Source: AGHT+IGmRepuRmqKBj0m9ihszE1JfZSl8aagQMMxA4XBYWhijJQtOPvIRhLoJHrciwXxCZ5AbYo2RQ==
X-Received: by 2002:a05:6402:5107:b0:649:64d3:1554 with SMTP id
 4fb4d7f45d1cf-64b8ea5cda2mr18185880a12.15.1766593866558; 
 Wed, 24 Dec 2025 08:31:06 -0800 (PST)
Received: from localhost.localdomain (188.171.88.92.rev.sfr.net.
 [92.88.171.188]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-64b91599605sm17138144a12.23.2025.12.24.08.31.02
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 24 Dec 2025 08:31:06 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 3/3] configs/targets: Forbid TriCore to use legacy native
 endianness API
Date: Wed, 24 Dec 2025 17:30:05 +0100
Message-ID: <20251224163005.91137-4-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251224163005.91137-1-philmd@linaro.org>
References: <20251224163005.91137-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x535.google.com
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

The qemu-system-tricore binary is buildable without a single
use of the legacy "native endian" API. Unset the transitional
TARGET_USE_LEGACY_NATIVE_ENDIAN_API definition to forbid
further uses of the legacy API.

Preliminary commits allowing this final change:

 . cd08bcaa36b target/tricore: Expand TCGv type for 32-bit target
 . 8a2235dd077 target/tricore: Un-inline various helpers
 . e843ef2bbac target/tricore: Pass DisasContext as first argument
 . 4f08815467e target/tricore: Expand TCG helpers for 32-bit target
 . f30c8aa229d target/tricore: Inline tcg_gen_ld32u_tl()
 . 6b2e4fcb836 target/tricore: Declare registers as TCGv_i32
 . c558aa94211 target/tricore: Replace target_ulong -> uint32_t in op_helper.c
 . 30257dcd2b0 target/tricore: Remove unnecessary cast to target_ulong
 . 44e2b68d275 target/tricore: Remove target_ulong use in gen_addi_d()
 . a15e8996268 target/tricore: Remove target_ulong use in translate_insn() handler
 . 0d5f9542561 target/tricore: Replace target_ulong -> vaddr with tlb_fill() callees
 . 809b460f305 target/tricore: Remove target_ulong use in gen_goto_tb()

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 configs/targets/tricore-softmmu.mak | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/targets/tricore-softmmu.mak b/configs/targets/tricore-softmmu.mak
index 5e018d81068..9a9f23c7731 100644
--- a/configs/targets/tricore-softmmu.mak
+++ b/configs/targets/tricore-softmmu.mak
@@ -1,3 +1,4 @@
 TARGET_ARCH=tricore
 TARGET_LONG_BITS=32
 TARGET_NOT_USING_LEGACY_LDST_PHYS_API=y
+TARGET_NOT_USING_LEGACY_NATIVE_ENDIAN_API=y
-- 
2.52.0


