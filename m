Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCE5BC7115C
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Jun 2025 17:14:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uSfJw-0000Y8-0R; Fri, 20 Jun 2025 13:14:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uSfJr-0000VX-KG
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 13:14:29 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uSfJp-0004DT-Ap
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 13:14:26 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-451d7b50815so16967305e9.2
 for <qemu-devel@nongnu.org>; Fri, 20 Jun 2025 10:14:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750439662; x=1751044462; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=f6Gw4GJ2ttFA3nhU45y8rK3c9WCCnz5KKolptG+K1JA=;
 b=EGu4l18V3t6V/wtIbDgT4sXiCO9qaTfqbi4clY0CBbWYfTlMefHcVFexuXcf6/zMCU
 q9JHzmLl1NUTK5PJA4f7LjQocUqeFaY4fJjNDtuh+UnznfRHUFoUy+FdpuHVsvE5BviU
 ryyf5P7qPtyrvc/lrVtu4uKsfUzoodHe/8g2kT6QQe1MbJJozU8WwotIDkT1WEbDzZ01
 OmjRNHsMof1Lv5pEw5EZfSPwCrPwwQgr66fRpvINMyqq1cU3tr5ArOFK7ya6uQsGzdke
 NSNjyO9ZoJlx+DpOucNSlDY7FpwSZuzzTYSHWy9SEqLD3hVUSRyxhXVSOy5UxqbxbbiF
 ZNoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750439662; x=1751044462;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=f6Gw4GJ2ttFA3nhU45y8rK3c9WCCnz5KKolptG+K1JA=;
 b=JV4fas/grULxpzOhzDSjtF3oejdnToyevPE1BEfxvxZcH8laDjEsU2Q4GoAhxVoTa7
 +zog8ERznLspOG2110c3SkOmEscU2MEDC1dr8mOb9AoHclzfqZTwiIm/dLZO+klQiyiJ
 jPP5ZfFvpXDCtRiBiy9/kEZMohgL/nwuBo2X6eXo70PIlAnomI8qan7Fkkp2qrjmicYS
 fyFF7baveIqnyEPPCpOFk3VKTR7y1UZGyLQXMo23PjzpBckc50zxLNY4ytOL2zF/heE+
 X4j8pl2RfGhuzqA+pwR/lcpEufup/kZZmV29FkXYCgbEBQPlPxbrCaO0savAk/sUgVO5
 PHkQ==
X-Gm-Message-State: AOJu0YwXjsUyUG+gOf9U9TvqVyRI/jqKx98jL8F66CKT9X6FXOHYW8Yu
 F81tI3V7VApRulORgamzbX0iL1abFumN/2TYcjjuCsFjztILNKWt41QIxkey90kOOjnckjTsnWm
 WG3N7G6E=
X-Gm-Gg: ASbGncsBc4cPTfeXmVHGjBs8lPJE3wjYucsYrTvpCIj6pf1sInFC6ND7bqAoaj0MpSL
 rN7LBBEgjvsY0HkDOWXN+YmnoITOwWS/XE9yPTc8f7GuI+PuNWK//qjLsD2oiQa5fHHLPXKd1H8
 VnFCxcZ9nYr+AmOSk+qoZfXftV6+3c8a8nSvYYJA8wJY5G2jBt9rUJq32njR4TU7ubiWjg9Yy6F
 a23iwm//FZ7bi5hAYbCLUc/Ls8ecEQcylmnYzcNNr94o/SyhAEcZKmO5FA1SsTm1KLNh3kUX3Tt
 6zV5UUSXmGy5nkoPsJNNXzrTYVs25VHdneWyfayhq6rTX8EtY1oZ41i5rMeENam+MoP/cCEVa1C
 l8rIPqleudK+95oUjlmxAr+Qs/9EFg65JmQsG
X-Google-Smtp-Source: AGHT+IEyvPUCgUHJyiJlNTeA/hJ+AhftyiHS4re+UtnlyZv09+jtykpVYtuzuYFQ3eo+mpNE3qy/sw==
X-Received: by 2002:a05:600c:4690:b0:450:d4a6:79ad with SMTP id
 5b1f17b1804b1-453659f5746mr31536315e9.23.1750439662356; 
 Fri, 20 Jun 2025 10:14:22 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45361461375sm48483875e9.14.2025.06.20.10.14.21
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 20 Jun 2025 10:14:21 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexander Graf <agraf@csgraf.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Cameron Esfahani <dirty@apple.com>,
 Julian Armistead <julian.armistead@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [RFC PATCH v2 08/48] accel/hvf: Re-use QOM allocated state
Date: Fri, 20 Jun 2025 19:13:01 +0200
Message-ID: <20250620171342.92678-9-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250620171342.92678-1-philmd@linaro.org>
References: <20250620171342.92678-1-philmd@linaro.org>
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
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/hvf/hvf-accel-ops.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/accel/hvf/hvf-accel-ops.c b/accel/hvf/hvf-accel-ops.c
index ec82b79b515..6a612599856 100644
--- a/accel/hvf/hvf-accel-ops.c
+++ b/accel/hvf/hvf-accel-ops.c
@@ -325,7 +325,7 @@ static int hvf_accel_init(MachineState *ms, AccelState *as)
 {
     int x;
     hv_return_t ret;
-    HVFState *s;
+    HVFState *s = HVF_STATE(as);
     int pa_range = 36;
     MachineClass *mc = MACHINE_GET_CLASS(ms);
 
@@ -339,8 +339,6 @@ static int hvf_accel_init(MachineState *ms, AccelState *as)
     ret = hvf_arch_vm_create(ms, (uint32_t)pa_range);
     assert_hvf_ok(ret);
 
-    s = g_new0(HVFState, 1);
-
     s->num_slots = ARRAY_SIZE(s->slots);
     for (x = 0; x < s->num_slots; ++x) {
         s->slots[x].size = 0;
-- 
2.49.0


