Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0313CA5FD4
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2026 16:58:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCgb1-0004P7-ML; Fri, 02 Oct 2026 12:58:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xCgaw-0004OO-OV
 for qemu-devel@nongnu.org; Fri, 02 Oct 2026 12:58:52 -0400
Received: from mail-ed2-x0f.google.com ([2a00:1450:4864:33::f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xCgat-0000tW-Dh
 for qemu-devel@nongnu.org; Fri, 02 Oct 2026 12:58:50 -0400
Received: by mail-ed2-x0f.google.com with SMTP id
 4fb4d7f45d1cf-6aa135d6e97so146215a12.2
 for <qemu-devel@nongnu.org>; Fri, 02 Oct 2026 09:58:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790960323; cv=none;
 d=google.com; s=arc-20260327;
 b=iDlJeyKMTVCCxKpKo6/cdq2Ed6PiVMMqvowyxUWo/N2cvBYLDSEeXoA2t3VCdpZzj6
 96wjlW3BNkEBdkG7NGspiGSCd53yHTew8CqKZfF/r5lyiiOa89Q/fwEPLwN47zyAhB2M
 ttxPBwVhRjGyDtT+0mOILhYBI5RTtbATJwzuweJb2GPcktR6qJYebYGj9PiFYjiwLD5v
 5AaKh0CeEPOEinJal6Yb5cTI6Qe/4qi38dgHQw+9dOPs2ZZ2/57Cp3b0TNw4XD9hDCuX
 dHt8tdB5QOTsQXPHyxwC+Rt0sv4LdZ+qt06lhaZiZJqb0m05x8M2Fpx+D5JrRC0HUvtW
 Q5SA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:dkim-signature;
 bh=xP5DDHCMbAjbUs3xe/3crv71NDZ6i37Mh/QwccJb0iw=;
 fh=AaEvk/D5tmlvu8+VmUVG12WAyVyClVXPdjEib6bz5hI=;
 b=NJQOlhZ8rcG3DwQZ0TWc70OchhDkPj5Rr0zkn5zGaaeF4f0Ay4oQJFteWc/keoKKUO
 tKdEhKTXZiAMEsxE3dwit8FExhJ42bac6eb+jQ+OEZsSwa1uhgprqKgoMhACkOQYb41e
 DSvEkcjRD7riIXlr5pCOSmFu8UwVHLOZO3e9F8uRe8kXmwS+Df9N/ZJTdGbrMrsWYR0t
 INBzAFVIlULnUZgtDa2w/2p6z/uwfDJTNwIXL6s59Hn2JcLuVld/hn75xirEWH3SwtpJ
 XVtk+VqNj6iYNVx/QIzfiE11Pp4BcgOTyhtGxyJBhb6RPK8uB/K62825qiAokiPMKYCn
 zCxg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790960323; x=1791565123; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=xP5DDHCMbAjbUs3xe/3crv71NDZ6i37Mh/QwccJb0iw=;
 b=OBkuXYHuP5IP6Q3QVpCgtBEUjLRnfdGlk3/WLm+p4Ypqb893firRw6ebsF4szQTixo
 aOs0uyK/hs03fNXyYN3PYDCjO/hQvojkWFzMQecUE4yRqW790nySpR4JW/6dNJB9yM4r
 YWj5eGj5OZHBrsIVIBhVSVbp+5e7ZPnpv4mt5bko+XwOkke8vUFrFU5Z3pBl8Tyk49cv
 qwQVlDCDlYzDCBAsxnEHK2wNPLEqZwqeKupWgiigQ5/ryZRwdFbLyHYLq0PcfOS2MQel
 uyNeQGR+tWRwJvuiy8lZMO6dwZPmOSutR4lG40wdm3DdBeg0TtAsJjIrghqui26rKnRe
 1YnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790960323; x=1791565123;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=xP5DDHCMbAjbUs3xe/3crv71NDZ6i37Mh/QwccJb0iw=;
 b=rpHX35D5F6rCpEwIbc6FkhHrmqIOxtwZ6GQk1t6D3h+Djr9oI/JYvuUGWM7BbPAmwP
 Wgbh96y47dyIHTbzbyqRlTzKdmvUjVQNXd6rHHqQVq0aO3zAz6K1/4mb7P8NNzGeV3+u
 4lwyEqkVVNUmP7gKBMrWQZXbdntv/r0vK8tdxRLInJiIAqVqMQ+bVhNWK8n0sU+ktdq2
 41VGb9zMIMTuDZGbtshZtN87VJFBLGhi68wOQ0NKzovcSi3yWzgtmZPVETucxw6HJaYl
 lEY1GhNvSBjxbbavDMZjsYGV77KVapnJ9lNBQuIeuwaxC9CzWdhG2nYwR5JlGoJiaSJc
 N2DQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxjegRPe0gwz4C6KXwGWRa84240POVbgttlCEs5f4xJkSqpg6lv9A1/D0YL1Ol6Y552G9YvJbVv2MYh@nongnu.org
X-Gm-Message-State: AFq9FYJ4bYlXja6ss2EBMM3eSpHPEzzG+ofNqCGJQciJQFHZZjWrz0EZ
 LmVQdO5xwVqE2c4623ZYGGekrC72+ddLjHBpqxBM0bKI+1LdRhROvN3t7ZdUeiIWqGBC/IwEyLf
 pvJT4/wWTP2F86lq+EK5urExWEcVmaJY=
X-Gm-Gg: AYBFou0knoCTTsYhNhMXaj49/BoennSQ7t7wEJxjcah1ELTiOL+/dkCbd7ot7a1DRXc
 6sYSVnwE3OAICGbyr6vpoff3J7x9U5EPrwL0ltcTyRxmC8oj4LKaD2ap+NevD+lIRA/5mgYaUdO
 +SbUtwsMvuMEa2jVVt32mwCmBjKAY6eOgbW1/VSwKPewNlJ7JxAlIL3Vrpaax8jlhh2bnmxNVPz
 +hh2Y/44b/mLui7Nm+aS0mkTGc7XubHE/X7EI3Gas2QOoxDreKHJUkZKgmkjtvtdldUS180jLc0
 bQBo1+kftxSxQb9waBbX3Y+LAhAgKdMa+BOcu5rE0tH305ZqOSRLO5CqdYC8EImtydk=
X-Received: by 2002:a05:6402:27c9:b0:6ab:6f77:c4eb with SMTP id
 4fb4d7f45d1cf-6af9e362590mr2151368a12.37.1790960323384; Fri, 02 Oct 2026
 09:58:43 -0700 (PDT)
MIME-Version: 1.0
References: <CAE2XoE8VyCpPCqRVFArBn_dDsyMw8vrSJxWMhKq17btZvO2n6A@mail.gmail.com>
 <b02db9e2-b348-4011-a98d-122e9d9f17e5@oss.qualcomm.com>
 <ar6a_uDw9OeLng6c@redhat.com>
 <6bf4dad5-4fa2-4df1-b6b8-d594dbd3842c@oss.qualcomm.com>
 <ar6lw3jAcnVej6vK@redhat.com>
 <557262df-b8e7-49b5-a245-ae46b8885b30@oss.qualcomm.com>
 <CAE2XoE8MriyEEeRF3uDwWgnJWPHBieK_-pD1+k0tUjROWjDpWg@mail.gmail.com>
 <a9cba466-f442-4bbf-9154-3674b5f10882@oss.qualcomm.com>
 <ar_coT44h5-zJPVV@redhat.com>
 <CAE2XoE8Jg=WHDF1_pQ-K-Y6f_aE2N8y5_=aJSeC4A52HWFwEkA@mail.gmail.com>
 <ar_hNU0Y4BxXKHnv@redhat.com>
In-Reply-To: <ar_hNU0Y4BxXKHnv@redhat.com>
From: Yonggang Luo <luoyonggang@gmail.com>
Date: Sat, 3 Oct 2026 00:58:29 +0800
X-Gm-Features: AclHuK9oLDsuIH_-0tyf2D0IfUvd5pve5TCsKMnaTRuIfsSbB4TbL5MGHOTOL9s
Message-ID: <CAE2XoE8YbxQobHHhttKHQrEgrMg2Z1XePzwFDKB2g7E1yH1noQ@mail.gmail.com>
Subject: Re: [PATCH v3 01/10] machine: allow -M name to differ from QOM type
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>, 
 qemu-devel@nongnu.org, Chao Liu <chao.liu@processmission.com>, 
 Eric Blake <eblake@redhat.com>, qemu-arm@nongnu.org, 
 Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>, 
 Alistair Francis <alistair.francis@wdc.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>, 
 Stafford Horne <shorne@gmail.com>, Peter Maydell <peter.maydell@linaro.org>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Fabiano Rosas <farosas@suse.de>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 qemu-riscv@nongnu.org, 
 Laurent Vivier <lvivier@redhat.com>, Max Filippov <jcmvbkbc@gmail.com>,
 Song Gao <17746591750@163.com>, 
 Philippe Mathieu-Daude <philmd@mailo.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Laurent Vivier <laurent@vivier.eu>, Weiwei Li <liwei1518@gmail.com>,
 Zhao Liu <zhao1.liu@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:33::f;
 envelope-from=luoyonggang@gmail.com; helo=mail-ed2-x0f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Reply-To: luoyonggang@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Sat, Oct 3, 2026 at 12:52=E2=80=AFAM Daniel P. Berrang=C3=A9 <berrange@r=
edhat.com> wrote:
>
> On Sat, Oct 03, 2026 at 12:43:19AM +0800, Yonggang Luo wrote:
> > On Sat, Oct 3, 2026 at 12:32=E2=80=AFAM Daniel P. Berrang=C3=A9 <berran=
ge@redhat.com> wrote:
> > >
> > > "is_available" is probably a bit overkill as a mechanism for
> > > introspecting, when we just need to return a list of targets,
> > > Since we have that already we might as well use it initially
> > > though.
> >
> > I have experimented with x86_64/i386 arm/aarch64 riscv32/riscv64 so
> > that I can tell:
> > using is_available will be a better option. As we can use inherent the
> > is_available from
> > parent, if we just use a bit set like QEMU_ARCH_ARM, then that means we=
 need
> > specify it for every single machine. And if any customization is
> > needed, for example, depends
> > on KVM config or other accel config or any condition not just
> > QEMU_ARCH_*, then is_available
> > still needed, so I would insist is_available with a TargetInfo*
> > parameter, then all concern
> > will be addressed.
> >
> >
> >
> > >
> > > > >> Does it matches what you would expect?
> > > > >>
> > > > >> Also, for compatibility with existing binaries, should we accept=
 -M
> > > > >> $arch-virt also? I feel like it does not hurt and would make thi=
ng
> > > > >> simpler to switch between existing and new binary.
> > > > >
> > > > > Same reason -M $arch-virt, indeed like -M $arch:virt,  but $arch-=
virt
> > > > > would be even harder.
> > > > > Because "-" is a valid separator in machine names, ":" is not a v=
alid
> > > > > machine name.
> > > > > So without init QOM, we can not reliably identify "$arch-virt" be=
longs
> > > > > to which target.
> > > > >
> > > >
> > > > From the conversation above, Daniel and I are not in favor to have =
any
> > > > kind of parsing based on this string. So either we'll pick virt, or=
 the
> > > > real qom name, but not anything else.
> > >
> > > Yeah, I'm leaning more towards always exposing the $arch-virt names
> > > in all binaries, and also exposing 'virt' in the traditional
> > > binaries only.
> >
> > I have a question, do we expose the "$arch-virt" as a machine "name"
> > and expose "$arch-virt" as machine qom "typename";
> > or expose "virt" as a machine "name" and expose "$arch-virt" as
> > machine qom "typename".
>
> The human facing machine "name" is the important one.
>
> For the QOM typename, I don't really mind either way. If we can keep
> the QOM typename and human "name" matching that's nice, but if they
> differ, then it is not a big deal - your series has the patch to
> expose the QOM typename in QAPI 'MachineInfo' which addresses the
> only downside of them differing. So whatever approach works best when
> implementing the ideas...

Then it's clear, for
single-target binary:
"virt" as machine "name" and "virt" as qom "typename"
multi-target binary:
"virt" as machine "name" and "$arch-virt" as qom "typename"


So for humans, we still use the familiar "virt". And for libvirt and so on
they still can use the old way to talk with qemu-system-$arch.
And to talk with the new qemu-system, we have returned qom "typename"
for them, the libvirt and so
on needs to be updated(not a big deal) as the qemu-system is a new
thing. If no more new concern
I'll go this direction for this series.

>
> With regards,
> Daniel
> --
> |: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
> |: https://libvirt.org          ~~          https://entangle-photo.org :|
> |: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|
>


--=20
         =E6=AD=A4=E8=87=B4
=E7=A4=BC
=E7=BD=97=E5=8B=87=E5=88=9A
Yours
    sincerely,
Yonggang Luo

