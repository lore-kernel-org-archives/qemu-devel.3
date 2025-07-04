Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDB88C83F03
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 13:25:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXgPN-0007lu-34; Fri, 04 Jul 2025 09:24:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uXgPK-0007lR-0q
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 09:24:51 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uXgPH-0004Zg-QS
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 09:24:49 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-451d54214adso6419065e9.3
 for <qemu-devel@nongnu.org>; Fri, 04 Jul 2025 06:24:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751635486; x=1752240286; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=HH76J7mfgU0UHATrsly8PtSYCJ8tRSp+6d55yja7d/M=;
 b=Vp9HehnKipn6iHDEC6BLaWm6hQ0YKIPYw/ht3daBVx+l3IHDXgvCxcagIb/NJovxQ4
 0qOvBAf5XljDPHnTBM2NGAFFIbW35NZESkTE7Dq09U0a9T0wyPQyShwcGA41w6bTMisv
 2cPRyhoMOyDQ3/Iz5t+kvcZoS8hAu4Di08xRvtdRP7j4omESiD19tw/Pi56FSh27Nks+
 57inu8E9iRaI+AGyoEYYyW0kCcKGEb1OwHleL3IJ+1yr8UAnHTFefMGQEVsV83B3iBCT
 CTTQdzdZonsGr/hf9BlFjAUECJGDNHeesBfnt4BBeJ7uz3JlN6bdEg6KbOEzG91KL4Op
 KUXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751635486; x=1752240286;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HH76J7mfgU0UHATrsly8PtSYCJ8tRSp+6d55yja7d/M=;
 b=sxmJ8Qi/Jt6dOFky3Yd4v+Kty7FeSOayVcCVZtPE3zmjuhaiK/8utVztMtyHMnZRQL
 wqzlctICZyrkYvsnmJdWKalTONLqSvwSsNwBY8Pg+cBUt2yGoDxHD/pWc80IlR5Kz1rn
 tRLs3QlUaz2Y8ripPd7NEn/e0YmP83MQDxx7PNfxEQz5eOP34nUa6sFJGnabQCC+MQFe
 QzottBDE6gIpeaqTpEd4kv/4SD0UG3Jf+prPxAs2PEd5OMU+UE2wPdvcXhaVhpOt64lE
 Qv1CncMDCB+nBKbfmU+5PzahiPHY2n+18b2gROLuDcB/tGwzcFctp/l1z0CgcABYgFSJ
 AadQ==
X-Gm-Message-State: AOJu0Yy8GP+cUL8U6IUTE/0XGo79AOpMbEX6cK+xaTjHbbyjcquBbpUR
 JHK2BcRULhQE5ahRR5v7oFS1vNXL5Qp/dzwSBDyuTPR+CenbE+W+kFUToBIZwt6O7vgXWVeMBIZ
 QGIXU
X-Gm-Gg: ASbGncvi15FdOponZd/wng8F34M2vXPX83R7qU0G/Im3f4HTHsF7YufVL2FbJ0TvUSM
 lxppQ8SORXve2rECSscUhAx5W8D/Q63TQRdHnuczoDQioYSWosLhccOPm+1pgRd5aRpqAgPdjru
 pOzHexcYJHyto/Ynlb3st7wlstgLfAmrJAgi23sa4afI8h2stL5G8P3kT04jHYGR1GGdMg2dI6A
 DKr5iXMqjuGFm/WKb2OzEEse+kuSHfXIu+IExRRqCsDF1LuXT1ZGP5EOt7R4CE7dQvGytTt5src
 XlQ2eD1R58n6Fs1iza0KT8ocXOjJgMX8nrjVPHr5HAMTde+/8E4IeUFMRDwJW6CmjEmhP2ZT3yt
 VZARcAFuseSB0iJxqNA7H1/y0P2u5Ld1RTt3KGXIOMg==
X-Google-Smtp-Source: AGHT+IGdTNCivtsYp80WuVWzLj8uxN+DXxzGoI7NfG6q5VJ8XU5v3s7XY50WMQXw9czo3be/KF5aZA==
X-Received: by 2002:a05:600c:474b:b0:453:8a62:df34 with SMTP id
 5b1f17b1804b1-454b3161d07mr22227525e9.21.1751635485717; 
 Fri, 04 Jul 2025 06:24:45 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b47030bd42sm2459479f8f.5.2025.07.04.06.24.44
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 04 Jul 2025 06:24:45 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL v2 08/36] accel/tcg: Clear exit_request once in tcg_cpu_exec()
Date: Fri,  4 Jul 2025 15:24:34 +0200
Message-ID: <20250704132439.25743-2-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250704132439.25743-1-philmd@linaro.org>
References: <20250704132439.25743-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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
Message-Id: <20250701144017.43487-62-philmd@linaro.org>
---
 accel/tcg/tcg-accel-ops-mttcg.c | 1 -
 accel/tcg/tcg-accel-ops.c       | 3 +++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/accel/tcg/tcg-accel-ops-mttcg.c b/accel/tcg/tcg-accel-ops-mttcg.c
index dfcee30947e..337b993d3da 100644
--- a/accel/tcg/tcg-accel-ops-mttcg.c
+++ b/accel/tcg/tcg-accel-ops-mttcg.c
@@ -113,7 +113,6 @@ static void *mttcg_cpu_thread_fn(void *arg)
             }
         }
 
-        qatomic_set_mb(&cpu->exit_request, 0);
         qemu_wait_io_event(cpu);
     } while (!cpu->unplug || cpu_can_run(cpu));
 
diff --git a/accel/tcg/tcg-accel-ops.c b/accel/tcg/tcg-accel-ops.c
index 6116644d1c0..71776bc29c0 100644
--- a/accel/tcg/tcg-accel-ops.c
+++ b/accel/tcg/tcg-accel-ops.c
@@ -80,6 +80,9 @@ int tcg_cpu_exec(CPUState *cpu)
     cpu_exec_start(cpu);
     ret = cpu_exec(cpu);
     cpu_exec_end(cpu);
+
+    qatomic_set_mb(&cpu->exit_request, 0);
+
     return ret;
 }
 
-- 
2.49.0


