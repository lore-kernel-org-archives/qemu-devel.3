Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDB48C47422
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jan 2024 10:58:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUPLJ-000414-6x; Mon, 29 Jan 2024 05:58:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1rUPLH-00040c-FH
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 05:58:19 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1rUPLF-0002QU-Ow
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 05:58:19 -0500
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 40T9O9D5003002; Mon, 29 Jan 2024 10:58:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=date : from : to :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=dqI9jz9WuXYKnX0woj/rjzBmVFHRwlITIZTxB+60FNU=;
 b=Y4M11VhgkbofBWEm8M5I9XivLLWzLoyREND126TfAc9bct56rtjTHj6ZUmFFhq2fhXBM
 0lIyMdZkpsZkH7PIj+KXXZSKAIaPjEfXriJ/6AnQy8fwt9M/g5tNqfd3eUimDwIsMo3C
 +12tOTsofWvBhPmhnol/f2X6JLY8OhhsrijXaLP4ym1KRH9ZR+MIqtqHmCjEdTgbm9qC
 O8yuCVpaoqnG4OEMwSXbI3w+QGAXNN6wobYJ+9K3MHGtBMCjIuXGp/fTyWyQy/7GPmsG
 l7l3/xCXYfBTvyaMb9Je6ZGXADCHhE+auiDLlbr5StciDOfef8qtP3+03tVx9ejBADiK uw== 
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vx6e2dv7k-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 29 Jan 2024 10:58:15 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 40TAaOa3017793; Mon, 29 Jan 2024 10:58:14 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3vwchyfw75-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 29 Jan 2024 10:58:14 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 40TAwCUG44171910
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 29 Jan 2024 10:58:12 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 90F9F20043;
 Mon, 29 Jan 2024 10:58:12 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5E31920040;
 Mon, 29 Jan 2024 10:58:12 +0000 (GMT)
Received: from heavy (unknown [9.179.7.240])
 by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Mon, 29 Jan 2024 10:58:12 +0000 (GMT)
Date: Mon, 29 Jan 2024 11:58:10 +0100
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Subject: Re: [PATCH v3 10/33] linux-user: Remove HOST_PAGE_ALIGN from mmap.c
Message-ID: <igvhbsc2zj6ed63jwbnu3t6fjpdaf3kikwenp6jaxttaj65tjd@ohtmvav5o7pt>
References: <20240102015808.132373-1-richard.henderson@linaro.org>
 <20240102015808.132373-11-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240102015808.132373-11-richard.henderson@linaro.org>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: ObQwzw5G1crBMpDJEzgcgcxMzsXU2jv7
X-Proofpoint-ORIG-GUID: ObQwzw5G1crBMpDJEzgcgcxMzsXU2jv7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-29_06,2024-01-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0
 priorityscore=1501 suspectscore=0 impostorscore=0 phishscore=0
 lowpriorityscore=0 adultscore=0 malwarescore=0 mlxscore=0 spamscore=0
 mlxlogscore=772 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401290079
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

On Tue, Jan 02, 2024 at 12:57:45PM +1100, Richard Henderson wrote:
> This removes a hidden use of qemu_host_page_size, using instead
> the existing host_page_size local within each function.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  linux-user/mmap.c | 13 ++++++-------
>  1 file changed, 6 insertions(+), 7 deletions(-)

Reviewed-by: Ilya Leoshkevich <iii@linux.ibm.com>

