Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D7BCCA5FC4
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2026 16:34:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBxG5-0004hu-5h; Wed, 30 Sep 2026 12:34:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xBxG1-0004hE-6T
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 12:34:13 -0400
Received: from mail-wm2-x11.google.com ([2a00:1450:4864:31::11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xBxFz-0001nA-5D
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 12:34:12 -0400
Received: by mail-wm2-x11.google.com with SMTP id
 5b1f17b1804b1-49e7bcb94d3so42191385e9.2
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2026 09:34:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790786049; x=1791390849; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=Z8KYlUwzlo2jh5Tkb4yVfgsf5kC0cIuFtup7W6rwT00=;
 b=eVxwc2kJkk5mV6tWEUpFbUrOO0Ba+zTLgaYoz05er3nanwOX/XNRRobP/LDXrUIkkR
 mfaJuXU1EMrWBojH1MwfWewW9irzFq4KPpgCtbZmjeW4+NUV5Jfq4104mQtESEpY74n3
 O7H9Z4SIGii9yA58cF1TTIn6Cj0laCLclm5VCYvJIYfo5F9cv9Mw9qKMevlFd0hYmCXi
 CZDXd+fPw5p3r7Zol8YkRMnH4+ROir4e95J9O/rADcRlx3IePA2drEAaduvxccGCS0jG
 qpbrjJxa/Zvuf0MVb3D97+V6dBS14SymYMtgEr1AZGMvRquTOPKleoLJpLfE2PRsWbuz
 HsIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790786049; x=1791390849;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Z8KYlUwzlo2jh5Tkb4yVfgsf5kC0cIuFtup7W6rwT00=;
 b=f+gtlIwtqNtnNd1ijEHm2CJ2H9IbKV/4Eba2mE5DZiqetNmFZTjea2CpL34e3vIua4
 LNI2ICnnHMbVvQ0eIhfLPTNh737sHs1n/WfhQD+WE/xSvL6RUAG+krdF/NMuHE50oBy5
 N8NZxTryPlD8Z+16qb0BtSOCNhjSDMAROdYKPSaYF6GBl4V5yR4Z/ugQ6WVGFru6FID2
 JuUbij6G6fQpiN9gp0zFAXGfna3db7Sraju5l1iL4cYDB9Xyy9gVv2AmSWvgS3dT6ymB
 V/UCOPzKhA9fde6NZwpQm6hpxVfRBGdfG/0KMSfGBlTvuWZTEihlOBEbK5vdrBcLFHUG
 obIA==
X-Gm-Message-State: AFuF++nKkT0rjgJvMmp0hP+6vzpFWvHcEfhXNm48M8ULJkqPluPKdlug
 dScE5mGYxrcVEjFTGedfw1hZR5GFYFVuPxWggt8Q1x8+kbpXxukiEjLW7p2XegoWNAk=
X-Gm-Gg: AYBFou0S1G/1Z6NWL0d6KFlI8qmLAJIZMoQykecF6RMgD9Kw/uZyRwKmPdaEKLCQ8Ex
 0xoWOp4u/QvqgcjspkXmQHZGmfYKWfao6A3U1+pz6PsJfHO0JUBbtUBF2YweDk4qzHdDnX8f0qM
 vwoXHuG17A5KmeN5pNHunPHbkufqMIHsaaKf/DlzRgXJlljAU0atEGbqpS7OR8PQv98v372hVgB
 fineSkVpYz045wEVH53Uf5rgIxwL8+g7dghh/g8MHWhB8BZl8ViXKwtM+FN0rfEZ21VvSz6DhUm
 4NaMEL7KgwPl72l2/ya+dVQkJ4npsQj1saUQZNW7URqApwa8HYHh1FNLqL23LWvYomjYaurYxep
 O4+mtaCMCK1o9vbE+pd934pikdH+4Qg57J/56C6qqkaDFLvSNLsGR8AhR95CUmaSz4yZCZty81S
 5ky2iCWQWVssrAH4nf9Fq9rAHONVFA7NcO65ATS/sKdezcBh6yviQdq2a9T3bABQKITpTB/Q==
X-Received: by 2002:a05:600c:4f45:b0:4a0:194e:5bcf with SMTP id
 5b1f17b1804b1-4a01b1306bamr38179545e9.30.1790786049438; 
 Wed, 30 Sep 2026 09:34:09 -0700 (PDT)
Received: from draig.lan ([185.124.0.156]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a01eb79f6asm2538475e9.11.2026.09.30.09.34.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Sep 2026 09:34:07 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id AC6785F8D0;
 Wed, 30 Sep 2026 17:34:05 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Max Filippov <jcmvbkbc@gmail.com>
Cc: qemu-devel@nongnu.org,  Ilya Leoshkevich <iii@linux.ibm.com>
Subject: Re: [PATCH] tests/tcg: fix buffer overflow in
 multiarch/linux/linux-sigrtminmax
In-Reply-To: <20260708150541.2137546-1-jcmvbkbc@gmail.com> (Max Filippov's
 message of "Wed, 8 Jul 2026 08:05:41 -0700")
References: <20260708150541.2137546-1-jcmvbkbc@gmail.com>
User-Agent: mu4e 1.14.4-pre4; emacs 30.1
Date: Wed, 30 Sep 2026 17:34:05 +0100
Message-ID: <87a4oylmv6.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:31::11;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm2-x11.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

Max Filippov <jcmvbkbc@gmail.com> writes:

> Fix new_argv allocation size to be `(argc + 2) * sizeof(char *)` bytes,
> which matches the way it's used to store `argc + 2` pointers.
>
> This fixes the test for me, which otherwise fails on xtensa with the
> following message
>
>   linux-sigrtminmax.c: 59: main: Assertion `execve(new_argv[0], new_argv,=
 environ) =3D=3D 0' failed.'.
>
> Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>

Queued to testing/next, thanks.
<snip>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

