Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A62E6D6100C
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Jan 2026 11:41:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlQP7-0000H8-SM; Thu, 29 Jan 2026 06:41:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vlQP5-0000FZ-UW
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 06:41:40 -0500
Received: from mail-yw1-x1129.google.com ([2607:f8b0:4864:20::1129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vlQP3-0001LK-Ns
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 06:41:39 -0500
Received: by mail-yw1-x1129.google.com with SMTP id
 00721157ae682-78fc174ada4so7141207b3.2
 for <qemu-devel@nongnu.org>; Thu, 29 Jan 2026 03:41:37 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769686896; cv=none;
 d=google.com; s=arc-20240605;
 b=GG7myrCeumg1SEiHYx4U3OdfuuhEar7aADiktxgRzL86sCyaUdLwng1ndtiH/oddK+
 90V6MgMYNVcEFT+SdihwaNSTL+996rB2VELKWNXz5ZpcgzYeLS6ZiEFeFH/L4C0I6x51
 8UZAYgBQ/Rjgh+ATmQYcmxrqSa+YGVsdoZyVXwcKmcccCWb72r0EecXpbc8L5UxhBwyc
 +3tHPlh4Wb9IGWOcdJWnObBVYezFhSAXPOtheqQ7Hmy+jRKC3LcomTScbIA/eD36nJ6e
 358tcSwmCD8OmAKcjRt7hmuEdXt9xJMmNcqdp0sgRq78Ga6Hkg8kJbIDilbjb5QG8nKo
 ZRMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=uimdnHTjxESHe6U4Yu5NNwY/Dveasqe0UAi1Rs6N2HE=;
 fh=rCzcKDnHtcsnfSsv3HN63n41sBQrg5PA0ewQfHnj8m8=;
 b=J4tr1uPGAVBQlgnTA7nv2xHyO7dL7DsJbFBixVbjS2D8l2JIJs7mhgWwmYbXTpKMVn
 1G5vVwL0nXUFMcDpQ6+EayNBGBZuMXRJP0n0Aw0iYBONhrYFkQ21e3IGf6EIy1DB6B6K
 Ths92QKkQKRlcgnRpdIqzInhBS9Zmte6oQbuxL3Ac2L/KkMrIM6Gi6NqJ788D+qpK9fu
 kFMJHryxeXFd1WOVyQX8JopXKy8toW67Tlw4rkZo9lgPTA4/N9H9JqhMZPJcqXqL5nF8
 UCh238kYedCQ5VnoDYl7TpDRNOBNataJop9NMNT4cFPgcd5wGQRanBxTn8WSwfXgXcGS
 tYHQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769686896; x=1770291696; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uimdnHTjxESHe6U4Yu5NNwY/Dveasqe0UAi1Rs6N2HE=;
 b=Z/iKj9ro2YDE+YCeZ4dP4x6WdhFiwNa8pYH1DO7rLlDoEc/uv9ygpBd7yGZHGf2nk8
 3GtLWOOQsvlMkUxt3V1IErqQeeneYQF4ozYC88c4EU2rq3wPiYhz2JMjG4kAUjx1NCvN
 Rn4dxcw+/9+CTsnelfYyw1VUkqbv2cmZRGS6X2MyypByR5DqDAvIyToXH0S87q2Afu6d
 AB84FH6YujlkV4muS9mHtVJVEi1HVuEetgE891iVxejlaeS3lRrcEbaFSmM8sefnzfKw
 sSJjrFvYhSka3qmqAoS+pevBc/FKIoMJGivSUyVe95vZ3/bzCQsoNFDU4GeCoUCkVCo4
 easg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769686896; x=1770291696;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=uimdnHTjxESHe6U4Yu5NNwY/Dveasqe0UAi1Rs6N2HE=;
 b=lvvyRCb4aRYiKLAZL++1HfghbmPUiWtDlsUpYX5b0vF0srH+Zp9BElF3lrcXmEya4W
 VZ+osiVR/n607tr7BihWJOUkPaNm3EjsS3FisiEGsBwR+CworORe0pogfD7WMJNDNDzK
 Nwpqb9eKpByWdQP6TYKISo3n99au8FCUoP2drBpQQfcuRLRs8Pz10ewafJUtikANa+4s
 Q6qnrj4LunO/YLIb0muYY9miEfDG6IWsxckdHQOeura3MUEe+DL+n6ESS5KOoq8Y8jRQ
 900Oy9iBVm9qEb4v+mgsGVWuWBMeYFIDaucAFHyGTuNcSI4Bs05aJjXLdlXDRTxq5zFd
 ET7w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXObJdY34xb11vkGG0lOwr+dOjzhPizfiSxL0xoZzTAyuqdUFuR37CqfkSTHr2l/OXO3gGB6kodTQDS@nongnu.org
X-Gm-Message-State: AOJu0YxCJ1ABIJoJulnokyoVYLDOMGsz6SmvE3clyCmT2AwAZ6B/Qzeb
 IRzg1OaMtw7XYRrwFHNVUdqvzwA66a1l0q4pZxwTJdVYLzCz3tvlQj6K1YiSQ6y5fMpcnOJa6k+
 cbecHQij9a6RRp/4YWnOhVuJpidNxcgHXMTKZaYNn+w==
X-Gm-Gg: AZuq6aL5yWrYao4i7m3S2fnBsrutJvOgy7cuGcgIXnpCjj/smPpOlw28BCW8PGMWJm5
 YfTprJezznomWrVJbRhS7t2UBq8Q/ZYPkqrnL5LyBd/Va4oGMAnSg6Bzz/TU3bKSo7FheRIv3q9
 8S33CyGPl52XFICIzrnwigudnW7YqeZoXdizR89nWWVa1Bpx2T7i5Tv5Rt8j7GQHr8sbqFgu9vH
 lAX8X6QP4Z2B5ZZYh9zUWDwN5E00DDuq7EHW0R8D2kIzxlcnUN5n+ivEzT5k69bVjiZTA==
X-Received: by 2002:a05:690c:102:b0:787:cad1:bdb2 with SMTP id
 00721157ae682-7947ac93bf2mr71809997b3.69.1769686896233; Thu, 29 Jan 2026
 03:41:36 -0800 (PST)
MIME-Version: 1.0
References: <20260115-sme2-hvf-v2-0-2eca481bd7ee@linaro.org>
 <20260115-sme2-hvf-v2-2-2eca481bd7ee@linaro.org>
 <2c3bb870-0321-4799-b7ca-65b2772ddf2c@linaro.org>
 <CAAjaMXabRsOX0OVXN202ev3A1sKqMmbDoeY6n7Z-EhmZWmL9Cg@mail.gmail.com>
 <CAFEAcA9oZ=rhUbw8WK5nUPAvs0TEPCJB8t8ReeViv=0b=_x-sQ@mail.gmail.com>
 <CAAjaMXZLG2aBtStRhyvmdENj1Z+Mx05BmDgyYUoYrc_ZnHwyVQ@mail.gmail.com>
In-Reply-To: <CAAjaMXZLG2aBtStRhyvmdENj1Z+Mx05BmDgyYUoYrc_ZnHwyVQ@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 29 Jan 2026 11:41:24 +0000
X-Gm-Features: AZwV_QhiZwgWeiH3_RacpRrXFgRjLYr49rU20GVeVljiCA_drdbnCkdlxNs3Q1o
Message-ID: <CAFEAcA-odFctT+aJb3xXDa_76=WGPRV6eMNdNTnYHqWV=x7VNw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] hvf/arm: expose FEAT_SME2 to guest if available
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>, 
 Alexander Graf <agraf@csgraf.de>, Mads Ynddal <mads@ynddal.dk>,
 qemu-arm@nongnu.org, Mohamed Mediouni <mohamed@unpredictable.fr>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1129;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1129.google.com
X-Spam_score_int: -4
X-Spam_score: -0.5
X-Spam_bar: /
X-Spam_report: (-0.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_SBL=1.623 autolearn=no autolearn_force=no
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

On Mon, 26 Jan 2026 at 08:34, Manos Pitsidianakis
<manos.pitsidianakis@linaro.org> wrote:
>
> On Thu, Jan 22, 2026 at 6:52=E2=80=AFPM Peter Maydell <peter.maydell@lina=
ro.org> wrote:
> > If giving the SME registers a good workout with the
> > gdbstub interface all seems to work fine, then I think
> > we can adjust this condition to be "if tcg_enabled && ...".
>
> gdb had a disastrous workout, because it turns out it also assumes SME
> must have SVE:
>
>
>   (gdb) target remote localhost:1234
>   Remote debugging using localhost:1234
>   ../../gdb/aarch64-tdep.c:3068: internal-error:
> aarch64_pseudo_register_type: bad register number 160
>   A problem internal to GDB has been detected,
>   further debugging may prove unreliable.
>   Fatal signal: Abort trap: 6

I think that if we rebase this series on top of the patchset I
just sent out:
https://patchew.org/QEMU/20260129113455.1283266-1-peter.maydell@linaro.org/
that should avoid this GDB internal error (which happened because
we were reporting the Z registers as zero width, so GDB got
confused about whether they existed or not).

The GDB and LLDB changes to handle SME-only CPUs seem to mostly
be related to the ptrace API, because of choices made in the Linux
kernel API about how to handle SME-only, so I'm optimistic we don't
need to wait for anything to land on the debugger side.

thanks
-- PMM

