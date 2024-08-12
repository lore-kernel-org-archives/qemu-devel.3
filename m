Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 539B8C3DA4A
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Aug 2024 02:59:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sdLGs-0004OO-5V; Sun, 11 Aug 2024 22:58:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sdLGq-0004Hf-BJ
 for qemu-devel@nongnu.org; Sun, 11 Aug 2024 22:58:56 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sdLGo-0003em-JL
 for qemu-devel@nongnu.org; Sun, 11 Aug 2024 22:58:56 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-70d1fb6c108so2690617b3a.3
 for <qemu-devel@nongnu.org>; Sun, 11 Aug 2024 19:58:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723431533; x=1724036333; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uTnoluISZ2MwVzhPbDJiXvg9KVOpgY1wyPYE6S/EINo=;
 b=fjxCcQruuUVdQseaoTzlwptQeVoVQxjpVkCLNO9z9roGao3Lx5dyxbONt/7PngZPio
 LRMRQwocq4EOzHf7OwzluKznbaT4fZsiE/+kZ83o5VH9DrOAjVkxK5lhEbGJBuOXJoMc
 OwHIgTyk2EF8FZ92aBUobrClVylyoKqxNHj8HRWQHox9Ubyvtc43IM23eQlBOmnvHfxK
 gcQyrDK1t3ZeDsQqXQlbtjlyggv5dSV7Sn9jpl27fKzKHJGMv5P5PYBHUM108lYWoaPv
 PZvwTpaeYlXET3S6ztpPxygkvmHCMH2NrI4Oq7V5pSuALjnOLv3Jynr635MAuDIfcee6
 mSIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723431533; x=1724036333;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uTnoluISZ2MwVzhPbDJiXvg9KVOpgY1wyPYE6S/EINo=;
 b=Go8PT91Tcx6qO31qJ+UbTMHUn01BaQYRfXXmz4RsY7t57D+jio8mmyGJx7IYrpZF5u
 kMI9xYFScWey9HbEAB05sIfC8/sZTlJBpMqSvri7zkaKmAiUMukHEg1Cfl8LblNjTWGl
 F9w2SMBKpMYMzCGuutO7y9iGx1hPYpEsgg50m1DXkjbixxypnb5UV4HJHPQXMqJLP+Kd
 EVeXExj4Y2zNGM4nvqbS9SP02ySGNfLF3i24vfheJ+Ny25kNPkpRMIH8QmCS+xHodFcs
 tFml8d18Pcn9kLEUlPdlpi/K6RIV8NBlWTCqEWbPmG7pvYlSOYUJsqgr5cLRlQvz+vtj
 plVw==
X-Gm-Message-State: AOJu0YwnOd40gcJQGaHR79sI2GsHvCOVOiD+yBXoxQilzkW1nTBiWH1l
 TOvOh13qWwHWEToOsxe1RoPPFy+AbIr7bK5YsuX89ZtN3GjXECeX1eFtMK1VNKeGiXUavYJ1zaK
 rork=
X-Google-Smtp-Source: AGHT+IFp8T8ktTiyPWuzR72QnaLlPB9/uu6ZEzxIptx6nmDRIgZ0KXqKR78Zd06YruQeERaruMmrcQ==
X-Received: by 2002:a05:6a00:23c7:b0:706:284f:6a68 with SMTP id
 d2e1a72fcca58-710dcaecfb3mr6227691b3a.23.1723431532714; 
 Sun, 11 Aug 2024 19:58:52 -0700 (PDT)
Received: from stoup.. ([203.30.4.111]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-710e5a43b49sm2984841b3a.100.2024.08.11.19.58.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 Aug 2024 19:58:52 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com,
	qemu-stable@nongnu.org
Subject: [PATCH 1/3] target/i386: Do not apply REX to MMX operands
Date: Mon, 12 Aug 2024 12:58:42 +1000
Message-ID: <20240812025844.58956-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240812025844.58956-1-richard.henderson@linaro.org>
References: <20240812025844.58956-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42f.google.com
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

Cc: qemu-stable@nongnu.org
Fixes: b3e22b2318a ("target/i386: add core of new i386 decoder")
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2495
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/i386/tcg/decode-new.c.inc | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/target/i386/tcg/decode-new.c.inc b/target/i386/tcg/decode-new.c.inc
index b22210f45d..03138b3876 100644
--- a/target/i386/tcg/decode-new.c.inc
+++ b/target/i386/tcg/decode-new.c.inc
@@ -1979,7 +1979,10 @@ static bool decode_op(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode,
             op->unit = X86_OP_SSE;
         }
     get_reg:
-        op->n = ((get_modrm(s, env) >> 3) & 7) | REX_R(s);
+        op->n = ((get_modrm(s, env) >> 3) & 7);
+        if (op->unit != X86_OP_MMX) {
+            op->n |= REX_R(s);
+        }
         break;
 
     case X86_TYPE_E:  /* ALU modrm operand */
-- 
2.43.0


