Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC13CC61DD6
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 12:50:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2TJN-0006Bw-1G; Fri, 04 Sep 2026 08:46:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x2TJH-00069I-TN
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 08:46:25 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x2TJE-0006rC-UB
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 08:46:23 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-485888b3c3dso872050f8f.2
 for <qemu-devel@nongnu.org>; Fri, 04 Sep 2026 05:46:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1788525979; x=1789130779; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=g5//nCM3pmvphFdrXdMpuw8XsMrA3mZsffpPB3jrr14=;
 b=H+4gA4W9QErtVPR1BZuVe8G4qm4gv8nDf6B0wu+dXBGQl2vaWWZ7fyBC3O7b7qqKL4
 mMEDkRQYxBE5qYNztJxvWYXzcChNpnYeT1T62/KDTAhHLHdd4aDTzuw6UPe37911dqaO
 tUmAajDMWrnUAlDZtevi794bS/yb6UCxt2mL5kgFKGdsfdi+Umce+aC/n2kdxxh26Bfc
 USwAAgM9BaZC1LbKmFqHro6ns4KRmgL+h5N1xqxTcjGrV7tPtlONeEKRhdDrc/gCpYze
 mzAi6htYTBNhhg0g6rlXKYx9Zsi5K9Dk7p2ac+I8/aIgfplSfaKA1pqCQ99SblY1Tplh
 V8kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788525979; x=1789130779;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=g5//nCM3pmvphFdrXdMpuw8XsMrA3mZsffpPB3jrr14=;
 b=an7Sj9kLS8ErQA3zm9q1EzPBQ0pG1WCz9OwGj8ZWLJwI/n/TXq5c+5Sn+Hc0XxJxYk
 qlzup6tZgN47unV/gt0V8fnDd2y3VMwjUDFEsxMOPvSYM3gRQOhjnYnwGmCO6KIdYKPV
 KGJTbkbFFOuu2SWmEkkXA75hMhb8otZC2O9kqIWiO3qFA5jSOPMZfa8JC1Aa7riM6hve
 oRrWRwAZRxQJGaCLqqUGrkqcJRk18xYZueM9yBn8mYY7hfSs5WN+eDnKkExI9boS6LqI
 Fj0jxt5J+yWwtaDJbckftJIBzZsclBbYcd1OprFz3JB6LBoTVMmEKMLgguzFpoUcPVGM
 vCYQ==
X-Gm-Message-State: AFuF++kt/iM9pJP6XWEPucLvgIjUW5V/qanDhfI8BJfcZAVZkT6sHjHW
 u1Zvpf5du7jnAPANiTRqcCtnA5g1ri2gpPs3DoMzUFqzgUbvDPotqawlH1F6qkXfHls=
X-Gm-Gg: AYBFou2hdSCJamD2osBIXacXXiJu/x8IZhERtie0h6Sg/kPWuqvfyVxqhE9k2djbDbH
 yonD5AxpDy2iJ2Fl8AMzEnPFqv5eLFGkZuoUFD13eW24qZdCSD1OeTfcsTtFRMYG9g0Cz1zrjKE
 dq4EWAzrnM0u8XBza4gtLl/eUIrX51aGK0OtKy2iZfN3kR8+yUBjkaIsim08xAor/3p3Rab7ZzE
 eflBOSQ/TDXD4chij8dFnv1J0oDxVszBJ6YrCrRFuiejxrjK0efCKgRNHb33JqTGhuRIkXRBHLt
 uWDB80ghkJqSCJBBEvqiciaIR+10tPwR8hY7lsmF0yAyab3DUY9ldOg7DNK2Vdz+Qe21vMFW4fx
 sEuDbHoDhHJXybcxNUFDca/KLnMFBNC3UF6u7niKVYZrrqmDeIYAjeQgnH9b2+WAtfXhUtQxesa
 QfGMas5eyeKm7fcNVLSwMLVnSx4B4lXsG9V4EuVOy3D/Adn2dKnbq+wokHIITK
X-Received: by 2002:a05:6000:46c7:b0:485:847f:fd97 with SMTP id
 ffacd0b85a97d-485870914ccmr6111641f8f.4.1788525978818; 
 Fri, 04 Sep 2026 05:46:18 -0700 (PDT)
Received: from draig.lan ([185.124.0.156]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4858ac2b4cdsm4587385f8f.16.2026.09.04.05.46.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Sep 2026 05:46:18 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 262EE618C3;
 Fri, 04 Sep 2026 13:46:08 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Aniket Sahu <asahu1x@linux.ibm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 qemu-arm@nongnu.org (open list:ARM TCG CPUs)
Subject: [PULL 039/105] tests/tcg/arm/fcvt.c: use raw opcode for FPRCVT
Date: Fri,  4 Sep 2026 13:44:53 +0100
Message-ID: <20260904124604.2207440-40-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260904124604.2207440-1-alex.bennee@linaro.org>
References: <20260904124604.2207440-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42e.google.com
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

From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

fcvtzs d0,s31 requires fprcvt support in compiler, which is only
available from gcc-16. Since our debian-all-test-cross container has
gcc-aarch64-14, this test will never run in CI.

Replace the concerned instruction with raw opcode, obtained from:
$ echo "fcvtzs d0, s31" | llvm-mc-22 -triple=aarch64 -mattr=fprcvt --show-encoding
fcvtzs  d0, s31 // encoding: [0xe0,0x03,0x36,0x9e]

Tested-by: Aniket Sahu <asahu1x@linux.ibm.com>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Message-ID: <20260827221506.91574-40-pierrick.bouvier@oss.qualcomm.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/tests/tcg/arm/fcvt.c b/tests/tcg/arm/fcvt.c
index 7c0cc4367e7..8c81ba8a1bc 100644
--- a/tests/tcg/arm/fcvt.c
+++ b/tests/tcg/arm/fcvt.c
@@ -173,9 +173,11 @@ static void convert_single_to_integer(void)
         output = input;
 #else
 #ifdef FPRCVT
-        asm("fcvtzs d0, %s1\r\n"
+        asm("fmov s31, %s1\n\t"
+            /* "fcvtzs d0, s31\n\t" */
+            ".byte 0xe0,0x03,0x36,0x9e\n\t"
             "fmov %0, d0" :
-            "=r" (output) : "w" (input));
+            "=r" (output) : "w" (input) : "s31", "d0");
 #else
         asm("fcvtzs %0, %s1" : "=r" (output) : "w" (input));
 #endif
-- 
2.47.3


