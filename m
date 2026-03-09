Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C2AAEF36E8
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 07:15:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzUpP-0005Iw-FJ; Mon, 09 Mar 2026 03:14:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vzUpL-0005If-5a
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 03:14:56 -0400
Received: from qs-2006k-snip4-5.eps.apple.com ([57.103.85.236]
 helo=outbound.qs.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vzUpI-0005Hc-Vp
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 03:14:54 -0400
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-2d-60-percent-6 (Postfix) with ESMTPS id
 524DE18000A9; Mon,  9 Mar 2026 07:14:46 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1773040491; x=1775632491;
 bh=kDCnIQBi2Kog13dygAjvogajonibD7R/gyzVoOBnCIY=;
 h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To:x-icloud-hme;
 b=G9UN14OFRdHaJYjdMWF57roQM/ILNR1W7t4798aXws7cpKx+hpcEK3vp9kUYALlwSrM1hD0h8pt5PzEblMeyRJzU5BaIAfgdrodcuMYvXfHKeVsmcHcGGg1aRubeDbTJo65r9K9q1kQXw1EoNE40JOfwYNjAmlq7jqfiCVymgthMehQ2774TdeeobpijchaqLq696fgrPw5v+kqpw/UGE+7SfTroNfMe4CGrwnZf2f1tXKHHqFsisT+eeD+1ngkpXLBJ68CxqaN2GFkE7R8dIjcbcKVCpFEiWIbt413a9ERd+CM8oeBxQhmMeDd8aIbmU+EJ40BE/ZmMjZmktEPnTA==
mail-alias-created-date: 1752046281608
Received: from smtpclient.apple (unknown [17.57.155.37])
 by p00-icloudmta-asmtp-us-east-2d-60-percent-6 (Postfix) with ESMTPSA id
 32379180013C; Mon,  9 Mar 2026 07:14:44 +0000 (UTC)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.400.21\))
Subject: Re: [RFC PATCH v2 0/1] target/i386/kvm: Configure proper KVM SEOIB
 behavior
From: Mohamed Mediouni <mohamed@unpredictable.fr>
In-Reply-To: <1279CDB9-C8E1-40A3-A01D-3C53E831989F@unpredictable.fr>
Date: Mon, 9 Mar 2026 08:14:32 +0100
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Shaju Abraham <shaju.abraham@nutanix.com>, Jon Kohler <jon@nutanix.com>,
 Mark Cave-Ayland <mark.caveayland@nutanix.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "mst@redhat.com" <mst@redhat.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "richard.henderson@linaro.org" <richard.henderson@linaro.org>,
 "eduardo@habkost.net" <eduardo@habkost.net>,
 "mtosatti@redhat.com" <mtosatti@redhat.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <EE8967D5-244F-407F-A106-1D14EA066039@unpredictable.fr>
References: <20260309054243.440453-1-khushit.shah@nutanix.com>
 <6A894B95-03A6-49EE-91A2-D3BCB09AAFCD@unpredictable.fr>
 <D74B0637-1332-4FC4-B29B-804E5AC18C33@nutanix.com>
 <1279CDB9-C8E1-40A3-A01D-3C53E831989F@unpredictable.fr>
To: Khushit Shah <khushit.shah@nutanix.com>
X-Mailer: Apple Mail (2.3864.400.21)
X-Proofpoint-GUID: mXD3lWSdJ9v5ZwGx9I0u3Po6b1VI1xWq
X-Authority-Info-Out: v=2.4 cv=IfKKmGqa c=1 sm=1 tr=0 ts=69ae7367
 cx=c_apl:c_pps:t_out a=bsP7O+dXZ5uKcj+dsLqiMw==:117
 a=bsP7O+dXZ5uKcj+dsLqiMw==:17 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=64Cc0HZtAAAA:8 a=r87lyr2CK6j1gDGuza8A:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA5MDA2NSBTYWx0ZWRfXw2MDNe/2wY0V
 lT2uJ9S62SVarh/uyMU5loG/x9j785+8XdVJM+pTbZvtmcq0fZ9swUbFgug439eyaUt3EZjE4YF
 2eeawucr5g5jl6z1mlmSRL1F8Fv+xPhReq6Wq1vXEarkin0tb4AENMvTDnp2XjnAEGJW5wv66su
 HCgaL9bTC038RtpULANk2R9f5k64mcKjPB4VgF2WjQK4Tf0LDze/+5o4MUwpLmd4aPD7Sq6OxJo
 CPDQzF92Z6odIJa1xw61bQK16ma93FnTak5pv7ir4qGaF1iIGRSb9icmieaswNG9L+QoawdgF4A
 mTPQi5kg4fu709sH7Ke7eRsa3ONQNWmsHVYS0eOa6wL7Ir+fsyoBoPU76aOv8Y=
X-Proofpoint-ORIG-GUID: mXD3lWSdJ9v5ZwGx9I0u3Po6b1VI1xWq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-09_02,2026-03-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 spamscore=0 mlxscore=0 mlxlogscore=999 phishscore=0 clxscore=1030
 suspectscore=0 malwarescore=0 lowpriorityscore=0 adultscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2603090065
X-JNJ: AAAAAAABCm9vdUDsevhxRjuvk9K/Lk8TWY+UGHXN4su70GaKWQW+y+Hcpbo8Sazn4BXtMOzAAzLznFw5FKjSFXVnagS8C2a+dg87MNRXWHL42JNHsCNwDKaKa3m90+MT8PcQWwtRx8LsqV5Ys4QX81ucmr2Wb9UvSKyB9ew1mYoq018m+U23olVBQfO/zDObYd5GGPhf/E5ugvFRws5zoiTlf4ydnHXEyyK7n/v+TX5KtlHp6j4bFbkcGoUbs/Ccg37b1ZVivL0vuIfLzFMRL6Uy3X6hDijHa9L22OR7zIPgCh18J6oiU3WcM7IXUZBLbug6izHvK7rQe1j2n5EN3RnxeK5Dd8jWaLZE/cuGgIDP6IjdUGw31YIZO06alTWnXXkGYgX1xnVY87/4fI69DAb7CdMr8fpAN0po9h5D2BEa8MFnahzOYm6XIH9P+VfwG9LEC7Cf0+0qqfGaMd5FoqhlpnHEUabNQE46VAELM+8+mQJykCGsQk06CmiHO1KHWmKNQnTnTGdepkmOjF2wy1unu1CTE4wTWjbqG3MxtzjqcZuA0G58o5alMB1SVwcRUuwDuYNxnMCQ29RwK9Tv0nj4YrrhKtedEJ4Z0TXhNndjiLkKeTFDxuJ5zCcjORApV5dGnue10H94krXnVlL6ROVA3D/Aj0ag1qfDViGIQd30C1lv5QZtG0+mMELHifn5HFOps4XhrpuOm6IjmiOcqTwWSUyb0B06bsyU4XU97MzAoO1kf8qj9mniwdF7/GTSpbSB/BBs9XNxwIrCciDn7TZsvgaaB5UwMws=
Received-SPF: pass client-ip=57.103.85.236;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.qs.icloud.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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



> On 9. Mar 2026, at 07:55, Mohamed Mediouni <mohamed@unpredictable.fr> =
wrote:
>=20
>=20
>=20
>> On 9. Mar 2026, at 07:33, Khushit Shah <khushit.shah@nutanix.com> =
wrote:
>>=20
>>=20
>>=20
>>> On 9 Mar 2026, at 11:27=E2=80=AFAM, Mohamed Mediouni =
<mohamed@unpredictable.fr> wrote:
>>>=20
>>> Hi,
>>>=20
>>> Ugh about this one, but am still convinced that a machine model =
version
>>> is _the_ right way to deal with this. Will this be backported to =
Linux LTSes on the KVM side?
>>>=20
>>> Or alternatively, what are the odds of having it fit as a CPU flag?
>>> For example -cpu host,x2apic-suppress-eoi-broadcast=3Don.
>>=20
>>=20
>> Hi,=20
>>=20
>> Thanks for the review.
>>=20
>> Regarding the -cpu flag: This doesn't feel right because SEOIB is an =
accelerator-specific (KVM)
>> value. Tying it to the CPU suggests an architectural feature that =
wouldn't apply to TCG. What
>> specifically feels off about keeping it as a KVM/Machine property?
> Hello,
>=20
> The reason why I considered this is that QEMU CPU models are versioned =
separately from the machine
> model, with an understanding that an older CPU model might not work on =
an older KVM.
>=20
> And with a common CPU model being also a requirement for live =
migration too.
>=20
> This has historically been generally leveraged for security =
mitigations but it could be a good fit here.
>=20
> That could provide a path towards it becoming the default when -cpu =
host on a supported kernel (which doesn=E2=80=99t entail having LM =
support), while keeping LM working and having it stepped in with newer =
CPU model versions, which people will update to more often than new =
kernels. Maybe the best shape could be a no_seoib flag for older =
predefined CPU models=E2=80=A6
s/new kernels/new machine models/g and no_seoib -> no_seoib_fix
>=20
> My concern is primarily somebody installing a new QEMU, running =
qemu-system-x86_64 -M q35,kernel-irqchip=3Dsplit [whatever], which would =
pick the latest machine model version and fail straight away if this is =
rolled as part of a new machine model if running on a kernel without the =
KVM side merged in.
>=20
> And having a custom flag not turned on by default for a long time for =
this comes with the risk that almost nobody will enable it instead of it =
being eventually phased in as the default configuration=E2=80=A6 Or =
maybe it matters a lot less because kernel-irqchip=3Dsplit is not the =
default today anyway?
Which is why I think that an accelerator property isn=E2=80=99t the =
ideal choice here - as there=E2=80=99s no -accel kvm-10.2 for example :/ =
And machine type-gating is more tied to the QEMU version than CPU model =
versions which have less of a tie.

But I might be wrong on this one, with machine type being potentially =
better in practice - although it=E2=80=99s way too late to define this =
as part of q35-10.2 baseline as that has been long released, so it could =
be a slower rollout with the default tied to a new QEMU release. And an =
error message to use a newer kernel in that case if using the newer =
machine model explicitly or implicitly.

> Thank you,
> -Mohamed
>>=20
>> Regarding the backports: The KVM kernel side is currently in 6.18 and =
6.19. I haven=E2=80=99t yet came
>> around to manually backported it to the older stable releases yet.
>>=20
>> Thanks,=20
>> Khushit.



