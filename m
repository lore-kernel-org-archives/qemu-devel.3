Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15F16D1D461
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Jan 2026 14:37:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdr6E-0007Ls-KH; Thu, 08 Jan 2026 09:34:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vdr5y-000737-B9
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 09:34:38 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vdr5v-0000jB-9h
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 09:34:38 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4779ce2a624so27216135e9.2
 for <qemu-devel@nongnu.org>; Thu, 08 Jan 2026 06:34:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767882873; x=1768487673; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MKZCBRJMVl+HwSw4Or6YDzCMoqNlO7kCpo//7lZNDA8=;
 b=vIwPeR9vXxRhLNZAEx3MKTV7cY0OXWL5g++S+pgSo0h8xQ8Z6hUeba6bKqqmCIfQSe
 YXP8qqbOwtZ7W3XSN93rBwHXr/Hr10Rrms8x18wosGPk9EWjDqoooYjUwrUoUYpw6F52
 ZpoPp93RjJrguxryhLc6VkjBEzaAOMOqil/N1Ug4vLKbUi11Ljx5kNDXPFcfK5rKZMMb
 St+D0p+UBD0WjE9nzFyve51Z70bD29oo3cqPBE9XKrABxBK30aFvejha8vNRaXvgXwIu
 KS/VNR7GsjPweuZkzLpzfshJSdFxsBJxg8IBfzCTED7IbhUSlDQe3SuYyNFgtMSG7cDb
 McJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767882873; x=1768487673;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=MKZCBRJMVl+HwSw4Or6YDzCMoqNlO7kCpo//7lZNDA8=;
 b=cw+OxtjsPWhbkuU4QWe6pTyKqPbVkIGviWsOi7R4b1N1oLVaC7FCdnguTOAX5FjKve
 /RLh/vqAFLPFcyHr9JAifyx8S/FnJSe+Ae0Yv/6TlfzcOuO40SYmTGnpkk0s+nmymbVC
 7f/A+5uzm4zyce26OVLHoyC9yvzFo9RAdGpSnqW1nPS/BFeyvBSZ4aSVW+T5v88Ac/H/
 Q7H/D7H0DceJodRiPbQrxnPIhoodENubKVOQsxTXtVSc02IOYxhMF8LghsKhmJttoCpR
 0RZ3Bp2m7aZpiRdvMkEDnC3a1E7T6vLAcaeREUUIReMQBp6KKdAg+AS4ZoBT/3/QImXS
 K6dg==
X-Gm-Message-State: AOJu0YzJvpVNOaA7No0OnhFskSCSlCzi4RNHI8gEHZLKHrY/uAKPF/+6
 Iq8udmHfffQxhgc948iKD2373xaGtROvvccT8AmFzsS2mVX1bdxAu2Ra71jPcfnJyTA=
X-Gm-Gg: AY/fxX5kqv1DlQyWTFpqOU6q3bAQYAfUOOA31nVKbFvrJ6AOIIEzmEB68JcT/A44mZr
 8kbHOSy9IM8FI7mIx6bgVntQqhXXbvgHHPc6FGhayo31xei0tFpsCPX4oKv13Qq+4x/RuiKH0DJ
 ieWdWw52dysLIjwUWUwuRVcSKGrlqmUepUMRORp99PYSSEiPmT76qRfzWYG+dFQQfx7Ko/nszp+
 dXx1I57JmEeQrCkZZZyqY+fPMzYLd4PFDLazmEKc0NafaAJj8gq8Zz7V8H/pm5zknToUl4siAC9
 lw6CGGKG+gFB+UQ1LZPP5c19GQm/31PSrOgLMwcRDI7cayNazquwqmS3Id0s6crVFJTIPwBPDv0
 AT+m+sBqUboP/Hoa3zXfYHqB51TBBXrxzrl1waFaOQAWvkWoaKE7B/eezycmnt8z0BRLioy3ZDK
 x7qtSC5jKEeAA=
X-Google-Smtp-Source: AGHT+IEMotvXhQTv160rwPcsVO9t+3//HM2qgzgfG8RwcgsbLPqB+CzG8MnZZAgqmXNlPB4P9Rb3IQ==
X-Received: by 2002:a05:600c:190e:b0:477:9aeb:6a8f with SMTP id
 5b1f17b1804b1-47d84b1faffmr81020035e9.9.1767882873126; 
 Thu, 08 Jan 2026 06:34:33 -0800 (PST)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d7f68f69dsm158067355e9.1.2026.01.08.06.34.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Jan 2026 06:34:32 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id D1BFC5FADA;
 Thu, 08 Jan 2026 14:34:24 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Bastian Koppelmann <kbastian@rumtueddeln.de>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Zhao Liu <zhao1.liu@intel.com>, Peter Maydell <peter.maydell@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-arm@nongnu.org, Yoshinori Sato <yoshinori.sato@nifty.com>,
 Yanan Wang <wangyanan55@huawei.com>, Aleksandar Rikalo <arikalo@gmail.com>,
 Thomas Huth <huth@tuxfamily.org>, Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [RFC PATCH 11/12] target/arm: remove extraneous cpu_reset from
 realizefn
Date: Thu,  8 Jan 2026 14:34:22 +0000
Message-ID: <20260108143423.1378674-12-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260108143423.1378674-1-alex.bennee@linaro.org>
References: <20260108143423.1378674-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x331.google.com
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

We already have do_cpu_reset called when the system is reset so there
is no need to do it here.

By removing this we now only do (smp*2)-1 calls to cpu_reset. Once per
core as part of qemu_system_reset and then once per secondary core as
PSCI calls are made to reset them.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 target/arm/cpu.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index caf7980b1fc..015131aea08 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -2208,7 +2208,6 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
     }
 
     qemu_init_vcpu(cs);
-    cpu_reset(cs);
 
     acc->parent_realize(dev, errp);
 }
-- 
2.47.3


