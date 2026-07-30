Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDDE2C55165
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2026 12:40:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wpQ3X-0002xj-1j; Thu, 30 Jul 2026 08:40:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wpQ3V-0002xT-AI
 for qemu-devel@nongnu.org; Thu, 30 Jul 2026 08:40:09 -0400
Received: from mail-yx1-xb130.google.com ([2607:f8b0:4864:20::b130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wpQ3T-0004j3-Pc
 for qemu-devel@nongnu.org; Thu, 30 Jul 2026 08:40:08 -0400
Received: by mail-yx1-xb130.google.com with SMTP id
 956f58d0204a3-66807ba2f0fso2906527d50.3
 for <qemu-devel@nongnu.org>; Thu, 30 Jul 2026 05:40:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785415206; cv=none;
 d=google.com; s=arc-20260327;
 b=NtGD/7JJI/5vEGecIiqTxjF14r+XDcm6KLelwHotE6Pzp9IjqvWeyrjN6RysFpRRb8
 zCMCMvfDEGCV/UDeifdt5ykyNWjxn5Aa9e92EDC11mitWjXFOFxk81uZnwy68GuaoyaD
 CfFDujF6zSfQj+RPk9I6uFwsFNxXEDnhl0RVVGw2vbzmC14FwvkqP0RYU+nyQ592LuQ8
 3ttt0lZokqYhDfeoYmdTBzbcbCShHWbgu7qyfOckvIrv32jU9QkRkS0p7t5XLvvEjdrb
 77aSZ+Qji6NQ5uEoFa+VihvD4zJirojJcX6JctJfCeZlpiccYcfL+u4Z5fY6gj40r0QO
 5NZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=/d6Inj6/U9LCwohs9S3aJ6OqLl/tb/tS0IkpZC/3DCo=;
 fh=vv0FGWIck5WKtE5e1M+uKFbKFKLJCFxl981zM5Az158=;
 b=rCw2NuTy+pGj4SfDEMDOJUaYn7HKUHJwEzpfZOk8LjQwLmVJF4PNIUfhcbUdJdAh1w
 JsC+8377GoI4zoCTh7UegaNytFhFc1hCHtUzfTWvCxoS8+uVfBVG69BrSHCsQ8Le0yJp
 yzM/h5O5zxjl4yF5NsFbbcF+9aZXqu3fZN9jIjc4sO0dGjsHweeq5PLeNE9qNwc2iEAb
 sVzGDVgy34WsYJHGJaaK0hYhnWEbssIdFGHmn1NBfAOhTRUd8T6yfx8gRjMf+1x83DMG
 3lCYunZ4/CewcAGjZTMd6QtXlVIHtvRAhBriJTILEkkpI+1lQ40xUFlUlp7OpAwJa0Wi
 c02w==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1785415206; x=1786020006; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=/d6Inj6/U9LCwohs9S3aJ6OqLl/tb/tS0IkpZC/3DCo=;
 b=iD4egvBRKNibTF+yC3xnvnbZTZ2vmLiPtXWGvhBoAHoLU0zD8DeBy/++a1mW0/GF4y
 d7KnchGZYNEdu7ZaWPTGm3zv7dQcPxZsxFSHuCX9VQSsmaKGkXeCqhSjd5WKZVuEdrkv
 wBb6DqMRG8FAmAegiy7tOJx7GG/xo+Oll6DDhMYfkXNvwndx4A/LrirSHYe2Djju15b2
 w60S9Ouqj/xFdfwhLhTmJcViTM7ig/7cAZ7Stqq6tpHal7OHY5olxLzy2OsQSQDaKCaE
 ph0bO1pCJ/QQIYvYEEk7cP/RFM4SQ6XL9MmAE7OD6fhL4vUbY9l4FK9EWV4kHTWvEfrs
 VACg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785415206; x=1786020006;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=/d6Inj6/U9LCwohs9S3aJ6OqLl/tb/tS0IkpZC/3DCo=;
 b=qdZ3TwLpMOgCoED7Q/WtfNWzn/Amxxh25t3p+KrCyUwPYyFa693L1sa35adKbsSRS/
 jntrzbx6pg2F8hu7uyz3LMcZalfPq6pmBZ4fSGJWvzBZ6G7m5W/zNhpRHVR4e3WdT3zt
 FKc22mNIUav024Gj48tY4UuJUzE50PSIgI9CZtTJtbA7rh7cI7mnGaqbk3hV1FHbt8W+
 GLF8lVkPgRlv7Spuqsm7tHBaaQ7XGZCjuRh1izVcL2lsUSb9ml37bdgw3Qk5PIfeWfDO
 p7TXmHeG77rfHP8nEUD1WUFjkh/RZvkyPlbgqkEWwVy9Zpy1G87SBhpPa8028aoDxKFl
 G12A==
X-Forwarded-Encrypted: i=1;
 AHgh+RqtiW/P85FyUuVh4ZAAlGdjL4U3OLGDh8uO3krzPZFM8A4R98zPKL68tdhJi6BdIEUpgZ9+dkdkoFdm@nongnu.org
X-Gm-Message-State: AOJu0YzdsKq+KSVVH8f0TjrvzrkJfhzT3pDOuKo4yNBfjvMNS4XAqCHg
 k8yvFKMfSg242Dxv5CEV6wtbipNhYSe0M76OIeFD8VJ1Q1f3vg+yIUj3uzOT2y2OwxnkrhrpXdA
 VhFzS3CTuPoZd7+80xaAYuBsYb40ZMAso9CDWAyyiiA==
X-Gm-Gg: AR+sD11miPJR6h04KMT6zkLC4cZVS9tQfT4jqgDntu91me3yR8E45G11fYfkc45bCpQ
 cGdBcyLqVgALrv7Jen7eqMavCsiK9MmRwRMf+NnpAqxivjAdCi3QuYTIEkKYsMywVNiPJGc8Dhz
 T1FkpPMuNTGGwpGGTJEz9LYNkO465PeKm1vcXVzDcvjhA5/hX2/EqtOKI6y9bQ25u+bJnGv7eHA
 jSG9HWyZb4ZdEEw4EUPMlTJvbzFnUVOOODLEGUPyK+AIEKP+cYb7MCD0J8pq6uKxyuaZtqGmRmK
 Ml6sRwOjgjazhQz/akdDdTZxzxjCuGoSl9K8py4zYYIjv4At8KmVsvZsiKiBMmDgiUhMYt0jhu7
 2qLKpI4PjO4L29z0dKrtLtp/jwr9pZQ==
X-Received: by 2002:a53:a684:0:b0:667:a1d6:9c33 with SMTP id
 956f58d0204a3-6692f6ec6f2mr1233995d50.69.1785415200740; Thu, 30 Jul 2026
 05:40:00 -0700 (PDT)
MIME-Version: 1.0
References: <20260729231325.3808993-1-titusr@google.com>
 <20260729231325.3808993-7-titusr@google.com>
In-Reply-To: <20260729231325.3808993-7-titusr@google.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 30 Jul 2026 13:39:48 +0100
X-Gm-Features: AUfX_mzS82PqNIcUfzgtqZbYbsM3lsTFrmm4fd5R0HXY4t8srKkA1Fgop-s7k30
Message-ID: <CAFEAcA9X+jQu9DtPoszcoa=wdJSPuxZtvA0j1BFJ2bzNQkWWww@mail.gmail.com>
Subject: Re: [PATCH 6/8] hw/i2c: fix VOUT_MODE representation on little-endian
 machines
To: Titus Rwantare <titusr@google.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, kfting@nuvoton.com, 
 imaginos32@gmail.com, wuhaotsh@google.com, philmd@mailo.com, 
 fanjason@google.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b130;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb130.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Thu, 30 Jul 2026 at 00:13, Titus Rwantare <titusr@google.com> wrote:
>
> From: Jason Fan <fanjason@google.com>
>
> Even though VOUT_MODE is only one byte, bitfields are allocated in the
> order specific to the host's endianness.
>
> Signed-off-by: Titus Rwantare <titusr@google.com>
> Signed-off-by: Jason Fan <fanjason@google.com>
> ---
>  include/hw/i2c/pmbus_device.h | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/include/hw/i2c/pmbus_device.h b/include/hw/i2c/pmbus_device.h
> index 9f3569e997..03b2c21c19 100644
> --- a/include/hw/i2c/pmbus_device.h
> +++ b/include/hw/i2c/pmbus_device.h
> @@ -449,10 +449,17 @@ typedef struct PMBusCoefficients {
>  /**
>   * VOUT_Mode bit fields
>   */
> +#if HOST_BIG_ENDIAN
>  typedef struct PMBusVoutMode {
>      uint8_t  mode:3;
>      int8_t   exp:5;
>  } PMBusVoutMode;
> +# else
> +typedef struct PMBusVoutMode {
> +    int8_t   exp:5;
> +    uint8_t  mode:3;
> +} PMBusVoutMode;
> +#endif

This is why where possible we don't use C bitfields for guest
data structures. Better to use the FIELD macros from
include/hw/core/registerfields.h.

thanks
-- PMM

