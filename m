Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79F09C3ABA5
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Apr 2025 15:40:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9n3R-0006hm-Ii; Tue, 29 Apr 2025 11:39:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u9n3B-0006Zy-VW
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 11:39:22 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u9n39-0007ah-N1
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 11:39:13 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-43690d4605dso47555255e9.0
 for <qemu-devel@nongnu.org>; Tue, 29 Apr 2025 08:39:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745941149; x=1746545949; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=e8K6kEID/otFQGFpZ6THZdlNxB8rttBD3fHPnDNJPs8=;
 b=qr8Am1ht0Ojes9r+9LuzAuhIUuY7LeB9RJA8wqu9whFjsnN7f1F78IxfFSuthDuDCl
 kTAIaERkNyLWuzvv/VpPXtFeam1lEvlDVy/StKgZH7Eek1VN7+qToNzyB++GJlPiy4GY
 Xt2eDUGGku2q4R6CzAPukx4wgqguCWFbyn2i8GtRsDGxOtoFpJvpqoMsH1n3tbCWZG/j
 4Ii5tWeSbD6UHSBvY8edWI8c4RnHWh8uwg5jmrL15UA7TY5tvk2feH6aC448eikJ3yWG
 MjezmerRlvm3ofmorr9KILporQK9MldljnsghZVCX/mQyzVuygKpeAQtU/DEYmjP7AEY
 /pcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745941149; x=1746545949;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=e8K6kEID/otFQGFpZ6THZdlNxB8rttBD3fHPnDNJPs8=;
 b=FKXKRHzmjFLl5NEJp0aVOWzDYEbjZ/W1rAMOBlJ0UXFFZ7OqlYaZJXkhSPq0naUv/3
 wcXqWI8YK+rnmDuD0It7hHkXxr5ZU1iGBV0lYDCsfo9aNrebpAsyAs4oiqLHZwDrkXGr
 h7qeT2a7zRfAmV7mlK4qSgnypaqahgn3M5npPazaynJb+hLwiyTwctvm05LOTiMcOH57
 eiMYm2xm4sds2p2+aC89tEW5ctfeaiKWbMKHK1Ysd39NWZHO34XLygSDFMaWx7NMyjvQ
 urgnaJXh7L6VmNlVCMYL4pHS/4avhIlVdtw6raevOSbnEM5iI1ca6D8kodMi4yIB8dSD
 7UAQ==
X-Gm-Message-State: AOJu0YyKwQTjeO1AbFmLE4miBgHYYQ27SDqInmoC4IFZamxW8pRL8NTs
 ABwC6OkXzq+UBjMaCT7mCsjhQVMr0o6acoWkK5dbRLsYq+2NrdUggcHtgnZyBpnOaeyhhCbBEk4
 e
X-Gm-Gg: ASbGncv5eZeJkXk7PV/mnbDIxYYK+WhZKKr5wGmf0SccAij2rlxSR+FWJNsr2KZm23q
 X6EmhzGXSzVCne91WEalK1TVkgeSljE7uiTGBx4ZCESdcjmUe9PTcv9tszBitroE+rJcix9zBgE
 odv5ua0+4f36R0iAKYC0+UDLFqlRU960wCp1GzZQ+8Su/sZpF37TwnyT0bkSye+qAbLGbgLYGMS
 Dx++3S0uS0HwaKJ5IqxXCIHZEft+N9t4rIXf8afl829hUaB+WlU60PKbBaxTGnU5p7V+PkywGWX
 KMnCP5sasdEPMnMN5M6C/8gbIgu0ggCVnOkmMbxw6ads6KIx+PchYCZOFlH2GGRwNv1rymtIeaH
 SPGJabof+za/jX+79c8aJ
X-Google-Smtp-Source: AGHT+IE6Db6AyeWPRg+ygxXO8vPHQEWWsScrNVjpbeToecX1+KBXLq8z0JekiIlAXOZVlV7e92ZtQA==
X-Received: by 2002:a05:600c:1c8c:b0:43d:9d5:474d with SMTP id
 5b1f17b1804b1-440ab65a367mr89213395e9.0.1745941148941; 
 Tue, 29 Apr 2025 08:39:08 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4409d2abdf7sm192118995e9.19.2025.04.29.08.39.08
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 29 Apr 2025 08:39:08 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 0/4] hw/arm: Remove deprecated virt-3.0 up to virt-4.0 machines
Date: Tue, 29 Apr 2025 17:39:03 +0200
Message-ID: <20250429153907.31866-1-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

The versioned 'virt' machines up to 4.0 been marked as deprecated
two releases ago, and are older than 6 years, so according to our
support policy we can remove them.

Based-on: <20250116145944.38028-1-philmd@linaro.org>
          "hw/arm: Remove virt-2.6 up to virt-2.12 machines"

Philippe Mathieu-Daudé (4):
  hw/arm/virt: Update comment about Multiprocessor Affinity Register
  hw/arm/virt: Remove deprecated virt-3.0 machine
  hw/arm/virt: Remove deprecated virt-3.1 machine
  hw/arm/virt: Remove deprecated virt-4.0 machine

 hw/arm/virt.c | 28 +---------------------------
 1 file changed, 1 insertion(+), 27 deletions(-)

-- 
2.47.1


