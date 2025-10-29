Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90B36CCF9F1
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Oct 2025 15:53:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vE8SH-0004KE-Sl; Wed, 29 Oct 2025 11:51:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vE8SC-0004Dx-5h
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 11:51:16 -0400
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vE8Ry-0002tS-49
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 11:51:14 -0400
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-b4736e043f9so6057266b.0
 for <qemu-devel@nongnu.org>; Wed, 29 Oct 2025 08:50:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761753056; x=1762357856; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uKr5Bi2eQz1IQt5nF2ox0QSeE5cWUROzQSNoAdPSO3w=;
 b=PpJ5qujGNC8Fs7eI+BxgVaOr0FfRoxwmsVYgAKJvW257LaJ7RKVRJ1e1uLnxDL9Pzh
 OtJDKb9AGoduAiJD3YFtOUmLJWWeorpoqk5EyBwWZa0rMQsdjCZ2DV+ZQCzWkdU/sMJE
 2j8lLKipfsc9F+bsjVCIhH1mVK4H//MIkcx6ADJEx2gKwIGNzLHjo9aRq748NaNWm/7z
 W1ibVuTOn7JZfkM+edWJVhzYgs/syADYtclkTyCwwNdcpAhSai2xqdve8ySfat9Fnfbq
 304xIzBB2uU6mJY4tc7wKPdMQ6F5r+eFvlca6lTvFRRjdCVj7BpMFJt7JLkiu4OEOGEa
 kgTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761753056; x=1762357856;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uKr5Bi2eQz1IQt5nF2ox0QSeE5cWUROzQSNoAdPSO3w=;
 b=xLRYJsYhaORC2QUr5PudwgMhKoxpU/qJ3UI4fKU7UbO21MW5eVUjzJ0gLq6CTwWBJL
 1wjghgE+rZZu/q9zHRuir5lX0pLTYoMslWFQOMuOnaIMVWA12RzcQkx4G2b1Un4kJVIQ
 2Zr/KfkfRoP3qWh0SZ8e1NFe/LerhuU+fwuBX0XR171x9eIBOVSyOiPRqB2DllOhbh+v
 sG2+KoJh+5Zv3k6W1bt5GA0r330339mMgLq3DLUjc9CWwvRik9ib8byEqInpCIig6sAX
 ZmjO8aFZmGi8hjZkJBTv1iRw1rTdayuyzmghuk1aEOS46NSZsxXvs2rrh/l0+RhO3Zz/
 dJgg==
X-Gm-Message-State: AOJu0YxfqW8Md/69BBY1QFDf7/yqyIA9s8zNFRVfC1p5aBR/gkMdxrFp
 376CP2D3wteiMksKxKjZYLYwmhElnEUiq8f/Uk5wweXIVVbMIJYfi1i4lfzXNLJ0i7c=
X-Gm-Gg: ASbGncvV8EuC3GzWqmcvd5XDU3iiVaW3mll35eQyEijLL9TPS16GmD+6NyI/1QE1Fx0
 F3UsX7suNpJMagciWjtxTDsVlP/OfX1+QI2MSseXWVPobuS0IEBbTkRzeYO/+azNu7MHqJ6dNjn
 VDu1620t7s1rckr1f6vSNzs4UX1WxVaMz0Ch0X4jPQ4DINMVayWpkTkKOrvThZzK4jF+KPzQ93c
 rTFFvH2rmhrPqNunxGIJ5tzMItfkSiuUUk6qXPRcCpGmidE9kvUZUnEkR4TZNM7SsjUwWyrRS4Y
 bb+0kf+0IAXDRgv2P7SC5C7IA0RflFCa72VYQ8eLkqiI29F9ChjrJ/5Y0NOeQQgUXqfmNiXSvJM
 Jy7uQlweDZcDvjvDCz0zwdqkMqk65pBrh0gkphR+YdOeYJTnsV68FpxAfH2tdGf+7SLq7bfUDh9
 Y4
X-Google-Smtp-Source: AGHT+IEL8nmpTqhO/IIboP1gvLXDS8d8jXq0dbS95ogw7yzy9fcgSvuGx7kFyAh3gCtZGZBFrBvN3w==
X-Received: by 2002:a17:907:9496:b0:b3c:3c8e:1896 with SMTP id
 a640c23a62f3a-b703d457176mr300504466b.42.1761753055992; 
 Wed, 29 Oct 2025 08:50:55 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b6d8535974asm1449152766b.25.2025.10.29.08.50.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Oct 2025 08:50:54 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 25307609D9;
 Wed, 29 Oct 2025 15:50:47 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Julian Ganz <neither@nut.email>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Michael Rolnik <mrolnik@gmail.com>
Subject: [PULL 13/35] target/avr: call plugin trap callbacks
Date: Wed, 29 Oct 2025 15:50:22 +0000
Message-ID: <20251029155045.257802-14-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251029155045.257802-1-alex.bennee@linaro.org>
References: <20251029155045.257802-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::633;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x633.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

From: Julian Ganz <neither@nut.email>

We recently introduced API for registering callbacks for trap related
events as well as the corresponding hook functions. Due to differences
between architectures, the latter need to be called from target specific
code.

This change places the hook for AVR targets. That architecture appears
to only know interrupts.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Julian Ganz <neither@nut.email>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20251027110344.2289945-14-alex.bennee@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/target/avr/helper.c b/target/avr/helper.c
index 4b29ab35263..365c8c60e19 100644
--- a/target/avr/helper.c
+++ b/target/avr/helper.c
@@ -28,6 +28,7 @@
 #include "exec/target_page.h"
 #include "accel/tcg/cpu-ldst.h"
 #include "exec/helper-proto.h"
+#include "qemu/plugin.h"
 
 bool avr_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
 {
@@ -102,6 +103,8 @@ void avr_cpu_do_interrupt(CPUState *cs)
     env->sregI = 0; /* clear Global Interrupt Flag */
 
     cs->exception_index = -1;
+
+    qemu_plugin_vcpu_interrupt_cb(cs, ret);
 }
 
 hwaddr avr_cpu_get_phys_page_debug(CPUState *cs, vaddr addr)
-- 
2.47.3


