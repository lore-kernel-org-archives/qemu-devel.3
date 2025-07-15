Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5030EC83F22
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Jul 2025 06:27:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubZ1Q-0002di-EU; Tue, 15 Jul 2025 02:20:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ubZ1F-0002RR-Gg
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 02:20:01 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ubZ1D-00075r-Bb
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 02:20:00 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-45600581226so29984625e9.1
 for <qemu-devel@nongnu.org>; Mon, 14 Jul 2025 23:19:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752560396; x=1753165196; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=S2++15hJzvyf/oh1q0RtDm/VcHzR4ITOplPRpy1k7FQ=;
 b=ukDjIMrT9KKKD7dSmQY0F+tm/6bBQ7Sqb/yURqxFDL7vGdbkaDqdjroiLKZ71O1FNk
 z5TRgObWrmCziIRnFUka2sKVbtzT+Or3NyqTc2+KRJq8153EeF0k4DBO6peQjUhYsH3H
 1GEDS8QiIlipKXYFsdEx8/+bF9jFJS58tkaBpe99uRdhtNjRkfrNn6RlGkhC3B3FF08E
 pCepd5FMKkBfbv7/BQeshxfzn0p0yLmrqJ0Ua6KWPnV5GNVDHb5njgbgmotx79st1194
 CTKCPdtABel37yWNU4RcjkxihN3rpbgShTjKgMhILf8kCIWUhJ2IIs5VCxs+zJClw2xl
 y2Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752560396; x=1753165196;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=S2++15hJzvyf/oh1q0RtDm/VcHzR4ITOplPRpy1k7FQ=;
 b=uui73O9Bsx1MUD1wntXRyCdKgH1oalztTBSXf98TeRGjoeXyPn5Zw1PAIoS96go7SF
 mJszCDmkQo6W9X0JX9GrH3y0z/WRM2v0VQoC52A4KbzikmIz1Foo+W83CZ3egsBY/HEu
 HC/uhvkCVdxiDvOtsU4Iv2JGAJoKhxoFcDpVQJK2wiXY45EKCxLDWY2dH3Laf9/jssp/
 plnLBD1Fg7voJubcfM1IbA55Pe8i0zfzmUamcMxyedRrwPNbDkni6z9fGn4QJlkcmomp
 JQtOAUA5HGifwH30DNxgIJurDOgxtNLYw7mWCxUrHkkJ6xYG0tMU64GNAiwCnzNAUHTv
 D9Sg==
X-Gm-Message-State: AOJu0YypiOK3FMuPMQc5bDcALAFsIbPBTMAfqcVdGX3AkxPeVgr7h0dJ
 3t7slWCfPhaBXMG0nH0whLdtWTi7j9Jc5WyFY9x+Fnh0vQIoIAcPQlBROe9hAkp5/rk2Tq88hu1
 O+Ysc
X-Gm-Gg: ASbGncuhWV7l8XdoLctZU9D1d6+cQCavLy4GVeD6sQTeG8N+I+ruHAf82lYfNhNrgct
 Tqz/U6qwLhDBoCxLOk0sKpmr2zkfo55XXTPk+yI13oatF3MavWwX12ccDJGzEmNV/6TI5JrQNGf
 Q62Nnote3MULsBtrc0LyDbEbY/hm6sdPxxsReChKrYPa7K5NPMY3bJQ+XnRBYQUN+d8j/acqK0e
 zRPJuKNxNwmDFPGEQ89cB0WcmDJ6GvJSJLeNDq48RyOxZymYNS69z+F6WHMwZOHiux+XAR+3Cp+
 xm1xwdpcavGoRIX86B6bgHKs1sCRYacKoWpQ4yvXXqVGqzGT8CAlYMuC0RWhsS/pfaSPJUdJKuF
 /vf4IInhqlWGnhH81+6WsM5iP+aOmqvjB8B28itUu/uXErffuR6WAmS/j2fE7UcSpXftGSgrE
X-Google-Smtp-Source: AGHT+IEGby7bns0UgwBuSb6fXgaxpe/aW6Jt7wqCS2A6VIAcfwo1n5Xtpl+uif1jDJtPmPvJ/PDc/g==
X-Received: by 2002:a05:600c:3507:b0:441:a715:664a with SMTP id
 5b1f17b1804b1-4562741795bmr9891065e9.20.1752560396090; 
 Mon, 14 Jul 2025 23:19:56 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b5e8bd1776sm14452975f8f.12.2025.07.14.23.19.55
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 14 Jul 2025 23:19:55 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Cole Robinson <crobinso@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Helge Deller <deller@gmx.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 07/17] roms: re-remove execute bit from hppa-firmware*
Date: Tue, 15 Jul 2025 08:19:07 +0200
Message-ID: <20250715061918.44971-8-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250715061918.44971-1-philmd@linaro.org>
References: <20250715061918.44971-1-philmd@linaro.org>
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

From: Cole Robinson <crobinso@redhat.com>

This was fixed in c9d77526bddba0803a1fa982fb59ec98057150f9 for
9.2.0 but regressed in db34be329162cf6b06192703065e6c1010dbe3c5 in
10.0.0

When the bit is present, rpmbuild complains about missing ELF build-id

Signed-off-by: Cole Robinson <crobinso@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Acked-by: Helge Deller <deller@gmx.de>
Message-ID: <52d0edfbb9b2f63a866f0065a721f3a95da6f8ba.1747590860.git.crobinso@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 pc-bios/hppa-firmware.img   | Bin
 pc-bios/hppa-firmware64.img | Bin
 2 files changed, 0 insertions(+), 0 deletions(-)
 mode change 100755 => 100644 pc-bios/hppa-firmware.img
 mode change 100755 => 100644 pc-bios/hppa-firmware64.img

diff --git a/pc-bios/hppa-firmware.img b/pc-bios/hppa-firmware.img
old mode 100755
new mode 100644
diff --git a/pc-bios/hppa-firmware64.img b/pc-bios/hppa-firmware64.img
old mode 100755
new mode 100644
-- 
2.49.0


