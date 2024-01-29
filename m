Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AE20C47422
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jan 2024 10:54:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUPHF-0002Xn-Vq; Mon, 29 Jan 2024 05:54:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1rUPHB-0002XO-H6
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 05:54:06 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1rUPHA-000176-0m
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 05:54:05 -0500
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 40T8nRrX023583; Mon, 29 Jan 2024 10:54:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=date : from : to :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=JQmhL5N4lY0Bkb5gvIRakfjYCOyxA/y/HhIbAu/7el8=;
 b=PjjAOC5dZqOL5OBUHF6YC7vZ5cIN9il62wROXusvWUw9uoutb/HU20b0DAmKHYiYCA8Z
 XdvE6BKI0k2xEn8NF6Zg8e3LOu9dTCvcnbMh+CRyBgPqsccZ2lNLp0RR/rqzVLEINAPy
 s8kS8PwxvGyrqWdTBVBNuXGU0A3FpX9Tt4cp9Y/ZIIvIBGwgZuCcIvf0SKIi1b4Gl4zf
 OGDS6JumoSEXY2GzzBJGllHSaseePLQ9PGpahraxi+ByrXI4jkO02CQyhIIioInln8MF
 jHVBAskP6+3giLTb3YMUMomOQ1DI+2lvSd34Kl2tPrhPvlvtcRh8pubofyGS6RHwGBTb Cg== 
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vwudu8932-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 29 Jan 2024 10:54:02 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 40T8L4lt010569; Mon, 29 Jan 2024 10:54:01 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3vwd5nfnmm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 29 Jan 2024 10:54:01 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 40TArxZn8323814
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 29 Jan 2024 10:53:59 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4C26320043;
 Mon, 29 Jan 2024 10:53:59 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B2C4620040;
 Mon, 29 Jan 2024 10:53:58 +0000 (GMT)
Received: from heavy (unknown [9.179.7.240])
 by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Mon, 29 Jan 2024 10:53:58 +0000 (GMT)
Date: Mon, 29 Jan 2024 11:53:57 +0100
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Subject: Re: [PATCH v3 08/33] linux-user: Remove qemu_host_page_{size, mask}
 from mmap.c
Message-ID: <64eomgmd5flxu6wrgooovewtm767pphiqhzgwlorqv4dkacqwk@n3ubmr3dbjsu>
References: <20240102015808.132373-1-richard.henderson@linaro.org>
 <20240102015808.132373-9-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240102015808.132373-9-richard.henderson@linaro.org>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: avU33DykWCdny_D6TbAfmMJqiPuS8vU4
X-Proofpoint-ORIG-GUID: avU33DykWCdny_D6TbAfmMJqiPuS8vU4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-29_06,2024-01-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0
 impostorscore=0 malwarescore=0 phishscore=0 spamscore=0 priorityscore=1501
 mlxscore=0 lowpriorityscore=0 suspectscore=0 adultscore=0 mlxlogscore=853
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2401290078
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

On Tue, Jan 02, 2024 at 12:57:43PM +1100, Richard Henderson wrote:
> Use qemu_real_host_page_size instead.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  linux-user/mmap.c | 66 +++++++++++++++++++++++------------------------
>  1 file changed, 33 insertions(+), 33 deletions(-)

Reviewed-by: Ilya Leoshkevich <iii@linux.ibm.com>

