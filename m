Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8FDEFD45FA
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 23:23:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvO9b-0006aI-J4; Wed, 25 Feb 2026 18:18:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vvO9Z-0006ZK-Ic
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 18:18:49 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vvO9Y-0003EZ-3D
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 18:18:49 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-48370174e18so1471795e9.2
 for <qemu-devel@nongnu.org>; Wed, 25 Feb 2026 15:18:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772061526; x=1772666326; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=dkWIniAQ+It75l/bddGUnOi+yHE3TEnUoQyjPEfTCYo=;
 b=TYxunxTdHzeuLwJb0Vr/pBGVwjHOokRmU4P4+TOyMuMb6kuMkUAIJ2+MpAt9HzdjxY
 IDSSsHS0/lnwEh4bIyQR/dzayZhlBZd78qGhtmtMyyGxzrJqAZADknn0/ump8uOEJoJK
 K1j8YamPWUkSrVZSzPWTV/s8hg/x51bHBSW/5B9/1rIw3F6gdJGsavUIYA7le3b4hJK7
 AhY4Jc8zwh/7jwVL0sH9TBMamOVmWrwlwhgId5zx3Mk3TCg2uTs6ytOUJN9MW2QtXhtJ
 9JrQHyPnMIq3s9ZGUWbNEmiUzCJ+rjlkhiJhAvfwIfY6+Yf7yDMbvTH4eP5b+aV8pCbe
 DI1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772061526; x=1772666326;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=dkWIniAQ+It75l/bddGUnOi+yHE3TEnUoQyjPEfTCYo=;
 b=Ya/0nq/3ixQ+HYAnJjM8tXaFnt+6c+bAD7WCyvct8LJpA5IFexx86K5jrnOS5YTxL7
 TY9ATYxO9Yrlch7Kb275Ib8gMycRObQgUcwRnfMS9kHEY7a0zub0usCmG2QlggvVGH0M
 oiqXrUwDNHogeclZVhKpoACjawGby12cJByATP52qyl1e6OfJN71lf3IoMqQ7c7sb8Po
 BlvtPnQKF5B+L/0Scwra/cYJMlNOHaxrVn8N8/k1YQkTg/a4AMG5Sc+NCb6Wcau6kmin
 e/sbeSLpjUceOyqGTQFBxHkyDhIM9gdw3fVM4sIZmarFErqgDFIr4yJmQtg48ZS+MbfO
 VYLA==
X-Gm-Message-State: AOJu0Yy0orNsQ83bOeR2VqJnhqxmz81hUitYZ0kUV5pNYWsiVsOkmSl5
 otKYWlDFM1sgCMUnw9bm/5l8F7BqciqN5yNgM5FPi6iaHZJpZSUmi0G3QVCLQ2Wu2Ohbx7U7jsi
 l9CYNuJ0=
X-Gm-Gg: ATEYQzx5nYk7D1drWRsV7qf7AVy2sFHZrrTRYCf+My1/JTxPPnhWPDm8QqYlM2pdOi+
 GwuMmKwZZTPwQjoEGX/a7LeXrtryMjYmoN4TmbN15HaJc/KJQhe8D1Bt7JrE5flRBfmuOqYU1Rv
 KZCjTBkXuaSMadbWvCyz7YAFpKBy45kIFRlry8+Zjph7QSNHgs5j2CSoNkvm9RAPQL98WCsj7Ww
 ANPZrXx4OPGsE8ZS3UMvTt2TSYnPU8OoXfUTAfRhmj0P/dktRLX6Dj8Zyp9wR7w6S7KDZgX6kRp
 xh4SnJ+42yDWBNhNrbVQNCAYTBQUPkY/cnek7QlVjKlQ/COXKh8b9FvGv2uP5jsINhfpjKq4Q+M
 oZoFs09Pe+b5usNPJBajv++yJu7XzoK+ghbKMi1ABN9eg//ej7VLivlDHJU9FEAoWyYjrW+6FGM
 ugYsHrGxg0uRHEYydoFHCb8NWdO1SZNo+6WaVZsTCOzOtVxOjUB8fyWjDYyAkcb5m5MM7aMeNI
X-Received: by 2002:a05:600c:34c3:b0:47a:814c:eea1 with SMTP id
 5b1f17b1804b1-483c21bd28emr40251475e9.35.1772061526287; 
 Wed, 25 Feb 2026 15:18:46 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43987f3ed03sm16948102f8f.16.2026.02.25.15.18.45
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 25 Feb 2026 15:18:45 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 40/70] target/alpha: Expand gdb_get_regl() -> gdb_get_reg64()
Date: Thu, 26 Feb 2026 00:13:40 +0100
Message-ID: <20260225231411.96482-41-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260225231411.96482-1-philmd@linaro.org>
References: <20260225231411.96482-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

The Alpha targets are only built as 64-bit:

  $ git grep TARGET_LONG_BITS configs/targets/alpha-*
  configs/targets/alpha-linux-user.mak:4:TARGET_LONG_BITS=64
  configs/targets/alpha-softmmu.mak:2:TARGET_LONG_BITS=64

Mechanically replace:

  gdb_get_regl() -> gdb_get_reg64()

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20260219191955.83815-33-philmd@linaro.org>
---
 target/alpha/gdbstub.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/alpha/gdbstub.c b/target/alpha/gdbstub.c
index 7722eb46806..b458eadd7d9 100644
--- a/target/alpha/gdbstub.c
+++ b/target/alpha/gdbstub.c
@@ -53,7 +53,7 @@ int alpha_cpu_gdb_read_register(CPUState *cs, GByteArray *mem_buf, int n)
     default:
         return 0;
     }
-    return gdb_get_regl(mem_buf, val);
+    return gdb_get_reg64(mem_buf, val);
 }
 
 int alpha_cpu_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
-- 
2.52.0


