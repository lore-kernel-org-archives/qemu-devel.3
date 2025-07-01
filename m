Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C49EC7EE30
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Jul 2025 14:52:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWcAX-0005k3-0u; Tue, 01 Jul 2025 10:41:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uWcAN-0005SF-FL
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 10:41:00 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uWcAK-0006pu-6y
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 10:40:57 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-45348bff79fso33236385e9.2
 for <qemu-devel@nongnu.org>; Tue, 01 Jul 2025 07:40:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751380847; x=1751985647; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Y/J3/dM6yL9EpwD8nNu/ZbysHMLeoDjMiAJQk/DeNw0=;
 b=ib9SnsOSNX5K1zujM1TYhxmUSCWhI0dVfSdzDmldmtKLO74UAfS0e1blNNppNkH4BO
 yDtBqVGGnl/anGeehwCevgnHIO+FrDzMIMDCdUzIroDH7C9n0qfBYndQtElDq23mayho
 AjKr8AOAvxK5J6/sK+CiPDCVUEa3j7KsRmI3V3alHSn3tKIMSoNDtFTDJtfLByJG2HnH
 +3Kd/5z9a6GFW4zhDhN2az1+qowdMYt+Y5tSVLg16vUpcX+hQCGRe6Ca2Gq8BOCSh+oY
 Dat82j2diyzCP2tiS0I6GoR0bxLjdYts03nllO7HP5CRjftXNWN9Ajfm0SQAhCcbpkmm
 xbFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751380847; x=1751985647;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Y/J3/dM6yL9EpwD8nNu/ZbysHMLeoDjMiAJQk/DeNw0=;
 b=mENtZF9IX/ve9LhrXannvlkHZJ1WywqgAdpGqcr7st77Xql3ZL1pITD3ct/aUZn+ng
 no2g6Vnl8vV58sdn3Ls4DbJ5yY3Y+3kZMLOUfhjXzwCZJ9krigobze2Qgrp9p+FXfAfK
 bbKgbhg3hOZYwwo3qD8WsxzI18j/FStTVAMedfX6ZZIZ3bVECmArEcEoHgVmPcnExmN4
 rcBo0tls81a3AfO/m48luivKEG2J+CP6yLh7AlkBsCNvvvkLGJzQ3FbD7lUtN+mUytJl
 CyC1Z8lNWBYBi3/QY5VdEAe24RThWdrGvxj6ZIIajULcnVl8btwHxj1hbYz4D9RyGn6+
 glBQ==
X-Gm-Message-State: AOJu0YzQ/6i0o82bx5AfBQU6FqEeU6OE2vmOwELq3vOFfFNcwhohBusv
 le7WO4taTJFdMbmGQ7Lpb3AXBUPFcJzm46LwNm6nLUteDSaQxoiUWuewEe+IhXhAaDlMTginw/v
 t9lVp
X-Gm-Gg: ASbGncus2sum+cz4prhZO0O6YMNbkjmNodIokK9XzPk35fzUvEAynjrqz0oQzvQMotr
 3cgAmyFUX9dKfsOxbt6tYjptsPZlVrQ1c81jusamtwR2jI/urw+RCRreZmB1EzF0UNYcKffDX9h
 SqK7tzFeSi9XIo2Sl9oDL5LmAm5tQAjZAZciz0UaVhBNnxaxpZsmWBsL57o/fBoAQqFgKijGqlC
 L7sZrA9XTL2Wm5u9OaxjmZ/PN2j7zTmlg5696Npf0/ZgqLvi2irv9RfQkGSgt81iQYouGnRUSkt
 PF3y3iaRlPH8F9TiZ6Y77dHf6d0991xwPdlIHDm4dG8HCe5twk49+uHRWnB/Npg62+fh6dHSbgq
 4phhOWHthNQxO+eYmIIcAt6mpD/ktFMqjU79q
X-Google-Smtp-Source: AGHT+IEXpHJS8wVbhtFpKIRV7/WijY561Afu9yjuqaQqjO4l13pQV6Fg9cpQK7fKChUL+nuEBRgd7Q==
X-Received: by 2002:a05:600c:190b:b0:440:6a1a:d89f with SMTP id
 5b1f17b1804b1-4538ee4fd6cmr197240465e9.4.1751380846811; 
 Tue, 01 Jul 2025 07:40:46 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4538234bc1fsm196638085e9.14.2025.07.01.07.40.45
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 01 Jul 2025 07:40:46 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Julian Armistead <julian.armistead@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 05/68] accel: Introduce AccelOpsClass::cpu_target_realize()
 hook
Date: Tue,  1 Jul 2025 16:39:13 +0200
Message-ID: <20250701144017.43487-6-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250701144017.43487-1-philmd@linaro.org>
References: <20250701144017.43487-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

Allow accelerators to set vCPU properties before its realization.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/system/accel-ops.h | 1 +
 accel/accel-common.c       | 3 +++
 2 files changed, 4 insertions(+)

diff --git a/include/system/accel-ops.h b/include/system/accel-ops.h
index 44b37592d02..a863fe59388 100644
--- a/include/system/accel-ops.h
+++ b/include/system/accel-ops.h
@@ -35,6 +35,7 @@ struct AccelOpsClass {
     void (*ops_init)(AccelClass *ac);
 
     bool (*cpus_are_resettable)(void);
+    bool (*cpu_target_realize)(CPUState *cpu, Error **errp);
     void (*cpu_reset_hold)(CPUState *cpu);
 
     void (*create_vcpu_thread)(CPUState *cpu); /* MANDATORY NON-NULL */
diff --git a/accel/accel-common.c b/accel/accel-common.c
index 56d88940f92..55d21b63a48 100644
--- a/accel/accel-common.c
+++ b/accel/accel-common.c
@@ -105,6 +105,9 @@ bool accel_cpu_common_realize(CPUState *cpu, Error **errp)
     if (acc->cpu_common_realize && !acc->cpu_common_realize(cpu, errp)) {
         return false;
     }
+    if (acc->ops->cpu_target_realize && !acc->ops->cpu_target_realize(cpu, errp)) {
+        return false;
+    }
 
     return true;
 }
-- 
2.49.0


