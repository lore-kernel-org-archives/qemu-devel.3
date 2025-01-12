Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A5FBC02181
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Jan 2025 22:22:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tX6Jq-0003g9-VF; Sun, 12 Jan 2025 17:20:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tX6Jl-0003DI-6S
 for qemu-devel@nongnu.org; Sun, 12 Jan 2025 17:20:25 -0500
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tX6Jj-0006pO-AM
 for qemu-devel@nongnu.org; Sun, 12 Jan 2025 17:20:24 -0500
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-3863c36a731so2642931f8f.1
 for <qemu-devel@nongnu.org>; Sun, 12 Jan 2025 14:20:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736720421; x=1737325221; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NrAERIRi/4iWN1y29jrfSTmeSOjPW3PD2Bfh20J+jkc=;
 b=eDeWCywkFmCcx+e0JWUXJ4h5HYHNsbZNk5gtKor7b9i2I0NKeXpVTUELXGBiMurfZz
 Dl2OAcf00mRnGUj0iW4xYxwGmGzdwris2aQi/FHFPIdCvsItZm3YBQr9MZzgDOEzNLAx
 xdadFUlRUTjntkjCpxpHagBf2B41JPwqp676e9Gel6WDcqecpozFFF0sxoFXixz32XAn
 bP/5wGKz27DnjYpSxsJEiz0qWQ2TQiVa98ZBdsKHQM+yp0rZncI7FMqogHnZekY88m+K
 e+Qq5y7Q48X0SpLksKYyVWLmPtXKy9N6GUXnX2zyWAkgwQnJIP10iCl3nutZDSeg2Ga+
 eD9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736720421; x=1737325221;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NrAERIRi/4iWN1y29jrfSTmeSOjPW3PD2Bfh20J+jkc=;
 b=ahR1RJ67ayv1QVJjJjJj7tr0UckxOwvm3IcIyhzp05lHqqpwE7ZcDUWAnN25/ypdKP
 D+OPKlfEBA2JH18q9g0MvohSkzBKhKM5M9s0eVLKzaNA5vAfR//ghbEsTO79jEk3lM9G
 wUAUAeDdNmV5pjF6HRRSxaShZu+DWrUcQbiw3CpUWYWL98f2XS3uVv9znwymXi0+5+je
 ZEFlg6m24g0QR2/LVfNjdwHcXZT69fFGTz2pkAbSWujVh+rdBJrGenbcXxnqO0ZXIo1G
 JwRHmWh40vROy9U6CdnXQmNhV3wcBGBzgicjjiJBXqX4/tdCfQEUQVj0TL7l8UoCZaW9
 sjnQ==
X-Gm-Message-State: AOJu0Yy2JRMpD+trj+Y72TEI6HlD3UXXEfwB6dO0yNn8pK5Mkr6/UA1k
 5Be9n4g+eoP6fQwLpj++qv5jg8fItOS7gRMV0NSFsVK8DMhkz2uO3X5xbKIoZZ0yRdy3WdoF81C
 P/50=
X-Gm-Gg: ASbGncvzhXi05sTKhtN9jCVGHkfTzSsXZG9QJMLFkIULajn5u3WSH2srFF4lxXeSIUP
 VhghgyrsqbaB0sr9sUqBDt/QMsBUrSvI8AOLWUyA+wvgEQanLRmyt3owGYATONpKkuAsdSKjWX0
 y86s9NX0GUpp2BC7QdmMmfF9t28ik+XsEwQIZIPOXxieKt+XLNVU8befodERJoNBX9md+qWeycr
 njdQYJmKwMtET1+IbNnMqJOicYws4ihUXedxyiRydx5wrI6on4hn7x7LgCo1zv4FPM1ep2pEHCY
 0Kji8TtWiKwXFZajhXTsjJJw/+tXlJM=
X-Google-Smtp-Source: AGHT+IEpxrIx7c2tZbI+AfiE619OlGm9RjJHfwNfOXKDxMFROfRwGYqjiIUU8F5gSbkk/v30BHdQYQ==
X-Received: by 2002:a5d:584f:0:b0:38a:68f4:66a2 with SMTP id
 ffacd0b85a97d-38a87312bdfmr16851999f8f.31.1736720421419; 
 Sun, 12 Jan 2025 14:20:21 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a8e3838a3sm10658965f8f.33.2025.01.12.14.20.20
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 12 Jan 2025 14:20:21 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-stable@nongnu.org, Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 35/49] tests/qtest/boot-serial-test: Correct HPPA machine name
Date: Sun, 12 Jan 2025 23:17:11 +0100
Message-ID: <20250112221726.30206-36-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250112221726.30206-1-philmd@linaro.org>
References: <20250112221726.30206-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42f.google.com
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

Commit 7df6f751176 ("hw/hppa: Split out machine creation")
renamed the 'hppa' machine as 'B160L', but forgot to update
the boot serial test, which ended being skipped.

Cc: qemu-stable@nongnu.org
Fixes: 7df6f751176 ("hw/hppa: Split out machine creation")
Reported-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20250102100340.43014-2-philmd@linaro.org>
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


