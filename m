Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7AF6C54E58
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Mar 2024 13:35:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmw5Y-0007Mo-Dy; Wed, 20 Mar 2024 09:34:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rmw5R-0007Ll-7V
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 09:34:35 -0400
Received: from mail-lf1-x12f.google.com ([2a00:1450:4864:20::12f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rmw5O-00054H-Fn
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 09:34:32 -0400
Received: by mail-lf1-x12f.google.com with SMTP id
 2adb3069b0e04-5148ea935b8so3333327e87.1
 for <qemu-devel@nongnu.org>; Wed, 20 Mar 2024 06:34:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710941665; x=1711546465; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=i+aeKijSs/ovcqH6qIFXo66FHGTGaQv/r9wTmq3UZNI=;
 b=Szu2yLgY6nRtVIZ6bnRsp2T9lyeBnU2aIEuo8WuL/K9jr1fdBrZmlhn7JlOmBpJeJr
 LL4snYQFt1MqF8DAZPgEKSiwPkHTs8wA2i3f3MQnkt4eRR7ZIc1j3TSVChHhl2Ijz1Hi
 4RBpsOJ29J6hEs5NQM6FiU5F11dyqztJFP6crEVlRc2vjtHeIEAQz13d+x2UFjmvOJnM
 aBGLdDVz7nlpWjuQMw0bDAi9WHbjTI2JyYgDjkR6BUYOgDCpSSlZ3ju7/teytigRWCEU
 +hl+QDm0unuHIsCBkpFul7OehPs6YoadpUadNYeTisOrP+26wKh5Kl02uAd36LFFjUlJ
 hGtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710941665; x=1711546465;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=i+aeKijSs/ovcqH6qIFXo66FHGTGaQv/r9wTmq3UZNI=;
 b=luj5/0H8EtWUd6AXJ5DdwfQXHclXVinZ/FN7qaXwltFUWq0s/tk1rKNzj9MWvFBUCZ
 EVDrIUXxeBDd1NHck48O9Wv3bPK+qDDmffwgyp2S7F3RiWmW3j02aOwYjUhJipy9EPNJ
 CgNglM72TTGp79LVPRLFz/XgG48LFkTQccJHqw7zOf0oqgWvpnBg9FcXluYJa92nstIo
 bxjQ9S7oDKzWUdoC7OQK9OkXkU7Dpvh8Gpbi2gYQ+JmD9wJdIy7Q1UOHaa1LOnYgvo2U
 ghWfGBaErMI15uboMfBYLlZLZAb3Zvhr4JXCwf2MWqPxDFIYK5FTlhV0V5bkawKNSRIR
 VQJg==
X-Gm-Message-State: AOJu0YwGlXvd3jVczERdpSMSIGiHmMQvJetQCtZgBM3X3dLMXWsz66e0
 EnBxzy/h4lqMxZMCviL2hGIG2AMzg2XVb+ZoMtMK61OaTLAOB0vpjZvSo+lpmVbLbN9I8aZHcyc
 0ugFMeKBEeZLrAbuvF50Xv0/kk39U33zb2wrkuQ==
X-Google-Smtp-Source: AGHT+IEaELGQfFoA9nP+iS6pYDW8Ot2p9Vs+ksR1E3Vl2Gv1cfPb9OIP0wQL0vDCqQchxZech8ClBPALHN5Uf8sZEkg=
X-Received: by 2002:a19:e05d:0:b0:513:bf92:79ad with SMTP id
 g29-20020a19e05d000000b00513bf9279admr1535400lfj.45.1710941664823; Wed, 20
 Mar 2024 06:34:24 -0700 (PDT)
MIME-Version: 1.0
References: <20240220150833.13674-1-philmd@linaro.org>
 <20240220150833.13674-5-philmd@linaro.org>
In-Reply-To: <20240220150833.13674-5-philmd@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 20 Mar 2024 13:34:13 +0000
Message-ID: <CAFEAcA-yALySmCJLbitCmYpiZKUXJNOavGJG9RYeo8fKqz7gcw@mail.gmail.com>
Subject: Re: [PATCH 4/4] hw/nmi: Remove @cpu_index argument from nmi_trigger()
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>, qemu-s390x@nongnu.org,
 qemu-ppc@nongnu.org, Christian Borntraeger <borntraeger@linux.ibm.com>,
 Corey Minyard <minyard@acm.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::12f;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x12f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Tue, 20 Feb 2024 at 15:09, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.or=
g> wrote:
>
> nmi_monitor_handle() is not related to the monitor,
> rename it as nmi_trigger().

> Return boolean value
> indicating success / failure. The 'cpu_index' argument
> is not used, remove it.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
>  include/hw/nmi.h       | 13 ++++++++++++-
>  hw/core/nmi.c          |  9 ++++-----
>  hw/ipmi/ipmi.c         |  3 +--
>  hw/watchdog/watchdog.c |  2 +-
>  system/cpus.c          |  2 +-
>  5 files changed, 19 insertions(+), 10 deletions(-)
>
> diff --git a/include/hw/nmi.h b/include/hw/nmi.h
> index c70db941c9..32b27067f2 100644
> --- a/include/hw/nmi.h
> +++ b/include/hw/nmi.h
> @@ -49,6 +49,17 @@ struct NMIClass {
>      bool (*nmi_handler)(NMIState *n, Error **errp);
>  };
>
> -void nmi_monitor_handle(int cpu_index, Error **errp);
> +/**
> + * nmi_trigger: Trigger a NMI.
> + *
> + * @errp: pointer to error object
> + *
> + * Iterate over all objects implementing the TYPE_NMI interface
> + * and deliver NMI to them.

I think I would document this something like;

 * nmi_trigger: Trigger an NMI, in a machine-specific way
 *
 * This function triggers an NMI, in a machine-specific way. The
 * intention is that this should typically trigger a guest kernel
 * dump or reboot, and might happen as a result of user request
 * from the monitor, watchdog timeouts, and similar events.
 * (For example on the x86 PC it triggers an NMI on all CPUs,
 * and on s390 it triggers the RESTART interrupt on the first CPU.)
 *
 * The NMI is triggered by looking for QOM objects which
 * implement the TYPE_NMI interface, and calling their nmi_handler
 * method. Usually it is the machine model class that implements
 * this interface.
 *
 * Not all machines implement NMI handling; this function
 * will return an error if used on a machine which does not
 * implement NMIs.

(In an ideal world we would also document per-board what
the NMI handling is, in the user-facing board docs...)

> + *
> + * On success, return %true.
> + * On failure, store an error through @errp and return %false.
> + */
> +bool nmi_trigger(Error **errp);

Why return a bool here? None of the callsites looks at the
return value.

thanks
-- PMM

