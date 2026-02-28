Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05B651048925
	for <qemu-devel@archiver.kernel.org>; Sat, 28 Feb 2026 02:26:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vwA1e-0003Bp-2M; Fri, 27 Feb 2026 21:25:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1vwA1b-0003Av-RK; Fri, 27 Feb 2026 21:25:47 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1vwA1a-0007cN-4I; Fri, 27 Feb 2026 21:25:47 -0500
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 61S1Vx9S1294942; Sat, 28 Feb 2026 02:25:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=bgI8PW
 6GH9cFvuBTHTTsdMEJATSBOxqs/QqM37erZLg=; b=VYNNoAf6McvDa8o+d1hLC+
 kVNBnqzaa2FJxg1rUH8QjQDpkozjMHMUDoI8aV4enC6JPO9amC+wL/2fzlQJ0XVS
 K6ln99AbvXLWUzGHxaV3NVxdiZotz/i9nSGQtrweLcDxGa61G59uVVdUX168ziy+
 2S93J/D3MUg7D4Zn+xPxeQOnI/0O6ocR7zMsK7BSV1ovvzrk3m8XI5MoaRMEbOfS
 DrYuSKd++Ja2I3BGjseCI0nXS0cuPLtPo/GzMMhnqqViKOclg2Zoo8vZKTqRbdsW
 eARE19IWLy9avaRALnB+RvFs1gLWLf8r8aS63d1wkMoKWqP/dNXdLkkejS0QUhNA
 ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ckpseg2nr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 28 Feb 2026 02:25:41 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 61S0WxZO003382;
 Sat, 28 Feb 2026 02:25:40 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4cfs8kcttw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 28 Feb 2026 02:25:40 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com
 [10.39.53.228])
 by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 61S2PdOe25625208
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sat, 28 Feb 2026 02:25:39 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E5AFA5804B;
 Sat, 28 Feb 2026 02:25:38 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5AE0358059;
 Sat, 28 Feb 2026 02:25:37 +0000 (GMT)
Received: from [9.61.45.42] (unknown [9.61.45.42])
 by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Sat, 28 Feb 2026 02:25:37 +0000 (GMT)
Message-ID: <815ee895-2d73-4ac3-8a53-5903f066f00b@linux.ibm.com>
Date: Fri, 27 Feb 2026 21:25:36 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Zhuoying Cai <zycai@linux.ibm.com>
Subject: Re: [PATCH v8 09/30] s390x/diag: Implement DIAG 320 subcode 2
To: thuth@redhat.com, berrange@redhat.com, richard.henderson@linaro.org,
 jrossi@linux.ibm.com, qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: david@kernel.org, walling@linux.ibm.com, jjherne@linux.ibm.com,
 pasic@linux.ibm.com, borntraeger@linux.ibm.com, farman@linux.ibm.com,
 mjrosato@linux.ibm.com, iii@linux.ibm.com, eblake@redhat.com,
 armbru@redhat.com, alifm@linux.ibm.com, brueckner@linux.ibm.com
References: <20260212204352.1044699-1-zycai@linux.ibm.com>
 <20260212204352.1044699-10-zycai@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <20260212204352.1044699-10-zycai@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: g4ZQu_Q9OChMJp_SHn88z2Y34lkAfDhY
X-Proofpoint-GUID: g4ZQu_Q9OChMJp_SHn88z2Y34lkAfDhY
X-Authority-Analysis: v=2.4 cv=VIzQXtPX c=1 sm=1 tr=0 ts=69a25225 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=VnNF1IyMAAAA:8
 a=Y-p8QTvz0Ndpyi03dzAA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI4MDAxOCBTYWx0ZWRfX46JUa/kMv6+I
 5AMxYrG3wbzfH6RFh3kaOZL3CWw5hAxPNoBp5MqWbZ8qFqBSkLRSmDy+l53R6CaEakzoVTTR6BI
 qlaycgVxcFr4x7/vPv9zFrPRxcO+he3gfHUhInTgWZ2CCIJ1a+4MlNaiUpOjKnVmroQbVh8M1Nn
 V2rsZqEzSGEFxuLR7CdIXjtUkY84XroJsMwXCSoAXabxCrUITrxdddPE44TjKyrL+tU1owI8kms
 vSPJYSj7B02jkS4Z9o7GR7iYU3PeEmlQ6peRZ/52gbIaCIbQrzhHIBUZD9JBNXaraI/BWzGSvlY
 Dsm0VmmiR9ZsxtWra0I6OLoS9cNMDw3wtj37T/tz35QEgpyy7fu0mB7HNNroKV37ISLNUQo3cnJ
 l0UKtNky1of1jKzSEmbN8ACM62D4ZKGPNBsp1IKJYIQDfcCT93rn5/SIOD6FcYPDDcK62Bi7k0+
 7xWFjWe9uAH2O7j+G6g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-27_04,2026-02-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 malwarescore=0 priorityscore=1501 bulkscore=0
 suspectscore=0 lowpriorityscore=0 phishscore=0 clxscore=1015 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602280018
Received-SPF: pass client-ip=148.163.158.5; envelope-from=zycai@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.706, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.401,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 2/12/26 3:43 PM, Zhuoying Cai wrote:
> DIAG 320 subcode 2 provides verification-certificates (VCs) that are in the
> certificate store. Only X509 certificates in DER format and SHA-256 hash
> type are recognized.
> 
> The subcode value is denoted by setting the second-left-most bit
> of an 8-byte field.
> 
> The Verification Certificate Block (VCB) contains the output data
> when the operation completes successfully. It includes a common
> header followed by zero or more Verification Certificate Entries (VCEs),
> depending on the VCB input length and the VC range (from the first VC
> index to the last VC index) in the certificate store.
> 
> Each VCE contains information about a certificate retrieved from
> the S390IPLCertificateStore, such as the certificate name, key type,
> key ID length, hash length, and the raw certificate data.
> The key ID and hash are extracted from the raw certificate by the crypto API.
> 
> Note: SHA2-256 VC hash type is required for retrieving the hash
> (fingerprint) of the certificate.
> 
> Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
> ---
>  docs/specs/s390x-secure-ipl.rst |  22 +++
>  hw/s390x/cert-store.h           |   3 +-
>  include/hw/s390x/ipl/diag320.h  |  50 +++++
>  target/s390x/diag.c             | 328 +++++++++++++++++++++++++++++++-
>  4 files changed, 400 insertions(+), 3 deletions(-)
> 
> diff --git a/docs/specs/s390x-secure-ipl.rst b/docs/specs/s390x-secure-ipl.rst
> index d3ece8a82d..22da589162 100644
> --- a/docs/specs/s390x-secure-ipl.rst
> +++ b/docs/specs/s390x-secure-ipl.rst
> @@ -38,3 +38,25 @@ Subcode 1 - query verification certificate storage information
>      The output is returned in the verification-certificate-storage-size block
>      (VCSSB). A VCSSB length of 4 indicates that no certificates are available
>      in the CS.
> +
> +Subcode 2 - store verification certificates
> +    Provides VCs that are in the certificate store.
> +
> +    The output is provided in a VCB, which includes a common header followed by
> +    zero or more verification-certificate entries (VCEs).
> +
> +    The instruction expects the cert store to
> +    maintain an origin of 1 for the index (i.e. a retrieval of the first
> +    certificate in the store should be denoted by setting first-VC to 1).
> +
> +    The first-VC index and last-VC index fields of VCB specify the range of VCs
> +    to be stored by subcode 2. Stored count and remained count fields specify
> +    the number of VCs stored and could not be stored in the VCB due to
> +    insufficient storage specified in the VCB input length field.
> +
> +    Each VCE contains a header followed by information extracted from a
> +    certificate within the certificate store. The information includes:
> +    key-id, hash, and certificate data. This information is stored
> +    contiguously in a VCE (with zero-padding). Following the header, the
> +    key-id is immediately stored. The hash and certificate data follow and
> +    may be accessed via the respective offset fields stored in the VCE.

[...]

>  QEMU_BUILD_BUG_MSG(sizeof(VCStorageSizeBlock) != VCSSB_MIN_LEN,
>                     "size of VCStorageSizeBlock is wrong");
> +QEMU_BUILD_BUG_MSG(sizeof(VCBlock) != VCB_HEADER_LEN, "size of VCBlock is wrong");
> +QEMU_BUILD_BUG_MSG(sizeof(VCEntry) != VCE_HEADER_LEN, "size of VCEntry is wrong");
>  
>  void handle_diag_320(CPUS390XState *env, uint64_t r1, uint64_t r3, uintptr_t ra)
>  {
> @@ -267,7 +585,8 @@ void handle_diag_320(CPUS390XState *env, uint64_t r1, uint64_t r3, uintptr_t ra)
>           * for now.
>           */
>          uint32_t ism_word0 = cpu_to_be32(DIAG_320_ISM_QUERY_SUBCODES |
> -                                         DIAG_320_ISM_QUERY_VCSI);
> +                                         DIAG_320_ISM_QUERY_VCSI |
> +                                         DIAG_320_ISM_STORE_VC);
>  
>          if (s390_cpu_virt_mem_write(cpu, addr, r1, &ism_word0, sizeof(ism_word0))) {
>              s390_cpu_virt_mem_handle_exc(cpu, ra);
> @@ -293,6 +612,13 @@ void handle_diag_320(CPUS390XState *env, uint64_t r1, uint64_t r3, uintptr_t ra)
>          }
>          env->regs[r1 + 1] = rc;
>          break;

Subcode 2 should raise a specification exception if the address in
register r1 is not on a 4K‑byte boundary. I will handle this with the
appropriate changes in the next version.

> +    case DIAG_320_SUBC_STORE_VC:
> +        rc = handle_diag320_store_vc(cpu, addr, r1, ra, cs);
> +        if (rc == -1) {
> +            return;
> +        }
> +        env->regs[r1 + 1] = rc;
> +        break;
>      default:
>          env->regs[r1 + 1] = DIAG_320_RC_NOT_SUPPORTED;
>          break;


