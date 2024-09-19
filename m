Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A90E1CDD573
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2024 13:16:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1srH0G-0001Og-Tc; Thu, 19 Sep 2024 09:15:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1srH06-0000rG-Mb
 for qemu-devel@nongnu.org; Thu, 19 Sep 2024 09:15:16 -0400
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1srH02-0001WH-LJ
 for qemu-devel@nongnu.org; Thu, 19 Sep 2024 09:15:13 -0400
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-5c3d20eed0bso1068324a12.0
 for <qemu-devel@nongnu.org>; Thu, 19 Sep 2024 06:15:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726751709; x=1727356509; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fFGE1BTMD8PgEyANRQyAdpYr6j7ELrOQUa9Nz8kkLRg=;
 b=jLy+1CuEXs+Q5DFmR1aXDdSkVvw2OpQeqLOhi4TrCZpyhXyNpv7BfCGfFDTXkZqkOg
 EiXBNPincourvw83ZjF47OaDOpwCEVCtBMejsd5yJMzm0JVMuD6LInX85zHG4MBBpe58
 MTeMPN8jw2ao2vx5zMLAs7K4fHk3Z47rE2rm4zgBkmr5f0HgpmIypl3ADsVF7sBDAjxN
 BdjsqeEHt7FF7HsG2ijSRxXx216+ZEeyR9KuZL6CGrL+0736dcN28810BJepaS5C2p+G
 tfNoYcU3DCXgvlY8muOQLXBkHgd+VoSEKuOMNN5kWJ3gRZLXvmNjboMKcdU4cSiTwyRT
 WZQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726751709; x=1727356509;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fFGE1BTMD8PgEyANRQyAdpYr6j7ELrOQUa9Nz8kkLRg=;
 b=c4U1kciwdM0iGSgaNwNvy7S7ErjBR/0QxTl04BhRl8kHmhmutqfwQohfbjppy8SX+q
 R9HOBSMbHo5GILJXo4n/RGcWQ5XWaG12HbktMnNDLuj3R06whgGWhCHyxE/1ItC1px79
 8b0GZqMYDKr0BRdjdODJOwUmfXrsA32KpwE0J2TrQ11DioWoqj0YW2yNzHC1hSVuCqyl
 hf3rQzECuWvoRt0oUrr0+EZ/II91XVxuOzP7rULjLTW7HDuaxXDaDv3kLWh9kC9ExA6y
 QoZB8LDTkCMaE5sYbk7ebk417/BogNm19nhBg5ZAaMqa8ZfofH/OtL/AoNpukgU+jRex
 HMcQ==
X-Gm-Message-State: AOJu0Yw5aug7AJhdTqIh3E7Av4A9wXBb5AwVmOvJlX2xJh8kaiBwhldt
 J+1jgjDpeBK1d0EVdWf5267UAWSwxskGztmudT1UjFKZzb/uBj2aAEhklud6HffteZVA8oewXYx
 bHXZVlF7B/ZOiNLOF0sbrHR9klAkRYdQVcCQqrH7vMFis8BJG
X-Google-Smtp-Source: AGHT+IECY+knqYtslkktAtnY5bLyNAt+5QhZH10vTv50sMurd9AuAZN+vv2ZVkSV6SUCKPVpICRCHt+x71iwpUBtxic=
X-Received: by 2002:a05:6402:1ec9:b0:5c4:4dfd:9fd5 with SMTP id
 4fb4d7f45d1cf-5c44dfda03emr5331227a12.29.1726751708815; Thu, 19 Sep 2024
 06:15:08 -0700 (PDT)
MIME-Version: 1.0
References: <20240918210712.2336854-1-alex.bennee@linaro.org>
 <CAFEAcA8tdyELui0=jYFObZO1=O_isJ-c1e0s4ZCbMVyfsrY=9A@mail.gmail.com>
 <875xqrg549.fsf@draig.linaro.org>
In-Reply-To: <875xqrg549.fsf@draig.linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 19 Sep 2024 14:14:57 +0100
Message-ID: <CAFEAcA8UGKtZLNZZVQiDryjst93AkQTKhQrBQ573+J21C-y4QA@mail.gmail.com>
Subject: Re: [PULL 00/18] tcg plugins (deprecations, mem apis, contrib plugins)
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52b.google.com
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

On Thu, 19 Sept 2024 at 14:11, Alex Benn=C3=A9e <alex.bennee@linaro.org> wr=
ote:
>
> Peter Maydell <peter.maydell@linaro.org> writes:
> > While I'm looking at the code, this caught my eye:
> >
> >     case QEMU_PLUGIN_MEM_VALUE_U64:
> >     {
> >         uint64_t *p =3D (uint64_t *) &ri->data[offset];
> >         uint64_t val =3D be ? htobe64(value.data.u64) : htole64(value.d=
ata.u64);
> >         if (is_store) {
> >             *p =3D val;
> >         } else if (*p !=3D val) {
> >             unseen_data =3D true;
> >         }
> >         break;
> >     }
> >
> > Casting a random byte pointer to uint64_t* like that
> > and dereferencing it isn't valid -- it can fault if
> > it's not aligned correctly.
>
> Hmm in the normal case of x86 hosts we will never hit this.

Not necessarily -- some x86 SIMD insns enforce alignment.

> I guess we
> could do a memcpy step and then the byteswap?

That's what bswap.h does, yes.

> Could it be included directly without bringing in the rest of QEMU's
> include deps?

It's technically quite close to standalone I think,
but I think it would be a bad idea to directly include
it because once you put QEMU's include/ on the plugin
compile include path then that's a slippery slope to
the plugins not actually being standalone code any more.

-- PMM

