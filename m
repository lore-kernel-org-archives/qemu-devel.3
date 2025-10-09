Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 873B5CCA470
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Oct 2025 08:19:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6lrp-0004Ub-Q2; Thu, 09 Oct 2025 04:19:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v6lrn-0004UQ-Vz
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 04:19:16 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v6lrl-00085j-64
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 04:19:15 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-46e48d6b95fso5904665e9.3
 for <qemu-devel@nongnu.org>; Thu, 09 Oct 2025 01:19:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759997950; x=1760602750; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=I6xYsvCSK4rbEWmr9hp03tz8RUCvGH9H+ecrsoWlrsU=;
 b=KApJWuEHdrxSNpk8Lab8arI4jhbccJdQMyahSxa1XT65BWToZous2V7H4zB1xVhVVQ
 gru3zoYsMSkoFuBmTarcSESRsubkWqzSTDp79TmYWJKJgjhD6hYWlEaVQIabvs0CgVmh
 pgJYVdJ7/Qmqv+HXJFmg1v+Yjv1JMgZOpDzfKtb3OEdcWsbvm6MPB4svM/X27i8qgvdY
 HJb05LqEPbhnpLeJic6csjt5oTDAx/OjICL5xPUo3iYX/ZdrGI/99L97YH8hESsJuXuS
 P1JZnKVDFr32zrbqyPFXZm9xHjeycc/8EtVAxQAxV5ltOEdAiAAzwobDV2H/IE5MsUwo
 sTWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759997950; x=1760602750;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=I6xYsvCSK4rbEWmr9hp03tz8RUCvGH9H+ecrsoWlrsU=;
 b=jV5WTOwVU5CqKpEn3xnP4xFF0zTXCzlsRaLBP5LA+EWmxX1O9gumPNE7PRhW8aDRLf
 UrDtIrf3M9QMXjlTOSTLl1HM+1xUYSUQFjvmsbTCUu6EXBHEHwHObgpYN53HVyM/zBzA
 cS/JIelue6seIQUP1MeV/sN6S0O1WJHYkRuiVbciv8wSwWsXkglbBh7Si4MMM3/Z+RY4
 /4ZeMZ71Hbo+HZhnizJ8cxDLUMQfkGI7wPrJxIPNzI7Ymkr/k8DOyxI+lCujsrDLKiq7
 7Jlqm7/qV72OPqp8EK6eb7dVoPSiY0wLjgfz+mAPUVMfBvEfdqwUdveHDLQ9I0qHZWpP
 KPiA==
X-Gm-Message-State: AOJu0YyFkQHH5vHO732hi2h/0S43+au6izZaOR+N+MbwE+frsJ1IGcZ2
 udZO1cu3Ox3CfK5O4pdPGvkGitn7R1+iB1dTnt2nGgRzBh/9QAaUxpSG5DlxmQWc8mmGp/UzlBf
 UIx8IDVPohQ==
X-Gm-Gg: ASbGnctWM3Bd+8o936RDtTSNmh3bRDVVyHHmwJI2RN7KTZDdsJA0SUvtFedeXKZ5h4l
 z0llcWXcZVMGCjn+wuz1mp6OAtY7na/Qe2crljSt/uVw/TBoMLx/FQfAvN7Q7j/n1fN/+p1c5oE
 uImmZ+YC6F7YyY+Nua7UQvZ+pkmeyC/mnpHXOdgm0MYzPfqXBCF8OlCgYJay7HBNloEWruM2vbm
 VvrY+ZL7Oj7Ee5kl07cct6tdJfp28c77TrMKM23cyW30IwoYYwjrMASYzzNsa21cVtQteOFzFzB
 EpDR6CUZ2XwvfwY3I1KJdSk0/NXlX8pqq/pliLzkhHP8A++qOLBaz9BS8Ma46pPjjYWFr3ZGCcf
 +lA7a7mBYG3xMqqstxOKKeghPnBHscYxu38YuS7bYZFoSXjJtG5TUSHJZqcY8OQwL5kPgaIOCfv
 bfPjugHK/Bv9Q6ZMo/MSbeMD3g
X-Google-Smtp-Source: AGHT+IEmlx+ooLWqP3TU/+F+6n8ApNEDxyheXBxav6koVBJQVidVegLpgP7uLEXQ26aYAkUGFh2etg==
X-Received: by 2002:a05:600c:34c2:b0:46e:502c:8d6a with SMTP id
 5b1f17b1804b1-46fa9b06499mr40068375e9.25.1759997950032; 
 Thu, 09 Oct 2025 01:19:10 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46fab633cdasm31076305e9.9.2025.10.09.01.19.08
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 09 Oct 2025 01:19:09 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Stafford Horne <shorne@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 01/10] target/openrisc: Replace VMSTATE_UINTTL() ->
 VMSTATE_UINT32()
Date: Thu,  9 Oct 2025 10:18:53 +0200
Message-ID: <20251009081903.13426-2-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251009081903.13426-1-philmd@linaro.org>
References: <20251009081903.13426-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

Both OpenRISCTLBEntry fields are of uint32_t type. Use the
appropriate VMSTATE_UINT32() macro.

There is no functional change (the migration stream is not
modified), because the OpenRISC targets are only built as 32-bit:

  $ git grep TARGET_LONG_BITS configs/targets/or1k-*
  configs/targets/or1k-linux-user.mak:5:TARGET_LONG_BITS=32
  configs/targets/or1k-softmmu.mak:5:TARGET_LONG_BITS=32

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Anton Johansson <anjo@rev.ng>
---
 target/openrisc/machine.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/openrisc/machine.c b/target/openrisc/machine.c
index 081c706d02c..fa054e528bd 100644
--- a/target/openrisc/machine.c
+++ b/target/openrisc/machine.c
@@ -26,8 +26,8 @@ static const VMStateDescription vmstate_tlb_entry = {
     .version_id = 1,
     .minimum_version_id = 1,
     .fields = (const VMStateField[]) {
-        VMSTATE_UINTTL(mr, OpenRISCTLBEntry),
-        VMSTATE_UINTTL(tr, OpenRISCTLBEntry),
+        VMSTATE_UINT32(mr, OpenRISCTLBEntry),
+        VMSTATE_UINT32(tr, OpenRISCTLBEntry),
         VMSTATE_END_OF_LIST()
     }
 };
-- 
2.51.0


