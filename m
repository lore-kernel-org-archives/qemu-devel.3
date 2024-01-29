Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B8D1C47DB3
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jan 2024 15:20:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUTPm-0007eS-Ox; Mon, 29 Jan 2024 10:19:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rUTPl-0007dw-Fx
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 10:19:13 -0500
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rUTPi-0007V4-Sn
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 10:19:13 -0500
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-3394b892691so1582828f8f.1
 for <qemu-devel@nongnu.org>; Mon, 29 Jan 2024 07:19:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706541549; x=1707146349; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=letmG5/Sw/UvLSNttdIXIs4OU6VOMo7YyUWWgNEfysU=;
 b=clGEcFZU8BN/Zn/kH9g16iJ4cMTkcy/FS2XiDEsNCCHyt0/lUSF94p5YNirerjLtSW
 zRMEYUbV3b2pB2ezHq88mXaISsPDFOmeh5kKU0MZO365mIzBM6VcUbwKburcjipzyvPH
 k8AdBXDa/4BK9BHlpLhN+Fh7yX8UHHF7rUsru8+OJkX/6CNGX8Z14IjE3bO2bEipjlXh
 rvf8QWC/y1+oj9Oggb6dOYmfmzznVYo1HMYOZgH5gfRs8UUdsVVbaGCJPJOqs+AXls9v
 0CZsJ2PfCWrgoYx/iQDSj0gfGQYMSXR3s0yBU51AQF4rw9z+kFCKERT16AqFipWWgHoE
 xASg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706541549; x=1707146349;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=letmG5/Sw/UvLSNttdIXIs4OU6VOMo7YyUWWgNEfysU=;
 b=ZnJfamAZdmb4hQAwIlL4WOhpqYE6H+SM2hd6xeGkgtDn8s7P5Uw8FR4tgeffn1J3sv
 drHEOkJB7dXKS5Gv0uUwU0SU5rGHpgxmRN4bDoWhJwbf44EjAZ2f813xwQz4ycgz5vl7
 TX0saTkP65enJb0s/vpcu+JL+cjNxAJgAJ4GCiwjyAV5liWQzf5VYa4DyZtQq41wvQlf
 lj79eC9Oy2NsCRYqhKRcbg4/ktCVL+NUFRteWwfqZ2uU7Y/shIpcQvyxgnQY4yAKrWyS
 WJwWAERjHO7sKTMmnmuX09EDK/T0ME1yO0v6EOlacojK58EMJqDPh7N+EPtuqj4YSIGD
 /4+A==
X-Gm-Message-State: AOJu0Yw7duzSTri5JRN7tUch5HNpnIuF8jAPTQbe2sxuG4Iu5t3Wi/QG
 Na1260c78zI5s/wYKk26tdYKntFMoYm4eSLPADJiM4msX4kx3O8Ghk5tJrwtzMPYBuhv2vjd/D+
 1
X-Google-Smtp-Source: AGHT+IGXo6y1a9DYDpQR+/s77OOYuTgpEYjuuCLJfdC3wkGMg68BFl5HCOhEI2pVxbiN5vcx+TO4rA==
X-Received: by 2002:a5d:59a6:0:b0:33a:f48d:1a16 with SMTP id
 p6-20020a5d59a6000000b0033af48d1a16mr1604375wrr.22.1706541549398; 
 Mon, 29 Jan 2024 07:19:09 -0800 (PST)
Received: from m1x-phil.lan ([176.187.219.39])
 by smtp.gmail.com with ESMTPSA id
 p7-20020a5d4587000000b0033af670213dsm92953wrq.110.2024.01.29.07.19.07
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 29 Jan 2024 07:19:09 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Tyrone Ting <kfting@nuvoton.com>,
 Subbaraya Sundeep <sundeep.lkml@gmail.com>,
 Alistair Francis <alistair@alistair23.me>,
 Igor Mitsyanko <i.mitsyanko@gmail.com>, Hao Wu <wuhaotsh@google.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>, Rob Herring <robh@kernel.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v3 6/9] hw/arm/musca: Simplify setting
 MachineClass::valid_cpu_types[]
Date: Mon, 29 Jan 2024 16:18:25 +0100
Message-ID: <20240129151828.59544-7-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240129151828.59544-1-philmd@linaro.org>
References: <20240129151828.59544-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42e.google.com
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

Musca boards use the embedded subsystems (SSE) tied to a specific
Cortex core. Our models only use the Cortex-M33.

Use the common code introduced in commit c9cf636d48 ("machine: Add
a valid_cpu_types property") to check for valid CPU type at the
board level.

Remove the now unused MachineClass::default_cpu_type field.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/arm/musca.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/hw/arm/musca.c b/hw/arm/musca.c
index 770ec1a15c..e2c9d49af5 100644
--- a/hw/arm/musca.c
+++ b/hw/arm/musca.c
@@ -605,7 +605,6 @@ static void musca_class_init(ObjectClass *oc, void *data)
     mc->default_cpus = 2;
     mc->min_cpus = mc->default_cpus;
     mc->max_cpus = mc->default_cpus;
-    mc->default_cpu_type = ARM_CPU_TYPE_NAME("cortex-m33");
     mc->valid_cpu_types = valid_cpu_types;
     mc->init = musca_init;
 }
-- 
2.41.0


