Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 032D8CDE003
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2026 13:43:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcNll-0004El-RL; Wed, 24 Jun 2026 09:36:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1wcNlV-0003xh-NP; Wed, 24 Jun 2026 09:35:43 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1wcNlU-0000qz-4a; Wed, 24 Jun 2026 09:35:41 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65OAmYv8550512; Wed, 24 Jun 2026 13:35:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=o8jp8i
 tipPqzXHUsTnS5C4d7cdE7J6Jc86I9G84zuWw=; b=LI2VEIHx5rvgxHPiBTgD55
 1PXhjTlMybSrPe3ANwNt/WrwmC1nQnlIrlv28TSsX/W7kOZSM874orh3n4hWjzv+
 IQiw4tsGhJkrEAo/nGYheqfUiiXFi/YG2y4J80zFv8VtpQ7SLAi05GN2uwabUdkR
 zZDazoIj6LJDyjon6smBCUwEe7dlTvZf+EAFfbKQsypHe9zjim5nI0PcprOiKJ8P
 FSp1yz9TAAOFcNibUYXB0W+koJ96dkXSVES4k3yBnslJzMcX4uTBVCoNKSzP6zSK
 yQZVhNXg0DhfSsSjyckzkFgxdbZQTcEI6W56zpEopyj68IIWjV6I8K66Nry4Vq4g
 ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ewh9gm832-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 24 Jun 2026 13:35:31 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65ODYfAf022196;
 Wed, 24 Jun 2026 13:35:30 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ex7dg8j83-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 24 Jun 2026 13:35:30 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 65ODZQnh49283348
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 24 Jun 2026 13:35:26 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B9ADA2004B;
 Wed, 24 Jun 2026 13:35:26 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2036620049;
 Wed, 24 Jun 2026 13:35:18 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com (unknown
 [9.39.19.28]) by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Wed, 24 Jun 2026 13:35:17 +0000 (GMT)
Date: Wed, 24 Jun 2026 19:04:52 +0530
From: Aditya Gupta <adityag@linux.ibm.com>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Shivang Upadhyay <shivangu@linux.ibm.com>,
 Sourabh Jain <sourabhjain@linux.ibm.com>,
 Hari Bathini <hbathini@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>,
 Miles Glenn <milesg@linux.ibm.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, devel@lists.libvirt.org,
 Misbah Anjum N <misanjum@linux.ibm.com>,
 Anushree Mathur <anushree.mathur@linux.ibm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 kvm@vger.kernel.org, Gautam Menghani <gautam@linux.ibm.com>,
 Chinmay Rath <rathc@linux.ibm.com>
Subject: Re: [PATCH 8/8] MAINTAINERS: Add self as maintainer for PowerNV
Message-ID: <ajvczRnjoRZhMjA6@li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com>
References: <20260623141933.577981-1-adityag@linux.ibm.com>
 <20260623141933.577981-9-adityag@linux.ibm.com>
 <aju1vc-yqJoaK7CO@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aju1vc-yqJoaK7CO@redhat.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=c62bhx9l c=1 sm=1 tr=0 ts=6a3bdd24 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=pGLkceISAAAA:8 a=YtZjg5rF9uJ-3N_UzN0A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI0MDExMCBTYWx0ZWRfX/hFxx7lYvwSP
 9yBqtO6VuLo8IuXoNAcDLTVmAuAehDcNTmqAiEf15QWXQrx10eqr/Ym8tIyTUHaPTd4yILbYG3b
 3ETA02PfEWw6r1dZKJwgtcRShoWMkwfhZEb7fVSj2MBRBbhJSe3X93i5LOWgqEVEjueyEDpdNAU
 vL+p05N9LfYQE2CGrHTHxJh6+mmStJZMCKPS2tUmHfcqDSyocGOk8GPBB1hVhQjGw8yY6KgeH+n
 TlTzu5Egn+LqtMSvZczYri+3RlvK+L3N4ZnxCQLzV7GYbd1J+P8U/kmoWTNJknyIi//aFjnVi9K
 lIUtdhXcM7RnQDJ/ARCGH4CL+iaZWJNoVTnsgGadHGe+3RkJu1xnr9jIlS0tkpUMtAP6Knj1CE8
 xmh/tYpgfxQ9F3q/mXl/Tdk198dDzQ==
X-Proofpoint-GUID: xicn4HJKaj7ffJ-uljR5JqmGZlMrBaQn
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI0MDExMCBTYWx0ZWRfX/T1I56G09y5q
 o0Sxkut7ly3FvtV8hlKxGzKKbNFOOEhu1VheDWD0AzAlqH0pB9BrRnQHu2pg5lZEjSoPeCkTjEt
 ovFZEREhpVvoNZi/EXe9RbQwTEtGyac=
X-Proofpoint-ORIG-GUID: ZMQldKijTdF4d8aQCDLcVGpWolXQUaEe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-24_03,2026-06-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 spamscore=0 bulkscore=0 adultscore=0
 suspectscore=0 malwarescore=0 classifier=typeunknown authscore=0 authtc=
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.22.0-2606150000 definitions=main-2606240110
Received-SPF: pass client-ip=148.163.158.5; envelope-from=adityag@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

On 26/06/24 11:47AM, Daniel P. Berrangé wrote:
> On Tue, Jun 23, 2026 at 07:49:33PM +0530, Aditya Gupta wrote:
> > Add myself as maintainer for PowerNV machine, and remove the
> > reviewer entry
> > 
> > Signed-off-by: Aditya Gupta <adityag@linux.ibm.com>
> > ---
> >  MAINTAINERS | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 93df53d87f63..67f65bff3913 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -1646,7 +1646,8 @@ F: tests/functional/ppc64/test_tuxrun.py
> >  
> >  PowerNV (Non-Virtualized)
> >  M: Nicholas Piggin <npiggin@gmail.com>
> > -R: Aditya Gupta <adityag@linux.ibm.com>
> > +M: Aditya Gupta <adityag@linux.ibm.com>
> > +G: @adi-g15-ibm
> 
> Please drop the G: line, as I'm changing the approach for recording
> this info to be more automatic.

Sure Daniel, will remove it in v2.

Thanks,
- Aditya G


