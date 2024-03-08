Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9396C5475B
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Mar 2024 15:53:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ricUN-0007Z5-9l; Fri, 08 Mar 2024 10:50:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ricUL-0007TS-JS
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 10:50:25 -0500
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ricUH-0004SM-R8
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 10:50:25 -0500
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-33e65ed1c3aso839672f8f.3
 for <qemu-devel@nongnu.org>; Fri, 08 Mar 2024 07:50:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709913020; x=1710517820; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=nJOv1VUlDUtGZM05W4ghzPsBoaI8fg6cac9YMIN+iE8=;
 b=hRgLwVNAzibtjDtTR9CAziilvy04fk135BEwVlLmFyl69BZn1GyRE11rp68pEdDmiq
 9hlf0mT28GjFNU9zgn8T904s5i3IpHiquFsqs/YSkWTYJfvdRfgsEGOghMXfwxQnowlJ
 yZsn/PlQdG+UmYM2DOdt4zqnMR1/LTuRVLZhJPrXwVY9mwLhIYZaHTZS9l4N9N/NdxYp
 CypmifLP1eGCABmepTo/2KsOl938WC2BZUHuULSIXzWIrSPiKajwT+cRAR0ekNe0GTFw
 kvYg60aSxGcLSSvwyquxADSoUnodPaefHeqWgbBHD9eU1+bIxgnRe+fEJOIMSAtvHlHS
 YJBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709913020; x=1710517820;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nJOv1VUlDUtGZM05W4ghzPsBoaI8fg6cac9YMIN+iE8=;
 b=WPFzs3uhr9VcM0yP0pOLED37WZchxwDUEfsBmL0fMeMLLMifnCR9Bvy/iJvrf5jIoH
 6UVfIgPKJduwkN/Mx4cMLd2JZlcXJjKMeFf2N/uLjT0DdBU/ax2VEvkVqojzNSEm2MGc
 JBMPuX7FJxbeF3hX7CIvEfNQu+tu8X9R0SffvhxVd//VvPtoSUTWBjtZIIjUNEHIGmm/
 je3CyTyEyCe9FwX58GYUVTcgx8AW6+icGZz399VjP5ZhkhwQZTU7RGg0kwUwgnPPI2ni
 iXNZyzLb6ImnF/QZgtJlJJIKkeXcZTDwqW/vq+Frf0s6BGpCjlwiEna4MluFXAS93OMS
 NtgA==
X-Gm-Message-State: AOJu0YxRfh2OFqka7p5AMXttRn2QFXfS5YGgm0oBvYtf0HOwfEAZmgCx
 iimThfQQPH0yjPYUPdgAGMM8t6ePzS5IEFWQPsKC/ptPobwtX7kHziBQe4sjPJU+ylfP9Zt5IEz
 B
X-Google-Smtp-Source: AGHT+IHYV27xM7P4PoInusiDoJmVZehXyN40TERtjN19Fllcx6mLR6k8zsBQ3zjJdUHN2/KT4scxZw==
X-Received: by 2002:adf:cc06:0:b0:33d:afbc:6c76 with SMTP id
 x6-20020adfcc06000000b0033dafbc6c76mr16326146wrh.1.1709913020181; 
 Fri, 08 Mar 2024 07:50:20 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 f2-20020adff8c2000000b0033e7a204dc7sm856080wrq.32.2024.03.08.07.50.19
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Mar 2024 07:50:19 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 08/14] target/arm: Enable FEAT_ECV for 'max' CPU
Date: Fri,  8 Mar 2024 15:50:09 +0000
Message-Id: <20240308155015.3637663-9-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240308155015.3637663-1-peter.maydell@linaro.org>
References: <20240308155015.3637663-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x434.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Enable all FEAT_ECV features on the 'max' CPU.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20240301183219.2424889-9-peter.maydell@linaro.org
---
 docs/system/arm/emulation.rst | 1 +
 target/arm/tcg/cpu64.c        | 1 +
 2 files changed, 2 insertions(+)

diff --git a/docs/system/arm/emulation.rst b/docs/system/arm/emulation.rst
index f67aea2d836..2a7bbb82dc4 100644
--- a/docs/system/arm/emulation.rst
+++ b/docs/system/arm/emulation.rst
@@ -28,6 +28,7 @@ the following architecture extensions:
 - FEAT_DotProd (Advanced SIMD dot product instructions)
 - FEAT_DoubleFault (Double Fault Extension)
 - FEAT_E0PD (Preventing EL0 access to halves of address maps)
+- FEAT_ECV (Enhanced Counter Virtualization)
 - FEAT_EPAC (Enhanced pointer authentication)
 - FEAT_ETS (Enhanced Translation Synchronization)
 - FEAT_EVT (Enhanced Virtualization Traps)
diff --git a/target/arm/tcg/cpu64.c b/target/arm/tcg/cpu64.c
index 5fba2c0f040..9f7a9f3d2cc 100644
--- a/target/arm/tcg/cpu64.c
+++ b/target/arm/tcg/cpu64.c
@@ -1184,6 +1184,7 @@ void aarch64_max_tcg_initfn(Object *obj)
     t = FIELD_DP64(t, ID_AA64MMFR0, TGRAN64_2, 2); /* 64k stage2 supported */
     t = FIELD_DP64(t, ID_AA64MMFR0, TGRAN4_2, 2);  /*  4k stage2 supported */
     t = FIELD_DP64(t, ID_AA64MMFR0, FGT, 1);       /* FEAT_FGT */
+    t = FIELD_DP64(t, ID_AA64MMFR0, ECV, 2);       /* FEAT_ECV */
     cpu->isar.id_aa64mmfr0 = t;
 
     t = cpu->isar.id_aa64mmfr1;
-- 
2.34.1


