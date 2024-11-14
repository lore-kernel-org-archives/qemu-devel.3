Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75708D637D5
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2024 01:19:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBORt-0000CZ-Le; Wed, 13 Nov 2024 20:15:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tBORY-00089K-6r
 for qemu-devel@nongnu.org; Wed, 13 Nov 2024 20:14:48 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tBORW-00028d-6l
 for qemu-devel@nongnu.org; Wed, 13 Nov 2024 20:14:43 -0500
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-431548bd1b4so890325e9.3
 for <qemu-devel@nongnu.org>; Wed, 13 Nov 2024 17:14:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731546880; x=1732151680; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Yi8oP/SEa8RdfPU0nVwuwaNWFqTgpMIdFqeiug4H/W4=;
 b=rfKfcX4JG07JMQDwwX+3GX4bIiEc2cze1LGAirRp3nriSbzvcuR2nLxcbUKapyQQcH
 lji8QagYzwRq4N3gD45ZNk0vtPsJ97rCk7TODdVBF1wF6JtEKwlWC+Yn6vql7eKVCxbg
 JsZaK7QWJE9UTaj9Atkr48aCAeNDp2eXibOnpu+dO0EyU0U4O4BcZ4gnrikAEd+EawSK
 ZGiNwnK5tVFkrCEeNsZAEUiqnyLWEf40s0s6jrFfUKSGTgHVoubDe2NNU1heDAU3FP/b
 ETwe/2eBrif4B05Cw4kDr3I62oj0cN4YNHfJLuChxIWBdzfE2RJRkrBWf6sExSgEsXM8
 q/7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731546880; x=1732151680;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Yi8oP/SEa8RdfPU0nVwuwaNWFqTgpMIdFqeiug4H/W4=;
 b=vfJoj8CO8D0IRvcZdn9/V0Qj0wev4JgNoXftdXWOOas4teMamgBpVMDDCLW7aYqWGm
 m/jtMYIcxvmL+jSVYnb/bkpcJrgsoXVmtQ/gya45AqcXLA1qnBVyB70f9oE1XNCG2unk
 yHCy0N/Zm6QIVh3fhw1wAtlyEzJNJWY9/SZEM+YMyW1f/5yXZJ0qta/CthQihcsaRuR1
 ruI0zXwAJoY4ZsZddCLWd+sjg3cGKThsdWOjqqkRKH3CeQjrVpijgL/atqUYPVOBqtrp
 ipI2auGI97DnX0mfIdFBlEHIR5pgjqfC532PBnF8MK6jFwQF7yVHXD6YMPM3VmtgYUfV
 Ppew==
X-Forwarded-Encrypted: i=1;
 AJvYcCVHQ2IhWLAApK3yhDt7SxGiUZ1SNerJbXZQGUEFmX1hQ2A/2PAjtUUIJZTfs3CRsdmxkwbHcjHQuuys@nongnu.org
X-Gm-Message-State: AOJu0Yy6jb45gCncsJQ93j5GToc8s4AtxZ1iqz8NCyjcZgjHBvKSUWQ0
 0OwuUYDI5lA1ALCg91YW+p5wG69/2d/datuw2B9OUxakiYdnrKXVhVXS/NUAb+Y=
X-Google-Smtp-Source: AGHT+IHshN65SEUSiXRSla/0TLQwOrSSZwJsNVoNHIKZKVGyfpL2AdokvGedv4UPA15Nq3l2/qFYYA==
X-Received: by 2002:a05:600c:384e:b0:431:3a6d:b84a with SMTP id
 5b1f17b1804b1-432da767a27mr2552595e9.4.1731546880412; 
 Wed, 13 Nov 2024 17:14:40 -0800 (PST)
Received: from localhost.localdomain ([176.187.209.238])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-432da265ca8sm4806795e9.14.2024.11.13.17.14.37
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 13 Nov 2024 17:14:39 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Anton Johansson <anjo@rev.ng>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Thomas Huth <thuth@redhat.com>, qemu-arm@nongnu.org,
 Peter Xu <peterx@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-riscv@nongnu.org,
 David Hildenbrand <david@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-s390x@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 10/24] target/arm/cpu: Restrict cpu_untagged_addr() to user
 emulation
Date: Thu, 14 Nov 2024 02:12:55 +0100
Message-ID: <20241114011310.3615-11-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241114011310.3615-1-philmd@linaro.org>
References: <20241114011310.3615-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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

Move the #endif guard where it belongs to restrict
the cpu_untagged_addr() implementation to user
emulation.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/arm/cpu.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index d86e641280..12b8466542 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -3355,8 +3355,8 @@ extern const uint64_t pred_esz_masks[5];
 #define TAG_GRANULE      (1 << LOG2_TAG_GRANULE)
 
 #ifdef CONFIG_USER_ONLY
+
 #define TARGET_PAGE_DATA_SIZE (TARGET_PAGE_SIZE >> (LOG2_TAG_GRANULE + 1))
-#endif
 
 #ifdef TARGET_TAGGED_ADDRESSES
 /**
@@ -3382,6 +3382,7 @@ static inline target_ulong cpu_untagged_addr(CPUState *cs, target_ulong x)
     }
     return x;
 }
-#endif
+#endif /* TARGET_TAGGED_ADDRESSES */
+#endif /* CONFIG_USER_ONLY */
 
 #endif
-- 
2.45.2


