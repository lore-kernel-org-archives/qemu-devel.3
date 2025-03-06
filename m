Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A78FFC282D1
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Mar 2025 16:00:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqDVy-0005AC-1Y; Thu, 06 Mar 2025 10:52:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tqDVc-0004XP-EB
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 10:51:40 -0500
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tqDVB-0006lD-0D
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 10:51:14 -0500
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-39129fc51f8so773790f8f.0
 for <qemu-devel@nongnu.org>; Thu, 06 Mar 2025 07:51:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741276271; x=1741881071; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=8ib0DFSQfS0N38e2Pblw6x531bMBILpkbdEfxQrB/nE=;
 b=KYxxoqU8cJ+wGCvTaDkaLYVF1tWOptXxM0tFxdVmhheeWlAsKmh+qCyxKGvzlNUUeP
 +f1K4Mbua7dodUR8NBquCN2WJXtqFhWpT7aFPjWHvkCC8xxNYmvj3zKh0fVpvIYg8ndH
 VMzAVO5ZmVCppbNOZhbh/tBXeKQBHRd9zS8C0VuYZMmfdsfDQq+YA81XYTqSlTiXF2m/
 Iu/DcCSIQeyVrHsFmIIUlurM3t0Sz0VLRk/5VWRbHVTcU8yMQdJb3HGEDzDXg33FFwkV
 22uhGrxmn3m5kDyEPhMllvX0EKTVuE9aHTPb0IF2Q5CzvbC/lky6mrDtgWyMdX1hvUKP
 0Ceg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741276271; x=1741881071;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8ib0DFSQfS0N38e2Pblw6x531bMBILpkbdEfxQrB/nE=;
 b=Og648B/qy/rws04xxKYjdkRS5kGRYbxaYsGYNxxQAqM6MO0hD/27wQnUbJCoTf8SFM
 wfsNSo9rVG5ZDWqyxH8l/tONwZo3X1uGsaFwINUWuPkF/8gERG3lMec/FHMsxKS2Kpb4
 NxIXeCKgnF6bfCfh8jwu4uY3JaModaTK9xmE8ur3IT6r7MCUp7pOrWSgAtuDfUighBtl
 IA0slC7b09CRIA+S1DL5tQqy194wBM3ibXDbU7SilaXIQ9YqB/AYHLid2Txu1ZZoRdao
 wb3l7ZEMUdabzgQTdymN/itR/+hCb4/2NKQQHe7f8+feev7P9YAHj0x7w6AG5JcKMolM
 T65g==
X-Gm-Message-State: AOJu0YyEeLi2WG/PBV3JbhszBIXa7YfUxxFcbHzTyiOEqHWEinmIfPhO
 BPY/gPmv1m0ilx/udEwUR8qf6UmUN3cWDGSN5WBb1Iv0bCLWoqHRncEYXlYLNxQn2ONLhhPd4gM
 hGnQ=
X-Gm-Gg: ASbGncsudNKjUpnLzMc8Py8lFoowAwVwIbcU3cKja794HtwUYXNT+TsR/NnWhcHUE3g
 4fNhs8CDPbikPAXQmQuXLpZa8IWiHwTBEpJuO8N+z4SndNLFWunwyqKXtAjNgGov01cbZKeNy04
 o7ocGPqmN6qSamOsD9jttvE8koFZAilqK6R7tM9yryeXWxBQefiss1DtYP9P077mXoRemMZzOJA
 P0QgaT86YRn8mJkvGHo+3xUea/HNRlyt8NoWZNhUFBt2vyqi1UJjrKxRCMthqHehbQWymb3HtRJ
 UTjKhBMcQMec7PjrEn+hbVOpNb1lo1d1vcCeby9k+0g0yDGjdxHH0qaIFAWeE9ij0WsUZPcgb6u
 2CrShCGOxSRASOX9Kgu8=
X-Google-Smtp-Source: AGHT+IFo/32PV7vNOlRdraRvwiwqv72dW9w7lSK7ceGetc0hECY4PtGt4UrWVc8mFrTVucjcN76IoA==
X-Received: by 2002:a05:6000:1886:b0:390:e8bf:55a8 with SMTP id
 ffacd0b85a97d-3911f7412f1mr6454919f8f.18.1741276271044; 
 Thu, 06 Mar 2025 07:51:11 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43bcc13b23asm53357865e9.1.2025.03.06.07.51.10
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 06 Mar 2025 07:51:10 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 47/54] target/sparc: Constify SPARCCPUClass::cpu_def
Date: Thu,  6 Mar 2025 16:47:29 +0100
Message-ID: <20250306154737.70886-48-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250306154737.70886-1-philmd@linaro.org>
References: <20250306154737.70886-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42d.google.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20250210133134.90879-3-philmd@linaro.org>
---
 target/sparc/cpu.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/sparc/cpu.h b/target/sparc/cpu.h
index dda811503b5..462bcb6c0e6 100644
--- a/target/sparc/cpu.h
+++ b/target/sparc/cpu.h
@@ -574,7 +574,7 @@ struct SPARCCPUClass {
 
     DeviceRealize parent_realize;
     ResettablePhases parent_phases;
-    sparc_def_t *cpu_def;
+    const sparc_def_t *cpu_def;
 };
 
 #ifndef CONFIG_USER_ONLY
-- 
2.47.1


