Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BD99C52D70
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Aug 2024 13:02:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbJhZ-00082e-Jj; Tue, 06 Aug 2024 08:54:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sbJhX-0007m2-61
 for qemu-devel@nongnu.org; Tue, 06 Aug 2024 08:54:07 -0400
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sbJhV-0000KX-8J
 for qemu-devel@nongnu.org; Tue, 06 Aug 2024 08:54:06 -0400
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-a7a83a968ddso68664166b.0
 for <qemu-devel@nongnu.org>; Tue, 06 Aug 2024 05:54:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722948843; x=1723553643; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=T2BNzJT5/rzAun9sis8NChUOI8pg5PZFtzu3546w0iw=;
 b=luom6VsDG7eJb/MsC2Emug3Dip+gUBk0+vtOqRnikMkTlCSOIYHp8TNeuSQGA3gmuu
 VXrS5mTGYjt8MLYCHKuTKXxT+eyTD7OnfgyJhT/YsCn8npp/UTuIXrFS7zQuqZ97GqgQ
 gXcP9D+U/JdccXbFubb7KdSVU0f/sZOJWI048fsCs8Y5ic3ztc/wRwxuWr8aqyWnVSNb
 L8Bfc8VblSJDMdSyaX1/KlIXLclbHsqRx+KYjMElpasigQud4qpXFqmj1N9HAzbWUIY9
 ygUFhhf2UCGEwd6zSAPT4Jj9R3khezu6TCfVzpGx0iSsY42S2sh7snEPNw/+WXZAPkuK
 8Nuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722948843; x=1723553643;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=T2BNzJT5/rzAun9sis8NChUOI8pg5PZFtzu3546w0iw=;
 b=QLCWZr5dDiri+X6FPfCQxfrH4K4XLVpIazSDL7TzTu7xGDJIZQj2CFmtXYRWbkbV3z
 cWE8Ka3wUJ/y7T7smO4rf0AXSEI+xRKvZyKxKloyvfE57Q9vNhOHnxHvVN1/ln1TClC0
 kW5Y+urGDGmCxbA/2IKFAtawSKJs4Wu7cOdLLsgT6vAM93CFnkGAx1APzxu9UwKMsmBa
 80H8J1CpeV5rCvrI1ELtlhZ2koZH0F85NKa03CQx7b7miTHGyUg7J9K/t8mrraQhfQr6
 U5EbinrSfr7KZGkkLgemWsQV0lpLNzxRlKUGWzMq8WZ7YiBscj57/9N8kEWpwql/Xt7x
 CskA==
X-Gm-Message-State: AOJu0Yw4+vFCftluAr1xHqouh8PgC/C9vHdaqv2F04se/GMbWvvIGnD1
 snd4CSBdW6V7vmC8aYaA9pvxIhQ7H2ermgu5oxsg6veLRjjjUIu8T/fL6OmZu0VDNvtnWK0GELc
 l
X-Google-Smtp-Source: AGHT+IG+moa5CelR4wcWKiPrSXr92jlFBykqrBUANqj/NP10lZca8tLDfw7h0yzZPG8/tpjwCGMWHQ==
X-Received: by 2002:a17:907:1b10:b0:a7d:3ab9:6a5d with SMTP id
 a640c23a62f3a-a7dc5130c90mr891231866b.69.1722948843425; 
 Tue, 06 Aug 2024 05:54:03 -0700 (PDT)
Received: from m1x-phil.lan (cor91-h02-176-184-30-206.dsl.sta.abo.bbox.fr.
 [176.184.30.206]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a7dc9ec7575sm539465766b.205.2024.08.06.05.54.02
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 06 Aug 2024 05:54:03 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 20/28] hw/block/fdc-isa: Assert that
 isa_fdc_get_drive_max_chs() found something
Date: Tue,  6 Aug 2024 14:51:48 +0200
Message-ID: <20240806125157.91185-21-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240806125157.91185-1-philmd@linaro.org>
References: <20240806125157.91185-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62b;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62b.google.com
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

From: Peter Maydell <peter.maydell@linaro.org>

Coverity complains about an overflow in isa_fdc_get_drive_max_chs()
that can happen if the loop over fd_formats never finds a match,
because we initialize *maxc to 0 and then at the end of the
function decrement it.

This can't ever actually happen because fd_formats has at least
one entry for each FloppyDriveType, so we must at least once
find a match and update *maxc, *maxh and *maxs. Assert that we
did find a match, which should keep Coverity happy and will also
detect possible bugs in the data in fd_formats.

Resolves: Coverity CID 1547663
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20240731143617.3391947-6-peter.maydell@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/block/fdc-isa.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/block/fdc-isa.c b/hw/block/fdc-isa.c
index e43dc532af..796835f57b 100644
--- a/hw/block/fdc-isa.c
+++ b/hw/block/fdc-isa.c
@@ -147,6 +147,8 @@ static void isa_fdc_get_drive_max_chs(FloppyDriveType type, uint8_t *maxc,
             *maxs = fdf->last_sect;
         }
     }
+    /* fd_formats must contain at least one entry per FloppyDriveType */
+    assert(*maxc);
     (*maxc)--;
 }
 
-- 
2.45.2


