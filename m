Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9D0DC83F0A
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Jul 2025 18:50:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZZry-00068H-7c; Wed, 09 Jul 2025 14:50:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1uZZoh-0004du-I0; Wed, 09 Jul 2025 14:46:55 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1uZZof-0001vQ-3f; Wed, 09 Jul 2025 14:46:50 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 569GQU2t021182;
 Wed, 9 Jul 2025 18:46:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=MnzK87
 xOAvxootay4KbLT+o7F58Xxkwyhs2l504EALk=; b=UbzMbrkECrxQoQ8UCrti12
 dKo1SuzEUz57wOFsoCb9HcidtL7z4D68W5sJIHcIS5F62a5UUZSCGR0i+yR55eyj
 p/ibgmi79MHH4ac4apgyVEUaMAA3HIcKvgy/1TbALhLjvpJM3QNTpN9C0iA0y1VE
 qelbpWAINgcv/O9uhyirVeb2tYbbo5Z88WqKnSN8WdgOTWJo84EOelU8lKEaOgjp
 nvl2mqDTNYmvEplEevkbtFuyI9Ow3/Tp8hCE820d7OplNt56UxzyoFP+ge6aoVv5
 GK+8/2tRnXXP9owd4UUYONgshhe5L6b32OvSVIShh3doPEIYkJ0KKl6zty+XUuHg
 ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47puss87uu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 09 Jul 2025 18:46:44 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 569GKIOG013555;
 Wed, 9 Jul 2025 18:46:43 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 47qgkm1dw5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 09 Jul 2025 18:46:43 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com
 [10.39.53.228])
 by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 569IkfBF29688336
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 9 Jul 2025 18:46:41 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6F30258065;
 Wed,  9 Jul 2025 18:46:41 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9E1C958055;
 Wed,  9 Jul 2025 18:46:40 +0000 (GMT)
Received: from [9.61.75.155] (unknown [9.61.75.155])
 by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTPS;
 Wed,  9 Jul 2025 18:46:40 +0000 (GMT)
Message-ID: <630f3ce0-7a1c-4845-a3b3-a60e3224946a@linux.ibm.com>
Date: Wed, 9 Jul 2025 14:46:39 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/5] pc-bios/s390-ccw: Allow to select a different
 pxelinux.cfg entry via loadparm
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 Zhuoying Cai <zycai@linux.ibm.com>
Cc: qemu-s390x@nongnu.org, Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Eric Farman <farman@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>
References: <20250709083443.41574-1-thuth@redhat.com>
 <20250709083443.41574-2-thuth@redhat.com>
Content-Language: en-US
From: Jared Rossi <jrossi@linux.ibm.com>
In-Reply-To: <20250709083443.41574-2-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Vaj3PEp9 c=1 sm=1 tr=0 ts=686eb914 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=VnNF1IyMAAAA:8 a=20KFwNOVAAAA:8
 a=hgG9rQ9fSHbztHr7FegA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: mKzlqdV4GB8ajHn7vB732jHKCTyQMYoz
X-Proofpoint-ORIG-GUID: mKzlqdV4GB8ajHn7vB732jHKCTyQMYoz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA5MDE2OCBTYWx0ZWRfX5XeHRP3tTQqa
 EIq8nXjoRgZabYYBZq9L0+019M2B9xGAwAIha5w4Is3DUY6hrNDE5DWZyOdmuynWQ47x29bn+KN
 Q/piqfQfLchc9yrAIr3YdQ/PehnyA2wMjw1I2FKsEbbuPuMHyjBt6pvpzy27BQd8UgfTWGyZ8Bu
 7TbvQGAoWbi4Fmbp8gWtOBizAmb9NPW7sHdp4ptVQ1dx7o4UbNlTWDQmch9qHitwqPZU2oG4lBX
 CFI98h54lXeGjTXQw7sLFUMOFpsPnjJc31dRF/BirR2RufwhGDSanStGKDygpwL/NPTxk3tL6t7
 nFjnvxYUCbVNcpNUfEFqLcXEvs7wvLUvstleMRtdP6ycDwy7Nb+tgTYaqiW0ohrJewPi5uDNu/o
 IMYZZPPXRjTfQ7rVc8qQ9As7n8jJOTsy1h/mfSg5U1QsYEA7mrtfAT78F6ogNw0WFUWIDuCA
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
> Since we're linking the network booting code into the main firmware
> binary nowadays, we can support the "loadparm" parameter now quite
> easily for pxelinux.cfg config files that contain multiple entries.
>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   pc-bios/s390-ccw/netmain.c | 32 ++++++++++++++++++++++++--------
>   1 file changed, 24 insertions(+), 8 deletions(-)
>
> diff --git a/pc-bios/s390-ccw/netmain.c b/pc-bios/s390-ccw/netmain.c
> index 719a547ada0..c0aafca22d2 100644
> --- a/pc-bios/s390-ccw/netmain.c
> +++ b/pc-bios/s390-ccw/netmain.c
> @@ -332,6 +332,27 @@ static int load_kernel_with_initrd(filename_ip_t *fn_ip,
>       return rc;
>   }
>   
> +static int net_select_and_load_kernel(filename_ip_t *fn_ip,
> +                                      int num_ent, int selected,
> +                                      struct pl_cfg_entry *entries)
> +{
> +    unsigned int loadparm = get_loadparm_index();
> +
> +    if (num_ent <= 0) {
> +        return -1;
> +    }
> +
> +    IPL_assert(loadparm <= num_ent,
> +               "loadparm is set to an entry that is not available in the "
> +               "pxelinux.cfg file!");
> +
> +    if (loadparm > 0) {
> +        selected = loadparm - 1;
> +    }
> +
> +    return load_kernel_with_initrd(fn_ip, &entries[selected]);
> +}
> +
>   #define MAX_PXELINUX_ENTRIES 16
>   
>   static int net_try_pxelinux_cfg(filename_ip_t *fn_ip)
> @@ -343,11 +364,8 @@ static int net_try_pxelinux_cfg(filename_ip_t *fn_ip)
>                                         DEFAULT_TFTP_RETRIES,
>                                         cfgbuf, sizeof(cfgbuf),
>                                         entries, MAX_PXELINUX_ENTRIES, &def_ent);
> -    if (num_ent > 0) {
> -        return load_kernel_with_initrd(fn_ip, &entries[def_ent]);
> -    }
>   
> -    return -1;
> +    return net_select_and_load_kernel(fn_ip, num_ent, def_ent, entries);
>   }
>   
>   /**
> @@ -433,10 +451,8 @@ static int net_try_direct_tftp_load(filename_ip_t *fn_ip)
>   
>               num_ent = pxelinux_parse_cfg(cfgbuf, sizeof(cfgbuf), entries,
>                                            MAX_PXELINUX_ENTRIES, &def_ent);
> -            if (num_ent <= 0) {
> -                return -1;
> -            }
> -            return load_kernel_with_initrd(fn_ip, &entries[def_ent]);
> +            return net_select_and_load_kernel(fn_ip, num_ent, def_ent,
> +                                              entries);
>           }
>       }
>   


