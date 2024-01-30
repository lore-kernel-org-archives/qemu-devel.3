Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E848AC46CD2
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jan 2024 10:45:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUlcd-0001K9-Do; Tue, 30 Jan 2024 05:45:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1rUlcT-0001GW-Fd
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 05:45:36 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1rUlcQ-0003er-2K
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 05:45:33 -0500
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 40UAWRWK020695; Tue, 30 Jan 2024 10:45:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=date : from : to :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=bvHAlCmedgGVxsHt0SwF+YGRCHFiwIaHP2nmCV6LO/g=;
 b=TVyezHWnhnc9aOr+8VlcQzWhlVKS936tcRsGeRzXwM9ohEFcwnGXgbzwfYkNTrcWkG2K
 BQEta0PPL/gvjtUQiEjKbwKPd5gmBiqu8odJwhzA8Ib1itdaXIN+zFet5nLJ92wl4AOP
 PPV1mKce7d07XoTEhDwmXClJSnO0TCsXoBsEsBdtL9tC1zsli2+E6yW3ZWm/AeAmQ36m
 9fCdkQlE5+SVpgR/uXVi4vvCEgNmtEto7zLIkSrP7lZNe38yZsZu9Jnce8sHjW5HHuvS
 SHBEkV+DMKQ1LZbX6v9iEXu7foAdWQrpHdBgwjsFqukkClTvHzXcbYj1o22R0j/bbL5C LQ== 
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vxyep8bhn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 30 Jan 2024 10:45:25 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 40UAWDcT008234; Tue, 30 Jan 2024 10:45:24 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3vwdnkx2w8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 30 Jan 2024 10:45:24 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 40UAjMrL19661436
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 30 Jan 2024 10:45:22 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 89E782004B;
 Tue, 30 Jan 2024 10:45:22 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4E66B20043;
 Tue, 30 Jan 2024 10:45:22 +0000 (GMT)
Received: from heavy (unknown [9.171.1.43])
 by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Tue, 30 Jan 2024 10:45:22 +0000 (GMT)
Date: Tue, 30 Jan 2024 11:45:20 +0100
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Subject: Re: [PATCH v3 23/33] linux-user: Split out mmap_h_gt_g
Message-ID: <bc3nw6nyaetyp5hyw4rkfdmdhj76fx3sm4xxr47xe2vb2fq2ca@kahrovvcvtuw>
References: <20240102015808.132373-1-richard.henderson@linaro.org>
 <20240102015808.132373-24-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240102015808.132373-24-richard.henderson@linaro.org>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 4VkoB5CJ2puW6-mt0G8iODDZoAQlTBy1
X-Proofpoint-GUID: 4VkoB5CJ2puW6-mt0G8iODDZoAQlTBy1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-30_05,2024-01-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 lowpriorityscore=0 phishscore=0 adultscore=0 suspectscore=0
 spamscore=0 impostorscore=0 mlxlogscore=625 clxscore=1015 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401300078
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

On Tue, Jan 02, 2024 at 12:57:58PM +1100, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  linux-user/mmap.c | 288 ++++++++++++++++++++++------------------------
>  1 file changed, 139 insertions(+), 149 deletions(-)
> 
> diff --git a/linux-user/mmap.c b/linux-user/mmap.c
> index 8b0a26e50d..552656edd4 100644
> --- a/linux-user/mmap.c
> +++ b/linux-user/mmap.c

[...]

> +    if (last < real_last) {
> +        abi_ulong real_page_start = real_last - host_page_size + 1;
> +        if (!mmap_frag(real_page_start, real_page_start, last,
> +                       target_prot, flags, fd,
> +                       offset + real_page_start - start)) {

Should we unmap start here and in a few places below?

[...]

