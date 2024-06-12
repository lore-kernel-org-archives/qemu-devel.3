Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05D74C27C77
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2024 11:14:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sHLud-0003uo-2z; Wed, 12 Jun 2024 07:13:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sHLub-0003uK-M2
 for qemu-devel@nongnu.org; Wed, 12 Jun 2024 07:13:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sHLuZ-00041A-Ti
 for qemu-devel@nongnu.org; Wed, 12 Jun 2024 07:13:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718190782;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OMQRfjpXB2+u1KrqSoO0tbVZRg5Oa7NhF6Rw8wH0UHA=;
 b=OZxkIJDUjleIj8Sjh/5Z1hHpX74nPMbdyaEyBSv/CU/UF3EAp2Kdudz7jBf0fE3EoF0LXX
 tG/vR42wG94SPNuQGyij80JciUOWC+WxoHrfjU3qoGgVmTIIXeRr1U4Tc0CsoY8l+Mjo61
 9y9KnPfUTrVtarCt8y313zXh8OJDhWY=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-7-Zc5Xzno6MWKe_VEYeX0UNQ-1; Wed, 12 Jun 2024 07:12:57 -0400
X-MC-Unique: Zc5Xzno6MWKe_VEYeX0UNQ-1
Received: by mail-lj1-f199.google.com with SMTP id
 38308e7fff4ca-2ebd5d5e151so35684901fa.2
 for <qemu-devel@nongnu.org>; Wed, 12 Jun 2024 04:12:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718190776; x=1718795576;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OMQRfjpXB2+u1KrqSoO0tbVZRg5Oa7NhF6Rw8wH0UHA=;
 b=lGq/8Lb98oEdI9xxWNl2O/airDFXkw8C1t7FZuCiZRQ7w+T0wC2srK+FMiBR7YjudN
 C+0Lo3f2oigXaMiOl+JW8KycTE48swseWU67DwtDgj49NF6kHGpqpsIhBl/ngXbWPkgF
 o1GQEJey9fM/c79OqR5iM3MeFS3ayZu7N6/fr1doyrGEV55f5TTq4wsrozZyaGm1NmJq
 BMDKGCOE5Qoq7eS5EEBd0icZipaMDAf+O6IjPteUbv8Dpj2H3qBvHfqbjLRxjyncLHn4
 MOT1LwES160UFyztck3ZqqJGBms3HxH3LT+E1bPnd9zzRuAsVnBRhrFRBlvWxB/hH40d
 XWrQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUYVMzFybLRf+96HC0Gk3+4/4pJ6UszyxSZ1s6efKRPgq0DtK9E9ig8mgoGcpEowSemylefgFqTsEgadYPPfH4MnX+dqU4=
X-Gm-Message-State: AOJu0YwsDxm5/O5WiasDoSSDm2uT2ORXzdu9Ly0pvnCCrRo44Ol6Y014
 LQB1sfM6O69gsQ44RoyPdFwdwFwIeX+V3IQ0vHAY/JXL7bXhmB+Kv+tvsx42w8s+feWkHPzmRDa
 fvoTT30KKTvo2fnRAk6H3CmEpX8OEnBcBghD2ASpRozl7xgn16Hq11cLBNtXPcfvbbncc4Q6Dkr
 M79PBWQQWoXPEWobHPufz+9zAsaZM=
X-Received: by 2002:a2e:8196:0:b0:2eb:e505:ebda with SMTP id
 38308e7fff4ca-2ebfc99f605mr9218921fa.42.1718190776397; 
 Wed, 12 Jun 2024 04:12:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF8pBo6d3UlaqhHrlbaYBIDvrVllX0yxtJcFjZ5nT4WFW1WIjgZPCDOaF+8fYBt01ETUxYVRVUNQ/UfDweJQZU=
X-Received: by 2002:a2e:8196:0:b0:2eb:e505:ebda with SMTP id
 38308e7fff4ca-2ebfc99f605mr9218741fa.42.1718190776051; Wed, 12 Jun 2024
 04:12:56 -0700 (PDT)
MIME-Version: 1.0
References: <20240612105525.8795-1-amonakov@ispras.ru>
 <ZmmAq8fbJLuaX4Qg@redhat.com>
In-Reply-To: <ZmmAq8fbJLuaX4Qg@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 12 Jun 2024 13:12:43 +0200
Message-ID: <CABgObfbGa=xpp9-cLwzqCpPFsf27qM+K-svfXEvc6ffjb=_VAg@mail.gmail.com>
Subject: Re: [PATCH 0/5] Reinstate ability to use Qemu on pre-SSE4.1 x86 hosts
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Alexander Monakov <amonakov@ispras.ru>, qemu-devel@nongnu.org, 
 Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.141,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Wed, Jun 12, 2024 at 1:04=E2=80=AFPM Daniel P. Berrang=C3=A9 <berrange@r=
edhat.com> wrote:
>
> On Wed, Jun 12, 2024 at 01:55:20PM +0300, Alexander Monakov wrote:
> > Hello,
> >
> > I'm sending straightforward reverts to recent patches that bumped minim=
um
> > required x86 instruction set to SSE4.2. The older chips did not stop wo=
rking,
> > and people still test and use new software on older hardware:
> > https://sourceware.org/bugzilla/show_bug.cgi?id=3D31867
> >
> > Considering the very minor gains from the baseline raise, I'm honestly =
not
> > sure why it happened. It seems better to let distributions handle that.
>
> Indeed distros are opinionated about the x86_64 baseline they want
> to target.
>
> While RHEL-9 switched to a x86_64-v2 baseline, Fedora has repeatedly
> rejected the idea of moving to an x86_64-v2 baseline, wanting to retain
> full backwards compat. So this assumption in QEMU is preventing the
> distros from satisfying their chosen build target goals.

I didn't do this because of RHEL9, I did it because it's silly that
QEMU cannot use POPCNT and has to waste 2% of the L1 d-cache to
compute the x86 parity flag (and POPCNT was introduced at the same
time as SSE4.2).

Intel x86_64-v2 processors have been around for about 15 years, AMD
for a little less (2011). I'd rather hear from users about the
usecases for running QEMU on such old processors before reverting, as
this does not get in the way of booting/installing distros on old
machines. Unless QEMU is run from within the installation media, which
it isn't, requiring a particular processor family does not prevent
Fedora from being installable on pre-v2 processors.

Paolo


