Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C9DCC47DDF
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jan 2024 10:07:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rV7UW-0007xX-Uu; Wed, 31 Jan 2024 05:06:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1rV7UT-0007eh-Ur; Wed, 31 Jan 2024 05:06:46 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1rV7UR-0000hA-Mv; Wed, 31 Jan 2024 05:06:45 -0500
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 40V9pRAt014716; Wed, 31 Jan 2024 10:06:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=pp1; bh=9mRulhmqJR5B79u+Jc8yRIZCnZPyDIp4S5gE97NA1KI=;
 b=fQdJjXPgBaEd+lvAOL6fADGuwBQOr0L0aRje8wNmUR51xnqtYfk/Ka8/VYaY02UBVSMh
 Fw3Ivk7jSPNekG8N34EstpJEKautwM2WlZfFotLX8aoVUdG3FLMwTMsG9ECdRF5ikDtR
 MppKMwPOwWU5VcFVEZfMlm2aTVTkOS8Va6v8U85hqIiBw/j9qnH6AW42TRK5cHs7JoZU
 HfAeM7jYLAyacwhdzPGoMJIFflwLcJXLb/sUlLG1CqLt2o64HSHGSsOTNTzZ2aC56pP+
 D3BwIC405MjKNbhPvKrvjZXblacq/RKNfPCco+H9C2dgGZOqTwp5yOG18JxdipWuy8NS Ew== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vyjsh9ymc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 31 Jan 2024 10:06:40 +0000
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 40V9pVdR015351;
 Wed, 31 Jan 2024 10:06:39 GMT
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vyjsh9yky-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 31 Jan 2024 10:06:39 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 40V7mtkm002190; Wed, 31 Jan 2024 10:06:38 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3vwc5tcy6m-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 31 Jan 2024 10:06:38 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 40VA6blv28246300
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 31 Jan 2024 10:06:37 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0C78C2006E;
 Wed, 31 Jan 2024 10:06:37 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9BA5920065;
 Wed, 31 Jan 2024 10:06:36 +0000 (GMT)
Received: from heavy (unknown [9.179.12.102])
 by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Wed, 31 Jan 2024 10:06:36 +0000 (GMT)
Date: Wed, 31 Jan 2024 11:06:35 +0100
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Helge Deller <deller@gmx.de>, Laurent Vivier <laurent@vivier.eu>
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 qemu-stable@nongnu.org
Subject: Re: Re: [PATCH] linux-user: Make TARGET_NR_setgroups affect only the
 current thread
Message-ID: <5hbh6xgr2q6aj4rxzvciyufocmkaybngbtizeufoqtf5sntgte@jlsn5udwgon6>
References: <20240131001851.15932-1-iii@linux.ibm.com>
 <c96f12a4-8a36-4d40-8fd9-54e4b0284ae6@gmx.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c96f12a4-8a36-4d40-8fd9-54e4b0284ae6@gmx.de>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: a2rSTY1usFh7mbyYqE9OsDQ-0ylZeZDI
X-Proofpoint-ORIG-GUID: Qi34oQDwregk0-UDctK4hJXQjEgJyobd
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-31_03,2024-01-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0
 impostorscore=0 mlxscore=0 bulkscore=0 adultscore=0 lowpriorityscore=0
 phishscore=0 priorityscore=1501 malwarescore=0 mlxlogscore=809
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401310076
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

On Wed, Jan 31, 2024 at 08:53:49AM +0100, Helge Deller wrote:
> On 1/31/24 01:18, Ilya Leoshkevich wrote:
> > Like TARGET_NR_setuid, TARGET_NR_setgroups should affect only the
> > calling thread, and not the entire process. Therefore, implement it
> > using a syscall, and not a libc call.
> > 
> > Cc: qemu-stable@nongnu.org
> > Fixes: 19b84f3c35d7 ("added setgroups and getgroups syscalls")
> > Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> 
> Patch seems ok, but just out of interest, how did you noticed?
> 
> Helge

Our internal users are trying to emulate a larger app, and they were
running into weird crashes between fork() and exec(). I had to
implement syscall catchpoints (posted) and follow-fork-mode child
(still needs a few cleanups before I can post it) to be able to debug
it, and found it was dying here [1], and from there it was easy.

[1] https://sourceware.org/git/?p=glibc.git;a=blob;f=nptl/nptl_setxid.c;h=4bfcfe41882d9b15b8090325bfdc9ceb5ab2693e;hb=36f2487f13e3540be9ee0fb51876b1da72176d3f#l25

