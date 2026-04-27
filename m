Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3BADFF8861
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2026 08:09:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHH1z-0001kD-4P; Mon, 27 Apr 2026 04:09:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wHH1W-00018Y-AJ
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 04:08:58 -0400
Received: from mail-yx1-xb130.google.com ([2607:f8b0:4864:20::b130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wHH1S-0001ju-2b
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 04:08:56 -0400
Received: by mail-yx1-xb130.google.com with SMTP id
 956f58d0204a3-65890a6ca20so757111d50.0
 for <qemu-devel@nongnu.org>; Mon, 27 Apr 2026 01:08:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777277333; cv=none;
 d=google.com; s=arc-20240605;
 b=e80O7Su0IeLO3buc4NYWp1bz9C0Wm9RUezDYKpZyAtgnG4c2+xELh0G0oT84ES4Bb/
 50qIQC6Igkgd5ESlpxvCH1O1Lg8uR83oRoxxDf7gD3BnWJOlxylLTncfekeOGG40u/il
 YoeEL7Q8A92hel3FIx6C/AWQ8z3a5eiaNW/sIIzPD7cUeJo6QzqwIjRzJIMaz0LGHTPs
 +LfCH0cz3G34X1AkxK9VNfSXIcs1C8qdq5dxb8uSA5hB/Rpr5vBA4dDeKrx1Mj9l/BHw
 MFivHCudbgsTxpDjaRBR8nGfCVwdqNu/r5AV94lgCicc1LGoWDHMa/dYz1ySCgCMhspf
 BgwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=1q2hYtKxXXpvGxSX0CTof6qHKewYGNFBV26RieKNCl0=;
 fh=BAMfBaJA6tjyRGl6BWWSRDVlTyu7OCKXW40FKUOTcNU=;
 b=lHyf+FXVxr2AUGACoM1p4DWgAojm0ZsV+vAHq3LCadmJlz/m/3f14Czk64oNbRnNE7
 o78yM8vKPI+t43Gt0K35RhyDpmoUOJ/B+t/otgivLI4PQYisuzh3f5L22Xe39FmUkH4E
 bDv+XnMvB3lCGNItHBKFjhZMblQ205B2zdE2E0FqlHymL3fAo4PZUzwh3Sk1swUcAUGe
 kTEvArn0gNkbp1TPk4yLP5J8c4XDulJS7GwG0FwwTHIrnSk2+6vZMNpmh6r1i6RmLWW9
 E+wWSq6q/FbJz+vAb6KdQIHewFhe8Jz4zw6z3cIEQaeO7WKT0K6QySsmC3pH22y+QnV1
 1TuQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777277333; x=1777882133; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1q2hYtKxXXpvGxSX0CTof6qHKewYGNFBV26RieKNCl0=;
 b=NYobF6SE3Fw+cgFNTR3iEq+z2lFp1yQsqd1zS5GaWO4ruP5vP4nG8y+VNK0FWzn3ly
 aqDXYe6FpZKXBHf7QJeeJmcG/e9hnwQuoZNJohPYSFgKEQESlUObHrwYzipFtlJdlUf3
 1w/EXU5EZAOyUwM7HutJq86Xcs+OnTpkocz86tFrynMGggWpyh5m7Ce3a4L8JqYp8Y9e
 Wydhf7VU47ORaLtN8drzO+GUzSDW/i0WlxcBLtXJmm20TUAT8oOvMWySOyNBW3FNUsn6
 xsLHBmfMRwrQvnBYjkSpDXyJmDMhBOT0SDESRzLKWWOPUmm4ih30mA1JBZzVkNi4+4PY
 G14g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777277333; x=1777882133;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=1q2hYtKxXXpvGxSX0CTof6qHKewYGNFBV26RieKNCl0=;
 b=YHwbbBs/6QYCb6ShPPHrg2Hhazu4wqjeNyiBEGdDa8W9JoF0LRDGas3txwZMkDo8a9
 pl2/CZAU7VAzfDFmQGxOt4T/WLsSCXQqlO6eG1vaEM4ABKwTn7zaEpFnZL8ub4TMIr2N
 Du3l4Wwy0hRg8XlVU2rvDFYCnvGeC7hkRPf47gIQ6EvKJ4f7nBzAIGPkvKKYuvm0BDJf
 kLpgSEXFVxy3tUdgsEnr4Uh/oKRIRTk4zYozVeMXXE8ahvFp94apIaoqIbJcMBSO0yVO
 spvmyoLg7YxetxCauESp+YOruggOmJKlBNgsz+UpC36D9yJ3dFQ7/aGhzG5i3Ej/DGFp
 qTKA==
X-Gm-Message-State: AOJu0Yydayuc7AqxYp6NDpWUH+W2zLd2pvvqzcIxgV9zBEgS7Qq79Hzb
 QDP4UmIo+cswVOHZuCrEjihqbRKd9kZtKN6Sk3B5oLbT6iWDJxAlCV3VvA1b5Iv/ighaH1zOVCX
 YRx29+qicoC7jQZPp7+7kOQnw42M6Jp/LdAsXlPlFDw==
X-Gm-Gg: AeBDieu2vS4YVngZS6tM9xMGzsFmL+c8utZAag/mw4F97bYbkG/XtgcXvwdUasqKW2e
 KZsyvZivyEE6uHMIzUnlM3ag4WaNNTHym3F8OndHmXYPD1s864qoba98tzD80kYOQwhg9rb4L2d
 cVc7LbuE36pQV9bSZcNcj7suJZ5mHioa8izS3egtVzLpYXHV30/28/2lI6S36u8WphnO0cm4vrz
 QmIJJic4RUy177c0+GaXYzveVTnVxhfrPkOsSf0DbfClrz6IdzuZ59qTXLRmirGFB5ysaoSWSMu
 3ZxBGA0QIX7OJNV7/SP3ujJq2Jl+rvZfB2jvlv7M/gJR101yTzyUj49mxTMVd61cz5/8Eby+6Pc
 q5g==
X-Received: by 2002:a05:690e:1913:b0:651:bacc:77c with SMTP id
 956f58d0204a3-6531086f908mr37511750d50.26.1777277332924; Mon, 27 Apr 2026
 01:08:52 -0700 (PDT)
MIME-Version: 1.0
References: <20260421093506.616307-1-alex.bennee@linaro.org>
In-Reply-To: <20260421093506.616307-1-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 27 Apr 2026 09:08:41 +0100
X-Gm-Features: AQROBzAMUK3UsDhAuY8DwEr0ywagnC9nDAdCshnyeU_NMGqgWHJ2jlOB5HpNoA4
Message-ID: <CAFEAcA9q3a0+2gzjRinq8i4GqOVeQRLVDvTTStHf0OhNPUAtTw@mail.gmail.com>
Subject: Re: [PATCH] docs/system: add FEAT_AA32 and FEAT_AA64 to emulation list
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>, 
 "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b130;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb130.google.com
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

On Tue, 21 Apr 2026 at 10:35, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
>
> This is just a documentation tweak as we already support both.
> FEAT_AA32 implies FEAT_AA32EL0. FEAT_AA64 implies FEAT_AA64EL[0123].
>
> This is however useful if you are using emulation.rst as a source of
> truth of what QEMU emulates and when cross checking with
> Features.json from Arm.
>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> ---
>  docs/system/arm/emulation.rst | 2 ++
>  1 file changed, 2 insertions(+)
>



Applied to target-arm.next, thanks.

-- PMM

