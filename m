Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D023AC369D1
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Apr 2025 14:10:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8JkX-00055Z-31; Fri, 25 Apr 2025 10:09:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hca@linux.ibm.com>) id 1u8JkR-00053B-9Y
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 10:09:47 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hca@linux.ibm.com>) id 1u8JkP-0008VK-65
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 10:09:46 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53PArN4m030598;
 Fri, 25 Apr 2025 14:09:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=pp1; bh=ZCM7TQA3cDdr3KkKsTkqp1Obp+4s9k
 F6CRkIIG1bx2A=; b=LNb1VMDPEP3dpB9G9oM0rFHFTu8OrQcWBF8tZrUXxb/+4B
 tMraCMsfzoDMTVoe3ruOQWGMcsGGGEgZ1D7eNL1WlZOrrTl1SRXbmq9+YkexA6EL
 vIFyqNxAq00mVWpmFt9RjKVQxFXYaYBOkHV/PAibSMTMqQycrwooBcsoVLAd1k4n
 AIYOvtWJQPYz/8g7z51VeaXuDDf/Qad3iGm2iraPtI+AC75J7aBb+p4axvRaeDDd
 ns/V3l39R2aYPYGKbNWqsgSZmrb7ZCnGwoBM8hrxIPJVIJ0BJnNBVWcKwC93+JS4
 kb15avnVgxhi2sZfkghuYAX9I1W152mhiHWyE1qA==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 467y90u7cj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 25 Apr 2025 14:09:35 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53PD6CnU001318;
 Fri, 25 Apr 2025 14:09:35 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 466jfy5h38-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 25 Apr 2025 14:09:35 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 53PE9VlL24117834
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 25 Apr 2025 14:09:31 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 465A82004D;
 Fri, 25 Apr 2025 14:09:31 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C71D92004B;
 Fri, 25 Apr 2025 14:09:30 +0000 (GMT)
Received: from osiris (unknown [9.111.13.86])
 by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Fri, 25 Apr 2025 14:09:30 +0000 (GMT)
Date: Fri, 25 Apr 2025 16:09:29 +0200
From: Heiko Carstens <hca@linux.ibm.com>
To: Niklas Schnelle <schnelle@linux.ibm.com>
Cc: Thomas Huth <thuth@redhat.com>, Farhan Ali <alifm@linux.ibm.com>,
 qemu-devel@nongnu.org, alex.williamson@redhat.com, stefanha@redhat.com,
 mjrosato@linux.ibm.com, philmd@linaro.org, kwolf@redhat.com,
 hreitz@redhat.com, fam@euphon.net
Subject: Re: [PATCH v5 1/3] util: Add functions for s390x mmio read/write
Message-ID: <20250425140929.7180Fdb-hca@linux.ibm.com>
References: <20250417173801.827-1-alifm@linux.ibm.com>
 <20250417173801.827-2-alifm@linux.ibm.com>
 <06f9244c-671c-4215-9d20-7bb69194fae6@redhat.com>
 <aae585ad4d9884e204ff1f153f4d1be5453b284a.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aae585ad4d9884e204ff1f153f4d1be5453b284a.camel@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=aZRhnQot c=1 sm=1 tr=0 ts=680b979f cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=kj9zAlcOel0A:10 a=XR8D0OoHHMoA:10 a=RASPwGoQohVzQn-ICVUA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: CsPJY9RCwawA00jXUpyDOsV-03Pz85LR
X-Proofpoint-ORIG-GUID: CsPJY9RCwawA00jXUpyDOsV-03Pz85LR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI1MDEwMCBTYWx0ZWRfXxLpRJi4bw5ZJ
 ttChqsdtfMQhavw22VYevgmVI/eMAZD9L6FCC9IkA8f5Ho3lx7RtZx1M/l6tXNM9isO3K2eVYVr
 gk6M3wvJLm4rc9apjmeYnZvQ+Mj3dnmPjQxjdi9BL8Aikqn0lg06R4ou+CHY9B93Mdd4SQzZ4u1
 DQPzVK3XEjQwdr+eYiOld9Ws8ORLqQgiktDMUbgAoG/hmfQmAAkx4rq7uUKuJQNDudFOBkr7kFA
 BZfNSZYGxPpwdDQrbMGD22l+gdx9CNZVtHLO1LenarGtaYOprJw29Vg7xrgBg/F5QqHmUfMQg2h
 3JcXOCIljoTSYwbkRmZmLh+2M5uk7oClvOgPsCs+ZutdtoonPzuQqKNlJEJnpcQdpbuvrZ8RQIT
 usy1bV5sw4csqgrmDXhpRCrRBk5avmaf6+Bgf0s/ADlsP5PazMTajGmDuqB7x369+6XJ7Wxk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-25_04,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0
 lowpriorityscore=0 suspectscore=0 adultscore=0 priorityscore=1501
 clxscore=1011 mlxlogscore=433 impostorscore=0 mlxscore=0 malwarescore=0
 phishscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2504250100
Received-SPF: pass client-ip=148.163.158.5; envelope-from=hca@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Fri, Apr 25, 2025 at 12:29:35PM +0200, Niklas Schnelle wrote:
> On Fri, 2025-04-25 at 11:00 +0200, Thomas Huth wrote:
> > On 17/04/2025 19.37, Farhan Ali wrote:
> > > +    asm volatile(
> > > +        /* pcilgi */
> > > +        ".insn   rre,0xb9d60000,%[val],%[ioaddr_len]\n"
> > > +        "ipm     %[cc]\n"
> > > +        "srl     %[cc],28\n"
> > > +        : [cc] "=d"(cc), [val] "=d"(val),
> > > +        [ioaddr_len] "+&d"(ioaddr_len.pair) :: "cc");
> > 
> > Do we need the "&" modifier here? ... at least the kernel does not seem to 
> > use it ...
> 
> From my understanding it's not strictly needed, but I also used it in
> the rdma-core user-space code where I had pointed Farhan. I looked at

It is not needed, since all inputs are consumed before to any output
is written to.

> > > +    asm volatile (
> > > +        /* pcistgi */
> > > +        ".insn   rre,0xb9d40000,%[val],%[ioaddr_len]\n"
> > > +        : [ioaddr_len] "+&d" (ioaddr_len.pair)
> > 
> > dito

Same here, it is not needed.

