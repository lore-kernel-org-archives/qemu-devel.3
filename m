Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 975CBC48BC3
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Feb 2024 14:15:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rc4Pi-0003RA-8j; Mon, 19 Feb 2024 09:14:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rc4Pf-0003MS-Ht
 for qemu-devel@nongnu.org; Mon, 19 Feb 2024 09:14:32 -0500
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rc4Pd-0008Pi-MJ
 for qemu-devel@nongnu.org; Mon, 19 Feb 2024 09:14:31 -0500
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-563fe793e1cso3629288a12.3
 for <qemu-devel@nongnu.org>; Mon, 19 Feb 2024 06:14:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708352068; x=1708956868; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=11KfkGQwT3DyJXfReiuxEKgaxGdeCZY+EPPlA79U4tU=;
 b=pTOXppyCCNnSKTiAvd73zmqstq3gnxuwl8txhpgdj1sonk/iAFmRQdPmqr2SV2npsq
 li+QMdS5IG+3ScnhuhzHNN5f6YvWk24ch+thKLTWf0aFouTHD3Lp9InjCuwCqkB+tubv
 dWvPFEh6zAIIUxnJEqH4mLWwhLvFi8eR/2JF+HoZEWtsvDHgpA3B6rl327eCe8BP0tyt
 XlGgqOHUej/oOs/pZLFayXFmWPSOdLjxHFOHsyD4jox4PmxTfUwk/GLGH59AW0Uzbycp
 RoC/fwpKb+XEDB/m2gXIbO7NIur9hyzYAf6VPH2IYi2F/R9iZJkAepvoabBhOtKZq8BZ
 85AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708352068; x=1708956868;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=11KfkGQwT3DyJXfReiuxEKgaxGdeCZY+EPPlA79U4tU=;
 b=u67isUKEt/Al2tegIKgVGDp69ol8x6LB4qWIGXhqhCCJpNGbHgBgt/nQBRgKd9RtvF
 Cv/tH4Qsl1lR/OMQBGTI3z8dUMSIjc31ad7Fm5STY+0tSfEO5SoXhWsPrOLBkzcsNd1U
 oNwckDK3oLgLxNaxS2LRq3UMs9MrnTIQ616V+Jrs1M7Lwkc1177dBQT+2YvPqkUQjnkT
 MYQjGGlnH/9gkDyr4CMhs032Z7UcI27X9X0zuMRcE/jwjkEYj/sZjeXo2mm9wn7e4o6g
 eAEoH5XIMxjgUyfZ9+/BUbvewQe+6jQw+Y0TdUjIEg8rYMMaHefmBsEGGNg9cUr0pWzM
 Iajw==
X-Gm-Message-State: AOJu0YwV7PpipVQR2ljGGViu8hjxXQ7fUVifTDLWanfyPQw1dd25pO8O
 SjlfEqAO4nzu8LG5zQF3S5io30oO9Sl28OwIAOBqpJaPHE+0oDuoUJwKmftI2P/Ljnwt3mc75z2
 p
X-Google-Smtp-Source: AGHT+IETYCEFpXzchz+BXlbjc5WCW+gYz2Guo3B1Sp9JkNHPWyqH7eULSPVQfml2IdnQ7YdjWl+ypw==
X-Received: by 2002:a17:906:a89:b0:a3e:a8bf:4c22 with SMTP id
 y9-20020a1709060a8900b00a3ea8bf4c22mr1345883ejf.9.1708352067862; 
 Mon, 19 Feb 2024 06:14:27 -0800 (PST)
Received: from m1x-phil.lan ([176.176.181.220])
 by smtp.gmail.com with ESMTPSA id
 vi17-20020a170907d41100b00a3d47ee62c7sm2983185ejc.124.2024.02.19.06.14.25
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 19 Feb 2024 06:14:27 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Igor Mammedov <imammedo@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Ani Sinha <anisinha@redhat.com>, Bernhard Beschow <shentey@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>, qemu-trivial@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH 2/5] hw/acpi/cpu: Use CPUState typedef
Date: Mon, 19 Feb 2024 15:14:08 +0100
Message-ID: <20240219141412.71418-3-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240219141412.71418-1-philmd@linaro.org>
References: <20240219141412.71418-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x530.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

QEMU coding style recommend using structure typedefs:
https://www.qemu.org/docs/master/devel/style.html#typedefs

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
---
 include/hw/acpi/cpu.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/hw/acpi/cpu.h b/include/hw/acpi/cpu.h
index e011d01adf..e6e1a9ef59 100644
--- a/include/hw/acpi/cpu.h
+++ b/include/hw/acpi/cpu.h
@@ -20,7 +20,7 @@
 #include "hw/hotplug.h"
 
 typedef struct AcpiCpuStatus {
-    struct CPUState *cpu;
+    CPUState *cpu;
     uint64_t arch_id;
     bool is_inserting;
     bool is_removing;
-- 
2.41.0


