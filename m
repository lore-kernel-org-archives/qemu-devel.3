Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DAA0C87FCF
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Aug 2025 23:42:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uj4oT-0003gE-EJ; Mon, 04 Aug 2025 19:41:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1uj4oG-0003dZ-26
 for qemu-devel@nongnu.org; Mon, 04 Aug 2025 19:41:40 -0400
Received: from p-east3-cluster3-host1-snip4-7.eps.apple.com ([57.103.86.10]
 helo=outbound.qs.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1uj4oB-00055n-Qd
 for qemu-devel@nongnu.org; Mon, 04 Aug 2025 19:41:38 -0400
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-6 (Postfix) with ESMTPS id
 203D718001AD; Mon,  4 Aug 2025 23:41:31 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; bh=vtPrdTj52AQ6ufUuRNBwcbh1QiYGHjbdK8ARPNohER4=;
 h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To:x-icloud-hme;
 b=WXlSwy5jQmope45Tt/YRWvEY6IWLEUn2brdWVwOxUYvNd4Uwk3CWoHjAwUObKKyWnwV3Lwu+OiAU23mCD65SwVAHxcQp5oqMcwIrMkb46ZHEF2oSiUwWpxRz+Ew+YqzPvzRhVAVhe7AW4L1iyCkfND5Q49Aq0bMby6Xl+S9d5oT1fSDGjNZ7Qi99soych+fdbJ8XtU82Ozw5GonI4tcAeZrmfGCqh30Uo0a/fv0nXRQ7ltDhTyUBKxZOhyFqEbz80HTltGcrowyompbWd/y/Aq9C7g99G3Ho5iHTlCX/tT7t9vw3r175N5ORIA/WdM5pJv0tlSH5KehbqVkqstzghw==
X-Client-IP: 46.189.47.18
Received: from smtpclient.apple (qs-asmtp-me-k8s.p00.prod.me.com
 [17.57.155.37])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-6 (Postfix) with ESMTPSA id
 EC48D1800164; Mon,  4 Aug 2025 23:41:30 +0000 (UTC)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3860.100.5.1.1\))
Subject: Re: [PATCH v4 14/17] hw/arm, accel/hvf, whpx: unify
 get_physical_address_range between WHPX and HVF
From: Mohamed Mediouni <mohamed@unpredictable.fr>
In-Reply-To: <cb5aa557-aab8-4a6f-977b-b9d15a5c6799@linaro.org>
Date: Tue, 5 Aug 2025 01:41:19 +0200
Cc: =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <AC693163-AB0C-41AF-A291-2A8E5C5415DC@unpredictable.fr>
References: <20250804142326.72947-1-mohamed@unpredictable.fr>
 <20250804142326.72947-15-mohamed@unpredictable.fr>
 <e5bfbc26-de3d-4f4c-b15d-6c7ea1b29e49@linaro.org>
 <cb5aa557-aab8-4a6f-977b-b9d15a5c6799@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
X-Mailer: Apple Mail (2.3860.100.5.1.1)
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA0MDE0NSBTYWx0ZWRfX/Y5bKNLir3mC
 KXtVjHiPPTG19Jt9Fe+IKfMTY80PSRQYL1OtqXDZaBQKU6DP64CsQ+40el2WtK9stTdYNbkEGpt
 fjPiTL+HJXVArmN1aVSSZnS6ecykpU6R7WIXmp8TmLnoynAIvq7th9lZndhr6RPDJoaHBRgaN+v
 V5CFw3ysj9o7xAKrvl0VWKRAg5DFLb2hbEzLpirszVu+nhkwpRzBy7l9WXLvGUQInVasfsTg9uN
 xaqybULSZlk8oaIVUiWUzGal/GQ0qm8pIiLbxQgQo6z07Le7AP4qPMb2llEGRxAFBw3/YOvgE=
X-Proofpoint-GUID: SxgkFaQvESQOnni_-nO59xnqTcqmqhGw
X-Proofpoint-ORIG-GUID: SxgkFaQvESQOnni_-nO59xnqTcqmqhGw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-04_10,2025-08-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 suspectscore=0 clxscore=1030 adultscore=0 mlxscore=0 mlxlogscore=953
 malwarescore=0 phishscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2506270000 definitions=main-2508040145
Received-SPF: pass client-ip=57.103.86.10;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.qs.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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



> On 5. Aug 2025, at 01:13, Richard Henderson =
<richard.henderson@linaro.org> wrote:
>=20
> On 8/5/25 09:03, Philippe Mathieu-Daud=C3=A9 wrote:
>> On 4/8/25 16:23, Mohamed Mediouni wrote:
>>> Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
>>> ---
>>>   accel/hvf/hvf-all.c        |  7 +++++--
>>>   hw/arm/virt.c              | 41 =
++++----------------------------------
>>>   include/hw/boards.h        |  4 ++--
>>>   include/system/hvf_int.h   |  2 ++
>>>   target/arm/hvf-stub.c      | 20 -------------------
>>>   target/arm/hvf/hvf.c       |  6 +++---
>>>   target/arm/hvf_arm.h       |  3 ---
>>>   target/arm/meson.build     |  1 -
>>>   target/arm/whpx/whpx-all.c |  5 +++--
>>>   target/i386/hvf/hvf.c      | 10 ++++++++++
>>>   10 files changed, 29 insertions(+), 70 deletions(-)
>>>   delete mode 100644 target/arm/hvf-stub.c
>>> diff --git a/target/i386/hvf/hvf.c b/target/i386/hvf/hvf.c
>>> index 818b50419f..fa06e3b815 100644
>>> --- a/target/i386/hvf/hvf.c
>>> +++ b/target/i386/hvf/hvf.c
>>> @@ -225,6 +225,16 @@ int hvf_arch_init(void)
>>>       return 0;
>>>   }
>>> +uint32_t hvf_arch_get_default_ipa_bit_size(void)
>>> +{
>>> +    return 48;
>>> +}
>>> +
>>> +uint32_t hvf_arch_get_max_ipa_bit_size(void)
>>> +{
>>> +    return 48;
>> These don't make much sense on x86...
>=20
> They don't *not* make sense.  x86 does have two-stage translation, =
though it has both 48-bit and 52-bit translation.
>=20
> While this is only invoked from hw/arm/virt.c at present, I can see =
that by piping the path through accel/hvf/ means that x86 needs to =
provide the symbols.  Though perhaps they should just be =
g_assert_not_reached() stubs for now.
Random note that probably doesn=E2=80=99t change things: every Intel Mac =
has 48-bit, and extended addressing will never happen as macOS 26 is the =
last x86 macOS release.

The other option I think is just #ifdefing out if =
(mc->get_physical_address_range) in hvf_accel_init based on arch...

>=20
> r~


