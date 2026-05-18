Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51363CD4F3D
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2026 00:27:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wOlp0-0001ux-0x; Sun, 17 May 2026 20:27:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wOloo-0001uQ-S8
 for qemu-devel@nongnu.org; Sun, 17 May 2026 20:26:50 -0400
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wOlon-0001r5-84
 for qemu-devel@nongnu.org; Sun, 17 May 2026 20:26:50 -0400
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-67f7caa33easo3666326a12.1
 for <qemu-devel@nongnu.org>; Sun, 17 May 2026 17:26:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779064007; cv=none;
 d=google.com; s=arc-20240605;
 b=TQs01Au6z0TtFcjNoEXTeFwYUAw1dpsN16A7mFvvbQ3S+4apC5vsKcd6ytV6MNRDu9
 xT23vchCRV6nFUO1h6BbTc2HIXmFcCHTt2W8/ZHIvVto6/VQQUWNRan79MLAzOMnubeX
 JaJ8Ng/68opL6NcNJPUufo2YdRsgAAkgktOXqYiIZ5w5Asuwn1VgGcg5RZTYk78Ry2Va
 DU4eiZcctfnJOYRXTs5LniKDn5cIrcisIbBk7yqtVVKmPOOq3NeJxSdoNHCWkMFqb8Sa
 tuvFD7KqHWPzZAfnrcllCs52zUTpeaq6wjfKuX1UbHkGZ2JI4vEUfMHN9BY1Fg8canKC
 Db9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=+5j+laAcedxEqAB0nfpzCNdzb5EAsYiDBpKk5067Pnc=;
 fh=KVOpv/uRisOiSZJbG1GGi+j9Gv9BSlYaxzBW6Fhr6i0=;
 b=fTLqQT2Z+mLaPHjYz5FMLrYQf7ryNRqvhosQD9tgVkvyD/MiwGYeKTyJD+I7dAve05
 zhlL8+ub2D/7PSibJoUzsUIpxuTW7wtCDQdBGZYthcNRc2XDuQoPA/LtkgFHq8aGjkKH
 S6eb4vHeubVr6fnzget4xZ7DE4mCHqApxhOljuXr0FlWnHsiG2cS95KRJnPyh0PUMzVO
 +RUYQvrGOIO8EwyjpWVGq6XgH6AtEXNJMEdGzmNZdzSYStRVc6VLZFJdo6a6y6fqO4qK
 fu6aqEWMqa1GCox5FzlZBfI+7mp7GrI6yKFjasuBpKbRVQr2ZtWt1QLjSZ4A2hoW1P1L
 CbfQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779064007; x=1779668807; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+5j+laAcedxEqAB0nfpzCNdzb5EAsYiDBpKk5067Pnc=;
 b=hcXJ3IBKzRRQMsO5hl83fkl1DAUCLQogYtIijMjn275a53KNahQ23xg/LGGGiRHzhj
 /XSe87iTKOWOt+J0PH9bTK3hR0cj8qhtsODEH+nj/rU4Q3PAtRLuY1Jg3ioIYlQeMc+g
 5wBD1kBfJaUh+dxOG9joVxN2OmTx0oXLyJuyudIfI2O0LzesOEZMtdxOK2ExQVeddwKC
 naheyjhKT4KHm7Fipk3UtHryQY8/tqrOlYRZQMS7SHqZdanXlhydfzGAXXu+NYKcLmdt
 smfDhIjPyPlcU0sjgIk7TcD3ZnR+WSEujfxAXfr1rk/djEsFQkc4iTbtl7u0//Cl45kR
 y1hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779064007; x=1779668807;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+5j+laAcedxEqAB0nfpzCNdzb5EAsYiDBpKk5067Pnc=;
 b=Db0yqFPznlzT9s2YMhOfmrS+ytl4fQQo5qSfHhMv3SnM9Aq9rH/jaieofX5nNgXGr9
 bwiW6LxcPXZnhNszasq2n3K/tPihmXbOlGe6cRmW6srcHUnTHgAcQlfPIArWB6tc1mFh
 U9U51sIjfKWOKd4hXsUAUA68/gKzEn4wW0ke/nOefoHRvI6AKmUsLIlIhuQdPjuoLXEd
 7TQT6ISJ+iyea1NPO7Icxbd1nWdGifIKutklJUDsHb+82+Tu3jhKha+7mud25gFMYNM0
 BEIhZKe8Lb76vWmbWii/aASlJMF/fZ9542kEJb0DN3DpdpO4X+5iuKMxYiPi2oREGzmx
 Ww6Q==
X-Forwarded-Encrypted: i=1;
 AFNElJ/D+uE/Wav07V80eF4exacuWFvr/1HpMVOnzQY0nJ4uJbTqt3aJZ+D8L6MWJGrpAKBM6Xne3qlYhNoB@nongnu.org
X-Gm-Message-State: AOJu0YxZnoNO9ZKVYjS8s1q5mr86lbwIvUZAA4CL0R0Kun4QA52ba61l
 1tW4fuOKdynDYOCxwbboFCSOBXBMv2mvXQT6M1cPBTPTqvMrhJTs08YDQgJKioFZ4EQAoqxwnRg
 z8TS2kE/UNrpbx4XHR3Mg1CT1/UMrFhE=
X-Gm-Gg: Acq92OE6kp7z/WNVVnYjNtcVONRVPdyJCutXDkprNo9642QWlYzxnr9BhE0TJ5mLf3N
 n8RieGF39pI/0xUZtotzMRt93QsRW3/bBpx5ZBZ8kakJPHdQ7ByOWaEi/iTZoHrPTLzhJyoZPS3
 szNARRbYZRZlEubIXc7BDegvI1+kWuCrWAo9YzUbTQ5/YWxeF/4JH//1l4nDyhIWhsWwBbIe3Q5
 LxRg3lFZbHX8cNX+PmWKuHFPshapxs6B3xtBzc41RYZ9kNVCIT1SiLbbTZS1JVd67BuDLhlLDug
 +n053OQ9FlkoWLkQ+nMymzO7tov2HcRnYZmN1Q==
X-Received: by 2002:a17:907:c22:b0:bc3:c6a4:a819 with SMTP id
 a640c23a62f3a-bd51796e738mr601119166b.36.1779064007347; Sun, 17 May 2026
 17:26:47 -0700 (PDT)
MIME-Version: 1.0
References: <20260511040534.2862443-1-vulab@iscas.ac.cn>
In-Reply-To: <20260511040534.2862443-1-vulab@iscas.ac.cn>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 18 May 2026 10:26:21 +1000
X-Gm-Features: AVHnY4K-u9qI9XvwtSHeX4zR2MKb2jf1sMfjKHuMmJO450V3LGLQc3xeoiMnz8c
Message-ID: <CAKmqyKN+va6pJTKT-a6L2K2YL5u8nOr6ZAnrs7h0rgUnm3nEvg@mail.gmail.com>
Subject: Re: [PATCH] target/riscv: Remove unconditional MENVCFG_CDE from mask
To: Zishun Yi <vulab@iscas.ac.cn>
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Chao Liu <chao.liu.zevorn@gmail.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=alistair23@gmail.com; helo=mail-ed1-x533.google.com
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

On Mon, May 11, 2026 at 2:10=E2=80=AFPM Zishun Yi <vulab@iscas.ac.cn> wrote=
:
>
> Currently, the MENVCFG_CDE (Counter Delegation Enable) bit is
> unconditionally included in the base write mask for CSR_MENVCFG.
> This make the subsequent conditional check
> `(cfg->ext_smcdeleg ? MENVCFG_CDE : 0)` completely ineffective,
> as a bitwise OR cannot clear a bit that is already set.
>
> Fix this by removing MENVCFG_CDE from the initial base mask. The bit
> will now only be writable when explicitly granted by the `ext_smcdeleg`
> configuration.
>
> This issue was discovered and reported by SpecHunter, an AI-driven
> architecture specification analysis tool.
>
> Link: https://github.com/yizishun/rv-isa-sec/blob/master/output/riscv-isa=
-manual/pr-2601/qemu.txt
> Signed-off-by: Zishun Yi <vulab@iscas.ac.cn>

Thanks!

Applied to riscv-to-apply.next

Alistair

> ---
>  target/riscv/csr.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/target/riscv/csr.c b/target/riscv/csr.c
> index da366cf56271..f6bcf128a147 100644
> --- a/target/riscv/csr.c
> +++ b/target/riscv/csr.c
> @@ -3175,7 +3175,7 @@ static RISCVException write_menvcfg(CPURISCVState *=
env, int csrno,
>  {
>      const RISCVCPUConfig *cfg =3D riscv_cpu_cfg(env);
>      uint64_t mask =3D MENVCFG_FIOM | MENVCFG_CBIE | MENVCFG_CBCFE |
> -                    MENVCFG_CBZE | MENVCFG_CDE;
> +                    MENVCFG_CBZE;
>      bool stce_changed =3D false;
>
>      if (riscv_cpu_mxl(env) =3D=3D MXL_RV64) {
> --
> 2.51.2
>
>

