Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F641FC5926
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Feb 2026 10:45:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvYs5-00016s-0I; Thu, 26 Feb 2026 05:45:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vvYrq-00012g-Tm
 for qemu-devel@nongnu.org; Thu, 26 Feb 2026 05:45:15 -0500
Received: from mail-yx1-xb12f.google.com ([2607:f8b0:4864:20::b12f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vvYrn-00087p-TP
 for qemu-devel@nongnu.org; Thu, 26 Feb 2026 05:45:14 -0500
Received: by mail-yx1-xb12f.google.com with SMTP id
 956f58d0204a3-64c9a6d6b70so471565d50.3
 for <qemu-devel@nongnu.org>; Thu, 26 Feb 2026 02:45:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772102710; cv=none;
 d=google.com; s=arc-20240605;
 b=kOlq8adl3itpAxpPaZmA4GRchDDzXxL0eOWysGvlDpFYtk3H4XqshXcnY76gU32JCI
 0upzlp1cd+4IItTXx0Hj2dcXO6WIzrMmCqN4cOK37V1ORXZAkVk5mlwpTnHqJD07wFLN
 GfX/bUFC1kYAKjftK+qqXTRq7pEnGYLZjx3zQNehF1WvSUuCwyR/iHpWvkeVlv4zyObe
 yAOjmQIVCszug9/GUojcVELomzdNWHtlDf7ziTYr2x+uQb0oGzTCvQB881RQmspl9nWp
 DHaR3cKOJbC2GiBxZSWu/moYwA36fz4ZDP55ZVLMB2eoUrmh+/c515l+LrVP9duH5t+b
 0F8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=+p/eARGQ3/oySAleuaCzSd4JkUmllWgPWmWpg3bC6z4=;
 fh=y8MUwU+YzfbfqpRAhYXKpItqB7biLDOVGflHzlqnYtg=;
 b=SHO7OwTF7H/RRgIZYyjCJiGmJrUXmEkoZPLxW3jTTMQkSMz5VSI4NroRriA99D1C9c
 APl7m42Ielpazhz05j2/tmvpCBHtFCwoJ4uK3ymxIdhqP1yw9ZhQ9yLbu71qVMPpgOn+
 MOVl+0wR1lwa4ojXTpI45p3Lw1xxSL5kxtCCnqx8RSwUZbaSKwsAQmYPNTNZ5qc/CjLW
 I6g8Tfa1a4Q87Cs+P06ZNYeYcHRdJb32Wad9lH676RY378CHlrRaXRdeardgGR+fCVoN
 opFal9qelFhPJor9zh4cpLvOQEpqYKLKy8+YKIIR/QgTPbIk692KkYQFvXRE16lj6xdB
 Kxsg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772102710; x=1772707510; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=+p/eARGQ3/oySAleuaCzSd4JkUmllWgPWmWpg3bC6z4=;
 b=irzXo3IIbYXRirWdMgCIHXRnniXyVe4+2bCIZ4ka8MajkZeOdn3NxoSqMRsQRuFuqF
 K0IlOWI5Acnd6LcMlSPBR7dW0I9aASj1RndDfRwY3OG8FZQDE061/eOxrzsrBg/2ahar
 LPNH2dlDTr46l3eQrS6tMjXwOyAZYZ3XLZ5m+5fhrIRIlXK+vPvSyVlevN1kl5o90H8e
 baZ73OHak7AchmzAfR56ytqelo9tD8RjkrzP0hcUBlsDgUm4JOoj90pAmpFjFA0mte1y
 ytb1ROcWv8pQw6khf+SQsuMZ9Fg75neeRs7bJNx8m6liYpz40kjnn+QXnwyB8LxX95i6
 HpOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772102710; x=1772707510;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+p/eARGQ3/oySAleuaCzSd4JkUmllWgPWmWpg3bC6z4=;
 b=RG97LrW14La9mmGiK/Ef0LzPoAnLUze0Pa9YX/NELZmRINCmUo2bXn9+70mHZ2+ZQv
 7XfLJARsugnWYCdyvY8KZZodsOTmkjw2cQTtUUKi+Ir2KS8Yw5JbgChbeZwdQQ9aOUiB
 glMsgVfUpLHzeWrS27hEazCcl27T+OUn2Z6g4vbTMLF/4/voa1N7RgUH47D04VnQu9pZ
 /fHWEKqaqvMvykZJ2q2Lc4e72dAtzQRWcNgYaAOBF9I2Jr+W1xvokaQ7scpIsECUGPKb
 PcbtzskY+c2sgTUgWGJru7NthZYcF9p0qdu+7EhhnPS+QcC4OKF+fBsXJqtzH1PHN+fH
 //FA==
X-Gm-Message-State: AOJu0YyH+7CmWuwnJ2PNQDeYdifDTY3nHIfPs8SfUu9l1rc+S56JXKoP
 zhZkGOzKFdjx54YY2Hvs5DDMeCv77+fD4jGXrVRTzwnu9AEYmAy/LD2vv5Z+46abHt53XP3wXPP
 dHNOzEZHhDjvMbGKS5Vc1FOiVS3/+j6+b6uYJ7YgGww==
X-Gm-Gg: ATEYQzxptTFntZgaJP2BF7J04AsTCVZUqPo94tlb93wcgcBq6qe/JiGooWk5aizuWTr
 mBe/pHc9RrY2SzjxuDl3LpC/KH6kuqpDEGkNFL24PVJ7IBZy1l/cIqqReSDGm/YJXTIAHCIZu56
 nW/EVDK/6iREIFr87bVliGTbvaCSFpGWfXZeUihYP4M1AL4IVEHB1tXJABRgj4Ffpj2c9Dfjy8L
 blM5rDc6Af1T5rXQ9ABgCJtli9gH8vHjINch4ZcxFLiDns45jnM6jQmgqHESw2VWxkRRVngrkhJ
 OqpAXRaeNhFf2AyflZklkkCHY+aEgNNqd+G1lV+xlEA1HpjhlXGrLQn6nmw4tqTZ1LA=
X-Received: by 2002:a05:690e:2026:b0:64c:a4ab:e4e9 with SMTP id
 956f58d0204a3-64cb22c8acdmr2781180d50.11.1772102709721; Thu, 26 Feb 2026
 02:45:09 -0800 (PST)
MIME-Version: 1.0
References: <20260224181440.832943-1-jsnow@redhat.com>
In-Reply-To: <20260224181440.832943-1-jsnow@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 26 Feb 2026 10:44:58 +0000
X-Gm-Features: AaiRm50121XoJp_9bq6eZQ3-bFRt-CUVK0QG2HJEZrDm_FWUQafaA4JSH5MkfAk
Message-ID: <CAFEAcA-zsPN0Pbg9USt2dWCD9+iONr=bCGDaxomysn3ubqx=gA@mail.gmail.com>
Subject: block/nfs.c and libnfs vs Fedora 43 (was: Re: [PULL v2 00/19] Python
 patches)
To: John Snow <jsnow@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Thomas Huth <thuth@redhat.com>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Qemu-block <qemu-block@nongnu.org>,
 Peter Lieven <pl@dlhnet.de>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12f;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12f.google.com
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

On Tue, 24 Feb 2026 at 18:14, John Snow <jsnow@redhat.com> wrote:
>
> The following changes since commit afe653676dc6dfd49f0390239ff90b2f0052c2b8:
>
>   Merge tag 'audio-pull-request' of https://gitlab.com/marcandre.lureau/qemu into staging (2026-02-23 14:03:50 +0000)
>
> are available in the Git repository at:
>
>   https://gitlab.com/jsnow/qemu.git tags/python-pull-request
>
> for you to fetch changes up to 4e55bb4be53bc7a5e3fe1429af12d2e3090049a5:
>
>   python: add setuptools and wheel dependencies (2026-02-24 13:11:29 -0500)
>
> ----------------------------------------------------------------
>
> ----------------------------------------------------------------

Hi -- it looks like this pullreq may have broken the "coverity" job
that (run on a separate schedule from main CI) does a QEMU build to
upload to the coverity scan service:

https://gitlab.com/qemu-project/qemu/-/jobs/13264087007

It fails during QEMU configure:

Dependency libnfs found: NO. Found 16.2.0 but need: '<6.0.0' ;
matched: '>=1.9.3'
Run-time dependency libnfs found: NO
../meson.build:1150:11: ERROR: Dependency lookup for libnfs with
method 'pkgconfig' failed: Invalid version, need 'libnfs' ['<6.0.0']
found '16.2.0'.

I'm guessing this is because:
 * the coverity job runs on the amd64-fedora-container
 * we just upgraded our Fedora container to F43
 * coverity configures with --enable-libnfs
 * in meson.build we enforce libnfs < 6.0.0
 * F43 ships with a newer libnfs

The "not libnfs v6" restriction was added by thuth in
commit e2d98f257138 in 2024 because of a big API change in
libnfs v6. The theory was that this was a temporary hack
until somebody updated block/nfs.c to handle the new API.
Over a year later, nobody has touched block/nfs.c...

I guess for the moment we should fix the Coverity build
by dropping the --enable-libnfs (and accepting that we
don't scan block/nfs.c any more). For the longer term:

 * does anybody want to update block/nfs.c ?
 * or should we mark it as deprecated and plan to eventually
   drop it, given that the set of supported distros you can
   build it on is rapidly shrinking ?

thanks
-- PMM

