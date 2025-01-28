Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BF51C0218A
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2025 14:22:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcmTh-0007lK-MW; Tue, 28 Jan 2025 09:22:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tcmTg-0007kj-DM
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 09:22:08 -0500
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tcmTe-0002Jm-TM
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 09:22:08 -0500
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-38637614567so2782493f8f.3
 for <qemu-devel@nongnu.org>; Tue, 28 Jan 2025 06:22:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738074125; x=1738678925; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=seznNsDAaQBVSpbp55D/hE//Nvg+4oVvDGjyXY54BGQ=;
 b=YRx7DfBT86YHuIWIWgciW0Z6EMmb1wgPrN/a2cJ4JkQxd2riiDxE8vVWb0xviFwUMY
 8rHpAbXOmTKlDuX6qcGqhmKprMJ5hSUSqk6F4uIU1YGs+5VZfunB2xQ2jy9hsDafvsKY
 FtB7ssge/POqp3frHoQCRM+ZQEpGH7iST01nZLKQuTGKTSzgoJ5NKJimHiZBWp12BK+t
 +JAMi+OfDNXfekI6wOHdfu+xhP0roVefm5SbfOtXc+yCguEeYsoD8/qJlrN/UYStvGLE
 xGezmuHPRZ4kO2b289IGuKchBT3y9fnsOWR+4eeiKTvXrCnTJh6VLCH1wrjtbMoaOavy
 WNEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738074125; x=1738678925;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=seznNsDAaQBVSpbp55D/hE//Nvg+4oVvDGjyXY54BGQ=;
 b=Pqz9d7uDlO5YuI4BxUKAN4xiZtB1nG83bISSiKbot2LWqAUC5BATnl5+Pr3yn0kqJb
 7rq8t4BqzyUUzVBr1zErCxko58IR6zmvuAJhJ7RVhE6yvghOZTgWzRDQVchPIEis6vQp
 NV7Rj7++teDpVWNlwh/Jrv7v0D0K04zxysy9ip0eMee0l0jVRBvzbm1L5poy0dwqBZDU
 13rglu+jD/bOZ1S1yEk7K2j6PKm+mIfUtKiBG41szEDksESLq8qF7jpYnDBmf2IFebpW
 dFDhHBtzssbnUpB0SOKRMpAeEt1DRP7tlDfaQTDVuINiQ0CeUC3ey+IaTkZxg1D538qm
 Gjng==
X-Gm-Message-State: AOJu0YwTbQb0xlDkZ7UExQBDbiX5qBmtd710mqzYZqN+oulBBowBjGMM
 5WBLRi31vP7XCQiOupp79Z9NyX77zpCWi1zhg2/565yGHZoT1UOFiFuVe7veAasuSVX7vO3WLN0
 2v3w=
X-Gm-Gg: ASbGncs0R1iyHx3Y9xTyQCPuHfRngf7kjFAOutB8g8mxgMZMgLBl1AmrgtMvPRvNPWs
 3Tnk9vUCif+ljg0R75fTfIpwTMm0Hl7XbtY/Jp2btk24KB3GRXWRJjyeN4vVJmyLwwtw9s+FGfe
 /B+JasWM+5w+I3eLZMMMMZtSLxDOqzKeUEB3gRbf9Trt5Sw9hB+EVsQPWpLIeI03i7rbRp3D5Y7
 5uCQIVRK8kjCyDbdZ5zWIc1LuU4BJkxSGfKUCH268g0+jwAInomistefWdVchRfxDLKpx77k0Gw
 WmxqCdQPUfDRUWAJZ8UAiku1SxQFO0ODNeXFLtOd7vPnsT5BN4q1YnEKgRpxdmvsng==
X-Google-Smtp-Source: AGHT+IE++a185aCVAwGW9af+PNdrfc3K4O3/zeNI4/CnMV32fBXiZN0yIo7Y1YMI+EEIUBCDGyE+Pg==
X-Received: by 2002:a5d:6d86:0:b0:385:df6b:7ef6 with SMTP id
 ffacd0b85a97d-38bf57c94a2mr50508168f8f.51.1738074124946; 
 Tue, 28 Jan 2025 06:22:04 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438bd5732edsm169125225e9.36.2025.01.28.06.22.03
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 28 Jan 2025 06:22:03 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Eduardo Habkost <eduardo@habkost.net>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, kvm@vger.kernel.org,
 Zhao Liu <zhao1.liu@intel.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [RFC PATCH 2/9] accel/tcg: Invalidate TB jump cache with global vCPU
 queue locked
Date: Tue, 28 Jan 2025 15:21:45 +0100
Message-ID: <20250128142152.9889-3-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250128142152.9889-1-philmd@linaro.org>
References: <20250128142152.9889-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x430.google.com
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

Invalidate TB with global vCPU queue locked.

See commit 4731f89b3b9 ("cpu: free cpu->tb_jmp_cache with RCU"):

    Fixes the appended use-after-free. The root cause is that
    during tb invalidation we use CPU_FOREACH, and therefore
    to safely free a vCPU we must wait for an RCU grace period
    to elapse.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 accel/tcg/tb-maint.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/accel/tcg/tb-maint.c b/accel/tcg/tb-maint.c
index 3f1bebf6ab5..64471af439d 100644
--- a/accel/tcg/tb-maint.c
+++ b/accel/tcg/tb-maint.c
@@ -891,6 +891,8 @@ static void tb_jmp_cache_inval_tb(TranslationBlock *tb)
     } else {
         uint32_t h = tb_jmp_cache_hash_func(tb->pc);
 
+        QEMU_LOCK_GUARD(&qemu_cpu_list_lock);
+
         CPU_FOREACH(cpu) {
             CPUJumpCache *jc = cpu->tb_jmp_cache;
 
-- 
2.47.1


