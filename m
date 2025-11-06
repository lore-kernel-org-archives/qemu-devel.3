Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D891CCFA13
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Nov 2025 22:58:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vH8v8-00072r-Hp; Thu, 06 Nov 2025 17:57:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1vH8v7-00072A-3y
 for qemu-devel@nongnu.org; Thu, 06 Nov 2025 17:57:33 -0500
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1vH8v4-0000sf-Uq
 for qemu-devel@nongnu.org; Thu, 06 Nov 2025 17:57:32 -0500
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-b728a43e410so30565466b.1
 for <qemu-devel@nongnu.org>; Thu, 06 Nov 2025 14:57:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1762469849; x=1763074649; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/Wfq0K+HffqXQsz5FZlocW3EX0vjFeyipwMJgKbrtFE=;
 b=WBmRCelAsZ02WFfHUEWuiPKjmD7lsfqnuZNXzVrlZVUmsp5FdPEjthBa0deC8J4+DV
 1QUbHlQFpFNf5yxJoIBL8OIkCKRt0LwSXKHvZpSDJOHtpr1JHYMWUpR0w/2h6KHCS5Iu
 MjLhr2it0vOErzZHrT/azz8qJkByhaZpPVO+4RO87qvdTEPPwI0+2t2ywNnZh0JwjDa1
 hsI70HMZb5xe3JtaaKgsB7NgtQXs2eLXGgBiB4cKki7m3Bqn2SIs4fXQKUG5eseDtwA3
 zifYejeQPF7VOwr4WBA3s0gj3DiTYX4QA5zlB6OS8J+waWuePMzi+WIl1wCLqWtNikeZ
 E1YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762469849; x=1763074649;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=/Wfq0K+HffqXQsz5FZlocW3EX0vjFeyipwMJgKbrtFE=;
 b=YwBlj3UEeFdzkJsUY5MmlF+uTLC5EULSSkTSWDYMZckJeYxTi05Q2iCK4YAFrF3fAI
 76AMpxFBQGMW7qND98Cmvm5rkeckMpPkdVtHq6Z8m9HEW4JfhPVwn2CQZWn8U15vEpJ+
 UNjvzT+PsJ0Emg6xY9TdxoUogihO4OtkYVPUOJNdoKTYO+HSVOswYv1jeViT7HW9QcMA
 ZrF2zVZ8AUJxUOue7PrMzF/jWM36++GSU5UwSUuDShk2kntNfgLjjsrZzxhq2WHlJmHb
 I71oE8eVnqt2Dbo73FJ1eZgo8wNfqC2bPhhDRZNQTCRVzyXDBDYL2euir82yiqyvIlvw
 l3XQ==
X-Gm-Message-State: AOJu0Yx5omeLO21FYXfJ4I3sptTgrds/njZX6YNGhV6M3/blW6XTOdtF
 PSdzMEmhrfQql6wWieB3JFYw+dtrfynpMS8GcwFRvu9tfvpvY164i4bXkzQqveHJ74lpVUm1ylq
 vEEGF4ZB4Qe+MSsTCz8CiaJAT4LCPYuQ=
X-Gm-Gg: ASbGncv+nPV5FL0V+KjpgjTTvib2PFUzRmV0vVaLPrIxQvjLhzg1kOva1vCUC6DtYyj
 QFmyBl5bWXGkYPc/sKoCebDsL9CwZNv2EU1BS9NHXQ0MT9RkHR68C82+Y/Rtv/uuvTRg3SOmyy6
 /IJYToNWeNsYNQ+37sbC+BfRWdGERf+K8PQpiG/eFlmg51k+ChR38oVG6WC/7h8DvsABuqU9d7Q
 bcSSM3kMHq+zfOMzhxJ2oX5mtez+HiLBqojgvxIWBotrf6JxYMyCZ1e9Ap+zlAqMvOntTql0moC
 o50iN+vVdE/861Y=
X-Google-Smtp-Source: AGHT+IHaQOE/9fc1kp6h2lF7CrmtLI6iQ3+ytMEIFkh+TAkuVpzxmnWSlIALcXwN5+8IVqrzqwdlWXOldq5pCdUS74U=
X-Received: by 2002:a17:907:2d13:b0:b71:854:4e49 with SMTP id
 a640c23a62f3a-b72c0d7079emr107865966b.56.1762469848494; Thu, 06 Nov 2025
 14:57:28 -0800 (PST)
MIME-Version: 1.0
References: <20251023043520.1777130-1-alistair.francis@wdc.com>
 <20251023043520.1777130-5-alistair.francis@wdc.com>
 <a8e88aaa-02ef-406e-9737-bbe017e420d3@linaro.org>
In-Reply-To: <a8e88aaa-02ef-406e-9737-bbe017e420d3@linaro.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 7 Nov 2025 08:57:02 +1000
X-Gm-Features: AWmQ_bnshogGwpVdFDf7vtdDLuIaDNoa1QEHq3c2dah8nzZujVJX3VArCpnH5zk
Message-ID: <CAKmqyKPEg6tpyxfZK7z+nsM-wYUiuzr8i7D2jZOQWmrxnNfwNQ@mail.gmail.com>
Subject: Re: [PULL 26/37] hw/misc: Add RISC-V CMGCR device implementation
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Anton Johansson <anjo@rev.ng>, 
 Djordje Todorovic <Djordje.Todorovic@htecgroup.com>,
 Chao-ying Fu <cfu@mips.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::635;
 envelope-from=alistair23@gmail.com; helo=mail-ej1-x635.google.com
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

On Wed, Nov 5, 2025 at 8:15=E2=80=AFPM Philippe Mathieu-Daud=C3=A9 <philmd@=
linaro.org> wrote:
>
> On 23/10/25 06:35, alistair23@gmail.com wrote:
> > From: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
> >
> > Add RISC-V implementation of the Coherent Manager Global Control
> > Register (CMGCR) device. It is based on the existing MIPS CMGCR
> > implementation but adapted for RISC-V systems.
> >
> > The CMGCR device provides global system control for multi-core
> > configurations in RISC-V systems.
> >
> > This is needed for the MIPS BOSTON AIA board.
> >
> > Signed-off-by: Chao-ying Fu <cfu@mips.com>
> > Signed-off-by: Djordje Todorovic <djordje.todorovic@htecgroup.com>
> > Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> > Message-ID: <20251018154522.745788-9-djordje.todorovic@htecgroup.com>
> > Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> > ---
> >   include/hw/misc/riscv_cmgcr.h |  50 +++++++
> >   hw/misc/riscv_cmgcr.c         | 248 +++++++++++++++++++++++++++++++++=
+
> >   hw/misc/Kconfig               |   9 ++
> >   hw/misc/meson.build           |   2 +
> >   4 files changed, 309 insertions(+)
> >   create mode 100644 include/hw/misc/riscv_cmgcr.h
> >   create mode 100644 hw/misc/riscv_cmgcr.c
>
>
> > +static inline void update_gcr_base(RISCVGCRState *gcr, uint64_t val)
> > +{
> > +    gcr->gcr_base =3D val & GCR_BASE_GCRBASE_MSK;
> > +    memory_region_set_address(&gcr->iomem, gcr->gcr_base);
> > +
> > +    /*
> > +     * For boston-aia, cpc_base is set to gcr_base + 0x8001 to enable
> > +     * cpc automatically.
> > +     */
> > +    update_cpc_base(gcr, val + 0x8001);
> > +}
> > +
> > +/* Read GCR registers */
> > +static uint64_t gcr_read(void *opaque, hwaddr addr, unsigned size)
> > +{
> > +    RISCVGCRState *gcr =3D (RISCVGCRState *) opaque;
> > +
> > +    switch (addr) {
> > +    /* Global Control Block Register */
> > +    case GCR_CONFIG_OFS:
> > +        /* Set PCORES to 0 */
> > +        return 0;
> > +    case GCR_BASE_OFS:
> > +        return gcr->gcr_base;
> > +    case GCR_REV_OFS:
> > +        return gcr->gcr_rev;
> > +    case GCR_CPC_STATUS_OFS:
> > +        return is_cpc_connected(gcr);
> > +    case GCR_L2_CONFIG_OFS:
> > +        /* L2 BYPASS */
> > +        return GCR_L2_CONFIG_BYPASS_MSK;
> > +    default:
> > +        qemu_log_mask(LOG_UNIMP, "Read %d bytes at GCR offset 0x%" HWA=
DDR_PRIx
> > +                      "\n", size, addr);
> > +    }
> > +    return 0;
> > +}
> > +
> > +static inline target_ulong get_exception_base(RISCVGCRVPState *vps)
> > +{
> > +    return vps->reset_base & GCR_CL_RESET_BASE_RESETBASE_MSK;
> > +}
> > +
> > +/* Write GCR registers */
> > +static void gcr_write(void *opaque, hwaddr addr, uint64_t data, unsign=
ed size)
> > +{
> > +    RISCVGCRState *gcr =3D (RISCVGCRState *)opaque;
> > +    RISCVGCRVPState *current_vps;
> > +    int cpu_index, c, h;
> > +
> > +    for (c =3D 0; c < gcr->num_core; c++) {
> > +        for (h =3D 0; h < gcr->num_hart; h++) {
> > +            if (addr =3D=3D RISCV_CLCB_OFS + c * RISCV_CORE_REG_STRIDE=
 + h * 8) {
> > +                cpu_index =3D c * gcr->num_hart + h;
> > +                current_vps =3D &gcr->vps[cpu_index];
> > +                current_vps->reset_base =3D data & GCR_CL_RESET_BASE_M=
SK;
> > +                cpu_set_exception_base(cpu_index + gcr->cluster_id *
> > +                                       gcr->num_core * gcr->num_hart,
> > +                                       get_exception_base(current_vps)=
);
> > +                return;
> > +            }
> > +        }
> > +    }
> > +
> > +    switch (addr) {
> > +    case GCR_BASE_OFS:
> > +        update_gcr_base(gcr, data);
> > +        break;
> > +    default:
> > +        qemu_log_mask(LOG_UNIMP, "Write %d bytes at GCR offset 0x%" HW=
ADDR_PRIx
> > +                      " 0x%" PRIx64 "\n", size, addr, data);
> > +        break;
> > +    }
> > +}
> > +
> > +static const MemoryRegionOps gcr_ops =3D {
> > +    .read =3D gcr_read,
> > +    .write =3D gcr_write,
> > +    .endianness =3D DEVICE_NATIVE_ENDIAN,
>
> Dubious DEVICE_NATIVE_ENDIAN use, do you mean DEVICE_LITTLE_ENDIAN?
>
> Maybe we can alter checkpatch to no accept new DEVICE_NATIVE_ENDIAN
> in our code base.

Ah good catch, this could be the s390 issue.

This patch was dropped in the v2 pull request, @Djordje can you fix
this in the next patch submission

Alistair

