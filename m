Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9498DC282DE
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Mar 2025 15:41:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpqrc-0000qF-34; Wed, 05 Mar 2025 10:40:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tpqrX-0000gU-KX
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 10:40:47 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tpqrV-0002cR-P4
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 10:40:47 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-438a39e659cso47730345e9.2
 for <qemu-devel@nongnu.org>; Wed, 05 Mar 2025 07:40:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741189243; x=1741794043; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zCLXy/6Jr/0dTWXwfCWT0ZtMvCFd8v9iNYIKh2Xds74=;
 b=LtHdewnI0eoML0y3ophnI/8JLHRmlU2u4RiXzulKM7Ub9tKUgPGhuNDk+Y5m5lHWWI
 WKBqZgGkj+YQ+ynLkwUCdKmfnhMRMlWa1bm7uPxz80AjZbYKYp73l4HGZf0PQnS/s+kw
 pWxCbYaaw3ee2SQZA1Txw1fd9R6t271IWQDznALzY422SuX6sFJQKi+Vazz3913yMjEQ
 X1C2HA3pJYpEdAWYJVHvmyNJ7GIRjwOzUkCmLSJMyAJ51KC44WrOYDCYYCc1Edy91Hzr
 d91iU5GzO5t4nCp4HzBoeGaqZe5nP1th8cchz505wA+HahkLhRpZ1+0eGU91tEUqKtmc
 bJsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741189243; x=1741794043;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zCLXy/6Jr/0dTWXwfCWT0ZtMvCFd8v9iNYIKh2Xds74=;
 b=Tb7iDtH7wf5CcnpE4ASRlOXXsiEmtoJegWmPshC2+wDU2sN2qTQJxjZsFzdH2RDJMa
 Qe14kQLFwNvdSItguYu3TuT9LsYxQIIEspDhqu+zPmFD7/EicMZ/ft1XVjOn4wI0hC0p
 8eMtzgu5NFmj4TkTxehWpb3gAIkrcM6/LZsz9/q/IxBS9ULKD8imbaiKd5hXjrRtRsIF
 U4g3JYFaz8wUgAxkN5GpfpZcDxZXu0KldssUCF0s5tCoGFulG56n7xFIzI6w3Et334XE
 Le5ATC6YyODk5QxAmvcT0LdGSXo1i0uiSif42UMwMpzM+lw6KwNnbFochHnxy1Qexu8X
 swOw==
X-Gm-Message-State: AOJu0YwWWrvgtFuedPTTF8ywpFcjIYxmL0TmxGoQkPDdj0iy9y0mUhUQ
 fE4cZZj5IPlWoAMn0DfXc8dHoFy2cXKfaI41tykH3HNxVzeONvIi+rEsggDnPrKJBjmoM0Pvp/e
 U+nY=
X-Gm-Gg: ASbGncuOppiHLDMbGdkv/VOZJAvGGPtqE8XLDjECq6yPQ6hKyBLadO1/8Qw3ouVLg47
 vyGkyxiEkGvgcUt5giWReSkcy1PVi9GSg+IzdsKLtzM53SeqOJhQGCahTrh3C/UW0CTDyfWnbu2
 C0jBtxVV4y+CpdfbM4Ym2aTmH5kxCfmxXZK/oUNIT/3BgYGTk0pbtApbFh/fHefIY3dw03F4OUF
 QqHo1lDpEHL+ZMiSOfTA0/hVtwEtmYKK+7xxzSKySanCG1WxRekzQjOdRi7P6oUzqvu+rtPPBsL
 19+UVJSYDTT+gBwHfzmqldD5EAopaSHcIAL+cE0+fKm0lbbcZCHYAFk58tIXB798Vvz5x0xB+aJ
 OTzgz6pPPrQq9p/xW34A=
X-Google-Smtp-Source: AGHT+IHEiBphRCdocbVqnHQgT/UnY6shrIcCANlIoob8I0XmTJJCBWeV1E92qmelqF6Ve7FsQLrpmw==
X-Received: by 2002:a05:600c:4f06:b0:439:9f42:8652 with SMTP id
 5b1f17b1804b1-43bd296df39mr27311485e9.17.1741189243554; 
 Wed, 05 Mar 2025 07:40:43 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39118753933sm5479088f8f.48.2025.03.05.07.40.42
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 05 Mar 2025 07:40:43 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [RFC PATCH 15/18] hw/microblaze/petalogix_ml605_mmu: Use
 legacy_binary_is_big_endian()
Date: Wed,  5 Mar 2025 16:39:25 +0100
Message-ID: <20250305153929.43687-16-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250305153929.43687-1-philmd@linaro.org>
References: <20250305153929.43687-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

For legacy binaries, legacy_binary_is_big_endian() is equivalent
of the compile time TARGET_BIG_ENDIAN definition.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/microblaze/petalogix_ml605_mmu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/microblaze/petalogix_ml605_mmu.c b/hw/microblaze/petalogix_ml605_mmu.c
index 21ad215e442..f324a863772 100644
--- a/hw/microblaze/petalogix_ml605_mmu.c
+++ b/hw/microblaze/petalogix_ml605_mmu.c
@@ -27,6 +27,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu/units.h"
+#include "qemu/legacy_binary_info.h"
 #include "qapi/error.h"
 #include "cpu.h"
 #include "hw/sysbus.h"
@@ -80,8 +81,7 @@ petalogix_ml605_init(MachineState *machine)
     MemoryRegion *phys_lmb_bram = g_new(MemoryRegion, 1);
     MemoryRegion *phys_ram = g_new(MemoryRegion, 1);
     qemu_irq irq[32];
-    EndianMode endianness = TARGET_BIG_ENDIAN ? ENDIAN_MODE_BIG
-                                              : ENDIAN_MODE_LITTLE;
+    EndianMode endianness = legacy_binary_endianness();
 
     /* init CPUs */
     cpu = MICROBLAZE_CPU(object_new(TYPE_MICROBLAZE_CPU));
-- 
2.47.1


