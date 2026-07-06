Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0927C43458
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 01:38:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgYI9-0008Ck-TI; Sun, 05 Jul 2026 21:38:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wgYI6-0008CV-NW
 for qemu-devel@nongnu.org; Sun, 05 Jul 2026 21:38:34 -0400
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wgYI5-0005Wi-4T
 for qemu-devel@nongnu.org; Sun, 05 Jul 2026 21:38:34 -0400
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-6986287534eso4110092a12.3
 for <qemu-devel@nongnu.org>; Sun, 05 Jul 2026 18:38:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783301911; cv=none;
 d=google.com; s=arc-20260327;
 b=WfwmEvFcXJVPgoea9geSUWxArNIoii2pk7ukUdVJzjANdQSke3NbPLEqb2Lv4RLWy6
 Fg/PEraFrWjJ3k/mFOZg5SJBWeqtmEbKtg+Vm+iXCJwj/gMJTjHV54rsEH+5SGETixxS
 w3oP8t3j8GZChC9Y7UyKfH77bcSdzFM6Qh0mzlxFFOP/Uywg10DzUAHuWj3R9z/kys7b
 xh2T9I8OVNQtoc2aTS3fqZP6mN8HrK264b6SNJXvzKZ2Lh4M9OwJwVHMXcKcsN7x4p8N
 xY/rnKNiL7xrK79h5qxbTp/RyG069wHDm4m28mmM5bcAGdGrHYs5+e7qjWa17y0kViVY
 RH6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=6nT9HSCFZ7Fvk4iHQKnEFRe7gqjvVGNDXfpSFYTcj3o=;
 fh=+NKKSU128UVQ+G4w1XTGroP+ZNvDEbGrwjm1jSfFZ3g=;
 b=SEGxexeljvM5hAb7Zpvu0U7CLzSSiKtED5fjlPfbmOni80a/ME0sEsfTEOi7BQX/cA
 mKhL5t+lpHdVgYMOLxTP/mhPnVwsBaK/Do1e2Nelsr56MXjpzQKXJm9i31ANg92HTBmp
 D1jn7YTr6Ok45+LhUdNlOy7H5nooHenZyLetsVXisolroL1EvaZbUsInnwU4PAbArc/L
 ZqOjhLjAUScoGbssf4MdMn8DTV/z+3B5zmbawprPe5AYAyCc/qgWIfWsHKEumIeyWSGp
 mmudsQXFF64utTU34JnCmQt7COYK0ED71GsxYvy/hcbWBQEndhxVdoyTyok+HIGc80Hf
 FtJw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783301911; x=1783906711; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6nT9HSCFZ7Fvk4iHQKnEFRe7gqjvVGNDXfpSFYTcj3o=;
 b=q+hiCxphmWGt6B1TeWRIklLYFyOe5Dx4Z/mG0zZ1gw5/fmDmD2Z3HUL+di0Wlfm24i
 v13DHMAUre2GzCOK3Pw/MIh+7WjoQwK2e+E1EHlXaTRPQx22YORMx0YKA6trJYS/Ihs5
 77x9OSz2Vmfx4hVVcQzaB8VU4dmOoRdRvn6xxMmz65QGNlNZC1lFBEicK63mXmaz07NP
 K296xgmnZTxd5yy9wAmgUk8e90b8FgbxIHgYGs1W98//fk/KszaUHG9dW7YN5+EeK7bG
 khK5n2D/s8Mo8/MIfnJLsM4lO0hzWBuKW7E7hffke91fxcgnw6ecqegtIbWYy+iDMHTh
 6zVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783301911; x=1783906711;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=6nT9HSCFZ7Fvk4iHQKnEFRe7gqjvVGNDXfpSFYTcj3o=;
 b=ejeJg1G2rYh+ThREvODsEipOQ7bqVfKzmMfuARRzYnC/go+cax6vovbUHxgcPdfZlw
 nZ3mN7QHRuVa2h89fVcVRmqQV+hJVTyBq3SKeMqEh2xhx9yUkweq4DUpEhp53OKvpiqz
 mpge7t51/4psTzSOu7eqDxN/aGRtKc8DEb4c4WLSDAaKuDH8NrSS08oATV0v3+teDLxp
 VoSh3uJHOeG3pwwyZiaP077IfRlgRLY7tlbp8Oc7JlSW3Ex65pGvoE4GVnp+67ac5XAY
 JHIEiPZi7QyrdajJJl/d/2Klyqy63wLGutSrIvnKWfU/3A8r4ZS62XQ4ySE4Q/VaxaYg
 yYkA==
X-Forwarded-Encrypted: i=1;
 AHgh+RrxRcHR7jNjm71fi64UJ5qYDEu70M+X7Hkwic/WNEh8k3E3unbeUkm1sc1UFtfyb4YU1ZLwVP+JJ5SU@nongnu.org
X-Gm-Message-State: AOJu0Yx0FjLjzj0xVVKHoUIYt9hbasl5A8R3jANJ31f55ATeZSlgw6dC
 zHDJjEUFGY6bCRm9l6ckSqGYJKxcYXHDXj9hlf1O69UQikF2ssH+rPHzr67cSZ42WNlzIBwyV39
 D9W0cxRbz9225NrdtOssHOGx0piE+194=
X-Gm-Gg: AfdE7cmHEtnJkTx9kemwJP/WwGOGi2xzNvqpPJyNFgykn9VulYCxpeecQg6DJ+1ea6F
 co9g4h+qA5n2PfC50+qa20AOVxoQvoPISHSO5umuSlBJWdSTQ8U3swI6Z+XsRkgV8qpbOVj2riU
 G3vxgH1bQ/Q6sFMWY4y+06YwgAWzz/HGm7kd74QeAiZPoK5rGxXQmxCHf7geVZoQeLoW8wU0Fap
 ve466uLkNXH3qXGde8eAq6sd5M3iUpjPsZ22UvGDCyVFJCo+SC51M9ZI+/cY8Q411iuzW7SMCPd
 WaLsI2QKXdck2UAUJtfnBHtEbr8=
X-Received: by 2002:a05:6402:2346:b0:698:aa8c:c15e with SMTP id
 4fb4d7f45d1cf-69a1a2ae06fmr2885928a12.25.1783301911475; Sun, 05 Jul 2026
 18:38:31 -0700 (PDT)
MIME-Version: 1.0
References: <20260705063147.199732-1-heinrich.schuchardt@canonical.com>
 <20260705063147.199732-2-heinrich.schuchardt@canonical.com>
In-Reply-To: <20260705063147.199732-2-heinrich.schuchardt@canonical.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 6 Jul 2026 11:38:04 +1000
X-Gm-Features: AVVi8Cf1alm5jvMiRLp25ra7zEY27Tbw-UV3x47liZCob19RvVJ-xO7cq3xub4k
Message-ID: <CAKmqyKMzA51avC5BwqfAeJW3mPTu6RV2FkngA8G2pQWNi4Pu8w@mail.gmail.com>
Subject: Re: [PATCH v5 1/3] tests: allow differences in SPCR
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Ani Sinha <anisinha@redhat.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
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

On Sun, Jul 5, 2026 at 4:31=E2=80=AFPM Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> For easier bisection add the SPCR table to bios-tables-test-allowed-diff.=
h.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>

Acked-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
> v5:
>         new patch
> ---
>  tests/qtest/bios-tables-test-allowed-diff.h | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bi=
os-tables-test-allowed-diff.h
> index dfb8523c8b..2c7086d9de 100644
> --- a/tests/qtest/bios-tables-test-allowed-diff.h
> +++ b/tests/qtest/bios-tables-test-allowed-diff.h
> @@ -1 +1,3 @@
>  /* List of comma-separated changed AML files to ignore */
> +"tests/data/acpi/loongarch64/virt/SPCR",
> +"tests/data/acpi/riscv64/virt/SPCR",
> --
> 2.53.0
>

