Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E4FAE7717F
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Dec 2024 19:14:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tMtx7-0002Hw-Kp; Sun, 15 Dec 2024 14:06:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tMtwi-0001Ve-3X
 for qemu-devel@nongnu.org; Sun, 15 Dec 2024 14:06:28 -0500
Received: from mail-oo1-xc2a.google.com ([2607:f8b0:4864:20::c2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tMtwg-0001Fj-JL
 for qemu-devel@nongnu.org; Sun, 15 Dec 2024 14:06:27 -0500
Received: by mail-oo1-xc2a.google.com with SMTP id
 006d021491bc7-5f340d6db09so449229eaf.1
 for <qemu-devel@nongnu.org>; Sun, 15 Dec 2024 11:06:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734289585; x=1734894385; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4Po02+cPNlfKpjVoSu+8QJp2TLU2nm8crEW/dnzqTYs=;
 b=qMM9vvdmZbnf1hLMJ9s7uL/d1Qeg0lXm9LGoCaKe20pDf/8AgZjcaubuVhOXwutVJ6
 lOliSJQJ0BOVkERB/AQPVlqkHKdgrCxbkcpqMqsNlcMuBIl//2GskhHxjbfMj+1AFjb8
 5Wrr9WJhJ2d1xpUt9/YJ2URm4hG67x+l/iJMotL4dcHoDfv3PyuspZRs+reau8tMUkWO
 /pnAT/3QGXOsbuRkFam/3qrt6RVu41dYClA0irnqHWqzx/kTBi47/YdgzTqWfzqPXMWd
 kCimR4hohEem4TAiGlUbB54FZXFGqBg9TaZ/FOg1Bu+Tspf6I1PqJp/Up7tTBy9Z2Bas
 z+3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734289585; x=1734894385;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4Po02+cPNlfKpjVoSu+8QJp2TLU2nm8crEW/dnzqTYs=;
 b=GKb5WGB7QHiL/Gn+GWtdEa8k9ZCTLjKDF/kBMCzhSk6ZRz20mrkxsFrojrHlsZnWr/
 e1quym1s+MhCcYy4MeXGytz/VzUdlF21mg0isoM7anuyjjHPOpVh2KCcHsH4zBy18b9G
 aSbnULCpFm8xYV6SHrEFEpTCb0DA9PbzRm3UzDJmkAHZ2lsvV5WYmqNKidtdbQxgCfPY
 gP54M6bgqmpJnj0PUDM1HrddJSe9LMdV8y93E4nHiMvIO/PCYerJXrDmgw3lcBpE8ZFN
 QW5i6iCxaOXDfCVbL4AlLChy6l6MGECkFKlWBpagyOkMO0ngSes4i1H4GqEUgfLRTtNz
 isTA==
X-Gm-Message-State: AOJu0YwS3cvQ7z6MXANEg8ntiRcl+zAQhmFyFanKtVOWAUorRquX8ptb
 BX7a5YPC2BZ6wnlTWG0er3xoj8+tkumzRwiShQuzqIcQPmBvsf18FrW2ZQpOtZKh97c7KzOgDU1
 GAvUVX49r
X-Gm-Gg: ASbGnct+ao0IX8EsItR2jPcGWVnjXCHasq7rVEhImY1FowdGuLzcpM/YMbcOMHzeP3e
 rI6wOePubArF7RDxDlNPm6AO+xUdxDRgeW094R4IWLJhMfE2yux9BAa3Sr8098iXG83tecQ5yvo
 2AO7Gos24kQD2B5BnRDe7Pytn1NEsL97in75GFZDmfnvkBQ6p0yRtk61cQatTPFgo+fUimjC8Xk
 DaRRPQm14Z8hhWi/ubYs72TPoH+CXoh2fyVntukFYcieRQlOTApnwUCeV96JS2fuS4a1iq1L4Hf
 ztZm+8MQ/ZAh8dGaQfCqwNW6zrDOhgswTOp0Saqy2Ms=
X-Google-Smtp-Source: AGHT+IHBeC2FbkoE5W1WzH0ubjGO27U9sXtga90BHjd6zjtEhwdmt+WpshcTxyBl8ATqpzNz7GwolA==
X-Received: by 2002:a05:6871:7a0:b0:29d:c6c9:c384 with SMTP id
 586e51a60fabf-2a3ac6beb64mr5535822fac.22.1734289585391; 
 Sun, 15 Dec 2024 11:06:25 -0800 (PST)
Received: from localhost.localdomain (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2a3d2914ac6sm1423214fac.39.2024.12.15.11.06.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Dec 2024 11:06:24 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com, Bernhard Beschow <shentey@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 34/67] hw/isa: Constify all Property
Date: Sun, 15 Dec 2024 13:05:00 -0600
Message-ID: <20241215190533.3222854-35-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241215190533.3222854-1-richard.henderson@linaro.org>
References: <20241215190533.3222854-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2a;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc2a.google.com
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

Reviewed-by: Bernhard Beschow <shentey@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 hw/isa/lpc_ich9.c | 2 +-
 hw/isa/pc87312.c  | 2 +-
 hw/isa/piix.c     | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/isa/lpc_ich9.c b/hw/isa/lpc_ich9.c
index dabd1217dd..378244aa8f 100644
--- a/hw/isa/lpc_ich9.c
+++ b/hw/isa/lpc_ich9.c
@@ -826,7 +826,7 @@ static const VMStateDescription vmstate_ich9_lpc = {
     }
 };
 
-static Property ich9_lpc_properties[] = {
+static const Property ich9_lpc_properties[] = {
     DEFINE_PROP_BOOL("noreboot", ICH9LPCState, pin_strap.spkr_hi, false),
     DEFINE_PROP_BOOL("smm-compat", ICH9LPCState, pm.smm_compat, false),
     DEFINE_PROP_BOOL("smm-enabled", ICH9LPCState, pm.smm_enabled, false),
diff --git a/hw/isa/pc87312.c b/hw/isa/pc87312.c
index f67155498d..7bb2af817d 100644
--- a/hw/isa/pc87312.c
+++ b/hw/isa/pc87312.c
@@ -327,7 +327,7 @@ static const VMStateDescription vmstate_pc87312 = {
     }
 };
 
-static Property pc87312_properties[] = {
+static const Property pc87312_properties[] = {
     DEFINE_PROP_UINT16("iobase", PC87312State, iobase, 0x398),
     DEFINE_PROP_UINT8("config", PC87312State, config, 1),
     DEFINE_PROP_END_OF_LIST()
diff --git a/hw/isa/piix.c b/hw/isa/piix.c
index b4a402f61b..8ec9c63b8a 100644
--- a/hw/isa/piix.c
+++ b/hw/isa/piix.c
@@ -408,7 +408,7 @@ static void pci_piix_init(Object *obj)
     object_initialize_child(obj, "rtc", &d->rtc, TYPE_MC146818_RTC);
 }
 
-static Property pci_piix_props[] = {
+static const Property pci_piix_props[] = {
     DEFINE_PROP_UINT32("smb_io_base", PIIXState, smb_io_base, 0),
     DEFINE_PROP_BOOL("has-acpi", PIIXState, has_acpi, true),
     DEFINE_PROP_BOOL("has-pic", PIIXState, has_pic, true),
-- 
2.43.0


