Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F094CD4F5E
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 04:41:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPYh7-0001JM-BK; Wed, 20 May 2026 00:38:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wPYh4-0001Id-CN
 for qemu-devel@nongnu.org; Wed, 20 May 2026 00:38:06 -0400
Received: from mail-ot1-x330.google.com ([2607:f8b0:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wPYgz-0003v9-Rc
 for qemu-devel@nongnu.org; Wed, 20 May 2026 00:38:04 -0400
Received: by mail-ot1-x330.google.com with SMTP id
 46e09a7af769-7dea1272943so2087475a34.0
 for <qemu-devel@nongnu.org>; Tue, 19 May 2026 21:38:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779251881; x=1779856681; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=yHZWpGY0QJSV2gclY4Jc/+86UjY1XPfedLkGpRhAq28=;
 b=NQ/ZGEy6Z/HwdrtrXilFBd1m9qyvbBmoB3cTUFcFxk9HeI7YbRN/sbP6KZHARLOUSj
 X/TN0ByoAsDuFz3w742NC8DQWZtZN81nsHWMRTzk1V6l2RJ74htqnnIkL1ynBdy+nbNd
 hYnC3TqOjZHvhrPhE1VNltyO3Kg0NKZBAmmNYIbBVulgRrlsHxAZ2u93FzOVpFLN5gJS
 3jNPVVHKEdHB9okIR+6dVmCMqJnfZTuYb55S6/DEI5grn/6d4rZJUPIp1ctnIfzKdd9m
 oa3zHaulIymn3ZTws0FxEHA8s9y+LBLoq7RQYmP+EXp464USjD2exEMAR+CgUjDgEZ8s
 tqsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779251881; x=1779856681;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=yHZWpGY0QJSV2gclY4Jc/+86UjY1XPfedLkGpRhAq28=;
 b=hBnUAtcrrsZFtJys78iIyhr9Q6tpxd2wYOx9fs4mEk/wRVN5nhSMQE3+O7JtzO/h1f
 Uqkl6PN+DwoqEZZ09uTFB6m8OF7ctup2PHFORd/i6E3evk1Cqb8/2d0OUswXvhUYzXru
 SpP71kRcZ8oKBW+fSBpgqfWSHpcjtQkFbeYUpazxSeaTb3dlKbV9RsZ80gEkwi32BQFo
 38B+/LuqKGzSrCMKJoevmtcfG9Tmd4exPiBnH9meWare4V2kN+AXs/n5YdgKC5gLzwgD
 CM8BGdllfDTGN1cz4XOtu8rD+19QLgK1sI6wHd17To48juMuOyN6UCvHgC0rOVdkz8yv
 uznQ==
X-Gm-Message-State: AOJu0Yxy87/jDM8hRhm4LvlMHbhDIXAux4ZnEuX4S6tN+XQXTS9GD7ZZ
 6SI9/iGngpT0BOaNUSau0wI0s31/jIpmYzeGV9XQpqwuh+Iagk7Y7HcV
X-Gm-Gg: Acq92OF7hjCZOnNE+DoaOLGoA0DYBT/KEAXZRnCCYJaRN+R0tmImZmPIRuOAItC/SGn
 +FwqocH/t4w29Zl/BkWXOy3nryJ0NMDkTdfMYh0RzHfayBN8ERcqSEx+M+GL8+Xz1Tj+ocDeU0A
 tVl2gubInnyjTDtNGxrlr8rZzwESV+A+QaJSyqvU7UXvonVzWOdUc5+KKG58gj82UnyVWa4FVV7
 FGKTYc0KGoYsmc/borGlGkc2yN3qMPW5Fi8xtHGufjUGUfWy+VT0DfRrihgrpYc5j8/6TUiFGLS
 dLYfOlZMQNcB0olgTH0L+jrBjLCXzArKW0cT+iGG/Zy7qy6bxFebweLYKOvEmb6y+zMj059Wuzb
 ZX99qRRDFIURG8Yiwy0+8Cz/UCZeTv8tNwCnr6xjEZUzs4q2s1mUUWzvCCwesGIpkuVO5E9LjAr
 aYAv7ZK6KbpDK63c2rCds0+Rkwjh/hvwtKGc+QIliXiSk3LfcbD1WWDpV+ECIOwzewlqQ8EdCX6
 Z08WyHQFH7Gx0kx4Kfd8V9E7iYV/ezDqz3lUONLerYazujZAHQ6LZ47VJfI44/ODJgT
X-Received: by 2002:a05:6830:2b27:b0:7de:a330:ecb8 with SMTP id
 46e09a7af769-7e4f2b4488dmr15939603a34.16.1779251880684; 
 Tue, 19 May 2026 21:38:00 -0700 (PDT)
Received: from mac.localdomain (184-96-146-19.hlrn.qwest.net. [184.96.146.19])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e55bc4f04fsm11574634a34.27.2026.05.19.21.37.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 May 2026 21:38:00 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Tue, 19 May 2026 22:37:33 -0600
Subject: [PATCH v10 39/45] target/mips: decode Octeon HSH and SHA3 COP2
 selectors
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260519-mips-octeon-missing-insns-v2-v10-39-306f9edfe15b@gmail.com>
References: <20260519-mips-octeon-missing-insns-v2-v10-0-306f9edfe15b@gmail.com>
In-Reply-To: <20260519-mips-octeon-missing-insns-v2-v10-0-306f9edfe15b@gmail.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Aurelien Jarno <aurelien@aurel32.net>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Aleksandar Rikalo <arikalo@gmail.com>, Huacai Chen <chenhuacai@kernel.org>, 
 James Hilliard <james.hilliard1@gmail.com>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>
X-Mailer: b4 0.15.2
Received-SPF: pass client-ip=2607:f8b0:4864:20::330;
 envelope-from=james.hilliard1@gmail.com; helo=mail-ot1-x330.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

Add explicit decodetree entries and translator bindings for the Octeon
HSH shared-window selectors and SHA3 operation selectors.  These paths
need helper calls because HSH/SHA3 selectors alias the architectural hash
register window and operation selectors have visible side effects.

Keep HSH/SHA3 decode separate from direct register transfers because the
shared hash-window aliases require helper-mediated state updates.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 target/mips/tcg/octeon.decode      | 75 ++++++++++++++++++++++++++++++++++++++
 target/mips/tcg/octeon_translate.c | 75 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 150 insertions(+)

diff --git a/target/mips/tcg/octeon.decode b/target/mips/tcg/octeon.decode
index fe9c97e380..f224cdc7a3 100644
--- a/target/mips/tcg/octeon.decode
+++ b/target/mips/tcg/octeon.decode
@@ -106,6 +106,7 @@ LDX          011111 ..... ..... ..... 01000 001010 @lx
     CVM_MF_HSH_IV1                       010010 00001 rt:5 0000 0000 0100 1001 &cp2
     CVM_MF_HSH_IV2                       010010 00001 rt:5 0000 0000 0100 1010 &cp2
     CVM_MF_HSH_IV3                       010010 00001 rt:5 0000 0000 0100 1011 &cp2
+    CVM_MF_SHA3_DAT24                    010010 00001 rt:5 0000 0000 0101 0000 &cp2
     CVM_MF_GFM_MUL_REFLECT0              010010 00001 rt:5 0000 0000 0101 1000 &cp2
     CVM_MF_GFM_MUL_REFLECT1              010010 00001 rt:5 0000 0000 0101 1001 &cp2
     CVM_MF_GFM_RESINP_REFLECT0           010010 00001 rt:5 0000 0000 0101 1010 &cp2
@@ -130,6 +131,30 @@ LDX          011111 ..... ..... ..... 01000 001010 @lx
     CVM_MF_CRC_IV                        010010 00001 rt:5 0000 0010 0000 0001 &cp2
     CVM_MF_CRC_LEN                       010010 00001 rt:5 0000 0010 0000 0010 &cp2
     CVM_MF_CRC_IV_REFLECT                010010 00001 rt:5 0000 0010 0000 0011 &cp2
+    CVM_MF_HSH_DATW0                     010010 00001 rt:5 0000 0010 0100 0000 &cp2
+    CVM_MF_HSH_DATW1                     010010 00001 rt:5 0000 0010 0100 0001 &cp2
+    CVM_MF_HSH_DATW2                     010010 00001 rt:5 0000 0010 0100 0010 &cp2
+    CVM_MF_HSH_DATW3                     010010 00001 rt:5 0000 0010 0100 0011 &cp2
+    CVM_MF_HSH_DATW4                     010010 00001 rt:5 0000 0010 0100 0100 &cp2
+    CVM_MF_HSH_DATW5                     010010 00001 rt:5 0000 0010 0100 0101 &cp2
+    CVM_MF_HSH_DATW6                     010010 00001 rt:5 0000 0010 0100 0110 &cp2
+    CVM_MF_HSH_DATW7                     010010 00001 rt:5 0000 0010 0100 0111 &cp2
+    CVM_MF_HSH_DATW8                     010010 00001 rt:5 0000 0010 0100 1000 &cp2
+    CVM_MF_HSH_DATW9                     010010 00001 rt:5 0000 0010 0100 1001 &cp2
+    CVM_MF_HSH_DATW10                    010010 00001 rt:5 0000 0010 0100 1010 &cp2
+    CVM_MF_HSH_DATW11                    010010 00001 rt:5 0000 0010 0100 1011 &cp2
+    CVM_MF_HSH_DATW12                    010010 00001 rt:5 0000 0010 0100 1100 &cp2
+    CVM_MF_HSH_DATW13                    010010 00001 rt:5 0000 0010 0100 1101 &cp2
+    CVM_MF_HSH_DATW14                    010010 00001 rt:5 0000 0010 0100 1110 &cp2
+    CVM_MF_HSH_DATW15                    010010 00001 rt:5 0000 0010 0100 1111 &cp2
+    CVM_MF_HSH_IVW0                      010010 00001 rt:5 0000 0010 0101 0000 &cp2
+    CVM_MF_HSH_IVW1                      010010 00001 rt:5 0000 0010 0101 0001 &cp2
+    CVM_MF_HSH_IVW2                      010010 00001 rt:5 0000 0010 0101 0010 &cp2
+    CVM_MF_HSH_IVW3                      010010 00001 rt:5 0000 0010 0101 0011 &cp2
+    CVM_MF_HSH_IVW4                      010010 00001 rt:5 0000 0010 0101 0100 &cp2
+    CVM_MF_HSH_IVW5                      010010 00001 rt:5 0000 0010 0101 0101 &cp2
+    CVM_MF_HSH_IVW6                      010010 00001 rt:5 0000 0010 0101 0110 &cp2
+    CVM_MF_HSH_IVW7                      010010 00001 rt:5 0000 0010 0101 0111 &cp2
     CVM_MF_GFM_MUL0                      010010 00001 rt:5 0000 0010 0101 1000 &cp2
     CVM_MF_GFM_MUL1                      010010 00001 rt:5 0000 0010 0101 1001 &cp2
     CVM_MF_GFM_RESINP0                   010010 00001 rt:5 0000 0010 0101 1010 &cp2
@@ -146,6 +171,9 @@ LDX          011111 ..... ..... ..... 01000 001010 @lx
     CVM_MT_HSH_IV1                       010010 00101 rt:5 0000 0000 0100 1001 &cp2
     CVM_MT_HSH_IV2                       010010 00101 rt:5 0000 0000 0100 1010 &cp2
     CVM_MT_HSH_IV3                       010010 00101 rt:5 0000 0000 0100 1011 &cp2
+    CVM_MT_SHA3_DAT24                    010010 00101 rt:5 0000 0000 0101 0000 &cp2
+    CVM_MT_SHA3_DAT15                    010010 00101 rt:5 0000 0000 0101 0001 &cp2
+    CVM_MT_HSH_STARTSHA_COMPAT           010010 00101 rt:5 0000 0000 0101 0111 &cp2
     CVM_MT_GFM_MUL_REFLECT0              010010 00101 rt:5 0000 0000 0101 1000 &cp2
     CVM_MT_GFM_MUL_REFLECT1              010010 00101 rt:5 0000 0000 0101 1001 &cp2
     CVM_MT_GFM_XOR0_REFLECT              010010 00101 rt:5 0000 0000 0101 1100 &cp2
@@ -175,20 +203,67 @@ LDX          011111 ..... ..... ..... 01000 001010 @lx
     CVM_MT_CRC_WRITE_BYTE_REFLECT        010010 00101 rt:5 0000 0010 0001 0100 &cp2
     CVM_MT_CRC_WRITE_HALF_REFLECT        010010 00101 rt:5 0000 0010 0001 0101 &cp2
     CVM_MT_CRC_WRITE_WORD_REFLECT        010010 00101 rt:5 0000 0010 0001 0110 &cp2
+    CVM_MT_HSH_DATW0                     010010 00101 rt:5 0000 0010 0100 0000 &cp2
+    CVM_MT_HSH_DATW1                     010010 00101 rt:5 0000 0010 0100 0001 &cp2
+    CVM_MT_HSH_DATW2                     010010 00101 rt:5 0000 0010 0100 0010 &cp2
+    CVM_MT_HSH_DATW3                     010010 00101 rt:5 0000 0010 0100 0011 &cp2
+    CVM_MT_HSH_DATW4                     010010 00101 rt:5 0000 0010 0100 0100 &cp2
+    CVM_MT_HSH_DATW5                     010010 00101 rt:5 0000 0010 0100 0101 &cp2
+    CVM_MT_HSH_DATW6                     010010 00101 rt:5 0000 0010 0100 0110 &cp2
+    CVM_MT_HSH_DATW7                     010010 00101 rt:5 0000 0010 0100 0111 &cp2
+    CVM_MT_HSH_DATW8                     010010 00101 rt:5 0000 0010 0100 1000 &cp2
+    CVM_MT_HSH_DATW9                     010010 00101 rt:5 0000 0010 0100 1001 &cp2
+    CVM_MT_HSH_DATW10                    010010 00101 rt:5 0000 0010 0100 1010 &cp2
+    CVM_MT_HSH_DATW11                    010010 00101 rt:5 0000 0010 0100 1011 &cp2
+    CVM_MT_HSH_DATW12                    010010 00101 rt:5 0000 0010 0100 1100 &cp2
+    CVM_MT_HSH_DATW13                    010010 00101 rt:5 0000 0010 0100 1101 &cp2
+    CVM_MT_HSH_DATW14                    010010 00101 rt:5 0000 0010 0100 1110 &cp2
+    CVM_MT_HSH_DATW15                    010010 00101 rt:5 0000 0010 0100 1111 &cp2
+    CVM_MT_HSH_IVW0                      010010 00101 rt:5 0000 0010 0101 0000 &cp2
+    CVM_MT_HSH_IVW1                      010010 00101 rt:5 0000 0010 0101 0001 &cp2
+    CVM_MT_HSH_IVW2                      010010 00101 rt:5 0000 0010 0101 0010 &cp2
+    CVM_MT_HSH_IVW3                      010010 00101 rt:5 0000 0010 0101 0011 &cp2
+    CVM_MT_HSH_IVW4                      010010 00101 rt:5 0000 0010 0101 0100 &cp2
+    CVM_MT_HSH_IVW5                      010010 00101 rt:5 0000 0010 0101 0101 &cp2
+    CVM_MT_HSH_IVW6                      010010 00101 rt:5 0000 0010 0101 0110 &cp2
+    CVM_MT_HSH_IVW7                      010010 00101 rt:5 0000 0010 0101 0111 &cp2
     CVM_MT_GFM_MUL0                      010010 00101 rt:5 0000 0010 0101 1000 &cp2
     CVM_MT_GFM_MUL1                      010010 00101 rt:5 0000 0010 0101 1001 &cp2
     CVM_MT_GFM_RESINP0                   010010 00101 rt:5 0000 0010 0101 1010 &cp2
     CVM_MT_GFM_RESINP1                   010010 00101 rt:5 0000 0010 0101 1011 &cp2
     CVM_MT_GFM_XOR0                      010010 00101 rt:5 0000 0010 0101 1100 &cp2
     CVM_MT_GFM_POLY                      010010 00101 rt:5 0000 0010 0101 1110 &cp2
+    CVM_MT_SHA3_XORDAT0                  010010 00101 rt:5 0000 0010 1100 0000 &cp2
+    CVM_MT_SHA3_XORDAT1                  010010 00101 rt:5 0000 0010 1100 0001 &cp2
+    CVM_MT_SHA3_XORDAT2                  010010 00101 rt:5 0000 0010 1100 0010 &cp2
+    CVM_MT_SHA3_XORDAT3                  010010 00101 rt:5 0000 0010 1100 0011 &cp2
+    CVM_MT_SHA3_XORDAT4                  010010 00101 rt:5 0000 0010 1100 0100 &cp2
+    CVM_MT_SHA3_XORDAT5                  010010 00101 rt:5 0000 0010 1100 0101 &cp2
+    CVM_MT_SHA3_XORDAT6                  010010 00101 rt:5 0000 0010 1100 0110 &cp2
+    CVM_MT_SHA3_XORDAT7                  010010 00101 rt:5 0000 0010 1100 0111 &cp2
+    CVM_MT_SHA3_XORDAT8                  010010 00101 rt:5 0000 0010 1100 1000 &cp2
+    CVM_MT_SHA3_XORDAT9                  010010 00101 rt:5 0000 0010 1100 1001 &cp2
+    CVM_MT_SHA3_XORDAT10                 010010 00101 rt:5 0000 0010 1100 1010 &cp2
+    CVM_MT_SHA3_XORDAT11                 010010 00101 rt:5 0000 0010 1100 1011 &cp2
+    CVM_MT_SHA3_XORDAT12                 010010 00101 rt:5 0000 0010 1100 1100 &cp2
+    CVM_MT_SHA3_XORDAT13                 010010 00101 rt:5 0000 0010 1100 1101 &cp2
+    CVM_MT_SHA3_XORDAT14                 010010 00101 rt:5 0000 0010 1100 1110 &cp2
+    CVM_MT_SHA3_XORDAT15                 010010 00101 rt:5 0000 0010 1100 1111 &cp2
+    CVM_MT_SHA3_XORDAT16                 010010 00101 rt:5 0000 0010 1101 0000 &cp2
+    CVM_MT_SHA3_XORDAT17                 010010 00101 rt:5 0000 0010 1101 0001 &cp2
     CVM_MT_CRC_WRITE_LEN                 010010 00101 rt:5 0001 0010 0000 0010 &cp2
     CVM_MT_CRC_WRITE_DWORD               010010 00101 rt:5 0001 0010 0000 0111 &cp2
     CVM_MT_CRC_WRITE_VAR                 010010 00101 rt:5 0001 0010 0000 1000 &cp2
     CVM_MT_CRC_WRITE_DWORD_REFLECT       010010 00101 rt:5 0001 0010 0001 0111 &cp2
     CVM_MT_CRC_WRITE_VAR_REFLECT         010010 00101 rt:5 0001 0010 0001 1000 &cp2
+    CVM_MT_HSH_STARTMD5                  010010 00101 rt:5 0100 0000 0100 0111 &cp2
+    CVM_MT_HSH_STARTSHA256               010010 00101 rt:5 0100 0000 0100 1111 &cp2
+    CVM_MT_SHA3_STARTOP                  010010 00101 rt:5 0100 0000 0101 0010 &cp2
+    CVM_MT_HSH_STARTSHA                  010010 00101 rt:5 0100 0000 0101 0111 &cp2
     CVM_MT_GFM_XORMUL1_REFLECT           010010 00101 rt:5 0100 0000 0101 1101 &cp2
     CVM_MT_CRC_WRITE_POLYNOMIAL          010010 00101 rt:5 0100 0010 0000 0000 &cp2
     CVM_MT_CRC_WRITE_POLYNOMIAL_REFLECT  010010 00101 rt:5 0100 0010 0001 0000 &cp2
+    CVM_MT_HSH_STARTSHA512               010010 00101 rt:5 0100 0010 0100 1111 &cp2
     CVM_MT_GFM_XORMUL1                   010010 00101 rt:5 0100 0010 0101 1101 &cp2
   ]
 }
diff --git a/target/mips/tcg/octeon_translate.c b/target/mips/tcg/octeon_translate.c
index ee69c7c652..c494eb9383 100644
--- a/target/mips/tcg/octeon_translate.c
+++ b/target/mips/tcg/octeon_translate.c
@@ -182,6 +182,31 @@ CP2_MF_I64(CVM_MF_GFM_RESINP1, gfm_resinp[1]);
 CP2_MF_U16(CVM_MF_GFM_POLY, gfm_poly);
 
 CP2_MF_HELPER(CVM_MF_CRC_IV_REFLECT, crc_iv_reflect);
+CP2_MF_HELPER(CVM_MF_SHA3_DAT24, sha3_dat24);
+CP2_MF_HELPER(CVM_MF_HSH_DATW0, hsh_dat0);
+CP2_MF_HELPER(CVM_MF_HSH_DATW1, hsh_dat1);
+CP2_MF_HELPER(CVM_MF_HSH_DATW2, hsh_dat2);
+CP2_MF_HELPER(CVM_MF_HSH_DATW3, hsh_dat3);
+CP2_MF_HELPER(CVM_MF_HSH_DATW4, hsh_dat4);
+CP2_MF_HELPER(CVM_MF_HSH_DATW5, hsh_dat5);
+CP2_MF_HELPER(CVM_MF_HSH_DATW6, hsh_dat6);
+CP2_MF_HELPER(CVM_MF_HSH_DATW7, hsh_dat7);
+CP2_MF_HELPER(CVM_MF_HSH_DATW8, hsh_dat8);
+CP2_MF_HELPER(CVM_MF_HSH_DATW9, hsh_dat9);
+CP2_MF_HELPER(CVM_MF_HSH_DATW10, hsh_dat10);
+CP2_MF_HELPER(CVM_MF_HSH_DATW11, hsh_dat11);
+CP2_MF_HELPER(CVM_MF_HSH_DATW12, hsh_dat12);
+CP2_MF_HELPER(CVM_MF_HSH_DATW13, hsh_dat13);
+CP2_MF_HELPER(CVM_MF_HSH_DATW14, hsh_dat14);
+CP2_MF_HELPER(CVM_MF_HSH_DATW15, hsh_dat15);
+CP2_MF_HELPER(CVM_MF_HSH_IVW0, hsh_iv0);
+CP2_MF_HELPER(CVM_MF_HSH_IVW1, hsh_iv1);
+CP2_MF_HELPER(CVM_MF_HSH_IVW2, hsh_iv2);
+CP2_MF_HELPER(CVM_MF_HSH_IVW3, hsh_iv3);
+CP2_MF_HELPER(CVM_MF_HSH_IVW4, hsh_iv4);
+CP2_MF_HELPER(CVM_MF_HSH_IVW5, hsh_iv5);
+CP2_MF_HELPER(CVM_MF_HSH_IVW6, hsh_iv6);
+CP2_MF_HELPER(CVM_MF_HSH_IVW7, hsh_iv7);
 
 CP2_MT_I64(CVM_MT_HSH_DAT0, hsh_dat[0]);
 CP2_MT_I64(CVM_MT_HSH_DAT1, hsh_dat[1]);
@@ -239,6 +264,56 @@ CP2_MT_HELPER(CVM_MT_CRC_WRITE_DWORD_REFLECT, crc_write_dword_reflect);
 CP2_MT_HELPER(CVM_MT_CRC_WRITE_VAR_REFLECT, crc_write_var_reflect);
 CP2_MT_HELPER(CVM_MT_GFM_XORMUL1_REFLECT, gfm_xormul1_reflect);
 CP2_MT_HELPER(CVM_MT_GFM_XORMUL1, gfm_xormul1);
+CP2_MT_HELPER(CVM_MT_SHA3_DAT24, sha3_dat24);
+CP2_MT_HELPER(CVM_MT_SHA3_DAT15, sha3_dat15);
+CP2_MT_HELPER(CVM_MT_SHA3_XORDAT0, sha3_xordat0);
+CP2_MT_HELPER(CVM_MT_SHA3_XORDAT1, sha3_xordat1);
+CP2_MT_HELPER(CVM_MT_SHA3_XORDAT2, sha3_xordat2);
+CP2_MT_HELPER(CVM_MT_SHA3_XORDAT3, sha3_xordat3);
+CP2_MT_HELPER(CVM_MT_SHA3_XORDAT4, sha3_xordat4);
+CP2_MT_HELPER(CVM_MT_SHA3_XORDAT5, sha3_xordat5);
+CP2_MT_HELPER(CVM_MT_SHA3_XORDAT6, sha3_xordat6);
+CP2_MT_HELPER(CVM_MT_SHA3_XORDAT7, sha3_xordat7);
+CP2_MT_HELPER(CVM_MT_SHA3_XORDAT8, sha3_xordat8);
+CP2_MT_HELPER(CVM_MT_SHA3_XORDAT9, sha3_xordat9);
+CP2_MT_HELPER(CVM_MT_SHA3_XORDAT10, sha3_xordat10);
+CP2_MT_HELPER(CVM_MT_SHA3_XORDAT11, sha3_xordat11);
+CP2_MT_HELPER(CVM_MT_SHA3_XORDAT12, sha3_xordat12);
+CP2_MT_HELPER(CVM_MT_SHA3_XORDAT13, sha3_xordat13);
+CP2_MT_HELPER(CVM_MT_SHA3_XORDAT14, sha3_xordat14);
+CP2_MT_HELPER(CVM_MT_SHA3_XORDAT15, sha3_xordat15);
+CP2_MT_HELPER(CVM_MT_SHA3_XORDAT16, sha3_xordat16);
+CP2_MT_HELPER(CVM_MT_SHA3_XORDAT17, sha3_xordat17);
+CP2_MT_HELPER(CVM_MT_SHA3_STARTOP, sha3_startop);
+CP2_MT_HELPER(CVM_MT_HSH_STARTSHA_COMPAT, hsh_startsha_compat);
+CP2_MT_HELPER(CVM_MT_HSH_DATW0, hsh_dat0);
+CP2_MT_HELPER(CVM_MT_HSH_DATW1, hsh_dat1);
+CP2_MT_HELPER(CVM_MT_HSH_DATW2, hsh_dat2);
+CP2_MT_HELPER(CVM_MT_HSH_DATW3, hsh_dat3);
+CP2_MT_HELPER(CVM_MT_HSH_DATW4, hsh_dat4);
+CP2_MT_HELPER(CVM_MT_HSH_DATW5, hsh_dat5);
+CP2_MT_HELPER(CVM_MT_HSH_DATW6, hsh_dat6);
+CP2_MT_HELPER(CVM_MT_HSH_DATW7, hsh_dat7);
+CP2_MT_HELPER(CVM_MT_HSH_DATW8, hsh_dat8);
+CP2_MT_HELPER(CVM_MT_HSH_DATW9, hsh_dat9);
+CP2_MT_HELPER(CVM_MT_HSH_DATW10, hsh_dat10);
+CP2_MT_HELPER(CVM_MT_HSH_DATW11, hsh_dat11);
+CP2_MT_HELPER(CVM_MT_HSH_DATW12, hsh_dat12);
+CP2_MT_HELPER(CVM_MT_HSH_DATW13, hsh_dat13);
+CP2_MT_HELPER(CVM_MT_HSH_DATW14, hsh_dat14);
+CP2_MT_HELPER(CVM_MT_HSH_DATW15, hsh_dat15);
+CP2_MT_HELPER(CVM_MT_HSH_IVW0, hsh_iv0);
+CP2_MT_HELPER(CVM_MT_HSH_IVW1, hsh_iv1);
+CP2_MT_HELPER(CVM_MT_HSH_IVW2, hsh_iv2);
+CP2_MT_HELPER(CVM_MT_HSH_IVW3, hsh_iv3);
+CP2_MT_HELPER(CVM_MT_HSH_IVW4, hsh_iv4);
+CP2_MT_HELPER(CVM_MT_HSH_IVW5, hsh_iv5);
+CP2_MT_HELPER(CVM_MT_HSH_IVW6, hsh_iv6);
+CP2_MT_HELPER(CVM_MT_HSH_IVW7, hsh_iv7);
+CP2_MT_HELPER(CVM_MT_HSH_STARTMD5, hsh_startmd5);
+CP2_MT_HELPER(CVM_MT_HSH_STARTSHA256, hsh_startsha256);
+CP2_MT_HELPER(CVM_MT_HSH_STARTSHA, hsh_startsha);
+CP2_MT_HELPER(CVM_MT_HSH_STARTSHA512, hsh_startsha512);
 
 static bool trans_BBIT(DisasContext *ctx, arg_BBIT *a)
 {

-- 
2.54.0


