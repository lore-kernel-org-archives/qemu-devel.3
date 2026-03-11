Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98F97112584F
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 15:48:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0LnB-00013c-Hr; Wed, 11 Mar 2026 11:48:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1w0Ln2-00010A-8q
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 11:48:06 -0400
Received: from p-west2-cluster3-host7-snip4-9.eps.apple.com ([57.103.69.52]
 helo=outbound.mr.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1w0Ln0-0000pf-8n
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 11:48:04 -0400
Received: from outbound.mr.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-2a-60-percent-7 (Postfix) with ESMTPS id
 1FB8918003B5; Wed, 11 Mar 2026 15:47:52 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1773244080; x=1775836080;
 bh=lVa8UcK1PmuTFHxbGnjbH3NP+y0ZzgDMuju+S6BlIwA=;
 h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To:x-icloud-hme;
 b=HGqlz1OXChE5928Emw4MjBBHRNgWwscyDaN4f0Wm8lpJshZ0jPHHL/8S8ZEEmr1MNcr4G8CXKu3JJUbyZCX/Ydopuf5KRmdD5ABAdDEROlh/LfOjFhzd8yfY5cMFWVoMCDeWzY6kFRBfwaRe3h1OnLlH2it8LBAHkYnIrPKsg/QmdW9xrKVpqdnqim/fe58NkNYKgFzUbqgG3G64Cite0ui+ynxuHrwXPuGrqiYSm6OtA2oSHcpakOuse/1NA2Z0j+tdrVPbrjD/C+YCyzB68N5cQGpQuCPEhdmWs+dBIXn61mKeomGYhsVJPCMyveIMd6aJzcfzwZFcXZhVaxavUg==
mail-alias-created-date: 1752046281608
Received: from smtpclient.apple (unknown [17.57.152.38])
 by p00-icloudmta-asmtp-us-west-2a-60-percent-7 (Postfix) with ESMTPSA id
 DF80418003B8; Wed, 11 Mar 2026 15:47:49 +0000 (UTC)
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.400.21\))
Subject: Re: [PATCH 10/14] accel/mshv: implement cpu_thread_is_idle() hook
From: Mohamed Mediouni <mohamed@unpredictable.fr>
In-Reply-To: <20260311-mshv_accel_arm64_supp-v1-10-c31699b7bc1f@anirudhrb.com>
Date: Wed, 11 Mar 2026 16:47:37 +0100
Cc: qemu-devel@nongnu.org, Magnus Kulke <magnuskulke@linux.microsoft.com>,
 Wei Liu <wei.liu@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?utf-8?B?IkRhbmllbCBQLiBCZXJyYW5nw6ki?= <berrange@redhat.com>,
 =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Aastha Rawat <aastharawat@linux.microsoft.com>, qemu-arm@nongnu.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <7AF42CAC-37D6-4120-8B74-E4F86572583B@unpredictable.fr>
References: <20260311-mshv_accel_arm64_supp-v1-0-c31699b7bc1f@anirudhrb.com>
 <20260311-mshv_accel_arm64_supp-v1-10-c31699b7bc1f@anirudhrb.com>
To: Anirudh Rayabharam <anirudh@anirudhrb.com>
X-Mailer: Apple Mail (2.3864.400.21)
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzExMDEzNCBTYWx0ZWRfX1Tfvb/DweDbt
 1WiAI4QXEWaPFElh8sIKV76xBEhJKbzBo4Tpo4GGYWuviXTGNprIUjbLfGZMrhgVVa4TJVx3gOo
 Kof9/mheakmFk1wl3rllx6tPUPktkq3ThzJ/UTKH39SXmjOV0XHKTS10ck7pSuAtzImqETPf5C4
 NEZTMXdyrb3KPOxoP9z93GFHk8cp7VQ/3qtBps5mYR3yBkzDcAqMCRGHGUYzOeBpB89FP4bNmw6
 QUf1Mq9Z+C+g267yN45m0pq3PWGUMB6iqj5ZLn6r/+1vZSwqVokYoETnsAXnqZh9+njLxiPcPgF
 F5kImv4CyFetWJg/Nu6xXrF6LoUmqGDA8IJAG1lbohWzPlOjT+g7zqQ5Sehu1Q=
X-Authority-Info-Out: v=2.4 cv=U+GfzOru c=1 sm=1 tr=0 ts=69b18ead
 cx=c_apl:c_pps:t_out a=9OgfyREA4BUYbbCgc0Y0oA==:117
 a=9OgfyREA4BUYbbCgc0Y0oA==:17 a=kj9zAlcOel0A:10 a=Yq5XynenixoA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=tFGNSmrwAAAA:8 a=yMhMjlubAAAA:8
 a=JYufygBZZNIU-1FwLxcA:9 a=CjuIK1q_8ugA:10 a=O8hF6Hzn-FEA:10
 a=LpD6Tdepsyerr7eS-Jg7:22
X-Proofpoint-GUID: Sy2XdUffxznWvVJUzZYICV0_ZGLpQvaR
X-Proofpoint-ORIG-GUID: Sy2XdUffxznWvVJUzZYICV0_ZGLpQvaR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-11_02,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 mlxscore=0 clxscore=1030 bulkscore=0
 mlxlogscore=999 spamscore=0 adultscore=0
 lowpriorityscore=0 phishscore=0 malwarescore=0 classifier=spam authscore=0
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2603110134
X-JNJ: AAAAAAABf6G49sJ3dAk2XhNzIQ1BC50b/ymD0OR7GK5JGkwm9g8Wd7cqPzqFJ+6WJ1w4ZZvKkGR71h9hphWYYrY1dJi+PAFhu19DFktuURV1D/5HNxnoswsEpVzP2lBWSTC8jssrtV1ANovqgehN6f6Y2t441CtY+2RQa75SKzPQQGytVjJWSC7HSr28R0qQC0H50TE5O6m1HN5RQijBH+xqP52Lyzni+1tutI7KFXS1rt92CVCZ24ehtYC+mZAtYRHWY/VI/Rdj5eTjKoUrRrW9tXpOkBf/i6h2Z9bXCv6pMFGTExGwdnIP6Itz1i0LcjbJ9ezD0Tw0aIcUhkxHLmn0MHwHnum1a5ylRfLeoHVOlkeK6mH138PL233LAlVfkPQP5Bc8gMH3LAuGdfUv/QQC1Hes3N9+zC0saAxMcl2rZu3ekt5uFboJEbX7JfGDdXr5hXZAPmYZ5R/3lDSc8WGXMX3pLGQBkolgTkQG/A7btfgFQKDqBZjkcjNlYsOGIXxCfLNV39UFGO87QYsyO2ZL5NiER2CkbV8+gS5Xa7OlHde/umxCGqcrTE4ZXGJ+KKTD1vkqA+ainS+O6UuekPY6lO3kxGascY+304sRm32q8TIcluJJUN3MZ9pFaya+Rul4dkXP35kjgE5CjAuAVHMc/rYAw5Msw9FBdOo610AZeKKt81ErrvpQmoFs+YMeITxOC1k/mb3xDQj5Lzn0OVlynjbr8w0R0EHJX3I/z6E7KccT/w==
Received-SPF: pass client-ip=57.103.69.52;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.mr.icloud.com
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



> On 11. Mar 2026, at 16:15, Anirudh Rayabharam <anirudh@anirudhrb.com> =
wrote:
>=20
> From: Magnus Kulke <magnuskulke@linux.microsoft.com>
>=20
> In MSHV the hypervisor APIC is always used, so we to implement this =
hook
> to make sure the AP's vcpu thread is not blocked waiting for an INIT =
SIPI
> by the BSP. Without this change soft reboots with -smp cpus>=3D2 will
> hang.
>=20
> Signed-off-by: Magnus Kulke <magnuskulke@linux.microsoft.com>
Reviewed-by: Mohamed Mediouni <mohamed@unpredictable.fr>
> ---
> accel/mshv/mshv-all.c | 12 ++++++++++++
> 1 file changed, 12 insertions(+)
>=20
> diff --git a/accel/mshv/mshv-all.c b/accel/mshv/mshv-all.c
> index 563599ef6a..9a101d51ff 100644
> --- a/accel/mshv/mshv-all.c
> +++ b/accel/mshv/mshv-all.c
> @@ -747,11 +747,23 @@ static const TypeInfo mshv_accel_type =3D {
>     .instance_size =3D sizeof(MshvState),
> };
>=20
> +/*
> + * MSHV manages the LAPIC in the hypervisor. SIPI for APs are handled
> + * internally. Halted vCPUs must still enter mshv_cpu_exec() so that
> + * MSHV_RUN_VP is called and the hypervisor will deliver SIPI to wake =
APs.
> + */
> +
> +static bool mshv_vcpu_thread_is_idle(CPUState *cpu)
> +{
> +    return false;
> +}
> +
> static void mshv_accel_ops_class_init(ObjectClass *oc, const void =
*data)
> {
>     AccelOpsClass *ops =3D ACCEL_OPS_CLASS(oc);
>=20
>     ops->create_vcpu_thread =3D mshv_start_vcpu_thread;
> +    ops->cpu_thread_is_idle =3D mshv_vcpu_thread_is_idle;
>     ops->synchronize_post_init =3D mshv_cpu_synchronize_post_init;
>     ops->synchronize_post_reset =3D mshv_cpu_synchronize_post_reset;
>     ops->synchronize_state =3D mshv_cpu_synchronize;
>=20
> --=20
> 2.43.0
>=20
>=20


