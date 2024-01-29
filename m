Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FBAEC47DB3
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jan 2024 14:44:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUSry-0008Cq-Tf; Mon, 29 Jan 2024 09:44:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1rUSrw-0008CM-4N
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 09:44:16 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1rUSru-00005D-40
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 09:44:15 -0500
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 40TEcU1K012493; Mon, 29 Jan 2024 14:44:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=date : from : to :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=XKx8Liwe0+ORdCSWPexhJ5DRRoj7+aPdcf+SG4BzbCY=;
 b=cQQWpj5CnPrvZD/AMSG0yrQ24Q9sg6cK1qRru/xmWbE86SyvEYGP0SoA1aaHRRcGiw5c
 S9IrCQ526dSrScKUY/8UkmWiMB6tsMoyjwe1sJVfe7HYATljBitB3cvt9JTCq9WIhCWH
 OjQ+spOeNqkC/HZQvmpkscyqowHyc3+DcKhJVVFAhojT0DboCzXNkrHQ694D7ovpNVz6
 INX2l6fckkY+Ew2r/y75E7TNl6NBI1LG7ujQptcGyB4ZtupBrAKMl7GDj5/tTIAWgjRP
 FjIplh9o/zMXyR8iZ80G0/4fENeK+etFWBeJukwbWw5gLu8esohpf3Keb1hJnRAVwWeE yQ== 
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vxdy304c8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 29 Jan 2024 14:44:11 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 40TDPrFm007179; Mon, 29 Jan 2024 14:44:11 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3vwev20aj0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 29 Jan 2024 14:44:10 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 40TEi9RD17236522
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 29 Jan 2024 14:44:09 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3B05A20043;
 Mon, 29 Jan 2024 14:44:09 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id ADD5A20040;
 Mon, 29 Jan 2024 14:44:08 +0000 (GMT)
Received: from heavy (unknown [9.155.200.166])
 by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Mon, 29 Jan 2024 14:44:08 +0000 (GMT)
Date: Mon, 29 Jan 2024 15:44:07 +0100
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Subject: Re: [PATCH v3 15/33] linux-user: Remove qemu_host_page_size from main
Message-ID: <knkjwavknsn6xz7u6nxcmzrzm2i22n46kbzxmhswqmo5dwj4qk@3jfifd6lupoz>
References: <20240102015808.132373-1-richard.henderson@linaro.org>
 <20240102015808.132373-16-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240102015808.132373-16-richard.henderson@linaro.org>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 4weYGu-DIWHkD_kEKaH5QP2x4ZW4PchO
X-Proofpoint-GUID: 4weYGu-DIWHkD_kEKaH5QP2x4ZW4PchO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-29_07,2024-01-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0
 lowpriorityscore=0 bulkscore=0 phishscore=0 impostorscore=0
 priorityscore=1501 spamscore=0 adultscore=0 mlxscore=0 suspectscore=0
 clxscore=1015 mlxlogscore=911 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2311290000 definitions=main-2401290107
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

On Tue, Jan 02, 2024 at 12:57:50PM +1100, Richard Henderson wrote:
> Use qemu_real_host_page_size() instead.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  linux-user/main.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/linux-user/main.c b/linux-user/main.c
> index 0cdaf30d34..5f217cc2a8 100644
> --- a/linux-user/main.c
> +++ b/linux-user/main.c

[...]

> @@ -806,8 +806,10 @@ int main(int argc, char **argv, char **envp)
>       */
>      max_reserved_va = MAX_RESERVED_VA(cpu);
>      if (reserved_va != 0) {
> -        if ((reserved_va + 1) % qemu_host_page_size) {
> -            char *s = size_to_str(qemu_host_page_size);
> +        int host_page_size = qemu_real_host_page_size();
> +
> +        if ((reserved_va + 1) % host_page_size) {
> +            char *s = size_to_str(host_page_size);

Does it make sense to allow values not divisible by TARGET_PAGE_SIZE
here? It's probably not a big deal, since in the worst case we'll
only waste a few bytes, so:

Reviewed-by: Ilya Leoshkevich <iii@linux.ibm.com>

[...]

