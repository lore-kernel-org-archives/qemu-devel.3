Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0515BCE8D47
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Nov 2025 15:32:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vJvld-0006bA-O3; Fri, 14 Nov 2025 10:31:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vJvbw-000662-Fs
 for qemu-devel@nongnu.org; Fri, 14 Nov 2025 10:21:16 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vJvbu-0003tJ-Uw
 for qemu-devel@nongnu.org; Fri, 14 Nov 2025 10:21:16 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4774f41628bso17032715e9.0
 for <qemu-devel@nongnu.org>; Fri, 14 Nov 2025 07:21:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763133673; x=1763738473; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=q216H4IGLv9TaDoeKYNHluqwKP3p7ETBMiN5sai97GA=;
 b=lvbfl8Ps8otQ5sIV+2/WC75iq7FPmpMjB3R3GV19RMpB0R8Hwreyg8ViaDTzr0uy/u
 rpAGsvA9JIOlI8mxMJWGrW5NLOc70wFbnexWOvD6Hqm939JEblccVwlfRt+IlS6PB9Pc
 lz0zzGdqiJxQnvYGA/5+bc6WkP4XCf1zqtCCrx4I9NtjO5gPC8z2XOMIF36PU6ZtUuBr
 YecTynxmkZobYuHoOjZlKesO1+S4CYrRYy3xSMRLnZJroawsK2QJtL4Vx37HXRLS2NFb
 exwwls7+dgrTS40JOVovNIWXe+5++CZ1FZ4j6z12SNf436cdRRuuRYZ+wuKnRKpuypcX
 OVBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763133673; x=1763738473;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=q216H4IGLv9TaDoeKYNHluqwKP3p7ETBMiN5sai97GA=;
 b=aO1wujVprCA6K/y1IA0IDxFzb1+LISzKx6+WIkg8TLdywjxjjPOjMDBgiUxQrgYU3x
 t7X7JWOWXsD2qcPoNnd6yjWw2qcGTm6ri6mmA3KGeRpIC/UT43NCDu5qhgZ0asUkHvTw
 E/bSYAJsdJBsuK9CLjHSfNwCuljD06XFTltoKYureWg2PqFY4+rLjmdLRMFcEGOpvshz
 ngnnf5A/Oq/XIG430fq76Oa2MF6gwk99VU5+cFLZoHoymfb5NI6J2yNwlqbUfCcHn2Qq
 e6OG8E537qFIYsitRR+m56nx7vOJ3AXQYsjzIC/O+yWsU2MW8xCVGRfEnbT3SRsULVk6
 u1wQ==
X-Gm-Message-State: AOJu0YwQ8jmyLXxFK0IZLhsnMpr2lqTAX+C+/x4465gfM0s2ebMOVohE
 ivmWo1Z+Gm7cLfiQZ+9MGQn76osrfoTZRRorv8nwmfKgVDn08DWjPB6R57phZcEv6kqiCQHJY5s
 6M9KG
X-Gm-Gg: ASbGncs4SUOxWEB+K9Of45+wzhOnrJHrtmWkNx5dkYk+FLbyWwzfAMf00aNkTtx8Nuv
 60tl8BIa1i64e3RgkgOZqbLLHU/ReaLjzcHg8TbfjXC83aF5HU7os1SuU9ny98QdYwZsbmE3AMO
 pRv3SkjMjctGk1bwAFTHcfxIAYgo20+vrrYOxkwMEX1LgdKicy9w9MMbC7z1b7kLmxRz00Myy2P
 5pZ5eWsGO/peW8ltWwWFCDwVMEZTKEGFXSJ3OMu81piPHAzPkddhoBrULWQsYDduiAOqoFGAqKY
 US5r8aAMdWLdeJo5x3+DdH/k3jnXTQnVGIoHbfgbE/9VJJ/6GaHzh+TKTj6tOW8BAvG6f92urlY
 hRyIBbVz7/HX6nMcjZFOyERjaYbGAGInF8sO3f64PT+b/hQ4uVtjEXWvKtKojftY42CSzaH7BlJ
 ZgvwWN7FUWS7/4Xa8p
X-Google-Smtp-Source: AGHT+IGrv5r2bjsfe3P4YEEKsnEwebxnV9dTyViPgzWx5xgfue3aizZ5VgK/KVxVmyZIgpTNwLsDCA==
X-Received: by 2002:a05:600c:1e29:b0:477:5639:ff66 with SMTP id
 5b1f17b1804b1-4778bd07ac2mr61429935e9.13.1763133673406; 
 Fri, 14 Nov 2025 07:21:13 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47787e8e798sm146772835e9.10.2025.11.14.07.21.12
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Nov 2025 07:21:12 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 01/10] MAINTAINERS: update maintainers for WHPX
Date: Fri, 14 Nov 2025 15:21:01 +0000
Message-ID: <20251114152110.2547285-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251114152110.2547285-1-peter.maydell@linaro.org>
References: <20251114152110.2547285-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32b.google.com
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

From: Mohamed Mediouni <mohamed@unpredictable.fr>

From Pedro Barbuda (on Teams):

> we meant to have that switched a while back. you can add me as the maintainer. Pedro Barbuda (pbarbuda@microsoft.com)

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
Message-id: 20251107072337.28932-1-mohamed@unpredictable.fr
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 MAINTAINERS | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 9cb181e1da7..38325e0617c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -547,7 +547,8 @@ F: include/system/hvf.h
 F: include/system/hvf_int.h
 
 WHPX CPUs
-M: Sunil Muthuswamy <sunilmut@microsoft.com>
+M: Pedro Barbuda <pbarbuda@microsoft.com>
+M: Mohamed Mediouni <mohamed@unpredictable.fr>
 S: Supported
 F: target/i386/whpx/
 F: accel/stubs/whpx-stub.c
-- 
2.43.0


