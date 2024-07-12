Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8898C2BD09
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2024 09:07:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sSCFA-0006RP-Jz; Fri, 12 Jul 2024 05:07:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jim.shu@sifive.com>)
 id 1sSCF8-0006LL-Tu
 for qemu-devel@nongnu.org; Fri, 12 Jul 2024 05:07:06 -0400
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jim.shu@sifive.com>)
 id 1sSCF4-0000Ia-4F
 for qemu-devel@nongnu.org; Fri, 12 Jul 2024 05:07:06 -0400
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-58b447c513aso2157915a12.2
 for <qemu-devel@nongnu.org>; Fri, 12 Jul 2024 02:07:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1720775220; x=1721380020; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=H6drIpNSAG4O2Lq+VdYMCtUtd/YL/OtX2wKOhTwAZlk=;
 b=V3gdUdK+Qz9B4tqPQnbJ0Dq/80JNhMFG4DRb5d6Ls14b+iU4PWxlq//IUzVVxAm+MH
 Li2XRZsz/T1WSFUC2ztQy056Nyh6wLd7pNCobkGQ01z4OJplPtYGSPLJ3jgH/AGz9kB4
 5z1846AQSgCIhgXqQyp8QxaJrbC2W6gDK4dDGX++srPOEpEgDgBnMEuEq590biqJH+IE
 R+NLRnV18H7oXXU3ZXMJRMVydAFE2csJzuMm6V7dnvUeVHksZwoPFBpFbKoiZd+I8X2m
 VzF0Cow9oCXco0x6E93+wGut6eEmHYUptBfv2pzeOgpA5ftag2OJS85RC/1r+I6FviKW
 6UaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720775220; x=1721380020;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=H6drIpNSAG4O2Lq+VdYMCtUtd/YL/OtX2wKOhTwAZlk=;
 b=uhth/55BIIVMmsQXx7hlZWUzMpqpjz9PbEIPWNHvt7dfuEKFowN0qwmT0Egfr1QRt4
 /douWIZIM0bYM/nd57pwLtoyWHIwmujMvmddcG3vmY+k/kufJkSgXaEpi/4FMpkXM4Ln
 bMVAkVS/3sDo2lVnSHtLdjpRuyOrA4vyYX5TcMysZis6csXvwue6QMXc8qsNZS5TWdGO
 mxDwgBqe9lWR87IghG6Ut8CO3qRUhA56L0Z1sN8yQkIrf/mAutiGc0ZKmQ7L4rq/5wUg
 ymejudq4xwFlN8iubgAPyYc1mQ02tkBWZI0UhpEGTT8tNoy84pQe2xRCVe9/v4hnMKN1
 JGJQ==
X-Gm-Message-State: AOJu0YySAdWZVszjtnnR0scDBbLQyktQsxUYHdBzNqFog+AUDMAtUxIa
 hTl6ELu5Sawgry81Ze1V+bBxKG6rIm5fyQh+aWKBI2vFVhYwPUPZfRZ2+ZJfzO9bhnIXkarCYUq
 MPRu8p70+Kx9SptY+ciM2T9LCcsOSq0WGU4KyLA==
X-Google-Smtp-Source: AGHT+IHrQuWfRa72YN4TTgMo0+6ry9rOsG+quSW1b+x4L+IPZCwTKtaD6dc6uzZgB1RWh5rjgbd4m17w7KU2kN6kBZA=
X-Received: by 2002:a05:6402:2071:b0:58b:565d:ac92 with SMTP id
 4fb4d7f45d1cf-594ba6953c2mr6359999a12.22.1720775220369; Fri, 12 Jul 2024
 02:07:00 -0700 (PDT)
MIME-Version: 1.0
References: <20240709113652.1239-1-zhiwei_liu@linux.alibaba.com>
 <20240709113652.1239-3-zhiwei_liu@linux.alibaba.com>
In-Reply-To: <20240709113652.1239-3-zhiwei_liu@linux.alibaba.com>
From: Jim Shu <jim.shu@sifive.com>
Date: Fri, 12 Jul 2024 17:06:49 +0800
Message-ID: <CALw707oVpuFBVeDDu65EcghuNS9nJGum4EtUvQe4oQNDEMSxGA@mail.gmail.com>
Subject: Re: [PATCH v4 02/11] disas/riscv: Support zimop disassemble
To: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, palmer@dabbelt.com, 
 alistair.francis@wdc.com, dbarboza@ventanamicro.com, liwei1518@gmail.com, 
 bmeng.cn@gmail.com, Deepak Gupta <debug@rivosinc.com>
Content-Type: multipart/alternative; boundary="000000000000bfb3a5061d0933ae"
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=jim.shu@sifive.com; helo=mail-ed1-x52e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

--000000000000bfb3a5061d0933ae
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 9, 2024 at 7:41=E2=80=AFPM LIU Zhiwei <zhiwei_liu@linux.alibaba=
.com>
wrote:

> Signed-off-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
> Acked-by: Alistair Francis <alistair.francis@wdc.com>
> Reviewed-by: Deepak Gupta <debug@rivosinc.com>
>

Reviewed-by: Jim Shu <jim.shu@sifive.com>

--000000000000bfb3a5061d0933ae
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">On Tue, Jul 9, 2024 at 7:41=E2=80=AFPM LI=
U Zhiwei &lt;<a href=3D"mailto:zhiwei_liu@linux.alibaba.com" target=3D"_bla=
nk">zhiwei_liu@linux.alibaba.com</a>&gt; wrote:<br></div><div class=3D"gmai=
l_quote"><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8e=
x;border-left:1px solid rgb(204,204,204);padding-left:1ex">Signed-off-by: L=
IU Zhiwei &lt;<a href=3D"mailto:zhiwei_liu@linux.alibaba.com" target=3D"_bl=
ank">zhiwei_liu@linux.alibaba.com</a>&gt;<br>
Acked-by: Alistair Francis &lt;<a href=3D"mailto:alistair.francis@wdc.com" =
target=3D"_blank">alistair.francis@wdc.com</a>&gt;<br>
Reviewed-by: Deepak Gupta &lt;<a href=3D"mailto:debug@rivosinc.com" target=
=3D"_blank">debug@rivosinc.com</a>&gt;<br></blockquote><div><br>Reviewed-by=
: Jim Shu &lt;<a href=3D"mailto:jim.shu@sifive.com" target=3D"_blank">jim.s=
hu@sifive.com</a>&gt;=C2=A0=C2=A0=C2=A0</div></div>
</div>

--000000000000bfb3a5061d0933ae--

