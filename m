Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 812DED2B921
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2024 13:07:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8JGW-0005SV-BM; Tue, 05 Nov 2024 08:06:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t8JGR-0005Bm-6l
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 08:06:31 -0500
Received: from mail-lf1-x131.google.com ([2a00:1450:4864:20::131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t8JGP-0002c3-I1
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 08:06:30 -0500
Received: by mail-lf1-x131.google.com with SMTP id
 2adb3069b0e04-539e8607c2aso5924211e87.3
 for <qemu-devel@nongnu.org>; Tue, 05 Nov 2024 05:06:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730811986; x=1731416786; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wFGgkm5n4LzlLdg21RwAQ7vz4q2WxQLn0Ned6IA69o0=;
 b=qJ30FYtUzFL7E65u+UymvYD3rWqD31n/DVReb78dLiCq1KhYiD5mNN0KOcJKhUOard
 xqdpJVN0y5D3GViSXrdWvHPj5FXMb3sPEUZTdU2YBSAEzByseK8P2LZN7qaxCDwxBbUt
 9FzkwGh1pE+yR+yvXEvEUgoRClf+rnieUl6dOsyg3ayh1fEmjsCfN3YXVRgZa/5AZ1Vo
 83ek2w3Jl4tUu4Oe6onPAP7dSwrh3uwu9KexRViQfwCWc0K85EmOaijLM3ZrjlSnTbTy
 WTlUcXxOLtc8WjLq151n6OJK0wF1F2uUetO1RCiA9HfRgQJRg019lzmI2Qo5oKQrgspd
 glRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730811986; x=1731416786;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wFGgkm5n4LzlLdg21RwAQ7vz4q2WxQLn0Ned6IA69o0=;
 b=gz4c8/DhNxVigkXW0djFNqgXfDxkCJ75MViQEtQXY9MdvZVIceVwTLCIE+2mGnRUkl
 cDb0QpclnJSOWK/ggEvCjQXbyfJfi+ggV3Afsluv8JL1hCes/IFsNn6hO31Wd4DKQdOv
 j7Kyaf3g5TffvlXCug2QhWiqX+554eueyOJOPlM3p23cSfHBe6OP8xh2fX+td3Nl3sHh
 2063IwwQHbhqHMJt23caobKvmS9WP0Fm25B18wUz56KNJ/WzjoXeUJLrAlX1v1A8tVox
 yrANqEGipVzge+MW+JbGdOyuusCiCYnMim8kC8LXbdlHiHnROMNHbayidkYoBtnbPxwA
 lNcQ==
X-Gm-Message-State: AOJu0YxJ+FJKyrbd6rIhZqvoJQwfH/TDLSUsYYdMWCknMnFNT2GN8O9b
 ihGTwPlnD6xwhctK5tEs7zU9nC9/oDfnZR8HRTBHlb1HB7ekNsl2Hz8t7IQ3FYlf/3MpZYOPHvq
 k9c4=
X-Google-Smtp-Source: AGHT+IFE9HUPx4C1HvI0xeVeqRG3FgfnVcqldGiQnuGamTFUmzYLVvKRdrwEBzmZXF3o00dHN/OMmA==
X-Received: by 2002:a05:6512:1152:b0:539:ee0d:2bb4 with SMTP id
 2adb3069b0e04-53b3491cb3cmr18858667e87.45.1730811986405; 
 Tue, 05 Nov 2024 05:06:26 -0800 (PST)
Received: from localhost.localdomain (86.red-88-29-160.dynamicip.rima-tde.net.
 [88.29.160.86]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-381c113e5e3sm16241441f8f.82.2024.11.05.05.06.22
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 05 Nov 2024 05:06:25 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org,
	Anton Johansson <anjo@rev.ng>
Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair@alistair23.me>, Thomas Huth <thuth@redhat.com>,
 qemu-arm@nongnu.org, devel@lists.libvirt.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 11/19] hw/timer/xilinx_timer: Allow down to 8-bit memory access
Date: Tue,  5 Nov 2024 14:04:23 +0100
Message-ID: <20241105130431.22564-12-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241105130431.22564-1-philmd@linaro.org>
References: <20241105130431.22564-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::131;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x131.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Allow down to 8-bit access, per the datasheet (reference added
in previous commit):

 "Timer Counter registers are accessed as one of the following types:
  • Byte (8 bits)
  • Half word (2 bytes)
  • Word (4 bytes)"

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/timer/xilinx_timer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/timer/xilinx_timer.c b/hw/timer/xilinx_timer.c
index 3e272c8bb39..e9498fc7eec 100644
--- a/hw/timer/xilinx_timer.c
+++ b/hw/timer/xilinx_timer.c
@@ -201,7 +201,7 @@ static const MemoryRegionOps timer_ops = {
         .max_access_size = 4,
     },
     .valid = {
-        .min_access_size = 4,
+        .min_access_size = 1,
         .max_access_size = 4,
     },
 };
-- 
2.45.2


