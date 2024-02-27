Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2385CC54798
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Feb 2024 13:43:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rexb0-000187-JY; Tue, 27 Feb 2024 08:34:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rexaF-0000hT-AC
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 08:33:23 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rexaD-0002qP-M9
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 08:33:23 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-412a14299a4so21618515e9.1
 for <qemu-devel@nongnu.org>; Tue, 27 Feb 2024 05:33:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709040800; x=1709645600; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=joGUYxBf+AHBPVlumJel18CoFaqnsq9/5R/fva28MLs=;
 b=SvGM7GFFl5uFII2d0L7WcjouzXmjkmx/amw6Q7S65ISrhqO216Qr8oqRa8TqyactUo
 O68R3U1vd7SFvXzqf6A1Vp139GafNnLzqLTPVwIT70foRkR3KOb5AXBmGgDwthOa/AvV
 ajnV17CVAmOXl6n47iMX4pormd8UgIDdMd0VTo6dgXAjs+kFbUQslHC20Vu52ZXVdFlV
 arfBgV4j39jKaDac0chsIdKf6mrJkCtxchnNF4YfYU/A6hsFVipO4YzGPNGw6FAP++rq
 MlOk4JZUYyKd1fCKg0OseErmpjTMhZ38wcQ8u3TxQytuCSCfh9/U+EJXl6O5wCL1MF3u
 lslQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709040800; x=1709645600;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=joGUYxBf+AHBPVlumJel18CoFaqnsq9/5R/fva28MLs=;
 b=vIMJQKLqUPV7yVNlqHpGQfZmil0IrQKMGzfu+kbE5yqZ/xPvSqhYUZgFpXgAg9rlLT
 ULflz+ilr//QtSbzzjbq0ok+kMXJGRDMwEx+fiEv9RBYZh+d57Ct9SlYQYNIzyJbYr4r
 zp6xayCA1c6AlqbqeZV/jGcwE6pb/+km0QK59lJ9ZjlQSwyH34MhCodG8x4O9lGGQBof
 lLveC5MsC+BSbXA0xRYVnhyvX2gM0V+VGxGV4RHU/Ey5ktBLay6KgWdAvyaImwe+jBkL
 LmxWB2CgLQPL977mFu2jmr2+y4md5O7ksUOe7LcazEkYC6SR/zE6mnNlIJE3dDg4ooZA
 qP8w==
X-Gm-Message-State: AOJu0YzxUi2/BvHFwMv1nfIgl93tnFoXrZAmk4BhvvEaFOnhUNkRMjVu
 BcQxVbZDZ0FAmAtbRNJGpJMyhxDodXp2c7bdAEnSyQ3mRn9KP8mvymfH5U8h9+MU2FBW77UM2mT
 o
X-Google-Smtp-Source: AGHT+IGrLS9SleRZ8pTHHTVmPIagucwFZ3mXF2RDMvHO2XOm8toZiB99uTqPEO5fvLyzZ4AQhc9r6w==
X-Received: by 2002:a5d:64e9:0:b0:33d:db7a:f8c1 with SMTP id
 g9-20020a5d64e9000000b0033ddb7af8c1mr4125271wri.48.1709040800397; 
 Tue, 27 Feb 2024 05:33:20 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 i13-20020adfe48d000000b0033ae7d768b2sm11319552wrm.117.2024.02.27.05.33.20
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Feb 2024 05:33:20 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 09/45] pl031: Update last RTCLR value on write in case it's
 read back
Date: Tue, 27 Feb 2024 13:32:38 +0000
Message-Id: <20240227133314.1721857-10-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240227133314.1721857-1-peter.maydell@linaro.org>
References: <20240227133314.1721857-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x335.google.com
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

From: Jessica Clarke <jrtc27@jrtc27.com>

The PL031 allows you to read RTCLR, which is meant to give you the last
value written. PL031State has an lr field which is used when reading
from RTCLR, and is present in the VM migration state, but we never
actually update it, so it always reads as its initial 0 value.

Cc: qemu-stable@nongnu.org
Signed-off-by: Jessica Clarke <jrtc27@jrtc27.com>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Message-id: 20240222000341.1562443-1-jrtc27@jrtc27.com
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/rtc/pl031.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/rtc/pl031.c b/hw/rtc/pl031.c
index 837b0bdf9bd..563bb4b446e 100644
--- a/hw/rtc/pl031.c
+++ b/hw/rtc/pl031.c
@@ -141,6 +141,7 @@ static void pl031_write(void * opaque, hwaddr offset,
         g_autofree const char *qom_path = object_get_canonical_path(opaque);
         struct tm tm;
 
+        s->lr = value;
         s->tick_offset += value - pl031_get_count(s);
 
         qemu_get_timedate(&tm, s->tick_offset);
-- 
2.34.1


