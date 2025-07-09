Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CDAEC83F0A
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Jul 2025 18:50:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZZsG-0006Yj-NL; Wed, 09 Jul 2025 14:50:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1uZZph-0005EX-Sq; Wed, 09 Jul 2025 14:47:54 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1uZZpf-000297-CH; Wed, 09 Jul 2025 14:47:53 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 569HOGsp027403;
 Wed, 9 Jul 2025 18:47:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=wv/Wah
 4Xg1UjmB5Qr1m10QJIFoW3PDzzCTNBlMWesNU=; b=NDq2B+jdI7cjJkujJUWC61
 poWGqYDbbgLjCyF0YFWnlhZYmMxAUeF5jvNZVqWbvHyH0spFZEeOapWBJvX9IOpl
 x3IZ3qQrZ2SYru5VSjhJDkpOLayT/6GWNyBfZkc4SPfadmfdZ7p9M/y4gItf34XI
 rUuR98lJjrun9VneO5HiBOCYrrlKhos/UalcWd97R7JECYwQHRWxE9YjqxrSQF3c
 7vskpGDQPdE25mpeo+En8D5wDVehGG3Dr0invq5FI/Xz/pFGYqvidCNYDz58J96t
 HQrdpaKc/aMrdw9O7WiMPU5Y2fAOd27zZpb6wHA0FCW+98+iI1pUwmnddI+cCgsQ
 ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47puss8800-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 09 Jul 2025 18:47:49 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 569G60WU013582;
 Wed, 9 Jul 2025 18:47:48 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 47qgkm1e0h-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 09 Jul 2025 18:47:48 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com
 [10.39.53.228])
 by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 569IlkYE15336066
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 9 Jul 2025 18:47:46 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CF9B158055;
 Wed,  9 Jul 2025 18:47:46 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 11FAC5804B;
 Wed,  9 Jul 2025 18:47:46 +0000 (GMT)
Received: from [9.61.75.155] (unknown [9.61.75.155])
 by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTPS;
 Wed,  9 Jul 2025 18:47:45 +0000 (GMT)
Message-ID: <4558a384-ea00-4c3e-8c8e-b0a711ead35a@linux.ibm.com>
Date: Wed, 9 Jul 2025 14:47:45 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/5] pc-bios/s390-ccw: Make get_boot_index() from
 menu.c global
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 Zhuoying Cai <zycai@linux.ibm.com>
Cc: qemu-s390x@nongnu.org, Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Eric Farman <farman@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>
References: <20250709083443.41574-1-thuth@redhat.com>
 <20250709083443.41574-4-thuth@redhat.com>
Content-Language: en-US
From: Jared Rossi <jrossi@linux.ibm.com>
In-Reply-To: <20250709083443.41574-4-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Vaj3PEp9 c=1 sm=1 tr=0 ts=686eb955 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=VnNF1IyMAAAA:8 a=20KFwNOVAAAA:8
 a=R3FVNjSJQuFLlcQU_dMA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: ejyOGTJAuSaGe39ngAwkIgaUxJmfzAti
X-Proofpoint-ORIG-GUID: ejyOGTJAuSaGe39ngAwkIgaUxJmfzAti
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA5MDE2OCBTYWx0ZWRfX/oKyo+vHSjTc
 2XIhc3Medqa/Eoc6dmrGvez8pUwoG4esyin3NWBV/yD3gFsgeA3vAll3m/JWKcZwyMZFC9j7LM4
 ctdsJRNlpEJdGTL0KMiAbcLnRhC3/oQAUa2J8serHVEqPrRwL/WUo/QfrSJCap5RApE71HTX1ca
 gRexzGgVUl2MEXUHC6nuUc5zTOUrsAr9GvWbweLod/e+k//GSClX6SwN/7e5gdK19V5hlDfFut9
 zyVRiPQAezy0y1oJLt/5xTiwhZuKcXQ2f9HBLLSuR6kYkK5eT1ZyQj7IwVcZxbETej3CRWV7HKv
 jV2JOjnfEHdaWEBUKnAvO4DfA1UL0G59Bqvv5CFsFOFbgd8hJ+UoPgNJx2uJX9LJjAvscETuhI7
 KPEh2OLNXdF3gHI1t8US9hEQf1kVe6QFyEPP7dQyi4tyoyF0n0Xijb+Tnm2UCup51yPyCiZk
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
> We are going to reuse this function for selecting an entry from
> the pxelinux.cfg menu, so rename this function with a "menu_"
> prefix and make it available globally.
>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   pc-bios/s390-ccw/s390-ccw.h | 1 +
>   pc-bios/s390-ccw/menu.c     | 6 +++---
>   2 files changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/pc-bios/s390-ccw/s390-ccw.h b/pc-bios/s390-ccw/s390-ccw.h
> index 6cdce3e5e5b..b1dc35cdedf 100644
> --- a/pc-bios/s390-ccw/s390-ccw.h
> +++ b/pc-bios/s390-ccw/s390-ccw.h
> @@ -87,6 +87,7 @@ int menu_get_zipl_boot_index(const char *menu_data);
>   bool menu_is_enabled_zipl(void);
>   int menu_get_enum_boot_index(bool *valid_entries);
>   bool menu_is_enabled_enum(void);
> +int menu_get_boot_index(bool *valid_entries);
>   
>   #define MAX_BOOT_ENTRIES  31
>   
> diff --git a/pc-bios/s390-ccw/menu.c b/pc-bios/s390-ccw/menu.c
> index 84062e94af4..eeaff78f870 100644
> --- a/pc-bios/s390-ccw/menu.c
> +++ b/pc-bios/s390-ccw/menu.c
> @@ -159,7 +159,7 @@ static void boot_menu_prompt(bool retry)
>       }
>   }
>   
> -static int get_boot_index(bool *valid_entries)
> +int menu_get_boot_index(bool *valid_entries)
>   {
>       int boot_index;
>       bool retry = false;
> @@ -224,7 +224,7 @@ int menu_get_zipl_boot_index(const char *menu_data)
>       }
>   
>       printf("\n");
> -    return get_boot_index(valid_entries);
> +    return menu_get_boot_index(valid_entries);
>   }
>   
>   int menu_get_enum_boot_index(bool *valid_entries)
> @@ -247,7 +247,7 @@ int menu_get_enum_boot_index(bool *valid_entries)
>       }
>   
>       printf("\n");
> -    return get_boot_index(valid_entries);
> +    return menu_get_boot_index(valid_entries);
>   }
>   
>   void menu_set_parms(uint8_t boot_menu_flag, uint32_t boot_menu_timeout)


