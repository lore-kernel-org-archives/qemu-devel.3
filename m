Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 744C4C87FCF
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Aug 2025 23:54:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uj4zn-0004Ui-M6; Mon, 04 Aug 2025 19:53:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1uj4zc-0004RE-50
 for qemu-devel@nongnu.org; Mon, 04 Aug 2025 19:53:25 -0400
Received: from p-east3-cluster5-host1-snip4-5.eps.apple.com ([57.103.86.136]
 helo=outbound.qs.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1uj4zZ-0006nR-Ug
 for qemu-devel@nongnu.org; Mon, 04 Aug 2025 19:53:23 -0400
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-7 (Postfix) with ESMTPS id
 E24FF18000BF; Mon,  4 Aug 2025 23:53:15 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; bh=cTJquXsPjv4ShE+qEC2i5SuDDtudEwPpzptwV611svM=;
 h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To:x-icloud-hme;
 b=ey0ltUWGrB53pDCA6ZSpJf3wMgWcWCIzxbSzEGAg1E4tkTQCOkcY1Vl31py8LGp9OY/CfUetGKQX7Y9SU2msQY66rehBJ9MuCLEKz9lILBBoGyJMNiXdulMhVUfeftk8X9weIyDl1Y6PDT5Si1cQlydMjaN8gFEC3mFW+UxN2KW5oL5saC/IFWA5jGz7Y1wGlrqeLwKyqLel7q2IEl5vmaph5WeztEdgfZdAjHolAJwrpGU8N/OjT7aHjUdxJrSn10kNQR49Re6DYYb0A6zfm6GhG0o8BGRl+d+V/9tmsZlmcuePcwdr8HshNyNtFvHJj6omcVDh2c0m0sOh5CpE9w==
X-Client-IP: 109.40.242.215
Received: from smtpclient.apple (qs-asmtp-me-k8s.p00.prod.me.com
 [17.57.155.37])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-7 (Postfix) with ESMTPSA id
 ED10018000A1; Mon,  4 Aug 2025 23:53:10 +0000 (UTC)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3860.100.5.1.1\))
Subject: Re: [PATCH v4 12/17] hw/arm: virt: cleanly fail on attempt to use the
 platform vGIC together with ITS
From: Mohamed Mediouni <mohamed@unpredictable.fr>
In-Reply-To: <395a77c2-53c3-436b-b46f-b301dc8e619b@linaro.org>
Date: Tue, 5 Aug 2025 01:52:57 +0200
Cc: qemu-devel@nongnu.org, Shannon Zhao <shannon.zhaosl@gmail.com>,
 Ani Sinha <anisinha@redhat.com>, Phil Dennis-Jordan <phil@philjordan.eu>,
 Roman Bolshakov <rbolshakov@ddn.com>, Igor Mammedov <imammedo@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Mads Ynddal <mads@ynddal.dk>,
 =?utf-8?B?IkRhbmllbCBQLiBCZXJyYW5nw6ki?= <berrange@redhat.com>,
 Sunil Muthuswamy <sunilmut@microsoft.com>, Zhao Liu <zhao1.liu@intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Alexander Graf <agraf@csgraf.de>,
 qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Cameron Esfahani <dirty@apple.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <62287B84-98BB-4E97-B43C-9ED31DB0C113@unpredictable.fr>
References: <20250804142326.72947-1-mohamed@unpredictable.fr>
 <20250804142326.72947-13-mohamed@unpredictable.fr>
 <395a77c2-53c3-436b-b46f-b301dc8e619b@linaro.org>
To: =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
X-Mailer: Apple Mail (2.3860.100.5.1.1)
X-Proofpoint-GUID: OPLyPOtWT-uH6_8C6qoqUC-hIyRvMJ97
X-Proofpoint-ORIG-GUID: OPLyPOtWT-uH6_8C6qoqUC-hIyRvMJ97
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA0MDE0NiBTYWx0ZWRfX8ALeT3KsLrli
 hdYghQemZXACNm+cmGtE4XoIv+1OblVc12qtOM25U2MCbi+bPpd4F9gPrTqddNJ0epAgp/C6ROb
 oB+YFL/UcFCmW7PWt5IYCsXuSXgCJ+KcMy9AL8Xwzuzog4YHCGVPL/YMyLfZxKyclQbOwjLbO0+
 tpbE0jN0fmHb5gYQQVbO0Hq/xQVINpOQiVJ2fmIADSfPLgstuYT372tZoAkkq5lfkEfxVIfzhwf
 CwVr4u5w1xddpt39k0fNWtTBN/Gxjgldc0nBzEX5p47cuzzZ1pdwFN8Bk8guhutoA+hSbkZwo=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-04_10,2025-08-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 adultscore=0 phishscore=0 suspectscore=0 bulkscore=0 spamscore=0
 mlxlogscore=999 malwarescore=0 clxscore=1030 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.22.0-2506270000 definitions=main-2508040146
Received-SPF: pass client-ip=57.103.86.136;
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



> On 5. Aug 2025, at 00:59, Philippe Mathieu-Daud=C3=A9 =
<philmd@linaro.org> wrote:
>=20
> On 4/8/25 16:23, Mohamed Mediouni wrote:
>> Windows Hypervisor Platform's vGIC doesn't support ITS.
>> Deal with this by reporting to the user and not creating the ITS =
device.
>> Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
>> ---
>>  hw/arm/virt.c | 10 ++++++++++
>>  1 file changed, 10 insertions(+)
>> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
>> index 98a1c74c42..0039f6a12b 100644
>> --- a/hw/arm/virt.c
>> +++ b/hw/arm/virt.c
>> @@ -741,6 +741,16 @@ static void create_its(VirtMachineState *vms)
>>          return;
>>      }
>>  +    if (whpx_enabled() && vms->tcg_its) {
>> +        /*
>> +         * Signal to the user when ITS is neither supported by the =
host
>> +         * nor emulated by the machine.
>> +         */
>> +        info_report("ITS not supported on WHPX.");
>> +        info_report("To support MSIs, use its=3Doff to enable GICv3 =
+ GICv2m.");
>=20
> So if the users deliberately asks for its=3Don, we ignore the request =
and
> keep going. Shouldn't we just exit so the user adapts its command =
line?
Maybe that=E2=80=99s the best way to go=E2=80=A6 what makes me a bit =
hesitant on that one though is that the default is its=3Don.
>> +        return;
>> +    }
>> +
>>      dev =3D qdev_new(its_class_name());
>>        object_property_set_link(OBJECT(dev), "parent-gicv3", =
OBJECT(vms->gic),
>=20
>=20


