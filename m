Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A924C4828F
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Feb 2024 08:56:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rYMfZ-0002iV-8d; Fri, 09 Feb 2024 03:55:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1rYMfY-0002i9-16
 for qemu-devel@nongnu.org; Fri, 09 Feb 2024 03:55:36 -0500
Received: from mout.gmx.net ([212.227.15.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1rYMfW-0006oq-5d
 for qemu-devel@nongnu.org; Fri, 09 Feb 2024 03:55:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1707468930; x=1708073730; i=deller@gmx.de;
 bh=msDndIM/0AnRjkd7hidSr4pvE5Egr7ts6GG1mfWSxPA=;
 h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
 b=BDrBPh+fyid6KavJKSkaWQ5E1S7zyVMaE4zCWFsJNx1llctmUHRYLav2ZdpsjCm6
 Zew52PnftasQNlLF98qbd22urQ9IitVG5FVNcpo/Ef6+Y1NfHOHAXLO1FmJ4IcyP9
 3WjJS60UfNu+PZQQ20EF5O4UtTvsFnY881TJe4kAnSuPf7j+bJXe2zWF6K627gNL4
 zkOOv3VD0ykdQE5eK6Ex6QTEtA8xTiQWqtSeOSr9Ce922SQglVZyft07gFmbO06TW
 bz633V9HutpfbajHeWve/DL/mcursRUsk64lgSC6pou7m78FC3+9EeazQRMlCowU7
 dZuwCk9mB6uVnPliMw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.55] ([94.134.148.154]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1McY8d-1qzqnf0Doz-00cwXU; Fri, 09
 Feb 2024 09:55:30 +0100
Message-ID: <98a27af7-a7f5-4f8e-9478-437d53d656bf@gmx.de>
Date: Fri, 9 Feb 2024 09:55:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/13] target/hppa: Fix PSW_W and PSW_E bits in rsm, ssm
 and mtsm
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, deller@kernel.org,
 qemu-devel@nongnu.org
References: <20240207182023.36316-1-deller@kernel.org>
 <20240207182023.36316-4-deller@kernel.org>
 <2736d6d1-5585-4bbd-82c7-a3b7f5c87fb9@linaro.org>
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <2736d6d1-5585-4bbd-82c7-a3b7f5c87fb9@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:R0eoVwsux3xAe+hNBpfRP8NbtJtoNQw62yEFYUE6AligKtvQj/N
 E5s2nT6iza+sHaoxzQ5cTTRUildOPaNa+JjLn3HjZNzio9DE6SklVZHiyXywWcxl03urCcx
 nsczaODebRNXIJ7tBV0ra9WT9mBAN/vN6lHHGH5lbASYE1m+i6g1kNCJFj9J5Hs4NNvwTLA
 CLNEuBiebSbO+T6po42aA==
UI-OutboundReport: notjunk:1;M01:P0:gfbyGxRtgZk=;2AOHPXyIx3uoNihGIiGTI6NtDTv
 mmmVvbIdyWWZWeMZfU7iQ+rSGKH4Rjh5yUufx/qwuwXSMwNWj31oOu6VK2Fozvzes/COkh8SB
 T8fTFPt0PwvpMAlPx6aR1ZLvKY5a7qBWc1CCQfYkCTsYEj148zx3wObnJFqab95SUdmvZxx7A
 OazMVbNTBxMWm5hQZvp7uqD/bndObgw5EKcI7HHoIPZmEr+SKex7f39ul6OTdDn1TFFHWeyMd
 dZCGAC61ZkJXtYIOPCIn09vS8HwEhaQSsxml3sJHpSOzI1DkLRY1s5SlYGuuHZjVXr00STqvm
 1iAzOIBi+cV17N1L3HhLmCX+puXXUITNdaQvd+9wXprZvTTmrWhfdHqr+SNpvUXTwzyl9bI7D
 bBamOFcs5FAt+rHw+K5jtV4qBUWOifmxfkVpmoKe+MPVmDIGAWA0cCvJL7XYSlbnHdj9zyWy/
 b/skMg46UqiGpYuI5zwPMJ5JpRQUj3c3La1up4qVhPnyH/D/xLu7u8hfndNcYz1mAdwX8UA5d
 Clw90YxTgnC91Q+3YzhMIWnJHTBS/GMqw51CmIHI/aBjdr97yFFRcsixDDsGgQsff4d/BaVD3
 /XtIiyZMgll+9KSde/7S72rnfOjH467s91Sc0FO98oLyEfrgg8IIGI7v1pdJMJH5+RiMP3sow
 HkqBsmUcEqiNlzn3CD2JCnkeaw3/PaEWcWzmsAqEOSqzJfKrABBrL93bGB56GmKdd4mHZDx7t
 Pc0Su1t/PLRBKYKOM2A3+p5cfaqxhs2VI7gc4OUD/RSs/Cdc6YpVuOZhI/3LbBXjbHRTvETVL
 lfDD0/Mno3uJtsAHhktZUe1UWsvEa9R/QMO9uh+UaGLss=
Received-SPF: pass client-ip=212.227.15.18; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 2/8/24 21:43, Richard Henderson wrote:
> On 2/7/24 08:20, deller@kernel.org wrote:
>> =C2=A0 #define PSW_E=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 0x04000000
>> +#define PSW_E_BIT=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 37 /* PA2.0 only */
>> =C2=A0 #define PSW_W=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 0x08000000 /* PA2.0 only */
>> +#define PSW_W_BIT=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 36 /* PA2.0 only */
> ...
>> +target_ulong HELPER(get_system_mask)(CPUHPPAState *env)
>> +{
>> +=C2=A0=C2=A0=C2=A0 target_ulong psw =3D env->psw;
>> +
>> +=C2=A0=C2=A0=C2=A0 /* mask out invalid bits */
>> +=C2=A0=C2=A0=C2=A0 target_ulong psw_new =3D psw & PSW_SM;
>> +
>> +=C2=A0=C2=A0=C2=A0 /* ssm/rsm instructions number PSW_W and PSW_E diff=
erently */
>> +=C2=A0=C2=A0=C2=A0 psw_new &=3D ~PSW_W;
>> +=C2=A0=C2=A0=C2=A0 if (psw & PSW_W) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 psw_new |=3D 1ull << (63 - =
PSW_W_BIT);
>> +=C2=A0=C2=A0=C2=A0 }
>
> Um, this has changed nothing, since 1 << (63 - 36) =3D=3D 0x8000000 =3D=
=3D PSW_W.

Yep.
I seem to have mixed strange things when writing that.
I've dropped the patch for now.

Thanks!
Helge


> The conversion of PSW_SM_W to PSW_W happens in expand_sm_imm().
> There's a comment there about keeping unimplemented bits disabled, inclu=
ding PSW_E. Perhaps this is the wrong layer in which to do this?
>
> In any case, what is the actual problem that you're seeing?=C2=A0 Becaus=
e it *isn't* that we were not considering the different placement of the b=
its, as your commit message suggests.
>
>> diff --git a/target/hppa/translate.c b/target/hppa/translate.c
>> index 53ec57ee86..10fdc0813d 100644
>> --- a/target/hppa/translate.c
>> +++ b/target/hppa/translate.c
>> @@ -2163,13 +2163,20 @@ static bool trans_rsm(DisasContext *ctx, arg_rs=
m *a)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 nullify_over(ctx);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tmp =3D tcg_temp_new_i64();
>> -=C2=A0=C2=A0=C2=A0 tcg_gen_ld_i64(tmp, tcg_env, offsetof(CPUHPPAState,=
 psw));
>> -=C2=A0=C2=A0=C2=A0 tcg_gen_andi_i64(tmp, tmp, ~a->i);
>> -=C2=A0=C2=A0=C2=A0 gen_helper_swap_system_mask(tmp, tcg_env, tmp);
>> -=C2=A0=C2=A0=C2=A0 save_gpr(ctx, a->t, tmp);
>> +=C2=A0=C2=A0=C2=A0 if (a->t !=3D 0) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 gen_helper_get_system_mask(=
tmp, tcg_env);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 save_gpr(ctx, a->t, tmp);
>> +=C2=A0=C2=A0=C2=A0 }
>
> If a->t =3D=3D 0, tmp is uninitialized...
>
>> +
>> +=C2=A0=C2=A0=C2=A0 if (a->i) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tcg_gen_ld_i64(tmp, tcg_env=
, offsetof(CPUHPPAState, psw));
>
> ... but read here.
>
>> @@ -2183,11 +2190,17 @@ static bool trans_ssm(DisasContext *ctx, arg_ss=
m *a)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 nullify_over(ctx);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tmp =3D tcg_temp_new_i64();
>> -=C2=A0=C2=A0=C2=A0 tcg_gen_ld_i64(tmp, tcg_env, offsetof(CPUHPPAState,=
 psw));
>> -=C2=A0=C2=A0=C2=A0 tcg_gen_ori_i64(tmp, tmp, a->i);
>> -=C2=A0=C2=A0=C2=A0 gen_helper_swap_system_mask(tmp, tcg_env, tmp);
>> -=C2=A0=C2=A0=C2=A0 save_gpr(ctx, a->t, tmp);
>> +=C2=A0=C2=A0=C2=A0 if (a->t !=3D 0) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 gen_helper_get_system_mask(=
tmp, tcg_env);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 save_gpr(ctx, a->t, tmp);
>> +=C2=A0=C2=A0=C2=A0 }
>> +
>> +=C2=A0=C2=A0=C2=A0 if (a->i) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tcg_gen_ld_i64(tmp, tcg_env=
, offsetof(CPUHPPAState, psw));
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tcg_gen_ori_i64(tmp, tmp, a=
->i);
>
> Likewise.
>
>
> r~


