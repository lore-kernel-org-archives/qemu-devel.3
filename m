Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3589BCD6E49
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2026 15:55:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSzYJ-0004eb-UL; Fri, 29 May 2026 11:55:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wSzYI-0004eT-Uq
 for qemu-devel@nongnu.org; Fri, 29 May 2026 11:55:15 -0400
Received: from mail-yw1-x1132.google.com ([2607:f8b0:4864:20::1132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wSzYH-00013b-Db
 for qemu-devel@nongnu.org; Fri, 29 May 2026 11:55:14 -0400
Received: by mail-yw1-x1132.google.com with SMTP id
 00721157ae682-7cb345cb5bfso121691827b3.0
 for <qemu-devel@nongnu.org>; Fri, 29 May 2026 08:55:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780070112; cv=none;
 d=google.com; s=arc-20240605;
 b=VAf/cgX5N1V1B6j8Wly71UrSWZYiuamRR3vFHQh8X+XSPOJAEQl2eHsabwHUrK0Tla
 8z/fHywYe8tzl0j6N1o9XN/yUpkYSFnR+lQrg8UjbVSN7d50b8qhmxq2UmSUsc2z/vgC
 SwKa1Q8ZS5pQe+xWBgbMCCSKWMqcAA+rZCrc04hCA0ZiF/uvnaRfc5Z67Ged6cdkyQoM
 /h1rz+OpHm2sGPnTkHSn2nxT7v9I/AAP7hF9MN85z07lT9jBOqjVcWlvQ8oPLgPpmceW
 3yL8Tv5v8OR6F8t96tyQUaoFcT0vTLRp1jsjGu2AtCCaEITufcug+xPMKmy/XxULL8Tt
 xXiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=p48DT0QqfSHL088hjxK+XXLQh/S7t110iUYXfbTekhc=;
 fh=h7q2rw1XHYafiR6RWpvnuz2ca1lrfLtBAl8nXrV1ED4=;
 b=ZGRuC/abH0odHy0pHEZN5dxPTTDsYfSHsZjCd63Z9XGlNILAthvOI5vMUufsfE33yo
 2syHU0zASnf6w6Sro61M3dUngT/6hE2635fmaFKe6oUZpt2jKdqu7yybn5zfOQk+EXpU
 EZ/RECfMfv5Oi6ceJm5eia+kfgdjBTg1c9opAaAb14LBJDgOwVbm9XB5Hd3ZZGayldGp
 tY0SLH76LkNETL7DyJY0dy0uRe68SgieNLVzYiTg0KEzVZ8l9FSlnjqrAkc6wDNDu+CC
 KQKclFEs/5MhuRThSIBO+ZRGBV3jkjV/7/c0TZbiYwONHYCJxzfSqMmRAnK5xXVusXoY
 upkg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780070112; x=1780674912; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=p48DT0QqfSHL088hjxK+XXLQh/S7t110iUYXfbTekhc=;
 b=pyR1zXgQdQi0bhag4amKn0Qn/b3JFB3OcglFQyVjvXhgkBfXxaKaF7B/ZkxapxL3tG
 MhDuA0z1VQbh2AvF+VelDgUTPcqVgPSFnMnHNCVTxV3KY4n7Kx/7Lp3cPgMrMysehl26
 3xEJD/sN5QsbNFcdZLoNruJnoIXZjUuxAfgChv2NFp3ZH+hm9sGb1knUm4gHa9wwNHzv
 wykivM1zuHTWVIN9kyCJz5+KEdy02zVuSky61BLhwvzYPDgGHFSjKiZjUEQ50t0sow9r
 XKGFc4bEWCkZzAP227VYXlU0IVspqjmCWF4TlZaenkjdbntBKhOACTph4OfgpIr3asHN
 owtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780070112; x=1780674912;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=p48DT0QqfSHL088hjxK+XXLQh/S7t110iUYXfbTekhc=;
 b=rdapzOfUeS4p/+6Mw6x3SO91aoP9Na0vz9Y7P83kWgqMtR1sAf0y2K7H3xvw3c1u7n
 TnEkLC7+tiASBHRzANiMnJE/jBAZ03FvyoiR/T8lvTZ0T6Go9333XgRLDIqGPI8yshSX
 bnZfvCZcbHLLz1LJueWqi7IaScWKL4spGLZq8w6I804YgD6RXEIaNl7K/5utUNUG1P/D
 kEUZg5CmLLtVem2MzFGgC7+2+dJss4nwe4HIf+5z6g0cKVft+QdkL7EAs054sPw7xX7a
 RNNO65kLR/f11oFVwuLjQRbEZrA9RywzybrD2sEIzgoqEEgjpqnGE96F5L9Mu5Mi/EeO
 51Sg==
X-Forwarded-Encrypted: i=1;
 AFNElJ/G2BwjouGA6k5PuVKqthVMLHyERQwmVe8FP8h2tHAPNkpN4E71fYTfwnYjgF3gxDKxCWTUR6oOx4u1@nongnu.org
X-Gm-Message-State: AOJu0YwCHoxTEPdaCZ5HvkFgtNYj9CWFRkpaIkbG8hEAlHR8CShsQ1f5
 j01WuPBp2k+sMnn6iBekgi5t9obptZc1g/L1mRm6V3KlhfSNN2PvdBaXuC2gdrVXpo92fiPkbjE
 het35/AsO5Z192e5Mt6VaUKfgmbluLyLoI/gMc00GaQ==
X-Gm-Gg: Acq92OFTFrdm8iUYLF8aZdihEcv/P6fSZxqU3pTqEr5ZaWRxUSUsnH5YdtAvBrHKeYC
 v0VYvB5UygBQt/LSktRwPtZ4NbvVrAtzcFZQO+NjDTEnRFUJEYVPp6PbMPinrYRRIhVZfTkB8cI
 Sa4/lsqb73uSQMlhLwrIUkBCmPuCVl1PR9ib8lbpkK4jkxa9lvgacsO9NmyrPM4DAGCYTEM+Qgi
 IZ+QMnHm1fNNo58LuD+rUYtqLrp4YhH+oA3eetAec215/zujfn0sbyMi5tw02WEA0YyMkRcnnZC
 0bi9x2BB8SrWJQqPpLeXqHZ1bHcn1rkIgh173QCHwHnHhimD+Ql0ihJ71dBgfs01I1TvzJ7ncJO
 8qQ==
X-Received: by 2002:a05:690c:e3ea:b0:7bf:55b:8f97 with SMTP id
 00721157ae682-7de465ed72emr30966977b3.14.1780070112081; Fri, 29 May 2026
 08:55:12 -0700 (PDT)
MIME-Version: 1.0
References: <20260529094619.1034458-1-pbonzini@redhat.com>
 <CAFEAcA_EWR_MjH1arCdi2y0saZ-Hc7zRAK97YTeEcesVRb9Rtg@mail.gmail.com>
 <20260529114114-mutt-send-email-mst@kernel.org>
In-Reply-To: <20260529114114-mutt-send-email-mst@kernel.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 29 May 2026 16:55:00 +0100
X-Gm-Features: AVHnY4IBSQ0G42tGK4xg7cBJfa9g9w7PnkHg-1zHoILqo0USP0LhjUVym2lR_-0
Message-ID: <CAFEAcA8usUU9f_WKNiDQUxgxC5Q9mv+3mMO=txibncYLxUjZEg@mail.gmail.com>
Subject: Re: [PATCH v2] docs/devel: relax policy on AI-generated contributions
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Alistair Francis <alistair.francis@wdc.com>,
 BALATON Zoltan <balaton@eik.bme.hu>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Fabiano Rosas <farosas@suse.de>, Kevin Wolf <kwolf@redhat.com>,
 Warner Losh <imp@bsdimp.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Paolo Bonzini <bonzini@gnu.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1132;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1132.google.com
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

On Fri, 29 May 2026 at 16:46, Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Fri, May 29, 2026 at 04:34:45PM +0100, Peter Maydell wrote:
> > On Fri, 29 May 2026 at 10:46, Paolo Bonzini <pbonzini@redhat.com> wrote:
> > > +**Documentation and code comments**
> > > +  While AI can help draft text, it still requires significant human
> > > +  oversight.  Pay attention to the organization and flow of the generated
> > > +  text, and strictly fact-check all technical details as LLMs are prone
> > > +  to being confidently wrong.
> >
> > I think the application to documentation and comments is the part
> > I'm least enthusiastic about here.
>
> But I am very enthusiastic about less agrammatical english in both.
> AI is super helpful for non native speakers.

There's a difference between "I wrote the comments / documentation
and then asked the AI to check it for grammatical mistakes" or
"I wrote the documentation in my own language and asked it to
translate" and "I asked the AI to write or draft the documentation
starting from nothing". I think the first two are OK, but not
so much the third.

-- PMM

