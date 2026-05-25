Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11BCCCD5BC9
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2026 21:55:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRdGq-0001Ol-71; Mon, 25 May 2026 17:55:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mattst88@gmail.com>)
 id 1wRdGk-0001OO-HI
 for qemu-devel@nongnu.org; Mon, 25 May 2026 17:55:32 -0400
Received: from mail-lf1-x132.google.com ([2a00:1450:4864:20::132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mattst88@gmail.com>)
 id 1wRdGg-0006rB-KU
 for qemu-devel@nongnu.org; Mon, 25 May 2026 17:55:29 -0400
Received: by mail-lf1-x132.google.com with SMTP id
 2adb3069b0e04-5a8fbe18b1dso15867574e87.2
 for <qemu-devel@nongnu.org>; Mon, 25 May 2026 14:55:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779746124; cv=none;
 d=google.com; s=arc-20240605;
 b=LhUsFm0o3jNQxGL0MnzbBjDho/zjSNFY/RngtmRgXaF2/aEz0FFKNVw7u5Q5ddeQIL
 UkMtZpIgXHgDZA9TI85IULHHg8f4egzw52U0Laio6xMDBuXt4IhtaXOtcF+OsJv/KaRj
 RGmwTipyj+6UA89xj4coglYgZjk8wl+ys7zIxfnVUAPGobhve7qNgv0khtJb6JaFR/rc
 thgf3AB4+mlJ+N7KCmv7SscJPLjjsc8ZzuYLd2kPGD5J7ZcRCg2DPRDlA29ZcXxpgY4E
 QB9L2+H1aEE+nk6R7zWb63MkmOhlwD4i4GxAOM49X26OeA9pHvhTCDc+VX45CkKvgYIM
 FgZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=PHtj1syAGZRimqFRPl1qSxFVsp0QeCW27LeXNBBHXD4=;
 fh=eKmQfR5UWln7ZxwKC+T9AfWL3XeHgjGcUjDKiGpRTGU=;
 b=a9Fmp6w1WnX2Qo3oEp1fMyNO9cf2uj2kgqsYkluQxJ+wGBOCzFnHWkjyHLog9i+IIC
 ib6nQ/uxyCfK24swl+w7IbMkGBRS4NIDFP9zotLCwngddOTKCBrYYprpV2j3KZEN5RfW
 uftjRp65OPJcYhmo4ZiXv3Qvu5U9usgPn6kIusp5YsGmYNu/GS/92kFW2DnBFKFTPojL
 heFtRuwiiwqECmhDXDxs2aLoMQq5YImAxVKY6VDN4L8YZ+mdfFVnpZ+Z192V1biQvqdj
 xiRgmzE5SQgbWCT5B3/Cr2N/ZCLdcymi/qrWz1p5csJNKqYkRdsM63UcCyHzvdP+doal
 l7VQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779746124; x=1780350924; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PHtj1syAGZRimqFRPl1qSxFVsp0QeCW27LeXNBBHXD4=;
 b=jR1AMYdh7xXTIJhQt+API7LMgHnYSM29FfMmfu1y/54ZTwybd7xO3+BDqZh4i6Sd9O
 2OjzO2Yzv5a/me/JXkQM7YdhN7FReEypxphUMRwdinzibVyUykoBsdsRkkuWWRO5+JaP
 xZ/+WDyN3zXZ6oBQUHHbYJM18T9eelRozCa4IcoCIBRw7/eJEA+JT1ncAKaiWEIh6118
 iEJ+tqRgn3ZXl6V4HrDXvnerMAGNV8DyBagnONi2aBhBCHy1B13RiFx3Yc+a9DiaP9iI
 +IYPC1fgDlCh35b8aCILTC1hdImFUv/Uz6cpLOMKyaSyz8j0H3MtiMz4eMhyDE6bhS/7
 C1SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779746124; x=1780350924;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=PHtj1syAGZRimqFRPl1qSxFVsp0QeCW27LeXNBBHXD4=;
 b=iZFYQs1KMcLnNfqemuD87ENCz3XXdy1wCHTbidu/FUyPKc3MPDQQuOjKLRVvRFqQ9q
 vfARD9aQX7vKd0xQiuFZeqXMrp7s8zpJdDy513BhsPxCc3Qw9nqtLlzM804kHmRW6Bq5
 9MxulfcCKz+E0ShQwr01bZyosyQT7BYaQ5bkiAnVhui5+Ivz+w1XOI/n+hH97CQ4srem
 AISSdWufpJnTkkI1AsMBcKHSICLwdUjkBMRtUCYwOEKTYwvFFx1rs8uhhKTycJa1IEgN
 APCtUvUNdSqtPgJl1YpkjjAsA+p1fWh0WuYVqDdtXkV0xgF4HHKJdHgnMZqidKbebP+H
 GqzQ==
X-Gm-Message-State: AOJu0YwCI2Xpas9c1oT4eKauj4wdaNrEpqtF942RiNe1JyykhlA1ktjM
 1/KTYiUJ/VNGQ+JWqb+h2PnfBhEIj5X9l2iOOs76dBw/+JcQnliiU1z5LFcjvZMKlVw22lI4d1u
 CcFJlbc15JnUE/1brJuWCne8JlUXV47IxoK96QfA=
X-Gm-Gg: Acq92OEPoizG11H4MHhyDV7KZ0tJfcFfxZVE2uB/946z9q7v2ED/OeYo7I++K1Tbu8K
 T3UgX3EOcwRWN01NoJeEoWUhqKXAh1vGu7QMPB9+ZHlNBvrSRp4JX5xoAbf++Dyg7tMOVmN4jC7
 ii5rLWMufoL3TVdrzQVD8Fok4U47Hi7zfzAj9EmB/LMQjJ0icHXZburnnLF/rtQNGJeP3PhUaLu
 yXY4oAnelNABVkUM4ibq7kn62kFEEmvMhP7adfPqIcoGJvTjIWsZAK11Fy9/2cWLHfo7ptUkdbb
 WDeMjfsEFA==
X-Received: by 2002:a05:6512:3047:b0:5aa:b6a:7a8b with SMTP id
 2adb3069b0e04-5aa32396e68mr5085033e87.42.1779746123935; Mon, 25 May 2026
 14:55:23 -0700 (PDT)
MIME-Version: 1.0
References: <20260525152739.4122267-1-mattst88@gmail.com>
In-Reply-To: <20260525152739.4122267-1-mattst88@gmail.com>
From: Matt Turner <mattst88@gmail.com>
Date: Mon, 25 May 2026 17:55:10 -0400
X-Gm-Features: AVHnY4LYjQAmMzgbyVBdeSsrXUfrC2Gn8n2_JOV3kY933OW9dRjSECvnt0YhVow
Message-ID: <CAEdQ38ESyxecURHYapChreNAjuC_kaQAM5fyrd67+TxeLxWfLA@mail.gmail.com>
Subject: Re: [PATCH] target/sh4: decode_gusa: recognize add#imm with prior mov
 Rm, Rn
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Yoshinori Sato <yoshinori.sato@nifty.com>,
 Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::132;
 envelope-from=mattst88@gmail.com; helo=mail-lf1-x132.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

On Mon, May 25, 2026 at 11:27=E2=80=AFAM Matt Turner <mattst88@gmail.com> w=
rote:
>
> The gUSA pattern matcher rejected `add #imm, Rn` whenever any prior
> `mov Rm, Rn` appeared (mv_src >=3D 0), forcing a fallback to
> cpu_exec_step_atomic for sequences like:
>
>   mov.l  @r2, r3      ; load
>   mov    r3, r7       ; save old value (mv_src =3D=3D ld_dst)
>   add    #1, r7       ; increment copy
>   mov.l  r7, @r2      ; store
>
> When mv_src =3D=3D ld_dst the move merely copies the loaded value to
> preserve it -- exactly the situation already accepted for the
> `add Rm, Rn` form. The immediate form can be handled identically with
> tcg_gen_atomic_fetch_add_i32 + tcg_gen_add_i32, so translate it inline
> instead of taking the slower single-step atomic fallback.
> ---

Signed-off-by: Matt Turner <mattst88@gmail.com>

