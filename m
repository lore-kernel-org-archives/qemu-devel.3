Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50C42C4829D
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Feb 2024 20:44:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZd9Q-0004CH-55; Mon, 12 Feb 2024 15:43:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1rZd9O-0004C7-O7
 for qemu-devel@nongnu.org; Mon, 12 Feb 2024 15:43:38 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1rZd9M-00020z-Q4
 for qemu-devel@nongnu.org; Mon, 12 Feb 2024 15:43:38 -0500
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 41CKbW1V019491; Mon, 12 Feb 2024 20:43:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=pp1; bh=LXBXs7t5w751PCFnKTw3LMF1mh1y1ygnIYfXuNN/5Cs=;
 b=E7YkDJnpCOIH2zcvm0fDkaAYCJiZUJ36MlaB43QmvBAnd3WqPttNnNzqfvcTFdtN3muL
 zr8DzEYKSR+Wu0REjBWhKsMOBv4DFRK15SmMjh2ZIa0jFDmHV2RGtPYMMUg8qAo8g4yV
 20Wt1/v30AGLkO7dJ2+XPZ6Zmc2gX/uZHZOvLuY3nXgsMYZ2uguBMdTKkjnWA9P1ygJr
 lheBy/SZy8wVVg0XgX68DVYIlX6kRN9g2izQnPp+lLhDjp+W8Bv0v6VG3HdABYdR6vTH
 ujgk37TJ2Yn54kTwhTsv5l4sGoaj0PHa3S0Z04qLeVxTa9M0kY4asHog/2U1WNoAxRFu Ig== 
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w7the82t7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 12 Feb 2024 20:43:32 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 41CIZWn0004247; Mon, 12 Feb 2024 20:43:31 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3w6kv038t5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 12 Feb 2024 20:43:31 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 41CKhRjT18743812
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 12 Feb 2024 20:43:29 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6670B2004B;
 Mon, 12 Feb 2024 20:43:27 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1297120040;
 Mon, 12 Feb 2024 20:43:27 +0000 (GMT)
Received: from heavy (unknown [9.179.4.126])
 by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Mon, 12 Feb 2024 20:43:26 +0000 (GMT)
Date: Mon, 12 Feb 2024 21:43:25 +0100
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Cc: QEMU Developers <qemu-devel@nongnu.org>
Subject: Re: Re: [PULL 05/13] linux-user: Use walk_memory_regions for
 open_self_maps
Message-ID: <2no4imvz2zrar5kchz2l3oddqbgpj77jgwcuf7aritkn2ok763@i2mvpcihztho>
References: <20230901204251.137307-1-richard.henderson@linaro.org>
 <20230901204251.137307-6-richard.henderson@linaro.org>
 <9860cd401db66e6bf10e9e41df148b25ee6c73fd.camel@linuxfoundation.org>
 <c845093f-1fe0-477e-bf5e-db22c985241a@tls.msk.ru>
 <3cc4df1a6fe27b211b29d2c17846812936255d7a.camel@linuxfoundation.org>
 <ca83fc98-219c-47b1-a16b-f281d914e4a0@linaro.org>
 <360135aa106e1925979bc0efd5a5d6fdeed4202d.camel@linuxfoundation.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <360135aa106e1925979bc0efd5a5d6fdeed4202d.camel@linuxfoundation.org>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: I8fNohOHzjyltZ0frmO5B5D4gvvESc5C
X-Proofpoint-GUID: I8fNohOHzjyltZ0frmO5B5D4gvvESc5C
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-12_16,2024-02-12_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 spamscore=0
 mlxlogscore=999 priorityscore=1501 malwarescore=0 lowpriorityscore=0
 impostorscore=0 suspectscore=0 mlxscore=0 adultscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402120160
Received-SPF: pass client-ip=148.163.158.5; envelope-from=iii@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H3=0.001,
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

On Mon, Feb 05, 2024 at 11:11:06AM +0000, Richard Purdie wrote:
> On Mon, 2024-02-05 at 13:05 +1000, Richard Henderson wrote:
> > On 1/26/24 23:52, Richard Purdie wrote:
> > > On Fri, 2024-01-26 at 16:33 +0300, Michael Tokarev wrote:
> > > > 26.01.2024 16:03, Richard Purdie wrote:
> > > > > I've run into a problem with this change.
> > > > > 
> > > > > We (Yocto Project) upgraded to qemu 8.2.0 recently and after that we
> > > > > started seeing errors cross compiling webkitgtk on x86_64 for x86_64
> > > > > during the introspection code which runs under user mode qemu.
> > > > 
> > > > Besides your observations, please be aware there's quite a few issues in 8.2.0.
> > > > Please take a look at https://gitlab.com/mjt0k/qemu/-/commits/staging-8.2/
> > > > (and https://gitlab.com/qemu-project/qemu/-/commits/staging-8.2/ which is updated
> > > > less often) for fixes already queued up, if you haven't looked there already.
> > > > 8.2.1 stable/bugfix release is scheduled for the beginning of the next week.
> > > 
> > > Thanks.
> > > 
> > > I should note that I did test the staging-8.2 branch and nothing there
> > > helped. The issue was also present with master as of yesterday.
> > > 
> > > https://bugzilla.yoctoproject.org/show_bug.cgi?id=15367 is Yocto
> > > Projects tracking of the issue which has the commits for master and
> > > staging-8.2 that I tested.
> > 
> > The yocto logs referenced here are not helpful for reproducing the problem.
> 
> It took me a couple of days I didn't have to workout which commit
> caused it, which versions showed the issue and how to work around it.
> 
> It looks host kernel specific since it doesn't happen on some systems
> so even with the binaries/command/environment vars, it may not be
> enough.
> 
> I was hoping the indication of the cause might help point to the fix as
> there is quite a bit of work in trying to extract this into a
> reproducer. The failure is 20 mins into a webkitgtk compile on a remote
> CI system which no longer has the context on it.
> 
> > Please extract a binary to run, inputs, and command-line.
> 
> I wish I could say that to the bug reports I get! :)
> 
> I'll do my best but finding the time is going to be a challenge.
> 
> Cheers,
> 
> Richard

I just ran into a similar crash and could reproduce it with
5005aed8a7e7 alpha-linux-user as follows:

#include <fcntl.h>
#include <sys/shm.h>

int main(void)
{
        shmat(shmget(IPC_PRIVATE, 1836016, IPC_CREAT | 0600), (void *)0x20000804000, 0);
        open("/proc/self/maps", O_RDONLY);
}

Apparently an mmap() is missing for shmat() when g>h and shmaddr is
specified. The mismatch between the host's and the guest's view of the
mapping's tail appears to be causing the SEGV.

