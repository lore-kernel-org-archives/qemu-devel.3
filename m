Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 297A7EE6B68
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Feb 2026 21:47:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1voTfA-0006KG-K2; Fri, 06 Feb 2026 16:46:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1voTeS-0005lF-8I
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 16:46:13 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1voTeP-0002ei-Mp
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 16:46:07 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4801c2fae63so20885715e9.2
 for <qemu-devel@nongnu.org>; Fri, 06 Feb 2026 13:46:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770414363; x=1771019163; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=olXwdv5oIdZcMfLqS+iBjKe3scvUkkqJWymOZuycPTQ=;
 b=pbfCF8DWBIlgsAKAYKvLHhtGLoCHjyTriCYyEl4M5vWEa9KtSodniIC43+ElZwHT/e
 brjoLEXanAVwp2x6w9TmUdul6N7buY5B21EYhFh5UJU8JyBhH0sfh5JVdS7c4d6CeDOh
 Bh4n45bPD7ANFSGRpkgutCicNJGbKLcaRGxLqPnxNRIT32npkEGbVeER9vRcqETJ4RUJ
 yOY/PSUrx9CpUzQqWy1/tCQCVBBjTPy6Gy9SlJFRHBguk1aiUtXW/zZI67oNGQ0jVoyC
 GADf7iEPAxVKPt9iaHmhY9Uix0n+jAkp2S+ksEvp4mTfeZjwOLYTynb4g2GkSumq2PO7
 gpHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770414363; x=1771019163;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=olXwdv5oIdZcMfLqS+iBjKe3scvUkkqJWymOZuycPTQ=;
 b=Xa6iNRh1qJaYfdzzRTipUVtJ2pA9CKd0onQ2xUqENECbgQ/WTVKYLLipWLUj2UA7Ab
 HTwfz7fsQi7Vzx97TsEHli4wzFamN4cSqo/nEA13GGrUPUJnwgK8rznVy9x4XMcXLUgD
 BSl6Wm3NBvSUJ9q/EAAmUcezzxujDkDhgJ8nZVX0/9Od0GcFc8MJdaoQDzsaur+unzI9
 s7xNtXfCwU3PTFI6zff6UpkdnwZY4UURH7Tkv4+qfYoo33IKHmYIzeieGoosXncptxBf
 M5wKZ220pndtC3kxaXJwnuEVwk6o2HGUd7XgMPLEoc6sTV38Wb6LDfys7yKUFz2SiP5q
 5LzA==
X-Gm-Message-State: AOJu0YxQywRHdO+slSSSSIZ0/bmsWeIopwz1IA5AJuYiD6ov5bmags9C
 E3Z/nilkWHn56GCq/SCKa/XdAtwiR7eL46AaaDGvdl5Jke8nVKqKj2MkcGKOa3avsbhO8KQbg5M
 YQvLVzFE=
X-Gm-Gg: AZuq6aIxPb+4++jumKXWk+TxjXrjCIG+4xioWjTiDCJgyI+KwVlvM4GfZJOJQFXFmGT
 JA5vzD2Nrb38UKaVXmHbHiIjGQQNOVWbH9l1aCC+LOjHIk2YtWUBFGqTG2DfLF5ycW4oIcZStZs
 0OHkzqzLWJgFlj9q9iTXiS45PiHkdpcnvPnpHYBwsrn67T/Nv/qXxgH83H6keoE5ajqvqv0M1A5
 NFj9nk13BjLx2CAQZwbkt4dwCn73id+Rbae49cBSBMghvMsx8B2qm/34xlyRZDDBtT72XH9Zkpw
 1ChrzA4Wc9dT+8YuMnF+FMkgBqJpae4Gcrcv7XyIMq/raaBWF2GsOBf8nZ2IJvjmfOgJ1TO15rl
 S1F3c97IpEV32HpmCIaM41xNsUR00RntZbHooSLCZt8JHY8cZQa27X2nGgOuLT3+xXJWxRlubo0
 TErqZuAXq7pIhUF1P00oA6ec2sn5RhYzg5HtT7A93KGp7I8YDblfIg/COVjZxJ
X-Received: by 2002:a05:6000:40e1:b0:42f:9f18:8f40 with SMTP id
 ffacd0b85a97d-4362938d4e9mr7169215f8f.42.1770414363373; 
 Fri, 06 Feb 2026 13:46:03 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-436296bd3b8sm8519472f8f.11.2026.02.06.13.46.01
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 06 Feb 2026 13:46:02 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org
Subject: [PULL 11/30] target/s390x: Expand tcg_global_mem_new() ->
 tcg_global_mem_new_i64()
Date: Fri,  6 Feb 2026 22:44:29 +0100
Message-ID: <20260206214448.22008-12-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260206214448.22008-1-philmd@linaro.org>
References: <20260206214448.22008-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

The s390x target is a 64-bit one, so tcg_global_mem_new()
expands to tcg_global_mem_new_i64(). Use the latter which
is more explicit.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20260206181953.18683-11-philmd@linaro.org>
---
 target/s390x/tcg/translate.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/target/s390x/tcg/translate.c b/target/s390x/tcg/translate.c
index 4dabd49840f..203afe265bc 100644
--- a/target/s390x/tcg/translate.c
+++ b/target/s390x/tcg/translate.c
@@ -217,9 +217,9 @@ void s390x_translate_init(void)
 
     for (i = 0; i < 16; i++) {
         snprintf(cpu_reg_names[i], sizeof(cpu_reg_names[0]), "r%d", i);
-        regs[i] = tcg_global_mem_new(tcg_env,
-                                     offsetof(CPUS390XState, regs[i]),
-                                     cpu_reg_names[i]);
+        regs[i] = tcg_global_mem_new_i64(tcg_env,
+                                         offsetof(CPUS390XState, regs[i]),
+                                         cpu_reg_names[i]);
     }
 }
 
-- 
2.52.0


