Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F452CA0EE4
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Aug 2025 12:31:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uohxQ-00034l-JR; Wed, 20 Aug 2025 08:30:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mads@ynddal.dk>) id 1uohxL-00032H-J5
 for qemu-devel@nongnu.org; Wed, 20 Aug 2025 08:30:21 -0400
Received: from p-west3-cluster5-host3-snip4-6.eps.apple.com ([57.103.72.29]
 helo=outbound.ms.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mads@ynddal.dk>) id 1uohxJ-0002tk-9k
 for qemu-devel@nongnu.org; Wed, 20 Aug 2025 08:30:19 -0400
Received: from outbound.ms.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-3a-100-percent-10 (Postfix) with ESMTPS id
 537A31800217; Wed, 20 Aug 2025 12:30:07 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ynddal.dk; s=sig1;
 bh=4n2wHqWaOgeBaKj98C9SbnSQaMjNEQ5Pb0GJYh3lJ6E=;
 h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To:x-icloud-hme;
 b=FqtR+FvzrdqzFH3XO/vr/3v4HaGs9cXbMuMHyqj1PetXkNltEkjUMN8eP32rfyB1WxaGcj3VDGHfU3qqncgLS7fDUl/9V+1TwMZ4BVImGLHia4fox9oC4r7vdof5RB8ZRJYrFVEDCJFxKUIsL49sSJyJ7oM4LlfrHHuXfUxZde+rwrPDXoN5gOz40bn+tfCGaysy8Er0D2MoRjR9Sa5qK1X/qP9houYJsHHA7Hv6JpKQh8K6kcbMY/bloeg578E44kbq1LFr0CJ9EcssaHgtIA+3e1P0F2CDM9a1c9OSCUYFitx024Yn2bfrSxEhH62dzHmZGnginMQgk0AphoS4Fg==
X-Client-IP: 194.62.217.67
Received: from smtpclient.apple (ms-asmtp-me-k8s.p00.prod.me.com
 [17.57.154.37])
 by p00-icloudmta-asmtp-us-west-3a-100-percent-10 (Postfix) with ESMTPSA id
 6CD4318002C5; Wed, 20 Aug 2025 12:30:04 +0000 (UTC)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH v6 02/13] hvf: switch hvf_arm_get_host_cpu_features to not
 create a vCPU
From: Mads Ynddal <mads@ynddal.dk>
In-Reply-To: <20250808070137.48716-3-mohamed@unpredictable.fr>
Date: Wed, 20 Aug 2025 14:29:52 +0200
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Shannon Zhao <shannon.zhaosl@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 qemu-arm@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Roman Bolshakov <rbolshakov@ddn.com>, Igor Mammedov <imammedo@redhat.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>, Alexander Graf <agraf@csgraf.de>,
 Cameron Esfahani <dirty@apple.com>,
 =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <F4920F23-C99A-494A-9960-02A53513DBF8@ynddal.dk>
References: <20250808070137.48716-1-mohamed@unpredictable.fr>
 <20250808070137.48716-3-mohamed@unpredictable.fr>
To: Mohamed Mediouni <mohamed@unpredictable.fr>
X-Mailer: Apple Mail (2.3826.700.81)
X-Proofpoint-GUID: j09U-xiItW9mSoOr8KazTJgN6bNsy3wU
X-Proofpoint-ORIG-GUID: j09U-xiItW9mSoOr8KazTJgN6bNsy3wU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIwMDExMCBTYWx0ZWRfX97wB1euIRTR1
 Yu4ZuGOggHPJ+xsiL+SVt8MNPZmnZneQti7bJRwk90RKYw8NoRv/qVcnuTEQSi5i11P1dZ/D5+5
 35lrPGDCLNC//CZIqPA4uoglC8WVgaSxBnQdtsTsbwV6e83eb3TwrzIS6Rur4etwoRDX4AJinhw
 Kj5COpu4tq9RVZC70uidtiMCPRhHmGgJMxIOyGpr/ogEhwqU5lMY7M7rtFijfi9QAQck+notR9q
 6ZCVoFNQY0vWOwripFsefGfLTPoiXH7nzGsXiqHSHr7FWjsHWagke+Av+aHG9YKlEsem2lZV0=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-20_04,2025-08-20_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1030
 adultscore=0 spamscore=0 mlxlogscore=925 malwarescore=0 mlxscore=0
 bulkscore=0 phishscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2506270000 definitions=main-2508200110
X-JNJ: AAAAAAAB0B0849wScDNMFfOita2Oj26NuB8kB2Pl+F8eCa96ikFGD5HdmlHrCqmBAgKsFtTHrfAVO8xYdHJex0pNlBtu/XdMXnXgpCxEpT/5jSyZff303wWgPJe+LUMb1z/9l2TPcGGGtP+2oC0B7/vuoYeYaelvM3UPXnUaDcr4pyAaRFXiJj369mKcaKFVoqwvSaHZNq5xxuKjsSgiM4vz8jCzcm9FLySCMKY1C/OrZJAtrzLs9w9LusPP3PCW8lwnCOsbGQgWWfsdwJzPTPJjlXcTMmatSaHU3yHWeSrbKgUCPsxig8hwrUc14Jbl8s2uGOOGiPoop0LJ2in1kKF5vv+n6aJlzH3EcuwMbPRg99ONLeVSXi4k3ky76CWid9xYbzzA1PPLuuh4uOwDRB1dTkBJrB/j4F8F4gt9cCAbzcikQ6kpXummtWjPnkErCslk7ROPQ+Fww5McIZCd1Rc2BBH6C3PdF5Z7YMhKVTRwEezFvJYuEHgmf/94P8p1DiRhG6zwafHCovz41gKoBDKJODLY6PJPpQfLeWqsdr1A1tMc0xlTBEkI75nl0lGkznLdHGcos1ZbyC+FT9e4RHelDfIZe5pHRokc
Received-SPF: pass client-ip=57.103.72.29; envelope-from=mads@ynddal.dk;
 helo=outbound.ms.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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


> On 8 Aug 2025, at 09.01, Mohamed Mediouni <mohamed@unpredictable.fr> =
wrote:
>=20
> Creating a vCPU locks out APIs such as hv_gic_create().
>=20
> As a result, switch to using the hv_vcpu_config_get_feature_reg =
interface.
>=20
> Hardcode MIDR because Apple deliberately doesn't expose a divergent =
MIDR across systems.
>=20
> Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
>=20
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
> target/arm/hvf/hvf.c | 36 +++++++++++++++---------------------
> 1 file changed, 15 insertions(+), 21 deletions(-)
>=20

Good way to avoid the limitations of hv_gic_create.

Reviewed-by: Mads Ynddal <mads@ynddal.dk>=

