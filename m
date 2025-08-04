Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E710C87FCF
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Aug 2025 21:00:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uj2Hn-00088P-Og; Mon, 04 Aug 2025 17:00:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1uj2Hc-000853-Rm
 for qemu-devel@nongnu.org; Mon, 04 Aug 2025 16:59:49 -0400
Received: from p-east3-cluster5-host2-snip4-5.eps.apple.com ([57.103.86.146]
 helo=outbound.qs.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1uj2Ha-00018v-Nx
 for qemu-devel@nongnu.org; Mon, 04 Aug 2025 16:59:48 -0400
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-2d-60-percent-2 (Postfix) with ESMTPS id
 7797718000AC; Mon,  4 Aug 2025 20:59:41 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; bh=yJK3r1fFOMJfBGotVvXALMJuZk77ijuD11x34Jzwqos=;
 h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To:x-icloud-hme;
 b=D4DFnANoJ5C0FSEeEYFIyMjj7o0GIFCvA5fW0b2Kp0JQDR5LJsDPCJRyLmC3l6YeZdJ23RvFY6XyxSt2EBmOIuTYd3cRK/7mSYgAYRDRUOEQHBKltcFKyAJ4JyWOwy8iwN40Y/hDXm1FvSx7Uct9bkIKWkL/MEFxO+jEbVQ9uGaPukJ+nwArtRcPeYpshScKLydXu+GYYGF5yhfaL0NTJYw+7bcEDKymvNM2avzZrQS/ZUtsy0JNHS9+wOkqm3nK8zj/vi7vtGDYyn5Vw7AYZGNyKzV61cZV2EOODhboziRMaPClVCYUC+CNXZkaGwiBwjy8ApnhgjfjUnFuhjnXBQ==
X-Client-IP: 46.189.47.18
Received: from smtpclient.apple (qs-asmtp-me-k8s.p00.prod.me.com
 [17.57.155.37])
 by p00-icloudmta-asmtp-us-east-2d-60-percent-2 (Postfix) with ESMTPSA id
 568D5180009F; Mon,  4 Aug 2025 20:59:38 +0000 (UTC)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3860.100.5.1.1\))
Subject: Re: [PATCH v4 12/17] hw/arm: virt: cleanly fail on attempt to use the
 platform vGIC together with ITS
From: Mohamed Mediouni <mohamed@unpredictable.fr>
In-Reply-To: <2bb26ff6-8ee5-4255-b8df-27aec29b56a9@linaro.org>
Date: Mon, 4 Aug 2025 22:59:26 +0200
Cc: qemu-devel@nongnu.org, Shannon Zhao <shannon.zhaosl@gmail.com>,
 Ani Sinha <anisinha@redhat.com>,
 =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
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
Message-Id: <9A4DE34A-784C-4501-B8AD-A93CBFB795B1@unpredictable.fr>
References: <20250804142326.72947-1-mohamed@unpredictable.fr>
 <20250804142326.72947-13-mohamed@unpredictable.fr>
 <a8239e8e-37ad-415c-b13a-4b4ce8fa2a36@linaro.org>
 <2BF73501-00C6-4194-B75C-CD50A8807314@unpredictable.fr>
 <2bb26ff6-8ee5-4255-b8df-27aec29b56a9@linaro.org>
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
X-Mailer: Apple Mail (2.3860.100.5.1.1)
X-Proofpoint-GUID: 916tm10gzln6jWU93H3Y5pBT858w0yQe
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA0MDEyNiBTYWx0ZWRfX0nGR2l59p2f0
 WJOIDT5k49rSOlZTGQTfB6vpzn3h0nRFKWDs/+3yAYg3qdpEAzTGRipkgsmOSXB/tGRrobqaH6H
 /Cw/O9Y3saudY5knEp8rPP3kesso5gymcGTs2aeNVOIbbFiT7QMkB5CdyBr0/JyhU6OTq7oUZtt
 Aj6Bzfzt3VT5wkDujSl4AArOYzXDBWlfMEo2lkgohyl5mb+0VYs3WmVGmlLYvJ5ptyHyGJurTNT
 DVy9kZVPbBVvRA0Q/5KM8lYO1o00OKu0tvJrzk4FUHfaudEKCZfmv+iU6uiNKd07Q+TLGSSkU=
X-Proofpoint-ORIG-GUID: 916tm10gzln6jWU93H3Y5pBT858w0yQe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-04_09,2025-08-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 clxscore=1030 spamscore=0 malwarescore=0 adultscore=0 suspectscore=0
 mlxlogscore=999 phishscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2506270000 definitions=main-2508040126
Received-SPF: pass client-ip=57.103.86.146;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.qs.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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



> On 4. Aug 2025, at 22:40, Pierrick Bouvier =
<pierrick.bouvier@linaro.org> wrote:
>=20
> On 8/4/25 12:56 PM, Mohamed Mediouni wrote:
>>> On 4. Aug 2025, at 21:50, Pierrick Bouvier =
<pierrick.bouvier@linaro.org> wrote:
>>>=20
>>> Is it equivalent to simply using its=3Doff, or is there a =
difference?
>>> The info_report seems to imply it's not the same.
>> Not equivalent.
>> Regular system: GICv3 + ITS
>> This configuration (for the newest machine version): GICv3 with no =
MSIs
>> And its=3Doff explicitly: GICv3 + GICv2m
>> It became not equivalent since the intro of GICv3 + GICv2m in patch 2 =
of this series.
>>=20
>> Thank you,
>=20
> I see. It could be worth adding this information to commit message.
> With that,
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>=20
> Slightly off topic for this commit, is there any downside to always =
have GICv3 + GICv2m setup enabled? Do some systems don't support GICv2m?
>=20
GICv2m is modelled as a device external from the GIC, and so it can be =
emulated everywhere.

It can be done but then it supposes that the same Qemu command line will =
expose a different device model (instead of just MSI support missing) =
when ran on a different system. Not sure that=E2=80=99s the right thing =
to do=E2=80=A6

That=E2=80=99s because the current setup already has ITS on by default =
when a GICv3 is chosen.

Note that GICv3 + GICv2m* hardware exists in the wild (Graviton1 =
notably) but VMs have a GICv3 w/ ITS configuration there.

* not quite, but gets shoehorned in with Linux quirks

Thank you,
-m


