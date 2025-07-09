Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 722D0C83F03
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Jul 2025 18:50:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZZs2-0006FL-Fv; Wed, 09 Jul 2025 14:50:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1uZZpB-0004rv-0S; Wed, 09 Jul 2025 14:47:22 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1uZZp5-0001zy-Vk; Wed, 09 Jul 2025 14:47:17 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 569Geo68029472;
 Wed, 9 Jul 2025 18:47:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=NfdSz3
 5P8rudrAguyvKBXR6K2i3++q/yzYtaDGqsvbw=; b=pJTl3nUUT6LY4leS9/whNi
 EJDq2tvDW+y4PaTYi1j/iOew3+N7taEO3M+hOMZVumxtscVMkvcH4i62RpY3IeLa
 SONOe4PxmYCauEDMXpNr6BdvkkuAsRAefsNKarnUJy/d5dQylV9WoRvVQo8HI8BA
 0xkCqeELJUFKflCpxsv+nHZI3NL45A091idACXRKtJH4/dwHj2pQsQqg6gspfcE2
 OrwgccQ7wZWZmoQMYMRfzFuzJ/JYdToCscflP3Y4A2Nn9iaD8BiOQoZKnTwEWC1F
 cnDE1ZCFBT7R8pfkRTobDc1/f0fbqmbHoLEh1kTnkMZQUST21gLIWm6GZq1Vm/2A
 ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47ptjr7cyu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 09 Jul 2025 18:47:13 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 569FhodX003362;
 Wed, 9 Jul 2025 18:47:12 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 47qfvmhgyh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 09 Jul 2025 18:47:12 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com
 [10.39.53.228])
 by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 569IlBUv20578872
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 9 Jul 2025 18:47:11 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 588B858055;
 Wed,  9 Jul 2025 18:47:11 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 917955804B;
 Wed,  9 Jul 2025 18:47:10 +0000 (GMT)
Received: from [9.61.75.155] (unknown [9.61.75.155])
 by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTPS;
 Wed,  9 Jul 2025 18:47:10 +0000 (GMT)
Message-ID: <4d51f720-3470-4c3c-8c4f-b4464dbf25b6@linux.ibm.com>
Date: Wed, 9 Jul 2025 14:47:09 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/5] pc-bios/s390-ccw: Allow up to 31 entries for
 pxelinux.cfg
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 Zhuoying Cai <zycai@linux.ibm.com>
Cc: qemu-s390x@nongnu.org, Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Eric Farman <farman@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>
References: <20250709083443.41574-1-thuth@redhat.com>
 <20250709083443.41574-3-thuth@redhat.com>
Content-Language: en-US
From: Jared Rossi <jrossi@linux.ibm.com>
In-Reply-To: <20250709083443.41574-3-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=GL8IEvNK c=1 sm=1 tr=0 ts=686eb931 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=VnNF1IyMAAAA:8 a=20KFwNOVAAAA:8
 a=WWRG6OkS7xGguCEXWggA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: CeXU5Hj1H0yGQV82yfTeJc6tcE1n1pDX
X-Proofpoint-GUID: CeXU5Hj1H0yGQV82yfTeJc6tcE1n1pDX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA5MDE2OCBTYWx0ZWRfXzZE4y/HOMmRt
 r9yLHarwKI5MsR1eFyVR5blRreKj0sMMTSJJH3kEFXPcwLElctE+qjZS8dRHAo1jctxB+fh4HjN
 P7iSQsxCGWWb+3uZ4g8HI90pifrxk0o4PxLwJxMIyjesCqR5gpg71jBxLynT7YN4OXdid14BUpJ
 ZhQEl6jdwFpK3H9Lqya5iqtxWT/POMtItaRGmyme5JYfHGVCzulve0CdYZBnkIeluShbRMiG9tc
 KF+acSbrIk1vjiQaMpzkQPuHcrIl/FaBmT7aqQKH7HxhWvHUEcKFmKG8olDdWtKv8xnhYeUZIYw
 piFUAcq66J5GhkEu5cs2mPNpAg5C3ucGC7b7miLbQprzru4T/m+a3a9CRMvSvIO6KdsJf9jse88
 3mH6y/lbg01O4kwQbCyTphMAPruWYoNM6jnbr/w9d8j8ypNWJyBO97ZAqdtmyFdcUQKHxSbs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-09_04,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0
 clxscore=1015 impostorscore=0 suspectscore=0 bulkscore=0 adultscore=0
 priorityscore=1501 mlxscore=0 spamscore=0 mlxlogscore=999
 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507090168
Received-SPF: pass client-ip=148.163.158.5; envelope-from=jrossi@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
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
> We're going to support a menu for the pxelinux.cfg code, and to be able
> to reuse some functionality from menu.c, we should align the maximum
> amount of possible entries with the MAX_BOOT_ENTRIES constant that is
> used there. Thus replace MAX_PXELINUX_ENTRIES with MAX_BOOT_ENTRIES.
>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   pc-bios/s390-ccw/netmain.c | 10 ++++------
>   1 file changed, 4 insertions(+), 6 deletions(-)
>
> diff --git a/pc-bios/s390-ccw/netmain.c b/pc-bios/s390-ccw/netmain.c
> index c0aafca22d2..6f64323cd84 100644
> --- a/pc-bios/s390-ccw/netmain.c
> +++ b/pc-bios/s390-ccw/netmain.c
> @@ -353,17 +353,15 @@ static int net_select_and_load_kernel(filename_ip_t *fn_ip,
>       return load_kernel_with_initrd(fn_ip, &entries[selected]);
>   }
>   
> -#define MAX_PXELINUX_ENTRIES 16
> -
>   static int net_try_pxelinux_cfg(filename_ip_t *fn_ip)
>   {
> -    struct pl_cfg_entry entries[MAX_PXELINUX_ENTRIES];
> +    struct pl_cfg_entry entries[MAX_BOOT_ENTRIES];
>       int num_ent, def_ent = 0;
>   
>       num_ent = pxelinux_load_parse_cfg(fn_ip, mac, get_uuid(),
>                                         DEFAULT_TFTP_RETRIES,
>                                         cfgbuf, sizeof(cfgbuf),
> -                                      entries, MAX_PXELINUX_ENTRIES, &def_ent);
> +                                      entries, MAX_BOOT_ENTRIES, &def_ent);
>   
>       return net_select_and_load_kernel(fn_ip, num_ent, def_ent, entries);
>   }
> @@ -446,11 +444,11 @@ static int net_try_direct_tftp_load(filename_ip_t *fn_ip)
>            * a magic comment string.
>            */
>           if (!strncasecmp("# pxelinux", cfgbuf, 10)) {
> -            struct pl_cfg_entry entries[MAX_PXELINUX_ENTRIES];
> +            struct pl_cfg_entry entries[MAX_BOOT_ENTRIES];
>               int num_ent, def_ent = 0;
>   
>               num_ent = pxelinux_parse_cfg(cfgbuf, sizeof(cfgbuf), entries,
> -                                         MAX_PXELINUX_ENTRIES, &def_ent);
> +                                         MAX_BOOT_ENTRIES, &def_ent);
>               return net_select_and_load_kernel(fn_ip, num_ent, def_ent,
>                                                 entries);
>           }


