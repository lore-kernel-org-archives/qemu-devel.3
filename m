Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF47AC54E60
	for <qemu-devel@archiver.kernel.org>; Sat,  9 Mar 2024 19:28:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rj2Ld-000097-Kd; Sat, 09 Mar 2024 14:27:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rj2Js-000769-Mu
 for qemu-devel@nongnu.org; Sat, 09 Mar 2024 14:25:22 -0500
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rj2Jl-0003Is-SN
 for qemu-devel@nongnu.org; Sat, 09 Mar 2024 14:25:18 -0500
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-563cb3ba9daso3523889a12.3
 for <qemu-devel@nongnu.org>; Sat, 09 Mar 2024 11:25:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710012309; x=1710617109; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=shKXB5mcwJL88T3p8o75GRzqkLr6uG1jmqPC2UukzhI=;
 b=pY4+LBsm4cXmBzCJybnR2Hy02QkbN0Bt/FH+E/VAwK8DCHjAFkyQ1ysrS7ckIyLDpr
 q0P1huPa1iAHzlkDqQlubQGYsdypCsGkrZO5sKMzurFY+tVGLt2OtcMm8klHbjwCYx1m
 UtVXzZSu3fZPpwQbwCwZIrihHeaPUVnR9iPJ9h3uIk0eOLoyUFZhUYkttNVJ5+LPHZB4
 DijuYjuOUsu/tYq9RB5OAou816u5NakeAhA8Gtu8xhiDNcqFzSSMD4EPU+840x1ZlyiP
 yfjX7bcmffnthpvWh8lUCMk4scgSetGPhNXbACO7o8uS3mJJfaR8tMQkoAI1kn5mFlHb
 CW+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710012309; x=1710617109;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=shKXB5mcwJL88T3p8o75GRzqkLr6uG1jmqPC2UukzhI=;
 b=PsnV/EXBSTrJazg9Aqr5hFN329JPxAdO7qv+otesJL/bxO5qghLHM2v/Ll9m33qmMA
 ePJRigyMqiMrunorat5su0C/vDY/UYLhC3GXkCWW0bSDJWqY5g0kp6JZnZBoUlLGtmq5
 bD4MnglLDmAg5VXHDIFCDpzH50URSLbcIQuP0tS3J1Cyal/Nd0O8KCpJQj0DYUF4CSQs
 9t1Z/Hp30wXGSenliInJ0d6TiUl18YkGFFfOd1lgT+BS8oJSyb2zwNRokah0ZaeW4/BQ
 ZGWWBhcUWYgiqlzJjScLEaZ12pYaLB2BhEzdlV8oqBKOjXI6TpREQJMite2mlTDty23Q
 okjQ==
X-Gm-Message-State: AOJu0YwHAa+eT3J9VTriNFDqRUjqkzm8pCoKdcT+sU/F5Gqjptt8TQaq
 R2Gb9XFWKmkL6ysxsNFfyOYSPthEPz5S1D6+iW5TIEzdM8AwhuMIKOeP/buoavwHTiEXstnAZEx
 T
X-Google-Smtp-Source: AGHT+IEdf1UFTYo3MXGvdv4E79IPcLBj7o3BSzYa5lB994OSUOKUxtNFgLGUlUitgmHMkoPZUGHxPQ==
X-Received: by 2002:a17:907:7856:b0:a44:415d:fa3a with SMTP id
 lb22-20020a170907785600b00a44415dfa3amr1436642ejc.40.1710012309349; 
 Sat, 09 Mar 2024 11:25:09 -0800 (PST)
Received: from m1x-phil.lan ([176.176.181.237])
 by smtp.gmail.com with ESMTPSA id
 y20-20020a17090629d400b00a45cc1e8fe3sm1169038eje.211.2024.03.09.11.25.08
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 09 Mar 2024 11:25:09 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, qemu-arm@nongnu.org,
 =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Kashyap Chamarthy <kchamart@redhat.com>
Subject: [PULL 29/43] docs/interop/firmware.json: Fix doc for FirmwareFlashMode
Date: Sat,  9 Mar 2024 20:21:56 +0100
Message-ID: <20240309192213.23420-30-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240309192213.23420-1-philmd@linaro.org>
References: <20240309192213.23420-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52c.google.com
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

From: Thomas Weißschuh <thomas.weissschuh@linutronix.de>

The doc title did not match the actual definition.

Fixes: 2720ceda05 ("docs: expand firmware descriptor to allow flash without NVRAM")
Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20240307-qapi-firmware-json-v2-2-3b29eabb9b9a@linutronix.de>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 docs/interop/firmware.json | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/docs/interop/firmware.json b/docs/interop/firmware.json
index a024f1b9bf..54a1fc6c10 100644
--- a/docs/interop/firmware.json
+++ b/docs/interop/firmware.json
@@ -223,7 +223,7 @@
 
 
 ##
-# @FirmwareFlashType:
+# @FirmwareFlashMode:
 #
 # Describes how the firmware build handles code versus variable
 # persistence.
-- 
2.41.0


