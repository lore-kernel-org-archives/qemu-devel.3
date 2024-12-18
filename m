Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 682ABE77187
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2024 12:32:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNtD1-0003jx-7K; Wed, 18 Dec 2024 07:31:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcin.juszkiewicz@linaro.org>)
 id 1tNtCw-0003jQ-6Y
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 07:31:18 -0500
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcin.juszkiewicz@linaro.org>)
 id 1tNtCo-0007pV-78
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 07:31:16 -0500
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-aa66ead88b3so1122477066b.0
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2024 04:31:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734525065; x=1735129865; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=0lGxPdDUNres/qgj71MFksVE9EyY0fMEzGI3zvEKGlA=;
 b=C+PtcgqX86EW/rO3puRiMQvevsl46Zlpa+u4e1imJhix71B6aNamgT3/xVlxL5BZZ/
 xuZ0B2KpikXusGtqCLVPHLZQJ3mk7BqS/bRsrlHhD55l7EV7+WDWgOupSUB1eENz3RWz
 7ynKyrjDGPeRLPnJi2igMRtngiJ5Pj0Y/zx/Gk3tcTQFoJfB0AHvc14HqQDPVVgVQluF
 cPfiUatpjS/e83Fn5zluMd3L1ebXUQmjstkkOWnNPR0eH1Icz7pBSF154kWr2yeALs27
 b6Ht99sCkHV8N5X18/Juous2JJCDN4W/PbW/50QVpzi3xUvtFpyQD2igcMO/DQkeb7jL
 4cjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734525065; x=1735129865;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0lGxPdDUNres/qgj71MFksVE9EyY0fMEzGI3zvEKGlA=;
 b=boNgTy0XeI4hngSGUppcPAHXsecASwb7FWxe5o1pkjfkK3MSVeO8oZNYrFTYdVPsKY
 2lX/em8pFLvJCC6BAeX3ujugD5DTUUTQmF8xByiMzpswllsJ+AyfczYWSifq6r6LoV7S
 YS6ujjJUTkIlLCWcy42sTqi8SChyC0VG+9I91EF7lgxYuU6RPJAdvgguAW9X2Su0h+rR
 kVdLm9qwKwtQVnJIEKpvRlXBduUqipIv/ogdw80s07nb9k7JSxNuAxPQLgIEhA+lZYyB
 kbKpqV+YJINKERkwGu1776J4NwSjhgAsoMSw8J7mweemj8+OipajGKkCO9rATZVqf2fK
 +Fqg==
X-Gm-Message-State: AOJu0YyOj2HR3Zx+E3E04xJpUw80xnvKHD0uaZ8F/ggmySGZgPAKN3tC
 +iZdC2w9ecRnnhL8GdL2Ka7jGhaCrNgvBsX7WFITDfUgJl4vOuIprNZo+od6k7G1IzwjLWQLBvi
 K
X-Gm-Gg: ASbGncsLsYolFf/hTAdTSS6W4V7zPNlac9b0PIhFyQs/Lqg36C0h77RrOSIcl/rIQQO
 JK9YpuSLH4eBnz8tLSMtE2XOBiIBYeNzBgzR8XTpAMTcw+hxrBbzh5FcfSrdLjs9rHybUFpde4A
 6ZWGfHk+0Y3puU4vtze3Fv+kVouKt8NgRD3H8dnCrILssSHX3lNBxH0I3nNnBvjrUZXH4balPf8
 g2qNg95z1zzORinwJn9VQGK1AshZg+rRcLw0ul6RyrPaXk3jP7TzBU51dsOmYzM83LjEGj+0mSM
 YxnEO7LpNs6cGwlHjj/umrbby3ydXJc=
X-Google-Smtp-Source: AGHT+IHQuYv9WSzj7fPYx4KPYq4hkRmCxNfu3mNxh08/DloOVe4/TlBTE7vsC5uc5Fgwf9U388kmtw==
X-Received: by 2002:a17:907:6d05:b0:aa6:abe2:5cb8 with SMTP id
 a640c23a62f3a-aabf497ae81mr170152066b.60.1734525065378; 
 Wed, 18 Dec 2024 04:31:05 -0800 (PST)
Received: from applejack.home (83.8.62.35.ipv4.supernova.orange.pl.
 [83.8.62.35]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aab9606891dsm550550166b.72.2024.12.18.04.31.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Dec 2024 04:31:04 -0800 (PST)
From: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
To: qemu-devel@nongnu.org
Cc: Leif Lindholm <leif.lindholm@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Radoslaw Biernacki <rad@semihalf.com>, qemu-arm@nongnu.org,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Subject: [PATCH 1/1] MAINTAINERS: remove myself from sbsa-ref
Date: Wed, 18 Dec 2024 13:30:55 +0100
Message-ID: <20241218123055.11220-1-marcin.juszkiewicz@linaro.org>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::630;
 envelope-from=marcin.juszkiewicz@linaro.org; helo=mail-ej1-x630.google.com
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

I am ending my time with Linaro and do not have plans to continue
working on SBSA Reference Platform anymore.

Signed-off-by: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
---
 MAINTAINERS | 1 -
 1 file changed, 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 822f34344b..776e0b997d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -918,7 +918,6 @@ SBSA-REF
 M: Radoslaw Biernacki <rad@semihalf.com>
 M: Peter Maydell <peter.maydell@linaro.org>
 R: Leif Lindholm <leif.lindholm@oss.qualcomm.com>
-R: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
 L: qemu-arm@nongnu.org
 S: Maintained
 F: hw/arm/sbsa-ref.c
-- 
2.47.1


