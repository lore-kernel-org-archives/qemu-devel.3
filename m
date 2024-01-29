Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CDACC47DB3
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jan 2024 15:21:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUTPg-0007bl-WE; Mon, 29 Jan 2024 10:19:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rUTPR-0007Vp-T5
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 10:18:58 -0500
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rUTPP-0007Rs-8k
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 10:18:52 -0500
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-33af3c7ef60so507682f8f.0
 for <qemu-devel@nongnu.org>; Mon, 29 Jan 2024 07:18:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706541529; x=1707146329; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jC58YmpOm3xZcOtP9AEc7xhs85+MVmwSSZ2Oh6qeQAw=;
 b=SvNVlvaKbHPd0DMHsuvn3DyYp/g1jZwlBJMNaocTvAkQxkA0txbZ7h0fwqWWLed5P9
 XziHd8/Os9rIEjRe4oEp/SOLcOohIPXLwB+G1ypXXjn+iWKV7xXiSMernT/S328E+l3o
 2JHpswy4CIdzLtLhoxDFB4x0dz79UhajbEYB0rBHsZdlAckv/BYfNIC1aC94/o8Kv4nW
 J98W0FjV+qS3fw5+HHYFBGi0yBH7AOYrn2xifNaUh/POx87GxFm6dn8k0nktatmbyZCu
 AbjDRtokYe7Mz4g1OPT1ub1iCT3KDp35gel0jNMKnml561ZqbK6A00z/E4SWpV9sfmKq
 5GfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706541529; x=1707146329;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jC58YmpOm3xZcOtP9AEc7xhs85+MVmwSSZ2Oh6qeQAw=;
 b=R2YdDZjxzJEqEuRN10RR+e5/Pvu9ZalX5LsK3rDOh/C209AoWbEVxlPJ2aSDMksXhh
 BZ36N6jXU2VOM9wS6wLnmoEsw68m0+onKUgEf1i4q060BReogv4o5tedIvRICAZfOI8b
 fcVzKrmU5qL0TLRz/jMWYVP8mK8uWNCLCGnnqOe6KWuGZ4OJPpoAVLB7QZn3YUyRME+h
 FIfnU6mil/TSr8VTMiecFaeHC1fYFH0df+1k3q9MFtGUQhg2flJgpFvWQ/YtNruCowbQ
 K9gaVZvXjNZEgEVLIP8MwJ6dOlYGFnGfXewLd/Qo54hwa65RuedqgTDAc0bgJgspskhc
 LWJg==
X-Gm-Message-State: AOJu0Yx2EAhjP7x0T8g1dN2T4doQMhqG8dZv7yITQD3bdsC5YbFPh2Zm
 f0weDrpNZPAlokWGPdFd42fA14yjhQXkUUssKnyrwEq3zlLNXIWUAX9zICOiIX8GzhxzRyo6tn4
 w
X-Google-Smtp-Source: AGHT+IEu+SX+SywsYmHegBw8+QwkdLEYCqtODjj2hYiHwfs7O5mTT5b1IvSXVHJdY4tVMmEpYXMzVg==
X-Received: by 2002:a5d:4fc4:0:b0:33a:e2d3:c3ec with SMTP id
 h4-20020a5d4fc4000000b0033ae2d3c3ecmr5192736wrw.60.1706541529826; 
 Mon, 29 Jan 2024 07:18:49 -0800 (PST)
Received: from m1x-phil.lan ([176.187.219.39])
 by smtp.gmail.com with ESMTPSA id
 en8-20020a056000420800b0033940016d6esm4250778wrb.93.2024.01.29.07.18.48
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 29 Jan 2024 07:18:49 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Tyrone Ting <kfting@nuvoton.com>,
 Subbaraya Sundeep <sundeep.lkml@gmail.com>,
 Alistair Francis <alistair@alistair23.me>,
 Igor Mitsyanko <i.mitsyanko@gmail.com>, Hao Wu <wuhaotsh@google.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>, Rob Herring <robh@kernel.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Gavin Shan <gshan@redhat.com>
Subject: [PATCH v3 3/9] hw/arm/highbank: Add missing QOM parent for CPU cores
Date: Mon, 29 Jan 2024 16:18:22 +0100
Message-ID: <20240129151828.59544-4-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240129151828.59544-1-philmd@linaro.org>
References: <20240129151828.59544-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
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

QDev objects created with qdev_new() need to manually add
their parent relationship with object_property_add_child().

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Gavin Shan <gshan@redhat.com>
---
 hw/arm/highbank.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/arm/highbank.c b/hw/arm/highbank.c
index e6e27d69af..b8d702c82c 100644
--- a/hw/arm/highbank.c
+++ b/hw/arm/highbank.c
@@ -209,6 +209,7 @@ static void calxeda_init(MachineState *machine, enum cxmachines machine_id)
         cpuobj = object_new(machine->cpu_type);
         cpu = ARM_CPU(cpuobj);
 
+        object_property_add_child(OBJECT(machine), "cpu[*]", cpuobj);
         object_property_set_int(cpuobj, "psci-conduit", QEMU_PSCI_CONDUIT_SMC,
                                 &error_abort);
 
-- 
2.41.0


