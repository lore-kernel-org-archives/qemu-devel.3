Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A68D2E83855
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Feb 2026 06:17:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vsEOC-0003bY-7a; Tue, 17 Feb 2026 01:16:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1vsEOA-0003an-73; Tue, 17 Feb 2026 01:16:50 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1vsEO8-0006pJ-7e; Tue, 17 Feb 2026 01:16:49 -0500
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 61GLBb3w2422918; Tue, 17 Feb 2026 06:16:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=pp1; bh=deQAodJ0ynLNlXSUtLxSzRCTUXQ2tV
 9AHQIrl1CwJLM=; b=tKKCS5BeBre4vY1EILhAqy5Oi29FYwBGLpCAcS0GRn/0YQ
 POPBe9s0bwpSQSWIRJxnYFkM3rVf9DodSa1wibgzxRG/ECsFdqlA6LXosVvmMkS8
 9P8aZIpOlVcG4MsJ/Bbm8kFprltR2Uwq8lHdf8q+KaeT0Nf1+0+Hh/FiUh/LLXrC
 cU9z+B1LdZBSrxRyCaUDrft9SsCzrwBFpqWso4pZdeCDgjoag82Qy79dA0QNQr4J
 N0m7OODQY+nSQS5cg8TwzNRpg+tQtKlUmZkABvgi2JhIqQFd7Llyfg5+qsKMNAwV
 QpeTdjzXP3QeYphzaCOWUxdpk1AYFaK77xlXo1Mg==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cajcqtqbu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 17 Feb 2026 06:16:46 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 61H3EaOA015697;
 Tue, 17 Feb 2026 06:16:45 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ccb451as9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 17 Feb 2026 06:16:44 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 61H6GftC58458396
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 17 Feb 2026 06:16:41 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E7E7120043;
 Tue, 17 Feb 2026 06:16:40 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A760920040;
 Tue, 17 Feb 2026 06:16:39 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com (unknown
 [9.109.199.210])
 by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Tue, 17 Feb 2026 06:16:39 +0000 (GMT)
Date: Tue, 17 Feb 2026 11:46:37 +0530
From: Aditya Gupta <adityag@linux.ibm.com>
To: Hari Bathini <hbathini@linux.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 Sourabh Jain <sourabhjain@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
Subject: Re: [PATCH v2 0/9] Implement MPIPL for PowerNV
Message-ID: <aZQHq8MUPILBZHJ2@li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com>
References: <20251206055648.1908734-1-adityag@linux.ibm.com>
 <7c6031bb-14ab-4c9b-82cc-5a0b67c6d02e@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7c6031bb-14ab-4c9b-82cc-5a0b67c6d02e@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 6dh2I7WbChrxtB52jl9bpkpmn_7O3N60
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE3MDA0OSBTYWx0ZWRfXzg3YljI5b7Wq
 fh57lhJU8uBfF76jARIKZpeAmqwOD2hinN2KUtz9HtJEDIY7Woh9KcJT1A6XHUivvpAoTwf2g75
 m25IMWRsYYK/MCIW1QdKxFbzvHCyRgGOrpTvR/ggxDfdWE8oasKycCSqr9rgEm46rdEu5+UpcYH
 njodic5h+i5HNDz07FbW36VlEPiKYDQtzdquL9a9aE1XQ74olnTvqHmI8gEBzeDaa8xPWuhln2b
 QUQxNommVMpF+ty4DqzDW2+W18AcYeWeToVm0RkQbYUOZjQl2m6/A2H4KGPJNj8T5gE+2LRO9+I
 3iKM8bcx/TCF21gRJyu2FivqhOTIij4K/Kr/S3q6OJfq56nQWGBWP8+CHG8kOKyuwQLk74DM6Ve
 m6mfBZwqUnjRwyroIVthtEar3Azl0UGsl5DjUn5FfcfiGhR259sGCqLLRzWGT6AFlGrPr/Zbx24
 LqI11oAYTHKn7vMwLSw==
X-Authority-Analysis: v=2.4 cv=UPXQ3Sfy c=1 sm=1 tr=0 ts=699407ce cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=kj9zAlcOel0A:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=EEfntKJWBf9MdpMMrQcA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: 6dh2I7WbChrxtB52jl9bpkpmn_7O3N60
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-17_01,2026-02-16_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 phishscore=0 impostorscore=0 adultscore=0
 bulkscore=0 clxscore=1015 lowpriorityscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602170049
Received-SPF: pass client-ip=148.163.156.1; envelope-from=adityag@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 26/01/19 01:09PM, Hari Bathini wrote:
> 
> 
> On 06/12/25 11:26 am, Aditya Gupta wrote:
> > Overview
> > =========
> > 
> > <...snip...>
> >
> > Both SBE's and hostboot responsiblities have in implemented in the SBE code
> > in QEMU.
> 
> s/have in implemented/are implemented/

Will fix it Hari.

Thanks,
- Aditya G

