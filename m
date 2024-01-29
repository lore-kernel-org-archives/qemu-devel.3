Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82931C47422
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jan 2024 10:16:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUOg9-00027S-Ry; Mon, 29 Jan 2024 05:15:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1rUOg3-00026g-VZ
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 05:15:45 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1rUOg2-000123-5I
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 05:15:43 -0500
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 40T9QGSK019532; Mon, 29 Jan 2024 10:15:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=date : from : to :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=blqwHjuaKevzFGVXvqt5Qx18STiTh1F8n4o5EdSG2Hw=;
 b=oTPoSoa6gp0w8oCg6lNU3KUISTzE5DOFpjeJTKJ02zlqHyEW8JTCozPBh/bOp8FPKbD+
 uEK4i+tLrKkmiLpF5jz3P9vSIr47k2dr65E5p3+kkf1LWzLYHOLLxWMWLWeIWZpkZeIx
 BN9dxVmX/JAWhV87IjN7dhH0nQ/0lZiptG9+aRjr4hOmD2sUipXcc1SZ0bqZU2wUyzX/
 PG5ldRxi2xYzBCYlvRZO9T29IthTcWCdl42j8NdSjS81fMG1Cetpk5DEVRjjMwdvui7u
 KnG73w6c01ekMpZfvO4kjVBL/D2utL0OoS0ZCCeJxnSJ/FaZNY3j0HIa6I4Tzev6xq1O Fw== 
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vx9cfs0g8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 29 Jan 2024 10:15:38 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 40T7ZQXw017723; Mon, 29 Jan 2024 10:15:35 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3vwchyfqqf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 29 Jan 2024 10:15:35 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 40TAFXLi40239360
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 29 Jan 2024 10:15:33 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C181C2004D;
 Mon, 29 Jan 2024 10:15:33 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 866442004B;
 Mon, 29 Jan 2024 10:15:33 +0000 (GMT)
Received: from heavy (unknown [9.179.7.240])
 by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Mon, 29 Jan 2024 10:15:33 +0000 (GMT)
Date: Mon, 29 Jan 2024 11:15:32 +0100
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Subject: Re: [PATCH v3 03/33] linux-user: Remove qemu_host_page_{size, mask}
 in probe_guest_base
Message-ID: <ccoaue53ghkurof6znivxn3vilwe6nqug22fnb6tjwff3ditt3@gvvv5yftou5g>
References: <20240102015808.132373-1-richard.henderson@linaro.org>
 <20240102015808.132373-4-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240102015808.132373-4-richard.henderson@linaro.org>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: xJTBJ2ztJFObsdgWMRjlUsYvzF49M7In
X-Proofpoint-GUID: xJTBJ2ztJFObsdgWMRjlUsYvzF49M7In
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-29_06,2024-01-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 mlxlogscore=999
 clxscore=1015 bulkscore=0 lowpriorityscore=0 spamscore=0 impostorscore=0
 mlxscore=0 malwarescore=0 priorityscore=1501 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2401290073
Received-SPF: pass client-ip=148.163.156.1; envelope-from=iii@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H4=-0.01,
 RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Tue, Jan 02, 2024 at 12:57:38PM +1100, Richard Henderson wrote:
> The host SHMLBA is by definition a multiple of the host page size.
> Thus the remaining component of qemu_host_page_size is the
> target page size.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  linux-user/elfload.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/linux-user/elfload.c b/linux-user/elfload.c
> index f3c1e0fb64..4df565d64b 100644
> --- a/linux-user/elfload.c
> +++ b/linux-user/elfload.c
> @@ -2892,7 +2892,7 @@ static bool pgb_addr_set(PGBAddrs *ga, abi_ulong guest_loaddr,
>  
>      /* Add any HI_COMMPAGE not covered by reserved_va. */
>      if (reserved_va < HI_COMMPAGE) {
> -        ga->bounds[n][0] = HI_COMMPAGE & qemu_host_page_mask;
> +        ga->bounds[n][0] = HI_COMMPAGE & -qemu_real_host_page_size();

Nit: qemu_real_host_page_mask() might be a bit more readable.

>          ga->bounds[n][1] = HI_COMMPAGE + TARGET_PAGE_SIZE - 1;
>          n++;
>      }
> @@ -3074,7 +3074,7 @@ void probe_guest_base(const char *image_name, abi_ulong guest_loaddr,
>                        abi_ulong guest_hiaddr)
>  {
>      /* In order to use host shmat, we must be able to honor SHMLBA.  */
> -    uintptr_t align = MAX(SHMLBA, qemu_host_page_size);
> +    uintptr_t align = MAX(SHMLBA, TARGET_PAGE_SIZE);
>  
>      /* Sanity check the guest binary. */
>      if (reserved_va) {
> -- 
> 2.34.1

Reviewed-by: Ilya Leoshkevich <iii@linux.ibm.com>

