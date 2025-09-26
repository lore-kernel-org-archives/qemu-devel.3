Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0D2FCAC5BE
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Sep 2025 14:14:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v299M-0008VP-GM; Fri, 26 Sep 2025 10:10:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v298q-0007nC-0e
 for qemu-devel@nongnu.org; Fri, 26 Sep 2025 10:09:45 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v298O-0005gc-OY
 for qemu-devel@nongnu.org; Fri, 26 Sep 2025 10:09:41 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-3fc36b99e92so2019558f8f.0
 for <qemu-devel@nongnu.org>; Fri, 26 Sep 2025 07:09:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758895745; x=1759500545; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=rs/KWAsQ5SpX2/EhCbEfW4QHUF/6557YiO72ZWIsagc=;
 b=xv12BqUu2jfYRqaCfMQX5qT4cTwd/C50U6Vvv5qKU7Utuo9pcDRcueljJChPQk+Ylv
 3L/50ceRjGpODDSfRABbSy8xS8Mlah/lwX96HlisqVBxtFMGRsYpS3iwVpm+VkflfRH+
 4akORth2i4gbkw415krt3CiopkGSewGo00tMIZwXeTGU7tCqJZcPYJZQylzjNUs0iW4A
 R9sM82NagGUKQh7UCdAG1mamQXfVCVYu5I6PhNekHOaoF8sABlM0QAHSZUxzF9D4Q0ip
 442YcmWyfYOvxC1+tEgl3EWrjT1L/ednyiFyMA3jj03IwZ/Msso6V/Y2jH+X2eTf5Mc9
 94gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758895745; x=1759500545;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rs/KWAsQ5SpX2/EhCbEfW4QHUF/6557YiO72ZWIsagc=;
 b=SNTN1RN55JIWnDBwmm7HqRIXW9FY8BNlS6wh4LaDqBwoZzsGinzYnYdBog5+iVdEgw
 CNE24GSJJUN5hgSZZHdORTQbb2OdLKTcvtwlFoawPPbmj4rbncfgWtRQJ4ePYCa4chAF
 QRUhWyVoniJwcEzi3Dvvq+/vztAOnnftDNTvl2U4ZCjhWTnMUk46rdu3zvUSWZguUHFH
 xJo0L97x/1wj2hyvHv3lkC3wEI+WAqqCDVCtD4fKtxrjxy+ywewyIAAPNuOpblSHuv9z
 mO5OXav3I7f0WN6owxX2HzqYPYE07qHOcJ16/JkSl/t9jxKzBnj/Z5l8ClGrAYTNGy+a
 FTjw==
X-Gm-Message-State: AOJu0YzKgoY1tbSKUP83D+1+ysjRw5986FJt2j5OTT2arnUubOsogZX9
 x8IKV0CgD3jGqm7AWlwJy+INmB05Rs09gfSCIHrjc1AG9hE9C4YIfmrgE2p4kpLBNJVtWwEUo4n
 +r4/p
X-Gm-Gg: ASbGncsBkPsowUT6dNHku6BU22XcPKPIlEktNg42NIlng6jYnM3GLW0x/zkRV72GgT/
 XLPkhy0S+FaRNxtLmOra21U5edOt/hRqF420/4N6xJ8POPBYv7n7y+ytMZIEYVn+wNv/3ULEv+y
 pPW026AgPBeL36TsNge7w5B7Y5uiDOTER8CA2nSilhogMtbLqx/ancy4Iv0D9OkPYYMAhE33fm4
 de5o+AaKWoF6vXptQhexe6fMRv8T8mQm0QtEqZ3aLzLIj/8Ou7lnOVHrgE/1nWoYtwk/ghu3qOo
 u3D0oJB+1oa6hdqHcHnjMnU3a+U0lVC1lbj7TvDJxrzCcqKqDJx7yXyx2uDPdlnAYE7aTZsvSpp
 KaZVdu5tpuKqHOHps5IfH7mCm6m09poR+ifGmYN8=
X-Google-Smtp-Source: AGHT+IF8vOuXnaXYVmX9qXud6P+bKt/X63312oXs6EqLm+t/y3JZaRTlsP2SOdiaGySCDxFiX52k3Q==
X-Received: by 2002:a05:6000:2204:b0:3ea:d634:1493 with SMTP id
 ffacd0b85a97d-40f5e5c1023mr6196924f8f.3.1758895745228; 
 Fri, 26 Sep 2025 07:09:05 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-410f2007372sm6338315f8f.16.2025.09.26.07.09.04
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Sep 2025 07:09:04 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 18/44] target/arm: Rename CP_REG_AA32_NS_{SHIFT,MASK}
Date: Fri, 26 Sep 2025 15:08:18 +0100
Message-ID: <20250926140844.1493020-19-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250926140844.1493020-1-peter.maydell@linaro.org>
References: <20250926140844.1493020-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42d.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

Rename from CP_REG_NS_* to emphasize this is specific to AArch32.

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpregs.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/target/arm/cpregs.h b/target/arm/cpregs.h
index f7dd6d2f758..417d79f7ba6 100644
--- a/target/arm/cpregs.h
+++ b/target/arm/cpregs.h
@@ -175,15 +175,15 @@ enum {
  * add a bit to distinguish between secure and non-secure cpregs in the
  * hashtable.
  */
-#define CP_REG_NS_SHIFT 29
-#define CP_REG_NS_MASK (1 << CP_REG_NS_SHIFT)
+#define CP_REG_AA32_NS_SHIFT     29
+#define CP_REG_AA32_NS_MASK      (1 << CP_REG_AA32_NS_SHIFT)
 
 /* Distinguish 32-bit and 64-bit views of AArch32 system registers. */
 #define CP_REG_AA32_64BIT_SHIFT  15
 #define CP_REG_AA32_64BIT_MASK   (1 << CP_REG_AA32_64BIT_SHIFT)
 
 #define ENCODE_CP_REG(cp, is64, ns, crn, crm, opc1, opc2)   \
-    (((ns) << CP_REG_NS_SHIFT) |                            \
+    (((ns) << CP_REG_AA32_NS_SHIFT) |                       \
      ((is64) << CP_REG_AA32_64BIT_SHIFT) |                  \
      ((cp) << 16) | ((crn) << 11) | ((crm) << 7) | ((opc1) << 3) | (opc2))
 
@@ -214,7 +214,7 @@ static inline uint32_t kvm_to_cpreg_id(uint64_t kvmid)
          * KVM is always non-secure so add the NS flag on AArch32 register
          * entries.
          */
-         cpregid |= 1 << CP_REG_NS_SHIFT;
+         cpregid |= CP_REG_AA32_NS_MASK;
     }
     return cpregid;
 }
-- 
2.43.0


