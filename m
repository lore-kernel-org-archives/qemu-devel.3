Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB5DE103E2F5
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2026 00:28:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0TuA-0001pw-Ec; Wed, 11 Mar 2026 20:27:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1w0Ttz-0001on-2M
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 20:27:48 -0400
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1w0Ttu-0002a3-Tv
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 20:27:44 -0400
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-662b933f8d1so635338a12.2
 for <qemu-devel@nongnu.org>; Wed, 11 Mar 2026 17:27:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773275259; cv=none;
 d=google.com; s=arc-20240605;
 b=LN6aR6jCSD6M3FLDVID4IkuVgImrQMaR8VnOoQ2br8LvIUpWHykwbCnktVBTlvenkx
 i10cAuOE2T3jZq6YlO2imMTHVSsAAOl466zI8z9QpyOY+EJl2GRZG/NGsBSgGR6RI0Lm
 AA/ftkKN90lDBiK2VGdGmTgBH9VTBmhJOr3WEh2LoUkesIbYEQhlDr4vANl+ldHKAkBj
 i+dsvT8lWqiMzuMQX2F9raAR11YQXG1YB0YCmvMbPS/OtGIiZxTN3oyA7XoJPGEtDUzj
 zpd5QfRH7LeESkUMO9AkK9m7/VJm/yo4k8f5C7snMq1b2Ax9a5ijAV46QkS9AvOb8O9N
 OA0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Mts6mRd8aW3liO3IAoqUfIxshuqH2+FdHHx6sKOHvr4=;
 fh=02yfZO3MCi97EyXeoLg1BYIgpUdGEMk3Yh61+offrCA=;
 b=MaaoS5Z5p4L2MJ1yOlG9a+2YkYg/4/qSXKFixKcoBlVuvT5gG3Lij9Y6cHGCzrN9mn
 wlnt62TrMDr599dqI6Qvq7iArBcbNYfu8XJouYum/JQBXU8etOyZdELP3ftZQPHzb3gy
 xvMrroMNYFoOVOYfDP1gvQj7xYKHc1DlnIEIo4HPAtE2pSvEONwAki+eAxsLg5B1OtRU
 Wo8b6IgVlxJPObsXeEIPDSpvKnuAZOyaRPpxzL07LcnqsX4IWyOhZurSK9JRhOBFewEf
 9WBuswPY56ae69Y7W+sdm8hO211ZKqGWS8fMP+LXT28GZq+haGV9Du8cf5VZdDdHlbVe
 kSXA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773275259; x=1773880059; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Mts6mRd8aW3liO3IAoqUfIxshuqH2+FdHHx6sKOHvr4=;
 b=jUTCLm8RMSrtgvEwaVQmhI74WB7g7YoqzvPtVKVMP43qnyodeQxhL5lyun9+d55aaT
 VCVaLtCYjgp/Z/I5+gymHEwnhQHbRQmZJbfeY7jzvWHeK1diNgKtSs1QTs0KitmECnlp
 bn3hZsER1QQH65vwN6WXPVPWE1I+kJgWzI2TQHMYzd78J59dRdAZehD99zTMdKoDKs9X
 wJ2nWnTDVdEVvv6+shXfMM78S8iMR3t56urw0d97nIKOCETU92F0Z4tRIjqJoqx6cMTJ
 k12a6MYqs+qoigTasVK/78TTGnnMKPmCPUljoulbuRb5gJHrvDC+ymeFNlBCAin6NGEh
 HleA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773275259; x=1773880059;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Mts6mRd8aW3liO3IAoqUfIxshuqH2+FdHHx6sKOHvr4=;
 b=jFW+H5zwdvYsd7UgklRJzsc5qgm4flylixjlVgG7cq4hj9PTpfe6qGJMIT3rRe0WTh
 pmke1yveCf6CMibpFuCyWyaTyXs6oMUw+Xjxyh9djV+xfr5CaGCZs3SGaOCT+8qoZAhh
 Izkc5pU3pHSi283rIxm0PrMbbjci0DY22VxnhtY7pxgpFS2ZcYJC1hqgBLL6tRNVKMrm
 YuIMV5bdN746yn1OMQ2TsuqmXghIU7PqbXNZ3VPXx6YKv+cY9qan+THNzXgZhnHjv5Lk
 1XQ785aBYKdvPX/AoF+YYhZMFBGYtf7AN+i6TOQ7rQtyLHsRupZjr1kYrDi8rF20FdCI
 j7Vg==
X-Gm-Message-State: AOJu0YyrD7QKy6pfzhN8TrabV4PE11La5tM6gjkEDJP5FyEmlxmd4Qcf
 XNZ7bVIq3UC0VCJu6j3gzZbKSXtWdElPDzdrLJv9+dzf9cVNXJFveB+yASHOirHpI+EYCRZpw/G
 YgCt9FAM/v2MoX3tAGgqR6aquSrHsA+g=
X-Gm-Gg: ATEYQzxfqT+HmI9150BM7w728Sb5LJdO+ZRDVVJd9fjK2BthY/7Su9AWj/HyfsNb76Y
 w2Km/jNvTKGkIWw7O43p0xEy9DdOaO9N715um0H6/l6Lq4btzPG/oBidN3PeU3oHPcfq/d2jruR
 jW1o8x5Sk7hil2u37fFzAFgsftfedMroxgrPN55jmAXmlMNF9E8G6xsn3Ertu6UYp0t13bS21AF
 t92NKPWCZLYTqwuBFE4kwHgGlvPeZWAqGBG4pxwph4GwilxT3L/dc0TL9iAK6XODZG1kW/n0hqy
 KBC49ejIohQVNoEFRrzfkZ30kFLAKup3YAuwTg==
X-Received: by 2002:a05:6402:1469:b0:661:7ba8:a4a0 with SMTP id
 4fb4d7f45d1cf-66319ef1869mr2270712a12.27.1773275259257; Wed, 11 Mar 2026
 17:27:39 -0700 (PDT)
MIME-Version: 1.0
References: <20260311115910.564481-1-djordje.todorovic@htecgroup.com>
 <20260311115910.564481-2-djordje.todorovic@htecgroup.com>
In-Reply-To: <20260311115910.564481-2-djordje.todorovic@htecgroup.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 12 Mar 2026 10:27:13 +1000
X-Gm-Features: AaiRm50sFx6Qg5csi1QnEk8di5VRiFYnqWuYU_Hp2UxzCSxkMgA0dW4CxkUEXnk
Message-ID: <CAKmqyKPKLkR9W7uRtPEkjmanjnAZKxScj-f7C6=rLDvZ-4-5=A@mail.gmail.com>
Subject: Re: [PATCH v3 1/9] target/riscv: Define MSTATUS_SBE and MSTATUS_MBE
 bit masks
To: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, 
 "cfu@mips.com" <cfu@mips.com>, "mst@redhat.com" <mst@redhat.com>, 
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>, 
 "dbarboza@ventanamicro.com" <dbarboza@ventanamicro.com>,
 "philmd@linaro.org" <philmd@linaro.org>, 
 "thuth@redhat.com" <thuth@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=alistair23@gmail.com; helo=mail-ed1-x534.google.com
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

On Wed, Mar 11, 2026 at 9:59=E2=80=AFPM Djordje Todorovic
<Djordje.Todorovic@htecgroup.com> wrote:
>
> Add the RISC-V privileged ISA defined bit positions for the Supervisor
> Big-Endian (SBE, bit 36) and Machine Big-Endian (MBE, bit 37) fields
> in the mstatus register. These are used alongside the existing
> MSTATUS_UBE (bit 6) to control data endianness at each privilege level.
>
> The MSTATUS_UBE definition was already present, but SBE and MBE were
> missing.

You are missing a  Signed-off-by line.

Otherwise:

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/cpu_bits.h | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
> index b62dd82fe7..c2a3ee4bf3 100644
> --- a/target/riscv/cpu_bits.h
> +++ b/target/riscv/cpu_bits.h
> @@ -628,6 +628,8 @@
>  #define MSTATUS_TSR         0x00400000 /* since: priv-1.10 */
>  #define MSTATUS_SPELP       0x00800000 /* zicfilp */
>  #define MSTATUS_SDT         0x01000000
> +#define MSTATUS_SBE         0x1000000000ULL
> +#define MSTATUS_MBE         0x2000000000ULL
>  #define MSTATUS_MPELP       0x020000000000 /* zicfilp */
>  #define MSTATUS_GVA         0x4000000000ULL
>  #define MSTATUS_MPV         0x8000000000ULL
> --
> 2.34.1

