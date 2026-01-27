Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACB1BD2F00D
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Jan 2026 12:47:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkiTJ-0005mG-WE; Tue, 27 Jan 2026 07:47:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vkiT8-0005OR-15
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 07:47:02 -0500
Received: from p-west3-cluster3-host12-snip4-10.eps.apple.com ([57.103.72.231]
 helo=outbound.ms.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vkiT2-0007uA-28
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 07:46:53 -0500
Received: from outbound.ms.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-3a-60-percent-9 (Postfix) with ESMTPS id
 B38D1180015B; Tue, 27 Jan 2026 12:46:38 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1769518000; x=1772110000;
 bh=8Lh/d6mUXXYROro4Kan9nBL8YH4TPaLTA8vJotKCkiU=;
 h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To:x-icloud-hme;
 b=SxwTXC64LSRwyQ6jZIZRPwzpCzaUw37xO1Ih1/MKcdNtbbTuvOD1QplxGT7v2MXYZ07Yj0wGyCgbVjPrgS+hPRZPWYgBEag2P52YyCqHl86tUnhnYL2Wyixdoyt92l9ikQnLsgT5s619sHwjov/1v7iFbWxtMHlegeXyx9Mrd69WHvLVi4mzlNcWTJSl3TrTBoNC0n9aSWAL7dcuGpUl13hAMzn428SOJIn2JZ1VEStU5kmd0QiAhCopKGN34GyFxfT9i0HYhPkh2JBiJwwLRiok5/Jm1vzsuQNzcpuNVUWXOPkcEpMXg+/k1VX5obkmB7ylz10CJBS5NXfhTvdHug==
mail-alias-created-date: 1752046281608
Received: from smtpclient.apple (unknown [17.57.154.37])
 by p00-icloudmta-asmtp-us-west-3a-60-percent-9 (Postfix) with ESMTPSA id
 56ABB180040F; Tue, 27 Jan 2026 12:46:34 +0000 (UTC)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.300.41.1.7\))
Subject: Re: [PATCH v17 03/21] hw: arm: virt: rework MSI-X configuration
From: Mohamed Mediouni <mohamed@unpredictable.fr>
In-Reply-To: <CAFEAcA-GL9UG5MN5tKDzLwQ04cBGa99cSau4=2BLTs0+GGSdJw@mail.gmail.com>
Date: Tue, 27 Jan 2026 13:46:21 +0100
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
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
Message-Id: <51E78FA9-2C66-4E8E-947F-F009A8AEEDFD@unpredictable.fr>
References: <20260121134114.9781-1-mohamed@unpredictable.fr>
 <20260121134114.9781-4-mohamed@unpredictable.fr>
 <CAFEAcA-GL9UG5MN5tKDzLwQ04cBGa99cSau4=2BLTs0+GGSdJw@mail.gmail.com>
To: Peter Maydell <peter.maydell@linaro.org>
X-Mailer: Apple Mail (2.3864.300.41.1.7)
X-Authority-Info-Out: v=2.4 cv=GrVPO01C c=1 sm=1 tr=0 ts=6978b3b0
 cx=c_apl:c_apl_out:c_pps a=qkKslKyYc0ctBTeLUVfTFg==:117 a=IkcTkHD0fZMA:10
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=KKAkSRfTAAAA:8
 a=YzH8LPeqeeXfAux3K4oA:9 a=QEXdDO2ut3YA:10 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: ujdhU1W630nZ-9O60Y2kb1a8_asYUPy7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI3MDEwNCBTYWx0ZWRfX0kpUyH01LCOf
 tKTUp3l4uarYISApHkOGU5Dm/nS6J5qa5LClhfL2QsVaSfmfsiYbpEvoQ0lQUI7D7wAsJE1J/L2
 JX25Rsp9vxpmcHCZj1YSnwp75aJOQqXKEME5JKYtfXGHt7M/CXSOZ9fBS4gn5w0Mgk3Ga9EZyUw
 PuYqFV7Ez4x7jqaxJg7393JzAeZACF+P5BnfbsWz5x1d+Bv+RiFNzlvw+JYqOdZhvVYQmSfB24y
 JmhGTK7xwrgJ0gA1OxEo+Hp6XAKdaVMWJw3XnhgEWKX0bm2szpSlSRJj69AflruRDRYXrANJGkj
 Nt2FSz4cElSTlzAQl5sG7fyngyksnXlfS1YyNkVUMAxJgmsQd9O0CEWV0AIRog=
X-Proofpoint-ORIG-GUID: ujdhU1W630nZ-9O60Y2kb1a8_asYUPy7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-27_02,2026-01-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 bulkscore=0 lowpriorityscore=0 spamscore=0
 phishscore=0 adultscore=0
 mlxscore=0 suspectscore=0 mlxlogscore=999 clxscore=1030 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2601270104
X-JNJ: AAAAAAABE7o/ghw+Q3mmoU/EA8zIGU1cC11Ae4PxYvTU2Z1V9Lg5v7i0tFC41IhSbFqL52on66cMEvHkqVMvZvFt0CHrRlf3ibtzl7atZz8eDwGVHsBlIAsJjYLVCb/sodFP725rN5yUMycp9YI4mmkAcZ98NtRODIEh+UOF/kTrgw/rT3pXqCmto4yE4H7pvZ8gOABoYJVxSkU3+QiDJUrevt/Cq7GZGZxr5v42bdA38h+zr2JEVrmjN9xskJm/Qann4Nn809N6CDnbSb6/6CtG9RDkQOcNVeztQPmDFp5+RyRsfZQldf5BbX21QKWPKE5vawGxOJuegIl6BV0iX41orpuls8EWSo6QUKIxnKARn8obsArZUs1di63vhKBoAR7802GtqxJ/fcn6RHRd7xSJMEb/E6gjV7q5qrcCVxO/U6V+I/wOclIOo+BY54nwDsQ2HRAYTySETGSoaupt6YuiF/u8TxWrRvHb59hLR6dxChGNcI2OcObV7yz6KlvdSWM83WW4LcJZnyIvDpN4EqSszB73n3mghAUX/qCxJGVxYYc81QfJI4nLITHkgedWjUKPTbyA0rCDK6C35K5uFdQRvrHhZr6kGpWTETNk4I0QlPZBf90Zsjwch5saLri52zoDaJj1K7dS8JzM9GKgs84g4hPS6CR6TriuvREJt5tnF9tHuL+LGcbGFg3dnB+Qw3ZbcKg8aPWAHCH1Cv1adtqzO+U/xnAFI6U3FMv3Z0jRHXN4fcckLW8x3qkuSL0UxNur8+F6mO/2Gz6TBblLROSZRatURfP00ajxR6Xf9ET+zI+LXNXE6ac9gK3GnlPKjd2odwZWduLlZeQt+nRKTDMPvLMgfJDSj3F0c3HKTeyxNRDU41NNYdZOSa9XKIWQsMcqJw==
Received-SPF: pass client-ip=57.103.72.231;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.ms.icloud.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001,
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



> On 27. Jan 2026, at 11:54, Peter Maydell <peter.maydell@linaro.org> =
wrote:
>=20
> On Wed, 21 Jan 2026 at 13:41, Mohamed Mediouni =
<mohamed@unpredictable.fr> wrote:
>>=20
>> Introduce a -M msi=3D argument to be able to control MSI-X support =
independently
>> from ITS, as part of supporting GICv3 + GICv2m platforms.
>>=20
>> Remove vms->its as it's no longer needed after that change.
>>=20
>> Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
>> ---
>> hw/arm/virt-acpi-build.c |  27 ++++++--
>> hw/arm/virt.c            | 137 =
+++++++++++++++++++++++++++++++++++++--
>> include/hw/arm/virt.h    |   8 ++-
>> 3 files changed, 157 insertions(+), 15 deletions(-)
>>=20
>> diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
>> index 03b4342574..187dd4e272 100644
>> --- a/hw/arm/virt-acpi-build.c
>> +++ b/hw/arm/virt-acpi-build.c
>> @@ -440,6 +440,17 @@ static void create_rc_its_idmaps(GArray =
*its_idmaps, GArray *smmuv3_devs)
>>     }
>> }
>>=20
>> +/*
>> + * In the prior Qemu ACPI table handling, GICv2 configurations
>> + * had vms->its=3D1... That's broken.
>> + *
>> + * Match that assumption to match the existing ACPI tables that
>> + * have been shipping for quite a while.
>> + */
>> +static int is_gicv2_acpi_workaround_needed(VirtMachineState *vms) {
>> +    return vms->gic_version =3D=3D 2;
>> +}
>=20
> We don't need to keep identical bug-for-bug ACPI tables like that.
> If we were incorrectly reporting an ITS in a GICv2-only ACPI table,
> that was a bug and we can fix it. (This might need adjusting of the
> golden reference ACPI data in some of the bios-tables-tests if we
> were testing that, so it ought to go in its own patch.)
>=20
Hello,

I=E2=80=99m a bit concerned about breaking hibernation in this case=E2=80=A6=
=20

My intent was keeping this behavior for now and then add a machine model =
version dependent toggle in a follow-up patch.
=20
>> +bool virt_is_its_enabled(VirtMachineState *vms)
>> +{
>> +    switch (vms->msi_controller) {
>> +    case VIRT_MSI_CTRL_NONE:
>> +        return false;
>> +    case VIRT_MSI_CTRL_ITS:
>> +        return true;
>> +    case VIRT_MSI_CTRL_GICV2M:
>> +        return false;
>> +    case VIRT_MSI_CTRL_AUTO:
>> +        /*
>> +         * Earlier Qemu considered its=3Don as the default when =
using the GICv2.
>> +         * It is safe to do this because this is called is prior to
>> +         * finalize_msi_controller.
>> +         */
>> +        return true;
>> +    default:
>> +        g_assert_not_reached();
>> +    }
>> +}
>> +
>> +bool virt_is_gicv2m_enabled(VirtMachineState *vms)
>> +{
>> +    switch (vms->msi_controller) {
>> +    case VIRT_MSI_CTRL_NONE:
>> +        return false;
>> +    case VIRT_MSI_CTRL_ITS:
>> +    case VIRT_MSI_CTRL_GICV2M:
>> +    case VIRT_MSI_CTRL_AUTO:
>> +        return !virt_is_its_enabled(vms);
>> +    default:
>> +        g_assert_not_reached();
>> +    }
>> +}
>=20
> Why do we need these? The idea of finalize_msi_controller()
> is that it fixes vms->msi_controller so that you can just
> directly say vms->msi_controller =3D=3D VIRT_MSI_CTRL_ITS or
> vms->msi_controller =3D=3D VIRT_MSI_CTRL_GICV2M rather than
> having to have more complicated logic.
>=20
It=E2=80=99s because of object_class_property_add_str(oc, "msi", =
virt_get_msi, virt_set_msi) (and the same applies for the its property), =
is it safe to assume that virt_get_msi/virt_get_its will never be called =
from that prior to finalize?


> thanks
> -- PMM
>=20


