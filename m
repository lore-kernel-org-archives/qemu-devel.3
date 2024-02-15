Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A9CAC48BC4
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Feb 2024 18:05:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rag1g-0006ZH-1L; Thu, 15 Feb 2024 13:00:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rag1X-0005mp-9d
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 12:59:51 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rag1U-0001rJ-DK
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 12:59:50 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-411d231ea71so9176725e9.1
 for <qemu-devel@nongnu.org>; Thu, 15 Feb 2024 09:59:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708019986; x=1708624786; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nD0xGIx0jqih+wWIcjwEtsdSIF+Dav0OUaDGYWjSMEc=;
 b=wmG7tInvbLWeQWiGXclknJ8uGy7wGrv+C0Rog8fq208kPEDbR73c10QDA1/CQ/PLo5
 6byUI8IoeJTC0lyq4Vg8zNlwqWq9yRLCrlq5guaxNzLHV1Rh6v0D0MKXqMz2Kluuz+c4
 2aXYqtDm5cjXBZGSHddORzt3kEu9+3ZHRmuYX3tO2pjI6dPqDhs+4JeqTWQ/u+rtbHqw
 cFfibHIWAc0b1E6T5YrvvFO7ZYfsJQrFaGnQIhUg+4ZnrQUR5Pt7YQcyPFexibK/NI/Z
 FoUSGqHP1EVohod9Hu6V0w5QMrzGmCCQpG1aXP7QuwQaG5mYrmLpihzXPZT5OoS9E5Xz
 nmrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708019986; x=1708624786;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nD0xGIx0jqih+wWIcjwEtsdSIF+Dav0OUaDGYWjSMEc=;
 b=cudACjo3rkbF5S0dywgN7J/UTQK2PzHTdekEmMjBjVYXkgi0TkIavnQ5nzxMl5ifBc
 5GtSfhXpOWMMgr+pQ8XSzIowZSjjZrV9y2cbjluWU/9A+RYcS5++rQuFJ23kYLJU+jWC
 AM5ls5xfZOKa27jADQmEJK37lLqJ8Czjv4KRvbpTiMntg9AYqmsdvm+nbbVS4MBtJgfW
 dVMoQZmpOgYjckiUKdVMi4v9nG4np6F+97LF49o3JJMgKXVhYLbQzet+AxCLuMBeqR5S
 KxJXkEvi1kFDc3CDcep1dYKTwR/cPjJxYtd8Shggq3opJz/B5vZjMw9yOV1v0lbj5Yxv
 OxOQ==
X-Gm-Message-State: AOJu0YzcdfVpR2nz4WlVvS+hTGpNI+vSJZu48Uk9M24P7u8hAiA9HTXy
 yhCKyFxm3x/aGnfobHKHx0doJOPWQfEl8TI50dUywgBgx/+d6BJmpYfbBlJ1to+gFgRd4vsgs3t
 XAOQ=
X-Google-Smtp-Source: AGHT+IEJHA5bEKhM2Q4FpPLroCzVyxgL2EOjG9iCokVLBYfaRvKIDx1dbKDK6M1lIFLA/tmfaVYcJQ==
X-Received: by 2002:a05:600c:5586:b0:411:ba7c:99a with SMTP id
 jp6-20020a05600c558600b00411ba7c099amr2126769wmb.38.1708019986191; 
 Thu, 15 Feb 2024 09:59:46 -0800 (PST)
Received: from m1x-phil.lan ([176.187.193.50])
 by smtp.gmail.com with ESMTPSA id
 fa25-20020a05600c519900b0041228b2e179sm1436839wmb.39.2024.02.15.09.59.44
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 15 Feb 2024 09:59:45 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, qemu-arm@nongnu.org, qemu-block@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, BALATON Zoltan <balaton@eik.bme.hu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Bernhard Beschow <shentey@gmail.com>
Subject: [PULL 17/56] hw/isa: fix ISA_SUPERIO dependencies
Date: Thu, 15 Feb 2024 18:57:11 +0100
Message-ID: <20240215175752.82828-18-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240215175752.82828-1-philmd@linaro.org>
References: <20240215175752.82828-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

From: Paolo Bonzini <pbonzini@redhat.com>

ISA_SUPERIO does not provide an ISA bus, so it should not select the symbol:
instead it requires one.  Among its users, VT82C686 is the only one that
is a PCI-ISA bridge and does not already select ISA_BUS.

Reviewed-by: BALATON Zoltan <balaton@eik.bme.hu>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Bernhard Beschow <shentey@gmail.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <20240213155005.109954-5-pbonzini@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/isa/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/isa/Kconfig b/hw/isa/Kconfig
index 7884179d08..5df3c09cd5 100644
--- a/hw/isa/Kconfig
+++ b/hw/isa/Kconfig
@@ -15,7 +15,7 @@ config I82378
 
 config ISA_SUPERIO
     bool
-    select ISA_BUS
+    depends on ISA_BUS
     select PCKBD
     select PARALLEL
     select SERIAL_ISA
@@ -47,6 +47,7 @@ config PIIX
 
 config VT82C686
     bool
+    select ISA_BUS
     select ISA_SUPERIO
     select ACPI
     select ACPI_SMBUS
-- 
2.41.0


