Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C38CC61DCD
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2026 08:55:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzsMC-0002UI-Gm; Fri, 28 Aug 2026 04:54:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wzsMA-0002Tg-0X
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 04:54:38 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wzsM4-0001l3-Uj
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 04:54:34 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-49b96837ca3so2568005e9.3
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 01:54:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787907271; x=1788512071; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=I9X/D7He2J2n30St04xcPDqYHSSehzEzNNOXohwO/sM=;
 b=iKfK9MSkXHtTSCxh+qgUPvBn5lo4KHhUOkWKPXxTMhEkNqdVmKllD438mQcLEVbymJ
 L4d1n1qWuMEjGmP4jTYC4R8yDJD3EGiQAoD27Vcm6vwD4xNeLrveQ2UCY5qDqfxhOveZ
 qdIR4Gar2Kcb8z4i7f1pZXyrKhs3Wy2phNCFFb94U3YADy4EqhzhKH3faBh2Z3sjC1oA
 wi4j6b4xS8OpB3tRfbhMyxltUyWp6k+9GyFvpO7DDpp6SyGzdwV3lrddYVSS2RnAWcdX
 bMjxk/3Z36TZAscb7dGBA5VX+OghgzQGS+7cM4NnqJ+CqwvBIE3x2h053d6BzZo4h8TJ
 W4Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787907271; x=1788512071;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=I9X/D7He2J2n30St04xcPDqYHSSehzEzNNOXohwO/sM=;
 b=UYrqfFuND5Qfj4sqNEg67lKiHDPcrNbiJAO/WYsIReYu+97Q9arBfggCFDZnMy/E4q
 yLvyjQZ+0xhqV7xl11WBY5OWJD8paXpgPSzZtLBSNm9bPMy0huu1qpYpTOkp33Qo4GuB
 kM/7MX2OEUWiYVdufTjxih5cGWXh6GYhWjv7NzyARgXBj6yM+oTKQ+ITHU72lCIc7uuu
 gJ0Xg820N1zvp0EDhcyVKEqiTqq+HBPtybABjwa0Hl7zcDdVvTr6gE641+uta3GySeTW
 fXSAFVIzZIsn/DkfzCj1lhhb1TL13rlNBkrLa1seb9rHzDx4XH+7eSohQCKNS3Jb3r7u
 ms8A==
X-Gm-Message-State: AFuF++nwMH5cw+0WQgrCHBocEwgjhy0CtzumI6aixiLpx8NTHWuEGtLj
 Tal58yEnocteUveZxwchG9y3iRa0lCIT5XY1xDHKnP5CrKc5xkh6LJXMq0Z0jRBr1XQ=
X-Gm-Gg: AR+sD13NPj8Tm6ZmNGyzo0qDdvL7s/1s6tB1ypzlWaR7aioiVrHvzNqL2yTDV1WU+PY
 GARycLbO6CEs2pLyFKyTnJtczk7QS/NZ1ga3hXGuoyUTuxnMSci050JDMaX641ULN12Z6xFl52g
 DLASZoBzc0whTBrNV0POAlbjC8uVHQqM6IZ1qvgfNaixjffodYROCvBa+oowbr/2K+5MYiaQiwf
 vjh6JMCTbYd7ZBRuaaVVL07I/hjPUmCwTpF9q3QGpAtTYgkl2H5Q88s/CrVb3EZ4ZA9P8Yo68Cy
 +WXwWtEpGmEQ9VVBt84USNUckK/1d9w4yBcAJjF5/073hjzF5ZIvW1fw5q5ry8XuxloI6jTkaqb
 eyi8KDqn5vu6dqqEOit7ohdhWGKFRzQtB0Ibls1iGK6Q0nX8bKZpmBR+7FIGsifO4CNJTRCud3i
 CpI4nG8USyEfUCr3aIcT/gr5LnXJfg3BA8WwEMoKNJe/BJvXiFC/nFtM98/g0S
X-Received: by 2002:a05:600c:8581:b0:499:a760:722f with SMTP id
 5b1f17b1804b1-49b91c47bf8mr63846845e9.13.1787907270898; 
 Fri, 28 Aug 2026 01:54:30 -0700 (PDT)
Received: from draig.lan ([185.124.0.156]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49b4c321184sm144768475e9.11.2026.08.28.01.54.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2026 01:54:29 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 644665F7E6;
 Fri, 28 Aug 2026 09:54:28 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org,  Stafford Horne <shorne@gmail.com>,  Paolo
 Bonzini <pbonzini@redhat.com>,  Ilya Leoshkevich <iii@linux.ibm.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,  Palmer
 Dabbelt
 <palmer@dabbelt.com>,  Richard Henderson <richard.henderson@linaro.org>,
 Bibo Mao <maobibo@loongson.cn>,  Helge Deller <deller@gmx.de>,  Max
 Filippov <jcmvbkbc@gmail.com>,  Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,  Brian Cain
 <brian.cain@oss.qualcomm.com>,  Song Gao <17746591750@163.com>,  Yoshinori
 Sato <yoshinori.sato@nifty.com>,  Laurent Vivier <laurent@vivier.eu>,
 Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v8 105/105] MAINTAINERS: add maintainer for tcg/tests
 meson infrastructure
In-Reply-To: <20260827221506.91574-106-pierrick.bouvier@oss.qualcomm.com>
 (Pierrick Bouvier's message of "Thu, 27 Aug 2026 22:15:06 +0000")
References: <20260827221506.91574-1-pierrick.bouvier@oss.qualcomm.com>
 <20260827221506.91574-106-pierrick.bouvier@oss.qualcomm.com>
User-Agent: mu4e 1.14.4-pre1; emacs 30.1
Date: Fri, 28 Aug 2026 09:54:28 +0100
Message-ID: <87ik4u4ocb.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x332.google.com
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

Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com> writes:

> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> ---
>  MAINTAINERS | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 6c18b8a4191..62ba29c9b77 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -472,6 +472,7 @@ F: tests/tcg/tricore/
>=20=20
>  Multiarch Linux User Tests
>  M: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> +M: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
>  S: Maintained
>  F: tests/tcg/multiarch/
>=20=20
> @@ -4646,8 +4647,9 @@ F: .gitlab-ci.d/windows.yml
>=20=20
>  Guest Test Compilation Support
>  M: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> +M: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
>  S: Maintained
> -F: tests/tcg/Makefile.target
> +F: tests/tcg/meson.build
>=20=20
>  GitLab custom runners (HW sponsored by Linaro, OSUOSL and IBM)
>  M: Alex Benn=C3=A9e <alex.bennee@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>


--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

