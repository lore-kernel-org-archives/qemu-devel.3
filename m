Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15D88CCD184
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Oct 2025 13:25:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8f1A-0004sK-AR; Tue, 14 Oct 2025 09:24:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v8f18-0004rh-IP
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 09:24:42 -0400
Received: from mail-yx1-xb129.google.com ([2607:f8b0:4864:20::b129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v8f13-0007Y1-73
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 09:24:42 -0400
Received: by mail-yx1-xb129.google.com with SMTP id
 956f58d0204a3-6353f2937f3so6281382d50.3
 for <qemu-devel@nongnu.org>; Tue, 14 Oct 2025 06:24:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760448274; x=1761053074; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=G8jDXamh0GAjhaOOyUbM/zxBl3+EgMCzhSCMLTGd7MM=;
 b=Kydw+eXXA4hMSPzxUjV9HI5oaP6PuGMeePHeDqJQlt9j6sVGp5YLRCkK40Mx7nTFv3
 bhJItSOXd3EFNK10ub6g0n4MZHG0wSikjJt5/wScnvszYN/2dX/01pcXVlpsIcXKsNK9
 E/CpHL0dQ9w09I1AOo+iuaSMgomHFZD04URVri9zfRaQhye5UIurtb0BJFRoX5hA9KkN
 h6Ks0bz0FeGt/fhEJyxIZBqUMrTb1hjejC2UwWy4t2r2CgftPRf5VuTpwnmyZsIJzeNL
 LxMogncCfhR5vVQ1RZmZ4PUSs0E0Dbb/1L3G15J8EQUwrRJOa0lHNiy6hLPMRvQmahi8
 /44w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760448274; x=1761053074;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=G8jDXamh0GAjhaOOyUbM/zxBl3+EgMCzhSCMLTGd7MM=;
 b=LzemJTXSnihN49Uw1A4AdhCxeY58tO8gTap8CR1+s89M24aR7tyW+WBSFEGRfct3XQ
 vW7M7nBApXSHd2a4jVCca60Z7XsWI8uqkb6kn0NxpzB9Zt8tZHyaVw2RWfLk/TMCXo7m
 +wl7AXO8Lo7zFdysCqHd04bmqocSooaqAppYehjaHJw+r32w8QxoMD/jYAtUEwRX1CJg
 wdfrkjNb7df6OCSgHhtJVOJy7du41bETWBs9Lrt7pk6V4b7dgGwPvNDBzLB1rWoIRfgM
 8TpvQ94pAEg6DMDryTnymIV17CIDr+o7kpYYv3CV0+1I4TNUbnyDjfyNpgKkyRzCO+ja
 0esw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW6eygw2pOw6NWfIva1qXhF2IOhorvb9KHSSUDp9ihtwDO3zOKLVKHhJx1uo5Cu7KO1mA/kk/QZ+oLO@nongnu.org
X-Gm-Message-State: AOJu0YzDUvbSnVRm0VX6X306Fr17wKRwkRh6ZxUWVQ83zrJc9fFLr91e
 pMjAxIjIO6m7ZQAYSer5b28s16ozO5MgOKEpuf8PxGJo3ZZjwLM078WzGsmD/3XD+Wlgk5P2FY5
 giaanVDAOogN9InG19lrbW9SkUSrlCrqnB6zxe7AOjg==
X-Gm-Gg: ASbGncsN5pwrmdULIUifnQ5rI2Cjiyn33ULrY8DA0aNuiQ89WpDLvULS2lovIeUeVRQ
 MOSoQndALqYheDae8iSQ3GndRFaVaMLi11TwjTttJpjkoMbQPhFywvC4O9kabMkisSawT9ED7Ca
 5kgMjfrmIc3Th/BZOb9crL+j50uMHku0BxomppNIQsydGmGqLGTmxNlEUpTeB/xu/BTNNcwnIZ6
 btto3xMw9Tx2suTBmebtPamkAM15AQ8NQ7DQb2ICA==
X-Google-Smtp-Source: AGHT+IHaFc3RRuDEiqeYSwnBo4u9QB+QqXv4aFN8eskYGje4t8Ipu4fV5lIW2GG8Dvb+kXgxpAr3wSK39vx2ipeuRE8=
X-Received: by 2002:a53:be0a:0:b0:63c:f5a7:3fc with SMTP id
 956f58d0204a3-63cf5a70a2emr7600436d50.64.1760448273771; Tue, 14 Oct 2025
 06:24:33 -0700 (PDT)
MIME-Version: 1.0
References: <20250908125058.220973-1-peter.maydell@linaro.org>
 <20250908104125-mutt-send-email-mst@kernel.org>
 <46AA9C03-CA7E-4C4B-AD05-A9053666BA52@gmail.com>
 <20251013070945-mutt-send-email-mst@kernel.org> <aOzm2ukHfkPF-zhT@redhat.com>
 <CAFEAcA9p51aPGhHgUPishEJ9TE60dm83ofKr5Wa-qM_1SqJ67w@mail.gmail.com>
 <aO5OndKoyP4Tk8Rw@redhat.com>
In-Reply-To: <aO5OndKoyP4Tk8Rw@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 14 Oct 2025 14:24:22 +0100
X-Gm-Features: AS18NWBEgp9rF0la74221YIrfcgrObUAY4l2alirlrVCyAB-5MtRwOFxwpklcIk
Message-ID: <CAFEAcA-K8=4O+rohY062YGQLLBpQP=knCgJMsJSoGTNsZHeLeA@mail.gmail.com>
Subject: Re: [RFC PATCH] docs/system/security: Restrict "virtualization use
 case" to specific machines
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Bernhard Beschow <shentey@gmail.com>,
 qemu-devel@nongnu.org, 
 Stefan Hajnoczi <stefanha@redhat.com>, Thomas Huth <thuth@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Alistair Francis <Alistair.Francis@wdc.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, qemu-riscv@nongnu.org, qemu-ppc@nongnu.org,
 Huacai Chen <chenhuacai@kernel.org>, qemu-s390x@nongnu.org, 
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Song Gao <gaosong@loongson.cn>, Bibo Mao <maobibo@loongson.cn>
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

On Tue, 14 Oct 2025 at 14:22, Daniel P. Berrang=C3=A9 <berrange@redhat.com>=
 wrote:
>
> On Tue, Oct 14, 2025 at 01:20:07PM +0100, Peter Maydell wrote:
> > On Mon, 13 Oct 2025 at 12:47, Daniel P. Berrang=C3=A9 <berrange@redhat.=
com> wrote:
> > > With a very minimal wording tweak our current defined policy could
> > > avoid being a blocker for enabling KVM in imx8mp-evk. In
> > >
> > >   https://www.qemu.org/docs/master/system/security.html
> > >
> > > where it describes the "virtualization use case", we could simply
> > > tweak it to always require a versioned machine type
> > >
> > > Change
> > >
> > >   "These use cases rely on hardware virtualization extensions
> > >    to execute guest code safely on the physical CPU at close-
> > >    to-native speed."
> > >
> > > To say
> > >
> > >   "These use cases apply to versioned machine types when used
> > >    in combination with hardware virtualization extensions
> > >    to execute guest code safely on the physical CPU at close-
> > >    to-native speed"
> >
> > With the suggested changes listed elsewhere in this
> > thread, my current manually curated list of machines is:
> >
> > aarch64
> >   ``virt``
> > i386, x86_64
> >   ``microvm``, ``xenfv``, ``xenpv``, ``xenpvh``, ``pc``, ``q35``
> > s390x
> >   ``s390-ccw-virtio``
> > loongarch64:
> >   ``virt``
> > ppc64:
> >   ``pseries``
> > riscv32, riscv64:
> >   ``virt``
> >
> > If we say "versioned machine type", that puts these machines
> > outside the "supported" boundary:
> >
> > i386, x86_64
> >   ``microvm``, ``xenfv``, ``xenpv``, ``xenpvh``
> > loongarch64:
> >   ``virt``
> > riscv32, riscv64:
> >   ``virt``
> >
> > I can certainly see the argument for loongarch64
> > and maybe even riscv[*] still being "not supported for
> > production security-boundary stuff", but do we really
> > want to say that the Xen machine types and microvm
> > aren't suitable for VM use ?
>
> No, that would be wrong. How about this alternative
>
>   @@ -21,7 +21,9 @@ Virtualization Use Case
>    The virtualization use case covers cloud and virtual private server (V=
PS)
>    hosting, as well as traditional data center and desktop virtualization=
.  These
>    use cases rely on hardware virtualization extensions to execute guest =
code
>   -safely on the physical CPU at close-to-native speed.
>   +safely on the physical CPU at close-to-native speed.  This use case is=
 limited
>   +to the use of versioned machine types, or machine types designed exclu=
sively
>   +for virtualization.
>
>  The following entities are untrusted, meaning that they may be buggy or
>  malicious:
>
> that wording would bring xen* and microvm into the scope, and so match
> your manually curated list.

I think that it's simpler for users if we explicitly list the
machines, rather than making them guess whether a machine
is "designed exclusively for virtualization".

thanks
-- PMM

