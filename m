Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26931C5B543
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Jun 2025 06:39:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uN4Fz-0002CE-Kh; Thu, 05 Jun 2025 02:39:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uN4Fu-0002BL-1u; Thu, 05 Jun 2025 02:39:14 -0400
Received: from mail-vk1-xa32.google.com ([2607:f8b0:4864:20::a32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uN4Fq-0005qW-Az; Thu, 05 Jun 2025 02:39:13 -0400
Received: by mail-vk1-xa32.google.com with SMTP id
 71dfb90a1353d-530807a8691so246148e0c.0; 
 Wed, 04 Jun 2025 23:39:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1749105549; x=1749710349; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7lD51IvUGeI3qac2jGaXlYB/6ppbHYanEuqXorGeXMo=;
 b=LBtQIvJUgSaDnuPpaCKOqrCFuD1p1b15Q1/bVcp0y2m8nvQoUjDPat7zo3Z9meD1Ik
 ZGAJrhFPDHRimhsiDHy7oOwugrentnA/FQjQ7tDcuLy5x18mxkqwlNgFkLFrUmzDppvy
 a4qxov3iUKBesCf8umPVVzcxNyrA54pPqCeeuxhta/u5Vz9SVkvpKg4RuUspK8RLugdj
 c1GtHVicPHxwgylX+q2SWYysa9Bg0/zUGhXtFtX+Pdvjc8IHR9zYVDKgSQA8dmJ3OIia
 LjNh3LnUFbSR1mMsXIOECfUHz8FLFXZwERzqwtx4YPqe410fAgLmjV5Ex4mO9VRuy0NQ
 YKug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749105549; x=1749710349;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7lD51IvUGeI3qac2jGaXlYB/6ppbHYanEuqXorGeXMo=;
 b=fpeRYyNfBs5YgKF2kzWeiyHLa/nwZxgCSkbQxZFOCoZ/FTdxAlIVr9b2xm3IKO8gVa
 LjxkttYUl4SD6uL/KvXtdDOeZO6hYvpF90+sCB10GFsZGH5Ka7q4IU5cQd4EMke0m4CW
 YloPkOczSuXkLCbCaGH0ejQXNzAH9OhF9/nuHcPA10S7JXZ8ir9m7IpyMT/Ss5UApmN9
 DiYiDpTBcOKo13n4/XfNl055xiOHAwS1QKWhzVCE+wiQ7A9PlazVyjCuY5iAt/vzYk+E
 Lv2pJigBox8mmUPit68D1JZNjb47ViD2LDXjD5ZfXcUWyqxGFPZ0vzY2EM+Vp7vuWGLa
 LkjA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUPIF4kcM8r/0IUZkZ/CYjh7ygJ65ydRYhnot4nBUdv2Uqy2wcs2puViFe+ER9HBvjn1mFPPwHRUZbbpg==@nongnu.org,
 AJvYcCVFdQ+VTm1okUesAbA/YZ7T54MRNKqZz2WznWGYG+g0ekkKqDWe+7Cijrc58EMUr50USZNztIJBzQfy@nongnu.org
X-Gm-Message-State: AOJu0Yx/yW7X9YoiH/GFLfhyJNm9Splmz+0oUbe82CAJZYIU8i3ORqjr
 UrB2J0CX6PfbKzYkt1N4RUxjKjTB1MH7vu4bmvteQHRGCYvhPvdFqcsDWYT/XbyD00eQVycrmS6
 2K75x5M9hMuZENiaRzcCHZQXXOmuzAwyMog==
X-Gm-Gg: ASbGncswpjPWEb/X5gBkvlrtIjuiodQ818274eujK8qv0K0GQITzsWfFugeesHLj6QI
 h8LWg5Q+b/l6IrQYGk0toTiQ55KJZ5XUy78EQjYVLN33omDT0scqF4VTvpCOvCEmYPG6BWsVfdG
 FFe8TYY2Rvh8pEJTq7XWSED4iiBf8lSjfe2xFsON7Xejh9vSOvJrV6Ea9I6ALhegQ=
X-Google-Smtp-Source: AGHT+IETXUKU4WiMlM78u0wOJMYA6ow2yZGflyf7awGFCCMHqQ5ZWF3knhr99d1dhzWqngQVp7+RAOBuvcDkQXkMVPs=
X-Received: by 2002:a05:6122:250a:b0:530:81ac:51be with SMTP id
 71dfb90a1353d-530c7366333mr4907934e0c.8.1749105548493; Wed, 04 Jun 2025
 23:39:08 -0700 (PDT)
MIME-Version: 1.0
References: <20250522081236.4050-1-jay.chang@sifive.com>
 <20250522081236.4050-3-jay.chang@sifive.com>
 <14110641-4610-4f44-b192-2fd35f302e15@ventanamicro.com>
 <CACNNAjNrm77bB48jhR=u00BB9C9=MJ+NJK_fVH5uSLhWHVxbrA@mail.gmail.com>
In-Reply-To: <CACNNAjNrm77bB48jhR=u00BB9C9=MJ+NJK_fVH5uSLhWHVxbrA@mail.gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 5 Jun 2025 16:38:42 +1000
X-Gm-Features: AX0GCFuwhWf2gHE2c3J7Ib2Dr5PCplxVjDFTHKF25rPZBRs06R2kUNhGWJnt-SI
Message-ID: <CAKmqyKPEdEgWZSH7b1KSOUKt9VpPzkCad5bdpnSHw__9RVwjQw@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] target/riscv: Make PMP region count configurable
To: Jay Chang <jay.chang@sifive.com>
Cc: Daniel Henrique Barboza <dbarboza@ventanamicro.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Frank Chang <frank.chang@sifive.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a32;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa32.google.com
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

On Thu, Jun 5, 2025 at 3:34=E2=80=AFPM Jay Chang <jay.chang@sifive.com> wro=
te:
>
> Hi Daniel,
>
> You're absolutely right =E2=80=94 thanks for pointing it out and providin=
g the fix!
>
> Would you like me to send out a v5 patch incorporating your changes?

Yes please

Alistair

>
>
> Best Regards
> Jay Chang
>
>
> On Thu, Jun 5, 2025 at 2:20=E2=80=AFAM Daniel Henrique Barboza <dbarboza@=
ventanamicro.com> wrote:
>>
>> It seems like this patch is breaking 'make check-functional':
>>
>>
>> >>> UBSAN_OPTIONS=3Dhalt_on_error=3D1:abort_on_error=3D1:print_summary=
=3D1:print_stacktrace=3D1 RUST_BACKTRACE=3D1 LD_LIBRARY_PATH=3D/home/daniel=
hb/work/qemu/build/contrib/plugins:/home/danielhb/work/qemu/build/tests/tcg=
/plugins MSAN_OPTIONS=3Dhalt_on_error=3D1:abort_on_error=3D1:print_summary=
=3D1:print_stacktrace=3D1 QEMU_BUILD_ROOT=3D/home/danielhb/work/qemu/build =
QEMU_TEST_QEMU_IMG=3D/home/danielhb/work/qemu/build/qemu-img PYTHONPATH=3D/=
home/danielhb/work/qemu/python:/home/danielhb/work/qemu/tests/functional G_=
TEST_SLOW=3D1 ASAN_OPTIONS=3Dhalt_on_error=3D1:abort_on_error=3D1:print_sum=
mary=3D1 MALLOC_PERTURB_=3D229 MESON_TEST_ITERATION=3D1 QEMU_TEST_QEMU_BINA=
RY=3D/home/danielhb/work/qemu/build/qemu-system-riscv64 /home/danielhb/work=
/qemu/build/pyvenv/bin/python3 /home/danielhb/work/qemu/tests/functional/te=
st_riscv64_tuxrun.py
>>
>>
>> Summary of Failures:
>>
>> 11/12 qemu:func-thorough+func-riscv32-thorough+thorough / func-riscv32-r=
iscv32_tuxrun TIMEOUT         90.02s   killed by signal 15 SIGTERM
>> 12/12 qemu:func-thorough+func-riscv64-thorough+thorough / func-riscv64-r=
iscv64_tuxrun TIMEOUT        120.13s   killed by signal 15 SIGTERM
>>
>>
>>
>> Going through the code:
>>
>>
>>
>> On 5/22/25 5:12 AM, Jay Chang wrote:
>> > Previously, the number of PMP regions was hardcoded to 16 in QEMU.
>> > This patch replaces the fixed value with a new `pmp_regions` field,
>> > allowing platforms to configure the number of PMP regions.
>> >
>> > If no specific value is provided, the default number of PMP regions
>> > remains 16 to preserve the existing behavior.
>> >
>> > A new CPU parameter num-pmp-regions has been introduced to the QEMU
>> > command line. For example:
>> >
>> >       -cpu rv64, g=3Dtrue, c=3Dtrue, pmp=3Dtrue, num-pmp-regions=3D8
>> >
>> > Signed-off-by: Jay Chang <jay.chang@sifive.com>
>> > Reviewed-by: Frank Chang <frank.chang@sifive.com>
>> > ---
>> >   target/riscv/cpu.c                | 54 +++++++++++++++++++++++++++++=
--
>> >   target/riscv/cpu.h                |  3 +-
>> >   target/riscv/cpu_cfg_fields.h.inc |  1 +
>> >   target/riscv/csr.c                |  5 ++-
>> >   target/riscv/machine.c            |  3 +-
>> >   target/riscv/pmp.c                | 28 ++++++++++------
>> >   6 files changed, 80 insertions(+), 14 deletions(-)
>> >
>> > diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
>> > index 629ac37501..8e32252c11 100644
>> > --- a/target/riscv/cpu.c
>> > +++ b/target/riscv/cpu.c
>> > @@ -1117,6 +1117,7 @@ static void riscv_cpu_init(Object *obj)
>> >       cpu->cfg.cbom_blocksize =3D 64;
>> >       cpu->cfg.cbop_blocksize =3D 64;
>> >       cpu->cfg.cboz_blocksize =3D 64;
>> > +    cpu->cfg.pmp_regions =3D 16;
>>
>> pmp_regions is set to 16 in the base class, which is what we want to kee=
p
>> the default intact. But then:
>>
>> >       cpu->env.vext_ver =3D VEXT_VERSION_1_00_0;
>> >       cpu->cfg.max_satp_mode =3D -1;
>> >
>> > @@ -1568,6 +1569,46 @@ static const PropertyInfo prop_pmp =3D {
>> >       .set =3D prop_pmp_set,
>> >   };
>> >
>> > +static void prop_num_pmp_regions_set(Object *obj, Visitor *v, const c=
har *name,
>> > +                                     void *opaque, Error **errp)
>> > +{
>> > +    RISCVCPU *cpu =3D RISCV_CPU(obj);
>> > +    uint8_t value;
>> > +
>> > +    visit_type_uint8(v, name, &value, errp);
>> > +
>> > +    if (cpu->cfg.pmp_regions !=3D value && riscv_cpu_is_vendor(obj)) =
{
>> > +        cpu_set_prop_err(cpu, name, errp);
>> > +        return;
>> > +    }
>> > +
>> > +    if (cpu->env.priv_ver < PRIV_VERSION_1_12_0 && value > OLD_MAX_RI=
SCV_PMPS) {
>> > +        error_setg(errp, "Number of PMP regions exceeds maximum avail=
able");
>> > +        return;
>> > +    } else if (value > MAX_RISCV_PMPS) {
>> > +        error_setg(errp, "Number of PMP regions exceeds maximum avail=
able");
>> > +        return;
>> > +    }
>> > +
>> > +    cpu_option_add_user_setting(name, value);
>> > +    cpu->cfg.pmp_regions =3D value;
>> > +}
>> > +
>> > +static void prop_num_pmp_regions_get(Object *obj, Visitor *v, const c=
har *name,
>> > +                                     void *opaque, Error **errp)
>> > +{
>> > +    uint8_t value =3D RISCV_CPU(obj)->cfg.pmp_regions;
>> > +
>> > +    visit_type_uint8(v, name, &value, errp);
>> > +}
>> > +
>> > +static const PropertyInfo prop_num_pmp_regions =3D {
>> > +    .type =3D "uint8",
>> > +    .description =3D "num-pmp-regions",
>> > +    .get =3D prop_num_pmp_regions_get,
>> > +    .set =3D prop_num_pmp_regions_set,
>> > +};
>> > +
>> >   static int priv_spec_from_str(const char *priv_spec_str)
>> >   {
>> >       int priv_version =3D -1;
>> > @@ -2567,6 +2608,7 @@ static const Property riscv_cpu_properties[] =3D=
 {
>> >
>> >       {.name =3D "mmu", .info =3D &prop_mmu},
>> >       {.name =3D "pmp", .info =3D &prop_pmp},
>> > +    {.name =3D "num-pmp-regions", .info =3D &prop_num_pmp_regions},
>> >
>> >       {.name =3D "priv_spec", .info =3D &prop_priv_spec},
>> >       {.name =3D "vext_spec", .info =3D &prop_vext_spec},
>> > @@ -2891,6 +2933,7 @@ static const TypeInfo riscv_cpu_type_infos[] =3D=
 {
>> >       DEFINE_ABSTRACT_RISCV_CPU(TYPE_RISCV_DYNAMIC_CPU, TYPE_RISCV_CPU=
,
>> >           .cfg.mmu =3D true,
>> >           .cfg.pmp =3D true,
>> > +        .cfg.pmp_regions =3D 8,
>> >           .priv_spec =3D PRIV_VERSION_LATEST,
>> >       ),
>> >
>> > @@ -2937,7 +2980,8 @@ static const TypeInfo riscv_cpu_type_infos[] =3D=
 {
>> >           .cfg.max_satp_mode =3D VM_1_10_MBARE,
>> >           .cfg.ext_zifencei =3D true,
>> >           .cfg.ext_zicsr =3D true,
>> > -        .cfg.pmp =3D true
>> > +        .cfg.pmp =3D true,
>> > +        .cfg.pmp_regions =3D 8
>>
>> We can't set pmp_regions =3D 8 in the CPU definitions too. This will ove=
rwrite the
>> pmp_regions =3D 16 from the parent object. In short, we're changing the =
default
>> val for a lot of CPUs.
>>
>> This diff fixes the test:
>>
>> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
>> index d49c02dfe4..b84f08e582 100644
>> --- a/target/riscv/cpu.c
>> +++ b/target/riscv/cpu.c
>> @@ -2933,7 +2933,6 @@ static const TypeInfo riscv_cpu_type_infos[] =3D {
>>       DEFINE_ABSTRACT_RISCV_CPU(TYPE_RISCV_DYNAMIC_CPU, TYPE_RISCV_CPU,
>>           .cfg.mmu =3D true,
>>           .cfg.pmp =3D true,
>> -        .cfg.pmp_regions =3D 8,
>>           .priv_spec =3D PRIV_VERSION_LATEST,
>>       ),
>>
>> @@ -3011,7 +3010,6 @@ static const TypeInfo riscv_cpu_type_infos[] =3D {
>>           .cfg.ext_zifencei =3D true,
>>           .cfg.ext_zicsr =3D true,
>>           .cfg.pmp =3D true,
>> -        .cfg.pmp_regions =3D 8,
>>           .cfg.ext_smepmp =3D true,
>>
>>           .cfg.ext_zba =3D true,
>> @@ -3086,7 +3084,6 @@ static const TypeInfo riscv_cpu_type_infos[] =3D {
>>           .cfg.ext_xtheadmempair =3D true,
>>           .cfg.ext_xtheadsync =3D true,
>>           .cfg.pmp =3D true,
>> -        .cfg.pmp_regions =3D 8,
>>
>>           .cfg.mvendorid =3D THEAD_VENDOR_ID,
>>
>> @@ -3110,7 +3107,6 @@ static const TypeInfo riscv_cpu_type_infos[] =3D {
>>           .cfg.rvv_ta_all_1s =3D true,
>>           .cfg.misa_w =3D true,
>>           .cfg.pmp =3D true,
>> -        .cfg.pmp_regions =3D 8,
>>           .cfg.cbom_blocksize =3D 64,
>>           .cfg.cbop_blocksize =3D 64,
>>           .cfg.cboz_blocksize =3D 64,
>> @@ -3167,7 +3163,6 @@ static const TypeInfo riscv_cpu_type_infos[] =3D {
>>           .cfg.ext_zifencei =3D true,
>>           .cfg.ext_zicsr =3D true,
>>           .cfg.pmp =3D true,
>> -        .cfg.pmp_regions =3D 8,
>>           .cfg.ext_zicbom =3D true,
>>           .cfg.cbom_blocksize =3D 64,
>>           .cfg.cboz_blocksize =3D 64,
>> @@ -3212,7 +3207,6 @@ static const TypeInfo riscv_cpu_type_infos[] =3D {
>>
>>           .cfg.mmu =3D true,
>>           .cfg.pmp =3D true,
>> -        .cfg.pmp_regions =3D 8,
>>
>>           .cfg.max_satp_mode =3D VM_1_10_SV39,
>>       ),
>>
>>
>> I removed all "pmp_regions =3D 8" assignments but the Si-five ones. The =
generic
>> CPUs should retain the default pmp regions value, and every other vendor=
 CPU
>> should set its own default if they want.
>>
>>
>> Thanks,
>>
>> Daniel
>>
>> >       ),
>> >
>> >       DEFINE_ABSTRACT_RISCV_CPU(TYPE_RISCV_CPU_SIFIVE_U, TYPE_RISCV_VE=
NDOR_CPU,
>> > @@ -2948,7 +2992,8 @@ static const TypeInfo riscv_cpu_type_infos[] =3D=
 {
>> >           .cfg.ext_zifencei =3D true,
>> >           .cfg.ext_zicsr =3D true,
>> >           .cfg.mmu =3D true,
>> > -        .cfg.pmp =3D true
>> > +        .cfg.pmp =3D true,
>> > +        .cfg.pmp_regions =3D 8
>> >       ),
>> >
>> >   #if defined(TARGET_RISCV32) || \
>> > @@ -2966,6 +3011,7 @@ static const TypeInfo riscv_cpu_type_infos[] =3D=
 {
>> >           .cfg.ext_zifencei =3D true,
>> >           .cfg.ext_zicsr =3D true,
>> >           .cfg.pmp =3D true,
>> > +        .cfg.pmp_regions =3D 8,
>> >           .cfg.ext_smepmp =3D true,
>> >
>> >           .cfg.ext_zba =3D true,
>> > @@ -3040,6 +3086,7 @@ static const TypeInfo riscv_cpu_type_infos[] =3D=
 {
>> >           .cfg.ext_xtheadmempair =3D true,
>> >           .cfg.ext_xtheadsync =3D true,
>> >           .cfg.pmp =3D true,
>> > +        .cfg.pmp_regions =3D 8,
>> >
>> >           .cfg.mvendorid =3D THEAD_VENDOR_ID,
>> >
>> > @@ -3063,6 +3110,7 @@ static const TypeInfo riscv_cpu_type_infos[] =3D=
 {
>> >           .cfg.rvv_ta_all_1s =3D true,
>> >           .cfg.misa_w =3D true,
>> >           .cfg.pmp =3D true,
>> > +        .cfg.pmp_regions =3D 8,
>> >           .cfg.cbom_blocksize =3D 64,
>> >           .cfg.cbop_blocksize =3D 64,
>> >           .cfg.cboz_blocksize =3D 64,
>> > @@ -3119,6 +3167,7 @@ static const TypeInfo riscv_cpu_type_infos[] =3D=
 {
>> >           .cfg.ext_zifencei =3D true,
>> >           .cfg.ext_zicsr =3D true,
>> >           .cfg.pmp =3D true,
>> > +        .cfg.pmp_regions =3D 8,
>> >           .cfg.ext_zicbom =3D true,
>> >           .cfg.cbom_blocksize =3D 64,
>> >           .cfg.cboz_blocksize =3D 64,
>> > @@ -3163,6 +3212,7 @@ static const TypeInfo riscv_cpu_type_infos[] =3D=
 {
>> >
>> >           .cfg.mmu =3D true,
>> >           .cfg.pmp =3D true,
>> > +        .cfg.pmp_regions =3D 8,
>> >
>> >           .cfg.max_satp_mode =3D VM_1_10_SV39,
>> >       ),
>> > diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
>> > index 229ade9ed9..67323a7d9d 100644
>> > --- a/target/riscv/cpu.h
>> > +++ b/target/riscv/cpu.h
>> > @@ -159,7 +159,8 @@ extern RISCVCPUImpliedExtsRule *riscv_multi_ext_im=
plied_rules[];
>> >
>> >   #define MMU_USER_IDX 3
>> >
>> > -#define MAX_RISCV_PMPS (16)
>> > +#define MAX_RISCV_PMPS (64)
>> > +#define OLD_MAX_RISCV_PMPS (16)
>> >
>> >   #if !defined(CONFIG_USER_ONLY)
>> >   #include "pmp.h"
>> > diff --git a/target/riscv/cpu_cfg_fields.h.inc b/target/riscv/cpu_cfg_=
fields.h.inc
>> > index 59f134a419..33c4f9bac8 100644
>> > --- a/target/riscv/cpu_cfg_fields.h.inc
>> > +++ b/target/riscv/cpu_cfg_fields.h.inc
>> > @@ -163,6 +163,7 @@ TYPED_FIELD(uint16_t, elen, 0)
>> >   TYPED_FIELD(uint16_t, cbom_blocksize, 0)
>> >   TYPED_FIELD(uint16_t, cbop_blocksize, 0)
>> >   TYPED_FIELD(uint16_t, cboz_blocksize, 0)
>> > +TYPED_FIELD(uint8_t,  pmp_regions, 0)
>> >
>> >   TYPED_FIELD(int8_t, max_satp_mode, -1)
>> >
>> > diff --git a/target/riscv/csr.c b/target/riscv/csr.c
>> > index d6cd441133..6296ecd1e1 100644
>> > --- a/target/riscv/csr.c
>> > +++ b/target/riscv/csr.c
>> > @@ -738,7 +738,10 @@ static RISCVException dbltrp_hmode(CPURISCVState =
*env, int csrno)
>> >   static RISCVException pmp(CPURISCVState *env, int csrno)
>> >   {
>> >       if (riscv_cpu_cfg(env)->pmp) {
>> > -        if (csrno <=3D CSR_PMPCFG3) {
>> > +        int max_pmpcfg =3D (env->priv_ver >=3D PRIV_VERSION_1_12_0) ?
>> > ++                              CSR_PMPCFG15 : CSR_PMPCFG3;
>> > +
>> > +        if (csrno <=3D max_pmpcfg) {
>> >               uint32_t reg_index =3D csrno - CSR_PMPCFG0;
>> >
>> >               /* TODO: RV128 restriction check */
>> > diff --git a/target/riscv/machine.c b/target/riscv/machine.c
>> > index c97e9ce9df..1600ec44f0 100644
>> > --- a/target/riscv/machine.c
>> > +++ b/target/riscv/machine.c
>> > @@ -36,8 +36,9 @@ static int pmp_post_load(void *opaque, int version_i=
d)
>> >       RISCVCPU *cpu =3D opaque;
>> >       CPURISCVState *env =3D &cpu->env;
>> >       int i;
>> > +    uint8_t pmp_regions =3D riscv_cpu_cfg(env)->pmp_regions;
>> >
>> > -    for (i =3D 0; i < MAX_RISCV_PMPS; i++) {
>> > +    for (i =3D 0; i < pmp_regions; i++) {
>> >           pmp_update_rule_addr(env, i);
>> >       }
>> >       pmp_update_rule_nums(env);
>> > diff --git a/target/riscv/pmp.c b/target/riscv/pmp.c
>> > index 5af295e410..3540327c9a 100644
>> > --- a/target/riscv/pmp.c
>> > +++ b/target/riscv/pmp.c
>> > @@ -122,7 +122,9 @@ uint32_t pmp_get_num_rules(CPURISCVState *env)
>> >    */
>> >   static inline uint8_t pmp_read_cfg(CPURISCVState *env, uint32_t pmp_=
index)
>> >   {
>> > -    if (pmp_index < MAX_RISCV_PMPS) {
>> > +    uint8_t pmp_regions =3D riscv_cpu_cfg(env)->pmp_regions;
>> > +
>> > +    if (pmp_index < pmp_regions) {
>> >           return env->pmp_state.pmp[pmp_index].cfg_reg;
>> >       }
>> >
>> > @@ -136,7 +138,9 @@ static inline uint8_t pmp_read_cfg(CPURISCVState *=
env, uint32_t pmp_index)
>> >    */
>> >   static bool pmp_write_cfg(CPURISCVState *env, uint32_t pmp_index, ui=
nt8_t val)
>> >   {
>> > -    if (pmp_index < MAX_RISCV_PMPS) {
>> > +    uint8_t pmp_regions =3D riscv_cpu_cfg(env)->pmp_regions;
>> > +
>> > +    if (pmp_index < pmp_regions) {
>> >           if (env->pmp_state.pmp[pmp_index].cfg_reg =3D=3D val) {
>> >               /* no change */
>> >               return false;
>> > @@ -236,9 +240,10 @@ void pmp_update_rule_addr(CPURISCVState *env, uin=
t32_t pmp_index)
>> >   void pmp_update_rule_nums(CPURISCVState *env)
>> >   {
>> >       int i;
>> > +    uint8_t pmp_regions =3D riscv_cpu_cfg(env)->pmp_regions;
>> >
>> >       env->pmp_state.num_rules =3D 0;
>> > -    for (i =3D 0; i < MAX_RISCV_PMPS; i++) {
>> > +    for (i =3D 0; i < pmp_regions; i++) {
>> >           const uint8_t a_field =3D
>> >               pmp_get_a_field(env->pmp_state.pmp[i].cfg_reg);
>> >           if (PMP_AMATCH_OFF !=3D a_field) {
>> > @@ -332,6 +337,7 @@ bool pmp_hart_has_privs(CPURISCVState *env, hwaddr=
 addr,
>> >       int pmp_size =3D 0;
>> >       hwaddr s =3D 0;
>> >       hwaddr e =3D 0;
>> > +    uint8_t pmp_regions =3D riscv_cpu_cfg(env)->pmp_regions;
>> >
>> >       /* Short cut if no rules */
>> >       if (0 =3D=3D pmp_get_num_rules(env)) {
>> > @@ -356,7 +362,7 @@ bool pmp_hart_has_privs(CPURISCVState *env, hwaddr=
 addr,
>> >        * 1.10 draft priv spec states there is an implicit order
>> >        * from low to high
>> >        */
>> > -    for (i =3D 0; i < MAX_RISCV_PMPS; i++) {
>> > +    for (i =3D 0; i < pmp_regions; i++) {
>> >           s =3D pmp_is_in_range(env, i, addr);
>> >           e =3D pmp_is_in_range(env, i, addr + pmp_size - 1);
>> >
>> > @@ -527,8 +533,9 @@ void pmpaddr_csr_write(CPURISCVState *env, uint32_=
t addr_index,
>> >   {
>> >       trace_pmpaddr_csr_write(env->mhartid, addr_index, val);
>> >       bool is_next_cfg_tor =3D false;
>> > +    uint8_t pmp_regions =3D riscv_cpu_cfg(env)->pmp_regions;
>> >
>> > -    if (addr_index < MAX_RISCV_PMPS) {
>> > +    if (addr_index < pmp_regions) {
>> >           if (env->pmp_state.pmp[addr_index].addr_reg =3D=3D val) {
>> >               /* no change */
>> >               return;
>> > @@ -538,7 +545,7 @@ void pmpaddr_csr_write(CPURISCVState *env, uint32_=
t addr_index,
>> >            * In TOR mode, need to check the lock bit of the next pmp
>> >            * (if there is a next).
>> >            */
>> > -        if (addr_index + 1 < MAX_RISCV_PMPS) {
>> > +        if (addr_index + 1 < pmp_regions) {
>> >               uint8_t pmp_cfg =3D env->pmp_state.pmp[addr_index + 1].c=
fg_reg;
>> >               is_next_cfg_tor =3D PMP_AMATCH_TOR =3D=3D pmp_get_a_fiel=
d(pmp_cfg);
>> >
>> > @@ -573,8 +580,9 @@ void pmpaddr_csr_write(CPURISCVState *env, uint32_=
t addr_index,
>> >   target_ulong pmpaddr_csr_read(CPURISCVState *env, uint32_t addr_inde=
x)
>> >   {
>> >       target_ulong val =3D 0;
>> > +    uint8_t pmp_regions =3D riscv_cpu_cfg(env)->pmp_regions;
>> >
>> > -    if (addr_index < MAX_RISCV_PMPS) {
>> > +    if (addr_index < pmp_regions) {
>> >           val =3D env->pmp_state.pmp[addr_index].addr_reg;
>> >           trace_pmpaddr_csr_read(env->mhartid, addr_index, val);
>> >       } else {
>> > @@ -592,6 +600,7 @@ void mseccfg_csr_write(CPURISCVState *env, target_=
ulong val)
>> >   {
>> >       int i;
>> >       uint64_t mask =3D MSECCFG_MMWP | MSECCFG_MML;
>> > +    uint8_t pmp_regions =3D riscv_cpu_cfg(env)->pmp_regions;
>> >       /* Update PMM field only if the value is valid according to Zjpm=
 v1.0 */
>> >       if (riscv_cpu_cfg(env)->ext_smmpm &&
>> >           riscv_cpu_mxl(env) =3D=3D MXL_RV64 &&
>> > @@ -603,7 +612,7 @@ void mseccfg_csr_write(CPURISCVState *env, target_=
ulong val)
>> >
>> >       /* RLB cannot be enabled if it's already 0 and if any regions ar=
e locked */
>> >       if (!MSECCFG_RLB_ISSET(env)) {
>> > -        for (i =3D 0; i < MAX_RISCV_PMPS; i++) {
>> > +        for (i =3D 0; i < pmp_regions; i++) {
>> >               if (pmp_is_locked(env, i)) {
>> >                   val &=3D ~MSECCFG_RLB;
>> >                   break;
>> > @@ -659,6 +668,7 @@ target_ulong pmp_get_tlb_size(CPURISCVState *env, =
hwaddr addr)
>> >       hwaddr tlb_sa =3D addr & ~(TARGET_PAGE_SIZE - 1);
>> >       hwaddr tlb_ea =3D tlb_sa + TARGET_PAGE_SIZE - 1;
>> >       int i;
>> > +    uint8_t pmp_regions =3D riscv_cpu_cfg(env)->pmp_regions;
>> >
>> >       /*
>> >        * If PMP is not supported or there are no PMP rules, the TLB pa=
ge will not
>> > @@ -669,7 +679,7 @@ target_ulong pmp_get_tlb_size(CPURISCVState *env, =
hwaddr addr)
>> >           return TARGET_PAGE_SIZE;
>> >       }
>> >
>> > -    for (i =3D 0; i < MAX_RISCV_PMPS; i++) {
>> > +    for (i =3D 0; i < pmp_regions; i++) {
>> >           if (pmp_get_a_field(env->pmp_state.pmp[i].cfg_reg) =3D=3D PM=
P_AMATCH_OFF) {
>> >               continue;
>> >           }
>>

