Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F9DCC5B555
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Jun 2025 19:36:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uNGNa-0006hm-3y; Thu, 05 Jun 2025 15:35:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uNGNO-0006gO-Oj
 for qemu-devel@nongnu.org; Thu, 05 Jun 2025 15:35:47 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uNGNN-00015N-6k
 for qemu-devel@nongnu.org; Thu, 05 Jun 2025 15:35:46 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-450cfb79177so7441505e9.0
 for <qemu-devel@nongnu.org>; Thu, 05 Jun 2025 12:35:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1749152143; x=1749756943; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ACcXdrmAYYNSlTqlDqHpslwOf43nPNTD1Sa9tjGMI5o=;
 b=tb+gOf8yyzSgEbplq/aOHjCFzqleIzyjdAUJwgV96kgD7hSEl3fXmxNKebTr9NBV1/
 csJ0MmTP5vsV62x6M0G0CwYLmXaqBPq7e35OQUTQTpITyHMEmMkR965iCiwdTRVofYaS
 YpMLIUiGmMbPqhxTwWI9PNE0Dcq6RlwVzYM/sCmeqWvGRWRUFPFxFggIEy0VrHf1L8zn
 9C7rAgTSasp5swFJAcYi2LolWcOILpS7EwjQ9yXIRD9qo2Z7Uh07clAYkz2VWc1O3W/d
 afDLWMDm7QQkNjYeKrB/jGAaT0qMMUyX1I1Cuh+3c5LRYed0JmF37wMHsmQHjR4jxpZu
 kvlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749152143; x=1749756943;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ACcXdrmAYYNSlTqlDqHpslwOf43nPNTD1Sa9tjGMI5o=;
 b=sIo88sZFJkgaJYGQVG9UeApTRa2TYKxTfUdzmDCTpjFkqZYlT1KFBgDs/teUWOlajj
 Ks4U8w5zUOwOX01e8dNnxqWJKqXBpsycZLRXRlC12z2S7xfVakjvL9XMmVt1PCiy+IHg
 flvpEj97UhHgoUMJrYR6IbbYt955AfoafTbZXiritMrjXxH5OhDdmgUeUfAX8pU7BFmE
 YkjnY2JjytinFehE0Q3koNYYJ9WUFh10oOVv1n9b9Ovt6wlx+e0iEb+Lb8GfWAxwnucE
 zX3SXJqtMdTA1PhsitGPdsSVMv+epeWsLip2vV03Z+WbGjcZpaCf0MaHbZFcpd1Igi5I
 Xrrg==
X-Gm-Message-State: AOJu0YwQPUpNUyGJ5l0tM+1lN9K6hoc8DX5P1XgzTtrUqqJVBJcbWV8k
 QAyjg66jmtgAOgw90eXIAku1K2sCPoYYckCV6ZQecZkNsXAwnP/Ol+PP7BeavdRa3y4IMxyNfji
 aTQP1F4U=
X-Gm-Gg: ASbGncu8VXuBs4YIVLL4Q8oHeffU3bdwT42tfWyoZ8GipZUPkSvYgNAZS84za/EsOpP
 muGWpjO9ZWKD8aKWmhzFWaF8OsSdCHyzAVkdaYXuoWjs1gv6h0M1atA8vQG1lmpyUlARbJtMHrp
 xYCSY7dVmDZwnqciS0U+37P7lpMnR2KODDtXc0XliCLV49S/LfwD5rPUVrFeIP65WoodlqBzbk0
 fG64eygY9VTUchnrAzPrvi6hgU29agPBjlGIvlyKLpVyxbH0zeWMR4aC13Q0BqrWlYjCVZynUap
 xmT+OQJ/OCtQDVdnezOjcg/kKX8qdWjA/9VXf06zQK4eOnHvuT13WmZv+xudvw+7TG/KetauwZA
 CV3ItOs4uYKH2OUSGc5WxXhjXTg==
X-Google-Smtp-Source: AGHT+IEuKt4XcWyk0bz/icZ8vtPJix8QUnKQptc0D8ioDsf844EYKuKL22MgvZaPiro4IXFu8m0OiQ==
X-Received: by 2002:a05:600c:6989:b0:442:e9eb:1b48 with SMTP id
 5b1f17b1804b1-452014977f7mr5652195e9.24.1749152143192; 
 Thu, 05 Jun 2025 12:35:43 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a5322ab845sm76228f8f.24.2025.06.05.12.35.41
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 05 Jun 2025 12:35:42 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-arm@nongnu.org, Glenn Miles <milesg@linux.ibm.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 0/4] system: Forbid alloca()
Date: Thu,  5 Jun 2025 21:35:36 +0200
Message-ID: <20250605193540.59874-1-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

Eradicate alloca() uses on system code, then enable
-Walloca to prevent new ones to creep back in.

Philippe Mathieu-Daudé (4):
  hw/gpio/pca9552: Avoid using g_newa()
  backends/tpmL Avoid using g_alloca()
  tests/unit/test-char: Avoid using g_alloca()
  buildsys: Prohibit alloca() use on system code

 meson.build                 | 4 ++++
 backends/tpm/tpm_emulator.c | 4 ++--
 hw/gpio/pca9552.c           | 2 +-
 tests/unit/test-char.c      | 3 +--
 4 files changed, 8 insertions(+), 5 deletions(-)

-- 
2.49.0


