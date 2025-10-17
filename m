Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94AC3CCD195
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Oct 2025 11:58:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9j56-0005KT-C1; Fri, 17 Oct 2025 07:57:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1v9j54-0005Jy-PR; Fri, 17 Oct 2025 07:57:10 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1v9j4y-0000fL-9v; Fri, 17 Oct 2025 07:57:10 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59H9NqTw001623;
 Fri, 17 Oct 2025 11:56:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=pp1; bh=aLQolF2CvSldNTsxuj2hMD1/rOQwuo
 Z5DtW78N1vz/8=; b=UkDwOK9bBaCfEJEI5cpTGqTY9Be0JLpFN9r8ID7IWj5wAi
 jDWc056ZO/dOjd98jARRgpshTa3IwdqVEaRN1AvPPCcT5mWD1pSuX1ZbNP/pMrbg
 bddp6FIGGpr9reCSmZ+hVrLHHv7ZvpmHSsYwK3v08YS8UFAlZ1/8pxDtbuAhawhi
 5zFVdo8ZAKSw3iVS/0sY652OoGojqICTZMJ+GTZI4ewdvi7AQP8QJJ85lWdCpEx9
 gq3eKQCFM2RQ3EutN7mNJk4atgrrWuBGCYgVFSKGMHaAyBluM78EUzxJ4Avjdyvs
 thK+8SA+QeSaRPosdEmVgvRMXQ0PPupMeIDg5S3A==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49rfp8dc5v-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 17 Oct 2025 11:56:59 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 59HBsGU9003742;
 Fri, 17 Oct 2025 11:56:58 GMT
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49rfp8dc56-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 17 Oct 2025 11:56:58 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59HBnD3W017008;
 Fri, 17 Oct 2025 11:56:57 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 49r32kd14g-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 17 Oct 2025 11:56:57 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 59HBurEX39780854
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 17 Oct 2025 11:56:53 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1176F20110;
 Fri, 17 Oct 2025 11:56:53 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DFBA72010C;
 Fri, 17 Oct 2025 11:56:50 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com (unknown
 [9.39.26.210]) by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Fri, 17 Oct 2025 11:56:50 +0000 (GMT)
Date: Fri, 17 Oct 2025 17:26:49 +0530
From: Aditya Gupta <adityag@linux.ibm.com>
To: Sourabh Jain <sourabhjain@linux.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Hari Bathini <hbathini@linux.ibm.com>
Subject: Re: [PATCH v4 1/8] hw/ppc: Implement skeleton code for fadump in
 PSeries
Message-ID: <zwhly2nrk7taklqsst5hhfeuukcpuakez2hhzsmueusgyflzbu@kqqjo4uwtu6h>
References: <20250323174007.221116-1-adityag@linux.ibm.com>
 <20250323174007.221116-2-adityag@linux.ibm.com>
 <0827c237-df2b-4a7a-8157-c496c4fa98cc@linux.ibm.com>
 <m5l3cqemaikgnrjqej3zqcdpo4o6ukj3id3ojx2ron4wjpbtul@roskcbsdes2g>
 <d2b492d2-6a21-490a-bba0-8b8f4e33d446@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d2b492d2-6a21-490a-bba0-8b8f4e33d446@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: N0IxiBqVPeNb7MG6CU0jjrCGY7EaDYlo
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDEyMDA4NCBTYWx0ZWRfXymABb8uUybsb
 57j0JvUuQJdy57TAQHVHvSaxmP/nIA/xcmQ3xfSsWWphb8LxpAxMUVGw7DuSSCvZbsTPDdGLPIP
 sSZw0YA7seMZYvq8hTKrb/eO9OWse9z5e6U85WQe4YBoyrY3xCX3YhcXJYjir0BzszEQtb2YRzG
 5Tq/vjsQ1dgu22EYQWtwWcsTXAurdi5hjduEtcekqMA1AaJ61MLwla5+rcOVO4Z1HiwGnnzPS2E
 WeyjEaBVOS5cUL19HLX7OL6Tkh+ZIQU1Bgza5H3QswGFP1HNKsDiwkH7NCAEJMzjovPpyaosQH+
 AKMTxIEPzhu88uMcVVHw9ILNu1+6hZLTpH2uW1+z3q5bA49IS1lFqhZJWtC5GsctWDHkhe4ZWx0
 VryETDPLht3gBlmUh/k28pAka1VYMg==
X-Proofpoint-GUID: HJ9EkNNzRuvrlQ7H0lPwp9p881VtDxOx
X-Authority-Analysis: v=2.4 cv=af5sXBot c=1 sm=1 tr=0 ts=68f22f0b cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=kj9zAlcOel0A:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=ainWpnNhXql5t2CvMZ0A:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-17_04,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 spamscore=0 adultscore=0 suspectscore=0
 bulkscore=0 phishscore=0 lowpriorityscore=0 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510120084
Received-SPF: pass client-ip=148.163.156.1; envelope-from=adityag@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

> > > > +
> > > > +struct SpaprMachineState;
> > > 
> > > Didn't understand the reason for the above forward declaration.
> > Yes, in this patch it doesn't make sense, when merging the 1st and 2nd
> > patch, then we see the use. Idea is as explained below.
> > 
> > It is because it's defined in spapr.h, and we use SpaprMachineState at
> > the end of this header in declaration of 'do_fadump_register'.
> > 
> > But spapr.h includes spapr_fadump.h, so can't include that else it will
> > become a cyclic dependency.
> > 
> > Hence forward declaration was a way to solve that cyclic dependency.
> Yeah I got that while reviewing the second patch in the series.
> 
> Why are we merging 1st and 2nd patch?

Based on Harsh's review that it made sense to not have a stub for
register, and implement all register/unregister/invalidate commands in
single patch, hence merging 1st and 2nd patch.

- Aditya G

> 
> - Sourabh
> 

