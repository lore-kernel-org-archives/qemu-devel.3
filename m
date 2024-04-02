Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF9C9CD1284
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Apr 2024 11:32:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rrcMC-0004Nj-GU; Tue, 02 Apr 2024 07:31:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rrcMB-0004NX-68
 for qemu-devel@nongnu.org; Tue, 02 Apr 2024 07:31:11 -0400
Received: from mail-wr1-f41.google.com ([209.85.221.41])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rrcLU-0002Qk-8x
 for qemu-devel@nongnu.org; Tue, 02 Apr 2024 07:31:09 -0400
Received: by mail-wr1-f41.google.com with SMTP id
 ffacd0b85a97d-341b01dbebbso4509663f8f.0
 for <qemu-devel@nongnu.org>; Tue, 02 Apr 2024 04:30:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712057420; x=1712662220; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=VWutY8z9bkN7X3i9ljyrwrRwmS6njDciQ2k14IDKqCs=;
 b=rWbibbC83i0UNS+P1PzdY2AZ9QGuGQ6UkShjVYrquuiSuT+9clngniZYWUf4jiXxo1
 xUZ9/EerrfTlURMoAV2t0Bj7KRHFqMENX2UK1InR/pHyh0DkMBtrIQNZsDWEvXg+hMcE
 dCpQRsbaMr1i6pOhImz+NKg2m/u7BiGLDGKArzPTv+BH5rOLcFbYn/6OhRxFrJzCVJmL
 4yGKkEv+EnvstjO/LaZLT2pQlgPd5MUymwyjslkZO7m8SPNLPYEiLqVLM7GzuRu2dwAS
 crx80+S6/cULqDJd/zBAhgmcWkGZb6oLpHSIhZq29Vej15PTef8CeHkszU8GdTh6N7c3
 svAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712057420; x=1712662220;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=VWutY8z9bkN7X3i9ljyrwrRwmS6njDciQ2k14IDKqCs=;
 b=IGL/T3HCPiephma95xbdkkUQOVPd7IPIWOBK/oKKvU/1vEAEVTAUGMOt7VKJPjVjeA
 SGxyOrEHf/NNBVAupqeS5He1bTRifRCyjKOktq6Ji7w49G5fDoZGVoMqzfIFGBX54+Y1
 cLgctd9HuzdbZqGrgTINEYnBaqx44NxHhcNqs3Cruwk0BOeQrBZaq+m5JmXhVkB1J8AU
 JjM9+8Ecb57d7ekpRTOzjFr92EeQ4xjyftDiCKy39/CuDvT9kbslbmzcFjH0FF6s87Na
 9+dRFQ32IhKdmxP+11Vgmn1DJEmqxY+9v8LgC+zUq9H5X3Uf/KiuIa51nuxVENosS4Po
 WBag==
X-Gm-Message-State: AOJu0YwDYGqQo55OIFmPaE5++Ab/DkEKJ5n/vMmWjUCIF+a+UJ69vqWT
 nLgd+mwaJwJJgknJETIYpFp/0z5rSr2t11sgUOqKwOdAFOQsM/imxtK3gVqlkOfbhx6X9UV9Ovb
 jijU=
X-Google-Smtp-Source: AGHT+IEQsg21cB6W9vrfwrwLITswJ7VcBzCSo3sy77cqGUdeuomccEaiW/O+xtz1TxqFimULyCkwuw==
X-Received: by 2002:a5d:4c44:0:b0:341:906b:3351 with SMTP id
 n4-20020a5d4c44000000b00341906b3351mr1302992wrt.0.1712057419779; 
 Tue, 02 Apr 2024 04:30:19 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.202.91])
 by smtp.gmail.com with ESMTPSA id
 bo15-20020a056000068f00b003434c6d9916sm5496356wrb.110.2024.04.02.04.30.17
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 02 Apr 2024 04:30:19 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Michael Tokarev <mjt@tls.msk.ru>,
 Stefan Weil <sw@weilnetz.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, qemu-trivial@nongnu.org
Subject: [PATCH 0/2] scripts/checkpatch: Do not use mailmap and check
 qemu-trivial@ author
Date: Tue,  2 Apr 2024 13:30:12 +0200
Message-ID: <20240402113015.66280-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=209.85.221.41; envelope-from=philmd@linaro.org;
 helo=mail-wr1-f41.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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

- qemu-trivial@ is not checked
- mailmap hides the mistakes we want to catch

See https://lore.kernel.org/qemu-devel/60faa39d-52e8-46f1-8bd9-9d9661794880@tls.msk.ru/

Philippe Mathieu-Daudé (2):
  scripts/checkpatch: Avoid author email mangled by qemu-trivial@
  scripts/checkpatch: Do not use mailmap

 scripts/checkpatch.pl | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

-- 
2.41.0


