Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1426FD4F03
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2026 17:00:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w00R5-0005ST-4C; Tue, 10 Mar 2026 12:59:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w00R3-0005S1-8W
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 12:59:57 -0400
Received: from mail-yx1-xb134.google.com ([2607:f8b0:4864:20::b134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w00R1-0007mJ-GJ
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 12:59:57 -0400
Received: by mail-yx1-xb134.google.com with SMTP id
 956f58d0204a3-64c9cabfe5dso170541d50.0
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2026 09:59:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773161994; cv=none;
 d=google.com; s=arc-20240605;
 b=ZSEkZprd68rgEvOvRic64wn7roSRm/iIkLg8ALTaGqhqq6FQnEu6TC5vPGHyfSK1vJ
 jELApl8dSqX/D7T+lkOO7ioRn1hM5hWt5hCNqqOqui1WKLvmyVxTWocjHyfEeP0HS7mc
 EOkBSUJF9qdDzOASfMxFbFbw/PRIPorrMU49/6cKdg7g6AReUeuypBaL8x0n9Md45cvg
 y5KxVJjIRAXMZToaKs2R0glLnXeRnO4juxk20yLjYT3KR/HzuHxqsJeOiKmG1thNddKf
 5qJ5altO8kOyjRSlR2oszH8AodXxchY7FnJEVGfbh8UAh2zSN4qdYY2hdt001H4Pp8zs
 UQqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=Db30H4+OlPYXxB/u40DQqXyoYBp8VUwu7x3aVXqr6JY=;
 fh=L0TlHOEEnsG8fZKcAojSy8uMGFRKUmRdvFPDkVDeddQ=;
 b=esAUBMToG6wOg8J029pRVwdebn8eG9e5GqnxXoNzhuv4lOhtddJAQNS2yf/ThL0rNM
 GjJ1Z/CLWjv/UKB/9IOe5YCrP9TJ8rVPp3jrVY5j2Ky0GwSxFGy4euj6f6qutjEXooGk
 jWvIAhwoVn2MCxIqPrWDJjT9mzCRRc8Gd4pb++XvpBVjmwz0OFzu0bjSszNv0K/Ce2A+
 JS/XUYDw8U+Fy+z6XEjIaEgP9+lBl0dzukgNCHQ3ns6hV55uAr2zrUWxryWuK85sucvx
 WZAQqALqtXsmY2RzUiogm/GUKjh5gStskUuhq3IdIGrmnWPQQxbRofegUeVze+qDyJ9X
 M8Iw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773161994; x=1773766794; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Db30H4+OlPYXxB/u40DQqXyoYBp8VUwu7x3aVXqr6JY=;
 b=vYqFe2f0HjONGbUaANpmRoUEP23GqLfbsMfEo32+oczK5qRFwpliSF1HexPYitnPJp
 7TVGxFiofZFphaqg6dDIpsFe3OG4yib7YUUljBwxUps/KoXyxO6V0WVpXnNKkX4LcNWQ
 R86DKK0Q0xqvUgvTejrPXplu1VCfAn+k3Kl09nFF+qw/F6tAzttij4QPdgr2RKbZbm7x
 lqUFM0s4iAyXpESY/trFgk8PtAVjpKapZINP5VrAO5RvcGBI2pg1Tj+aFxzlPbW1iLAc
 6tWeaj40mTplsGspa1bFAPlQ1lczkfPusH9Ec3FFt59FaMtQ93QXTEXEr1POchQJl6Id
 zVgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773161994; x=1773766794;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Db30H4+OlPYXxB/u40DQqXyoYBp8VUwu7x3aVXqr6JY=;
 b=cIX5IhglJKghfdnAy77nSeYWbXiVHT3z2pvyXUdFRMYnr4thiWyI5DCgf7JlxU+mv8
 xGvytrLYuXDKW8ClxzW5Jee5IPW2Vc0doNlAB0lGEATLAJm6yimEmjCbuC2Uf/Wdi5j9
 CsbmyXIp4cM0AlInynpd82lr/TwTpS9v+X0V004wtWaDnHcgN8G2KjeRLRgPVay6PW28
 DGI7aqziw8v26uMPbse/JuWJJXujmMIuQMEpc5xnNrHIEcnaT8Av/RelZSdo9wXqSOKA
 ONapNwyKdWzar89nh/hEyHx3ZcoQJo9xg6NdbVsIn8iDxIrAFUSeJqvst2H89aR5boE+
 dkPg==
X-Gm-Message-State: AOJu0YwhIKLdS74yZzfBxJKMQT1uOYvTZOKYU1a7Rr/k2BEHlcaINoMB
 eHrOtiWFrR5msahCzLmhITkVsGzMCaBIS1+Qs79H576RP2ehKIgYtuRxU/ulAdB7BNxvj/geaxT
 MxOcXnEWsGEv22lZtAl+4teh4JwQg4qp/DlDsKaqB1SKHB5+YDq49
X-Gm-Gg: ATEYQzyjOCabZE6d7XGjo6zG358hGQ0oSThN0yMoyBkXCJ58uwQfvCkSg5s5rwkc5ls
 w5DHgkuVWx7+KmngXjKXTVdEDmzNxptBaqoFY+DV5ucZeug46WUXxQUoHh8QV/1OyaIzJsfrInI
 DJebyhpq7sJUiNET1VpoWWAlZ3v+bj0WZ/iKfNzJxKh3mBec52fA/IiTMOCAqxYdc88hT2uRLAU
 Fm6QJ1c5Bh2/yHb43kyrZ6WImSMvQcQ3i0z3FY3qmOF0m8/SIS97oobIN/IWb7dyoeVJDf0Vu8x
 BD5mY1iLFSS16Z/2Dp1haCXvsZGZV1WY2Jl9g43QrGhOmmvs78PrZ9z2cVPPpkT6S50=
X-Received: by 2002:a53:4906:0:b0:649:601e:432f with SMTP id
 956f58d0204a3-64d5a130bc1mr3183822d50.16.1773161993746; Tue, 10 Mar 2026
 09:59:53 -0700 (PDT)
MIME-Version: 1.0
References: <20260302084338.473368-1-pbonzini@redhat.com>
 <20260302084338.473368-64-pbonzini@redhat.com>
In-Reply-To: <20260302084338.473368-64-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 10 Mar 2026 16:59:42 +0000
X-Gm-Features: AaiRm52dFwLVRkGC1b3QlteeW1uIDaBEd8mVm_zy2mGAcobLilgQGLb2cEqR3Po
Message-ID: <CAFEAcA946w93RSBw6OeJ=d8kaHHTQj30e63ffKE=j2AjiD_QuA@mail.gmail.com>
Subject: Re: [PULL 063/102] i386/sev: add support for confidential guest reset
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Ani Sinha <anisinha@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b134;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb134.google.com
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

On Mon, 2 Mar 2026 at 08:57, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> From: Ani Sinha <anisinha@redhat.com>
>
> When the KVM VM file descriptor changes as a part of the confidential guest
> reset mechanism, it necessary to create a new confidential guest context and
> re-encrypt the VM memory. This happens for SEV-ES and SEV-SNP virtual machines
> as a part of SEV_LAUNCH_FINISH, SEV_SNP_LAUNCH_FINISH operations.
>
> A new resettable interface for SEV module has been added. A new reset callback
> for the reset 'exit' state has been implemented to perform the above operations
> when the VM file descriptor has changed during VM reset.
>
> Tracepoints has been added also for tracing purpose.
>
> Signed-off-by: Ani Sinha <anisinha@redhat.com>
> Link: https://lore.kernel.org/r/20260225035000.385950-23-anisinha@redhat.com
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Hi; Coverity points out an issue with this commit:




> +static void sev_handle_reset(Object *obj, ResetType type)
> +{
> +    SevCommonState *sev_common = SEV_COMMON(MACHINE(qdev_get_machine())->cgs);
> +    SevCommonStateClass *klass = SEV_COMMON_GET_CLASS(sev_common);

Getting the class pointer assumes that sev_common is not NULL...

> +
> +    if (!sev_common) {

...but then we check for this afterwards.

Since this is a reset method you can assume that the object
is not NULL, as usual for methods on objects.

> +        return;
> +    }
> +
> +    if (!runstate_is_running()) {
> +        return;
> +    }
> +
> +    sev_add_kernel_loader_hashes(&sev_load_ctx, &error_fatal);
> +    if (sev_es_enabled() && !sev_snp_enabled()) {
> +        sev_launch_get_measure(NULL, NULL);
> +    }
> +    if (!sev_check_state(sev_common, SEV_STATE_RUNNING)) {
> +        /* this calls sev_snp_launch_finish() etc */
> +        klass->launch_finish(sev_common);
> +    }
> +
> +    trace_sev_handle_reset();
> +    return;
> +}

thanks
-- PMM

