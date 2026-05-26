Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 599E8CD5BC8
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2026 18:41:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRwhI-0001lI-Oa; Tue, 26 May 2026 14:40:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>)
 id 1wRwh7-0001jy-Ml; Tue, 26 May 2026 14:40:02 -0400
Received: from mout.gmx.net ([212.227.15.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>)
 id 1wRwh5-0007ow-6G; Tue, 26 May 2026 14:40:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1779820786; x=1780425586; i=deller@gmx.de;
 bh=Eg2AOc2iUbW4fgDXTwfIPVXOkVMDI09uDP9nFsp78ps=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
 cc:content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=ZY2VCmtX+AFrnUil+Kg1n07APTyJ+PXfsuY3aM3/GLDtILuldk+G4rjsjPQxmHVr
 JblCsJxBymZATpbgVwOnZ8VtIdbj6zpqo/6VTLjY/qoYQFi58h+PS9Vh34ejqbZ5j
 oWT8v3SG0PvgU7B9OMuwYsLpMu7+2s5XWkQXHrU7Pwf6ssscUadkC4YA7KoRsDRsX
 mH9wa575pYdl9kGy79LhLDtDTJjm9URdh70TmX+BfapzPxDjzCmc14F5dsBm9UxiJ
 625vJANkasTA0n1bXPgZFg5FbFolwxQnkH0R+wxZyfIuvmyIXIyCzB8hVnLXM342J
 rODfeTY+unaPy9zoVw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mg6e4-1wyGpo0aP0-00iT13; Tue, 26
 May 2026 20:39:46 +0200
Message-ID: <513e471b-0368-4426-b9c4-76ec729320e1@gmx.de>
Date: Tue, 26 May 2026 20:39:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] linux-user/s390x: restore fpu_status rounding mode
 from FPC on sigreturn
From: Helge Deller <deller@gmx.de>
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
 <c41af5dc-3f5d-48e2-b28d-770e86be7cba@gmx.de>
Content-Language: en-US
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <c41af5dc-3f5d-48e2-b28d-770e86be7cba@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:CSqwXJyYpHDZAQfdBSsJULLWiPAGZ7/egZ+P55cyTwX5yERT7X3
 n9uqGyR3ZwZFANuRq/5H0rrVw4qv4k6Oi8OsTNFJjFet+9U3LMoBjgl9wS9uL/xxaBuW3Nr
 GkleCXC94FnL0BMJDMyEHxyc0l42N00PJe9kQvooub+7jltPAz6CIPo04/GTdsoSo9jj0Ww
 hr/Nuf/fb7wh9nLQ1+v8Q==
UI-OutboundReport: notjunk:1;M01:P0:D71VVH5g9kQ=;Lj6thtloVFaCBSOdwmIa2Zmznty
 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
 i0BDBnIqyHLwKTL1xzZ2qSn4wZusFOg4jfJDkzZ
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

On 5/26/26 17:10, Helge Deller wrote:
> On 5/26/26 17:05, Matt Turner wrote:
>> QEMU keeps the s390x floating-point control register (FPC) in env->fpc.
>> The rounding mode bits [2:0] of FPC are reflected into the derived
>> env->fpu_status via set_float_rounding_mode(); every architectural
>> write to FPC goes through HELPER(sfpc) which keeps the two in sync.
>>
>> restore_sigregs() restored FPC with a direct assignment:
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0 __get_user(env->fpc, &sc->fpregs.fpc);
>>
>> This wrote env->fpc correctly but never updated env->fpu_status, so on
>> sigreturn the interrupted code resumed with whatever rounding mode the
>> signal handler last installed in fpu_status.
>>
>> Factor the two-step "write fpc + sync fpu_status" logic out of
>> HELPER(sfpc) into cpu_s390x_load_fpc(), declare it in cpu.h, and call
>> it from restore_sigregs() in place of the direct assignment.
>>
>> cpu_s390x_load_fpc() partially reuses the sanity check from
>> HELPER(sfpc): if the FPC value has an invalid rounding mode or reserved
>> bits set, it falls back to 0, matching the kernel's fpu_lfpc_safe()
>> behavior where a corrupt signal frame value causes a specification
>> exception and 0 is used instead.
>>
>> HELPER(sfpc) now calls cpu_s390x_load_fpc() after its full
>> specification-exception check, including the FEAT_FLOATING_POINT_EXT
>> test that is not needed for the signal restore path.
>>
>> Fixes: 2941e0fa05 ("linux-user/s390x: Save/restore fpc when handling a =
signal")
>> Cc: qemu-stable@nongnu.org
>> Signed-off-by: Matt Turner <mattst88@gmail.com>
>> ---
>> =C2=A0 linux-user/s390x/signal.c=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 6 ++++=
+-
>> =C2=A0 target/s390x/cpu.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 1 +
>> =C2=A0 target/s390x/tcg/fpu_helper.c | 20 ++++++++++++++------
>> =C2=A0 3 files changed, 20 insertions(+), 7 deletions(-)
>>
>> diff --git ./linux-user/s390x/signal.c ./linux-user/s390x/signal.c
>> index 96d1c8d11c..28ad80bde4 100644
>> --- ./linux-user/s390x/signal.c
>> +++ ./linux-user/s390x/signal.c
>> @@ -332,7 +332,11 @@ static void restore_sigregs(CPUS390XState *env, ta=
rget_sigregs *sc)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 for (i =3D 0; i < 16; i++) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __get_user(env->=
aregs[i], &sc->regs.acrs[i]);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> -=C2=A0=C2=A0=C2=A0 __get_user(env->fpc, &sc->fpregs.fpc);
>> +=C2=A0=C2=A0=C2=A0 {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uint32_t fpc;
>=20
> to avoid putting this block into braces, can't fpc be moved some lines a=
bove,
> where the other variables are declared?

Forget this. ^^^
I see it's used like this in various places across architectures, so
let's keep it like you have in this patch here.

Helge

