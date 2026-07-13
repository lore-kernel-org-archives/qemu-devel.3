Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2261FC44501
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2026 12:31:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjFne-0003Zt-L6; Mon, 13 Jul 2026 08:30:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wjFnc-0003Yx-NO
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 08:30:16 -0400
Received: from mail-yx1-xb12a.google.com ([2607:f8b0:4864:20::b12a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wjFnb-0001mp-3i
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 08:30:16 -0400
Received: by mail-yx1-xb12a.google.com with SMTP id
 956f58d0204a3-664db84f074so4772578d50.0
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2026 05:30:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783945814; cv=none;
 d=google.com; s=arc-20260327;
 b=SRG4+3Cp0dRuR+UKQfORlJ5K2T7Z0P7uPbWru+mSxy50rgovKKMpQrtoUsQffbFu9R
 TJ0eLRKn7ZZTCyMNcZGXTpRrS9TGke1aUTe7HXmB5q+aRJseS8L9i9n6bl9KxxBNeEan
 kOfnb6qAWQ7oOPULGyotld9j5MMrRzfcfKBd11W81B6qCfC0Kx2ACwU/7MxlCnNRq4ez
 /OSfL70sYRGyGz8o6NekLNRBBPy9YsIfQJx1+q0n9gfTfhN0iCXyjgxXQXpofTunwdq1
 5XH+Sj7pmLdI/Kol6JIskY42FFzre6wftcuIDuwNCUwSBOdydgZXSQ71f3mmJOJ+kb/Y
 rZCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=+ybV/j2by3J1u5959bamM1uqiY6miBdVJuaDY054d1k=;
 fh=pkpBMAgDwVfDlnZww9MIpqRzzs+R02DTUqHHvkr2M6M=;
 b=m1cZeezVBuBsX82ccWmQb4VsG879C85SnRavbdiqVvycP7i7q1EBSHY2SOXNl/yANd
 ouWNgi3dxKXbz9/USCaIo7KutNAb7TZ+PD+yPmKI5hMl9NZS4F4LsbX2YqG/CSExP/My
 Xq77UNsid4ZXSmnHZySj+3dX9E1jhJQ1HbLgbzXR8l0QRNW56SyiEF1k7zrml+zCWxuQ
 fm18H5+Rm31IkPstGHPQXEFcjXzMjerzmrH6vTuKUOdR+KeZJZ5m5SSuDkVxLNhbS4rr
 c2EixTxCupFHcR4RHhwd36vWukB1V2Ak8WjJ5HrYdVEESyW5THPv2WlXnXPmxgA36Z3y
 KHBw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783945814; x=1784550614; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=+ybV/j2by3J1u5959bamM1uqiY6miBdVJuaDY054d1k=;
 b=raUHKNYOYLKOMVD7QSzyOz3mR5Ys8EQpE51w2zcYkQlVEc1dJ03Q9xrvjr4YMPG2j5
 Es3VrcjiQn/9Vm3AatMuDKid+dUppz0OpzEPib+BlwPRvtuWW0tN6dcwFQCD6R8+4jwH
 kiG39HnxWxl97KoMusBb2Lf6UaWrD7opyU0gsQYPNL58j4OxdCrXAP57gs/4dzJwXukZ
 s27awrcOKO4RcVUKlWV1tWUp5z0bJ/yx/6b3G0a2ye8FkX54uovhofODRezoeia7kEdm
 k5vfUw4eSh0/uA6JGcG/BsNkR63b7zxpd8deL8WVBw/dxNZE1KHfNzPeFUs01W+c2q+y
 roCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783945814; x=1784550614;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=+ybV/j2by3J1u5959bamM1uqiY6miBdVJuaDY054d1k=;
 b=tLhwUzA1OGfFODojzj5pe7OItEOhE+9PqLWnO4pcs1Li59cFdsDG0r44Xb/SboPRBk
 EzozqPe4LF0Xs1PxC+H1cHwGK6hDsfmCU74Goma3Q3jp+sXTHz0B4/pa+XDZeu+wMX/t
 cRiCwGdMKNzde4zMmrguXqX2ssx2gYYEIwEOxytsi2Xm0i6kvR2vaRuwZJvZ/AjxaPWh
 EkhiH9q2QC2F+iUvcVEDbh1Kj8Tn1pzXWRPr8XsWmuRQYeyCozaHUOeR/GhwhFTtqugg
 o9u5o1HJW7k33AODYqffk1hVEAez67kWIvj6TxYx3Zoy6+n/aBpG5n+G57znwNc7y/SY
 8AtQ==
X-Gm-Message-State: AOJu0Ywjm4yPexoaArFQSEUOC7ZWSqsyf4VhxYcE05cMdmCkrBIGlxlZ
 i9hNNEg8h8xNswWScqXsJaY6QZo9YpeHeNgrlxDg0bCOg0Y1rjKlE8kNKaWUArmLGzErZB+RqcV
 XxeYrUNFh1V5U6O+LKTsFUZpXyDdfNYAGjq99XUQDHg==
X-Gm-Gg: AfdE7cmcGq1SVJqc4ME2xK21/dCrFPHL7nCmaAu6GlNJSvIe4xL4Lt/9n359r5zAGqb
 eX+AQY1fgHdpfscBr91IIEkZWla/tkN6EpgPg67h5MEs/voWMs9C7Lx7Pf395JDc+Qgvo9Xi2v2
 Ue5ro42i22vsBy+2SH3YtKPLwpx7FGFx6fa/kL3m6cWblLaSaPkWRsOY0UGkcNxlKIKaszhVZxC
 T49XzHRC0Cwg/FOstCuUUWa/aQUCS/lSgt1yy0AvpQWc0jwfQUC7F2G6nTr9Y5CNzRi4Hvru9v5
 vr/2z5KDTspZ+FIOebBWnaYJy+pYEsoaNGfaaRnd7/m+fxJqjYGQ4c7G
X-Received: by 2002:a05:690e:b83:b0:667:cf87:5838 with SMTP id
 956f58d0204a3-667d7b3bed7mr6039924d50.25.1783945813430; Mon, 13 Jul 2026
 05:30:13 -0700 (PDT)
MIME-Version: 1.0
References: <CAFEAcA_zmc=Vvs38Qos_gecCmGAbRgDQF-0+x85Ja66nsqrHxA@mail.gmail.com>
 <alSkWHw6ryhEEaDf@redhat.com>
In-Reply-To: <alSkWHw6ryhEEaDf@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 13 Jul 2026 13:30:02 +0100
X-Gm-Features: AVVi8CdoaDe6c1VntWaFXN8kG1FRcMc8wBAHJRV0XYcoOHMtBM5Mp_fFWumeaYQ
Message-ID: <CAFEAcA_6TDhB1vDgb04QvF-yJUnL=1aTuz7cnhJAkFFi-9Yc3A@mail.gmail.com>
Subject: Re: what is qemu_system_guest_panicked() for?
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>, 
 Pedro Barbuda <pbarbuda@microsoft.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>, 
 Nicholas Piggin <npiggin@gmail.com>, Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>, Eric Farman <farman@linux.ibm.com>, 
 Matthew Rosato <mjrosato@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12a;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12a.google.com
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

On Mon, 13 Jul 2026 at 09:40, Daniel P. Berrang=C3=A9 <berrange@redhat.com>=
 wrote:
> IMHO we should NOT be abusing "panicked" for cases which are
> not guest OS panics.
>
> Adding new QMP events is cheap and we should do so. We need
> at least a "MCE"  event.
>
> IMHO the "unknown / unexpected" VM exits likely deserve a
> different event again.

So what classifications would we like here?

"panic" =3D=3D "the guest OS told us it has crashed" is pretty clear.

What is "machine check exception" intended to mean? Is that for
"the host hardware has a problem and we don't have a way to
tell the guest about it" ?

"unknown/unexpected VM exit" feels to me like a subset of a
larger category: "something happened that QEMU can't handle and
we can't keep running the guest". That "something" could be any of:

 - KVM/another accelerator told us about a problem
 - QEMU doesn't implement something and the missing functionality
   is serious enough that we can't continue guest execution
   (possible example: on Arm, an attempt to execute from an MMIO
   region: we can't do that under an accelerator, and we can't
   really continue the VM. We could feed the guest an exception,
   but it won't be expecting that.)
 - the guest did something that put the VM into a state where
   we can't continue (e.g. s390 going into an exception loop,
   or Arm M-profile Lockup state). On real hardware this would
   typically result in the system sitting there doing nothing
   useful forever. In QEMU we could emulate "do nothing" but
   it's probably more helpful to the user to stop the VM.

Categories 2 and 3 you can get without KVM, so "VM exit" doesn't
really apply there.

Do we care about splitting those up? Is there a good name for
these kinds of failure?

thanks
-- PMM

