Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7C5DCCD19A
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Oct 2025 12:02:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9j9D-0007CN-BG; Fri, 17 Oct 2025 08:01:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1v9j95-00072Y-K7; Fri, 17 Oct 2025 08:01:19 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1v9j78-00014l-OZ; Fri, 17 Oct 2025 08:01:19 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59H9NFWj021748;
 Fri, 17 Oct 2025 11:59:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=pp1; bh=UoiXajcXxrzbl/VwEhcR6KCaqfZgwK
 Z44F/Y2ouyG8o=; b=CuoDvNXN0UQCWyKA+I9OAqGseMmGZFGt95dJPRb3WmPQH8
 xirUEZ+5eiWK5GZmp8mofs+zoGKEZiX0b1Ks1r5bD8fSXFMamluvuKznsHY7vSyR
 VE5/59ehu1PD+GbeDnk16H+Z1FMuxZaXlb+cjbjCu+s/SW5QmKRPmRpdyki/b7TR
 2qds8JExZbeWPJbG9w6KDHKd187mBy8T6mYTQn3BQPeP62cGqOmFNv5ipvT/LKok
 9R8Emkgka2l0IhkZf9CGZmjITB5c1zPIze5LlxbBFjSLd0F0zdd+pvs8V+i4CcFl
 cDVyRQzhJ/tt8z3sUSldkdd9DMek6W5NkGPWQQ0A==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49qey9aj0w-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 17 Oct 2025 11:59:12 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 59HBo7C5028136;
 Fri, 17 Oct 2025 11:59:12 GMT
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49qey9aj0s-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 17 Oct 2025 11:59:12 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59H9dOIm014981;
 Fri, 17 Oct 2025 11:59:11 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 49r3sjvujt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 17 Oct 2025 11:59:11 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 59HBx7RR28443224
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 17 Oct 2025 11:59:07 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 667F220040;
 Fri, 17 Oct 2025 11:59:07 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 284DC2004B;
 Fri, 17 Oct 2025 11:59:05 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com (unknown
 [9.39.26.210]) by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Fri, 17 Oct 2025 11:59:04 +0000 (GMT)
Date: Fri, 17 Oct 2025 17:29:03 +0530
From: Aditya Gupta <adityag@linux.ibm.com>
To: Sourabh Jain <sourabhjain@linux.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Hari Bathini <hbathini@linux.ibm.com>
Subject: Re: [PATCH v4 3/8] hw/ppc: Trigger Fadump boot if fadump is registered
Message-ID: <b7evdypwdhwnxurt4etjm3aryodf2cqgzxaemmbvii7lo36v53@2r5uzeowpjlx>
References: <20250323174007.221116-1-adityag@linux.ibm.com>
 <20250323174007.221116-4-adityag@linux.ibm.com>
 <0dda0c58-0351-41a6-bc76-56e46aa8f02c@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0dda0c58-0351-41a6-bc76-56e46aa8f02c@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Dws6Uj4uLt5q7rD_lexy3GcuTb3wCL7a
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAxMSBTYWx0ZWRfXyJNdoUvmO9Du
 TH31Fpz7BT7wSdoNcSagh39/1grsk+fdbW9RR1836g71zPcyjefeM2Abm1OIVfQRY0XuRDFHqJ/
 rKveEFo1kteaS7vg0Yke8mPLPAjs17cIOhCyK5u6HGgXwDOBJnAGInGxZNcroUR8AFKfO61MRSB
 gjrURjrSlmLthWbOEgCTxY0zBJsbjtq6gewT0K11A3zgZGTzMcO5MNGheHMx6LDSo/0NxJ+N1si
 jwIONjZXvNc532BiFpfkQ4/ZM5Wizi5J5odmXPWi+tW47SomLmMO78d2ti7Pm8LSHKXnmv+2z5e
 qe8zI2kHyFJX51mWIkFa0d7Cgsli4F2C+GHxcqwB/WfrkIIRMCiUFHRKzoPK2rQiwc2CFUA4xjs
 ieP3SzIvKB3hJDAX4Nck+ySOXy4ztQ==
X-Proofpoint-GUID: uXDuvOvtpi3MVIJDInQF06lJzLrgVy3x
X-Authority-Analysis: v=2.4 cv=QZ5rf8bv c=1 sm=1 tr=0 ts=68f22f90 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=kj9zAlcOel0A:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=8BSAm38HViyM-3UT0loA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-17_04,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 phishscore=0 bulkscore=0 suspectscore=0
 spamscore=0 malwarescore=0 impostorscore=0 clxscore=1015 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510110011
Received-SPF: pass client-ip=148.163.156.1; envelope-from=adityag@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
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

On 25/10/17 04:56PM, Sourabh Jain wrote:
> 
> > <...snip...>
> > +    /*
> > +     * Mark next boot as fadump boot
> > +     *
> > +     * Note: These is some bit of assumption involved here, as PAPR doesn't
> > +     * specify any use of the dump status flags, nor does the kernel use it
> > +     *
> > +     * But from description in Table 136 in PAPR v2.13, it looks like:
> > +     *   FADUMP_STATUS_DUMP_TRIGGERED
> > +     *      = Dump was triggered by the previous system boot (PAPR says)
> > +     *      = Next boot will be a fadump boot (My perception)
> 
> Can we say assumption made or assumed instead of My perception.
> 
> > +     *
> > +     *   FADUMP_STATUS_DUMP_PERFORMED
> > +     *      = Dump performed (Set to 0 by caller of the
> > +     *        ibm,configure-kernel-dump call) (PAPR says)
> > +     *      = Firmware has performed the copying/dump of requested regions
> > +     *        (My perception)
> > +     *      = Dump is active for the next boot (My perception)
> 
> Same here.

Done. Thanks Sourabh !

- Aditya G



