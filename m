Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3061AC47422
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jan 2024 10:04:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUOUZ-0004ZU-9k; Mon, 29 Jan 2024 05:03:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1rUOUX-0004ZG-Li
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 05:03:49 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1rUOUW-0006Xj-08
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 05:03:49 -0500
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 40T85Rk2023740; Mon, 29 Jan 2024 10:03:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=date : from : to :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=x1fJNS1AjQQ24sJYvQNeKjRSODdrURHWrXAXS2+ZGWg=;
 b=EJg2fkbPZC2PgGGIagbGzJT6mq4aSA+F1n+kaqon3S6AIzi8GyQYYtf1UvJHdTT29Ya1
 uowwfv+abTBhWpME41kxhKxIwGLXY+K92su3MKA2cXLam/IIpktzg+xJ2WC8XVTvds3L
 nAz1uBruMqh6V/dcddwFEJCe9zt8DaL4wX7iB2tp+Ml7STLjJJ41OFWlWWCwLwGd6kxk
 RrN+34EX5HUMLH1IcVkEGFaAh99s/BggY5+HqmbHVTtvf6yxGNsX6Q9UIdDyKkSc0UXl
 BmfrrLT4w0UxWbB40LllG/CaQT4yXwHn2WxZfA8QhX67xYHc+LQxlXc2Loa0NlNGwni5 Ag== 
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vx86vtg46-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 29 Jan 2024 10:03:46 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 40T7HF35002223; Mon, 29 Jan 2024 10:03:44 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3vwc5sys5q-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 29 Jan 2024 10:03:44 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 40TA3ggW37945652
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 29 Jan 2024 10:03:42 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9E7CB2006C;
 Mon, 29 Jan 2024 10:03:42 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6925F2006A;
 Mon, 29 Jan 2024 10:03:42 +0000 (GMT)
Received: from heavy (unknown [9.179.7.240])
 by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Mon, 29 Jan 2024 10:03:42 +0000 (GMT)
Date: Mon, 29 Jan 2024 11:03:40 +0100
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Subject: Re: [PATCH v3 02/33] linux-user: Adjust SVr4 NULL page mapping
Message-ID: <f7i7vbam5fh7h6iom26qmm6ilhsw75niv7tj2orponyx7i5bs2@n7z32bdx3zpu>
References: <20240102015808.132373-1-richard.henderson@linaro.org>
 <20240102015808.132373-3-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240102015808.132373-3-richard.henderson@linaro.org>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 0RhPZ75tMxFQz0HKrkvNVNzppdQMwJ6b
X-Proofpoint-ORIG-GUID: 0RhPZ75tMxFQz0HKrkvNVNzppdQMwJ6b
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-29_06,2024-01-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0
 mlxlogscore=999 mlxscore=0 phishscore=0 bulkscore=0 suspectscore=0
 adultscore=0 clxscore=1015 lowpriorityscore=0 malwarescore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401290072
Received-SPF: pass client-ip=148.163.158.5; envelope-from=iii@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
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

On Tue, Jan 02, 2024 at 12:57:37PM +1100, Richard Henderson wrote:
> Use TARGET_PAGE_SIZE and MAP_FIXED_NOREPLACE.
> 
> We really should be attending to this earlier during
> probe_guest_base, as well as better detection and
> emulation of various Linux personalities.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  linux-user/elfload.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/linux-user/elfload.c b/linux-user/elfload.c
> index cf9e74468b..f3c1e0fb64 100644
> --- a/linux-user/elfload.c
> +++ b/linux-user/elfload.c
> @@ -3911,8 +3911,9 @@ int load_elf_binary(struct linux_binprm *bprm, struct image_info *info)
>                 and some applications "depend" upon this behavior.  Since
>                 we do not have the power to recompile these, we emulate
>                 the SVr4 behavior.  Sigh.  */
> -            target_mmap(0, qemu_host_page_size, PROT_READ | PROT_EXEC,
> -                        MAP_FIXED | MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
> +            target_mmap(0, TARGET_PAGE_SIZE, PROT_READ | PROT_EXEC,
> +                        MAP_FIXED_NOREPLACE | MAP_PRIVATE | MAP_ANONYMOUS,
> +                        -1, 0);
>          }
>  #ifdef TARGET_MIPS
>          info->interp_fp_abi = interp_info.fp_abi;
> -- 
> 2.34.1

Nit: should we print a warning if we get EEXIST?

Reviewed-by: Ilya Leoshkevich <iii@linux.ibm.com>

