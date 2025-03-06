Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08875C282DE
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Mar 2025 15:49:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqDSE-0007YO-V4; Thu, 06 Mar 2025 10:48:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tqDSD-0007Xi-5U
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 10:48:09 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tqDSB-0006Ea-GC
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 10:48:08 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-438a39e659cso4915895e9.2
 for <qemu-devel@nongnu.org>; Thu, 06 Mar 2025 07:48:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741276085; x=1741880885; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=jYtwJvU4r0akXgP5T1pK8wv7rwtoSTLrcOo1FyW8tGY=;
 b=AjKpw0Qb35Els9tF9TPq8qskjEiIdtBrJKEQPjFzdWYRPCVQHt8IfWLLwnfB1cIHm3
 ukdskb41TdpKL/bCQoQwTnfVemRLLDJYfCB0SQihg6SgmxU/AZCI4GPRs7hx7OcpjcKC
 8T0gUB5T+qjDY7x1mZ56nll7SKndMerZlnr+yqTRtZOIDcUEX/Aw1Zdiao8je/WM/FCI
 4lzKuEimOiWKGgY3m+WA6lB2+y3UNCdqPzKvbw9DTklaN5LjCMeZR/zGQQmU2YKnciKz
 pAInINe54IYetDGNEnc2osSbklLkzD2idFuUA/Eq6zOMtekHUyANGAs2oc28rV2ROYr7
 X74Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741276085; x=1741880885;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jYtwJvU4r0akXgP5T1pK8wv7rwtoSTLrcOo1FyW8tGY=;
 b=XRR98az6h73bD576mP9YGOjLWSpRP2WBXhA8vKM/rMkcxB0dCfgZEKjiPxKwtlkmBx
 +lEf+q67Npl0W8sVqJItDZ3D4JxK3ZmtjIzzDrTtkiPR139201oW8/v5Gip6QB+RhS4p
 AL1kTvPdTi0swgGbZsRqPnmlcQ2RjR//MzvCG3oIFscMjMsB1SEvDxtYAzWe0ndNwrGz
 ujXLIObDUc2DCppIdpFn3/FhMPh0uDIJGO142PcNQnicXItMzJfc/eHZ6XpVmFBrjWxl
 kjNsz8DUlUoLYc8jeLpEkZsJ+ojPseV3Yd3CbvPVKIKgJrC0GQ6x0YyIfO3Q72VeQF//
 Tojw==
X-Gm-Message-State: AOJu0YyU2VzqaJl6ohviN20trhIstHDe1OTtVv2Vz1Vnbrc+OIiUD1km
 F08Feh+v9HT7ItAEzQOi96HyD6K6LSLtPOYpeKEiTdq24cAKa6sz9hksicfmiNJY6opHgclyPKc
 R4ys=
X-Gm-Gg: ASbGncsnnsdrTw7PGERw0dZE8BN8hygClL+FmcZOQKRDIslarhe9qBIuGyEQ87A/W4A
 BCgBsDNYgRpPVLy6JmZBwBNWNoCHDjN8UCQ/8ffX/VQeXOMJsKq9o/wqljP5WJPNqhZB8YAdl2h
 OF18YRvJObUw3kzFTeXhguY+z9KR07gby2UBMTfUioPmOGT8izGpu3kDrwiGP0m86Rz/cE3nnkf
 LDxfbW3q4NmRoKro1bKos9RiNlDzxp2W+uWnFnZScvwZJv8rl67S/0Nk0bv1flDD2MXIROajJze
 sAQ/xs3OUOwgOHZtIxLMkft749BMFqnyjeh9e3DBsLfL6Op4UCmt1qM8IrJVmtjO5IxaG6Si2jy
 Rzgn6MKtqH9zb7Pi2whY=
X-Google-Smtp-Source: AGHT+IEPfyxEDDZ6xKqz3aqxPSDwzkRuS+U+CuBxfsJpIpXa/vXfnfZO/KTHloQQxsScX+WegP5Czw==
X-Received: by 2002:a05:600c:548a:b0:439:8e95:795b with SMTP id
 5b1f17b1804b1-43bd29d8dbemr64346385e9.31.1741276085541; 
 Thu, 06 Mar 2025 07:48:05 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43bd4352fa3sm53125305e9.30.2025.03.06.07.48.04
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 06 Mar 2025 07:48:05 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 06/54] accel/accel: Make TYPE_ACCEL abstract
Date: Thu,  6 Mar 2025 16:46:48 +0100
Message-ID: <20250306154737.70886-7-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250306154737.70886-1-philmd@linaro.org>
References: <20250306154737.70886-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

From: Philippe Mathieu-Daudé <philmd@redhat.com>

There is no generic acceleration, we have to use specific
implementations. Make the base class abstract.

Fixes: b14a0b7469fa ("accel: Use QOM classes for accel types")
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Message-Id: <20200129212345.20547-3-philmd@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 accel/accel-target.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/accel/accel-target.c b/accel/accel-target.c
index 08626c00c2d..3236d6335b1 100644
--- a/accel/accel-target.c
+++ b/accel/accel-target.c
@@ -38,6 +38,7 @@ static const TypeInfo accel_type = {
     .parent = TYPE_OBJECT,
     .class_size = sizeof(AccelClass),
     .instance_size = sizeof(AccelState),
+    .abstract = true,
 };
 
 /* Lookup AccelClass from opt_name. Returns NULL if not found */
-- 
2.47.1


