Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D957CF9934F
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2026 07:58:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFowW-0003p6-Cq; Thu, 23 Apr 2026 03:57:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jim.shu@sifive.com>)
 id 1wFowV-0003oi-2U
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 03:57:47 -0400
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jim.shu@sifive.com>)
 id 1wFowS-00043J-UO
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 03:57:46 -0400
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-ba7fd666666so484273366b.3
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2026 00:57:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776931063; cv=none;
 d=google.com; s=arc-20240605;
 b=CAJ8KVrjse5GiJnX9Vn2BSQCnHkxCG7lGHLnKFvpKIeD9ZJy30+6ZZWXeS2EfGAQBl
 NzxZOet1zpobJwsyBotQtzq0jlURAogyZD/IFQrsFkZ5wm6uB5VOjW12mF+ZNm0RFCcm
 93q0IpyONntogGFm9G1egwNWBwqN7rYmC0hhh+fAtUyt4ZuwUtbaE28UrODtMT1jYBoQ
 stF519dRNNSXxWhVCRkI5AHzTCYMskXuMkaHsv68d4k40ZZDjR3/eAaKaSUTnk4FhhGC
 DPOmxWqwUENu7fqfqqjiiy/SYjT/2fIArP331Hr8KwNBf9nXW9uZGdFEpc7RTBlPjS2p
 Rj9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=NjbH1c7hs6kxyvRTLuoj6u/bq+4VEr2SgoTGiTLMLqo=;
 fh=WJG0E6XwtIN7w0FXodofQKSuA+vnd21xSMiYp9Rwea4=;
 b=AyFbtDico6XNY3aFkxh37vrARPqm5QqbyX6eBBR4oWVcONQyqAaJQJ+1Yfl4J8aISy
 MMpfrvPly0VFz2/Ra8FOIcnYej22LaUQgUiHNWlQ2H2RZPaC4U3sedKI5KZLZYh+7WwI
 whc4pVG8nt+x26yBfTjVCTmAnJ+IgU4k9fUA1vodlRfRsGjte9cedV64dIJA3qYI2G6b
 ro9JGKOfLv4/IbObGX50DUdq+O/bgpbWxXax4Ui40CRPZCJ6eMAEMXf3iLobnBO6LsxZ
 3EfS8qLyGASIdCvSQ6CjghNh0DT4LYmhrhb3K3h6NIfQGQ6Kkh/gs3N9LeWvAhRZX5UE
 QXaQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1776931063; x=1777535863; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NjbH1c7hs6kxyvRTLuoj6u/bq+4VEr2SgoTGiTLMLqo=;
 b=L8MSzl1VbIIIGmcHeIQXfIcDCMM87jGq0hiuSD0cBzsMgZKCtBHwI6A2wK03rlAaXu
 0h4mtawpVDxCEcjRPIdoHU82rJrIOmXlrL13YyzGgjBKbHZhjR5cYwJDVaWK4+brjTY8
 1Wp55t09MVNjYtoZsIJoTAdaF+lENhXPxcxHWekr9id4iujVt56pFcRY+wjSalgjMLSY
 6cAaTnuKF05UhlBp4DV2Fu7rquGV4A9hKtmqeeJ2XFyD5tJE0MUBIRrHllBlbct2qPJZ
 enm10zJzCYh9D3X++N6AVgOBlre3W4/cqVu6s2zRRZU3i4UrAzMb/FpaUjhXlLkFSdHN
 CX9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776931063; x=1777535863;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=NjbH1c7hs6kxyvRTLuoj6u/bq+4VEr2SgoTGiTLMLqo=;
 b=dnA5mTmknEkud0HclsNQUJ6DSHjzCsefMz1q3MuCuC7185xp6EvK2drEh4h5Ldxj9R
 yfIHRT2hQODvUgj05rL7XitgyLHMjUHpNfQ+ZQhbmsQCA5bwOxCGVYhOKqrV0IomoIpK
 7tAlv8P/X8zfjfImbC8LPtVs5Y5ZedwTN8Lwi9VfzajG1teNDCbo/SRAbDvyV39OBYvj
 2aSLqeOcmOCzflHnmj8Sw3TmIFP5zZ1MTpchh1OSZjDf2NkNgVlkVKOOOdy2DWlGP+HR
 adOMHjX5e7R4woKMCdb59+4uR7uEKs7zhGOETmGh8LzvGgl3WoiIMKp/2Dtqchsi7Old
 gTOg==
X-Gm-Message-State: AOJu0Yy/4Kis1DuNSHDKDxdZkvSxXtsPjIAQLBbe/T7WHhy5a1fcoIEp
 /c6Ljbk9MMJgaSjK7ZK+Eeb7UKm0zcDJKl8pSGjLcYDJCWNw5tsnlozqpBaM+n79BabseiQEqAc
 iNA/VBePJjn7DqNBoedZP4ZrnPkhxVrEvpA8OPRsOcg==
X-Gm-Gg: AeBDieuD2YTt7jrNGVuAonKHgNRRdP8Rwni6vXx+pX6+gntGIzIIZUDbGVQV3I8KCPN
 0W2YOXGCyRGyJKtvlA49Z0zWlqQwMmQJYt0TApm/xIQm9XlOuD+6REFjOvmvFEEHIvhvVy2J37R
 mQUhQkh4jxcP4ZX3H/qu4V/wew9fPn1LklhloZ10FbRLqp+IKzjs4BF4PWTlztLXujj6VW9nYnt
 IRdj4CXEqmiyWNEzNF0Z928C/qFLLSoy+85Par+MNU8PRisDvCiv0ZQvdlfa1Vpf8LfTUh16VKN
 qFbPQ17gIIly6gN4AHne
X-Received: by 2002:a17:907:3f9d:b0:ba5:20b1:c13b with SMTP id
 a640c23a62f3a-ba520b1c177mr1155676966b.28.1776931063188; Thu, 23 Apr 2026
 00:57:43 -0700 (PDT)
MIME-Version: 1.0
References: <20260421162912.3295598-1-jim.shu@sifive.com>
 <20260421162912.3295598-2-jim.shu@sifive.com>
 <5ba47c77-3e2a-49c6-96b5-37fa97ef60c4@linux.ibm.com>
In-Reply-To: <5ba47c77-3e2a-49c6-96b5-37fa97ef60c4@linux.ibm.com>
From: Jim Shu <jim.shu@sifive.com>
Date: Thu, 23 Apr 2026 15:57:31 +0800
X-Gm-Features: AQROBzASPIPBGsWPBKCgNRBlrKuw_ihjgxfTUQTLKaNhyY0x4CZG-dxf5G_CXQc
Message-ID: <CALw707pwzyd-DUXbBprFOH8cO0inmhRh4Ajs3G65PK5E49AzAg@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] accel/tcg: Pass access_type as an argument of
 tlb_set_page*()
To: Ilya Leoshkevich <iii@linux.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, 
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, 
 Zhao Liu <zhao1.liu@intel.com>, Peter Xu <peterx@redhat.com>, 
 Michael Rolnik <mrolnik@gmail.com>, Helge Deller <deller@gmx.de>,
 Song Gao <gaosong@loongson.cn>, Laurent Vivier <laurent@vivier.eu>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, 
 Aurelien Jarno <aurelien@aurel32.net>, Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Aleksandar Rikalo <arikalo@gmail.com>, Stafford Horne <shorne@gmail.com>, 
 Nicholas Piggin <npiggin@gmail.com>, Chinmay Rath <rathc@linux.ibm.com>, 
 Glenn Miles <milesg@linux.ibm.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Chao Liu <chao.liu.zevorn@gmail.com>, Yoshinori Sato <yoshinori.sato@nifty.com>,
 David Hildenbrand <david@kernel.org>, Cornelia Huck <cohuck@redhat.com>,
 Eric Farman <farman@linux.ibm.com>, 
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, 
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Bastian Koppelmann <kbastian@rumtueddeln.de>, 
 Max Filippov <jcmvbkbc@gmail.com>,
 "open list:PowerPC TCG CPUs" <qemu-ppc@nongnu.org>, 
 "open list:S390 TCG CPUs" <qemu-s390x@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::631;
 envelope-from=jim.shu@sifive.com; helo=mail-ej1-x631.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Wed, Apr 22, 2026 at 5:04=E2=80=AFPM Ilya Leoshkevich <iii@linux.ibm.com=
> wrote:
>
>
> On 4/21/26 17:29, Jim Shu wrote:
> > Pass the access_type so that we could know CPU will do the read or
> > write access. Then, CPU can fill the CPUTLBEntry[Full] of the specific
> > permission (@prot).
> >
> > It is fine for address_space_translate*() to return different section o=
f
> > read and write access. tlb_set_page*() only sets 'CPUTLBEntry.addr_*'
> > for specific @prot, so access from another @prot will only get TLB miss
> > and start to overwrite 'CPUTLBEntry[Full]' with new @prot.
> >
> > It is the preliminary patch of next commit to pass the iommu_flags
> > to IOMMUMemoryRegion from access_type.
> >
> > Signed-off-by: Jim Shu <jim.shu@sifive.com>
> >
> > ---
> >   accel/tcg/cputlb.c                   | 14 ++++++++------
> >   include/exec/cputlb.h                | 11 +++++++----
> >   target/alpha/helper.c                |  2 +-
> >   target/avr/helper.c                  |  3 ++-
> >   target/hppa/mem_helper.c             |  1 -
> >   target/i386/tcg/system/excp_helper.c |  3 ++-
> >   target/loongarch/tcg/tlb_helper.c    |  2 +-
> >   target/m68k/helper.c                 | 10 +++++++---
> >   target/microblaze/helper.c           |  8 ++++----
> >   target/mips/tcg/system/tlb_helper.c  |  4 ++--
> >   target/or1k/mmu.c                    |  2 +-
> >   target/ppc/mmu_helper.c              |  2 +-
> >   target/riscv/cpu_helper.c            |  2 +-
> >   target/rx/cpu.c                      |  3 ++-
> >   target/s390x/tcg/excp_helper.c       |  2 +-
> >   target/sh4/helper.c                  |  3 ++-
> >   target/sparc/mmu_helper.c            |  6 +++---
> >   target/tricore/helper.c              |  2 +-
> >   target/xtensa/helper.c               |  3 ++-
> >   19 files changed, 48 insertions(+), 35 deletions(-)
>
> [...]
>
> > diff --git a/target/hppa/mem_helper.c b/target/hppa/mem_helper.c
> > index ffbad8acfd2..63606c19d07 100644
> > --- a/target/hppa/mem_helper.c
> > +++ b/target/hppa/mem_helper.c
> > @@ -482,7 +482,6 @@ bool hppa_cpu_tlb_fill_align(CPUState *cs, CPUTLBEn=
tryFull *out, vaddr addr,
> >       out->prot =3D prot;
> >       out->attrs =3D MEMTXATTRS_UNSPECIFIED;
> >       out->lg_page_size =3D TARGET_PAGE_BITS;
> > -
> >       return true;
> >   }
>
> This whitespace change looks unnecessary.

I will remove it in the next series.

>
> > @@ -1461,6 +1462,7 @@ void HELPER(ptest)(CPUM68KState *env, uint32_t ad=
dr, uint32_t is_read)
> >       int prot;
> >       int ret;
> >       target_ulong page_size;
> > +    MMUAccessType qemu_access_type;
>
> Do we need to assign MMU_DATA_LOAD as a default here?

Yes, LOAD should be the default value.
I will add it in the next series.

>
> >       access_type =3D ACCESS_PTEST;
> >       if (env->dfc & 4) {
> > @@ -1468,9 +1470,11 @@ void HELPER(ptest)(CPUM68KState *env, uint32_t a=
ddr, uint32_t is_read)
> >       }
> >       if ((env->dfc & 3) =3D=3D 2) {
> >           access_type |=3D ACCESS_CODE;
> > +        qemu_access_type =3D MMU_INST_FETCH;
> >       }
> >       if (!is_read) {
> >           access_type |=3D ACCESS_STORE;
> > +        qemu_access_type =3D MMU_DATA_STORE;
> >       }
> >
> >       env->mmu.mmusr =3D 0;
> > @@ -1480,7 +1484,7 @@ void HELPER(ptest)(CPUM68KState *env, uint32_t ad=
dr, uint32_t is_read)
> >       if (ret =3D=3D 0) {
> >           tlb_set_page(env_cpu(env), addr & TARGET_PAGE_MASK,
> >                        physical & TARGET_PAGE_MASK,
> > -                     prot, access_type & ACCESS_SUPER ?
> > +                     prot, qemu_access_type, access_type & ACCESS_SUPE=
R ?
> >                        MMU_KERNEL_IDX : MMU_USER_IDX, page_size);
> >       }
> >   }
> Otherwise it may be used uninitialized here.

Have fixed them in v3 branches:
https://github.com/cwshu/qemu/tree/iotlb-add-type-v3-alpha
Next series will contain these fixes.

Regards,
Jim

