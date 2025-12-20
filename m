Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 758E3D637B2
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Dec 2025 05:52:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vWpsW-0005Ni-AN; Sat, 20 Dec 2025 00:51:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vWpsS-0005Ly-UX
 for qemu-devel@nongnu.org; Sat, 20 Dec 2025 00:51:41 -0500
Received: from p-east3-cluster4-host7-snip4-9.eps.apple.com ([57.103.84.72]
 helo=outbound.qs.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vWpsL-0006Ke-LG
 for qemu-devel@nongnu.org; Sat, 20 Dec 2025 00:51:37 -0500
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-2d-10-percent-0 (Postfix) with ESMTPS id
 C18D43000092; Sat, 20 Dec 2025 05:51:28 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; bh=oP/Oc4m6kB5S3pWvoaZMt3sV0vBDz4Ty68HSqzKfyos=;
 h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To:x-icloud-hme;
 b=Swu/RhDRs5MoLo7DKQRuFGmxt9J4H/Ki0HByyxlT04y1ViBfdxmjxLCiJi78QC2iLFUTirPeIxVaVjj6CeYXXGHQoA5WDaQP98bTHGvYorRZ+dAlksQnE67Fi9CUrsiIDyZ/pdYorbgv0TogKRvRHD0TxrXb2BSF9b5A5uriYE5h5Y4KP99KrtFiB5jHsm5SyG1V1ZBoZmL6tvqwoVZaOZpf4Ce56DRgwG9cuKk4HY7pGj3A3KstzLOOXoQ4cemZNT+E1+Yw8BrRSXq4NDfTwwhLmAagJwZzWj+u2xhkTNkm9MJ3G7YqaPiUNegG7iDZDJagGquSFaIEEPbS6EBmgA==
mail-alias-created-date: 1752046281608
Received: from smtpclient.apple (unknown [17.57.155.37])
 by p00-icloudmta-asmtp-us-east-2d-10-percent-0 (Postfix) with ESMTPSA id
 92E963000106; Sat, 20 Dec 2025 05:51:26 +0000 (UTC)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.300.41.1.7\))
Subject: Re: [PATCH] hvf: support changing IPA granule size
From: Mohamed Mediouni <mohamed@unpredictable.fr>
In-Reply-To: <1C0540B1-1D8F-470B-8719-34CF03A93573@unpredictable.fr>
Date: Sat, 20 Dec 2025 06:51:14 +0100
Cc: qemu-devel@nongnu.org, Cameron Esfahani <dirty@apple.com>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>, Mads Ynddal <mads@ynddal.dk>,
 Alexander Graf <agraf@csgraf.de>, Peter Maydell <peter.maydell@linaro.org>,
 "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <1F07D7C2-791A-4ED5-8813-92B952274848@unpredictable.fr>
References: <20251219183716.4379-1-j@getutm.app>
 <1C0540B1-1D8F-470B-8719-34CF03A93573@unpredictable.fr>
To: Joelle van Dyne <j@getutm.app>
X-Mailer: Apple Mail (2.3864.300.41.1.7)
X-Authority-Info: v=2.4 cv=Ic+KmGqa c=1 sm=1 tr=0 ts=69463961 cx=c_apl:c_pps
 a=bsP7O+dXZ5uKcj+dsLqiMw==:117 a=bsP7O+dXZ5uKcj+dsLqiMw==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=0bx1jPMI5ibwf_58FhwA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: DER-vi1Tb8A8rgXNKTXPfnP0fk-_5cTh
X-Proofpoint-GUID: DER-vi1Tb8A8rgXNKTXPfnP0fk-_5cTh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjIwMDA0MiBTYWx0ZWRfX7La68Uwg/V4g
 mMut78p6nk59myk3YUnpKXOaKlhg458bDGYT5lpfRqPbXdgTX4mPTXLG0O+t70Nl1KcIqhA456u
 njLF6bhuo5dtuTzOe30sZVbuAwru+QVqnw9i7Md8x9a7kRUBzAvYhOpMpERUB8nOqiaDGXvJIap
 VIFbYjUjT+dlSppf99fSvTrLHiCJfSX9nNErTCoy+5pfGVYvmSUc5bwR9rzUNZ3s7pA20pvhPHd
 rE7pPdGSHuuCoLilBlvAkjMacT7X4HXR7aHdoRq93Nit0xynrwuoSX2Qk487ap40WXpnL0rp9vc
 yz5/qghWy74MJYQShmU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-19_08,2025-12-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=595
 clxscore=1030 bulkscore=0 malwarescore=0
 phishscore=0 spamscore=0
 adultscore=0 suspectscore=0 mlxscore=0 classifier=spam authscore=0 adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512200042
X-JNJ: AAAAAAABcSHweMVIgRGA4eJ3tG41GWT7/MP9ETBPsNnisfvYYTHHXbjlOmEVYjKwM8EiGdvHShFnJulYsurnufGyef+EjKHJsiG9l9i2fqFDL4JkjrXaIwEXijMkDA4amyuvnYdRpbzNVlKvRGebp2zfPpoHRL2QisfZ66iz97Niw9txCvsssXQMMvrO8M+lY2Wq4QAwXRTVvZg7JJX7v6G+XHaiQSnlxfHEm+Tv9AOcrG0sJKsdi8LAh/FSiaoGHWzI0Bjje74v2dlyHNZJoVBdVHnJOaeESpV8UkOkbvFnaquBr3cOdU5yNATy2vCaTacCnluqauGgIa+JiSnIfQr2z8A8g9p8ngHU8Beqk8ksapM8/Wc/31M9j4bx5NdooVyrM34B41ujIyPMPZ4vuz3O6Tn+xWH2J6W9IGu1OWrHfDqd2LCuF9O+1eM+AZM+4LGfxJPE3hkMKmT7qAx7TzKK2m3aSFN1zlfDXbFBmvf8ovQZk8A6u8EMRmSNDahEKA/938KOQVR4rpXFGj1J9XFdDcTJkggNf1aZ5kjOrvRFUm2k//h/+85gibBrUnMFYOR7g3dQbHCLmxc4Dkv88g4SjOVT2KS6sF6oeh8XPMbOfomRgT/stPM+u6KPOCY8AsVHCFD57+aWe4xhdvaLcMvags5n0Yi6HfssFYceyfd5rKd9AT7QCnZltTivKcHGZqNB7tc=
Received-SPF: pass client-ip=57.103.84.72;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.qs.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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



> On 19. Dec 2025, at 19:46, Mohamed Mediouni <mohamed@unpredictable.fr> =
wrote:
>=20
> Hello,
>=20
>> On 19. Dec 2025, at 19:37, Joelle van Dyne <j@getutm.app> wrote:
>>=20
>> The IPA granule is the smallest page size hv_vm_map() support. For =
Venus, we
>> need to support 4KiB pages. macOS 26 introduces a public API for =
setting
>> the granule size. We can only use this when compiled with macOS 26 =
SDK and
>> run on macOS 26+. Otherwise, we fall back to an older, private, API =
which
>> achieves the same purpose.
>>=20
>=20
> Let=E2=80=99s have an HVF_NO_PRIVATE_API define (or the opposite) to =
have a single toggle to disable all private API use at build time
>=20
>> +
>> +    /* older macOS need to use a private API */
>> +    if (!set_ipa_granule) {
>> +        set_ipa_granule =3D dlsym(RTLD_NEXT, =
"_hv_vm_config_set_ipa_granule");
>> +    }
>> +    if (set_ipa_granule) {
>> +        return set_ipa_granule(config, ipa_granule_size);
>> +    } else if (ipa_granule_size !=3D page_size) {
>> +        error_report("Failed to find =
_hv_vm_config_set_ipa_granule");
>> +        return HV_UNSUPPORTED;
>> +    }
>> +
>> +    return HV_SUCCESS;
>> +}
>> +
>> +hv_return_t hvf_arch_vm_create(MachineState *ms, uint32_t pa_range,
>> +                               uint32_t ipa_granule_size)
>> {
>>    hv_return_t ret;
>>    hv_vm_config_t config =3D hv_vm_config_create();
>> @@ -891,6 +932,13 @@ hv_return_t hvf_arch_vm_create(MachineState *ms, =
uint32_t pa_range)
>>    }
>>    chosen_ipa_bit_size =3D pa_range;
>>=20
> The PA range is actually different depending on the IPA granule size.
>=20
> An example from M4 Max:
>=20
> % sysctl -a | grep ipa
> kern.hv.ipa_size_16k: 4398046511104
> kern.hv.ipa_size_4k: 1099511627776
>=20
Looks like the Apple APIs will always return the smallest supported IPA =
space size instead of the current one
so this is actually ok - but doesn=E2=80=99t provide access to the =
bigger IPA space the hardware supports unless explicitly queried via =
sysctl=E2=80=A6

Something else to add as private API use I guess...
>>  +    if (ipa_granule_size) {
>> +        ret =3D hvf_set_ipa_granule(config, ipa_granule_size);
>> +        if (ret !=3D HV_SUCCESS) {
>> +            goto cleanup;
>> +        }
>> +    }
>> +
>>    ret =3D hv_vm_create(config);
>>=20
>=20
>=20


