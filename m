Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FB61C43458
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2026 02:50:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wf7Ug-0008HC-Nb; Wed, 01 Jul 2026 22:49:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1wf7Uf-0008Gq-3a; Wed, 01 Jul 2026 22:49:37 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1wf7Ud-0000E9-BJ; Wed, 01 Jul 2026 22:49:36 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6621KThg2646495; Thu, 2 Jul 2026 02:49:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=d3w1sX
 GD01ue4V2UPAub2ujT+yHzCM4eyZak+jfxnDE=; b=DxFI+rRFSpiMBzqBXtVcB0
 mqnD9EO00eHLRm8cXBgxi5QlH/MxKlBpPH51Sz+6bridG5Xy427xq0fRlLhA+8U7
 sGfHOBnpQC9hW2RBBoGRI80yX7xfeFj51Z3mGZEuRur17KwDOgRQFVzNzQVvhDba
 XnkAkgvAcXSr9NjJE29hY15dy8wWdyLW+1uIFJnVDYwNLD5JSXiFklvEXrB1JLE8
 ybjwnOnOVn28BDtLPaAM57nc7UChi+oyA8OYGAMZfXCEsfMmAHVTl1gkIy4/0J6m
 EO+wvZsyTOa3rIKmSHDV+2jmgLNQDkaYBjBETCqmHcUPDpuIjI+CCS6+kuBSSyww
 ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f26qg7qs1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 02 Jul 2026 02:49:30 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6622Yaga026806;
 Thu, 2 Jul 2026 02:49:29 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f2u2ghyqm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 02 Jul 2026 02:49:29 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com
 [10.241.53.100])
 by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 6622nRO323527992
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 2 Jul 2026 02:49:28 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D9D7A58058;
 Thu,  2 Jul 2026 02:49:27 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5337358057;
 Thu,  2 Jul 2026 02:49:26 +0000 (GMT)
Received: from [9.61.143.111] (unknown [9.61.143.111])
 by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTPS;
 Thu,  2 Jul 2026 02:49:26 +0000 (GMT)
Message-ID: <17c83e1a-0466-4a37-ab3d-7d6c473d888f@linux.ibm.com>
Date: Wed, 1 Jul 2026 22:49:25 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 24/35] pc-bios/s390-ccw: Add signed component address
 overlap checks
To: Zhuoying Cai <zycai@linux.ibm.com>, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org
Cc: cohuck@redhat.com, berrange@redhat.com, richard.henderson@linaro.org,
 david@kernel.org, walling@linux.ibm.com, jjherne@linux.ibm.com,
 pasic@linux.ibm.com, borntraeger@linux.ibm.com, farman@linux.ibm.com,
 mjrosato@linux.ibm.com, iii@linux.ibm.com, eblake@redhat.com,
 armbru@redhat.com, alifm@linux.ibm.com, brueckner@linux.ibm.com,
 pierrick.bouvier@oss.qualcomm.com, jdaley@linux.ibm.com
References: <20260701204922.1320349-1-zycai@linux.ibm.com>
 <20260701204922.1320349-25-zycai@linux.ibm.com>
Content-Language: en-US
From: Jared Rossi <jrossi@linux.ibm.com>
In-Reply-To: <20260701204922.1320349-25-zycai@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=RYqgzVtv c=1 sm=1 tr=0 ts=6a45d1ba cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=n215UdciXD4LtEMnI7YA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAyMDAyNiBTYWx0ZWRfX7IzN8NwaAm1R
 u8MP5d9oDa58n6fdEkfL3ZwcYypjI4D8CzGT2VSXkuY7HvDbCzXPhdwBApRnKcjwfrD2gp1HKkk
 d7WnIB1DTAxxXX+Is9MepIW6e3u0ILY=
X-Proofpoint-GUID: gQkTCNqdGxA99-2k8CqSsVN_WkZG-XTW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAyMDAyNiBTYWx0ZWRfX6GLFUWNj3q0O
 RTacsPTITeNbT/M4xp0mc49xirr2Jd4DMB6UfELC3LOM1pX34tG3JqXMtddc23BcAi0A3vUFoB8
 2j5h9MBa6mmuZGkOqXMRQ90D1m35rffym4Pj/jvFEIvHVAQHU1EMWpEtEyf0cnkG0Seo1xO3xNI
 NEbLIMMSfZmKov0yqu1qCmr3+iCfY6PgJmeqSMk6I6RyRwy5GOxIDD7HLbDjq/PvGBU40qrJWaX
 De7zVwhr3spnGhLvICzeirgtQLIRcIEAn8zRKDIvjRaJ0z64wYBdjQTxKZRXDoUFYwmP/fTR8AF
 XGR5118seCp3IpuNoKZfJjNBeo8tFgAvrCFYkW6w1WOWx3UtyKm4gkyesbTnQfOt0+bxsP6VHEq
 Oijx7W1LJrbkti2gj5BbP9n4AYCTrO3y8IoCPV3XETUjHW4HGDmBf3EuLFDWIhseRz/NBzwNJzV
 V9Ol/jr/EXGB1tK5Cgw==
X-Proofpoint-ORIG-GUID: gQkTCNqdGxA99-2k8CqSsVN_WkZG-XTW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-02_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0
 adultscore=0 priorityscore=1501 suspectscore=0 bulkscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607020026
Received-SPF: pass client-ip=148.163.156.1; envelope-from=jrossi@linux.ibm.com;
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



On 7/1/26 4:49 PM, Zhuoying Cai wrote:
> Add address range tracking and overlap checks to ensure that no
> component overlaps with a signed component during secure IPL.
>
> Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
> ---
>   pc-bios/s390-ccw/secure-ipl.c | 19 +++++++++++++++++++
>   pc-bios/s390-ccw/secure-ipl.h |  6 ++++++
>   2 files changed, 25 insertions(+)
>
> diff --git a/pc-bios/s390-ccw/secure-ipl.c b/pc-bios/s390-ccw/secure-ipl.c
> index 2d9a4cbc02..af98881aa5 100644
> --- a/pc-bios/s390-ccw/secure-ipl.c
> +++ b/pc-bios/s390-ccw/secure-ipl.c
> @@ -193,6 +193,23 @@ static void init_lists(IplDeviceComponentList *comp_list,
>       cert_list->ipl_info_header.len = sizeof(IplInfoBlockHeader);
>   }
>   
> +static void check_comp_overlap(IplDeviceComponentList *comp_list,
> +                               IplDeviceComponentEntry comp_entry)
> +{
> +    IplDeviceComponentEntry *comp;
> +
> +    /*
> +     * Check component's address range does not overlap with any
> +     * signed component's address range.
> +     */
> +    for_each_rb_entry(comp, comp_list) {
> +        if (comp->flags & S390_IPL_DEV_COMP_FLAG_SC &&
> +            intersects(comp->addr, comp->len, comp_entry.addr, comp_entry.len)) {
> +            zipl_secure_error("Component addresses overlap");
> +        }
> +    }
> +}
> +
>   static int zipl_load_signature(ComponentEntry *entry, uint64_t sig)
>   {
>       if (entry->compdat.sig_info.format != DER_SIGNATURE_FORMAT) {
> @@ -287,6 +304,8 @@ int zipl_run_secure(ComponentEntry **entry_ptr, uint8_t *tmp_sec,
>               comp_entry.addr = comp_addr;
>               comp_entry.len = (uint64_t)comp_len;
>   
> +            check_comp_overlap(comp_list, comp_entry);
> +
>               /* no signature present (unsigned component) */
>               if (!sig_entry.len) {
>                   comp_list_add(comp_list, comp_entry);
> diff --git a/pc-bios/s390-ccw/secure-ipl.h b/pc-bios/s390-ccw/secure-ipl.h
> index d5d6d6f7ac..1b1287858b 100644
> --- a/pc-bios/s390-ccw/secure-ipl.h
> +++ b/pc-bios/s390-ccw/secure-ipl.h
> @@ -113,4 +113,10 @@ static inline bool verify_signature(IplDeviceComponentEntry comp_entry,
>       return false;
>   }
>   
> +static inline bool intersects(uint64_t addr0, uint64_t size0,
> +                              uint64_t addr1, uint64_t size1)
> +{
> +    return addr0 + size0 > addr1 && addr1 + size1 > addr0;
> +}
> +
>   #endif /* _PC_BIOS_S390_CCW_SECURE_IPL_H */

Reviewed-by: Jared Rossi <jrossi@linux.ibm.com>

