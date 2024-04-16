Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19EABC04FF6
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2024 15:32:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rwknI-0002n7-NC; Tue, 16 Apr 2024 11:32:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rwknB-0002lq-4N
 for qemu-devel@nongnu.org; Tue, 16 Apr 2024 11:32:17 -0400
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rwkn8-000253-SA
 for qemu-devel@nongnu.org; Tue, 16 Apr 2024 11:32:16 -0400
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-570175e8e6fso3931764a12.3
 for <qemu-devel@nongnu.org>; Tue, 16 Apr 2024 08:32:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713281533; x=1713886333; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=hudcqseDaRR0N8XewaNtk//cuBQUYgPlX3T0H9lmFEE=;
 b=YPYcBr2nSYtDeB+nWLks9CgY72LOgluqFx7c4mGIeEdBQ55E2EW53E50kYdpSQ4XzR
 i2Etd4FlZbNaz4IcP2rD4qnuvETOlqlDS0t0LBtmwD58e+baLbDsyWCsNxgX6/LdF6fg
 hlN5z9Cx3t+0BBlY2650PAUiFOU+OpW0U2srzxV2axAEvxePbbrc8CZ10hmc1W0zEMJy
 oSJxP876evPkCnZ4bO/AcZ1+2wUd6cN5lQdivUZqaVO6N2pDZkN7cp+uQ+Hmnj9UrGp9
 c+hoY8mxdSW2shX4Dlox6wHQpy37fmp/nhM3Ck0HYzlvV+YUP28xYKJJZoruehjOXCQy
 59xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713281533; x=1713886333;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hudcqseDaRR0N8XewaNtk//cuBQUYgPlX3T0H9lmFEE=;
 b=IoRohZXMNrmgfjaMJp4THMMPiM8R6G98WGcOcgRnabE7h3Ua2KuAmz8EI/zn661IhB
 lTETHQHf4n6HJrM3ipUteVhbf99k3PmNO2oEY6TsdUrREj+pS3KwOMjMItZ56eHlZWDR
 FmmcWsJXdl8IurpLcFnnb6vGFk1ViZhYHxkVRm2NSBWtfryRbPgolAIUcwnF1gWspyAd
 1sJYH92ey8zwIxskfbsKuS0+n83DkT105Uf+ZpTkmJUIK+VoMZiuIrh8xbOBYn/qmh+o
 06XFh4JUZt2tcEXECw04kaXO61AxqpovHezJX1VNr2/Lr3lwdI4r6CaNdl1FGcvjXjGW
 bC3w==
X-Gm-Message-State: AOJu0YyBMKagnwuBjRIyTfLOAwCcGZbs1pmG/W371G6fv8fZPQnwAldU
 +h4zGFYVRh8eH6fuv9cCJtsor5t+JiMJmfgEAziu4aPHUE5EkzEpLUyoPyeTkea0X3FLkyAE/8p
 MDQlJQo+aDoxluFOj0Q9ObP7c2lFrw6WWEAfFsQ==
X-Google-Smtp-Source: AGHT+IEJywo+IoptT+Hqsyj7eI82vwvEbzJ1romQfKWQDM/uSluV93jRle8lfwAUaRUXH3oiw32/Sus+obWePU3WW6o=
X-Received: by 2002:a50:9ee2:0:b0:56e:23e3:bdc3 with SMTP id
 a89-20020a509ee2000000b0056e23e3bdc3mr8298281edf.16.1713281533259; Tue, 16
 Apr 2024 08:32:13 -0700 (PDT)
MIME-Version: 1.0
References: <20240412073346.458116-1-richard.henderson@linaro.org>
 <20240412073346.458116-28-richard.henderson@linaro.org>
In-Reply-To: <20240412073346.458116-28-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 16 Apr 2024 16:32:01 +0100
Message-ID: <CAFEAcA8S_0keikrqhFcivmzGscmVv+B=6FhzES0s5zA+Lr9WFw@mail.gmail.com>
Subject: Re: [PATCH v3 27/27] target/i386/kvm: Improve KVM_EXIT_NOTIFY warnings
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x532.google.com
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

On Fri, 12 Apr 2024 at 08:37, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/i386/kvm/kvm.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
> index e68cbe9293..1fc809b2f9 100644
> --- a/target/i386/kvm/kvm.c
> +++ b/target/i386/kvm/kvm.c
> @@ -5275,7 +5275,6 @@ int kvm_arch_handle_exit(CPUState *cs, struct kvm_run *run)
>      uint64_t code;
>      int ret;
>      bool ctx_invalid;
> -    char str[256];
>      KVMState *state;
>
>      switch (run->exit_reason) {
> @@ -5335,15 +5334,16 @@ int kvm_arch_handle_exit(CPUState *cs, struct kvm_run *run)
>      case KVM_EXIT_NOTIFY:
>          ctx_invalid = !!(run->notify.flags & KVM_NOTIFY_CONTEXT_INVALID);
>          state = KVM_STATE(current_accel());
> -        sprintf(str, "Encounter a notify exit with %svalid context in"
> -                     " guest. There can be possible misbehaves in guest."
> -                     " Please have a look.", ctx_invalid ? "in" : "");
>          if (ctx_invalid ||
>              state->notify_vmexit == NOTIFY_VMEXIT_OPTION_INTERNAL_ERROR) {
> -            warn_report("KVM internal error: %s", str);
> +            warn_report("KVM internal error: Encountered a notify exit "
> +                        "with invalid context in guest.");
>              ret = -1;
>          } else {
> -            warn_report_once("KVM: %s", str);
> +            warn_report_once("KVM: Encounterd a notify exit with valid "

"Encountered"

> +                             "context in guest. "
> +                             "The guest could be misbehaving. "
> +                             "Please have a look.");

"Please have a look" is a bit more chatty than we usually are
in warning messages...

thanks
-- PMM

