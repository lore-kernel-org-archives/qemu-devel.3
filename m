Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8CA2CD3436
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2026 14:40:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wLMMq-0001tb-Gc; Fri, 08 May 2026 10:39:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wLMMo-0001tG-J3
 for qemu-devel@nongnu.org; Fri, 08 May 2026 10:39:50 -0400
Received: from mail-yx1-xb130.google.com ([2607:f8b0:4864:20::b130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wLMMn-0007eY-4T
 for qemu-devel@nongnu.org; Fri, 08 May 2026 10:39:50 -0400
Received: by mail-yx1-xb130.google.com with SMTP id
 956f58d0204a3-65c21049dafso2141765d50.2
 for <qemu-devel@nongnu.org>; Fri, 08 May 2026 07:39:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778251187; cv=none;
 d=google.com; s=arc-20240605;
 b=EVEAoXWkUjYghKmKQbOHXJNnGV4e4h0zCYK2SvxBA33+jYweN6ay8uM3ROijD4/keR
 Hm4q+0gasEyIpwUG4UuLSWXJotVTytSjm0p85+7Vqf9EgkEXUlmpiquAbdnnFU7QIGIM
 gkLJpfAQSPiPXVL3JS8cghgCMlSVIh/NXV+0FUFzkf8PakUjetFJs5lvNmrYVXuqcizK
 txB3AFqnxpMuprVd4k1gbV005EB1sm8E+3G9Q3Y7qgnpyXS1IY3FYBAMr5XNA4P5Aj6F
 Sap269LzU+hdMWhG0iUDHjLmicVeAGCNN5eRFs3+sKKJ/WJ6FA2NiDp97djwq56HNlHK
 Lp0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=mGtj+jBfEzlJnwzXeqe1IxkZE0c3n7RTntHWguXQ3wo=;
 fh=mETJrUA9knZcUYknHzBqf/LXMPxMv4tYjJyItObJ7SA=;
 b=L9nY7Ijfk8rL1G/H8KNWzUnHmT4dRnEtIerKWQ3GgIBnYNowdIlVDIsaygVeD7Lun+
 2pzDf47NImdiC/mcAVjC5qqyNKNxWq19inZI8DexFYEb4471+Z6TVGpFcY0v/x1OS0C7
 VWE0oVPZNDcz33YoPsGCmhmSm3p77lngppTECpTj8ideFKZMcmEKjnDBqmb35smWVUK5
 PELGb+ICVuXt5zcQseK9Ekz6EZ5IVvOFonAUVteeVg8e6DD2MkRrwkEht+0GmTK69svL
 MS//jvxNYDm/o1dtr6hSGCJ4xgwZ1XiCRYw/P8VL9tmtCZfLoRzlmbqe2n+a7sLwUHOF
 p8pA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778251187; x=1778855987; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mGtj+jBfEzlJnwzXeqe1IxkZE0c3n7RTntHWguXQ3wo=;
 b=R7YJi26yQEik1oug7ZBNqmk5gJsPuUz9c9l4NN1JmjCREO8I75Lvs4t50v9QSPNATh
 6p1sA0uTtq/CLW2Z0ExJWoTk4/AW8b4oflMWMYB82KOoZuiPGakFRZ5aYUbBpogqclqd
 PlFKR7hqKLb6yMl7iz4S7CEfh2XqoO09n7t2MqUgvDa4ku8MqbhqxCq4MJs4gt5beAlb
 93aYdz4fjg3ioNkkT92cJFf8ZMe67IWvd/xEMLo6iul7E4EeziqHdupBzt8MvmoH41tN
 FXw5ZrTX9PsUAG4T0Q9viB1nAqgEN6zgiQ30jzaDfI5RvSINkRAcu1IFk8Lup0Nf5C6Q
 Am5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778251187; x=1778855987;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=mGtj+jBfEzlJnwzXeqe1IxkZE0c3n7RTntHWguXQ3wo=;
 b=ogqi5SEQZ7vClJnuYQdL68Gd/3QXYpnsttL55KBfNVZE1Bh9cmDjLcvvyZq5fNGVhJ
 OypmDpK8LC3/tLH260hCoFMxEro6pW4/oUm9R2M3deQA13sQ3sIvy4/VhHmpC+9cbtdC
 PqacmVzEiWMV1M+rSkbAJpbFohA1yEF+TsdY8dxWXZ5x631+vIaRZQvDqwCp/UicUsHo
 hN3jLoL2Swo9b4ixrROs+MrkiYw+63YHfTTwyC2JrFeNFMB3DPmyMQP4qgPrUpUml/WU
 Q7O4TS6ZlaiZv77Y3bu6LP/GWvxY4ZJliEfjcvD2W9v4jVMvsUlPS77Rn45fFCF18pjo
 t8gw==
X-Forwarded-Encrypted: i=1;
 AFNElJ9Pjc6ZXisAcaC4EQB2euB/3JUeQUFqq768USTatoqmDG3uAiqxlQtT2W5rKIiO/YFV7Cnx/HJP7L5u@nongnu.org
X-Gm-Message-State: AOJu0YxarNCM0WyFuaP+eNZPJzBOjXPosx8niKI82Sov9DqB9FpU/WBE
 oH4HMfncZomFfawWkgP8cxHTCdINPwsUz+tBqoaG9H0e3TTePoCSKDCIsg1sqheCvaoFPZJpYTF
 qD7oYKXIQRIX+W6Mt+t5M7wXQNREQy1oLcckt4m48Rg==
X-Gm-Gg: Acq92OEuZ+/53CO+Fy1sYBMMmfc5eYMwercu1wi2xz80Xrw5rsqGf/ckhM5Rx5VkYJV
 EnZ+MtjNRgqK4i8aMSuY+vDQfuW/5HzSToe+gdvmqXA4NGiFJKMDn2wEDlobUi1Y8nTNB+KomYc
 eWTIoOpUCDP0v5dJVyKWmLfcPSmdzvvqpUjY0NeeBdiuUdx0KxWLEAwFMHr3RO3huiofU3tDIXB
 SslGNEhgiA/MZxS/QOVK0ztrpSDCtAsWIhP3v2G96dP0uJI0JHDKYV3rAFdPNbR2QY/muQilt5R
 VSB9fpIDOqr1Xk+UmDxZRhhGf0FGu1WFD61IPEBu7Nn9hCBNVLWzYn4fmFgIwdneqfxg7UvqiQ/
 2SA==
X-Received: by 2002:a05:690e:12c8:b0:64a:ef61:188c with SMTP id
 956f58d0204a3-65d94c95f02mr2750028d50.47.1778251186993; Fri, 08 May 2026
 07:39:46 -0700 (PDT)
MIME-Version: 1.0
References: <20260508102657.644247-1-john.levon@nutanix.com>
 <IA4PR10MB8301FE3A10AA391212B387EE903D2@IA4PR10MB8301.namprd10.prod.outlook.com>
 <af3zEgHy7UMYN4Ow@lent>
In-Reply-To: <af3zEgHy7UMYN4Ow@lent>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 8 May 2026 15:39:35 +0100
X-Gm-Features: AVHnY4KAA2v8D4L6N1AxPINOXiFlvnmmYIBkRx7NXLwsiUo1MYIm9lxeOWJuRdE
Message-ID: <CAFEAcA_sQahkspZ15NP0Hmw9AedH1pHUv__YL_ww3UtmX=LPDA@mail.gmail.com>
Subject: Re: [PATCH] Mark Multi-Process QEMU as Orphaned
To: John Levon <john.levon@nutanix.com>
Cc: Jag Raman <jag.raman@oracle.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, 
 Elena Ufimtseva <elena.ufimtseva@oracle.com>, "clg@redhat.com" <clg@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b130;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb130.google.com
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

On Fri, 8 May 2026 at 15:29, John Levon <john.levon@nutanix.com> wrote:
>
> On Fri, May 08, 2026 at 02:21:37PM +0000, Jag Raman wrote:
>
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 0a90204ae9..ce2b494086 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -4429,7 +4429,7 @@ F: tests/tcg/aarch64/system/semiheap.c
> >  Multi-process QEMU
> >  M: Elena Ufimtseva <elena.ufimtseva@oracle.com>
> >  M: Jagannathan Raman <jag.raman@oracle.com>
> > -S: Maintained
> > +S: Orphan
> >  F: docs/devel/multi-process.rst
> >  F: docs/system/multi-process.rst
> >  F: hw/pci-host/remote.c
> >
> > Thanks for the reminder, John!
>
> (Just for context, C=C3=A9dric suggested this after my patch to update th=
e
> libvfio-user submodule for the compilation issues.)
>
> > I=E2=80=99ll send a PR shortly removing parts we are not longer using.
>
> QEMU maintainers can correct me, but I'd think it has to go through a
> deprecation cycle first?

That's generally correct. Apart from features which are clearly
unused because they were actually broken without anybody noticing,
we have a deprecation cycle where we first list the feature
in deprecated.rst; then it is in the deprecated state for
that release and the following one, and can be finally
removed in the one after that.

However in this case as I understand it the multiprocess
feature has always been "experimental" (as marked by the
machine and device names "x-remote", "x-pci-proxy-dev", etc
having an "x-" prefix). So if we really don't think this is
likely to be being used by anybody in practice I think the
experimental state allows us to remove it without waiting.
Dan, Paolo, what do you think ?

-- PMM

