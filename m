Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D700DCF45B7
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Jan 2026 17:42:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfLvf-0002uu-LE; Mon, 12 Jan 2026 12:42:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vfLvA-0002p0-LO
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 12:41:50 -0500
Received: from mail-yw1-x112d.google.com ([2607:f8b0:4864:20::112d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vfLv4-0003iJ-UH
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 12:41:37 -0500
Received: by mail-yw1-x112d.google.com with SMTP id
 00721157ae682-7926b269f03so19006177b3.2
 for <qemu-devel@nongnu.org>; Mon, 12 Jan 2026 09:41:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768239682; x=1768844482; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=B721qfUlsGqXZvbl4e0pu+gAclaI0hj2lF7hrMzY3x4=;
 b=K46TOUXAfQevWGt8dJX4UGWGEpC1iTg37dZp+WEVJXAvL7STkGeWiu9kaIAXEzWQEv
 LOe8fJVzzJSVr8jo5/e/4hkVaikxMRKmaY837Fzq1Ehcm/BNZ3BplAcI2QQEEgC/HNum
 znE91cvenAnvhvkDgC8DAO/Njq2FiYRC19ty3iM8T2uzx3+qwmiv5XZwwq0n5RLb87tN
 7d54Yvd01mpbqCS4v21IqyOVAQ0jl6vKoq8KZ7P9wKeALafJvs/bJ8qznhfM5ojyuRAg
 X5031114E9q2ftUhAkam6BKih1Rnd2pc3vxbNGMEgCa0Qwmk8TGtt7oBJSMMtd+ozN9S
 l19g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768239682; x=1768844482;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=B721qfUlsGqXZvbl4e0pu+gAclaI0hj2lF7hrMzY3x4=;
 b=FJfwZEmOGEZu0y8wjzU8WcRafOcCdSK4dema9mzUrtRa9olYuBU7Dhp++XMdXwEU8I
 tFAxhQrXuP5Eh8+aRvMikWBE0DLKjznv1GTRl6M4W9iIIH6nGlltHdvc3NXo5q379Ruv
 pOoLBz+23ouvodZMAuqG++Pbi3EgX3KF6ZlmG0aCPBu+T86qB5AHGRvBMpjmqK7qUMUB
 uYWOOS+ZLQkh7VqfTG06gEqPqvIQrAaty6K8G/jlAzfCnD2Pj5g0ojUbkJomkac8QrsH
 8m9D5lra1AooORnYjzZn4uCyL0i1ZGEd0VbfxhGV59P5duASn4WFWerv/sIkPZ004HRi
 ZJzw==
X-Gm-Message-State: AOJu0YydOsgvR6N4W5vrMVczdiLn8B8ZVQ1e+oOMyeZhg12+EJsGR0DD
 2+r05Go5uWuuRtT5QEQz0IDfVZwoT1O9kpS0lRJ2C2iS31CsTeTEuPmMyvKsIuzTJEFpaUdzq1g
 liCfBO+Gci7g4slYvghgId71mRgwQM4Opq9whF10+8g==
X-Gm-Gg: AY/fxX7KTlH2nnOS7hvR1GsSbILRm3Os3uVtogUBK9YeO6Ct1fI+jfHHo9RoKq6rAiT
 tZnD1wxRbN/o+kWw/CgYjpFcUXLO4H7/+ryO+xkidvtXSr+D1s6rxFFVSbuanIUYYnRJyE78+Qj
 4nEgldZhZHgVRFyFW3OrC768p02tBQYjr6WxnIEqrkRB0o6Ru+DklLI520WpuyvW+yej869tREs
 nk8TBdSoG5KzVdcSRJlf4d4MOst3Nelu9Ywg2vrZ1fgZvlOw18Z5X0VslmHZKTR0QbSf+5ukkTb
 /awLtoERkZrpxpv0nUMPiHU=
X-Google-Smtp-Source: AGHT+IFCMyTAHQuPTd5JU+nZpICaj7KwGpPf02Liq6ZaBGeeDS7aPm+I3hC7Dz307GoKrLQ42vb6Vq2CBOBH82JzluY=
X-Received: by 2002:a05:690c:2607:b0:784:88df:d9d with SMTP id
 00721157ae682-790b572d336mr329010777b3.2.1768239682074; Mon, 12 Jan 2026
 09:41:22 -0800 (PST)
MIME-Version: 1.0
References: <20260109063504.71576-1-philmd@linaro.org>
 <20260109063504.71576-4-philmd@linaro.org>
In-Reply-To: <20260109063504.71576-4-philmd@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 12 Jan 2026 17:41:10 +0000
X-Gm-Features: AZwV_QgggA_Ih939e2Ry2sHu1cpL2eljv9TKAowr7maAvFn3Zi5cnIMEhGyFMzo
Message-ID: <CAFEAcA-c8Y89Wk2i8GJxGbpF9yYmUbT8yx8k556yD3gr_aF6Zg@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] system/memory: Extract 'qemu/ldst_unaligned.h'
 header
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>,
 BALATON Zoltan <balaton@eik.bme.hu>, 
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 Jagannathan Raman <jag.raman@oracle.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Alexander Graf <agraf@csgraf.de>, 
 Phil Dennis-Jordan <phil@philjordan.eu>, Peter Xu <peterx@redhat.com>,
 Jason Wang <jasowang@redhat.com>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 qemu-ppc@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::112d;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Fri, 9 Jan 2026 at 06:35, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org=
> wrote:
>
> Unaligned memcpy API is buried within 'qemu/bswap.h',
> supposed to be related to endianness swapping. Extract
> to a new header to clarify.
>
> Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>

I'm not very enthusiastic about this one, because it takes
one set of functions out of a family of ones with related
names, and moves it into  a different header and drops it
from the documentation comment:

> -/* unaligned/endian-independent pointer access */
> -
>  /*
>   * the generic syntax is:
>   *
> @@ -201,7 +200,6 @@ CPU_CONVERT(le, 64, uint64_t)
>   *   q: 64 bits
>   *
>   * endian is:
> - *   he   : host endian
>   *   be   : big endian
>   *   le   : little endian
>   *   te   : target endian

These are all doing variants on the same thing, which is
why they're all in one place and have the "same pattern"
names they do.

thanks
-- PMM

