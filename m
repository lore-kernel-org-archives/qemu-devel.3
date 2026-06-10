Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07A44CD98C6
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2026 16:21:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXLY0-0000Q9-7A; Wed, 10 Jun 2026 12:12:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wXLXl-00083u-By
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 12:12:43 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wXLXj-0005Z7-Oz
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 12:12:41 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-46013161068so3571879f8f.2
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2026 09:12:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781107958; x=1781712758; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=SAW30Hz/JyRwYpKHJIGNsXhTml6Z0bCpb1cEKyFbxqM=;
 b=eie90+rrOJEJfpOMQC0//sCZEEHZf79d/puimNTCCkbMWCQDib+6GnraQXX/2QO4hT
 wqxv2NqraDwvjxwU3ZDrEnty187JXuZyV6+/P690CClsiKD2wFEFR4k2uJKHapgbFkHp
 ry3K/ogaPF3e+1emigmtfEb9B2OrnrbZjQ8MsqF0bE18m2R6gii8hoqXBy3HgIivdvnE
 dsFt6vX/1lZdELJmwn5SJRUonyJTYI7YU7/HVKa6WywpsvKAqdQui8mPWYfIO8zN6H1b
 Xhamm/IGoeArgzRUokkOZUbPhk2K4FKGaNKsyDgukyeCi66YwAvLvitYJDvCAzqxP15g
 oPCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781107958; x=1781712758;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=SAW30Hz/JyRwYpKHJIGNsXhTml6Z0bCpb1cEKyFbxqM=;
 b=E3nOrgnqeRwFNcoQcf+zXUhMvf7wwID8BvFJXbrdOAh48S8D9V3/PCK2mwQD74kPTC
 +Ji2B6RTZLf53XS+4/+UstLg+WkwTu0vn7Z/JxqmKerpydu6bq+u4x4tVwFpRsUF+aky
 ZVoxYXJWO3efHPk0atowFwuYpww78hs8ns4ygmtMhX0RxUJUAnEN81THWRSAZ53NHWgl
 xgw50GoFdHslpvQLcQ39Zwjga55ttEycjLvtN1DjLSHeGFkyX3+5Ae063UApZ3FJVCBj
 qFYC9gMNtk9PItLQG/oM5XdB+fl6K1bMBMiQVN+8SUJB/suv0Ah0C2GuyDYqDFGvzTb9
 LZPA==
X-Gm-Message-State: AOJu0YxTJjg1X+G7McGE13aXL4jZxKfjpqJ4r19tCGtEfIjHaGePP0H/
 hQkimi0VHZVX10uQA2fdLZAbGGUyIEHw38BWNy82K+RQPSl06LsBbIky/5TKEqAhH3JhxCVeIUR
 yC1bB
X-Gm-Gg: Acq92OG32ZIx+aLBFROB4UJrV31+TAGnlXqCLGWhMpOMM1E3oa2c1jK5Cu+S2PGExl8
 KOz3dpwi003/CiWSakhvBzxwUtEqsKsp6sB6G8f84v8Eb7vu1Oq26aMpX1kuzgGv1U10aWE5SNr
 9fjiISOtJ3c6hzPtatVO3/DUbVO9LibN+ANMFCsiy2WyhY9KprNVpjDz/NhZTm4w5n/HVXYB8w/
 94kiWXXBr8ySjR/4EQmZJNRoUxCkOoTSN7zT9cc/CYpSFT96HxhKgVClXHa5/34WRWWHFEcuTur
 Y8t0EC361yPKVN4WawUG4zpN5Qa/J3AtrQARy6I02Bq3OJZCom0cJud4687j2jKFn82+TSxCaDU
 3uvPNsAm5YnHHRajM2/Ppp3Sz/KlbBVhQBZ1tf4updbJwhLUmo53IE6/PJd0QtXjqbN76YVYE5T
 XSgeYYVTLNU/yjaa/tXbgca5yxVA+R1Y8kahsfBPOkOBjjk+E9xoYNDyAF+51HiphCpGx2c93ln
 sXE4heDrr4GB/Yw49jqXA/OCdTKxm8FU48j+hzydro=
X-Received: by 2002:adf:fe01:0:b0:43c:ffee:ee94 with SMTP id
 ffacd0b85a97d-460304fae00mr32245803f8f.11.1781107958351; 
 Wed, 10 Jun 2026 09:12:38 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4601f2dcbe3sm67911360f8f.8.2026.06.10.09.12.36
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jun 2026 09:12:36 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 25/71] fpu: Handle all rounding modes in partsN_uncanon_normal
Date: Wed, 10 Jun 2026 17:11:16 +0100
Message-ID: <20260610161202.2235298-26-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260610161202.2235298-1-peter.maydell@linaro.org>
References: <20260610161202.2235298-1-peter.maydell@linaro.org>
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

From: Richard Henderson <richard.henderson@linaro.org>

Missed float_round_nearest_even_max when recomputing round.

CC: qemu-stable@nongnu.org
Fixes: 72330260cdb ("softfloat: Add float_round_nearest_even_max")
Reported-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Message-id: 20260608190155.637067-2-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 fpu/softfloat-parts.c.inc | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fpu/softfloat-parts.c.inc b/fpu/softfloat-parts.c.inc
index a154faf32b..c86fc9ccc5 100644
--- a/fpu/softfloat-parts.c.inc
+++ b/fpu/softfloat-parts.c.inc
@@ -437,6 +437,7 @@ static void partsN(uncanon_normal)(FloatPartsN *p, float_status *s,
             /* Need to recompute round-to-even/round-to-odd. */
             switch (get_float_rounding_mode(s)) {
             case float_round_nearest_even:
+            case float_round_nearest_even_max:
                 if (N > 64 && frac_lsb == 0) {
                     inc = ((p->frac_hi & 1) ||
                            (p->frac_lo & round_mask) != frac_lsbm1
-- 
2.43.0


