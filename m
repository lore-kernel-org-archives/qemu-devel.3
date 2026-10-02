Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3300CA5FC4
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2026 15:47:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCfTA-0007Ot-Fq; Fri, 02 Oct 2026 11:46:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xCfT3-0007OJ-2t
 for qemu-devel@nongnu.org; Fri, 02 Oct 2026 11:46:38 -0400
Received: from mail-ed2-x0e.google.com ([2a00:1450:4864:33::e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xCfT0-0001bL-PS
 for qemu-devel@nongnu.org; Fri, 02 Oct 2026 11:46:36 -0400
Received: by mail-ed2-x0e.google.com with SMTP id
 4fb4d7f45d1cf-6aae359e2c0so12174269a12.3
 for <qemu-devel@nongnu.org>; Fri, 02 Oct 2026 08:46:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790955992; cv=none;
 d=google.com; s=arc-20260327;
 b=GA2MkQh1mFCrkm2rVXMj66A0WGS2vCA7R0fgxfpm4cjYpYU1cB40XseZyA6TmBfnMF
 ilmyl0D3BRc0ubSpKKTbUGZgWRzwXw727N6Bd+c6Zr/YQpG+DIkUF1daPXwcaw3l3Mgh
 P6teuAPcmFKgpPEjP2dQj1kyuMQgHbCeYqlzKp06pS3HpQFW1/t+Ft3pet0hhJfT/WCR
 3q92tKZYA3GQxxRogQJcUlGKJ+UocQ70GQkLPZ3Pya5putll+w3v4CPTN9b2MKdGt8T1
 SnP/nq5JL/+5L4EmhNaFP2iPbO+jwBG5vSr5QkQmYNMgEVuJBRlwlXQakZbp6EqIekM3
 r9rQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:dkim-signature;
 bh=DcmBuQgOQuAEhXZY1VVxRnodJZmxTBNA4BXr+UWH02Q=;
 fh=42ltMDgnRgkLbX9DkVvAuanKsU3ZhnYXVgwti90xs7Q=;
 b=mlRNX8x8j+KOqIPbDVRCyQSmxQYvolDEepSRXG2P+ZKnIsPGv3U4bps6bFEhsnXpcQ
 XM+GH7YUqD+rxyJtvF0UmTRsGDeKoipK4X64UTkc0wWan5t/V3O1Q1KxZbvevYlaoyNC
 AtzNntn4u6KnWk3D7oDSIWuBYisor8ZpBM3RBj/0mTlyrv7EBAdhG2BH7nocpomXVmDH
 G7gmGcvGjHPwljk2DNMa7yYhY3Riy+6tb0siIVP9AxjTFYD6GHT7KXL47OrT7msQ12W0
 A54V7L4SgJlxwVww8jKwz0a+rzWnZ7vZf6dUf1QmIu2ja1oLUmape2kiqQ1xhcWIZxxF
 ynNA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790955992; x=1791560792; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=DcmBuQgOQuAEhXZY1VVxRnodJZmxTBNA4BXr+UWH02Q=;
 b=E7hr1CfvuxgmW8LmKkJJ2vAm10ywO/jHeMQ5xoz8/wrIKUALYVITke73sObuuU74X8
 osH01ZG5UXZ73dg07hi8tLo+eI0981ZFZj8/WUwP+Fe67++BdFoAfAlMJwGKcMRQCngL
 xac/K1asdnp3X+y57r47SzITVHhv870zKCy7Bbc8s5YIXaTQ2shKYLxPkVtQ/+rbQRRQ
 hA7xNnIaYp4ioWNrvskru9oNUW3orPCxJvEwWa9R2mxsbHjjdRxqu5frvWV2a8xXH66L
 9bMk1PRlqbYZSR/MTwuvgBtE9G5yyL2whOJ3UkuushPdTBlAwGaNtI7X4yZ9sqnYsZXd
 8NcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790955992; x=1791560792;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=DcmBuQgOQuAEhXZY1VVxRnodJZmxTBNA4BXr+UWH02Q=;
 b=2jQb0SLprm5c0O2UHroebxiuMrJ0cRanCt4SeV+7hI7p51yQ3dYFUrXcDo5nq3LUQa
 6AHyV/rn2J8p+Qr9LvIvMSesnuSYDddYS0n1e/JZhvikFcRUcyZ+N5OBnyZyU7pvN6ED
 mhv5AvcbiEjGpBrNwgvKFRl/wfvMxMngLMIkT6t19yrBbckrsnhZuDN2sqXlXB/iXmzV
 pkyMcEMHMffXz/e1LlrS7Vk5cEij5bRcPmKcPBJs70WVcoY7eR/PEKjxyIki4IL3cLB3
 rnEtCOv30jdqHkXJaQPzrjtFlw1jG0XjthrX/3Y0JmeqkUw7vWMgrCsDYcexWVfihEMj
 /XLw==
X-Forwarded-Encrypted: i=1;
 AKwUvByucYGEaHRMoiNpBkSW5CUEqfl0kdHmBu3d7mxUtnjcoH4II7jTikyq+4SyX0Rymi9ca9PCM1f/XCLS@nongnu.org
X-Gm-Message-State: AFq9FYIkxrxWpVHfBwr5UykYbc+4y0tYjlIcouiS5r8V9bpCHJst1AB9
 WKYht7wgwy3MEMfL5cB6e5twq9WOj9GNtRoIFHYj2bd7U9KgOL1zyylCMJbzQOsJNITue1W0vWc
 IYCHy6MXPf7/g5vxoAELLWdOGav8kFxI=
X-Gm-Gg: AYBFou3fRFH8JfS2rzC2h0XyyC67BCLELxJJaSKkb3mm5iJF81owqFdZJKvFLdTVMTk
 AQnggN31a3EN5Y/jHPxiVID11X7Y1FRMsGvRcJGxdgMFqluLAj7MVa+IlZmeXeKqLDL760US8P3
 ccB5DjnHMP/yxtwpNvzNCOcmbdzp8mXeESwk9lULymKPxHSVBfAPHFNoVEsD2vTjsABKWHxh3Qi
 Y7Ih5ueseCzxTbdO3runECj424Rerj9Rd9PIj6KFxlmHQKm2klVXQ4TluC/e7wqB3HTPrffJ/AB
 IYYVD2uCSyhVU53fhwnI8DFYZXOXKKLw9I8yasUNlPmywTRi36+TW2A=
X-Received: by 2002:a05:6402:1ec7:b0:6ab:81e:e812 with SMTP id
 4fb4d7f45d1cf-6af9e36ca95mr2181563a12.34.1790955992041; Fri, 02 Oct 2026
 08:46:32 -0700 (PDT)
MIME-Version: 1.0
References: <20261001-rv-dedup-v1-0-ea69b07afd31@rev.ng>
 <20261001-rv-dedup-v1-7-ea69b07afd31@rev.ng>
 <CAE2XoE_ag1RR_JFwgcg+9zPed+qpO2skf7W1_kiqvwB=Vf9aAQ@mail.gmail.com>
 <f8f27bc3-83ce-4ccf-ae38-a43188b2ebc5@oss.qualcomm.com>
 <ar_AzEWpF9XDGNdg@hive.localdomain>
In-Reply-To: <ar_AzEWpF9XDGNdg@hive.localdomain>
From: Yonggang Luo <luoyonggang@gmail.com>
Date: Fri, 2 Oct 2026 23:46:19 +0800
X-Gm-Features: AclHuK8D0gFkig897zC0TtaIrSv_CPgbUV-lanFSIxvUTjdMTlOY2kU-ZaeUwcI
Message-ID: <CAE2XoE-ove_cvoSZ8h_A8yw4d6YE9BS0VHc4SQ-mQ7JM1uqMvg@mail.gmail.com>
Subject: Re: [PATCH 07/18] target/riscv: Runtime register MAX and BARE CPUs
To: Anton Johansson <anjo@rev.ng>
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org, daniel.barboza@oss.qualcomm.com, 
 philmd@oss.qualcomm.com, palmer@dabbelt.com, alistair.francis@wdc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:33::e;
 envelope-from=luoyonggang@gmail.com; helo=mail-ed2-x0e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-To: luoyonggang@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Fri, Oct 2, 2026 at 11:36=E2=80=AFPM Anton Johansson <anjo@rev.ng> wrote=
:
>
> On 02/10/26, Pierrick Bouvier wrote:
> > On 10/1/2026 9:28 AM, Yonggang Luo wrote:
> > > On Thu, Oct 1, 2026 at 11:55=E2=80=AFPM Anton Johansson via qemu deve=
lopment
> > > <qemu-devel@nongnu.org> wrote:
> > >>
> > >> Moves initialization of satp and mxl fields to a class initializatio=
n
> > >> function that checks target_riscv64().
> > >>
> > >> Note: I'm aware the current iteration of this patch is rather hacky,=
 I
> > >> don't like the introduction of runtime_misa_mxl_max, but I'm keeping
> > >> this in to get the series out there and collect feedback.
> > >>
> > >> Signed-off-by: Anton Johansson <anjo@rev.ng>
> > >> ---
> > >>  target/riscv/cpu.h |  1 +
> > >>  target/riscv/cpu.c | 90 +++++++++++++++++++++++++++++++++++--------=
-----------
> > >>  2 files changed, 59 insertions(+), 32 deletions(-)
> > >>
> > >
> > > This patch is how I handle these, just for reference, not a review.
> >
> > Yonggang approach looks cleaner, I would favor this one.
>
> I'm personally not a huge fan, it still feels rather hacky. Why add a
> completely new RISCVCPUDef::target_init just to make sure fields are
> initialized before riscv_cpu_validate_misa_mxl()? Wouldn't moving the
> check to a later point, maybe .instance_init, be better? Then for
> riscv_cpu_init() we get
>
>   riscv_cpu_validate_misa_mxl(mcc);
>   env->misa_mxl =3D mcc->def->misa_mxl_max;
>

Yeap I also tried instance_init but it's too generic, that needs if else in
riscv_cpu_init guard which CPU name from(that's not explicitly related).

    if (target_riscv32()) {
        if (mcc->def->misa_mxl_max > MXL_RV32) {
            mcc->def->misa_mxl_max =3D MXL_RV32;
            mcc->def->cfg.max_satp_mode =3D VM_1_10_SV32;
        }
        if (mcc->def->bare) {
            mcc->def->cfg.max_satp_mode =3D VM_1_10_SV32;
        }
#ifndef CONFIG_USER_ONLY
        if (mcc->def->misa_mxl_max =3D=3D MXL_RV32 &&
            !valid_vm_1_10_32[mcc->def->cfg.max_satp_mode]) {
            mcc->def->cfg.max_satp_mode =3D VM_1_10_SV32;
        }
#endif
    }
That would be something like this.
Maybe another option is get max_satp_mode to be a function instead?
Indeed "max_satp_mode" depends on the chosen target.

> misa_mxl_max would be verified only during instance rather than
> class initialization, which seems like a decent tradeoff for a simpler
> solution.
>
> --
> Anton Johansson
> rev.ng Labs Srl.



--=20
         =E6=AD=A4=E8=87=B4
=E7=A4=BC
=E7=BD=97=E5=8B=87=E5=88=9A
Yours
    sincerely,
Yonggang Luo

