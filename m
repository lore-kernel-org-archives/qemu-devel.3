Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46AFDC4345F
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2024 13:44:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ruuiN-0004L7-K2; Thu, 11 Apr 2024 09:43:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ruuiN-0004Kz-2n
 for qemu-devel@nongnu.org; Thu, 11 Apr 2024 09:43:43 -0400
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ruuiH-0000TJ-1X
 for qemu-devel@nongnu.org; Thu, 11 Apr 2024 09:43:42 -0400
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-56e4a148aeeso2002634a12.2
 for <qemu-devel@nongnu.org>; Thu, 11 Apr 2024 06:43:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712843013; x=1713447813; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=EPz68a90kbDwcDM0qQKkUULiUGnOnkoYTWy+aZ4oRyQ=;
 b=piWj9rVE8dCYZn50ZqeA3WwraDa8ipMd+aqA4iGwnF6QxvDHIhyg1ygsBEAMsyclMX
 NZ/J8uMynV4ADuSt8e6fwEhe97TQESQordVY3378zqA3sdaAGbHDJ0d8HQ99Scy6ElND
 Rnh58WemF2se1pIN4r8dfmYulG/RvfCwsZU3eomoZ5y7Df/z6sJSjRkUf5+kUfI+Hg38
 isa8hx0SaLO2Q9IpwJtVtR+/e/IKbI/J53Mw8Tl6YXCSTMv13maKJuE1cFHftv7LVskt
 5eTkQeOc1qS83UMOGE7Jm9UPm64kOspSKeKCjLHMOys/SFeWDl02APIpuc3qqJL4Zhpy
 NdFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712843013; x=1713447813;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=EPz68a90kbDwcDM0qQKkUULiUGnOnkoYTWy+aZ4oRyQ=;
 b=dLzHBErzDi7fe2xZQhAog35DOqJxkOCHHuRk+HO4EzL0Mm4LNbSUTrNOrY/hIWESPS
 XwhPyBa5XdFTd71GF/CIf+2/yNAbzRcAVqQvO5eIqXjViOi0Of3zqSzhagphUN2xozPT
 GbwynSQPdlRDyITYZK7SPIO6neudoqT+M+DLs8Xqgo2xwYa3xko3eBKIKXrnxKwu/syl
 4t0EX7qlpr0bRP30ka+gGzSJgUvIu0WVoOqLeKpQeCYnbw9SyczJlw+SBPSGQdotWJvb
 4QX4LQxF4f17d8IJIPOFAsLY3KhzsvrMtGGzUfvoWyn1Sb15BJcN7pcm02/st1sJVVY7
 nPyA==
X-Gm-Message-State: AOJu0Yw1meF4A27jHL7+FerHPouZmjFcnjLQDpKxU9PVXVrrAQGZWRO0
 jXq1fcdyvPsno6Y851mtEMhczRJOb2Gdu1FpOTzTKtwJx9eAP0sL8976uBiRzuGQWglb7goh2Ec
 7CAi6pqMkDDFl3MyVpglditIg9oeFETP8NAE+2yAWb7SaQgoO
X-Google-Smtp-Source: AGHT+IHPIT/HG0Hm7OWOyhdQ4qmnbEiF1tZvWzx92vPxaTTVuafJGejvG52BIszGPwZQE5S09AWwaQqfHBBpXICb+Lg=
X-Received: by 2002:a50:9f65:0:b0:568:d7fe:a768 with SMTP id
 b92-20020a509f65000000b00568d7fea768mr4537914edf.25.1712843012606; Thu, 11
 Apr 2024 06:43:32 -0700 (PDT)
MIME-Version: 1.0
References: <20190821163341.16309-1-damien.hedde@greensocs.com>
 <20190821163341.16309-3-damien.hedde@greensocs.com>
In-Reply-To: <20190821163341.16309-3-damien.hedde@greensocs.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 11 Apr 2024 14:43:21 +0100
Message-ID: <CAFEAcA8FUgmnq0-QfutpbN=xkeKxRe75b56Fu2zoXknXczwnvA@mail.gmail.com>
Subject: Re: [PATCH v4 02/10] hw/core: create Resettable QOM interface
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, berrange@redhat.com, david@gibson.dropbear.id.au, 
 Damien Hedde <damien.hedde@dahe.fr>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, 
 =?UTF-8?Q?Phil_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x535.google.com
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

On Wed, 21 Aug 2019 at 17:34, Damien Hedde <damien.hedde@greensocs.com> wrote:
>
> This commit defines an interface allowing multi-phase reset. This aims
> to solve a problem of the actual single-phase reset (built in
> DeviceClass and BusClass): reset behavior is dependent on the order
> in which reset handlers are called. In particular doing external
> side-effect (like setting an qemu_irq) is problematic because receiving
> object may not be reset yet.

So, I wanted to drag up this ancient patch to ask a couple
of Resettable questions, because I'm working on adding a
new ResetType (the equivalent of SHUTDOWN_CAUSE_SNAPSHOT_LOAD).

> +/**
> + * ResetType:
> + * Types of reset.
> + *
> + * + Cold: reset resulting from a power cycle of the object.
> + *
> + * TODO: Support has to be added to handle more types. In particular,
> + * ResetState structure needs to be expanded.
> + */

Does anybody remember what this TODO comment is about? What
in particular would need to be in the ResetState struct
to allow another type to be added?

> +typedef enum ResetType {
> +    RESET_TYPE_COLD,
> +} ResetType;

> +typedef void (*ResettableInitPhase)(Object *obj, ResetType type);
> +typedef void (*ResettableHoldPhase)(Object *obj);
> +typedef void (*ResettableExitPhase)(Object *obj);

Was there a reason why we only pass the ResetType to the init
phase method, and not also to the hold and exit phases ?
Given that many devices don't need to implement init, it
seems awkward to require them to do so just to stash the
ResetType somewhere so they can look at it in the hold
or exit phase, so I was thinking about adding the argument
to the other two phase methods.

thanks
-- PMM

