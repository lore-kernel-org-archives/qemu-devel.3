Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C05E8C52D6F
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2024 04:05:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sinRO-00045N-4L; Tue, 27 Aug 2024 00:04:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sinRM-0003xA-0l; Tue, 27 Aug 2024 00:04:20 -0400
Received: from mail-vk1-xa31.google.com ([2607:f8b0:4864:20::a31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sinRK-0006Og-DJ; Tue, 27 Aug 2024 00:04:19 -0400
Received: by mail-vk1-xa31.google.com with SMTP id
 71dfb90a1353d-4fd01b38dd7so1740031e0c.0; 
 Mon, 26 Aug 2024 21:04:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1724731457; x=1725336257; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/MGWADV6nVanmpFw4E0ILaABXa3MWCJsTgQcK3/vW+E=;
 b=c9kAYNmhYkRIzkk3cYoip36P8FRV7O6Chza3XwMY9M4SzenTgA+FV2XZe5BcKrCxK/
 6k/qnDG/ouEJMyPZPS8OXIKQeM4UsrmMA/50DRoYNmQ4CQh2jRM6G7xbOJToLrtf+JQ9
 XW+K75Ak3soVYksRpSjH4z3hR3s/Z7gDdVpZq7Kyay9XheiG774PDDehANl5DoOi44fX
 Mp1Jcg8NJz69RoyyO7rtQ8MDG9OCPiLmxkil+7w3UJS2hcvbTqzhPHVBdFkfvZvYgEBE
 ELGBj4y+yDUWWI7XgzmVyAOcVQ0n0JgQY4X6npoZ2GwbqUI+kWC+DTsD23vAJqUoNmX8
 pEBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724731457; x=1725336257;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/MGWADV6nVanmpFw4E0ILaABXa3MWCJsTgQcK3/vW+E=;
 b=xNOvDhfeuGLWKfeBfFJWw18BVUDUhg3yNJktnaqNZhE7qrnoQMSf1Rt8vULkgjhtAs
 QpDxxeSnikeiuaSGHmG/IjrHXb1mBbIi7hCliTuRp1ua3HDlD3WTdVRRB9atNIH0kO1x
 K5rRRIEVI4SImPIxUJxbSkxX234ObPcwWej1qM+YYvdkWfEPZN5msRFAizWzgrUr9GEn
 8agnbwlfY1/A4zKBGImFgTtlpZzH33MrtTl7VQRgb9pIeJzZPBAOJ755n3Yvu0VrGmkn
 u0iv9Fslte8t3+p2Vs09SK8EWJd/C9MXmuWt4W6wtKD3G+OkdnrMYGfyQH5SSbDEFhNi
 eZ3w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUpViGVhRQi+osUA9FBd0cjfGqwgP6UlaOQEoWsgdr4FYcOPVe9yTvWdYsRK1ocNY0K/wIgEqUOj5hsXQ==@nongnu.org,
 AJvYcCVwB52MgwqN5k3lDGSZglhAIv35/zQgRYheleAVBC3pI1r/Jnw/cisZeHGU+uuMKwvJ0MYdug4oPf9/@nongnu.org
X-Gm-Message-State: AOJu0YwZslmLkYKYhsDfOSN/jYIPy6GXBoTRb76Vn8nExgkx4aLz2PLZ
 BNsXHbq0Q4/DIt3SVSvN4F/sQLMWOzkbhu8FdLxUGfdRwBT91+t3YQF8hzMBYc/b5uHLO1qwiqB
 WyWA4HTu57JDlzPmcfA59rHfWxc4=
X-Google-Smtp-Source: AGHT+IFtcGWvXU7aoMTX9KvsXUaWN878VFZGA4u6Nko32KjNifwihlZKiTCDb7skAGKboQhFuwKbMUsBKloBbUFMjeM=
X-Received: by 2002:a05:6122:2191:b0:4ef:5e6b:98c0 with SMTP id
 71dfb90a1353d-4fd1a7dddf7mr14226339e0c.9.1724731456659; Mon, 26 Aug 2024
 21:04:16 -0700 (PDT)
MIME-Version: 1.0
References: <20240826152949.294506-1-debug@rivosinc.com>
 <20240826152949.294506-4-debug@rivosinc.com>
 <da021104-6836-4e5b-a8a4-991f975c553c@linaro.org>
 <Zs0jURx7jbgd64jV@debug.ba.rivosinc.com>
 <056740af-1b61-426a-940d-3ca118ebd081@linaro.org>
 <CAKmqyKOni_x8bw_3TfdV=xGg0MX-NPnPgo84dsKojdRqO_j36g@mail.gmail.com>
 <db8fa0c7-5c8b-45ca-a0e2-e660ffe7cd42@linaro.org>
In-Reply-To: <db8fa0c7-5c8b-45ca-a0e2-e660ffe7cd42@linaro.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 27 Aug 2024 14:03:50 +1000
Message-ID: <CAKmqyKNN28WeR=UsPjnhFZi+W9imeE6v3tHsX5bj_OwdP7XyiA@mail.gmail.com>
Subject: Re: [PATCH v9 03/17] target/riscv: save and restore elp state on priv
 transitions
To: Richard Henderson <richard.henderson@linaro.org>
Cc: Deepak Gupta <debug@rivosinc.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org, 
 palmer@dabbelt.com, Alistair.Francis@wdc.com, bmeng.cn@gmail.com, 
 liwei1518@gmail.com, dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com, 
 jim.shu@sifive.com, andy.chiu@sifive.com, kito.cheng@sifive.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a31;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa31.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, Aug 27, 2024 at 1:58=E2=80=AFPM Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 8/27/24 13:53, Alistair Francis wrote:
> > Exposing the *envcfg CSRs to userspace seems tricky as everything is
> > currently built with the S/M CSRs removed from user builds.
>
> It is as simple as moving them out of ifdefs, then initializing them as n=
eeded in reset
> for CONFIG_USER_ONLY.  That's what we do for Arm.

Is that really better though?

Then we have these CSRs that are included in the build, so people can
write code that checks the CSRs, but they are never actually changed.

I guess it simplified the CONFIG_USER_ONLY checks, which is handy and
your original point. But it seems like it is clunky that we have these
CSRs that are kind of fake

Alistair

>
>
> r~

