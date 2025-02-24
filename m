Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C89AC021A4
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2025 11:16:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmWRO-0005qZ-Ge; Mon, 24 Feb 2025 06:16:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tmWR7-0005oF-0x
 for qemu-devel@nongnu.org; Mon, 24 Feb 2025 06:15:57 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tmWR4-0001AF-Ge
 for qemu-devel@nongnu.org; Mon, 24 Feb 2025 06:15:44 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-43995b907cfso25514195e9.3
 for <qemu-devel@nongnu.org>; Mon, 24 Feb 2025 03:15:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740395740; x=1741000540; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4UDGq1/nftyfWIeWE3zhkfJ5qF1yxDplS+dEScuvFz8=;
 b=B7lLdMqyYY4f4XzJ2CT7jIEDkIQ1HeL8LkDRuIsWJ6eGfThRBU1G1zFEFOM8erV9+B
 hpSwvDSNGE57SNQpEZgMSLXsdspdWYGm85Beq9wkqAueurr6q+iFJ57K25s6fDLoCyHV
 EmSzQigfGA1V68/yhFg4PFY7kmTrctcKMhpESF2fvLWk07tUXxliXLaqY3+pNqE8d1BJ
 ufp3fJ/bMKRaLDJK1OzZ+yFxyfxLk1QbpUlyD4qBTNKPZO58Iu//GEEB+CSqADG4KTjz
 U2KVMQLj6e/smfLyzrLFRfdXK5hzP2hXaRSOddvmJTJmVoBuQCwI/9GZpi2drgNxRFi1
 LsHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740395740; x=1741000540;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4UDGq1/nftyfWIeWE3zhkfJ5qF1yxDplS+dEScuvFz8=;
 b=inKAmfE7JWYskhcQIPh8LHJgY0R7Fh6SIxc3ViEw6SwnK8TaEKMpJ/pVWG6s2rYtME
 qjtLhyMajq3cyW9+Tpq7jDrZVIbiiVGFt1nBsEwcKl+GbVhBXB+wsnODkuChzkE88MOv
 9ba2HFuFn8op4ejUAvWpjT8GZDzrkNdBXtMPFwJ4aWpi6JePQND48KCyvirSrcCZlY9T
 RwlPHnN5pVa7l1QqlANxU25t4HFVzVaBhD46Nhg9KKX3i9QMFtvjStfO2UGjyQb3frd4
 o4gkO8iVheXzr1KXkyJzmECuLMwt/YmgeHDtYymQStMokMITc0rK+j/uXzJuXphFA6Nd
 wEPg==
X-Gm-Message-State: AOJu0Ywk0p3cJn0UFP/dvtrUA9EBYvnzS/8W0x0tSBhwNiaiARL5DwXK
 j9CCH2zuMFYeohdkfMy2YiBtE3NsZL0LAuN/revELNxYZYPB2ygdbVAbrZ3yOq02BH0FhAgToYZ
 l
X-Gm-Gg: ASbGnctMGsQYfKWjBLigIM9lqZU5StvbtdxDlw5CPm2KG0T0jJ59FRz/AZEGC8GAFLo
 pdWv/Azx2hjL+/a6e4vq0NZdvkO4WoZGJZtHK2R7zo6eIXDuLx+RPtBKm/pKiSpbQjVfPdq6E6F
 DMzGrd6VJn15r7hmp2DAaO7jEyAG/+5FeQz8jlwyat9DJeawYGVvyhb0YeRzbYGyraIVuxXniII
 lGBUz8URvKKbmtDCYc3SUWimjH6E6EwhoU0SHZ/ChvCiu0u+TtKptDRju81hrxsOfm+LH3ugGgr
 TxU2hfDJcz3ZqtqDiHYl4Lg3eYGAMJkU
X-Google-Smtp-Source: AGHT+IEDuyTkS81O1UdbaFlosz8KvxAoiInng2rPvJzcNgQKDUCuU5NcwztStQKuxlfnPxF27YsPZQ==
X-Received: by 2002:a05:600c:548b:b0:439:89e9:4f06 with SMTP id
 5b1f17b1804b1-439ae1f1873mr121508685e9.14.1740395740487; 
 Mon, 24 Feb 2025 03:15:40 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-439b037214asm101447705e9.38.2025.02.24.03.15.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Feb 2025 03:15:39 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 12/12] fpu: Build only once
Date: Mon, 24 Feb 2025 11:15:24 +0000
Message-ID: <20250224111524.1101196-13-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250224111524.1101196-1-peter.maydell@linaro.org>
References: <20250224111524.1101196-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32f.google.com
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

Now we have removed all the target-specifics from the softfloat code,
we can switch to building it once for the whole system rather than
once per target.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20250217125055.160887-11-peter.maydell@linaro.org
---
 fpu/softfloat.c | 3 ---
 fpu/meson.build | 2 +-
 2 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index b38eea8d879..34c962d6bd9 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -79,9 +79,6 @@ this code that are retained.
  * version 2 or later. See the COPYING file in the top-level directory.
  */
 
-/* softfloat (and in particular the code in softfloat-specialize.h) is
- * target-dependent and needs the TARGET_* macros.
- */
 #include "qemu/osdep.h"
 #include <math.h>
 #include "qemu/bitops.h"
diff --git a/fpu/meson.build b/fpu/meson.build
index 1a9992ded56..646c76f0c69 100644
--- a/fpu/meson.build
+++ b/fpu/meson.build
@@ -1 +1 @@
-specific_ss.add(when: 'CONFIG_TCG', if_true: files('softfloat.c'))
+common_ss.add(when: 'CONFIG_TCG', if_true: files('softfloat.c'))
-- 
2.43.0


