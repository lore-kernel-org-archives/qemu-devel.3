Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6597C3ABAC
	for <qemu-devel@archiver.kernel.org>; Tue,  6 May 2025 14:54:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCJXn-0005BL-3U; Tue, 06 May 2025 10:45:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uCJVB-0001YR-Km
 for qemu-devel@nongnu.org; Tue, 06 May 2025 10:42:34 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uCJV9-00026y-Oi
 for qemu-devel@nongnu.org; Tue, 06 May 2025 10:42:33 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-43cf848528aso43119635e9.2
 for <qemu-devel@nongnu.org>; Tue, 06 May 2025 07:42:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746542548; x=1747147348; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Wi+lV0/pTudn7Ibuemmr2NH/wCQ4m7bA75r+AsmlHj4=;
 b=yMYJ6xAfG2gD/4bUjNTawPdqzY4RtmIbA/HX3HE6j41XX1oRHi7W+dcmRZH2zYkewt
 NHET5l5wiwon66g27Hzuk50FP7gbM8pGdGgwTAtWAh3kwaVsM/Jq+AWUwEsLQ+fZUUbI
 lN4DbwwohlP7quYzsmtGIrovEJnNKAofYXqL05j64WBDPE2GAuu9nA2jsaTROAQl8wZQ
 6N1rExMjneWGDEG2u2mVfi4N3Jn7EuDDOI5lt6Xo40GICZtHPmaWsoeK1QAjtx9CkqyJ
 PyWfJncNfFLxnlyL0sWdilOFBZxj4cI/35/D5lWRyeZrrXqTvo2cexGkESz8esuAm8M3
 PoUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746542548; x=1747147348;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Wi+lV0/pTudn7Ibuemmr2NH/wCQ4m7bA75r+AsmlHj4=;
 b=fFMM45w5Ek1R4CB/rP4akv33zyZJ4weqeRHDJIbjArQcia4sNgB6jhvllEZRYgibRr
 toUuYFNOck/3ktzp7fpE3kfHy7ZR3YLwuoEezp2MfCsR0DcVTkwIriAguaG+WovlTTjz
 MyJHcz+jf3ZGmedlVjD+pfbMfCYT1uwrFmuRS+zodl1/oaQb2geLIn4RKgapIWAvVjb/
 CTZ5ao/nXS8b4RelU6Kw+4dPqtvjIz2Uw5AzWd4wukS0e5DREAuG42c33wntZzkJ/8Hw
 WYvcZUFUlFA7rbayp2qFX22ELyPZlvg4KUcZVudD/0LLxE9DUxd22u+q/XzgFnu5m1Te
 rRNA==
X-Gm-Message-State: AOJu0YxGz5+8nZZf+F0ABmGePLy1dFK9KvltNk46y9cI34RR1OG3UziU
 S0lLsR6DarivN3OEowoPKHrn2q+TB3Xl6iEQ/YTdvjTYEigTXAWokzUKecIh5ly/8PqJ74BGLxp
 3
X-Gm-Gg: ASbGncurF1FygRCxfTqi7YszRAtXAea+TJM+I93hzVLCEQnvmnj6NRvOsE0vku7Bebi
 IhpOZQsmOHacmiMF1Zop/fxch9qMPrzBP7BVj56+WxOw32g0N6G9Z44Q7gIruBYTRwE95P5Xmqa
 woj0XH/n9yWwoqh3VeZ6OiuNbz3Oi3LTUzc0GNc3GPDy0tOn90vgIpD3A6x1i1qc0sAt+N6dVJ3
 iS/atJXtlLkQnZf1bbaj8ltX2Fu7idBHVwh0mvNs9MF0TeuUnNQc+Me3g2qj+/K0QiKaKtIncGe
 Km5l9HMplfxc1APjwCOlOhjTqliz6e/d+Kpm1PHdq8LVI2w=
X-Google-Smtp-Source: AGHT+IHWitUy25/sZbKIiUtb+GEjF06Q+8yzq5T2+7D7EWgEAWU4/H/xn4jsezNUnO7IOCbtPVttUg==
X-Received: by 2002:a05:600c:1e85:b0:43c:ed61:2c26 with SMTP id
 5b1f17b1804b1-441d0fd2c76mr34942545e9.17.1746542548226; 
 Tue, 06 May 2025 07:42:28 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-441b89edfc2sm169603435e9.20.2025.05.06.07.42.27
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 May 2025 07:42:27 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 09/32] hw/arm/virt: Remove VirtMachineClass::no_pmu field
Date: Tue,  6 May 2025 15:41:51 +0100
Message-ID: <20250506144214.1221450-10-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250506144214.1221450-1-peter.maydell@linaro.org>
References: <20250506144214.1221450-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x329.google.com
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

The VirtMachineClass::no_pmu field was only used by
virt-2.6 machine, which got removed. Remove it and
simplify machvirt_init().

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/arm/virt.h | 1 -
 hw/arm/virt.c         | 4 ----
 2 files changed, 5 deletions(-)

diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
index c8e94e6aedc..27c5bb585cb 100644
--- a/include/hw/arm/virt.h
+++ b/include/hw/arm/virt.h
@@ -120,7 +120,6 @@ struct VirtMachineClass {
     bool disallow_affinity_adjustment;
     bool no_its;
     bool no_tcg_its;
-    bool no_pmu;
     bool claim_edge_triggered_timers;
     bool smbios_old_sys_ver;
     bool no_highmem_compact;
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 17a88aa9b25..e82b8a45664 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -2273,10 +2273,6 @@ static void machvirt_init(MachineState *machine)
             object_property_set_bool(cpuobj, "kvm-steal-time", false, NULL);
         }
 
-        if (vmc->no_pmu && object_property_find(cpuobj, "pmu")) {
-            object_property_set_bool(cpuobj, "pmu", false, NULL);
-        }
-
         if (vmc->no_tcg_lpa2 && object_property_find(cpuobj, "lpa2")) {
             object_property_set_bool(cpuobj, "lpa2", false, NULL);
         }
-- 
2.43.0


