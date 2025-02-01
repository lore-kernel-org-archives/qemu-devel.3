Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A916C0218A
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Feb 2025 16:45:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1teGYA-0006I5-0J; Sat, 01 Feb 2025 11:40:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1teGY2-0006Am-Gy
 for qemu-devel@nongnu.org; Sat, 01 Feb 2025 11:40:46 -0500
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1teGY1-00018T-3G
 for qemu-devel@nongnu.org; Sat, 01 Feb 2025 11:40:46 -0500
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-388cae9eb9fso1681239f8f.3
 for <qemu-devel@nongnu.org>; Sat, 01 Feb 2025 08:40:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738428043; x=1739032843; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=BOcEJ4SdhzQ4YNSZVKN1C6haq4Tby0lVfAz7G5bWyzg=;
 b=jqQ8Pht0k4qxV+kXCoyOor0/AQL1y8rUonc33cJFfSyIfb+eKpC9+zmcBL2gbtzPY2
 V2AgHz6Vx7W/pJNZD7KYQsTB2YGsofndv9uZylo/RkJ+Hip+/fTb13x6StCwgZ/94f23
 09z7AAtGcRTvep7drujWIk/NJoxvI0Wh6O6Dz6hGH/NT3fFjacXMfTlnOdSOYemxXxaP
 9Om4iK8Ng4T94higIMqczASInG0fkYd/2Ueh7F5u8HoGvxVacHz7bNG30s8ojwkvlLHS
 hsWzLqDzZu9Iu0o70L+ssd+W/Aufy8I4C6Q0cMHvAJVv082IikhgHFwL5hW83OU1Y5ll
 ddBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738428043; x=1739032843;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BOcEJ4SdhzQ4YNSZVKN1C6haq4Tby0lVfAz7G5bWyzg=;
 b=UhxdZCPVTZlVoTNw1hOVqBn4+pegGIJ9oN/nNgT0roXOsw6zSH4f3dBpgkD1IFzinN
 Ty67EyLX2qrTjearAQTCuBNj46rcKZauS96dANRMqDCO+tWUc9FmhN6a6k4xy4pAOLYi
 gV4vPY6QLIPgYZHjDp9ZjPQMWV385+vvQibf0bJ91ptqTFDgILEoiU7PSacTqFGpfCE5
 m6e1MJNv2k1ONIimsO5stso8mulqenDhvsJxTIeh6AUnU2fvfWAnZklz7bTEF0Ie6wVF
 t6BWzpgAXAnKBSObtPVkOgb8GTLAAZmfYM5WVsO9QGPZkA+g3w/lgrU2mCvG2JgjhiP2
 fQEg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWikjUyM6C8KsJZnZ1ggNSiIo9BWTPzdMRrq6RO7tJLG9AZG+9axvhVCy4wE8hiIUEYCtLPR8oG4kSU@nongnu.org
X-Gm-Message-State: AOJu0Yw4juP88j8+6USxE58u7gSbVoK9aSoj9mvlry+D6ZpJANsU7Dfx
 ydZVjyU1/PWzs/kSb3yQD+64EYbJKyQPK+svx07EwAhC68qCjsGAgSoKPmJ2yDw=
X-Gm-Gg: ASbGncvm4YAU0X4tCrlcQxUaIwIv7W1MNK8Fp0NyVz6473q+uuE+jQZMN11Vn1WASTz
 fl1mTfwZeTBKomltmJOHuFh/2bK8qSS3JpaW3oFy9+4LxKji9XcAhAj14yeyJgmICuJ6bb1Ovxr
 jKgQQnb7/FqsmV7XYKpUA4Cho0IXYvDlZF0A5EVsbH2654x1mlTW/rWiFdMfimE6DweuR3o9gA9
 gchIlixfmffepzMYaziebT0/hYr89FexN5gdbMwlhb0qERowvMTlmsYbhx8VhWMtj42RZG+ou6m
 GDLnfFqvUUtLwxB8Xcv5
X-Google-Smtp-Source: AGHT+IFFU3/y6jF2KAEsjmZ+CQMlnpJA82Rd8RnYJ++o2GAu5lcmt7YCgJutJLDlgH7i54WIgxvY9Q==
X-Received: by 2002:a5d:4d47:0:b0:38b:f44b:8663 with SMTP id
 ffacd0b85a97d-38c520bb322mr10226318f8f.55.1738428043226; 
 Sat, 01 Feb 2025 08:40:43 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438dcc81d74sm127401525e9.37.2025.02.01.08.40.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 01 Feb 2025 08:40:42 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH v2 20/69] target/arm: Handle FPCR.NEP in do_cvtf_scalar()
Date: Sat,  1 Feb 2025 16:39:23 +0000
Message-Id: <20250201164012.1660228-21-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250201164012.1660228-1-peter.maydell@linaro.org>
References: <20250201164012.1660228-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x433.google.com
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

Handle FPCR.NEP in the operations handled by do_cvtf_scalar().

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/translate-a64.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 21e68878c48..f31ac3b9549 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -8744,7 +8744,7 @@ static bool do_cvtf_scalar(DisasContext *s, MemOp esz, int rd, int shift,
         } else {
             gen_helper_vfp_uqtod(tcg_double, tcg_int, tcg_shift, tcg_fpstatus);
         }
-        write_fp_dreg(s, rd, tcg_double);
+        write_fp_dreg_merging(s, rd, rd, tcg_double);
         break;
 
     case MO_32:
@@ -8754,7 +8754,7 @@ static bool do_cvtf_scalar(DisasContext *s, MemOp esz, int rd, int shift,
         } else {
             gen_helper_vfp_uqtos(tcg_single, tcg_int, tcg_shift, tcg_fpstatus);
         }
-        write_fp_sreg(s, rd, tcg_single);
+        write_fp_sreg_merging(s, rd, rd, tcg_single);
         break;
 
     case MO_16:
@@ -8764,7 +8764,7 @@ static bool do_cvtf_scalar(DisasContext *s, MemOp esz, int rd, int shift,
         } else {
             gen_helper_vfp_uqtoh(tcg_single, tcg_int, tcg_shift, tcg_fpstatus);
         }
-        write_fp_sreg(s, rd, tcg_single);
+        write_fp_hreg_merging(s, rd, rd, tcg_single);
         break;
 
     default:
-- 
2.34.1


