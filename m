Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4EDAC36010
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Apr 2025 16:14:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u169j-0000ZJ-QX; Sat, 05 Apr 2025 12:14:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u169i-0000Yw-Eq
 for qemu-devel@nongnu.org; Sat, 05 Apr 2025 12:14:02 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u169g-0005Ft-UN
 for qemu-devel@nongnu.org; Sat, 05 Apr 2025 12:14:02 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-3913d129c1aso2085067f8f.0
 for <qemu-devel@nongnu.org>; Sat, 05 Apr 2025 09:14:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743869639; x=1744474439; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Z9hjvUeWbVz+/CYEuU3h1CcQqcFWfFRSfQhQvW00JOQ=;
 b=KauNOhoU3NgjENPgGOwYOmNnuAuOKxrR6DVF3Bq7wP9Kxg6xRTL7TlhgzLHcnNEHiZ
 zrBvdoTZ0d136NqDQmcFiIoGPuVxZHiwCMX/jhSWCwAPC9WVPUvpuSrhmD7B/tLOuifM
 U/EtWdYbT2N/ra/tKMT8kYGVulmyCOctwIF/dgvPCMIAH9GhyntKZPzKjHp6g9EuJsHQ
 j96Y6/c+yvEBBWNm+LDM4RtdG1pvAlwR0n+EuXDti5BjCqOXUmrtbu0ddP9qfZsd8UyD
 Gi5FRHo/ER1BLCzgeDKz5FIykD0wzq6gWSjfSPmjdKR9ygZI/RPwR59dZWZOu7Su5JUg
 NEyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743869639; x=1744474439;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Z9hjvUeWbVz+/CYEuU3h1CcQqcFWfFRSfQhQvW00JOQ=;
 b=tnG5OND1Vfk2NB5g+GWF03OnHRNeMETs8L570jL7VviJ5Ea5AbcOAW7ZAfna6Y/D4q
 pwRCMOsAHz6/M9XqZFtTgrs1MBRg3Le4PTCRaRfo1XYLqFFQQ73TDM+GYmeK1MVp57DU
 znaf4Yha0ip2giKE4N7Q0MyLYDEhBI/wYQR/GUriO9uN3QFMgHugf6guXUDYsr+dRJ1V
 +K6e8Q0+9150rDQjEwx1hmk6uLV5gtIwr1u/6Ks/c7kf6WjuzObIX+3hB3/6kxX9Fnat
 sX+7gOwg1kicv+ggmU2w5Qe+ebE4mSYxcqqICwRru86+yA1hLcSvnXDCKEbAbgucinLc
 LVFw==
X-Gm-Message-State: AOJu0Yy2VAUkjatrSdqijwC3Yy0xES9XwvuWV3TfmfbuWcQcCqL4qVew
 OMpViWRgeKHScc32Bh5GM2u5tw2OdlHN0EJEqzgehd4HzUgwdRlI0eWTJAAse0JxgpULviZCJEX
 7
X-Gm-Gg: ASbGncu/JwTomWsipHI/erAwuzijQJ/8Yis7byp0JzwQzdhgUbM8OcjjhbB0tLYF6Rw
 U0RN3SBbQn6OQtqmBv8X5zJ0RRa1ojCeoIo67vAotJU6dJRANsl2Zgbk7KWqQd65Agx668u8VsT
 Oi8xapnt2lF1vetEkiBPOX82vdOhNEYNv20/E89mMsn8Bqq6aWbSSGjZ3IClDeERkOOumBhUgCN
 CTdvBMQkwsWiedZaAuN9Cd1Qq6C2J5ei+ns/fiPu2thba3sRAxU8DPdCKLFSSDWV7IxvEZjMzJS
 XapL6LMKD/fk6UgLsoQyQTf8UZd1eRYCWKEQforJqXQEeAdT4lx4+s9XmYsSOZvPlZ7EZkpLkZb
 jAh1snFsei6kQOXdDClUygF2W
X-Google-Smtp-Source: AGHT+IG/lKPbzIlnGA5/oN/w99pxKhnDg+8hYH+bBNjSEZU1SbjbxP5KOYJmwMYmQMtHVi9/8kQmbg==
X-Received: by 2002:a05:6000:2511:b0:391:386d:5971 with SMTP id
 ffacd0b85a97d-39c2e6221bcmr10073915f8f.14.1743869639008; 
 Sat, 05 Apr 2025 09:13:59 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43ec1692ba4sm79368045e9.16.2025.04.05.09.13.58
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 05 Apr 2025 09:13:58 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-10.1 v4 08/16] tcg: Remove use of TCG_GUEST_DEFAULT_MO in
 tb_gen_code()
Date: Sat,  5 Apr 2025 18:13:12 +0200
Message-ID: <20250405161320.76854-9-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250405161320.76854-1-philmd@linaro.org>
References: <20250405161320.76854-1-philmd@linaro.org>
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

Use TCGCPUOps::guest_default_memory_order to set TCGContext::guest_mo.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/translate-all.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index 7467255f6e4..c007b9a1902 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -353,7 +353,7 @@ TranslationBlock *tb_gen_code(CPUState *cpu,
     tcg_ctx->tlb_dyn_max_bits = CPU_TLB_DYN_MAX_BITS;
 #endif
     tcg_ctx->insn_start_words = TARGET_INSN_START_WORDS;
-    tcg_ctx->guest_mo = TCG_GUEST_DEFAULT_MO;
+    tcg_ctx->guest_mo = cpu->cc->tcg_ops->guest_default_memory_order;
 
  restart_translate:
     trace_translate_block(tb, pc, tb->tc.ptr);
-- 
2.47.1


