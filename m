Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CCADE7718B
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jan 2025 10:04:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tTI3Z-0002bB-MY; Thu, 02 Jan 2025 05:03:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tTI3Y-0002av-Q3
 for qemu-devel@nongnu.org; Thu, 02 Jan 2025 05:03:56 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tTI3R-0006i8-77
 for qemu-devel@nongnu.org; Thu, 02 Jan 2025 05:03:51 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4368a293339so73993575e9.3
 for <qemu-devel@nongnu.org>; Thu, 02 Jan 2025 02:03:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735812227; x=1736417027; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gmi9t5Hr2PyM0Z7P9N6nRRkJ25K1LZ2uGASUBS+KL10=;
 b=nz8uALZ6ZRNc81QAM+t6+R9g6BK4n0MA371kVB5EHj6LvaFR4AiS3nVXVwxQuawUE5
 hxACDDfgKkGwSyCL+7LfIEiCoHryBKMEZReM5wlAEwL6INUdysQIxAPHTIYfZxSQK3Pq
 d4EuOQZbtI4I3xgr4MCM3ZUr310wtkf3+ZN61dhUFSrybNGnvdpdV0EW05DoI2TsPYJv
 RF3aSX904wUo3enoR8dxSzdTWZuy4OLPKEED29ib03VEA3UKlrqQrN1M9mkLfs0UBIQ3
 Nt3XzBLVou4fH9wjxDRx1sg5YFxm5oYy8pOxb5oQcEi1qyIY71bheAv8tEpcQpTc6Eoj
 jTyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735812227; x=1736417027;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gmi9t5Hr2PyM0Z7P9N6nRRkJ25K1LZ2uGASUBS+KL10=;
 b=AuyZfscw5ZfBGMZr0KEUTjQoo63rKngRtz9RLWGRCFNp3I9ZnheoHVAs++uJx9IF0V
 JgZ4JMzx8eNJOXsTKyKbQcfBicetGUpm4IqH/wARFsGq5ZKIMIcg5E/OIZR5lG+XUqQf
 osdDm4LpAW9fHKGA3EfB/XxwJ6XabpwkUzKwAWkELnF41ESLtaspuAkz0rcRO4a32t5P
 UWCJkEM5hbeUiKfylpbOKsK/za+d7CcG8LefNw+hl1paswgBM1IjhFvLgPAgBp1pIlos
 tq9MMPVjb4tq5s3vF1vAAEtXv05ohBqb4Nuu+SwC/7UwNb0FGlYGVMrTRAGZAWWTmqGO
 z0ug==
X-Forwarded-Encrypted: i=1;
 AJvYcCUN+Eyhm44jH/n/4JCuwrclRkQuDKpjKAEQTApWJ9gSPrEDNUDhJdnosf5fFMIh2BKabL6nRS86O8Sw@nongnu.org
X-Gm-Message-State: AOJu0YzaXTtbFd/cAar1HL2Vmd6apat1kagbPXO3AlZu/L6Mc/C/fK09
 6vXxy1h6ZnO2CH7rhkxIS6OYKbZTM789VWp2rpINz3bbF0+Ro+M3WpnnbWtOow0=
X-Gm-Gg: ASbGnctSfrIaRyPJJbf2DExebGcgS/X4JJL7cW/t/DMmgKvlJBKPJNOkygoDri2Nvuk
 bEvLyifF7EJBwePf09uJDYT4Gu/w+EBA2jnNxG2kSSM+OUvVmmCYxq7g45uMijO20CiNc2HO2cp
 yE2PdiOAi2JZL1w3gCzltx6afQEAOrRfoUQq8kiL97mB8rbnm9+LSsxEutbdeLWvvIVYK4hgfzp
 DkLr2jPVxsPS8a1nQo1SzLq7e1X2mgri0X/RThFLlP2yhiMO6yWvgjI9c8OaXbBH1XqWguIFIjk
 5S2rScFZGegWXSh/K2+gSIK8QlBO3G4=
X-Google-Smtp-Source: AGHT+IHNmMg/s80nCAWvjUYlY0SWe2ZYC2viGyzcf2kG5XQOrdvxY6pzIukFtFpG/vtn5DJajEytCQ==
X-Received: by 2002:a05:6000:4b10:b0:385:f470:c2c6 with SMTP id
 ffacd0b85a97d-38a221e21a9mr39819960f8f.11.1735812227503; 
 Thu, 02 Jan 2025 02:03:47 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a1c89e375sm38350294f8f.73.2025.01.02.02.03.45
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 02 Jan 2025 02:03:47 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Thomas Huth <thuth@redhat.com>,
	qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>, Helge Deller <deller@gmx.de>,
 Fabiano Rosas <farosas@suse.de>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-stable@nongnu.org
Subject: [PATCH v6 1/2] tests/qtest/boot-serial-test: Correct HPPA machine name
Date: Thu,  2 Jan 2025 11:03:39 +0100
Message-ID: <20250102100340.43014-2-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250102100340.43014-1-philmd@linaro.org>
References: <20250102100340.43014-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

Commit 7df6f751176 ("hw/hppa: Split out machine creation")
renamed the 'hppa' machine as 'B160L', but forgot to update
the boot serial test, which ended being skipped.

Cc: qemu-stable@nongnu.org
Fixes: 7df6f751176 ("hw/hppa: Split out machine creation")
Reported-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 tests/qtest/boot-serial-test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/qtest/boot-serial-test.c b/tests/qtest/boot-serial-test.c
index 3b92fa5d506..7759e8c9702 100644
--- a/tests/qtest/boot-serial-test.c
+++ b/tests/qtest/boot-serial-test.c
@@ -185,7 +185,7 @@ static const testdef_t tests[] = {
       sizeof(kernel_plml605), kernel_plml605 },
     { "arm", "raspi2b", "", "TT", sizeof(bios_raspi2), 0, bios_raspi2 },
     /* For hppa, force bios to output to serial by disabling graphics. */
-    { "hppa", "hppa", "-vga none", "SeaBIOS wants SYSTEM HALT" },
+    { "hppa", "B160L", "-vga none", "SeaBIOS wants SYSTEM HALT" },
     { "aarch64", "virt", "-cpu max", "TT", sizeof(kernel_aarch64),
       kernel_aarch64 },
     { "arm", "microbit", "", "T", sizeof(kernel_nrf51), kernel_nrf51 },
-- 
2.47.1


