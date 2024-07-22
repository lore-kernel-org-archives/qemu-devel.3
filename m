Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FA99C3DA59
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2024 23:25:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sW2Oc-0003ii-Sq; Mon, 22 Jul 2024 19:24:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <atishp@rivosinc.com>)
 id 1sW2Oa-0003dF-TS
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 19:24:44 -0400
Received: from mail-lf1-x12c.google.com ([2a00:1450:4864:20::12c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <atishp@rivosinc.com>)
 id 1sW2OY-00060h-QM
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 19:24:44 -0400
Received: by mail-lf1-x12c.google.com with SMTP id
 2adb3069b0e04-52fc4388a64so708847e87.1
 for <qemu-devel@nongnu.org>; Mon, 22 Jul 2024 16:24:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1721690677; x=1722295477;
 darn=nongnu.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4rijGo3HaETYPHa30L2mqR1DEK8teFf3f2P78Lzwjek=;
 b=NZPBmw6GfFgw2MV4THjlfU7a389rzLp/woHpS3BM6e0W0eeu/fq+288kSbq4OsEN8J
 ZH9I1F745ijgciECpu6G5iZzjXaXWOuEGuXiKnPLVC6+ZfcojD9LwSB1A4+9ZKufui2l
 TXHHR+thXdNImycnoe5vXyxQlKgYHfSf0Vi2GjtnPIHanlZpXwIOhQkYtbcTPSrvhxZg
 ULGOiT5woPSXIcnFdtgL9pkkaPhSzxfdXxwzHLUJEWg047AS6TIg5aTRf3v9M4er0skF
 z60ZgBAhHwkePL59dupDZdCZF0C/FvEB81GCh1/hLJr8hGzr7sfRVsgZtW+BVE3BUIq3
 BPIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721690677; x=1722295477;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4rijGo3HaETYPHa30L2mqR1DEK8teFf3f2P78Lzwjek=;
 b=PsqJsJ95CW3Df3X7QvItl/BZfJ/zAulLhweG3d2+g9QW1waIzsrsfRD6z0shA49aDY
 EL+KDk2vc9eNEfuB2RG52gdd7AxOMsF7D08p1R3n4riPCqdwf7+le9G5O+gRyqDeKNmT
 si5zFfhLc0Ll3PkdKEsrrZzicTsggdLS459q4e6fmhdsNilFFuFJeC02NkpAvgZaCJty
 8dJE2zY/2VpE9p4fQS8tF8/yv4yMCQi2o6Dn6Ck+kDnVoSU6m5+KjumcDaOwhfODssvh
 qfFwlq2smYUwoR7dZVcubtoPlfRYbdQ6Dx7P4XKLPOZmzpruf2ky0Aa6tRyukd3wB+qK
 ogKA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXpuIkI6P/Yxu0l0mkXSlgG30OTU3fVKzfKu3z+Y95h42n2e+abU0HAPBBR+Q2SJcbjKKidfkU3+yhfk7M8TpuDDV39cnw=
X-Gm-Message-State: AOJu0YwG/tnM+ATXB1hcEl59yQ72hAvVHI85Svq0/5Lx9Cjq6u9BNoLQ
 94430PrO82NdStLuXM6yAS87VKnjk0rdDKAy7ieJaOAxi//Mvm4u2JSvL8l2ayRJlETK9kKVKzB
 j/tZAKvnsIg+MTeWtg9jIHp3ytEOLocVmEAAbeQ==
X-Google-Smtp-Source: AGHT+IFKfc4v679rnAGo7XggcR2Jyw6mkDnxv5CnqrWBSUP7I+gxv06+8Li4inxuE/V9xaFHw+v/w/iTNSitH8DxsyQ=
X-Received: by 2002:a05:6512:10cf:b0:52f:c24b:175f with SMTP id
 2adb3069b0e04-52fc4047b2bmr701334e87.20.1721690677292; Mon, 22 Jul 2024
 16:24:37 -0700 (PDT)
MIME-Version: 1.0
References: <20240718021012.2057986-1-alistair.francis@wdc.com>
 <20240718021012.2057986-22-alistair.francis@wdc.com>
 <CAFEAcA9dToUo9LwxQwCLSL=gVTXWs9M23BpLhm+eD1rZShnehQ@mail.gmail.com>
In-Reply-To: <CAFEAcA9dToUo9LwxQwCLSL=gVTXWs9M23BpLhm+eD1rZShnehQ@mail.gmail.com>
From: Atish Kumar Patra <atishp@rivosinc.com>
Date: Mon, 22 Jul 2024 16:24:26 -0700
Message-ID: <CAHBxVyGQHBobpf71o4Qp51iQGXKBh0Ajup=e_a95xdLF==V_WQ@mail.gmail.com>
Subject: Re: [PULL 21/30] target/riscv: Implement privilege mode filtering for
 cycle/instret
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Alistair Francis <alistair23@gmail.com>, qemu-devel@nongnu.org, 
 Rajnesh Kanwal <rkanwal@rivosinc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, 
 Alistair Francis <alistair.francis@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::12c;
 envelope-from=atishp@rivosinc.com; helo=mail-lf1-x12c.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On Sat, Jul 20, 2024 at 7:44=E2=80=AFAM Peter Maydell <peter.maydell@linaro=
.org> wrote:
>
> On Thu, 18 Jul 2024 at 03:12, Alistair Francis <alistair23@gmail.com> wro=
te:
> >
> > From: Atish Patra <atishp@rivosinc.com>
> >
> > Privilege mode filtering can also be emulated for cycle/instret by
> > tracking host_ticks/icount during each privilege mode switch. This
> > patch implements that for both cycle/instret and mhpmcounters. The
> > first one requires Smcntrpmf while the other one requires Sscofpmf
> > to be enabled.
> >
> > The cycle/instret are still computed using host ticks when icount
> > is not enabled. Otherwise, they are computed using raw icount which
> > is more accurate in icount mode.
>
> Hi; Coverity points out some possible issues with this patch
> (CID 1558459, 1558462):
>
>
> > +typedef struct PMUFixedCtrState {
> > +        /* Track cycle and icount for each privilege mode */
> > +        uint64_t counter[4];
> > +        uint64_t counter_prev[4];
> > +        /* Track cycle and icount for each privilege mode when V =3D 1=
*/
> > +        uint64_t counter_virt[2];
> > +        uint64_t counter_virt_prev[2];
>
> These two arrays are defined with size 2...
>
>
> > +static void riscv_pmu_icount_update_priv(CPURISCVState *env,
> > +                                         target_ulong newpriv, bool ne=
w_virt)
> > +{
> > +    uint64_t *snapshot_prev, *snapshot_new;
> > +    uint64_t current_icount;
> > +    uint64_t *counter_arr;
> > +    uint64_t delta;
> > +
> > +    if (icount_enabled()) {
> > +        current_icount =3D icount_get_raw();
> > +    } else {
> > +        current_icount =3D cpu_get_host_ticks();
> > +    }
> > +
> > +    if (env->virt_enabled) {
> > +        counter_arr =3D env->pmu_fixed_ctrs[1].counter_virt;
> > +        snapshot_prev =3D env->pmu_fixed_ctrs[1].counter_virt_prev;
> > +    } else {
> > +        counter_arr =3D env->pmu_fixed_ctrs[1].counter;
> > +        snapshot_prev =3D env->pmu_fixed_ctrs[1].counter_prev;
> > +    }
> > +
> > +    if (new_virt) {
> > +        snapshot_new =3D env->pmu_fixed_ctrs[1].counter_virt_prev;
> > +    } else {
> > +        snapshot_new =3D env->pmu_fixed_ctrs[1].counter_prev;
> > +    }
> > +
> > +     /*
> > +      * new_priv can be same as env->priv. So we need to calculate
> > +      * delta first before updating snapshot_new[new_priv].
> > +      */
> > +    delta =3D current_icount - snapshot_prev[env->priv];
> > +    snapshot_new[newpriv] =3D current_icount;
> > +
> > +    counter_arr[env->priv] +=3D delta;
>
> ...and in this function we may use those counter_virt and
> counter_virt_prev arrays with newpriv and env->priv as indexes,
> but in the callsites like riscv_cpu_set_mode() the assertions on
> newpriv etc are things like
>   g_assert(newpriv <=3D PRV_M && newpriv !=3D PRV_RESERVED);
>
> so Coverity thinks newpriv might be PRV_M (because that's the only
> explicit range guard it's seen) and we will overrun the array.
>
> If this is a "can't happen" case I think we should have asserts in the


Yes. Both these arrays are used when virt is enabled which can't
happen when PRV_M.
The separate array is required to distinguish between VS and HS mode
where both priv is PRV_S.

> functions like riscv_pmu_icount_update_priv() and riscv_pmu_cycle_update_=
priv()
> that might index into these arrays that the indexes can't be out of bound=
s
> for these smaller arrays.
>

Sure. I will add the asserts and send a fix patch.

>
> thanks
> -- PMM

