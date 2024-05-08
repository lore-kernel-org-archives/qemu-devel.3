Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56DABC04FFE
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2024 17:46:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4lMe-0000O1-OY; Wed, 08 May 2024 13:46:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s4lM9-0000KT-0A
 for qemu-devel@nongnu.org; Wed, 08 May 2024 13:45:30 -0400
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s4lM6-0007Ic-EJ
 for qemu-devel@nongnu.org; Wed, 08 May 2024 13:45:27 -0400
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-a59a5f81af4so1227611766b.3
 for <qemu-devel@nongnu.org>; Wed, 08 May 2024 10:45:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715190324; x=1715795124; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UIF3u0N5I7QP9EtogOTWS3nnNPFic90FVU2Lm7bwK+4=;
 b=hMQCv4M5UWNYSO53L0UIrp4qg+W4zPVRPVXzumcndqPGS65zkcFOv/djRZ0i973XD2
 x9d/lf3J51BNNKgL0rCuWSk0RZkwKIn4ilPBqefxKNCxD6VGH6GUPvgwuQch9fM56dSw
 xqXvaXogCBhA0XzPdBYhodaLcA/fNOgIqNXQHOwtQzj3p3Q9G99t9BfJKKr9+k0P21HI
 4jA2voYm59IhBCLs5Z1U3iBf3tUKPJdpyWBsJWPU3aiYOTN1Dxiqjxc8zrMFBfBE3Q8E
 s8DeMivA63wI8QRIjQ78lng7StlHrsE746Vpgh3qiqgTgWBdFYVNAhKATLHE3xyB8KtR
 og2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715190324; x=1715795124;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UIF3u0N5I7QP9EtogOTWS3nnNPFic90FVU2Lm7bwK+4=;
 b=YV/vvI4ZLcyQa6W2PDwmAm3C6xN5DylKkyD4kHQagzosjCzPAjRBUNB9oIt9WMbbqP
 7CYwNx/E+vEeE3sizjk5kKZp8UaeXQsaDkMuJ88a3oe/h8QLF/poUAgRS8pRdRLR0z0Q
 FJoqIXcrJpfe89hbd5ippqYVO6Fhwfv9/oz/XCnA310hML7MXzCc7PuqVnSYil98qYpW
 RMNi9WEV9FcGQuOuRxlNebRpdNmSJKgVFXAp5bfQoZ4lT3vuY89lye6hokoNhohsqIkT
 swci4WCdfF/HGJzIZdp3niYkwDlN50q2PpnG0OP6+YI8jWJ2tvuzWGIDdP8yLfeMSLPi
 udRw==
X-Gm-Message-State: AOJu0YzocqTRb/a2irAn/vW/kCHhg0K8dUFLZsELCOC+D51xZriHzpyB
 /8lEzmItQMkkOHz7Fpt0mS+q8Ui7LeBz0rdye/q3N5x8gjQUcIL5OiEg5wpDWao71fFcvEuwlsg
 J
X-Google-Smtp-Source: AGHT+IHFtNnKIpPHWs5X5ndEAEwcPC8b1aIJGPBTCnfSHnF8xy4tRg7n+BZkq+WGVvTU7Xx38vM5FQ==
X-Received: by 2002:a17:906:f8c4:b0:a59:bf43:4e40 with SMTP id
 a640c23a62f3a-a59fb94a651mr225408466b.14.1715190324214; 
 Wed, 08 May 2024 10:45:24 -0700 (PDT)
Received: from m1x-phil.lan (sar95-h02-176-184-10-250.dsl.sta.abo.bbox.fr.
 [176.184.10.250]) by smtp.gmail.com with ESMTPSA id
 jl24-20020a17090775d800b00a599acaff03sm6667049ejc.19.2024.05.08.10.45.23
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 08 May 2024 10:45:23 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 02/26] target/ppc: Replace g_memdup() by g_memdup2()
Date: Wed,  8 May 2024 19:44:46 +0200
Message-ID: <20240508174510.60470-3-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240508174510.60470-1-philmd@linaro.org>
References: <20240508174510.60470-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::636;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x636.google.com
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

Per https://discourse.gnome.org/t/port-your-module-from-g-memdup-to-g-memdup2-now/5538

  The old API took the size of the memory to duplicate as a guint,
  whereas most memory functions take memory sizes as a gsize. This
  made it easy to accidentally pass a gsize to g_memdup(). For large
  values, that would lead to a silent truncation of the size from 64
  to 32 bits, and result in a heap area being returned which is
  significantly smaller than what the caller expects. This can likely
  be exploited in various modules to cause a heap buffer overflow.

Replace g_memdup() by the safer g_memdup2() wrapper.

Trivially safe because the argument was directly from sizeof.

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Acked-by: David Gibson <david@gibson.dropbear.id.au>
Message-Id: <20210903174510.751630-27-philmd@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/ppc/mmu-hash64.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/ppc/mmu-hash64.c b/target/ppc/mmu-hash64.c
index 5a0d80feda..0966422a55 100644
--- a/target/ppc/mmu-hash64.c
+++ b/target/ppc/mmu-hash64.c
@@ -1188,7 +1188,7 @@ void ppc_hash64_init(PowerPCCPU *cpu)
         return;
     }
 
-    cpu->hash64_opts = g_memdup(pcc->hash64_opts, sizeof(*cpu->hash64_opts));
+    cpu->hash64_opts = g_memdup2(pcc->hash64_opts, sizeof(*cpu->hash64_opts));
 }
 
 void ppc_hash64_finalize(PowerPCCPU *cpu)
-- 
2.41.0


