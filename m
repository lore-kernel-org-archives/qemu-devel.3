Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7B5AC87FCB
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Aug 2025 20:47:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ujl1q-0004vv-C1; Wed, 06 Aug 2025 16:46:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1ujl1m-0004tC-6h; Wed, 06 Aug 2025 16:46:26 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1ujl1j-0003wU-Qs; Wed, 06 Aug 2025 16:46:25 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 576Hk5JV012329;
 Wed, 6 Aug 2025 20:46:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:reply-to:subject:to; s=pp1;
 bh=hFUbnEmKvWsvlEmg+GoBPi41yXcU/wjsef60+KiMBNs=; b=LtIXhkUGcL3B
 55qghxxt9vYmlb2kUVV7uHZbpYZq1ccM1Xlg01fEo0AcJqTsYbq6crUBHX8FpAex
 k8NasxbBdsNAUh+8ti2C6ttcC5E95M9Tip/7Sd9tL3303HscxUguPMuR2EcvVHA9
 dZFVnPx0TdRy4LQS552QiOwv7XWUASIfQNoC0ACp0Iv8GkU3Q8D/Om7VKtYDoD6w
 bCVmMYfMhNXVaekVHx7V+fVeUOpWiDdeJ0eLxgEnZFB20Zl541RXuyKxvyLAl9qV
 ybViPCMCaiMiWcYk8wzQ8TTb6sgheAq80uGpQDifzEFl93/eg2HsEOQ/w8A9J4qE
 i5tKYFGu+A==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48bq63pexj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 06 Aug 2025 20:46:22 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 576KkLqW029765;
 Wed, 6 Aug 2025 20:46:21 GMT
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48bq63pexh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 06 Aug 2025 20:46:21 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 576K3GCY031314;
 Wed, 6 Aug 2025 20:46:20 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 48bpwndf5c-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 06 Aug 2025 20:46:20 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com
 [10.39.53.233])
 by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 576KkJLM32309908
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 6 Aug 2025 20:46:19 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 54D635804E;
 Wed,  6 Aug 2025 20:46:19 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 76CA75803F;
 Wed,  6 Aug 2025 20:46:18 +0000 (GMT)
Received: from mambor8.rchland.ibm.com (unknown [9.10.239.198])
 by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Wed,  6 Aug 2025 20:46:18 +0000 (GMT)
Message-ID: <6afc919bdb18166a71a2dba1a3862709629d5e08.camel@linux.ibm.com>
Subject: Re: [PULL 00/50] ppc queue
From: Miles Glenn <milesg@linux.ibm.com>
To: =?ISO-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>, Michael Tokarev
 <mjt@tls.msk.ru>, qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, Daniel Henrique Barboza
 <danielhb413@gmail.com>, Michael Kowal <kowal@linux.ibm.com>, Caleb
 Schlossin <calebs@linux.ibm.com>, Gautam Menghani <gautam@linux.ibm.com>,
 qemu-stable <qemu-stable@nongnu.org>
Date: Wed, 06 Aug 2025 15:46:18 -0500
In-Reply-To: <4468aea8-b8cc-4313-abbe-8a5f58a35adc@redhat.com>
References: <20250721162233.686837-1-clg@redhat.com>
 <10177005-d549-41bc-b0eb-c98b7e475f97@tls.msk.ru>
 <ce863981-3d5e-4ec4-94ee-e35d773eab78@redhat.com>
 <fe6a0924-aff9-4881-9c2a-5665776d619f@tls.msk.ru>
 <dc796c6ae712a1a63eba2c6ab9c5c59b03942f50.camel@linux.ibm.com>
 <4468aea8-b8cc-4313-abbe-8a5f58a35adc@redhat.com>
Organization: IBM
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-27.el8_10) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA2MDEzOCBTYWx0ZWRfX4/tvXDMTWMrs
 kjXyHQJOo2THShiux7nj1USbcsmYqde+Z17c42A3aWJOJb673vEhUk2dE49LrQ1QmyIN2QFVKWp
 3YU31+pkFucjdbKktkuvNpD4tD9V3oNrqw+LEWQAdpKtWrbWuX3GdAPUuevsaPXzA1663xn9kJt
 A3JsVqy9waS/yjZ/0pWsg0/mb7elTkxVqYfh7WfbkGL0t4ksb/WtDpPyu1GfxpTKFu6H3jYS0Zn
 FKi1Ikb9Ui9Pw9Ygjn12K/WavBo2yFr4i66kMYPSZqhBFiTegHFy+y00GkelhPAwwYgFDECtN55
 +fDx745lrXipigLN8L2KsTYTvW0KVLyH01thccV/4565fUEI3jX8oWSlvpYr7GRdsTa7QaazWix
 55DuHjOzt6NkX0R2sfIex9cM5LnSiQnk5DhXnZUCXfqWM4jHxe+UoOLJMqrjwqY7DMpQhskr
X-Proofpoint-ORIG-GUID: I2JIuqLay92Li5KNwFMgu6N1XMy0_Euq
X-Authority-Analysis: v=2.4 cv=LreSymdc c=1 sm=1 tr=0 ts=6893bf1e cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=VuoU5WFxUHF8b41vZTMA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: g9qmyPAhcOuRN7pFI8q29-gEHl9OhOsF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-06_04,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 lowpriorityscore=0 phishscore=0 spamscore=0
 priorityscore=1501 impostorscore=0 adultscore=0 mlxlogscore=899 bulkscore=0
 malwarescore=0 mlxscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2507300000
 definitions=main-2508060138
Received-SPF: pass client-ip=148.163.158.5; envelope-from=milesg@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-To: milesg@linux.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, 2025-08-05 at 22:07 +0200, Cédric Le Goater wrote:
> On 8/5/25 18:26, Miles Glenn wrote:
> > On Tue, 2025-07-22 at 17:25 +0300, Michael Tokarev wrote:
> > > On 22.07.2025 16:37, Cédric Le Goater wrote:
> > > > + Glenn, Michael, Caleb, Gautam
> > > > 
> > > > On 7/22/25 13:44, Michael Tokarev wrote:
> > > > > 21.07.2025 19:21, Cédric Le Goater wrote:
> > > > > 
> > > > > > ----------------------------------------------------------------
> > > > > > ppc/xive queue:
> > > > > > 
> > > > > > * Various bug fixes around lost interrupts particularly.
> > > > > > * Major group interrupt work, in particular around redistributing
> > > > > >     interrupts. Upstream group support is not in a complete or usable
> > > > > >     state as it is.
> > > > > > * Significant context push/pull improvements, particularly pool and
> > > > > >     phys context handling was quite incomplete beyond trivial OPAL
> > > > > >     case that pushes at boot.
> > > > > > * Improved tracing and checking for unimp and guest error situations.
> > > > > > * Various other missing feature support.
> > > > > 
> > > > > Is there anything in there which should be picked up for
> > > > > stable qemu branches?
> > > > 
> > > > May be the IBM simulation team can say ?
> > > > I think this would also require some testing before applying.
> > > > 
> > > > Which stable branch are you targeting ? 7.2 to 10.0 ?
> > > 
> > > There are currently 2 active stable branches, 7.2 and 10.0.
> > > Both are supposed to be long-term maintenance.  I think 7.2
> > > can be left behind already.
> > > 
> > > Thanks,
> > > 
> > > /mjt
> > 
> > Michael T.,
> > 
> > All of the XIVE fixes/changes originating from myself were made in an
> > effort to get PowerVM firmware running on PowerNV with minimal testing
> > of OPAL firmware.  However, even with those fixes, running PowerVM on
> > PowerNV is still pretty unstable.  While backporting these fixes would
> > likely increase the stability of running PowerVM on PowerNV, I do think
> > it could pose significant risk to the stability of running OPAL on
> > PowerNV.  With that in mind, I think it's probably best if we did not
> > backport any of my own XIVE changes.
> 
> These seem to be interesting to have :
> 
> ppc/xive2: Fix treatment of PIPR in CPPR update
> ppc/xive2: Fix irq preempted by lower priority group irq
> ppc/xive: Fix PHYS NSR ring matching
> ppc/xive2: fix context push calculation of IPB priority
> ppc/xive2: Remote VSDs need to match on forwarding address
> ppc/xive2: Fix calculation of END queue sizes
> ppc/xive: Report access size in XIVE TM operation error logs
> ppc/xive: Fix xive trace event output
> 
> ?
> 
> Thanks,
> 
> C.
> 

I'm still not sure that the benefit is worth the effort, but I
certainly don't have a problem with them being backported if someone
has the desire and the time to do it.

Thanks,

Glenn




