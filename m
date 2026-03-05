Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01E18EFCE4D
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2026 00:12:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxwK7-0007O0-Jk; Wed, 04 Mar 2026 19:12:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1vxwK6-0007NV-48
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 19:12:14 -0500
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1vxwK4-0002W9-KQ
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 19:12:13 -0500
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-b8fb3c4bbc4so1111029266b.2
 for <qemu-devel@nongnu.org>; Wed, 04 Mar 2026 16:12:12 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772669531; cv=none;
 d=google.com; s=arc-20240605;
 b=G515vo44VgyTPRjT+HvNGIHfvkee7z0Yq2fNG6nxvRqAx0MfwenD9/byumlT+cgDQT
 ADYq1ARR9TOHeHLQmoqXJEMluldhLShio55BA/J0IXSs3T6uDWE49bHCcJ21Nr0d734e
 U1U+vfKcMB+UvcJy4z0GENVmNhBXv2URnEVqOCfr8DbNE9bnvXRSLqlH3VLgYOgRhJOm
 gmVtuqwuGszLarnPKZ7Fof/VEC9Sjaw85yNgAAqrzJgce5RN1auM0Urjs/nuhbzlnLBN
 B6O6QA8VnKmWIKElrejaqcKPBmA8/msGRDIJvvyZKpanRVapWLS8hW8CbHb/Lcvqcolq
 QBxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=1b66/f9eNvLT777XlULO2vDdkYyLOk65RR2VaBpeijI=;
 fh=11PPQr8Sm1fBEAA2kMW2WMUNV9HrFN2XuXcI054+bQE=;
 b=c9CWZyJtS3mxZRc9wwwIkvSPqKikA3KQP3xeFEGR3oatmrKstoEcv7po2FPcI0tDkP
 xwYhQ/FmYM/Xs/aEXW1X+FjqxTtTJaPwPh3hnRPMjOuvhE+w2Pqrf6F6DUldPPX8zF0b
 A20OAJLlUBiw6GozXep3ci1wiq7+mwmSIH09jkvpuC2OGp2Z/XcRnDOYWCJsdo7PXUPO
 oJHUNjHlr5OL48oKPDZ4+T3vkg0hfyAXphCfr8WND657M4k00IhwsXMxP0I/ydlZ/da0
 AWYj9lcPtremaURoJHAPfJ+qQZxNOAhGYpo4tPiWe5ywBXVY/lBt0X/PDiVHS0YF9Yae
 +O9A==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1772669531; x=1773274331; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1b66/f9eNvLT777XlULO2vDdkYyLOk65RR2VaBpeijI=;
 b=e6ENX2C49Ezbi8oZtBvwlcgDK1jao7O/WRbRCsnQXU8dceaArySmrNPlu/Qy8kMMW2
 JEDUZBbG3z17FMOVa5rIOANzBKeWyOefy0UaKIaLY+mbn7m09Z36Odig7y7H0yjDDxPg
 oBDKGkwbNEIAdvQ2akyW4yqzpal3tXTG8kyAl/jpdzpG4WHvbld2iBwrzd0Ukl+4XgMw
 wSO7IqcdUyrOgnQzVMBfY1joK3TiaXFdpKDr+FF9ZGBk1SsbCOiz/4147UXgW3uVcyLV
 8m7BcD7ar/mHE26ShlB8NN8SSq+gzjMTuSE+oivwTbKK0o2e9+3zTfjGGv+ui4KnEiYF
 Y4mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772669531; x=1773274331;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=1b66/f9eNvLT777XlULO2vDdkYyLOk65RR2VaBpeijI=;
 b=k4fWOpebURlnzD2MKMhWfT/Rwck5DkBO9Knyh8sS3sS+L1HcX7tiX3DG5AeXlQvV5d
 1VtqwRBnqGH9o3skXGzzvMujclR/q0903I95HpqM6Sdpdi6v6fYzJSkyKFas11ONMt+c
 lis3FKQtNkvHzu6wUpMiZPH25Sn5atVrpM8E2kCh+Bv/Vgw+iHbRBgIWtzeAo/oFSAzm
 zaNZklA4127voRw+DJQGqnFkmBHnHjaBw4lgUHaNheE6r+j3+sxECeBMe3Ip7vISZ+nN
 ZH1E4Ne8Z/3SCDT/3nnmuXLSWRrGijdB+QimVSymE64Mknm1xvcv12s3FjhYIqoxXFmW
 RIlg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUR3JBCZL5qS38mihla0yUWz+7Nw6Ve8SUzLRN2PUaLpTqux+7nIR8qScP1CVq9D99mKWmAYjjk2up7@nongnu.org
X-Gm-Message-State: AOJu0Yxx09XHORtzkcFYw/m7MGchonw+xpfrMintLmfTaLZuwVtGsm5b
 9RZDnNvkMvFeWxy50PPkZ161R0qeUtMyuYDXncIZFRC6sW4v/K5ySnEuF5roFmoOXuT85cRM8Lq
 Dpa8afWnQnIx3P24CwR628B8NwUIc7HI=
X-Gm-Gg: ATEYQzw2TZrOMKv3dfClCeiOFx/tqdQDDDAXKyfgkXxRPkxZGl6Mq/oVXs0dE2k33jb
 ixjVWM/2tDI5J4Fz69LWIwvh6K1IYCGahXWqnHYVASrvEHYDohi3CgdOZbGIWQoog6w7j0MwrmX
 RZ10Gg5TaSS17kBAlyBVPfW0JxRcprUWKrXoV4kkxSBZDnCaficXOVyk8rW4RS3zkQDICVnZhhy
 bCurUG+13kueqgDEWrINfdy65l8HoK5Jg6qZgNdGKwFvA/JnlKxamZizxFzvSBbPwgv0C1liad5
 iwTHJQFYP71OCnkyTe63N74sRdAUiT+HCLDuDQ==
X-Received: by 2002:a17:907:9707:b0:b88:48ba:cd7 with SMTP id
 a640c23a62f3a-b93f11bc319mr222246266b.3.1772669530600; Wed, 04 Mar 2026
 16:12:10 -0800 (PST)
MIME-Version: 1.0
References: <177159976712.8279.7732381632410882915-4@git.sr.ht>
 <bdcd1226cd1588c746506955ef77548e493cf8b3.camel@wdc.com>
 <511c95f2-b939-4461-9d83-8a2151da1bee@lowrisc.org>
In-Reply-To: <511c95f2-b939-4461-9d83-8a2151da1bee@lowrisc.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 5 Mar 2026 10:11:44 +1000
X-Gm-Features: AaiRm538JQBUmp4_FzxBGlycTLW594FiO6OfIugoiBx5aMfnuY7eGPZLF-lMEeA
Message-ID: <CAKmqyKN_h+PqFvYGL-WY6dANLi84GbPDwaZvPDnFWTC1VK9Eog@mail.gmail.com>
Subject: Re: [PATCH qemu 04/11] [ot] target/riscv: implement custom LowRisc
 Ibex CSRs
To: Lex Bailey <lex.bailey@lowrisc.org>
Cc: Alistair Francis <Alistair.Francis@wdc.com>, 
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "amitkh@google.com" <amitkh@google.com>, 
 "qemu-maintainers@lowrisc.org" <qemu-maintainers@lowrisc.org>,
 "philmd@linaro.org" <philmd@linaro.org>, 
 "alistair@alistair23.me" <alistair@alistair23.me>, 
 "marcandre.lureau@redhat.com" <marcandre.lureau@redhat.com>, 
 "nabihestefan@google.com" <nabihestefan@google.com>,
 "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, 
 "zhiwei_liu@linux.alibaba.com" <zhiwei_liu@linux.alibaba.com>,
 "palmer@dabbelt.com" <palmer@dabbelt.com>, 
 "pierrick.bouvier@linaro.org" <pierrick.bouvier@linaro.org>, 
 "dbarboza@ventanamicro.com" <dbarboza@ventanamicro.com>,
 "liwei1518@gmail.com" <liwei1518@gmail.com>, 
 "dave@treblig.org" <dave@treblig.org>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>, 
 "berrange@redhat.com" <berrange@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62c;
 envelope-from=alistair23@gmail.com; helo=mail-ej1-x62c.google.com
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

On Wed, Mar 4, 2026 at 11:12=E2=80=AFPM Lex Bailey <lex.bailey@lowrisc.org>=
 wrote:
>
> On 27/02/2026 00:04, Alistair Francis wrote:
> > Is new MIT code allowed in QEMU?
> >
> > Alistair
>
> I believe so? if not then this will be a big barrier to contributing
> this code.
>
> checkpatch.pl told me: "Saw acceptable license 'MIT' but note
> 'GPL-2.0-or-later' is preferred for new files unless the code is derived
> from a source file with an existing declared license that must be
> retained. Please explain the license choice in the commit message."
>
> In this case "a source file with an existing declared license that must
> be retained" describes many of the files on our fork, since these are
> already published under the MIT license. (on our github repo)

If it's published by you you can relicense it as 'GPL-2.0-or-later'.

>
> I suppose perhaps you could interpret it as meaning only "a source file
> already in the repository".

I would assume it means if there is an existing MIT licensed file
published by someone else then the original MIT license can be
retained (it must legally be retained, I just mean that QEMU will
accept it). But in this case it's just lowrisc code, so it can be
re-published as GPLv2 as you own the copyright.

Alistair

>
> Can someone clarify this please?
>

