Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21427C7115C
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Jun 2025 22:27:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uSk5q-0003LP-JF; Fri, 20 Jun 2025 18:20:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uSfaQ-0007o3-44
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 13:31:34 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uSfaO-0006UK-4T
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 13:31:33 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-450cf214200so20000695e9.1
 for <qemu-devel@nongnu.org>; Fri, 20 Jun 2025 10:31:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750440689; x=1751045489; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3gEBWmiUOZIjMq62oH3lhBWssCXqDPix6WpBdlVFuNo=;
 b=YyQfaxaVkZgtZODznXjFsIDUwqqXSaDPSpWKz1QsgYbjoj/CHOKAmseFn5M/EAMiAm
 JfkA3J7SVTgz6664IpJSnPX8l3QWM17u+jWPFaGVdrZOX2udCM7NTfjn0uJj/U4eVCHd
 nGUhb9SsraBCw8bd+vCB3GC8/M8eHeXnCuzPjudpEcdp2B7ZvFxdo3tHLUL+RwftcIwA
 aWCL803fgNK0ljVoc5H0XLyXI+ugM9uDzmGTNJ+MResvYXgkBcUrRetTX56fBxT8DOM1
 W+FVcNHcfgUufsbIpgrPU/kIAG/Ah91z76PyMGwpm4Pr35OLE8vxsKLSLIo/rY/tvjMg
 M9wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750440689; x=1751045489;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3gEBWmiUOZIjMq62oH3lhBWssCXqDPix6WpBdlVFuNo=;
 b=mwLdv1QUpO0G8N39Ck31rzD5co4huCfJHk1eTNg5/X/lrsG8z3GpVLCvgq5y7hmUMx
 NgqSV/DG+2pFBWjHreVWPITjW1v8ihMOxKyMd7O5AOIj437PNnEMCCRINpRYd/qFUhji
 bO5DhIGRZA0nf02fzNIhvpteeTIlUi92CRwBfdztTvilM7Pu0ADP8XwJiiNAtTcolC4u
 3P7rwDil55wFCrw0Et9dQYLTLgWLjbKCe/GX5VdAHn2h5dXn7JQ6ZB8Obi7EXHLTus6v
 IXBxUEguKfFZzVMxhcy/IJs/9pNBRFdF4QAIMkh6NNRz0Nh5CtvyKmirpt8185ste4+1
 oD9w==
X-Gm-Message-State: AOJu0YwLXjxDv2felLeZAHycY8P+NF1dnfJqkFBqQQkQSHMd0MTlPPnF
 3idsFmnpUyb/IPVLenNgKUKu+fzQwRbaoNi55LDI+I6SsgDJfUndZDkA645j7w/ygVso+zpP0sZ
 wgrBfBCvFBA==
X-Gm-Gg: ASbGnctCGDGcvhF4ip/aJZ+Agsx1PZdlrCRAVmvden5lKrxyeg2ry11udA/698k+9Xf
 0o4R6eRWzmeWwx4p5LLtKcgv7XpjqAOxmwRcRaTRQuMLsXClhN44+sWAfUBmxyXas0RJqF/fvhp
 kMyrqnDo7+PiF+nS2E89Ih5RvAU97fNHkzxTWNG/zhT5dBsIzLVtWKXaln7kuVxOJdaEwDShgyd
 dmRfLne3MGKmEcKlHZGrJ8yMu/sw+GrI0UTjgwuduzC5lseGwUU51YyE6W9bMRqi2RjfXN2dV0R
 SrX3GYfoxpQRyPuQDr9/LAhT3awZl6qwwtP7nIqf3iO0z64aJSZo0F1jU0vMOMT43xSbozIsXEM
 2T1E51LVlNZQ3qx38/DqfhT35whgAPu4kfsLUO5dY2qdhF4ZS/gvoKVWy
X-Google-Smtp-Source: AGHT+IGB5BnSAjnNc/z++zffeoAreXHb9kis41dz/r2SzhDg2iIKcui2BGOpg+oWjJMHN1yAkGwQoQ==
X-Received: by 2002:a05:600c:4443:b0:43c:f8fe:dd82 with SMTP id
 5b1f17b1804b1-453659ee9d9mr39278545e9.18.1750440689429; 
 Fri, 20 Jun 2025 10:31:29 -0700 (PDT)
Received: from localhost.localdomain
 (101.red-95-127-63.dynamicip.rima-tde.net. [95.127.63.101])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45361461375sm48846645e9.14.2025.06.20.10.31.26
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 20 Jun 2025 10:31:29 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Alexander Graf <agraf@csgraf.de>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Julian Armistead <julian.armistead@linaro.org>,
 Cameron Esfahani <dirty@apple.com>, Mark Burton <mburton@qti.qualcomm.com>,
 Thomas Huth <thuth@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [RFC PATCH RESEND 24/42] accel/split: Implement handle_interrupt()
Date: Fri, 20 Jun 2025 19:27:32 +0200
Message-ID: <20250620172751.94231-25-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250620172751.94231-1-philmd@linaro.org>
References: <20250620172751.94231-1-philmd@linaro.org>
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
 accel/split/split-accel-ops.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/accel/split/split-accel-ops.c b/accel/split/split-accel-ops.c
index 399bf71a9ec..5a36e22f205 100644
--- a/accel/split/split-accel-ops.c
+++ b/accel/split/split-accel-ops.c
@@ -249,7 +249,15 @@ static void split_synchronize_pre_resume(bool step_pending)
 
 static void split_handle_interrupt(CPUState *cpu, int mask)
 {
-    g_assert_not_reached();
+    SplitAccelState *sas = SPLIT_ACCEL(cpu->accel->accel);
+    AccelClass *ac = cpu->accel->use_hw ? ACCEL_GET_CLASS(sas->hw)
+                                        : ACCEL_GET_CLASS(sas->sw);
+
+    if (ac->ops->handle_interrupt) {
+        ac->ops->handle_interrupt(cpu, mask);
+    } else {
+        generic_handle_interrupt(cpu, mask);
+    }
 }
 
 static int64_t split_get_virtual_clock(void)
-- 
2.49.0


