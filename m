Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBDB1C47DB3
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jan 2024 14:58:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUT4q-0006E3-2P; Mon, 29 Jan 2024 09:57:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1rUT4o-0006Dv-5f
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 09:57:34 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1rUT4m-0002YL-NG
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 09:57:33 -0500
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 40TEsQ21025801; Mon, 29 Jan 2024 14:57:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=date : from : to :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=4yL2dGvkHaw8Xq53LURcQ9t+GrGBlNtYTZQPwHJk90Y=;
 b=gvsGphFpJQnmWUNFIAD/N1IxJiMwuO9y856tawgZoinRWV0Wx3d4gQCKXGDTRDLGE9UC
 5rcXWn5eZcigRnpjtj4KDMX8WuIbGxXlCUB9lABHn8jN9bsHmd2OrkAp/i5jLxF6tB5R
 tE+spV6bYNPiW9J8ZKQiEPEa97VCejG5x+mopjWMdWPA5XwdvRtiQlz4CNdLDoelamtA
 0FWahl6hJAOondKIXuZBrT1rvPqhlpXao6UPyZ7mkuFWo6RlmhCjKEXfZg+J2G0iIoW3
 TIcBP86vYU3u57WueexxQWHivsUCHOqqFUFCHyWerSIqnej81PvONRP13sYLTnDFiVl8 pg== 
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vxdy30dr0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 29 Jan 2024 14:57:29 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 40TDvgHD017712; Mon, 29 Jan 2024 14:57:08 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3vwchyh0v4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 29 Jan 2024 14:57:08 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 40TEv6EN43581954
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 29 Jan 2024 14:57:06 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1851E20043;
 Mon, 29 Jan 2024 14:57:06 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id F175920040;
 Mon, 29 Jan 2024 14:57:05 +0000 (GMT)
Received: from heavy (unknown [9.155.200.166])
 by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Mon, 29 Jan 2024 14:57:05 +0000 (GMT)
Date: Mon, 29 Jan 2024 15:57:04 +0100
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Subject: Re: [PATCH v3 18/33] linux-user: Fix sub-host-page mmap
Message-ID: <en5ret64vxt3pyok5efftdlrrs5hpncewushr5sxrrwukv4552@tik2k4sp3imb>
References: <20240102015808.132373-1-richard.henderson@linaro.org>
 <20240102015808.132373-19-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240102015808.132373-19-richard.henderson@linaro.org>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 6oE2XObEa_AobjRV9WU6Q7VaExOvOFke
X-Proofpoint-GUID: 6oE2XObEa_AobjRV9WU6Q7VaExOvOFke
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-29_09,2024-01-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0
 lowpriorityscore=0 bulkscore=0 phishscore=0 impostorscore=0
 priorityscore=1501 spamscore=0 adultscore=0 mlxscore=0 suspectscore=0
 clxscore=1015 mlxlogscore=927 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2311290000 definitions=main-2401290110
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

On Tue, Jan 02, 2024 at 12:57:53PM +1100, Richard Henderson wrote:
> We cannot skip over the_end1 to the_end, because we fail to
> record the validity of the guest page with the interval tree.
> Remove "the_end" and rename "the_end1" to "the_end".
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  linux-user/mmap.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)

Reviewed-by: Ilya Leoshkevich <iii@linux.ibm.com>

