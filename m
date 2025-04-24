Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DED5FC369CB
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 01:25:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7krP-0003x0-Mi; Wed, 23 Apr 2025 20:54:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7kqX-00015o-Sr
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 20:53:46 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7kqM-0004ld-67
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 20:53:35 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-736a72220edso415372b3a.3
 for <qemu-devel@nongnu.org>; Wed, 23 Apr 2025 17:53:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745456013; x=1746060813; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YwX79sAas1p4NfMgvATwyqCc393tpLGILDciw+NSDio=;
 b=miLwNKlWWOuDEL0BROqS3lyfJ4f2Ib1MDOJzyMAubg1/uo71DiyDD5agdR0frrXq+n
 ZJLvye67FPekm/QYt9tiMCtEY72yVU4ggY5/6p1UkKD7TqrEoZHf25R7mXAmE0Wkqynf
 o56+Guv4+oh4zcGjggVegi6Yd02Sd8kW0LTYvqhSIPB52VAFzt4PNKHzrR1oKkoRSCO8
 qZuZI/ieurnfkae/BKdR42PRrdPlO1hddUqNUsoxL7yOM2UlhFc6zSk3BjOs9K6QQR4E
 zeg4rkgNXcSbsMk3slrPGAcq4g9aiS6QOZLUqwj9Kjt2RUV93qzP/cEoN0tGs15JNT5W
 INqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745456013; x=1746060813;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YwX79sAas1p4NfMgvATwyqCc393tpLGILDciw+NSDio=;
 b=EweoOQeNuNAYmLi83UJUgDzbZvW7ATnfFYxy2XpGIyDbZfsH6NDu72zpbjBz8xzH5K
 pNm6kbyMjX7jLvb0rtlaa8g5CA2IBA/qKKxLaYwTKSw66LE+hgJuVTm4W9hNK8eC6Gl6
 S7XI6Jc+zhKux5ml6RsCV2g1sJbqxQ7f3Pgrhbv4JyD107KnFI3Kuu2sQ65wRe94Fkqu
 /S93gTrjKe+S6986ErQ9atkyXrbAL1NWHk1nx/fbqavu8GizCOHJZ4QpBQuISwtzacvn
 L9gZ+NTrazI0O3q3jfdfQ+mRYXIsoMrbccRfStPL8G4AgR7AffP3ehGcO85BSdkrCkon
 kAgA==
X-Gm-Message-State: AOJu0YxVBwcnFSAoRyR1oVL18n6rt5yt7i6jQThkIDimySHDpVFJXESi
 WanSixnFuX/GmBq/1uM49O8Q9W4kg2kXQ9rYAK7EYB1p+oMzpfmF76y3VuQMvJYLP3+mYPBsfO6
 l
X-Gm-Gg: ASbGncu+ghWbJKjRy7+iU0iaHQXqenJYH1V7SXZuSG7CarcoNzh5oSzr+DJb/Et/UL9
 zqL8AI54+j1VgoBDsDvfi7umjslLsi4emkutFiGO46nvxu0MfaZ86+JAZYOduZ1XG//glO1laSc
 1s7xQ7gzHDtA8V7LZxMKc2yKPWDOx6Pzz3Er5OyjhW3prLNJ3VVdBlGzd4G5yUzWzThzFykVMOq
 tDYuYia/0aY9l9k60XLgMUY0Xms5TbME4T3N9jwA7QniYemRJfmjm0Hj+PtaX2ZP9/TUo9xmPSy
 r78rbHasCv9492Vm2hnPxgFPIbbwE40tls7EA6369E6vbGPzhu5Te2vZkTlf+ETM3+GZ7FdRspk
 =
X-Google-Smtp-Source: AGHT+IE1IZI68mR1XdTe14pWG8lwjYxUhcI2m0lhvkxfyPG02QS4uvtjOrGcqPIEH7ZBnoxdO9Ouwg==
X-Received: by 2002:a05:6a00:2e84:b0:736:a8db:93b8 with SMTP id
 d2e1a72fcca58-73e243c63cbmr1119046b3a.3.1745456012854; 
 Wed, 23 Apr 2025 17:53:32 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73e25a6a971sm209353b3a.103.2025.04.23.17.53.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Apr 2025 17:53:32 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 078/148] target/i386: Remove unused cpu_(ldub,
 stb)_kernel macros
Date: Wed, 23 Apr 2025 17:48:23 -0700
Message-ID: <20250424004934.598783-79-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250424004934.598783-1-richard.henderson@linaro.org>
References: <20250424004934.598783-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x430.google.com
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20250401080938.32278-8-philmd@linaro.org>
---
 target/i386/tcg/seg_helper.h | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/target/i386/tcg/seg_helper.h b/target/i386/tcg/seg_helper.h
index ebf1035277..6b8606cd6d 100644
--- a/target/i386/tcg/seg_helper.h
+++ b/target/i386/tcg/seg_helper.h
@@ -35,8 +35,6 @@
  * TODO: Convert callers to compute cpu_mmu_index_kernel once
  * and use *_mmuidx_ra directly.
  */
-#define cpu_ldub_kernel_ra(e, p, r) \
-    cpu_ldub_mmuidx_ra(e, p, cpu_mmu_index_kernel(e), r)
 #define cpu_lduw_kernel_ra(e, p, r) \
     cpu_lduw_mmuidx_ra(e, p, cpu_mmu_index_kernel(e), r)
 #define cpu_ldl_kernel_ra(e, p, r) \
@@ -44,8 +42,6 @@
 #define cpu_ldq_kernel_ra(e, p, r) \
     cpu_ldq_mmuidx_ra(e, p, cpu_mmu_index_kernel(e), r)
 
-#define cpu_stb_kernel_ra(e, p, v, r) \
-    cpu_stb_mmuidx_ra(e, p, v, cpu_mmu_index_kernel(e), r)
 #define cpu_stw_kernel_ra(e, p, v, r) \
     cpu_stw_mmuidx_ra(e, p, v, cpu_mmu_index_kernel(e), r)
 #define cpu_stl_kernel_ra(e, p, v, r) \
@@ -53,12 +49,10 @@
 #define cpu_stq_kernel_ra(e, p, v, r) \
     cpu_stq_mmuidx_ra(e, p, v, cpu_mmu_index_kernel(e), r)
 
-#define cpu_ldub_kernel(e, p)    cpu_ldub_kernel_ra(e, p, 0)
 #define cpu_lduw_kernel(e, p)    cpu_lduw_kernel_ra(e, p, 0)
 #define cpu_ldl_kernel(e, p)     cpu_ldl_kernel_ra(e, p, 0)
 #define cpu_ldq_kernel(e, p)     cpu_ldq_kernel_ra(e, p, 0)
 
-#define cpu_stb_kernel(e, p, v)  cpu_stb_kernel_ra(e, p, v, 0)
 #define cpu_stw_kernel(e, p, v)  cpu_stw_kernel_ra(e, p, v, 0)
 #define cpu_stl_kernel(e, p, v)  cpu_stl_kernel_ra(e, p, v, 0)
 #define cpu_stq_kernel(e, p, v)  cpu_stq_kernel_ra(e, p, v, 0)
-- 
2.43.0


