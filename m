Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B200EC47DDB
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jan 2024 15:07:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUTDd-0002DW-LX; Mon, 29 Jan 2024 10:06:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1rUTDb-0002DA-Lf
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 10:06:39 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1rUTDZ-0004Ty-Ob
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 10:06:39 -0500
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 40TEm01w025832; Mon, 29 Jan 2024 15:06:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=date : from : to :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=hhcVkusQOV6RPQmCbzs1glPX7UMtQGm9pTpZljWbZoM=;
 b=ZcCQwd5b3PvKXp+KR1Vq2M2TiUJt/U09XfLe4njniJcR8ucFygA9b0MRNdP2TMsdZN4N
 4LrDw4Dqh9EunfrszeSRhaxKV/6x9QWhdt4DcYcj3C6WLdHSf3H9B1FkUCsuwBidEmij
 6QBrx8YBZlSAgdAf55P9vM0uJkCCstaVAN4jb1RIfoYGD6bDSTrPRz3OjMYyjQJLC9bz
 XALR03IWrToPwORHXDkba2zj45K8k3NxIRDCGR0UZnNhorUrtJpRtmEJB1Y6HokHL0K0
 /h5NBPCIrLGsvnNDb0WZW9z6snlWPsObUgUVQ/GW1T0YX6XBmYqT6vxKClaM7kOcP6t7 Ww== 
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vxe3drn15-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 29 Jan 2024 15:06:34 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 40TDscTN002230; Mon, 29 Jan 2024 15:06:33 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3vwc5t1633-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 29 Jan 2024 15:06:33 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 40TF6WZ427656826
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 29 Jan 2024 15:06:32 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 13E5920040;
 Mon, 29 Jan 2024 15:06:32 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id F26062004B;
 Mon, 29 Jan 2024 15:06:31 +0000 (GMT)
Received: from heavy (unknown [9.155.200.166])
 by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Mon, 29 Jan 2024 15:06:31 +0000 (GMT)
Date: Mon, 29 Jan 2024 16:06:30 +0100
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Subject: Re: [PATCH v3 20/33] linux-user: Do early mmap placement only for
 reserved_va
Message-ID: <nncoextydgx42xejqhmpeok2r5s4jbdqcea7zeeznutlg3uxwx@b5knv7cqhv5b>
References: <20240102015808.132373-1-richard.henderson@linaro.org>
 <20240102015808.132373-21-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240102015808.132373-21-richard.henderson@linaro.org>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: hElVnzxKl5m8Fe2GjRqsmc5fQzEuEvy1
X-Proofpoint-ORIG-GUID: hElVnzxKl5m8Fe2GjRqsmc5fQzEuEvy1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-29_09,2024-01-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015
 lowpriorityscore=0 malwarescore=0 mlxlogscore=999 suspectscore=0
 priorityscore=1501 impostorscore=0 phishscore=0 adultscore=0 mlxscore=0
 spamscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401290111
Received-SPF: pass client-ip=148.163.156.1; envelope-from=iii@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Tue, Jan 02, 2024 at 12:57:55PM +1100, Richard Henderson wrote:
> For reserved_va, place all non-fixed maps then proceed
> as for MAP_FIXED.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  linux-user/mmap.c | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/linux-user/mmap.c b/linux-user/mmap.c
> index cc983bedbd..42eb3eb2b4 100644
> --- a/linux-user/mmap.c
> +++ b/linux-user/mmap.c
> @@ -540,17 +540,19 @@ static abi_long target_mmap__locked(abi_ulong start, abi_ulong len,
>      host_offset = offset & -host_page_size;
>  
>      /*
> -     * If the user is asking for the kernel to find a location, do that
> -     * before we truncate the length for mapping files below.
> +     * For reserved_va, we are in full control of the allocation.
> +     * Find a suitible hole and convert to MAP_FIXED.

suitable?

[...]

Reviewed-by: Ilya Leoshkevich <iii@linux.ibm.com>

