Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96C76C982C1
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 23:52:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6zQ6-00061l-U5; Wed, 16 Sep 2026 19:52:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x6zQ4-00061b-I7
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 19:52:04 -0400
Received: from mail-pj2-x0e.google.com ([2607:f8b0:4864:39::e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x6zQ3-0006b4-0z
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 19:52:04 -0400
Received: by mail-pj2-x0e.google.com with SMTP id
 98e67ed59e1d1-396ccb65437so173490a91.3
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2026 16:52:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789602721; x=1790207521; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=pxTheTmuEJVS5NQG/0gsVUvYnK6yf8SSBLXaSvpGHCM=;
 b=qGaBc132Xc1PuXqNM8uRSEJoOI1kia5jS+7z25bAiZodDUkaF/C3DnEEXqhjDFyPxs
 tH9BVPJIXeWaKsnEky2zhKExfCzhambCZ0YsAsgFQAwkq9Upv2sF19drO0CqhEr4iQSZ
 sq7HusIBP5aHqGfvM+8vOW2847xp7EzuecnswsJAljP7XEKW/NlgA2w7z9zx5uxcuE38
 HeTb3ts9Bgrpn3JTN9CryNDJMAgFL4zfdhAVTAJ1++U2G+LR0xreq1TNFSx6MLUI83zZ
 bcMDiN92FMcsvOgRh6xODq5Hd4+cp0s/8nu6tVdTzoSyPT+KAdrduE+Og+8kos3e52/x
 eN/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789602721; x=1790207521;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=pxTheTmuEJVS5NQG/0gsVUvYnK6yf8SSBLXaSvpGHCM=;
 b=OhyEXzQaNmInYYPeocIm6n2ykRwL6AAGNLJjUj22NBlSNFWRnfn2VtTp0HuwH0ydIf
 3IoDbVrI4Z9G7N4tx0eBKInKaxz8tsJBZSiSM1qUfNdqoxYixJidCWJjTylaygOl9W4r
 fbHdRG0/byY+hCfxede2dNxfuwdv2ng7fG5F1ALIlzhRDW9LkN2mONvJ7LlD7wVH7/4U
 4d7r3A2UUo8yk/C+0SoZYabha4JYiIBWDkCvvTfjNELwRhAs8BFLmB542+CC3mOYuFVQ
 AcPkefLZFISRB+qTVKcYeNuQ7Og6y90VvwOi7hF/ZrGlQ93+AWi3wazxna3o13i/2zHG
 nb1Q==
X-Gm-Message-State: AFuF++mPFAw3G9OGgFlj7LIUq6xWSijycspirlLefoMclv8BaA3ee3vn
 Q3xvwu7nzL75mlXUpTFDRiV8ny4ph/GGm6l6bns6SEOksZCwp7iXT/8WDI0I0rs0aakN4iy1q6Q
 glE6z9aA=
X-Gm-Gg: AYBFou1oFeePFpjma8oljsIVmTGAaVsKZEf4YIaD61+xPaBOCgYbogQhHJcuFuvdnTw
 SZkc9cRhJ0m3vPTXeFh3fZ5DKp4uxAyUIXpaXKxrNX03ovfzNCClqyZCo2YTfWlL6c6LRzjwL6E
 nix0cKG4/alKKEbSVfrxnmR6XttbANuq/uLe+z795V8806DX8cTGWAsmb6XlphBUcIQzjxJDn9d
 LW3Ja2oRTuVXUafDVpE2PQLpDVHkbABiObtGNDohkysL/ExiBayw5cO0gyQXTDJjGNbTNXJLo1P
 WQZR06Gs+o4yPtOSGsCzc1wIRjUiqs/nRVMqOk+LxKpRbqqntRKwxfU9pYQLYciPPKxX70+cEfk
 ybZhCYIEH8deAzadI01SVMcd+1wQMcz5XH8JubTdpkZsnPSzLRjaptxwPm4bhBNxZObmgd9CUwk
 g6g32Tf37EBLPmfTbAkgta2Ue1U49+lWiaiM0hz0owt0i6himQEbGD/PHwbGxFgiFbGHUBuusuD
 5GptlNg
X-Received: by 2002:a17:90a:d88b:b0:39e:3baa:bd3a with SMTP id
 98e67ed59e1d1-39e3baae393mr1147465a91.12.1789602721253; 
 Wed, 16 Sep 2026 16:52:01 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:325f:1938:d075:8c13])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33bfb05e604sm9240454eec.12.2026.09.16.16.52.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2026 16:52:00 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: cui.tao@linux.dev
Subject: [PATCH v2 0/2] accel/tcg: fix crash on instruction straddling
 address-space end
Date: Wed, 16 Sep 2026 13:51:56 -1000
Message-ID: <20260916235158.294901-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:39::e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj2-x0e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

Handle address space wraparound during translation, with help from
the target translator.

Without cooperation of the target translator, unless this is a 64-bit
guest, this will no longer assert but is unlikely to function
correctly as generic code doesn't know the address space width.

Thanks to Tao Cui for a brilliant test case.


r~


Richard Henderson (1):
  accel/tcg: Allow some address space wraparound during translation

Tao Cui (1):
  tests/tcg/i386/system: Add regression test for translator_ld
    wraparound

 include/exec/translator.h          |  3 ++
 accel/tcg/translator.c             | 45 +++++++++++++++++++-----------
 tests/tcg/i386/system/meson.build  |  4 +++
 tests/tcg/i386/system/wraparound.S | 35 +++++++++++++++++++++++
 4 files changed, 70 insertions(+), 17 deletions(-)
 create mode 100644 tests/tcg/i386/system/wraparound.S

-- 
2.53.0


