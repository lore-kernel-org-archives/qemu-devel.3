Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD7FDC5DF6D
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2026 09:23:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwcV7-0007pR-DQ; Wed, 19 Aug 2026 05:22:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wwcV5-0007mx-Fr
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 05:22:23 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wwcV2-0001vx-C4
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 05:22:23 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4955aa106b1so8126025e9.0
 for <qemu-devel@nongnu.org>; Wed, 19 Aug 2026 02:22:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787131339; x=1787736139; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=pc/GOaaPlMM8Rx6IwwNSVab3AJ0ESXz+I20bcOy9tBo=;
 b=BnRxpsQEZGtN2beXW2mAk4CD+m/ofZbsbMb4kf0tYhZ4RMdsusc0Rn84+XgDyOLQ1I
 Y9cY9nK8Rlkf9KtkpD+y+J+og0ioxQbw50xrcjTohg+h6VX3/NqW3r/vDgj3yg7jXhUP
 W7TJPmq6arfUz71//R81A0xTanVMYCfCtY6Cm6ntefrT7hl0bEu3vNtxwdtaUt1sg/ei
 kcR/2VdflItt/3GFNx3ZAtVVEMAHpJt78+yEy7Ej3Bgy6F0ELtL0ZRHqF8pef8eAzFgb
 tDdUWZca8uPJyM1EdYD8u6JoANYSHbcfR8wnYXjAKNEUl4jZjFT44L+xDBnL7YgUXjT7
 9oAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787131339; x=1787736139;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=pc/GOaaPlMM8Rx6IwwNSVab3AJ0ESXz+I20bcOy9tBo=;
 b=sco9rqYW0LXQO/d11Awn4438wQzL2QTCGER6nKEIg+gBQNdKmKSBKmqnV6wri6RHNK
 iKTOEsTA5He82LEYWz0JiOaxv+WJAIEXhDfD/SfRPfp1aLY0tDJw8jtuQtq+vvkavDfc
 PepSvvGlx+gW7jA2KVPVpHe7eRnEqsXeQGGYlDF6upP3DK7m/U4DQbzUbH8yZixVmoe0
 h73zEB6Hp7iNie8rLfLSmkEXZ3jLMgjzLjN8UClJTW2Iwv7RQyHolCh2b/HfMv2YuOU8
 rpZ5TbPxhCWKfA99MQKxzZiAYXOzchtneYLVwCGpoJLfcpP9o43mS0eBSRcpkRRLbsvU
 bxMw==
X-Gm-Message-State: AOJu0YwvGYUCzTsTaPVCTbj7GF6MTwYtVYprt4NBsbBPXq9TFy7JDEWH
 We/JvnX4nmkN8Uz+q/sHc8P/Nghu3g8MJuAwUphpdkwCrEvdLWOXr35PjyR8iEFoA2g=
X-Gm-Gg: AR+sD11MVQ3f2uFB3JSRmy4X7GFjBaXrsJbNLkvCO2m568pYjg4sinOtEPcZoh2H0eP
 dbu6Icyxaz2Vl2G8jlnWEktkyVbOnocExQtI5WoXgD39O/qoRjfVhk2qJDuGG2imAvP9raTbFTH
 WtpN4e80HAwM9cLMw+U6EZysfCgAhl2qTs/x7/8IbizDA6597UDkXCJtKB+k3VQYJdZALz1mwZ1
 +VdKgQlZIhTmhszPyfON874/D9KnvvIlg1REK5E38UjRq/Itf3EpebiuzPKE9sTUW9utMpvRmRk
 kE19jXp3BRiti2J0zqGKm1YRe5VALMemevn6RH8pkm+EAERQmmXMH9c1hbDgKWMBGYOfP1HrCHR
 rRk8LWfuhhTop7Olx09CEuFxJu1wIzHIQ0oYI9OO+Q0hLpv7AU/7wj3SUW91SQWxAjihPfc945N
 5FwI8VPbz7PZOOXp4QrKaydbf7EQnnv6+mQUK73YkBkcd3iD6S6SD2XhO21M62
X-Received: by 2002:a05:600d:8446:10b0:499:9eb8:a1d7 with SMTP id
 5b1f17b1804b1-499aa1d0a9fmr40563525e9.9.1787131338788; 
 Wed, 19 Aug 2026 02:22:18 -0700 (PDT)
Received: from draig.lan ([185.124.0.156]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499a9dffa59sm66006495e9.3.2026.08.19.02.22.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Aug 2026 02:22:15 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 640865F878;
 Wed, 19 Aug 2026 10:22:14 +0100 (BST)
From: =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Wed, 19 Aug 2026 10:22:02 +0100
Subject: [PATCH 2/6] tests/arm: add explicit CFLAGS for system build
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260819-fixes-for-11-2-v1-2-b7981c2cc371@linaro.org>
References: <20260819-fixes-for-11-2-v1-0-b7981c2cc371@linaro.org>
In-Reply-To: <20260819-fixes-for-11-2-v1-0-b7981c2cc371@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, 
 "Gonglei (Arei)" <arei.gonglei@huawei.com>, 
 zhenwei pi <zhenwei.pi@linux.dev>, "Michael S. Tsirkin" <mst@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>, 
 Laurent Vivier <lvivier@redhat.com>, Amit Shah <amit@kernel.org>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>, 
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>, 
 qemu-block@nongnu.org, devel@lists.libvirt.org, 
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1369;
 i=alex.bennee@linaro.org; h=from:subject:message-id;
 bh=MJWvive3XIw267cYiTNdmu4ac2myJrVPkfmdAGEdR0E=;
 b=owEBbQGS/pANAwAKAfvQ2wlanipEAcsmYgBqhXXFQdbqk4aNMoF8Fqsqd+U0IJwWLn9FjAcLG
 nvn4891lYiJATMEAAEKAB0WIQRmha6Z51FnvK/I3zX70NsJWp4qRAUCaoV1xQAKCRD70NsJWp4q
 RIMFB/4skduvdp2/XpuM6BCYc4XFHaKQCdl97vaqJUBVZgQs3hWJmU9r9u16zm93Zw0Wqyv+rZk
 fAPA2L9ZNDzrFaw0Wv2fAF4GcnHYPd3FOIb3a4IvdWrSbxFlO2Uio188ujTBhIWLmCiZDkboEBv
 X5SDsLWn4NjZsnSmGrv80jmOMuqMZAP2sYW/fDVwIKnN93XUtKXqFOY2SIaQJsRiyXbLlU2tNDX
 M2zlszD4TZpoLCtOrmXUaEUuLHrdZVNz96H9ufJhXTFMzq+kIcZamIlREzeyUIXhaidRyu9Vemp
 EEu6Z2sJPXfw+sAt8w9TlTd1yA/kyQ4ZoWbpp46idbigBmoa
X-Developer-Key: i=alex.bennee@linaro.org; a=openpgp;
 fpr=6685AE99E75167BCAFC8DF35FBD0DB095A9E2A44
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32a.google.com
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

The brew toolchain on macOS (arm-none-eabi-gcc) is a little different
from the default on Debian (arm-linux-gnueabihf-gcc) as a result it
defaults to an older architectural baseline (without isb's), assumes
softfloat and will get confused by including stdint.h without being
told it is compiling freestanding code.

Make these all explicit so we can build arm-softmmu tests on macOS.
The test-armv6m-undef is unaffected as it has it's very own build
stanza.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Message-ID: <20260723200904.224413-3-alex.bennee@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/tcg/arm/Makefile.softmmu-target | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/tcg/arm/Makefile.softmmu-target b/tests/tcg/arm/Makefile.softmmu-target
index b66074b0b43..3e8a9b4073e 100644
--- a/tests/tcg/arm/Makefile.softmmu-target
+++ b/tests/tcg/arm/Makefile.softmmu-target
@@ -29,7 +29,7 @@ ARM_TESTS+=$(patsubst $(ARM_SRC)/%.c, %, $(ARM_TEST_SRCS))
 CRT_PATH=$(ARM_SRC)
 LINK_SCRIPT=$(ARM_SRC)/kernel.ld
 LDFLAGS=-Wl,-T$(LINK_SCRIPT)
-CFLAGS+=-nostdlib -ggdb -O0 $(MINILIB_INC)
+CFLAGS+=-march=armv7-a+fp -ffreestanding -nostdlib -ggdb -O0 $(MINILIB_INC)
 LDFLAGS+=-static -nostdlib $(CRT_OBJS) $(MINILIB_OBJS) -lgcc
 
 # building head blobs

-- 
2.47.3


