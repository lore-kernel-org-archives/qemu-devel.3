Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECE8CCCD1BF
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Oct 2025 19:21:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vCNLq-0002iQ-8k; Fri, 24 Oct 2025 15:21:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vCNLn-0002hU-Kh
 for qemu-devel@nongnu.org; Fri, 24 Oct 2025 15:21:23 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vCNLl-000860-VL
 for qemu-devel@nongnu.org; Fri, 24 Oct 2025 15:21:23 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-475dab5a5acso1853175e9.0
 for <qemu-devel@nongnu.org>; Fri, 24 Oct 2025 12:21:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761333680; x=1761938480; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bMcBlXKnqngCL255Kg+00wgjmclnjFHMKw4fRpPlVQQ=;
 b=lLR8GFjjEIXV9fte8gnwuBCq88bPsOCEcb/j9ZNxG4lsE3KpVCpe+B80ShhnuMwwGA
 KXJMXH8ow0wWQuxKss7aMKsEChOCy7pgWGmC+mdKZiDhZKEqK1QMMsNBveUEoUMIAsMV
 uLuDtrnndFjex6KZ37nZvWmyYwm5G3l/VDO19LpH4E7ImyFYoj7x9GYWS6278tbigXWP
 VLx6rbO8sCOq2QEI+adLi48iDmcGL5N/kvXtRlzAtEqJOkREFkXuTiStn2DAcGT6px1D
 Ib9h27MndIX2NltDu/nK6dH9QOgtIDpqjisjgIr771xb80LzXq+lqPHR2/EJhrE9ve35
 FKxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761333680; x=1761938480;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bMcBlXKnqngCL255Kg+00wgjmclnjFHMKw4fRpPlVQQ=;
 b=Gd3vju8cfIbrSXPaSlHOSrlQ78MMKy+xB597L3icSwR2rK2DRZZmlEJaA16EO2DOCX
 gHYxk2JansQVOpmgAooOGb8jvcPXYTw33iscchAhSr1WcSLcwkuXlj8GE7v/mROl2u0a
 g5XTfhIUJcym5i916YYzOXj4kimah9wVwyl/GhENP0oAbF+CdEP5PS6QRoWCK8wilY0Q
 UuxsDoTGxvlZWhLJcxSJMdNT6xqnSZzRDnLUHs6d8tSwICIuRzUClaOlpTdZ2cwEhzY2
 YS4SnyERi/D1gl4Qb3xr08lQ8l1c51hMMiBAm7ub6bk/vvNpMKPHAfEjM+doW6xygqG2
 EBPA==
X-Gm-Message-State: AOJu0YydgAmhQxVMlitM/MCEj5T66GsliMcMr17tYIM/1JJ569mnGYis
 vh9jxZCJI4jAvsgegjXFHNUHLwREa1acMVk0oQXrOowsq8hNKnQZxFBo0/7IphI3RSG+7rym7hT
 /kz7rDVY=
X-Gm-Gg: ASbGncu5oj1St0jrbbkWli3DUM8Aoovo9RSmOkaJ3OW9JAwgEfh0JaXi3f3VSORue0L
 klmr0JNnLgFdRPKlJbRvs8lkkFCBwPmW0ILEnGlQvLCdRY+7WJfnSVEkxKsOPhDQmuANj3T60gF
 EZKsnlVisFeg11UiLrVTu6aN1R4M7Lpmn2D2hhwdXUlV8ddjDpZTktzhFNX+rbDF3TMOXXJbpkL
 cGXaUnQYo/ruCZi3/iJdT8BSRVw+GRGT+0xvl7GPCQT3XLvordfMIG6h6qqNsZySDZv7W02fHyF
 mpDnsGPWTHSZ9nKN+MOXUR5IXRiw/P9K6KrEioqHKsBaA3PZcKey99DwFhmWelUsHRLQhiddavZ
 +Cn/JZocISl95oqnq0d4/dyy5g9E+f9hEtG8F+klLjIrdPlg1dO40sPRmMQhxfYv4DHUQhcmLzf
 3mNJ6IEG+E4lhh1eJlzK5LSV1Y9UbTdd7Zxrv/Al/5gKEOZCg1UYdqlJrGdxDY
X-Google-Smtp-Source: AGHT+IF98tSKGOclOKd2UUk9BuTJ+gGYlALhz51TmHF0V+InD1cuYVxw9Raf0MXJc4crfeJgqQqAxg==
X-Received: by 2002:a05:600c:548c:b0:471:16e6:8e60 with SMTP id
 5b1f17b1804b1-471177c0948mr208244445e9.0.1761333680110; 
 Fri, 24 Oct 2025 12:21:20 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-475dba615c0sm4139005e9.16.2025.10.24.12.21.18
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 24 Oct 2025 12:21:19 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-riscv@nongnu.org, qemu-block@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, Ani Sinha <anisinha@redhat.com>
Subject: [PATCH 11/27] hw/misc/unimp: Include missing 'system/memory.h' header
Date: Fri, 24 Oct 2025 21:03:58 +0200
Message-ID: <20251024190416.8803-12-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251024190416.8803-1-philmd@linaro.org>
References: <20251024190416.8803-1-philmd@linaro.org>
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

"system/memory.h" header is indirectly pulled by "hw/sysbus.h".
Include it explicitly to avoid when refactoring the latter:

  In file included from ../../hw/arm/aspeed_ast10x0.c:17:
  include/hw/misc/unimp.h:22:18: error: field has incomplete type 'MemoryRegion' (aka 'struct MemoryRegion')
     22 |     MemoryRegion iomem;
        |                  ^

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/misc/unimp.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/hw/misc/unimp.h b/include/hw/misc/unimp.h
index 518d627dc5d..a0a1f359e1d 100644
--- a/include/hw/misc/unimp.h
+++ b/include/hw/misc/unimp.h
@@ -12,6 +12,7 @@
 #include "hw/sysbus.h"
 #include "qapi/error.h"
 #include "qom/object.h"
+#include "system/memory.h"
 
 #define TYPE_UNIMPLEMENTED_DEVICE "unimplemented-device"
 
-- 
2.51.0


