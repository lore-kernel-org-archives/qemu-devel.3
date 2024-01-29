Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C9A7C47422
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jan 2024 10:47:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUP9n-0001D7-UA; Mon, 29 Jan 2024 05:46:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1rUP9l-0001CZ-3f
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 05:46:25 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1rUP9j-0007Ic-Ba
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 05:46:24 -0500
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 40T9QEPI019453; Mon, 29 Jan 2024 10:46:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=date : from : to :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=McmQYp7J6sVvnovt+lwovF1tzvXSehI1y25zdsmCMH0=;
 b=pJ2gCNKQoBqPbUYdMQJ0kHVgBpfExW8gNPbLYOVVGRq1PaKJNWnqis+220icQ+e5XYzk
 oh3MARH2ohEhi6yk9bqyBMj//fF3mHihen7R8MK5A1xdfgKB2/WO4UjtdntJnPgsRHme
 8yyfbmten9xEhpTRHwqXy+Sde/yj9uJrvsFNUMtXg2ZEiyvKg2z+FN3NnfoM4mqYEpQT
 scjIPLDwFrHl9koYB86q75zkYdm0xKSHnMUk/h496NZASR8AL1eIdxPzIPq1UqHowgdR
 HQwpZjz9/GiPE9KcoiXFzXBzD5WQJWlg+sR42mo8m5CrjLc8abHT9O9hiMRIfzqFzSCb lA== 
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vx9cfsn8t-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 29 Jan 2024 10:46:20 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 40T9S1Ka011292; Mon, 29 Jan 2024 10:46:02 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3vweck7ad8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 29 Jan 2024 10:46:02 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 40TAk1Bm18022964
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 29 Jan 2024 10:46:01 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 35A3420040;
 Mon, 29 Jan 2024 10:46:01 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id EBCA52004D;
 Mon, 29 Jan 2024 10:46:00 +0000 (GMT)
Received: from heavy (unknown [9.179.7.240])
 by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Mon, 29 Jan 2024 10:46:00 +0000 (GMT)
Date: Mon, 29 Jan 2024 11:45:59 +0100
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Subject: Re: Re: [PATCH v3 05/33] linux-user/hppa: Simplify init_guest_commpage
Message-ID: <ply57pnockogr2kd5lhyyrllpofhrh7wnnlqysbxh6jxmvydjd@3ox6e6pkdrrg>
References: <20240102015808.132373-1-richard.henderson@linaro.org>
 <20240102015808.132373-6-richard.henderson@linaro.org>
 <kqvg3av32qzov353adhxhk2vx6vifjflacvfy7rjqrw3yiyt7l@rfnalshy7vkw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <kqvg3av32qzov353adhxhk2vx6vifjflacvfy7rjqrw3yiyt7l@rfnalshy7vkw>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: JxSOW5LulirBdpc5TZQiTmhzAKg7d4Zi
X-Proofpoint-GUID: JxSOW5LulirBdpc5TZQiTmhzAKg7d4Zi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-29_06,2024-01-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 mlxlogscore=882
 clxscore=1015 bulkscore=0 lowpriorityscore=0 spamscore=0 impostorscore=0
 mlxscore=0 malwarescore=0 priorityscore=1501 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2401290078
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

On Mon, Jan 29, 2024 at 11:28:59AM +0100, Ilya Leoshkevich wrote:
> On Tue, Jan 02, 2024 at 12:57:40PM +1100, Richard Henderson wrote:
> > If reserved_va, then we have already reserved the entire
> > guest virtual address space; no need to remap page.
> > If !reserved_va, then use MAP_FIXED_NOREPLACE.
> > 
> > Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> > ---
> >  linux-user/elfload.c | 23 ++++++++++++++---------
> >  1 file changed, 14 insertions(+), 9 deletions(-)
> > 
> > diff --git a/linux-user/elfload.c b/linux-user/elfload.c
> > index c166faabab..96d8d4f84c 100644
> > --- a/linux-user/elfload.c
> > +++ b/linux-user/elfload.c
> > @@ -1969,16 +1969,21 @@ static inline void init_thread(struct target_pt_regs *regs,
> >  
> >  static bool init_guest_commpage(void)
> >  {
> > -    void *want = g2h_untagged(LO_COMMPAGE);
> > -    void *addr = mmap(want, qemu_host_page_size, PROT_NONE,
> > -                      MAP_ANONYMOUS | MAP_PRIVATE | MAP_FIXED, -1, 0);
> > +    /* If reserved_va, then we have already mapped 0 page on the host. */
> > +    if (!reserved_va) {
> > +        int host_page_size = qemu_real_host_page_size();
> > +        void *want, *addr;
> >  
> > -    if (addr == MAP_FAILED) {
> > -        perror("Allocating guest commpage");
> > -        exit(EXIT_FAILURE);
> > -    }
> > -    if (addr != want) {
> > -        return false;
> > +        want = g2h_untagged(LO_COMMPAGE);
> > +        addr = mmap(want, host_page_size, PROT_NONE,
> > +                    MAP_ANONYMOUS | MAP_PRIVATE | MAP_FIXED_NOREPLACE, -1, 0);

One question though: if TARGET_PAGE_SIZE > host_page_size, things would
work, because the magic offsets are quite small. But wouldn't it be
overall cleaner to map TARGET_PAGE_SIZE bytes, just to be closer to the
real thing?

