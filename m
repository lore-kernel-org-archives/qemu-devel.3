Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43BD4C531D0
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2026 11:21:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woJOK-0000qV-3m; Mon, 27 Jul 2026 07:21:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1woJOD-0000k0-QK
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 07:20:58 -0400
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1woJOB-0007is-SD
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 07:20:57 -0400
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-38a0c7e841fso2918478a91.2
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2026 04:20:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785151254; cv=none;
 d=google.com; s=arc-20260327;
 b=ryiSVakeY9exNRLKRI5LY4NeTnSZUZF/FLH7WJv7WvFPsF+eAd5A3L/fXRiqA2cPYO
 KSK+8xo2XDIAv4+k82mGxvQ92bmoAMVBije8M7bEnAKUUUPVO7O8tld1MNam1knIn30D
 Uncz5JXc2nhqSWj62wXJPEP+pLTM2l5d/q8X+/vM0ImdLPDyNCHdHUqL7pIAsPOtEY3J
 lUrK2BEV8QKATGyQYpG8XvaXsoOjQEbgFmLVmtza/a22Vc5vTS1iCPhGMERTmZxA/5fV
 C7sDPm2jFiYajHBHPosCywSmtVldT8ViXEfjYzKjAIf/RV4CskNTFS2hueaucuSPmLmC
 DZzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=SxuFWpLUIIRucz4RDzwijrmPwByqoC27gCPg7Xmmi0U=;
 fh=Idq8xgKK/mGAqPyU45Y97lyMtVr0rEqN/2040FYaiUM=;
 b=MiWzynnmf9UCEC5DW9yciMauOdpVPztCLApdxDE4uY/5LNEjXB8gAMQpRJhLbIwb5E
 f523BXZD21ni3STBbBp6vTYyE3g/geGQQOqBIG1w9Y4P7c176ntbLGFlJOiCZaVXMiEX
 H/N6uBcqBOvOWemV/+0l2PMUrBlMWAPPC+CncBDOI6TjAUTJDSDiMrgZJNhu2GvNISlV
 tpfkioWxBAhowtxDaYzkrN5ZN/CN0PnTa5wFI69r7QmYf/vyGRG6n0qdrb5Qvs6/dMis
 jPGF8GbAbKQFYjA73JZkHnGIvWgumwJsvBdjxRRX4iGrMdHfhsPBB5eTpXAVHwJls+TI
 Smjg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1785151254; x=1785756054; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=SxuFWpLUIIRucz4RDzwijrmPwByqoC27gCPg7Xmmi0U=;
 b=pzQ2WH1WtL6gn+QsRE2FEWlwJ9g7vXoVUnCjscAs45WsLJJSSwakDkYqJtGNbWEZzG
 jioitw1vs1SOWPCu1Vy4NHQVfewTAczwHC7Led1o7EDIZzxYuiPOqvrWhmH/JyOu4pTr
 RdeQv5UvAKJtpi3YIBGENp/wshONzoDzdXeFV72Wh1wNtwcUQ2TTF32xbYypcU56r6fv
 V92Xjb9Mihiag6l8lVvZX7PMtDgOCfNZYGa4wikwjxBt20LzooAnXefeaNiDgefTDKqQ
 1tXGb8kyFNy0YxvXxTR0iALceJPepoBoJR1PTKjzbxySAvYE7luxM4skSaCU5th9K1mz
 pBYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785151254; x=1785756054;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=SxuFWpLUIIRucz4RDzwijrmPwByqoC27gCPg7Xmmi0U=;
 b=mvVG995fwBYfWVrmC6ed3nkwxjKE/GMu9N0yO1w9mPkCg6QYzaHGff8uefFc2vWWrK
 6th4iTrXf4FNa4d24tjfN7Y0BOZR+E9lv7v7dxbkMrVHhHm87Oh1xsA3mEb/XGVNTXAK
 0WoeoQw8g1sGLjbJwrAWlWPSzepG39RLvQz30tcnzezPqksJA4RK6k7d0wqwk+aPYUxD
 +Qv6YrzLazT/f7SUpyyq5P1e7W60N1OMqyQr6i531rsaUvUNi8IfGxMJ0eCU0JsQOuTD
 Pxo6hdAHOjH3aSgXB6COze0uwtipBkSR/fBuJktf4lf19wpSDrA37KtiuFMabXk0WFOH
 UWKg==
X-Forwarded-Encrypted: i=1;
 AHgh+Rq3Df9rT0SrRnv6jzRs5MT30vzvCNjWZ60tVLgb0q4lpC7XqcScNW8Be5GMecVZgXpol50BKjbHvgmN@nongnu.org
X-Gm-Message-State: AOJu0Yw3N7EHu46r2B5RSGnoqmF5DtSthXvgg5vsPA+I17g1Ez4gVaRZ
 ZohFqXWJYRDrsIbJXl0OJk2Y5jn7oZ1oUaQu2Qh4nt50x+YJcKE5Gkzm+FHpqq28a7/gYPjqQvX
 hgA169AA3R5qDqtuiA5wlfk1Mg4qG2Yw=
X-Gm-Gg: AR+sD12Ay1ABwkAFA0fdaMJipd83r7CjfF4mGEz5NiUwa4LTQGPuhL+zzPGRLyQmic7
 +HBZFvGbKXT38/bMbFszQtlXL92f880dyY5i/ImP9Lx/8ZmAZ1/KL/5Lf8UQGRw5vfYR8iOPHKI
 nJRUszPPbt8zY4B7qEvT3/bxiFub4bDNJ5/jYLBJgeg05Lg66aFcBoVH48wIm6JTmEYhJrl598u
 LLdOdLM2X7Vibnlyv0xKVHBK3kqXw+gZKobHSkRbu//BPf/TbG3pY3WG+LTaboGD2havq7lzEG7
 YKyzkKjypAgce6AW1Q==
X-Received: by 2002:a17:90b:1f85:b0:387:e0db:3fae with SMTP id
 98e67ed59e1d1-38f298bc8e2mr7941153a91.39.1785151254036; Mon, 27 Jul 2026
 04:20:54 -0700 (PDT)
MIME-Version: 1.0
References: <20260725-fix2-v1-0-5c9a6ce7b96a@redhat.com>
 <20260725-fix2-v1-1-5c9a6ce7b96a@redhat.com>
 <d6876e8f-1414-4e7d-b6e2-1b59a18e8288@rsg.ci.i.u-tokyo.ac.jp>
 <CAMxuvawR=TiF4r+wdVCDF3Hyu-ND9neFHjUEZn5_YnSbxweXhg@mail.gmail.com>
 <amc7i7-2N5fgXt39@redhat.com>
In-Reply-To: <amc7i7-2N5fgXt39@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Mon, 27 Jul 2026 15:20:41 +0400
X-Gm-Features: AUfX_mxOVrbUuUSv0c33dlx5by0nJHsS7uHAnBJxGVX1I1lAQT2jjBank9y2usE
Message-ID: <CAJ+F1CLAX7YrOQhRzA+a6W7gTeCZNqOhVqN+A8YhhywMx80kHw@mail.gmail.com>
Subject: Re: [PATCH 1/7] hw/display/virtio-gpu-rutabaga: zero-init capset info
 response
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, qemu-devel@nongnu.org, 
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, 
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 qemu-block@nongnu.org, 
 Jonathan Cameron <jic23@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Fam Zheng <fam@euphon.net>, 
 Zhao Liu <zhao1.liu@intel.com>, Roman Bolshakov <rbolshakov@ddn.com>, 
 Phil Dennis-Jordan <phil@philjordan.eu>, Wei Liu <wei.liu@kernel.org>,
 linux-cxl@vger.kernel.org, Brian Cain <brian.cain@oss.qualcomm.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@mailo.com>, 
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 Haotian Jiang <jianghaotian.sunday@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::102e;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-pj1-x102e.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Hi

On Mon, Jul 27, 2026 at 3:07=E2=80=AFPM Daniel P. Berrang=C3=A9 <berrange@r=
edhat.com> wrote:
>
> On Sun, Jul 26, 2026 at 12:24:52PM +0400, Marc-Andr=C3=A9 Lureau wrote:
> > Hi
> >
> > On Sun, Jul 26, 2026 at 11:33=E2=80=AFAM Akihiko Odaki
> > <odaki@rsg.ci.i.u-tokyo.ac.jp> wrote:
> > >
> > > On 2026/07/25 23:00, Marc-Andr=C3=A9 Lureau wrote:
> > > > rutabaga_cmd_get_capset_info() only fills in capset_id,
> > > > capset_max_version and capset_max_size before sending the response =
to
> > > > the guest. The remaining fields of struct virtio_gpu_resp_capset_in=
fo,
> > > > including hdr.fence_id, hdr.ctx_id and hdr.ring_idx, are left with
> > > > stack garbage and leaked to the guest, including host pointers usef=
ul
> > > > for an ASLR bypass.
> > > >
> > > > Zero the response first, matching virgl_cmd_get_capset_info().
> > > >
> > > > Not a real risk thanks to -ftrivial-auto-var-init=3Dzero.
> > >
> > > GCC only added -ftrivial-auto-var-init=3Dzero in GCC 12, while QEMU s=
till
> > > supports GCC 10.4/11.
>
> Opps, I thought we had new enough versions already.
>
> >
> > Good point, may be we should update:
> > https://patchew.org/QEMU/20260723094622.1515831-1-berrange@redhat.com/
>
> I'm inclined to bump our min GCC/Clang versions so we can assume
> zero-init.
>
> We picked 10.5 due to NetBSD, and CentOS 9 still has 11.x
>
> In both those cases, however, Clang is available in new enough
> version to support -ftrivial-auto-var-init=3Dzero. In NetBSD
> there are also many new versions of GCC  available, only the
> base system GCC is 10.5.

Apparently it needs clang 16 from Mar 2023
(https://releases.llvm.org/18.1.6/tools/clang/docs/ReleaseNotes.html#remove=
d-compiler-flags)

>
>
> With regards,
> Daniel
> --
> |: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
> |: https://libvirt.org          ~~          https://entangle-photo.org :|
> |: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|
>
>

