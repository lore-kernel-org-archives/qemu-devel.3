Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E12EC27C4F
	for <qemu-devel@archiver.kernel.org>; Sun, 30 Jun 2024 19:04:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sNzoF-0005ZX-En; Sun, 30 Jun 2024 15:01:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sNznT-0004vn-On
 for qemu-devel@nongnu.org; Sun, 30 Jun 2024 15:01:11 -0400
Received: from mail-ot1-x32e.google.com ([2607:f8b0:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sNznO-0007Z4-2a
 for qemu-devel@nongnu.org; Sun, 30 Jun 2024 15:01:11 -0400
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-702003e213eso1012397a34.3
 for <qemu-devel@nongnu.org>; Sun, 30 Jun 2024 12:01:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719774065; x=1720378865; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9p2fp7XdbFJ8aljrdGklD3IJ8hzw/a4pd+uON5c7MOU=;
 b=yg/m8W40fe5E/LvFOXqNZBc5k/fi8/WyfkXJHLtUYDMZKXaCtp4nMVbXZJKn638Dp5
 vYR1AZJp5j7wcCOTILHiiVbe7gArQuS23ujv965syz+JM+9tTworgZJTq55jnFILKodW
 4DCtlqTC8FvGMHS3MKOWYno68fz1glrGUtdQfkpmZ9/RyF0CctLda9xau6TuhqLScpaX
 KTPWEZKMiCqnM7x1gwqlBanrd59EnkEhbQAN+cJSZlhAd7qDzt94GeThKW0wAK6Yk5dZ
 aM4tLJjvAFZ1IfuJ59J4y/fvpYmdyPKKdpeyzh9+xJKDBYVxbyb1OIVzgTadrQ5FmlUv
 /ztQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719774065; x=1720378865;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9p2fp7XdbFJ8aljrdGklD3IJ8hzw/a4pd+uON5c7MOU=;
 b=aLohps92KgscYTN53tzLlwc5Kj4U009uS/mLnjTM1YITBGuaS7d9IpkJkkgcyyNT9P
 3NVCcEGiirVoH7NYCQnFceFA40jyxWrxJtfAXe8EIi2uDpZ3y+AdGrcYTbRyJ5jUph0O
 X+RaCpH4PYPmcpvLvPqEQVsgGat8nokmtXA0LGnF65ogvL3SC0DNIzUshSBOj8xot4EM
 /SI1MBbVYJ3bOs91F2Gd0oyt5F827MGVelHAoJF5gxL9xf1pWEe0O2tWg5w9Gx3ClwXu
 pIOAcTsoWZVMQzerzMisi05fZJa1Ks2lGqfz3eBCJ3dx7z5WmoLTaPZoepPqAJI30knO
 4leA==
X-Gm-Message-State: AOJu0YwKmHEqNDWLtguRdgSa0mxZQtA9VeD45TVL+M/zDlnoFWHeMuH5
 bNxicMkbh3bygggHdN42gOLUKN7Ldt8oqC6lUR1YMnM6Jq5rRAPOrakc9xsqkfy2tCEx3zrwPXQ
 d
X-Google-Smtp-Source: AGHT+IHzT+H34aAkrBWOGKQHXfHgGQmXLoe6idPG2FyXai0sBeH/tR4QlDnO4lIA8ijFx8OyYzqaFQ==
X-Received: by 2002:a05:6358:8a2:b0:1a6:35f:964a with SMTP id
 e5c5f4694b2df-1a6acf79589mr411758555d.20.1719774064554; 
 Sun, 30 Jun 2024 12:01:04 -0700 (PDT)
Received: from stoup.. (174-21-76-141.tukw.qwest.net. [174.21.76.141])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2c91d3e7e4bsm5115641a91.52.2024.06.30.12.01.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 30 Jun 2024 12:01:04 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: akihiko.odaki@daynix.com,
	alex.bennee@linaro.org,
	qemu-arm@nongnu.org
Subject: [PATCH v4 13/14] tests/tcg/arm: Use vmrs/vmsr instead of mcr/mrc
Date: Sun, 30 Jun 2024 12:00:49 -0700
Message-Id: <20240630190050.160642-14-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240630190050.160642-1-richard.henderson@linaro.org>
References: <20240630190050.160642-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32e;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x32e.google.com
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

Clang 14 generates

/home/rth/qemu/src/tests/tcg/arm/fcvt.c:431:9: error: invalid operand for instruction
    asm("mrc p10, 7, r1, cr1, cr0, 0\n\t"
        ^
<inline asm>:1:6: note: instantiated into assembly here
        mrc p10, 7, r1, cr1, cr0, 0
            ^
/home/rth/qemu/src/tests/tcg/arm/fcvt.c:432:32: error: invalid operand for instruction
        "orr r1, r1, %[flags]\n\t"
                               ^
<inline asm>:3:6: note: instantiated into assembly here
        mcr p10, 7, r1, cr1, cr0, 0
            ^

This is perhaps a clang bug, but using the neon mnemonic is clearer.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tests/tcg/arm/fcvt.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/tests/tcg/arm/fcvt.c b/tests/tcg/arm/fcvt.c
index d8c61cd29f..ecebbb0247 100644
--- a/tests/tcg/arm/fcvt.c
+++ b/tests/tcg/arm/fcvt.c
@@ -427,10 +427,9 @@ int main(int argc, char *argv[argc])
 
     /* And now with ARM alternative FP16 */
 #if defined(__arm__)
-    /* See glibc sysdeps/arm/fpu_control.h */
-    asm("mrc p10, 7, r1, cr1, cr0, 0\n\t"
+    asm("vmrs r1, fpscr\n\t"
         "orr r1, r1, %[flags]\n\t"
-        "mcr p10, 7, r1, cr1, cr0, 0\n\t"
+        "vmsr fpscr, r1"
         : /* no output */ : [flags] "n" (1 << 26) : "r1" );
 #else
     asm("mrs x1, fpcr\n\t"
-- 
2.34.1


