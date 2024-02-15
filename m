Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61C7EC48BEB
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Feb 2024 14:22:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1racbj-0005aQ-VQ; Thu, 15 Feb 2024 09:20:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1racbg-0005YS-OT
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 09:20:56 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1racbW-0000DF-Kt
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 09:20:56 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-41211acfcfcso6360905e9.1
 for <qemu-devel@nongnu.org>; Thu, 15 Feb 2024 06:20:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708006843; x=1708611643; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3nHBcC1vTxuWuhw1KTr8iuMLr3JCNHYJX8skgFi1VDE=;
 b=NeenWfF6pti7xuc5xaXoi2F2DFjYnQRtALd5VeHXVVoFKFRn0ampEC5BSpukajIP3g
 z2CchPiDOi8hCi0jDvgl97XeTE3JF7x2/EqS1y3pv2EFRKWsaGufNe+wU+bOC+Au+Kdz
 tIqmN+xdEwBi5xamAU3A+zymxacPgMPcoGFDYHqV4uR2zg6PGzXyLZ66wj4gjd9TTL+n
 FZSqBVTECY+W7C0rb8N0loVY17l95LgjMGrTrtwPqqUNjRBegp3sI35oL5036f3yILzt
 Vt88kbXfTgyXULtjC8FpFoZ4qCE2cSqK3lXzT5Qp+ySzeQFrUPbHoO0FR+YRvSDalYx3
 aKgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708006843; x=1708611643;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3nHBcC1vTxuWuhw1KTr8iuMLr3JCNHYJX8skgFi1VDE=;
 b=JPy59Ay2+G+01OZo9eczhD1w8ImXLIlspv1LY3yFxFYdoKzeL4Xj4Ian4d1GtuRjet
 x2E3b5OMXkVD+PK0Hz2WA3j13bl3gcqgFwoewAL8F7ethvylilFlIMj9oaMsODdGVDZ5
 Gt+g+2xb9BScXayU5V2jpOwgt+thdIVsinLWPQWXXDVzfEZ0E96wRITd1ufC/wBvCGRu
 hGYSd+qn2Z/E77+u7ymX8opZdWkgTiU2O3E+yctJSqSNfn0Rx73IhLnyZ59LGDfAX2/a
 fUBzjTxabbykvMKdyqqz+GG8X9CUQuRSt8nNMKKQEAWLc/ix8v5Gy6WtPgxhX5wUI5WP
 77MA==
X-Gm-Message-State: AOJu0YxSlJvv6UXmkqchwF6SZlXZ3Tx99I9T++TPCgvqKz6XeAoq+3zS
 3MN888kM5X5ANzTO2PToeGpqp5xomw0NDddv2DZYy2jIt93FhP1pXXA/JDIbu+VvjE5e00xRV97
 +VGg=
X-Google-Smtp-Source: AGHT+IGYTlTqE8oJnVvdqEH05RJIW0vLAV8SwKPHsQTNe656NKaFZ1cePEGe5vdZtMaDKsmuuMyucg==
X-Received: by 2002:a05:600c:3caa:b0:411:d7de:ea8e with SMTP id
 bg42-20020a05600c3caa00b00411d7deea8emr1310715wmb.23.1708006843679; 
 Thu, 15 Feb 2024 06:20:43 -0800 (PST)
Received: from m1x-phil.lan ([176.187.193.50])
 by smtp.gmail.com with ESMTPSA id
 z7-20020a05600c0a0700b00411c3c2fc55sm2159883wmp.45.2024.02.15.06.20.42
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 15 Feb 2024 06:20:43 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
 Marcelo Tosatti <mtosatti@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 1/3] MAINTAINERS: Cover hw/i386/kvm/ in 'X86 KVM CPUs'
 section
Date: Thu, 15 Feb 2024 15:20:33 +0100
Message-ID: <20240215142035.73331-2-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240215142035.73331-1-philmd@linaro.org>
References: <20240215142035.73331-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index a24c2b51b6..b526a08015 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -490,6 +490,7 @@ L: kvm@vger.kernel.org
 S: Supported
 F: docs/system/i386/amd-memory-encryption.rst
 F: docs/system/i386/sgx.rst
+F: hw/i386/kvm/
 F: target/i386/kvm/
 F: target/i386/sev*
 F: scripts/kvm/vmxcap
-- 
2.41.0


