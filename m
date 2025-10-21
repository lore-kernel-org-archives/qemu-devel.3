Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B467CCD1A7
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Oct 2025 15:49:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBEbU-0006Ur-0T; Tue, 21 Oct 2025 11:48:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vBEbS-0006UY-CC
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 11:48:50 -0400
Received: from mail-yw1-x1134.google.com ([2607:f8b0:4864:20::1134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vBEbP-0006pe-Fc
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 11:48:49 -0400
Received: by mail-yw1-x1134.google.com with SMTP id
 00721157ae682-7847ee5f59dso46856407b3.2
 for <qemu-devel@nongnu.org>; Tue, 21 Oct 2025 08:48:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761061723; x=1761666523; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=+XQlvPldcBObR86sqjK8x+H0Kz9EtpThz3BgqMC5bkc=;
 b=pGnPx4tgC+jg7XGByw3XgW9qnvq0/2VmriGnaDenmoQuTyzqrQBfPAIEHRFyIKGixL
 vh9I2RoBdFlr91GueK5TYFrpUwAO0CrEJFaiw4FggnYGlXhgEygt6+65jR97fFrSg8lZ
 5vSE4nCGwNsVtdZcEDGZYbRyi+GE1qyLqzpOQdU9v941LA5oYAZCms8Nrp6KIzAI0Se6
 pCvDuhtCO9+T83jGizFZ6LM3zvhK1aBvfO04iKHbW6Fn/W0CSjCfl/XEm/4eYr6/f7ab
 Tg1sKjT71KSJLbHlwRH/d2oZAdJ1xmC098mifJ1MQwCNp/d1kge8FON1XG/WRxHitjB+
 xJhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761061723; x=1761666523;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+XQlvPldcBObR86sqjK8x+H0Kz9EtpThz3BgqMC5bkc=;
 b=Uda4gRWQso90dPckxcKX24XR/L2CXUQa2biFpacHccdxeoOtX8fknRpcRApER9S0+8
 4zOrQAt9FD0teM5G3JkkSFJkhPX19y8i5tWV3701inNi03sgZG8tXv0zimezTU7tG6aI
 tB81HasIZdFWbUI5cohYwbuf02IoAO9lp2xdulFjfgSFLK2U+5g1/IKr3SmfGhiNoAOo
 Cma7Ad0R9F7TbyBXqe/G3u5bb1dK6gupvlWsRjb4D3FJeo2qZhGNzP3W/idnrpjCnhQk
 HoOgH0M7UuBLj2AcDTbr08GsqhknyfgxMNTGGqzLFOlMMpCD9cF9M/vD/4CVobJnvozG
 gbeA==
X-Gm-Message-State: AOJu0YzyaVBb3GY0IY3/p20VujviBAnGuoJeqoNKJl1TeP6DXwDEoCq1
 JkCbaCZuC8uB//OxU/tsawuedhZ9fuMV1Pgl+HxuwzXBxcvd4OB5spWIuFJhppjM6O7t5HkPFzi
 XCxLba1Q9J8VJXqydOvrxrAd+4smC7i/eOvVfIewRgg==
X-Gm-Gg: ASbGnct3hW+q/jo0pX1csp0mxX2k3efLmfpPN7sHj+KYLjCVHxL39LUv+NceD246nYg
 NmRG4Mw4eI8x14wZ011c/8OE1q4wcfydbfMzOpIpyrBOa9sc2RuL/BRiGlXZj76vXti6fuH29Fq
 UqX0qG8aMOpsKl0PC6CKdf5Mf1i5wcuOcTVQE7D5R2CY6+l5H5t6Ar1sg+h69lSRPjo93A74oWK
 vHcwpiFCUVFe9slzSuzPcwV+qBSUO6pTK+6FZf3G0f4VK93W4ZBc1+NCpOpvFhn953pr++B
X-Google-Smtp-Source: AGHT+IFUvL0EQZbBUPijffI0h1tcpC13pfLrxHQzVFLYYqHHSUdzuHlG6BPxLl4/HYTwQkguQj2HQ2S9+w0bT8064BM=
X-Received: by 2002:a53:accc:0:10b0:63e:e5f:9e8c with SMTP id
 956f58d0204a3-63e161785d7mr12480143d50.2.1761061723697; Tue, 21 Oct 2025
 08:48:43 -0700 (PDT)
MIME-Version: 1.0
References: <20251009075026.505715-1-pbonzini@redhat.com>
 <20251009075026.505715-17-pbonzini@redhat.com>
In-Reply-To: <20251009075026.505715-17-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 21 Oct 2025 16:48:32 +0100
X-Gm-Features: AS18NWBd9uKE29_yiZLAFZi683ID9TkdzC3Y1_cqSScxVgHPN_cJhDTYfkCE51Q
Message-ID: <CAFEAcA--=G3j=jDXvT-Afzk=Hbo_3y_6S6CwJRJynzN+ueydBQ@mail.gmail.com>
Subject: Re: [PULL 16/35] accel/mshv: Add vCPU creation and execution loop
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Magnus Kulke <magnuskulke@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1134;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1134.google.com
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

On Thu, 9 Oct 2025 at 08:53, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> From: Magnus Kulke <magnuskulke@linux.microsoft.com>
>
> Create MSHV vCPUs using MSHV_CREATE_VP and initialize their state.
> Register the MSHV CPU execution loop loop with the QEMU accelerator
> framework to enable guest code execution.
>
> The target/i386 functionality is still mostly stubbed out and will be
> populated in a later commit in this series.
>
> Signed-off-by: Magnus Kulke <magnuskulke@linux.microsoft.com>
> Link: https://lore.kernel.org/r/20250916164847.77883-11-magnuskulke@linux.microsoft.com
> [Fix g_free/g_clear_pointer confusion; rename qemu_wait_io_event;
>  mshv.h/mshv_int.h split. - Paolo]
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---


Hi; Coverity points out a problem with this code (CID 1641400):

>  static void mshv_start_vcpu_thread(CPUState *cpu)
>  {
> -    error_report("unimplemented");
> -    abort();
> +    char thread_name[VCPU_THREAD_NAME_SIZE];

Here we create an array, which we don't initialize...

> +
> +    cpu->thread = g_malloc0(sizeof(QemuThread));
> +    cpu->halt_cond = g_malloc0(sizeof(QemuCond));
> +
> +    qemu_cond_init(cpu->halt_cond);
> +
> +    trace_mshv_start_vcpu_thread(thread_name, cpu->cpu_index);

...and here we tell the trace event to print the uninitialized
array as a string, which will print garbage...

> +    qemu_thread_create(cpu->thread, thread_name, mshv_vcpu_thread, cpu,
> +                       QEMU_THREAD_JOINABLE);

...and we pass the uninitialized array to qemu_thread_create() too.

Something needs to init the array here :-)

> +}

thanks
-- PMM

