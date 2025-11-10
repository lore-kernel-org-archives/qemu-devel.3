Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 450D0CCFA13
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Nov 2025 11:29:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vIQ59-0000Pf-UG; Mon, 10 Nov 2025 06:29:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vIPne-0004zN-UW
 for qemu-devel@nongnu.org; Mon, 10 Nov 2025 06:11:15 -0500
Received: from mail-oo1-xc34.google.com ([2607:f8b0:4864:20::c34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vIPnc-0004LA-C2
 for qemu-devel@nongnu.org; Mon, 10 Nov 2025 06:11:06 -0500
Received: by mail-oo1-xc34.google.com with SMTP id
 006d021491bc7-653652a4256so1270562eaf.0
 for <qemu-devel@nongnu.org>; Mon, 10 Nov 2025 03:11:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1762773062; x=1763377862; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DHao9ZBgFmJVV7PunBlOeozDZldx+WvW4UpohKz1KQo=;
 b=F+JomiChUQN95CVxY2gPuhxx51qvkT+EO15kkDXs5loR8+oFn1rup2l0kYEvdGKPIB
 i89Qfhxz18xm5NlO6t1nNYi918Bh6BriOAj5Zpyoj2GRwhbsIxbzX1sw1ETmzzU2Tdk9
 SQHoTbfmoAqG6vJ0S1N6l/bKA6j/g1qhV0TjFOKiPfRKuii5DbClp75vIpC/V32lD7Pn
 6ddSDyEChfIf8gn8wc1sCIgwDQE823OA7+aCGQT/mi4ZFJhAy7H9lYjuRg5U0N4h+NkM
 qvaOXU2pU+iUUtnKfDRAPXEm7JS8HsBkhtZp2+71N5DboBDUdylP3xI+zZ1j+/HjOpD6
 hHoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762773062; x=1763377862;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=DHao9ZBgFmJVV7PunBlOeozDZldx+WvW4UpohKz1KQo=;
 b=ki2feTO5bDeGh1Mi+fcCLnWX4h1qNUf1QjYEy/Jg5bnCw4N7dmZn8GT/POzv76wVhc
 v8S/iR/48aKfekn1dpHcn+M0ilc8LEHEEoGtAST9j7WY30FSrcwTkURz8UHSULMIe2fM
 /O0NKBfNqEO2dsHhNwB0iTVK/3/Y8m+izDAPzKbUXNU1lsodqQpMKQzEfDfnfDhkxtbs
 4HVPyIT6ObIIUmwe1ZoKfIROBYbU5FKWwsWvZ6bOshusKW5Yo60znX8OAjyJ0xa8bIm7
 HwpU8IWvCJk9GeGJBtCeFAQGoU9nKYnRFvsdjExbEa5eoV0E61LSuocpIF0hG+pKQrAt
 KStQ==
X-Gm-Message-State: AOJu0Yx18P+Bvx/66B+Sid8+DaLFKPpjCpZ41ilp6bL2/jwu1EBislwR
 BiL6HurUfLGlmbceme1AioS/qskG22TxMUavh+yZCk70Qj/NL87191EmuiRBdURkObhKKQ0SDOd
 U3hjL
X-Gm-Gg: ASbGncsfUniB+JtN74ygYW4IBrKNpVh0t45jvYuH2tlT0jVwt7885fVVLIWImRLVbLd
 7Hp91wKNR+QbK12Q729Zz/A3OSkReVQmIfl77K14OhqDPFLXi3w6EoNu6aQ7DBPsLIIK7qW+kJ/
 dXHb/6RxZ17hHCsuXkXhYG7iaOhSRFTtSbXE6LmKaPzwAn0GP8kBXLdK6Hw+Fe0HtV7hIincgSU
 IE+4S78x9AlmYawtSqp4+VcOw10OccQSnad6nWqfGJ4IUJJuyqFYME/i7BPrYVQZK5227jHcFz5
 xLFHIomXXi7wS+HPqt7NMtyNeAUeIN3jVxWmTu6maHUe4oYGn0JCkzL8THDXX1g+7l24P+pB8J8
 X5Aw9mkO/HPcWTlm8vW+KWSfQfFAxvQ4VZ/B74PNA6+7wQ+v0HGud63NoeiOyf57oM+YMR566Vz
 mQHzooUvLIy7J+h2IMnti4QcMbeiwdEQ==
X-Google-Smtp-Source: AGHT+IEO1yibSeEEWE/tgqVbTFPKhY3z26+xK5EBB3HueJ1BWi/VUAoRI1GtPCADQCHGgwDLmAFWSg==
X-Received: by 2002:a05:6808:220c:b0:43f:61b6:2ab9 with SMTP id
 5614622812f47-4502a1cb1edmr4069511b6e.15.1762773061688; 
 Mon, 10 Nov 2025 03:11:01 -0800 (PST)
Received: from stoup.. ([172.58.183.226]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-450426be56dsm1603412b6e.18.2025.11.10.03.10.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Nov 2025 03:11:01 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
	qemu-stable@nongnu.org
Subject: [PULL 5/5] target/x86: Correctly handle invalid 0x0f 0xc7 0xxx insns
Date: Mon, 10 Nov 2025 12:10:45 +0100
Message-ID: <20251110111046.33990-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251110111046.33990-1-richard.henderson@linaro.org>
References: <20251110111046.33990-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c34;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc34.google.com
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

From: Peter Maydell <peter.maydell@linaro.org>

In the decode_group9() function, if we don't recognise the insn as
one that we should handle, we leave the 'entry' pointer unaltered.
Because the X86OpEntry struct has a union for the gen and decode
pointers, this means that the top level code will call decode.e.gen()
which tries to use the decode function pointer (still set to
decode_group9) as a gen function pointer.

This is undefined behaviour, but seems to be mostly harmless in
practice (we call decode_group9() again with bogus arguments and it
does nothing).  If you have CFI enabled then it will trip the CFI
check:

../target/i386/tcg/decode-new.c.inc:2862:9: runtime error: control flow integrity check for type 'void (struct DisasContext *, struct X86DecodedInsn *)' failed during indirect function call

Set *entry to UNKNOWN_OPCODE to provoke the #UD exception, as we do
in decode_group1A() and decode_group11() for similar situations.

Thanks to the bug reporter for the clear description and analysis of
the bug and the simple reproducer.

Cc: qemu-stable@nongnu.org
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3172
Fixes: fcd16539ebfe2 ("target/i386: convert CMPXCHG8B/CMPXCHG16B to new decoder")
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20251021173152.1695997-1-peter.maydell@linaro.org>
---
 target/i386/tcg/decode-new.c.inc | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/target/i386/tcg/decode-new.c.inc b/target/i386/tcg/decode-new.c.inc
index a50f57dbaa..f4192f1006 100644
--- a/target/i386/tcg/decode-new.c.inc
+++ b/target/i386/tcg/decode-new.c.inc
@@ -335,6 +335,8 @@ static void decode_group9(DisasContext *s, CPUX86State *env, X86OpEntry *entry,
         *entry = group9_reg;
     } else if (op == 1) {
         *entry = REX_W(s) ? cmpxchg16b : cmpxchg8b;
+    } else {
+        *entry = UNKNOWN_OPCODE;
     }
 }
 
-- 
2.43.0


