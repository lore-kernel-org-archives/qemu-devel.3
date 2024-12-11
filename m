Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C131CE77180
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2024 23:05:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLVkh-0002uC-Jg; Wed, 11 Dec 2024 18:04:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tLVkg-0002tH-08
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 18:04:18 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tLVkd-0001xt-Rf
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 18:04:17 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-434a736518eso81064555e9.1
 for <qemu-devel@nongnu.org>; Wed, 11 Dec 2024 15:04:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733958254; x=1734563054; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VCHSGNyFv8LSm9JlTuEHKD53SXdp1uauhC0W87/H+/o=;
 b=YywzPHbWUWQp+LriOA1CcyVn2HTyfr2hPLLOv8gtwPo1GCVfVn15ZM0fjBtpQsl4Rf
 CFVhPETVF5/EJHfjaHmlmx6IxJO2QqTUXj+AChr8oscMXJCLV2UHthyvL2ifbSOmaZrH
 qK1OsWkF+3mTocxJQpLBoZ0QF/UYZJsEwg5alQA6/msC9EPFS/zpm7vvZilPhjJPmS3i
 LEOYYTLT2GiI7htjI7Ab0SBgzBHNUDBIECHFf3z9p6vZt1nMEYEZ17BYng7HSaXvsB33
 HdMUio5oAKzcU+TF3EAGvJMF84c33J1yFTDiM9j/7IZJ4kSuxrHbWMbvUEWZY4gxnbFP
 vqjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733958254; x=1734563054;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VCHSGNyFv8LSm9JlTuEHKD53SXdp1uauhC0W87/H+/o=;
 b=dub2oGi2K0W0ndVvKy/8nXt3hDB7wFcBGrasx9KjHp6DTePV1LjANVyb9LFlsuE4h6
 DdqiCC4Vx20lDtURpj6EEdZ8A8fJYl5xgrYwxEVXjx41MFphtbAVYzYNWCk2ZvxWcB/k
 bKYYa+DRi9Ao3bbY5IU3jexQ5vPPVrhXwoH2N/cSp1OIHPLxx/rLwnoJk+aLJZqHr7e3
 aVR1FQB2VoZvKODkkY1AMzzipjaahRdcy1tCblEMik+p77hqaD2WOh17whKRESN+mosK
 Nlh0/WnaBnTcBrnOou7Zz60WFQZ99cbLpBvq+LjENirOqzz/sweILDMuh7jwUruAfrlq
 5JcQ==
X-Gm-Message-State: AOJu0YzZItUtMAUzeXi9FTk24LfFptX+wTB+JSNrXfQzSQZ6bISoBb64
 zaw+YkkqWy4RxTL5n6GbUgcvg1AJRWaJtQEEAZ5VeuW4U5ZWv2TNuZUWNDsJlTQ02cCNtxGuL4i
 P
X-Gm-Gg: ASbGncuf1Ux8EYALlJFL9pg7xyPOkxYCuWLL0kEEFxr8bXYgiwauDnU6bf1JHiZk4rf
 6TI/kz+Q5+TLeujtbO+BjVgTbNEOy/A6kkeE4c7REGZ3AGZtXNgJIApq1UelsPCHkRW9jsX4SHc
 lOBQIP277rpwIOd/xWz9W5hUzYT8zYl7ikp49VRwEu41iN3YSAxGDCV3j+TIyp0Iw3a2F17EhGi
 cLU2Xr9IKMqzPA+KePbZ11Su2ZSW6o30iyq+2CqLD9M0b1lEz36YbfMnXcDNMEvQqr42Cf6okan
 I5CG7gmfFLvKgGWGGlDLyercklrlbG7x9Q==
X-Google-Smtp-Source: AGHT+IGc3/AWzOOAriMV+IbB28ThDUkQnPPwa4fCXVt4koxt2DxrUannj4gUNc61UUYJBiBPXKTxTw==
X-Received: by 2002:a5d:598c:0:b0:385:ebaf:3824 with SMTP id
 ffacd0b85a97d-3864cea38edmr4351410f8f.27.1733958254128; 
 Wed, 11 Dec 2024 15:04:14 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-435aab63baesm62036735e9.38.2024.12.11.15.04.13
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 11 Dec 2024 15:04:13 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-ppc@nongnu.org,
 qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 3/9] accel/tcg: Include missing 'exec/tswap.h' header in
 translator.c
Date: Thu, 12 Dec 2024 00:03:51 +0100
Message-ID: <20241211230357.97036-4-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241211230357.97036-1-philmd@linaro.org>
References: <20241211230357.97036-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

translator.c indirectly gets "exec/tswap.h" declarations via
"exec/cpu-all.h". Include it directly to be able to remove the
former from the latter, otherwise we get:

  accel/tcg/translator.c:433:15: error: call to undeclared function 'tswap16'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
    433 |         tgt = tswap16(raw);
        |               ^

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 accel/tcg/translator.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/accel/tcg/translator.c b/accel/tcg/translator.c
index cbad00a5172..ff5dabc9014 100644
--- a/accel/tcg/translator.c
+++ b/accel/tcg/translator.c
@@ -15,6 +15,7 @@
 #include "exec/cpu_ldst.h"
 #include "exec/plugin-gen.h"
 #include "exec/cpu_ldst.h"
+#include "exec/tswap.h"
 #include "tcg/tcg-op-common.h"
 #include "internal-target.h"
 #include "disas/disas.h"
-- 
2.45.2


