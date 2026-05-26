Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 907D4CD5BC8
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2026 15:56:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRu7z-0005YE-Fm; Tue, 26 May 2026 11:55:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wRu7w-0005Xd-9Z
 for qemu-devel@nongnu.org; Tue, 26 May 2026 11:55:32 -0400
Received: from mail-yx1-xb132.google.com ([2607:f8b0:4864:20::b132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wRu7u-0006rI-1S
 for qemu-devel@nongnu.org; Tue, 26 May 2026 11:55:31 -0400
Received: by mail-yx1-xb132.google.com with SMTP id
 956f58d0204a3-654672a6d68so10259308d50.0
 for <qemu-devel@nongnu.org>; Tue, 26 May 2026 08:55:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779810929; cv=none;
 d=google.com; s=arc-20240605;
 b=cHRY2NITwsuG0+Cm9p+dtWhIKIHTVldoz/BLh/LJ0+MI6b1gPXQrAQ7AwyBTALt75S
 /E2kOoo0qwI5IQ66qaTF1qUfRDaSs37hCP0XxAm/wRR3iU82pXP/I6BU6whaZEPyxggA
 KXiMmI2pT9nrve/xG4JZGin6HOByyS3jMT/+KF5Sv9P+21NrSqrFbC44AlN2Id/o3b9D
 dkAfzE+soL08ykXf+XD6C6OitWlnZzZ4zdcPzig2LW0+yJ4YtVJGzqY8+QGOrHklrZA/
 a7Ntyxvx2n0maXK7EaPkNEwezjlDaQqRw5H6wSBkAcyQouVyJr3sCP/myFTKW5cS2QNW
 TMlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=+b9Kf/CszHgxNBcDmuakcMyonHIw3rytgxgZQ5SEFlc=;
 fh=ZunbYo7vBCjqSWc9622LTLPHQcfFJMelhG0lIzAt0Bo=;
 b=fd7/bJYc7S8fCh+BayhS9n34COK7nq/WYKbnpR8U/d0SHU2xWQszPswbfPsLK/yaK3
 8OZc4JyXgizmaeD8H/h/0+yEJxqoF3jLIIS81iG2EVWshojH7TkSwrKghBpS3eFMMdHS
 dDSFzoR56W+foV8QzcY2MM3847poG7xA16Rp8loI+Ey9X7hWNEZgahbg0qdMddgRTadh
 YpUjFsCKC47Jpms1ukeo6Ym/8u2gJKeRwkESIzMD4OWbOjBLIddJaM/HEYuhpc8+yVbS
 bH+ntwfjys1s3WKZmEWAwEuNsyYKuAqhDHCYRWBba6JRr85/U19GvNTBjw9feiEr6sjF
 9YDA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779810929; x=1780415729; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+b9Kf/CszHgxNBcDmuakcMyonHIw3rytgxgZQ5SEFlc=;
 b=jCKvTXqIigHF6FNf/Sk3eaWm5ZC/p9Lb6SvLiSn6+5DVnYPxOxh6eGvbNylXUehiv4
 1pa923+T0kGYVQ79VJgcUd1RY8TxnXbda0wmhrfXBuHW2iCywwWDk4VzHKQkkUJr/oFX
 +y+mjd+BkdlsxLNoLcyinRQcSedNIDQLxpyLbtFm1hepttGuVooAkH3RrwlQyUSdEcAI
 yn7R9dvSTUAnf4724R/rPZWtot95acLp7HkJ44Hk/+80Rf3PfRCoIX3gBkCflfJqKy1o
 MRS9kbjIKcZfscAxTOu+y0u709WFgeDlCk/HKVlnaGOAI44BdsUnJ/+OR/8xDBabM2xd
 i6Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779810929; x=1780415729;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+b9Kf/CszHgxNBcDmuakcMyonHIw3rytgxgZQ5SEFlc=;
 b=sOMnoViB7lDFhGofNkO1IHjLt+vGvp82AJ+0d+l2czuo1/+3qlpXdzI1a/dlLIKsbf
 hR/6/hghubv0DEoA6sz5Mm/DdSwfyaxyymwhNaWaP3W5z+6Tg5cwsvIf+tC5WEitJoA5
 fwcVikaOl+fBNWunMkRHAZWAVVhdcNT89GQYQ5TH5MbO8uJnXjm49I4qMEeZbRHeoEnH
 mNUu9LyIuuKYG4xgN0H+TXzRhPVkwS2aSuTybLWE1osJY9AK8YRFqarwqwCRetDm4akJ
 r/slBJ5tjkt31CdYPPjzaaoVH/XIqOcWaX97GZDTIrM3AyOGKjYROsg5N5w8yOBHzQai
 rdpQ==
X-Gm-Message-State: AOJu0Yxm0skNVXIYpDDWd9OaZTcDwp17sjlGFVooyIAEZr5v+Cstkzxe
 OLwgwR1B8rpG7yQIkYjwcPH12M4WGVviaBvfOej2tT+yL5+yDWL7qBrXEQ41B2+dF0QDCOIt7Lz
 2ib2VaynWL72rEaHT6tvaIVi3jnwID5bTGMw4IIryQ2/8degZEQnt
X-Gm-Gg: Acq92OHsGYLbVm+475zkxLrqMcCr/PYyk72f8n2p43YM94u5CRwhiJ8i1tLurBiby80
 yB+WkCUU7Y18I7zQO65tARMob46pKwsASQ/cz3JM/GvjXs4p0APJMoNWgmXrAw56EZaZnc7zbMW
 HR3U/AP6LQX4BhmolYiQouqa17DX5mrHUPV9Y0fCqL+/faRt6r0JxwTKUl32NcLUuQoZ/4XeSiw
 ivh4x3/lH3rh1YxLbeoKAnBImzyE/b1rHCdUpcRmcWY2OeYkSHekmFT1jAN2mRNzKV+3Tf93jyC
 SsyfbzTU5vpD/HYflqHP9/8JdOzD7zEuHkFUQvnvKxTnEQXKQ82IOHmmqh/ZFktbQ/0=
X-Received: by 2002:a05:690e:4846:b0:65e:5aa3:9632 with SMTP id
 956f58d0204a3-65ec97a1f0cmr13931280d50.22.1779810928438; Tue, 26 May 2026
 08:55:28 -0700 (PDT)
MIME-Version: 1.0
References: <20260519144553.91483-1-philmd@linaro.org>
In-Reply-To: <20260519144553.91483-1-philmd@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 26 May 2026 16:55:16 +0100
X-Gm-Features: AVHnY4LUaxuF0q6-gl8u_W9ULJLLNlXpmPuppjCisLcKLjEhHuvzM2fg0g1YsA4
Message-ID: <CAFEAcA9_RB-VjLuy43p5kgkvXNJPa=WyADocKLxRxve1rFq-Ng@mail.gmail.com>
Subject: Re: [PATCH v8 00/18] single-binary: Make hw/arm/ common
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b132;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb132.google.com
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

On Tue, 19 May 2026 at 15:46, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.or=
g> wrote:
>
> Series fully reviewed.

Since it's all reviewed, if you want to take it via
a single-binary pullreq you can have my
Acked-by: Peter Maydell <peter.maydell@linaro.org>

Otherwise I can take it in my next arm pullreq, but
that might be a while as I've just sent one.

-- PMM

