Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E325C47DB3
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jan 2024 16:47:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUUmW-0007Se-6k; Mon, 29 Jan 2024 11:46:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rUUlU-0005yb-D7
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 11:45:47 -0500
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rUUlP-0003do-Ek
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 11:45:42 -0500
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-33ae74e5394so862627f8f.3
 for <qemu-devel@nongnu.org>; Mon, 29 Jan 2024 08:45:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706546738; x=1707151538; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DX37RoqmIV4LbscHP0LblED21zanCtHAqywHz6ZSi8I=;
 b=iuvBQIoKihZUYbPrBAd5mBbevO7sqM7qyyQx/ZNWhxXkeoFol1SnbOQC8sHhW4zpWr
 u4uYBuuGwm76XQZ0C+Xn747g+2PdpH+CQOX6MDGhhV7fsEJq5+4uiTj5bRd3TiEikcjr
 q1PAvckXpKBqdKaHrVFAS5S7vHB64XEgW5bgVgjpts32TQ18ReZvLeF0AV+LVqH9/CG0
 xHLoCs+0zJUxu+4eMufHCtp0O/IYDuDn/XBYLED2p/BPx+CL5+0rJqDYSUyz/juzNQUc
 YD274FrAopZWD7tB0Nk1FOg8GJ9yZJwFbfaqi2+Vl5S/g0Fc5IzB98QCnksSD/0vshul
 G60Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706546738; x=1707151538;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DX37RoqmIV4LbscHP0LblED21zanCtHAqywHz6ZSi8I=;
 b=eM8sUfU1bBKBKKdmDq/soNXBolnk3lze2FIB6X1ce12PdkP/VwfpK8HQvst2sMSHCz
 jJQmrfyzK+5AnoKITjLNjvemkUAkvQRY1wCXxbMVfA1lGw51FY0Oa1Fv5/2wBx58Q7VK
 DDgZPMCyj5jygg74L6JdAw4EhEiPwmDOkMmuNPWRf8erMSlZuUJuhwMrb2uaMXlEMYra
 qNx+eWBaRX+Vaa+asWARd2tDsEK5Ur9gj/czIssxc+DyvJK4ahiWhMW7Ym0d56KSdCLv
 EA2PsaMCtrLMDP3HZSWguOCqU3MnLM9TRAP4ohYtDIl8FJ5IRyZ7wmJ/FkCAtJ8IPA0u
 8ZjA==
X-Gm-Message-State: AOJu0YzcmIiASHaD21deSemlZQJY7jmSMTaWDC+tGyt1vrjkbfqDNHhc
 CEdBRn36hZqlZ55c2izqUjLyzUr23BWG4jfYIdmd053f7L3nQGmuavUZNDhT7HWIqgodH2VNNHy
 F
X-Google-Smtp-Source: AGHT+IGx14JXv0Db9aHtz3xdBJroRMX/UovaupO29Cg95YnE6U8ErBiRARcqLYVG/qrT9WzZB0Gscw==
X-Received: by 2002:a05:6000:1888:b0:33a:f12d:61c3 with SMTP id
 a8-20020a056000188800b0033af12d61c3mr1992032wri.68.1706546737831; 
 Mon, 29 Jan 2024 08:45:37 -0800 (PST)
Received: from m1x-phil.lan ([176.187.219.39])
 by smtp.gmail.com with ESMTPSA id
 v9-20020adff689000000b0033af5c43155sm653530wrp.56.2024.01.29.08.45.36
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 29 Jan 2024 08:45:37 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, qemu-s390x@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
 qemu-ppc@nongnu.org, qemu-arm@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>
Subject: [PATCH v3 03/29] hw/acpi/cpu: Use CPUState typedef
Date: Mon, 29 Jan 2024 17:44:45 +0100
Message-ID: <20240129164514.73104-4-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240129164514.73104-1-philmd@linaro.org>
References: <20240129164514.73104-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

QEMU coding style recommend using structure typedefs:
https://www.qemu.org/docs/master/devel/style.html#typedefs

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
---
 include/hw/acpi/cpu.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/hw/acpi/cpu.h b/include/hw/acpi/cpu.h
index bc901660fb..209e1773f8 100644
--- a/include/hw/acpi/cpu.h
+++ b/include/hw/acpi/cpu.h
@@ -19,7 +19,7 @@
 #include "hw/hotplug.h"
 
 typedef struct AcpiCpuStatus {
-    struct CPUState *cpu;
+    CPUState *cpu;
     uint64_t arch_id;
     bool is_inserting;
     bool is_removing;
-- 
2.41.0


