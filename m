Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59765CA0EFF
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Aug 2025 21:50:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urO1L-0000zX-4H; Wed, 27 Aug 2025 17:49:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alifm@linux.ibm.com>)
 id 1urO1H-0000y3-HT; Wed, 27 Aug 2025 17:49:27 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alifm@linux.ibm.com>)
 id 1urO1E-0005hD-SP; Wed, 27 Aug 2025 17:49:27 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57RC0ThS008379;
 Wed, 27 Aug 2025 21:49:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=GDhAeu
 it4ePtbM+JUXvZIG23xLuH30s5tY0VPIK+/aY=; b=PN6Po1SatedgY6ypnfS12H
 O8RdYs70c6UlzYi6mN63+VdXo9FPar0J01TAr2Dp3PZ6RjFqImgcK1M5wkg/3jAa
 mNLt9TyqsOZrUY7s7g0V2a5mxJYTMHUF76vcfquc5X/gbwgIzuMt7dKCMqkLUJfv
 DbKagmKXTjXaoWsjk5nGuhoKqpNvLhK93yv091zNrT52o1BSdUx4i9388MbKwmC0
 9Dugp6HiSBGTV01Uy8rypEdj778rmveLBLioFhi1D5WzUjjoZuweO2w+YLBA2WBY
 bmEv0rLgtABv+cXDLCbYbhXKnEc9JKgfaIpnr7y4UvT1DEUsOSo2Ur9DCsnu3bCA
 ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48q42j6ck9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 27 Aug 2025 21:49:20 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 57RIQvtC007474;
 Wed, 27 Aug 2025 21:49:19 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 48qqyuj6c9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 27 Aug 2025 21:49:19 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com
 [10.241.53.101])
 by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 57RLnIXn4981764
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 27 Aug 2025 21:49:18 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7C95B5805A;
 Wed, 27 Aug 2025 21:49:18 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 54D9E58051;
 Wed, 27 Aug 2025 21:49:17 +0000 (GMT)
Received: from [9.61.245.55] (unknown [9.61.245.55])
 by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 27 Aug 2025 21:49:17 +0000 (GMT)
Message-ID: <537aa1cf-7135-471e-874e-a4cd3796b5bc@linux.ibm.com>
Date: Wed, 27 Aug 2025 14:49:17 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 07/29] s390x/diag: Implement DIAG 320 subcode 1
To: Zhuoying Cai <zycai@linux.ibm.com>, thuth@redhat.com, berrange@redhat.com, 
 richard.henderson@linaro.org, david@redhat.com, jrossi@linux.ibm.com,
 qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: walling@linux.ibm.com, jjherne@linux.ibm.com, pasic@linux.ibm.com,
 borntraeger@linux.ibm.com, farman@linux.ibm.com,
 mjrosato@linux.ibm.com, iii@linux.ibm.com, eblake@redhat.com,
 armbru@redhat.com
References: <20250818214323.529501-1-zycai@linux.ibm.com>
 <20250818214323.529501-8-zycai@linux.ibm.com>
Content-Language: en-US
From: Farhan Ali <alifm@linux.ibm.com>
In-Reply-To: <20250818214323.529501-8-zycai@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDAxMCBTYWx0ZWRfX1kpojvK5wLkx
 h+6YKG2ljjR/DUYgE8AZ1hTcLBsdX0ICTaEYqZGTY/0GszZ1guD8dsh1yJqc6MB2I6MesSoxdo+
 AP01ZPafU/mncDCDnIvxfn99s0saESXEprnr8q3PKJ2sQvxTvzFj0Het44fhKSq7hVlr8yNR6cm
 cChcMk0EMb4GYS8vv2dsCmDxhATLJmpiqS+u52rUm5PoamlMcfwt0uxVUoj/N815BvhulwmA6c5
 xFeoo6gafc8iMnu81IkdNLJvDW6Z6N8ZGcx4uhHYo5MXBQjgkCvZ2oWWPMyMt19dIDOTLNjWCf5
 oLvvpzs6FtEyna3QQc7k3V2pzPSYeiEXl/IlFjsPjzmWRfvNMiS2iqosoD4vwp2QHeUw3heVeSV
 I/GFVYqg
X-Proofpoint-ORIG-GUID: Og2roixrnSj2HR68BXm_MrLjGYjUBVqB
X-Proofpoint-GUID: Og2roixrnSj2HR68BXm_MrLjGYjUBVqB
X-Authority-Analysis: v=2.4 cv=evffzppX c=1 sm=1 tr=0 ts=68af7d60 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=P-IC7800AAAA:8 a=VnNF1IyMAAAA:8
 a=FAZsi83HLsRZ-jeIq-0A:9 a=QEXdDO2ut3YA:10 a=d3PnA9EDa4IxuAV0gXij:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-27_04,2025-08-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 malwarescore=0 spamscore=0 bulkscore=0
 impostorscore=0 clxscore=1011 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508230010
Received-SPF: pass client-ip=148.163.158.5; envelope-from=alifm@linux.ibm.com;
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


On 8/18/2025 2:43 PM, Zhuoying Cai wrote:
> DIAG 320 subcode 1 provides information needed to determine
> the amount of storage to store one or more certificates from the
> certificate store.
>
> Upon successful completion, this subcode returns information of the current
> cert store, such as the number of certificates stored and allowed in the cert
> store, amount of space may need to be allocate to store a certificate,
> etc for verification-certificate blocks (VCBs).
>
> The subcode value is denoted by setting the left-most bit
> of an 8-byte field.
>
> The verification-certificate-storage-size block (VCSSB) contains
> the output data when the operation completes successfully. A VCSSB
> length of 4 indicates that no certificate are available in the cert
> store.
>
> Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
> ---
>   docs/specs/s390x-secure-ipl.rst | 10 ++++++
>   include/hw/s390x/ipl/diag320.h  | 22 +++++++++++++
>   target/s390x/diag.c             | 56 ++++++++++++++++++++++++++++++++-
>   3 files changed, 87 insertions(+), 1 deletion(-)
>
> diff --git a/docs/specs/s390x-secure-ipl.rst b/docs/specs/s390x-secure-ipl.rst
> index 70e9a66fe0..ddc15f0322 100644
> --- a/docs/specs/s390x-secure-ipl.rst
> +++ b/docs/specs/s390x-secure-ipl.rst
> @@ -23,3 +23,13 @@ Subcode 0 - query installed subcodes
>       Returns a 256-bit installed subcodes mask (ISM) stored in the installed
>       subcodes block (ISB). This mask indicates which sucodes are currently
>       installed and available for use.
> +
> +Subcode 1 - query verification certificate storage information
> +    Provides the information required to determine the amount of memory needed to
> +    store one or more verification-certificates (VCs) from the certificate store (CS).
> +
> +    Upon successful completion, this subcode returns various storage size values for
> +    verification-certificate blocks (VCBs).
> +
> +    The output is returned in the verification-certificate-storage-size block (VCSSB).
> +    A VCSSB length of 4 indicates that no certificates are available in the CS.
> diff --git a/include/hw/s390x/ipl/diag320.h b/include/hw/s390x/ipl/diag320.h
> index aa04b699c6..6e4779c699 100644
> --- a/include/hw/s390x/ipl/diag320.h
> +++ b/include/hw/s390x/ipl/diag320.h
> @@ -11,10 +11,32 @@
>   #define S390X_DIAG320_H
>   
>   #define DIAG_320_SUBC_QUERY_ISM     0
> +#define DIAG_320_SUBC_QUERY_VCSI    1
>   
>   #define DIAG_320_RC_OK              0x0001
>   #define DIAG_320_RC_NOT_SUPPORTED   0x0102
> +#define DIAG_320_RC_INVAL_VCSSB_LEN 0x0202
>   
>   #define DIAG_320_ISM_QUERY_SUBCODES 0x80000000
> +#define DIAG_320_ISM_QUERY_VCSI     0x40000000
> +
> +#define VCSSB_NO_VC     4
> +#define VCSSB_MIN_LEN   128
> +#define VCE_HEADER_LEN  128
> +#define VCB_HEADER_LEN  64
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
>   
Should this be a packed structure? The Linux kernel defines it as packed 
https://elixir.bootlin.com/linux/v6.17-rc3/source/arch/s390/kernel/cert_store.c#L81

Thanks
Farhan


