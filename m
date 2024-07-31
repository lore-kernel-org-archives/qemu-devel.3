Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34AE2C3DA7F
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2024 08:28:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZ4fq-0004u6-3s; Wed, 31 Jul 2024 04:27:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sZ4fp-0004sr-04
 for qemu-devel@nongnu.org; Wed, 31 Jul 2024 04:27:05 -0400
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sZ4fm-0000cg-VL
 for qemu-devel@nongnu.org; Wed, 31 Jul 2024 04:27:04 -0400
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-5a20de39cfbso7372568a12.1
 for <qemu-devel@nongnu.org>; Wed, 31 Jul 2024 01:27:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722414421; x=1723019221; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uBqVN9xvtD1uH5jTjQebmW4+35/w0vGS/68vJqS8Ujk=;
 b=XYNKinye7uPgSJj/NcHocmY4n8+ojY2NHAXwtIZOF60bX0i11BSPLvejiX6TMjnkgf
 liQhHBjkn9SKzkrG4ug6ureECYHVflPjQwSfUEOarVz1rEmGZMVcr3H+rFAOIrt/sDHF
 4bpuNHtb5vb/FML8fErZwAwzyw2U8ZqP7DPF4/bT9lLgG/VCX99XtUErv0vsC2c/n6TK
 mV6cE+mFdFoQFbNLBy90MNBJ2lznq/SIm06iHZVmp34G7/Tq94TIVC1726mgdCRuRYKL
 yQyRRA0jh/CJIiAIx7MOWp+0Rrfy+bL7ChDUUckz9tsuhpjv/YEdVqCZzwXQ/SFwGquf
 BHUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722414421; x=1723019221;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uBqVN9xvtD1uH5jTjQebmW4+35/w0vGS/68vJqS8Ujk=;
 b=B8n+emolThOw05pyH+6jcOR22H1iK+ChzZRheZh8zHXBtW/pKUpYnDYgylh3FtiXLS
 U3zMi1qqlq7MPW+aJD9oUYuJMEpOomSwzqBe2nqlqXxYLsE1u02oR3BWbszvdtsBrBxP
 NvAwcfO0i20/NIKsFkHod3gdRHBwN0nL9nh44gqbKo1l6vqwfsD7tC5AFyPkh4qwfryr
 CKtWG/3spmli98O2UXly4UJ4cRt04rKXkx5Ed7DPOKgNlrB6oto2vA42lD/dCRIZBldj
 Gctp+Bx7/V5BQ7KQ5l2olbKKN7tF/8CxvddrTIfu0mjhtbQdaDST/IsG+vRhCWVSbg7X
 VFJQ==
X-Gm-Message-State: AOJu0YySfDM2Ho7ZyswUWpKZ5+/9dHw1sCkubA1aVPSTjUn9lx/wRQax
 /MzggJco4LOPEVJGum7gC29Qdv7QhJRnXl026yf6u4W0zobZqC20XEqrUrFjVLbPSoSLJ9AZP3j
 tZO5wIXTjE4qVDYZWK3ATBBzhXwdsnQ4PtkDtPA==
X-Google-Smtp-Source: AGHT+IFz6yfItp0hQsuBZ3s2LES1zBRLC7lkJP5M/rA7miaECoht0EPAUtEEBTR4xJXp6HWFRn5/jas955DYs/Uh0Xc=
X-Received: by 2002:a50:a683:0:b0:5a1:faf:e5ac with SMTP id
 4fb4d7f45d1cf-5b0224cef4cmr8203761a12.26.1722414421096; Wed, 31 Jul 2024
 01:27:01 -0700 (PDT)
MIME-Version: 1.0
References: <20240718230031.69641-1-danny_canter@apple.com>
 <CAFEAcA9Y3yNoOQp+Ei3M4mtOyeMKAh9fD9_WBimrSYETxFkUhA@mail.gmail.com>
 <8CEBAF31-2582-45B5-B391-DE4F392EB932@apple.com>
In-Reply-To: <8CEBAF31-2582-45B5-B391-DE4F392EB932@apple.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 31 Jul 2024 09:26:50 +0100
Message-ID: <CAFEAcA8WN5abC7wARmMd1+ePr2yaZ61wVLpJMcZ-5TUnvxQXFA@mail.gmail.com>
Subject: Re: [PATCH] hvf: arm: Allow creating VMs with > 63GB of RAM on macOS
 15+
To: Danny Canter <danny_canter@apple.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 Cameron Esfahani <dirty@apple.com>, rbolshakov@ddn.com, agraf@csgraf.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x534.google.com
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

On Tue, 30 Jul 2024 at 22:53, Danny Canter <danny_canter@apple.com> wrote:
>
> Thanks Peter!
>
> For the macOS 13 comment just so I=E2=80=99m clear, you=E2=80=99re saying=
 the minimum we support is
> 13 now so the conditional compilation for those isn=E2=80=99t required an=
ymore as well? I suppose
> that tracks given the wording that we support the last two macOS releases=
 at any given
> time, that kind of slipped my mind when thinking about what actually need=
s to be ifdef=E2=80=99d
> here. That certainly cleans things up a bit for some of the functions in =
this patch.

Yep, that's the idea. We tend to leave the conditionals in a bit beyond
literally just last two releases, so there's a period of "not supported but
it probably still works" for a release that's fallen off the end of our
support list. But in this case since we already have code in QEMU that
requires 13 to even compile, there's no need to add new 13-or-better ifdefs
in this new code.

-- PMM

