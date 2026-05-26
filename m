Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EF89CD5BB1
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2026 15:11:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRtQj-00019e-Ko; Tue, 26 May 2026 11:10:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>)
 id 1wRtQU-00017B-K1; Tue, 26 May 2026 11:10:39 -0400
Received: from mout.gmx.net ([212.227.15.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>)
 id 1wRtQS-0003fX-Dc; Tue, 26 May 2026 11:10:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1779808230; x=1780413030; i=deller@gmx.de;
 bh=h+FUDpMI1biJOvTWmDwSnGgGcrEFQeSiGB2e0eheG08=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=cx2TOFOCTCR0Mue+liSDITWyrOEats4MI06vZtEwj3+Xf/ldPj7CA7oSAnjG67mk
 A7yhtRlQkgVSv8fCozbvSutS520emEl659C4Kqo+nipeyidvbCjaGCHsD1mw5FjN5
 Rmdf22WaBfKRjLWyIimoICOlJlg6+sbAHQv01rLkBMW9vxmh77XXBWomiCb9k7PFX
 jNo9z98SofUspaN3XrevstRDrGBe6PVSOwqN2EpbGRDyvZ14Kq5C1Bg/x+VSc4kPO
 lV/QZhEGxn04bxiXrt8QtUuLwSOXYQRwj7P3NqlbPeN5MsqXPz/vJcehkMEFwaKSz
 OiZ8pSDXDAUnGwE/vQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N5VHM-1xPiyV2htC-00sOVK; Tue, 26
 May 2026 17:10:30 +0200
Message-ID: <c41af5dc-3f5d-48e2-b28d-770e86be7cba@gmx.de>
Date: Tue, 26 May 2026 17:10:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] linux-user/s390x: restore fpu_status rounding mode
 from FPC on sigreturn
To: Matt Turner <mattst88@gmail.com>, qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, David Hildenbrand <david@kernel.org>,
 Cornelia Huck <cohuck@redhat.com>, Eric Farman <farman@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>, qemu-s390x@nongnu.org,
 qemu-stable@nongnu.org
References: <20260525152210.4119543-1-mattst88@gmail.com>
 <20260526150534.170504-1-mattst88@gmail.com>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <20260526150534.170504-1-mattst88@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:16t5bDsEqgGOoMZZImkF3XtbJ+IbqR+r+dRy+IL1xHouiBDM2lr
 6Gx129yk81BB8P8NIRlwHkXnspr0u6E+RArIX4BRtM7KkHAO+7sbFGA6kWqiLt0QY0WZIq5
 eNGlZrnf3Zbbep11/BypEeAbpgFx7uthOKVZYz/5NLZkt/gAUqoehhxozVXyMfYANhOa1Hs
 6WI+jXm8o9zOoxfkrXAtg==
UI-OutboundReport: notjunk:1;M01:P0:o7M4+UaBeo4=;o9auOK60kHM40ibG35cO7INgoso
 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
 PFBtibpdKepv0RpJtnhAPiwNHMqBnwqQ8uXREps
Received-SPF: pass client-ip=212.227.15.18; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 5/26/26 17:05, Matt Turner wrote:
> QEMU keeps the s390x floating-point control register (FPC) in env->fpc.
> The rounding mode bits [2:0] of FPC are reflected into the derived
> env->fpu_status via set_float_rounding_mode(); every architectural
> write to FPC goes through HELPER(sfpc) which keeps the two in sync.
>=20
> restore_sigregs() restored FPC with a direct assignment:
>=20
>      __get_user(env->fpc, &sc->fpregs.fpc);
>=20
> This wrote env->fpc correctly but never updated env->fpu_status, so on
> sigreturn the interrupted code resumed with whatever rounding mode the
> signal handler last installed in fpu_status.
>=20
> Factor the two-step "write fpc + sync fpu_status" logic out of
> HELPER(sfpc) into cpu_s390x_load_fpc(), declare it in cpu.h, and call
> it from restore_sigregs() in place of the direct assignment.
>=20
> cpu_s390x_load_fpc() partially reuses the sanity check from
> HELPER(sfpc): if the FPC value has an invalid rounding mode or reserved
> bits set, it falls back to 0, matching the kernel's fpu_lfpc_safe()
> behavior where a corrupt signal frame value causes a specification
> exception and 0 is used instead.
>=20
> HELPER(sfpc) now calls cpu_s390x_load_fpc() after its full
> specification-exception check, including the FEAT_FLOATING_POINT_EXT
> test that is not needed for the signal restore path.
>=20
> Fixes: 2941e0fa05 ("linux-user/s390x: Save/restore fpc when handling a s=
ignal")
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Matt Turner <mattst88@gmail.com>
> ---
>   linux-user/s390x/signal.c     |  6 +++++-
>   target/s390x/cpu.h            |  1 +
>   target/s390x/tcg/fpu_helper.c | 20 ++++++++++++++------
>   3 files changed, 20 insertions(+), 7 deletions(-)
>=20
> diff --git ./linux-user/s390x/signal.c ./linux-user/s390x/signal.c
> index 96d1c8d11c..28ad80bde4 100644
> --- ./linux-user/s390x/signal.c
> +++ ./linux-user/s390x/signal.c
> @@ -332,7 +332,11 @@ static void restore_sigregs(CPUS390XState *env, tar=
get_sigregs *sc)
>       for (i =3D 0; i < 16; i++) {
>           __get_user(env->aregs[i], &sc->regs.acrs[i]);
>       }
> -    __get_user(env->fpc, &sc->fpregs.fpc);
> +    {
> +        uint32_t fpc;

to avoid putting this block into braces, can't fpc be moved some lines abo=
ve,
where the other variables are declared?

> +        __get_user(fpc, &sc->fpregs.fpc);
> +        cpu_s390x_load_fpc(env, fpc);
> +    }
>       for (i =3D 0; i < 16; i++) {
>           __get_user(*get_freg(env, i), &sc->fpregs.fprs[i]);
>       }
> diff --git ./target/s390x/cpu.h ./target/s390x/cpu.h
> index 3acbe83f0f..f55b79ef8a 100644
> --- ./target/s390x/cpu.h
> +++ ./target/s390x/cpu.h
> @@ -895,6 +895,7 @@ void s390_init_sigp(void);
>   /* helper.c */
>   void s390_cpu_set_psw(CPUS390XState *env, uint64_t mask, uint64_t addr=
);
>   uint64_t s390_cpu_get_psw_mask(CPUS390XState *env);
> +void cpu_s390x_load_fpc(CPUS390XState *env, uint32_t fpc);
>  =20
>   /* outside of target/s390x/ */
>   S390CPU *s390_cpu_addr2state(uint16_t cpu_addr);
> diff --git ./target/s390x/tcg/fpu_helper.c ./target/s390x/tcg/fpu_helper=
.c
> index 6ca0b7162b..107025e675 100644
> --- ./target/s390x/tcg/fpu_helper.c
> +++ ./target/s390x/tcg/fpu_helper.c
> @@ -1087,6 +1087,19 @@ static const int fpc_to_rnd[8] =3D {
>       float_round_to_odd,
>   };
>  =20
> +void cpu_s390x_load_fpc(CPUS390XState *env, uint32_t fpc)
> +{
> +    /*
> +     * Mimic kernel fpu_lfpc_safe(): a corrupt signal frame value that =
would
> +     * trigger a specification exception instead results in FPC being s=
et to 0.
> +     */
> +    if (fpc_to_rnd[fpc & 0x7] =3D=3D -1 || fpc & 0x03030088u) {
> +        fpc =3D 0;
> +    }
> +    env->fpc =3D fpc;
> +    set_float_rounding_mode(fpc_to_rnd[fpc & 0x7], &env->fpu_status);
> +}
> +
>   /* set fpc */
>   void HELPER(sfpc)(CPUS390XState *env, uint64_t fpc)
>   {
> @@ -1094,12 +1107,7 @@ void HELPER(sfpc)(CPUS390XState *env, uint64_t fp=
c)
>           (!s390_has_feat(S390_FEAT_FLOATING_POINT_EXT) && fpc & 0x4)) {
>           tcg_s390_program_interrupt(env, PGM_SPECIFICATION, GETPC());
>       }
> -
> -    /* Install everything in the main FPC.  */
> -    env->fpc =3D fpc;
> -
> -    /* Install the rounding mode in the shadow fpu_status.  */
> -    set_float_rounding_mode(fpc_to_rnd[fpc & 0x7], &env->fpu_status);
> +    cpu_s390x_load_fpc(env, fpc);
>   }
>  =20
>   /* set fpc and signal */


