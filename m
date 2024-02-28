Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0679C47DD9
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Feb 2024 20:26:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfQUb-0007zJ-8P; Wed, 28 Feb 2024 15:25:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rfQUZ-0007yq-Qy
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 15:25:27 -0500
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rfQUX-0007M9-VB
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 15:25:27 -0500
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-299b92948a6so74154a91.3
 for <qemu-devel@nongnu.org>; Wed, 28 Feb 2024 12:25:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709151924; x=1709756724; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uYpmvWcDo9XJ8PEub2Zz6TVzblWCi4U6QK1BUlbCzJU=;
 b=ZuiSzcsiVV3QK5uuxZKUMgcV8OG6xgt/60HjQFzFp6hccCjzyV8xBW51LIaB12d1vX
 fiP8bu7BbADetVeD7mzEKXA9EZqUCu7JjXBeCVlNVMgIbEGE0Bxk+mQhy8eefBz6Sccl
 E3ic4+BYcp+BaAgplHV4zBjC3aBpae0GjSFyD9/yDAg0jWyrrhqjUlcjtEe07t7IdOWh
 X15k1qe7YgImLGZLTanlpvlEdW47S7dXmsS0QFk8HleIv9MzN1AK8IN9utzGyfsbmDD+
 opsC/W3a8cR6Vf+/Z/8PviNaOh77hQznlbpgno/1E9WzXj/L5b805Dw9+3LOfkvgwhNu
 kxqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709151924; x=1709756724;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uYpmvWcDo9XJ8PEub2Zz6TVzblWCi4U6QK1BUlbCzJU=;
 b=LJ/1kIjiiwnImNAwBFcn1Sm5+nKgZc6b3jhmwDZiaxfM7z6cc/UKN5q1qEojKvYgYy
 bjKv9IHhP+rATr2xoueOlIuIuI+nYDr/7yC7M58xaeOQSh7gDY26NIOx9NY4piwQQhUt
 Z8bsIXMN6CEOsJd8dcvtcwBXiGVHDPchMxD3jcWV4KtIwYBlLima7BUq5noGSUcmh7G9
 z4bDsJe13amGQpvrWS6NUhNpqaw3uCK1gYEAdvPqCWFhb22MZcoVdbAUwOm3BG/ZEXhV
 7KETXjBOTksnms/W5Am4BPvFn+tP5qwO+gyG9R21j7jCH8L2PcGjDRW5xM/626XOWKTg
 g/aA==
X-Gm-Message-State: AOJu0Yz/0ZadDiFYp334BqeoIfL1Con2lPkVk6cf5MKegFWcW1mKQ2pW
 o/NyomlCDGUKmlz4vno//aYNoVQ1f2IifOyXmOwsnDYaimeZtoeWPVUIKcn9+6dRCAmphqfNNVo
 E
X-Google-Smtp-Source: AGHT+IG2gks6tKbJ90ttA2XGR+baKFdv/JDAyktePlU80AHYmmIZdyEEfNK+0Rr9rJvHp8QcrP+H7A==
X-Received: by 2002:a17:90b:1c07:b0:299:4f5a:62d5 with SMTP id
 oc7-20020a17090b1c0700b002994f5a62d5mr291809pjb.18.1709151924493; 
 Wed, 28 Feb 2024 12:25:24 -0800 (PST)
Received: from stoup.. (098-147-055-211.res.spectrum.com. [98.147.55.211])
 by smtp.gmail.com with ESMTPSA id
 oh5-20020a17090b3a4500b0029ab712f648sm2118499pjb.38.2024.02.28.12.25.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Feb 2024 12:25:24 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu, richard.purdie@linuxfoundation.org, mjt@tls.msk.ru,
 iii@linux.ibm.com, Song Gao <gaosong@loongson.cn>
Subject: [PATCH v2 2/5] linux-user/loongarch64: Remove TARGET_FORCE_SHMLBA
Date: Wed, 28 Feb 2024 10:25:15 -1000
Message-Id: <20240228202518.33180-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240228202518.33180-1-richard.henderson@linaro.org>
References: <20240228202518.33180-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102d.google.com
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

The kernel abi was changed with

    commit d23b77953f5a4fbf94c05157b186aac2a247ae32
    Author: Huacai Chen <chenhuacai@kernel.org>
    Date:   Wed Jan 17 12:43:08 2024 +0800

        LoongArch: Change SHMLBA from SZ_64K to PAGE_SIZE

during the v6.8 cycle.

Reviewed-by: Song Gao <gaosong@loongson.cn>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/loongarch64/target_syscall.h | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/linux-user/loongarch64/target_syscall.h b/linux-user/loongarch64/target_syscall.h
index 8b5de52124..39f229bb9c 100644
--- a/linux-user/loongarch64/target_syscall.h
+++ b/linux-user/loongarch64/target_syscall.h
@@ -38,11 +38,4 @@ struct target_pt_regs {
 #define TARGET_MCL_FUTURE  2
 #define TARGET_MCL_ONFAULT 4
 
-#define TARGET_FORCE_SHMLBA
-
-static inline abi_ulong target_shmlba(CPULoongArchState *env)
-{
-    return 64 * KiB;
-}
-
 #endif
-- 
2.34.1


