Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C401C982C1
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 22:49:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6yQq-0005kd-D1; Wed, 16 Sep 2026 18:48:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1x6yQc-0005k1-QI
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 18:48:39 -0400
Received: from qs-2006f-snip6-7.eps.apple.com ([2a01:b747:3006:202::3c]
 helo=outbound.qs.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1x6yQb-0008FT-4a
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 18:48:34 -0400
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-1 (Postfix) with ESMTPS id
 1D9D31800164; Wed, 16 Sep 2026 22:48:30 +0000 (UTC)
X-ICL-RepId: 01a0ac68-49e3-7ed4-a8a8-7fce20dc83d1
X-ICL-Out-Info: HUtFAUMHWwJACUgBTUQeDx5WFlZNRAJCTQ1OHVwPUhxEDlYCVRcOVk1UF1sMWg5WMEwWQx9SD1sTTRlRAVJFVAIZHldQQgVCAlwcWg5DClAcXFZVHxcZUU0KWFsIWwQPH0wMUQJCBVZeSAsdBFQHXQVdVlACWktCBEtFaFwFXBxAF0gdX2pLVhQEDV0dRQ5WGVoMUg9bDhwWS1heBFNWDjEAPHJVB150XQk7AikaX3A2CFUKW3FaHzIMPAApDloFQwpOCi1CBUICXBxaDkMKUBxcVlUfCUtGCUkdDg5CGEYfVCdXAloKWx4=
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1789598912; x=1792190912;
 bh=DDubo+swun7WQowGjdMjnWbUBh4kkVNnqHA+1ZGSFw0=;
 h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To:x-icloud-hme;
 b=kbrwKCViC4285T3ws41I35iwxr1pTmfc/FGnIXiA8MJnGrgSrxh+EBtrIdlVZ8BSZiOYy7woaOwIXUlKc1M6iVwuNVfurZBTxXkrWjflhFlHwOQ+8OtozuacGxamn9vEpiq3h4Qmw9Lx3GUMKp436irJUleLL9cJUwBnrQMe1RW6BGGcznt0r/GLoJ4qAI99wqmrhSLKD+MCCZEcb6GylhhH5hFIVaPuKA90bdCeLCyh1I7oh553FpBIWJraYxyWYDWKtDk469Sr/4psrY6zDTBF7wTNCgwHpPe4r8UYA6UIFwP0UGMRcuHRLa9B7xYC6mAQqKs2KMER6OioCGpDfA==
mail-alias-created-date: 1752046281608
Received: from smtpclient.apple (unknown [17.57.155.37])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-1 (Postfix) with ESMTPSA id
 D93211800117; Wed, 16 Sep 2026 22:48:29 +0000 (UTC)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3901.100.1.1.11\))
Subject: Re: [PATCH] target/arm/whpx: fix uninitialized PhysicalAddressWidth
From: Mohamed Mediouni <mohamed@unpredictable.fr>
In-Reply-To: <2BF9A691-51CA-424D-84F4-AD62FB08721F@unpredictable.fr>
Date: Thu, 17 Sep 2026 00:48:17 +0200
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Pedro d'Aquino Filocre F S Barbuda <pbarbuda@microsoft.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <A9DA805F-0C1D-4BF1-96F1-B5D3D9173369@unpredictable.fr>
References: <LVXPR21MB7009F3FB78275620435BEEC6ADB92@LVXPR21MB7009.namprd21.prod.outlook.com>
 <2BF9A691-51CA-424D-84F4-AD62FB08721F@unpredictable.fr>
To: "Doug Cook (WINDOWS)" <dcook@microsoft.com>
X-Mailer: Apple Mail (2.3901.100.1.1.11)
X-Authority-Info-Out: v=2.4 cv=R+sO2NRX c=1 sm=1 tr=0 ts=6aab1cbf
 cx=c_apl:c_pps:t_out a=bsP7O+dXZ5uKcj+dsLqiMw==:117
 a=bsP7O+dXZ5uKcj+dsLqiMw==:17 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=mDV3o1hIAAAA:8 a=yMhMjlubAAAA:8
 a=74HSPsPGVx47i_QpgXgA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: 2LH7DRWiaqNVkfZCivfRgw886jHZT75O
X-Proofpoint-GUID: 2LH7DRWiaqNVkfZCivfRgw886jHZT75O
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE2MDMxOSBTYWx0ZWRfX3xqT1Q72E1VR
 Y1GZKJLrfWoPUlOpHM6M4uYyJMkIRR9SUQPq1a7vfM4xBvNDglt1zGWsAk53SJbF3Aw9yD8wI2Y
 W6qGPG9iHASYTOON6u/3qUulFTAyN9cVtGbfcwpldo898fYI+Ht1EHQ0DHVpEZN3iM0C6Mzr3mU
 o/klUgBOj5L4lQFkR5pUJ4CKFP/705gnRw/962LYYovd/dRJXYXLHY/XSAmcaHyA7Vaw2XPs2+2
 Qx+sXcBtAuAnYqRkV/y7xMe7wX9n+UA+yHfRODr7DNvNocNgksnZlWdOviFKlZNHHEcjXZ7s1qQ
 l9sNjwXAuKrlQvqOvk7OEQ/mlzQM+06tdHnGPF2wIHSiMtV/g8JaYWD+La+DBY=
X-JNJ: AAAAAAABLV97vrS9WlXPX/SFmmsjEI8aFWtvYDyf0X+TOWzgJIoeaXi9U+02oC1zYqPStZiyAuozZ+DxG9L14N1mH/YcuPii3vdwYr8ojnd+VKpPgJUly6pgz9qMih36oDUWWTsJCeapNeE7e0a07Cgj1fB48i22FhIm+IZ8AhWcb08/shlHxd6foaLnCe1Bo0IDmP/FPaLvREptozwK+EnrolikDTgKu4KAoDmtolELo+N5/ErxX4971ThJaLYwi+/ryhYiTbg57K8ziIqVsPTET+9wigOp3Z+yYWKsyqRSrKW0uP2JxSCa5SBQxMtRJ84AiQB/Np9YU7GsyadqGr8sFFLeWnC5auCohu+PkhUcfHVHxBeZS80cCslBks0JziAF1ujDbuJgix+ylgH8z2pRYSiM7NfYm8VvA2fhuVtcA8HdXB0hUOIczBiFCyMBk1uLw+cwRsgWgffjHyHm48Wu8A89zxkgnPfSL8ZJdpejVAngUBZBMTx6oj3+2cVjNXA1GOyllDYpPyHaVAijVDwwyyv0S+UqqsSAY6txyIB1t/ILQKuUNPoAEa6haqYmfEHZnylhDCaAnNWUqHHeARuK0/y8yZcc3RXNKJaF3qEAp0RmGqetZnE9aJNnwGgO06RWQDmkk2b07iR0A5BpXUEcPbfCuqQfEVWs2w54wKt4oW77XkgFb1p+kRordAy5h9Wsqp/OPVQ05azNxtfPWBfF2rz9yGvs+y8TIF7sZXO2dRU9V/HcBg+Qoc7efsddNazZ44BJwLtcIcm1IRdOrrSKdL2poG/PHSRB+jDmUzKcccht8ruNiy8pdwDTcBg9cyViH9lZmMTLUGjqWUEjUdqqqZNGgX2L0XDbQdTlePw5PJ4uZ5iBvXb14CUmWS4rksWGjvkYiy78wLvRCqi2WN6g+pb6O0S41yoDz5j1XgyinxQOn/WBtJDbhjesU3pZeRCSEDqaeyrBC+1rnWemEP8g9becHb4
 wxza2tahlY4OsbyHafqK10fmhfwNJSEUzcw+RYlaDBwB9/PkeCWPYWtEPcEUqeOtrFdKPkCncajIGcUjC1qXjpEEqODIXEFezGjpzKz+jg0RakgEQPEzZJTzHKfR2Gy99YWpnMnjxfAU44HSFgjNNXCop+PXI0OECs/Or9HMa22FKlb/H5UsKyWG+baiuBR09Ycn+0QaRnDCsN8qD2sG1A2XuitnZ0Lg5lvI0ZMQDk2A3CTGLz/nYrfTogxbxIp2c41swW29/kyf0ABFuBKUyuRxWdiXg66DKp7I02sFPsV0OTJgIKIps/Ht+4/PqSbXsmod2S1sDIBE9J4QfLGKU2QQAOEGa/7BoQCdnRvV4HOF0OItGcuv55jA=
Received-SPF: pass client-ip=2a01:b747:3006:202::3c;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.qs.icloud.com
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



> On 17. Sep 2026, at 00:12, Mohamed Mediouni <mohamed@unpredictable.fr> =
wrote:
>=20
>=20
>=20
>> On 16. Sep 2026, at 23:49, Doug Cook (WINDOWS) <dcook@microsoft.com> =
wrote:
>>=20
>> whpx_arm_get_ipa_bit_size() declares WHV_CAPABILITY whpx_cap on the
>> stack and initializes it only via WHvGetCapability(). If that fails, =
the
>> error is reported but execution falls through to
>> round_down_to_parange_bit_size(whpx_cap.PhysicalAddressWidth), =
reading
>> an uninitialized value.
>=20
> Hi,
>=20
> We have default values on the stack as initialised as 0 in QEMU.
>=20
>>=20
>> round_down_to_parange_index() searches pamax_map[] for the largest =
entry
>> that is <=3D the requested size and ends in g_assert_not_reached(). =
The
>> smallest valid PARange is 32, so any smaller value aborts QEMU.
>>=20
>> Fix by setting PhysicalAddressWidth to 32, the smallest
>> architecturally valid PARange.
>=20
> Where are you getting this condition? Is a certain Windows release =
broken
> there that I=E2=80=99m not aware of?
>=20
> Or is the hypervisor present check not happening early enough?

(On-list)

TL;DR at the end:

During a rebase before the initial WHPX merge, the fix for this
was dropped by mistake instead of a proper squash as was intended.

It was "whpx: arm64: check for physical address width after WHPX =
availability" at
https://lists.gnu.org/archive/html/qemu-devel/2025-10/msg07939.html

So I resubmitted that commit now.

>> Behaviour then becomes defined, and
>> where the guest memory map fits within that range initialization
>> continues on to the accelerator capability checks and their more
>> specific error messages.
>>=20
>> Fixes: ea475a5ebb00 ("whpx: arm64: clamp down IPA size")
>>=20
>> Signed-off-by: Doug Cook <dcook@microsoft.com>
>> ---
>> target/arm/whpx/whpx-all.c | 1 +
>> 1 file changed, 1 insertion(+)
>>=20
>> diff --git a/target/arm/whpx/whpx-all.c b/target/arm/whpx/whpx-all.c
>> index d106400686..dc70b33bc0 100644
>> --- a/target/arm/whpx/whpx-all.c
>> +++ b/target/arm/whpx/whpx-all.c
>> @@ -663,6 +663,7 @@ uint32_t whpx_arm_get_ipa_bit_size(void)
>>    if (FAILED(hr)) {
>>        error_report("WHPX: failed to get supported "
>>             "physical address width, hr=3D%08lx", hr);
>> +        whpx_cap.PhysicalAddressWidth =3D 32;
>>    }
>>=20
>>    /*
>> --=20
>> 2.55.0.vfs.0.8
>=20
>=20


