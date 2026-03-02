Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7B6BEB363C
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2026 22:03:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxBM9-0000Mo-SH; Mon, 02 Mar 2026 17:03:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1vxBM8-0000M0-OR
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 17:03:12 -0500
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1vxBM7-00017y-8I
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 17:03:12 -0500
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-439b97a8a8cso1333523f8f.1
 for <qemu-devel@nongnu.org>; Mon, 02 Mar 2026 14:03:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1772488989; x=1773093789; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PCgeZ4WT/UGV6AN+XwdgDAtAbtkm4Hs1MZFKN1R+k64=;
 b=MDegD4VRHG84wh2WjueUuHPBHS9tZecp0+AXyPwUrF0at9WPGAdH/PyW7Peb6qILBc
 TqwhfQ4E46EGAeVP0lOk+k3N7SQ/rRzlmsM6WJaXgwqkc7HsyyXZ7Jf922gSM9u67p1e
 ZgoG8tE7uRCtw8PJ8QT2nUil15YAldcnXZ8YvsOdxqSZLi1OGQZKSCrR2iEFi3GEhwU1
 +JIS0CfleGnagbWuaKbcipmWMu4nxRuRBpVSW8NwRM/+pRzcmu62dmS2QQ6/1f/v9rT9
 ZHd9C91XCZta0ksqLgvO3J0UqV7MXcKG5UGIVcPWoznQffJmZeZa8+9WBBJRPUa2LGLb
 2AZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772488989; x=1773093789;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=PCgeZ4WT/UGV6AN+XwdgDAtAbtkm4Hs1MZFKN1R+k64=;
 b=vz6V36kLb4u+8duZjKGSH7cCCXr/G87TuHZeLTaPV0K8yuTuipvleXGz2HyfYZAZRf
 b+sDxMtPNAMWUjq1JajBucDX32teoDi2wyujuHQf29oumQCIv6I4nkfrFu8vZ0oGkPwz
 0YatlSaHX23+CUqP1k+FHSKIUqEGrvMLitIiamX53/AysZ02wjAVY4MYGxnWTHRTkzVz
 wiQZFKfuBI4ZgQgR9TuMOMNNaGT2XRR7syY+LShwhSzgrJmuorenviH294FR5jgCCQBg
 2/6sqJeRJhpakXPFs7VCjp4b7yH3yzamO0x7SrC3cGTHWpeA2scIME3/Ofve1UbKrybO
 Y+OA==
X-Gm-Message-State: AOJu0YwWyozt/BHj/NDRKEk2ZUQX7EBNL9LE4bC3EkQ9qvpuvb9HCWe0
 lwDQOzGBdBSwk9j+VgLWYh08kHIWRBLMLQBXUCkZty0rcQiI/zc3BmwiXi7hGA==
X-Gm-Gg: ATEYQzzr6CG9oY529VdiGJH6qtZohkYMBPInYAiImzT7gYItvFIzahZMq+YRqC/FTvA
 570qveFQeSkkLX2fOtdkeYZVOJB6w8EG104qkjcJ5sMFPXQiJm2Er18aKlNIZDW0Dtv7WFkTWoi
 JIwBLiJhdZbDtBe0FPijyD65Pzhk2ICqQHk06oq3LW2PQtJWiNvK6/kt44yxibmdiAUuQobuD4s
 FwZWclpDDwEN0O4xZ2PpSZnD2nmfAjVj0hW0dTdZsFsJwJkrcg4yQNVsNlmbwxYxYh4/tIWw3/y
 3pzt6b/6lK8GYPKo6DQjyC4emZzdZddmkJjNRrkwZjjBi7BF7YAnus429MUzl04WBWSo+nO7uCl
 Rb+N7z6ZB4qf5PuPTLDd2hAkQ897rBqAQV2pXdP7hAjLLxWjYdGa97jfTS/gcNRsXEVWbgkiJyZ
 NeR1NUps+rXctvs/orUJBzqlLcMu6/EuPvUsDaIXKaeK6wB/DcK8yrFyUuDnlpwL30/dRgpML8/
 qrWQBXpTApvRi7y//ILT+Viw0llrri4i/tNrcNFiUFijNY=
X-Received: by 2002:a05:6000:1884:b0:439:af39:b406 with SMTP id
 ffacd0b85a97d-439af39bc50mr13671050f8f.24.1772488989386; 
 Mon, 02 Mar 2026 14:03:09 -0800 (PST)
Received: from Provence.localdomain
 (dynamic-2a02-3100-2e0b-4800-0219-99ff-feb2-2458.310.pool.telefonica.de.
 [2a02:3100:2e0b:4800:219:99ff:feb2:2458])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4399c765c38sm29308102f8f.31.2026.03.02.14.03.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Mar 2026 14:03:08 -0800 (PST)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, qemu-arm@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Helge Deller <deller@gmx.de>, Andrew Jeffery <andrew@codeconstruct.com.au>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>,
 Mark Cave-Ayland <mark.caveayland@nutanix.com>,
 Jamin Lin <jamin_lin@aspeedtech.com>, Joel Stanley <joel@jms.id.au>,
 Troy Lee <leetroy@gmail.com>, Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH 05/12] hw/char/serial: Remove unhelpful comment
Date: Mon,  2 Mar 2026 23:02:47 +0100
Message-ID: <20260302220254.1166849-6-shentey@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260302220254.1166849-1-shentey@gmail.com>
References: <20260302220254.1166849-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=shentey@gmail.com; helo=mail-wr1-x432.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

There is no "is_load" flag and one can tell from the method name what
the method does. Remove this unhelpful comment.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 hw/char/serial.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/hw/char/serial.c b/hw/char/serial.c
index 2c558cb9fc..f73de1ae4f 100644
--- a/hw/char/serial.c
+++ b/hw/char/serial.c
@@ -281,9 +281,6 @@ static void serial_xmit(SerialState *s)
     s->lsr |= UART_LSR_TEMT;
 }
 
-/* Setter for FCR.
-   is_load flag means, that value is set while loading VM state
-   and interrupt should not be invoked */
 static void serial_write_fcr(SerialState *s, uint8_t val)
 {
     /* Set fcr - val only has the bits that are supposed to "stick" */
-- 
2.53.0


