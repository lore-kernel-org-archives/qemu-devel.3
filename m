Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A893606A331
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Nov 2026 14:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=BKUTYYab
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWwbU-00031n-HW; Fri, 27 Nov 2026 09:07:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xWwbL-0002yZ-7Y
 for qemu-devel@nongnu.org; Fri, 27 Nov 2026 09:07:02 -0500
Received: from mail-yx1-xb12a.google.com ([2607:f8b0:4864:20::b12a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xWwbJ-0008Dk-NX
 for qemu-devel@nongnu.org; Fri, 27 Nov 2026 09:06:58 -0500
Received: by mail-yx1-xb12a.google.com with SMTP id
 956f58d0204a3-67db8985419so9999489d50.1
 for <qemu-devel@nongnu.org>; Fri, 27 Nov 2026 06:06:57 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795788416; cv=none;
 d=google.com; s=arc-20260327;
 b=VKGgR1qHE5UmMa9ZQ9YKpTwV5vLKUlZMaeZVt03MBKZz3bzxcDSI1PJDC6awb/SELR
 E+zUCYMZGLM9GhyGCP2hM7Rd43XW57PWXeO6Zn3Yuo9aC4iGfLJqdGPdMsHzXB2VrfbM
 mykmhrrSf+9Gd0IU0gKD04vzVl2EPDuLnbyunIP24PudKLfCiYf8XeWW/oolyNjpIve7
 rHyHRsOcjljeRRhD1C0tHi1pXpoZluT9q23Lt6rU6HwaM1q3FslDc7dARs89s3xnRlB9
 pvhVDVTDBMWipQXqckQa8uxfNfYDNPXcyvbHYOO5E0NJ147lObHgdtUIXaISly1TGFPP
 a1vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=mvfnzJrBYsAVo1xCLafRHj0de6P2u/OZUv0dLOXLbZI=;
 fh=vC/uU4M5uV4UbxLhfWAsSLjz/kqUTNTugKKi/gUgbKk=;
 b=qRnUM6hsEJYW3QBbbC5lOLZGxg02HkPXmyEyPQXSlS8BLf5UCtYiGjBg5lvlFMcaZZ
 zXMrJa/VCf7QEXwK4yPoOZdlBEwKsz2/0bu4Pp497FaGhk9dLDvnoKkjLHa1PmvKD9Vw
 owL1EDtE5xv0gnw26SK00JQ4cBMy++eQ9Qh7ebdUuV+bbuOX5m+4Jdele8bvLfUTeek1
 O9eYBD6kVkrBrXiyrPJByqiYZq2Y5o8m8GgMsWi4GfbdoVlXHbbz87ZcVFV5sjHyCg19
 PcUzi6BV9LxH6XgCvkhyO0FZsFlu999DWB1lmYp5O51XeyfT0d/VxktWJ0+seblLWgq0
 wkIg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1795788416; x=1796393216; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=mvfnzJrBYsAVo1xCLafRHj0de6P2u/OZUv0dLOXLbZI=;
 b=BKUTYYab4GZSBiHFv9qar4Yu4Cjh9x8uhc0GoNgRGYcZ5MyK7x9SGr+KQu3mJ9QqO0
 3i2n7olpIZ7t9bmqMsR1QICABjKpPVZzxJQr4HpN2nLQzI1WYB6Q8cnU1Ine7cwRHjCo
 n+3kpNfnNWE1PEsnf8rOvwDRUCWmThQB+qiCbx44bJo+oFgNtsvn8rO935zRbbuPqyTJ
 gc4nVfEUeDTMfbSo2mhFaa/QdF2EoLE3wzBDC8/nU78YlKnGd46CLU3AMKpWLITbPQAE
 js+n5yaGLqtFIIoAvu0tTWJ04BiJ9u9FPXFw5tUQeJlxl4tRCiRpcrmAM6bCdRK7gPG8
 KAJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795788416; x=1796393216;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=mvfnzJrBYsAVo1xCLafRHj0de6P2u/OZUv0dLOXLbZI=;
 b=m6jUT+zxNzkcF0XtfRUZWH1jp6HCNUqDj1sJcjOT0MlO4eM/VNwkx8d7/djHmJ5DB2
 t2SvYnSiEqCbLHD5bSlC67SPNnzyJGfaFX0EyU+yrMH+zGcBT3Vw+TCJiJ8QyiRprXnb
 pBI0IG2W4wfbXSvFK4cSrt04X6rJK3kFRJZaMGTCOWNgLSQzt/G+E15/BfdbjngaJ41b
 yyCTPmhT59bi187dLVjZcTsA4cOklRjzvpvebnsBLFOJXEln7E4FG2twATLQEvGYOnXS
 Vmwt0U7lbPaET25VyFaydBymMxDuJNoqTcVhB95HslqtJVCE1J0l34pqImF4zuNR2L9e
 fESw==
X-Gm-Message-State: APuU4Z809RylwZ8cZgUy9yBRx368Y61ehwg9IXnFRDqTWyQ1TozwXOoK
 E6dBfjSiD152G+MExiAUYSQV1Fa+qAfhlfRHAcA0fij4fzt9Ksi9PC92a0O0lkXJZDC8hH7PujK
 y5jIAuNBaOXWP4yjfEAiQpbZAQ+ZthTdCM+FH7cIdEw==
X-Gm-Gg: AZFdTZfM1A5GlN78DQDqwXPIFqbZKDA0zMA6BMcN2zmw/zccEyE/bODP5uyA8AZCcUU
 VEVVJu8Q2m1He/d0bey46e8t63uB1yXzIsfDylhphBFIxmgIJiqOiKq/aiKHSJXCt0HyNhxsdh7
 9+wGtF8/TJo8GmnabJszOrTsmO3NLrOiLTeIA6TRq1/Qu4uYrKbH3jbV0120uuWKAMozAH30qXB
 Q+dML/400JLXaB4HD3vk9/G1R6yIedA0bfUUsUq6dj0+lYkm1/qiNtwAcxHU1XI4PoakkoGGfM9
 D0QReUBWeHCIK8dL4u+QTqvFmKdA1z8VBmt+p2os1B35mrhNvInVlA9dSJHaQjspThzpTiEkNb+
 IUu79V1zKWD5v/YrcqcDIfvbZvx2AOG1QF6Byfq1RIE7QShFJY+IjMp8WUTOoh+BBwmj8e7e2uo
 ajtraYVoigkUz/yR1W4pxZ
X-Received: by 2002:a05:690e:1202:b0:67c:6e85:56b7 with SMTP id
 956f58d0204a3-67df447c38emr9980612d50.58.1795788416168; Fri, 27 Nov 2026
 06:06:56 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261124073406.87537-1-philmd@oss.qualcomm.com>
 <20261124073406.87537-3-philmd@oss.qualcomm.com>
In-Reply-To: <20261124073406.87537-3-philmd@oss.qualcomm.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 27 Nov 2026 14:06:44 +0000
X-Gm-Features: Aa3M54o25NVGED0YG36sowGMjU4N59Gerl7Yf55Ht-whfpUqxDCN4_7cSTkO_7A
Message-ID: <CAFEAcA8G-MfHjV0jGet-dGXAM+ayounR3A_GFvcTHcjpFeWuhw@mail.gmail.com>
Subject: Re: [PATCH-for-11.2 2/4] hw/sd/sdhci: Cancel queued DMA progression
 on DAT reset
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, 
 Bin Meng <bmeng.cn@gmail.com>, Karl Mehltretter <kmehltretter@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12a;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, 24 Nov 2026 at 07:35, Philippe Mathieu-Daud=C3=A9
<philmd@oss.qualcomm.com> wrote:
>
> A DAT reset left the transfer timer armed, so the queued DMA
> continuation restored DAT Line Active after the reset.
>
> Cancel the timer on DAT reset. Software Reset For DAT Line aborts
> DMA transfers (SD Host Controller v1.00, sections 1.5, 2.2.16).
>
> Fixes: d7dfca0807a0 ("hw/sdhci: introduce standard SD host controller")
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@oss.qualcomm.com>
> ---
>  hw/sd/sdhci.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
> index 1e70e1e7dd52..695de6448f89 100644
> --- a/hw/sd/sdhci.c
> +++ b/hw/sd/sdhci.c
> @@ -1246,6 +1246,7 @@ static inline void sdhci_reset_write(SDHCIState *s,=
 uint8_t value)
>          s->norintsts &=3D ~SDHC_NIS_CMDCMP;
>          break;
>      case SDHC_RESET_DATA:
> +        timer_del(s->transfer_timer);
>          s->data_count =3D 0;
>          s->prnsts &=3D ~(SDHC_SPACE_AVAILABLE | SDHC_DATA_AVAILABLE |
>                  SDHC_DOING_READ | SDHC_DOING_WRITE |
> --

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

