Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88AA2C30653
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2024 09:54:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPJA1-0003GC-2S; Thu, 04 Jul 2024 05:53:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sPJ9z-0003Fg-Gs
 for qemu-devel@nongnu.org; Thu, 04 Jul 2024 05:53:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sPJ9x-0007Eu-T7
 for qemu-devel@nongnu.org; Thu, 04 Jul 2024 05:53:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720086828;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lFwN7klfV1Gn22BHhOWAcF3G8RTqVRfrRyy/Zhidv18=;
 b=h9P6Iytix334XkhNL3KCcefqDO55Om1CFgp6aGKVmu7+gLXZT68MGBiSKwr28AhHdybkDe
 mE4Qrbr/2LmqXvpv3ft142bVXVZPMOpQM2CQLW4bpuxrdyEa6i9bB9Uj9WwsXjBq+T50sG
 EdiRvKWusCy2EsYBR6iVSUqhH4xgLCM=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-618-uGawdZMsNN-B0H5IvAMb-A-1; Thu, 04 Jul 2024 05:53:46 -0400
X-MC-Unique: uGawdZMsNN-B0H5IvAMb-A-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4257db9d71fso3338115e9.2
 for <qemu-devel@nongnu.org>; Thu, 04 Jul 2024 02:53:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720086825; x=1720691625;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lFwN7klfV1Gn22BHhOWAcF3G8RTqVRfrRyy/Zhidv18=;
 b=bhls+GH/eLFfOHtJbX4ZDLLWwOJM1lVchZ9VVTr6nEhYZsVitVVPfcq47JI0W/j5nY
 Yotm2vE9+6TxWJtsLLHhXWVuDCUcsfLLuALg23sNlQvHpZgUHwPS+2z0ZfKU0vghJzwN
 0r4uRX32XJzWfgYLe+RFggZ4CAdK5P+Oyte4Z6xpnpPLmqFpgCRek4RcarbvS5i/5I+d
 x8cLsWTUzMp8yDulEnaUHiquWs/e1bKmEezDvKuQfPrnM0Z7YD44GC0KjWuqowcjt3Lm
 98zhL3Wq/YnnL/aOnfNqKIyfO5pUmN9TShkajlzBfHkpWzwF7n+bz7cEGXmrQAvUN/uc
 urnA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXOvyuSfmcW1YMQQxL5NWcuYneo3hWJqOWFIi3bj3kXvhIGcomorlDg4wDT5ofFeUK4JWOkgSI7N1FznVZo7kDh7AcWwRY=
X-Gm-Message-State: AOJu0YyHBE43CNN4h7U6AL36no4LAo1kIjX1y3TRLIZHx6N7jvUGrj6N
 KbxzRqJNgbBe4FqlvbCesv4VzmX2Im1jWL9ZrY88PXrdSeJRJQcVN25ATIeGJfbbvak5q9JkXgM
 qwva7FUU36PB4Ewvtymh+LjLGWwhKniKSG5R34TqpboQ2/GOYue3+ZgTxK1ORbyXWKoPQKEm/MV
 EIsagvOU3IM67DMo2ynkgcDRaZf70=
X-Received: by 2002:adf:ebc2:0:b0:367:434f:ca9a with SMTP id
 ffacd0b85a97d-3679db85af9mr960887f8f.0.1720086825210; 
 Thu, 04 Jul 2024 02:53:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGY/HpM9wSh0ELdFeoqqhrzd44QPH6iJElBQT1rrcFoxhPiV2knLIShRKH29kicVZVdZYH5dBG47G/Xy7K8q4U=
X-Received: by 2002:adf:ebc2:0:b0:367:434f:ca9a with SMTP id
 ffacd0b85a97d-3679db85af9mr960872f8f.0.1720086824853; Thu, 04 Jul 2024
 02:53:44 -0700 (PDT)
MIME-Version: 1.0
References: <20240704000019.3928862-1-michael.roth@amd.com>
 <CABgObfYX+nDnQSW5xyT3SjYbQ72--EW5buCkUuG_Z_JPFqfQNA@mail.gmail.com>
 <ZoZge_2UT_yRJE56@redhat.com>
 <CABgObfbf1u_RvRTcoZFepFWdavFnkqNwUCwHm1nE4tNKmM8+pA@mail.gmail.com>
 <ZoZtxUPdDmnFaya6@redhat.com>
In-Reply-To: <ZoZtxUPdDmnFaya6@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 4 Jul 2024 11:53:33 +0200
Message-ID: <CABgObfZwmvpHE-cadR1yu_a4pftid9=N7X50HBfeCYokLge6-g@mail.gmail.com>
Subject: Re: [PATCH] i386/sev: Don't allow automatic fallback to legacy
 KVM_SEV*_INIT
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Michael Roth <michael.roth@amd.com>, qemu-devel@nongnu.org,
 kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, Jul 4, 2024 at 11:39=E2=80=AFAM Daniel P. Berrang=C3=A9 <berrange@r=
edhat.com> wrote:
> > The debug_swap parameter simply could not be enabled in the old API
> > without breaking measurements. The new API *is the fix* to allow using
> > it (though QEMU doesn't have the option plumbed in yet). There is no
> > extensibility.
> >
> > Enabling debug_swap by default is also a thorny problem; it cannot be
> > enabled by default because not all CPUs support it, and also we'd have
> > the same problem that we cannot enable debug_swap on new machine types
> > without requiring a new kernel. Tying the default to the -cpu model
> > would work but it is confusing.
>
> Presumably we can tie it to '-cpu host' without much problem, and
> then just leave it as an opt-in feature flag for named CPU models.

'-cpu host' for SEV-SNP is also problematic, since CPUID is part of
the measurement. It's okay for starting guests in a quick and dirty
manner, but it cannot be used if measurement is in use.

It's weird to have "-cpu" provide the default for "-object", since
-object is created much earlier than CPUs. But then "-cpu" itself is
weird because it's a kind of "factory" for future objects. Maybe we
should redo the same exercise I did to streamline machine
initialization, this time focusing on -cpu/-machine/-accel, to
understand the various phases and where sev-{,snp-}guest
initialization fits.

> > I think it's reasonable if the fix is displayed right into the error
> > message. It's only needed for SEV-ES though, SEV can use the old and
> > new APIs interchangeably.
>
> FYI currently it is proposed to unconditionally force set legacy-vm-type=
=3Dtrue
> in libvirt, so QEMU guests would *never* use the new ioctl, to fix what w=
e
> consider to be a QEMU / kernel guest ABI regression.

Ok, so it's probably best to apply both this and your patch for now.
Later debug-swap can be enabled and will automatically disable
legacy-vm-type if the user left it to the default.

If you want to test this combo and send a pull request (either to me
or to Richard), that would help because I'm mostly away for a few
days.

Paolo


