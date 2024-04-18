Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDCD7C05023
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Apr 2024 19:31:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rxXSP-00089S-VZ; Thu, 18 Apr 2024 15:30:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rxXQa-0002FP-No
 for qemu-devel@nongnu.org; Thu, 18 Apr 2024 15:28:15 -0400
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rxXQS-0007hz-E5
 for qemu-devel@nongnu.org; Thu, 18 Apr 2024 15:28:08 -0400
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-a526a200879so155496166b.1
 for <qemu-devel@nongnu.org>; Thu, 18 Apr 2024 12:28:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713468482; x=1714073282; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=o0/TLkq+0Cek1YtUvPVSPSPpKhvNS+eTx919tWRRKxo=;
 b=c/IqhHd5rFyjt+7/J95u+CqZ/4ldYN50hoEPLJKba9lPKy7MpeSLefEkTpcz5JoQ4O
 CBiWKCiUfjjOvSKTCfb15XrgZjhtj9cIZWuUiLKVVPXBaW1D+1flaxxUhxNT4pjv6Y7N
 YnMnBNIUL1Myu8RfcYbTS31Yu6qcQsO0neVxU403/R4Y5YMFaBQyfdVzcb5OWCZLjIjM
 IBJjrygxBlciJYz+6QlUvR4zL9P5S1GfS65mrIfAfGOlaT3fjPPWlO+W5ZTQHimOClcx
 gKamW+i3ipHuJ/v9X2+2mb7t1ttilolgru3Gdmolj4UiYaecm6mFz41fGhdOhY661VDt
 8WSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713468482; x=1714073282;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=o0/TLkq+0Cek1YtUvPVSPSPpKhvNS+eTx919tWRRKxo=;
 b=q+HVnbnGLF5qS43tv9kYBzqzgMS+su8V6SE1Z2W0GmcUXtYBlgkINk0pQH2IZ5Fx1t
 sb/QJUuw0lg5RB/XnWc5jt31hDXEAMp4Vf1Vkq+KE6Xe5dS25zZ46s7fRA7PIw+PwZE4
 LrQJVge6HXWd5C74p+EWpyFB6T2LUCxdPi/rXMWZe53736a+grc5roXgHhO3EmBOX+XI
 qa2OmAXhYEy63PEsNeSiCQbEUpYiSBrt3T638A38cYds+4PsmZEHiWNMMZGkJKvIa3It
 lSOsRSEbykLtbYy+dRyqpuoz9o5ikGKDDayxjgp0IPEflCrMP2+NdWhB5c4p98jz3mxj
 JqYA==
X-Gm-Message-State: AOJu0YxKt5RH165BBeTUkHFWciPhy6HnRmeteBNYnxPKxN/Lr7eWFpWp
 pcbbb9NgMT9ch+uZKpEa52GhnIoAte/MavBNpZof8sCEcXzNHij6W1llIF3foXAYUfZYC4G3GDg
 k
X-Google-Smtp-Source: AGHT+IH9yyvoNEN3HFm6hHVceIDsgByTLejuLf3ciPZ1cvgkKcJXZJEDKVJuDdc5pS0wuniEfSC/cQ==
X-Received: by 2002:a17:906:a008:b0:a55:4d24:6f9a with SMTP id
 p8-20020a170906a00800b00a554d246f9amr59518ejy.6.1713468482236; 
 Thu, 18 Apr 2024 12:28:02 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.151.213])
 by smtp.gmail.com with ESMTPSA id
 z13-20020a170906434d00b00a51e5813f4fsm1286099ejm.19.2024.04.18.12.28.00
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 18 Apr 2024 12:28:01 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org,
 qemu-ppc@nongnu.org, qemu-riscv@nongnu.org,
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Anton Johansson <anjo@rev.ng>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH 20/24] hw/xtensa: Include missing 'exec/cpu-common.h' in
 'bootparam.h'
Date: Thu, 18 Apr 2024 21:25:19 +0200
Message-ID: <20240418192525.97451-21-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240418192525.97451-1-philmd@linaro.org>
References: <20240418192525.97451-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::635;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x635.google.com
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

cpu_physical_memory_write() is declared in "exec/cpu-common.h".

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/xtensa/bootparam.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/xtensa/bootparam.h b/hw/xtensa/bootparam.h
index ade7891ec5..f57ff850bc 100644
--- a/hw/xtensa/bootparam.h
+++ b/hw/xtensa/bootparam.h
@@ -1,6 +1,8 @@
 #ifndef HW_XTENSA_BOOTPARAM_H
 #define HW_XTENSA_BOOTPARAM_H
 
+#include "exec/cpu-common.h"
+
 #define BP_TAG_COMMAND_LINE     0x1001  /* command line (0-terminated string)*/
 #define BP_TAG_INITRD           0x1002  /* ramdisk addr and size (bp_meminfo) */
 #define BP_TAG_MEMORY           0x1003  /* memory addr and size (bp_meminfo) */
-- 
2.41.0


