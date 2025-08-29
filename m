Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2817BCA0FFF
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 15:50:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usNE0-0003a1-Nq; Sat, 30 Aug 2025 11:10:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gautam@linux.ibm.com>)
 id 1urvuw-0001NF-2c; Fri, 29 Aug 2025 06:01:10 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gautam@linux.ibm.com>)
 id 1urvut-0004rk-F4; Fri, 29 Aug 2025 06:01:09 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57T8HVK4003441;
 Fri, 29 Aug 2025 10:00:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=pp1; bh=iOF4ZZisFqskEA3NhKyBz2eFj9wYRB
 nzDClvzpNFheI=; b=rU6iI9oySfYmModQGKxTy3NveFkjc4gEOXc2Wkyx4LDrph
 7VNJqsXG4FFbgaKMw5xvQIvnUmfYx0ak8gOf5+j0tjK/CXnDn1aer7tW48Ugoaay
 eEdvLk4mnUoZ3OLu34G9QL+wq2nbtq6kyQze7iuMges5wC2j/w2wi1EI/cGgnRB4
 ZTxFgESh3VEmKJPaoJ8q+1xha5RC0ckdc6tnETOVUAHrgI+1RWZOfsKJZMjlDM/a
 cHNCrZu8MCPlYxa4tgS3d6DnyHnrrSx44SeyuF13MwyiOK4sJ7ew3GLcCwU+lQNk
 /EzV+AE7h9bHEi5kxJURL6Z5FkJHXUxifO2Gcgpw==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48q558f2h0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 29 Aug 2025 10:00:43 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 57T7rgkl029982;
 Fri, 29 Aug 2025 10:00:42 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 48qsfn1645-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 29 Aug 2025 10:00:41 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 57TA0bS833882488
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 29 Aug 2025 10:00:37 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C975520040;
 Fri, 29 Aug 2025 10:00:37 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C357320043;
 Fri, 29 Aug 2025 10:00:36 +0000 (GMT)
Received: from li-c6426e4c-27cf-11b2-a85c-95d65bc0de0e.ibm.com (unknown
 [9.98.110.17]) by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Fri, 29 Aug 2025 10:00:36 +0000 (GMT)
Date: Fri, 29 Aug 2025 15:30:33 +0530
From: Gautam Menghani <gautam@linux.ibm.com>
To: Aditya Gupta <adityag@linux.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org
Subject: Re: [PATCH] docs: fix typo in xive doc
Message-ID: <aLF6QdzfAEGySiLH@li-c6426e4c-27cf-11b2-a85c-95d65bc0de0e.ibm.com>
References: <20250827053228.519707-1-adityag@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250827053228.519707-1-adityag@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: t74zNPtzzb_5wPmIbYbdoAQHNjv-xYHB
X-Proofpoint-ORIG-GUID: t74zNPtzzb_5wPmIbYbdoAQHNjv-xYHB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDAyMSBTYWx0ZWRfX4gTHW0XBpJA7
 9b1Ow+mjOw1e4zywc7xYm+uB3yC+nXM3HK9MMg12Hm+CB3oBQ7GUEUzVUewUld8O8Hmjzfs6m/G
 w7whujGxZzATE8sSo7gfdG6Tha0ULhQYwSe+d/A0uJISGehXhpi9B9s+pbJjZ0hqcc3/+HQX4Pk
 DUgYJQmaoWuNM3z0+ibvTt7KtEmHIPZQqUbpPtdT5TH++mPN+BgYgXlK2UV8nQzEcLgJspftynE
 cPk2rD9N50uxKf6XAs0U9s6m8WJv8WcmG5c+xHixP/OVaLp5EY1Uovi5X6qs9hPAKw0beIHyyWx
 UVYitPQlsefBFlAo6/oHKE6MPYhD8r60YdyoFM1VtgFngJvH93/17tDZ6JZTk7IJBMfQBKNWfh7
 R/OAoY4q
X-Authority-Analysis: v=2.4 cv=A8ZsP7WG c=1 sm=1 tr=0 ts=68b17a4b cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=kj9zAlcOel0A:10 a=2OwXVqhp2XgA:10 a=VnNF1IyMAAAA:8 a=04G3KJoz7ZlbNnLg_G4A:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-29_03,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 priorityscore=1501 suspectscore=0 clxscore=1015
 spamscore=0 impostorscore=0 malwarescore=0 bulkscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508230021
Received-SPF: pass client-ip=148.163.156.1; envelope-from=gautam@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, Aug 27, 2025 at 11:02:28AM +0530, Aditya Gupta wrote:
> "Interrupt Pending Buffer" IPB, which got written as IBP due to typo.
> 
> The "IPB" register is also mentioned in same doc multiple times.
> 
> Signed-off-by: Aditya Gupta <adityag@linux.ibm.com>
> ---
>  docs/specs/ppc-xive.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/docs/specs/ppc-xive.rst b/docs/specs/ppc-xive.rst
> index 83d43f658b90..968cc760d466 100644
> --- a/docs/specs/ppc-xive.rst
> +++ b/docs/specs/ppc-xive.rst
> @@ -157,7 +157,7 @@ Interrupt flow from an O/S perspective
>  
>  After an event data has been enqueued in the O/S Event Queue, the IVPE
>  raises the bit corresponding to the priority of the pending interrupt
> -in the register IBP (Interrupt Pending Buffer) to indicate that an
> +in the register IPB (Interrupt Pending Buffer) to indicate that an
>  event is pending in one of the 8 priority queues. The Pending
>  Interrupt Priority Register (PIPR) is also updated using the IPB. This
>  register represent the priority of the most favored pending

Reviewed-by: Gautam Menghani <gautam@linux.ibm.com>

> -- 
> 2.50.1
> 

