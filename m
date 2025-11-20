Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF73ECFA442
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Nov 2025 20:21:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vMB8D-0004Z2-18; Thu, 20 Nov 2025 15:19:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vMB8B-0004Ym-Jf
 for qemu-devel@nongnu.org; Thu, 20 Nov 2025 15:19:51 -0500
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vMB8A-0001SF-4I
 for qemu-devel@nongnu.org; Thu, 20 Nov 2025 15:19:51 -0500
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-42b3ac40ae4so768126f8f.0
 for <qemu-devel@nongnu.org>; Thu, 20 Nov 2025 12:19:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763669988; x=1764274788; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=q/LNyvQG4XVC2EIShm261QCUAXye4D5qWj6DTyVXrjE=;
 b=sKXOb2CQP/kMP29zBTw2ayPS7zuEeFsQCpRJOlnu+Gzobbd2IDkudbb5MtDlEVPtup
 8nRmbfFFJsGs7QJRo7gz5SolDfc6kQ+A1HenX3NEYKN0oJ1gbSGL1fkifhv5OJ/VibwU
 e/3bn90Ob9SOLmh1+EhJpZ8EImWfrlQsq75W4PM6xEHJk0ekL70hNogNwaQMNUrS4fRt
 EACc1mwuFcDdOcrRbZRTFU9gMJ4KRVt7z3HLjhsghYh/v5/eXkNX/i0aQNEzBVhLXQEl
 3vpl86EXdNq38XEB8de4YlEfCBIPvlBjsezM0C0GzJ92r+mvQHCHhh1poM1mXI8y0zmq
 pqYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763669988; x=1764274788;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=q/LNyvQG4XVC2EIShm261QCUAXye4D5qWj6DTyVXrjE=;
 b=WEZBPwmnmreQREq4kLcENRIIf0VMGU7q6b7y755zEpu/NT96/5NMBvD1Ax7AMfLcWk
 dLTjOGCCqsD49MJF/2cEXPiTn6EOK+jRcUnodVbcGnUCg59GNQ+DgWdFIsql9QLba5ZG
 AfT/NfVGmZ8bFhYeeK8tHoNvyydM+zQ5RKglH1TuYebjpcgcWtMOHdgHzu2tdMEkF4IZ
 2V7USsmkCmfY2Fe+2+GKv5PMuKG4ZMAcx7bZwM3zl4fUO75WnQmOooE5hWNx1SfxZtON
 ormIzivoeMr83w2ViIaE+Iq5Vpvtl1V541SAzk7H7+vRAYc4CpmOzvprOTHvNKFyVRTO
 2S8A==
X-Gm-Message-State: AOJu0YwJuglSMwggm2fLWY/DQUQxYB67AxEkCOyceknAcjUYhNTNfp/i
 sZaTLBtdzb4hZXeM+C7wlHw1dDPyGUxdBx0J7rtPmp9t8qWdzPuaa45P0A8GBGd3JjGSdEMo2aC
 5d9VDdzPSCw==
X-Gm-Gg: ASbGnctFTwtiUayyrBi5CgN3Bpte/7ZQhZYIO7z0+pEAV9yGSrHwvoY6PHx9+TOwwE6
 YCBUkZAEuw+vf8pD+TEq1kY0pdgIGHHUO123Bp2RZjWQRR2DFh/8Gwo+9SDWbXkE3v512ORgFF2
 otzOq77gsQ6gtBcinIeLWTVxvEUdx4sWRqatqzYMyuWE5vkA3HqrsHXCUUM9glFETGMDAIW7lGy
 qzAURLMvKXEDToPO9iELvJ4I5blKRioNPuGcHZBEAk6sj/KgbroGiUzZQheqtADXncMRZlWu80E
 6DZRu6pURxkHVFyLPgLmsUEDWMYgGT/H/5thJvlylbOpsacnHPfsmQXjorAIpkoroYuLIrP3L1M
 x9pt1dqe9dY4ByGWlTqnweWFO5nwH2kQV5ju+i8ByE9ho1lPKnqorald2GGI+N3X6cPNFJ77MA8
 sk57+7rP1Ezcl1CMm6kNrU4Pce+4ez4K28tMd+k2lEa/u3YVFHBvYdbLWbRvBpRhqoRM5EOxc=
X-Google-Smtp-Source: AGHT+IHNm0Ov85ZZjxC6qaQbM+Z4H/+3Mwo7o8+ziOUz1rk3t3p1iYi37H7Pd6vy5hz/qcp3g58O9A==
X-Received: by 2002:a05:6000:2408:b0:42b:396e:2816 with SMTP id
 ffacd0b85a97d-42cb99f5613mr4430094f8f.17.1763669988372; 
 Thu, 20 Nov 2025 12:19:48 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42cb7f34ff3sm7790179f8f.16.2025.11.20.12.19.47
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 20 Nov 2025 12:19:47 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
Subject: [RFC-PATCH-for-11.0 v2 4/8] target/sparc: Use big-endian variant of
 cpu_ldl_code()
Date: Thu, 20 Nov 2025 21:19:15 +0100
Message-ID: <20251120201919.8460-5-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251120201919.8460-1-philmd@linaro.org>
References: <20251120201919.8460-1-philmd@linaro.org>
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

SPARC instructions are always stored in big-endian order.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/sparc/int32_helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/sparc/int32_helper.c b/target/sparc/int32_helper.c
index b29f693a6bf..a777d17a01c 100644
--- a/target/sparc/int32_helper.c
+++ b/target/sparc/int32_helper.c
@@ -151,7 +151,7 @@ void sparc_cpu_do_interrupt(CPUState *cs)
         if (!env->fsr_qne) {
             env->fsr_qne = FSR_QNE;
             env->fq.s.addr = env->pc;
-            env->fq.s.insn = cpu_ldl_code(env, env->pc);
+            env->fq.s.insn = cpu_ldl_be_code(env, env->pc);
         }
         env->pc = env->npc;
         env->npc = env->npc + 4;
-- 
2.51.0


