Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C23C3CDB479
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2026 21:18:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcUz3-0007Ln-Nv; Wed, 24 Jun 2026 17:18:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1wcUz1-0007Lb-P5
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 17:18:07 -0400
Received: from mout.gmx.net ([212.227.15.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1wcUyz-0005I2-Ty
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 17:18:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1782335871; x=1782940671; i=deller@gmx.de;
 bh=L2Dolwwui+YISEqZ6L/3jlrBqVCuqYGGxcTI1+PKn1k=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=rK1KjO+7dKagi14oqplUrNl2CBMBfRIfmm9qNwWefhKBPxLu7mMC3UFVRa6BtSsA
 Uu/NPSRDCERY7XWMRC69vaI+XyFsfKWmP0gbgzI+FLDMqrrtFW/3pTEQMFebqhqV6
 ELMmJGexSwku9TsUYqBrYpZXmr4xkIetirjisfOfZH/pXgEnrEUlelk+sTi1qEMtn
 9/7j2EsK3lLCrzfZOdETYA8o3ZMak2giiCPUIx15quLwFx1VIl/5qyVXZ5z+FMuFl
 /gDwBTHZgNA/9hipST9fYvyBDyUUk7ex4t4TVF05FHM1arBptfCnuZxEwfanFVuJt
 zPd0/6THi5D1uK4Y/A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MtOGa-1xQc1Q3g9G-010OSi; Wed, 24
 Jun 2026 23:17:50 +0200
Message-ID: <1727f2bc-162a-479d-bcdd-87b58d139913@gmx.de>
Date: Wed, 24 Jun 2026 23:17:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] linux-user/xtensa: save/restore FP registers across
 signal delivery
To: Michael Tokarev <mjt@tls.msk.ru>, Matt Turner <mattst88@gmail.com>,
 qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Max Filippov <jcmvbkbc@gmail.com>
References: <20260610152648.677463-2-mattst88@gmail.com>
 <20260612141406.1211912-1-mattst88@gmail.com>
 <e17b14a6-575e-4b7f-9a3c-6ace863602d0@tls.msk.ru>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <e17b14a6-575e-4b7f-9a3c-6ace863602d0@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:JsMd3BMMOUNze41I0rz2tmtfexdyV5hHbiNDjXhBLM/ZpG5LOP2
 DkCxKxTeTrrr3o9qrlgEC7tR7HKJ0GnXrTJmGQOmltwIVUoK1r1VL+HSdwdNVjYS/t0PjJr
 3/ibdIoKknS5Ex5f81nAXzRingHqECzJQezpkgkWL48jgdKSXVG3TjgOwxEu4Fgt/+Wu4dy
 fhyWihf9fkPqwoqVrhMcg==
UI-OutboundReport: notjunk:1;M01:P0:hzdNoMj/fsg=;yxwcdbJuQBH7rH9K61A7yWdEPIg
 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
 w1N86JhoY=
Received-SPF: pass client-ip=212.227.15.15; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 6/24/26 00:04, Michael Tokarev wrote:
> On 12.06.2026 17:14, Matt Turner wrote:
>> Add support for saving and restoring f0-f15 across signal delivery.
>> The target_xtensa_xtregs_fp struct carries 32-bit f-regs for cores
>> with XTENSA_OPTION_FP_COPROCESSOR; target_xtensa_xtregs_dfp carries
>> 64-bit f-regs for cores with XTENSA_OPTION_DFP_COPROCESSOR.
>>
>> Lock the xtregs region via lock_user before reading on sigreturn,
>> since sc_xtregs is a user-space pointer that may lie outside the
>> locked sigframe.
>=20
> Now this is kind of fun.
>=20
>> @@ -282,7 +360,9 @@ long do_rt_sigreturn(CPUXtensaState *env)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 target_to_host_sigset(&set, &frame->uc.t=
uc_sigmask);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 set_sigmask(&set);
>> -=C2=A0=C2=A0=C2=A0 restore_sigcontext(env, frame);
>> +=C2=A0=C2=A0=C2=A0 if (!restore_sigcontext(env, frame)) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto badframe;
>> +=C2=A0=C2=A0=C2=A0 }
>=20
> There's another patch for linux-user/xtensa which is queued up for
> the stable series:
>=20
> 54e08dbe8f linux-user/xtensa: fix unlock of uninitialized frame pointer =
on sigreturn
>=20
> This patch (fix unlock of frame pointer) removes `goto badframe` from
> this same function.=C2=A0 With that patch applied, the compiler complain=
s:
>=20
>  =C2=A0linux-user/xtensa/signal.c: In function =E2=80=98do_rt_sigreturn=
=E2=80=99:
>  =C2=A0linux-user/xtensa/signal.c:293:1: error: label =E2=80=98badframe=
=E2=80=99 defined but not used [-Werror=3Dunused-label]
>  =C2=A0cc1: all warnings being treated as errors
>=20
> and the build fails.
>=20
> But this works on master because of this patch (6858e3a71c save/restore
> FP registers").
>=20
> So, I should either extend 54e08dbe8f in stable series to remove the
> now-unused label, or include this 6858e3a71c change *too* (with the
> previous 7e859bacea).
>=20
> Does it hurt to pick 7e859bacea and 6858e3a71c to the stable series?
> This feels like another bugfix too, but a bit more involved.=C2=A0 And i=
t
> builds at passes all tests, at least.

I suggest to pull in all patches to keep difference to head minimal.

Helge

