Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 055B4CAC5B0
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Oct 2025 13:50:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4JgI-0001aP-C0; Thu, 02 Oct 2025 09:49:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1v4JgB-0001Ws-Es; Thu, 02 Oct 2025 09:49:08 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1v4Jg2-0000xO-0X; Thu, 02 Oct 2025 09:49:07 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 592CKdks021593;
 Thu, 2 Oct 2025 13:48:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=9aQviV
 YzPc9Pt5F8k6sPXJWvutfIDvcptbfLn8Zm4J4=; b=kf7Axj7FdlWoD1nko4YY8y
 eK+Cfy0eV/vumHwJJcwSMC7ob4cKNutfKJQgvke2KH27ascZOAiBmWlbmkJlMUYN
 u2nXpuGK7kcmyojaRUr7LIlghFnkV5pWQpm0PBH9dplPhv/gTMD1gerkuPITM67c
 9VoQKskfrXLWX9zWt1Zv1I7v59oyiAtSECp4cMWhn8jT8HFcv1+xyWHmlkt/zqf6
 igJhrpmPL4ke1bHcT/avSUDu9ZUj0jSY/6c8epyWEqwj/zZUPVuJ5o01fad/Qoy2
 4UcIWSicvnAx2Vr5mvj5Zc24Vlsio+QjSBHKQ/I14MQTOJ8S5W8mOHphuKrrs0Cw
 ==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49e7e7nu2e-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 02 Oct 2025 13:48:38 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 592CUCSd003325;
 Thu, 2 Oct 2025 13:48:36 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 49etmy6bd0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 02 Oct 2025 13:48:36 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com
 [10.241.53.102])
 by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 592DmZTB20906556
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 2 Oct 2025 13:48:35 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7BCEB5805A;
 Thu,  2 Oct 2025 13:48:35 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BB5055803F;
 Thu,  2 Oct 2025 13:48:34 +0000 (GMT)
Received: from li-479af74c-31f9-11b2-a85c-e4ddee11713b.ibm.com (unknown
 [9.61.134.141]) by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Thu,  2 Oct 2025 13:48:34 +0000 (GMT)
Message-ID: <b12255dc056d0c5c0fc238ef01865674ca67233d.camel@linux.ibm.com>
Subject: Re: [PATCH] s390x/pci: set kvm_msi_via_irqfd_allowed
From: Eric Farman <farman@linux.ibm.com>
To: Matthew Rosato <mjrosato@linux.ibm.com>, qemu-s390x@nongnu.org
Cc: thuth@redhat.com, pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 richard.henderson@linaro.org, david@redhat.com, iii@linux.ibm.com,
 qemu-devel@nongnu.org
Date: Thu, 02 Oct 2025 09:48:34 -0400
In-Reply-To: <20251001200511.325815-1-mjrosato@linux.ibm.com>
References: <20251001200511.325815-1-mjrosato@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 5VqQjSqVm0syQdjb_jgWfVfF-4dOPsO8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI3MDAyMCBTYWx0ZWRfX9ZPFekjZQQf3
 UeBkHYwNQqXjR2nJiFx4opz4mceLqGcyerK8iPB7eN2ppvbOo4Q4zTvOyp629HkEtXGuj6dhIq6
 y+dZ7gOt1eeosu2KVctrioVKVqnpzv2aJp+OI7s4FoTwhaEmPMnp1pD9Kk24/VLMriKryEv1POm
 JJDuxxTJ69EeAtCKvxwlINKGt8hlDXnAjPtLhrab0AG5zid38jZJeGYHTKVYfxB0b92NwReZ8pu
 Wsumi+jwt2V7fpuQL/YvvGGmCWrATgO6yzH0dTZaqwnvVVvM79V+/mf84InpSanTLc2dmKFF0dQ
 YHyApPKcyEPTaEmbIZ/kSPTYOwwpfWiggRlCGrTjmWxwCewlnUlGgdtfdAWdnn5ehg2APH3FRAD
 czxqYuW9mIWi8ARn3msZ3VI0lR7JZg==
X-Proofpoint-GUID: 5VqQjSqVm0syQdjb_jgWfVfF-4dOPsO8
X-Authority-Analysis: v=2.4 cv=Jvj8bc4C c=1 sm=1 tr=0 ts=68de82b6 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VnNF1IyMAAAA:8 a=rYs2pAiug4XxLha7xFkA:9
 a=NqO74GWdXPXpGKcKHaDJD/ajO6k=:19 a=QEXdDO2ut3YA:10 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-02_05,2025-10-02_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 priorityscore=1501 impostorscore=0
 suspectscore=0 phishscore=0 bulkscore=0 clxscore=1015 spamscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2509150000
 definitions=main-2509270020
Received-SPF: pass client-ip=148.163.156.1; envelope-from=farman@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, 2025-10-01 at 16:05 -0400, Matthew Rosato wrote:
> Allow irqfd to be used for virtio-pci on s390x if the kernel supports
> it.
>=20
> Signed-off-by: Matthew Rosato <mjrosato@linux.ibm.com>
> ---
>  hw/s390x/s390-pci-bus.c | 1 +
>  1 file changed, 1 insertion(+)

As Matt alluded to in another reply, this is probably just historical overs=
ight.

Reviewed-by: Eric Farman <farman@linux.ibm.com>

>=20
> diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
> index e8e41c8a9a..88852acf45 100644
> --- a/hw/s390x/s390-pci-bus.c
> +++ b/hw/s390x/s390-pci-bus.c
> @@ -900,6 +900,7 @@ static void s390_pcihost_realize(DeviceState *dev, Er=
ror **errp)
>      s390_pci_init_default_group();
>      css_register_io_adapters(CSS_IO_ADAPTER_PCI, true, false,
>                               S390_ADAPTER_SUPPRESSIBLE, errp);
> +    kvm_msi_via_irqfd_allowed =3D kvm_irqfds_enabled();
>  }
> =20
>  static void s390_pcihost_unrealize(DeviceState *dev)

