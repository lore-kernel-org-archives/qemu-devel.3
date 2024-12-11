Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CA8FE7717D
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2024 16:24:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLPS8-0000KR-Cw; Wed, 11 Dec 2024 11:20:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tLPS4-0000Ic-EL
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 11:20:40 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tLPS2-0007jT-V2
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 11:20:40 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-43618283dedso16746635e9.3
 for <qemu-devel@nongnu.org>; Wed, 11 Dec 2024 08:20:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733934037; x=1734538837; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=elThihR9o8htBA19kSW3jQQIVfaQiQSaHPvk+cMrk5s=;
 b=EvFITmLkbf9/a+6VXSCWi+R3P6p+1Qu/hzAXgVdQbEsDAUby8QEzMYt/HQQff6UXf0
 zcZLzOqUUW+S/sRNW2PakzxY/KmjBU95xvmTH5UoNxfJiF/kcp169KuxCyUjMeruGdil
 7oAOQlTpF1TUOGPEHT6wq/+1bMMiPxcZe7QVZvf4CEvqTOxZBEJF+PEZxEGZFEecAAm9
 OM80TLReaBmmIzMEQBF4BjI0ciIBMDqNkfHZlvAtKuvVWhmJbEzbFhLWe7Vo4H1PDSE6
 X3ziIpZ23aSpY5LBsK+XszQoNSDQ23VzbUbfsU0+8EQWhS2RxgZnaLyadzr7XYfygBYd
 vVmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733934037; x=1734538837;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=elThihR9o8htBA19kSW3jQQIVfaQiQSaHPvk+cMrk5s=;
 b=LZW7uRdkPeJpSSKFy3l0IE/Yu/+ox3ithVNoT10jZzF2MKdQ7iq0ZH85nfzghJKyxy
 Wtr10v0CAaxJeUsCU2MTERZWocDnSJofyBeJUF4vCkb1cx86iKTc4O0I1ttKB5Iqx61m
 2ycpu88VNoYJXIkAnAXc3BDAd9dgQS/LOcJNdymJkR2MXTg+sge7l16HrsTgDA7C2GzD
 L3L3D3gROE3BHbMtV+SCFJawAmiB5d8yjx6er68JuabwaWhO9R0B9ZZ9xAM/DVP3+3XT
 8EwtnsY5mC4T1usGGaIo8ymGrfAynO+fq5JojHW9GzGxksjXROyBBABQvkL331BcvDyM
 s0vQ==
X-Gm-Message-State: AOJu0Yw+reL53an6y4NVaU2uEpxOOq0NI01MZPJBVy8eTViv5HT4/NX/
 A+zwMj7BOJnOuP2DJDDL+6td19M4VB5Ru+DTmk+Bk+w0b6ZCi1AKWV93YBnDHWkDMdOZjQUrg+F
 A
X-Gm-Gg: ASbGncuo8Azi6NYUsrHsXHHrx+tJMTpU6hPa6GbJ//DeNVo7cYn4PEJPv5DeT/EN1Rn
 sP93RZkVA++sFsGsoSDfPtt024Wgl3n8JlVV3dvfxcZVMs0klMOEZjBZLDd991SIZd6tD1YNODk
 +3JYpofPwnXIFPFYcJEs1lV/MDvI3dzsuc10CuNPadG4Hbx5bB4p7Ii/dpkeM2wlY7bK+VnsNrY
 Czln71wSU5mX1JvwJdkgC67mC+tWyQ5AJ06Hx71iZvGvB7454SqU1L/IZTx
X-Google-Smtp-Source: AGHT+IGyBaDe78Wr9sep2EcncJJ7qhKeEhQqq14eN8kgeSBhUv1xJYAiw2XTtP2UsimzoTQB0/s6Vw==
X-Received: by 2002:a05:600c:1d2a:b0:434:a781:f5e2 with SMTP id
 5b1f17b1804b1-4362282ab63mr3103675e9.8.1733934037628; 
 Wed, 11 Dec 2024 08:20:37 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-434f4dfdcdfsm121460595e9.39.2024.12.11.08.20.36
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Dec 2024 08:20:36 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 26/72] target/sparc: Set Float3NaNPropRule explicitly
Date: Wed, 11 Dec 2024 16:19:18 +0000
Message-Id: <20241211162004.2795499-27-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241211162004.2795499-1-peter.maydell@linaro.org>
References: <20241211162004.2795499-1-peter.maydell@linaro.org>
MIME-Version: 1.0
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

Set the Float3NaNPropRule explicitly for SPARC, and remove the
ifdef from pickNaNMulAdd().

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20241202131347.498124-22-peter.maydell@linaro.org
---
 target/sparc/cpu.c             | 2 ++
 fpu/softfloat-specialize.c.inc | 2 --
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/sparc/cpu.c b/target/sparc/cpu.c
index 61f2d3fbf23..0f2997a85e6 100644
--- a/target/sparc/cpu.c
+++ b/target/sparc/cpu.c
@@ -814,6 +814,8 @@ static void sparc_cpu_realizefn(DeviceState *dev, Error **errp)
      * the CPU state struct so it won't get zeroed on reset.
      */
     set_float_2nan_prop_rule(float_2nan_prop_s_ba, &env->fp_status);
+    /* For fused-multiply add, prefer SNaN over QNaN, then C->B->A */
+    set_float_3nan_prop_rule(float_3nan_prop_s_cba, &env->fp_status);
     /* For inf * 0 + NaN, return the input NaN */
     set_float_infzeronan_rule(float_infzeronan_dnan_never, &env->fp_status);
 
diff --git a/fpu/softfloat-specialize.c.inc b/fpu/softfloat-specialize.c.inc
index 8a36280df1a..c4d8d085a98 100644
--- a/fpu/softfloat-specialize.c.inc
+++ b/fpu/softfloat-specialize.c.inc
@@ -511,8 +511,6 @@ static int pickNaNMulAdd(FloatClass a_cls, FloatClass b_cls, FloatClass c_cls,
         } else {
             rule = float_3nan_prop_s_cab;
         }
-#elif defined(TARGET_SPARC)
-        rule = float_3nan_prop_s_cba;
 #elif defined(TARGET_XTENSA)
         if (status->use_first_nan) {
             rule = float_3nan_prop_abc;
-- 
2.34.1


