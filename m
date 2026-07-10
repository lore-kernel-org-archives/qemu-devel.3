Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01E86C43458
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 20:37:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wiHy8-0006SB-Ak; Fri, 10 Jul 2026 16:37:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <walling@linux.ibm.com>)
 id 1wiHxt-0006Hy-GR; Fri, 10 Jul 2026 16:36:53 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <walling@linux.ibm.com>)
 id 1wiHxs-0005wM-1e; Fri, 10 Jul 2026 16:36:53 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66AKIgMf2253083; Fri, 10 Jul 2026 20:36:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=DESW63
 lPjWXMpQy3/aTQfyxdPL5RpfT/14+mSRvW7zY=; b=aoSOWaGC58jC2zcTlFhrqi
 F+BKFL5csJGg95vDjIajfu//HvmSndC5DQUeO4zyHHbduxaFcUjj9NQ9BZWTM5xb
 gDoTdjbwDSQVZQ1kEy09PJ8Li4QJ8P6LEyltN2Yat/g17mdwM+6UhuFj2MFc2Mdk
 25PNeqT9NnpV2VsJfTkGnPc5i54GGdzrwPFLAZmLkb7+tWx7BuzsmwwkC5tyiezI
 HIcgbiUTVisPfk/S9ecaKM6o+QqCWmK1BhaG0xlA7IvZMiFonzKRIB/3Kp0orkyN
 woe8igIJhv0jhf+MczJurDqACUol52N/DXUFMk3Vd4ewJkWLeGctnO2eoQtVEyrA
 ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6qknyxj9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 10 Jul 2026 20:36:47 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66AKYd5T018346;
 Fri, 10 Jul 2026 20:36:46 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4f7e0huqry-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 10 Jul 2026 20:36:46 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com
 [10.241.53.103])
 by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 66AKajHX25428510
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 10 Jul 2026 20:36:45 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 70F9D5805A;
 Fri, 10 Jul 2026 20:36:45 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2895E58056;
 Fri, 10 Jul 2026 20:36:44 +0000 (GMT)
Received: from [9.67.136.45] (unknown [9.67.136.45])
 by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTPS;
 Fri, 10 Jul 2026 20:36:44 +0000 (GMT)
Message-ID: <7ca05abd-dd96-4e03-92a1-21d15c08c57b@linux.ibm.com>
Date: Fri, 10 Jul 2026 16:36:43 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v16 24/33] pc-bios/s390-ccw: Add signed component address
 overlap checks
To: Zhuoying Cai <zycai@linux.ibm.com>, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org
Cc: jrossi@linux.ibm.com, cohuck@redhat.com, berrange@redhat.com,
 richard.henderson@linaro.org, david@kernel.org, jjherne@linux.ibm.com,
 pasic@linux.ibm.com, borntraeger@linux.ibm.com, farman@linux.ibm.com,
 mjrosato@linux.ibm.com, iii@linux.ibm.com, eblake@redhat.com,
 armbru@redhat.com, alifm@linux.ibm.com, brueckner@linux.ibm.com,
 pierrick.bouvier@oss.qualcomm.com, jdaley@linux.ibm.com
References: <20260707231132.2492104-1-zycai@linux.ibm.com>
 <20260707234047.2499921-1-zycai@linux.ibm.com>
 <20260707234047.2499921-5-zycai@linux.ibm.com>
Content-Language: en-US
From: Collin Walling <walling@linux.ibm.com>
In-Reply-To: <20260707234047.2499921-5-zycai@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Q/XiJY2a c=1 sm=1 tr=0 ts=6a5157df cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=8___NipYdFz1lqdmwR0A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: h5PNSUf7Vy0C3Bi5kPOF4KiIOQ9DsdPs
X-Proofpoint-ORIG-GUID: h5PNSUf7Vy0C3Bi5kPOF4KiIOQ9DsdPs
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDIwNCBTYWx0ZWRfXzMo1I1if8JoS
 3/N7CWqhNs8IE+YPs6xvy9mxXdWRi1nC0K1ztj7oklccI4NrjdNkNnqi+0bex+Ze2ssrjntMDe8
 uMCDtIft/O6ZPUlwdsoyMBcovF4tbUM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDIwNCBTYWx0ZWRfX/6Ipp3rrbCsJ
 MIVfro/7iKCMCHeGJUGVpB5GjA4MqM/ZJSD3NbIwLdRmulpPegdnFLtJEkJ7mpfrEZIF4sq++0t
 XcfnXV2LxHuNWKr5AByuyLTr/Ub69VqUVCxL0ouN3Jxa8ooklldW8XMb7ixaBIa143affnyZmzh
 w5GELryHDSYwnoI3sOKOf49DF1frtOJeYrWgK8cpnJM7yMUfAm8n1Pg1xest0HhjqLXOOdonYte
 LU0uJxZCmMg2ZndkACZoxbveAxQafkszk6tQx1Xxf0da8XaZdCM5s/hnxlirEODAzP2BmnHg/OQ
 BUt09ZwO2glR3vzMd7yCldVsjWBGcLNvbVZ78Wt20ZGgaEjj8E39R1gCtwQ/YaRPlMfAVTeUoAx
 81XrSH3sKr6XV9u5YGQg83F181niA9+QjjM5HPR46RlFYlG4J1sSjztd7f58m6IT0rJ/l00J99K
 nwDzHp2nyPCNUvirqpQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_06,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 spamscore=0 phishscore=0 priorityscore=1501
 bulkscore=0 clxscore=1015 lowpriorityscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607100204
Received-SPF: pass client-ip=148.163.158.5; envelope-from=walling@linux.ibm.com;
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

On 7/7/26 19:40, Zhuoying Cai wrote:
> Add address range tracking and overlap checks to ensure that no
> component overlaps with a signed component during secure IPL.
> 
> Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
> Reviewed-by: Jared Rossi <jrossi@linux.ibm.com>
> Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
> ---
>  pc-bios/s390-ccw/secure-ipl.c | 19 +++++++++++++++++++
>  pc-bios/s390-ccw/secure-ipl.h | 10 ++++++++++
>  2 files changed, 29 insertions(+)
> 
> diff --git a/pc-bios/s390-ccw/secure-ipl.c b/pc-bios/s390-ccw/secure-ipl.c
> index 1ab41e5543..cd2d18bfa0 100644
> --- a/pc-bios/s390-ccw/secure-ipl.c
> +++ b/pc-bios/s390-ccw/secure-ipl.c
> @@ -193,6 +193,23 @@ static void init_lists(IplDeviceComponentList *comp_list,
>      cert_list->ipl_info_header.len = sizeof(IplInfoBlockHeader);
>  }
>  
Reviewed-by: Collin Walling <walling@linux.ibm.com>

-- 
Regards,
  Collin

