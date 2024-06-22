Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91C75C2BD05
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Jun 2024 12:08:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKzWC-0007pZ-Ar; Sat, 22 Jun 2024 08:06:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sKzW8-0007lR-N6
 for qemu-devel@nongnu.org; Sat, 22 Jun 2024 08:06:53 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sKzW6-0000Je-BM
 for qemu-devel@nongnu.org; Sat, 22 Jun 2024 08:06:52 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-3632a6437d7so1646048f8f.0
 for <qemu-devel@nongnu.org>; Sat, 22 Jun 2024 05:06:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719058009; x=1719662809; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=S6scBZe6eKXFZ2uoGKEj8e/OcZjXe1rGfVYARHRdKps=;
 b=sYOxj6bmixfUgkekGrDjtwYwK1stO6KUv3zfAeCtA7L6FidwKXt/baKSLezR8FAiCV
 o5USarl4P8NwHBwpKJq1umPPjew6LAFBoKnfU1o18NKZyzm9aJ0yXWtwIrnQFLNf04bW
 u5t0AHLwxItiTgaTRgrogDlWf3rlKxUELNG1eXwstR2CLraK7XLpFTISGJPey1C85f+h
 oYfJfbIqrUmfebEwIbqO4pC6pRyuOd+VDjnzhh0B7onif/JFeZqA0nHOHdrlSKM21xsK
 CFfN5Ydq0NPSv1o+0KzFxonZoO1eGdbhfSDgBIos+72xJx1Oc1pzDpgtV6FU/PR4PUOY
 MAGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719058009; x=1719662809;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=S6scBZe6eKXFZ2uoGKEj8e/OcZjXe1rGfVYARHRdKps=;
 b=R2ZWJKO5DEvptBO3iwmj3CnLIZID2Wz9C7p9s5U/y4+gm1jaq4hwR5eY/zlA7o3n2t
 PmkT8Ev0SWtzEUROs13r7E6wRwVMJ60ue7pSin/wRcrPSJcaB4Nin5g8aarCLJVP8eV2
 4aDLs0fwTzAS+8eH5STcXUAhoHG/HpukCC6xZ4z7gQAoepZpqEzZ9908eK66xo6uYUJd
 cxKkyMHTrd2hMByWPPHnOnX5bcc2PRlpXWexIroladNWl65vx8v8iA/ZkVcOq8DKAyry
 9Ko5qipclh9yEKkoT6lYiW0Nxd/hEFQiCsGbaj2+lumavMcEAj0iWC8Imx1S/A1Rc2V/
 XI4g==
X-Gm-Message-State: AOJu0YxGbtN9kh240OL+/lCzPZLgvcfvRAorMnFBSwSqgZofeq/w/vLs
 eySTUogNV4iuCT0Dy4SYlNwz8lo5zLSBqJO2MhpnZgNNipSecjG4x3HWigQqeSjWEQCYkFc9x+V
 9uco=
X-Google-Smtp-Source: AGHT+IG08rTDwlsDK6dpbDyHnUU0GLa++V60uk7AiySKPa5qQ5R9+MPws4c9qS3SV8MAYfMiTlf+Dg==
X-Received: by 2002:a05:6000:d09:b0:360:7856:fa62 with SMTP id
 ffacd0b85a97d-366e3291345mr905788f8f.15.1719058008725; 
 Sat, 22 Jun 2024 05:06:48 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3663a2f698dsm4393006f8f.70.2024.06.22.05.06.48
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 22 Jun 2024 05:06:48 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 07/18] scripts/coverity-scan/COMPONENTS.md: Add crypto headers
 in host/include to the crypto component
Date: Sat, 22 Jun 2024 13:06:32 +0100
Message-Id: <20240622120643.3797539-8-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240622120643.3797539-1-peter.maydell@linaro.org>
References: <20240622120643.3797539-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x432.google.com
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

host/include/*/host/crypto/ are relatively new headers; add them
to the crypto component.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20240604145934.1230583-4-peter.maydell@linaro.org
---
 scripts/coverity-scan/COMPONENTS.md | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/coverity-scan/COMPONENTS.md b/scripts/coverity-scan/COMPONENTS.md
index fb081a59265..205ab23b280 100644
--- a/scripts/coverity-scan/COMPONENTS.md
+++ b/scripts/coverity-scan/COMPONENTS.md
@@ -79,7 +79,7 @@ chardev
   ~ .*/qemu((/include)?/chardev/.*)
 
 crypto
-  ~ .*/qemu((/include)?/crypto/.*|/hw/.*/.*crypto.*|(/include/sysemu|/backends)/cryptodev.*)
+  ~ .*/qemu((/include)?/crypto/.*|/hw/.*/.*crypto.*|(/include/sysemu|/backends)/cryptodev.*|/host/include/.*/host/crypto/.*)
 
 disas
   ~ .*/qemu((/include)?/disas.*)
-- 
2.34.1


