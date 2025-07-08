Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35C7FC8303C
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Jul 2025 20:04:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZEYA-0007Ov-1k; Tue, 08 Jul 2025 16:04:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1uZCPi-0002Q8-Cp; Tue, 08 Jul 2025 13:47:56 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1uZCOl-0004mF-30; Tue, 08 Jul 2025 13:47:24 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5684dQOT020492;
 Tue, 8 Jul 2025 13:13:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=TkWf+v
 zxOQn5QWJLz4uv76bqB1vH7U3b7npFUQzwkWw=; b=kAzqNVQdftskyFTMCkDEY7
 ERTeVyJjCwu2F9/V9FT0Y2W0VQHrCtX3EejnM0IpFQzdfIzG5r/9NvB4x2nteAwb
 ZWwDh1gA0R0hP5qO7Gg1+tVltr55ImnBtcYBqVJ2XfG4tdPpwXxa9aajxnkI6vPC
 sqUxHAWQw+VaddkeKaP9Al4aYWUQfMMdk3bmo+nL/x3xFtcl1kGUUb54zBpaoT2a
 owrDim0CB6r5ln+jG1rJgUZPC/Rr/K6tyzFzuitAPfWAO6Gr1y+sR7G8uv6v2xS4
 3dAWUotJj4mDQepNyi3WB1SzoGKcDaOGOp7XbAHYk8H7HXCf8hPEwmuyxZ10V+rA
 ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47puss01e5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 08 Jul 2025 13:13:25 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5689mpRu021522;
 Tue, 8 Jul 2025 13:13:24 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 47qectk7sm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 08 Jul 2025 13:13:24 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com
 [10.39.53.228])
 by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 568DDNEQ26739008
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 8 Jul 2025 13:13:23 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id F401C58055;
 Tue,  8 Jul 2025 13:13:22 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 351FE5804B;
 Tue,  8 Jul 2025 13:13:22 +0000 (GMT)
Received: from [9.61.75.155] (unknown [9.61.75.155])
 by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTPS;
 Tue,  8 Jul 2025 13:13:22 +0000 (GMT)
Message-ID: <6d0f221a-f5d7-4f2e-b3e8-1cb302681caf@linux.ibm.com>
Date: Tue, 8 Jul 2025 09:13:21 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] pc-bios/s390-ccw: Allow to select a different
 pxelinux.cfg entry via loadparm
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 Zhuoying Cai <zycai@linux.ibm.com>
Cc: qemu-s390x@nongnu.org, Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Eric Farman <farman@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>
References: <20250708125630.58676-1-thuth@redhat.com>
 <20250708125630.58676-2-thuth@redhat.com>
Content-Language: en-US
From: Jared Rossi <jrossi@linux.ibm.com>
In-Reply-To: <20250708125630.58676-2-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Vaj3PEp9 c=1 sm=1 tr=0 ts=686d1975 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=20KFwNOVAAAA:8 a=9Y155P_POryI0N1-XLAA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: oaGaDRHGVkrYv7Oabre26c2fkPH1i1Xq
X-Proofpoint-ORIG-GUID: oaGaDRHGVkrYv7Oabre26c2fkPH1i1Xq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA4MDEwNiBTYWx0ZWRfX0MMy3v+e7eVP
 a/ISOoWe7/OMxKeXBhoHFGaVizRQ7mxagK79695Rs7u7bwravPWpebKwXCXakB/26EYE9EXajFt
 vLPcvQ90sRHQ1vqhuIszDefA09EpRVHbq9cXhJUUJWphDhBla8D+mkGWCPANVyGHNX7k6qvMZHZ
 9I9GS6Cyh6Y2MoWQ83BHAfL9NJAo8k3WhbEO+0yrMhC5LF55SiO3xQ7lod/+VLt1mPTZ/PT6nfO
 9jNEl00L1vvDaRAl71cANjU51yJqNJGtDW08C3YlDjMLQnIEQzrZCA1cDu8xoaAnaBlmmw2VYlT
 3zNI+wKNnoOc+bzvSOpzVu/mDl3f4elbG4rqY1VepmKG6VjokcncDKJG3/sWtXYJkvyqnfL6Z9O
 Nb03OB294b5sK5JE6fVjXtqrowK1S+IqObwkJXJrwd9PyDouDSnTmTDIG6k3KCMpvPM9MEZB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-08_03,2025-07-07_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 mlxlogscore=999 suspectscore=0 clxscore=1015 adultscore=0
 lowpriorityscore=0 impostorscore=0 malwarescore=0 bulkscore=0 mlxscore=0
 spamscore=0 phishscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507080106
Received-SPF: pass client-ip=148.163.156.1; envelope-from=jrossi@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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



On 7/8/25 8:56 AM, Thomas Huth wrote:
> From: Thomas Huth <thuth@redhat.com>
>
> Since we're linking the network booting code into the main firmware
> binary nowadays, we can support the "loadparm" parameter now quite
> easily for pxelinux.cfg config files that contain multiple entries.
>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   pc-bios/s390-ccw/netmain.c | 33 +++++++++++++++++++++++++--------
>   1 file changed, 25 insertions(+), 8 deletions(-)
>
> diff --git a/pc-bios/s390-ccw/netmain.c b/pc-bios/s390-ccw/netmain.c
> index 719a547ada0..024b4419ef6 100644
> --- a/pc-bios/s390-ccw/netmain.c
> +++ b/pc-bios/s390-ccw/netmain.c
> @@ -332,6 +332,28 @@ static int load_kernel_with_initrd(filename_ip_t *fn_ip,
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
> +    if (loadparm > num_ent) {
> +        printf("Error: loadparm is set to entry #%d, but there are only "
> +               "%d entries in the pxelinux.cfg file!\n"
> +               "Using default entry now instead.\n",
> +               loadparm, num_ent);
Commit 64fa0de established that the IPL should abort on any loadparm 
misconfiguration, therefore I think this should result in a fatal error 
rather than using the default.

> +    } else if (loadparm > 0) {
> +        selected = loadparm - 1;
> +    }
> +
> +    return load_kernel_with_initrd(fn_ip, &entries[selected]);
> +}
> +
>   #define MAX_PXELINUX_ENTRIES 16
>   
>   static int net_try_pxelinux_cfg(filename_ip_t *fn_ip)
> @@ -343,11 +365,8 @@ static int net_try_pxelinux_cfg(filename_ip_t *fn_ip)
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
> @@ -433,10 +452,8 @@ static int net_try_direct_tftp_load(filename_ip_t *fn_ip)
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


