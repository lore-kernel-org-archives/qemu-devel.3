Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56183C44522
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Jan 2026 12:29:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1viXKQ-0002uG-9p; Wed, 21 Jan 2026 07:28:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1viXJI-00082N-9C
 for qemu-devel@nongnu.org; Wed, 21 Jan 2026 07:27:44 -0500
Received: from ci-2002l-snip4-2.eps.apple.com ([57.103.88.243]
 helo=outbound.ci.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1viXJE-0002aF-I6
 for qemu-devel@nongnu.org; Wed, 21 Jan 2026 07:27:43 -0500
Received: from outbound.ci.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-central-1k-100-percent-12 (Postfix) with ESMTPS id
 CA1D518001FC; Wed, 21 Jan 2026 12:27:33 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1768998458; x=1771590458;
 bh=Yht18MJmfuiIF51o4n4O5AQVwJszwT3sToSE4/L74hg=;
 h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To:x-icloud-hme;
 b=FL1OcAsscNV965k4mNTPJtTDsRkHqMs8mEmfZrrAUdfK0INAI/V2HWxZNIXILDliBBOZ+ghD1v4aac/r0gHSrBlAnhkV4J7CXIaN9QliPsAB6cAy5Nx8tdymGG6h4jekaLlJ8gGB4DEHByUx/JvP7YRMk7qDw557aae4GY8cl8gYuLyQU6GwuQUK/vhnEJaNdcW/C0s3R2dU+6Dk5BeMCGzbjbHLhIfdSN/WUnnc5Eiwu3vspA/8hwZJBRg7ew2yb6BWZhhFeHy10XFdCWZJxHzY1OUzZei/r19YUbZOqHbOTtW+96F2x5OO0DEhyVilI0YFR/rvRPfudZppCP0g2A==
mail-alias-created-date: 1752046281608
Received: from smtpclient.apple (unknown [17.57.156.36])
 by p00-icloudmta-asmtp-us-central-1k-100-percent-12 (Postfix) with ESMTPSA id
 012D118001F1; Wed, 21 Jan 2026 12:27:30 +0000 (UTC)
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.300.41.1.7\))
Subject: Re: [PATCH v16 04/26] hw/arm: virt: add GICv2m for the case when ITS
 is not available
From: Mohamed Mediouni <mohamed@unpredictable.fr>
In-Reply-To: <CAFEAcA9FMiNZXgRP8OZgvAyPJXfBphXXs4eB1kBZtDgqYDTYUQ@mail.gmail.com>
Date: Wed, 21 Jan 2026 13:27:19 +0100
Cc: qemu-devel@nongnu.org,
 =?utf-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Shannon Zhao <shannon.zhaosl@gmail.com>, qemu-arm@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <0A38F8AC-2756-4BDD-AA0A-AD1502E2F715@unpredictable.fr>
References: <20260116135235.38092-1-mohamed@unpredictable.fr>
 <20260116135235.38092-5-mohamed@unpredictable.fr>
 <CAFEAcA-3P6i_w3b7SaFTn4Zmwnot5vpDs89y+zpjcJ=-mEnP5w@mail.gmail.com>
 <8158CEFE-8EA2-40A4-970E-01B30BACC019@unpredictable.fr>
 <CAFEAcA9JC1HRboZ=722dsT7a4nDQNF_ECjLK+z84T5MJisfppg@mail.gmail.com>
 <2FD2C3C6-8FBA-4833-B890-5E81637BE7EE@unpredictable.fr>
 <CAFEAcA-MAsQpaaUx0dJHRHjUJ6bEWwnf58VZN965Npmi7_kHXQ@mail.gmail.com>
 <FF6F91A9-9A09-48B1-8857-FF213C9A4644@unpredictable.fr>
 <CAFEAcA9FMiNZXgRP8OZgvAyPJXfBphXXs4eB1kBZtDgqYDTYUQ@mail.gmail.com>
To: Peter Maydell <peter.maydell@linaro.org>
X-Mailer: Apple Mail (2.3864.300.41.1.7)
X-Proofpoint-ORIG-GUID: ROUE6FrLG-QJKFWefmJifvU-lferh8Y2
X-Proofpoint-GUID: ROUE6FrLG-QJKFWefmJifvU-lferh8Y2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIxMDEwNCBTYWx0ZWRfX+fr+hRgH3BhE
 1Ltm/xnb7Fn0mXLdfQwf2N95NSWbaR1mGTVBJBgzbLGJwUQ1yAPIQDVHReThE90HXDjxmGIRsci
 GUFDYJRHkb+p3495jm5aQAfkCoL6J0+ik3uDepOxb6EGYmMXLQA4eQ+jcmOkeIN53TIk5nR54G5
 v/eMQKwuhnL9X89dcdKcfp4B//F7rQBU+LeFSpg8+hy70W78K0aJWJwZCWVTNz2eL8H9MoR40fM
 0+yJRvIA5Bv566F5klEYWRfYgFuHzfwZs2hsKkWGI5iuELCT7jVhENseYTf/jCS/E1VbFDLYj1G
 OBbJWYBHCazljQWH7eFBOBYuIftjBKvX3AbPS3PQursLM0MqJOoaEA6s2qxgzU=
X-Authority-Info-Out: v=2.4 cv=AdW83nXG c=1 sm=1 tr=0 ts=6970c637
 cx=c_apl:c_apl_out:c_pps a=2G65uMN5HjSv0sBfM2Yj2w==:117
 a=2G65uMN5HjSv0sBfM2Yj2w==:17 a=8tVNtdTugjW4QW2w:21 a=kj9zAlcOel0A:10
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=KKAkSRfTAAAA:8
 a=ABBp3Z9_OFQcteDbQAsA:9 a=CjuIK1q_8ugA:10 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-21_01,2026-01-20_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 lowpriorityscore=0 spamscore=0 adultscore=0 mlxscore=0 phishscore=0
 mlxlogscore=936 clxscore=1030 suspectscore=0 bulkscore=0 malwarescore=0
 classifier=spam authscore=0 adjust=0 reason=mlx scancount=1
 engine=8.22.0-2601080000 definitions=main-2601210104
X-JNJ: AAAAAAABmu3Zi9UJIi1LUc4zq9pV6/vnrkMeI5Yu0h9/jC6fqiMMbQnh3saLusPLzqHpPZOa0J1ZGUwQFFmLGbPV4ZO1oAbItxoCNowI6TmbXuULg2+kdiaKhYCGh/eGbEmNt5rNXSICtZMh9cx3Tyk7jDQoHLA53qL5Zcn3+bidXpiYr2avl6X5796KJ+KR27ejHD4dY+qUXNVTm+/YgN/qrBSefM0CJddrQ8yOSictKRsJVObo/KtFwhnfVhEI6Bzsrk2SDJsousPzjMjY7xM5i19pAVtBQLvR8F2tZgZJNW2lTvVUYJcRHpprlp7AMXhpw4WF/AP81JVlv5q2XIjFD0rIQlSaj5VpOwsWtK3redHkGt00wv6sdH83wA3wIaHTbT1x8KBDRVbG+wFQJQSHA3WGUQVboKRTr76+5nTwRk0JD3G5sM3gMUc+qOhc9wTv36j1v6Umip1x3ubXnfffit3qHx+UNkPg9YAtVo8bDQWNL2phaXdvrempgRLrI3d8Z9z1x5TS6mX3roiJ1naKU612g9+r6uCmkFFJ6lcJf04jFniseExfGdBUhoQigQOEEHn3GPLNA6tATLATiwTPP0cGPCY0d2VaV5QNxwsD5zGOaJvT+HV+zZCwe3YUJ3jowcYXdnKPVFJdJjomBc9GwR1V8JvxlnUHknbfu5yJIx+KnLSlEeBysUaCjQxxpzuw0DlBz3XwnEXLyFdHGBnwT+NujBHPiWjk1lCDzsUmqLywGMupQX9o5H4KRcJ5gijQqRjJjEt9VCN0Z+z70rNkjndCWjcK11XOEIVF1vpY59De2FpbBpuOCp3A
Received-SPF: pass client-ip=57.103.88.243;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.ci.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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



> On 21. Jan 2026, at 13:19, Peter Maydell <peter.maydell@linaro.org> =
wrote:
>=20
> On Wed, 21 Jan 2026 at 12:00, Mohamed Mediouni =
<mohamed@unpredictable.fr> wrote:
>>=20
>>=20
>>=20
>>> On 21. Jan 2026, at 12:33, Peter Maydell <peter.maydell@linaro.org> =
wrote:
>>>=20
>>> which I think means we do need
>>> the its option to be an on/off/auto one
>>=20
>> Hello,
>>=20
>> Would this be ok instead?
>>=20
>> typedef enum VirtMSIControllerType {
>> VIRT_MSI_CTRL_NONE,
>> /* This value is overriden at runtime.*/
>> VIRT_MSI_CTRL_AUTO,
>> /* Legacy option: its=3Doff provides a GICv2m when using GICv2.*/
>> VIRT_MSI_LEGACY_OPT_ITS_OFF,
>> VIRT_MSI_CTRL_GICV2M,
>> VIRT_MSI_CTRL_ITS,
>> } VirtMSIControllerType;
>>=20
>> Combined with:
>>=20
>> static void finalize_msi_controller(VirtMachineState *vms)
>> {
>> if (vms->msi_controller =3D=3D VIRT_MSI_LEGACY_OPT_ITS_OFF) {
>> if (vms->gic_version =3D=3D 2) {
>> vms->msi_controller =3D VIRT_MSI_CTRL_GICV2M;
>> }
>> else {
>> vms->msi_controller =3D VIRT_MSI_CTRL_NONE;
>> }
>> }
>=20
> Is this with the idea that the its option get/set
> functions would set msi_controller (to ITS_OFF or ITS) ?
>=20
Yes, vms->its is completely gone in my tree.

Going to post a rev with it soon, would you prefer to have it separate =
instead of a whole WHPX series?
> thanks
> -- PMM


