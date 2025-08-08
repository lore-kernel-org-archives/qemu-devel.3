Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20616C87FDA
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Aug 2025 16:15:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ukPkO-0004OO-W8; Fri, 08 Aug 2025 12:15:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ukPkE-000403-QX
 for qemu-devel@nongnu.org; Fri, 08 Aug 2025 12:15:03 -0400
Received: from mail-yw1-x112c.google.com ([2607:f8b0:4864:20::112c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ukPkB-0001BO-Du
 for qemu-devel@nongnu.org; Fri, 08 Aug 2025 12:15:00 -0400
Received: by mail-yw1-x112c.google.com with SMTP id
 00721157ae682-71b49bbb95cso22223357b3.1
 for <qemu-devel@nongnu.org>; Fri, 08 Aug 2025 09:14:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754669698; x=1755274498; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=prhq8y6zrjCUBFremScXMjEOI9QfXxVZfKJGjxYC6cc=;
 b=Qf8jUcAAq4S3blSD9UoLAErO2lp87sCGDX3zmcF6nlDo3JjXqLCUm+jTvWbDrKzkpa
 S5KPpliZImvLF1c2JV2xBDnjX1vE0DpRFVrsAWtJCs5o1diHneFzEs8gvo41UtxkGZlo
 3E5aw3C+Q9m5EbZQXe0DBmVYaT4QyIigQGbxH2XYf2Ol4h1EgYpzy7z37lhSb+SCKORI
 hsT4gpv+J4sjuUrG6g1swS6Zbx7PxJnA+zwBP0JBnXAtA64YffP+S4yyGvwgTbFfGtIU
 G1NDupULPio8oUG/Kpj8gR5A2WMQKCbpdwGJXZy4s/jnH7zToIsMDp+672FYbfRodbZu
 2yJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754669698; x=1755274498;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=prhq8y6zrjCUBFremScXMjEOI9QfXxVZfKJGjxYC6cc=;
 b=V/zGq8/xl1nr7Jj2WD+v4O5UnTVE85vj7/1c/x6+KHz4oWAmZfj/GB5dvJNzwtr+o/
 Be+GynfH6AHV5k1MjjxBhL35dc6cr8Jn8GZf8paGQ5Bdl7bCKC66xh+nsi+xFHMsmNWx
 NpsgMN1M3tRmU84jnukFB/hkumfjtX8SxpGFKsVHy7Rq3uJ5yihcIfJ+yTfliALcXbLh
 gCR3yQMZSbNjc8lEG2R29VPT/BJKrBguoQnFhupPm0eXPFwLmA7QKPZy8AfdJwTxkAwQ
 WBha7gl3sirgE7CesyDWGtkd7ZwEJHYEmITtOE6oojpxFImfpF1uIiToS3Y3EYM0Dl8U
 vzwA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWRUlY8W3H44msZry6OSKWsHEJZLnoOVLYvFTElWxvOBNT22xn48HPCilmjuVPqQyudY3LGthNCjVIb@nongnu.org
X-Gm-Message-State: AOJu0Yy04P4RdtEm/BBxc0nFuz1gqO5I9dWjWLZsbVIunhQNQnGW1b/W
 V2UsluPhbVUvRZwtO7D3fzEH2L4oUan4yqXMoV5Kkfzk+ygcotnhzVu1NmIGO35whZ/Vwu1Ablx
 DPMCiyXDRrxtjuSqcOTD0BY+UNHh9UmKeGVo2Uxui+g==
X-Gm-Gg: ASbGncuU9g7P2BnZKCxHLcOVerBG5EFPZ/wq989s+ZiIe7VO1sML1OdgT+W2q+paMKS
 XxX9D67Lq8IC4iC6OpbFLnnEeAb16pye7s7SSaNXmqipMNhrAvOLlcx16++Bf9tb+WD1XqrdcDA
 Vac+8MWJZhzU/8Y6K+gOJ7VlEiNHEjLDJvn1aIlVLkMkG7GdsA5tMctxTdJ3LCtiJP9H6EaVQNx
 saZvgr4
X-Google-Smtp-Source: AGHT+IHUT1+Y9HPlCiZ6H2ADeNjK5a+rUJP2zG7yWxXv478IRdXBRnBjJe+FDqpioeX4w8a7QmMuundAVB918321a4Y=
X-Received: by 2002:a05:690c:4885:b0:719:f41b:820c with SMTP id
 00721157ae682-71bf0ed9de3mr41356707b3.39.1754669697780; Fri, 08 Aug 2025
 09:14:57 -0700 (PDT)
MIME-Version: 1.0
References: <20250808-gdbstub-aarch64-pstate-regs-v1-0-14ba70be1b3d@linaro.org>
 <20250808-gdbstub-aarch64-pstate-regs-v1-1-14ba70be1b3d@linaro.org>
 <CAFEAcA-2Zt7HTDX_bdBHjJyQS7o=csE1x6eDymyEPkV3K+pXrg@mail.gmail.com>
 <CAAjaMXbZK=n_HJGrmuGv1DZZ3AeaX7-fK-soFto4J=w-9=vdmQ@mail.gmail.com>
 <6190716c-09da-4abe-94e5-2b713855f0e9@linaro.org>
In-Reply-To: <6190716c-09da-4abe-94e5-2b713855f0e9@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 8 Aug 2025 17:14:44 +0100
X-Gm-Features: Ac12FXxE3pBrpoQOTw6jsOUOUbSesaOvooiMP4QXm_rxvmUEBiLDF3d2m5Bi6c0
Message-ID: <CAFEAcA-QcjtkAUUUGVvaUVrJBqP3NvSX0DuXQ==MGcPrjNtGQw@mail.gmail.com>
Subject: Re: [PATCH 1/4] gdbstub/aarch64: add CurrentEL register
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, qemu-devel@nongnu.org,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Gustavo Romero <gustavo.romero@linaro.org>, 
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::112c;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112c.google.com
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

On Fri, 8 Aug 2025 at 17:11, Pierrick Bouvier
<pierrick.bouvier@linaro.org> wrote:
>
> On 8/8/25 5:26 AM, Manos Pitsidianakis wrote:
> > On Fri, Aug 8, 2025 at 3:21=E2=80=AFPM Peter Maydell <peter.maydell@lin=
aro.org> wrote:
> >>
> >> On Fri, 8 Aug 2025 at 12:30, Manos Pitsidianakis
> >> <manos.pitsidianakis@linaro.org> wrote:
> >> The debugger already has this information in the 'cpsr'
> >> register, so it could implement convenience views of
> >> the subfields itself if it liked.
> >
> > Yep, but consider: it is a register, architecturally, so it's nice to
> > include it for consistency. It's redundant only because gdb has cpsr
> > which is not a register. So this is about more about being technically
> > correct than correcting an actual problem.
> >
>
> I agree with Manos on this.
> As mentioned on a previous thread, cpsr is not even supposed to exist
> for aarch64. So adding architecturally defined registers, even if data
> is redundant with cpsr, should not be a problem.
> I'm sure gdb folks can understand this too.

I'm not saying this is the wrong way to represent this.
I'm just saying we're not the only gdbstub in the world,
and it would be nice to have a wider discussion than just
QEMU folks so we are consistent about how we represent
PSTATE (including what we want to do about the new
bits that appear in the high 32 bits of an SPSR), before
we commit to any particular direction.

-- PMM

