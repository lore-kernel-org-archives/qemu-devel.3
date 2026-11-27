Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78E1A606A323
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Nov 2026 15:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=unpredictable.fr header.i=@unpredictable.fr header.a=rsa-sha256 header.s=sig1 header.b=fnJy2xrQ
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWy79-0003a4-2h; Fri, 27 Nov 2026 10:43:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1xWy76-0003ZH-Be
 for qemu-devel@nongnu.org; Fri, 27 Nov 2026 10:43:53 -0500
Received: from st-2003c-snip6-11.eps.apple.com ([2a01:b747:3001:200::1f]
 helo=outbound.st.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1xWy73-0005hj-0r
 for qemu-devel@nongnu.org; Fri, 27 Nov 2026 10:43:50 -0500
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-1a-60-percent-8 (Postfix) with ESMTPS id
 147E7180050C; Fri, 27 Nov 2026 15:43:45 +0000 (UTC)
X-ICL-RepId: 01a21dad-4b0a-7031-8060-dfaa3b0e731e
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1795794227; x=1827330227;
 bh=vAESA5/xICE25HOGl0V2oJP1IBN1u/z/FPkKeyXeFgM=;
 h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To:x-icloud-hme;
 b=fnJy2xrQrvRvPbtjzqp+Rvx0HEQ8/II/HdUn2S4+9mlcx43c2mWFRmsrIWIZnxPVEqp4+n1Ok2IGld7Jy9ZNXJVmCDWaXFEzAG01EbH8NuPVKDW9hg4lW4YH1K94g34HHDHdjUGRLQXzbwokA8ds3UInon6hi8+FTUKY/DYFqEx6QaFvTGDxpfdKhYcmOK6dd5SeoI1fIhCsmaRTJwUJZlKt6iwKUXSBP8tnG4MoC9E6IKwAu9buJ801/kSrIzkjG58XYPKIa+IJbwcy4wmRnhyE65OB8PGOHYppTLVGxUXJhp6itvAlR+81+x1W4/fuyXD+ZAA5ECVDCb+4UKB/xQ==
mail-alias-created-date: 1752046281608
Received: from smtpclient.apple (unknown [17.156.216.30])
 by p00-icloudmta-asmtp-us-east-1a-60-percent-8 (Postfix) with ESMTPSA id
 59B8B18043ED; Fri, 27 Nov 2026 15:41:01 +0000 (UTC)
Content-Type: text/plain;
	charset=utf-8
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3901.200.71.1.16\))
Subject: Re: [PATCH] target/i386/mshv: use common emulator for str pio
From: Mohamed Mediouni <mohamed@unpredictable.fr>
In-Reply-To: <20261127153020.179180-1-magnuskulke@linux.microsoft.com>
Date: Fri, 27 Nov 2026 16:40:53 +0100
Cc: qemu-devel@nongnu.org,
 =?utf-8?Q?Doru_Bl=C3=A2nzeanu?= <dblanzeanu@linux.microsoft.com>,
 Wei Liu <wei.liu@kernel.org>,
 =?utf-8?Q?Doru_Bl=C3=A2nzeanu?= <doru.blanzeanu@microsoft.com>,
 Magnus Kulke <magnuskulke@microsoft.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <6C256F75-D3D4-49F4-A83D-3F3D52EFB5BB@unpredictable.fr>
References: <20261127153020.179180-1-magnuskulke@linux.microsoft.com>
To: Magnus Kulke <magnuskulke@linux.microsoft.com>
X-Mailer: Apple Mail (2.3901.200.71.1.16)
X-Proofpoint-ORIG-GUID: 7qCc4dDWn4nyZjJmojAfrvVQOJVpp8yy
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI3MDA2MiBTYWx0ZWRfX24E3zZBa2URz
 armOKssbi9XqHbzBYftzt9hESfd9AovAJvIQErDAv7QofkZ8sQVNPWkyxRfnCZ8s1kBKpsclsoj
 rG0bb/kUN7nPPYqnlofh6AagPpS7dsM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI3MDA2MiBTYWx0ZWRfX7b4Ex6WY4wvR
 wcD9lnhV+swo4FIsrBcwebajOQHudxaw2ZMzVFqtQLOWMweoWl+VzEaMdvylBctU/PEh6k/CAkn
 w+kd+XGqrcl9oVjhAzzaOler/Fh/Q/aB1SGHNS8ST+15RPoOH95kkJhJOO88NUs65XbEm517IsQ
 UMnHOVl96oLPd7n1ILCUNE9A2J7nCCFODbqqSq20ewHUX2QcMHtE4a5fticrMxxIUF7SZCkfXcC
 93Fw+1lH+Dj1spupXetL5iFqZsZSzzqSHfxlZiJcYzih+H6oIpWQS2J3VK4CRZ5V+gR7aJ50nPc
 aZytTy+jPfmhZdgDayPJC4G7/k/UOqNksWMo/dNtQikVZtnfu8WNcQR1PPg2yo=
X-Proofpoint-GUID: 7qCc4dDWn4nyZjJmojAfrvVQOJVpp8yy
X-Authority-Info-Out: v=2.4 cv=HKtWhYtv c=1 sm=1 tr=0 ts=6b09a532
 cx=c_apl:c_pps:t_out a=oyWFxbOnq+dmhQrAPgaJYA==:117
 a=oyWFxbOnq+dmhQrAPgaJYA==:17 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=c8vfPlyRl1mTKFn8zNL0:22 a=fTT_BlTF5xfLCWSJyvcG:22
 a=yMhMjlubAAAA:8 a=KKAkSRfTAAAA:8 a=zypEQrEzbmVKZOJxtg0A:9 a=QEXdDO2ut3YA:10
 a=cvBusfyB2V15izCimMoJ:22
X-JNJ: AAAAAAABU8Uprf4WrjfAVOWJDh5pQkG/0RJ44nLBuX0Rt4Er6V/maElcguhXX8QAZr3cXI
 QBX8Vke+KqKzkwa2B2qRH+o5XhxQ7ULh5XAOBFfg5zc6vl8zPoPi1RY+qysFOnFj/UnVKt
 5PpZMELILX0yg3amdMRpyTpwDj94GsGY03dKG3Lhl1SN5RKkNtfqbnk45OEXigVqt6xs4l
 SiAD4aEis8g15LXDZXbNxlAI8LdYYBQm/jKvKBNIICE4GoFn+wZJ83jaFiWs0136+6OnxV
 37wxv8xkdM1kJdRTypeM12tkrpS/DsUC5N4vztJVYjFxE6HWYDaYpY+bCfnR82b55rOFbK
 ds03jAAVkW4DLuGiWWbLZUOU9IwlIO7sKJ438y/bLZh8aUPHtxUIma9NBS3NwqtpsMaiML
 C8MnrOnmDlDflb++5tRAAOCIpg7vSs9AbK0rIV6YHG9suMzmEtSND7K/t7p81Nq4gG/YIB
 Pqgm8Gve8ss9USWf9Mp4G1N5UJNgeWawEIAZhmL1O++dY6N9Pkkw5csTNDRVWywEEMjrQM
 DvJD76aEsTDicX3j4WPoMmEwnBIGmUSWMwNMAYcqFA92QUTGwVzBnoaLgpX1tSFm2I0MZZ
 v28jdelJPVoedcJlBGpNlNTVLFt2QPLi76Idb4OInrP6lFbWCD+s1K3v693AGe3HVMM/bg
 X8rYk3FTgsDHHpmexGojhRjU9lw7m//HXRMzDTG02NpR510feyRLj3XnzysaDBbo603pgn
 MbVpxK9WX3plMFhsV9CLbtTm83KzAhvLiZGebKPQdk8ZBR6gBPIlRB8iO2H96vZUt8mDWg
 VrXhCON/QjdjwR/UYHxJllq9exZ7IjezUKEH5CdsWrvgWrK1lGy5xfmFnmT+RVzTM1nUk7
 nGt5pcMp+NbROXugZbyaaz1CPDfooA/R7zwc9S+GLVHu8o5aIOEKAqVfJAmHm5mycdEUY5
 eH3nSEz5qXhES4vi/y+R9s/SGFZGB4sX3XQ5biYtcMNXNmK6q0BLzRWJMXfs3osTzUWbFl
 7BMv8wvWzB0aWCHr17DCZqk3rQUh6DHXu1PcMolj1vyeoQrg76LItuwKDUjxTLojRoHAzN
 NDrdGBTeoFgjYzUCxOtbYZYaNDMibWUJvTbLDzCDJNGiVbqzXV3AAKv5ozS/o7H5cevuvK
 9KsALB5t/UfUtVSkW42YH3OBbsoRI3IdGMo6US9U5jyJlGa0HZig3gq7/Q0rIExPDLbmvX
 mykhUZB/0Ats4TQadBRY4p7q0Xm2ZWFd8EFWvpBy/DEg4cTLPv1ayG7Nc+/olZIs8iwSLA
 xA8i1IHczc5e8W+sbDy8Z55TFLWnFrc2MQQ1le3bCWfV/jU2Iq8rMZHZOZ4LcaMahQ9e9i
 2ccaQOiXprNHWkmWLZD8iqaZG+SVIWWWEsF3uxlQsdTzHBozaw==
Received-SPF: pass client-ip=2a01:b747:3001:200::1f;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.st.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



> On 27. Nov 2026, at 16:30, Magnus Kulke =
<magnuskulke@linux.microsoft.com> wrote:
>=20
> The mshv-local PIO emulation had a bug in which we did not honor a
> segment-override prefix on OUTS (the handler always read the source =
from
> DS:RSI, even when ES:RSI was requested). This was triggered by IDE =
boot of
> Windows ISOs.
>=20
> This change switches to the common decoder/emulator for string pio. =
This
> resolves the bug and removes the last remaining call to =
translate_gva()
> in favor of a userland table walk.
>=20
> Signed-off-by: Magnus Kulke <magnuskulke@linux.microsoft.com>

Reviewed-by: Mohamed Mediouni <mohamed.mediouni@linaro.org>

> ---
> target/i386/mshv/mshv-cpu.c | 328 +++++++++++-------------------------
> 1 file changed, 98 insertions(+), 230 deletions(-)

[=E2=80=A6]
>=20
> +static bool is_user_mode(CPUState *cpu)
> +{
> +    CPUX86State *env =3D &X86_CPU(cpu)->env;
> +
> +    /* If the guest is in real mode, it is not user mode. */
> +    if (!(env->cr[0] & CR0_PG_MASK)) {
> +        return false;
> +    }
> +
> +    return (env->segs[R_CS].selector & 3) =3D=3D 3 || (env->eflags & =
VM_MASK);
> +}

Think that the is_user_mode implementation in =
target/i386/emulate/x86_mmu.c
should have this as the default instead of having this as an override.

Not a blocker though, can add it on my list for later.

> +
> static const struct x86_emul_ops mshv_x86_emul_ops =3D {
>     .read_segment_descriptor =3D read_segment_descriptor,
> +    .is_user_mode =3D is_user_mode,
> +    .handle_io =3D handle_io,
> };
>=20
> void mshv_init_mmio_emu(void)
> --=20
> 2.34.1
>=20
>=20


