Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEFD3CA1005
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Sep 2025 13:15:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utQpB-00071F-Ar; Tue, 02 Sep 2025 09:13:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1utQow-0006Rs-8W
 for qemu-devel@nongnu.org; Tue, 02 Sep 2025 09:13:10 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1utQop-0004iq-Fk
 for qemu-devel@nongnu.org; Tue, 02 Sep 2025 09:13:09 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-3d1bf79d75aso1081484f8f.0
 for <qemu-devel@nongnu.org>; Tue, 02 Sep 2025 06:13:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756818780; x=1757423580; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=hjwcUJJSQtOz70iFspOPdXzaMy4QJRp2F0LsGT4wN/o=;
 b=ZteowRP+xVco5sMfKwFUWVn0dj8ZvucPiNS4DApHWAFJF5jyPv08dKX0JDLM3BXdfb
 8gItc4z76H34gLWLWqy1w17FMC7NTrK59ErQCftCrBDdOycUedv2oLn/hm5jYLRmsp/U
 ih7OLnWavIFA9uWB3znRkfxBM/tVmfcMrmyaT+OnKpfxRxC37sPmSiIsa4KE4zo1hF7s
 hzOEP8Gb7dtq3ZJp2yEDzXnCrWv1iz+ri4aCa5gw8lBAS8BI6A4J2ypvUjNw/EDnggZZ
 uT9Eh3iibEtpnl/LWKePxL8e+kZr/d6cCxho9njdgCg37yJX5p18o7AY67zwb1m9pe+y
 JL6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756818780; x=1757423580;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hjwcUJJSQtOz70iFspOPdXzaMy4QJRp2F0LsGT4wN/o=;
 b=fwToschVrXvudID5fLUnWjkq0WTjDQb3vf4cXD92Pj2zQsI0bK1ATI1xJ+zs8BeJvQ
 5sptCD477NNtrbA3PTy2XZwbIXRenRJx01zv1tpPC/ECBhh1/ecOk0aiHqAxLusmOckf
 SyCTPdwn9Fd0Bn8tVdjAwSNkOIHTnixFam6p4vPIDACveNnPPh86RNY7b776cxnDiwV+
 TfQnRBj4WL9dT/ukspmlP9AT3kC27mhtUXwKzvRNHONFGoa9pVvuHDWio+sFrsq9JWIn
 BRiJnkrNxnLdEeS5TWhaDdLtjGMdSvZLY4tflaBZXhIutWY1NjcDP5MxpcCZna9u/J8e
 yvgw==
X-Gm-Message-State: AOJu0Yzp5Y7L9QAOhcw3hsVic5JevfrlJoO8cCTSJxgoShXppMCE15oQ
 hLYvdsFgD5HdpG1dI+NHfQzOLXoHDbydzaaXkSxz9xPvzrbScVPIq7TQ9WOHuf1W/Zpo5tDS/Gw
 48Kqm
X-Gm-Gg: ASbGncup523e+F8imz7vhr2gQtnIAnThXo6OfsVlCysmM+HwtsZQn0LEajQFd3JM3gp
 XwYwyi4/T9kcczUlfNzn4S/JmcXP2L1boRpnAC+zmxv4C/aIOvXKO2tSWEd+Fwg9dmq0LMKtr5Q
 VqUpJNXB+YLv0ySK7ht+ThREREG7xdYYoK1Qsvq+rIp5RK2r7KNVfzqQlkCaBkXCbhojJm5Dv6b
 LIwFDk2lB38chVnmdx8Cac56F6SuP50CtFfLXW5xLsKVOWTea+im334vMYfa7aLzeqtv0wPYIzE
 xKzKAyw38DF5kTyBCSG3R3iVHZMRC9MHn+4NJFNTFshdeoHuTY4gKW+cRZCdSOrxCZv/o09hvq0
 j+ZeicQdtOERitzArQk2hV51FZp/KW2TaL50agrwnF1ndr2MG4taXTg5mtbRW5SaML5cD4IY7
X-Google-Smtp-Source: AGHT+IEWSZZBSg5pdiHeBdLAVFpObgfQwoGLF+6h6hXg8I3pakn+V4Bb/2G0IHMVTLRMbQQYDP+JFw==
X-Received: by 2002:a05:6000:3110:b0:3cf:ef30:c819 with SMTP id
 ffacd0b85a97d-3d1dc699e64mr8347574f8f.4.1756818779794; 
 Tue, 02 Sep 2025 06:12:59 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3d66b013b7dsm8869318f8f.28.2025.09.02.06.12.58
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 02 Sep 2025 06:12:59 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 35/39] hw/mips/loongson3_virt: Include 'system/system.h'
Date: Tue,  2 Sep 2025 15:10:12 +0200
Message-ID: <20250902131016.84968-36-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250902131016.84968-1-philmd@linaro.org>
References: <20250902131016.84968-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42e.google.com
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

From: Cédric Le Goater <clg@redhat.com>

Files using serial_hd() should include 'system/system.h'. Fix that.

Cc: Philippe Mathieu-Daudé <philmd@linaro.org>
Cc: Huacai Chen <chenhuacai@kernel.org>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>
Signed-off-by: Cédric Le Goater <clg@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20250901064631.530723-4-clg@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/mips/loongson3_virt.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/mips/loongson3_virt.c b/hw/mips/loongson3_virt.c
index de6fbcc0cb4..672083dec98 100644
--- a/hw/mips/loongson3_virt.c
+++ b/hw/mips/loongson3_virt.c
@@ -49,6 +49,7 @@
 #include "system/qtest.h"
 #include "system/reset.h"
 #include "system/runstate.h"
+#include "system/system.h"
 #include "qemu/error-report.h"
 
 #define PM_CNTL_MODE          0x10
-- 
2.51.0


