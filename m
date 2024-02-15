Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6686C48BC4
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Feb 2024 17:59:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rag0N-00021T-Kx; Thu, 15 Feb 2024 12:58:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rag0H-0001pe-Ej
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 12:58:33 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rag00-0001Vb-N0
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 12:58:33 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-41211097adcso7851755e9.3
 for <qemu-devel@nongnu.org>; Thu, 15 Feb 2024 09:58:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708019895; x=1708624695; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Agls286qrzGsJ1hJI9sraTA4L0NishS8JrZlDzd0umA=;
 b=PEBm7ceI9Zkgz5uGcjKzBbZdycx+pLIsToFToiqLsmvKBSbpLkwMeeegi4RZIocsUF
 WJv1RM/RjYTXPf5JfyjG1qTTV0O7CslAGWIR5uH3LQB56LySJLeBEHF4BdflAKr17sCw
 eIl3U1zjMv/dWjkr1mTL8hcJBnmVFrROeIX0LoIpYhXuIQmR/jGRFZ3kqB/H24WEE4nz
 6rNUGpYvRRW6YXLgXrofOvXz43QbU/CrngAxiigdmSk+9S4OfOqX1oJLwglPS/VLjs7x
 QHgG8YTan02QUSZHJwDxb4l9Oyj2oFQC+sGrbw+kkF8jR5YyHB5Is9a9IvciNmzCYmAv
 8xlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708019895; x=1708624695;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Agls286qrzGsJ1hJI9sraTA4L0NishS8JrZlDzd0umA=;
 b=VOZFJSmaMITTlTgQpj/nmKlO+NhvvF8rzjYUYadqJg93t6828aT3lGQAE3698gLpX9
 BVUE9I/T95Vw1BuY25QiSJN2lgbDNLpyT8SNkjJLzxi9f0YbLu9tS3PqXyXKw7p/rurM
 2bqHMTfOL/vqS4wVMLEql6YxaPZcTeBiWWe42Wi7kbQV+cndu9SMFD/HMVMha8sa6/M4
 EFKk7/NmlML/vM98gpn+p8pqXO6AqwZd2xaqC+Xsgk5EBttycz1xdoBkSAgqtNeYY10H
 QQybPDeFmdCtMXOwYoS/5rvpuRAC8RIKvd91z2HThebEzh1Uq2WNXgBd7Fy67wpEfpgV
 SK1g==
X-Gm-Message-State: AOJu0YzwvD4PCWSnIE0iaJx+TQr2rpCIdH2m+mncp+ngSBgfTT4tN93w
 rs48z0nogYViJxQVC+jiuZNbOi6WgYpp/6ifGP1O+PwWJrf+8h65DuWpvcf8fhwb5Ze73WBY11g
 DWAo=
X-Google-Smtp-Source: AGHT+IFNb/9ECMbxAKPLendWbsSb67EYu/O9JmvIMn90J/gls0XaRrtaHbhgHzJAHcAnR8YpyYNNmg==
X-Received: by 2002:adf:a446:0:b0:33d:4e5:b1f2 with SMTP id
 e6-20020adfa446000000b0033d04e5b1f2mr1479996wra.38.1708019895026; 
 Thu, 15 Feb 2024 09:58:15 -0800 (PST)
Received: from m1x-phil.lan ([176.187.193.50])
 by smtp.gmail.com with ESMTPSA id
 ci3-20020a5d5d83000000b0033d10bd6612sm1315244wrb.81.2024.02.15.09.58.13
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 15 Feb 2024 09:58:14 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, qemu-arm@nongnu.org, qemu-block@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>
Subject: [PULL 03/56] target/mips: Use qemu_irq typedef for CPUMIPSState::irq
 member
Date: Thu, 15 Feb 2024 18:56:57 +0100
Message-ID: <20240215175752.82828-4-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240215175752.82828-1-philmd@linaro.org>
References: <20240215175752.82828-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Missed during commit d537cf6c86 ("Unify IRQ handling")
when qemu_irq typedef was introduced for IRQState.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20240130111111.6372-1-philmd@linaro.org>
---
 target/mips/cpu.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/mips/cpu.h b/target/mips/cpu.h
index ef26fe03c7..b4788e1af2 100644
--- a/target/mips/cpu.h
+++ b/target/mips/cpu.h
@@ -1183,7 +1183,7 @@ typedef struct CPUArchState {
     CPUMIPSMVPContext *mvp;
 #if !defined(CONFIG_USER_ONLY)
     CPUMIPSTLBContext *tlb;
-    void *irq[8];
+    qemu_irq irq[8];
     struct MIPSITUState *itu;
     MemoryRegion *itc_tag; /* ITC Configuration Tags */
 
-- 
2.41.0


