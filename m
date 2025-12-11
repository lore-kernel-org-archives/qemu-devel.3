Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B689D3E78B
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Dec 2025 04:10:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vTXzv-0005WF-Me; Wed, 10 Dec 2025 23:09:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vTXzt-0005W4-BA
 for qemu-devel@nongnu.org; Wed, 10 Dec 2025 23:09:45 -0500
Received: from p-west1-cluster3-host3-snip4-6.eps.apple.com ([57.103.66.69]
 helo=outbound.pv.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vTXzr-0005YZ-3r
 for qemu-devel@nongnu.org; Wed, 10 Dec 2025 23:09:45 -0500
Received: from outbound.pv.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-1a-20-percent-3 (Postfix) with ESMTPS id
 7406718000B6; Thu, 11 Dec 2025 04:09:35 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; bh=+9UjHun5UTmn6Gs5sLgq4LJBUv1jInx8rHtqHovLT74=;
 h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To:x-icloud-hme;
 b=arkewZ2TGOdYEduykMfuZ3eKnY8Hzg8TppFe0jzYQQn9qBGJ1ZaljUHvAfi3s7+KQPwC/HnoJ0mtIgYcZcRQonIkinvclEcYCGCiQ8xKQ7ksjCwfPL8cEdfl0hOxdk7BF/mCOsd4HhzpiZWHDUEELoguljTcgBcoX6+CQ2C221fi5vniypSNo1WL0brCD+xovMsT9+Sc8Tli9xWMSvhBe/kNTjXrwiAUUzkqdubARzY6ap0ogOCx3p032YM5Qg+lXxFTEuKDBKHoYvIxaT73STkHBIaVYeYK0nRhMnxIqnrG0ceRSaaJeRbpWHruxfB5zi7sRU5HNEjGYKXHTkOgXg==
mail-alias-created-date: 1752046281608
Received: from smtpclient.apple (unknown [17.56.9.36])
 by p00-icloudmta-asmtp-us-west-1a-20-percent-3 (Postfix) with ESMTPSA id
 A282918000AC; Thu, 11 Dec 2025 04:09:33 +0000 (UTC)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.200.81.1.6\))
Subject: Re: [PATCH RFC 2/7] virtio-gpu-virgl: check page alignment of blob
 mapping
From: Mohamed Mediouni <mohamed@unpredictable.fr>
In-Reply-To: <20251203040754.94487-3-j@getutm.app>
Date: Thu, 11 Dec 2025 05:09:21 +0100
Cc: qemu-devel@nongnu.org,
 =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <9E75DEF6-30FB-4136-8CFC-E6154C91058E@unpredictable.fr>
References: <20251203040754.94487-1-j@getutm.app>
 <20251203040754.94487-3-j@getutm.app>
To: Joelle van Dyne <j@getutm.app>
X-Mailer: Apple Mail (2.3864.200.81.1.6)
X-Authority-Info: v=2.4 cv=ft3RpV4f c=1 sm=1 tr=0 ts=693a43ff cx=c_apl:c_pps
 a=azHRBMxVc17uSn+fyuI/eg==:117 a=azHRBMxVc17uSn+fyuI/eg==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=DPrs_iQuYpXKpRMb13MA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: qtNCkB0k-sDjalQAaj9PZGvky8TVwqyf
X-Proofpoint-ORIG-GUID: qtNCkB0k-sDjalQAaj9PZGvky8TVwqyf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjExMDAyNSBTYWx0ZWRfX3GjVzBhOtBex
 WloC6dsGH8/OZxbMSQhMGGc25uO/DHhHCmTfcUPzbrMWIDsfo94UU+/hRG+jw77UF5RyprQAzKl
 mp1J2yA1oDWowt6wChZnoItxiHO3D7xgoor/pXIQ/l3DZ3LtPj69idPJLYDXVLAwojWgWnNcDHU
 yHSwZIPn8vMtxD1WZovcJ5NOz96mdVGYeuGqzhP4zhSfN1sMUAR4gSDTi4qbM7dCvl7KdRg5c/D
 FJzAOCycSNAxzXYhtUd88RR7yGCZkK1JcDXSdIfgHTrVEs5S2v3jEUT3DuuK3lQJ/oa46nvLs2Y
 +e03UGAjAUmp9vdIWw7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-10_03,2025-12-09_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 adultscore=0 spamscore=0 mlxscore=0 bulkscore=0
 suspectscore=0 phishscore=0
 clxscore=1030 malwarescore=0 classifier=spam authscore=0 adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2510240001 definitions=main-2512110025
X-JNJ: AAAAAAABpDkXUN8FbsLeZo/Cm9180iRLx4MXl1GVZazBtlv45FC2vIXW5GNK27makZnXK/T0nuGJp4S/ckuo00OJdHcdba6vhOMv76MqGdYRWZzP3RczuJyQa7LwCAmqW9WYchumbVU+r+G4zspOG0prO/XBcnJ7hqbQEIXyRY0o0Vj8BIQ4EJvWFGkA/vdBYQF00qGd5nBOeOJpsGnWE0lB1dE7ArjI5fJ0jc6IxIQ/k9sjoGaZJVSMefN/VXnIavel10hIHdwz4Cc2JmOS3jfyeqPv0/USapVH5rx3yvJbko57BNVUb2crp8BiqPtw6tHg/b0MHjmcGBqM5VaD8OZpkd88hY6fQHwDXADOukHnSShUgeW6Zv4o0ySF5ziU/aNE2FSuNtcYze0p4NY4Q15xTDDIcBQTmNDG60KtM25c+oNeuy4ox3zvJ4lDUwgYBAhh2akI320mLVtwz3at7cNbyK1o+f9pCZg9EuQXdUlcCBAiJWhxhLuU4yQqDLcgzKjTSXxk+lCEM4KUBB4f0Ukk5FdWMfLS5183Z+RCrp03LlqfzFBnhc6PdQAP5ysri1vtnFpP24B9F11EwKQ6jprBM3pY7w1xIzc7bP2sgChNdwSx45IHrccQz2amkon0UKU22Xy2lGsSp+VhRAu3+TPViPlCg5qCAvDIW5veyoKO/kDQ6NvO5LhfQWSwTB08ehcW2m6YQUfdFUhaYB7dZXhQud8=
Received-SPF: pass client-ip=57.103.66.69;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.pv.icloud.com
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



> On 3. Dec 2025, at 05:07, Joelle van Dyne <j@getutm.app> wrote:
>=20
> Currently if a mapping is not page aligned, it will sliently fail and =
the
> guest, assuming it is mapped, will attempt to access the memory and =
fail.
> This is particularly an issue on macOS when the host page size is =
16KiB and
> the guest page size is 4KiB.
>=20
> Signed-off-by: Joelle van Dyne <j@getutm.app>
> ---
> hw/display/virtio-gpu-virgl.c | 14 ++++++++++++++
> 1 file changed, 14 insertions(+)
>=20
> diff --git a/hw/display/virtio-gpu-virgl.c =
b/hw/display/virtio-gpu-virgl.c
> index 20c856c04e..adf02ac22b 100644
> --- a/hw/display/virtio-gpu-virgl.c
> +++ b/hw/display/virtio-gpu-virgl.c
> @@ -116,6 +116,20 @@ virtio_gpu_virgl_map_resource_blob(VirtIOGPU *g,
>         return ret;
>     }
>=20
> +    if (!QEMU_IS_ALIGNED((uintptr_t)data, =
qemu_real_host_page_size())) {
> +        virgl_renderer_resource_unmap(res->base.resource_id);
> +        qemu_log_mask(LOG_GUEST_ERROR, "%s: address %p is not aligned =
to page size\n",
> +                      __func__, data);
> +        return -ENOMEM;
> +    }
> +
> +    if (!QEMU_IS_ALIGNED(size, qemu_real_host_page_size())) {
> +        virgl_renderer_resource_unmap(res->base.resource_id);
> +        qemu_log_mask(LOG_GUEST_ERROR, "%s: size 0x%llx is not =
aligned to page size\n",
> +                      __func__, size);
> +        return -ENOMEM;
> +    }
> +
>     vmr =3D g_new0(struct virtio_gpu_virgl_hostmem_region, 1);
>     vmr->g =3D g;
>=20
> --=20
> 2.41.0
>=20
>=20

Hello,

There=E2=80=99s a better way to handle this without guest breakage.

Please use hv_vm_config_set_ipa_granule, it=E2=80=99ll allow to have 4KB =
granule allocations as the IPA.

Note: This might have some impact on performance so we might to want to =
enable it only when virtio-gpu is used.

Thank you,





