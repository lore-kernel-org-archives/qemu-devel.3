Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19279C87FCA
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Aug 2025 17:22:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhtSV-0003jD-Np; Fri, 01 Aug 2025 13:22:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uhs3K-0002ve-Ef
 for qemu-devel@nongnu.org; Fri, 01 Aug 2025 11:52:14 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uhs3I-0000z6-Ix
 for qemu-devel@nongnu.org; Fri, 01 Aug 2025 11:52:14 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-3b7892609a5so1668709f8f.1
 for <qemu-devel@nongnu.org>; Fri, 01 Aug 2025 08:52:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754063531; x=1754668331; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=LcTTleyGohrqHXwUOe5A/ufrJLHVqKxLROdZ++CPg0A=;
 b=iXaCI2Tu6xOww/HzOsInGS7/nvIKX8l/lKkFYXNgQZnPJiFZvduMR+M5eMPjukzrsa
 U/iC7zPgco1u8wMe7c3ikfqlRZOajkcKkXWqwYBtLwarYj/kZM5mu+w7mzgQbAPLhK6T
 i/RbNxSkkRBo+j0pi8bA0+gYZ+5ORb34aDPx2dvm5Nm///nClM9zyJ/FgRiu46CFMJ5D
 ynSoYm/LZVpKYWim/u0HR/y+ATz947ycY9tWsFAg8e85bucCIZVW7CpJAfazl8gNqIDl
 LuIg+Gzmmeg26kKx9sj7waKJa/mrJhWzjwxZIal0FuRvgMpVFxqGD6709GRkZfZVj9Pd
 RMuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754063531; x=1754668331;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LcTTleyGohrqHXwUOe5A/ufrJLHVqKxLROdZ++CPg0A=;
 b=K5pCuPCthRoQNao/7JQd50EIlYpXo5FcIPApZbvUDwFOOGVQzCu7bDq5g8/KGKiudp
 bs160+BKXpnhrBqjR0Yh1dZTyYYksQfUriub5Vk7WAKCxa2Q7sgiUudB8FVgec0CS51s
 2lmD/MCxOpuT6js0xx5F9DCNzn3WR064kRLQbE7qQfPdX6cdVLshulvfzy/CWTAZDGO4
 g22yrN+h2EyzYdbXcITJ649hJajUGlkoqvJbRi0NrJ6uquWeHv6Li+xbT8XTWyjBdOKI
 qjC6r1EgTpNug6D/09kSaU5r8IGOCsifedrdR3hRp1H+jVyr4PmjyBVIeQoU4Ye+O0vT
 ux3A==
X-Gm-Message-State: AOJu0Yyt3X2zsXBYewjAnSjS7V6IANdl9S/Pj+Kj9mjHyHpQ1XWxpcEq
 0hIcv4d9Sx3Ma9uKFn/LzXv9lARP/CS0GsfbKW+9bROjCSoehN2/XEB0jeGFXiHl8v0RDkW7wn5
 tuBZV
X-Gm-Gg: ASbGncsDjKuucop04s//1jXecUZ+3AE0pbEct4Mao2PsuDYFyV2T6URp0AOBGv5hUDQ
 fyfNenS3lSLraYI4Fks5bNBf1Bv4QHDbXlBii1QuIJJ1UvDzTZjSadd/9yLL60t1z88FEeOMEcb
 h11kz5rpKE7nd8iZcl0gnGslhkcoOoRNxheW7IKpoy2Oczc28IT+vmMkgs9W3hdMGG6RqCHkBoR
 6o+G01kDHb09Wm+fzG7M84PZAoY8m5/+iUIOsIlYHUo2ucGg6mgaVJQL34OXhW2EIspJAQ40O7/
 deqC3QR0yJpm269A8ElumbiZhawus04fqdm1o47GXXQngD5BLOgpbCOHUNl9N6h0IgNUC/ksxKR
 g7G3WsS3IKnfs3l7eJc9cQEit3FbL
X-Google-Smtp-Source: AGHT+IHOAbGxTjN3WxTi9B9e2fJovcAvSEF9ZMhVjP8rURqD/X7Q6F1p1qLJpz9t0HIiDscT3t3TUA==
X-Received: by 2002:a5d:584e:0:b0:3b7:8410:22b6 with SMTP id
 ffacd0b85a97d-3b8d9468fb3mr236063f8f.6.1754063530692; 
 Fri, 01 Aug 2025 08:52:10 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b79c4a2f03sm6176670f8f.72.2025.08.01.08.52.09
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Aug 2025 08:52:09 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 6/8] target/arm: Fix big-endian handling of NEON gdb remote
 debugging
Date: Fri,  1 Aug 2025 16:51:57 +0100
Message-ID: <20250801155159.400947-7-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250801155159.400947-1-peter.maydell@linaro.org>
References: <20250801155159.400947-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42b.google.com
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

From: Vacha Bhavsar <vacha.bhavsar@oss.qualcomm.com>

In the code for allowing the gdbstub to set the value of an AArch64
FP/SIMD register, we weren't accounting for target_big_endian()
being true. This meant that for aarch64_be-linux-user we would
set the two halves of the FP register the wrong way around.
The much more common case of a little-endian guest is not affected;
nor are big-endian hosts.

Correct the handling of this case.

Cc: qemu-stable@nongnu.org
Signed-off-by: Vacha Bhavsar <vacha.bhavsar@oss.qualcomm.com>
Message-id: 20250722173736.2332529-2-vacha.bhavsar@oss.qualcomm.com
[PMM: added comment, expanded commit message, fixed missing space]
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/gdbstub64.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/target/arm/gdbstub64.c b/target/arm/gdbstub64.c
index 64ee9b3b567..4fce58d895e 100644
--- a/target/arm/gdbstub64.c
+++ b/target/arm/gdbstub64.c
@@ -115,8 +115,22 @@ int aarch64_gdb_set_fpu_reg(CPUState *cs, uint8_t *buf, int reg)
         /* 128 bit FP register */
         {
             uint64_t *q = aa64_vfp_qreg(env, reg);
-            q[0] = ldq_le_p(buf);
-            q[1] = ldq_le_p(buf + 8);
+
+            /*
+             * On the wire these are target-endian 128 bit values.
+             * In the CPU state these are host-order uint64_t values
+             * with the least-significant one first. This means they're
+             * the other way around for target_big_endian() (which is
+             * only true for us for aarch64_be-linux-user).
+             */
+            if (target_big_endian()) {
+                q[1] = ldq_p(buf);
+                q[0] = ldq_p(buf + 8);
+            } else{
+                q[0] = ldq_p(buf);
+                q[1] = ldq_p(buf + 8);
+            }
+
             return 16;
         }
     case 32:
-- 
2.43.0


