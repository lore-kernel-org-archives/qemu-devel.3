Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB8A7C83030
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Jul 2025 11:05:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXHhM-0001Vg-Ds; Thu, 03 Jul 2025 07:01:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uXHeO-0005s9-Oi
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 06:58:47 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uXHeL-0002v8-0d
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 06:58:43 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-3a4ef2c2ef3so4773806f8f.2
 for <qemu-devel@nongnu.org>; Thu, 03 Jul 2025 03:58:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751540318; x=1752145118; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zXEwQpLJNPRsbrPUQjvTni2WYpP8FdNuXX6y2BMbIXo=;
 b=yJSC1MlSa0VdjO8mpGA+Im8vchGxnne8k0Rs0ZB/tcbXogHmvPiGA9AMRmkcgU2iUk
 iDcVQSLwy+jz94J6U4p8TEL+hPXbvtQFuQffGW/0KHo/rrdhxZAErYNJfH6T4hRaZGt7
 GmO8nRfeFeu5dj3hhkuXpZXRzFDyl6XtF05Z3aNcgU04UPeE+ym4gJmZRuQcM8Yps5gD
 zaeeMxoum1UoJesRoijp71meGmDINVQk7uuGpBv4Of4C1gm3iGUQ2thFSrXIdFCA/Sla
 C09NMINNgFb0AgCDOsx/XOeGehgTJP4igTkrlz0bHEUF58YC5FRv5uCVq686a+Q/Hi4J
 TTMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751540318; x=1752145118;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zXEwQpLJNPRsbrPUQjvTni2WYpP8FdNuXX6y2BMbIXo=;
 b=sEbx8MsoqPqofzYR/BJOe33VkFxRAXxgdhPFMcfMdvfg/yGfzpuhV2HsL0pykw8JvX
 ruW5XKqCCxFiKMvXyXeqy3beuALTUv34HA8EQ/DOLcW+1ZsCRzYuOQ2A8afak1J6ffMi
 2H2NOEy7WrNrWAXK08Oze3lSGLkuJYGoQxkAc1lzMq6l/hLk05y+phyEbzMCDFHrEP/Q
 pNjI+VrNLErgh3LNUvUI2b7dSubnspaJvuQemV0K85raFoyBKc+v1JwdlDAHwuFyt9ga
 Q4xop2btsOaxlcGni7OZVDrrI2SJBdjvBmXE6jPGeladp/LLm8YOo02sncbhey/M7FIM
 EOfQ==
X-Gm-Message-State: AOJu0YxzCoDcPxfZQzwf75v06DlH9k5InUtjeuDI1OXefCchhBEJgWYx
 pyLWoRRUYp6dnKJU5JJ0Iu4njMNxUjySUzFgldlEniqkaTu5W/ICIrbmPmZucWS5oiplekJVaaW
 nn9+tlo8=
X-Gm-Gg: ASbGncu2caKPvXdYMPTDthCKrCAraA8aHl9xj5A/BHJy/1Pz2tTVyr/I7e5bLfRMmro
 OhfhWnHZLMzhSe78nUxdVu3Ra37ULdUuloeSQLq1vklq1RI9sHV27ONJCmghqvGpO/8M/9cPLia
 xvy8laExa37pA0pO5whO8k971cpEybneh9M0QhVaXPpG2Hkc11pMSPRkqrckJ7RI9o4PvfMBoFG
 JeVag6CZ1JRV06B7cvA4JYj8n7PGftQ+XHYu+INBIi0S6AHtsHN0pvNF6vRlcCBy8SDGDW9YR3A
 AJn6xCzL7JR8eBqQzlS6gibwKFis7AXYo2LhdH/ChrVV5GehwTAePDpNiolWmPKWPul8NLuqiFO
 7mWo9MZuYZBA=
X-Google-Smtp-Source: AGHT+IEDeve+hxPyKdiNduihX+UkbzFqIDkknGnvYLjOBdrA0tfyF6dpvjNV99JhtblwgCC6TQDZjw==
X-Received: by 2002:a5d:5f92:0:b0:3a5:1471:d885 with SMTP id
 ffacd0b85a97d-3b2019b7da6mr5691035f8f.56.1751540317731; 
 Thu, 03 Jul 2025 03:58:37 -0700 (PDT)
Received: from localhost.localdomain ([83.247.137.20])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-454a99c1186sm23334265e9.36.2025.07.03.03.58.35
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 03 Jul 2025 03:58:36 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, kvm@vger.kernel.org,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Shatyuka <shatyuka@qq.com>, Cameron Esfahani <dirty@apple.com>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>, Mads Ynddal <mads@ynddal.dk>
Subject: [PATCH v5 33/69] accel/hvf: Report missing
 com.apple.security.hypervisor entitlement
Date: Thu,  3 Jul 2025 12:54:59 +0200
Message-ID: <20250703105540.67664-34-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250703105540.67664-1-philmd@linaro.org>
References: <20250703105540.67664-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x432.google.com
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

We need the QEMU binary signed to be able to use HVF.
Improve the following:

  $ ./qemu-system-aarch64-unsigned -M virt -accel hvf
  qemu-system-aarch64-unsigned: -accel hvf: Error: ret = HV_DENIED (0xfae94007, at ../../accel/hvf/hvf-accel-ops.c:339)
  Abort trap: 6

to:

  $ ./qemu-system-aarch64-unsigned -M virt -accel hvf
  qemu-system-aarch64-unsigned: -accel hvf: Could not access HVF. Is the executable signed with com.apple.security.hypervisor entitlement?

Suggested-by: Shatyuka <shatyuka@qq.com>
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2800
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Acked-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 accel/hvf/hvf-accel-ops.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/accel/hvf/hvf-accel-ops.c b/accel/hvf/hvf-accel-ops.c
index c07ebf8a652..ada2a3357eb 100644
--- a/accel/hvf/hvf-accel-ops.c
+++ b/accel/hvf/hvf-accel-ops.c
@@ -337,6 +337,11 @@ static int hvf_accel_init(AccelState *as, MachineState *ms)
     }
 
     ret = hvf_arch_vm_create(ms, (uint32_t)pa_range);
+    if (ret == HV_DENIED) {
+        error_report("Could not access HVF. Is the executable signed"
+                     " with com.apple.security.hypervisor entitlement?");
+        exit(1);
+    }
     assert_hvf_ok(ret);
 
     s->num_slots = ARRAY_SIZE(s->slots);
-- 
2.49.0


