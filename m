Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 562B4C83F17
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Jul 2025 20:17:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ueftx-0005SL-Q7; Wed, 23 Jul 2025 16:17:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1ueftp-0005GS-A2; Wed, 23 Jul 2025 16:17:16 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1ueftn-00037f-LG; Wed, 23 Jul 2025 16:17:13 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56NFoRhA015888;
 Wed, 23 Jul 2025 20:17:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=gTISlY
 5rUTblfjAsYKmTnDhpbvleypnHpP0GIDlb51s=; b=gokCCrDYWsG6aTk4d08WlL
 Yp3e9lGO7AN1cUfvhe95JazVOpv6u8rApUGxV1DzHwXlZTkWBA/OGrzlaAeFFdwj
 CnmKXr8G5rIs/oxmNAfw4Xjsy7ZHMJO0cL/17E36tQVX2z2svSG4GQKVFvEIcvb7
 GgENSIZXlWDkZwmGTjDLneKyY0fsZyTQwNWdFIjX/yzy7vV0/+vf55J+SEqvne8h
 yK/icIdzc0aOLRr8ReapuyP9NKT8q7r87tLY5IeHSYf0OEmLv3VvpW0kcmt5BJQg
 sJfcbN+uT/WFz+G9QqdPthrnvhJMuPgYeq80nBcMmmAO4LKShTGCOQORcCkgBdTA
 ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 482ff66vsf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 23 Jul 2025 20:17:09 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 56NG7WhN025005;
 Wed, 23 Jul 2025 20:17:09 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 480nptsjnf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 23 Jul 2025 20:17:09 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com
 [10.39.53.229])
 by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 56NKH7Lh11403884
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 23 Jul 2025 20:17:08 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B18A358058;
 Wed, 23 Jul 2025 20:17:07 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id EFD6858059;
 Wed, 23 Jul 2025 20:17:05 +0000 (GMT)
Received: from li-479af74c-31f9-11b2-a85c-e4ddee11713b.ibm.com (unknown
 [9.61.117.32]) by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 23 Jul 2025 20:17:05 +0000 (GMT)
Message-ID: <58a1b29e31f13e0fa58d29f222a652b4ccba0f83.camel@linux.ibm.com>
Subject: Re: [PATCH v4 07/28] s390x/diag: Implement DIAG 320 subcode 1
From: Eric Farman <farman@linux.ibm.com>
To: Zhuoying Cai <zycai@linux.ibm.com>, thuth@redhat.com, berrange@redhat.com, 
 richard.henderson@linaro.org, david@redhat.com, pbonzini@redhat.com,
 jrossi@linux.ibm.com, qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: walling@linux.ibm.com, jjherne@linux.ibm.com, pasic@linux.ibm.com,
 borntraeger@linux.ibm.com, mjrosato@linux.ibm.com, iii@linux.ibm.com
Date: Wed, 23 Jul 2025 16:17:05 -0400
In-Reply-To: <20250711211105.439554-8-zycai@linux.ibm.com>
References: <20250711211105.439554-1-zycai@linux.ibm.com>
 <20250711211105.439554-8-zycai@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIzMDE3MSBTYWx0ZWRfX07uiU0ro0jPI
 umisNl7FjLa/xGwjfWWRhrVYyHud3euXjlXTcuG61MZJ7R06du2J7bkFLQdLPAMh2bNUyzXRiUR
 YqXejjAKzBOJWRhDz6HfYWuoOfaWHyZBJQUSa/bRPOurtavO7UQ6e98VwvK43LrYJzGPq4+A02v
 Qz8leHxrt7bP7I8XpXWKxf7/V4MJyIHZHPllx+zmdGByOzJpqDzmVj97SILYGx8/Fn54jzjdOMF
 sAnqmm/rqeeFkiYsZiMse/AxwtjlnUNn3vb4CPZK5eVKBUwpOEErF5ZYD5gHql5aXixnRWqQV3r
 CrcSzi4m8GOc+53nnbevFCKw8f7cf/cWXiwAfLJU7xKvYSne29MVaEYy0hJ0SDtT8wOmDMVNPp+
 bRedgGJtv5TyMWOzI4KxT0AK2muxKPbs8ZVgUuj2INjr4m3Kco3Zrdbf3uULxlhqB0DeMan/
X-Proofpoint-ORIG-GUID: BF1uOxSm2HjalDBTb7P9LWmMsMKzZp5O
X-Proofpoint-GUID: BF1uOxSm2HjalDBTb7P9LWmMsMKzZp5O
X-Authority-Analysis: v=2.4 cv=TtbmhCXh c=1 sm=1 tr=0 ts=68814345 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=VnNF1IyMAAAA:8 a=DmXT93rT6q0WCjUsXQ0A:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-23_03,2025-07-23_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=999 suspectscore=0 impostorscore=0 malwarescore=0
 priorityscore=1501 clxscore=1015 mlxscore=0 lowpriorityscore=0 spamscore=0
 adultscore=0 phishscore=0 bulkscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507230171
Received-SPF: pass client-ip=148.163.158.5; envelope-from=farman@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Fri, 2025-07-11 at 17:10 -0400, Zhuoying Cai wrote:
> DIAG 320 subcode 1 provides information needed to determine
> the amount of storage to store one or more certificates.
>=20
> The subcode value is denoted by setting the left-most bit
> of an 8-byte field.
>=20
> The verification-certificate-storage-size block (VCSSB) contains
> the output data when the operation completes successfully.
>=20
> Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
> ---
>  include/hw/s390x/ipl/diag320.h | 23 ++++++++++++++++++++++
>  target/s390x/diag.c            | 36 +++++++++++++++++++++++++++++++++-
>  2 files changed, 58 insertions(+), 1 deletion(-)
>=20
> diff --git a/include/hw/s390x/ipl/diag320.h b/include/hw/s390x/ipl/diag32=
0.h
> index 713570545d..3916a2915e 100644
> --- a/include/hw/s390x/ipl/diag320.h
> +++ b/include/hw/s390x/ipl/diag320.h
> @@ -11,7 +11,30 @@
>  #define S390X_DIAG320_H
> =20
>  #define DIAG_320_SUBC_QUERY_ISM     0
> +#define DIAG_320_SUBC_QUERY_VCSI    1
> =20
>  #define DIAG_320_RC_OK              0x0001
> =20
> +#define VCSSB_MAX_LEN   128
> +#define VCE_HEADER_LEN  128
> +#define VCB_HEADER_LEN  64
> +
> +#define DIAG_320_ISM_QUERY_VCSI     0x4000000000000000
> +
> +struct VCStorageSizeBlock {
> +    uint32_t length;
> +    uint8_t reserved0[3];
> +    uint8_t version;
> +    uint32_t reserved1[6];
> +    uint16_t total_vc_ct;
> +    uint16_t max_vc_ct;
> +    uint32_t reserved3[7];
> +    uint32_t max_vce_len;
> +    uint32_t reserved4[3];
> +    uint32_t max_single_vcb_len;
> +    uint32_t total_vcb_len;
> +    uint32_t reserved5[10];
> +};
> +typedef struct VCStorageSizeBlock VCStorageSizeBlock;
> +
>  #endif
> diff --git a/target/s390x/diag.c b/target/s390x/diag.c
> index 7b9b47a171..1f7d0cb2f6 100644
> --- a/target/s390x/diag.c
> +++ b/target/s390x/diag.c
> @@ -191,9 +191,13 @@ out:
>      }
>  }
> =20
> +QEMU_BUILD_BUG_MSG(sizeof(VCStorageSizeBlock) !=3D 128,
> +                   "size of VCStorageSizeBlock is wrong");
> +

The message doesn't provide any information that QEMU_BUILD_BUG_ON wouldn't=
 give us, so maybe just
use that.

Also, maybe replace 128 with VCSSB_MAX_LEN?

>  void handle_diag_320(CPUS390XState *env, uint64_t r1, uint64_t r3, uintp=
tr_t ra)
>  {
>      S390CPU *cpu =3D env_archcpu(env);
> +    S390IPLCertificateStore *qcs =3D s390_ipl_get_certificate_store();
>      uint64_t subcode =3D env->regs[r3];
>      uint64_t addr =3D env->regs[r1];
>      int rc;
> @@ -215,13 +219,43 @@ void handle_diag_320(CPUS390XState *env, uint64_t r=
1, uint64_t r3, uintptr_t ra)
> =20
>      switch (subcode) {
>      case DIAG_320_SUBC_QUERY_ISM:
> -        uint64_t ism =3D  0;
> +        uint64_t ism =3D cpu_to_be64(DIAG_320_ISM_QUERY_VCSI);

Oh... Doesn't this suggest that there should have been a bit here stating t=
hat Query ISM itself is
supported? (I agree it's a catch-22, but...)

> =20
>          if (s390_cpu_virt_mem_write(cpu, addr, r1, &ism, sizeof(ism))) {
>              s390_cpu_virt_mem_handle_exc(cpu, ra);
>              return;
>          }
> =20
> +        rc =3D DIAG_320_RC_OK;
> +        break;
> +    case DIAG_320_SUBC_QUERY_VCSI:
> +        VCStorageSizeBlock vcssb;
> +

Verify that addr is doubleword aligned?

> +        if (!diag_parm_addr_valid(addr, sizeof(VCStorageSizeBlock),
> +                                  true)) {
> +            s390_program_interrupt(env, PGM_ADDRESSING, ra);
> +            return;
> +        }
> +
> +        if (!qcs || !qcs->count) {

For my own curiosity, can qcs actually be NULL? Looks like s390_ipl_get_cer=
tificate_store() returns
the address of the cert_store struct in the IPL device.

> +            vcssb.length =3D cpu_to_be32(4);
> +        } else {
> +            vcssb.length =3D cpu_to_be32(VCSSB_MAX_LEN);
> +            vcssb.version =3D 0;
> +            vcssb.total_vc_ct =3D cpu_to_be16(qcs->count);
> +            vcssb.max_vc_ct =3D cpu_to_be16(MAX_CERTIFICATES);
> +            vcssb.max_vce_len =3D cpu_to_be32(VCE_HEADER_LEN + qcs->max_=
cert_size);
> +            vcssb.max_single_vcb_len =3D cpu_to_be32(VCB_HEADER_LEN + VC=
E_HEADER_LEN +
> +                                                   qcs->max_cert_size);
> +            vcssb.total_vcb_len =3D cpu_to_be32(VCB_HEADER_LEN +
> +                                              qcs->count * VCE_HEADER_LE=
N +
> +                                              qcs->total_bytes);
> +        }
> +
> +        if (s390_cpu_virt_mem_write(cpu, addr, r1, &vcssb, sizeof(VCStor=
ageSizeBlock))) {
> +            s390_cpu_virt_mem_handle_exc(cpu, ra);
> +            return;
> +        }
>          rc =3D DIAG_320_RC_OK;
>          break;
>      default:

