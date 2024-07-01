Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11C45C30659
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2024 11:54:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOFbs-0002hY-Ns; Mon, 01 Jul 2024 07:54:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sOFbr-0002h6-Rj
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 07:54:15 -0400
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sOFbp-0003vS-9s
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 07:54:14 -0400
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-57cc1c00ba6so202610a12.1
 for <qemu-devel@nongnu.org>; Mon, 01 Jul 2024 04:54:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719834851; x=1720439651; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=diWGSKEJHDwNS9/KY+g5WzBWyzvSwg7wbXFwFcc2MUU=;
 b=FLiLAlr/aIIKTwiJ9Iy269vW80igaw5RYdp5OX9tKTJrJe6G3YYtG3M938PMve9odQ
 TUnrpAHAEIki8PwqXo277l/Y3FEOeQamlPjxHPCV3262QssyVdpivcsmt0hBEj0f1dxM
 4hnDylT8Zt2rKLFo+0RzP8xm/CC6QAkefxyfuyxhipDfhdFjmVh0JqxgGPA2EibQ+VPt
 CrdJy4B67oo7ycTNG1g9gtQLSEIAVfoYRvVyT+gs0RofDOZfbGG+nismVB0LFt7otqTR
 DBSJiygnm0FZuEapo+n6feu5YOYlUEP1vukSNHDflpKEA7WpjByKfzGsFDzxozsBK8/U
 dKVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719834851; x=1720439651;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=diWGSKEJHDwNS9/KY+g5WzBWyzvSwg7wbXFwFcc2MUU=;
 b=LzWl1svfzu7qi8fMC7QL6K2F7DYGTZ6dc9WkcN76gQJ+K5Rg4Pa8EEQSltGYOGQkDv
 oHbJZitw8YpeT7VURyAocsd4HW7dhjJCvOriat8r4IH0FdwHteXrMtOcgaa6O+o9d803
 Ywe4+NHmDHtCbB8Kxywq4XvxoOPAIXTzoVmqiefaEt/KtegGWd3D0bQGJJoMvVvbTmlD
 uDZnQHUouotDJEzyw/1euzqu+sczVU2PJlvRhrnjFar1AmqkuxgvbvGJ/NNlB8cuIlWu
 qhfiFglHbP7q1ONcbqXY4z2qNQvv/sD+mnDY4SZIl12PL6y0/7o5Uq+3Z7F30TerunAi
 3Evg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWM9Bz5F+bNtsLinWROdmek2VnZw/8NMRrk2hBEJ994XUQLEaBPC9Kn9NVHGORMP+uOZbBTn/Gr9vZvkhwjDXM0xsiro30=
X-Gm-Message-State: AOJu0YyXciG01AapKit9XN8VPtIXTC3x6J/BfAh7Gok83wR9/siRmkEz
 Ek6kK2FJpLtbOm+CHglYgaB1baf0aGLWHv1MFZomI1by9ARQHPdYaa6nO6aHiWz3rOgFnR8qnXl
 XRXdqE1ybqXvSkZVCowqyuZ1k7wnx81ZzZW0Yz+Hkrjr1xMSM
X-Google-Smtp-Source: AGHT+IHijEQAOAUqWvxvsqstKl8oRdB2qisbNKZcyxSfqTzMzvglDMVuDwrww+L0z/qQ6Q56iIe2cXQ35tP0iJAOC4Y=
X-Received: by 2002:a05:6402:908:b0:584:2314:e8a0 with SMTP id
 4fb4d7f45d1cf-587a0b0377dmr3235232a12.28.1719834851320; Mon, 01 Jul 2024
 04:54:11 -0700 (PDT)
MIME-Version: 1.0
References: <20240629-pmu-v1-0-7269123b88a4@daynix.com>
 <20240629-pmu-v1-2-7269123b88a4@daynix.com>
In-Reply-To: <20240629-pmu-v1-2-7269123b88a4@daynix.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 1 Jul 2024 12:54:00 +0100
Message-ID: <CAFEAcA8FQLQF69XZmbooBThA=LeeRPDZq+WYGUCS7cEBiQ+Bsg@mail.gmail.com>
Subject: Re: [PATCH 2/3] target/arm: Always add pmu property
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org, qemu-devel@nongnu.org,
 kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x531.google.com
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

On Sat, 29 Jun 2024 at 13:51, Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>
> kvm-steal-time and sve properties are added for KVM even if the
> corresponding features are not available. Always add pmu property too.
>
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---
>  target/arm/cpu.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/target/arm/cpu.c b/target/arm/cpu.c
> index 35fa281f1b98..0da72c12a5bd 100644
> --- a/target/arm/cpu.c
> +++ b/target/arm/cpu.c
> @@ -1770,9 +1770,10 @@ void arm_cpu_post_init(Object *obj)
>
>      if (arm_feature(&cpu->env, ARM_FEATURE_PMU)) {
>          cpu->has_pmu = true;
> -        object_property_add_bool(obj, "pmu", arm_get_pmu, arm_set_pmu);
>      }
>
> +    object_property_add_bool(obj, "pmu", arm_get_pmu, arm_set_pmu);

This will allow the user to set the ARM_FEATURE_PMU feature
bit on TCG CPUs where that doesn't make sense. If we want to
make the property visible on all CPUs, we need to make it
be an error to set it when it's not valid to set it (probably
by adding some TCG/hvf equivalent to the "raise an error
in arm_set_pmu()" code branch we already have for KVM).

thanks
-- PMM

