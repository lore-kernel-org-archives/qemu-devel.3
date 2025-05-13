Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F682C3ABC9
	for <qemu-devel@archiver.kernel.org>; Tue, 13 May 2025 17:48:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEtjY-0007nt-U5; Tue, 13 May 2025 13:48:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uEtbe-0008ML-25
 for qemu-devel@nongnu.org; Tue, 13 May 2025 13:39:59 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uEtbc-000399-Kv
 for qemu-devel@nongnu.org; Tue, 13 May 2025 13:39:53 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-3a0b6aa08e5so39435f8f.1
 for <qemu-devel@nongnu.org>; Tue, 13 May 2025 10:39:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747157991; x=1747762791; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fZ+iRFzlsz++4RFD9fl5KNYh6wELAyZ06jqDq2TXAd8=;
 b=lxDLEpMId/WwWYWmtwN0ALnWCGjktA76umZDnrHyiO9iauuztAjA1/rGgw/FMICDTc
 1Vjm0fcu2jRmt0LFE0FfpytqlfG3MY6r2MSx9S7X/75exOLCOnsr/73mbyeltuEPKYKL
 UvARxRrUnNcV/VGhXsTYj+4S2u3Nd16OdYdT8zZGHzBYOJFqrwXdpyMVYpdTnXb9DwxY
 1UTXvnaB0VZ6NLsfmZQdZByLC3ObdMOykqZOP0dH9YLY1TR12eAE7KfnL//+UNEuM3jw
 Q7T78g51MY8E+REOWmcKAF6EQ8oZpl3O9xuG9aB+ls7AzLzNaXImOxhqYXuj+baMiFp6
 R5MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747157991; x=1747762791;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fZ+iRFzlsz++4RFD9fl5KNYh6wELAyZ06jqDq2TXAd8=;
 b=uk/ftjrBsD/hww53tz+p25G2ncmeTp3guH84Jr8g9KoW93QoBufdq5UZXvSb7MLZ9T
 y7N3UsZc87lBA1qw7z0tnRAr8FIVpltdTdOiim12rt5wS4EpuN1bcNSt5w1NN3gvRJfA
 He/ufB7fZz8lSbJ1oFfwxL+t/6/7uylj1G/3if7ccnrV+wsYrGQ8R1wAk1k0OpS/57WQ
 FOv3Z0MWauatYNQiLIcmbKbxA6X4PePk5HygV0ofIjryjz+OUb33PYb/0tqF7hti62Pm
 kYjzer8M93YZ5A2TjrSUOjS5DGZlAEobP5Uvr1mj8qqf3R7AJ8V9j0R/Sngl28u0r/n8
 gsAw==
X-Gm-Message-State: AOJu0Yy0z7A3eEBL1PULzfOL+ydELY3XuPaF7YHAkuLli6lwRvs6EwMl
 lKl6jnj+3w7tCjk6ykW1MvJv+09K5I4V4T0ePiknLXcaztcJhuOMYG+aTa0dXS3Hqul4Gmg3gtT
 czlM=
X-Gm-Gg: ASbGncujjkAKybeaOSvTYzciCB/2WPi6MgEXhJOc7zc2vyAH4pUysOmVIz+zR+5oIOW
 PHxlLF6DFFa81jtYRy7h/hoTMD33wHqTROV5qavb+gdocNwNCuV9inkgND368KLPfLt3qNnWujT
 oxGQZ/T9n2kKOeIndC/vBTKu+Awdg7SVnzVVage1iQ54TRnCFXnXLC5APkUnjri0VxvMw1KdmXe
 mrgC+QcEwjr23h+OxD5fUnABuSqsH4nJKoyb/V84RDtEm/WX0P0u2Sf6S+xiqUqDxCqZf+Tjd3Q
 gDxuG9qXVhGRHe+2MP2hzqOz3Q145/HKUMuFG1Czj4u2r5f4DEfUENldp3WLDaRBECaFYoaqS55
 OzX9+JFU9GPqWfK50HU6t/jKu8AiO
X-Google-Smtp-Source: AGHT+IHEX8qyR6nyxz3lFuciGpSkSB6FW0Yqx0MS2RyNHPDGPv4kGeF39UI6qKSPpb5Y7/5f1OzFZg==
X-Received: by 2002:a05:6000:4283:b0:3a0:8524:b480 with SMTP id
 ffacd0b85a97d-3a340d15a00mr3980462f8f.2.1747157990807; 
 Tue, 13 May 2025 10:39:50 -0700 (PDT)
Received: from localhost.localdomain (110.8.30.213.rev.vodafone.pt.
 [213.30.8.110]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a1f58f2ab2sm16803819f8f.46.2025.05.13.10.39.49
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 13 May 2025 10:39:50 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 04/19] target/arm/cpregs: Include missing 'target/arm/cpu.h'
 header
Date: Tue, 13 May 2025 18:39:13 +0100
Message-ID: <20250513173928.77376-5-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250513173928.77376-1-philmd@linaro.org>
References: <20250513173928.77376-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x431.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

CPReadFn type definitions use the CPUARMState type, itself
declared in "cpu.h". Include this file in order to avoid when
refactoring headers:

  ../target/arm/cpregs.h:241:27: error: unknown type name 'CPUARMState'
  typedef uint64_t CPReadFn(CPUARMState *env, const ARMCPRegInfo *opaque);
                            ^

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/arm/cpregs.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/arm/cpregs.h b/target/arm/cpregs.h
index 2183de8eda6..c1a7ae37356 100644
--- a/target/arm/cpregs.h
+++ b/target/arm/cpregs.h
@@ -23,6 +23,7 @@
 
 #include "hw/registerfields.h"
 #include "target/arm/kvm-consts.h"
+#include "cpu.h"
 
 /*
  * ARMCPRegInfo type field bits:
-- 
2.47.1


