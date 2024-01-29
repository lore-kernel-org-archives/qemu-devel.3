Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0744FC47422
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jan 2024 10:18:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUOie-00039c-HP; Mon, 29 Jan 2024 05:18:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1rUOiT-000370-Ul
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 05:18:19 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1rUOiS-0001O3-6F
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 05:18:13 -0500
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 40T8Tv0b028054; Mon, 29 Jan 2024 10:18:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=date : from : to :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=u8xammxiE96iuK6HOlrJ5nRsy2SyFOWFO1FDkz3x8FI=;
 b=TNQ1Gsyu7nwW897QfqFLf9WU7CgX42LdR1lQ0y6rsP1tP5oL4PAgd3B3VDf3GXe3+kXe
 5wpH0MalBTf8rYFX071/Fv7Gm3Zus8/JDhIcePKSFj3nKpRHqSZ8ThgIzekrEwrj0ZVQ
 +qRqwZLGVUL4JbULw8KIzjTXEFOOUHdbmlzZ3wwpUpiI+S8EkyvIunNP3067HTWOIBZK
 2QscAZBqBYWRRk86mwpyqEzsB/qOzQs5d8ue9MqexBFp8wc/sId5HizDLbjCg16ExCkt
 N/hhYHTvlOJn2vIokc6PMTZbbPAwyeNsggbmq5PfRIa+H4/xwBQ4NMYzV2kcmG46HIav AA== 
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vx6635mad-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 29 Jan 2024 10:18:09 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 40T8L4bK010569; Mon, 29 Jan 2024 10:18:07 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3vwd5nfgw3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 29 Jan 2024 10:18:07 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 40TAI5vn3998430
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 29 Jan 2024 10:18:05 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B69D7201C3;
 Mon, 29 Jan 2024 10:18:05 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 782822017D;
 Mon, 29 Jan 2024 10:18:05 +0000 (GMT)
Received: from heavy (unknown [9.179.7.240])
 by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Mon, 29 Jan 2024 10:18:05 +0000 (GMT)
Date: Mon, 29 Jan 2024 11:18:03 +0100
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Subject: Re: [PATCH v3 04/33] linux-user: Remove qemu_host_page_size from
 create_elf_tables
Message-ID: <h4dnjbdfx6v34kojvwaoal5rsgdsq6mzgekacjmr2yltitvi2b@pizn6m2tjtse>
References: <20240102015808.132373-1-richard.henderson@linaro.org>
 <20240102015808.132373-5-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240102015808.132373-5-richard.henderson@linaro.org>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: JaD_hWkWtf1u5QsJ7GewZgBaJEuOfddf
X-Proofpoint-GUID: JaD_hWkWtf1u5QsJ7GewZgBaJEuOfddf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-29_06,2024-01-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 bulkscore=0
 spamscore=0 adultscore=0 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 mlxlogscore=999 phishscore=0 clxscore=1015
 malwarescore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2311290000 definitions=main-2401290074
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

On Tue, Jan 02, 2024 at 12:57:39PM +1100, Richard Henderson wrote:
> AT_PAGESZ is supposed to advertise the guest page size.
> The random adjustment made here using qemu_host_page_size
> does not match anything else within linux-user.
> 
> The idea here is good, but should be done more systemically
> via adjustment to TARGET_PAGE_SIZE.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  linux-user/elfload.c | 8 +-------
>  1 file changed, 1 insertion(+), 7 deletions(-)
> 
> diff --git a/linux-user/elfload.c b/linux-user/elfload.c
> index 4df565d64b..c166faabab 100644
> --- a/linux-user/elfload.c
> +++ b/linux-user/elfload.c
> @@ -2678,13 +2678,7 @@ static abi_ulong create_elf_tables(abi_ulong p, int argc, int envc,
>      NEW_AUX_ENT(AT_PHDR, (abi_ulong)(info->load_addr + exec->e_phoff));
>      NEW_AUX_ENT(AT_PHENT, (abi_ulong)(sizeof (struct elf_phdr)));
>      NEW_AUX_ENT(AT_PHNUM, (abi_ulong)(exec->e_phnum));
> -    if ((info->alignment & ~qemu_host_page_mask) != 0) {
> -        /* Target doesn't support host page size alignment */
> -        NEW_AUX_ENT(AT_PAGESZ, (abi_ulong)(TARGET_PAGE_SIZE));
> -    } else {
> -        NEW_AUX_ENT(AT_PAGESZ, (abi_ulong)(MAX(TARGET_PAGE_SIZE,
> -                                               qemu_host_page_size)));
> -    }
> +    NEW_AUX_ENT(AT_PAGESZ, (abi_ulong)(TARGET_PAGE_SIZE));
>      NEW_AUX_ENT(AT_BASE, (abi_ulong)(interp_info ? interp_info->load_addr : 0));
>      NEW_AUX_ENT(AT_FLAGS, (abi_ulong)0);
>      NEW_AUX_ENT(AT_ENTRY, info->entry);
> -- 
> 2.34.1

Reviewed-by: Ilya Leoshkevich <iii@linux.ibm.com>

