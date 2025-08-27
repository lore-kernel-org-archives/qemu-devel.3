Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5897BCA0EFF
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Aug 2025 05:39:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ur8s0-0005MU-HJ; Wed, 27 Aug 2025 01:38:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ur8rx-0005Lr-CE
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 01:38:49 -0400
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ur8rv-0006lD-7M
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 01:38:49 -0400
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-323266cdf64so4720520a91.0
 for <qemu-devel@nongnu.org>; Tue, 26 Aug 2025 22:38:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756273123; x=1756877923; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=P/LENQOxma9sLlNHQfVZiYtvAKkgBC0iDr3UdZUm5Y4=;
 b=LHoXPT428Lg8fQigWkbS7zULZE/Asjy2rJoD+cFBIb734/ssTWYO/Z0XvV2KB/AtQd
 SoukstMrZd1exKk63OkjtBt4I3e3dnL1A6dtZDhLGX05AZnYYAIMqhnE2wugBHlOD190
 UN3YghvbrqFFoXaLntKAqcwT4kKf1IRspbQTDgsPeU7mDSZEzaHyG2CziZpuQGWGFj8S
 EbZv7lqkgxxFS85mhhP4Dql9efuG7SmbvOYfrO68WaWsCUnS6OqvkhwqRkNbi0WoNG/s
 XJqH6CcipEBbKmeuojpOJ5YuRpCLRM6nFAF5b1M2PZ7nqwh8SWviMoVxQ0bl0NajLmAx
 NdPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756273123; x=1756877923;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=P/LENQOxma9sLlNHQfVZiYtvAKkgBC0iDr3UdZUm5Y4=;
 b=Sx4XCJQte5+8/TShNaid8f+yIPeGUipZUHDFykivPuRvSvIeOeAQRC22obdMvcTYu7
 y4T9lkQZWiaJA4A9bhBR0PBi3VRi5vZP43lXX9miT9bVNW1hKDRJcC8MW+aMR3cpdzE/
 CAEzylEGIBispOKkSkG/8GUIucRzZU5gPIjElfuV0NNnIMMVe6JQj7q/1ho2C3+Ohh4g
 TOMyTGZw7TUWofCfFeWGAVjJysbsNg+ZmDQtdT/vh1DgwyyQYeFQZdDsz3opJCVFCeHO
 WJWosAAZ6wQRljRL3D8vFl7GF/okbbbAbg3su4921Yu3mbrFjyt2s5DWgsNLb1L6InO3
 1+iA==
X-Gm-Message-State: AOJu0Yyc9xig+xftbYRmt0/Qo2BWK0H9wsHUdXFCMbkHd+WCr1tqR1kg
 aYy7Hb8iXgqG/gEN0DnfMAO5HRE2CmfrtQajmq/KQHK1Pye+S9zW78DK7/Rb1/igLnR4GiK/mnf
 6jPNdb2E=
X-Gm-Gg: ASbGnctYdj3ZLBNbf969sOdlVGX5fovTdABbvFwALR6kf82+1IGZJxIRo8/8jBxF4JD
 CqlD2R1MG6ozE7RtewJ+Mt9MkgNE6qS4Gl4Xr+/i8a+fgpmGqEJr6DI6nsUlXDU7dDsquuHxIbz
 +ArH/0og1G9yK/5TF6SeVW6fwuDTaucHMpWACWPZnVbJ18RPIldIaqFeJe9PxDBt3EW/Y9wXlfy
 zr/c/9EUNp+O0ufrh0ZEPK58BTCVu8dt8ckqKhHvZ5vL7oksBpWmwf8WCCeHBA6Lfvxw8AruOs/
 O7MFJva/TG82QRc2PTB+RBVEBqrotXY1r8kNzzLDosQhSKc6S2H6EVPst5MdJcypTxFnGAvGvmU
 8aQeJMkdMPPI+ycGeo+3niWsnSSxRoFjj3Qqa
X-Google-Smtp-Source: AGHT+IHgsvwyHEG/8HvYpL/s4U3LtwfWQC+ywYEPdOfVkBHS9Ow+Kpo0Xj/EgHd/uB/a7ILDGD7TdA==
X-Received: by 2002:a17:90b:58ce:b0:323:7e80:8819 with SMTP id
 98e67ed59e1d1-32518b825b3mr21057154a91.36.1756273122933; 
 Tue, 26 Aug 2025 22:38:42 -0700 (PDT)
Received: from stoup.. ([144.6.121.55]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-770401af6b2sm12071868b3a.56.2025.08.26.22.38.40
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Aug 2025 22:38:42 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/2] hw/core: Use qemu_log_trylock/unlock in
 cpu_common_reset_exit
Date: Wed, 27 Aug 2025 15:38:22 +1000
Message-ID: <20250827053822.4094239-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250827053822.4094239-1-richard.henderson@linaro.org>
References: <20250827053822.4094239-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1031;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1031.google.com
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

Ensure that the "CPU Reset" message won't be separated
from the cpu_dump_state output.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 hw/core/cpu-common.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/hw/core/cpu-common.c b/hw/core/cpu-common.c
index 26321be785..259cf2a3c3 100644
--- a/hw/core/cpu-common.c
+++ b/hw/core/cpu-common.c
@@ -135,10 +135,15 @@ static void cpu_common_reset_hold(Object *obj, ResetType type)
 static void cpu_common_reset_exit(Object *obj, ResetType type)
 {
     if (qemu_loglevel_mask(CPU_LOG_RESET)) {
-        CPUState *cpu = CPU(obj);
+        FILE *f = qemu_log_trylock();
 
-        qemu_log("CPU Reset (CPU %d)\n", cpu->cpu_index);
-        log_cpu_state(cpu, cpu->cc->reset_dump_flags);
+        if (f) {
+            CPUState *cpu = CPU(obj);
+
+            fprintf(f, "CPU Reset (CPU %d)\n", cpu->cpu_index);
+            cpu_dump_state(cpu, f, cpu->cc->reset_dump_flags);
+            qemu_log_unlock(f);
+        }
     }
 }
 
-- 
2.43.0


