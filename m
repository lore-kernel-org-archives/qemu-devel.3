Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78178C021B1
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2025 16:23:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tl9JK-00077p-7L; Thu, 20 Feb 2025 11:22:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tl9JI-00076b-1s
 for qemu-devel@nongnu.org; Thu, 20 Feb 2025 11:22:00 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tl9JG-0008Ez-6V
 for qemu-devel@nongnu.org; Thu, 20 Feb 2025 11:21:59 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-43690d4605dso7503045e9.0
 for <qemu-devel@nongnu.org>; Thu, 20 Feb 2025 08:21:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740068517; x=1740673317; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=RN4feOr7qTvutqZQVG2BW1YcXuGPMb4XmE2WtQfDC0Q=;
 b=QrkiL8nINFPvaXig7afB7ifx9fYNOxa1zhXQ9nqyU/dMc7tF4jEkGfO8aesJd1FUCV
 C/b/lMr1Tmf5n4WY60YLMQyyE/cxOFDDb92pEVPImAWy1NYnkOA9Ifo9GvzaX9KklKOP
 taeTXwCt/ge3ENSgHFKz891fmo3vXQPbGU/yvLW4oSMDqYX5+mpXQXdRRLIMKc/kKe6x
 9hvTQ9EKnJDGthwCQyYSs3orotIZ455iif70BSsiwZlj0EJTP8ubWV5e0umD43NWs7w6
 W/v77RwiwH/3kY4aK2YoUWdV6iEk5zZPqzL9WjhFea6Lt2Lke2Ouj29+ScZwF4Xh66Ga
 QPpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740068517; x=1740673317;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RN4feOr7qTvutqZQVG2BW1YcXuGPMb4XmE2WtQfDC0Q=;
 b=fHwAmAbAgqPU+nUJ4d96KDIznpCFDnJPiC/Cdj0g4cmDifni/XHeJBg2kJkRkWRbK9
 cIWm4KDjuc8eYtDg64OP6/rw97jL24v0ZTCG7SYaTQoVgNIjf87RGWwDx3I9kR5s7EYM
 qwCIFVkAEKoz7i1R10mQbFvgwGuFxOg445VKCX42VgBpDPMJt1NvJEoI3l6U5kswGrIk
 vIjN55GJoS6VP5hpfUahXKe/p4x+SH/uPd8xniymOp3u73jFLoaWj08b2xnNDdb6ZtHW
 lH34AOjMpcNtmv3RgCuIkSIKnOEzFQ7G2Szh5tVlAtYKArzPcopiKpgAqU63+qK/libm
 XCxA==
X-Gm-Message-State: AOJu0YzFtqGwdp4Q6qspegUGc+r1LO/Mo/5mdTIN2aruw0Kt6liosDB+
 VBADxBCqpgkH0JevQFRVVKY2FgwbicOi38Z+cpgs1xmFHu5zjpuIeRMkB7UaFgxg1nKjo6UvgAg
 E
X-Gm-Gg: ASbGncve0kDSl0dKgWeTyCfip8WXpmEvsmdTS8MC/UT69W3o+4w0UJ21rGjmHdhL5yf
 vpMjpYZZYcDZdcbHmG9sWUC11h+wRLwWUvXmM60mfjSZlWFBmGz3zEsxEIta01kAteXbCSKHtmP
 5cZO7hHHFruJQUBLZVtzC60QBiZdLTIsBr8kZJeMrF24PNBMQKw2wofDRRLNqAtki9uZ0cS1HNm
 4gHUTjTQXmTIGYyFWsDJY+SUmUuTQUkggcVTqlnbXPxntLz0B2qc8JozYtSgfY624lSoqAcg1dQ
 9HMLYp6/l/YnHrHWUNuFWg==
X-Google-Smtp-Source: AGHT+IGwJbWcKPQr9p7wNn+1wchRr+P28IOXofDyAEFPPMT0A8mw1an7Gtd9q71ZQQcZmdUF7lVufw==
X-Received: by 2002:a05:600c:354b:b0:439:9e13:2dd0 with SMTP id
 5b1f17b1804b1-4399e132f5dmr65697345e9.6.1740068516705; 
 Thu, 20 Feb 2025 08:21:56 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4399d55fc1asm48806415e9.35.2025.02.20.08.21.54
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Feb 2025 08:21:55 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 25/41] roms: Update vbootrom to 1287b6e
Date: Thu, 20 Feb 2025 16:21:06 +0000
Message-ID: <20250220162123.626941-26-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250220162123.626941-1-peter.maydell@linaro.org>
References: <20250220162123.626941-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x333.google.com
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

From: Hao Wu <wuhaotsh@google.com>

This newer vbootrom supports NPCM8xx. Similar to the NPCM7XX one
it supports loading the UBoot from the SPI device and not more.

We updated the npcm7xx bootrom to be compiled from this version.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Hao Wu <wuhaotsh@google.com>
Message-id: 20250219184609.1839281-2-wuhaotsh@google.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 pc-bios/npcm7xx_bootrom.bin | Bin 768 -> 768 bytes
 roms/vbootrom               |   2 +-
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/pc-bios/npcm7xx_bootrom.bin b/pc-bios/npcm7xx_bootrom.bin
index 38f89d1b97b0c2e133af2a9fbed0521be132065b..903f126636f9ef5d1100c056656ccfb2b32e5e10 100644
GIT binary patch
delta 90
zcmZo*Yhc^(l+nU*!D9x6DNkDr=09a-2ztoGz`#|*F#jn7L;r()|Np;c0m>C1$z?$0
Ywog`Ma%Vh0Ig_b-VgU<}A_D>d06Rh+WdHyG

delta 69
zcmZo*Yhc^(lu^NO!D9x2$xoRb7CdZGnE#ZCA@Cs+0|QqL!~CZV4E+!GPG)41X52Pe
SmdTy*+~icIZXQJj1ONb5*AzJb

diff --git a/roms/vbootrom b/roms/vbootrom
index 0c37a43527f..1287b6e42e8 160000
--- a/roms/vbootrom
+++ b/roms/vbootrom
@@ -1 +1 @@
-Subproject commit 0c37a43527f0ee2b9584e7fb2fdc805e902635ac
+Subproject commit 1287b6e42e839ba2ab0f06268c5b53ae60df3537
-- 
2.43.0


