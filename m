Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 688A3CDE008
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2026 01:19:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcvDP-00077X-27; Thu, 25 Jun 2026 21:18:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wcvDM-00076T-Qw
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 21:18:40 -0400
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wcvDK-0005Eu-Qq
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 21:18:40 -0400
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-693c69b97e7so761564a12.2
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2026 18:18:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782436717; cv=none;
 d=google.com; s=arc-20260327;
 b=kGU4hI+AJNwamHNRzZQPirwUJSRE7YALR8gvWK+UjV0KUHuSGqwGyfd+NAMAbGIZ+K
 IrxR43icJ6AmKYmVHIlJBlpqjxcRzmXQmlcuc2GZEFVQNw4dIjm61toac7sO63P/WmOf
 VTATzdrhei8M0hOqEuxqBEmmnlPB/SooUo0ZWREHMupw13JbzqnOJLy7eWrw0RQdS4PV
 WaA6r/GkS0I2VW0DHE7GxF8v8lVLK47TQsSyAIDKmBTRypW8UkxbjV1dbxxdxjp49T1H
 M0vCYMbchzZWJrw/+DQzAYcwPR3T6etamsbNR6ldq0wrQCLYxhKvREc0vDGu7D69zD4G
 VZ6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=iVThim7V5qzId7sCg2WID4kqNl9aqLXIaxPlrT23pCg=;
 fh=9/4tzqKjgzJcjmYJcCvfm+LbcgW0ATp/rdwAYjKmbVo=;
 b=dEEMaame3Viui0PLuSGWc2bbt+N3fUky0JZOikq3r/nZnj7Tpd6hNq9qloLz0ZLnbT
 004zYKUqidwa82/cQ832ubgeDTvKOQDEwt+jUTVWmDwonhOgpv2g4JMw/MgOLZ/h+eSE
 HOXhBzxxXTaiTBqAh0BoRjRwgjAaDUnD+iLPf3hFtfztVbVmPUeSOoJxTKmrFMcWaSmt
 5tQYVPNX6JQxIJgdqSa7UpV/VwiDp/Zg1ZDI9LTIKRN7fk47Dcnmgv9yLPQHesPsgq7q
 1u4C0ZENH7rg7HMXaBb8cmx1Dkd3b6nYlhGqdAXLuBbS1N+AfkHy/UIXfhVKluPS0mwM
 Y5nA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782436717; x=1783041517; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iVThim7V5qzId7sCg2WID4kqNl9aqLXIaxPlrT23pCg=;
 b=dykUJy3Q7jYBtc+XzvSLi0C3uHg/Ce2zuo2dEaCz0TFuetbzc3PJAoV8AkoT4uON/v
 EUtEc3dSzGh0C/MgnP55DZmKQjNPKRqCtefilgkgQD/tVoXTI5mhBpa5i/irkmQ12TSs
 pL42vIQA3N0Jo7oZLz2le9eJRguVX4jxRbQBEtLUnjCm/UPqvOxn0hafk0jkQm6qVafj
 HwvPm3cj5iG/Ra6YrGEZ+hZlTGYbOwhFB4PcT9wE5wDp7c4Nr6de6TxJukHeN1h1kk4w
 g/dnL5zyNRVKgYmAZlPYSaL3n2DJ4nhcE0vwTHgSOPP5dgFybinyi7WDBIWMi/CKffZG
 rAoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782436717; x=1783041517;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=iVThim7V5qzId7sCg2WID4kqNl9aqLXIaxPlrT23pCg=;
 b=qYZLQgiVKTan5UmHqDuw7QSsRt/kL4A3cDW8v00QOuWbQkrnTWGT2aynZbhu4fY5Oa
 q40AXbRusERQ7Jri52alDszQ9FwK8X1RWJCD+uDTP21dDgJ4RppmMsjRzb2mUmUqCcvT
 I7/x92LV/TicFxu0Ny+KR8OudZcK7J6gvyBlcQ9ocUrfzLU7guV4mYI0DkW1atlG3yT9
 SK2Dd260gy+/g/AR5FdGq5zJ4etdfCCKvsCS7PfkSP9lk3M86DqnUFFrK6YvevOZwZzd
 f/JW7oLhrZHTWsOpo48cbkfF+qbka5HOEYjBXjuTrHeUTryxh0DjbmE3jWRYtbLDSgyi
 PNvg==
X-Gm-Message-State: AOJu0Yytuz+GaJr6AkC7u4Gs6CA5aOx4Ns6qPnL6wKHk9xs9zypLzyvg
 n/7SE9+4rVuZ5ItKIAxkIVdld8+ah/W/PiIWdVFq9JvKSXdZOo51yLIotOYXs0X1RvSNzGJcZMC
 BTiZwiPyuyN8/F/u0QYgxpn1HXQRubdC/Tv8ZlC15wQ==
X-Gm-Gg: AfdE7cnpeVrYI0mWBk/4gHj1p7uNHheTvUVgx1inbAy4wtmvrQ0LXAkjF5tWcYPDocP
 hoxzQfEm1Zrvk45j0doIeqXmsnX6IfVZOwxgEd5izVgdjifum36gns1FB4eynPpFyIO4fc79b1A
 nb07Gf+iD8IszEbz9WiTjGpsG7NtNhfPtfCVElHHQmvnqCTr5IyqjpQGqA6DrmV9JA50/94lHNv
 eM3W9UaTTaKIZf0AzXX2Y6YthAnuzAkDl445AJIMPv3G2l3i4RG3KVRWxUBkg/ZA+0uDCR0KlRB
 dwddXnnRhaju0GyJpu/pBZUX9JU=
X-Received: by 2002:a05:6402:321b:b0:695:37ba:fa00 with SMTP id
 4fb4d7f45d1cf-69810a181f1mr916456a12.4.1782436717138; Thu, 25 Jun 2026
 18:18:37 -0700 (PDT)
MIME-Version: 1.0
References: <20260624000632.2149359-1-daniel.barboza@oss.qualcomm.com>
 <20260624000632.2149359-19-daniel.barboza@oss.qualcomm.com>
In-Reply-To: <20260624000632.2149359-19-daniel.barboza@oss.qualcomm.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 26 Jun 2026 11:18:10 +1000
X-Gm-Features: AVVi8CfcJCjhH9GExaiXSLhXfQ_k7XQADxdGh1NibW6EWznfTG9Xv3c_oM5Qm_4
Message-ID: <CAKmqyKPFciQ_odLwOLVzSxs326RmMma+Ge8qZ=ZXp6zx2ZqkiA@mail.gmail.com>
Subject: Re: [PATCH v2 18/24] hw/riscv/riscv_hart.c isolate tcg only bits
To: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com, 
 pierrick.bouvier@oss.qualcomm.com, philmd@oss.qualcomm.com, 
 fritchleybohrer@gmail.com, Palmer Dabbelt <palmer@dabbelt.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=alistair23@gmail.com; helo=mail-ed1-x52d.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Wed, Jun 24, 2026 at 10:08=E2=80=AFAM Daniel Henrique Barboza
<daniel.barboza@oss.qualcomm.com> wrote:
>
> riscv_cpu_register_csr_qtest_callback(), vcsr_call() and
> csr_qtest_callback() are all TCG only and are not available in
> --disable-tcg builds.
>
> Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/riscv/riscv_hart.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/hw/riscv/riscv_hart.c b/hw/riscv/riscv_hart.c
> index d1c7188369..747754be61 100644
> --- a/hw/riscv/riscv_hart.c
> +++ b/hw/riscv/riscv_hart.c
> @@ -61,7 +61,7 @@ static void riscv_harts_cpu_reset(void *opaque)
>      cpu_reset(CPU(cpu));
>  }
>
> -#ifndef CONFIG_USER_ONLY
> +#if defined(CONFIG_TCG) && !defined(CONFIG_USER_ONLY)
>  static void csr_call(char *cmd, uint64_t cpu_num, int csrno, uint64_t *v=
al)
>  {
>      RISCVCPU *cpu =3D RISCV_CPU(cpu_by_arch_id(cpu_num));
> @@ -151,8 +151,10 @@ static void riscv_harts_realize(DeviceState *dev, Er=
ror **errp)
>
>      s->harts =3D g_new0(RISCVCPU, s->num_harts);
>
> -#ifndef CONFIG_USER_ONLY
> -    riscv_cpu_register_csr_qtest_callback();
> +#if defined(CONFIG_TCG) && !defined(CONFIG_USER_ONLY)
> +    if (qtest_enabled()) {
> +        riscv_cpu_register_csr_qtest_callback();
> +    }
>  #endif
>
>      for (n =3D 0; n < s->num_harts; n++) {
> --
> 2.43.0
>
>

