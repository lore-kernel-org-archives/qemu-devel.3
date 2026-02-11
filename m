Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41800ECD6C1
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Feb 2026 16:00:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqCcP-0008Ah-3u; Wed, 11 Feb 2026 10:59:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ckeong.teo17@gmail.com>)
 id 1vqCcO-0008AZ-4t
 for qemu-devel@nongnu.org; Wed, 11 Feb 2026 10:59:08 -0500
Received: from mail-qt1-x835.google.com ([2607:f8b0:4864:20::835])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ckeong.teo17@gmail.com>)
 id 1vqCcM-0004d3-HZ
 for qemu-devel@nongnu.org; Wed, 11 Feb 2026 10:59:07 -0500
Received: by mail-qt1-x835.google.com with SMTP id
 d75a77b69052e-5062fc5d86aso59451191cf.1
 for <qemu-devel@nongnu.org>; Wed, 11 Feb 2026 07:59:06 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770825545; cv=none;
 d=google.com; s=arc-20240605;
 b=c0c1nBCZ/ss7FLTL9Rcungm3GrnJshxS10mrIjwOxLAr5yanMFH3INmb8yyEIGVgR9
 SYJ84fluKpilb4WpHU+VRqJ3uy44g/0LOkRUUcT6D2z6j7A/JjmrB/vWK1lMoc27nL3w
 9r28+wYrnuEb7L8UIHVXnJSf1nLr6C+QNS038OQXxV3LpxmY2T5XO14EFVs954V8gpWk
 +j04+OirleI3la9+BCqTmBohd8S9ac6re/ZXy1Q5glOUVAuOaAGx+D5ro89kR3Z3hS/H
 XXvN5i/3Ol96ccchOe8vtnxWIZ+vNfQpnIEZflqLwMvHPT4XF/NtOF+zv2q4XwwMIPFh
 Z//Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Pl91R4CeyV88YBAQQEAdbieGUnB5uP/LcVxSz6ZdcRQ=;
 fh=816itPJgJ05r90TtzCCMjxMj438b0MmMMtWJHJey0jI=;
 b=Np2sZ3r0stCt/DPDn/JqjDU+ZMXYQGGgkvXRE66v4GOvXYdzFNrIGVcTbyirHmecIB
 qKegsbg84jO89ZcSuaoq0Zjf1XiNK08g0fTdHuQBSG2BqHIBaDdCiRktO+J/Mzf57A+y
 wT1Wyyo70VAQJ4SEtY5HuMcZvG9tWrgeKZU3M+XvmzAqDncnGWHz/STCQpxhk8/91SaJ
 CAioWKCMIU2SaVov3GUadQgeEfZzWlpfSeLwPE7OzTqVMZ9iIbFMtGdoacCQhpsT4JrK
 bavZgSNmWIQmBVM/LeQpzo9ML978wDb6vCbQEAczxL+fDnkzVcrAsesFzC/9S4KcWFVL
 6gMA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770825545; x=1771430345; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Pl91R4CeyV88YBAQQEAdbieGUnB5uP/LcVxSz6ZdcRQ=;
 b=gY4Yr6knjpZS9lgK3lWY6tZC0goH8W/Ny4glYs2tOWEB11QdfoWB2i2bd2fqfzWftU
 Zqu9zgL/YZP4ahj61X65w3Mpx+dabrglfAR4m/l75v4P18PYYJFDY/QisCL1B9szCc0H
 k6nXC9J6/0LXIQ3tjIIEHNAz5v2Ys/AGNw+5LfJqU3qwL+enIHdg3lcR/tHzWyc9tYKa
 UvPgGQrO25LRI0S3Wl4sUL1NV5jS91gtSngpziqsvn7BqKodrjcH7ewDlgi21+nwXUXu
 F/imU0hO/QOhn4YgeC9KknWuDPtu476B73rzT/xJ9jBaIph9fO7DS3CHmEECreDSunDj
 EGaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770825545; x=1771430345;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Pl91R4CeyV88YBAQQEAdbieGUnB5uP/LcVxSz6ZdcRQ=;
 b=JPVj1JgNn/HvlucVQo+QZAWC3Jh2fjKfwHRdP3zKxvMQei9WLgI5/OynqlTGdtHlm7
 SzTjDrRiu81IPajTNkM+DiWzLVNat4IH8scgEfiMgMeZ8HcPEVlqRn+0AbUWxRA6uahn
 aOqw1eQVVEXzUnDoekuYApIfan9/RvVryG3+bDE6HnglpgLIQAUARFcYXVkhpkKDdd4H
 9K/3dbRmaRPMbWZTNl0k0qHKNf+CpaMVgqNYvROGnMUIurT0WsJ5C+4wXiUHnlQVGvq+
 l2Pl6AoZUrULa24h4uTJty1cpI5rNylQlyO5+EULk/z6nwB9mygTCn8eHK4+2yyhDAxc
 PGlg==
X-Gm-Message-State: AOJu0YwzTF1g1CV6kEZ30fU5NmUf1bhSwdFwBaDbo7lLOPtRmiZjXAYv
 rN4ySTTCI0PUVB1QM7d26xswatPZ7K3huSr4CY9C/DgRsT2irJ6I8NEFP35juIOy5u+Z0cvZvuW
 etCgN9Bc4MVstGTz5vHie4cQ9tRtDZbs=
X-Gm-Gg: AZuq6aKe96oqarKm267L3rHs9TzTpy84y8l0B4Ge1fjDi57n7yDDfrTAge4BhbntAe0
 QloZ4Yb7kThAuH8LJuCd7Q2i97ySZUSqJevw7+x4UUm+2b1bbPXrXf+pWw3eV5WW74cq3AS9gAr
 EheroTW7CN0zx5qHIw51R+KaEenPxnkQOS9KI3KeIUEDfZOJLDKtjig2NzgzFIH9gdBlhz8E1gY
 Aklu5fPlH4TyNFxi6dXpjDh1HsNjsdVLRPOffozWmj8bsJGYcKzfyviNLjW5+3hvilI9aMGpory
 +OnfdDwqwD5CZBu99B68KsZ3zXj0oxCBxCI30A==
X-Received: by 2002:a05:622a:1482:b0:4f4:c080:15e5 with SMTP id
 d75a77b69052e-50673cf1eccmr87221661cf.1.1770825545151; Wed, 11 Feb 2026
 07:59:05 -0800 (PST)
MIME-Version: 1.0
References: <20260211065826.3974-1-ckeong.teo17@gmail.com>
 <53fdcc9e-53af-4a84-89a4-e15c008633c1@redhat.com>
In-Reply-To: <53fdcc9e-53af-4a84-89a4-e15c008633c1@redhat.com>
From: Choon Keong Teo <ckeong.teo17@gmail.com>
Date: Wed, 11 Feb 2026 23:58:53 +0800
X-Gm-Features: AZwV_QhYaOjY2ZmFKxoXqqVOJgPmJS1o95L-sQghItWjW3u2pVYquDP6OBdq6zk
Message-ID: <CAOkKuiOkP50bWByZQ+QesiyL+rvbQYhUkSamPKiew88jMwzxTw@mail.gmail.com>
Subject: Re: [PATCH] hw/i386/pc.c: add description for fd-bootchk option
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, richard.henderson@linaro.org, 
 eduardo@habkost.net, mst@redhat.com, marcel.apfelbaum@gmail.com, 
 Peter Maydell <peter.maydell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::835;
 envelope-from=ckeong.teo17@gmail.com; helo=mail-qt1-x835.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

Thank you Thomas, this is a very helpful suggestion. I will change it
and resend the patch for review shortly.



Best regards,
Choon Keong.

On Wed, Feb 11, 2026 at 4:36=E2=80=AFPM Thomas Huth <thuth@redhat.com> wrot=
e:
>
> On 11/02/2026 07.58, Choon Keong wrote:
> > The 'fd-bootchk' option for pc and q35 machines currently lacks of
> > description in the help output. This makes it difficult for users
> > to understand the purpose of the command.
> >
> > This commit solve this issue by adding description using
> > object_class_property_set_description() in hw/i386/pc.c,
> > adding the the description message for the option 'fd-bootchk'.
> >
> > Suggested-by: Peter Maydell <peter.maydell@linaro.org>
> > Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3193
> > Signed-off-by: Choon Keong <ckeong.teo17@gmail.com>
> > ---
> >   hw/i386/pc.c | 2 ++
> >   1 file changed, 2 insertions(+)
> >
> > diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> > index 5cb074c0a0..eb39c18788 100644
> > --- a/hw/i386/pc.c
> > +++ b/hw/i386/pc.c
> > @@ -1822,6 +1822,8 @@ static void pc_machine_class_init(ObjectClass *oc=
, const void *data)
> >       object_class_property_add_bool(oc, "fd-bootchk",
> >           pc_machine_get_fd_bootchk,
> >           pc_machine_set_fd_bootchk);
> > +    object_class_property_set_description(oc, "fd-bootchk",
> > +        "Enable/disable floppy disk boot check");
>
> I'd maybe use a text based on the description from "-no-fd-bootchk" in th=
e
> qemu-opions.hx file:
>
>   "Enable/disable boot signature checking for floppy disks in BIOS."
>
> ?
>
> ... so that it is clear that this influences the behaviour in the BIOS.
>
>   Thomas
>

