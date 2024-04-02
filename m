Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45FB5CD128D
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Apr 2024 14:28:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rrf4w-0001K6-FQ; Tue, 02 Apr 2024 10:25:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rrf4t-0001D9-TN
 for qemu-devel@nongnu.org; Tue, 02 Apr 2024 10:25:32 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rrf4n-0008Ao-DC
 for qemu-devel@nongnu.org; Tue, 02 Apr 2024 10:25:30 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-3436b096690so511581f8f.1
 for <qemu-devel@nongnu.org>; Tue, 02 Apr 2024 07:25:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712067922; x=1712672722; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xwZDj6i22zNsshQLGOawEr+LQWS78suiJsL8DAY6t9k=;
 b=yQmoSM6HZNtRTueqG4mllekcPyqjFnjLlGmJXY4ArLegJVNFO5rpEpfYQ9jMKlgnnZ
 AQm50fvAYZngiolXvSUKHYrOEmVlP9fPejU0oAaWLRibFYw+GJ34y7waCymZ4NOoO5no
 XFNhZkxEql+3CsfFqYY1UfEHLdmZFilbJjMPy5xWcZlVkuLXBDnmGnTtj7RZLsTGUGqu
 oiju77rYgzVvB2eWQd2IBRhhXgVDzmdJ95hKjwF8MnQv95UcWhAoLS34zETbTHUV78fY
 AMy3xqUKomla9NsfmNZMdXaBWYVjxdkbO/gZnkWcaDA1HJRP+pZOOe3Z54nnEwoaTEyh
 v9lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712067922; x=1712672722;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xwZDj6i22zNsshQLGOawEr+LQWS78suiJsL8DAY6t9k=;
 b=NG4VELrg3MGh5F8TVEr0NsA9ngqocKYDjwXdvsV5uz9W//YZjl8rinsBXUr1lehtHz
 Et8eFhgbwdwUfqAMO9jBd0mK/ovBXPY/fVTbu9shj6zuh9KpPm+3DSIl52W9JWVjwOIQ
 sLNtYWJJNkf5OOkXk8J7r6LoD7DxGxC9gnf3W71qCrONymF1324l6V6RXJekMD9Qw5l7
 YY7kr0OVOkIdijVrhf7+iOO1nN2NwO10MmbNTaHfLIViMaNz8W/I6k3Td6NKIGsEIrZE
 A98bnhBd/KSspWtRCdx6qXNQ8vslh7dfWmetXPLBwYNkcFdN88mzKLuXehHBFftKhD82
 sBtw==
X-Gm-Message-State: AOJu0YxqThycOfHzhpSBtdZi3wjmqviNuknFx9f5RfJp1609z66e9ic6
 z7FXjvewH/iwpngKq2ikSyYQmQBruRyqtxbcbFD48n5hoWJy5ZXpFsg79ese9vKsT227NNJ4hKr
 KZDY=
X-Google-Smtp-Source: AGHT+IHnyfHvzjH/4paP1GBT5Y0OidsdosNhQOHsj4YQC+yCQDDfFWmDG/Dg9bhk1SNG0/StWTvY6A==
X-Received: by 2002:a5d:4ccc:0:b0:33e:c0fc:5e4b with SMTP id
 c12-20020a5d4ccc000000b0033ec0fc5e4bmr12886979wrt.2.1712067921877; 
 Tue, 02 Apr 2024 07:25:21 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.202.91])
 by smtp.gmail.com with ESMTPSA id
 fa14-20020a05600c518e00b004159df274d5sm2909420wmb.6.2024.04.02.07.25.20
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 02 Apr 2024 07:25:21 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, qemu-block@nongnu.org, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 John Snow <jsnow@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PULL 07/15] qtest/libqos: Reduce size_to_prdtl() declaration scope
Date: Tue,  2 Apr 2024 16:24:22 +0200
Message-ID: <20240402142431.70700-8-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240402142431.70700-1-philmd@linaro.org>
References: <20240402142431.70700-1-philmd@linaro.org>
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
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Since size_to_prdtl() is only used within ahci.c,
declare it statically. This removes the last use
of "inlined function with external linkage". See
previous commit and commit 9de9fa5cf2 for rationale.

Suggested-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20240326171009.26696-4-philmd@linaro.org>
---
 tests/qtest/libqos/ahci.h | 1 -
 tests/qtest/libqos/ahci.c | 2 +-
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/tests/qtest/libqos/ahci.h b/tests/qtest/libqos/ahci.h
index 48017864bf..a0487a1557 100644
--- a/tests/qtest/libqos/ahci.h
+++ b/tests/qtest/libqos/ahci.h
@@ -599,7 +599,6 @@ void ahci_port_check_cmd_sanity(AHCIQState *ahci, AHCICommand *cmd);
 
 /* Misc */
 bool is_atapi(AHCIQState *ahci, uint8_t port);
-unsigned size_to_prdtl(unsigned bytes, unsigned bytes_per_prd);
 
 /* Command: Macro level execution */
 void ahci_guest_io(AHCIQState *ahci, uint8_t port, uint8_t ide_cmd,
diff --git a/tests/qtest/libqos/ahci.c b/tests/qtest/libqos/ahci.c
index a2c94c6e06..6d59c7551a 100644
--- a/tests/qtest/libqos/ahci.c
+++ b/tests/qtest/libqos/ahci.c
@@ -662,7 +662,7 @@ unsigned ahci_pick_cmd(AHCIQState *ahci, uint8_t port)
     g_assert_not_reached();
 }
 
-inline unsigned size_to_prdtl(unsigned bytes, unsigned bytes_per_prd)
+static unsigned size_to_prdtl(unsigned bytes, unsigned bytes_per_prd)
 {
     /* Each PRD can describe up to 4MiB */
     g_assert_cmphex(bytes_per_prd, <=, 4096 * 1024);
-- 
2.41.0


