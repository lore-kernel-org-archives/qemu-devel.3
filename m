Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D7CEC3DA7F
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2024 14:37:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sebaj-0008OY-BS; Thu, 15 Aug 2024 10:36:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sebai-0008N5-66
 for qemu-devel@nongnu.org; Thu, 15 Aug 2024 10:36:40 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sebag-0006Sf-Ei
 for qemu-devel@nongnu.org; Thu, 15 Aug 2024 10:36:39 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-367963ea053so669424f8f.2
 for <qemu-devel@nongnu.org>; Thu, 15 Aug 2024 07:36:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723732596; x=1724337396; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=kw/kMF2UrPFy/1Y87Dczx++p4s+nUe86BSQw9sw3PK8=;
 b=egi9Y8hYPRy+/HeByUkCiG04B34XyN84g/eFf8D7p8nXHw9NrVpf7EY1HFvO5JIe2y
 +rue4tJc7u6AyK8w45m0uoeG2xSwXC/TKE1TQEXp0YRdxw2EgIGKJecI5RdL7c/vr6MS
 ZSOGnr0Q2YrsHpFB8iInqRE8CgTH5A9vY4fNwVQL8P4TuFb7Va6oLtspcu0Lyw31sF53
 QMV2A5mBFsveHVSm2pdEZ3PVDVmZ/xbXJgPHiWo/OsOnaSmEsv9t6kt0oa3lffJ5SgcW
 kQGR4bt73m0UO8TjkXmUGzpP/qHe6i+h5RXASVWD1gB6gkudgwoOYFmYCminCchbs5mW
 5Snw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723732596; x=1724337396;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=kw/kMF2UrPFy/1Y87Dczx++p4s+nUe86BSQw9sw3PK8=;
 b=WenM5LfBEkh02l+2DH2ahBED3LDy51F8rdwVXatO3x+xszQCm/wBdaULnttn1pom1s
 W/VcpAxhPE+PNkRWPfC25/Fygb8zqVbIfpNzU240ux8N3yVDzaQFljBV6NKUszjiMTvb
 d7+5GO19Wb2ZoFl+6FNfzgujYiFidyn57fzD2QcYC3ERiSHMxMubV/PB2ENXQxZbJKrq
 8U5JCY78yI4zueNZSsMUFpBA4Y25Jn4XbF0pbcPEHCpgjSLehV02wGgddjVBMjGIjJ8r
 aYxRRmunsBrMGSHKTPQ+uqTqxa0xYeERt1jk9Jlv3j3106fORkfmUr/5k8etSvf5POuj
 e3Uw==
X-Gm-Message-State: AOJu0YxCVDOss2uDZDjD4I8nKvaJCSll5GPNomUhwh4PtLCIIrTvjkz6
 HR16VMX0ID5uBi9oI1DF3wPLLAQN6zGSB+0hcD98okMKAqeqyddAxHDuMwyFrvJuPqIVgEtIWLt
 s
X-Google-Smtp-Source: AGHT+IH+IJcPuQwYLYBiTxJK49qlzqTiCEGLtVwQJ/COobM/l80Xee7cQVq5/WJcUM4Fq8zAYCCt/g==
X-Received: by 2002:a05:6000:4388:b0:371:83ae:809b with SMTP id
 ffacd0b85a97d-37183ae8285mr3118007f8f.4.1723732596272; 
 Thu, 15 Aug 2024 07:36:36 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37189839f16sm1667146f8f.18.2024.08.15.07.36.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Aug 2024 07:36:35 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH for-9.2] accel/tcg: Remove dead code from rr_cpu_thread_fn()
Date: Thu, 15 Aug 2024 15:36:34 +0100
Message-Id: <20240815143634.3413679-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42c.google.com
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

The main loop in rr_cpu_thread_fn() can never terminate, so the
code at the end of the function to clean up the RCU subsystem is
dead code. Replace it with g_assert_not_reached().

(This is different from the other cpu_thread_fn for e.g. MTTCG or
for the KVM accelerator -- those can exit, if the vCPU they
are responsible for is unplugged. But the RR cpu thread fn
handles all CPUs in the system in a round-robin way, so even
if one is unplugged it keeps looping.)

Resolves: Coverity CID 1547782
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 accel/tcg/tcg-accel-ops-rr.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/accel/tcg/tcg-accel-ops-rr.c b/accel/tcg/tcg-accel-ops-rr.c
index 48c38714bd6..38ab16244e3 100644
--- a/accel/tcg/tcg-accel-ops-rr.c
+++ b/accel/tcg/tcg-accel-ops-rr.c
@@ -302,9 +302,7 @@ static void *rr_cpu_thread_fn(void *arg)
         rr_deal_with_unplugged_cpus();
     }
 
-    rcu_remove_force_rcu_notifier(&force_rcu);
-    rcu_unregister_thread();
-    return NULL;
+    g_assert_not_reached();
 }
 
 void rr_start_vcpu_thread(CPUState *cpu)
-- 
2.34.1


