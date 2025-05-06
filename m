Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA84EC3ABBC
	for <qemu-devel@archiver.kernel.org>; Tue,  6 May 2025 14:49:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCJXZ-0003zE-4A; Tue, 06 May 2025 10:45:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uCJVW-0002Ed-E9
 for qemu-devel@nongnu.org; Tue, 06 May 2025 10:42:54 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uCJVU-0002C0-L2
 for qemu-devel@nongnu.org; Tue, 06 May 2025 10:42:54 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-43edb40f357so30051835e9.0
 for <qemu-devel@nongnu.org>; Tue, 06 May 2025 07:42:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746542571; x=1747147371; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=E9yfhXZokLgtDIcGcft1VTqGRAA3GZXFhIIB6HWLDaM=;
 b=Bqjnw6Rqn7aX+l+qAhs3f9VX4gxLvJWBcQO3XdklKnbcJ3VIqai06n9oQPRyauhp7q
 LnyQ33m8jORvPQmIMuQb9cV8JGaoQ/DZwMOAtBC/e8+mfd7p2BqiiUZzrCsjOLr/mnWP
 OicvcFrS/iF+6X3soViyUxkfAXctk6uWC2Hle6a9sJs2DVTsO+Pf/J1kYlh3AThznsI1
 FPm8S771raEpzYcxenpcqtjdTKC2j4teyHdMiNZ09HPJX0easRxhRBSdDDLIpIQzONM+
 6085rJPmO895eF7qv6003rWvqkDyDKX+G4fWQKnXYK9YpdHIoFNeLpjZs8Mit3s6Uazx
 LUtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746542571; x=1747147371;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=E9yfhXZokLgtDIcGcft1VTqGRAA3GZXFhIIB6HWLDaM=;
 b=WKVLMWKNGbyG9EqhwFx8rF8v+lcnW9nYHotDR8NZbtUXf9HQlhFWWnul2dbDgalWNm
 VvNxaA4WjTVd+pzD2yM2s/dmWys9a21VlC4OyXYv2sOKLeDLA5KG7HQPoOD6TCMxlsws
 2mVIgvpVEAeHPt0rIHeuzl2bemUUT3u/pDKkGgrcD7rGOD21pPIPXfHlIG4Zas9Tvxmx
 rNDSzCvGf5T8MiHcjTXGtO2fLvrUGJUkMC5c1AXIj20hVKZ3rOAxVbFv8C0KNI0eNCsS
 Bi5Mjop3HnYATy9t2+Fd1R2x9vH8Hnyyzw61/XyQzFhPTsNnriYvHU6tssQsxAsNUFNo
 b7ag==
X-Gm-Message-State: AOJu0YzKjwpdsk258+1g+eBkKZtTQVBYPzdBvfMxhhO76aUxtdZ21+b6
 C0mJDRENnPn4dJosG/F84luSyoiRt6F1Lmc9sVIbxuR04Qrrnvwk3dqi6LQzhxn0pe4qYnJLzPr
 l
X-Gm-Gg: ASbGncuL73gpuMeEKmDSFO2TrXs21EgTkiChpuiwCG1UovDrWG3PJ1bDkxosnoVCy5V
 GpcvJqGgYW3QFh0403fi5jeBemnWaiwfbz++Z1QGzsyOeAnGY81PKxmusDcTjwYN0xacAbArq4m
 WXv1k1H394GXkF0//6HPlICQa2nWWGxJOG0WE7bjCE7z4MDLPnZDjZieEUBXFnQHkmui5kU+Ss0
 K/dEMg0Wb2YZHkF8cEk+nVZV/syJZW0Pk6ec+yRtgoLJw7N17gts/7msTBLDB7r2k2Bv+KvDSKR
 g+VxMUlqS0lHWz43hL8jgPbhWDl0NHck4gt60EOuxXcA2mQw5g6JgBznqw==
X-Google-Smtp-Source: AGHT+IGf/PZLZLHwGuJedFmIPRhVb0PEyq4sPt5m/MHreCeHjfwyZxAre+mMy96wiw2jwAys4Tx9lw==
X-Received: by 2002:a05:600c:1394:b0:43c:fe15:41d4 with SMTP id
 5b1f17b1804b1-441d0fd2c8bmr31543505e9.18.1746542570915; 
 Tue, 06 May 2025 07:42:50 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-441b89edfc2sm169603435e9.20.2025.05.06.07.42.50
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 May 2025 07:42:50 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 31/32] hw/arm/virt: Remove deprecated virt-3.1 machine
Date: Tue,  6 May 2025 15:42:13 +0100
Message-ID: <20250506144214.1221450-32-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250506144214.1221450-1-peter.maydell@linaro.org>
References: <20250506144214.1221450-1-peter.maydell@linaro.org>
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

This machine has been supported for a period of more than 6 years.
According to our versioned machine support policy (see commit
ce80c4fa6ff "docs: document special exception for machine type
deprecation & removal") it can now be removed.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20250429153907.31866-4-philmd@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/virt.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 1e4841f036c..61fd8557683 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -3569,10 +3569,3 @@ static void virt_machine_4_0_options(MachineClass *mc)
     compat_props_add(mc->compat_props, hw_compat_4_0, hw_compat_4_0_len);
 }
 DEFINE_VIRT_MACHINE(4, 0)
-
-static void virt_machine_3_1_options(MachineClass *mc)
-{
-    virt_machine_4_0_options(mc);
-    compat_props_add(mc->compat_props, hw_compat_3_1, hw_compat_3_1_len);
-}
-DEFINE_VIRT_MACHINE(3, 1)
-- 
2.43.0


