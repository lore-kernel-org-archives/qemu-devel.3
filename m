Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62DDBC4829E
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Feb 2024 15:12:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1radOi-0001oR-FB; Thu, 15 Feb 2024 10:11:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1radOg-0001mO-6a
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 10:11:34 -0500
Received: from mail-lj1-x236.google.com ([2a00:1450:4864:20::236])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1radOd-0004Tb-BW
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 10:11:33 -0500
Received: by mail-lj1-x236.google.com with SMTP id
 38308e7fff4ca-2d0d7985dfdso14019091fa.2
 for <qemu-devel@nongnu.org>; Thu, 15 Feb 2024 07:11:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708009889; x=1708614689; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=pNghoLPXthAQrjQvMbiLtG5ZZFo5ifcr0c5D+WQ9IrY=;
 b=fX8F3JcSf9R9Tk0t9y3U+JLxJAJ/5EXPdYTs3zSuiN8nec81Twc1/dBfQpUTYWEx1v
 8IIlHwT56uoqDBWBv5weV4SM+34txE8Cx2I4/jfmpVPyxMbfka0dk6i6yErbZrZ18w+5
 nAP4QO7CnkKSYgv9B3oxBW/o9Yv/CFIH+L1KWWXJAJKiHWWiGBZ9yHh1JtjUfiBfZqQ8
 n7xuNBwVocCnlxPOpV0XmH2HDzP4mMh/Tf5AQCq95axLEg/bZnCDS+eoIX3vW2tO99Gt
 q7P55U6+Pd5wyOwySDtPuxpd5E52nHaBAzfs/VjRAI0Nmfi+Sak241/Hs7VWl4G9YzQa
 yoNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708009889; x=1708614689;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=pNghoLPXthAQrjQvMbiLtG5ZZFo5ifcr0c5D+WQ9IrY=;
 b=kW0o53heDz0YA3LJNVS5KoXRQpo2aA6F/JGtOCKQcqyOsEZNR90ZAEAAR4MHZBneQD
 KXezLCzcd8pCJxrJU1eERPCpEmM4xWdBX99AkPsMOqL8S6WUsWtJUtgPxl6cUXli5ZSS
 bAxjivhILWNmb8EjTrhJQvrjy0jv9DNPHgZDa7WwEAYagSZW+br8VK6E8/H3vcq+Umi7
 VmgBtCNmIuogSdXw2lWVXp8H2cIaduOkOFMhNyJ7FM52+knwVGACe3ZajSPxH8Fy1t3k
 kKN05PsWNtCsRAIMaYja12jKxeoA8nJiuREV28uJftBp6lmCFqwwa85jn2+92l2I5FAt
 Z53w==
X-Gm-Message-State: AOJu0YxSDDgpdz5Gja7iFszw07hGe/mER1dPEVvV6zIB6ZwAb7lV1Clc
 ekn7R+n7VAVJ67Etrg429Wh6eqo5VlTF6ckUOL7VQdWWrKDz3CQB3h04QDkDQVbGp7i67XBL6oq
 37VXWvSsY4zoxyVWdblz8+ui8Zqkgjw07doOYGA==
X-Google-Smtp-Source: AGHT+IHy5JjuzhTnefD6NdS9AlGh/MuVdt6RKKZLJbVCqOvz+9XRFMxLPEPH9KEAd9J83uMFjcO5Q6wcrJO/OW8gGMA=
X-Received: by 2002:a2e:a98e:0:b0:2d0:de71:935c with SMTP id
 x14-20020a2ea98e000000b002d0de71935cmr2182793ljq.0.1708009889242; Thu, 15 Feb
 2024 07:11:29 -0800 (PST)
MIME-Version: 1.0
References: <20240215150133.2088-1-Jonathan.Cameron@huawei.com>
 <20240215150133.2088-2-Jonathan.Cameron@huawei.com>
In-Reply-To: <20240215150133.2088-2-Jonathan.Cameron@huawei.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 15 Feb 2024 15:11:17 +0000
Message-ID: <CAFEAcA-_z8FWxXRdGVdk7u5rgOMOEnfSLokdx6_ocyObzPF8bA@mail.gmail.com>
Subject: Re: [PATCH 1/3] accel/tcg: Set can_do_io at at start of lookup_tb_ptr
 helper
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: qemu-devel@nongnu.org, Gregory Price <gregory.price@memverge.com>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Sajjan Rao <sajjanr@gmail.com>,
 Dimitrios Palyvos <dimitrios.palyvos@zptcorp.com>, 
 richard.henderson@linaro.org, Paolo Bonzini <pbonzini@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>, linux-cxl@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::236;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x236.google.com
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

On Thu, 15 Feb 2024 at 15:02, Jonathan Cameron via
<qemu-devel@nongnu.org> wrote:
>
> From: Peter Maydell <peter.maydell@linaro.org>
>
> Peter posted this in the thread trying to fix x86 TCG handling
> of page tables in MMIO space (specifically emulated CXL interleaved memory)
> https://lore.kernel.org/qemu-devel/CAFEAcA_a_AyQ=Epz3_+CheAT8Crsk9mOu894wbNW_FywamkZiw@mail.gmail.com/#t
>
> Peter, are you happy to give your SoB on this one?
>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  accel/tcg/cpu-exec.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
> index 977576ca14..52239a441f 100644
> --- a/accel/tcg/cpu-exec.c
> +++ b/accel/tcg/cpu-exec.c
> @@ -396,6 +396,14 @@ const void *HELPER(lookup_tb_ptr)(CPUArchState *env)
>      uint64_t cs_base;
>      uint32_t flags, cflags;
>
> +    /*
> +     * By definition we've just finished a TB, so I/O is OK.
> +     * Avoid the possibility of calling cpu_io_recompile() if
> +     * a page table walk triggered by tb_lookup() calling
> +     * probe_access_internal() happens to touch an MMIO device.
> +     * The next TB, if we chain to it, will clear the flag again.
> +     */
> +    cpu->neg.can_do_io = true;
>      cpu_get_tb_cpu_state(env, &pc, &cs_base, &flags);
>
>      cflags = curr_cflags(cpu);
> --

Happy to provide a
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

but I'd appreciate RTH's review to confirm this is the right
way to deal with the problem.

thanks
-- PMM

