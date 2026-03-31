Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F2A6109B491
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2026 15:38:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7b9S-0007nq-6U; Tue, 31 Mar 2026 11:37:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <walling@linux.ibm.com>)
 id 1w7b9A-0007Q7-Ke; Tue, 31 Mar 2026 11:36:58 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <walling@linux.ibm.com>)
 id 1w7b93-0006xu-BG; Tue, 31 Mar 2026 11:36:48 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62V74Jei039609; Tue, 31 Mar 2026 15:36:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=P6mBoY
 3j9BWMc5mXQQXoFLlZGvvdZlGGqXatd3sWWEg=; b=npntv2JYB62i+L/HwR7wCL
 XmdVu6wLFKcbtcSrL8q05vZPHTI0dQdAf3VK1MffBnsbVsC1dZDVeII7y9/PgYbw
 kRZXW37S+EPqUDgWoyBSefQPswTXEdIEO/4KYnvCtGDG7BoyJIFnp093HSv/t13l
 qqxPdSCOaSz/RoBPaM/TmvO4beWYwsWMJsZ5UgW64Bdai8KjzYRAWerYJ/BWSox1
 sCw1Qz4FwnyQhPFKKXVr1E14DzouI7EREu8+LRuRZHKzQH0evW1bmKVojLC3zNFI
 qBTPT0YQ7AJZ/Ox7WJBmOMGiFwjqP1FeMh1LE1rcDlmGw1NrjOJAjuYBcGmvWSHg
 ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d64dgkrsa-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 31 Mar 2026 15:36:39 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62VCU5MX030990;
 Tue, 31 Mar 2026 15:36:39 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4d6uhjsjf3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 31 Mar 2026 15:36:39 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com
 [10.39.53.231])
 by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 62VFaDj728049972
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 31 Mar 2026 15:36:13 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4A5AC58050;
 Tue, 31 Mar 2026 15:36:37 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 78C6D58045;
 Tue, 31 Mar 2026 15:36:35 +0000 (GMT)
Received: from [9.12.68.85] (unknown [9.12.68.85])
 by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTPS;
 Tue, 31 Mar 2026 15:36:35 +0000 (GMT)
Message-ID: <07cdfe36-dab9-481b-971d-f3febcf56b21@linux.ibm.com>
Date: Tue, 31 Mar 2026 11:36:35 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 13/30] s390x/ipl: Introduce IPL Information Report
 Block (IIRB)
To: Zhuoying Cai <zycai@linux.ibm.com>, thuth@redhat.com, berrange@redhat.com, 
 jrossi@linux.ibm.com, qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, pierrick.bouvier@linaro.org,
 david@kernel.org, jjherne@linux.ibm.com, pasic@linux.ibm.com,
 borntraeger@linux.ibm.com, farman@linux.ibm.com,
 mjrosato@linux.ibm.com, iii@linux.ibm.com, eblake@redhat.com,
 armbru@redhat.com, alifm@linux.ibm.com, brueckner@linux.ibm.com,
 jdaley@linux.ibm.com
References: <20260305224146.664053-1-zycai@linux.ibm.com>
 <20260305224146.664053-14-zycai@linux.ibm.com>
Content-Language: en-US
From: Collin Walling <walling@linux.ibm.com>
In-Reply-To: <20260305224146.664053-14-zycai@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzMxMDE0OCBTYWx0ZWRfX9l0qcer/zykL
 i3a0E52IABp+qgssVhBWEnXZS/DFY6tF1yuiQdnYF/320/m4nJzUbnxSowt39tCyS6DyKUyP6vs
 UvHEoTaqO+h8L7vLm3CIPq2SFLk5l01lHh1MES0GKTjvkF4Tl7oBvpMo/oSwE1nkoYqUpkQEToi
 aanBITpY3o7zyEkrsLvsWARAbWv2pL3q/57gjsES4Gxe7isxaegxDB6FOBJNcrUUE6U844tA7an
 4Q+/RCi0RhJIGFb9mcG6aUKWUVtdlTjuxTufyU5X+g2OP/k70D2q/bmGZw1uJzfG++nlomIkfVW
 iYfY0SXjWu+4Ow3ZFSPXclYXzfVL7Dx7Z2tSiguR2G6MK++EX8y4ECWMsVLJH5TPfqVBOV+8zZ5
 9wcWS7RRDQMDlrB00y/su+4q4QyqsPSwdOP9AgfshZ/4slndshYxF3BskisMGOlFieQ/K3I2rZe
 hqREloT53PQY5TG9fJg==
X-Authority-Analysis: v=2.4 cv=QKZlhwLL c=1 sm=1 tr=0 ts=69cbea07 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=RewWC_GU4WWWpF838n8A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: xHyxbbTo4vH98-kQ17oKcD-VkIUGoqtM
X-Proofpoint-ORIG-GUID: xHyxbbTo4vH98-kQ17oKcD-VkIUGoqtM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-31_03,2026-03-31_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 phishscore=0 adultscore=0 impostorscore=0 clxscore=1015
 spamscore=0 bulkscore=0 priorityscore=1501 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603310148
Received-SPF: pass client-ip=148.163.158.5; envelope-from=walling@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -6
X-Spam_score: -0.7
X-Spam_bar: /
X-Spam_report: (-0.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1, RCVD_IN_VALIDITY_RPBL_BLOCKED=1,
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

On 3/5/26 17:41, Zhuoying Cai wrote:
> The IPL information report block (IIRB) contains information used
> to locate IPL records and to report the results of signature verification
> of one or more secure components of the load device.
> 
> IIRB is stored immediately following the IPL Parameter Block. Results on
> component verification in any case (failure or success) are stored.
> 
> Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
> Reviewed-by: Farhan Ali<alifm@linux.ibm.com>
> ---
>  docs/specs/s390x-secure-ipl.rst | 14 ++++++++
>  include/hw/s390x/ipl/qipl.h     | 59 +++++++++++++++++++++++++++++++++
>  2 files changed, 73 insertions(+)
> 
> diff --git a/docs/specs/s390x-secure-ipl.rst b/docs/specs/s390x-secure-ipl.rst
> index 32add09dc1..fc37de52b9 100644
> --- a/docs/specs/s390x-secure-ipl.rst
> +++ b/docs/specs/s390x-secure-ipl.rst
> @@ -95,3 +95,17 @@ Subcode 1 - perform signature verification
>      * ``0x0302``: PKCS#7 format signature is invalid
>      * ``0x0402``: signature-verification failed
>      * ``0x0502``: length of Diag508SigVerifBlock is invalid
> +
> +IPL Information Report Block
> +----------------------------
> +
> +The IPL Parameter Block (IPLPB), utilized for IPL operation, is extended with an
> +IPL Information Report Block (IIRB), which contains the results from secure IPL
> +operations such as:
> +
> +* component data
> +* verification results
> +* certificate data
> +
> +The guest's kernel inspects the IIRB and uses the certificate data it contains
> +to build the keyring.

With what we've learned in patch 19, remove the sentence above and add
the blurb below.

"""

During early boot, the guest kernel reserves the memory region
containing the IIRB. This preserves the data while the guest kernel is
operating and during re-IPL.

The guest kernel uses the contents in the IIRB for:

* Boot logging: reports which components were loaded and verified.
* kexec operations: builds the next kernel’s IPL report from the
existing one.
* Keying: installs IPL certificates into the platform trusted keyring.

"""

Additionally, add a short message to the commit message that briefly
explains that this data gets reserved by the guest kernel and will not
be overwritten... or something to that effect.

[...]

-- 
Regards,
  Collin

