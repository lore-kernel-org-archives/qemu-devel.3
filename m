Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 864D6C531D0
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2026 15:23:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woNB1-0004T6-AP; Mon, 27 Jul 2026 11:23:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1woNAy-0004Sn-BF
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 11:23:32 -0400
Received: from mail-yx1-xb133.google.com ([2607:f8b0:4864:20::b133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1woNAw-0001Kb-Rz
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 11:23:32 -0400
Received: by mail-yx1-xb133.google.com with SMTP id
 956f58d0204a3-667971437d6so3249267d50.2
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2026 08:23:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785165809; cv=none;
 d=google.com; s=arc-20260327;
 b=emmhKG2FsKPUj2JmiLjBigcj3SKipQ9U/uFVoPZ40Pz4Wb1wq1WXMDjRZkiVAAvLxi
 t/oU6ZHL9kEbWiBZoTuSRBonq0zrLKxGmAeVu0+3aKItAqZuPEvYxReay1PbdnilIQo/
 v8ucycusn1NEbDSZeP29x2KWn/9HpIS86KQRXCjEXjG2v0z0Y3CYo5TMvCYSv0D9z28G
 MtDm6+nJt/ndYMge0wix/wi0Ii1/Kz/IPAlhRed1HT1gtVz+mX4b+R9B2s3giwUC6yBy
 fcNMqAsT16WxsFs2dkoMSNvPx10L4WkI3eP8/nADeFMN+YvESKTbeg/b3c7vTIgAZP/T
 eVCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=nVwegPiCUrZ5IVEwHMKNwAai+p5zgJ2FEYLbd2wEh9M=;
 fh=krQ6Vl3sXCPHFDzW4GkZo+VOdcBRRWxDK6R6iZbzZd4=;
 b=SPvFdMK45W/oM6iDv52yaQRhFFqc6NyE4tG8/93C/nyWbCmxAhIG74bWVSjcfATeCh
 p9d1SrVjDGnb/wk8RtecNPfqEwJPXx2+Vy14ihAmidEn5bPv2I1QmrefJHWaiQZaifjh
 2tQtju5sKY90iWdKcGk6JqNjLNBs95NhE2V0fLryazQvsJ0Qt48niFGz+TwE87E9Wrye
 t7syqocFm8K4R/3jYZxHPZd6DZDe0vj33f1FOjLlpiw9EWDk7l4mZwrFS0c8+dYVst/q
 iesgMb3DGBclfkAgu8D1vdkZTKUzneX/Hvv/tFiDqyL9mm0NyBo7Er9/E8x5lUUR5WgK
 9ecQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1785165809; x=1785770609; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=nVwegPiCUrZ5IVEwHMKNwAai+p5zgJ2FEYLbd2wEh9M=;
 b=wgVLKC+gU4dK2EA4Eo2eLRVRi7As8CTGdFMd/MOJK7vFMj6O+YCringI6QC+DR4O4X
 NfUtp8IEbqJlDNvtfKoO+QiyUSGPaiezJD1fHSd+I6a7lKGjrXwYPQlTw3Y517Hz/YPA
 r562L0Gq7wzbI8Qyc34tSY2yyGToIS3mQo9zt5vHE8NoQqSglq8QUOxp5r5h9ZejOB5I
 PBINuYNjXxb14+qiaUcwp4FJ8vqENIy4EFz2LPY1ez0M7C3vUfVtb+ijqOEaHJ/u6uTD
 4JDtoTeyxfXlq+YMesbZeNtPsqtZLMtjlhIKRrmjxSIjonD6dgWqS+c76Z8H+NRpspwI
 sQKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785165809; x=1785770609;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=nVwegPiCUrZ5IVEwHMKNwAai+p5zgJ2FEYLbd2wEh9M=;
 b=tW3AVM1XGqIK3+TAGSyqoEYAonKuxgpL3E6+Sg46dHqa6009lvCc7R0/c0K3LaOlPY
 D+VyK+8oz3WAf6AF4azvHbxKZZ+UCAKJJlBTqzXLsOKOpSU7YjSGqy2mhgPDuOLYW2lY
 lzZdSDHgSHK6WaWemfZTzj7Ob6FU4x5LVGbjPvpA9yJtok+APWVlaKbiri+9CS0E8KYz
 OkS3gapVRWgFqCLIoPDAi+3asc4Xc3P0eEG3BrwQ+F5Lvc7+hvorYfEfUSk3Ocb80qyZ
 TovTjqdCYvMew/AO59QPSGuvkkOMbHyoTnV6NbvlpjynB3jOvltDX63YiyJWqfDevu/P
 8kVw==
X-Forwarded-Encrypted: i=1;
 AHgh+RoeUd9Dz9kJMR+tXl6dmQlrqBrWOnwuGOR3HHX9pBAdzCCCNPYWBtGWLekLRQGj90aKgiFws+/9BP7P@nongnu.org
X-Gm-Message-State: AOJu0YyCMLVaSeuHa0AOOCa6bmqwggoV6kpmKEb6y5dgWh3/zShooY5O
 8faKdnH2ivaGpAxxjeDz4VjkyezZh8Z08km7YetPjhUXpUqm0JiSs32jlbU2CLZiec1ErEBXs/O
 JgrqE0CDYOyWKVatS71yJlBxASuKpp41urKlEVn8dew==
X-Gm-Gg: AR+sD10Nd/1dZQyCQ14XyfrDzujNe8oXFPUhdCX6tzkOS62v9wYEQmaJFGHgv/fq6gN
 FPpuC7p/EIlK+QkmsypIFzNw+Ii3Zxa6CtBGp/flJ3aSBAUhkIooD6JOkjfa7F5dS87MIIvh9sf
 WLHzI6JOCYE0duLJLi4TowjCfhqXhfLtbv79GmfDij1MU+hKxmBGLM6pVLF7sFlSdOApN1EtlDm
 cxcxX/gZ8nOesHIUGgOS/7+n64T92yd7mLXhQWydHp5AtQ9OLgVDz4/2Y+hslt6q4XgOx+ej87Z
 RT/5ndgOtFnL+MVRUvpO8rPZOHypdQJnQqpzJtU8OFGahA==
X-Received: by 2002:a05:690e:400a:b0:668:4d8d:18b2 with SMTP id
 956f58d0204a3-668c7a7baaamr2766876d50.108.1785165809238; Mon, 27 Jul 2026
 08:23:29 -0700 (PDT)
MIME-Version: 1.0
References: <20260724135413.1716872-1-flosch@nutanix.com>
 <708798a8-3d43-48d9-a4f6-210eb88a88cb@oss.qualcomm.com>
 <92358092-080b-4b1d-82e5-733d2531ff38@oss.qualcomm.com>
 <c68be7c9-113d-4de1-8ab5-bee142e8db15@redhat.com>
 <6b432df2-b318-75ec-e26d-e1134baa06ca@eik.bme.hu>
 <3677fd2b-64fc-45fe-8bb7-04f84773c77e@oss.qualcomm.com>
 <87bjbspipl.fsf@suse.de>
In-Reply-To: <87bjbspipl.fsf@suse.de>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 27 Jul 2026 16:23:17 +0100
X-Gm-Features: AUfX_mxMsVD7FROix_RCm-7GHL_DPmRILDJe7vxNP9gxWOsTF2amu_gWdlXZcEs
Message-ID: <CAFEAcA-VTV=r4cCKgfXD-4L3HixAVOMX3BUerRWbN=6fg_L3MQ@mail.gmail.com>
Subject: Re: [PATCH] Add option to disable building tests
To: Fabiano Rosas <farosas@suse.de>
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>, 
 BALATON Zoltan <balaton@eik.bme.hu>, Thomas Huth <thuth@redhat.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Florian Schmidt <flosch@nutanix.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@mailo.com>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b133;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb133.google.com
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

On Mon, 27 Jul 2026 at 16:16, Fabiano Rosas <farosas@suse.de> wrote:
>
> Philippe Mathieu-Daud=C3=A9 <philmd@oss.qualcomm.com> writes:
> > I'm not saying this patch is a bad idea, I'll likely use it too;
> > I want to clarify what are the valid use cases the community sees
> > here. Building pointless things clearly has a negative impact on
> > resources and our time, but not testing changes also has.
>
> Perhaps we could add something to checkpatch that emits an error if
> config-status has --disable-tests.

I think that's probably overkill. People who don't run tests
are much more likely to be doing it by simply not running
"make check" and "make check-functional" than by using this new
--disable-tests configure option :-)

I think if --disable-tests isn't the default then that's enough
to mean that it only gets used for the situations where it matters
to cut down that build time (like the bisection-test cases etc).

(Also, checkpatch runs in a source tree and can't know about
configure options, which are per-build-tree.)

thanks
-- PMM

