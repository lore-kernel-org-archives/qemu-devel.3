Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0DC0C677C4
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Jun 2025 16:48:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uNaC2-0004xB-AT; Fri, 06 Jun 2025 12:45:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uNaBz-0004tQ-LU
 for qemu-devel@nongnu.org; Fri, 06 Jun 2025 12:45:21 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uNaBx-0003Nu-7g
 for qemu-devel@nongnu.org; Fri, 06 Jun 2025 12:45:18 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-451d7b50815so20351675e9.2
 for <qemu-devel@nongnu.org>; Fri, 06 Jun 2025 09:45:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1749228314; x=1749833114; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=za4OfKA+ZM6zV60/HKnwP61V+8x3zdpeOiThEah6L0g=;
 b=GCoQGPp+QGNlneZQg8feSdT0IO5VTZqr0KjMrK1CWQ2f1Y8aaO9BqBy0lgGMUIONXb
 G2o3hyevlV2UCUHBZteNKEfYi4lVNjBHPXSwjUW7sVZwG1s+lWtYvrOYell6EshLDiSn
 Hpw+7N3BHorE7Zw5FUqqThKpLQYlwOEW3bIpJzNTSq5UJVq/Kx6eHI6o9Lj1fPCSIQuP
 m7uCYP1FeSHh9hync7vfnFyuJUqpR94owtIS6UplegRatqc9PQ6gy6ygNGfCgRDehAAT
 jvNySmcHoC7tqtyemt8Q6xXScdTPtmV6rKdNBJSYTZlsoaFrXtoD0Id+zLEDn8QhUk8y
 ouwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749228314; x=1749833114;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=za4OfKA+ZM6zV60/HKnwP61V+8x3zdpeOiThEah6L0g=;
 b=EMVDKXoK09EysVHVa4WDr0yO0WPj5I5C/ahdcPrtuAAYcBcpIrwC/Rsb9uqAI4sp+X
 3J3/irpMViUy/Q9WoKC71Po/YjRZ3y1UoFcC8NJpaHD0bQHh9fV0HC2PHLA5BiomOQ4w
 UDh1D3O8OqN6HOkzPYTihdHXxnC4oG1gvgiXZkSToymmWdN5nUHnc1jyINRhcOWHCp9l
 qPo2HaZ7/Jm0Rbd/V3YNQdZbg6A6zdSj8dHX8PLVvDoEvgseUGAngmbMPA+jYEMKg/CA
 k3H2Xe04vIzp3Jrwg2CmuremxhLcOwCy6MmdL7bUUcwWIRSDdwCib5l9D43IUzCVintO
 8fVg==
X-Gm-Message-State: AOJu0YzEw5r0WC2Cbmd5lxIGIpHcXOwCSLizaeySeuj98CiIZCX3QpWm
 W64SYn/NSJfZUHA2HMWkJVzkIx9XJ9r43ZNri0k8l4LeQwyYAu4JN89nKvyPvrn0jgYXUipy0Qh
 KgAYw0UZoBw==
X-Gm-Gg: ASbGncu3J1t9JkNQfWErNiey83JcGNsbKQKdBSc2PaWTbQ7OGXDJZy9o+iBHEDNce0S
 Gn17fuVxsRcsjaKtePePLD0Gxy1I/Ls0GHmEctVQE+JPeDc4uABHiBs0iF0oppzleJ/QNVKgvs9
 75Flvd+nM9JCfmaa4CNmTZ86TfLBM3/ux1+veUEM3kTrvGNzmS0olRl3mVf3udnKQqy2x8xlmvt
 0M6/K0OvI6yyqYMckBKCtgpRTwjZXJ6+KsT94tbENqwusxrMu4HTIlsydbbA6fLMfwDnLN9LmIl
 E/TvR8l7JQ+3jjw6h27wj5m2PEwWH1AACAXBZ9iJ5FTMQvOqxHdotc6sZuLIHfzkIe0VHcup5Vf
 Ah8dqf1hrIsjFBV2B5HXy+M0vyqAIXOLRPwvWPg==
X-Google-Smtp-Source: AGHT+IEjSinlxGgF0FigYMIbyMdqDg7XFFwUvXebA+wAtPU7UTy04H353qxRggmeMlVzRt0NOrPPTg==
X-Received: by 2002:a05:600c:1c90:b0:450:d01e:78ee with SMTP id
 5b1f17b1804b1-4520140b8b5mr42932815e9.24.1749228313673; 
 Fri, 06 Jun 2025 09:45:13 -0700 (PDT)
Received: from localhost.localdomain (59.red-95-127-62.dynamicip.rima-tde.net.
 [95.127.62.59]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a53229dea7sm2431121f8f.12.2025.06.06.09.45.12
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 06 Jun 2025 09:45:13 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [RFC PATCH 07/19] accel/hvf: Re-use QOM allocated state
Date: Fri,  6 Jun 2025 18:44:06 +0200
Message-ID: <20250606164418.98655-8-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250606164418.98655-1-philmd@linaro.org>
References: <20250606164418.98655-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 accel/hvf/hvf-accel-ops.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/accel/hvf/hvf-accel-ops.c b/accel/hvf/hvf-accel-ops.c
index 808ecea3816..f4a983d1328 100644
--- a/accel/hvf/hvf-accel-ops.c
+++ b/accel/hvf/hvf-accel-ops.c
@@ -319,7 +319,7 @@ static int hvf_accel_init(MachineState *ms, AccelState *as)
 {
     int x;
     hv_return_t ret;
-    HVFState *s;
+    HVFState *s = HVF_STATE(as);
     int pa_range = 36;
     MachineClass *mc = MACHINE_GET_CLASS(ms);
 
@@ -333,8 +333,6 @@ static int hvf_accel_init(MachineState *ms, AccelState *as)
     ret = hvf_arch_vm_create(ms, (uint32_t)pa_range);
     assert_hvf_ok(ret);
 
-    s = g_new0(HVFState, 1);
-
     s->num_slots = ARRAY_SIZE(s->slots);
     for (x = 0; x < s->num_slots; ++x) {
         s->slots[x].size = 0;
-- 
2.49.0


