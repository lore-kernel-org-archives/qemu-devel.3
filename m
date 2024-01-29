Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B5E7C47422
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jan 2024 10:55:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUPIJ-0002vs-7Z; Mon, 29 Jan 2024 05:55:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1rUPIE-0002u9-69
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 05:55:12 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1rUPIC-0001KP-08
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 05:55:09 -0500
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 40T9orrM031956; Mon, 29 Jan 2024 10:55:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 content-transfer-encoding : in-reply-to; s=pp1;
 bh=zxdwPo4CrcyfIUHoS0NizypCy/KymNSB1V5bjlr+48o=;
 b=KuR6mzZbP7rKEkbxSh2vEqofaEbW3U4oyWHyxk+vSy/VLEuoRwBrxF6W2oEgd9AyxmHM
 dPSNv4JAQDZS6+EiDXmRjbPYp1cnydZlfbvi+DXdA5J/RmfK2k4185CwuwS50r60j/R5
 Tv0dZfUbFzTNfZZ3bCyjYlXDFYqaNpnZPp133xO+eCcduVVzqXwgvj5599P1S+TP7ijv
 cFutvs/C0kss5DzkfFzwjmngj/w72ES17ZXFuY9pk2722GF0CsWisfQ/NJvzr7mM5Gvo
 /LL+gYAUa/yGcH02W65QjuP60o0m97dvdDZc6jHJb4ja47IVfVxnnpv2S9VpqF8tzW+v 6A== 
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vw20adyww-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 29 Jan 2024 10:55:05 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 40T9eB4n011231; Mon, 29 Jan 2024 10:55:04 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3vweck7bjb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 29 Jan 2024 10:55:04 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 40TAt2Ip24380030
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 29 Jan 2024 10:55:02 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CEDBF20043;
 Mon, 29 Jan 2024 10:55:02 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8E80120040;
 Mon, 29 Jan 2024 10:55:02 +0000 (GMT)
Received: from heavy (unknown [9.179.7.240])
 by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Mon, 29 Jan 2024 10:55:02 +0000 (GMT)
Date: Mon, 29 Jan 2024 11:55:01 +0100
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH v3 09/33] linux-user: Remove REAL_HOST_PAGE_ALIGN from
 mmap.c
Message-ID: <hgfjhyrtqd4li6h3yac2uh5blxgx6iiupbhzdixfstd7riijhv@4xf7rvxnhf6c>
References: <20240102015808.132373-1-richard.henderson@linaro.org>
 <20240102015808.132373-10-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240102015808.132373-10-richard.henderson@linaro.org>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: JOUGsxPOMo70woQnLQpOPBRRJbbC7iFY
X-Proofpoint-ORIG-GUID: JOUGsxPOMo70woQnLQpOPBRRJbbC7iFY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-29_06,2024-01-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 bulkscore=0 adultscore=0 clxscore=1015 spamscore=0 mlxlogscore=749
 phishscore=0 suspectscore=0 impostorscore=0 priorityscore=1501 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401290078
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

On Tue, Jan 02, 2024 at 12:57:44PM +1100, Richard Henderson wrote:
> We already have qemu_real_host_page_size() in a local variable.
> 
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  linux-user/mmap.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Ilya Leoshkevich <iii@linux.ibm.com>

