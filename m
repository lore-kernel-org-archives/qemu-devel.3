Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A5C5D3ABFA
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Nov 2024 22:04:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tAcVh-0005cQ-HU; Mon, 11 Nov 2024 17:03:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1tAcVf-0005bw-Gf; Mon, 11 Nov 2024 17:03:47 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1tAcVd-00043R-PQ; Mon, 11 Nov 2024 17:03:47 -0500
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4ABGUMWj001201;
 Mon, 11 Nov 2024 22:03:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:reply-to:subject:to; s=pp1;
 bh=FGLvFxf7dWIRqa4WLxHSPZ7ctjgl68IqEVUc3vm1FwI=; b=dBB4sb+LjaK9
 5lcWkwz0++RMxyp7VRH7yoXlJkxFrsMTSIzphWc8tZab3/IlGLRQX2jJAi/6nHKk
 DU8jYATjJPdR/dL+aR5aQqcVW9I57/JP5wgASf/M63Eunjtt34wN8SFrxIz6eq3g
 EmEZ1veqcI5ufa8uyQdbU+H9pJwv9ReTS99rg+aIgzne5H6k/2VVYCw6Fbwzsb4P
 BYPylLEbE/ZNoTqcXt7Jl8R2dLvEwfNiTKZyWS7EB3/hC5N11GYzPoKgMtb5cfwC
 Pihn09ZQZVDw+TAcc/MU/KnRJrFdaUVE/6cGBp3A+brqqCbo6S5QVcznac6USCQ5
 r6ED8QZbdg==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42un6y9bgh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 11 Nov 2024 22:03:27 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4ABM3Qru003934;
 Mon, 11 Nov 2024 22:03:26 GMT
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42un6y9bgc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 11 Nov 2024 22:03:26 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4ABICE9Q007703;
 Mon, 11 Nov 2024 22:03:25 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 42tm9jaxbe-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 11 Nov 2024 22:03:25 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com
 [10.241.53.103])
 by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 4ABM3PBx47448570
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 11 Nov 2024 22:03:25 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4353A58062;
 Mon, 11 Nov 2024 22:03:25 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DDE1558052;
 Mon, 11 Nov 2024 22:03:24 +0000 (GMT)
Received: from mambor8.rchland.ibm.com (unknown [9.10.239.198])
 by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 11 Nov 2024 22:03:24 +0000 (GMT)
Message-ID: <325521ab9fcfc132a08081f5d5686d336ffc5bc7.camel@linux.ibm.com>
Subject: Re: [PATCH 1/6] bitops.h: add deposit16 function
From: Miles Glenn <milesg@linux.ibm.com>
To: Titus Rwantare <titusr@google.com>, peter.maydell@linaro.org,
 minyard@acm.org, clg@redhat.com
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, philmd@linaro.org,
 venture@google.com, wuhaotsh@google.com, milesg@linux.ibm.com
Date: Mon, 11 Nov 2024 16:03:24 -0600
In-Reply-To: <20241107195453.2684138-2-titusr@google.com>
References: <20241107195453.2684138-1-titusr@google.com>
 <20241107195453.2684138-2-titusr@google.com>
Organization: IBM
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-22.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: puR_PUB8XIS15eBqAdg6rZW-Az-KiqWu
X-Proofpoint-GUID: 0-AWGSjFau0eQDMlUKVh_rqcVaJCcf4P
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 spamscore=0 phishscore=0 suspectscore=0 adultscore=0 malwarescore=0
 bulkscore=0 impostorscore=0 clxscore=1011 mlxlogscore=650
 priorityscore=1501 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2409260000 definitions=main-2411110173
Received-SPF: pass client-ip=148.163.156.1; envelope-from=milesg@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Reply-To: milesg@linux.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Reviewed-by: Glenn Miles <milesg@linux.ibm.com>

On Thu, 2024-11-07 at 19:54 +0000, Titus Rwantare wrote:
> Makes it more explicit that 16 bit values are being used
> 
> Signed-off-by: Titus Rwantare <titusr@google.com>
> ---
>  include/qemu/bitops.h | 26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
> 
> diff --git a/include/qemu/bitops.h b/include/qemu/bitops.h
> index 2c0a2fe751..05179e3ded 100644
> --- a/include/qemu/bitops.h
> +++ b/include/qemu/bitops.h
> @@ -459,6 +459,32 @@ static inline int64_t sextract64(uint64_t value,
> int start, int length)
>      return ((int64_t)(value << (64 - length - start))) >> (64 -
> length);
>  }
> 
> +/**
> + * deposit16:
> + * @value: initial value to insert bit field into
> + * @start: the lowest bit in the bit field (numbered from 0)
> + * @length: the length of the bit field
> + * @fieldval: the value to insert into the bit field
> + *
> + * Deposit @fieldval into the 16 bit @value at the bit field
> specified
> + * by the @start and @length parameters, and return the modified
> + * @value. Bits of @value outside the bit field are not modified.
> + * Bits of @fieldval above the least significant @length bits are
> + * ignored. The bit field must lie entirely within the 16 bit word.
> + * It is valid to request that all 16 bits are modified (ie @length
> + * 16 and @start 0).
> + *
> + * Returns: the modified @value.
> + */
> +static inline uint16_t deposit16(uint16_t value, int start, int
> length,
> +                                 uint16_t fieldval)
> +{
> +    uint16_t mask;
> +    assert(start >= 0 && length > 0 && length <= 16 - start);
> +    mask = (~0U >> (16 - length)) << start;
> +    return (value & ~mask) | ((fieldval << start) & mask);
> +}
> +
>  /**
>   * deposit32:
>   * @value: initial value to insert bit field into


