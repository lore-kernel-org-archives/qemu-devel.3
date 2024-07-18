Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91BC2C3DA60
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2024 13:22:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUR4B-00022T-DX; Thu, 18 Jul 2024 09:21:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sUR3t-00009q-V4
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 09:20:46 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sUR3s-0004XF-5q
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 09:20:45 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-3684e8220f9so398649f8f.1
 for <qemu-devel@nongnu.org>; Thu, 18 Jul 2024 06:20:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721308842; x=1721913642; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=79yCY4ObJ0UJwhXu8mzRzCS0V2zPCSrYq+jeYyYlXHs=;
 b=Dxt2Kyh3FZG1zc8IuuyQ7T1RYfsysRAJaIded8TsEn3Qdg+CQR1lGmv4lRWEPKgjOn
 W/JRBpZ6RXpSVDHalJMkZFdYwkEWPq7nhKOu8OHmpKzjJoDTkid4zDFQBg2Wa3jWtzvb
 3rKNTCl8J7ogM61aiT6GANoRP9Rp1l1QuChZWbR+LJsq/WyeoYMTQfBrUoFu0znOT1Sr
 Rw/YVGfQOS1CoQU4a+1H6srC7glAX3v4lj7dm7lwYgK74N1HNVRgx+0j9/UnC4JAtamM
 adr+bu6bqtF9J4vn5PYqvfz2Jc3wovYMnJ6/Uex7Ba2vt2sCPnmzhOxCq0T7k0tSt/y8
 RNfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721308842; x=1721913642;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=79yCY4ObJ0UJwhXu8mzRzCS0V2zPCSrYq+jeYyYlXHs=;
 b=YB4qSO1lZT2pM4WBKxRpNV/QVNLMUtfRIOaK+osxyhVoFVbQE1vmC81DIHGsu1wXZU
 GlfsMbC1UHIG4llORcDhtVVZRMzNZy6srzDeiTiXIfnskeoafV7VXhf+xPbZIbSrBcNV
 9gZJ1TccoIcVdh+mCIOwCoJMFs90VoBpvgthQhbs1/IqGQjR44UK+LG7jzyaPvVmk8fY
 5ays9aZ6rICaGRdfrkE5uBs8v849oUvtHF3hGY1+/MWm/FMhtyWfcM1L6FyZeiEWSDoe
 HE+HvOXBOTOEa+Y+7La59xoRdOYJRnEOqMhn1Eeu/cxRxuP2y3ByZFml96Swbi9Unb/D
 hwpA==
X-Gm-Message-State: AOJu0Yy3i2voq8NlHwwy9UEzi0DPU7U6MllGQDxp6gD173cZdj1TB+68
 0ysGIHPiP7A6oN+agJTUyoKvFNkwP8UiaYWNhSxF7eEZSvKZ+1sWzGoVGv35/krqCEABh6tiS/M
 y
X-Google-Smtp-Source: AGHT+IEiuB71/4W1eCZIUp/EuIk3SDnoj+ndXnhXyNhBT2VQujocRzhOQNOafpSvtxZ5mu9z+XzDRQ==
X-Received: by 2002:adf:a11b:0:b0:368:37aa:50b3 with SMTP id
 ffacd0b85a97d-3684b3e3543mr2156357f8f.24.1721308842720; 
 Thu, 18 Jul 2024 06:20:42 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427d2a8e420sm14059315e9.35.2024.07.18.06.20.42
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Jul 2024 06:20:42 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 26/26] hvf: arm: Do not advance PC when raising an exception
Date: Thu, 18 Jul 2024 14:20:28 +0100
Message-Id: <20240718132028.697927-27-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240718132028.697927-1-peter.maydell@linaro.org>
References: <20240718132028.697927-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x429.google.com
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

From: Akihiko Odaki <akihiko.odaki@daynix.com>

hvf did not advance PC when raising an exception for most unhandled
system registers, but it mistakenly advanced PC when raising an
exception for GICv3 registers.

Cc: qemu-stable@nongnu.org
Fixes: a2260983c655 ("hvf: arm: Add support for GICv3")
Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Message-id: 20240716-pmu-v3-4-8c7c1858a227@daynix.com
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/hvf/hvf.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index ef9bc42738d..eb090e67a2f 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -1278,6 +1278,7 @@ static int hvf_sysreg_read(CPUState *cpu, uint32_t reg, uint32_t rt)
         /* Call the TCG sysreg handler. This is only safe for GICv3 regs. */
         if (!hvf_sysreg_read_cp(cpu, reg, &val)) {
             hvf_raise_exception(cpu, EXCP_UDEF, syn_uncategorized());
+            return 1;
         }
         break;
     case SYSREG_DBGBVR0_EL1:
-- 
2.34.1


