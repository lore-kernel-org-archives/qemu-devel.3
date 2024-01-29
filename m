Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72ACCC47DDB
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jan 2024 15:13:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUTJS-000417-RV; Mon, 29 Jan 2024 10:12:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1rUTJR-00040x-6D
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 10:12:41 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1rUTJO-00068S-Om
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 10:12:40 -0500
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 40TF2IEc007309; Mon, 29 Jan 2024 15:12:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=date : from : to :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=u5peRW+Ttk5hXEgml120vzKHzs0CdlegRpF3+JZyR78=;
 b=pK+h9RcIBRPXGGDbCzU2U6w//T255A3TE7AIXAw77+3sqJW4JMXcG79iz1uQBuhI2MBx
 +6KkpG2L6V7Lg2E5j/nAens+xP5PDTSOBT0t6zNIsmIhZNpbb6jvXf96jo0PwaFWXP5a
 XRkAQddl3Md6xMZyxMwqkknoT+lpZO/jRWNyrIpNSQePlz1zfNwtO/9KUPpjzJRvh/1t
 ZMrz4ck2Qjih6wIcOm7+CpZuBrRWTywU6GXLGomZklou2ooOiLcUJTUGL78OdryHsmdd
 nJXftKCMDJC8dChd1lFuDUSr7vnCgs7rB3IbOY24orD87BTs6io7lGpcBnsWxxokROjG Aw== 
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vxeabg6us-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 29 Jan 2024 15:12:34 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 40TD0WkM011237; Mon, 29 Jan 2024 15:12:30 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3vweck8juf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 29 Jan 2024 15:12:30 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 40TFCT8t38797580
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 29 Jan 2024 15:12:29 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 105B320043;
 Mon, 29 Jan 2024 15:12:29 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 74AF120040;
 Mon, 29 Jan 2024 15:12:28 +0000 (GMT)
Received: from heavy (unknown [9.155.200.166])
 by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Mon, 29 Jan 2024 15:12:28 +0000 (GMT)
Date: Mon, 29 Jan 2024 16:12:27 +0100
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Subject: Re: [PATCH v3 21/33] linux-user: Split out mmap_h_eq_g
Message-ID: <3f75hcwrqjos5mnrm3yknx2c7ae5pvh6bofbpvfsjbxiinrnnq@wmyrvxma4uki>
References: <20240102015808.132373-1-richard.henderson@linaro.org>
 <20240102015808.132373-22-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240102015808.132373-22-richard.henderson@linaro.org>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 5wxq7wU4cOhAW_lCX3lZ1shkaED2gSgs
X-Proofpoint-ORIG-GUID: 5wxq7wU4cOhAW_lCX3lZ1shkaED2gSgs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-29_10,2024-01-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0
 phishscore=0 mlxscore=0 mlxlogscore=611 adultscore=0 bulkscore=0
 lowpriorityscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2311290000 definitions=main-2401290112
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

On Tue, Jan 02, 2024 at 12:57:56PM +1100, Richard Henderson wrote:
> Move the MAX_FIXED_NOREPLACE check for reserved_va earlier.
> Move the computation of host_prot earlier.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  linux-user/mmap.c | 66 +++++++++++++++++++++++++++++++++++++----------
>  1 file changed, 53 insertions(+), 13 deletions(-)
> 
> diff --git a/linux-user/mmap.c b/linux-user/mmap.c
> index 42eb3eb2b4..00003b8329 100644
> --- a/linux-user/mmap.c
> +++ b/linux-user/mmap.c
> @@ -527,6 +527,31 @@ static abi_long mmap_end(abi_ulong start, abi_ulong last,
>      return start;
>  }
>  
> +/*
> + * Special case host page size == target page size,
> + * where there are no edge conditions.
> + */
> +static abi_long mmap_h_eq_g(abi_ulong start, abi_ulong len,
> +                            int host_prot, int flags, int page_flags,
> +                            int fd, off_t offset)
> +{
> +    void *p, *want_p = g2h_untagged(start);
> +    abi_ulong last;
> +
> +    p = mmap(want_p, len, host_prot, flags, fd, offset);
> +    if (p == MAP_FAILED) {
> +        return -1;
> +    }
> +    if ((flags & MAP_FIXED_NOREPLACE) && p != want_p) {

Should we munmap() here?
I've seen this situation in some of the previous patches as well, but
there we were about to exit, and here the program may continue
running.

[...]

