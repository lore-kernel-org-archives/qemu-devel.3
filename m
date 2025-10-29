Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAE20CCF9EB
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Oct 2025 21:55:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEE7I-0008Ib-FP; Wed, 29 Oct 2025 17:54:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vEE7G-0008HV-Kw
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 17:54:02 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vEE6t-0007uK-Dv
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 17:54:02 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-475dc6029b6so3633865e9.0
 for <qemu-devel@nongnu.org>; Wed, 29 Oct 2025 14:53:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761774809; x=1762379609; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8IuzXfYtFtGeolSJyrOSQ3n8KrRKZEFt8FOM0hiORo4=;
 b=ydDyWXK51Esb3SqVpBbkh9UWoURg/AqFGUuWhEVuWKMuh9n8rZUwPeTwfHfEb+gbKK
 8W2DCR2m7Sc0r9zbA0ysO3xUjwgGTrji3FoyStk2cFvU8aJGVe8A2wH6Me8iDuXtjNr1
 jDMxgM5/N7JB5Wb5ZmcBmKEOYk0HviIvVQAMG/021RTmyPi+GTChzXFNjS95kmJxel7V
 dyBPhCxPRMhW442PQvx81o3CBnNN1O7bATwewZMwdQi09ZIWGFWMmYZZIvp81a/bnvEE
 n34L66upcj/5PjpAGHalhrM5R7Apg+2w//iYPeCsLLOts0ctUcd3tkG6R0Z7Vat6Erg1
 n30g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761774809; x=1762379609;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8IuzXfYtFtGeolSJyrOSQ3n8KrRKZEFt8FOM0hiORo4=;
 b=hSEPORRVX4xXnnK5AelZz4MPTv9Id5kUSv+l0vnI77q6hnRyr8bLr8iMdzhg2BCY/a
 Tk7dgHe7sAkX9Zo+f2Fw1gbM66mi+M58KISr75roaNLQ4EFaD4OZomxZZB9E+fUHbeO0
 YnCE/fzaMaQ0D/0TZytow7oM8UpWkKdg3zbkfI/1R1afcFTtcZiLcwbNDeezEVKEXxGV
 kTutyHAsnmtdHOx8DtL/uEzK+euHPx5WDnGwAzmSqco5x1qxMw8Bd1AOcdvvgFxWGHq6
 L+YIPk/XFMmuB8ZUTgeY2E6bYWkYbw+G4irGWwGJM9+jpqW4N7x11l+T4+u7RIrw7xOz
 n4uQ==
X-Gm-Message-State: AOJu0YyVUEFzkfNNMYlJLwSdLkIVDZWctqTUvY1g6IwZN1R7CX9Onf7H
 zMVJeDVEkXpgMmGyLoHP294lzu/VOZHXF4PkUNBVEpLQ/EOSauayLR7X7jYBVpjDGEfUiCeoPmT
 QAWzZaRY=
X-Gm-Gg: ASbGncvuBr80d/Uem+se2oWR6PnP9J4kspmiXrzqQDIcpu3mCXy/ERSkFgbD9fAv6uW
 HSYr+BNNaZDNxQKoSjQkpoHpzb5IgkiLfCjWqeKCYnXSOqHERhC5jB1j9PpDgbsEnHqTYMIWkUv
 UDagh8Lp+jwsNmOdqATYSwD1gru6gZHTeLZ227uWbPrXzqOC+DEfnlKk70CkrZhuQ4TuPup2YKW
 Zm0YG41o8X/nW807htvs7ZwMgxpINzJQGNsbWmwVI759R3LUFLyMM1RG69dU+yQ8NGAdAhDSmBq
 uj/LWcXkp0zIrMwLu7FvWyprv6QGQCCCKYIb3o9QMHuLCoiDTst0L2bBiir3bihFRJWws77V1Jw
 fXWAQGWvZXTum0aDWrxWa1wlR6AqZ3pnzcvuSUJmxUXahAiBcj1C5FWAA+LVRzdpcDxKPPVkWPs
 2c1H+7LJltdgydXCFlj1uDXkBI5i2JsSb1MHfnozJoKZKehWI2pA==
X-Google-Smtp-Source: AGHT+IEbCv9u46QjKnA4rQkkvi3GpFj/ow6eoLMh3K0PHF3wh6oDrcUw1YVhVtjAlpwb6ICi2ZtJIQ==
X-Received: by 2002:a05:600c:4ecc:b0:46f:b42e:e360 with SMTP id
 5b1f17b1804b1-4771e1f3e35mr37477755e9.40.1761774808573; 
 Wed, 29 Oct 2025 14:53:28 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47719004d79sm52860015e9.5.2025.10.29.14.53.27
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 29 Oct 2025 14:53:28 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PULL 13/23] hw/arm/virt: Get default CPU type at runtime
Date: Wed, 29 Oct 2025 22:39:50 +0100
Message-ID: <20251029214001.99824-14-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251029214001.99824-1-philmd@linaro.org>
References: <20251029214001.99824-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

Prefer MachineClass::get_default_cpu_type() over
MachineClass::default_cpu_type to get CPU type,
evaluating TCG availability at runtime calling
tcg_enabled().

It's worth noting that this is a behavior change:

- Previously only

  ./configure --disable-tcg --enable-kvm
  ./qemu-system-aarch64 -M virt -accel kvm

  would default to 'max' and

  ./configure --enable-tcg --enable-kvm
  ./qemu-system-aarch64 -M virt -accel kvm

  would default to 'cortex-a15'.

- Afterward, -accel kvm will always default to 'max'.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Zhang Chen <zhangckid@gmail.com>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Acked-by: Peter Maydell <peter.maydell@linaro.org>
Message-Id: <20251021210144.58108-5-philmd@linaro.org>
---
 hw/arm/virt.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index dda8edb2745..d07cfe16512 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -3257,6 +3257,12 @@ static int virt_hvf_get_physical_address_range(MachineState *ms)
     return requested_ipa_size;
 }
 
+static const char *virt_get_default_cpu_type(const MachineState *ms)
+{
+    return tcg_enabled() ? ARM_CPU_TYPE_NAME("cortex-a15")
+                         : ARM_CPU_TYPE_NAME("max");
+}
+
 static GPtrArray *virt_get_valid_cpu_types(const MachineState *ms)
 {
     GPtrArray *vct = g_ptr_array_new_with_free_func(g_free);
@@ -3312,11 +3318,7 @@ static void virt_machine_class_init(ObjectClass *oc, const void *data)
     mc->minimum_page_bits = 12;
     mc->possible_cpu_arch_ids = virt_possible_cpu_arch_ids;
     mc->cpu_index_to_instance_props = virt_cpu_index_to_props;
-#ifdef CONFIG_TCG
-    mc->default_cpu_type = ARM_CPU_TYPE_NAME("cortex-a15");
-#else
-    mc->default_cpu_type = ARM_CPU_TYPE_NAME("max");
-#endif
+    mc->get_default_cpu_type = virt_get_default_cpu_type;
     mc->get_valid_cpu_types = virt_get_valid_cpu_types;
     mc->get_default_cpu_node_id = virt_get_default_cpu_node_id;
     mc->kvm_type = virt_kvm_type;
-- 
2.51.0


