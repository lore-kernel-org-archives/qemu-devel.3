Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44F4AC47DB3
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jan 2024 14:53:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUT0R-0004KN-3h; Mon, 29 Jan 2024 09:53:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1rUT0H-00048o-G5
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 09:52:55 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1rUT0F-0001jQ-LG
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 09:52:53 -0500
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 40TEkmwg029312; Mon, 29 Jan 2024 14:52:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 content-transfer-encoding : in-reply-to; s=pp1;
 bh=xN2IgVg9pFwumyp7dr9eYrXgOXRbT/gf0UNUQz6ivk0=;
 b=c1CxEBrR8wsLWP0VC42rz3Lixxlt92uvZ+56m31IjpKO3oPM9CT1ainUIi05ST00Zw5g
 pPtnNqNBU9Sgn+/nksLyPbM95GoSY5cn2kjzUr8VM3Wp4OSybrJX95LETjh0NLetM/LX
 grB/faYiorvm95iU55uU3voNoiX5wbs7CqKkgoj6Ue3+/NXsG4/4fm5M8e90hbq3btHz
 XIzwkt2lv/tjkT0Ek74Y8JNTtb9A5FVfsoiYH80v6vC1PTRikddfJU9wImF528+r5BCY
 IegcWZe13+nS3ZQnsiqtbacg1z88dzRYyYPV/vj5s5L0E6V7E6WR0ClxQQvL1KlOdox3 XA== 
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vxe34g7f1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 29 Jan 2024 14:52:49 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 40TDabNP002319; Mon, 29 Jan 2024 14:52:48 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3vwc5t13gr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 29 Jan 2024 14:52:48 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 40TEqkXT35520804
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 29 Jan 2024 14:52:46 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 91F392004B;
 Mon, 29 Jan 2024 14:52:46 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 79A3020043;
 Mon, 29 Jan 2024 14:52:46 +0000 (GMT)
Received: from heavy (unknown [9.155.200.166])
 by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Mon, 29 Jan 2024 14:52:46 +0000 (GMT)
Date: Mon, 29 Jan 2024 15:52:45 +0100
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH v3 17/33] linux-user: Move some mmap checks outside the
 lock
Message-ID: <att66ghmazgiuhxlcj6p4534fuhvx3otey3nsd3nfjbuhtoikn@rqdkeon4tots>
References: <20240102015808.132373-1-richard.henderson@linaro.org>
 <20240102015808.132373-18-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240102015808.132373-18-richard.henderson@linaro.org>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 05LoS8JGeT9RpAO-vcDKSnL8FmmFJ3g5
X-Proofpoint-ORIG-GUID: 05LoS8JGeT9RpAO-vcDKSnL8FmmFJ3g5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-29_09,2024-01-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 mlxlogscore=793 mlxscore=0 malwarescore=0 phishscore=0 impostorscore=0
 suspectscore=0 adultscore=0 lowpriorityscore=0 bulkscore=0 spamscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401290108
Received-SPF: pass client-ip=148.163.158.5; envelope-from=iii@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
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

On Tue, Jan 02, 2024 at 12:57:52PM +1100, Richard Henderson wrote:
> Basic validation of operands does not require the lock.
> Hoist them from target_mmap__locked back into target_mmap.
> 
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  linux-user/mmap.c | 107 +++++++++++++++++++++++-----------------------
>  1 file changed, 53 insertions(+), 54 deletions(-)
> 
> diff --git a/linux-user/mmap.c b/linux-user/mmap.c
> index b4c3cc65aa..fbaea832c5 100644
> --- a/linux-user/mmap.c
> +++ b/linux-user/mmap.c

[...]

> @@ -778,13 +726,64 @@ abi_long target_mmap(abi_ulong start, abi_ulong len, int target_prot,
>                       int flags, int fd, off_t offset)
>  {
>      abi_long ret;
> +    int page_flags;
>  
>      trace_target_mmap(start, len, target_prot, flags, fd, offset);
> +
> +    if (!len) {
> +        errno = EINVAL;
> +        return -1;
> +    }
> +
> +    page_flags = validate_prot_to_pageflags(target_prot);
> +    if (!page_flags) {
> +        errno = EINVAL;
> +        return -1;
> +    }
> +
> +    /* Also check for overflows... */
> +    len = TARGET_PAGE_ALIGN(len);
> +    if (!len || len != (size_t)len) {
> +        errno = ENOMEM;
> +        return -1;
> +    }

The overflow fix is probably worth mentioning in the commit message (or
even deserves a separate commit, for backporting into stable).
Regardless:

Reviewed-by: Ilya Leoshkevich <iii@linux.ibm.com>

