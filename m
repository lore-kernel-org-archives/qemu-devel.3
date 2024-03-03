Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41E42C48BF6
	for <qemu-devel@archiver.kernel.org>; Sun,  3 Mar 2024 05:34:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rgeTz-0003f4-Ua; Sun, 03 Mar 2024 00:33:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1rgeTt-0003Z1-Lg
 for qemu-devel@nongnu.org; Sun, 03 Mar 2024 00:33:51 -0500
Received: from mout.gmx.net ([212.227.15.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1rgeTp-0001Zp-UX
 for qemu-devel@nongnu.org; Sun, 03 Mar 2024 00:33:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1709444022; x=1710048822; i=deller@gmx.de;
 bh=W6CzrgepE0azMyZTpZXytNCpwWpzYajdBk+zuB8fT9Q=;
 h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
 b=s6xb0BCeoYAyyL+Mf+aFDOggXfAm6OznfMd+PZG3kY3ZvBroCzB0Wbd3XKeZTAim
 sHKPyNF8JieOFfl5HzmE/6BskeVm0RvmQ2mpGasu2MpODtrxSRBiyEwqGJuSn4cWL
 IqJZf0YU1xAm4YBKA3BjGTl/GakdrMQYZeQgDtg3cayTc4uGycOvM+4D+DNAfwAdt
 4UXM7U7EYo3Od2xOkCkKgYcLNK5PJ7TOzRIxAl4JFdhvir8X+CUlveuE/I7ZJb/KY
 PRqkNC2ocIsVsMw1RRtIgGBpHGrklNi3O0CG4N/Pn8AhbH5itqvtX0AU/Q7iJAa+u
 S3xwq/sQzHFekF2eVQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.55] ([94.134.144.221]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N6bfw-1qnM9g2DOA-0180S9; Sun, 03
 Mar 2024 06:33:42 +0100
Message-ID: <34a994a5-f815-415e-90a1-baf37e54a897@gmx.de>
Date: Sun, 3 Mar 2024 06:33:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] target/hppa: Fix unaligned double word accesses for
 hppa64
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, deller@kernel.org,
 qemu-devel@nongnu.org
References: <20240302223524.24421-1-deller@kernel.org>
 <20240302223524.24421-2-deller@kernel.org>
 <4f6bbf0f-20d2-4599-a8b3-5fb0a381d6dd@linaro.org>
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <4f6bbf0f-20d2-4599-a8b3-5fb0a381d6dd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:oTfAPg114ZFMloWtIu3SjN5LjpqmPf5DgHVgTnxpMOW1/zPwMme
 sWK+KGZluSOupG/n9qkCRbp5oUMqCD8hVeysmQOmxwkhkPMiVl3T3DxLjorTwovH2VM9uy4
 wBqQNblxU45w6YbdBmuckAEcZlg68xj9EZFymTYYlNCJ2p2/O1+36JyRsA+IfiAcpN6YccS
 YVCaG1uyy3lhKd7i/B6Yg==
UI-OutboundReport: notjunk:1;M01:P0:nXACziC8BwY=;OuG93YoB9NN88ibQBkvr2gbMejc
 TmDe0Gju3WCQHuw0Bt0DPOA/MPGb+6nCY6r2d3d4urLV/VKhhWgsyb2yI2/gooEsKmzle/qMU
 +n4ca4LNUDaK4DFGJgm8kuCv09b3ZdckeuBKYi3lCnlwcdDKev+EuaDcdbP2qmOPwd/SyMvTv
 GNy5WoZN3ee9YUKyUov12FWDCzjyPBywFvzgAnoYughAcmtFAgp10/XeDHAV7T0bCwar5puwk
 Zdpc+bEwzBwj4Kg62qRCWpv9QpkUQmi3Nxxtg9xynK5G5J6uk4InFakPgXGlCEA7GgeFJd3MS
 /7+6qUB4QwXHdSrPanj9hCW7Qf6A7uDwdCwiQafvEcPp8d2YE8r7IS1oOrazOSPsB5pWl49+9
 6gvuk4lczc1SaPL8OUZHWAntBWlJpDInBXTX7tLn5o1m9GW/rQ8IfI3jQaiIit4l6LVJ6Eqov
 2tfgQt3Tpn3hpfZPpxa1X7PBGNL3zfYfkIdMHwfW0Vgc+4C1DABMRAw3OnenR3h8A+MA6UuDX
 xOjH7g60uGgulMqR/mocLr9PPzVDWl7M89CCPsHme21zdBG84ww7PJP8KOTv2HGPI7zu2vXyx
 iQ0WwoMqitfn/oJYi5ml/kpKiBvN/0NBL3HGZPfiso4+nM0a9brVZnbw8BCJpmqctBWq1BG5+
 j0yATxchlhF+rESEvTjlhX+rBFULmA0+X8vJmmkoocZcOh5QKyZXInoJ+BI2dZWa4TeeePoXS
 dTLAaxYMMznAsJnBfk757PtACSqZwtx4kLw1j3dIIU8+dkMcnNYx978jwh2MSETATbHVN2fLB
 FnI0E+f/9keJp5/oW5uGw9/orDRbRq+7jHsy+U7QsNP1g=
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

On 3/3/24 03:10, Richard Henderson wrote:
> On 3/2/24 12:35, deller@kernel.org wrote:
>> From: Guenter Roeck <linux@roeck-us.net>
>>
>> Unaligned 64-bit accesses were found in Linux to clobber carry bits,
>> resulting in bad results if an arithmetic operation involving a
>> carry bit was executed after an unaligned 64-bit operation.
>>
>> hppa 2.0 defines additional carry bits in PSW register bits 32..39.
>> When restoring PSW after executing an unaligned instruction trap,
>> those bits were not cleared and ended up to be active all the time.
>> Clearing bit 32..39 in psw prior to restoring it solves the problem.
>>
>> Fixes: 931adff31478 ("target/hppa: Update cpu_hppa_get/put_psw for hppa=
64")
>> Cc: Richard Henderson <richard.henderson@linaro.org>
>> Cc: Charlie Jenkins <charlie@rivosinc.com>
>> Cc: Helge Deller <deller@gmx.de>
>> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
>> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>> =C2=A0 target/hppa/helper.c | 7 ++++++-
>> =C2=A0 1 file changed, 6 insertions(+), 1 deletion(-)
>>
>> diff --git a/target/hppa/helper.c b/target/hppa/helper.c
>> index 859644c47a..7b798d1227 100644
>> --- a/target/hppa/helper.c
>> +++ b/target/hppa/helper.c
>> @@ -76,7 +76,12 @@ void cpu_hppa_put_psw(CPUHPPAState *env, target_ulon=
g psw)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 psw &=3D ~reserved;
>> -=C2=A0=C2=A0=C2=A0 env->psw =3D psw & ~(PSW_N | PSW_V | PSW_CB);
>> +=C2=A0=C2=A0=C2=A0 if (hppa_is_pa20(env)) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 env->psw =3D psw & ~(PSW_N =
| PSW_V | PSW_CB | 0xff00000000ull);
>> +=C2=A0=C2=A0=C2=A0 } else {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 env->psw =3D psw & ~(PSW_N =
| PSW_V | PSW_CB);
>> +=C2=A0=C2=A0=C2=A0 }
>
> https://patchew.org/QEMU/20240217015811.1975411-1-linux@roeck-us.net/
> was the better version.

Oh, yes. Will use that one in the pull request.
Thanks!
Helge


