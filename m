Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7F2BC54791
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Mar 2024 18:51:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkTg2-0001YT-Mz; Wed, 13 Mar 2024 14:50:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rkTfx-0001Xz-Oj
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 14:50:06 -0400
Received: from mail-lf1-x129.google.com ([2a00:1450:4864:20::129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rkTfv-0003v8-F7
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 14:50:05 -0400
Received: by mail-lf1-x129.google.com with SMTP id
 2adb3069b0e04-513ca834ad7so270147e87.0
 for <qemu-devel@nongnu.org>; Wed, 13 Mar 2024 11:50:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710355801; x=1710960601; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=2uvg7pJFeMQcnPLMPf2nUqArdk7gKSBHY/6kmDxSVbs=;
 b=zKbuVom8E5Ehj9++mWQzupIomgmIPzB9ta2GbFi6TK7TXPJNh7woMUss20a+4wbcv/
 18U0cYnzAWbnjALLMANhs6L/u21qIWZmzV5V0GLVpoPdw7kY2fRkKVEUzrW6xWCyfVQX
 Gi/2tG6fS4j3LSaeGOQsMH6c0tumWNyJWRjJ2Lg0WHfjCmmqFRkLRd9UjoQhJEefiERB
 bamBgwRBGvv4ulckZI8iZZENgbzwigpj48kEtZoftoJ0HtAEEV7Z4NmzwWukUrOHJ712
 E5DjNY5ZNGSxLOYzxBcGPWFWpvnKV80oXKxBY4rBljJ1VCQPRaoGi/i19NflREKp3uIn
 dbag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710355801; x=1710960601;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2uvg7pJFeMQcnPLMPf2nUqArdk7gKSBHY/6kmDxSVbs=;
 b=FUYsow9BffR0np3ct/wJOtTjWJPxb/sHj75dnwRLEEk+gWMAILNDawtiq20ffoggkQ
 IrgsdIQ3a+K3qpus6x88wA0mvd1EFAK92JHta7eOsO68P76FDZb4kUTRdsLAbC5tXHih
 Cuii8Xilp0blq6YL5VRTBgG9RVLC4ArkXvC/R0zZRvAJ0wehphXooBXQwfJ4V9GzR9W9
 w8XM8lo/TEd439IWWewwVBo1zbHpj7y3EASWb5n0HHlULNUlkmrfKAre2TI6iYGADJoa
 gELyj7G/ck2TQeM72W+isUPkZEOZCjMEga/+iDalEUO/crXky6utc1YMCS1mNRBCqN1d
 WuHg==
X-Gm-Message-State: AOJu0Yzwl6k4zAter9unSaDG18te6wsGe1W42YbF5niHuxAzSum7kpGH
 jH68Ao2vpW99TVCweePJdmf0VNWhz2WtanTYMjFE1VFCvenkkWZnwqoKzh2LLte14nIz5z5+eTn
 3
X-Google-Smtp-Source: AGHT+IGd5oSOAY+51z1dpoBzCAMSQ7nNh4ZMyTYUDBI9tf4tfYJf62nh9LNKW4d2JKypejTXtL5Whg==
X-Received: by 2002:a19:771c:0:b0:513:cbf2:50b3 with SMTP id
 s28-20020a19771c000000b00513cbf250b3mr1061509lfc.35.1710355800790; 
 Wed, 13 Mar 2024 11:50:00 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.182.179])
 by smtp.gmail.com with ESMTPSA id
 o16-20020a05600c511000b00412c1d51a0dsm3088896wms.45.2024.03.13.11.49.57
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 13 Mar 2024 11:50:00 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 John Snow <jsnow@redhat.com>, Alexander Graf <agraf@csgraf.de>,
 Eric Auger <eric.auger@redhat.com>, qemu-block@nongnu.org,
 Thomas Huth <thuth@redhat.com>, qemu-arm@nongnu.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Cameron Esfahani <dirty@apple.com>, Roman Bolshakov <rbolshakov@ddn.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-9.0 0/4] overall: Avoid using inlined functions with
 external linkage again
Date: Wed, 13 Mar 2024 19:49:50 +0100
Message-ID: <20240313184954.42513-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::129;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x129.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Mostly as a C style cleanup, use -Wstatic-in-inline to avoid
using inlined function with external linkage.

Philippe Mathieu-Daudé (4):
  hw/arm/smmu: Avoid using inlined functions with external linkage again
  accel/hvf: Un-inline hvf_arch_supports_guest_debug()
  qtest/libqos: Un-inline size_to_prdtl()
  meson: Enable -Wstatic-in-inline

 meson.build               | 1 +
 hw/arm/smmu-common.c      | 2 +-
 target/arm/hvf/hvf.c      | 2 +-
 target/i386/hvf/hvf.c     | 2 +-
 tests/qtest/libqos/ahci.c | 2 +-
 5 files changed, 5 insertions(+), 4 deletions(-)

-- 
2.41.0


