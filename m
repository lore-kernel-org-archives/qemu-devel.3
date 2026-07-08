Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13632C43458
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2026 15:41:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whUOZ-0003jB-R3; Wed, 08 Jul 2026 11:41:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1whUOP-0003fJ-0D
 for qemu-devel@nongnu.org; Wed, 08 Jul 2026 11:40:57 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1whUOG-00067P-Bl
 for qemu-devel@nongnu.org; Wed, 08 Jul 2026 11:40:53 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-47defd0c1c5so470051f8f.3
 for <qemu-devel@nongnu.org>; Wed, 08 Jul 2026 08:40:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783525245; x=1784130045; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=HMuzRhZr1rzcFhcmTQTs52hr5q9k+KM2/VooJwERO78=;
 b=lsK3fDbDLV156JlXI2zQ4rJEN1fU/QjX6BVwc0xEwTpNREZyl9yoHG9719Bvmtl1dE
 lm7byxGNncJNvx9awttCxxBArFEmFccEKJ08ggyeDJqYMlYONOHNy5Sm2pgxW/LccInP
 qLbx4GAdEzRaHPXxKAcWSyve5HlduhZG5/RT4YTeWcfGeJ2pxvp4/aWcylcyFge63mee
 IyqmpCfJXmJztR7JA/zgBxrBUeNq4ON51ep23AesyG9QNM880DXR8Ksrn59obcmRcupL
 cYUia6D7w/LaJrrjirlSFUpIz4SJfD7N++W+lmpYz3Nma0qukEvVXiNjLFBNjh4ZDXe9
 Qw7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783525245; x=1784130045;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=HMuzRhZr1rzcFhcmTQTs52hr5q9k+KM2/VooJwERO78=;
 b=EPhR3+5Bx+Jh8kQX5cQzZeqjR5mNOxX6wXDsXG/83HJX7hd6FjpBac8l/jcr7F2VDD
 g6ACgEMHPSVhMVKFOJ3RykfdEjChGF6AfDH0IPUrRBG2BLAlHzcmzzmeuP/88t7hWrPG
 aoIJRxiy9UzTi65aHbEZPzoIOnCbYmQ2cLohLOAT6R2tvsqEfducAmdv/5cheJUvOnjQ
 cG41fiREHe/ig7MENs8W6eLUa0fGk2G9oN/A6YgFNe5K6XZUlZni3yrSn7917YLbiqmh
 rHH39eewfnCxVxUFgCl5QDpf7p+VPZqAEQuZu4hwTckaw4DEMI9rTBym7IDV+BDa6xej
 9zcA==
X-Gm-Message-State: AOJu0YyudtU/OI+WOox9fZkiCqnVrG0fxAy2hDVjg1VYKUouZZEt3OWc
 m4WbqYNEl4nBipWAgvpcdD0fWZ/vqYooO5ERZtJRZ8LQqC6z4CwXQNABCl7p7tDpWPnB8pcBxFO
 Wv1u5kdE=
X-Gm-Gg: AfdE7cnQrElyVX5ByhYEFTnuECaoNEOx8UWqc2c7D7+QU7AiKTuWskhXHlMQnZ4xV6l
 qn31Tne8dtzYemWccy8NLDiCLkvGBwb9ueYhSt54ATq+rAIKYA9/WYnxRgPd4T/l1iy8Cna+rGD
 ZpCW2gJUNuUMScdRo29JNxE4LOl3lpoTx9wZCu3LZQzillFVgBpWt1g0koS4nfB4w1o267kI+qE
 JPh0AWe+HiW29i/1FbldIxS3tr+TicpQV7q/8yzKKnwBTvtJ0ZYxz4AsTpgao6SRsGxybsNrBCo
 bukqkuY2AbngDdl9h1oGVLt2Fn4ZgNcBluV3BYJIYo0QJoMC/+V5jg881VV0oy8btFEhPOLJ2aE
 uvdZ5ufRH/2/mzjyLRrGqey3y97YMNUI7pypXK0VCMv+S/QrbH+ojUhl3d1VCt9fS70DZzmX+QL
 Q4OO3Ha9Gts81C
X-Received: by 2002:a05:6000:1a8e:b0:45d:4a00:b927 with SMTP id
 ffacd0b85a97d-47df07ec6abmr3833499f8f.31.1783525245205; 
 Wed, 08 Jul 2026 08:40:45 -0700 (PDT)
Received: from draig.lan ([185.124.0.114]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47aa0f21543sm40911720f8f.35.2026.07.08.08.40.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Jul 2026 08:40:44 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 49B055F8F3;
 Wed, 08 Jul 2026 16:40:43 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Max Filippov <jcmvbkbc@gmail.com>
Cc: qemu-devel@nongnu.org,  Ilya Leoshkevich <iii@linux.ibm.com>
Subject: Re: [PATCH] tests/tcg: fix buffer overflow in
 multiarch/linux/linux-sigrtminmax
In-Reply-To: <20260708150541.2137546-1-jcmvbkbc@gmail.com> (Max Filippov's
 message of "Wed, 8 Jul 2026 08:05:41 -0700")
References: <20260708150541.2137546-1-jcmvbkbc@gmail.com>
User-Agent: mu4e 1.14.2; emacs 30.1
Date: Wed, 08 Jul 2026 16:40:43 +0100
Message-ID: <87cxwxtrpg.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x433.google.com
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

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  tests/tcg/multiarch/linux/linux-sigrtminmax.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tests/tcg/multiarch/linux/linux-sigrtminmax.c b/tests/tcg/mu=
ltiarch/linux/linux-sigrtminmax.c
> index a7059aacd9cb..b5ea65f3d393 100644
> --- a/tests/tcg/multiarch/linux/linux-sigrtminmax.c
> +++ b/tests/tcg/multiarch/linux/linux-sigrtminmax.c
> @@ -39,7 +39,7 @@ int main(int argc, char **argv)
>      assert(qemu);
>=20=20
>      if (!getenv("QEMU_RTSIG_MAP")) {
> -        char **new_argv =3D malloc((argc + 2) + sizeof(char *));
> +        char **new_argv =3D malloc((argc + 2) * sizeof(char *));
>          int tsig1, hsig1, count1, tsig2, hsig2, count2;
>          char rt_sigmap[64];

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

