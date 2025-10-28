Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5684CCCF9E0
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Oct 2025 10:49:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDhFT-0002GQ-Md; Tue, 28 Oct 2025 06:48:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vDhF4-00023g-5a
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 06:47:58 -0400
Received: from mail-yx1-xb135.google.com ([2607:f8b0:4864:20::b135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vDhF0-0005xw-Pj
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 06:47:53 -0400
Received: by mail-yx1-xb135.google.com with SMTP id
 956f58d0204a3-63b710f276fso5768841d50.1
 for <qemu-devel@nongnu.org>; Tue, 28 Oct 2025 03:47:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761648467; x=1762253267; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=iRUNPzBvz0MRk1I0+mVwY+KKP1PmceJ3cj2K11a40gQ=;
 b=vlj1UcbJee65U6knCj7Tf9hlh8dEcWTMYM2ti0XrUHrLI5/oUfjvZoR43kkkunCHBv
 TDwhHJ6lwoZoeAGK2+afIQWKMYYAwuJNVsvRWpz43ymWG1fzM2bxzeAMh7Ic3tImSF5I
 Xc6vo6lI1VD4ZJgaG4V1zZaxiG6Dn4inTPlGoqvnpXr7sDT7bjk0+Zgx07kG9/Bz5iUt
 G7a9Pk2C+JQcljMa823LHJYN3FRlpDM0rg/FZ2h8hNH8BpLFVMB4AiCajF/EQUFuwdyh
 2nr1ulBmREzfINNcw+B6CEq8bhR+2zSEfsumZ9XrkcfrCyKKH5nakT79PTVoj9sT42df
 MfGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761648467; x=1762253267;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=iRUNPzBvz0MRk1I0+mVwY+KKP1PmceJ3cj2K11a40gQ=;
 b=KXyBgvEUGBePtex8fQPolJtL+4FCdrRXx8d8yD4fe6Zq3etPuyWCpTt0fkfdHmJPLc
 T55K4Ic7TzbZn79Mpn+TWRvXnKrvWKfpI47LH3P86iRQ5VYdvaqycKhSkEhN//OHA/1Y
 LnZ3m5L8BLy1YFIrYAzuiMGQc3MgPG1XRKXZ//ta2NswiGmNJy+iYmnXTbp6yCIOIG31
 SCxM2MTHpbiUFHmA/TbOR3/3eUKvxE3hB/hSRin5Uk1hDYBeT9KgHqe+YADoG6n94XST
 Vqyp9yxvUNupk55KygC3moz2LifrDx21o4w1mUOtZevvW/q7RvsB2eMO3HEYRegl0W9o
 iYnw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVWrhsY0o5zsBI7hkBfnB0KcR9dDWDMY8dxYK4JE/BCYvre765iuMqFMNSv1HDcHzBXRHjgtagFsLSi@nongnu.org
X-Gm-Message-State: AOJu0YynyCPWHPdJzesNUGQBFsXQ/zAlOCqMjWQgTv4ed6cOiESfHMJJ
 3ieejw0DYy1xFeURsvSqDVv54JNDmYnppFkTX25Exn8QtCX9TjD+6OmhQl+WPQU55rc27jgX3fd
 HUJUdAA0Q2H8HgdKAf5lfsJEPmL0IU8pdSa9w+PGu9Q==
X-Gm-Gg: ASbGncvD/NpASbLfiiYSNN+cnQPr5GedDqX+oMAsqzy2fEAvfgTQu7be5QyrmrgO3Oy
 FBXYkPkNZM8ojZeE+3wGiXGblYyouTUd1jBXl4gbh8qUSGFboKF7BIAPSWrTPCFzRsFK8lhFxf4
 Gj8cSyoZLVrAjiJsAyIDaDbhDBLO64cn+8/ffPGA7DRDF0EbMsl4Kh5pnBiLLABj3e0YOEUD9aR
 n+pP+wIUEsqdZR9p6iNbut9jJknGh71h1Uw45MRSmVs15kEPLwVz0edxoRnIQ==
X-Google-Smtp-Source: AGHT+IGPTM2iiHEyDIVRewOlL4lqy7N51X3cCne5oqH6fh2JoZ/udWKHzozJ6CuHLv136CHYTxWli41gm645UgJuv0o=
X-Received: by 2002:a53:ad81:0:b0:63e:2fdc:b59 with SMTP id
 956f58d0204a3-63f6b92fd73mr2069912d50.1.1761648466612; Tue, 28 Oct 2025
 03:47:46 -0700 (PDT)
MIME-Version: 1.0
References: <20251016140039.250111-1-eric.auger@redhat.com>
 <3c963761-8587-4905-8c8b-60dda381262f@redhat.com>
In-Reply-To: <3c963761-8587-4905-8c8b-60dda381262f@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 28 Oct 2025 10:47:35 +0000
X-Gm-Features: AWmQ_bm1K-lEwZ9WEx-MK3kzDLu5Q3463OgitBiBK4EtAiNaXzAKaDYryZDPANk
Message-ID: <CAFEAcA9LfL8cYka8Dr2t6oS4av+4+Gvso4ywoMb8ERcXVJETHQ@mail.gmail.com>
Subject: Re: [RESEND PATCH 0/7] Mitigation of "failed to load
 cpu:cpreg_vmstate_array_len" migration failures
To: eric.auger@redhat.com
Cc: eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 cohuck@redhat.com, maz@kernel.org, oliver.upton@linux.dev, sebott@redhat.com, 
 gshan@redhat.com, ddutile@redhat.com, peterx@redhat.com, philmd@linaro.org, 
 pbonzini@redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b135;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb135.google.com
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

On Tue, 28 Oct 2025 at 10:05, Eric Auger <eric.auger@redhat.com> wrote:
>
>
>
> On 10/16/25 3:59 PM, Eric Auger wrote:
> > When migrating ARM guests accross same machines with different host
> > kernels we are likely to encounter failures such as:
> >
> > "failed to load cpu:cpreg_vmstate_array_len"
> >
> > This is due to the fact KVM exposes a different number of registers
> > to qemu on source and destination. When trying to migrate a bigger
> > register set to a smaller one, qemu cannot save the CPU state.
> >
> > For example, recently we faced such kind of situations with:
> > - unconditionnal exposure of KVM_REG_ARM_VENDOR_HYP_BMAP_2 FW pseudo
> >   register from v6.16 onwards. Causes backward migration failure.
> > - removal of unconditionnal exposure of TCR2_EL1, PIRE0_EL1, PIR_EL1
> >   from v6.13 onwards. Causes forward migration failure.

> Gentle ping.
>
> Any comments on the approach?

A couple of general remarks:

(1) This isn't KVM specific -- see e.g. commit 4f2b82f60
where we had to add back a fake cpreg to un-break forward
migration of TCG CPUs. So our handling of this kind of problem
shouldn't be restricted to only working with KVM.

(2) essentially we're re-inventing the migration compat
support that VMStateDescriptions provide. That's kind of
unavoidable because of the way I implemented cpreg migration
years ago, but is there anything we can learn in terms of
(a) required feature set and (b) trying to keep parallels
between the two for the way things work ?

thanks
-- PMM

