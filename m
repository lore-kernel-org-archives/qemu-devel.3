Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D300C43458
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2026 12:53:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfdOJ-00045k-QZ; Fri, 03 Jul 2026 08:53:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1wfdOG-00045V-6A
 for qemu-devel@nongnu.org; Fri, 03 Jul 2026 08:53:09 -0400
Received: from mout.gmx.net ([212.227.15.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1wfdOE-0007wP-2W
 for qemu-devel@nongnu.org; Fri, 03 Jul 2026 08:53:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1783083184; x=1783687984; i=deller@gmx.de;
 bh=Rat0OBN+zgajZ5Xwhohj0KLfn87vY2epUMhfFMGsI40=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=C0Q0Junrf10R82MlkC05u00U1g3sFkFSWwlRSpNkete5lnJLP6ctIee7bhP3rtwU
 kYbbejoGv7ZfXciYWEJoOX7C04LEm2dZahZtHiJ1p+/gGFd7k2OriAYNZW++zzVHN
 Cb0UN4f6PPteRX7vnkkZWCTCsv8H0rFl31RK0SlYmR02JH23h5SopF2DwilHnyyIj
 0kBdKRKe6dJHpGeM4SzfxfxZYBkSrZbU28q0EMbxMEWHAp6Y66juJbbRzrskQY6vJ
 6rrxHWGsI12FpPbJG6P/K6zNGcHCePZ+Ezpnv/zJCrQXbMrQPiqddKhm6J4tb8V0j
 g2dxAPUorSKWzsBF6w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1McpNo-1xE97t48AM-00m2jF; Fri, 03
 Jul 2026 14:53:04 +0200
Message-ID: <7dd708c1-de14-4ed2-8e0d-1cd99e5a60cb@gmx.de>
Date: Fri, 3 Jul 2026 14:53:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/hppa: Work around Fast TLB insert instruction for
 HP-UX 9
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Helge Deller <deller@kernel.org>, richard.henderson@linaro.org,
 qemu-devel@nongnu.org
References: <20260702224241.29866-1-deller@kernel.org>
 <6db9c705-004d-4ce4-bc8f-3c264127578a@oss.qualcomm.com>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <6db9c705-004d-4ce4-bc8f-3c264127578a@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:SUIzm3erxVVd5rKIJn+p60ntHad6RKypdcDCax7LiksDlmyg5nh
 EPxEmwVQ2O75xQWY/Hz6Hr9ogHFjl25v/2B8NrD4luA9FIH9QDK5Ra7wmOfgXRkF0i4yA+f
 bAYvoBAy/lJbVv3dbI0laFISltMbOZcQDXk4mr0IVI7znWHFyeOU/x34S+XG0eVaDLUizam
 3Dwqzo+SxOuTFvMrIUVzA==
UI-OutboundReport: notjunk:1;M01:P0:OOSU71ROCAg=;mx8GeUVfmUEL2MGK73nrLnz4nO4
 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
 9Y/EzzpmixXTwZFIHQ=
Received-SPF: pass client-ip=212.227.15.15; envelope-from=deller@gmx.de;
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

On 7/3/26 03:58, Philippe Mathieu-Daud=C3=A9 wrote:
> On 3/7/26 00:42, Helge Deller wrote:
>> From: Helge Deller <deller@gmx.de>
>>
>> The HP-UX 9 kernel uses two TLB insert instructions (0x05315440 and
>> 0x05385400), which seem to be wrongly encoded fast TLB instructions, bu=
t
>> similiar to the non-fast instructions idtlba r17,(r9) and
>> idtlbp r24,(r9).
>>
>> It's not clear, if those undocumented instructions were used by mistake=
,
>> or intentionally. Either way, this patch allows qemu to handle those
>> instructions, so that a HP-UX 9 boot-CD can now boot somewhat further (=
but
>> still crashes due to other reasons afterwards).
>>
>> Signed-off-by: Helge Deller <deller@gmx.de>
>> ---
>> =C2=A0 target/hppa/insns.decode |=C2=A0 4 ++--
>> =C2=A0 target/hppa/translate.c=C2=A0 | 11 +++++++++++
>> =C2=A0 2 files changed, 13 insertions(+), 2 deletions(-)
>>
>> diff --git a/target/hppa/insns.decode b/target/hppa/insns.decode
>> index 13c6a55bf2..837a0b73e6 100644
>> --- a/target/hppa/insns.decode
>> +++ b/target/hppa/insns.decode
>> @@ -162,8 +162,8 @@ ixtlbx=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 000001 b:5 r:5 sp:2 0100000 addr:1 0 00000=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 data=3D1
>> =C2=A0 ixtlbx=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 000=
001 b:5 r:5 ... 000000 addr:1 0 00000=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 \
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sp=3D%assemble_sr3x data=3D0
>> -# pcxl and pcxl2 Fast TLB Insert instructions
>> -ixtlbxf=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 000001 00000 r=
:5 00 0 data:1 01000 addr:1 0 00000
>> +# pcxl and pcxl2 Fast TLB Insert instructions (with HP-UX 9 workaround=
)
>> +ixtlbxf=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 00=
0001 b:5 r:5 0- 0 data:1 01000 addr:1 0 00000
>> =C2=A0 # pa2.0 tlb insert idtlbt and iitlbt instructions
>> =C2=A0 ixtlbt=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 000=
001 r2:5 r1:5 000 data:1 100000 0 00000=C2=A0=C2=A0=C2=A0 # idtlbt
>> diff --git a/target/hppa/translate.c b/target/hppa/translate.c
>> index 4e34822565..72bc881784 100644
>> --- a/target/hppa/translate.c
>> +++ b/target/hppa/translate.c
>> @@ -2666,6 +2666,17 @@ static bool trans_ixtlbxf(DisasContext *ctx, arg=
_ixtlbxf *a)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *=C2=A0=C2=A0=C2=A0 return gen_ill=
egal(ctx);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
>> +=C2=A0=C2=A0=C2=A0 /*
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * The HP-UX 9 kernel uses two undocumented in=
structions 0x05315440 and
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * 0x05385400, which seem to be wrongly encode=
d fast TLB instructions,
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * similiar to idtlba r17,(r9) and idtlbp r24,=
(r9).
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * To support HP-UX 9, check b against 0 (docu=
mented) and 9 (to allow the
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * r9 case), and genenerate an illegal instruc=
tion trap otherwise.
>=20
> Typo "generate".
>=20
>> +=C2=A0=C2=A0=C2=A0=C2=A0 */
>> +=C2=A0=C2=A0=C2=A0 if (a->b !=3D 0 && a->b !=3D 9) {
>=20
> s/&&/||/?
>=20
> But since @b is not consumed otherwise, what about dropping it from
> the decoder instead?
>=20
>  =C2=A0 ixtlbxf=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 000001 00000 r:5 0- 0 data:1 01000 addr:1 0 00000
>  =C2=A0 ixtlbxf=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 000001 01001 r:5 0- 0 data:1 01000 addr:1 0 00000

Yes, that's better.
I'll fix it accordingly.

Thanks!
Helge

