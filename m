Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A6EDC5DF9D
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 05:45:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzSup-0000fr-4v; Thu, 27 Aug 2026 01:44:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1wzSuk-0000f7-Td
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 01:44:38 -0400
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1wzSui-0004pg-An
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 01:44:37 -0400
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-cc1cb472b76so1189151a12.0
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2026 22:44:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787809474; cv=none;
 d=google.com; s=arc-20260327;
 b=kUZZ0VXdIyIuyq6ueCus4DDeebBT8JIEh9qrqSr0epOE3BDMtCLUa6+mvewq37Yk72
 UaGi6FJ8cJDmoasAwS6qCe2I4ftYJoajIL6PFTDP3Nw3V3+2jTLzGnfGzHKQDhQoFLT6
 ov07yEjNtBF5/Gek9+cED4KuCSt+tbBthT7nvmf1AJSKbTeP5rAbJ4djFQ+IMp4S7Xu4
 /sIpG2dlT2T0Bwkdp7+MJ+Y53cBrQdD1AW0YoGxVnKt28afdxAqoA6uVH/Nyg3HFjx+d
 2y6A4m0pvYfqmK3s/z9y3uXFpKN1l4RqDj2myHLhY4BvdV/na2e/m06QoYNbFClk6Q2A
 n5rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=AbYlBgUjv2EsZ3ymdlepPEsbU8BxbkPUJDDwFWNpzsE=;
 fh=Per2Qv/4GGtpnoasDFXjOSn0I4kYI1g5zM44b59yZOQ=;
 b=iXnW8MCJ3p46hQi/x4qkEMM6iSkhOsChPtug3zYeTxkX2pTtbxPmgmWsEiQKOvl6lJ
 5lELiHd/53yWnoyDHrC5sllnCXvLBOLO3BUxnKLiOSFs4WOAh/rBIXERK94i7tMymLeH
 Aqp7Z0Dvgm422AUrPbyS/TNvKpy0kqFg98PaBTpIT4XMFRNDOSX/iLndTHoWw1AJyNci
 7g3nMyrFY+IPI3Y2m2rVWK3xy+OLX/8F3NIqnf18Y4kNBQ9rEBq7WrMnZ+SwSVfcwE9T
 ZgcaF0lvdevT6FOfPwTWBIY2AM2xBH2yYRbR/9t5SktHmhzSE/cf7Fnoo2t4VhPkmw5r
 kCYg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=jms.id.au; s=google; t=1787809474; x=1788414274; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=AbYlBgUjv2EsZ3ymdlepPEsbU8BxbkPUJDDwFWNpzsE=;
 b=NkiD13PMLvqYajOsRL8XnkDbUN37f+jzvnrblLgSrKuujazVAVW9kULzvbbrtHII2h
 Hm1fAnTrT2PQ3rcSIrDOjPT2EehTUymIuTUa2SWpf1nemoaXoVVs0XURoZQnFde6Cqna
 aALzEDazXkvvVOjCW3g8eAkcu+Mt0SW6r1luY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787809474; x=1788414274;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=AbYlBgUjv2EsZ3ymdlepPEsbU8BxbkPUJDDwFWNpzsE=;
 b=LkHmx6yfX4niJIYsQF1OaZDUrcOSSn+1Qs3nMFDQMaTAMVBfuOVdhpfYgH0CxeNY2j
 FLsJdsREI4azMBKWj9S540rPOG4WAOp7zI7UOCLuqUlL6QAqq1Y/oPcaGSB2R61bi6ar
 tZfIGblqm5bEkPqomlQiJ7c7HnGIOugT8PCNTt22c3HWfJym1TO6oWUX49ztwDwU5Sy5
 XfTtwGD9PIv5w4Y68L8DxsawKwZ1Fmy1DXouCS8UhtrKT60I7woeENw0eAN5YcjWeSVj
 7NwBYV2sK20+olDx8NRZ6EiaFlgK7Q1uXXWZqyhp8enQDo8G0XYWUfv9AB5YCAbupemo
 Ft/Q==
X-Gm-Message-State: AFuF++noMVZVj5mdxuguifg0C3tdH8TI17Z2Zh/ThKuyc+NFhFPETi4U
 msa80iaHKBR0or+PdvY6NBaaW56HruwUkj+ffzOJNayexG8cUVYydQvfOSLBvLQkJ1jDntiIJWH
 LwijqICCNs3o0HDq3McsWd1OCadNRXIk=
X-Gm-Gg: AR+sD10vDdR2jD7EZ++oPKRRE5G7xtEHJtwc22SgbYoaCkSN2pc/JblKCsdIUKCZZfU
 qboBAUk3iC5VelbNJabgx+aFAhT+drTlniK6HhXfpXUZqxJGRt6fSDANqmAJirzgDsoan7kSQEk
 oc2XLJQoDBk6TQcjoL4YOLhbsLv+PBaxAKgK7p2oJq+Hc5/89JVuDXYjUJ9zV+hDaIax2Ym1HOV
 45IlpX10vnc4SBpUG2ELNnM68T7eJchIl1EGjJFqgZKAYagVY3S+IdxF+uSdNsOic7+ZS6Gfvpm
 osNPY3PhFKgZxs8RWuGmowO4s5QhkoDWFMUkf4Ge85SQcHu+A3tDJrTsuN6Xv94NYpesY2CuGkp
 vNaoBw2hyVt81voOR80srLzsVE9AIBUw80FT6lDKSZyjXJt20I1PhNAm8b7HuxxLBs/L7hndn8K
 nzKa/yhyYMey4U2WpTDAQe08A20MI=
X-Received: by 2002:a05:6a21:b8c:b0:3d1:2f88:913f with SMTP id
 adf61e73a8af0-3d12f889786mr7232912637.14.1787809474130; Wed, 26 Aug 2026
 22:44:34 -0700 (PDT)
MIME-Version: 1.0
References: <20260826214643.122728-1-daniel.barboza@oss.qualcomm.com>
 <20260826214643.122728-3-daniel.barboza@oss.qualcomm.com>
In-Reply-To: <20260826214643.122728-3-daniel.barboza@oss.qualcomm.com>
From: Joel Stanley <joel@jms.id.au>
Date: Thu, 27 Aug 2026 15:14:22 +0930
X-Gm-Features: AcwNN1UnktlU7wPe1G16IDdCEg99MmZQ9rm71p78Iisxm9RRK83A_WS_MadRcGI
Message-ID: <CACPK8XehmqwQVKjvfGNdVQjApBQJNxrO0JHywabqRUiucCP92Q@mail.gmail.com>
Subject: Re: [PATCH v3 02/14] hw/riscv/fdt-common,
 virt.c: add riscv_create_fdt_flash()
To: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, 
 chao.liu@processmission.com, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::530;
 envelope-from=joel.stan@gmail.com; helo=mail-pg1-x530.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
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

On Thu, 27 Aug 2026 at 07:16, Daniel Henrique Barboza
<daniel.barboza@oss.qualcomm.com> wrote:
>
> Add a common helper to create a cfi-flash compatible flash subnode.
>
> This change only affects the existing 'virt' board for now but it will
> be used by the future 'riscv-server-ref' board in the future.

Why do we have two flash devices?

(I know why ARM does, where the code was copied from, but why does RISC-V?)

>
> No FDT changes intended.
>
> Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@oss.qualcomm.com>
> ---
>  hw/riscv/fdt-common.c         | 12 ++++++++++++
>  hw/riscv/virt.c               | 18 ++----------------
>  include/hw/riscv/fdt-common.h |  1 +
>  3 files changed, 15 insertions(+), 16 deletions(-)
>
> diff --git a/hw/riscv/fdt-common.c b/hw/riscv/fdt-common.c
> index 3a8da03cfb..6fcc1ce21f 100644
> --- a/hw/riscv/fdt-common.c
> +++ b/hw/riscv/fdt-common.c
> @@ -283,3 +283,15 @@ void riscv_pmu_generate_fdt_node(void *fdt, uint32_t=
 cmask, char *pmu_name)
>     qemu_fdt_setprop(fdt, pmu_name, "riscv,event-to-mhpmcounters",
>                      fdt_event_ctr_map, sizeof(fdt_event_ctr_map));
>  }
> +
> +void riscv_create_fdt_flash(void *fdt, hwaddr flashbase, hwaddr flashsiz=
e)
> +{
> +    g_autofree char *name =3D g_strdup_printf("/flash@%" PRIx64, flashba=
se);
> +
> +    qemu_fdt_add_subnode(fdt, name);
> +    qemu_fdt_setprop_string(fdt, name, "compatible", "cfi-flash");
> +    qemu_fdt_setprop_sized_cells(fdt, name, "reg",
> +                                 2, flashbase, 2, flashsize,
> +                                 2, flashbase + flashsize, 2, flashsize)=
;
> +    qemu_fdt_setprop_cell(fdt, name, "bank-width", 4);
> +}

This is a copy of the code in hw/arm/virt.c, which was also copied by
hw/loongarch/virt-fdt-build.c.

