Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B603CFA1FEE
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2026 19:59:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFdjE-0005L4-Qs; Wed, 22 Apr 2026 15:59:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wFdiP-0005Do-0t
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 15:58:40 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wFdiL-000086-Il
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 15:58:27 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4891d7164ddso23662315e9.3
 for <qemu-devel@nongnu.org>; Wed, 22 Apr 2026 12:58:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776887904; x=1777492704; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=wjrUfj18R8AJxR69zVGB6yxWXQphoD9JjPzqUr5brEo=;
 b=f8NCGl/LBABUuUg+kqEUnbHNXeLo0cefKcgRdZmmF/zckWt6XQGEEp7XIuIgOO4yTu
 RbmCEtEEhfAWy3d69uo7oFUONDZFP3TRKoLvhGrwAP3kxohvoqEYPQW4B7tAnUsbvlIn
 n1NwQNBHfVlzf+SD+yqekmjvDOae81sdldNqWlCrk80TYvG+ZUwgXRFs4FxOL0xbBMNa
 dETRYDG/Yj30Y8RtPK0vLEvVD7Qh5pqfvJFHPDP4tMUL8c/uesTS5kxrucZvS0/pQZIx
 Ojc6XwVVL0hwXqvZST+GwdGwdnMSh3FW9lZAXCNT57FwGRCDSbnjRsHZ/9MingVxqhw/
 5yDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776887904; x=1777492704;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=wjrUfj18R8AJxR69zVGB6yxWXQphoD9JjPzqUr5brEo=;
 b=lAcQcHRwYP+LS6y6HG9TuLVV5fMHAcgCJ/sg0V6XjVlpVBSGE0vMFaeiFnfuPPP4Lz
 Lnqo/FCKtdCbo0SMGyRMPwFMU3a8EHM4j2hN+eEGeCd6X/d3d3lBMqsVlh47YPsWhmlP
 xc+eKMKj9eg2FIvwTZbiKWZBcIPC3akvXrs8CE6h9dS6zOxAIG7ssJlmK+XE8XW2esDf
 ovWn/F5tPKj6cqq5fQgq+UYgLcNZ5NEvJcIH5nfjGahWBVonoq9CP3B84P5T9dADysSj
 845UoWdITdi1kHknAMbQUJ47jT51rGVgSkX57TsyrPMGLUSkcEND/THVqwVzM4vkGzrK
 sgSw==
X-Gm-Message-State: AOJu0YyH4gaT0BRkQJuWegjtgpnRtqksBPNcV6PmQa849Yga+X3DUv21
 9jtKA0/nTfp1BTZg1nXd4mIIIuZlR4/rXKd0j9AZ18iS1qDurxlwv6MSBGkka6nuOAA1PjE+3OR
 s0RArA7A=
X-Gm-Gg: AeBDieuiTi65qIdiP4Yok5reOJlffehace0fXgBDwi2sbxf31CEeAZk3uCXUAcF/NwE
 lkcKd7UL1/k34kMXCL3hTmmMgcIn7OipYGFV6pCYWfjStGVHbLUHs2lIY6A6UUBXLM1bmml2n36
 f7v8uXNYtQ2tEuZOd0ZVi15Kla5G2rRLLe1xbLGhcKFo9Zd2088pCleJX9PoE6ZG0phwShVzRXM
 RbvtkbOH304DWDNdqJRBvD+aLZyhRurOiC/qUB/tlPYyo/QkiZ4zu2srzmj6c4mI0RTT3rt6Nzs
 Bi2e01qETG3wOVhqMVPUdHDxBaEtWZ+xcF93gIrBPKPA0+kJaOvfH4rbntYt92F5FvCkfJM1UQE
 bp34KzBTtu34MJivRjazETnnVQFzv9gnudRAJ7Zpnpz0BYda1TiQ7WxVe4WXBOu9t9O8G3l9L+S
 97EO0Yy/Rnvm97jYVbqY4sHPndEOtfHun8suf1sC+UBXVCAPROu23fzPeMkNg+453udf5qkzpJP
 bs7Huy9QOQ=
X-Received: by 2002:a05:600c:46cb:b0:488:ac01:72de with SMTP id
 5b1f17b1804b1-488fb7451e4mr342543175e9.5.1776887903639; 
 Wed, 22 Apr 2026 12:58:23 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488fc1cfbf2sm483089465e9.15.2026.04.22.12.58.22
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 22 Apr 2026 12:58:23 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 05/48] hw/avr: Include full path to target 'cpu.h' header
Date: Wed, 22 Apr 2026 21:57:03 +0200
Message-ID: <20260422195746.88865-6-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260422195746.88865-1-philmd@linaro.org>
References: <20260422195746.88865-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-Id: <20260313062055.2188-23-philmd@linaro.org>
---
 hw/avr/boot.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/avr/boot.h b/hw/avr/boot.h
index 9eed2055591..c5efa54d98c 100644
--- a/hw/avr/boot.h
+++ b/hw/avr/boot.h
@@ -12,7 +12,7 @@
 #define HW_AVR_BOOT_H
 
 #include "hw/core/boards.h"
-#include "cpu.h"
+#include "target/avr/cpu.h"
 
 /**
  * avr_load_firmware:   load an image into a memory region
-- 
2.53.0


