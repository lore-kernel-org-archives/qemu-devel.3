Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E8DECA0EE4
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Aug 2025 17:50:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1umyZ0-0000Yy-Lg; Fri, 15 Aug 2025 13:50:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1umyYx-0000XT-Eg
 for qemu-devel@nongnu.org; Fri, 15 Aug 2025 13:49:59 -0400
Received: from mail-yb1-xb36.google.com ([2607:f8b0:4864:20::b36])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1umyYu-0006Aq-QV
 for qemu-devel@nongnu.org; Fri, 15 Aug 2025 13:49:59 -0400
Received: by mail-yb1-xb36.google.com with SMTP id
 3f1490d57ef6-e931cc09dd0so2417687276.2
 for <qemu-devel@nongnu.org>; Fri, 15 Aug 2025 10:49:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1755280188; x=1755884988; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=iUFaVjXweYK7tV4BzNg37mvRv5VdPyHuHU+RmpAwTcQ=;
 b=ej8Ysf109TUm2LngyGEfnFLAFq32kTWOLsoH/osMyuEk5e8x4mx8IUmvkf6MEx0QqS
 9tg+F6TJXRU0SxR0jLUQBcFTxjBqtJ40yk/P/Bm/7/2iTYlnU+G1kQsN+wOF5p6pOmuF
 SMy+fovSB0pwE21CgeZ1w1cBN92ZRr+pZ4ttW0CSnHlj8o8vSn8BKnJ1H7JcgY44mc34
 VcGY7jX+TqqwbX8S9n3997+ff3fv+/GS9fzhPgaH8ohhhqHp1z0AxgE2WxRR283LqECJ
 EKaT9Zwp7F0eIkx9CTqA7DMhpksLuEQuaO20aH7u6rkW2I1CwlgAXOnXiOq7aMDdcMH4
 QTPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755280188; x=1755884988;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=iUFaVjXweYK7tV4BzNg37mvRv5VdPyHuHU+RmpAwTcQ=;
 b=FrxgrvtXJtppUK9ZKMMurXI1a2KNex685a/rpNba6gyi6KoVwqjKt3p9ymvjK7qS+Z
 HjZPHP92cN+qy6oL1jB6+an4nMlc0s+Vd7yLrR78r6MFEvAgOIJRFxFgP64EWaOvbn1F
 vB0Ra2BpEbK+Iy3cfKDt+Jx9WrlFJ9BGqgnb4vFjZKh2IoqcqOancmLnvH3SugnIiSnU
 T6pBHVQNzjZkMrQyRQthXp/HCIhjt/Aj+h+YBd+XGYpk80xwvdpsOouPGXr4w2dRZoBG
 3jc6TmO8MYy2aVweqBLux2GC5p4OMsQUc9nFI9sbCT/fWkK/0dmneQOEu7xjaGU9Xpen
 VLOQ==
X-Gm-Message-State: AOJu0YxAasKF7wuo15zO9dhwSIoBQREUH9ADxJcncVniEcEQgb8Eg/Kg
 O9h7kfMRetljcer41KDarhKtxOGgWlkj8K4g50W9mHXrN/nTU0Rs6qk22UUEd6cymr72xIUCmis
 K7yfNzOeVvVXlHcU31GsWiuuslhbuXZXWxg/YYNFdfCy5r1BOX1Wt
X-Gm-Gg: ASbGncuG/r8F52R0X469D8qyKkOvw/hdWtsJU0LVJMSrlv1F40eXGNBLYNNbxu4NJiU
 QueIkQxVjiw42IYHHjsAhh3THoRyqcuRQw+KjGwEjqOszdWa+jLYc6kI0PfDie+pnTYixv+o/8k
 ipg5JBL7qkm/gqCH7Y/f5e+ok1eemPn+U15zgPTTeTx89WGxZTNkbLYb1QXdMkMqU9u4xGPkKXx
 HQNufs9
X-Google-Smtp-Source: AGHT+IEDMJEJ0wgJ+lpB9KUzsiOjVBqkFQxj5uHHw3fEPG+gTJ++YFrrZ0CvcUNhTPtW3NGzTX6kmW/30fEtaTyv9u4=
X-Received: by 2002:a05:6902:c12:b0:e84:1b38:7ff0 with SMTP id
 3f1490d57ef6-e93323a0197mr4321637276.3.1755280188511; Fri, 15 Aug 2025
 10:49:48 -0700 (PDT)
MIME-Version: 1.0
References: <20250721201134.13270-1-fanyihao@rt-thread.org>
In-Reply-To: <20250721201134.13270-1-fanyihao@rt-thread.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 15 Aug 2025 18:49:37 +0100
X-Gm-Features: Ac12FXxevrJwnc5gQf-iKdU4tykZkGtfo2W29W0jOv8xzN6igFJfWLmFEpa0KNo
Message-ID: <CAFEAcA8vXBKQ-2LA5-fmmTOz5z8Pbr11QMsNADjrGsETfu0QxA@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] Add STM32F4 support and USART device model
To: fanyihao@rt-thread.org
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b36;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb36.google.com
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

On Mon, 21 Jul 2025 at 21:11, <fanyihao@rt-thread.org> wrote:
>
> From: Yihao Fan <fanyihao@rt-thread.org>
>
> This patch series introduces basic support for the STM32F407 SoC and
> a new STM32F4spark machine in QEMU, along with a USART device model.
>
> This series includes:
> - A new SoC model (STM32F407) with initial integration.
> - A board model called STM32F4spark to instantiate and test the SoC.
> - A USART device implementation for STM32F4xx family.
>
> Signed-off-by: Yihao Fan <fanyihao@rt-thread.org>
>
> Yihao Fan (3):
>   Add-the-stm32f407-SoC
>   Add the STM32F4spark Machine
>   Add STM32F4xx USART device model
>
>  MAINTAINERS                       |  16 ++
>  hw/arm/Kconfig                    |  13 ++
>  hw/arm/meson.build                |   2 +
>  hw/arm/stm32f407_soc.c            | 154 +++++++++++++++++++
>  hw/arm/stm32f4spark.c             |  48 ++++++
>  hw/char/Kconfig                   |   3 +
>  hw/char/meson.build               |   1 +
>  hw/char/stm32f4xx_usart.c         | 236 ++++++++++++++++++++++++++++++
>  include/hw/arm/stm32f407_soc.h    |  47 ++++++
>  include/hw/char/stm32f4xx_usart.h |  60 ++++++++

For a new board model there are a couple of things we'd like
to see that aren't in this patchset:

(1) Documentation. This lives in docs/system/arm/. For
this board you want to add it to stm32.rst.

(2) A test case in tests/functional/ -- generally this is
something that downloads an image file from a public stable
URL, runs it in QEMU and checks for some output from the
guest on the UART indicating success. Lots of examples
in this directory to see how to do it.

thanks
-- PMM

