Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBFECD0EE3F
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2024 20:46:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1szMWK-0003qZ-Of; Fri, 11 Oct 2024 16:45:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <atishp@rivosinc.com>)
 id 1szMWH-0003py-5h
 for qemu-devel@nongnu.org; Fri, 11 Oct 2024 16:45:53 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <atishp@rivosinc.com>)
 id 1szMWF-0002SG-HQ
 for qemu-devel@nongnu.org; Fri, 11 Oct 2024 16:45:52 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-71df1fe11c1so2036242b3a.2
 for <qemu-devel@nongnu.org>; Fri, 11 Oct 2024 13:45:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1728679549; x=1729284349;
 darn=nongnu.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=n2DfuRyeZF47307DoPYcO3eVWdPDyJaZwtbw690pN7A=;
 b=Wgk4aiNMqOBXYM5htZ8CTUSJ3u/GfElABnm/OXhO/cbUkSw67MzQBzeBTgp3P95tU0
 OTq7knDulcCaUeXMBSrJm/DRoMzp76vZbLzzuaCqr+bvTcPvSaEPkQET0bAHMSNEqT1J
 O0k0sY8Wq90EX4hnpnR34DaOhUxcHQ3+86tYLj4is1kutyR8uD/smtKD7WrBOjSo9GgO
 C6j9BCCN46tNOVQtzF3VwWo6Q5GmU/A0GQBckLbI3+V2WM1VgvI5DBexOf84PanCQHkK
 pdJsTdkSJL2VtvGT/DSm97JYohE7M06aUaKDrrl+nwhQ9eyr1p+aK/j2MGYT1NaavG2p
 31kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728679549; x=1729284349;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=n2DfuRyeZF47307DoPYcO3eVWdPDyJaZwtbw690pN7A=;
 b=cyfpZdQfmUx3Qhm4+w17YcMx7fFupTImETziFTIZ4Osc37ehwfrRFbBFgVnn/GefCF
 Viv9XlGEIOPpCVC2jEynSp7bEFb0E/BlYpH/HH6O+hxU+F0b7XeFSDJc/n0liPxnCF20
 nedIaL3yl5XCJwoBusLSvupqE4bOwRVjf2C+3BP+/SpmpONrkpvSioGfSZHiBrwCgQSX
 qh+8+ohPRPtmmqApBeGUD+uMD658j2cDUXB3yFk48gVHgGRTmO2dLmQdtaK5BiFtqb17
 KdiapZp42zs1Qr8RUu2tbILskJzu2oIhpBdgdkooUSRUXIzmFx7TGmoMxfwnD84hrrBg
 T0mw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXdaJKraq6wsQmmM6s3QS8XyDa+WSbYwlvq0z1KMhasYFRal76JW66w7t3ZBHXAws0CTsjuBPeNZJrG@nongnu.org
X-Gm-Message-State: AOJu0Yxoq6fmtbvRPX4W6lsOQ5Ni0YL6XyT8UoRQJCpjEQvw5KoOsZfp
 yJdFg8uLsaKO68X4vcK2R6bpRdb2n6QOaxpjLOvtUy4gt6aKOojqP0qv+mzt9LzqCM9GkwkXoTG
 tIIHNzhrYofifSlUFsGF3lK8kSqiGhZlroQoV8w==
X-Google-Smtp-Source: AGHT+IG03S/mwcu0rUGMnZOvyWeGMKhDnsOae9vgHboK0J/VOsI4Ls3fUgtFbwNS5xtffJn889gtSJS88cfODghS8HM=
X-Received: by 2002:a05:6a21:1707:b0:1d0:2531:ddb1 with SMTP id
 adf61e73a8af0-1d8bcfc235dmr5024352637.43.1728679548840; Fri, 11 Oct 2024
 13:45:48 -0700 (PDT)
MIME-Version: 1.0
References: <20241009-pmu_event_machine-v1-0-dcbd7a60e3ba@rivosinc.com>
 <20241009-pmu_event_machine-v1-6-dcbd7a60e3ba@rivosinc.com>
 <fd89dafa-279d-436c-9569-f2fdc289bac9@yadro.com>
In-Reply-To: <fd89dafa-279d-436c-9569-f2fdc289bac9@yadro.com>
From: Atish Kumar Patra <atishp@rivosinc.com>
Date: Fri, 11 Oct 2024 13:45:37 -0700
Message-ID: <CAHBxVyE2C3sRJNbLOwhOZCnXAUTsEdh-mCewVAEJDDAURL10ug@mail.gmail.com>
Subject: Re: [PATCH RFC 06/10] target/riscv: Define PMU event related
 structures
To: Alexei Filippov <alexei.filippov@yadro.com>
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org, 
 alexei.filippov@syntacore.com, palmer@dabbelt.com, liwei1518@gmail.com, 
 zhiwei_liu@linux.alibaba.com, bin.meng@windriver.com, 
 dbarboza@ventanamicro.com, alistair.francis@wdc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=atishp@rivosinc.com; helo=mail-pf1-x432.google.com
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

On Thu, Oct 10, 2024 at 5:44=E2=80=AFAM Alexei Filippov
<alexei.filippov@yadro.com> wrote:
>
>
>
> On 10.10.2024 02:09, Atish Patra wrote:
> > Signed-off-by: Atish Patra <atishp@rivosinc.com>
> > ---
> >   target/riscv/cpu.h | 25 +++++++++++++++++++++++++
> >   1 file changed, 25 insertions(+)
> >
> > diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> > index 2ac391a7cf74..53426710f73e 100644
> > --- a/target/riscv/cpu.h
> > +++ b/target/riscv/cpu.h
> > @@ -189,6 +189,28 @@ typedef struct PMUFixedCtrState {
> >           uint64_t counter_virt_prev[2];
> >   } PMUFixedCtrState;
> >
> > +typedef uint64_t (*PMU_EVENT_CYCLE_FUNC)(RISCVCPU *);
> > +typedef uint64_t (*PMU_EVENT_INSTRET_FUNC)(RISCVCPU *);
> > +typedef uint64_t (*PMU_EVENT_TLB_FUNC)(RISCVCPU *, MMUAccessType acces=
s_type);
> > +
> > +typedef struct PMUEventInfo {
> > +    /* Event ID (BIT [0:55] valid) */
> > +    uint64_t event_id;
> > +    /* Supported hpmcounters for this event */
> > +    uint32_t counter_mask;
> > +    /* Bitmask of valid event bits */
> > +    uint64_t event_mask;
> > +} PMUEventInfo;
> > +
> > +typedef struct PMUEventFunc {
> > +    /* Get the ID of the event that can monitor cycles */
> > +    PMU_EVENT_CYCLE_FUNC get_cycle_id;
> > +    /* Get the ID of the event that can monitor cycles */
> > +    PMU_EVENT_INSTRET_FUNC get_intstret_id;
> > +    /* Get the ID of the event that can monitor TLB events*/
> > +    PMU_EVENT_TLB_FUNC get_tlb_access_id;
> Ok, this is kinda interesting decision, but it's not scalable. AFAIU

Yes it is not scalable if there is a need to scale as mentioned earlier.
Do you have any other events that can be emulated in Qemu ?

Having said that, I am okay with single call back though but not too sure
about read/write callback unless there is a use case to support those.

> none spec provide us full enum of existing events. So anytime when
> somebody will try to implement their own pmu events they would have to
> add additional callbacks, and this structure never will be fulled
> properly. And then we ended up with structure 1000+ callback with only 5
> machines wich supports pmu events. I suggest my approach with only
> read/write callbacks, where machine can decide by itself how to handle
> any of machine specific events.

Lot of these events are microarchitectural events which can't be
supported in Qemu.
I don't think it's a good idea at all to add dummy values for all the
events defined in a platform
which is harder to debug for a user.


> > +} PMUEventFunc;
> > +
> >   struct CPUArchState {
> >       target_ulong gpr[32];
> >       target_ulong gprh[32]; /* 64 top bits of the 128-bit registers */
> > @@ -386,6 +408,9 @@ struct CPUArchState {
> >       target_ulong mhpmeventh_val[RV_MAX_MHPMEVENTS];
> >
> >       PMUFixedCtrState pmu_fixed_ctrs[2];
> > +    PMUEventInfo *pmu_events;
> > +    PMUEventFunc pmu_efuncs;
> > +    int num_pmu_events;
> >
> >       target_ulong sscratch;
> >       target_ulong mscratch;
> >

