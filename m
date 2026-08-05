Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5670C55174
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2026 13:55:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wrc4a-0003HI-Cm; Wed, 05 Aug 2026 09:54:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nikhilks@linux.ibm.com>)
 id 1wrc4W-0003GJ-LE; Wed, 05 Aug 2026 09:54:18 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nikhilks@linux.ibm.com>)
 id 1wrc4R-0001Re-K8; Wed, 05 Aug 2026 09:54:13 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 675CHggq3793612; Wed, 5 Aug 2026 13:54:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=Lp+rZ/
 6DJeF0SWUQifZQf8S8Bgdj+yaVVVTf1Nv2bak=; b=GKg1VHom/AOuidzT3l6ef9
 6uX85u9U10FbV7ZDLuLeTi1WS4FMhUSq1lsluPG6rViFv8SRpyXqJABUtZfPKUgR
 XqxfRJ9kBPQDArNpHih2XrM+BIWJGd3YeOgWDcGcjbqKxoQ8S22XtpZS49IkM9gd
 sU0ro5KM5XdD4ExVsSW3pJALMG1C15wzy18gRUTLF19DTJbVG1I/0EhGXUkPXLG1
 azrp9OtKjgeOyx3b9sInnVwSjiHP/AoU1FxttrGMs5JinZ2E6rvpJeKS5HEp0qQP
 kj6hOWZFMM/CHOzQYOsXgAhBZXKukbKsdmuas+ihhgOiAjBK5vEOQx1Rzv176rug
 ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs8a43bch-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 05 Aug 2026 13:54:06 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 675Do98A000523;
 Wed, 5 Aug 2026 13:54:05 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fswbgem1j-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 05 Aug 2026 13:54:05 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 675Ds2k645875540
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 5 Aug 2026 13:54:02 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 44DEF20043;
 Wed,  5 Aug 2026 13:54:02 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 37F102004B;
 Wed,  5 Aug 2026 13:54:00 +0000 (GMT)
Received: from [9.43.76.92] (unknown [9.43.76.92])
 by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed,  5 Aug 2026 13:53:59 +0000 (GMT)
Message-ID: <c21c72fc-672a-4674-a8d6-0b999502b4ad@linux.ibm.com>
Date: Wed, 5 Aug 2026 19:23:58 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Nikhil Kumar Singh <nikhilks@linux.ibm.com>
Subject: Re: [PATCH] hw/pci-host/pnv_phb4: fix guest-triggerable abort on
 8-byte config access
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org, qemu-ppc@nongnu.org
Cc: qemu-stable@nongnu.org, npiggin@gmail.com, adityag@linux.ibm.com,
 milesg@linux.ibm.com, harshpb@linux.ibm.com
References: <20260805090530.1333997-1-nikhilks@linux.ibm.com>
 <501df67e-28d0-4630-b98a-769abb41086b@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <501df67e-28d0-4630-b98a-769abb41086b@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=E6P9Y6dl c=1 sm=1 tr=0 ts=6a73407f cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=IoMl_ZB-b3GhOJz6oEQA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: gtWjJg3-FB5bYopH8XidSBlNBTmivrzr
X-Proofpoint-GUID: jwVWqDHpHIjuIivA38arAvGPchXI5OaM
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA1MDExMSBTYWx0ZWRfX2arZSATgi4g3
 VRbE5wvILNPmDUSO6y+vIYa9uIcohdlwAjVejhveGr3eL8J5zvT6ZaBxZ0JgbrWxj+Q/ZMas/il
 E243PCt7f/PsQlv4lBCG8xib31J2eYw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA1MDExMSBTYWx0ZWRfXxQlP5O3AGY7o
 pFDceA/306w+5m8jZvbMKZOb1iSBSzrE+gbnBVBNwLe+2fMkXE8w4YGUh/EVKgbtjAWwuhtGb3p
 LzZlHOZtMM/3C+kKvZu2z+DdxE7T7nxXx66Cq+blmbeYSDs4prf8DvbqBs0lsLIysHS/b34RuA8
 6tn5ZsmdWRsmR/rIQfG5KjPE6BTEnKAMiK5WkGjDuE7y1n55FtTV3jFWT7pPK3btiODg+wTvx80
 edlcYnALYhzrJPwFmfhNLW61KOFxy0FuO/fxGX3KSqLymZFfVjQD1ZN56ufAC9tLz//5Ia0QHEe
 L4UycbY7nT7V9gKhQwwQz4y3sPHCK3+StPtQB1/tpGXxp+y7kV34Y7a8K+MpvM0bY9N+nJzPx9c
 EcB/r7c+KE3a1nIQf9FaS49ncIFsnL9F8GPkAmkznhLGMbl6uaTCSdc2UnxJVvcEsCeanoGo2j6
 M77+j0ddl2jyhhFslzQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-05_04,2026-08-04_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 lowpriorityscore=0 priorityscore=1501
 suspectscore=0 adultscore=0 spamscore=0 malwarescore=0 impostorscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608050111
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=nikhilks@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
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

Hi Philippe,

Thanks for the review.

1. Regarding MIN(size, 4): I avoided this because silently truncating an 
8-byte guest read to 4 bytes leaves the upper 32 bits unpredictable, 
which might mask guest OS bugs. Returning ~0ull explicitly matches 
standard PCI behaviour for invalid reads and is safer.

2. Regarding pci_host_data_le_ops: I agree this is the right way to 
handle it. However, PHB_CONFIG_DATA is currently interleaved inside the 
larger big-endian PHB4 MMIO region. Moving it to generic little-endian 
ops requires a memory region refactor using overlays.

Since this patch addresses an immediate DoS crash, I kept the scope 
minimal. Memory region refactoring can be picked up as a separate 
follow-up patch.

Regards,
~ Nikhil

