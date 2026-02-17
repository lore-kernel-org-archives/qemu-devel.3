Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74ED3E6815B
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Feb 2026 09:58:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vsHps-0007ix-F5; Tue, 17 Feb 2026 04:57:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vsHpr-0007ib-GN
 for qemu-devel@nongnu.org; Tue, 17 Feb 2026 04:57:39 -0500
Received: from mail-ot1-x32d.google.com ([2607:f8b0:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vsHpp-0001Cu-PV
 for qemu-devel@nongnu.org; Tue, 17 Feb 2026 04:57:39 -0500
Received: by mail-ot1-x32d.google.com with SMTP id
 46e09a7af769-7d18a9d2b1aso3710652a34.2
 for <qemu-devel@nongnu.org>; Tue, 17 Feb 2026 01:57:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771322256; x=1771927056; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=eEX9ymO65QuTU4jpBkZ1UxQXc5p//uJ4DsnmCRgXSR0=;
 b=RxoietxMuzDeGCT5oFc4tr8ty94te4h/K8nk8O69O7GuivooM/HRJRVr5kyqRTUPWH
 zJ4M/TTTZVqgLYIlEFEzAIMEQbIYpXXexknvnONjFx8G0Aa8lbzKMAbXr0e8e4OGpBkM
 zU82y+0LdMDNPrQzm1mfm4dUNWi3RXDOyakCIxUu78leKQM5I2Dnd+eztmwebeXO2h31
 9CbxFYbBRjVLqBdGVVWK4fHeqQQEVh961y/2h1HFWsSvalJtVy0+KJfi1pDXmc0bBw5p
 cAT4L9+HvO6v02Bm2EiGAKPiKOSeuVxqK5Z6u4C6shtSSJ6/0K3TthXs+6X0SV7tsalM
 WceA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771322256; x=1771927056;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eEX9ymO65QuTU4jpBkZ1UxQXc5p//uJ4DsnmCRgXSR0=;
 b=hShRupBc56KB+haAEX3ZD2piF0tH7rbHruEZzgeRXsG3dklx0Poxu1HShEfgkRbQjb
 YjT/7V0O39hXAzJguX2YFk5AJMy9cMQnuh+konuxOUaghhU7FTkkz7sXW0tLaNeSP7Dn
 gAtwu5hkH6tBNMqC41tCuhJIlp3DWptq56698TXZBAUDn4zHGM5gLYH5BKWR4COBkL4n
 9Ku/rBG+X32fhzhGf6SEtejiZ9msszGQ215YFDvkXR5nH6XikW84lqAVHbzoe88wVMR4
 T34gBMaasmIw95+Mk/sfWxo38U8RYhamO3F1MXR36z/q3hTFONHHHcpRYVjPU2YHuDje
 EaoA==
X-Gm-Message-State: AOJu0YzUV8qdn6GyM78xOqtIDNsa92PU77LnbIktOs1Aqdr7YmAFjQt1
 XMtNRJp4zckhVHCEupJiGyaVUbVAS+AtogeYRPMfkJ0R2q3GrFK+RAakfit8scJqqVgCe9/MRFP
 U9nuBpAw=
X-Gm-Gg: AZuq6aIEHPcl7/iDeHHXS4ZtrpLOhl8h6ypMnLv/eMio6eOQOGhJ8OXXuF9uMD9m1YP
 Imu8psK5jbIm/9pTTvzBiTEAkd6ihLmYyU0Il5pU6b0AQ0dgl33/NtiTXFaX2bUT686RmryVKVz
 NXPty2LWB4gFJsL9UveDCHgW6iaXLiFgwXltk9Iv7AlwFp366uZQiJ+jfl1WGXfQJP4gyVbkeUj
 XRTn6m+3L7hjDBNnS5mgQH1O6gUgsAEzRZEt/oSjOF1fwzBtIvosjj8u/WkeAqzpvteF3kxGogP
 2prGt1wMXYvEYrLRwZTCSU0BwKszNNxfuqOGWw0m8DwzEA5Nca6ug6/KjBTWNpFRt42jG7fdJ4c
 Wvk63yIil0T6ZVcSjY7xVrdOHi6nwDs/ESIuNHyQXDHPqJ+tu8Yr8Qenoxz51hX98SGWgPj8COW
 IoqPJ4HGKFXSQnGiGPeJZLrFYw/8Tv9TetHzB8HYPRig3SzC64T5mSRzvGG501+qaZGxCraYckS
 oaDOoD7yJCEcUpNLyogUptqST/N1KQULzknuYE=
X-Received: by 2002:a17:902:d591:b0:2aa:e3da:52b5 with SMTP id
 d9443c01a7336-2ab50519ee2mr115665065ad.9.1771321872346; 
 Tue, 17 Feb 2026 01:51:12 -0800 (PST)
Received: from localhost.localdomain
 (2403-580b-742d-0-10a2-dce1-aa4a-dd32.ip6.aussiebb.net.
 [2403:580b:742d:0:10a2:dce1:aa4a:dd32])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ad1a6fa33esm99108675ad.13.2026.02.17.01.51.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Feb 2026 01:51:11 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org
Subject: [PATCH v2 0/7] page-vary: Build once
Date: Tue, 17 Feb 2026 19:50:59 +1000
Message-ID: <20260217095106.598486-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32d;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x32d.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Phil,

What about going a step or two further and eliminating
page-vary-target.c entirely?


r~


Philippe Mathieu-Daudé (1):
  page-vary: Expose TARGET_PAGE_BITS_MIN definition

Richard Henderson (6):
  target-info: Add page_bits_{init,vary}
  target-info: Move TARGET_PAGE_BITS sanity check
  page-vary: Build set_preferred_target_page_bits as common code
  page-vary: Build finalize_target_page_bits as common code
  page-vary: Build migration_legacy_page_bits as common code
  target-info: Eliminate TARGET_PAGE_BITS_LEGACY

 include/exec/page-vary.h          | 19 ++++++--
 include/qemu/target-info-impl.h   |  7 +++
 target/arm/cpu-param.h            |  1 -
 configs/targets/aarch64-softmmu.c |  2 +
 configs/targets/arm-softmmu.c     |  2 +
 page-vary-common.c                | 44 +++++++++++------
 page-vary-system.c                | 33 +++++++++++++
 page-vary-target.c                | 81 -------------------------------
 target-info-stub.c                | 15 ++++++
 meson.build                       |  2 +-
 10 files changed, 103 insertions(+), 103 deletions(-)
 create mode 100644 page-vary-system.c
 delete mode 100644 page-vary-target.c

-- 
2.43.0


