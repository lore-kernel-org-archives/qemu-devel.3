Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01280CCFA02
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Oct 2025 18:34:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEtwU-0004Ni-BR; Fri, 31 Oct 2025 14:33:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vEtwS-0004N9-Di
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 14:33:40 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vEtwF-0006CJ-Ra
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 14:33:40 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-429c4c65485so678470f8f.0
 for <qemu-devel@nongnu.org>; Fri, 31 Oct 2025 11:33:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761935602; x=1762540402; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=PGUX2D/mVgJffc35+CNcs3kiIp9mGri+SCs7fWEJdZY=;
 b=hv+6Ygx4WFXlLcZeKp4KuJ6phJmyY9hyeY5TLrhrdi16Ak0zG7MPXtv4sx49YecynA
 vaJ/sbDtmEdLev2eCZBev6w2JlgooSsSqbakQOdKB9alkt+/2GPfh4zsQuAfCq3E9sgZ
 j+oWYqwxsiyKQm9cJjt23QqTO4CWwR45OK+drID7KdaaQ9pHqtZUGr9pyj4M+2+HQEHK
 GiX9Vc/5fij5NWmjnkLrXQT+gaM597Vie8bxaI93JBZkQcf1VhaQmQU8NSHxixQntz1P
 cqNMGSFtD0L5CfNxVlvNqZGzDDPQAjtmfoomvtUjFeqeyzvGrDAVax67PKvJ0Ae1sBBY
 ePbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761935602; x=1762540402;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PGUX2D/mVgJffc35+CNcs3kiIp9mGri+SCs7fWEJdZY=;
 b=h4ToPbJ3CG0VPQERfBDbAPPWIHbAn2mTXmB8W+0PJbnYgMyOXFnVN+vnJ0SmdHIsV/
 yAZLIH0aec/8EWiT2q/eH4Ntq4ykHigF2+FA3EF3zGhiZnfv/98D3ALL0cZrDvlQBXOc
 xtev3FO3cAJNIRJdw74jFxdxy3DOl8ujI2s0YxoMUpNRuKcTC0XDIpmG9p65KCyCwTB+
 vG7vwnzKPdog6sKhhmiP4Zo9zNz73Lqodl+2UFqj3C6o6W9g+ohRXJlX/SPQmoc7Vk9O
 32zcrS0bab+uisb5A1KHWtuUjnHs0uiz4/zFpLmdMNthMeDI5SkwCclfZSIFxbcVEmYY
 iUUQ==
X-Gm-Message-State: AOJu0YwNU+mYJ3mJS7eygfgGpt4oWHwNq5LdSPULO8QgIpubTU26bl0Q
 4mJ5+vNHv40DJZgkmOELb8EAdh5p/dqyUL9XSHnlrbKr0uQNFAZc5uyh+6thwD3dm+VyD/BeRzx
 MRXZt
X-Gm-Gg: ASbGnct2P2WJIPomeTtSst8MldGrxc7xwrzNC/xyWD29RYFEURm8SAhSZY8jkz6FxJ5
 WgSdXWBMLaskn3oB1yzB8ctRr4dE+igjR9NLgVuLOmgJVSoIjEMpOzzZC48In5QVuY5k5wNcxg+
 7StTtuk/n9ZvvUYJZ9OI88fi65r/4uGVlO/FJbfdncJEPmHKjNXIR5lM6/R8f36fyPtuRcWf9hb
 oHm/tcIEAI1MgUUc3mD9JFzZKkslTgReelhsFeNH/qv+CCGaCSuFUJ14SrXCcDccYFkEvu3sOPk
 F+vwKS+duLEXpQ8Iz2OHm62LQIypd9MlJORMuhotLb8b1INa7VUQdBP44OW09czN8OPFUCq4qYw
 axk4LNOPuQOx/9VPSr59SCJFRltMYj0rvxmhJSULcNTwt4AI7TfkftJXJYv12gBeu3FqWkW4dte
 z5JdM+uS6/FPgylU9X
X-Google-Smtp-Source: AGHT+IHeqwAMJ/ZwtDrzVJdxcXA0wIjRTNd0jTdw41YVhYoKQh9Ltix+soMgizN2lVMnk0F1o5qwzw==
X-Received: by 2002:a5d:5d13:0:b0:429:c4bb:fbc5 with SMTP id
 ffacd0b85a97d-429c4bbfdfdmr1478195f8f.7.1761935602056; 
 Fri, 31 Oct 2025 11:33:22 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429c114c944sm4859142f8f.20.2025.10.31.11.33.21
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 Oct 2025 11:33:21 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 10/38] target/arm/hvf: Trace vCPU KICK events
Date: Fri, 31 Oct 2025 18:32:42 +0000
Message-ID: <20251031183310.3778349-11-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251031183310.3778349-1-peter.maydell@linaro.org>
References: <20251031183310.3778349-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42e.google.com
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/hvf/hvf.c        | 1 +
 target/arm/hvf/trace-events | 1 +
 2 files changed, 2 insertions(+)

diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index 83db1088384..91bbd3a6aae 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -963,6 +963,7 @@ int hvf_arch_init_vcpu(CPUState *cpu)
 
 void hvf_kick_vcpu_thread(CPUState *cpu)
 {
+    trace_hvf_kick_vcpu_thread(cpu->cpu_index, cpu->stop);
     cpus_kick_thread(cpu);
     hv_vcpus_exit(&cpu->accel->fd, 1);
 }
diff --git a/target/arm/hvf/trace-events b/target/arm/hvf/trace-events
index b29a995f3d3..538af6e0707 100644
--- a/target/arm/hvf/trace-events
+++ b/target/arm/hvf/trace-events
@@ -12,3 +12,4 @@ hvf_psci_call(uint64_t x0, uint64_t x1, uint64_t x2, uint64_t x3, uint32_t cpuid
 hvf_vgic_write(const char *name, uint64_t val) "vgic write to %s [val=0x%016"PRIx64"]"
 hvf_vgic_read(const char *name, uint64_t val) "vgic read from %s [val=0x%016"PRIx64"]"
 hvf_illegal_guest_state(void) "HV_ILLEGAL_GUEST_STATE"
+hvf_kick_vcpu_thread(unsigned cpuidx, bool stop) "cpu:%u stop:%u"
-- 
2.43.0


