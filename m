Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6746DC83F17
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Jul 2025 11:19:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ugLs8-0002JO-Nn; Mon, 28 Jul 2025 07:18:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1ugLO0-0004CA-41
 for qemu-devel@nongnu.org; Mon, 28 Jul 2025 06:47:16 -0400
Received: from p-east3-cluster2-host11-snip4-7.eps.apple.com ([57.103.87.238]
 helo=outbound.qs.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1ugLNw-00071D-Od
 for qemu-devel@nongnu.org; Mon, 28 Jul 2025 06:47:15 -0400
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-2d-60-percent-1 (Postfix) with ESMTPS id
 AC7CF180011E; Mon, 28 Jul 2025 10:47:09 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; bh=cLjPuPYOUhuKvBEn7VsnYOUTHfuyTb1QdxC9mu+H5xE=;
 h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To:x-icloud-hme;
 b=MGlnssf7xZvnO1dlJ6psg1njvC4WHSjsthp8F8w10hGLQ+emwdv6bI8EbGj3N8nZ98a1wWVofXtrK58K9V4hVXn1cR8dfNoqpJPUT4Jjpyg+kDz7OKMhVN+TAVt7KOFXh0klb2kV6Uf/6d1zVtLjX8Ki0bNQdMktdUx3wtyogfhdnzX2lN7dlzasF8MqTKsb5qccK9jfn5JIbQ5ENYIdcNBnChDxxyVeahqbtLxhJygBI59SSQVRgCfqePHTxsq8adkPmSyYabF56yS96NdfvT12D6OxlgzI9Y1hrxduFR8NqRxHD28OErrNTB/k8cS8RHaeoYhTtre3DgvYov5pPw==
X-Client-IP: 46.189.47.18
Received: from smtpclient.apple (qs-asmtp-me-k8s.p00.prod.me.com
 [17.57.155.37])
 by p00-icloudmta-asmtp-us-east-2d-60-percent-1 (Postfix) with ESMTPSA id
 B0EB71802086; Mon, 28 Jul 2025 10:47:07 +0000 (UTC)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3860.100.5.1.1\))
Subject: Re: [PATCH v3 3/9] target/arm: add asserts for code paths not
 leveraged when using the vGIC
From: Mohamed Mediouni <mohamed@unpredictable.fr>
In-Reply-To: <e9afdf9e-b357-43a5-acc6-f4839c539585@linaro.org>
Date: Mon, 28 Jul 2025 12:46:56 +0200
Cc: qemu-devel@nongnu.org, Phil Dennis-Jordan <phil@philjordan.eu>,
 Mads Ynddal <mads@ynddal.dk>, Cameron Esfahani <dirty@apple.com>,
 Ani Sinha <anisinha@redhat.com>, qemu-arm@nongnu.org,
 Igor Mammedov <imammedo@redhat.com>, Alexander Graf <agraf@csgraf.de>,
 Shannon Zhao <shannon.zhaosl@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <5F11EE68-0CC5-4A41-A89D-48CF789196A9@unpredictable.fr>
References: <20250725223035.52284-1-mohamed@unpredictable.fr>
 <20250725223035.52284-4-mohamed@unpredictable.fr>
 <e9afdf9e-b357-43a5-acc6-f4839c539585@linaro.org>
To: =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
X-Mailer: Apple Mail (2.3860.100.5.1.1)
X-Proofpoint-ORIG-GUID: dBwgEYyZD97qbZmm8MkYVF7EeQlH-Uy2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI4MDA3OSBTYWx0ZWRfX7aQpdsSyosPl
 jlxsXCQkhuFsipOpXbtq2a+g4aSTyyB3q00q+Ss9LdCOCi3CjU870TV8708mX9bNw8ZOhpOlfbN
 AlShZaWwnIZib1Wy4WB+A36Yh4DLXI4yEoiYCrs24/PKU0mnAb/f4OPqkubsjz+9s3TrYg2C99o
 3Bdf3xkGlrSPpfkBfjLaMxchaKVTDwCwVbRq+vqIVlUFMYLN/++smERUG5jl2+lvubnfR8gDlmJ
 +OxdHxxlcjGrB0r73M63A8Nm1FN9OH/FhS6CR4sYsVM0I0FHH1+yyUnEuOb3y8S8IOy731WBI=
X-Proofpoint-GUID: dBwgEYyZD97qbZmm8MkYVF7EeQlH-Uy2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-28_03,2025-07-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 suspectscore=0 bulkscore=0 adultscore=0
 mlxlogscore=865 clxscore=1030
 phishscore=0 spamscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2506270000 definitions=main-2507280079
Received-SPF: pass client-ip=57.103.87.238;
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

Hi,

> On 28. Jul 2025, at 12:18, Philippe Mathieu-Daud=C3=A9 =
<philmd@linaro.org> wrote:
>=20
> Hi Mohamed,
>=20
> On 26/7/25 00:30, Mohamed Mediouni wrote:
>> When using the vGIC, timers are directly handled by the platform, so =
no vmexits ought to happen in that case.
>> Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
>> ---
>>  target/arm/hvf/hvf.c | 10 ++++++++++
>>  1 file changed, 10 insertions(+)
>=20
>=20
>> @@ -1965,6 +1971,10 @@ int hvf_vcpu_exec(CPUState *cpu)
>>          /* This is the main one, handle below. */
>>          break;
>>      case HV_EXIT_REASON_VTIMER_ACTIVATED:
>> +        /* This is only for when a user-mode irqchip is used. */
>> +        if (hvf_irqchip_in_kernel()) {
>> +            assert("vtimer activated vmexit when using platform =
GIC");
>=20
> This line does nothing (not firing), is that what you intended to?
It=E2=80=99s specifically so that if this trips, I know that I really =
screwed things up. Helped me a bit in developing this.

However, this whole patch isn=E2=80=99t expected to ever trigger irl, so =
would be fine to drop from that perspective.

HV_EXIT_REASON_VTIMER_ACTIVATED will never be returned by =
Hypervisor.framework when the vGIC is enabled.

Thank you,
-Mohamed
>> +        }
>>          qemu_set_irq(arm_cpu->gt_timer_outputs[GTIMER_VIRT], 1);
>>          cpu->accel->vtimer_masked =3D true;
>>          return 0;
>=20


