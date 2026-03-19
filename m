Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E4B11090222
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2026 13:23:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3DKv-00089y-Dv; Thu, 19 Mar 2026 09:22:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1w3DKt-00089U-W6; Thu, 19 Mar 2026 09:22:52 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1w3DKs-0006Zj-57; Thu, 19 Mar 2026 09:22:51 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62ILEOhJ853168; Thu, 19 Mar 2026 13:22:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=6A3AWm
 eoEDdzAQ9Om3+Pg0TIf0Z9yKRuBicJJ/Ldk6w=; b=h5UlpCAimaW4dH5qlHmk/Z
 vKgWhNu5JSQ/LrZ2r7q2OWZVJlAF434TY0ggS0Ym24QpD6W76jidxZJpFL9Gzn5E
 5XZ2XWmBfd0J5jySzVDWaMsQbsTJi7wZfZ6UaR+6sC8hlLiQ9CX81i/nC6RtlYCO
 nXd5tGH2PTEX54QouWKmCYDmnBkZI8DgQ42m7A6WBoibAqBnF4pou1N2qjX7aYpB
 ijtYDrGhrk6ox/bbpe1EF7f4l2Q+C7LwtzNFD9L3/MuARRozvOU1aOWdYgIgtiKe
 sdnecY2n5YI96ZrCP1oFv18q2V/vhAGnVbe/eBxHYlWX6OCUuBP8eheUaD/16x4Q
 ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cvyaupa4m-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 19 Mar 2026 13:22:46 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62J9VD2i028765;
 Thu, 19 Mar 2026 13:22:45 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4cwkgkjjyv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 19 Mar 2026 13:22:45 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com
 [10.39.53.232])
 by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 62JDMimK12321284
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 19 Mar 2026 13:22:44 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9BD9758059;
 Thu, 19 Mar 2026 13:22:44 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E7F8958043;
 Thu, 19 Mar 2026 13:22:43 +0000 (GMT)
Received: from [9.61.145.197] (unknown [9.61.145.197])
 by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 19 Mar 2026 13:22:43 +0000 (GMT)
Message-ID: <5e8e66d5-e4e8-4257-883f-8e2f95474972@linux.ibm.com>
Date: Thu, 19 Mar 2026 09:22:43 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: S390 CPU topology: Change maintainer
To: Gautam Gala <ggala@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org
Cc: Nina Schoetterl-Glausch <nsg@linux.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>, Eric Farman <farman@linux.ibm.com>
References: <20260319094835.80329-1-ggala@linux.ibm.com>
Content-Language: en-US
From: Matthew Rosato <mjrosato@linux.ibm.com>
In-Reply-To: <20260319094835.80329-1-ggala@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE5MDEwNSBTYWx0ZWRfX8XQAWA8wP9JI
 gPMkOk+nVuH08wKwP81tWb8S3rQxLQJxBmvsxtU70FJD/1h9qzHp8P7sBGRAOofwe5CsTHzpQDB
 ywAR17wHIEUEWFCjfEzXkxOlWIgHbw+pcM/qvESi/aC5kTs8Q1MU5H2AO1z+RFxBQ0f1qt9Jl2F
 ka1n16Q/472cTgKwxJdFlw1nRF32pdf9dD7TvX5LFSZMGa9W5lbR118TEDii5qPPHAqfbv3I3Y6
 tPQEz4EU+9liuoB4s554T5s+BjPM3j204rdDDCZfPENCweh9XU0LTtT9zq4Yi0cZzZs4Xij3lf/
 cSbYuZ6JVNMawDvFSiN1/kSkGeZbKeJrAvAXdc7JuOa8ccQ2SdfauFna9M+b0s8rg0RzrRQGLMv
 D9xHsFsDU7Gz24UvS2+wglnUeXVtClh0j8z0H7gMUuPV00EJgpdzRB/CQvlV4kKAE6z28eLsQZK
 tFmpbRmkDpATkVe5WyA==
X-Authority-Analysis: v=2.4 cv=GIQF0+NK c=1 sm=1 tr=0 ts=69bbf8a6 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=69wJf7TsAAAA:8 a=vDfXbEq_FW8YIDqasRAA:9 a=QEXdDO2ut3YA:10
 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-ORIG-GUID: i0e9gj_BSJkPe5KxmO-GyKGqUac319YY
X-Proofpoint-GUID: i0e9gj_BSJkPe5KxmO-GyKGqUac319YY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-19_01,2026-03-19_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 bulkscore=0 lowpriorityscore=0 malwarescore=0
 phishscore=0 impostorscore=0 suspectscore=0 adultscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603190105
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=mjrosato@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -9
X-Spam_score: -1.0
X-Spam_bar: -
X-Spam_report: (-1.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 3/19/26 5:48 AM, Gautam Gala wrote:
> Replace Nina with me as the maintainer for s390 CPU topology.
> 
> Signed-off-by: Gautam Gala <ggala@linux.ibm.com>


Thanks for taking this on, Gautam!

And Nina, thanks alot for the work you did in this area!

Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>

> ---
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 97f2759138..f977a41757 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1916,7 +1916,7 @@ F: hw/s390x/sclp*.c
>  L: qemu-s390x@nongnu.org
>  
>  S390 CPU topology
> -M: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
> +M: Gautam Gala <ggala@linux.ibm.com>
>  S: Supported
>  F: include/hw/s390x/cpu-topology.h
>  F: hw/s390x/cpu-topology.c


