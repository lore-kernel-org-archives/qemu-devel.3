Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 699D5CD98CE
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2026 07:21:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXwCP-0005ZP-Jz; Fri, 12 Jun 2026 03:21:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1wXwCM-0005Y5-JY; Fri, 12 Jun 2026 03:21:02 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1wXwCJ-0006tP-2M; Fri, 12 Jun 2026 03:21:02 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65BNU5Vu4146539; Fri, 12 Jun 2026 07:20:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=Edx9mg
 LO5DnsSqO31NffKKxiZeGgcRggL3RU8RsPKdY=; b=E3LbRZya3Zq9ppNE/Q7tyG
 N0E5vojhe/HnCP4ZQg2ghHA47zrlkVF8oOgm2ayaG0vP3cWWKuCp0P0ad+FgrAFp
 hyo0SOsOsCJfeObJPrq7j213XuXZ2L7fsIB30m9AkLeURFlwSZg8OYdEuXiqmaTR
 7CMOs6xQvr790REGbRJ7SpISQ7xSO4oFtRcr7FcTnpkAEWMIlxobjQTkdwh8A1Vx
 WJ+kNooJEMXcE4SIb3HGYQwSfvpxLO+yDdU/mB+p6EuHAedVO4BWVbFtYsOkRSVF
 9MSaTFleWcwHcG1mVEB+aTushEycVfrkUXcruqS5dSWjvWqPIKDiRx6r55AekPLg
 ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4eqe8c7qx1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 12 Jun 2026 07:20:55 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65C7K0Bh003778;
 Fri, 12 Jun 2026 07:20:54 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4eqe09xrxc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 12 Jun 2026 07:20:54 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 65C7KoMY50332156
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 12 Jun 2026 07:20:50 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C16E820043;
 Fri, 12 Jun 2026 07:20:50 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BBB0120040;
 Fri, 12 Jun 2026 07:20:45 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com (unknown
 [9.124.211.181])
 by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Fri, 12 Jun 2026 07:20:45 +0000 (GMT)
Date: Fri, 12 Jun 2026 12:50:42 +0530
From: Aditya Gupta <adityag@linux.ibm.com>
To: =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Miles Glenn <milesg@linux.ibm.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, devel@lists.libvirt.org,
 kvm@vger.kernel.org, Misbah Anjum N <misanjum@linux.ibm.com>,
 Shivang Upadhyay <shivangu@linux.ibm.com>
Subject: Re: [PATCH 4/4] ppc/pnv: Remove Power8E and Power8NVL CPUs
Message-ID: <aiuy1bOIZfwnWLCx@li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com>
References: <20260610090800.3672832-1-adityag@linux.ibm.com>
 <20260610090800.3672832-5-adityag@linux.ibm.com>
 <c3abad18-a3dc-4cf8-b552-18946b1dab64@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c3abad18-a3dc-4cf8-b552-18946b1dab64@redhat.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjEyMDA2MiBTYWx0ZWRfX9JYAosxA4sb9
 IPa0vcA5rwQrsUnr0/OVU1/WpBlmnTMHkvx7P8q/EUaPbYIeXNQaF/nw9YRjHkDLsdmPSEytkHs
 +AndwTmGH3foXUNBzQ3sqI6LHVW3Pjk=
X-Authority-Analysis: v=2.4 cv=AYCB2XXG c=1 sm=1 tr=0 ts=6a2bb357 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=pfJ4YV6O0BFcPFKEksUA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: _ARuWuQGQFMj-wjS2hjCv8AVnXJrRUbs
X-Proofpoint-ORIG-GUID: grC5IVX-iXAiUoTsSLTx66I9ShIa-Tlv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjEyMDA2MiBTYWx0ZWRfX25mmb75noNL5
 ef0T5Mh2mFOC/4MCR1F0J+tYjuReZWzcSKIWybWqoXTPqC4t7jTmE+tPdPiS6n8tE3+z2pt279g
 GzTrqFoeCAM0OKlqjDnHDX7CSG0Xx7ymGk6V7DJ/ucPDNKg7NLHdziW9IKblt6E1svYofgemjnX
 StokhiGV0txBMsKiVQAnLwH/8O2BSimpbi2lSTSoqJk5Fhu8i72gDQs60ZRSAS8HATKPF1OIuBz
 P4kOsDYdWWTNzN5jeW3OVDlSfiKjKfOisCi3SLybTssWXc7TWNPyo07Bk1wqiL6sf0iY9aI+xKB
 vZYcM64dV0ZB48ZVp9w8Fjotl+DES5Metm8IsgGvMeD5b8+m0L9/coDvyqn2kO6rE5Syp97NLLm
 v+iXXT9eVviyKz/gl+P+cHUVhCirBtwXjRf+FF2dOn+WqMDlfKqgvsf4frUf5tpsrbjTthhgQgI
 4foIxy5GCQXI+Zt4psQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-12_01,2026-06-11_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 malwarescore=0 spamscore=0 phishscore=0
 lowpriorityscore=0 bulkscore=0 adultscore=0 priorityscore=1501 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606120062
Received-SPF: pass client-ip=148.163.156.1; envelope-from=adityag@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, TVD_SUBJ_WIPE_DEBT=1.004 autolearn=no autolearn_force=no
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

On 26/06/12 09:16AM, Cédric Le Goater wrote:
> On 6/10/26 11:08, Aditya Gupta via Devel wrote:
> <...snip...>
> > --- a/docs/about/deprecated.rst
> > +++ b/docs/about/deprecated.rst
> > @@ -215,15 +215,6 @@ embedded 405 for power management (OCC) and other internal tasks, it
> >   is theoretically possible to use QEMU to model them. Let's keep the
> >   CPU implementation for a while before removing all support.
> > -Power8E and Power8NVL CPUs and corresponding Pnv chips (since 10.1)
> > -'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
> > -
> > -The Power8E and Power8NVL variants of Power8 are not really useful anymore
> > -in qemu, and are old and unmaintained now.
> > -
> > -The CPUs as well as corresponding Power8NVL and Power8E PnvChips will also
> > -be considered deprecated.
> > -
> 
> docs/about/removed-features.rst needs an update too.

Sure cédric, will update it

Thanks,
- Aditya G

> 
> C.

