Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67E94C43602
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2026 03:52:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wf8TR-0001LN-0r; Wed, 01 Jul 2026 23:52:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1wf8TK-0001Ky-Eh; Wed, 01 Jul 2026 23:52:18 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1wf8TI-0002st-Hf; Wed, 01 Jul 2026 23:52:18 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6621M45q2393149; Thu, 2 Jul 2026 03:52:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=UFJEss
 YYi8aO0Xif3Ork5aAIlWuQOo8j30lIUdcbxiM=; b=qYz2S37vFZniaw9/cbw55v
 tDq5y7MDtCyQUTcdrLyH6TQCQKi7mJ6wNSgzekJxIUHqrP7upHS2ju6dllcT9yKN
 NPs5A9Io7bzF4fb/mHamq2yBDRIZ8RZzblKFRfSusxNDZbA6fKxiONcvmSY8Bzj/
 r7bWJMOn3LikaKxrs6tetu4P7mhimlzXkHHphswTFPdYqBQrZuHuwUe1bCCOcP1l
 TdNVxcA0QaUDwihYmp1+VrC3tovPAFYPeouOc9ON6XFAH4DbegsXkY9SLyuHak9t
 x636faBQC+OvvfBtjLJBH6djMm9aJ6x7tICmFRYj+byCJDFKq/7zrlYqsuSMYNNQ
 ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f26rf7esu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 02 Jul 2026 03:52:11 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6623naSP002587;
 Thu, 2 Jul 2026 03:52:06 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f2u2gj5bw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 02 Jul 2026 03:52:06 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com
 [10.241.53.105])
 by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 6623q6AJ16188100
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 2 Jul 2026 03:52:06 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1A35658055;
 Thu,  2 Jul 2026 03:52:06 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CA73858043;
 Thu,  2 Jul 2026 03:52:03 +0000 (GMT)
Received: from li-479af74c-31f9-11b2-a85c-e4ddee11713b.ibm.com (unknown
 [9.61.136.69]) by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Thu,  2 Jul 2026 03:52:03 +0000 (GMT)
Message-ID: <42398960d5694ecbfcdb6ee31df7b55c48ef8018.camel@linux.ibm.com>
Subject: Re: [PATCH v12 07/35] s390x/diag: Implement DIAG 320 subcode 1
From: Eric Farman <farman@linux.ibm.com>
To: Zhuoying Cai <zycai@linux.ibm.com>, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org
Cc: jrossi@linux.ibm.com, cohuck@redhat.com, berrange@redhat.com,
 richard.henderson@linaro.org, david@kernel.org, walling@linux.ibm.com,
 jjherne@linux.ibm.com, pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 mjrosato@linux.ibm.com, iii@linux.ibm.com, eblake@redhat.com,
 armbru@redhat.com, alifm@linux.ibm.com, brueckner@linux.ibm.com,
 pierrick.bouvier@oss.qualcomm.com, jdaley@linux.ibm.com
Date: Wed, 01 Jul 2026 23:52:03 -0400
In-Reply-To: <20260701204922.1320349-8-zycai@linux.ibm.com>
References: <20260701204922.1320349-1-zycai@linux.ibm.com>
 <20260701204922.1320349-8-zycai@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=a4kAM0SF c=1 sm=1 tr=0 ts=6a45e06c cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=QGWI42vgUKyBKJXPML4A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: bbzh9CcZP9-3-iGlssMyJyVmJxmOVVPc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAyMDAzNCBTYWx0ZWRfXzf8ZTgIgaAwU
 CrlLsUqrX58mS0WkXZLIbAmJua3cT+8iutbBhxSfdt1XgIGpIQ50LYqiFFXXi+To173G5nYy7wq
 9hSSLI/yLtln7u1pJTvIaJbDZnHtXbRj3C+BF9zP5WEUO3nFXWSDxcjJBQwLQbuLCs2Zw2lSpif
 5g9lOpJOYr43r0j6hf/AXueGcq7hqBhJwPrPS5QlTJf/eGnbwPb7NCPIZWILPEhLY63GzGqpWOD
 frtFTvSw/QXH4PtS9G7+hs/J0EY6E7pfG8+7P/vok0uVpNYCf3v7WNbQLT6mSkTt8xSZkb2q67l
 GX6eWsA2r+0GRBik62k6OM2OaqB7rrRM2oJoVL3Hv6sGrG3mgJLko3HSpxTcXcCIcnl8wa/5jH3
 9uTAzblm0W34+UBjZvIFfjcF9fptBg1t2H87iYmaDfHMVU5H1nth0erskZaQGR5GH47NxgmHSJZ
 Q8oxt8BKTwyGHIiLVtg==
X-Proofpoint-GUID: bbzh9CcZP9-3-iGlssMyJyVmJxmOVVPc
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAyMDAzNCBTYWx0ZWRfX7YKlTmQTNx8U
 Fqt+uT7igZn3J3GC8KkO2pNtu+XyCq40PEuzSxej9mTo5Ptf43DsnsA63R57MM1oWCOs3DiUAdD
 UMlhtI9vyOI7l41VwPOMOKonjGOeya0=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-02_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 suspectscore=0 lowpriorityscore=0 impostorscore=0
 spamscore=0 priorityscore=1501 adultscore=0 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607020034
Received-SPF: pass client-ip=148.163.158.5; envelope-from=farman@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

On Wed, 2026-07-01 at 16:48 -0400, Zhuoying Cai wrote:
> DIAG 320 subcode 1 provides information needed to determine
> the amount of storage to store one or more certificates from the
> certificate store.
>=20
> Upon successful completion, this subcode returns information of the curre=
nt
> cert store, such as the number of certificates stored and allowed in the =
cert
> store, amount of space may need to be allocate to store a certificate,
> etc for verification-certificate blocks (VCBs).
>=20
> The subcode value is denoted by setting the left-most bit
> of an 8-byte field.
>=20
> The verification-certificate-storage-size block (VCSSB) contains
> the output data when the operation completes successfully. A VCSSB
> length of 4 indicates that no certificate are available in the cert
> store.
>=20
> Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
> Reviewed-by: Farhan Ali <alifm@linux.ibm.com>
> Reviewed-by: Collin Walling <walling@linux.ibm.com>
> ---
>  docs/specs/s390x-secure-ipl.rst | 12 ++++++
>  hw/s390x/cert-store.h           |  3 +-
>  include/hw/s390x/ipl/diag320.h  | 57 +++++++++++++++++++++++++++++
>  target/s390x/diag.c             | 65 ++++++++++++++++++++++++++++++++-
>  4 files changed, 134 insertions(+), 3 deletions(-)

One nit below; but either way...

Reviewed-by: Eric Farman <farman@linux.ibm.com>

>=20
> diff --git a/docs/specs/s390x-secure-ipl.rst b/docs/specs/s390x-secure-ip=
l.rst
> index 331d793008..d5d4c3a24d 100644
> --- a/docs/specs/s390x-secure-ipl.rst
> +++ b/docs/specs/s390x-secure-ipl.rst
> @@ -30,3 +30,15 @@ Subcode 0 - query installed subcodes
>      Returns a 256-bit installed subcodes mask (ISM) stored in the instal=
led
>      subcodes block (ISB). This mask indicates which subcodes are current=
ly
>      installed and available for use.
> +
> +Subcode 1 - query verification certificate storage information
> +    Provides the information required to determine the amount of memory =
needed
> +    to store one or more verification-certificates (VCs) from the certif=
icate
> +    store (CS).
> +
> +    Upon successful completion, this subcode returns various storage siz=
e values
> +    for verification-certificate blocks (VCBs).
> +
> +    The output is returned in the verification-certificate-storage-size =
block
> +    (VCSSB). A VCSSB length of 4 indicates that no certificates are avai=
lable
> +    in the CS.
> diff --git a/hw/s390x/cert-store.h b/hw/s390x/cert-store.h
> index 7fc9503cb9..6f5ee63177 100644
> --- a/hw/s390x/cert-store.h
> +++ b/hw/s390x/cert-store.h
> @@ -11,10 +11,9 @@
>  #define HW_S390_CERT_STORE_H
> =20
>  #include "hw/s390x/ipl/qipl.h"
> +#include "hw/s390x/ipl/diag320.h"
>  #include "crypto/x509-utils.h"
> =20
> -#define CERT_NAME_MAX_LEN  64
> -
>  #define CERT_KEY_ID_LEN    QCRYPTO_HASH_DIGEST_LEN_SHA256
>  #define CERT_HASH_LEN      QCRYPTO_HASH_DIGEST_LEN_SHA256
> =20
> diff --git a/include/hw/s390x/ipl/diag320.h b/include/hw/s390x/ipl/diag32=
0.h
> index aa04b699c6..d37d8eaa86 100644
> --- a/include/hw/s390x/ipl/diag320.h
> +++ b/include/hw/s390x/ipl/diag320.h
> @@ -11,10 +11,67 @@
>  #define S390X_DIAG320_H
> =20
>  #define DIAG_320_SUBC_QUERY_ISM     0
> +#define DIAG_320_SUBC_QUERY_VCSI    1
> =20
>  #define DIAG_320_RC_OK              0x0001
>  #define DIAG_320_RC_NOT_SUPPORTED   0x0102
> +#define DIAG_320_RC_INVAL_VCSSB_LEN 0x0202
> =20
>  #define DIAG_320_ISM_QUERY_SUBCODES 0x80000000
> +#define DIAG_320_ISM_QUERY_VCSI     0x40000000
> +
> +#define VCSSB_NO_VC     4
> +#define VCSSB_LEN_VALID   128
> +
> +#define CERT_NAME_MAX_LEN  64
> +
> +struct VCStorageSizeBlock {
> +    uint32_t length;
> +    uint8_t reserved0[3];
> +    uint8_t version;
> +    uint32_t reserved1[6];
> +    uint16_t total_vc_ct;
> +    uint16_t max_vc_ct;
> +    uint32_t reserved3[11];
> +    uint32_t max_single_vcb_len;
> +    uint32_t total_vcb_len;
> +    uint32_t reserved4[10];
> +};
> +typedef struct VCStorageSizeBlock VCStorageSizeBlock;
> +
> +struct VCEntryHeader {
> +    uint32_t len;
> +    uint8_t flags;
> +    uint8_t key_type;
> +    uint16_t cert_idx;
> +    uint8_t name[CERT_NAME_MAX_LEN];
> +    uint8_t format;
> +    uint8_t reserved0;
> +    uint16_t keyid_len;
> +    uint8_t reserved1;
> +    uint8_t hash_type;
> +    uint16_t hash_len;
> +    uint32_t reserved2;
> +    uint32_t cert_len;
> +    uint32_t reserved3[2];
> +    uint16_t hash_offset;
> +    uint16_t cert_offset;
> +    uint32_t reserved4[7];
> +};
> +typedef struct VCEntryHeader VCEntryHeader;
> +
> +struct VCBlockHeader {
> +    uint32_t in_len;
> +    uint32_t reserved0;
> +    uint16_t first_vc_index;
> +    uint16_t last_vc_index;
> +    uint32_t reserved1[5];
> +    uint32_t out_len;
> +    uint8_t reserved2[4];
> +    uint16_t stored_ct;
> +    uint16_t remain_ct;
> +    uint32_t reserved3[5];
> +};
> +typedef struct VCBlockHeader VCBlockHeader;
> =20
>  #endif
> diff --git a/target/s390x/diag.c b/target/s390x/diag.c
> index 9f98e4b677..2336732c9f 100644
> --- a/target/s390x/diag.c
> +++ b/target/s390x/diag.c
> @@ -205,11 +205,56 @@ out:
>      }
>  }
> =20
> +static int handle_diag320_query_vcsi(S390CPU *cpu, uint64_t addr, uint64=
_t r1,
> +                                     uintptr_t ra, S390IPLCertificateSto=
re *cs)
> +{
> +    g_autofree VCStorageSizeBlock *vcssb =3D NULL;
> +
> +    vcssb =3D g_new0(VCStorageSizeBlock, 1);
> +    if (s390_cpu_virt_mem_read(cpu, addr, r1, vcssb, sizeof(*vcssb))) {
> +        s390_cpu_virt_mem_handle_exc(cpu, ra);
> +        return -1;
> +    }
> +
> +    if (be32_to_cpu(vcssb->length) > sizeof(*vcssb)) {
> +        return DIAG_320_RC_INVAL_VCSSB_LEN;
> +    }
> +
> +    if (be32_to_cpu(vcssb->length) < VCSSB_LEN_VALID) {
> +        return DIAG_320_RC_INVAL_VCSSB_LEN;
> +    }

These two checks could be squashed together, because the QEMU_BUILD_BUG bel=
ow ensures that
sizeof(*vcssb) =3D=3D VCSSB_LEN_VALID, and so vcssb->length should also be =
only that.

> +
> +    if (!cs->count) {
> +        vcssb->length =3D cpu_to_be32(VCSSB_NO_VC);
> +    } else {
> +        vcssb->version =3D 0;
> +        vcssb->total_vc_ct =3D cpu_to_be16(cs->count);
> +        vcssb->max_vc_ct =3D cpu_to_be16(MAX_CERTIFICATES);
> +        vcssb->max_single_vcb_len =3D cpu_to_be32(sizeof(VCBlockHeader) =
+
> +                                                sizeof(VCEntryHeader) +
> +                                                cs->largest_cert_size);
> +        vcssb->total_vcb_len =3D cpu_to_be32(sizeof(VCBlockHeader) +
> +                                           cs->count * sizeof(VCEntryHea=
der) +
> +                                           cs->total_bytes);
> +    }
> +
> +    if (s390_cpu_virt_mem_write(cpu, addr, r1, vcssb, be32_to_cpu(vcssb-=
>length))) {
> +        s390_cpu_virt_mem_handle_exc(cpu, ra);
> +        return -1;
> +    }
> +    return DIAG_320_RC_OK;
> +}
> +
> +QEMU_BUILD_BUG_MSG(sizeof(VCStorageSizeBlock) !=3D VCSSB_LEN_VALID,
> +                   "size of VCStorageSizeBlock is wrong");
> +
>  void handle_diag_320(CPUS390XState *env, uint64_t r1, uint64_t r3, uintp=
tr_t ra)
>  {
>      S390CPU *cpu =3D env_archcpu(env);
> +    S390IPLCertificateStore *cs =3D s390_ipl_get_certificate_store();
>      uint64_t subcode =3D env->regs[r3];
>      uint64_t addr =3D env->regs[r1];
> +    int rc;
> =20
>      if (env->psw.mask & PSW_MASK_PSTATE) {
>          s390_program_interrupt(env, PGM_PRIVILEGED, ra);
> @@ -231,7 +276,8 @@ void handle_diag_320(CPUS390XState *env, uint64_t r1,=
 uint64_t r3, uintptr_t ra)
>           * but the current set of subcodes can fit within a single word
>           * for now.
>           */
> -        uint32_t ism_word0 =3D cpu_to_be32(DIAG_320_ISM_QUERY_SUBCODES);
> +        uint32_t ism_word0 =3D cpu_to_be32(DIAG_320_ISM_QUERY_SUBCODES |
> +                                         DIAG_320_ISM_QUERY_VCSI);
> =20
>          if (s390_cpu_virt_mem_write(cpu, addr, r1, &ism_word0, sizeof(is=
m_word0))) {
>              s390_cpu_virt_mem_handle_exc(cpu, ra);
> @@ -240,6 +286,23 @@ void handle_diag_320(CPUS390XState *env, uint64_t r1=
, uint64_t r3, uintptr_t ra)
> =20
>          env->regs[r1 + 1] =3D DIAG_320_RC_OK;
>          break;
> +    case DIAG_320_SUBC_QUERY_VCSI:
> +        if (addr & 0x7) {
> +            s390_program_interrupt(env, PGM_SPECIFICATION, ra);
> +            return;
> +        }
> +
> +        if (!diag_parm_addr_valid(addr, sizeof(VCStorageSizeBlock), true=
)) {
> +            s390_program_interrupt(env, PGM_ADDRESSING, ra);
> +            return;
> +        }
> +
> +        rc =3D handle_diag320_query_vcsi(cpu, addr, r1, ra, cs);
> +        if (rc =3D=3D -1) {
> +            return;
> +        }
> +        env->regs[r1 + 1] =3D rc;
> +        break;
>      default:
>          env->regs[r1 + 1] =3D DIAG_320_RC_NOT_SUPPORTED;
>          break;

