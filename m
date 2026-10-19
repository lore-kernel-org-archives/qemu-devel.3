Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82CA1CCF2DB
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2026 09:49:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIjzL-0004Se-Uy; Mon, 19 Oct 2026 05:49:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xIjzJ-0004R7-6a
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 05:49:01 -0400
Received: from mail-yw1-x112e.google.com ([2607:f8b0:4864:20::112e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xIjzH-00059L-Nz
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 05:49:00 -0400
Received: by mail-yw1-x112e.google.com with SMTP id
 00721157ae682-8b0ca1ebc8bso13669367b3.2
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 02:48:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792403338; cv=none;
 d=google.com; s=arc-20260327;
 b=B6bw25b0gFcvLd5tmW11cM6mX/w3ZwQiLx8LYiJmcDY7ZacTUhpea8F6LgokBV3xWZ
 OG78mOC+1cTuecWXYus/7/RI77TBQ81QJ2+4iUHuYuxZrRe6Wuk4nJM6uZV+GGwjKCQW
 hpIn6PIzfu4TSpGZMCFt3wFgeRpBng6KWy5TtT4ys0Ygrh0+oaam05Trn1KHMQKewsX0
 dyATb9/w9S9kwzcBvbM2Ah2yz8lhG/lpLa/L/X7mQ3bMmjbBw3nYx+kmyNo+N7CirKrx
 HKm0sNKjKr1pwjYm6ZKPNg+VEELXVzWRuy0goA3hu44E+fN+rv62IebJbhxArJ/Ieu14
 qhcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=VpazGT/H0cNlBGgBGm0mofOQrsYsp4CwtARvM4aII+Y=;
 fh=C0p+Ns9KoS0PDDaH5QGOYnJPnX6c0tcriKgAp76Azbg=;
 b=HfJZ9xRzEoOQET9z9jHbxXOEh96iDmAT2oSrHNmjnqVTVS6ZsRnqBv0R1A2TRTVuOk
 0D3DHThF7pS9HGBXMKdhxTnsxbuB0d4pwnh9cwFoM4nW6bE4uYk9vA80F0gjPrYNmbCG
 J760GEKhEj+M+0So9LJevHk8hfuVFahMwo3H0dcGC8N4E7h43liIlhy84l9DBuxdPbMr
 2YPX8Z1AAfRkSmIl9ZGmEMosJys199Xo5kGtb/xO5zQeEJ5je/a0E7uMQoHXqAxWBqw4
 OnvUF9+96FiPwyAVcb1Ifk2ab48IwJ6Bw0uW3yCzCu/zNhlBlrqWRBC+1SzJUpX9X5Nc
 SGpA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792403338; x=1793008138; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=VpazGT/H0cNlBGgBGm0mofOQrsYsp4CwtARvM4aII+Y=;
 b=jzka2MbN67RQe6Q3sw0f1EMQtds+8Ia+Gu8iBN4gcc/fi6nZsW/QANyutlkvRrFXzh
 35Dh3Qc1TEYJOqEMecwyNElMyg9bmNewlEWYAP7PN+mo3g7G7rV8pVmtGv1R/pT0DmAr
 /m9I749Ku4bI/xGZPtAeBneQN1aiwrZmB+PrjLaKSPwLXU4HuKvLgXuIkOBqeA+UGdgV
 2/gJ53FYRCF0DsnCOpfLqLGmjFqLKprYr0RROqu4AOaJ6dGw3oXN2brsq7EwHpmwRyrZ
 TWsEPoY7dPVZaL/goEBSzyvxEf/td3DshJYpbEU6Mm7Mh0BHKO+VAsAGk4K/8nNOrEaE
 f+Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792403338; x=1793008138;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=VpazGT/H0cNlBGgBGm0mofOQrsYsp4CwtARvM4aII+Y=;
 b=iPyc08GkN665o12GHr0gRBZ/dUgYwtaq9jmWRH8SJaPpqdHvrKXhX+R08l/joSkVmQ
 oL7c3wIW6AKzTC5pAyAzKXGGvoSrNLTFLY8ov2mOOOQqtFRi50dXNGboP9RgGTQiBi4N
 n+R7uv+ohaT4OAAHJ5nAsqXzecwEStAcG/iqbxPprb/Pb9rtDczv5HdbYc5iRvNvsb/d
 1A7FM5OqnwZFnkdWV1CzPJxGolLCNwJ6aY+B0fcJxMCoM9R/gzVHcTJ2OJ+kb0GewAPh
 dUG/OM15ZmmePwHLxjZpxxiC1naojEECDsYoXuBs9Y6HCvpr7/xM7yU5QIBDZndb0C0p
 riww==
X-Forwarded-Encrypted: i=1;
 AKwUvBxzJ6+3P0HTA/Mfiza842atX2HJXCo/mO5LnKEVaQS+1ydCAkj2heaan2XMOgGMiLi4AJt/FW5i0cgD@nongnu.org
X-Gm-Message-State: AFq9FYJgNMiTeSTuWcg2T6yzMixeiJaBgk1POBTnx7wTvUZb7lA36+RG
 OQnvvRWvIyLJKsX+ZIh3YJzwRJ+54AjU+6YydZGPPi22hYqZg5CX6ixTyx+AbU/WcgRPNUgjPfv
 uCObPJ533oLrz0kYyTtjBbhM06idH3bplgjS6rRMpEQ==
X-Gm-Gg: AYBFou2IsHCZhL0l+3oKosme2vBx4d7/RkyjmLX9HQoVa5HamPwRjHGU1VaPpQt3k1h
 4eOCt0yujvSK0aPmOLqqFC/VUsa0uGz0dc7US1Ib5JRBSOhx+eeuRxmMyo6k+Uak/UBn1iEUlgj
 l4bNSp1CUguseAuYyKvQkqeFLnNZggTZiiGL0lSFqJFsMP9ObowFtvpu1R0qwa9JZcauj3GsT59
 fRHWH7mlvaJPGfYPNraFgkBOFgCUPWAvP9fwcfKdL3YPXxgQYV6/lYifH8XU+09Ujo4wZ89a8bk
 LQ1+220Q/JLfRXgi4FtvMsafXOnEbfaAFCG3uUycsiPucytGX4WExM6w0/g+7yxeiKg0JNuZINu
 XkGL+rJq+KY8Jf4SphnhrGVEgi4pFf0Dz6Sv/y/U=
X-Received: by 2002:a05:690c:e3ef:b0:8b0:ad5b:d487 with SMTP id
 00721157ae682-8b0f2065a34mr28644737b3.2.1792403338459; Mon, 19 Oct 2026
 02:48:58 -0700 (PDT)
MIME-Version: 1.0
References: <20261018230741.6560-1-philmd@oss.qualcomm.com>
 <8360ad12-6dab-44e6-a930-17ed8e92a09b@oss.qualcomm.com>
In-Reply-To: <8360ad12-6dab-44e6-a930-17ed8e92a09b@oss.qualcomm.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 19 Oct 2026 10:48:47 +0100
X-Gm-Features: AclHuK-coNXjJOiyeIIN5PLDBbZToILIcDSjk6lnon2bFaxl5z1EVFGcfdu7qyY
Message-ID: <CAFEAcA8thrNkzvR_UVnfYUjaSNiaax6Xupw=DsBapHDyPbpdEg@mail.gmail.com>
Subject: Re: [PATCH] docs: Remove stale chapter on RISC-V 'Z' CPU properties
To: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>, 
 qemu-devel@nongnu.org, qemu-riscv@nongnu.org, devel@lists.libvirt.org, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::112e;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112e.google.com
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

On Mon, 19 Oct 2026 at 10:42, Daniel Henrique Barboza
<daniel.barboza@oss.qualcomm.com> wrote:
>
>
>
> On 10/18/2026 8:07 PM, Philippe Mathieu-Daud=C3=A9 wrote:
> > RISC-V 'Z' CPU properties were removed in commit 455c0fa9eef,
> > for the release v10.1.0. Remove the stale comment.
>
> I wasn't aware that we need to remove stuff from deprecated.rst after
> awhile.  Thanks for taking care of it!

We are supposed to move the section from deprecated.rst to
removed.rst (adjusting it as necessary) when the feature moves
from "deprecated" to "actually removed". We didn't do that in
455c0fa9eef, so we should do that here, rather than just deleting
the section.

> >   docs/about/deprecated.rst | 24 ------------------------
> >   1 file changed, 24 deletions(-)

Alistair, could you unqueue this, please, as it doesn't update
removed.rst ?

thanks
-- PMM

