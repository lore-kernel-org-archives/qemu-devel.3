Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58B26C61DD3
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2026 03:10:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1bLq-0001KA-BG; Tue, 01 Sep 2026 23:09:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prcups@krgm.moe>) id 1x1bLo-0001Jm-Ed
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 23:09:24 -0400
Received: from krgm.moe ([103.47.186.116])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prcups@krgm.moe>) id 1x1bLl-0005Z4-Jp
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 23:09:23 -0400
Received: from yuno-loong.localnet (unknown [103.47.186.116])
 by krgm.moe (Postfix) with ESMTPSA id A6405DFA5;
 Wed, 02 Sep 2026 08:39:13 +0530 (IST)
From: SignKirigami <prcups@krgm.moe>
To: Bibo Mao <maobibo@loongson.cn>, qemu-devel@nongnu.org
Cc: xianglai li <lixianglai@loongson.cn>,
 Hengyu Yu <yuhengyu25@mails.ucas.ac.cn>
Subject: Re: [PATCH v4 03/14] target/loongarch: Add LVZ CSR metadata
Date: Wed, 02 Sep 2026 11:09:10 +0800
Message-ID: <uxrjBmMGQxybFt1E_UoFpA@krgm.moe>
In-Reply-To: <24a8e1b0-c986-367e-fbb9-9a6f53f0a4f6@loongson.cn>
References: <cover.1787739852.git.prcups@krgm.moe>
 <2c261c4b32b901a077952757d7228570a822e592.1787739852.git.prcups@krgm.moe>
 <24a8e1b0-c986-367e-fbb9-9a6f53f0a4f6@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
Received-SPF: pass client-ip=103.47.186.116; envelope-from=prcups@krgm.moe;
 helo=krgm.moe
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, UPPERCASE_50_75=0.008 autolearn=no autolearn_force=no
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



=E4=BA=8E 2026=E5=B9=B49=E6=9C=881=E6=97=A5 GMT+08:00 15:08:59=EF=BC=8CBibo=
 Mao <maobibo@loongson.cn> =E5=86=99=E9=81=93=EF=BC=9A
>
>
>On 2026/8/26 =E4=B8=8B=E5=8D=886:30, SignKirigami wrote:
>> Add LVZ host and guest CSR access metadata to the existing CSR table. Ke=
ep
>> one shared register description and calculate the host or guest bank
>> offset at translation time instead of duplicating CSRInfo entries.
>>=20
>> Mark guest read-only, sensitive and unavailable CSRs for later LVZ
>> instruction translation.
>>=20
>> Signed-off-by: SignKirigami <prcups@krgm.moe>
>> Signed-off-by: Hengyu Yu <yuhengyu25@mails.ucas.ac.cn>
>> ---
>>   target/loongarch/cpu.c                        |   3 +-
>>   target/loongarch/csr.c                        | 108 +++++++++---------
>>   target/loongarch/csr.h                        |   2 +
>>   .../tcg/insn_trans/trans_extra.c.inc          |   2 +-
>>   .../tcg/insn_trans/trans_privileged.c.inc     |   6 +-
>>   5 files changed, 65 insertions(+), 56 deletions(-)
>>=20
>> diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
>> index 2f7692dc93..0f6a211949 100644
>> --- a/target/loongarch/cpu.c
>> +++ b/target/loongarch/cpu.c
>> @@ -783,7 +783,8 @@ static void loongarch_cpu_dump_csr(CPUState *cs, FIL=
E *f)
>>               qemu_fprintf(f, " CSR%03d:", col);
>>           }
>>   -        addr =3D (void *)env + get_csr_offset(csr_info, 0);
>> +        addr =3D (void *)env + get_csr_offset(csr_info,
>> +                                             LOONGARCH_VM_LEVEL_HOST);
>>           qemu_fprintf(f, " %s ", csr_info->name);
>>           len =3D strlen(csr_info->name);
>>           for (; len < 6; len++) {
>> diff --git a/target/loongarch/csr.c b/target/loongarch/csr.c
>> index 309b826ca9..fa018a4582 100644
>> --- a/target/loongarch/csr.c
>> +++ b/target/loongarch/csr.c
>> @@ -13,15 +13,16 @@
>>           .flags =3D FL, .readfn =3D RD, .writefn =3D WR           \
>>       }
>>   -#define CSR_OFF_ARRAY(NAME, N)                                \
>> +#define CSR_OFF_ARRAY_FLAGS(NAME, N, FL)                      \
>>       [LOONGARCH_CSR_##NAME(N)] =3D {                             \
>>           .name   =3D (stringify(NAME##N)),                       \
>>           .offset =3D CSR_OFFSET(CSR_##NAME[N]),                  \
>> -        .flags =3D CSRFL_BASIC, .readfn =3D NULL, .writefn =3D NULL    =
       \
>> +        .flags =3D FL                                           \
>>       }
>>     #define CSR_OFF_FLAGS(NAME, FL)   CSR_OFF_FUNCS(NAME, FL, NULL, NULL)
>>   #define CSR_OFF(NAME)             CSR_OFF_FLAGS(NAME, CSRFL_BASIC)
>> +#define CSR_OFF_ARRAY(NAME, N)    CSR_OFF_ARRAY_FLAGS(NAME, N, CSRFL_BA=
SIC)
>>     static CSRInfo csr_info[] =3D {
>>       CSR_OFF_FLAGS(CRMD, CSRFL_EXITTB),
>> @@ -35,6 +36,7 @@ static CSRInfo csr_info[] =3D {
>>       CSR_OFF_FLAGS(BADI, CSRFL_READONLY),
>>       CSR_OFF(EENTRY),
>>       CSR_OFF(TLBIDX),
>> +    CSR_OFF_FLAGS(GTLBC, CSRFL_GSPR),
>>       CSR_OFF(TLBEHI),
>>       CSR_OFF(TLBELO0),
>>       CSR_OFF(TLBELO1),
>> @@ -71,9 +73,13 @@ static CSRInfo csr_info[] =3D {
>>       CSR_OFF_FLAGS(TVAL, CSRFL_READONLY | CSRFL_IO),
>>       CSR_OFF(CNTC),
>>       CSR_OFF_FLAGS(TICLR, CSRFL_IO),
>Should previous CSR_OFF_FLAGS(GTLBC, CSRFL_GSPR) be moved to here? since a=
ll these registers relative with LVZ.
>> +    CSR_OFF_FLAGS(GSTAT, CSRFL_GSPR),
>> +    CSR_OFF_FLAGS(GCFG, CSRFL_GSPR),
>> +    CSR_OFF_FLAGS(GINTC, CSRFL_IO | CSRFL_GSPR),
>> +    CSR_OFF_FLAGS(GCNTC, CSRFL_GSPR),
>>       CSR_OFF(LLBCTL),
>> -    CSR_OFF(IMPCTL1),
>> -    CSR_OFF(IMPCTL2),
>> +    CSR_OFF_FLAGS(IMPCTL1, CSRFL_GSPR),
>> +    CSR_OFF_FLAGS(IMPCTL2, CSRFL_GSPR),
>It change the old flags, previous its flag is CSRFL_BASIC, and not it is r=
eplaced with CSRFL_GSPR. How about CSRFL_BASIC | CSRFL_GSPR and keep old fl=
ag still on?
CSRFL_BASIC is for "no flag but valid", as new get_csr sees csr_info with f=
lag 0 as invalid,
no other code uses this flag so it is ok to delete this flag when another f=
lag exists.

Regards
SignKirigami
>
>>       CSR_OFF(TLBRENTRY),
>>       CSR_OFF(TLBRBADV),
>>       CSR_OFF(TLBRERA),
>> @@ -82,57 +88,57 @@ static CSRInfo csr_info[] =3D {
>>       CSR_OFF(TLBRELO1),
>>       CSR_OFF(TLBREHI),
>>       CSR_OFF(TLBRPRMD),
>> -    CSR_OFF(MERRCTL),
>> -    CSR_OFF(MERRINFO1),
>> -    CSR_OFF(MERRINFO2),
>> -    CSR_OFF(MERRENTRY),
>> -    CSR_OFF(MERRERA),
>> -    CSR_OFF(MERRSAVE),
>> -    CSR_OFF(CTAG),
>> +    CSR_OFF_FLAGS(MERRCTL, CSRFL_GSPR),
>> +    CSR_OFF_FLAGS(MERRINFO1, CSRFL_GSPR),
>> +    CSR_OFF_FLAGS(MERRINFO2, CSRFL_GSPR),
>> +    CSR_OFF_FLAGS(MERRENTRY, CSRFL_GSPR),
>> +    CSR_OFF_FLAGS(MERRERA, CSRFL_GSPR),
>> +    CSR_OFF_FLAGS(MERRSAVE, CSRFL_GSPR),
>> +    CSR_OFF_FLAGS(CTAG, CSRFL_GSPR),
>>       CSR_OFF_ARRAY(DMW, 0),
>>       CSR_OFF_ARRAY(DMW, 1),
>>       CSR_OFF_ARRAY(DMW, 2),
>>       CSR_OFF_ARRAY(DMW, 3),
>> -    CSR_OFF_ARRAY(PERFCTRL, 0),
>> -    CSR_OFF_ARRAY(PERFCNTR, 0),
>> -    CSR_OFF_ARRAY(PERFCTRL, 1),
>> -    CSR_OFF_ARRAY(PERFCNTR, 1),
>> -    CSR_OFF_ARRAY(PERFCTRL, 2),
>> -    CSR_OFF_ARRAY(PERFCNTR, 2),
>> -    CSR_OFF_ARRAY(PERFCTRL, 3),
>> -    CSR_OFF_ARRAY(PERFCNTR, 3),
>> -    CSR_OFF_ARRAY(PERFCTRL, 4),
>> -    CSR_OFF_ARRAY(PERFCNTR, 4),
>> -    CSR_OFF_ARRAY(PERFCTRL, 5),
>> -    CSR_OFF_ARRAY(PERFCNTR, 5),
>> -    CSR_OFF_ARRAY(PERFCTRL, 6),
>> -    CSR_OFF_ARRAY(PERFCNTR, 6),
>> -    CSR_OFF_ARRAY(PERFCTRL, 7),
>> -    CSR_OFF_ARRAY(PERFCNTR, 7),
>> -    CSR_OFF_ARRAY(PERFCTRL, 8),
>> -    CSR_OFF_ARRAY(PERFCNTR, 8),
>> -    CSR_OFF_ARRAY(PERFCTRL, 9),
>> -    CSR_OFF_ARRAY(PERFCNTR, 9),
>> -    CSR_OFF_ARRAY(PERFCTRL, 10),
>> -    CSR_OFF_ARRAY(PERFCNTR, 10),
>> -    CSR_OFF_ARRAY(PERFCTRL, 11),
>> -    CSR_OFF_ARRAY(PERFCNTR, 11),
>> -    CSR_OFF_ARRAY(PERFCTRL, 12),
>> -    CSR_OFF_ARRAY(PERFCNTR, 12),
>> -    CSR_OFF_ARRAY(PERFCTRL, 13),
>> -    CSR_OFF_ARRAY(PERFCNTR, 13),
>> -    CSR_OFF_ARRAY(PERFCTRL, 14),
>> -    CSR_OFF_ARRAY(PERFCNTR, 14),
>> -    CSR_OFF_ARRAY(PERFCTRL, 15),
>> -    CSR_OFF_ARRAY(PERFCNTR, 15),
>> -    CSR_OFF(DBG),
>> -    CSR_OFF(DERA),
>> -    CSR_OFF(DSAVE),
>> -    CSR_OFF_ARRAY(MSGIS, 0),
>> -    CSR_OFF_ARRAY(MSGIS, 1),
>> -    CSR_OFF_ARRAY(MSGIS, 2),
>> -    CSR_OFF_ARRAY(MSGIS, 3),
>> -    CSR_OFF(MSGIR),
>> +    CSR_OFF_ARRAY_FLAGS(PERFCTRL, 0, CSRFL_GUEST_INVALID),
>what is different between flag CSRFL_GSPR and CSRFL_GUEST_INVALID?
>
>With CSR register access instruction, on host value zero is return if it i=
s not implemented. On guest mode, I think that there should be GSPR excepti=
on and trap to host and let hypervisor to handle this if it is not implemen=
ted. There is no much meaning to return zero and does not trap to host.
>
>> +    CSR_OFF_ARRAY_FLAGS(PERFCNTR, 0, CSRFL_GUEST_INVALID),
>> +    CSR_OFF_ARRAY_FLAGS(PERFCTRL, 1, CSRFL_GUEST_INVALID),
>> +    CSR_OFF_ARRAY_FLAGS(PERFCNTR, 1, CSRFL_GUEST_INVALID),
>> +    CSR_OFF_ARRAY_FLAGS(PERFCTRL, 2, CSRFL_GUEST_INVALID),
>> +    CSR_OFF_ARRAY_FLAGS(PERFCNTR, 2, CSRFL_GUEST_INVALID),
>> +    CSR_OFF_ARRAY_FLAGS(PERFCTRL, 3, CSRFL_GUEST_INVALID),
>> +    CSR_OFF_ARRAY_FLAGS(PERFCNTR, 3, CSRFL_GUEST_INVALID),
>> +    CSR_OFF_ARRAY_FLAGS(PERFCTRL, 4, CSRFL_GUEST_INVALID),
>> +    CSR_OFF_ARRAY_FLAGS(PERFCNTR, 4, CSRFL_GUEST_INVALID),
>> +    CSR_OFF_ARRAY_FLAGS(PERFCTRL, 5, CSRFL_GUEST_INVALID),
>> +    CSR_OFF_ARRAY_FLAGS(PERFCNTR, 5, CSRFL_GUEST_INVALID),
>> +    CSR_OFF_ARRAY_FLAGS(PERFCTRL, 6, CSRFL_GUEST_INVALID),
>> +    CSR_OFF_ARRAY_FLAGS(PERFCNTR, 6, CSRFL_GUEST_INVALID),
>> +    CSR_OFF_ARRAY_FLAGS(PERFCTRL, 7, CSRFL_GUEST_INVALID),
>> +    CSR_OFF_ARRAY_FLAGS(PERFCNTR, 7, CSRFL_GUEST_INVALID),
>> +    CSR_OFF_ARRAY_FLAGS(PERFCTRL, 8, CSRFL_GUEST_INVALID),
>> +    CSR_OFF_ARRAY_FLAGS(PERFCNTR, 8, CSRFL_GUEST_INVALID),
>> +    CSR_OFF_ARRAY_FLAGS(PERFCTRL, 9, CSRFL_GUEST_INVALID),
>> +    CSR_OFF_ARRAY_FLAGS(PERFCNTR, 9, CSRFL_GUEST_INVALID),
>> +    CSR_OFF_ARRAY_FLAGS(PERFCTRL, 10, CSRFL_GUEST_INVALID),
>> +    CSR_OFF_ARRAY_FLAGS(PERFCNTR, 10, CSRFL_GUEST_INVALID),
>> +    CSR_OFF_ARRAY_FLAGS(PERFCTRL, 11, CSRFL_GUEST_INVALID),
>> +    CSR_OFF_ARRAY_FLAGS(PERFCNTR, 11, CSRFL_GUEST_INVALID),
>> +    CSR_OFF_ARRAY_FLAGS(PERFCTRL, 12, CSRFL_GUEST_INVALID),
>> +    CSR_OFF_ARRAY_FLAGS(PERFCNTR, 12, CSRFL_GUEST_INVALID),
>> +    CSR_OFF_ARRAY_FLAGS(PERFCTRL, 13, CSRFL_GUEST_INVALID),
>> +    CSR_OFF_ARRAY_FLAGS(PERFCNTR, 13, CSRFL_GUEST_INVALID),
>> +    CSR_OFF_ARRAY_FLAGS(PERFCTRL, 14, CSRFL_GUEST_INVALID),
>> +    CSR_OFF_ARRAY_FLAGS(PERFCNTR, 14, CSRFL_GUEST_INVALID),
>> +    CSR_OFF_ARRAY_FLAGS(PERFCTRL, 15, CSRFL_GUEST_INVALID),
>> +    CSR_OFF_ARRAY_FLAGS(PERFCNTR, 15, CSRFL_GUEST_INVALID),
>> +    CSR_OFF_FLAGS(DBG, CSRFL_GSPR),
>> +    CSR_OFF_FLAGS(DERA, CSRFL_GSPR),
>> +    CSR_OFF_FLAGS(DSAVE, CSRFL_GSPR),
>> +    CSR_OFF_ARRAY_FLAGS(MSGIS, 0, CSRFL_GUEST_INVALID),
>> +    CSR_OFF_ARRAY_FLAGS(MSGIS, 1, CSRFL_GUEST_INVALID),
>> +    CSR_OFF_ARRAY_FLAGS(MSGIS, 2, CSRFL_GUEST_INVALID),
>> +    CSR_OFF_ARRAY_FLAGS(MSGIS, 3, CSRFL_GUEST_INVALID),
>> +    CSR_OFF_FLAGS(MSGIR, CSRFL_GUEST_INVALID),
>>   };
>>     CSRInfo *get_csr(unsigned int csr_num)
>> diff --git a/target/loongarch/csr.h b/target/loongarch/csr.h
>> index c2b6b882bc..647695e248 100644
>> --- a/target/loongarch/csr.h
>> +++ b/target/loongarch/csr.h
>> @@ -20,6 +20,8 @@ enum {
>>       CSRFL_IO       =3D (1 << 2),
>>       CSRFL_UNUSED   =3D (1 << 3),
>>       CSRFL_BASIC    =3D (1 << 4),
>> +    CSRFL_GSPR     =3D (1 << 5),
>> +    CSRFL_GUEST_INVALID =3D (1 << 6),
>>   };
>>     typedef struct {
>> diff --git a/target/loongarch/tcg/insn_trans/trans_extra.c.inc b/target/=
loongarch/tcg/insn_trans/trans_extra.c.inc
>> index 655dce329e..e69384497f 100644
>> --- a/target/loongarch/tcg/insn_trans/trans_extra.c.inc
>> +++ b/target/loongarch/tcg/insn_trans/trans_extra.c.inc
>> @@ -55,7 +55,7 @@ static bool gen_rdtime(DisasContext *ctx, arg_rr *a,
>>           tcg_gen_sextract_tl(dst1, dst1, high ? 32 : 0, 32);
>>       }
>>   -    offset =3D CPU_CSR_OFFSET(CSR_TID, 0);
>> +    offset =3D CPU_CSR_OFFSET(CSR_TID, LOONGARCH_VM_LEVEL_HOST);
>This should be another small patch.
>
>Regards
>Bibo Mao
>>       tcg_gen_ld_i64(dst2, tcg_env, offset);
>>         return true;
>> diff --git a/target/loongarch/tcg/insn_trans/trans_privileged.c.inc b/ta=
rget/loongarch/tcg/insn_trans/trans_privileged.c.inc
>> index 6728ce5ec9..bcfc977990 100644
>> --- a/target/loongarch/tcg/insn_trans/trans_privileged.c.inc
>> +++ b/target/loongarch/tcg/insn_trans/trans_privileged.c.inc
>> @@ -122,7 +122,7 @@ static bool trans_csrrd(DisasContext *ctx, arg_csrrd=
 *a)
>>           if (readfn) {
>>               readfn(dest, tcg_env);
>>           } else {
>> -            offset =3D get_csr_offset(csr, 0);
>> +            offset =3D get_csr_offset(csr, LOONGARCH_VM_LEVEL_HOST);
>>               tcg_gen_ld_tl(dest, tcg_env, offset);
>>           }
>>       }
>> @@ -157,7 +157,7 @@ static bool trans_csrwr(DisasContext *ctx, arg_csrwr=
 *a)
>>           writefn(dest, tcg_env, src1);
>>       } else {
>>           dest =3D tcg_temp_new();
>> -        offset =3D get_csr_offset(csr, 0);
>> +        offset =3D get_csr_offset(csr, LOONGARCH_VM_LEVEL_HOST);
>>           tcg_gen_ld_tl(dest, tcg_env, offset);
>>           tcg_gen_st_tl(src1, tcg_env, offset);
>>       }
>> @@ -196,7 +196,7 @@ static bool trans_csrxchg(DisasContext *ctx, arg_csr=
xchg *a)
>>       newv =3D tcg_temp_new();
>>       temp =3D tcg_temp_new();
>>   -    offset =3D get_csr_offset(csr, 0);
>> +    offset =3D get_csr_offset(csr, LOONGARCH_VM_LEVEL_HOST);
>>       tcg_gen_ld_tl(oldv, tcg_env, offset);
>>       tcg_gen_and_tl(newv, src1, mask);
>>       tcg_gen_andc_tl(temp, oldv, mask);
>>=20
>



