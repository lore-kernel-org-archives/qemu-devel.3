Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E69FAC83F0A
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Jul 2025 18:51:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZZsY-0006pl-9e; Wed, 09 Jul 2025 14:50:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1uZZq4-0005NW-1f; Wed, 09 Jul 2025 14:48:16 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1uZZq0-0002DK-RJ; Wed, 09 Jul 2025 14:48:15 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 569E2hE5003799;
 Wed, 9 Jul 2025 18:48:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=DP1tU5
 K3bMvR9XDs6Vfp21W811ZJceJXsGvSu2ZcdIk=; b=EgfdbpMf8a4ufY4dHi9fr0
 YakounDTUglpwMm1XhA4sDSsHHF1KxBCX6My73YWvBkLrrOkAKozRMAFj9FZnHFh
 9yk9gRGD5LHspg5+vQde9tkEfapv3cM7eRJbfTw3hEZRUcj736LAOt6sMSAj/XEP
 hvopVbLfjfXfBn95tmaNZZcGXITJAVbbQcxne0iAVOZjUmzOKr5cDgEnvRPVxObK
 cS86IaSFvw5H6abBAoiUP53PaBjSnVsyA+NbyDv6ZZYqJlU1JctX2K1fQctZ5RIR
 5bCD3XLRACpeE33yv3U9c4TmJ8PJiHBguL52cbZnrE8wj1KIST/sS0gca15QrDtw
 ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47puss881c-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 09 Jul 2025 18:48:11 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 569I7DJN021519;
 Wed, 9 Jul 2025 18:48:10 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 47qectsu3h-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 09 Jul 2025 18:48:10 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com
 [10.39.53.228])
 by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 569Im8H727787976
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 9 Jul 2025 18:48:09 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id AC3DA5805B;
 Wed,  9 Jul 2025 18:48:08 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D74E558055;
 Wed,  9 Jul 2025 18:48:07 +0000 (GMT)
Received: from [9.61.75.155] (unknown [9.61.75.155])
 by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTPS;
 Wed,  9 Jul 2025 18:48:07 +0000 (GMT)
Message-ID: <49c1dc9b-74b5-46ed-b604-ece2f46508e8@linux.ibm.com>
Date: Wed, 9 Jul 2025 14:48:07 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/5] pc-bios/s390-ccw: Add a boot menu for booting via
 pxelinux.cfg
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 Zhuoying Cai <zycai@linux.ibm.com>
Cc: qemu-s390x@nongnu.org, Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Eric Farman <farman@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>
References: <20250709083443.41574-1-thuth@redhat.com>
 <20250709083443.41574-5-thuth@redhat.com>
Content-Language: en-US
From: Jared Rossi <jrossi@linux.ibm.com>
In-Reply-To: <20250709083443.41574-5-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Vaj3PEp9 c=1 sm=1 tr=0 ts=686eb96b cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=VnNF1IyMAAAA:8 a=20KFwNOVAAAA:8
 a=LF3KbhBF8ko_OsX6SCMA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: ELDmoRmKaI2adEgwLuPCMNIeSGz74UHS
X-Proofpoint-ORIG-GUID: ELDmoRmKaI2adEgwLuPCMNIeSGz74UHS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA5MDE2OCBTYWx0ZWRfXwCzxGIYu390o
 8CGDlNGYG6wlXc4UU84RDFbCxS+fa79uQhYxEqWISvmw9azMooRT60434C67zvJ9Swu3/booqtB
 Z7+l+YlHjImST15KDs2LzDgnDNQIUkrnFveL/Ss5cPb6r/IOZjL9NH/jo28RPRTKp5QidiJyWF+
 YbCKCwNHCFKWvxiQVqoxOfx+ZYkpQKlYXvdTuV66gkqCCa3A6kRaYuKBgirUrgUw9mt15rqaTOO
 aIMqUtY83ZneZR/v6II+oIDXn2lu36CjlTMrvd5BQuYZIJ5uGLlcVZ6a50qa4Uzid+eMxq2g0kF
 D749KZCNdL/3nHfdPIPZ+p+sE+kYNfPe/Ry793aDqFWEBgBxbA0zxHdbPScehbGnP1QN1//uv50
 OBW/WutNM0YT24dp5ygnH1ZYo9emkyJJuR3aRtG4/2bOnIUbfrqHMjXH50r0NTPvkUmHq3eW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-09_04,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 mlxlogscore=999 suspectscore=0 clxscore=1015 adultscore=0
 lowpriorityscore=0 impostorscore=0 malwarescore=0 bulkscore=0 mlxscore=0
 spamscore=0 phishscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507090168
Received-SPF: pass client-ip=148.163.156.1; envelope-from=jrossi@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Reviewed-by: Jared Rossi <jrossi@linux.ibm.com>

On 7/9/25 4:34 AM, Thomas Huth wrote:
> From: Thomas Huth <thuth@redhat.com>
>
> Show a simple boot menu for pxelinux.cfg, too, if the user requested it.
>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   pc-bios/s390-ccw/netmain.c | 26 ++++++++++++++++++++++++++
>   1 file changed, 26 insertions(+)
>
> diff --git a/pc-bios/s390-ccw/netmain.c b/pc-bios/s390-ccw/netmain.c
> index 6f64323cd84..a9521dff416 100644
> --- a/pc-bios/s390-ccw/netmain.c
> +++ b/pc-bios/s390-ccw/netmain.c
> @@ -332,6 +332,28 @@ static int load_kernel_with_initrd(filename_ip_t *fn_ip,
>       return rc;
>   }
>   
> +static int net_boot_menu(int num_ent, int def_ent,
> +                         struct pl_cfg_entry *entries)
> +{
> +    bool valid_entries[MAX_BOOT_ENTRIES] = { false };
> +    int idx;
> +
> +    puts("\ns390-ccw pxelinux.cfg boot menu:\n");
> +    printf(" [0] default (%d)\n", def_ent + 1);
> +    valid_entries[0] = true;
> +
> +    for (idx = 1; idx <= num_ent; idx++) {
> +        printf(" [%d] %s\n", idx, entries[idx - 1].label);
> +        valid_entries[idx] = true;
> +    }
> +    putchar('\n');
> +
> +    idx = menu_get_boot_index(valid_entries);
> +    putchar('\n');
> +
> +    return idx;
> +}
> +
>   static int net_select_and_load_kernel(filename_ip_t *fn_ip,
>                                         int num_ent, int selected,
>                                         struct pl_cfg_entry *entries)
> @@ -342,6 +364,10 @@ static int net_select_and_load_kernel(filename_ip_t *fn_ip,
>           return -1;
>       }
>   
> +    if (menu_is_enabled_enum() && num_ent > 1) {
> +        loadparm = net_boot_menu(num_ent, selected, entries);
> +    }
> +
>       IPL_assert(loadparm <= num_ent,
>                  "loadparm is set to an entry that is not available in the "
>                  "pxelinux.cfg file!");


