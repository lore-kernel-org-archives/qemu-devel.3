Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75012CA0EDC
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Aug 2025 13:19:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1umXiU-0003C0-LM; Thu, 14 Aug 2025 09:10:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mads@ynddal.dk>) id 1umXiO-00035D-HF
 for qemu-devel@nongnu.org; Thu, 14 Aug 2025 09:09:57 -0400
Received: from p-east1-cluster3-host6-snip4-10.eps.apple.com ([57.103.91.191]
 helo=outbound.ci.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mads@ynddal.dk>) id 1umXiH-00067L-1V
 for qemu-devel@nongnu.org; Thu, 14 Aug 2025 09:09:56 -0400
Received: from outbound.ci.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-central-1k-20-percent-1 (Postfix) with ESMTPS id
 AFE411800195; Thu, 14 Aug 2025 13:09:40 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ynddal.dk; s=sig1;
 bh=w2CjkhliRfAUzMGtjsGF2RwoF2pCByth6J1Vhgg6ddo=;
 h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To:x-icloud-hme;
 b=jT3Whi09pKUZydcLOnzwiDB+3KcKr0WrS+MDq7cHXqM9qVIjLSjt+CVFwjueZ9/a4RlGAwFF3j9o3GGCDf6i/kvHloawSsa+ygL5PNN+FHFXC79RMbltzcK1VN+1lzq3999Qntekw7YsxwLQXsrvUC4ug64Lqq2YD2wQlqlxGqBMC33RcXls+COuGPieahGqApNdhJKNCZX0CNAqKVqTop9+QhDjEsSsmiCmY98pDN3JqFGCrnHzvTvtprLbL9BAI+llu/cGn++xJaA3n6A3QOGQzalo6oUKQpa5x0I3dgXvt1i+rSXdNpo/yIx54wJkW/UbFgP7Qm469+hK1yg0Cg==
X-Client-IP: 212.60.126.184
Received: from smtpclient.apple (ci-asmtp-me-k8s.p00.prod.me.com
 [17.57.156.36])
 by p00-icloudmta-asmtp-us-central-1k-20-percent-1 (Postfix) with ESMTPSA id
 3BF1B1804E16; Thu, 14 Aug 2025 13:06:56 +0000 (UTC)
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH v6 12/13] target/arm: hvf: instantiate GIC early
From: Mads Ynddal <mads@ynddal.dk>
In-Reply-To: <20250808070137.48716-13-mohamed@unpredictable.fr>
Date: Thu, 14 Aug 2025 15:06:44 +0200
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Shannon Zhao <shannon.zhaosl@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 qemu-arm@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Roman Bolshakov <rbolshakov@ddn.com>, Igor Mammedov <imammedo@redhat.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>, Alexander Graf <agraf@csgraf.de>,
 Cameron Esfahani <dirty@apple.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <FB7A9640-30C1-47FD-A1B7-73A7333BDB23@ynddal.dk>
References: <20250808070137.48716-1-mohamed@unpredictable.fr>
 <20250808070137.48716-13-mohamed@unpredictable.fr>
To: Mohamed Mediouni <mohamed@unpredictable.fr>
X-Mailer: Apple Mail (2.3826.700.81)
X-Proofpoint-GUID: XVFlJKab-qIt-4RmFc5HXcLpoDqQ8vvL
X-Proofpoint-ORIG-GUID: XVFlJKab-qIt-4RmFc5HXcLpoDqQ8vvL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE0MDExMCBTYWx0ZWRfX2LZeA7mRVYqs
 5mfFKvnu4hE3q3/NF7ybH4bpLlEb1dxehlZWtIESXwauW3WxmoULO1wmZKDUyKaidEKxf3kp2Mk
 F6oL6oBpp0ncpFqDrEV6FutpsNlhRMStC5uNeAZaqJRa0+YZ+vcJMtapqLNp1IDmQokIn1SGxKh
 BgdAKUQfXqa3xsf6l7gAqO1EOv87CXbQQVYO7kMNQuZzfg9fMqGcAP/NV5ozMn6Tvy9v67sKKVX
 f7thq9g5rVOWtC8SMQBitY1D4NkSdgQIdQByz3huLbyzl/9pxnNFPvpzVt9LDwBBRu4Yo3noQ=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-13_02,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=892
 malwarescore=0 mlxscore=0 spamscore=0
 suspectscore=0 clxscore=1030
 phishscore=0 bulkscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2506270000 definitions=main-2508140110
Received-SPF: pass client-ip=57.103.91.191; envelope-from=mads@ynddal.dk;
 helo=outbound.ci.icloud.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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
> While figuring out a better spot for it, put it in =
hv_arch_vm_create().
>=20
> After hv_vcpu_create is documented as too late, and deferring
> vCPU initialization isn't enough either.
>=20
> Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
> ---
> target/arm/hvf/hvf.c | 15 +++++++++++++++
> 1 file changed, 15 insertions(+)
>=20
> diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
> index 6da636724b..bb7b84ff35 100644
> --- a/target/arm/hvf/hvf.c
> +++ b/target/arm/hvf/hvf.c
> @@ -1084,6 +1084,21 @@ hv_return_t hvf_arch_vm_create(MachineState =
*ms, uint32_t pa_range)
>     }
>=20
>     ret =3D hv_vm_create(config);
> +    if (hvf_irqchip_in_kernel()) {
> +        /*
> +         * Instantiate GIC.
> +         * This must be done prior to the creation of any vCPU
> +         * but past hv_vm_create()
> +         */
> +        hv_gic_config_t cfg =3D hv_gic_config_create();
> +        hv_gic_config_set_distributor_base(cfg, 0x08000000);
> +        hv_gic_config_set_redistributor_base(cfg, 0x080A0000);
> +        hv_return_t err =3D hv_gic_create(cfg);
> +        if (err !=3D HV_SUCCESS) {
> +            error_report("error creating platform VGIC");
> +            goto cleanup;
> +         }
> +    }
>=20
> cleanup:
>     os_release(config);
> --=20
> 2.39.5 (Apple Git-154)
>=20

It is difficult to find a place to initialize the GIC config, so I don't
know if it gets better than this.

Should the values 0x08000000 and 0x080A0000 be defined somewhere, or
found through a look up? I see hw/arm/virt.c has them in the
base_memmap.

You can do os_release(cfg) after hv_gic_create.=

