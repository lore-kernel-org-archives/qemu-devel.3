Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85592CD4F54
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2026 18:53:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSfqI-0005iK-Pc; Thu, 28 May 2026 14:52:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <walling@linux.ibm.com>)
 id 1wSfph-0005VX-4O; Thu, 28 May 2026 14:51:57 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <walling@linux.ibm.com>)
 id 1wSfpd-0003yq-1G; Thu, 28 May 2026 14:51:51 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64SCA3bL2692375; Thu, 28 May 2026 18:51:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=hqH3Th
 xfaAIDgyOqWkc/8895pavzJdRsMxDWv1HwpxY=; b=CihJdhQ6DNwMRv/soUdodc
 8vZ0gF4PJe6dMro1pCR1/SfvWs0jbcCU/3teRtYMfxkAlZzvUDNr6Rv+w+ALbYo1
 HWoAvbip/J2kTnz1k6rEVLqAPRnAlpoP/5bNLhD7VuvVRaKxdK1nl54SlbztYP8M
 oulFnB2c1Pb7qLlbMwadUUhh8sBVD5XJxFQZQ/1+F7f87EuvlLUkDg4a4BL8FCbG
 I1O7008uWhoaO8PaB2qswOxpCFU9Ar7xEahhN9zsSjcXLRRV0PhICiyV3hpQNQBK
 qWfJew+M8eWpGu6PKNC+vpLfkzf347AMCBvGQYmOi5i6IfWoFHHtT2SedKoqIL7A
 ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ee884cq64-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 28 May 2026 18:51:42 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64SId54D012675;
 Thu, 28 May 2026 18:51:41 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4edjrb9juk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 28 May 2026 18:51:41 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com
 [10.241.53.100])
 by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 64SIpdpZ2884482
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 28 May 2026 18:51:39 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8E5CB58059;
 Thu, 28 May 2026 18:51:39 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8499E58057;
 Thu, 28 May 2026 18:51:38 +0000 (GMT)
Received: from [9.12.68.85] (unknown [9.12.68.85])
 by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTPS;
 Thu, 28 May 2026 18:51:38 +0000 (GMT)
Message-ID: <b288fe32-664b-420e-a011-b6a1df6ae9b4@linux.ibm.com>
Date: Thu, 28 May 2026 14:51:37 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 22/32] pc-bios/s390-ccw: Add signed component address
 overlap checks
To: Zhuoying Cai <zycai@linux.ibm.com>, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org
Cc: jrossi@linux.ibm.com, cohuck@redhat.com, berrange@redhat.com,
 richard.henderson@linaro.org, david@kernel.org, jjherne@linux.ibm.com,
 pasic@linux.ibm.com, borntraeger@linux.ibm.com, farman@linux.ibm.com,
 mjrosato@linux.ibm.com, iii@linux.ibm.com, eblake@redhat.com,
 armbru@redhat.com, alifm@linux.ibm.com, brueckner@linux.ibm.com,
 pierrick.bouvier@oss.qualcomm.com, jdaley@linux.ibm.com
References: <20260505201905.997996-1-zycai@linux.ibm.com>
 <20260505201905.997996-23-zycai@linux.ibm.com>
Content-Language: en-US
From: Collin Walling <walling@linux.ibm.com>
In-Reply-To: <20260505201905.997996-23-zycai@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=fIYJG5ae c=1 sm=1 tr=0 ts=6a188ebe cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=MQLUL_whLfvqxDHUHTUA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: We9okNLh8qO-B1uqjb7rZeQHED14nW8K
X-Proofpoint-GUID: We9okNLh8qO-B1uqjb7rZeQHED14nW8K
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI4MDE4OCBTYWx0ZWRfXweXgnfziesGl
 jbC8kSW6NzMrFrUUowDXYpLmv+a3tPGiJgppWzy8ly8XILFWUQQD9mKaiLvwbtu4ZSMtcHr5tb6
 b1+Di6sC2vFs78BRBU+fnDMCRh05u+UGhur25meKJFPRVXfEhDYZd3imTr1/kD3MjXm/gCVb1fY
 qQI+SjTbYJzwLN/seWkrHB+LhyLoASUzUrv9Rv7TOLauf/n5oQxgoOmhqwDb/01Kc8rd7NGN+4H
 ARPS+Z96MqzLdfRrbcdNi12RG0Z9KNjAGgVaxEzGWKc7DLEhJmU/Cft3rS7yBAbBhPOqV/1L65G
 38AIojdzNNh/2e4MEnVUBHKCEiN/F61BoWe2OQHUSPivKhsC3Gw1haxLdYhZCSl2B6jmhBN4KvF
 gcKvl9sGX7KyOsii3SJHZw4TjRJDpr0+PxVOr5p85pUNVakJo/cf/iVY83BawcI4+NoqzdxtcGk
 RQB/sBt9vSxfK16q4Kw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-28_04,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 suspectscore=0 impostorscore=0
 priorityscore=1501 malwarescore=0 clxscore=1015 adultscore=0 spamscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2605280188
Received-SPF: pass client-ip=148.163.156.1; envelope-from=walling@linux.ibm.com;
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

On 5/5/26 16:18, Zhuoying Cai wrote:

[...]

> +typedef struct SecureIplCompAddrRange {
> +    bool is_signed;
> +    uint64_t start_addr;
> +    uint64_t end_addr;
> +} SecureIplCompAddrRange;
> +
> +/*
> + * Custom struct for managing a list of secure IPL component address ranges.
> + * Tracks up to MAX_COMP_ENTRIES address ranges with an num counter.
> + */
> +typedef struct SecureIplCompAddrRangeList {
> +    SecureIplCompAddrRange comp_addr_range[MAX_COMP_ENTRIES];

What about using a IplDeviceComponentEntry here?  It has an addr (same
as start_addr), length (same as end_addr = start + length), and flags
(can be checked if it's signed).

In fact, couldn't the existing IplDeviceComponentEntry array inside the
IplDeviceComponentList be used?  Then these two data structures aren't
needed.

> +    int num;
> +} SecureIplCompAddrRangeList;
> +

-- 
Regards,
  Collin

