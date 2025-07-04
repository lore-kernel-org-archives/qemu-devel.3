Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F0F5C83F03
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 10:16:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXdTG-0000ie-NE; Fri, 04 Jul 2025 06:16:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uXdTA-0000Ce-FQ
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 06:16:36 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uXdT7-0006yM-Mx
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 06:16:35 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-450ce3a2dd5so5914315e9.3
 for <qemu-devel@nongnu.org>; Fri, 04 Jul 2025 03:16:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751624191; x=1752228991; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=dFobWdh11IzhN53VTmVorncMVB6vG7uRGziOzupdhm0=;
 b=iX/UQnTxpvKPYBIJzy2p9i25OBQiumciz75EHkAhQOkae2v02k4b3zFGKtNWLiPvss
 jlrK14EYOmyZdbouZ4RdXK5y/MPqx/bgnRvllsWER+SV41ixXBTqI3Cf4v9I7gWKKY+i
 c89nZx/18FMsZmLg+Hll+KLnUKfudoiNA70U/Et/21J0rEBvvF79aMUVzsXk7IzPM+TO
 PkI5d8YfA2O0DzbZ8Lg3MMEO+tC4BeP3aMzahiOfzYssQTutYcPgpiZj9YehEAw3v+0Z
 RMNzr9E3jnc5JXj6F8q+VwqvKjL+MGphRfgkN50cFoeTRQaYsrBXsuSqDvLfjJNsNq3l
 0znw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751624191; x=1752228991;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dFobWdh11IzhN53VTmVorncMVB6vG7uRGziOzupdhm0=;
 b=EgVSekqCbloQ7YnYfpOkjxRj5W4slTMH7lSQobXjESpM01uJAcynPGlq/5XEevKKEJ
 BQFIeqFW4TCLh52G2VOJsojFd6/n3ivvRxtNUvMe4sNf4jNkmVTQqtEv7Id82k+hiTZB
 y4n4BgzuG3IEsk1DO0phyQT85hOSbdVC+NIRM+tcybd6qakl7twOUdzRMOK0cD/S6Dvt
 jBqOTlDrnKTO23Ct8+XPSUkAkO4L3knwMqlJjBZ1Teyk504UT/gKH42z+TRecBdpMoie
 nQEjwPDRyIm3rwznAiZzI4tRWZrYc9IzbhqyyhhuiggKcQ1HYCX3Z7IQj1ArIbEnRn3I
 6Knw==
X-Gm-Message-State: AOJu0YxA9e7kkTST4utITjFX6/6zGYQ8zdE1WvYmAI5M4FNglaOSExzt
 gcN4xzc+dxMPRisnpz+gWRslIiCduuqLIbuBUSfLn6A7hBRWDC6bR3kH9G89avQ/XR5UHlPr5xM
 8WTi4kdU=
X-Gm-Gg: ASbGncvWekrd6Ua6cYftFonOHAepUh8EzF6bbHW8PQ+Mmw9SFQxb54e9m7EfozzZ5Zy
 CpmwvKPdnRrHZQW5YG/1Ouz+wDnZ2Jw9Xd+zjT9FivLGFe4crwVf8W4jy36LVAb0NeImNBv8cou
 jCo8+twoI2B9eTMN5FX9SmR//6FuabWX7v+zLwsKwZBYzgQKpoXhP+7mtTEW4LBJG+kOCiD6WR+
 mjBXfFR0h16H5mFe5XCnb0ptwMdSATSC3Epji8Tvw1DT30Kx0vjmsXaYCimjNnMPdyPDVPW+x1P
 h4QPEzDR/K3IDwCf7fHOLs9vBaeQHagK8jj5XT3Sl+zX6116q4StyWV/7avF1oKxc63iBuVfRz/
 sgOzR3vFxMJ6iv/qXDpGnJPfNTWqPtXjBVmRv
X-Google-Smtp-Source: AGHT+IFGvDP96FT9707JTcu52eun1VIz5YX3LGlM1fAQyz3LMzrWUmUsm7p6BomSpnNJOCRbpm7YyQ==
X-Received: by 2002:a05:600c:8599:b0:453:483b:626c with SMTP id
 5b1f17b1804b1-454b50b0173mr9720945e9.23.1751624191300; 
 Fri, 04 Jul 2025 03:16:31 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-454b161e8f1sm22689075e9.8.2025.07.04.03.16.30
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 04 Jul 2025 03:16:30 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 25/31] accel/kvm: Prefer local AccelState over global
 MachineState::accel
Date: Fri,  4 Jul 2025 12:14:26 +0200
Message-ID: <20250704101433.8813-26-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250704101433.8813-1-philmd@linaro.org>
References: <20250704101433.8813-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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
Message-Id: <20250703173248.44995-32-philmd@linaro.org>
---
 accel/kvm/kvm-all.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 264f288dc64..72fba12d9fa 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -2588,15 +2588,13 @@ static int kvm_init(AccelState *as, MachineState *ms)
         { /* end of list */ }
     }, *nc = num_cpus;
     int soft_vcpus_limit, hard_vcpus_limit;
-    KVMState *s;
+    KVMState *s = KVM_STATE(as);
     const KVMCapabilityInfo *missing_cap;
     int ret;
     int type;
 
     qemu_mutex_init(&kml_slots_lock);
 
-    s = KVM_STATE(ms->accelerator);
-
     /*
      * On systems where the kernel can support different base page
      * sizes, host page size may be different from TARGET_PAGE_SIZE,
-- 
2.49.0


