Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47B2FC27C53
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2024 11:52:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sHMWB-00009i-4e; Wed, 12 Jun 2024 07:51:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sHMW6-00009E-PO
 for qemu-devel@nongnu.org; Wed, 12 Jun 2024 07:51:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sHMW4-0003wg-2F
 for qemu-devel@nongnu.org; Wed, 12 Jun 2024 07:51:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718193106;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5gF9pkPBW/v5g7eEtkHFwueHYLAvvWguL9mR2yxu3aI=;
 b=fvX6TzQCGvXPxC83/nMgfKXIcPV/IUVDm8aRizuxFSuLkFY0iInbtFhLe71M0SlB9kWMjl
 MaSHI76BpvACAg/d53BYlntiM27lCCZ9xo44tb6I934tPpzytYvWIY4emeOx2rO7Urfozn
 DFXmrmVHjhOMBSNFlONIGpBNZTZN9N0=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-549-QDrUXGpUPVyp5hllSe0ZEw-1; Wed, 12 Jun 2024 07:51:44 -0400
X-MC-Unique: QDrUXGpUPVyp5hllSe0ZEw-1
Received: by mail-lj1-f200.google.com with SMTP id
 38308e7fff4ca-2e95a73c99eso18490711fa.2
 for <qemu-devel@nongnu.org>; Wed, 12 Jun 2024 04:51:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718193103; x=1718797903;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5gF9pkPBW/v5g7eEtkHFwueHYLAvvWguL9mR2yxu3aI=;
 b=ShkNnesIMkM2rGYDGU41Xzm3IYSQy9WlKfGB/l0LRdzUWdW92ri1PiUm+nfTThRnGQ
 L3eAfFJzP6tc4P8inxl0PKkKkg+NLUilpDR4QYZ9P17uaer09RiCgFm0Ss2b1xsbxyyr
 GJ7GXPMFABxHDvCxke/g1NT7sM9m4gVk0mPRT0iOSCMZtpAh4uVY8j5KNkCtnK5znFv5
 06KoawKUTNpbe4KC/8+q5hcjwduAFONwwJFpMRVnHbufIVSHLnGJQAGp1moY6WsBqCZ3
 5fLBuMPXMPO3is6LiJuRBZz0lq24TcLAtznrEWxcN4v+VDCJBsjUWfK/71y1gFD5ZQYR
 nz3w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUfpzguYzUp0lFnLdg0+2+SqZsgf+bDRO0AooHBMsT+wFRloi1+MKE2+D8FqzcEEeCQBI9TWqnpzaq0f5NgZUvEmxx5hnY=
X-Gm-Message-State: AOJu0YxqoIWi8XcxQDQyY3FUurZpLhsnRsDnPQBrNJWc5YGR2DHfLX9n
 Qo5eXGTOO63MvnWGdb1ue046F0fuQwtsLGvk/6s6JE9bOCLoTEAJN7c36DOFrCBBfXhhf1W/w6a
 MrBWnldclwBuR1e2Vnlc3RqeoDFvDR4oKMhRukxKWSUwCV16LoNmFXKDuUs5sPyJvZ0dYuB+VsX
 ioG2LAQFRrLj/6L/VyqR14g16sQq4=
X-Received: by 2002:a05:651c:543:b0:2eb:fca8:7f19 with SMTP id
 38308e7fff4ca-2ebfca88181mr18419351fa.36.1718193103202; 
 Wed, 12 Jun 2024 04:51:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEwYQvwMOolQkRyMpsP67SjICJaGe02mJD7XzUV391BvLSkOJkboEsefipiAySm+QxDWTRIVQSMDUndx4zqvc4=
X-Received: by 2002:a05:651c:543:b0:2eb:fca8:7f19 with SMTP id
 38308e7fff4ca-2ebfca88181mr18419181fa.36.1718193102851; Wed, 12 Jun 2024
 04:51:42 -0700 (PDT)
MIME-Version: 1.0
References: <20240612105525.8795-1-amonakov@ispras.ru>
 <ZmmAq8fbJLuaX4Qg@redhat.com>
 <CABgObfbGa=xpp9-cLwzqCpPFsf27qM+K-svfXEvc6ffjb=_VAg@mail.gmail.com>
 <ZmmIpr5f0sQy-VGl@redhat.com>
In-Reply-To: <ZmmIpr5f0sQy-VGl@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 12 Jun 2024 13:51:31 +0200
Message-ID: <CABgObfZHBGxS-D9LdM1v0oDXBHoKm2-A4FknixmqjfJeQR1YLw@mail.gmail.com>
Subject: Re: [PATCH 0/5] Reinstate ability to use Qemu on pre-SSE4.1 x86 hosts
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Alexander Monakov <amonakov@ispras.ru>, qemu-devel@nongnu.org, 
 Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.143,
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

On Wed, Jun 12, 2024 at 1:38=E2=80=AFPM Daniel P. Berrang=C3=A9 <berrange@r=
edhat.com> wrote:
> This isn't anything to do with the distro installer. The use case is that
> the distro wants all its software to be able to run on the x86_64 baselin=
e
> it has chosen to build with.

Sure, and they can patch the packages if their wish is not shared by
upstream. Alternatively they can live with the fact that not all users
will be able to use all packages, which is probably already the case.
Or drop QEMU, I guess. Has FeSCO ever expressed how strict they are
and which of the three options they'd pick?

Either way, this only affects either the QEMU maintainers for the
distro, or the users of QEMU. It's only if the installation media used
QEMU, that this change would be actively blocking usage of the distro
on old processors.

> If we want to use POPCNT in the TCG code, can we not do a runtime check
> and selectively build pieces of code with  __attribute__((target("popcnt"=
))),
> as we've done historically for the bufferiszero.c code, rather than
> changing the entire QEMU baseline ?

bufferiszero.c has a very quick check in front of the indirect call
and runs for several hundred clock cycles, so the tradeoff is
different there.

I guess that, because these helpers are called by TCG, you wouldn't
pay the price of the indirect call. However, adding all this
infrastructure for 13-15 year old CPUs is not very enthralling.

Paolo


