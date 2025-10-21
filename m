Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F756CCD1A7
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Oct 2025 17:32:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBGDH-0000K5-Pv; Tue, 21 Oct 2025 13:31:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vBGDG-0000Jt-Ga
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 13:31:58 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vBGDE-0003ST-AP
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 13:31:58 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-471131d6121so46004785e9.1
 for <qemu-devel@nongnu.org>; Tue, 21 Oct 2025 10:31:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761067914; x=1761672714; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=fzYRYzOJyVbAdZ4b5oTMi1DK6fs6nMUpWqgzZh8E360=;
 b=WfIZOuuQKoDwqyODvAq8HGuK/1sXlIB2ksKNmGeAW8PRXKGYSioCCfCVV0rHD0OcTC
 ZbXtcqd+5Pjxp7nV1Kvwbk8/2FyrgOfR8feAkwlbcC0FVfh3qTUu8o7c4Pr7gQOO6K5x
 u1LHLIvgk+IOBvnwAcYW6gF6pBfPUSVNPVIN5sVa1qmNOOVJ5qP73OrSPHUzNNvUqJjJ
 cj//DtBvR3U78dvhlX+Ul6lejEWiRdBN5CeZx4syosWrIrqxFDTx3Q30CJoPwd9B94Yi
 srcc7Nc+42AG7WzNm/nBw9gDgXNVMn8Amf2SEy6EGEHLkfd4YbaBqCtTIkG9X4j2oyKd
 eU0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761067914; x=1761672714;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fzYRYzOJyVbAdZ4b5oTMi1DK6fs6nMUpWqgzZh8E360=;
 b=LiDKYT+cfJ6LsNk1A4tCKZrYCaJu8c7AREi1PSAOdYjlwyetXFkyjzHD9dudV7mlqm
 qxdhY46mXeVVzTF3BQubpPI1WcgYLhLSp7v3qqUuC9/R8JefZqx6yqP7aZ9NqWu8u7j8
 1Q4oQV75GYw+g2f7APFYsoQy6JpgcCe/lykaQWSe/lX18GetGpjaBWNtjzEXwklMNTla
 eC+PUvhA4M81aM949AqqzB1E39l2w2N48xL6osdgDCXN5Tqay+nHDu2wkgjDiTSj5EZj
 cFa2u3n6KbYkqcvRt490M87wczm9ZZCgwSxOyralI2tAMTJInrzTYoqPqa4WxujDOiiR
 PAUw==
X-Gm-Message-State: AOJu0YzurySXTDsSwRVTMzSmTsV3gSmzKJj58V38hlZJTpFbdKTj5kFy
 Db/RKGX/kNiSrRwHV+F4NnfjHjY5JhLSEkMsoICVIgy7hxX9U/Y5r1NaZksWuAWLwCvH4JdiODu
 w3r5q
X-Gm-Gg: ASbGncsDU7HGZs9yxV2xWL8rLJq9VWIwZL6vOgMlhUKRA/m2v9Fv09vWySj2uZqCxrd
 9giB5vQAp/UwyGMNePx4wt31+qtoftPL8gjoPhK9uT1V+qS6OE6/Ru6DHBN7azUZB1khOjgTviQ
 +gkAwKfzzQBpevSCWzBWopmexKWkEhWdGyo5S6OQa/Ng4qINToGX9fgf8hfcZpa3uXN5SGuHHY1
 Q6eiP0xBc1Ya37o8c2p1Iw/xPTGW8htTXDmQ8Avs2jBS975zR+EqeMptheY+j+6p13jovdDHjcw
 KArPDn+oqgUPuXRrZMpoZNTfnU7G8uuiK2SjxSW9YV5PTo8jmwHZWnHMlzTpVG27ss32zliEgre
 WVMTKJXMtuQ/wUESwQG+yeThsmJDZ+cCf+H9ehVkII3iWQqsJ0/2AHV+OuHpjR8VZnopTT696Ie
 9T5fRGZ+tlo+0jP0eG
X-Google-Smtp-Source: AGHT+IHoZibVoYDCFsP0Kogi2h9l99+QLKbH1uiWDwb3/4qM+8rIySnCCz6JwkyOYT8JNK1220IqQQ==
X-Received: by 2002:a05:600c:3b03:b0:46e:53cb:9e7f with SMTP id
 5b1f17b1804b1-471178a3ff6mr127808055e9.18.1761067913955; 
 Tue, 21 Oct 2025 10:31:53 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-475c4369b3esm2354725e9.13.2025.10.21.10.31.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Oct 2025 10:31:53 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: [PATCH] target/x86: Correctly handle invalid 0x0f 0xc7 0xxx insns
Date: Tue, 21 Oct 2025 18:31:51 +0100
Message-ID: <20251021173152.1695997-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x332.google.com
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
---
 target/i386/tcg/decode-new.c.inc | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/target/i386/tcg/decode-new.c.inc b/target/i386/tcg/decode-new.c.inc
index a50f57dbaab..f4192f10068 100644
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


