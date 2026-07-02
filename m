Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28562C43458
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2026 01:59:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wf6hS-0006fI-Q8; Wed, 01 Jul 2026 21:58:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1wf6hP-0006ew-Fo; Wed, 01 Jul 2026 21:58:43 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1wf6hM-0008QY-Oz; Wed, 01 Jul 2026 21:58:43 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6621LIKV2391333; Thu, 2 Jul 2026 01:58:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=at6zz1
 rYPJydWYID6fgTi7mSk4gr/awBs5Gat47tGkg=; b=lZ5k0R3KkGr+XKZILHzYJk
 aFyuQhm75YOVEP6BbrHKpjoLpg92GSbo5FcNQI1aMV7C3QiDAa6vYI/vf1pCicRJ
 0CqCZU5eKAumnBqOFqZCAhIKBYIOqsNV7DwZpXzUpCc2H/VTWPToFhcoZKfIPoi/
 gnRE2jwj73XVdvUqmaXHsb223+eeCFoEzGTkjhvLtdRMxMWUQwhFw/zDozRFh/X1
 8hTkeZ06PsjmGhj8Qg8m0OFbjx51qHlbY4zAMEF4NyocWdZ6D/bkTZlmEmflUkn6
 gxmkBJYsVJ+MRQSczx5dg3d0+rZIiJKbr3cw3BxsqcUw83iX2IFsrq/jELCZBUmA
 ==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f26qa77j0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 02 Jul 2026 01:58:34 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6621nbLg017835;
 Thu, 2 Jul 2026 01:58:33 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f2uhyhqtw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 02 Jul 2026 01:58:32 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com
 [10.241.53.100])
 by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 6621wVdD21627454
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 2 Jul 2026 01:58:31 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2880F58058;
 Thu,  2 Jul 2026 01:58:31 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id EE67758057;
 Thu,  2 Jul 2026 01:58:29 +0000 (GMT)
Received: from [9.61.143.111] (unknown [9.61.143.111])
 by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTPS;
 Thu,  2 Jul 2026 01:58:29 +0000 (GMT)
Message-ID: <7a7daacb-a55e-4590-9d13-73234a088c68@linux.ibm.com>
Date: Wed, 1 Jul 2026 21:58:29 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 21/35] pc-bios/s390-ccw: Rework zipl_load_segment
 function
To: Zhuoying Cai <zycai@linux.ibm.com>, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org
Cc: cohuck@redhat.com, berrange@redhat.com, richard.henderson@linaro.org,
 david@kernel.org, walling@linux.ibm.com, jjherne@linux.ibm.com,
 pasic@linux.ibm.com, borntraeger@linux.ibm.com, farman@linux.ibm.com,
 mjrosato@linux.ibm.com, iii@linux.ibm.com, eblake@redhat.com,
 armbru@redhat.com, alifm@linux.ibm.com, brueckner@linux.ibm.com,
 pierrick.bouvier@oss.qualcomm.com, jdaley@linux.ibm.com
References: <20260701204922.1320349-1-zycai@linux.ibm.com>
 <20260701204922.1320349-22-zycai@linux.ibm.com>
Content-Language: en-US
From: Jared Rossi <jrossi@linux.ibm.com>
In-Reply-To: <20260701204922.1320349-22-zycai@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAyMDAxNiBTYWx0ZWRfX5nQAf2HpJvpm
 lwaUlmgEDZeGPzhuo4E0F1kzbaFvFL2xXCNEukQ1zTKqoQdHvkvr9v+l4WizwJXFdh3n+rHFynR
 Otnf4My9Ihc/KJf4rP/ISl/p/rpX9SMUQtJpX/9mfbxKltFWjAautH9gSvJFkp/XNAbY2vdbuTA
 Ti8tFhvOvKrs2dl1caHRQI2b7Ihy4XMvuBtTdDS7VzO3pfCF5azMEfJ77Vb9QEFysEGXY6mi8q2
 CGVAjHeHIzh1JwPfZNW5onP9lDZ0y0T4Vf9pq81SVWy/xZARtfFLzHg6qI5ZSSqn5lKWPh5KjNz
 PzidRCohhrJkVkAMKNuxzzQhNhyz2zDUqXVU/t28EByWVdpXVX7pLK4MUKXNRrNgbyTzP1XFXvD
 Eh1h4MJgbmrPyAvpP3h0Ox7zVQOPE03aM8blm1QaV/dmkVJbyCIJmeQziTnSjmBvaGFagaw57K4
 tcdVZbTiTww5CNBvn0g==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAyMDAxNiBTYWx0ZWRfX/dqwSFQ5UD1n
 h8WVjxjkQKJ079wQY0Kovpt4CPA/r67U9wIrinjQsmokhyIOS+0L/FJelNZ/jB1a9upARQK7aIZ
 YkLcmtv5fOhfJWcn9XblzRuk0iXqO0Q=
X-Proofpoint-GUID: eBiLBBU-N0F9Ivjj40ZdCeGCn6xtQid6
X-Proofpoint-ORIG-GUID: eBiLBBU-N0F9Ivjj40ZdCeGCn6xtQid6
X-Authority-Analysis: v=2.4 cv=WZ88rUhX c=1 sm=1 tr=0 ts=6a45c5ca cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=20KFwNOVAAAA:8 a=dDsesF0xEnKmZbA7g9YA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-02_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 phishscore=0 clxscore=1015 bulkscore=0
 impostorscore=0 priorityscore=1501 lowpriorityscore=0 suspectscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607020016
Received-SPF: pass client-ip=148.163.158.5; envelope-from=jrossi@linux.ibm.com;
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



On 7/1/26 4:49 PM, Zhuoying Cai wrote:
> Change zipl_load_segment() to accept explicit blockno and address
> parameters instead of ComponentEntry pointer and return segment length.
>
> Modify this function to allow the caller to specify a memory address
> where segment data should be loaded into.
>
> seg_len variable is necessary to store the calculated segment length and
> is used during signature verification. Return the length on success, or
> a negative return code on failure.
>
> Remove static qualifier and add function declaration to bootmap.h to
> make it accessible to other modules.
>
> Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> Reviewed-by: Collin Walling <walling@linux.ibm.com>
> ---
>   pc-bios/s390-ccw/bootmap.c | 18 ++++++++++--------
>   pc-bios/s390-ccw/bootmap.h |  2 ++
>   2 files changed, 12 insertions(+), 8 deletions(-)
>
> diff --git a/pc-bios/s390-ccw/bootmap.c b/pc-bios/s390-ccw/bootmap.c
> index b9ba004cfc..b19981feb1 100644
> --- a/pc-bios/s390-ccw/bootmap.c
> +++ b/pc-bios/s390-ccw/bootmap.c
> @@ -613,19 +613,19 @@ static int ipl_eckd(void)
>    * IPL a SCSI disk
>    */
>   
> -static int zipl_load_segment(ComponentEntry *entry)
> +/*
> + * Returns: length of the segment on success,
> + *          negative value on error.
> + */
> +int zipl_load_segment(block_number_t blockno, uint64_t address)
>   {
>       const int max_entries = (MAX_SECTOR_SIZE / sizeof(ScsiBlockPtr));
>       ScsiBlockPtr *bprs = (void *)sec;
>       const int bprs_size = sizeof(sec);
> -    block_number_t blockno;
> -    uint64_t address;
>       int i;
>       char err_msg[] = "zIPL failed to read BPRS at 0xZZZZZZZZZZZZZZZZ";
>       char *blk_no = &err_msg[30]; /* where to print blockno in (those ZZs) */
> -
> -    blockno = entry->data.blockno;
> -    address = entry->compdat.load_addr;
> +    int seg_len = 0;
>   
>       debug_print_int("loading segment at block", blockno);
>       debug_print_int("addr", address);
> @@ -668,10 +668,12 @@ static int zipl_load_segment(ComponentEntry *entry)
>                   puts("zIPL load segment failed");
>                   return -EIO;
>               }
> +
> +            seg_len += bprs->size * (bprs[i].blockct + 1);
>           }
>       } while (blockno);
>   
> -    return 0;
> +    return seg_len;
>   }
>   
>   static int zipl_run_normal(ComponentEntry **entry_ptr, uint8_t *tmp_sec)
> @@ -687,7 +689,7 @@ static int zipl_run_normal(ComponentEntry **entry_ptr, uint8_t *tmp_sec)
>               continue;
>           }
>   
> -        if (zipl_load_segment(entry)) {
> +        if (zipl_load_segment(entry->data.blockno, entry->compdat.load_addr) < 0) {
>               return -1;
>           }
>   
> diff --git a/pc-bios/s390-ccw/bootmap.h b/pc-bios/s390-ccw/bootmap.h
> index 95943441d3..8d61ac383c 100644
> --- a/pc-bios/s390-ccw/bootmap.h
> +++ b/pc-bios/s390-ccw/bootmap.h
> @@ -113,6 +113,8 @@ typedef struct ScsiMbr {
>       ScsiBlockPtr pt;   /* block pointer to program table */
>   } __attribute__ ((packed)) ScsiMbr;
>   
> +int zipl_load_segment(block_number_t blockno, uint64_t address);
> +
>   #define ZIPL_MAGIC              "zIPL"
>   #define ZIPL_MAGIC_EBCDIC       "\xa9\xc9\xd7\xd3"
>   #define IPL1_MAGIC "\xc9\xd7\xd3\xf1" /* == "IPL1" in EBCDIC */

Reviewed-by: Jared Rossi <jrossi@linux.ibm.com>

