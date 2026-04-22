Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D953FF9EDC5
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2026 12:54:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFX5h-0006u2-Ii; Wed, 22 Apr 2026 08:54:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wFX4m-00061u-Iw
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 08:53:09 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wFX4j-0005Vn-K1
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 08:53:08 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-488ad135063so47385025e9.0
 for <qemu-devel@nongnu.org>; Wed, 22 Apr 2026 05:53:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776862384; x=1777467184; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9fpr3Ng7R6+bvHtx79oLF5EYo5OylKP6gzyU2DP/N60=;
 b=DcOwuHQXBQBgBOgYnWRfyoqu1IOQKXkxDvJMajF5zbh1uc5e39Jw1SZ5ihhFKbBg+U
 8G7gb6+kwP+qL4UNSvSvPgyUBCLSGWz28Z9jLH8OF40TzphpaIZVbKLykyshAzWDSlom
 sOOZ1CV3GAQrPn00vickrWDNhlSHTNMsDLoGXu36jmw3yhfAE6ueOvwUdx2or132vANQ
 94j41jp9U/1FOLdIx+XHQtbmgDYvmuKqrsiN+CG3aucj+GJKjmxOtMkHL4kMp3HORdJV
 8neLsFxGatemL3VMWivJ4W62uFHg91Wxmo1zl2EG3B6MSDlJx1wpUiLaPhH0DQkoo/hR
 WMgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776862384; x=1777467184;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=9fpr3Ng7R6+bvHtx79oLF5EYo5OylKP6gzyU2DP/N60=;
 b=segPjqkii4DlUB4Kmcg5bOhICWZwiMJbFnWuwxKRzxPcANEL0Sr8UR1ng/aaKoFjb4
 T3LqMdcM2IWE8RnD8zoi2dSk6FlUekd6F5QhfGoStcdq2qkmhUokBEPNU+rf8MQdTAeC
 dtrtLV2jFezllbFiO0cacGIheZ0TaBvRQmEh5s1eWOv22Y4USKzNqAb0cmAk5ipisz1B
 nfTpS6IGSC9zP25Ekz9QIUb2kjDhPM5lyUhX8CQZf6US3yLQcH4Kzqp/NKP4EuVsyMln
 STqRG3Jex6qt5ec+jO1gyn9sZ1CHgijFA0p6OEgUetydrboW39o8mIn0bt66I6rHgqFt
 LHOg==
X-Gm-Message-State: AOJu0Yw6dozfpmx26gFlsHNrq9w+Mp0JY60bltBiRel64K/ku9318DT+
 2X22zlM0yosXVoQedfvNdwBoQw6OZQnR/xUrV3hN882WyE5NdscAAHlTr+kj8/Sou2s=
X-Gm-Gg: AeBDiesRu2/6xXdBemYgXGerIPwStZR5PBR11obdeveXfnjGDWloaeDZEHGx7Y/oAy5
 z/YvQTKMQe+UsB1M8EqQikvIxVDhayEX+p6Fz6CMQrK3m1AxSEDpuAI0zch/higNPAkiIoOkFHq
 jv/SdiFBNE6u44vmTi/ZF8RqAdvA4XCOXEJ4UTPvVw5JP+u5deGUSzOlzxrC06BpmNvyuhbboJA
 Npyf0a58lBk8oy1kdVAiUgqTynPNl/kwCt/cKto0ZVLXgT8pd7W+mowXrat/GDHEWz7d7BEE+p8
 Z5fLjAOZTNqaTxdPGspo784Lnjl6Jy9foJq1EBT8o04IPL6lYnJd+xxk6yOJfdQ1212KISnlK2U
 /9JdOdUnxiypEsZ45KvABiOgVX/F7axiEq4U6+1Pburj2b41J9YLx9k+IwEJkiJH+YKtL3q+E6I
 XoTquQ3U3O7PcVBccs0sMPPml20sbHsfV6Sw6A6eapkvMl
X-Received: by 2002:a05:600c:8b55:b0:48a:57e1:d8cc with SMTP id
 5b1f17b1804b1-48a57e1d8d4mr85199615e9.9.1776862384161; 
 Wed, 22 Apr 2026 05:53:04 -0700 (PDT)
Received: from draig.lan ([185.124.0.195]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a5499b0edsm137343125e9.14.2026.04.22.05.52.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Apr 2026 05:53:02 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 3D0B3610BC;
 Wed, 22 Apr 2026 13:52:52 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pedro Barbuda <pbarbuda@microsoft.com>, Alexander Graf <agraf@csgraf.de>,
 Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>, kvm@vger.kernel.org,
 qemu-arm@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v3 16/32] target/arm: use syndrome helpers in
 arm_cpu_do_interrupt_aarch32_hyp
Date: Wed, 22 Apr 2026 13:52:33 +0100
Message-ID: <20260422125250.1303100-17-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260422125250.1303100-1-alex.bennee@linaro.org>
References: <20260422125250.1303100-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32c.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

One more step towards dropping the old #defines.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

---
v2
  - drop excess brackets
---
 target/arm/helper.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 7389f2988c4..40dd070d2c1 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -8898,9 +8898,9 @@ static void arm_cpu_do_interrupt_aarch32_hyp(CPUState *cs)
              */
             if (cs->exception_index == EXCP_PREFETCH_ABORT ||
                 (cs->exception_index == EXCP_DATA_ABORT &&
-                 !(env->exception.syndrome & ARM_EL_ISV)) ||
+                 !FIELD_EX32(env->exception.syndrome, SYNDROME, IL)) ||
                 syn_get_ec(env->exception.syndrome) == EC_UNCATEGORIZED) {
-                env->exception.syndrome &= ~ARM_EL_IL;
+                env->exception.syndrome = FIELD_DP32(env->exception.syndrome, SYNDROME, IL, 0);
             }
         }
         env->cp15.esr_el[2] = env->exception.syndrome;
-- 
2.47.3


