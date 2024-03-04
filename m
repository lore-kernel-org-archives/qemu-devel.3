Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11ADAC5478C
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Mar 2024 15:32:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhAI7-0006OY-Nc; Mon, 04 Mar 2024 10:31:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rhAI6-0006Ny-1Z
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 10:31:46 -0500
Received: from mail-lj1-x233.google.com ([2a00:1450:4864:20::233])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rhAI4-0007IA-Fp
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 10:31:45 -0500
Received: by mail-lj1-x233.google.com with SMTP id
 38308e7fff4ca-2d180d6bd32so56739291fa.1
 for <qemu-devel@nongnu.org>; Mon, 04 Mar 2024 07:31:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709566302; x=1710171102; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=jNlEAps2RdInrw/fzJby2xxi5laZepePUW8FL58p5Iw=;
 b=OZFZGVETiy7Uo66D1HwG2vfo9fbcXJppmmDOkF2D+Y5cq+MdvxHV9/5tuVNmyLbYiP
 +pRTo/RuNlF+vDX5d04h1GkhUqAofqhysgbZ91hKywodGQ+/JKdqGTpStlObic9UI9qU
 rHkFc9X6ebON8ojL31wCNhZPFCCgH8QfQpuoa3PLXvrbuozwAfdd/05gk6Q+pD837DyT
 N97Rti9sQ8rDXW1IhmzAFj3lMcEdXcoUjqLXyysM324uin0xzMqJQyo9MotfRQSwD1t/
 qa7PdU6RVQ+29suO4BJpNIi9rBj1HjtNOnwGkwee4lbCWiJ2Es6ksKR0HvQzYGy5gXrG
 RWww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709566302; x=1710171102;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jNlEAps2RdInrw/fzJby2xxi5laZepePUW8FL58p5Iw=;
 b=YhomEi7LL2F+taWE19wwM3oRASL3G9QX6MRDLp+AdUiX3iSNpgEwXG3F2VMj2tsJXy
 276KVv/HfPmOptFhLZZRxPRVwQlBtebF7Zd6ozprMY9KYvcnmgSDkQN/3vezf4W1la9G
 wMF9LmQtclQ416yuP2KZjzyFDXIkdOt6aG0B5ob/1gvvblqqJsyLHEDAN9u6DSQgfMWF
 HpwF89Q8htfcUq6Xd4O26T5WA97PjbJKXosC4ZD2/DEuVv/2/XmWwJCZqY64ceSZApKx
 TfCWWxqYRKYy35dhNwQp2NLe3ACCiAhXkvZXSRLiR0SN5sz2v0yVQw6+7yLR7HbH9VcQ
 zTYA==
X-Gm-Message-State: AOJu0Yx0yZTuwQuHJYvazL4R7aZSxc+7Qq3Qvn920x8QGSjLLaLDERdi
 qpehRvj3VMXvwgfkPs1NZXlJGh9WMIcMfITl/Z11AdAsSBZ6jsrNXFznX4JaBl8XF+j8UjFsetS
 7F0+qIYd+MbOXDjS1ulxOdYq/nt5WLFmyG5J8Aw==
X-Google-Smtp-Source: AGHT+IEwVxl9C+oZXIqNGi5A0Ow8jD1k2aJM1b2LXPZZ+Cad720vAGTyfKsfHMGcyt/9Wdf38BWRMUFAfyWDnXjKzZw=
X-Received: by 2002:a2e:874e:0:b0:2d2:b915:e073 with SMTP id
 q14-20020a2e874e000000b002d2b915e073mr5208024ljj.27.1709566302445; Mon, 04
 Mar 2024 07:31:42 -0800 (PST)
MIME-Version: 1.0
References: <20240221110059.152665-1-thuth@redhat.com>
In-Reply-To: <20240221110059.152665-1-thuth@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 4 Mar 2024 15:31:31 +0000
Message-ID: <CAFEAcA_X90UiX8tJZw0vYpzFHB7FcrgzvdKOfe2zOL4ux4UZLw@mail.gmail.com>
Subject: Re: [PATCH] hw/intc/Kconfig: Fix GIC settings when using
 "--without-default-devices"
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-arm@nongnu.org, Fabiano Rosas <farosas@suse.de>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::233;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x233.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Wed, 21 Feb 2024 at 11:01, Thomas Huth <thuth@redhat.com> wrote:
>
> When using "--without-default-devices", the ARM_GICV3_TCG and ARM_GIC_KVM
> settings currently get disabled, though the arm virt machine is only of
> very limited use in that case. This also causes the migration-test to
> fail in such builds. Let's make sure that we always keep the GIC switches
> enabled in the --without-default-devices builds, too.
>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  hw/intc/Kconfig | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)

I don't understand the Kconfig infrastructure well enough to
review this, but if somebody who does wants to give it a
reviewed-by I'm happy to take it into target-arm.next.

thanks
-- PMM

