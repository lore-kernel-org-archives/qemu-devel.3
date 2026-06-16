Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BD19CD98DA
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 02:44:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZJmI-0002LZ-Fh; Mon, 15 Jun 2026 22:43:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wZJmF-0002KX-RE
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 22:43:48 -0400
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wZJmE-0001Ul-3p
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 22:43:47 -0400
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-6870ad8072eso9041295a12.0
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2026 19:43:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781577824; cv=none;
 d=google.com; s=arc-20240605;
 b=XrhlT/lDaP8Kzx3QL3v6XuUtyw9XTP+br5hiym7naatW9bkAE4qhBdhHx2tPNVfa8O
 NTUuuujIGYlO7lBvsi3Eu/8CRXsFw9XCVbTgyJtoUYDNuZkVMPz4ExO4PIO48flIjnIB
 qvmPXCwV8gZI41wyZEy3sv0bJZOyvr7dFWtT9ntJBaayRpJpbj2pAsHJS9WMRds+GgJl
 aC/X9IWMdkf3E3lYsVao5vzZpPYf1nfAnB5iyf/Y+3YyZ0fL3A5RexBHBfdBHtzvpz7i
 tSWfOJpudvGkvURyYxCzYKC8fWyTVj7J9vvMwppDpG3HbGXdTcm579aOXC5OTaRtZEhf
 0IFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=xhu6mlAL62u1e3/p3JLPBui22dSWxEzn/BDRKv4iWK0=;
 fh=y/39rxWsHsSIhiCgFyox46bvYsAfNaBS3wRFv9pkMrs=;
 b=Ht9ZvzSVcGlq+LFt2G21dyGoUHn/mLA7LkpZ5DbiOwCPWvtsKqHpBfjz/G9VUTNVaj
 Nm59Kc+08XclNuoVbMoTnuAPxv4K6knxFXXZ5pZwIUYHqaiT7lsMnTAyRSmLXWzY+5Qm
 omiZEJ5E1Uw9bmXWrEOOy4Ct0mva1HWu1YI1z63YaPQM/Xc+qraR39VwmkWXATnx5CXy
 36DvGVaAGK34DsgDAxaw11+Sl2aTiWLkvstpfuFeSc8Wl/nOTHIe9ZMalJ25iGOEeU3x
 iJV+fIickfGAnICIfIBSh9kmJ//7wozzTMAYodeXgBWlljIj8XRdGzFj0tyKM3ZyA49D
 XTmg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781577824; x=1782182624; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xhu6mlAL62u1e3/p3JLPBui22dSWxEzn/BDRKv4iWK0=;
 b=SW+5Q6n55CteD466FuE4B5LIH9X2+QrHOtcEGyYD7KqS110qz3mB/XhDiCg3RYC56J
 EJOroREPlM6dn9eMjstZWOaBWOn4B+aX8Ep5s2QW7tmF/gSwG6df85NraDKFx0ZAsztS
 8iCL+v2vilW5MtRk63xzUDpKUWm5RH1VKfSzC40jxYecu9XoafuCjWBkoI1U35/E9POx
 EPMsGNgDBnOJlGi6Cm7tmpHYLay954+ZfTXminHzMJf0AcSYgVwF+vo3W7RZAY2+whsl
 jpsVqolO2emXHLTfy5YRCRIdF85HX7ecQsgLZkcPP/3VnnMMgmRGGeaOekr+KorykKyn
 u/VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781577824; x=1782182624;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=xhu6mlAL62u1e3/p3JLPBui22dSWxEzn/BDRKv4iWK0=;
 b=pJxuBgpeV87Mhcm5IgpHWALBIvJ8lhtLdrjHtBpOAJgXzbtD1hG/xR1JGPz2wv4L0E
 GCfy5gBtqwi3RaiPBExvE5FPwwS8YnCa3HhPQQFlkS/J7SjIyQb5G7sBn6YF4cSPHpd2
 a1zepB6fL60t/QH0HF44bTuTkQCI8opfZfR+NXxacpIPja+HAHYspAeKcC+MULxY6/9K
 bYrL7x64KbcVeToJAWX6K3gPXco040ULOMBqansNyPzfW4xAKv1A86qzkGAIojvVHUvv
 O6fePKwiQUGg2EtDhGtVtJW/JK2dGzH7PEiTAlRVAeA9fR6Enf1ci7DjYMDoG7ElyMO3
 pgGg==
X-Gm-Message-State: AOJu0Yx8FeHs9j37AWnIMlietuFh4FWoB8jDvx27Rl0awGNCNEE83T0i
 3d5ZtZ54N4QKhMzWeyqRABQnu53jCLrAEyuZYPvUaH45L3mssji0+qtKZpWrI2r6JBCLiVyJbGz
 edraDXkABvSXGSijWFTbcJVYmqp/weG0=
X-Gm-Gg: Acq92OHvM5FLqWPDSW4lgaKOE362NSc5xWZT/nJpBj6Hus7eAr59NzviOrv37pYfa0R
 S0Tzll6iqcEHA9JLEBUdmfL3gYGj/xZu7C+meEdtZvo5mexs3Iw4YtAl3m1UWtvFzNONzwtdDZp
 VF6fvR2RZgkxc7ugALmslp0EUfLVhvkEG95JSI05rlZHNglFutkPUQBOfkKBANk7//ukvV45wPs
 6tm0MgC9xveaOJ+tLoVzFTAmV+mCVNeCXU7MeJ5HPsf09KalRiYIdb9RSrg8Mbc7g2X+XawNGim
 5TTyBI4nXMINxR2VWyFIY/nBCZXQgBV+w8eMCQ==
X-Received: by 2002:a05:6402:194a:b0:67e:9cd6:c68f with SMTP id
 4fb4d7f45d1cf-695082024f7mr870607a12.7.1781577824544; Mon, 15 Jun 2026
 19:43:44 -0700 (PDT)
MIME-Version: 1.0
References: <20260615203734.954428-1-daniel.barboza@oss.qualcomm.com>
 <20260615203734.954428-4-daniel.barboza@oss.qualcomm.com>
In-Reply-To: <20260615203734.954428-4-daniel.barboza@oss.qualcomm.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 16 Jun 2026 12:43:17 +1000
X-Gm-Features: AVVi8Cc8uGcun8IodzEKNUFPPOEdK1fxcBy6FrQL8bD7jvWQT4Zqozi_68jnUi8
Message-ID: <CAKmqyKMy8Du2A9Cf5W8iePqYaJBvU-DA2e1VK4vopxSraQp-yw@mail.gmail.com>
Subject: Re: [PATCH 03/13] hw/riscv/numa: make numa_enabled() public
To: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com, 
 Palmer Dabbelt <palmer@dabbelt.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=alistair23@gmail.com; helo=mail-ed1-x52c.google.com
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

On Tue, Jun 16, 2026 at 6:38=E2=80=AFAM Daniel Henrique Barboza
<daniel.barboza@oss.qualcomm.com> wrote:
>
> There's FDT logic gated around 'numa_enabled()' in virt.c and spike.c.
> We want to move the FDT code to a common helper without having to call
> hw/riscv/numa.c functions from it, but at the same time being aware of
> the FDT changes if numa is enabled.
>
> To do that the boards will inform the FDT helpers if we have
> numa_enabled in the env or not.  And for the boards to be able to do
> that we need the static 'numa_enabled' function to be public.
>
> Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/riscv/numa.c         | 20 ++++++++++----------
>  include/hw/riscv/numa.h |  8 ++++++++
>  2 files changed, 18 insertions(+), 10 deletions(-)
>
> diff --git a/hw/riscv/numa.c b/hw/riscv/numa.c
> index 8a144925c1..8933d9d81f 100644
> --- a/hw/riscv/numa.c
> +++ b/hw/riscv/numa.c
> @@ -25,21 +25,21 @@
>  #include "hw/riscv/numa.h"
>  #include "system/device_tree.h"
>
> -static bool numa_enabled(const MachineState *ms)
> +bool riscv_numa_enabled(const MachineState *ms)
>  {
>      return (ms->numa_state && ms->numa_state->num_nodes) ? true : false;
>  }
>
>  int riscv_socket_count(const MachineState *ms)
>  {
> -    return (numa_enabled(ms)) ? ms->numa_state->num_nodes : 1;
> +    return (riscv_numa_enabled(ms)) ? ms->numa_state->num_nodes : 1;
>  }
>
>  int riscv_socket_first_hartid(const MachineState *ms, int socket_id)
>  {
>      int i, first_hartid =3D ms->smp.cpus;
>
> -    if (!numa_enabled(ms)) {
> +    if (!riscv_numa_enabled(ms)) {
>          return (!socket_id) ? 0 : -1;
>      }
>
> @@ -59,7 +59,7 @@ int riscv_socket_last_hartid(const MachineState *ms, in=
t socket_id)
>  {
>      int i, last_hartid =3D -1;
>
> -    if (!numa_enabled(ms)) {
> +    if (!riscv_numa_enabled(ms)) {
>          return (!socket_id) ? ms->smp.cpus - 1 : -1;
>      }
>
> @@ -79,7 +79,7 @@ int riscv_socket_hart_count(const MachineState *ms, int=
 socket_id)
>  {
>      int first_hartid, last_hartid;
>
> -    if (!numa_enabled(ms)) {
> +    if (!riscv_numa_enabled(ms)) {
>          return (!socket_id) ? ms->smp.cpus : -1;
>      }
>
> @@ -104,7 +104,7 @@ bool riscv_socket_check_hartids(const MachineState *m=
s, int socket_id)
>  {
>      int i, first_hartid, last_hartid;
>
> -    if (!numa_enabled(ms)) {
> +    if (!riscv_numa_enabled(ms)) {
>          return (!socket_id) ? true : false;
>      }
>
> @@ -132,7 +132,7 @@ uint64_t riscv_socket_mem_offset(const MachineState *=
ms, int socket_id)
>      int i;
>      uint64_t mem_offset =3D 0;
>
> -    if (!numa_enabled(ms)) {
> +    if (!riscv_numa_enabled(ms)) {
>          return 0;
>      }
>
> @@ -148,7 +148,7 @@ uint64_t riscv_socket_mem_offset(const MachineState *=
ms, int socket_id)
>
>  uint64_t riscv_socket_mem_size(const MachineState *ms, int socket_id)
>  {
> -    if (!numa_enabled(ms)) {
> +    if (!riscv_numa_enabled(ms)) {
>          return (!socket_id) ? ms->ram_size : 0;
>      }
>
> @@ -159,7 +159,7 @@ uint64_t riscv_socket_mem_size(const MachineState *ms=
, int socket_id)
>  void riscv_socket_fdt_write_id(const MachineState *ms, const char *node_=
name,
>                                 int socket_id)
>  {
> -    if (numa_enabled(ms)) {
> +    if (riscv_numa_enabled(ms)) {
>          qemu_fdt_setprop_cell(ms->fdt, node_name, "numa-node-id", socket=
_id);
>      }
>  }
> @@ -170,7 +170,7 @@ void riscv_socket_fdt_write_distance_matrix(const Mac=
hineState *ms)
>      g_autofree uint32_t *dist_matrix =3D NULL;
>      uint32_t dist_matrix_size;
>
> -    if (numa_enabled(ms) && ms->numa_state->have_numa_distance) {
> +    if (riscv_numa_enabled(ms) && ms->numa_state->have_numa_distance) {
>          dist_matrix_size =3D riscv_socket_count(ms) * riscv_socket_count=
(ms);
>          dist_matrix_size *=3D (3 * sizeof(uint32_t));
>          dist_matrix =3D g_malloc0(dist_matrix_size);
> diff --git a/include/hw/riscv/numa.h b/include/hw/riscv/numa.h
> index e68ce8e8af..ac07786555 100644
> --- a/include/hw/riscv/numa.h
> +++ b/include/hw/riscv/numa.h
> @@ -23,6 +23,14 @@
>  #include "hw/core/sysbus.h"
>  #include "system/numa.h"
>
> +/**
> + * riscv_numa_enabled:
> + * @ms: pointer to machine state
> + *
> + * Returns: true if NUMA is enabled in the machine state.
> + */
> +bool riscv_numa_enabled(const MachineState *ms);
> +
>  /**
>   * riscv_socket_count:
>   * @ms: pointer to machine state
> --
> 2.43.0
>
>

