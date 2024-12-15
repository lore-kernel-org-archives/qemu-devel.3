Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9B47E7716A
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Dec 2024 19:06:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tMtwB-0001FV-Vf; Sun, 15 Dec 2024 14:05:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tMtw9-0001Ef-7f
 for qemu-devel@nongnu.org; Sun, 15 Dec 2024 14:05:53 -0500
Received: from mail-oa1-x2a.google.com ([2001:4860:4864:20::2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tMtw7-0000zS-QZ
 for qemu-devel@nongnu.org; Sun, 15 Dec 2024 14:05:52 -0500
Received: by mail-oa1-x2a.google.com with SMTP id
 586e51a60fabf-2a3c075ddb6so1026509fac.2
 for <qemu-devel@nongnu.org>; Sun, 15 Dec 2024 11:05:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734289550; x=1734894350; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4KqTM/+wxwYqUqyOIxknRrXlNo+1wIkfDm+xIm6YiEI=;
 b=L+MhTAldJmdGi24wKbiv5TLmw8mohHx8UxagdnPrJTguY7s7aq+UcZfwnw8+1AU96n
 r9Arc6xcQYy7Bm+tvUUWnBBNnSv4B4s0umUkKfWCCgrVSOUINjv+gtZb2V+U5LASrKl1
 /ySuUf1kTgDEZLlka3AMw7ExvN2AWaFEaQ28u++GHkyZuc/h+TQSmQ5ejEa4pq+MYY5o
 dXSS+OJpfvTkxppKYk88MVC9FrLjBBTd55dgaXEUJvlVi+ArsiRdZAEzzT2YEMlq8Is/
 ipdNfxa1ggd87rQMii2u3sd4GmiK5+/46dog6VkKWzth58e/WFQEm+ashBf1Ew0i4Bta
 0IRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734289550; x=1734894350;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4KqTM/+wxwYqUqyOIxknRrXlNo+1wIkfDm+xIm6YiEI=;
 b=efNEMI5xQf8elMPXjZr4gVTSZYBhFAZVnASk9kakSbhCpSqQieZQOL4lNrA7FNP2xf
 tZgkcRvFhx0Ne+pJ+aJomqUFx1crbkY4qks4MP/Jf8BVxst1yTi0JFMQCOK/d0vFv5Hv
 1q4FUqlkQIRC5DL5BpGlosBMBogeQbSzdWBWpISyOhdEmxHJ8u4CELqBAAW6DfhsGdqR
 e2AAI5NZY6hvlBIsnNoNUwd2BTkKSy+DQnvtAT0nn9gH4El67XVtPZmBnhj49BWLlFuC
 jg3kOqBWPUns7OAq9hXnQGXL1RTzcIQIwBtKHsGMhPm5GCDC2WAO/32I7GPt64u2H+Jk
 V2og==
X-Gm-Message-State: AOJu0YxY4O2iFz8oZITN+iDOUAhdoqxzV3iFYDHEDm0I8/DfJbfSdtgm
 BkXMbciOQoF1JWjELwh8ItLEsJOLHo57Mmst9zXEQUxFWRHKPww7uoteWNI7EwCH6WDCChnqYwG
 fCbsuT2du
X-Gm-Gg: ASbGncudsWro1loZqISiWp/ImuwYQiWCUNgt9dhEWcjqO1YqftcoHBsnMjxkk5Mtlxw
 8njAJ4HnsGSMqRP5XUOTkqKDngKheQx2H1/+uqIdSpnmSOhqd04qCWWqi33pI0BhEsJHEM8usrN
 p/PQRoKio2C2/fB3cTHfSYZyeADXslN7qlUwCnD7OhdNFt3N8V7kcouzYgBiqwGkt17rmj00qVo
 4Y7VDvODvYGjKVeLn9XpGBEoqp1lmpu78uHpmQiH9LatuXBsz3VmLSO0NOXvoX60lQRJJfMUkf/
 6ZDrb1tfC3JAwxd9z2APi76r/fRR+cMETsL3XzO6iOw=
X-Google-Smtp-Source: AGHT+IH9ltcnqg71D0sVunmJsUC42Or2M+zH1eDkdySqRWGEVq4Hzk2bSjZJvaDV7P62VK+EhsF03w==
X-Received: by 2002:a05:6871:891:b0:29e:5ffa:b769 with SMTP id
 586e51a60fabf-2a3ac8bac38mr5487674fac.29.1734289550637; 
 Sun, 15 Dec 2024 11:05:50 -0800 (PST)
Received: from localhost.localdomain (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2a3d2914ac6sm1423214fac.39.2024.12.15.11.05.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Dec 2024 11:05:50 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PULL 07/67] target/riscv: Constify all Property
Date: Sun, 15 Dec 2024 13:04:33 -0600
Message-ID: <20241215190533.3222854-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241215190533.3222854-1-richard.henderson@linaro.org>
References: <20241215190533.3222854-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::2a;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x2a.google.com
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/riscv/cpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 80b09952e7..4329015076 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -2661,7 +2661,7 @@ RISCVCPUImpliedExtsRule *riscv_multi_ext_implied_rules[] = {
     NULL
 };
 
-static Property riscv_cpu_properties[] = {
+static const Property riscv_cpu_properties[] = {
     DEFINE_PROP_BOOL("debug", RISCVCPU, cfg.debug, true),
 
     {.name = "pmu-mask", .info = &prop_pmu_mask},
-- 
2.43.0


