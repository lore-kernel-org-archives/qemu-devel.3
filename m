Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC589CD98E4
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2026 03:03:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wbUwl-0004WW-Ck; Sun, 21 Jun 2026 23:03:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wbUwi-0004Vp-ED
 for qemu-devel@nongnu.org; Sun, 21 Jun 2026 23:03:36 -0400
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wbUwg-0004vq-PN
 for qemu-devel@nongnu.org; Sun, 21 Jun 2026 23:03:36 -0400
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-6977c8ec631so1030540a12.0
 for <qemu-devel@nongnu.org>; Sun, 21 Jun 2026 20:03:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782097413; cv=none;
 d=google.com; s=arc-20240605;
 b=Ggh24tFaZOoZPCBJMQHHCHWtR/iRr3onSfX45xmqJDMb6aqom3ivDn3dBs4nXMuw0p
 Klj5GkcOkizJ4gRUtduk/xkXoOOeizFTqNc+StWzIQCrBNzIhySiz0AMPpBfUxrGFjy5
 Wjhw5bK4rZHCEM7PU+DyMrXSXD6aYATbSR0yQ4ww3r5mv1zFJ7sbgUeVItBmzGuilExC
 nMk/xcrpoYt6A45W/ccQM/kCZajDzgIeR16msZoQ1fyUP6VwD06CczPVekkHVG96apY2
 wILfQuHxBzt4gdDIrvjnXjynXdnH2RzG+Ka3oMXwd1tFf1KK60UG4lHQUUSZbWucwSZS
 LiEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Zm1XUkgLFCUl1+npnTvCWYpIX9/4Q7Uv+87zd9HrCaA=;
 fh=37FU9UkQqTXJQCBirpdkGit3Ki/mSuB0AUPxzpAQmrk=;
 b=fOyfE3+tnz/b95bjBsZO4eCbuQ65/7YtXrExRYRwGnHiUXE2BviLIJMYrqDRf5DSG/
 YCeq2kmoL0Yb4PIXGkd/xpjgLlXmvj7RcHJKMlvM5O28dsapoA9B0JkyTwGHqpcjwt2p
 s+TVedAkNkZJm73HZ2++Dtoabo+FzcIDJyZ2gp8yRMHPT6uE0ze7Xjegeg2Ts7Ae2+PC
 wIrWRsnP/X60inAs+IlTzPv8uyjqQFvA3DBm/ScMj44AsqLnb4rc5NGBHNv73wrVCDWE
 T8sFBff6Lw3T9akRYDdOoCfPx/Tv8NZ4PtT49F0VHx8sp488hQGUeqigEHy/mRzRoiGt
 WZ2A==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782097413; x=1782702213; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Zm1XUkgLFCUl1+npnTvCWYpIX9/4Q7Uv+87zd9HrCaA=;
 b=VJee01z986tcOuw93wu2cylJhk8zsrYYbSNWmcUFwq+IvfFKQaFIrFdPQ2haIjwbEe
 C3UqizxuW3R8tiivjgk25Dqb6QhkQf/LobXuUukvnbLqoJasj74KEnaCdmmr/AFiHijl
 ZVyeFg6oNZUP8V5ePkN2GU9LO/RKXBRdPYP52wVDaZpVdStHY+4yL1ICZW5hDVNrfsYV
 dAdTy2yHJR9pwcwpRH0HYs7AJwPtZr7LOZ7/VF6LNO7jpDyDd+ZXSMF3BFvowhNmgKV6
 p8mGeFenns09Uz2yL25rzmTSe5odvoYHLRtO6EDabyNvLhWaCEYTazdrbQAYJ2kFprOI
 Ndkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782097413; x=1782702213;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Zm1XUkgLFCUl1+npnTvCWYpIX9/4Q7Uv+87zd9HrCaA=;
 b=SSjR3OIGLnctVHyY9NmpKxPqy7fdbm/XT/VYpdISONEoU4b8lqASVuACEygxqpcna5
 WWgUCfaYMFqQPsbYII3vfT6js1amgbsUWxOy08Ly2ivW1iPSoFQHaupjS+ofA1raTgAi
 NiMLZWWKyyerv+9JE0ZZyWAOJRhNGbUutXJRUN1D5+pGrjx3gC/LLTUftp9dZqF6Y/Pw
 ojo4gXbJdHOAG+UwVQNiIkT4F9juZAR1LTIjc827jWwgoJJXMNj2m90gRvos4CNHsnYk
 ru66rN35UYJsySUqIhdSBXGCrKPD1hZIEMVlPOX1x6RPLMpJXZOu9jX/lCgXvIt13sbQ
 Oarw==
X-Gm-Message-State: AOJu0YyR8ZdXeDO7sYBoh+0ghGxj82j1cIzrsWlKgRmAMsPIaFsNovAB
 v6UP/Z4uJd4LMrjk9okJu1ono1ZzfGOil0PzXIMskmJp+Z1xxVXmG5sSKXa1XCc5hS3LA6QUkS1
 H1CZcigv0W+NrdKXJVRXjrcKNCxt8Z/o=
X-Gm-Gg: AfdE7cluTcnzTPuJ0+O0JTbK3Ltai6eFF5egc++KyX+bWJJuCrOsuVxm4OjhXuWZhTb
 18hrnMxx+KbQUg/LQLeAUB4oWA5FqySeffzIzHFdbEkLbDgPi+Cm2w0web682kKPi+xz+Hx53QS
 lIEFSpdn0UK8uHP3kSHKKrSQSukkICIZfMG7toLXBcERIzmFdjXRTgs9kPNSpflpTxG9ejV/cTG
 /omcFSXFDpE+W/5ZmO6JgvqPQzS8PP9WYlhwGRWUTpyJKhwCrGuiUIZlOVXks5nLaIYEeAGPL8s
 dyHXn/+xA7jtweVMIX7FE2eg8kO2hkhc+CL2dA==
X-Received: by 2002:a05:6402:28ce:b0:67c:a6d1:c48b with SMTP id
 4fb4d7f45d1cf-697022d41bemr4649293a12.11.1782097413182; Sun, 21 Jun 2026
 20:03:33 -0700 (PDT)
MIME-Version: 1.0
References: <tencent_CA380CBF4A98C990C07BC04A9E748C438309@qq.com>
In-Reply-To: <tencent_CA380CBF4A98C990C07BC04A9E748C438309@qq.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 22 Jun 2026 13:03:06 +1000
X-Gm-Features: AVVi8CfbiBIH95SiFdJMriXuBjhtsb-KTXtSRIbLlfZ3IIY2HRZRrBki8C8q-8Q
Message-ID: <CAKmqyKN09Ut3BAnUpF4Fen=DzMcT=sNpGjTHa8yPeu58H5EpDg@mail.gmail.com>
Subject: Re: [PATCH v3] target/riscv: raise access fault for Zicbom MMIO-like
 accesses
To: ZhengXiang Qin <qinzhengxiang@foxmail.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=alistair23@gmail.com; helo=mail-ed1-x52b.google.com
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

On Sun, Jun 21, 2026 at 10:48=E2=80=AFPM ZhengXiang Qin
<qinzhengxiang@foxmail.com> wrote:
>
> check_zicbom_access() currently treats any probe_access_flags() result
> other than TLB_INVALID_MASK as a successful access. However, a result
> with TLB_MMIO means that the target is MMIO-like and should not be
> treated as a normal cache block management target.
>
> Raise a store/AMO access fault for Zicbom accesses to MMIO-like regions
> so that cbo.clean, cbo.flush and cbo.inval do not silently succeed on
> non-cacheable/MMIO-like memory.
>
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3501
> Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
> Reviewed-by: Chao Liu <chao.liu.zevorn@gmail.com>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@oss.qualcomm.com>
> Signed-off-by: ZhengXiang Qin <qinzhengxiang@foxmail.com>

Thanks!

Applied to riscv-to-apply.next

Alistair

> ---
> Changes since v2:
> - Add else before the success path for readability.
> - Keep fault_addr as target_ulong since CPURISCVState::badaddr is target_=
ulong.
> - Add Philippe's Reviewed-by tag.
>
> Changes since v1:
> - Use a bit test for TLB_MMIO since probe_access_flags() returns a bitmas=
k.
> - Keep Reviewed-by tags from v1.
>
>  target/riscv/op_helper.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/target/riscv/op_helper.c b/target/riscv/op_helper.c
> index 81873014cb..50fd1b73ea 100644
> --- a/target/riscv/op_helper.c
> +++ b/target/riscv/op_helper.c
> @@ -218,6 +218,7 @@ static void check_zicbom_access(CPURISCVState *env,
>      void *phost;
>      int ret;
>
> +    target_ulong fault_addr =3D address;
>      /* Mask off low-bits to align-down to the cache-block. */
>      address &=3D ~(cbomlen - 1);
>
> @@ -235,7 +236,10 @@ static void check_zicbom_access(CPURISCVState *env,
>       */
>      ret =3D probe_access_flags(env, address, cbomlen, MMU_DATA_LOAD,
>                               mmu_idx, true, &phost, ra);
> -    if (ret !=3D TLB_INVALID_MASK) {
> +    if (ret & TLB_MMIO) {
> +        env->badaddr =3D fault_addr;
> +        riscv_raise_exception(env, RISCV_EXCP_STORE_AMO_ACCESS_FAULT, ra=
);
> +    } else if (ret !=3D TLB_INVALID_MASK) {
>          /* Success: readable */
>          return;
>      }
> --
> 2.43.0
>
>

