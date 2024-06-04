Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BD73C27C50
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 15:01:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEVdX-0001eY-T6; Tue, 04 Jun 2024 10:59:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sEVdW-0001d6-GK
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 10:59:42 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sEVdS-0005C6-Tl
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 10:59:42 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-35dc984b3d2so4121509f8f.1
 for <qemu-devel@nongnu.org>; Tue, 04 Jun 2024 07:59:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717513177; x=1718117977; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=c7wbzy7WDaepr51wx9nx6cyHqhwiCFruLACsC21nEms=;
 b=reFLwqLvnTf8fPdDj6qjnJ0fpp8dzqfFKpV09VCrjL2yjjO7QtuBnf7Hzl2V5NF+d7
 5Eyp/OTwfhqYhg19Iht0JczrOQ6UerPlt8l0ofyeWJvg6wEBU+6Rkv5nDIbspe+9Pkzr
 Sq7905M3NAhomMyf5GrhyrAQcAAShGzV8zBoogIsCsLxcSFJxsyF4X3GSu9rexKuKtFa
 T1w9oZH+IgN5mSaPo4Yv7aDAjaamTRzSF7ddF7pvYpH3SfkKrkIksUOLJFOK1Le/TVgy
 NcFEV8Luu4xDLyugOqxQYUcDfUc2SIy7YReJa0AHMuhwfy0fUV5/eHSZldj7u2j7vVFQ
 9zkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717513177; x=1718117977;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=c7wbzy7WDaepr51wx9nx6cyHqhwiCFruLACsC21nEms=;
 b=rH7dnB3t6pof2MQKyyG6Xv4rW6qbeHrJoPB8pobiMFgHP3sdYKGtWZV6I51HCsd0FB
 DbUoajJXalaJBeKCBAIWGbEFp1/6x/X4dch+4xmoqNJbEzGkcpmcyhbmOMY4JmuP5FI5
 pofSxdg4CBWq3fol8OPI/VUZmCx7BApu8F2TVsWeohxQoGk+rkyX+eeE9+B2NqKkmt6C
 KHt5kciIF5j7TdysZuHfWjTa/Dt0uVb200gDMIQj1yGfw8PnrBhQRlcF3DWM9hoqyUUa
 BW9wjgqa67ASx19MuQ7Uwm8Cx/lkVAGs0R+dMeJt0dQKb4CBwL5xXJC1XqGXqi/WHluy
 5Ohw==
X-Gm-Message-State: AOJu0Yyna98Io+OU9H4I6g8kpbShH8Z3EFZOb8NvoG9Kq3s/5lpk/dRH
 24vbo0WOSSaD6S9HZA2DZcKX2DiOys4HP/26wLjERawJ06Xovsu5QbdQy2qA/SNfanYc7HNyLaM
 8
X-Google-Smtp-Source: AGHT+IHwAXU69kIY8N2Ts8ktpxI0J1lOR4BdKsevtdOpSbd4D7P7PF5PU8KlGEzm5ftHUO+TqYPC0A==
X-Received: by 2002:a05:6000:4011:b0:357:9daf:963f with SMTP id
 ffacd0b85a97d-35e0f35549amr11181893f8f.70.1717513177516; 
 Tue, 04 Jun 2024 07:59:37 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-35dd064bbb1sm11767869f8f.101.2024.06.04.07.59.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Jun 2024 07:59:37 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 3/5] scripts/coverity-scan/COMPONENTS.md: Add crypto
 headers in host/include to the crypto component
Date: Tue,  4 Jun 2024 15:59:32 +0100
Message-Id: <20240604145934.1230583-4-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240604145934.1230583-1-peter.maydell@linaro.org>
References: <20240604145934.1230583-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x432.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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


