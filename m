Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8992CD3445
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2026 16:01:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wLNdF-0003VN-FC; Fri, 08 May 2026 12:00:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1wLNd9-0003SU-6O; Fri, 08 May 2026 12:00:48 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1wLNd7-0002Pv-HM; Fri, 08 May 2026 12:00:46 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6481dGIK3012905; Fri, 8 May 2026 16:00:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=cps/Yz
 XopmLfv0cFK6jGdwMoG/lbhlpooOJrBrbq02k=; b=EAiGF4n15aPk5xU6MKcaay
 YKfkWIwrXhQfr8aRGiQ7rp6JEn3N0nj+TCyEZ6dYKB0Gp7aw6+IPMtrg5YJpVYI2
 HC/fByLykxw8AkpEUbmgd8IpwuH4/CmPspWq2f7BF73JM3XNZHo1ncdjp4PvGvpP
 XcrRnDQxRTANT43GKC8CyhWKcwycyqbDutvChnEbbFWLWC1veXksJZ7UslcgXblg
 Rr64ICeEoVe/DVBcCwvugMYBQqZlLN69gA7oW7i8txu69Z4tMOs8aBFju/nz2RV3
 ppQp/dr6fqTA9/A7lTDvxiuMJi0hpQyuv+JDS2vw4nudiF0dj0iRd2FdTo2hkGFg
 ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dw9y53777-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 08 May 2026 16:00:35 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 648Fsbnq005667;
 Fri, 8 May 2026 16:00:34 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4e10073xd9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 08 May 2026 16:00:34 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 648G0TGD49021310
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 8 May 2026 16:00:29 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B26A620043;
 Fri,  8 May 2026 16:00:29 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3D0B520040;
 Fri,  8 May 2026 16:00:23 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com (unknown
 [9.124.210.83])
 by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Fri,  8 May 2026 16:00:22 +0000 (GMT)
Date: Fri, 8 May 2026 21:30:19 +0530
From: Aditya Gupta <adityag@linux.ibm.com>
To: Saif Abrar <saif.abrar@linux.vnet.ibm.com>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, clg@kaod.org,
 npiggin@gmail.com, fbarrat@linux.ibm.com, mst@redhat.com,
 marcel.apfelbaum@gmail.com, cohuck@redhat.com, pbonzini@redhat.com,
 thuth@redhat.com, lvivier@redhat.com, danielhb413@gmail.com,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, jishnu@linux.ibm.com
Subject: Re: [PATCH v4 0/9] pnv/phb4: Update PHB4 to the latest PHB5 spec
Message-ID: <af4HEUe0erFyaQmB@li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com>
References: <20260210134110.1515322-1-saif.abrar@linux.vnet.ibm.com>
 <20260305060923.3753402-1-saif.abrar@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260305060923.3753402-1-saif.abrar@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA4MDE1NiBTYWx0ZWRfX5omAMPA6qwTa
 HXXslbnJfQUYKY7K8nA8fciqOo3CFgyto7MvfWLGirKPzxYeKcrU4V8gYbz1vyBtRwBjAOaxM77
 Psx8+yswmdxMrO+MbJ6P+OEIZ309k9gs0eB/z4gFMza5BPooHDwaGQ3QVuZ5e4UiKFL3bFCFA8P
 3ELEqhOIZfIgrNJyWxUv6AdejwOB9gJ9yuxcb3p2Zh09bvZAtpRj1S1d2S9gTBAFzkPJdOizZA/
 vGCipqW4dwRCSYLMPmVjMqCDqxgp5fixJSk0s/kZUmDC6wD94RkLMA0vIXOKB6Tpz6VmtDwuMHF
 43glPbkPtk9kAxSeVgwKX+0KKRzkNwmHuvGWDntWuN93jO2W4my0ow+wh4rsVwGy0VvV2Z3knmS
 tQNyMh3X/1CyMxnsKZp9+Px1Dj3YvRAZgZ7ppHVzrq9X2MOrAvm1YwfXiL5xNEVF7hw6mhtZ5Eu
 RLZjwHLqAA3XAswudyw==
X-Authority-Analysis: v=2.4 cv=J4GaKgnS c=1 sm=1 tr=0 ts=69fe08a4 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=p0WdMEafAAAA:8
 a=VnNF1IyMAAAA:8 a=l3JJ0GewlTvkCApe_08A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: Ihyo90Yc2W-3d899CP8dnvpJHxNzixOx
X-Proofpoint-ORIG-GUID: PBeYMwPFVBnhCTBUAPhZjcmSsMZcj6nX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-07_02,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1011 malwarescore=0 bulkscore=0 suspectscore=0
 priorityscore=1501 spamscore=0 phishscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605080156
Received-SPF: pass client-ip=148.163.158.5; envelope-from=adityag@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 26/03/05 12:09AM, Saif Abrar wrote:
> Hello,
> 
> This patchset v4 resolves the tsan build failure seen in
> https://gitlab.com/mstredhat/qemu/-/jobs/13201554945
> 
> Few variables were declared directly after a case label inside a switch,
> causing the compilation failure.
> These are now moved to the top of the block.
> 
> This series updates the existing PHB4 model to the latest spec:
> "Power Systems Host Bridge 5 (PHB5) Functional Specification Version 0.5_00".
> 
> Updates include the following:
> - implemented sticky reset logic
> - implemented read-only, write-only, W1C and WxC logic
> - return all 1's on read to unimplemented registers
> - update PCIE registers for link status, speed and width
> - implement IODA PCT debug table without any functionality
> - update LSI Source-ID register based on small/big PHB number of interrupts
> 
> Also, a new testbench for PHB4 model is added that does XSCOM read/writes
> to various registers of interest and verifies the values.

Thanks for introducing phb5, saif.

I am currently seeing powernv functional tests failing with the patches
applied:

	 1/16 qemu:func-thorough+func-ppc64-thorough+thorough / func-ppc64-hv                    SKIP              0.17s   0 subtests passed
	▶  2/16 test_powernv.PowernvMachine.test_powernv10                                       FAIL
	▶  2/16 test_powernv.PowernvMachine.test_powernv11                                       FAIL
	 3/16 qemu:func-thorough+func-ppc64-thorough+thorough / func-ppc64-fadump                OK              166.62s   1 subtests passed
	▶  2/16 test_powernv.PowernvMachine.test_powernv9                                        FAIL
	 2/16 qemu:func-thorough+func-ppc64-thorough+thorough / func-ppc64-powernv               ERROR           182.93s   exit status 1

Able to consistently reproduce it with: 'make check-functional-ppc64 -j4'

Bisect points to below commit:

	commit 9b95949d3eb9e733973c692b0e8e0b9043df98e9
	Author: Saif Abrar <saif.abrar@linux.vnet.ibm.com>
	Date:   Thu Mar 5 00:09:04 2026 -0600
	
	    pnv/phb4: Add reset logic to PHB4

Can you fix the above failure ?

Meanwhile, will be reviewing the series.

Thanks,
- Aditya G


