Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6555C3ABDA
	for <qemu-devel@archiver.kernel.org>; Wed, 14 May 2025 19:22:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFHgZ-0006v8-MA; Wed, 14 May 2025 15:22:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kowal@linux.ibm.com>)
 id 1uFHUj-0006ux-Gi; Wed, 14 May 2025 15:10:24 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kowal@linux.ibm.com>)
 id 1uFHUh-0001GA-EU; Wed, 14 May 2025 15:10:21 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54EEglxc026369;
 Wed, 14 May 2025 19:10:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=3hXHlR
 X8xreihPOd9X9f/zlgsKyiKDtOBjMOMVAo/us=; b=aR6XRcJWwvASxyQ3CONVjc
 T6P+FE2ZhBf4IkvzNX0zK8xz9MI2MMwmWXrv0WWZrTpN4hjK0t87QSmT6/QkZ2QQ
 /S/UAMfFvHMgIQKcOy0pYaJbPmnbl2K7vUgpfv46U7xZz8wjENwIJpPsvtJ7LQZD
 c8+w3RxLlDWlZ8Eogq4mtHFDi/bRdOWea9E0cTL539Dbgwo3Qe7Tq8GQvoP7FMtX
 38sEbjP/hUdLXasiyJIOgVZjBZKyoB3PsK3djVn1IxwHdE5YTlARPcRi4i0ywl+O
 ehgHDkyGNDG5TxdNher7dnMirVT/yf64exLJAUU/2gr/5iZdgqYtIHLgVq3RCB+Q
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46mnst3uv7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 14 May 2025 19:10:09 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 54EJA8A2006120;
 Wed, 14 May 2025 19:10:08 GMT
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46mnst3uv2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 14 May 2025 19:10:08 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 54EGOeox015353;
 Wed, 14 May 2025 19:10:07 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 46mbfpx0m5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 14 May 2025 19:10:07 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com
 [10.39.53.233])
 by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 54EJA6At20972178
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 14 May 2025 19:10:06 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7B76B5804E;
 Wed, 14 May 2025 19:10:06 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id EB44058055;
 Wed, 14 May 2025 19:10:05 +0000 (GMT)
Received: from [9.10.80.143] (unknown [9.10.80.143])
 by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 14 May 2025 19:10:05 +0000 (GMT)
Message-ID: <1a95a779-10b9-458e-af09-92604dc38afe@linux.ibm.com>
Date: Wed, 14 May 2025 14:10:05 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 19/50] pnv/xive2: VC_ENDC_WATCH_SPEC regs should read back
 WATCH_FULL
To: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, =?UTF-8?B?RnLDqWTDqXJpYyBCYXJyYXQ=?=
 <fbarrat@linux.ibm.com>, Glenn Miles <milesg@linux.ibm.com>,
 Caleb Schlossin <calebs@linux.vnet.ibm.com>
References: <20250512031100.439842-1-npiggin@gmail.com>
 <20250512031100.439842-20-npiggin@gmail.com>
Content-Language: en-US
From: Mike Kowal <kowal@linux.ibm.com>
In-Reply-To: <20250512031100.439842-20-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: tTYaO1HGuQdtRyoxu6bFq2RCsZLfXOlw
X-Authority-Analysis: v=2.4 cv=V+590fni c=1 sm=1 tr=0 ts=6824ea91 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=VnNF1IyMAAAA:8 a=pGLkceISAAAA:8
 a=OIwot2dQPgAvwoVT6JIA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: P4V8IQO_SbB0_T6y3-P1qDvZNJyu8-yE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE0MDE3NCBTYWx0ZWRfXxuMARivfDJy0
 b8/46T012m5/s/MdwhrvhEOpQjkbzLLf0xvpiiWxq91jnLoJIAgKv8Dam5aoNzrLlf8mDQ507mQ
 vGy5XEusV4hUpkd+DmjI1US8wRel47Ia5c51vIKw7SylA5odybmlKh6P9a3vNJqj7Ln6ukiz4fQ
 uTfdxlMXWDiNSzKZ3sIPSxgftsVtVEECry6KP45+OOvxEV4Mg742/BrvZQONPuIHaeQczu14ZTD
 MWhBb8a4la2jLFGAHPyPIiEC0Kzpzd9g3eT9tXMv85tzC98Z+3OC18QQBSabBCBN4MMGalDAsHb
 crG9M4P6cNWRycgNdIb5ayz6fsq/QEWFIfDQTFeTtNS+LBYySVkpsCuLwPTz6yAKA/oZgfviRKp
 nKXcJdLl7WdY77vGUDEmMQ8Ikl33+y0dOrw4k+cznEJv6Vxn1jzubHtrsbackb/Ru/hoGwiq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-14_04,2025-05-14_03,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 priorityscore=1501
 mlxlogscore=989 lowpriorityscore=0 bulkscore=0 suspectscore=0
 impostorscore=0 malwarescore=0 phishscore=0 adultscore=0 clxscore=1015
 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2505070000
 definitions=main-2505140174
Received-SPF: pass client-ip=148.163.156.1; envelope-from=kowal@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


On 5/11/2025 10:10 PM, Nicholas Piggin wrote:
> Firmware expects to read back the WATCH_FULL bit from the VC_ENDC_WATCH_SPEC
> register, so don't clear it on read.
>
> Don't bother clearing the reads-as-zero CONFLICT bit because it's masked
> at write already.

Reviewed-by: Michael Kowal <kowal@linux.ibm.com>

Thanks MAK


>
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>   hw/intc/pnv_xive2.c | 1 -
>   1 file changed, 1 deletion(-)
>
> diff --git a/hw/intc/pnv_xive2.c b/hw/intc/pnv_xive2.c
> index fcf5b2e75c..3c26cd6b77 100644
> --- a/hw/intc/pnv_xive2.c
> +++ b/hw/intc/pnv_xive2.c
> @@ -1329,7 +1329,6 @@ static uint64_t pnv_xive2_ic_vc_read(void *opaque, hwaddr offset,
>       case VC_ENDC_WATCH2_SPEC:
>       case VC_ENDC_WATCH3_SPEC:
>           watch_engine = (offset - VC_ENDC_WATCH0_SPEC) >> 6;
> -        xive->vc_regs[reg] &= ~(VC_ENDC_WATCH_FULL | VC_ENDC_WATCH_CONFLICT);
>           pnv_xive2_endc_cache_watch_release(xive, watch_engine);
>           val = xive->vc_regs[reg];
>           break;

