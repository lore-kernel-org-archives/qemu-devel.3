Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D1BBCAC5B1
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Sep 2025 17:33:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1TLZ-0005dA-1I; Wed, 24 Sep 2025 13:32:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v1TLD-0005Y9-PE
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 13:31:50 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v1TKb-0006XZ-0q
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 13:31:41 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-3f0ae439b56so85448f8f.3
 for <qemu-devel@nongnu.org>; Wed, 24 Sep 2025 10:30:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758735031; x=1759339831; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=9lju0keDiyZCGy83UbLxiqv6iaF6N2xC0VKasEwFjBk=;
 b=jif2zo3K/q0zi55lGS3bN6Rfq62QnzT8JvayZ36zHBhpOanu2xdiVwrJwyCPBd1DOz
 V1U6HFmsUOQTVza3Y2/J4NkQgxrTlSfQwxFfADgt6GCFnzllkI9FqAnxWM7rByqXEaEr
 L6aaQW2kIBOVDsOBoWwmUzU/U5xQ5NTTTcKyO2pM+GyNR/EssSwCEGxhXYrwX3Mi2+Zo
 uZlP/GhKoOlalehv1R+RjBxIhz+HfpIXv2OzPAiaADYaNI4K2PROFqSpLl2ay1V2fPXl
 BLhytmArA6pBvtkVIEuJedylFb0uz45bgCRIFdXG3wcdpozdjm7BwQH+dl3kggIKCGbF
 aQkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758735031; x=1759339831;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9lju0keDiyZCGy83UbLxiqv6iaF6N2xC0VKasEwFjBk=;
 b=ok281EpvbMdSWIfPFMyAQGgUPwYaQloUbsqzlxUJ4zgSeVKIVzrCGXb3+TFFm7D4OG
 lRTMlyxUH3YBDdswcfM9MoBr38k7Jd+voOtSa9CnhDLOhdAEANaSeAYOTNd4SbOIe1VX
 PltXU8pvwpfkPhnP//p0BOXlq+LfkWb+W/zwiOjN0Rs1VWRCwrrnXNsP1iWJmg9MuvHt
 sHhmsjYCWGy5dn/TXCxQeyURei+PEDKfC+PDnUKoHbVftwR/919lOlji8hDNTioaACdD
 Xjl4EyHblYaz8JGtQIAPWR+L19Y739ePXdfeEyo8rhQKJq2EHWSsuSO0DavCvTmtmuJy
 FZxQ==
X-Gm-Message-State: AOJu0Yy9FxmfJV7USxAZ3QaLIdtakeWyEtzCD0G5vqunxjDl0ZhN+pbT
 q3yp0jg/p6QWb6uYqU7F4LE8/z+39P8nIKSKs9Z+tz6iWNdoO/P2uabFxX7wYgi7SIhbCwsQr+K
 ja0lmrL8iqg==
X-Gm-Gg: ASbGnctwX8KC6P//5VqJPDoZhiYTBUtEKwA0CXX3BBVjG/M52ttTvwq8mS3sBDFJEfL
 3ZA9QQpLbdKOSmRJXKE/KGPQmcBKCmpL6w5BTno1ISMAZfCjvjwV22HP4a0Wcs1FnQx7RrerJxJ
 k3ZtHEc+3k/wN9yr2OKdmebg9D/+4pNOM0UklWMjFPBS1hA50u2GjYywJ01esa4D+UoiJjYOgui
 ZP25Pr3oAvtF3i34m/Y1lelRWvL/fSeIO9dzbNT/hr5aLkrnIGKrB7MdoVR7b3b5EqIwUbQrKku
 GRzSfIUxmLZJGUnMJosamXrhOjMtp8HfBq20PxoaDCsODRB9HrUNI+wZN7IxvxVjNprvTWkmaIu
 6y0J5dmzP06Y5ryWfSoO+uSU9w5NTIN4cX8IhN/ka6PJ86fxVdaRCP1K6cA8P8SegawHKPJgl
X-Google-Smtp-Source: AGHT+IE2SlFGcUNLjysEpdgikzu2akvou/gLxUKIdgOUXkfaCjo/AYhMu7dXvMyjG+eEH9heeRqsQQ==
X-Received: by 2002:a05:6000:2511:b0:402:71e6:5e00 with SMTP id
 ffacd0b85a97d-40e447770c1mr626875f8f.7.1758735031032; 
 Wed, 24 Sep 2025 10:30:31 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3ee0fbefd5csm31113306f8f.51.2025.09.24.10.30.29
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 24 Sep 2025 10:30:30 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Bernhard Beschow <shentey@gmail.com>, Nicholas Piggin <npiggin@gmail.com>,
 bharata.rao@gmail.com, benh@kernel.crashing.org,
 Chinmay Rath <rathc@linux.ibm.com>, qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 0/3] target/ppc: Have gen_pause() actually pause vCPUs
Date: Wed, 24 Sep 2025 19:30:25 +0200
Message-ID: <20250924173028.53658-1-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x429.google.com
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

Probably due to a type, gen_pause() keeps vCPUs running.
Fix that.

Philippe Mathieu-Daudé (3):
  hw/ppc: Do not open-code cpu_resume() in spin_kick()
  target/ppc: Have gen_pause() actually pause vCPUs
  target/ppc: Re-use gen_pause() in gen_wait()

 hw/ppc/ppce500_spin.c  |  3 +--
 target/ppc/translate.c | 15 ++++++---------
 2 files changed, 7 insertions(+), 11 deletions(-)

-- 
2.51.0


