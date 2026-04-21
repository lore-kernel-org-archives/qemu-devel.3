Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C28DEF8FA78
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2026 14:24:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFBzx-0006CO-KG; Tue, 21 Apr 2026 10:22:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jim.macarthur@linaro.org>)
 id 1wFBzv-0006Ah-Ur
 for qemu-devel@nongnu.org; Tue, 21 Apr 2026 10:22:43 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jim.macarthur@linaro.org>)
 id 1wFBzs-0007OS-J9
 for qemu-devel@nongnu.org; Tue, 21 Apr 2026 10:22:43 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-488a8ca4aadso58646525e9.3
 for <qemu-devel@nongnu.org>; Tue, 21 Apr 2026 07:22:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776781358; x=1777386158; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=o3zvbU/P1VBtqICRahxjL8iOuK5j880AJkIh1dca91A=;
 b=MamdK0juNjfTpqH+eqfFH36cVlWWd9DKEjGrdPptTLKX5XF4W+zkSRE0nK0mpPATdS
 bcmYhKA1IsN3t0aTkPoo18VKwT8hN0qVGOm6WswfQUhraK22wNF3p9PC717toGN0DE4t
 9sLKr4tvTJPqeKuvlX4iehXoCJcZH/AAW4ICIlipTPp64UtpLVHcRa+42o6tlCqfRg9o
 Pyd5K/efuMt98jwTE/MHTtc/FEPItqkS1Qpsg7fPfP4l6EKm6/CajU3e/M7cnY6chaTp
 8uSLidSqE+h50MDyVB8znsDAJ9igYh4vBcjNMQ1BTHZriB8FB02pUukl6FwWlTfkN9Zg
 Kpow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776781358; x=1777386158;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=o3zvbU/P1VBtqICRahxjL8iOuK5j880AJkIh1dca91A=;
 b=ibMImZBR5zX+Ne1IOAVMRZ5G9oML7kPemTCiRhSBqcQ0Ggi/t/kdfZ7N6IkAYpckKw
 ah7PpxSrtTZgVjZvM2FHJVWBYqHBZeoePJN9b2tOHwRxXd/19or+bfNweAWb4qpNzanE
 P4bL6PVuXc0cFxAu7+s1iQaOPrNu2DBVsb+T8jIywwKoqOpBDAcbTP8h0u+3JeOJ3CA7
 6C8u7jKhJ/OPIJ1jgTrKtNFNjPGWw7zZ3QpRrW3NNPs6MAMo+SkYVmwUe05IoZvin2G6
 GU1i8ZE+JzsZo0HH//Ym3IZEzmof5RVEmmkUBKnx9zZrzfl7QToriJM610kxwepXvaXk
 /OWw==
X-Gm-Message-State: AOJu0YwdkO4ou+oCjmGiDlrxBeayY/DqgeUtbd8l/cfvBmbNd6ZOqG4C
 8fF8kcLLTc01/gstOnuXtVqBq9O0Oas8utrM6GW6EAQc3iKhN07kX3rB5wwWUR4e/9w=
X-Gm-Gg: AeBDievZd36SSE2wKGpnAYRgxBqU6mbmw50MWVh5zeZcIZX/DfnFi4hzxujWq77TuwY
 MUr3p7yU/nPNIGu0cJLXKimc4UTNqQhXAU8/t0UT9yfhJdJU9hUPSUXuxkuro678URO72TbYIpT
 q+qRqURaQAtfViQNXSWl5Vr79NYSpIwz+oaR5MZqdoQpCTl9+XK5ipJAFiH/VTjNYT6VVfv8708
 aRxyXoZQKThdRFkAnMnE5m8in3XXhcrEqmKs2bGoKEUX4Mu+XQVnwflGeS5SbQYCoUom+0lsuyX
 CWTgnpI/qa6QpaSnZJW45gOspRR1jAqqsGq+NUww28B8pxtD/Z+L+GyZCYE9/Z6X/ADYFHaGMmP
 tFpbqizmeuVumoSNQK42NqJYdX4faL6pfXb7I7IsfY9SDy9EPMbVPVP7BS/NvgDENEfhrn7Froq
 q48nYv6T3sGVzc8TCem83J4n67fsZdmyIV8SWJSQ==
X-Received: by 2002:a05:600c:3110:b0:487:2439:b7be with SMTP id
 5b1f17b1804b1-488fb7389dfmr280872495e9.6.1776781358387; 
 Tue, 21 Apr 2026 07:22:38 -0700 (PDT)
Received: from [127.0.1.1] ([2a10:d582:31e:0:5364:f814:f749:9bf5])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4891cca5743sm164250465e9.9.2026.04.21.07.22.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Apr 2026 07:22:37 -0700 (PDT)
From: Jim MacArthur <jim.macarthur@linaro.org>
Date: Tue, 21 Apr 2026 15:22:34 +0100
Subject: [PATCH v3 1/4] target/arm/cpu-features.c: New fields in AA64MMFR4
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260421-jmac-feat_rme_gdi-v3-1-ecd20c77eae1@linaro.org>
References: <20260421-jmac-feat_rme_gdi-v3-0-ecd20c77eae1@linaro.org>
In-Reply-To: <20260421-jmac-feat_rme_gdi-v3-0-ecd20c77eae1@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, 
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org, 
 Jim MacArthur <jim.macarthur@linaro.org>
X-Mailer: b4 0.13.0
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=jim.macarthur@linaro.org; helo=mail-wm1-x329.google.com
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

Added RMEGDI for FEAT_RME_GDI and other new fields.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Jim MacArthur <jim.macarthur@linaro.org>
---
 target/arm/cpu-features.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/target/arm/cpu-features.h b/target/arm/cpu-features.h
index b683c9551a..2d1a3196b7 100644
--- a/target/arm/cpu-features.h
+++ b/target/arm/cpu-features.h
@@ -346,8 +346,16 @@ FIELD(ID_AA64MMFR3, SDERR, 52, 4)
 FIELD(ID_AA64MMFR3, ADERR, 56, 4)
 FIELD(ID_AA64MMFR3, SPEC_FPACC, 60, 4)
 
+FIELD(ID_AA64MMFR4, POPS, 0, 4)
+FIELD(ID_AA64MMFR4, EIESB, 4, 4)
 FIELD(ID_AA64MMFR4, ASID2, 8, 4)
+FIELD(ID_AA64MMFR4, HACDBS, 12, 4)
+FIELD(ID_AA64MMFR4, FGWTE3, 16, 4)
+FIELD(ID_AA64MMFR4, NV_FRAC, 20, 4)
 FIELD(ID_AA64MMFR4, E2H0, 24, 4)
+FIELD(ID_AA64MMFR4, RMEGDI, 28, 4)
+FIELD(ID_AA64MMFR4, E3DSE, 36, 4)
+FIELD(ID_AA64MMFR4, SRMASK, 44, 4)
 
 FIELD(ID_AA64DFR0, DEBUGVER, 0, 4)
 FIELD(ID_AA64DFR0, TRACEVER, 4, 4)

-- 
2.43.0


