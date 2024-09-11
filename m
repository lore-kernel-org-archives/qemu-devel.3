Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC6C5EE499D
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2024 12:19:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1soMJ1-0005eR-8s; Wed, 11 Sep 2024 08:18:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1soMID-00021P-GN
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 08:17:58 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1soMIB-0007bE-Pc
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 08:17:53 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-42cbe624c59so17523475e9.3
 for <qemu-devel@nongnu.org>; Wed, 11 Sep 2024 05:17:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726057070; x=1726661870; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fw5xOtBNIRHkpMkNkgTQIdZ9ohmUJVJx9XSvRhYmISM=;
 b=nmpR3zY8mEhmcyLY4kiwRzr2cgLJqbsfYOFQK4iIytiPsf8CUbbhqQJjvtr3LnTEWn
 LHMHJk016U9MlcHJsd+/ZByDRHKe/teM7AIYxIc26bTIdBW5pTBwm7ZVqdtDQG3m1G9z
 IPvLv7onjlvLpGLw6aS2ElYHG0V01Ti5p/riyzwApO8Tbx4W0OZYUSYCpP89+Tn+ViTd
 CFjUk5+lXXllfuucY1ounvhTJVnLFDPwj0Q6c6/r2rByY2MDVT1+UI2MvqsHCgiTDgx6
 qVWxk6If/SdCqFCwpzq3ntHxa6ccjQlJA+940H/hNpot0GAjIPHsheDKh00cnj3/2C3y
 bvXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726057070; x=1726661870;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fw5xOtBNIRHkpMkNkgTQIdZ9ohmUJVJx9XSvRhYmISM=;
 b=DfViQuMG/osiVhAr09FeqJE2lz6fswkJ3dn+Yi/hpePL7tY0ITfSkB52bMCFqedOjA
 ouSTCby7iIbUJR2SS/FQ+tlEo4ZbrqcCYtViywr+E2ozix9mX2v/NArNVCRp/fHZC6xf
 hDlYMOsQxKQEN8b55DvEPTIrCyFlhb+QnRFOYvwBym80L+A74lokcJAzCFl9kfRdAPYf
 SQhJlX29AgSuwHncIzxRIZh8nXKUXgG2eg9E3dvHrLs43ZM6tAd6Oew3C/cC/M+hTJL/
 3Yl9okd5bYlFXN2zioaBi7gTsDmJGPbqoz+TGHM2TPDl+pE0QENW7Hdesdw1JTPlo4hF
 PPYw==
X-Gm-Message-State: AOJu0YwYdxuDp/+9pP3y3L3/xcJUWWZPfvycGJ3K9A9GnTC1MkI1rMWh
 W3EbVYGuD0zLijcLb+ZPFTUXcOaL1W2JbFnaBSigArFwgtqWbqx8OpPcBBl+ewmcURls9pFRIXV
 O
X-Google-Smtp-Source: AGHT+IFM+3RAPND2HiwojAZnU0IVJFCdQN341yNAX6F4b8ye6tmvcREpD+eP2rwqRqV1lSefoqeBTA==
X-Received: by 2002:a05:600c:5252:b0:42c:b750:19ce with SMTP id
 5b1f17b1804b1-42cb7501eb6mr80335095e9.1.1726057069931; 
 Wed, 11 Sep 2024 05:17:49 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.196.107])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42cb6db7ddbsm105424855e9.34.2024.09.11.05.17.48
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 11 Sep 2024 05:17:49 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>,
 Jason Wang <jasowang@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Michael S . Tsirkin" <mst@redhat.com>
Subject: [PULL 31/56] MAINTAINERS: Add myself as a reviewer of VT-d
Date: Wed, 11 Sep 2024 14:13:56 +0200
Message-ID: <20240911121422.52585-32-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240911121422.52585-1-philmd@linaro.org>
References: <20240911121422.52585-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>

Signed-off-by: Clément Mathieu--Drif <clement.mathieu--drif@eviden.com>
Acked-by: Jason Wang <jasowang@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20240820095112.61510-1-clement.mathieu--drif@eviden.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index a197994c10..da631eb467 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3663,6 +3663,7 @@ VT-d Emulation
 M: Michael S. Tsirkin <mst@redhat.com>
 R: Jason Wang <jasowang@redhat.com>
 R: Yi Liu <yi.l.liu@intel.com>
+R: Clément Mathieu--Drif <clement.mathieu--drif@eviden.com>
 S: Supported
 F: hw/i386/intel_iommu.c
 F: hw/i386/intel_iommu_internal.h
-- 
2.45.2


