Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CF30C54E58
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Mar 2024 13:55:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmwQ2-0007Yz-8d; Wed, 20 Mar 2024 09:55:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rmwQ0-0007RI-OC
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 09:55:48 -0400
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rmwPy-0000if-M8
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 09:55:48 -0400
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-566e869f631so7665732a12.0
 for <qemu-devel@nongnu.org>; Wed, 20 Mar 2024 06:55:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710942944; x=1711547744; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Z4GKj2LUrRSpGgh2xdfRJL46b+460ygZgMLHeHbOItY=;
 b=w4mWqOJrfDCcuh7Ssyw0KCaUqQhpzAEI7cV4Ne7fxpuG/Zij4ykr33tAAC3LIr9dOd
 fcAEttQsRwDkAh9yxA7DZL9AuVPIq7cJPS+LQF9TbF+YQ9Df1YxCw4UvXpsAaXa2souw
 CGgClnOqZzGOp4bpV13Hj+gC0cvpXe/PYiiNldpta7M8z+wr4lKBpRbRutQ8xSYRIXjc
 2senYisD7e8m1VEzCjx6wrAKma1FFp6gOSht3wEd6NUIgqFEn1bwexNN7UqSDvk80G7I
 WoZoA53SZZmxcTwjqqljts1a3QSEdcjZQ6B3Nr8ZSe/2iJ+yvaiIw3FP9CD4auXjAtX/
 x4KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710942944; x=1711547744;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Z4GKj2LUrRSpGgh2xdfRJL46b+460ygZgMLHeHbOItY=;
 b=xNYrpl/optcuQpY/7N60Jo/BuXqpkDtX+V742K5+RQkH2VPyncVSFtVx+naenqXOyZ
 USfekzjH3cj2mRwzm93f9wdJ2R5l8ArI2Zpkm9HrQ3yzFx05g9wZH1T75e/WWtzrQDha
 9GzaQfcoCLcxrPBJFUSVztwDguQ/ZzyNzsH+IQFCwvNM+rpIEJrCrQJ28ou/YeCYxbBy
 YpUP787XHddkO+TAdt1RLlyAiF7V96KlyQaFZ8s4zk80crXr5lSqj+9VXKJFWLMZUIV3
 xP5C3fnxfJcdXRFIqDc0LalfNWjbpr9GjzSf//CF+mG+eHmyHYmTzgWqj1i9p87q8D7B
 0xBQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU3XZatGsxkg16rQNWS4K1oF1jBJgKvzpLXoLycxQOiLYY0F+4tozDiudaCuBnJWQoUw8X1gVEqacFQRe3qi7FGERl5kvk=
X-Gm-Message-State: AOJu0YyohDKgkuVSlkXv/nvlv9iN5yC0EjeqpYNamsYu9sLz1lwsbyso
 UNk9lRIqOdKZ9V9dFg/blB5NIxcIIdNZow2Rg40IU7sAoHotlVjV/dZM/pgT48gMllxqmeRSAS+
 1NPqmPB/rjBwJ28e0TpuqZLYpS5RlYbuZSfN9qw==
X-Google-Smtp-Source: AGHT+IFqU/OllHShdIn5HY5X0pGz2VsCmtW9ge9rSjnVqdeawm2VsCI9X6tYQjloIcYgtYnPqTf0hBgLRlIo2M0uCpw=
X-Received: by 2002:a05:6402:500e:b0:567:9fef:f7ee with SMTP id
 p14-20020a056402500e00b005679feff7eemr5261307eda.16.1710942944496; Wed, 20
 Mar 2024 06:55:44 -0700 (PDT)
MIME-Version: 1.0
References: <20240220150833.13674-1-philmd@linaro.org>
 <f4a6492b-cff4-439d-8f34-cdf04cb747ee@redhat.com>
 <cc132404-dcd5-4aed-a481-b46d6e3115b0@linaro.org>
 <CAFEAcA_0qUFW0MewHC+v+pSOisE-kQDt9Wv4F3RafEkyQ0DGJA@mail.gmail.com>
 <59C20F1A-FCFE-4E26-B511-A6C0E1EF6F61@qti.qualcomm.com>
In-Reply-To: <59C20F1A-FCFE-4E26-B511-A6C0E1EF6F61@qti.qualcomm.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 20 Mar 2024 13:55:33 +0000
Message-ID: <CAFEAcA8MVbKqv-TgaO7Vv95f0p164Gao+LT-CM5+92cXjkpmTw@mail.gmail.com>
Subject: Re: [PATCH 0/4] hw/nmi: Remove @cpu_index argument
To: Mark Burton <mburton@qti.qualcomm.com>
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Thomas Huth <thuth@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Markus Armbruster <armbru@redhat.com>,
 "qemu-s390x@nongnu.org" <qemu-s390x@nongnu.org>, 
 "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>,
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52c.google.com
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

On Wed, 20 Mar 2024 at 12:31, Mark Burton <mburton@qti.qualcomm.com> wrote:
> > On 20 Mar 2024, at 13:00, Peter Maydell <peter.maydell@linaro.org> wrot=
e:
> > What NMI probably ought to be is board-specific: so it's like
> > having some notional front panel switch labeled "NMI", and the
>
> Do the youngsters of today know what one of those is ?
>         :-)
>
>
> Is there a reason for not using a GPIO interface for =E2=80=99NMI=E2=80=
=99 - wiring it up like any other wire?

The places we want to generate 'NMI' are:
 * when the user uses the 'nmi' command in the monitor
 * in the generic "a watchdog timer expired" handling code (in the
   case where the user used a monitor command to say "trigger an NMI
   if the watchdog times out")
 * when the user requested to send the VM an NMI via IPMI

In all those cases we don't have a pointer to the board or
any kind of idea of what a GPIO wire would be, and because at
the moment TYPE_MACHINE is not a subclass of TYPE_DEVICE a
machine model can't have external GPIO lines anyway. From
a convenience point of view all those callsites simply want
to be able to call a function to say "trigger an NMI please"
(which is what nmi_monitor_handle() does). Beyond that the
implementation of that function is just whatever is convenient.

If in your particular machine model it makes sense to have NMI
be something you deal with via GPIO wiring, you can implement the
TYPE_NMI interface on your machine class to work by raising a
GPIO line.

thanks
-- PMM

