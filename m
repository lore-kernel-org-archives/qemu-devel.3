Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCAA4C369C2
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Apr 2025 14:32:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8K5F-0001h7-Ha; Fri, 25 Apr 2025 10:31:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <seiden@linux.ibm.com>)
 id 1u8K5A-0001gD-M1; Fri, 25 Apr 2025 10:31:13 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <seiden@linux.ibm.com>)
 id 1u8K58-0003Yr-CM; Fri, 25 Apr 2025 10:31:12 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53PA41es026461;
 Fri, 25 Apr 2025 14:30:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=pp1; bh=GoUoHZi/HP0QEXV0jU7oEFcHl0nqTa
 8aRsWZBhVoMwA=; b=aHZfHj4aSpYoV73sR1hjhJEU8IizrsPbTDtMh557ZIsF3V
 6uGCPWoBtdF5qqDJoy+ef8mmuK+3CuxNYD1HiiyYkfCa0NoUekMvbMmBX78ZfY5X
 7K8lsRaJpz4SLbIyjYZ2k7+BKuYb7TQ6XnYPgR17wMgfMiZenrhP5MttYHaHgl6r
 MEcOhLMYIETano6EUby+0zD+OfYQkE9Jm57yrSe7zQ2WFpanvlLwV7FtSX0EEf+/
 xb7zctOl4Q+PiswCUBvAc8K5ABcNjFe3t+DjAjLVT/Wvs4OvYU8YS88KC8Z+kzUU
 V/EBZUnQXOO2m1PXVHisuF6TPNvIhJ/5gnbHak3g==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4688ajs5uy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 25 Apr 2025 14:30:54 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53PC4U1U008666;
 Fri, 25 Apr 2025 14:30:53 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 466jfxwm98-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 25 Apr 2025 14:30:53 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 53PEUnes32702776
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 25 Apr 2025 14:30:49 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B75D320043;
 Fri, 25 Apr 2025 14:30:49 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4990A20040;
 Fri, 25 Apr 2025 14:30:49 +0000 (GMT)
Received: from osiris (unknown [9.111.72.247])
 by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Fri, 25 Apr 2025 14:30:49 +0000 (GMT)
Date: Fri, 25 Apr 2025 16:30:47 +0200
From: Steffen Eiden <seiden@linux.ibm.com>
To: Gautam Gala <ggala@linux.ibm.com>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Thomas Huth <thuth@redhat.com>, Janosch Frank <frankja@linux.ibm.com>
Subject: Re: [PATCH v5 3/3] target/s390x: Return UVC cmd code, RC and RRC
 value when DIAG 308 Subcode 10 fails to enter secure mode
Message-ID: <20250425143047.632151-E-seiden@linux.ibm.com>
References: <20250423080915.1048123-1-ggala@linux.ibm.com>
 <20250423080915.1048123-4-ggala@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250423080915.1048123-4-ggala@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI1MDEwMCBTYWx0ZWRfXxjhk/iPyTcvK
 +TMcZw67woHtEaWBd0SxrpVvZJax/O4daEqC7EBC2ST9cbxYo/DF1Mu4Hyl9yUvxa3wBNpwtA/u
 UQ5SJ2zSlxfYgICU70QqbbhLTMjnDGQTQMXY22htxOBFsmZnTH97fdEL2QaCO1lYANsihEf8i5d
 CV9sQ46B+bSiA+a55Ygb1l3eYdxKGyGMjTxsvFZ099/0PWsVhq8uHO9Hknz2Y5XkzANxQWQl13j
 jVcn6Nzi79nzytwZoaswVECIf4zpdXiu+tEA16OZf7F/6Syq//oU43F7p8/lnY+peKLINeQZ3DC
 J7ycnCoya49dCZkXuWczeP60y0z5tB7FmkDLPo79jVwKF09dkudZRTL36ezZZrNWJtBrXMjKt/O
 2BQINj7rVjyONH6da93Ga4kbFBpSc6SYG8ij6JWf86KGLNghipeaolnF+E80G/TcIh2FrDVn
X-Authority-Analysis: v=2.4 cv=F8xXdrhN c=1 sm=1 tr=0 ts=680b9c9e cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=kj9zAlcOel0A:10 a=XR8D0OoHHMoA:10 a=VnNF1IyMAAAA:8 a=HLircMxoZoq3qCPMhvQA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: TSAun840M3rFWj9bKPoGaDXQdsdCPdMa
X-Proofpoint-ORIG-GUID: TSAun840M3rFWj9bKPoGaDXQdsdCPdMa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-25_04,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_spam_definite policy=outbound
 score=100 phishscore=0
 impostorscore=0 mlxscore=100 priorityscore=1501 lowpriorityscore=0
 mlxlogscore=-999 malwarescore=0 clxscore=1015 bulkscore=0 adultscore=0
 spamscore=100 suspectscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2504070000 definitions=main-2504250100
Received-SPF: pass client-ip=148.163.156.1; envelope-from=seiden@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
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

On Wed, Apr 23, 2025 at 10:09:15AM +0200, Gautam Gala wrote:
> Extend DIAG308 subcode 10 to return the UVC RC, RRC and command code
> in bit positions 32-47, 16-31, and 0-15 of register R1 + 1 if the
> function does not complete successfully (in addition to the
> previously returned diag response code in bit position 47-63).
> 

Reviewed-by: Steffen Eiden <seiden@linux.ibm.com>

> Reviewed-by: Janosch Frank <frankja@linux.ibm.com>
> Signed-off-by: Gautam Gala <ggala@linux.ibm.com>
> ---
>  hw/s390x/ipl.c             | 11 ++++----
>  hw/s390x/ipl.h             |  6 +++--
>  hw/s390x/s390-virtio-ccw.c | 14 ++++++-----
>  target/s390x/kvm/pv.c      | 51 +++++++++++++++++++++++++++-----------
>  target/s390x/kvm/pv.h      | 26 +++++++++++++------
>  5 files changed, 73 insertions(+), 35 deletions(-)
> 

