Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACB64C43458
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2026 13:43:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whp1m-0007oc-0G; Thu, 09 Jul 2026 09:42:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1whp1f-0007ns-9v
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 09:42:51 -0400
Received: from mail-yx1-xb129.google.com ([2607:f8b0:4864:20::b129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1whp1d-0004wJ-Ar
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 09:42:51 -0400
Received: by mail-yx1-xb129.google.com with SMTP id
 956f58d0204a3-667627ae83aso2508936d50.0
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2026 06:42:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783604568; cv=none;
 d=google.com; s=arc-20260327;
 b=SzxJ4xfwpUT4qju89v9ZkM/c+GiyoQeGnfi1Iv8DW8setTADJtoIPQ0M5gTVdPJCGF
 T0Fd8ZgMQdnAL0ulYTLTktH22XzLyIg8Jro7xcgsxIwuWjhdQ8urDXFtB4aHKEdjuqa7
 PoVCgm4huzthfzque0vKWGGqd6sVQw+aqJD0rRBYEnPcxUkwE1awgRDFCrD5BDULGybH
 ef4CwR158gcLJ6+9e9KlkqSETrAz4qzIqzse4K5fRDuR3AhBC8D5OrZuXSiMYiQ3UMak
 M+cegHXyVWSLVsfMRjDf7/w8B++rUuLsOcYuvEiTIBurz4KkzDAU7GeYV7hRSw2Va8V4
 Ecbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=4f47UdzlpaPaLaEHs49RxH5ctcH6rW/5dLJR9+xiMVs=;
 fh=Bptd14tCRVfFJ/wvH3Hgwgzs1fHSqMw9RxsN16lyQDM=;
 b=hP7XK5h15LtWIGb+HfBLcbO+KToiAo/YcRlQQ2H7/Tl/GpgtXnLJsMD9h6wELwLCBs
 fSkzNOJywnJwq92R44DBF6HcVsvnhw5Kl05IqfgNMK/CIP/fDgoDomdEZY5AIlRBcULN
 hR69JFugvr8ncxHIOekbgiHncDAMQDb+h5B1XmFA8GtAVrbraFAZL1UtUuoLfFaEqXtI
 bRP06Qp52UQLxfQ/Vw0HBFiRaryq6axhqQWt3bSpVBLL+ixD9GZ1Ypd2Oh1H9FpiuXcM
 kLve1h8hr2zaWGp5l7JZIBnDEyHqvZd1J4+tRAnR9JLbcvQdGg6GSs0bXSCKFyGwNPPW
 VBdg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783604568; x=1784209368; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=4f47UdzlpaPaLaEHs49RxH5ctcH6rW/5dLJR9+xiMVs=;
 b=UKeBXfdxSWRkSwXPnyNAi2d0DRGVA1NxQ0YARLXCrDFg6eyp7VHqv1ra/yLqSMzkDK
 G7nEAND2WyO5x4McL9kHxgTLv6RbG8oZY1TLCtD31lCGwXjQQr6AUVn6ownLU2Cdcctp
 pD+M1DqzVlbb18Y57jo0qQY5V4iu2pKTpk9YMxINnsmNjsqP2Olk+uVvzzHQqHnsyUj2
 bM/yO+rFqTRKN05EIEDIVIMEB33ARlm+UYxBlBz373BX6/GhH8igfAOMf4yLS3MgaAXf
 OVU8RdrchZvTvC+IY+UEE5k/MNZZPPWPNCppKesM71Mlpr6fw7ct6Rnwitax0jmOM0wj
 zw5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783604568; x=1784209368;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=4f47UdzlpaPaLaEHs49RxH5ctcH6rW/5dLJR9+xiMVs=;
 b=bhqprb+Cr548JHzaN/u2Ohl6C6WchtuITFq2UWau9L2jBs2lPeaNCDTW59psFX2zo7
 TujFjJdpKvS/u5eYtDBywt7nx5hKJdnmj8M6wvH70Zx9b+dtXzZTylkKap68z8reEpn0
 IW6rR4A+BkW2v2KIyeznaAK3zIQ3iySUrIhGHwBG97wS+29PjPW6xoj1VSFHDdxifH+e
 EuhKAjEV7+X0ZE/rnXKhg44xIWn3d4s5d8sS6OLTlYK4zzynbs03CxXSGy8I+BqLWNAk
 2OW+vO+9doT3cfSk3la1cRtwrJCWMfX0mxtp5zX0KD2UpJ+UFCe7AZhcXxM6S/w7m5YK
 wE+Q==
X-Forwarded-Encrypted: i=1;
 AHgh+Row5Wjafp7JqDH2IsvrsqEWLFZ8bRuzAwPNIjxFvtNGV3ohGURkp17TR9SmxoDf0ruhXla0XCjHU2KG@nongnu.org
X-Gm-Message-State: AOJu0Yxbm+Nb/BrBj911cS8lGxbwcErjc7t0i4EMKVhLulLIiRjg8t1+
 q727AhCxhBPocW7davgEx+y4GcRc70aP9LNdYRXExY4c28F8iWkfF9vSmdDdF5vzPTf+RBkQqEI
 y9qYaJjSDqpcdc2nOZVCE0rTU9gjxq4bA/IzBomiZoA==
X-Gm-Gg: AfdE7clM7iN9BbCg1DSnDyr5uZXYWLezVuuO6YX86qkNzV8iOo2V69sCSt7Cr9mjXqg
 +YOkytV/isMo0w0C9z7qZRPSN1md6s0kn46ansjQEzzFVEuCMXhD2E9LeALJKAMqJ4uGmAH7YmS
 oUUxnZAoeZ33eZWXFJXXYRS7JBmNFwMkTfD/x6fPojLPQWosbE1b7DJBr9USdfYMdJKnFz0JqEK
 4uSwvSNzRGdVZpoPyeg6xi8m3kf4/fumvA/mti2/TgqVvV1Sgl6F6fTt02aQvStttOCQdOw+H6z
 4WOg0vTE34Oez58RP/osgmZGbAktreRO2A4Qh4R2zZOgNFmH+vIzt205
X-Received: by 2002:a05:690e:d4e:b0:667:67e3:4747 with SMTP id
 956f58d0204a3-6679f00e6dfmr4896508d50.15.1783604568011; Thu, 09 Jul 2026
 06:42:48 -0700 (PDT)
MIME-Version: 1.0
References: <87o6gge6b0.fsf@pond.sub.org>
 <CAFEAcA9goRQuxw3VD7AqUOHHTdOXu8MSfCxdQMBviE3QgGD58w@mail.gmail.com>
 <87zf00cn7m.fsf@pond.sub.org> <ak-i1dNY_RrGNHAM@redhat.com>
In-Reply-To: <ak-i1dNY_RrGNHAM@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 9 Jul 2026 14:42:36 +0100
X-Gm-Features: AVVi8CenNDKnjzGdESqchhDSqsDMSy6UlHlkVjZbw6v6FR4WVJLBJc2NNjTeOAY
Message-ID: <CAFEAcA_=rz22ZqPr77REQa5BJRZVuEkriq-gJ9xGg4E46JPUxQ@mail.gmail.com>
Subject: Re: A few Machines crash when "no default audio driver available"
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org, 
 Jan Kiszka <jan.kiszka@siemens.com>, qemu-arm@nongnu.org, 
 BALATON Zoltan <balaton@eik.bme.hu>, qemu-ppc@nongnu.org, 
 Huacai Chen <chenhuacai@kernel.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@mailo.com>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Gerd Hoffmann <kraxel@redhat.com>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b129;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb129.google.com
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

On Thu, 9 Jul 2026 at 14:32, Daniel P. Berrang=C3=A9 <berrange@redhat.com> =
wrote:
>
> On Thu, Jul 09, 2026 at 03:22:05PM +0200, Markus Armbruster wrote:
> > Cc: mainainters for "Overall Audio backends"
> > Peter Maydell <peter.maydell@linaro.org> writes:
> >
> > > On Thu, 9 Jul 2026 at 12:44, Markus Armbruster <armbru@redhat.com> wr=
ote:
> > >>
> > >> I stumbled over ARM machine musicpal, PPC machines pegasos1, pegasos=
2,
> > >> and MIPS machine fuloong2e crashes.
> > >>
> > >> I run them like this:
> > >>
> > >> $ qemu-system-aarch64 -M musicpal -nodefaults -S -display none -moni=
tor stdio
> > >
> > >> Died when device_set_realized() tried to propagate a "no default aud=
io
> > >> driver available" error to &error_abort.
> > >
> > > Is this something we want to have be a possibility the devices
> > > have to cope with? Can we have the "ignores all audio data"
> > > backend be always available instead?
> >
> > There's plenty of precedence for /dev/null-like backends.
> >
> > > Otherwise every audio device needs to cope with "there is no
> > > audio backend available" and implement "do nothing with the
> > > audio data" itself.
> >
> > Yes.
>
> We've got a bit of tension between "no defaults" and "builtin audio
> devices" here.
>
> Cnosider if I had instead done
>
>   qemu-system-x86_64 -M pc -device ac97 -nodefaults
>
> It is not unreasonable to expect to see an error because you asked
> explicitly for 'ac97'  and forgot to wire up the required audio
> backend, and asked to NOT have any defaults.
>
> But with your 'musicpal' machine example, you never asked for the
> frontend device, so you should be forgiven for also not asking
> for a audio backend.

Ah, so this is because of -nodefaults, not because QEMU was
somehow built with no audio backends in it.

> If we guarantee a /dev/null audio backend always exists, we help
> the second case but degrade the first case

As a possible analogy, for network devices we just warn in
the analogous "device created but no backend wired up":

 ./build/x86/qemu-system-x86_64 -nodefaults -device e1000 -display none
qemu-system-x86_64: warning: nic e1000.0 has no peer

and the effective behaviour is that output packets are dropped.

We could make audio devices do that (which would be basically
equivalent to "if we need an audio backend and we don't have
one, warn and create the null backend").

-- PMM

