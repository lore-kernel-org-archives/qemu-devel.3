Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60AB8C43458
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2026 01:03:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wf5pP-0006Uy-WD; Wed, 01 Jul 2026 21:02:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1wf5pN-0006Tm-36; Wed, 01 Jul 2026 21:02:53 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1wf5pL-0000mC-6m; Wed, 01 Jul 2026 21:02:52 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 661LnOQp1971015; Thu, 2 Jul 2026 01:02:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=BQdno1
 W9hX3D+Q2BVjRu6OvTE38+d1OTILA4VeIbjqc=; b=p0EvcozuuGKTSR0qEqHEDo
 JKABQkdmRHQ8+aQqF21/F+fi/MdeJBTNN7fajK1flLDJ+N5VSTv+rqDbpxA7FFRN
 q+VX+x4YCfg7g1Z39DxVt76UrFNHv6qGWBLZz24yjOhgeiMH6CHLajro3rhGggLK
 myR4kbhrI0eXO6jsecflZt2dRfRgU7Sqv7O4bPcLaEdxQm0vbRQ1nt4kueQEkHOG
 p00jN2vnPvwb/cMc/W4Q0As1U7KSg2u3ELJ4cLhPo9iyDU9wswrPEKKRM37BopRT
 KXZY+V2xRsnipNkiF4SMsEJsiQYeiwfQufLZZJ4f80LdntQJBDkfxrUD/oZ+CZ/w
 ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f26qa72am-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 02 Jul 2026 01:02:40 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6620nmN3017504;
 Thu, 2 Jul 2026 01:02:39 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f2u2ghpav-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 02 Jul 2026 01:02:39 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com
 [10.39.53.232])
 by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 66212bLw1114724
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 2 Jul 2026 01:02:37 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 514E95805D;
 Thu,  2 Jul 2026 01:02:37 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 55A6458053;
 Thu,  2 Jul 2026 01:02:35 +0000 (GMT)
Received: from [9.61.65.1] (unknown [9.61.65.1])
 by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Thu,  2 Jul 2026 01:02:35 +0000 (GMT)
Message-ID: <d425523c-2892-4509-ba73-1e3988bb3e3f@linux.ibm.com>
Date: Wed, 1 Jul 2026 21:02:34 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 10/35] hw/s390x: Define finite size for single entry
 VCEntry
To: Zhuoying Cai <zycai@linux.ibm.com>, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org
Cc: jrossi@linux.ibm.com, cohuck@redhat.com, berrange@redhat.com,
 richard.henderson@linaro.org, david@kernel.org, walling@linux.ibm.com,
 jjherne@linux.ibm.com, pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 farman@linux.ibm.com, iii@linux.ibm.com, eblake@redhat.com,
 armbru@redhat.com, alifm@linux.ibm.com, brueckner@linux.ibm.com,
 pierrick.bouvier@oss.qualcomm.com, jdaley@linux.ibm.com
References: <20260701204922.1320349-1-zycai@linux.ibm.com>
 <20260701204922.1320349-11-zycai@linux.ibm.com>
Content-Language: en-US
From: Matthew Rosato <mjrosato@linux.ibm.com>
In-Reply-To: <20260701204922.1320349-11-zycai@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAyMDAwNSBTYWx0ZWRfX6/0otegta8c7
 MH+39oPqBrn91ulkvDAC5K3a/TSdv3Cod9ZKMYY/GzspYPmrf9SPvC0B4duguk9F9y4xWQtRFJw
 mx0JfrsTFEUhsPQBYlfbO2rXuCkOd/rqsLrEd6NmTe/XEN0uWbhdUg5ncNinLKjyqfkYW4KZ1xo
 m5jkc9XvN0TtTZuEL74FvVf9YjiImTH1/p/414Mw+xq8TZmtF0m0ak22P7OH7Fy+WYfXZFxhH+n
 G8sWQl0UxbldCiKrKpoEO7RHMev2K8SPr9WDRyCNcDMGuQvnm3+ZMIiU+TSfapRYWCbb/vYEMzp
 /mAY8B1Xo0DlvDh3fqlxMJbBDAyc1S+M88DXAWSqTpuuFdQST05PgAAee9X68vFJ+VPyjkkhK1v
 CxzUPVzShb+muHBpGIpgobe0v5gXcDV3DmPsEUWrPwFXgaDZeGUnB2gkIhJj99DO4C71MwRNFV3
 LbEWA+y1Bxfv8R+VO0A==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAyMDAwNSBTYWx0ZWRfX4qL7hWfago0U
 YVqJ13v3fw2ir66NdNpuEXS20kIj9V1SgfV0d8ADjACU54fSrV/z/XcOLVat33g3z30jg/iIriy
 ZfkvpapBIXr1f1x3kPgM/uk3Lombmgk=
X-Proofpoint-GUID: 41IFGVLej8XSXp2gbybOkMFaPsJYLCDX
X-Proofpoint-ORIG-GUID: 41IFGVLej8XSXp2gbybOkMFaPsJYLCDX
X-Authority-Analysis: v=2.4 cv=WZ88rUhX c=1 sm=1 tr=0 ts=6a45b8b0 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=Zf7DidIrBeUTxF-Om7YA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-01_05,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 phishscore=0 clxscore=1015 bulkscore=0
 impostorscore=0 priorityscore=1501 lowpriorityscore=0 suspectscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607020005
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=mjrosato@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
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

On 7/1/26 4:48 PM, Zhuoying Cai wrote:
> Define MAX_VCENTRY_SIZE(8KB) and CERT_BUF_MAX_LEN to establish a finite
> size for a single entry VCEntry. Add validation in update_cert_store()
> to ensure certificate data does not exceed this limit.
> 
> This finite size definition is needed for proper memory allocation and
> will be used in a later commit to handle VCEntry structures with known
> size constraints.
> 
> Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
> ---
>  hw/s390x/cert-store.c          | 6 ++++++
>  include/hw/s390x/ipl/diag320.h | 3 +++
>  2 files changed, 9 insertions(+)
> 
> diff --git a/hw/s390x/cert-store.c b/hw/s390x/cert-store.c
> index ab3abf414b..08c38d18df 100644
> --- a/hw/s390x/cert-store.c
> +++ b/hw/s390x/cert-store.c
> @@ -86,6 +86,12 @@ static int update_cert_store(S390IPLCertificateStore *cert_store,
>      cert_buf_size = ROUND_UP(cert->der_size, 4);
>      data_buf_size = keyid_buf_size + hash_buf_size + cert_buf_size;
>  
> +    if (data_buf_size > CERT_BUF_MAX_LEN) {
> +        error_report("Certificate data size %zu exceeds maximum buffer size %ld",
> +                     data_buf_size, CERT_BUF_MAX_LEN);
> +        return -1;
> +    }
> +

Took me a minute to realize why this needed to be its own patch vs
squashed in with hw/s390x/ipl: Create certificate store, because it
seems kind of like a fix? ...

>      if (cert_store->largest_cert_size < data_buf_size) {
>          cert_store->largest_cert_size = data_buf_size;
>      }
> diff --git a/include/hw/s390x/ipl/diag320.h b/include/hw/s390x/ipl/diag320.h
> index 7fda2d44fd..f3c23a3176 100644
> --- a/include/hw/s390x/ipl/diag320.h
> +++ b/include/hw/s390x/ipl/diag320.h
> @@ -92,6 +92,9 @@ struct VCEntry {
>  };
>  typedef struct VCEntry VCEntry;
>  
> +#define MAX_VCENTRY_SIZE      (8 * 1024)
> +#define CERT_BUF_MAX_LEN      (MAX_VCENTRY_SIZE - sizeof(VCEntryHeader))
> +

... it's because of VCEntryHeader.  Would it be possible to instead pull
this code, the VCEntryHeader definition and CERT_NAME_MAX_LEN back
to 'hw/s390x/ipl: Create certificate store' so that we can detect
this condition right from the beginning?

Otherwise, the code itself seems fine so if it can't be squashed then:

Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>


>  struct VCBlockHeader {
>      uint32_t in_len;
>      uint32_t reserved0;


