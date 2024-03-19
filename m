Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A75BCD11C2
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Mar 2024 15:45:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmbcT-0005Eb-0A; Tue, 19 Mar 2024 11:43:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rmbcR-0005D8-8p
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 11:43:15 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rmbcK-0004lW-DY
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 11:43:14 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-414617882b3so10515805e9.3
 for <qemu-devel@nongnu.org>; Tue, 19 Mar 2024 08:43:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710862986; x=1711467786; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UuEAK7pSccwrCzu7hxaK2/2f3QdH4s+KeUETWrTDkmI=;
 b=HwRJUTyvxHIoyfcsI9rTdFZUKEObmCEulrwneWFcy8lKikqBS3H2bgpP9xEAijpsjo
 G/3sLRDVKMFhVzSCChyfLxIJFiLnIosR/gJQai42DfiArhp+3pe9dcNpMXsGP2y753bH
 2484zeTOLVLqnXQ3fwBZ1cH1ZmbgqbO8FqRW2+D99i2nzPN5CuqdrqiWOVEsdy20b7m9
 yrsXwSe7VKQH1hMobtNXc4FZIDItsXgS//Oq3P2o4n1KKFG939e4/tE/rEl/dnmy2VFz
 ejV5pBW0tleLZl7WgHPAkieyQthuZL1W5jKE3dLbJSmfvjK3mCNDU4fxYfkE2bi5GVCD
 aDnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710862986; x=1711467786;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UuEAK7pSccwrCzu7hxaK2/2f3QdH4s+KeUETWrTDkmI=;
 b=tXZO6XEV7clEk4Uypcr/CzWxQGY2igYDwgPpC5juoCxO8izDLIYV7ivwq7BN9VfFCX
 8NtccC3JsX3LAJ59UcHB4CFU1Ms4VPGiDtCpw663/HI3mUVtQBN0xjflSvlSEZsb25aG
 a0ymEK887k8ZlCS3Kru5JqUm30T/Xtmjjv67wZ0UVmT1Xoc8F02SH7/DO0HaJ1qarNAo
 QCFdnDoJx9WUdRSPltMKBH4nmPipEf9FGL5Q2QpIR6wfZ5UZJJPphy8iZAz/55J0HaPD
 2GajDUuemkZ+sCmhvo8o2Ecm4LCkjfU+13DlQ2Heh2SRh4sG2GaKlBfbhS16HtFzvnA/
 nsKQ==
X-Gm-Message-State: AOJu0YztaGB90nrKhnyP2szBzaTTvr3J9FO85G0utteag1fDmifV2ntf
 aOaDzZuKuvOhn+3d/r0TxtQUjMxaJfg3Iovs3n4bKBu55BiqpLfSlR9Uk2VHrPnt+Zihgpk8utL
 E
X-Google-Smtp-Source: AGHT+IEwjXyq1lx/4wp5+SvJ69Rn1Jf0HcOxQkPwDffs0fSluS4MDfEEylCe6pbiQlunyuQa1ieLzA==
X-Received: by 2002:a05:600c:a47:b0:414:860:bdc9 with SMTP id
 c7-20020a05600c0a4700b004140860bdc9mr6982443wmq.33.1710862986594; 
 Tue, 19 Mar 2024 08:43:06 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.166.129])
 by smtp.gmail.com with ESMTPSA id
 l12-20020a05600c4f0c00b0041409d4841dsm10415982wmq.33.2024.03.19.08.43.05
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 19 Mar 2024 08:43:06 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 qemu-ppc@nongnu.org, qemu-arm@nongnu.org, qemu-riscv@nongnu.org,
 Anton Johansson <anjo@rev.ng>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH-for-9.1 01/27] accel/tcg: Ensure frontends define
 restore_state_to_opc handler
Date: Tue, 19 Mar 2024 16:42:30 +0100
Message-ID: <20240319154258.71206-2-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240319154258.71206-1-philmd@linaro.org>
References: <20240319154258.71206-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 accel/tcg/cpu-exec.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index 5c70748060..987e6164f7 100644
--- a/accel/tcg/cpu-exec.c
+++ b/accel/tcg/cpu-exec.c
@@ -1069,7 +1069,10 @@ bool tcg_exec_realizefn(CPUState *cpu, Error **errp)
     static bool tcg_target_initialized;
 
     if (!tcg_target_initialized) {
-        cpu->cc->tcg_ops->initialize();
+        const TCGCPUOps *tcg_ops = cpu->cc->tcg_ops;
+
+        assert(tcg_ops->restore_state_to_opc);
+        tcg_ops->initialize();
         tcg_target_initialized = true;
     }
 
-- 
2.41.0


