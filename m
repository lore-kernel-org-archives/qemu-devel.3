Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 391EEE7718B
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Dec 2024 20:25:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tRGt9-0004Gm-OL; Fri, 27 Dec 2024 15:24:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tRGt8-0004GQ-MJ
 for qemu-devel@nongnu.org; Fri, 27 Dec 2024 15:24:50 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tRGt7-00051E-2v
 for qemu-devel@nongnu.org; Fri, 27 Dec 2024 15:24:50 -0500
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-43622354a3eso52042515e9.1
 for <qemu-devel@nongnu.org>; Fri, 27 Dec 2024 12:24:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735331087; x=1735935887; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tOiBkjb8mh+lWuc5hL1sFnWxqlY1hmRaS9nt/JCya4M=;
 b=P9lmwGmTDKeOMBVmx4pIn1O1WZ9Q33RqOq8nKZLMYQWIiKe9+y31/brpMlvg0/oohc
 TyN2NsIzkB2ByCsFVACQaHvMJHd22EEY1qqLdwwHBer66v9OZZbyf/GAZG7eagw+ME3h
 3/RDgZOT+M8kJsTJFgzkJEeij/NwBtbIt0oEzpb+9yN0Y2lXiFiHPz9dHqgJ6nZkUfmp
 KV1C3+/WBWm4qBKAf38Fy515M/V6Tsx6JM3LY50ewm3XsoN1hmRrzEUbz7Id/0FAsn+l
 cHOUuuah6oT/RsNB95MEVOIL25/RqC/ADffbEjDgnGCTtRDiCk5nqMON8UbDQP1Fdl0/
 4KUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735331087; x=1735935887;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tOiBkjb8mh+lWuc5hL1sFnWxqlY1hmRaS9nt/JCya4M=;
 b=FWHOpWpW5aHj4EgXHR3hB9qRdq+dUaYt19cB+gd6x+nicUfabeUgrtKer4r/jEs7Hv
 ebg5gOMnp9NBe8ErN/fRp69c4+kmJt3rHlLENSc/yvnmLLE5lkuIJZaqjYzjvHj1e4gB
 DB0/3vMiahguRDalHo9lCnTxxUqC+dbtn0TyzpCeHeUmeZtKMp0miDFyAtQ1AAXkr+Ld
 ZMCF7QVzMw+t+MMmSyR92xyCw6JuYa1b1EooRCqoGYj3EAovLdp5AnadMUSYyQxeTORs
 SdvHfZ1UOFsLnhQexHIOlPmbbmEjDuV5LZg+petvRYIg8km6546C6hR7kdO6QJNoIETG
 HRtw==
X-Gm-Message-State: AOJu0YyATwj7V6IifuP15tv43ICehcMsxP7cg8+ehHoSIsZWiuTm/l4g
 JMlzcgGS1E/wiIOIEEpzT5ameq7H5v/K5DBlFTQdPrZAOeWk4mMPNL22cihKz3fQ10jkpyUNEYx
 b
X-Gm-Gg: ASbGncuqDv08IcuovnF4xD/EgJLmh2FEEDNiq6fWK7nLMjmNWxKAi3lUZRAv43qUiYY
 eRDfa2ThvG1d+UVmU+BDGHdMS8QLs/O2ZAW6124W5/+cai80GkDm3sPGFX+N/DzGiZ6bJC0p6G8
 a0JjFJj+B+j4xB9VtkdyPLl58BBXQPHFatlB0fJmwqSjkHv+Oxsow8u0LVWSr74sqyXQkOAkLD/
 zEuOO7J703g5IX+/ocvpKZcJ29kCF+GUdjMA+Dkkcazl511GjQvNNP8KQUcsZQ/sNW6msPzSgGT
 92krADNMMohM7lC8mvFmFFSscGzcnWA=
X-Google-Smtp-Source: AGHT+IGPviQGedOb/mJoWgd0EluiNKPk2wrWCU6GYbwmg5vkdtDrPyfrYgO7t01He1/0J2LJNKr9Mw==
X-Received: by 2002:a05:600c:350c:b0:434:fdaf:af2d with SMTP id
 5b1f17b1804b1-43668b7850emr246307105e9.30.1735331087390; 
 Fri, 27 Dec 2024 12:24:47 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43656b0145csm310239725e9.15.2024.12.27.12.24.45
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 27 Dec 2024 12:24:46 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 2/2] hw/intc: Have ARM_GIC select ARM_GICV3 when KVM is not
 available
Date: Fri, 27 Dec 2024 21:24:35 +0100
Message-ID: <20241227202435.48055-3-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241227202435.48055-1-philmd@linaro.org>
References: <20241227202435.48055-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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

When the KVM accelerator is selected, the Kconfig ARM_GIC key
selects the KVM GIC implementation (ARM_GIC_KVM).
For other accelerators (TCG, HVF, ...), select the generic
implementation.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/intc/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/intc/Kconfig b/hw/intc/Kconfig
index 7547528f2c2..762139d8df3 100644
--- a/hw/intc/Kconfig
+++ b/hw/intc/Kconfig
@@ -23,7 +23,7 @@ config APIC
 
 config ARM_GIC
     bool
-    select ARM_GICV3 if TCG
+    select ARM_GICV3 if !KVM
     select ARM_GIC_KVM if KVM
     select MSI_NONBROKEN
 
-- 
2.47.1


