Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61F91C48BF6
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Feb 2024 11:31:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1reZBO-0007gP-UP; Mon, 26 Feb 2024 06:30:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1reZBI-0007fR-Q8; Mon, 26 Feb 2024 06:30:01 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1reZBF-00032P-8b; Mon, 26 Feb 2024 06:29:58 -0500
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 41Q9EHoD017013; Mon, 26 Feb 2024 11:29:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 content-transfer-encoding : in-reply-to; s=pp1;
 bh=3Yt0HHcfgQJQ2mVUFCVFY7JwRkHlZOjHbpu/ccz6oww=;
 b=LgDctyMEr9PUjd/hIY3RSzFX/MRH7Xfvy/Bo6z2NGr9II6JmM04WjwsqL0rfi6859Hbc
 js05rZdCQ5szr2/xVN30vcfTU2al/57t66yehvQxAL62EfcTIQgUlBY/VPL5tfkT8ud1
 qRcqyk8FdxCm8C7KMqnFWYkuwkmgJuSgat6kbLgcdU5L1pETI2WjwrX8IN3XzyiHngHY
 FBtK6E4BX5bOOT0Gd63i4sfwauFuIAM3C7g6oa2RroeFY8oZdHXLRWIC1jvOtBnhCtW1
 ZEpLKm7U0AGMHNfytKa1J6Gj5UHIZJ+Qm6fFGIUuR5VJVGpd9iYwMmrwshNteKkS1x3p iA== 
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wg56yuntu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 26 Feb 2024 11:29:53 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 41QAi5Kc012338; Mon, 26 Feb 2024 11:29:53 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3wfwg206ka-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 26 Feb 2024 11:29:52 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 41QBTnHP16581292
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 26 Feb 2024 11:29:51 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2A4C22004B;
 Mon, 26 Feb 2024 11:29:49 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C94EE20040;
 Mon, 26 Feb 2024 11:29:48 +0000 (GMT)
Received: from heavy (unknown [9.171.71.141])
 by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Mon, 26 Feb 2024 11:29:48 +0000 (GMT)
Date: Mon, 26 Feb 2024 12:29:47 +0100
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 qemu-stable@nongnu.org
Subject: Re: [PATCH] linux-user: Make TARGET_NR_setgroups affect only the
 current thread
Message-ID: <vqmdjxoplrifjs53kkl2e7td3rymw6t6p66gkqgsa4y7mhooct@y54pgwyceatk>
References: <20240131001851.15932-1-iii@linux.ibm.com>
 <f39cb7d6-beaa-4365-bbd8-7fc8546cf655@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f39cb7d6-beaa-4365-bbd8-7fc8546cf655@linaro.org>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: gN5tOhq47WQt2YGRe0q2DZFall6ZvC9l
X-Proofpoint-ORIG-GUID: gN5tOhq47WQt2YGRe0q2DZFall6ZvC9l
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-26_07,2024-02-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 mlxscore=0
 lowpriorityscore=0 malwarescore=0 mlxlogscore=952 suspectscore=0
 phishscore=0 spamscore=0 adultscore=0 clxscore=1011 impostorscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402260086
Received-SPF: pass client-ip=148.163.158.5; envelope-from=iii@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H3=-0.01,
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

On Wed, Jan 31, 2024 at 02:10:55PM +0100, Philippe Mathieu-Daudé wrote:
> On 31/1/24 01:18, Ilya Leoshkevich wrote:
> > Like TARGET_NR_setuid, TARGET_NR_setgroups should affect only the
> > calling thread, and not the entire process. Therefore, implement it
> > using a syscall, and not a libc call.
> > 
> > Cc: qemu-stable@nongnu.org
> > Fixes: 19b84f3c35d7 ("added setgroups and getgroups syscalls")
> > Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> > ---
> >   linux-user/syscall.c | 10 ++++++++--
> >   1 file changed, 8 insertions(+), 2 deletions(-)
> 
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

Thanks for the review!

A few weeks have passed and I wonder if this patch fell through the
cracks. Do I need to do something to have it applied?

