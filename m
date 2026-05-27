Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9EE3CD4F54
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2026 16:39:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSHH1-0004vv-0B; Wed, 27 May 2026 12:38:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wSHGs-0004vO-1s
 for qemu-devel@nongnu.org; Wed, 27 May 2026 12:38:19 -0400
Received: from mail-yx1-xb12b.google.com ([2607:f8b0:4864:20::b12b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wSHGq-0001bi-Fy
 for qemu-devel@nongnu.org; Wed, 27 May 2026 12:38:17 -0400
Received: by mail-yx1-xb12b.google.com with SMTP id
 956f58d0204a3-66039d3efcbso83232d50.2
 for <qemu-devel@nongnu.org>; Wed, 27 May 2026 09:38:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779899895; cv=none;
 d=google.com; s=arc-20240605;
 b=dksz1H69V8Mbq98iGhHTqeG0cBlEpeq2Iazngvo8gI7roPcSrhoQioJyTFScKd4qMl
 +GQoyfr+RG2P374y0dljhgyoROBELDWyTAPafkJtEYrcL+AWMsubqPwux/2XuONq/vEn
 CzWJNzLH4LEAnW5tg9krgxL1TqZ7RpyR5pY4uFt58ONPOMksEqnLXER4FRN/Ib2GQ1w3
 mxb1cWComAXEN09kkSOfXUaV38EotIiJL/PLq8ZZ1pWsAiR8AAjWwi/Gc5lUAZ+QsXDn
 aRXoEUhiHOqI1GToay62goCMrP3C/zt1A0k368epI2Wkviu9HlNrrtSsid5k288I71UH
 klIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=022TXSF4NsUzKi9zlp5RDNvktdo2lu0slIiUiOkxoH0=;
 fh=P2z0cHMgDv848FPmkj6ZJttTJqtryc4v+uF5M/GBQSg=;
 b=N+0hxvG4KzvdJgh0BcSHWHZCgEIzerUy8kuPS4Qow7z9wSod3UVvazIkU1tcY4h7DH
 +9yvVuaytpy1bKTeO9hBnEedrS5w0MyOs9qcNwxC9AoTc+IuCS0LYh0N+/TlNrPZudl7
 r2x2X3vZ6QXtHWqweJNCqiX5wwTL8wTLwrnBZYtLVlxnIUtpDOWfW7P4irt7rgfjgOR1
 sQl6HO2MTAFtoMq9qlxfPnH/C6W02Wrh+9NAM8O4xwKb9+YKioaWfKpklcjqRM/JtZAV
 fSa735nvaKl+EsshrUTdpsA+gawN2EDV+JiPicCvC8Ak0tuygFka5p7GtvfCgkKXypkN
 jkEA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779899895; x=1780504695; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=022TXSF4NsUzKi9zlp5RDNvktdo2lu0slIiUiOkxoH0=;
 b=xJQ7stKuLryawBv28pTIx04mNglE0nLaPEZW8HWAqn07WlmREYt0J8xSpSf5m1EPRr
 +fGtbM0zPi1jMw7hvbps/WXYrD6kkP14Pi+71u79mNhXNYZXvpCpFZDuALzkSoYMXs39
 pDaFidNd3Lrkl3eUxPqvtv+lYZTqnL2Rp7LJm3aydNzgFNhCgO9bqp5MPkoTyDTmJgGO
 jjbdRKp3v2zg+48NIsLEsWW6U+vLsQTS+lY8HRw1hzOIh4VVo0I9fECq/DvSIBQ+APOa
 k74LB7TSaSABa/kPlGdTwgIvmG5V3kVeWcULMksKXxhABet+DaHoMi37PEpTUUwBd07t
 He9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779899895; x=1780504695;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=022TXSF4NsUzKi9zlp5RDNvktdo2lu0slIiUiOkxoH0=;
 b=O4SpVJ9fW7WGg8PSClMapYFPMi7wvDoPehg53TeSleX04MO+IcNgSg4jx9jBHYkWxE
 rdPIbAZwPd9+fkFFO5Xoj69N/UTbMskLlj/AyuzeZgRsBasZ0GHW99VE1e3rUi+tgHfe
 YVb9LHKmQca2awQoLHmq4t2yXHMfk5bugSNoeU5Vg9kMWuuS/47eNUpserrx/7zdbLAM
 Zolb3BbWIZ9vHZkOaE1vjeQpp4wnEQgiYwynGXg/QdRykndGcWJCJpXHwHAzQr5QIuc5
 0clAyLQ6cO3drtxKHFOLF6T5sDRWUEy0v4YPNteti2OSW2EPn6cDuL7jtYG3r4lv/6QG
 m2Vw==
X-Forwarded-Encrypted: i=1;
 AFNElJ/w+BjM5C7e6AqAiGdL1HyTusXufzoT3QwT3SAdgcThQM1+LetyxF4P3R2Z95F3PHCRen+TsHAQbSbN@nongnu.org
X-Gm-Message-State: AOJu0YyyyJAjxxnWozAWEW3yGs5px+cIxZi7QTx0ozsX7VvMR7KMMLKA
 z4rjPNdKjyYR38BrituKocC8qJiD7+gjJK3HIL8Lsjcp75QGhvVvj4YReP25nhWPT7PqojpnmOm
 7r9qpIIygq7AY4x1bcEOkkIkdZNuhPcvGDjvwApZBjA==
X-Gm-Gg: Acq92OEO+aFfPrVl/prFGX5d+LMje28CW8FjScY5lxvJ1vwZXIGtCjLhtVXyXiXBNkI
 9I1Po9uVGalMwPtX8TQhrBMY57D0mNUdzI/Ne3ECVws2+Himh5y9MLXLDNuvQbQnDEJ1n4bcJqR
 0KGc67H3C3JtpE4Ca9jZp1jpOAsr0/3xFGkk1fB5zcBkQnG9ry42H0kOdk79xwHVQRjPNFqcQuV
 /QQQVAZvA4b78KBVJa8lHL3OuYLhQxQpUnLch04dd3I0J9mMfOPLeolZW6do1R+j4RJ//OVWwZb
 3SWVoCiuGlQXxNGdPt8370TUwkcJdAmsAwXpPB14LU7teWcIybdjsvjjfZR5+rdeAZ8=
X-Received: by 2002:a05:690e:c49:b0:660:3426:3ff1 with SMTP id
 956f58d0204a3-66034264363mr1167814d50.34.1779899895236; Wed, 27 May 2026
 09:38:15 -0700 (PDT)
MIME-Version: 1.0
References: <20260518-pr-pacbti-v1-0-8932a885b03d@foss.st.com>
 <20260518-pr-pacbti-v1-3-8932a885b03d@foss.st.com>
 <875x49x8gr.fsf@draig.linaro.org>
In-Reply-To: <875x49x8gr.fsf@draig.linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 27 May 2026 17:38:02 +0100
X-Gm-Features: AVHnY4JAGwT71ORGpbHHm2l4eBCFUen4qv6Y0myYDHJMY-BsDCM_0dMHEMmx5BQ
Message-ID: <CAFEAcA_-tnisyn=THfXK2vDd3LSk2g1qGZCyzi-K5oSxZoYzNg@mail.gmail.com>
Subject: Re: [PATCH 3/3] target/arm: implement v8.1-m PAC support
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: =?UTF-8?Q?Torbj=C3=B6rn_SVENSSON?= <torbjorn.svensson@foss.st.com>, 
 qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12b;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12b.google.com
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

On Wed, 27 May 2026 at 14:55, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
>
> Torbj=C3=B6rn SVENSSON <torbjorn.svensson@foss.st.com> writes:
>
> > The algorithm used for hashing is a simple XOR between the pointer
> > and the modifier using the "implementation defined" scheme.
> >
> > Signed-off-by: Torbj=C3=B6rn SVENSSON <torbjorn.svensson@foss.st.com>

> > @@ -90,6 +90,8 @@ FIELD(V7M_CONTROL, NPRIV, 0, 1)
> >  FIELD(V7M_CONTROL, SPSEL, 1, 1)
> >  FIELD(V7M_CONTROL, FPCA, 2, 1)
> >  FIELD(V7M_CONTROL, SFPA, 3, 1)
> > +FIELD(V7M_CONTROL, PAC_EN, 6, 1)
> > +FIELD(V7M_CONTROL, UPAC_EN, 7, 1)
>
> Hmm my copy of the v7m Arm ARM doesn't include these bits...

If you're looking at the v7M Arm ARM that's the wrong one.
You want the v8M Arm ARM; most recent rev is DDI0553 B.z.
https://developer.arm.com/documentation/ddi0553/latest/

-- PMM

