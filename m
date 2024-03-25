Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F5F0C54E58
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Mar 2024 03:05:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1roadt-0001Lm-SO; Sun, 24 Mar 2024 23:04:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1roadr-0001LS-Dz
 for qemu-devel@nongnu.org; Sun, 24 Mar 2024 23:04:55 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1roadp-0001sg-TQ
 for qemu-devel@nongnu.org; Sun, 24 Mar 2024 23:04:55 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-6e6082eab17so2878543b3a.1
 for <qemu-devel@nongnu.org>; Sun, 24 Mar 2024 20:04:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711335891; x=1711940691; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Yjc3OFrM1VjcRTTWqjllxh/4TppvcFlFCFlpC5vRBhg=;
 b=MKqh1hGqM9/EJ/JlGUvayxJwYQ87zO8yowqKdG8Mh8aXzAxmvXOWZKAib+WCxhnwre
 xcpJjlHCCquFe13Cs1ttjii/ZpdUDcjjq1n34sWgF2fmMBCYiNpiwrNvz3FDpXpCMlky
 Ni3bxq+O+PzOTMNbztwvzBbDpsZS2ww+FNQ+dnc29bUapHSWmOs+pYnCOssZM69WAmma
 WfK+ggIuyYsoTT1BRM+CuHQDWyQ82l0rN24J4Jgs6UB7JUVtv1eO+/046GyQYni9CYLv
 EFIxcWDzCwNXcgofoMmG05Udl9/nL4FmAgUowfwZFffxi+Zk4cVbOmEtEbUJrli404/c
 QeMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711335891; x=1711940691;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Yjc3OFrM1VjcRTTWqjllxh/4TppvcFlFCFlpC5vRBhg=;
 b=wzU6nFFUGK7gRxzMpDJrWQ32A1w5P9d2f+mLMaspH5g6F8FhS/XcCj1PNif+4g1nmp
 u8uPutovyESZXN5TS7SEzVDhIsDLVhlOd+zpENACypkT+cat1T7jnuNvKTPjLljWvwfL
 HB5ErJAYW881WngYrKVp70igC8jnzzKKrZ7yKsHEsB0y7a+wh3lU+BlZjMY5B9iSx+S2
 Yb+1nXcbRKFfWkmB12gTkg4DLQFZsZUagOJhMwu5P8eY6NAXCR/fFAxCVC36YlNxupe5
 62pf6qUJ2933qwPxu9+msGz481zAZGGFhBGKIawPjWY1yCV17XuyQXHq4UH8TfEXwgsy
 i7qQ==
X-Gm-Message-State: AOJu0YzDLkFeDRGk+giafwxZ9BV/afDJncKpWNU5kW1x2iXhmq4kn4Y4
 K0Re5TP+IPwX6FPvWIJGNS8LXOWptwF2UkFgrQ9GrYppvebRXeJptTkcT7mIMnnfmewA7DA+MXq
 G
X-Google-Smtp-Source: AGHT+IGwgBL8zNTHpQ+RJTLQ1BfYfkHqBPH3lFhJ7u0Z3AOrqbNeN+ENAeR5gx8K/WXI1W21Ail46A==
X-Received: by 2002:a05:6a00:9aa:b0:6e7:4ab3:f8fe with SMTP id
 u42-20020a056a0009aa00b006e74ab3f8femr6952424pfg.7.1711335891046; 
 Sun, 24 Mar 2024 20:04:51 -0700 (PDT)
Received: from stoup.. (173-197-098-125.biz.spectrum.com. [173.197.98.125])
 by smtp.gmail.com with ESMTPSA id
 q12-20020aa7982c000000b006e6b4c637b6sm3291880pfl.116.2024.03.24.20.04.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 24 Mar 2024 20:04:50 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: deller@gmx.de
Subject: [PATCH for-9.0 0/3] target/hppa: Fix DCOR, UADDCM conditions
Date: Sun, 24 Mar 2024 17:04:45 -1000
Message-Id: <20240325030448.52110-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x434.google.com
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

Two problems, both related to the reconstruction and computation
of carry bits.  Simplify UXOR a bit, since no carry is involved.
While in the area, optimize UADDCM without condition, as that's
the common case for inverting a register.


r~


Richard Henderson (3):
  targt/hppa: Fix DCOR reconstruction of carry bits
  target/hppa: Optimize UADDCM with no condition
  target/hppa: Fix unit carry conditions

 target/hppa/translate.c | 240 ++++++++++++++++++++++------------------
 1 file changed, 132 insertions(+), 108 deletions(-)

-- 
2.34.1


