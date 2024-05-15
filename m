Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 291D6C25B75
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2024 07:55:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s79Rx-0004Yv-V1; Wed, 15 May 2024 03:53:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s79Rv-0004Tz-HD
 for qemu-devel@nongnu.org; Wed, 15 May 2024 03:53:19 -0400
Received: from mail-lf1-x129.google.com ([2a00:1450:4864:20::129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s79Rq-0001gh-4H
 for qemu-devel@nongnu.org; Wed, 15 May 2024 03:53:18 -0400
Received: by mail-lf1-x129.google.com with SMTP id
 2adb3069b0e04-52232d0e5ceso5661761e87.0
 for <qemu-devel@nongnu.org>; Wed, 15 May 2024 00:53:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715759592; x=1716364392; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WSsZfxq/88RzELsWEja85iYyfeFnMRpyB3iR3ue9fiM=;
 b=pdzSkBZ0LYzyBr54fTxhWlgPgVSONkjLEtue0kzXyQTDQ+jmVi/Bm90H/np88nldf/
 MLZT/CFwWWXVYRneU0g7M+6KTlvqfXjl31LqZzrLl27eZVNkP1uvk+FyQAGYT850Zih/
 ZlJS86RPlTFV8ly1IF42zgG0G5oH3nofbpJLeHM7ZRyC4OySGIsEGZnd/oFXRd8C8jbb
 aH6psb/u1boMknUtwOzbgA0zAlEPhPTqvBdDBueu3kyQlvzInYpC3rH7cU/r4ZkG0euj
 HadHhGu3MKdZmimi5Amd/I9e9KYOPGzcaA0xoCXOPIMaQw6ffNGp+0o5LCaHTXsI3aNT
 YIeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715759592; x=1716364392;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WSsZfxq/88RzELsWEja85iYyfeFnMRpyB3iR3ue9fiM=;
 b=CeK1JWlyrgN+qmjCoqrSW1CAVRe7s2uEoXaUIgkBW1+PwK3WopnsA+wFvMPwse/nrX
 sUumbyxAax/Rvnc/vf4ma519uNjMgq4eCUQeTplw1480U7Ipsv8bP5EGEbSGwOpsJwD9
 olVX47bW2E387O3wMd98dZfKj+9ZljMHgY8TLlVlSCu0NZgyLQ1b1v6e7X3v5OVPz4M8
 mMQg35WUaquTFuCTyGebF7iSptdFyO11LW3oPa+GYWNo2SSMRXOypiLLuQPJX5ccTZK2
 2FVbJNBFVX4CzdW0AyEjP7sULYB9DFXwSpTjcEgg8hjJDNNtXR/Vl/NCJwpTxd5rPZWJ
 pH2w==
X-Gm-Message-State: AOJu0YwGIh752tSONPcTSAAKXDnCfXrsmAp3+uI08mivSLRLSyrZ6CDn
 z0bnwo78H1wu+ITqw/m5sAue7OusLwd1htaGDEqZWv1blJjoHQM4gcIF3At6qCjYby0zF2p3OVB
 g9mw=
X-Google-Smtp-Source: AGHT+IHAfYevWIF5gfrAkN8JVKdE0qnkv81sPd0hw/jWoJvrBX+3j6fPxbLp7+sEqoyDfcCIhpZOXQ==
X-Received: by 2002:a2e:bb8e:0:b0:2d8:df61:9c6c with SMTP id
 38308e7fff4ca-2e51ff66898mr82080741fa.20.1715759592234; 
 Wed, 15 May 2024 00:53:12 -0700 (PDT)
Received: from stoup.. ([149.14.240.163]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-41fccee9292sm222611855e9.37.2024.05.15.00.53.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 May 2024 00:53:12 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 33/34] accel/tcg: Remove cpu_ldsb_code / cpu_ldsw_code
Date: Wed, 15 May 2024 09:52:46 +0200
Message-Id: <20240515075247.68024-34-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240515075247.68024-1-richard.henderson@linaro.org>
References: <20240515075247.68024-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::129;
 envelope-from=richard.henderson@linaro.org; helo=mail-lf1-x129.google.com
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Previous commits replaced them by translator_ld* calls.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-Id: <20240405131532.40913-1-philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/cpu_ldst.h | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/include/exec/cpu_ldst.h b/include/exec/cpu_ldst.h
index 11ba3778ba..71009f84f5 100644
--- a/include/exec/cpu_ldst.h
+++ b/include/exec/cpu_ldst.h
@@ -355,16 +355,6 @@ uint32_t cpu_lduw_code(CPUArchState *env, abi_ptr addr);
 uint32_t cpu_ldl_code(CPUArchState *env, abi_ptr addr);
 uint64_t cpu_ldq_code(CPUArchState *env, abi_ptr addr);
 
-static inline int cpu_ldsb_code(CPUArchState *env, abi_ptr addr)
-{
-    return (int8_t)cpu_ldub_code(env, addr);
-}
-
-static inline int cpu_ldsw_code(CPUArchState *env, abi_ptr addr)
-{
-    return (int16_t)cpu_lduw_code(env, addr);
-}
-
 /**
  * tlb_vaddr_to_host:
  * @env: CPUArchState
-- 
2.34.1


