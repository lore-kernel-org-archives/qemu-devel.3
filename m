Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93A8ED2FED4
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Jan 2026 18:36:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkntH-0004Ya-GN; Tue, 27 Jan 2026 13:34:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vknqo-00083e-9s
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 13:31:50 -0500
Received: from p-west3-cluster2-host2-snip4-7.eps.apple.com ([57.103.74.120]
 helo=outbound.ms.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vknqk-0004Jm-Ks
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 13:31:40 -0500
Received: from outbound.ms.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-3a-100-percent-4 (Postfix) with ESMTPS id
 85ADE1800CE3; Tue, 27 Jan 2026 18:31:29 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1769538692; x=1772130692;
 bh=sqyPOFWqsQ9KJywIJYuJ0LA9jE4orTdr3yqvYdonyjA=;
 h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To:x-icloud-hme;
 b=UrX7EymZqixpcHtu+oNoxP18u+1i402C9ycDRzDyoIyhIVoEindcQLEY5J4oC1XOs6ug4UA7XllgFfi0+I5n6qRsA7k/C0faih1XMGIyy6BF/PtByuu/LTymNA+MeOvicVP2AohaMIKCA51AX+3MKV7gNJtIRGr9ag4TblTbDjL8mO1GCC4zCMwqil8vQklVmWn8VlFFE6WjavjZLPz3I2jHtp5oM7DnhW6HXQDRoFxfISCulXUShQjvFB5OCAB65ojgdtnS8fX9ITm3BnhmKWG72NMvjlI5HMEayDWVOHXJv6hLsI7tAaEkGirSPmfeGI+nUlwDKw+fFW2o9bh1DQ==
mail-alias-created-date: 1752046281608
Received: from smtpclient.apple (unknown [17.57.154.37])
 by p00-icloudmta-asmtp-us-west-3a-100-percent-4 (Postfix) with ESMTPSA id
 6F09518000F0; Tue, 27 Jan 2026 18:31:25 +0000 (UTC)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.300.41.1.7\))
Subject: Re: [PATCH v17 03/21] hw: arm: virt: rework MSI-X configuration
From: Mohamed Mediouni <mohamed@unpredictable.fr>
In-Reply-To: <20260127102534-mutt-send-email-mst@kernel.org>
Date: Tue, 27 Jan 2026 19:31:12 +0100
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>, Alexander Graf <agraf@csgraf.de>,
 Igor Mammedov <imammedo@redhat.com>, Cameron Esfahani <dirty@apple.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-arm@nongnu.org, Shannon Zhao <shannon.zhaosl@gmail.com>,
 =?utf-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, Roman Bolshakov <rbolshakov@ddn.com>,
 Ani Sinha <anisinha@redhat.com>, Pedro Barbuda <pbarbuda@microsoft.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <54440B7F-B42B-4A3A-AD6A-4FE9916428E8@unpredictable.fr>
References: <20260121134114.9781-1-mohamed@unpredictable.fr>
 <20260121134114.9781-4-mohamed@unpredictable.fr>
 <CAFEAcA-GL9UG5MN5tKDzLwQ04cBGa99cSau4=2BLTs0+GGSdJw@mail.gmail.com>
 <51E78FA9-2C66-4E8E-947F-F009A8AEEDFD@unpredictable.fr>
 <CAFEAcA_7o-dNFUgMo=UdYD_cf=dwbMCy6b+_2SRSxVbDmmAUmw@mail.gmail.com>
 <9ECB5E0B-3BD3-47D3-9E6B-204A354CEA84@unpredictable.fr>
 <CAFEAcA_g3VfRectVpUG-OnLh_AtsqpLt7YYrYXDSfiesS5EuKw@mail.gmail.com>
 <20260127102534-mutt-send-email-mst@kernel.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
X-Mailer: Apple Mail (2.3864.300.41.1.7)
X-Proofpoint-GUID: 6FNgzovoOVBkwO1yoqxY_YLWS_HxW6qs
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI3MDE1MSBTYWx0ZWRfX8U56HIT3B+SV
 J9p/eSApcBSDMrr1voYAtdUjdeP7sTn7opK1D9g9ELcsXFkabJOQMCyG+xJL2dGIXKS5VU4SkVX
 wwVTWSKEPe+9NHWo0wcOB5Eajw70Hj1/kgWnaEUXQTZ6RaOwet1CRJJs4Qwg6TKLtX5hrNIDask
 YuqKPq73SDMDKgwe9cPdvixtNTekRsRpVxxScl4v513P2qyPNcdI0u/efDzatOO4m1wr2FzLQPv
 9HegQ8fVH2cPjwAYyr0FP8XNXYbhA+1hbhi8F0GvzavRjSNjGbdrNiNzl0GjUb4eG6PXPbhmbNO
 SxCQoQDrgBb5OmCveyU
X-Proofpoint-ORIG-GUID: 6FNgzovoOVBkwO1yoqxY_YLWS_HxW6qs
X-Authority-Info-Out: v=2.4 cv=MtFfKmae c=1 sm=1 tr=0 ts=69790483
 cx=c_apl:c_apl_out:c_pps a=qkKslKyYc0ctBTeLUVfTFg==:117 a=IkcTkHD0fZMA:10
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=20KFwNOVAAAA:8 a=KKAkSRfTAAAA:8
 a=wKKgmu9azzEBwTzVMMoA:9 a=QEXdDO2ut3YA:10 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-27_04,2026-01-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 phishscore=0 malwarescore=0 clxscore=1030 bulkscore=0 spamscore=0
 adultscore=0 mlxlogscore=999 suspectscore=0 classifier=spam authscore=0
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2601270151
X-JNJ: AAAAAAABhT9b3fB8IC0qypCPK64O3LC8B/5T+ttsLS9B71+/pmAmCFGgyoaYBNfDCC1DliBzHySO3zLMCJULY3kVPxiMMJZzBYENAJ8YbZtP+jSZydKE4aYw54hVzUL4aA6GQ2P3iRX9HbMzN0oFjG3cJfOK+jAoqYInPD3CPkG9C66krfljSjy1cSFl7SwzNQK6yXQo/0wmJPD8uPk/BQq6P7DJ3ohBswS25TXp+Gbo1xtSTV7yR6qeR5SBka+m9iFjdc2Hsus0mQqnT8Mwo1mmZWF+srv89oIrgTdZScrt84sqlYaB92mc3m2qfazFjmqjZ+zSb7ZpW0F8xDroIt3T7lx9VdrJGFeZUnzGGg+OueqmK1+XMSdA7AdhY8R3pqGPbCZhTzQCzW0PSFoMHjJyy/eBVhI+QJfoLJsnYZWh8JO9lWc10tYwU0i6wH2xVYnsWa/BNU9vW3IhzoT4svoj4P4xQ0Bdv8RCKMCk5Fdv7Vfo4k1NJABZOxKtbvg6WwWSwlE4rzUoFpXGPLwZU6aNu7Q8alAOhQdmW2TY1lyX/OVSGzmG8XmljDY9uAgz6gY1RtaQsqsyM7dRHM2jmKr3AZ/MUgYywFAfeys/7+xucLkUqfKqa5qQXii0zldmAA8wueVH4Ah6p+Nll6lqN6AgMsaPVWsvnWDujlJ7fHt8x8EOfzl+0luUhnNyyzhqnq3wXyAoodgpS9fyadPluCeyMcDs3UK6UjmGdM41LuBUw9hB7rNOsX0j6NletngVDDBrvcPfnWDEwI3ECyBJb/dT2IRrE7bM0a5/oobzDEN5Uuv55zP6hxOSnlkkBUhFuwFnJslas9BKxOSS4bp4rZYwB6jwY5vc6CywXVkEPT5ubMqLNcONXMfh92RWj6RfvDR2
Received-SPF: pass client-ip=57.103.74.120;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.ms.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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



> On 27. Jan 2026, at 16:34, Michael S. Tsirkin <mst@redhat.com> wrote:
>=20
> On Tue, Jan 27, 2026 at 02:10:08PM +0000, Peter Maydell wrote:
>> On Tue, 27 Jan 2026 at 13:40, Mohamed Mediouni =
<mohamed@unpredictable.fr> wrote:
>>>=20
>>>=20
>>>=20
>>>> On 27. Jan 2026, at 13:54, Peter Maydell <peter.maydell@linaro.org> =
wrote:
>>>>=20
>>>> On Tue, 27 Jan 2026 at 12:46, Mohamed Mediouni =
<mohamed@unpredictable.fr> wrote:
>>>>>> On 27. Jan 2026, at 11:54, Peter Maydell =
<peter.maydell@linaro.org> wrote:
>>>>>>=20
>>>>>> On Wed, 21 Jan 2026 at 13:41, Mohamed Mediouni =
<mohamed@unpredictable.fr> wrote:
>>>>>>> +/*
>>>>>>> + * In the prior Qemu ACPI table handling, GICv2 configurations
>>>>>>> + * had vms->its=3D1... That's broken.
>>>>>>> + *
>>>>>>> + * Match that assumption to match the existing ACPI tables that
>>>>>>> + * have been shipping for quite a while.
>>>>>>> + */
>>>>>>> +static int is_gicv2_acpi_workaround_needed(VirtMachineState =
*vms) {
>>>>>>> +    return vms->gic_version =3D=3D 2;
>>>>>>> +}
>>>>>>=20
>>>>>> We don't need to keep identical bug-for-bug ACPI tables like =
that.
>>>>>> If we were incorrectly reporting an ITS in a GICv2-only ACPI =
table,
>>>>>> that was a bug and we can fix it. (This might need adjusting of =
the
>>>>>> golden reference ACPI data in some of the bios-tables-tests if we
>>>>>> were testing that, so it ought to go in its own patch.)
>>>>>>=20
>>>>> Hello,
>>>>>=20
>>>>> I=E2=80=99m a bit concerned about breaking hibernation in this =
case=E2=80=A6
>>>>>=20
>>>>> My intent was keeping this behavior for now and then add a machine =
model version dependent toggle in a follow-up patch.
>>>>=20
>>>> I'm not an ACPI table expert but my understanding is that it's
>>>> OK to change the ACPI table contents without having to make
>>>> those changes machine-version dependent. See e.g. commit =
d6afe18b7242,
>>>> which changed the ACPI tables for the its=3Doff case and did not
>>>> make those changes machine-version specific.
>>=20
>>> That commit didn=E2=80=99t affect the default/regular config so it =
wouldn't have been too problematic in practice.
>>>=20
>>> Have had countless issues with how brittle hibernation is* - and =
more or less subtle ACPI table changes
>>> tend to break it.
>>=20
>> I don't want to add back-compat handling for this to the virt
>> board unless one of our ACPI table experts says that yes we
>> do need to keep the ACPI table contents identical for older
>> versioned machine types.
>>=20
>> thanks
>> -- PMM
>=20
>=20
> Generally what we have handles VM migration, not hybernation.  The =
issue
> with hybernation is guests might cache some data to speed up init. If
> you want to go overboard you would have to never change anything at =
all
> in the firmware.  Whether they do it in any specific instance is hard =
to
> predict 100% but our approach generally is to try with a couple of
> popular guests, and not to worry too much ahead of time otherwise.  =
For
> several reasons: one is most changes are harmless, another one there's
> no special race here, if there's an issue you can trigger it
> predictably, yet another one is hybernation is a rarely used feature.
>=20
> For the specific change, I'd guess just test and if fine - fix it =
without a compat.
>=20
Hi,

It turns out that even the Ubuntu stock kernel of all things has =
hibernation disabled on arm64.
Had to install the linux-aws variant to test it and that testing =
didn=E2=80=99t go too well without even making
any Qemu changes between suspend and resume.

So considering it as unimportant=E2=80=A6

(And just sent a new rev with putting the new behaviour, had to tackle a =
bug on the way)

Thank you,
-Mohamed
> --=20
> MST
>=20
>=20


