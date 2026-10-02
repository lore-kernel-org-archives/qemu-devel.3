Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3827FCA5FC4
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2026 16:44:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCgME-0007V7-1Y; Fri, 02 Oct 2026 12:43:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xCgMC-0007Um-Kc
 for qemu-devel@nongnu.org; Fri, 02 Oct 2026 12:43:36 -0400
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xCgMA-0007hM-OH
 for qemu-devel@nongnu.org; Fri, 02 Oct 2026 12:43:36 -0400
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-6ae14eecc64so455860a12.1
 for <qemu-devel@nongnu.org>; Fri, 02 Oct 2026 09:43:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790959413; cv=none;
 d=google.com; s=arc-20260327;
 b=Gt/m+U//+HgA6gY/wxKpoP8mlowc3EaF+GCdp7ojOTS6oAzkqO7uxf0krMOZ/lIONp
 fAB3ERauCivudlHYizPUd4+QsBaDZtEJ4BsmNBf3fbO7DoTlhkTPGWBNeV9DFZMxwbLS
 NO6KYdzncw7KuSLfDtIh0VbY/qyvyImR+30qdopH4rTTX0odN6DLyyx6CshVpe3oUdU5
 TzERqqz6B3PdQrGI8UtXbQ+Y93JqdS+u/h3SXeFwhvlHQ2Qatv75nJ53apvYdfs0+QT+
 O11awo0fuZ8e7rRVctd6ONFspnonUEK1RkHNnUOjk7GOBFM/LVvKJqJClw2i8FEzrSM1
 q0Wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:dkim-signature;
 bh=ciq6ioagLvGVtduSTjIpkMRSg/H6W0iYwuNShnlnLLI=;
 fh=pmDfkioQ31Zi0QLM+RYSuXdce+lUoyPhiGduEkUHMTQ=;
 b=Q9TQbOK5c/lT6O7KASwQAlcTTnVHQYcBSDFRxMacgrvWqWXv5oPzOsh6mDzUz86dKy
 pmo0fJVfI3qT+EJJxH8SR9J/bcZZT00qCwGSc4BWZP21T41m1mU2e3MP7kFobFgt9lyu
 OQB2PEp+5M27LWYYyo5GUKoc2f8oWZIoXc19BbKi4R6H+6C4u2GWumH6qXYlJ86SH9P2
 pINRXD+o8hmFq+LZNIbyO5O5EWgXpBnybT9J0oyJzhEh8e25d9uv2qriAxVt3EyXDNn2
 /gu9q0p65hPLpNUqrEXHYaXybVfKBuKqcpvy7SD8GXMadnsMI1xh8FSTxN5dqT2dxpuT
 3+8Q==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790959413; x=1791564213; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=ciq6ioagLvGVtduSTjIpkMRSg/H6W0iYwuNShnlnLLI=;
 b=GeUMYtitBj0ndWEw6ibwMYDSBEzdVfcifwfshugNXOtDFVZ/cT3q46Y/AhPoUXhhYC
 oPvGWApHsFmS4oroonx6U3W9c3RN8xp6J/kipW3kqnASXVjIDBlv42CzUOgO7AscdP2n
 VQfrDzTFLLAAxRMbueuj4JaEfPLjJx1Sw/pBAtbgd089L33VzQZn7wmUQjfcZOzyW4Cg
 q38sbrrhAeyxUHq4ET9cKtSs+h4lfCbZ7XuhtJLMexOzWYsemCaam+XwtNOEBk26wskl
 FG9MBq7SDYrtf1E/qCncsTw3+cKNv2L3opxWdc722NJTRi/Q4V0dWoP5RssqeRgZdNht
 Y0NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790959413; x=1791564213;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ciq6ioagLvGVtduSTjIpkMRSg/H6W0iYwuNShnlnLLI=;
 b=DmPE2A38FdAIEV3DPPbe4RlzBRuri68nrB/eoZLcRBZs/bqCaAgbHzddyk0ILP0BTR
 gTv2IqSLoiSMuSGlM9TloGV6nwqLTevfh5Z8TMyBTRKPSzYX8XT/H1YIpWRiqUE/qrhA
 HC1vVxqe4tv6NsscyROxLPgdg61tETFDRCq7Lke60H8d40FndO+0EJ4+14T9XZ+ZcfK0
 gKae1J9eysdpIHP8mndHt267d3Qj2TIe/jONE43REySIGGLEXprc1acHR1TOQ1in1+pZ
 9csaT2YFy199zfOIbGGNUM37Pa0eNHN41yG6LvbuCUtWuFGjtZGQJNvIIpRlp0rEkb5f
 QH/w==
X-Forwarded-Encrypted: i=1;
 AKwUvBwUBE4vDJ3GEEvm4+1yYIPImMcX+x/Mm+qUYPtezqC3dpcFhLs+lI6hqEGkLvweodKclOkGhInEvzB6@nongnu.org
X-Gm-Message-State: AFq9FYIRUtAnQHLh1t712blUY+7RUwjQUwRDBxPmzQdgSZb8Vb/tHyTN
 bzSznmr5oQtGq9/L5n72g264Esuxq34LOk6HPMhhE0zjXqmfykqB+nMzwhkUsQ7ZtRIrbaMHVHJ
 lTCB3+JJPOmYMtjP0cAyZrsByTXPo6qc=
X-Gm-Gg: AYBFou0iRSGrh1KsOh6dNgSpgTowcfXWxnUQr+r2KzkbvvBI8eBjCkxe4ETWvl9N1ei
 Ph+ntLhYLA5d+ICDoclHv2f3I1ZMC3nO2lKhgUZR9HT6ZNzrPE2OL+zU37DMCVP1H1Nrb9HgXA9
 NBfjYuEDyA/QHISvSWbiQp/MmZzkAcN6SJ+xuVnOztZnvXDINcp44mRHBbVTwjz+s84xJ9COda8
 jGryVOrKlzYg3a8dCNXK7rSMcQ6tfLnpVahhYmFTUfD77WWaKR0AzX3rkQvr7tmvylkeUyG7VoR
 MpP+nEiJYztppux38/8dstMOf14lwmSHvJnZCYXDVct+3I24hTA2pD0=
X-Received: by 2002:a05:6402:27cf:b0:6a7:ee56:615d with SMTP id
 4fb4d7f45d1cf-6afada112e9mr62964a12.31.1790959412772; Fri, 02 Oct 2026
 09:43:32 -0700 (PDT)
MIME-Version: 1.0
References: <CAE2XoE8q3LYJ-JCTbRBk4iPdUQdRE8zzmOgiZ=HEXDL78iw8UQ@mail.gmail.com>
 <26b0d44d-0322-4ceb-a47b-747fc52c61b7@oss.qualcomm.com>
 <CAE2XoE8VyCpPCqRVFArBn_dDsyMw8vrSJxWMhKq17btZvO2n6A@mail.gmail.com>
 <b02db9e2-b348-4011-a98d-122e9d9f17e5@oss.qualcomm.com>
 <ar6a_uDw9OeLng6c@redhat.com>
 <6bf4dad5-4fa2-4df1-b6b8-d594dbd3842c@oss.qualcomm.com>
 <ar6lw3jAcnVej6vK@redhat.com>
 <557262df-b8e7-49b5-a245-ae46b8885b30@oss.qualcomm.com>
 <CAE2XoE8MriyEEeRF3uDwWgnJWPHBieK_-pD1+k0tUjROWjDpWg@mail.gmail.com>
 <a9cba466-f442-4bbf-9154-3674b5f10882@oss.qualcomm.com>
 <ar_coT44h5-zJPVV@redhat.com>
In-Reply-To: <ar_coT44h5-zJPVV@redhat.com>
From: Yonggang Luo <luoyonggang@gmail.com>
Date: Sat, 3 Oct 2026 00:43:19 +0800
X-Gm-Features: AclHuK8m_qVx9TWXeFIs_zQQIaSXtVcRCVfzkmDq_etOtUdmQMUUpBDu4hJ8myQ
Message-ID: <CAE2XoE8Jg=WHDF1_pQ-K-Y6f_aE2N8y5_=aJSeC4A52HWFwEkA@mail.gmail.com>
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
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=luoyonggang@gmail.com; helo=mail-ed1-x52c.google.com
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

On Sat, Oct 3, 2026 at 12:32=E2=80=AFAM Daniel P. Berrang=C3=A9 <berrange@r=
edhat.com> wrote:
>
> "is_available" is probably a bit overkill as a mechanism for
> introspecting, when we just need to return a list of targets,
> Since we have that already we might as well use it initially
> though.

I have experimented with x86_64/i386 arm/aarch64 riscv32/riscv64 so
that I can tell:
using is_available will be a better option. As we can use inherent the
is_available from
parent, if we just use a bit set like QEMU_ARCH_ARM, then that means we nee=
d
specify it for every single machine. And if any customization is
needed, for example, depends
on KVM config or other accel config or any condition not just
QEMU_ARCH_*, then is_available
still needed, so I would insist is_available with a TargetInfo*
parameter, then all concern
will be addressed.



>
> > >> Does it matches what you would expect?
> > >>
> > >> Also, for compatibility with existing binaries, should we accept -M
> > >> $arch-virt also? I feel like it does not hurt and would make thing
> > >> simpler to switch between existing and new binary.
> > >
> > > Same reason -M $arch-virt, indeed like -M $arch:virt,  but $arch-virt
> > > would be even harder.
> > > Because "-" is a valid separator in machine names, ":" is not a valid
> > > machine name.
> > > So without init QOM, we can not reliably identify "$arch-virt" belong=
s
> > > to which target.
> > >
> >
> > From the conversation above, Daniel and I are not in favor to have any
> > kind of parsing based on this string. So either we'll pick virt, or the
> > real qom name, but not anything else.
>
> Yeah, I'm leaning more towards always exposing the $arch-virt names
> in all binaries, and also exposing 'virt' in the traditional
> binaries only.

I have a question, do we expose the "$arch-virt" as a machine "name"
and expose "$arch-virt" as machine qom "typename";
or expose "virt" as a machine "name" and expose "$arch-virt" as
machine qom "typename".

>
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

