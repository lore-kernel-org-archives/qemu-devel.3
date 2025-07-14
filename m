Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5B9FC83F17
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Jul 2025 22:25:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubRal-0002K1-1n; Mon, 14 Jul 2025 18:24:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <walling@linux.ibm.com>)
 id 1ubQBD-0006zQ-82; Mon, 14 Jul 2025 16:53:43 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <walling@linux.ibm.com>)
 id 1ubQBA-0002ls-Ss; Mon, 14 Jul 2025 16:53:42 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56EH8XS2002668;
 Mon, 14 Jul 2025 20:53:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=jSXttz
 ueQ5TBh1oRu2NkdrCq1iuYDb2+0sVdj/A3oyQ=; b=WV9GZrASM3mdQdUJBqJKhw
 L9bdX4YpGfOdc+/DcKzBhU6jhyCvbGZlm9RQbwdJFubyr1RtYOzJuzFS3tLrcRMq
 h2D+aOGGUxgINolURcWNdtVdvaS4YptvktbmO7BEF0LZdZcvIjPjXlQyo4mz3OTJ
 EYfKa6EXEiXBC2X1sHqPVT34i6vUXQU1Ax7J2Bel4DKvZa7rcFipPhrfXCPhSddn
 JbbzzcCnT31+6p0uLL8HBYtCtiNkWhRQia7Yxb33vRU2HFrrli06kooEPwwTzw41
 qYilewSaNiQKY/CnObOx9QHTPos+HIe30x85UbgCX1xNmsKo9++Z2ab6pc9octqA
 ==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47ue4tumnm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 14 Jul 2025 20:53:37 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 56EJvHNO021972;
 Mon, 14 Jul 2025 20:53:36 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 47v4r2y6ap-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 14 Jul 2025 20:53:36 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com
 [10.39.53.232])
 by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 56EKrZin19530494
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 14 Jul 2025 20:53:35 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1653F58053;
 Mon, 14 Jul 2025 20:53:35 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D714B58043;
 Mon, 14 Jul 2025 20:53:33 +0000 (GMT)
Received: from [9.12.68.85] (unknown [9.12.68.85])
 by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTPS;
 Mon, 14 Jul 2025 20:53:33 +0000 (GMT)
Message-ID: <22f0688b-c33e-4716-baed-fa9e1ef6c30d@linux.ibm.com>
Date: Mon, 14 Jul 2025 16:53:33 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 18/28] pc-bios/s390-ccw: Refactor zipl_run()
To: Zhuoying Cai <zycai@linux.ibm.com>, thuth@redhat.com, berrange@redhat.com, 
 richard.henderson@linaro.org, david@redhat.com, pbonzini@redhat.com,
 jrossi@linux.ibm.com, qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: jjherne@linux.ibm.com, pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 farman@linux.ibm.com, mjrosato@linux.ibm.com, iii@linux.ibm.com
References: <20250711211105.439554-1-zycai@linux.ibm.com>
 <20250711211105.439554-19-zycai@linux.ibm.com>
Content-Language: en-US
From: Collin Walling <walling@linux.ibm.com>
In-Reply-To: <20250711211105.439554-19-zycai@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=baBrUPPB c=1 sm=1 tr=0 ts=68756e51 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=VnNF1IyMAAAA:8 a=K7vxbn2xGZbTZNcvMCgA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: DVm18RIZjJaQykYVp7Nws6M-uznMkerF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE0MDEzOSBTYWx0ZWRfX0Ym6FgBI07bJ
 NbDBobGJwJ5lq8vY2WB7D9kH2pOC2wv+9RSP5CXFD+OPPCctCYxOerEWPam9be0Uhrgguo/NOgI
 PXVmQ+i59VTXYeOjgh/mtzj+YWEV1e5Z86tcjDfVU8UMawFMoOOVBi3NdLPR8ILmBlK+LpLpXwo
 pV00AVyAyRcpIBD9BmcI8ZOCdbhfaUYQgvVawXW+ytElJraOscNIGhDqF0ieEniNQLTasEd7AEj
 +5wObTBZ5r4Y3qwG83CGSYR/5n0RtPMKt97czA0oz01wNu1xwailawyUa1z4zDTuqgNzetmzBr0
 2rjNLQNcUhtqiN33nN/1PzJmuVnfEtp4etcArNObjOSGyAZVj05FmuaS+gDcNYJgvTy/XKC5uRB
 fAJqwO/hnYjZ5lDm3HEkfk43hcn3T/zwVv8HnuGGVTfSwXVNOUCWGpduM4JGpi5Ti877kjLU
X-Proofpoint-ORIG-GUID: DVm18RIZjJaQykYVp7Nws6M-uznMkerF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-14_02,2025-07-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 mlxlogscore=999
 suspectscore=0 adultscore=0 impostorscore=0 phishscore=0
 lowpriorityscore=0 priorityscore=1501 clxscore=1015 mlxscore=0
 malwarescore=0 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507140139
Received-SPF: pass client-ip=148.163.158.5; envelope-from=walling@linux.ibm.com;
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

On 7/11/25 5:10 PM, Zhuoying Cai wrote:
> Refactor to enhance readability before enabling secure IPL in later
> patches.
> 
> Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
> ---
>  pc-bios/s390-ccw/bootmap.c | 58 ++++++++++++++++++++++----------------
>  1 file changed, 34 insertions(+), 24 deletions(-)
> 
> diff --git a/pc-bios/s390-ccw/bootmap.c b/pc-bios/s390-ccw/bootmap.c
> index 0f8baa0198..ced5190888 100644
> --- a/pc-bios/s390-ccw/bootmap.c
> +++ b/pc-bios/s390-ccw/bootmap.c
> @@ -674,6 +674,38 @@ static int zipl_load_segment(ComponentEntry *entry)
>      return 0;
>  }
>  
> +static int zipl_run_normal(ComponentEntry *entry, uint8_t *tmp_sec)
> +{
> +    while (entry->component_type == ZIPL_COMP_ENTRY_LOAD ||
> +        entry->component_type == ZIPL_COMP_ENTRY_SIGNATURE) {
> +

Add space to align this line with the one above, as it was in the code
you're refactoring:

       while (entry->component_type == ZIPL_COMP_ENTRY_LOAD ||
              entry->component_type == ZIPL_COMP_ENTRY_SIGNATURE) {

> +        /* Secure boot is off, so we skip signature entries */
> +        if (entry->component_type == ZIPL_COMP_ENTRY_SIGNATURE) {
> +            entry++;
> +            continue;
> +        }
> +
> +        if (zipl_load_segment(entry)) {
> +            return -1;
> +        }
> +
> +        entry++;
> +
> +        if ((uint8_t *)&entry[1] > tmp_sec + MAX_SECTOR_SIZE) {
> +            puts("Wrong entry value");
> +            return -EINVAL;
> +        }
> +    }
> +
> +    if (entry->component_type != ZIPL_COMP_ENTRY_EXEC) {
> +        puts("No EXEC entry");
> +        return -EINVAL;
> +    }
> +
> +    write_reset_psw(entry->compdat.load_psw);
> +    return 0;
> +}
> +
>  /* Run a zipl program */
>  static int zipl_run(ScsiBlockPtr *pte)
>  {
> @@ -700,34 +732,12 @@ static int zipl_run(ScsiBlockPtr *pte)
>  
>      /* Load image(s) into RAM */
>      entry = (ComponentEntry *)(&header[1]);
> -    while (entry->component_type == ZIPL_COMP_ENTRY_LOAD ||
> -           entry->component_type == ZIPL_COMP_ENTRY_SIGNATURE) {
> -
> -        /* We don't support secure boot yet, so we skip signature entries */
> -        if (entry->component_type == ZIPL_COMP_ENTRY_SIGNATURE) {
> -            entry++;
> -            continue;
> -        }
> -
> -        if (zipl_load_segment(entry)) {
> -            return -1;
> -        }
>  
> -        entry++;
> -
> -        if ((uint8_t *)(&entry[1]) > (tmp_sec + MAX_SECTOR_SIZE)) {
> -            puts("Wrong entry value");
> -            return -EINVAL;
> -        }
> -    }
> -
> -    if (entry->component_type != ZIPL_COMP_ENTRY_EXEC) {
> -        puts("No EXEC entry");
> -        return -EINVAL;
> +    if (zipl_run_normal(entry, tmp_sec)) {
> +        return -1;
>      }
>  
>      /* should not return */
> -    write_reset_psw(entry->compdat.load_psw);
>      jump_to_IPL_code(0);
>      return -1;
>  }

Both zipl_run_normal and zipl_run_secure will end with:

   if (entry->component_type != ZIPL_COMP_ENTRY_EXEC) {
       puts("No EXEC entry");
       return -EINVAL;
   }

   write_reset_psw(entry->compdat.load_psw);

I'd suggest making the refactor pass &entry and leaving the checks
mentioned above at the end of zipl_run.  That way there is less
duplicate code between _normal and _secure.

-- 
Regards,
  Collin

