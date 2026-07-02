Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D784C43458
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2026 14:57:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfIqJ-0004W4-N8; Thu, 02 Jul 2026 10:56:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1wfIqH-0004Vb-Pp; Thu, 02 Jul 2026 10:56:41 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1wfIqG-0003YM-10; Thu, 02 Jul 2026 10:56:41 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 662EID8c4134379; Thu, 2 Jul 2026 14:56:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=mBXFhS
 mXWt44+Z4MiuGGLDykDwAgyJ9dX1ryZEgGGGM=; b=fCCL93cu4XBzLFhd+qRCLi
 A4pKAfgZkIxQkZl1fidbBx/zh5/fJlfOO9INC5vsMV6aGSJ/K+0Ap2IgKXWxZjs1
 txeh+KjuWFLMrRuxEaKoJ7WTvGWUzosJUljCD95gjOy9QCtbjDe3ZhL7La+s0Fjp
 Y+azuiFmZhA8e+HygbraZc38UvaF2p0blPEvwFoUwFSXAIEype03JF4nd1JjrSxg
 Zla0xgYdQceCix+546b8CkNpH9aMh/xklAw8C918I3Tuhvpc6AG2/3541+EWfuD8
 8Cd4vF9gQky1Hw5vLipKJxKikJWs4eOCucgbjeIKgTMWIQqJPSeltHF09Nb8jzlA
 ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f26peam5y-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 02 Jul 2026 14:56:35 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 662Encuk005419;
 Thu, 2 Jul 2026 14:56:34 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4f2sukcfjh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 02 Jul 2026 14:56:34 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com
 [10.241.53.101])
 by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 662EuXwr33227406
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 2 Jul 2026 14:56:33 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3531D5805E;
 Thu,  2 Jul 2026 14:56:33 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B29645805C;
 Thu,  2 Jul 2026 14:56:31 +0000 (GMT)
Received: from li-479af74c-31f9-11b2-a85c-e4ddee11713b.ibm.com (unknown
 [9.61.136.69]) by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Thu,  2 Jul 2026 14:56:31 +0000 (GMT)
Message-ID: <5dd80793bb0139b0b4e69eee31c832f72493dede.camel@linux.ibm.com>
Subject: Re: [PATCH v12 18/35] hw/s390x/ipl: Rework s390_ipl_map_iplb_chain
 for certificate storage
From: Eric Farman <farman@linux.ibm.com>
To: Zhuoying Cai <zycai@linux.ibm.com>, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org
Cc: jrossi@linux.ibm.com, cohuck@redhat.com, berrange@redhat.com,
 richard.henderson@linaro.org, david@kernel.org, walling@linux.ibm.com,
 jjherne@linux.ibm.com, pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 mjrosato@linux.ibm.com, iii@linux.ibm.com, eblake@redhat.com,
 armbru@redhat.com, alifm@linux.ibm.com, brueckner@linux.ibm.com,
 pierrick.bouvier@oss.qualcomm.com, jdaley@linux.ibm.com
Date: Thu, 02 Jul 2026 10:56:31 -0400
In-Reply-To: <20260701204922.1320349-19-zycai@linux.ibm.com>
References: <20260701204922.1320349-1-zycai@linux.ibm.com>
 <20260701204922.1320349-19-zycai@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: y-vSjfE_3iBrDpWYdZffvHXV-18Gxz5L
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAyMDE1NSBTYWx0ZWRfX4DggJOOVtmUP
 MFsB5jkeM5zqm0Ug1m5UspHsInnjjdoDhyFbdGSB3JqLvA87L4UL2TfLcd+MJochgiDq6E7IhiS
 jRH7fqSHNlr0vhtLI4zOt+GfgvQHWLQ=
X-Authority-Analysis: v=2.4 cv=edsNubEH c=1 sm=1 tr=0 ts=6a467c24 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=uCevHG5er4JxBSMMyI8A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAyMDE1NSBTYWx0ZWRfXwDlBhzYkmjm8
 Tsl8IafJqnZDoblpMOjVFctPRn9hGT5RB9AoyGHSRueElEznG/09kcRLPeG6ah1mYFVCLmi83/1
 PKpIos2iZi8Is23jqSdI2w5eUTo+Wk4P0QPhoaVO61kHxXqnG4cfySGD206Z3vPk6Mh6hD9ZOqi
 wrkZ/Evh2Cg6nZPTyN4Z5bisSqYAfViW8RgQmyup7mhIluHG8pcpPm2tqVkngaepJBH1vJt0Ij1
 Okq1J7X/G+lHR6paMg9MjkWoeFigFAkiCkE8irr32gWWkwEm+sOhXIajzanMmyPwhzK72PgGpSm
 cTirF16SQjzLs6O/j1+zYBx3A9unTlmKs0OhO5KIrZQRrRoCxGS9YVkFPfBfND3ClDk8X0V8ppF
 5TSiT63eWDWq68gST/5EqioR4u8XvuTKugKQ2Q913KIb5CQNJK4uNCWCtBReMgVlEZtw67sPWJz
 RtymEJ4H/mwiU+qU9Gw==
X-Proofpoint-ORIG-GUID: y-vSjfE_3iBrDpWYdZffvHXV-18Gxz5L
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-02_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 adultscore=0 impostorscore=0 bulkscore=0
 spamscore=0 suspectscore=0 clxscore=1015 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607020155
Received-SPF: pass client-ip=148.163.156.1; envelope-from=farman@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Wed, 2026-07-01 at 16:49 -0400, Zhuoying Cai wrote:
> Rework s390_ipl_map_iplb_chain to always allocate maximum memory for
> the IPLB chain, regardless of the number of boot devices. This space
> is also used to store certificates during secure boot, providing a
> safe location for certificates until the kernel reads them during boot.
>=20
> Rename next_iplb to ipl_data to better reflect its multiple purposes:
> storing both IPLB chains and certificate data.
>=20
> Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
> ---
>  hw/s390x/ipl.c              | 13 ++++++++++---
>  include/hw/s390x/ipl/qipl.h |  2 +-
>  pc-bios/s390-ccw/iplb.h     |  4 ++--
>  3 files changed, 13 insertions(+), 6 deletions(-)
>=20
> diff --git a/hw/s390x/ipl.c b/hw/s390x/ipl.c
> index 9cb41511e8..7734b6edc7 100644
> --- a/hw/s390x/ipl.c
> +++ b/hw/s390x/ipl.c
> @@ -425,10 +425,9 @@ static S390PCIBusDevice *s390_get_pci_device(DeviceS=
tate *dev_st, int *devtype)
>      return pbdev;
>  }
> =20
> -static uint64_t s390_ipl_map_iplb_chain(IplParameterBlock *iplb_chain)
> +static uint64_t s390_ipl_map_iplb_chain(IplParameterBlock *iplb_chain, u=
int16_t count)
>  {
>      S390IPLState *ipl =3D get_ipl_device();
> -    uint16_t count =3D be16_to_cpu(ipl->qipl.chain_len);
>      uint64_t len =3D sizeof(IplParameterBlock) * count;
>      uint64_t chain_addr =3D find_iplb_chain_addr(ipl->bios_start_addr, c=
ount);
> =20
> @@ -629,8 +628,16 @@ static bool s390_init_all_iplbs(S390IPLState *ipl)
>              dev_st =3D get_boot_device(i);
>              s390_build_iplb(dev_st, &iplb_chain[i - 1]);
>          }
> +    }
> =20
> -        ipl->qipl.next_iplb =3D cpu_to_be64(s390_ipl_map_iplb_chain(iplb=
_chain));
> +    /*
> +     * Allocate maximum space for IPLB chain and/or certificate storage.
> +     * Once a valid boot device is found, this space will be used to sto=
re
> +     * certificates if secure boot is enabled.
> +     */
> +    if (iplb_num > 1 || s390_has_certificate()) {
> +        ipl->qipl.ipl_data =3D cpu_to_be64(s390_ipl_map_iplb_chain(iplb_=
chain,
> +                                                                 MAX_BOO=
T_DEVS - 1));

I think iplb_chain needs to be explicitly initialized to zero now that you'=
re allocating a larger
space. load_next_iplb() is still honoring the length of the count when walk=
ing the IPLBs, but the
above does a memcpy of the whole array.

>      }
> =20
>      return iplb_num;
> diff --git a/include/hw/s390x/ipl/qipl.h b/include/hw/s390x/ipl/qipl.h
> index a2180719b1..2b29dfa8c5 100644
> --- a/include/hw/s390x/ipl/qipl.h
> +++ b/include/hw/s390x/ipl/qipl.h
> @@ -61,7 +61,7 @@ struct QemuIplParameters {
>      uint32_t boot_menu_timeout;
>      uint8_t  reserved3[2];
>      uint16_t chain_len;
> -    uint64_t next_iplb;
> +    uint64_t ipl_data;
>  } QEMU_PACKED;
>  typedef struct QemuIplParameters QemuIplParameters;
> =20
> diff --git a/pc-bios/s390-ccw/iplb.h b/pc-bios/s390-ccw/iplb.h
> index c92a3d0f0c..c807e7f49b 100644
> --- a/pc-bios/s390-ccw/iplb.h
> +++ b/pc-bios/s390-ccw/iplb.h
> @@ -61,11 +61,11 @@ static inline bool load_next_iplb(void)
>      }
> =20
>      qipl.index++;
> -    next_iplb =3D (IplParameterBlock *) qipl.next_iplb;
> +    next_iplb =3D (IplParameterBlock *) qipl.ipl_data;
>      memcpy(iplb, next_iplb, sizeof(IplParameterBlock));
> =20
>      qipl.chain_len--;
> -    qipl.next_iplb =3D qipl.next_iplb + sizeof(IplParameterBlock);
> +    qipl.ipl_data =3D qipl.ipl_data + sizeof(IplParameterBlock);
> =20
>      return true;
>  }

