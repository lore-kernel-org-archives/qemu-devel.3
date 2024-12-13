Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DDBCE77180
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2024 17:33:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tM9XA-00071j-MC; Fri, 13 Dec 2024 12:33:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tM9Ws-0006sF-63
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 12:32:43 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tM9Wk-0001RS-Tc
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 12:32:41 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4361dc6322fso13669595e9.3
 for <qemu-devel@nongnu.org>; Fri, 13 Dec 2024 09:32:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734111153; x=1734715953; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=xo0UYeexX9TkySsgN+7gPRXhELG1k0acVRq85YNwIwg=;
 b=y7AjXGxBybAEpDO+tZ/dy4p0ULbPXYihpiIWvrgtavTaUgU1+g7I3p1KuKke0SEaLk
 x95F1dwJk9YoRQuvPhbMfyW9NDGbwKyIINLi6NlvEpOgFefc61Gj//w7I9sZrLqZjLyJ
 BpYuP1Tjo0vliUgcrCbJSG+1BoRv9Dmhz356qEaHfuvAo9lZnWxuHZtWtObfp7/YV8hV
 9BmcW8TxSlaKvd5QxxUy8ZzRo7KtJYTv1Y+1ZAHKLKJmHivfJ71WhUfp2FT25mOJxzau
 9p7JLDLyffPnWrGt4Ot7nlQrZgzTFMgqXMdJ2ymHnQvs59WX4LlkWMa5nIiDqOb4mCm0
 3uRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734111153; x=1734715953;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xo0UYeexX9TkySsgN+7gPRXhELG1k0acVRq85YNwIwg=;
 b=Zl5RFdlTqTltLE4e3JpnOYLjOCyKvr+9l0JhROTvtJ433+eQEmNnYZzMTH2JP/LE6T
 UDL0abSKqtyfR1UWLU3fwNOy1e1oTp/DyINOgq59VF4mpPpRskhANwQdm1+Rno3+0IqY
 U7FguLIfcEal2RV1CfsqfYofrWqL4XbMduR2i376vuklPnZ5nPcfppDwrSdFWOAGkFyC
 qxjCH3x/o+E0IYJjbpmlG0wqvNbyI7y0VAyDrw7uZyrfvEOtfOyMx+YpDICfIDiPH/yt
 J9Wt4k+SW1Vqnohus/o7qCHblY9/sxoaYB00LLUCtbS21EFDlkCMlvbKjLxlTqHjkf/w
 P/Tw==
X-Gm-Message-State: AOJu0Yzb91pc6YRcYm+tW6L4Qz6Ysef8EteCqchghVLvenxc3zZ4jsgX
 JcPF3fJkY0Rub9FwGYAiM/9kfeVUsULebgTAjdJiaykbRpLWOMxsOBvxpvPS21kOyQivNmKPoq3
 c
X-Gm-Gg: ASbGncuqD4SUeV3k33iev5fJtEzCsIy446Zyp94kfPHHVppqnw9YpxGpGrKl9RU1LdM
 zc8cFYyoQ4YkVmXg4JAraLDKEUucXfN8bgIVNdBcEXn/VebPW+zWOjp7JJARKYQ9Xv2WmqFr18T
 OprOsUKQKSo9cjBZjD1+jS1QzE/LtGL3zD1+k34s6O1ThJTCFlhjUA33bkm+rpebZNRB33KGhC3
 tJQLqdtHu2YAFE1CQt+l0CrFotvtWNcvEPuAT8hN24CxuE7QjRPU35A1WbDnA==
X-Google-Smtp-Source: AGHT+IFsMJ0UKiQTKOjk9sR3qhvk6aj5+39sgJfv5MlML95MoeMxx6TqXZjQHfYpxgqcp0lJGhhPdg==
X-Received: by 2002:a05:600c:500a:b0:434:ff9d:a370 with SMTP id
 5b1f17b1804b1-4362a98248emr33539935e9.0.1734111152782; 
 Fri, 13 Dec 2024 09:32:32 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-388c80162ddsm87026f8f.37.2024.12.13.09.32.31
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Dec 2024 09:32:32 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 01/85] target/arm: Add section labels for "Data Processing
 (register)"
Date: Fri, 13 Dec 2024 17:31:05 +0000
Message-Id: <20241213173229.3308926-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241213173229.3308926-1-peter.maydell@linaro.org>
References: <20241213173229.3308926-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32e.google.com
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

At the same time, use ### to separate 3rd-level sections.
We already use ### for 4.1.92 Data Processing (immediate),
but not the two following two third-level sections:
4.1.93 Branches, and 4.1.94 Loads and stores.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20241211163036.2297116-2-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/a64.decode | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index 331a8e180c0..d28efb884df 100644
--- a/target/arm/tcg/a64.decode
+++ b/target/arm/tcg/a64.decode
@@ -161,7 +161,7 @@ UBFM            . 10 100110 . ...... ...... ..... ..... @bitfield_32
 EXTR            1 00 100111 1 0 rm:5 imm:6 rn:5 rd:5     &extract sf=1
 EXTR            0 00 100111 0 0 rm:5 0 imm:5 rn:5 rd:5   &extract sf=0
 
-# Branches
+### Branches
 
 %imm26   0:s26 !function=times_4
 @branch         . ..... .......................... &i imm=%imm26
@@ -291,7 +291,7 @@ HLT             1101 0100 010 ................ 000 00 @i16
 # DCPS2         1101 0100 101 ................ 000 10 @i16
 # DCPS3         1101 0100 101 ................ 000 11 @i16
 
-# Loads and stores
+### Loads and stores
 
 &stxr           rn rt rt2 rs sz lasr
 &stlr           rn rt sz lasr
@@ -649,6 +649,21 @@ CPYP            00 011 1 01000 ..... .... 01 ..... ..... @cpy
 CPYM            00 011 1 01010 ..... .... 01 ..... ..... @cpy
 CPYE            00 011 1 01100 ..... .... 01 ..... ..... @cpy
 
+### Data Processing (register)
+
+# Data Processing (2-source)
+# Data Processing (1-source)
+# Logical (shifted reg)
+# Add/subtract (shifted reg)
+# Add/subtract (extended reg)
+# Add/subtract (carry)
+# Rotate right into flags
+# Evaluate into flags
+# Conditional compare (regster)
+# Conditional compare (immediate)
+# Conditional select
+# Data Processing (3-source)
+
 ### Cryptographic AES
 
 AESE            01001110 00 10100 00100 10 ..... .....  @r2r_q1e0
-- 
2.34.1


