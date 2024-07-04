Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 297F0C30653
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2024 09:32:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPIoS-0005CY-Gj; Thu, 04 Jul 2024 05:31:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sPIoQ-0005CA-6a
 for qemu-devel@nongnu.org; Thu, 04 Jul 2024 05:31:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sPIoO-0000Ic-Jg
 for qemu-devel@nongnu.org; Thu, 04 Jul 2024 05:31:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720085491;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kxNojJQhevmJiR5jUJTMNLDBmomzLCrmfrhYNJxWwrk=;
 b=VoQLTDuGpdVpckTCqfoBcQ5XzfF3DmkQNA5AksaZQcw5ZTS149tNsjrlM8dnS5vYJetQfm
 HrrVx1tEtLCJEa/LHxr6IbtbkCf9gTA6daQM9RPh34OspbKfMQvIBJNrGGRUjaj67jyP7X
 hS7QzAWtCIvq1JeGp2CLW7NtoD63xrs=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-528-XNvov1_qPEivJnoVRVKw0A-1; Thu, 04 Jul 2024 05:31:29 -0400
X-MC-Unique: XNvov1_qPEivJnoVRVKw0A-1
Received: by mail-lj1-f200.google.com with SMTP id
 38308e7fff4ca-2ec4efbbb7aso4069161fa.2
 for <qemu-devel@nongnu.org>; Thu, 04 Jul 2024 02:31:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720085488; x=1720690288;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kxNojJQhevmJiR5jUJTMNLDBmomzLCrmfrhYNJxWwrk=;
 b=EQSWOI6j/P0cUHdGof/7+TzYC5sW4TFo2xZPq0cgnS7gAg84IMMKXfCmJNVXZMQU20
 ZNnb+LhMjoeEjHx5ypQr+sby0cSrh9/SP0saXfFUjAP7SiS6FqtSbeMAyG/bdNtMjCwP
 cJW9NPQg0Y2uf35atzYFI8WoMVUkaB/1TG6lQNZgadpnzBEhGBKUaiVVZ8OLjwH2i8ns
 822fkiQw0iPOH9wOkZLNDJSao5WBfg12sskKgX6aSRwXQCJif87YpwrSmM3V24u/Vk0U
 8HIzxJXtst765x6AWILb0Qj5LJgrB3gH1GXRRc1J1U/nZNHbRakf5F4hMjKCheUS7PXX
 HeLg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVNQqFYlfdStoRPzj1hCNeHw7RQ8zOCMZI83ky3bU9FTPzEIJrNb8uvFIXF0zcM7tCeiqQlyVd0omyKkghYdBQ10jdkgXU=
X-Gm-Message-State: AOJu0Yy7hWcl+PXzyd99MbvoL45Y9azslI0HRuwAileUarHCVHik+Dfs
 Lu+uQafJHYJTf/YFmiJlpslv7Rux32sjtemHPKmK4hGSbfPw1BexnN2EUv6OOAu5N0GIfYr1u5u
 6P2FRrj2ZzDo5Y6Go0CaVfonsXq+dLEyZu8iNJVnLwev7WkJb5UzIYYKRBl3V6tc2Z6CtfqRz8/
 RxEerljeIZb6EDC8NSLjV2CVhGFJ0=
X-Received: by 2002:a2e:9ad4:0:b0:2ee:8566:32cb with SMTP id
 38308e7fff4ca-2ee8ed91179mr8615431fa.16.1720085488333; 
 Thu, 04 Jul 2024 02:31:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGVbVO4d+JOSmyjsLo6p8Y4Usmvfss8knt2bViouPT6u4HSsDLVbHbNmD8TcEEVPjVTziY4gUfUv0aH0IDagiM=
X-Received: by 2002:a2e:9ad4:0:b0:2ee:8566:32cb with SMTP id
 38308e7fff4ca-2ee8ed91179mr8615341fa.16.1720085487933; Thu, 04 Jul 2024
 02:31:27 -0700 (PDT)
MIME-Version: 1.0
References: <20240704000019.3928862-1-michael.roth@amd.com>
 <CABgObfYX+nDnQSW5xyT3SjYbQ72--EW5buCkUuG_Z_JPFqfQNA@mail.gmail.com>
 <ZoZge_2UT_yRJE56@redhat.com>
In-Reply-To: <ZoZge_2UT_yRJE56@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 4 Jul 2024 11:31:16 +0200
Message-ID: <CABgObfbf1u_RvRTcoZFepFWdavFnkqNwUCwHm1nE4tNKmM8+pA@mail.gmail.com>
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

On Thu, Jul 4, 2024 at 10:42=E2=80=AFAM Daniel P. Berrang=C3=A9 <berrange@r=
edhat.com> wrote:
>
> On Thu, Jul 04, 2024 at 08:51:05AM +0200, Paolo Bonzini wrote:
> > On Thu, Jul 4, 2024 at 2:01=E2=80=AFAM Michael Roth <michael.roth@amd.c=
om> wrote:
> > > Currently if the 'legacy-vm-type' property of the sev-guest object is
> > > left unset, QEMU will attempt to use the newer KVM_SEV_INIT2 kernel
> > > interface in conjunction with the newer KVM_X86_SEV_VM and
> > > KVM_X86_SEV_ES_VM KVM VM types.
> > >
> > > This can lead to measurement changes if, for instance, an SEV guest w=
as
> > > created on a host that originally had an older kernel that didn't
> > > support KVM_SEV_INIT2, but is booted on the same host later on after =
the
> > > host kernel was upgraded.
> >
> > I think this is the right thing to do for SEV-ES. I agree that it's
> > bad to require a very new kernel (6.10 will be released only a month
> > before QEMU 9.1), on the other hand the KVM_SEV_ES_INIT API is broken
> > in several ways. As long as there is a way to go back to it, and it's
> > not changed by old machine types, not using it for SEV-ES is the
> > better choice for upstream.
>
> Broken how ?   I know there was the regression with the 'debug_swap'
> parameter, but was something that should just be fixed in the kernel,
> rather than breaking userspace. What else is a problem ?

The debug_swap parameter simply could not be enabled in the old API
without breaking measurements. The new API *is the fix* to allow using
it (though QEMU doesn't have the option plumbed in yet). There is no
extensibility.

Enabling debug_swap by default is also a thorny problem; it cannot be
enabled by default because not all CPUs support it, and also we'd have
the same problem that we cannot enable debug_swap on new machine types
without requiring a new kernel. Tying the default to the -cpu model
would work but it is confusing.

But I guess we can add support for debug_swap, disabled by default and
switch to the new API if debug_swap is enabled.

> I don't think its reasonable for QEMU to require a brand new kernel
> for new machine types, given SEV & SEV-ES have been deployed for
> many years already.

I think it's reasonable if the fix is displayed right into the error
message. It's only needed for SEV-ES though, SEV can use the old and
new APIs interchangeably.

Paolo


