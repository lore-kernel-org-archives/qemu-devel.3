Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15E15CDE00B
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2026 00:22:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcuJh-0004en-Ah; Thu, 25 Jun 2026 20:21:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wcuJd-0004bu-Vn
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 20:21:07 -0400
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wcuJb-00082m-0Z
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 20:21:05 -0400
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-6980ae819f4so753567a12.0
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2026 17:21:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782433260; cv=none;
 d=google.com; s=arc-20260327;
 b=Td+XPYeWSqDThEkNdNw6kKXFCKNk0eWJTfKmH7kbOLv+Dl21Kc+YVgjWVOQpSB0HGq
 9PQ+AjjxhsqrbwKuC8mUk7kNmkViav1jV5AuXbiFiyjLEYkItfBBjguuwpUIDRk9E/vQ
 Pbt2KNQpSxEWFW2GH9T+DRXYdrgruTn8amhMM5fE9qXtmbWTvxXqCauu0TgILHNyc17h
 lZoyVOaH6r687uLuN4WKAidM5uU+nk0TjU2anUdudkh0i/qEXtRkvCskfMGKPbjc7Rsd
 zMgi3xb3VpB/b2Cn9ZLH1NdypMMOZOjLuFd8vk2ffqi/+xEJwyS2szazMkM3L0JSJQ6O
 0v2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=MsFvL8roDi5UUhdr5GhIxrGR00w7NGjSrA9UxUxrxDw=;
 fh=9/4tzqKjgzJcjmYJcCvfm+LbcgW0ATp/rdwAYjKmbVo=;
 b=HmKQHoMF1YVZDEfgNggdVdiZJGDWBn4ngEvi5pmnyZvLvdi35Andhoki20o+WNFHOz
 eQu7rubQ88qbXGrNw6xoVfDTSUWBKKZBdMczMpNH9lIQfR8oyXeYR6QgSUQePRcFffVQ
 BeYFt90wgyRhv+YX/iG97oEOj5nF5P3N6M4RG5be7OLQlWi8T3L/D0qj41BaNU+i2b43
 8vpGAGT/tz/IF6+BHYTPO62uyFR5lnHLpgqwIHLyP8aZagfPvs015gB9MDR8Lcnxyd/O
 8/GPtyti64+KQQdRgojD/ZfG0uiz7Pw0ooWnof1OPZkYkA1pb5SaNbLDQBn4T2KeXLEP
 LXLQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782433260; x=1783038060; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MsFvL8roDi5UUhdr5GhIxrGR00w7NGjSrA9UxUxrxDw=;
 b=UOX9jeuBhf15Z9lTJlstuvaUFhpK7WUeiAca76I2Tem9PYwhOp2Io+Kg2bBnyUcs8/
 gKufiEOqSQgFbWY/u03wae3uFRbHKO3s4XlG7CI42LkPuLdqi8X7YVLPO+zZWiR8+mOW
 s4LYmTWuoUiAeM6wFRowr1jrZFl5990iQP+0bYCbKzH1fEu83ogCeS6MvGbuz3dWvFJm
 wpyFDD/2FCZf2s77i2raLJtMlFAfPw3AVPT42F7Tqt7FkNVQuRm2IpP0B3ZCALLE1bqC
 DDWJLhDr14OQQDK9m562QxWi+SOtjoOMypNy0wmJ6rjlHslVUebF6pukO4H3QpeaPQ9k
 eZBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782433260; x=1783038060;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=MsFvL8roDi5UUhdr5GhIxrGR00w7NGjSrA9UxUxrxDw=;
 b=bjhFHlJtCZvpmOkzL8rVk0eLLEfcO5TZKdyDML8e06Iy5T1CkolMyoG+l3jI2k8gJW
 NEUhzmHm+SiZ9hh9mKDAiSby57ojkpJPLPLYejP6SRlacAMWNs6GZpU/09eT8m50b01c
 T5cDwrwQATpU/SmOmVwTaXYh+BhQ+28UZkF5bact1ACe+tYVfQJlkHG5oaC2O7f/pLFt
 TwUsTtRxccTrUXLml39AVVYxTBsWvNyUT5Q3GdAGrEN6MqIMhKly0AayDAxRWUjbTda/
 Uh7jZqBt47FWhYw0t7RdVgnlZPXuxZ9UX9CgNhWm2VA6YSLGSgzzB1ILodmcNw/1FnGK
 WhSA==
X-Gm-Message-State: AOJu0YyiroF0bybY0oCi+rb06vWRUTrj9hDYSDmGvheYr3QNrEjl0zFv
 RFDtf0MJa7fYiqbdLGFHGsUQtI4PnGmbPykfuYzN/3NvQs75ZQCCFI45OpZRvPsOZJUgyk8RYou
 XrJ2kuoZQOzMDjsC/awtxuSyocs/tVE8=
X-Gm-Gg: AfdE7cmAXOHxXGVW23BVkPUlFqtNmm5rpjHvVTN7R9Sv9lpvp7fan0Q2bFNs3y9w+jA
 EF+C+Vi0U+UG9wGI4XBq/iNeY1/vMapjAvUrpcp4RkZUtUHpg0utId7pg5++qBCZsB0KAK3Ot3B
 7MdveJKlj5jecJnzlmq0Uaz4VDIl8lwQ6KnAbAj9UOoyqd6h2bGoqJNx36ovefQCJyMHtWIrv2N
 4pTUJuG5pLx9i3nq3rlOCz6YoyryqtkLH07f/l4jqYlWuBCxxmC3TsXd4KKpotHnTlg7hTos2JG
 ie3Hz+bNSicIEwMFRwxmvOt8/ks=
X-Received: by 2002:aa7:d7d6:0:b0:697:645b:90e5 with SMTP id
 4fb4d7f45d1cf-697d42cdeb5mr4285367a12.4.1782433260170; Thu, 25 Jun 2026
 17:21:00 -0700 (PDT)
MIME-Version: 1.0
References: <20260624000632.2149359-1-daniel.barboza@oss.qualcomm.com>
 <20260624000632.2149359-3-daniel.barboza@oss.qualcomm.com>
In-Reply-To: <20260624000632.2149359-3-daniel.barboza@oss.qualcomm.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 26 Jun 2026 10:20:33 +1000
X-Gm-Features: AVVi8CeLO2kj1wNuoCRGUGZKgD5GweBrBeLjqiBQq-Lw0-x5ZGAi0yQe07tUx9I
Message-ID: <CAKmqyKPXcZX2EvTGv+W53fUnk2nMbJRpMvqaDGDnFwuyRyFypw@mail.gmail.com>
Subject: Re: [PATCH v2 02/24] target/riscv: move TCG only files to tcg subdir
To: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com, 
 pierrick.bouvier@oss.qualcomm.com, philmd@oss.qualcomm.com, 
 fritchleybohrer@gmail.com, Palmer Dabbelt <palmer@dabbelt.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=alistair23@gmail.com; helo=mail-ed1-x536.google.com
X-Spam_score_int: -7
X-Spam_score: -0.8
X-Spam_bar: /
X-Spam_report: (-0.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FORGED_GMAIL_RCVD=1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

On Wed, Jun 24, 2026 at 10:09=E2=80=AFAM Daniel Henrique Barboza
<daniel.barboza@oss.qualcomm.com> wrote:
>
> We have *way* too much TCG-only code hanging around in target/riscv,
> where ideally we would have things that are shared between accelerators.
>
> We'll follow the example of other targets like i386 and loongarch and
> move everything to the tcg subir.  This will not only cleanup target/risc=
v
> but it will also expose what is common code but it's buried inside a TCG
> helper.
>
> We're leaving some stuff behind because these require a little more
> case to not end up breaking KVM.  We'll take care of them next.
>
> Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@oss.qualcomm.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/meson.build                      | 16 ----------
>  target/riscv/{ =3D> tcg}/bitmanip_helper.c      |  0
>  target/riscv/{ =3D> tcg}/cpu_helper.c           |  0
>  target/riscv/{ =3D> tcg}/crypto_helper.c        |  0
>  target/riscv/{ =3D> tcg}/csr.c                  |  0
>  target/riscv/{ =3D> tcg}/debug.c                |  0
>  target/riscv/{ =3D> tcg}/fpu_helper.c           |  0
>  .../insn_trans/trans_privileged.c.inc         |  0
>  .../{ =3D> tcg}/insn_trans/trans_rva.c.inc      |  0
>  .../{ =3D> tcg}/insn_trans/trans_rvb.c.inc      |  0
>  .../{ =3D> tcg}/insn_trans/trans_rvbf16.c.inc   |  0
>  .../{ =3D> tcg}/insn_trans/trans_rvd.c.inc      |  0
>  .../{ =3D> tcg}/insn_trans/trans_rvf.c.inc      |  0
>  .../{ =3D> tcg}/insn_trans/trans_rvh.c.inc      |  0
>  .../{ =3D> tcg}/insn_trans/trans_rvi.c.inc      |  0
>  .../{ =3D> tcg}/insn_trans/trans_rvk.c.inc      |  0
>  .../{ =3D> tcg}/insn_trans/trans_rvm.c.inc      |  0
>  .../{ =3D> tcg}/insn_trans/trans_rvv.c.inc      |  0
>  .../{ =3D> tcg}/insn_trans/trans_rvvk.c.inc     |  0
>  .../{ =3D> tcg}/insn_trans/trans_rvzabha.c.inc  |  0
>  .../{ =3D> tcg}/insn_trans/trans_rvzacas.c.inc  |  0
>  .../{ =3D> tcg}/insn_trans/trans_rvzalasr.c.inc |  0
>  .../{ =3D> tcg}/insn_trans/trans_rvzawrs.c.inc  |  0
>  .../{ =3D> tcg}/insn_trans/trans_rvzce.c.inc    |  0
>  .../{ =3D> tcg}/insn_trans/trans_rvzcmop.c.inc  |  0
>  .../{ =3D> tcg}/insn_trans/trans_rvzfa.c.inc    |  0
>  .../{ =3D> tcg}/insn_trans/trans_rvzfh.c.inc    |  0
>  .../{ =3D> tcg}/insn_trans/trans_rvzicbo.c.inc  |  0
>  .../insn_trans/trans_rvzicfiss.c.inc          |  0
>  .../{ =3D> tcg}/insn_trans/trans_rvzicond.c.inc |  0
>  .../{ =3D> tcg}/insn_trans/trans_rvzimop.c.inc  |  0
>  .../{ =3D> tcg}/insn_trans/trans_svinval.c.inc  |  0
>  .../{ =3D> tcg}/insn_trans/trans_xlrbr.c.inc    |  0
>  .../{ =3D> tcg}/insn_trans/trans_xmips.c.inc    |  0
>  .../{ =3D> tcg}/insn_trans/trans_xthead.c.inc   |  0
>  .../insn_trans/trans_xventanacondops.c.inc    |  0
>  .../{ =3D> tcg}/insn_trans/trans_zilsd.c.inc    |  0
>  target/riscv/{ =3D> tcg}/m128_helper.c          |  0
>  target/riscv/tcg/meson.build                  | 30 +++++++++++++++++--
>  target/riscv/{ =3D> tcg}/mips_csr.c             |  0
>  target/riscv/{ =3D> tcg}/op_helper.c            |  0
>  target/riscv/{ =3D> tcg}/pmu.c                  |  0
>  target/riscv/{ =3D> tcg}/th_csr.c               |  0
>  target/riscv/{ =3D> tcg}/translate.c            |  0
>  target/riscv/{ =3D> tcg}/vcrypto_helper.c       |  0
>  target/riscv/{ =3D> tcg}/vector_helper.c        |  0
>  target/riscv/{ =3D> tcg}/vector_internals.c     |  0
>  target/riscv/{ =3D> tcg}/vector_internals.h     |  0
>  target/riscv/{ =3D> tcg}/zce_helper.c           |  0
>  49 files changed, 28 insertions(+), 18 deletions(-)
>  rename target/riscv/{ =3D> tcg}/bitmanip_helper.c (100%)
>  rename target/riscv/{ =3D> tcg}/cpu_helper.c (100%)
>  rename target/riscv/{ =3D> tcg}/crypto_helper.c (100%)
>  rename target/riscv/{ =3D> tcg}/csr.c (100%)
>  rename target/riscv/{ =3D> tcg}/debug.c (100%)
>  rename target/riscv/{ =3D> tcg}/fpu_helper.c (100%)
>  rename target/riscv/{ =3D> tcg}/insn_trans/trans_privileged.c.inc (100%)
>  rename target/riscv/{ =3D> tcg}/insn_trans/trans_rva.c.inc (100%)
>  rename target/riscv/{ =3D> tcg}/insn_trans/trans_rvb.c.inc (100%)
>  rename target/riscv/{ =3D> tcg}/insn_trans/trans_rvbf16.c.inc (100%)
>  rename target/riscv/{ =3D> tcg}/insn_trans/trans_rvd.c.inc (100%)
>  rename target/riscv/{ =3D> tcg}/insn_trans/trans_rvf.c.inc (100%)
>  rename target/riscv/{ =3D> tcg}/insn_trans/trans_rvh.c.inc (100%)
>  rename target/riscv/{ =3D> tcg}/insn_trans/trans_rvi.c.inc (100%)
>  rename target/riscv/{ =3D> tcg}/insn_trans/trans_rvk.c.inc (100%)
>  rename target/riscv/{ =3D> tcg}/insn_trans/trans_rvm.c.inc (100%)
>  rename target/riscv/{ =3D> tcg}/insn_trans/trans_rvv.c.inc (100%)
>  rename target/riscv/{ =3D> tcg}/insn_trans/trans_rvvk.c.inc (100%)
>  rename target/riscv/{ =3D> tcg}/insn_trans/trans_rvzabha.c.inc (100%)
>  rename target/riscv/{ =3D> tcg}/insn_trans/trans_rvzacas.c.inc (100%)
>  rename target/riscv/{ =3D> tcg}/insn_trans/trans_rvzalasr.c.inc (100%)
>  rename target/riscv/{ =3D> tcg}/insn_trans/trans_rvzawrs.c.inc (100%)
>  rename target/riscv/{ =3D> tcg}/insn_trans/trans_rvzce.c.inc (100%)
>  rename target/riscv/{ =3D> tcg}/insn_trans/trans_rvzcmop.c.inc (100%)
>  rename target/riscv/{ =3D> tcg}/insn_trans/trans_rvzfa.c.inc (100%)
>  rename target/riscv/{ =3D> tcg}/insn_trans/trans_rvzfh.c.inc (100%)
>  rename target/riscv/{ =3D> tcg}/insn_trans/trans_rvzicbo.c.inc (100%)
>  rename target/riscv/{ =3D> tcg}/insn_trans/trans_rvzicfiss.c.inc (100%)
>  rename target/riscv/{ =3D> tcg}/insn_trans/trans_rvzicond.c.inc (100%)
>  rename target/riscv/{ =3D> tcg}/insn_trans/trans_rvzimop.c.inc (100%)
>  rename target/riscv/{ =3D> tcg}/insn_trans/trans_svinval.c.inc (100%)
>  rename target/riscv/{ =3D> tcg}/insn_trans/trans_xlrbr.c.inc (100%)
>  rename target/riscv/{ =3D> tcg}/insn_trans/trans_xmips.c.inc (100%)
>  rename target/riscv/{ =3D> tcg}/insn_trans/trans_xthead.c.inc (100%)
>  rename target/riscv/{ =3D> tcg}/insn_trans/trans_xventanacondops.c.inc (=
100%)
>  rename target/riscv/{ =3D> tcg}/insn_trans/trans_zilsd.c.inc (100%)
>  rename target/riscv/{ =3D> tcg}/m128_helper.c (100%)
>  rename target/riscv/{ =3D> tcg}/mips_csr.c (100%)
>  rename target/riscv/{ =3D> tcg}/op_helper.c (100%)
>  rename target/riscv/{ =3D> tcg}/pmu.c (100%)
>  rename target/riscv/{ =3D> tcg}/th_csr.c (100%)
>  rename target/riscv/{ =3D> tcg}/translate.c (100%)
>  rename target/riscv/{ =3D> tcg}/vcrypto_helper.c (100%)
>  rename target/riscv/{ =3D> tcg}/vector_helper.c (100%)
>  rename target/riscv/{ =3D> tcg}/vector_internals.c (100%)
>  rename target/riscv/{ =3D> tcg}/vector_internals.h (100%)
>  rename target/riscv/{ =3D> tcg}/zce_helper.c (100%)
>
> diff --git a/target/riscv/meson.build b/target/riscv/meson.build
> index 79f36abd63..61874ed0af 100644
> --- a/target/riscv/meson.build
> +++ b/target/riscv/meson.build
> @@ -16,31 +16,15 @@ riscv_ss.add(when: 'CONFIG_ARM_COMPATIBLE_SEMIHOSTING=
',
>
>  riscv_ss.add(files(
>    'cpu.c',
> -  'cpu_helper.c',
> -  'csr.c',
> -  'fpu_helper.c',
>    'gdbstub.c',
> -  'op_helper.c',
> -  'vector_helper.c',
> -  'vector_internals.c',
> -  'bitmanip_helper.c',
> -  'translate.c',
> -  'm128_helper.c',
> -  'crypto_helper.c',
> -  'zce_helper.c',
> -  'vcrypto_helper.c'
>  ))
>
>  riscv_system_ss =3D ss.source_set()
>  riscv_system_ss.add(files(
>    'arch_dump.c',
>    'pmp.c',
> -  'debug.c',
>    'monitor.c',
>    'machine.c',
> -  'mips_csr.c',
> -  'pmu.c',
> -  'th_csr.c',
>    'time_helper.c',
>    'riscv-qmp-cmds.c',
>  ))
> diff --git a/target/riscv/bitmanip_helper.c b/target/riscv/tcg/bitmanip_h=
elper.c
> similarity index 100%
> rename from target/riscv/bitmanip_helper.c
> rename to target/riscv/tcg/bitmanip_helper.c
> diff --git a/target/riscv/cpu_helper.c b/target/riscv/tcg/cpu_helper.c
> similarity index 100%
> rename from target/riscv/cpu_helper.c
> rename to target/riscv/tcg/cpu_helper.c
> diff --git a/target/riscv/crypto_helper.c b/target/riscv/tcg/crypto_helpe=
r.c
> similarity index 100%
> rename from target/riscv/crypto_helper.c
> rename to target/riscv/tcg/crypto_helper.c
> diff --git a/target/riscv/csr.c b/target/riscv/tcg/csr.c
> similarity index 100%
> rename from target/riscv/csr.c
> rename to target/riscv/tcg/csr.c
> diff --git a/target/riscv/debug.c b/target/riscv/tcg/debug.c
> similarity index 100%
> rename from target/riscv/debug.c
> rename to target/riscv/tcg/debug.c
> diff --git a/target/riscv/fpu_helper.c b/target/riscv/tcg/fpu_helper.c
> similarity index 100%
> rename from target/riscv/fpu_helper.c
> rename to target/riscv/tcg/fpu_helper.c
> diff --git a/target/riscv/insn_trans/trans_privileged.c.inc b/target/risc=
v/tcg/insn_trans/trans_privileged.c.inc
> similarity index 100%
> rename from target/riscv/insn_trans/trans_privileged.c.inc
> rename to target/riscv/tcg/insn_trans/trans_privileged.c.inc
> diff --git a/target/riscv/insn_trans/trans_rva.c.inc b/target/riscv/tcg/i=
nsn_trans/trans_rva.c.inc
> similarity index 100%
> rename from target/riscv/insn_trans/trans_rva.c.inc
> rename to target/riscv/tcg/insn_trans/trans_rva.c.inc
> diff --git a/target/riscv/insn_trans/trans_rvb.c.inc b/target/riscv/tcg/i=
nsn_trans/trans_rvb.c.inc
> similarity index 100%
> rename from target/riscv/insn_trans/trans_rvb.c.inc
> rename to target/riscv/tcg/insn_trans/trans_rvb.c.inc
> diff --git a/target/riscv/insn_trans/trans_rvbf16.c.inc b/target/riscv/tc=
g/insn_trans/trans_rvbf16.c.inc
> similarity index 100%
> rename from target/riscv/insn_trans/trans_rvbf16.c.inc
> rename to target/riscv/tcg/insn_trans/trans_rvbf16.c.inc
> diff --git a/target/riscv/insn_trans/trans_rvd.c.inc b/target/riscv/tcg/i=
nsn_trans/trans_rvd.c.inc
> similarity index 100%
> rename from target/riscv/insn_trans/trans_rvd.c.inc
> rename to target/riscv/tcg/insn_trans/trans_rvd.c.inc
> diff --git a/target/riscv/insn_trans/trans_rvf.c.inc b/target/riscv/tcg/i=
nsn_trans/trans_rvf.c.inc
> similarity index 100%
> rename from target/riscv/insn_trans/trans_rvf.c.inc
> rename to target/riscv/tcg/insn_trans/trans_rvf.c.inc
> diff --git a/target/riscv/insn_trans/trans_rvh.c.inc b/target/riscv/tcg/i=
nsn_trans/trans_rvh.c.inc
> similarity index 100%
> rename from target/riscv/insn_trans/trans_rvh.c.inc
> rename to target/riscv/tcg/insn_trans/trans_rvh.c.inc
> diff --git a/target/riscv/insn_trans/trans_rvi.c.inc b/target/riscv/tcg/i=
nsn_trans/trans_rvi.c.inc
> similarity index 100%
> rename from target/riscv/insn_trans/trans_rvi.c.inc
> rename to target/riscv/tcg/insn_trans/trans_rvi.c.inc
> diff --git a/target/riscv/insn_trans/trans_rvk.c.inc b/target/riscv/tcg/i=
nsn_trans/trans_rvk.c.inc
> similarity index 100%
> rename from target/riscv/insn_trans/trans_rvk.c.inc
> rename to target/riscv/tcg/insn_trans/trans_rvk.c.inc
> diff --git a/target/riscv/insn_trans/trans_rvm.c.inc b/target/riscv/tcg/i=
nsn_trans/trans_rvm.c.inc
> similarity index 100%
> rename from target/riscv/insn_trans/trans_rvm.c.inc
> rename to target/riscv/tcg/insn_trans/trans_rvm.c.inc
> diff --git a/target/riscv/insn_trans/trans_rvv.c.inc b/target/riscv/tcg/i=
nsn_trans/trans_rvv.c.inc
> similarity index 100%
> rename from target/riscv/insn_trans/trans_rvv.c.inc
> rename to target/riscv/tcg/insn_trans/trans_rvv.c.inc
> diff --git a/target/riscv/insn_trans/trans_rvvk.c.inc b/target/riscv/tcg/=
insn_trans/trans_rvvk.c.inc
> similarity index 100%
> rename from target/riscv/insn_trans/trans_rvvk.c.inc
> rename to target/riscv/tcg/insn_trans/trans_rvvk.c.inc
> diff --git a/target/riscv/insn_trans/trans_rvzabha.c.inc b/target/riscv/t=
cg/insn_trans/trans_rvzabha.c.inc
> similarity index 100%
> rename from target/riscv/insn_trans/trans_rvzabha.c.inc
> rename to target/riscv/tcg/insn_trans/trans_rvzabha.c.inc
> diff --git a/target/riscv/insn_trans/trans_rvzacas.c.inc b/target/riscv/t=
cg/insn_trans/trans_rvzacas.c.inc
> similarity index 100%
> rename from target/riscv/insn_trans/trans_rvzacas.c.inc
> rename to target/riscv/tcg/insn_trans/trans_rvzacas.c.inc
> diff --git a/target/riscv/insn_trans/trans_rvzalasr.c.inc b/target/riscv/=
tcg/insn_trans/trans_rvzalasr.c.inc
> similarity index 100%
> rename from target/riscv/insn_trans/trans_rvzalasr.c.inc
> rename to target/riscv/tcg/insn_trans/trans_rvzalasr.c.inc
> diff --git a/target/riscv/insn_trans/trans_rvzawrs.c.inc b/target/riscv/t=
cg/insn_trans/trans_rvzawrs.c.inc
> similarity index 100%
> rename from target/riscv/insn_trans/trans_rvzawrs.c.inc
> rename to target/riscv/tcg/insn_trans/trans_rvzawrs.c.inc
> diff --git a/target/riscv/insn_trans/trans_rvzce.c.inc b/target/riscv/tcg=
/insn_trans/trans_rvzce.c.inc
> similarity index 100%
> rename from target/riscv/insn_trans/trans_rvzce.c.inc
> rename to target/riscv/tcg/insn_trans/trans_rvzce.c.inc
> diff --git a/target/riscv/insn_trans/trans_rvzcmop.c.inc b/target/riscv/t=
cg/insn_trans/trans_rvzcmop.c.inc
> similarity index 100%
> rename from target/riscv/insn_trans/trans_rvzcmop.c.inc
> rename to target/riscv/tcg/insn_trans/trans_rvzcmop.c.inc
> diff --git a/target/riscv/insn_trans/trans_rvzfa.c.inc b/target/riscv/tcg=
/insn_trans/trans_rvzfa.c.inc
> similarity index 100%
> rename from target/riscv/insn_trans/trans_rvzfa.c.inc
> rename to target/riscv/tcg/insn_trans/trans_rvzfa.c.inc
> diff --git a/target/riscv/insn_trans/trans_rvzfh.c.inc b/target/riscv/tcg=
/insn_trans/trans_rvzfh.c.inc
> similarity index 100%
> rename from target/riscv/insn_trans/trans_rvzfh.c.inc
> rename to target/riscv/tcg/insn_trans/trans_rvzfh.c.inc
> diff --git a/target/riscv/insn_trans/trans_rvzicbo.c.inc b/target/riscv/t=
cg/insn_trans/trans_rvzicbo.c.inc
> similarity index 100%
> rename from target/riscv/insn_trans/trans_rvzicbo.c.inc
> rename to target/riscv/tcg/insn_trans/trans_rvzicbo.c.inc
> diff --git a/target/riscv/insn_trans/trans_rvzicfiss.c.inc b/target/riscv=
/tcg/insn_trans/trans_rvzicfiss.c.inc
> similarity index 100%
> rename from target/riscv/insn_trans/trans_rvzicfiss.c.inc
> rename to target/riscv/tcg/insn_trans/trans_rvzicfiss.c.inc
> diff --git a/target/riscv/insn_trans/trans_rvzicond.c.inc b/target/riscv/=
tcg/insn_trans/trans_rvzicond.c.inc
> similarity index 100%
> rename from target/riscv/insn_trans/trans_rvzicond.c.inc
> rename to target/riscv/tcg/insn_trans/trans_rvzicond.c.inc
> diff --git a/target/riscv/insn_trans/trans_rvzimop.c.inc b/target/riscv/t=
cg/insn_trans/trans_rvzimop.c.inc
> similarity index 100%
> rename from target/riscv/insn_trans/trans_rvzimop.c.inc
> rename to target/riscv/tcg/insn_trans/trans_rvzimop.c.inc
> diff --git a/target/riscv/insn_trans/trans_svinval.c.inc b/target/riscv/t=
cg/insn_trans/trans_svinval.c.inc
> similarity index 100%
> rename from target/riscv/insn_trans/trans_svinval.c.inc
> rename to target/riscv/tcg/insn_trans/trans_svinval.c.inc
> diff --git a/target/riscv/insn_trans/trans_xlrbr.c.inc b/target/riscv/tcg=
/insn_trans/trans_xlrbr.c.inc
> similarity index 100%
> rename from target/riscv/insn_trans/trans_xlrbr.c.inc
> rename to target/riscv/tcg/insn_trans/trans_xlrbr.c.inc
> diff --git a/target/riscv/insn_trans/trans_xmips.c.inc b/target/riscv/tcg=
/insn_trans/trans_xmips.c.inc
> similarity index 100%
> rename from target/riscv/insn_trans/trans_xmips.c.inc
> rename to target/riscv/tcg/insn_trans/trans_xmips.c.inc
> diff --git a/target/riscv/insn_trans/trans_xthead.c.inc b/target/riscv/tc=
g/insn_trans/trans_xthead.c.inc
> similarity index 100%
> rename from target/riscv/insn_trans/trans_xthead.c.inc
> rename to target/riscv/tcg/insn_trans/trans_xthead.c.inc
> diff --git a/target/riscv/insn_trans/trans_xventanacondops.c.inc b/target=
/riscv/tcg/insn_trans/trans_xventanacondops.c.inc
> similarity index 100%
> rename from target/riscv/insn_trans/trans_xventanacondops.c.inc
> rename to target/riscv/tcg/insn_trans/trans_xventanacondops.c.inc
> diff --git a/target/riscv/insn_trans/trans_zilsd.c.inc b/target/riscv/tcg=
/insn_trans/trans_zilsd.c.inc
> similarity index 100%
> rename from target/riscv/insn_trans/trans_zilsd.c.inc
> rename to target/riscv/tcg/insn_trans/trans_zilsd.c.inc
> diff --git a/target/riscv/m128_helper.c b/target/riscv/tcg/m128_helper.c
> similarity index 100%
> rename from target/riscv/m128_helper.c
> rename to target/riscv/tcg/m128_helper.c
> diff --git a/target/riscv/tcg/meson.build b/target/riscv/tcg/meson.build
> index 061df3d74a..5684fcf985 100644
> --- a/target/riscv/tcg/meson.build
> +++ b/target/riscv/tcg/meson.build
> @@ -1,2 +1,28 @@
> -riscv_ss.add(when: 'CONFIG_TCG', if_true: files(
> -  'tcg-cpu.c'))
> +if 'CONFIG_TCG' not in config_all_accel
> +  subdir_done()
> +endif
> +
> +riscv_ss.add(files(
> +  'bitmanip_helper.c',
> + 'cpu_helper.c',
> +  'csr.c',
> +  'crypto_helper.c',
> +  'fpu_helper.c',
> +  'm128_helper.c',
> +  'op_helper.c',
> +  'translate.c',
> +  'tcg-cpu.c',
> +  'vcrypto_helper.c',
> +  'vector_helper.c',
> +  'vector_internals.c',
> +  'zce_helper.c'))
> +
> +
> +riscv_system_ss.add(files(
> +  'debug.c',
> +  'mips_csr.c',
> +  'pmu.c',
> +  'th_csr.c',
> +))
> +
> +
> diff --git a/target/riscv/mips_csr.c b/target/riscv/tcg/mips_csr.c
> similarity index 100%
> rename from target/riscv/mips_csr.c
> rename to target/riscv/tcg/mips_csr.c
> diff --git a/target/riscv/op_helper.c b/target/riscv/tcg/op_helper.c
> similarity index 100%
> rename from target/riscv/op_helper.c
> rename to target/riscv/tcg/op_helper.c
> diff --git a/target/riscv/pmu.c b/target/riscv/tcg/pmu.c
> similarity index 100%
> rename from target/riscv/pmu.c
> rename to target/riscv/tcg/pmu.c
> diff --git a/target/riscv/th_csr.c b/target/riscv/tcg/th_csr.c
> similarity index 100%
> rename from target/riscv/th_csr.c
> rename to target/riscv/tcg/th_csr.c
> diff --git a/target/riscv/translate.c b/target/riscv/tcg/translate.c
> similarity index 100%
> rename from target/riscv/translate.c
> rename to target/riscv/tcg/translate.c
> diff --git a/target/riscv/vcrypto_helper.c b/target/riscv/tcg/vcrypto_hel=
per.c
> similarity index 100%
> rename from target/riscv/vcrypto_helper.c
> rename to target/riscv/tcg/vcrypto_helper.c
> diff --git a/target/riscv/vector_helper.c b/target/riscv/tcg/vector_helpe=
r.c
> similarity index 100%
> rename from target/riscv/vector_helper.c
> rename to target/riscv/tcg/vector_helper.c
> diff --git a/target/riscv/vector_internals.c b/target/riscv/tcg/vector_in=
ternals.c
> similarity index 100%
> rename from target/riscv/vector_internals.c
> rename to target/riscv/tcg/vector_internals.c
> diff --git a/target/riscv/vector_internals.h b/target/riscv/tcg/vector_in=
ternals.h
> similarity index 100%
> rename from target/riscv/vector_internals.h
> rename to target/riscv/tcg/vector_internals.h
> diff --git a/target/riscv/zce_helper.c b/target/riscv/tcg/zce_helper.c
> similarity index 100%
> rename from target/riscv/zce_helper.c
> rename to target/riscv/tcg/zce_helper.c
> --
> 2.43.0
>
>

