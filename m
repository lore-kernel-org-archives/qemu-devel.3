Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2989BC43458
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 13:45:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wh67A-0000cG-7h; Tue, 07 Jul 2026 09:45:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jcmvbkbc@gmail.com>)
 id 1wh672-0000bb-Jd
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 09:45:24 -0400
Received: from mail-qv1-xf2b.google.com ([2607:f8b0:4864:20::f2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jcmvbkbc@gmail.com>)
 id 1wh671-0006N8-6A
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 09:45:24 -0400
Received: by mail-qv1-xf2b.google.com with SMTP id
 6a1803df08f44-8fcc43c48f7so11138706d6.2
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2026 06:45:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783431921; cv=none;
 d=google.com; s=arc-20260327;
 b=QOtezMwmy4YsiGzy1b12lPSLlavZlaadJOtjXrpBIyiHNjGAtPwqGqEsYiO7h4R49V
 O/g+OIm5q7M+IGcakDTYgAl0bkTj8N73eGOkeejDb+qsu4EAhDBbJoBY97phUz91nfNd
 DnFKfvFgWSW+2c6zcFAIDALLf2B0rJ0ZROa2w8Ui+m2kcscjMRDEU0ATGOBwVKFeE+J2
 O2M8YOYBEUmq8GZOGLH0xHlWRUYjw0v75asT8o13oPlEUAF1ANb3fQy1RexwK85v1zug
 4wbCOc5HbcfOY82P97AJr3eP4SFNxzixLfd1+SAvkg4c2PHwl55T9GIr8AnrquMIyQmk
 fpTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=wm/60aNWAOHFJ7tkfk/4L5Ib+Ec8HzBqcWsXDy4oW8U=;
 fh=py8qWij750+NlEfFcK5ghwGWeGBs72nVcPl8SzkNb0c=;
 b=FFagBIw462K5oHOpfL709z8BWaanGo3PFEmmDgLpkVJGBM/vHMbkJh5Wz+zMaeCc9W
 59OB5TV8uJH5aqOUHZ2iHUjkFqNLDXriS9F4bBbw4/2jpT5VPgDi1hO0pmiMLrFsy1Nh
 nKZ7yQyjJX6dtOmAYPgL7/5UtzV9hFIHUbGt1bVFTBhjIcoJ45E7pBQle/Xz+HiK9mtU
 sMPWMEQj7Fi4OBhECND2RIWKWF49OGJy7q5oPVk3VpvMepXLn85/r3PHOQMeaH33LFzp
 Bx+oDI6RvayeNV/ltDwtP1Ot7215f8LkBubzmz3Pgj/P90y2lUkbuulWkGxvfWHn3HzI
 d1nA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783431921; x=1784036721; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wm/60aNWAOHFJ7tkfk/4L5Ib+Ec8HzBqcWsXDy4oW8U=;
 b=DwVTwhtDBzw5qsjWHZ2ivoAAwQzJkybFshFHVA42MlUmJ/s7XmLOelzp1TCB6enItN
 KSLQ6eThEQ4vffBijJxRUqe33EpkK1hCS68HlpnPEnOR3r+gKCARgfCdNvq9/gaRtF/0
 OT8C+AGGDzZyCIRzzes8H1xn5EC2Mu8GY2r7PZOUcmW8hJZmu1HQ/HY9IiNvAK/pG3HD
 SB9zTt1Tu7InYWgGzke5MF8l7p91b+q1XcP3nk62/u4DDGSD5bs8QV6QHMzsnqwcPgOR
 h+G8yJ63Lj6VqhLzcr/FWNrp1Rfk3q8eC+VR5BR+w4duNH1Ye7nKldm4NzqJ5qWmoP69
 4n7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783431921; x=1784036721;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=wm/60aNWAOHFJ7tkfk/4L5Ib+Ec8HzBqcWsXDy4oW8U=;
 b=c2wO7TmDVuSzwpcXnKrV8zcj5TCKZ4vWXCVCMOF0qTysR6/f9pfHTlT29DuUryFZ7Q
 fUiBUFyNP2PaHf+7eyqojASkH4xZWHImIPdEaTW/LeNJryn1VxZ5R73co8pSuYOeuFdR
 jgIVoOdPQ5IiB4C5DG3GlGq3yERI5dl1y8OqkWm3w+yxpQk52YT2Cz8d7lUSqqvpOmnR
 8rIdNxokts4m3UnsSTig+hO2HGrstP8VpotOdnZrNEdCGM2A1h2EA0xs3BcIhjTL1Yzy
 dO/FeoR2RHlJqHH2k7h94eaNb3vXRAEY7yUjZaCxlaZNFCjemJgZTCh7JGx38d87Z27C
 zKRA==
X-Gm-Message-State: AOJu0YyaBko/00kXJdJSAzVZiEEYChVieuACzjst2iRXO8WIRbEup5rx
 7UxFETASOTKVwdGuft2jJ9azAm5Fzg+BrwlAMFfgwc/1xlh7y3R/9VW0pn/IkWbWmzwprW8+s1l
 WU7tmV8t3b6m/qYRM6LZjyWocQgyLR0U=
X-Gm-Gg: AfdE7cmmVQ5e56qRbqZpuOnPukeEh6m+KyI2tNSrcr7RgExZigVRyBBk4oTwYmSvLUa
 GiIlMfMbbw+UehSTJEWt0CcME1Fo6OWYK0XaCwTJTXmjdUHY1fFvEYthCaGLuHgX9sO+2zX+PXZ
 OW8RvELNUo5OgassmTUPNy0uPF2rPcV5jGkymacmq+0IUYgl0wpBcNb7SWDA1yjgBj2KJNwD8lK
 y4XQLTQG6vV6LQv3GojvaLda8dmihFOkHZ/1IVOkJBr1Y8HEwnsxziwdadL8cx/PnPHRTTF/anC
 dFCvW0XE+7Ryl8buiIUc0i6aiWGTCH9vbdgckj2Q/2NKNrvnE+pXtR61lt9J
X-Received: by 2002:a05:6214:3007:b0:8e9:f5de:d636 with SMTP id
 6a1803df08f44-8fcb6781154mr58464656d6.55.1783431921032; Tue, 07 Jul 2026
 06:45:21 -0700 (PDT)
MIME-Version: 1.0
References: <20260706223343.988769-1-pierrick.bouvier@oss.qualcomm.com>
 <20260706223343.988769-88-pierrick.bouvier@oss.qualcomm.com>
In-Reply-To: <20260706223343.988769-88-pierrick.bouvier@oss.qualcomm.com>
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Tue, 7 Jul 2026 06:45:09 -0700
X-Gm-Features: AVVi8CdfutWPkjDCnKFfqXTEe963b_9Kum4awF9MzKDO6vH0TKBkouwfcmaWzAg
Message-ID: <CAMo8BfJg09ca6Kxw0WLLj0SQLBcOCwYmSN=e3u063oY-fgrdfw@mail.gmail.com>
Subject: Re: [PATCH v3 87/91] tests/tcg/xtensa/crt.S: align .text section
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>, 
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Peter Maydell <peter.maydell@linaro.org>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Gustavo Romero <gustavo.romero@linaro.org>, Laurent Vivier <laurent@vivier.eu>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Helge Deller <deller@gmx.de>, 
 Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::f2b;
 envelope-from=jcmvbkbc@gmail.com; helo=mail-qv1-xf2b.google.com
X-Spam_score_int: 4
X-Spam_score: 0.4
X-Spam_bar: /
X-Spam_report: (0.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 FROM_LOCAL_NOVOWEL=0.5, HK_RANDOM_ENVFROM=0.999, HK_RANDOM_FROM=0.999,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Mon, Jul 6, 2026 at 3:43=E2=80=AFPM Pierrick Bouvier
<pierrick.bouvier@oss.qualcomm.com> wrote:
>
> Needed, else we get this error:
> dangerous relocation: l32r: misaligned literal target: .text

This flag wasn't needed before because crt.S hasn't been built
with text-section-literals, why is it needed now?

> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> ---
>  tests/tcg/xtensa/crt.S | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/tests/tcg/xtensa/crt.S b/tests/tcg/xtensa/crt.S
> index 909872cd385..de8fd8c1cd7 100644
> --- a/tests/tcg/xtensa/crt.S
> +++ b/tests/tcg/xtensa/crt.S
> @@ -6,6 +6,7 @@
>      jx      a2
>
>  .text
> +.align 4
>  .global _start
>  _start:
>  #if XCHAL_HAVE_WINDOWED
> --
> 2.47.3
>
>


--=20
Thanks.
-- Max

