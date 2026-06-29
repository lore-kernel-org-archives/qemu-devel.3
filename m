Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D3F6C43458
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2026 14:28:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weCxo-0002zo-LO; Mon, 29 Jun 2026 10:27:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1weCxm-0002z9-T3
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 10:27:54 -0400
Received: from mail-yx1-xb12a.google.com ([2607:f8b0:4864:20::b12a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1weCxl-0007o5-4z
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 10:27:54 -0400
Received: by mail-yx1-xb12a.google.com with SMTP id
 956f58d0204a3-664c535f1a0so1868749d50.1
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 07:27:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782743272; cv=none;
 d=google.com; s=arc-20260327;
 b=Usq8uzXN0zyrTKH/1Z+9Pc3iZRcA2eRIanFxUu0uQ/OS9/ICdam0qgz2/36C1VS6RM
 0LrkRcQGFmjgFRcRGrWMt3jJioPc4laF35xuocH4CENCFFR/q1Mptk10pHLlAvWqKQOO
 yvvph4RDxVUEABNAbhOJVpPRSn3THLa/c8m7cUQQgxAX66oVvNKSCAzZZyKjFbtuLuwC
 AojXEtwSASbM/mVGB3qNeumAUJXlXzADojNcQ1mCcM4T0+D/5PrGBUoX6YIg3LeC5YY9
 JKzX3XLttSegf2b7VZlS4QM+PzaaU5+KtcB4BAI6YrEFrr1hEE/yarPkfGrzVZXM+K87
 vTUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=dPVdbrlX0SftFTbd4YwYoQRGuLy9Nrn1Xft7J3pIgrg=;
 fh=roDjFKv19ZllecJyRRgQ4fMQOxy44Ax9FITRP8Icy8I=;
 b=rdSVo6E1IiwpU+At9jMvoCgxucDjd0+UNk1unCuc45Au17HzG3rUWIaTzltTUXpQXG
 9WlTdQDUiJwX5ChLlFcQH5XuHpoENs2zLWP7iev+dMz3gFeCQkxwO3vH9xqaORWigfMm
 Equ18IHDl+yowUL2JvLN/qqazhE+2/E9Gme1wLl9mvuqN/m37iljvCIZRzc1+sCDgSi6
 jAYBbw4mHz569cyg91TO+Boz9kVPB5ipPmpJ1GGL+QyCpZoVfRBXUPKq7w2+bl07cxG6
 VUzlKiS7BSQZBobH3aS9HpFdcQjx50mmiop3nK6GP2rvgYQzElWhrqClclXgoOjw+IAa
 Zczg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782743272; x=1783348072; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=dPVdbrlX0SftFTbd4YwYoQRGuLy9Nrn1Xft7J3pIgrg=;
 b=vJTsGocFZUXMhgbwUYygdrDM6CxCnR4SPR23luEyFoGrqTLSveWdRkF75/NpzS6wHJ
 8j+b/+8XqJg4XAUv5yIQbiEEz4bmxtXWJYkAIswktv4UuM1xGUQ9FX0lEtlebhusu9V3
 MWih1HOZVurtybAXGoMJjxy+dG/igTVd2BVfRuEVRsSgKe/a+SeCHkQTJ1X2kzQu/EiE
 IdGYOy6nnvBzru/DdoRAhmFx9Q+caSEUiHpYi1vp5dRN+xz7fYUhDefHcSbpw0JfhODY
 hdD0GA1E1Z6/VJb3/EGuk57ryVBwpmfyarbia4CT1XQda5qTelXdH/iLHi/RZTOeVQWn
 n6dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782743272; x=1783348072;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dPVdbrlX0SftFTbd4YwYoQRGuLy9Nrn1Xft7J3pIgrg=;
 b=nZUNkivIwq2kPilBiDrdv1BpqIAsdSJLsqoyqJq2/VUwxNgH352KTNrdwqGhqH9lfu
 JNEqI6s+7IwrNmIUOVpjqWxRcQK9dvkB9fVtwaPUbJ4kysNsc7tgDv46xOQZQFlbbw1Y
 ewpI/kFNONXizdzXxf1UIrizJYDjWW7iCDM+I2XlrzWRk0yCT9i8+HJ+0f7c2uWJ3oqQ
 UNo2zk7d+fLmVmJmcheM3KCWOOI0rZ95d89v8Uu1YSILE76hrT2KxbiF3Zg+4DIbkSyR
 iplm2lggPmHgMvAAIdPovWMYdO9c9aVT6/fdEZb1l8nN8xXEJq0nIPIvxBblZxQBFSJj
 BjZw==
X-Gm-Message-State: AOJu0Yyh1WqYisZIJ+6Q7bCdqLKXRF6+pnM2koNOaqNfrx6PiRrS/GEu
 zTJZ9uYqxWmVPAxF3mjq2hrVJT6PyxjUg3LCnZCm7Yywugbxr7CW7iWZYYNgH8LjTCL3UjJ1MI5
 cSStdyJf2o6raWdH4PUSX4y+LWDfxpa35NbBerZwFXQ==
X-Gm-Gg: AfdE7ck2o1jHBtSz8PYs0EC7ahho4aXL+xF4jbd0k+DJVEt9tde9NLcqaQ5c2G+Eb5b
 V/zSKwdWi6ad1k8cH2egos7hbqOkCDpBczqa4A3Qt/0aJoc1qA8C3RyQSoTTiQzRnlB2/5A8dSI
 Q/91Z0Hszy/ZN/Ky1nQX/5ZUJK4L+bs/E0fh8Y31UG0GLQ+1gYI3KS+ZnmE5Bxi7fxMa43Up0Iy
 S+5jT8WytHwJQuSbAJz5Z+RIaimg4L6IdHxi8f2z6FPOBwU+6HecEoFhlhozcFmM2/AyE+jlf8e
 6r03dVeinulsM33YPfbzjmiIz0YzWCVXZ8JJ4RvCOSDoYiENIy5KAxFd
X-Received: by 2002:a05:690e:1186:b0:662:89c8:4a62 with SMTP id
 956f58d0204a3-664f606461emr532083d50.18.1782743271759; Mon, 29 Jun 2026
 07:27:51 -0700 (PDT)
MIME-Version: 1.0
References: <20260626101748.1728079-1-pbonzini@redhat.com>
 <20260626101748.1728079-24-pbonzini@redhat.com>
In-Reply-To: <20260626101748.1728079-24-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 29 Jun 2026 15:27:40 +0100
X-Gm-Features: AVVi8CcQxR8rqlR1p4kUj74QRAR6CMwwRgeJ4iOvrmH6QDOlJ2xu0UUGRF6rZq8
Message-ID: <CAFEAcA_TQHLNswnYhGKVf8bY+oy_fxWDoTTbunrwXGtAcV-gbw@mail.gmail.com>
Subject: Re: [PULL 23/45] accel/mshv: store partition proc features
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Magnus Kulke <magnuskulke@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12a;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12a.google.com
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

On Fri, 26 Jun 2026 at 11:23, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> From: Magnus Kulke <magnuskulke@linux.microsoft.com>
>
> We retrieve and store processor features on the state, so we can query
> them later when deciding which MSRs to migrate.
>
> Signed-off-by: Magnus Kulke <magnuskulke@linux.microsoft.com>
> Link: https://lore.kernel.org/r/20260417105618.3621-19-magnuskulke@linux.microsoft.com
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Coverity points out what looks like an error in this commit
(CID 1660876):

> ---
>  include/hw/hyperv/hvhdk.h |  2 +-
>  include/system/mshv_int.h |  3 +++
>  accel/mshv/mshv-all.c     | 57 +++++++++++++++++++++++++++++++++++++++
>  3 files changed, 61 insertions(+), 1 deletion(-)
>
> diff --git a/include/hw/hyperv/hvhdk.h b/include/hw/hyperv/hvhdk.h
> index 9ad16c47da9..9e6dcb22f61 100644
> --- a/include/hw/hyperv/hvhdk.h
> +++ b/include/hw/hyperv/hvhdk.h
> @@ -353,7 +353,7 @@ union hv_partition_processor_features {
>          uint64_t lass_support:1;
>          uint64_t idle_hlt_intercept_support:1;
>          uint64_t msr_list_support:1;
> -    };
> +    } QEMU_PACKED;
>  };

hv_partition_processor_features is a union of a 2-element
uint64_t array and a pile of bitfields...

>
>  enum hv_translate_gva_result_code {
> diff --git a/include/system/mshv_int.h b/include/system/mshv_int.h
> index 5eef2e6e2cb..0cf68d2879e 100644
> --- a/include/system/mshv_int.h
> +++ b/include/system/mshv_int.h
> @@ -14,6 +14,8 @@
>  #ifndef QEMU_MSHV_INT_H
>  #define QEMU_MSHV_INT_H
>
> +#include "hw/hyperv/hvhdk.h"
> +
>  #define MSHV_MSR_ENTRIES_COUNT 64
>
>  typedef struct hyperv_message hv_message;
> @@ -53,6 +55,7 @@ struct MshvState {
>      int nr_allocated_irq_routes;
>      unsigned long *used_gsi_bitmap;
>      unsigned int gsi_count;
> +    union hv_partition_processor_features processor_features;

...and processor_features is a field with one of those unions.

>  };
>

> +static int get_proc_features(int vm_fd,
> +                             union hv_partition_processor_features *features)

In this function we take a pointer to a union hv_partition_processor_features...

> +{
> +    int ret;
> +
> +    ret = get_partition_property(vm_fd,
> +                                 HV_PARTITION_PROPERTY_PROCESSOR_FEATURES0,
> +                                 features[0].as_uint64);
> +    if (ret < 0) {
> +        error_report("Failed to get processor features bank 0");
> +        return -1;
> +    }
> +
> +    ret = get_partition_property(vm_fd,
> +                                 HV_PARTITION_PROPERTY_PROCESSOR_FEATURES1,
> +                                 features[1].as_uint64);

...and treat that pointer as an array of at least 2 elements.

> +    if (ret < 0) {
> +        error_report("Failed to get processor features bank 1");
> +        return -1;
> +    }
> +
> +    return 0;
> +}
> +
>  static int create_partition(int mshv_fd, int *vm_fd)
>  {
>      int ret;
> @@ -520,6 +571,12 @@ static int mshv_init(AccelState *as, MachineState *ms)
>hv_partition_processor_features
>      s->vm = vm_fd;
>      s->fd = mshv_fd;
> +
> +    ret = get_proc_features(vm_fd, &s->processor_features);

But here we pass in s->processor_features, which has only
one hv_partition_processor_features, not 2. So the [1]
element access will read beyond the size of the field.

My guess is that the intention here was "features.as_uint64[1]"
rather than "features[1].as_uint64" (and similarly for 0,
though there it doesn't actually walk off the end of the field).

thanks
-- PMM

