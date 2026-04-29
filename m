Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5641FF887E
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2026 23:10:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIE2c-0000XU-MX; Wed, 29 Apr 2026 19:10:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jcmvbkbc@gmail.com>)
 id 1wIE2b-0000Ww-IP
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 19:10:01 -0400
Received: from mail-qv1-xf2c.google.com ([2607:f8b0:4864:20::f2c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jcmvbkbc@gmail.com>)
 id 1wIE2a-00044O-2T
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 19:10:01 -0400
Received: by mail-qv1-xf2c.google.com with SMTP id
 6a1803df08f44-8a4b8c3a30bso3609996d6.3
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 16:09:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777504199; cv=none;
 d=google.com; s=arc-20240605;
 b=gU9kIoMsZgOzk5t3g7aA5cR/ELpNFC9Xy+vQafFv5nn17j/AGtFU39UUOX6/CkeIta
 QhF8zQGc8A2YebsUdBWxiYUSf54zCY8xx6VtzoSc22Jumf8tI2N215bVkZNwRDFX5MeA
 Tq/oNsUSv/Qk4bHhqZc/Ef0s3O+pEM5Co0dZqGobMvuS1g7iRR+Ghs6mo43q6wRHm4bO
 Om3uz3TIuoGhRlE7/MWKqbF7DotaGyG+WGJaeGovKbzuW1qFFAhmaU/WWyugGOafwbOO
 fE7sK4UimCCMAj5YmYTCZfWw4g5c+EBnh4TPrRqQIM61waftRlgNWkAEczz0QOFJ1qqh
 TOxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=b5KUf+EpjT6+E/xxW2Kz3sCAPqWD7PLZx/UtzwB/uME=;
 fh=mSInTDacno7JPRaoivKQV9Dkx3wW1y7+FWTiLZYswWE=;
 b=lcNgq5HplElwVAr/r7mDlF7USL5xzv3xGYlk2KWC0XL2MeT1XpK+kdeLGRG+nblceV
 dIy+PMHexKNyc6yMSdMp2pynZJWBa2Ll1sM+Z/jCpMQq2QQi6+WK44N2wq+jhkQv7r9n
 r3v0ndCK9Fq4QLPPuNFdqwIg9IJV8nvhG5tfunfqnXPxXYbqg7Cv3K9RfeLqPmzOllm7
 xbHFE4A64ZnAdqMMP0JFty9fg9FQ19JMv8p8CQdHCqkyZkY6L1FqUdMlrp90Fh5Uya1A
 M8lHDOdgjTIfYAJeXhtZL9kZH61GTWey6No8dyYgeBXeEC8omFinI9Yq5P+4uGVzdWnB
 ZtHQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777504199; x=1778108999; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=b5KUf+EpjT6+E/xxW2Kz3sCAPqWD7PLZx/UtzwB/uME=;
 b=B2g9YanPTuy7D/a6Ej/9iKDWGEoMCPh7OTXCRK5fK2KELpx5W+FtbEIhpdCXsenpL8
 VZUJjLeDf+klpVWPxYtb1RMSojQ70/8Fplc5Lm/77Q1LwPXxCUwO7Me6M1fTm7ifsdbz
 jwl94i+2MUslSGbAnctpUZHp4YywYfKgbfxi5CjNL4flF7gwEEdUG1n6wqeQyprTTFzp
 WzdabTlUPgvY37WvqX1zeoZNpMtkyts+htjYTP/4knRGCo8fU3tC3qJ8HJW1HXeAlb/H
 cdGxrKBU7hsQlSwhqpgaZ/flsfxPrpggvCnD2uYcER5WhfWlmhIDkrBgTKgy8Gw+z+Hb
 OYqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777504199; x=1778108999;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=b5KUf+EpjT6+E/xxW2Kz3sCAPqWD7PLZx/UtzwB/uME=;
 b=jDOy+9ema0kq4hBmxWVIkaWs/7Acq9oDGrpftWoVluIc7tFs7GXgwcTwzLqahRi0ll
 pbrAbUtO5uQVgX3CEqLIUiLrw69Dzf67v8Aql9/GqKgU/3uWt0lVXS9nG1tx9ct/dTRF
 DQrUl/4wy1k/cD05Ej5wSvjkLn+dQkSHYf/3oa148jBt9xmg9Gb9CHqcWGzV97jBeVun
 7YIXYkp66c6m+OlMEemhQvnv2Duh/eVG9yS1EzEwFW9a3X+czibFXDlnNEuq0cs/J+o6
 TsJmLz4mDm3IBvoTE8eDNlRB71RyOYZgQe6TDKwhcg69xgdfBVaPEN9xzAS4VJ7Y7kwT
 WGxA==
X-Gm-Message-State: AOJu0YwTVqhcxlrEmBlTV/QrG+8LSKIWQa986bHJIrnA49BEztMKs7rm
 vJBmVJK6+Kw4Oz26h+iLw66rmjMA6nvsKe+ZRzbUSA+cbrC8QYfyrE7ffpEnkWsBTuttVK89uJZ
 44PL07KZVSxYoDjB88MVLkIZsf9LpXLw=
X-Gm-Gg: AeBDieurZnLFbAQmNXL3ddpGvhU5tLhz50VoCjOSI039mXSkX/QWHq9W/K5jvySdD34
 IxBI2WqPihVIvTvO6SOjDXzcAgeqQlvkbncAvqao9s6ONKpmdOrUgRBljSqJCwRIGm9Csu4dVJY
 rk6cG8EAWASEgb2p06O1JTk4+mBNqRJJDyF1a77+p+mxEDxKlB440HWwTYkbmMbn9O2F7pl7BZ2
 9EHOPyUn5if78l6FzIN67JUyzqTZNN8wFlxHIE3RJj8AROsKpDd5nUjB8gv/Xwl48zbeoOPsba+
 r6pHrUvzP0UbE5vSeNzzfoCI+p3tPr8ZuxUS9DDQeckKK09UQB9xv1Sf2gSPBlYOVbD/c8iYco9
 ESCIBbRw1t1zKlTctVPe1sjqa5/tRucGBy5bM1IDA2mRDJMc=
X-Received: by 2002:a05:6214:e86:b0:8a6:d318:4909 with SMTP id
 6a1803df08f44-8b3fe6f6c65mr8696746d6.2.1777504198617; Wed, 29 Apr 2026
 16:09:58 -0700 (PDT)
MIME-Version: 1.0
References: <20260428093339.2087081-1-peter.maydell@linaro.org>
 <20260428093339.2087081-4-peter.maydell@linaro.org>
In-Reply-To: <20260428093339.2087081-4-peter.maydell@linaro.org>
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Wed, 29 Apr 2026 16:09:46 -0700
X-Gm-Features: AVHnY4LwYIAWO1_LQZP1m7SOE7egf7w5UsD7o1YPQ0BK0WG76yEPW_hDWx4pCAE
Message-ID: <CAMo8BfLkJiXW2XRVKisvVh0n7bMKRZbkxV=e_iqnOTcN_L68pA@mail.gmail.com>
Subject: Re: [PATCH 3/4] hw/xtensa/mx_pic: Specify xtensa_mx_pic_ops .impl
 settings
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Chao Liu <chao.liu.zevorn@gmail.com>, Tyrone Ting <kfting@nuvoton.com>, 
 Hao Wu <wuhaotsh@google.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Xu <peterx@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 qemu-riscv@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::f2c;
 envelope-from=jcmvbkbc@gmail.com; helo=mail-qv1-xf2c.google.com
X-Spam_score_int: 4
X-Spam_score: 0.4
X-Spam_bar: /
X-Spam_report: (0.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 FROM_LOCAL_NOVOWEL=0.5, HK_RANDOM_ENVFROM=0.999, HK_RANDOM_FROM=1,
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

On Tue, Apr 28, 2026 at 2:33=E2=80=AFAM Peter Maydell <peter.maydell@linaro=
.org> wrote:
>
> The xtensa mx-pic interrupt controller has a rather odd register
> setup, where some registers are 32 bits but are decoded at offsets
> only one apart from each other.  The QEMU implementation handles this
> correctly, but it did not set .impl.unaligned =3D true.  This has
> worked up til now because QEMU has entirely ignored .impl.unaligned,
> and just allowed through unaligned accesses when
> .valid.unaligned is set.
>
> To allow the possibility of properly implementing synthesis of
> unaligned accesses by the memory subsystem when they are valid but
> the device doesn't implement them, and for clarity of intention,
> state explicitly that this MR's read and write functions directly
> handle unaligned accesses, by setting .impl.unaligned =3D true.
>
> While we are adjusting the MemoryRegionOps, we set also the minimum
> and maximum allowed access sizes.  Since the only way to get at this
> device is via the CPU's RER and WER instructions, which always
> operate at 32-bit sizes (see the HELPER(rer) and HELPER(wer)
> functions in target/xtensa/op_helper.c), we know we will always get
> 32-bit accesses.  Specify explicitly that that is what is valid and
> implemented for the MR.
>
> Add a comment to clarify that the hardware behaviour here is not
> "true memory-mapped registers", so the odd-looking implementation is
> correct.
>
> Based-on-a-patch-by: CJ Chen <cjchen@igel.co.jp>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  hw/xtensa/mx_pic.c | 27 +++++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)

Reviewed-by: Max Filippov <jcmvbkbc@gmail.com>

--=20
Thanks.
-- Max

