Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14AC9C83030
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Jul 2025 09:38:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXGNr-00036t-LO; Thu, 03 Jul 2025 05:37:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gautam@linux.ibm.com>)
 id 1uXGNo-000367-NF; Thu, 03 Jul 2025 05:37:32 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gautam@linux.ibm.com>)
 id 1uXGNk-00030L-8K; Thu, 03 Jul 2025 05:37:30 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 562MTPfW003964;
 Thu, 3 Jul 2025 09:37:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=pp1; bh=teJEC+rEOEgsnabKyjHMgmAmJw2gbB
 D5syFKdrfWzUc=; b=AhMvrUi1kKnDXCPBVhDeWt67WbLt7fDV7jXUpIy2mDZz+N
 PFqWO1NAXBhCgBVr/1qL5qqzGaaEF7/Vf9mKtvAlLK8OI+FRlW7afYPp05tbtPfA
 B9ckelXbgs4oyvCiXJa8fz3CLFxaSgKcIrAVuEJuc2EBBz6ATt5+2N8T7S7951HX
 MGnBS22T5F9LRYFJ/4HXLc4zOc8Mb/wQxBha0CdYIr2sxOa+jrvQ2jwDmk94vrTQ
 fO+/Wc6pCZ+/BsmBF4kSn9rdiDHt5K25nD6rytrAPXJ9DziXiirYz2PtRMwxllzK
 2T6XA01TTAPtYNbJxbR/Wj7XPG9w/Nv4fAeFvtxQ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47j5ttjpdf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 03 Jul 2025 09:37:25 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 5639YAgc012659;
 Thu, 3 Jul 2025 09:37:24 GMT
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47j5ttjpde-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 03 Jul 2025 09:37:24 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5636M9fJ021909;
 Thu, 3 Jul 2025 09:37:24 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 47juqpv4g1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 03 Jul 2025 09:37:24 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 5639bKXj53543390
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 3 Jul 2025 09:37:20 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 14FCA2004D;
 Thu,  3 Jul 2025 09:37:20 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A9FFE20040;
 Thu,  3 Jul 2025 09:37:18 +0000 (GMT)
Received: from li-c6426e4c-27cf-11b2-a85c-95d65bc0de0e.ibm.com (unknown
 [9.204.207.58])
 by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Thu,  3 Jul 2025 09:37:18 +0000 (GMT)
Date: Thu, 3 Jul 2025 15:07:16 +0530
From: Gautam Menghani <gautam@linux.ibm.com>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org,
 =?utf-8?B?RnLDqWTDqXJpYw==?= Barrat <fbarrat@linux.ibm.com>,
 Glenn Miles <milesg@linux.ibm.com>, Michael Kowal <kowal@linux.ibm.com>,
 Caleb Schlossin <calebs@linux.vnet.ibm.com>
Subject: Re: [PATCH 00/50] ppc/xive: updates for PowerVM
Message-ID: <rsxrim7v3jrghmoif46vlabl6bdtrqcpvkqk4qcj4fcn5gsjpv@24452e6sftjx>
References: <20250512031100.439842-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250512031100.439842-1-npiggin@gmail.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 45iLKTL_QsqAY7kkIZjoxH-5Yv6KObj6
X-Authority-Analysis: v=2.4 cv=UtNjN/wB c=1 sm=1 tr=0 ts=68664f55 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=kj9zAlcOel0A:10 a=Wb1JkmetP80A:10 a=VnNF1IyMAAAA:8 a=MXip1V9D6JMEvDxORhQA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: NHphe_IOIfgLj7rv-aUKEHvey1OT218-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzAzMDA3NSBTYWx0ZWRfXyBy3f857B3dk
 HiBl15xo9pDF9j+DaQ8itprPK5sak7nAPCI/rTs+n7IUU2Z0UoToLSJAKqx9eIT55GO60oiGo09
 dwKBWce+VJSngLA09K6isIZZDTmM6uJTuNR4FYhLFNx1tyGZvYK7XzgruTNI2sGaC6tcrwmZhvY
 bCRt3A9W18Cx2hSlN3Vz8o5auJHNU/CZScbxTPGeAALg43sJpTyVB7tRH1t+iknsqtIuyi/qiEN
 mjYeaO/7fjyTLacWYXHIrifxq07tFa0IkrbDaciLss5dQMdD5L243bqfSDINavNzMLELe9Zx94V
 jd8H9/CKNE4hrHjqzWP5B8IVed/1XJEWsuAz0uhi9+5rrMhYKWcOZuY6uWmq3RB+VcZasG03n8q
 RqDI2Wh0ZFjFo9O+4X059hjiZSahfD5TbZi57jYagwUO9Xcwn+n+NPqqdiKpi+0fGfHatjDB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-03_02,2025-07-02_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0
 priorityscore=1501 phishscore=0 mlxscore=0 spamscore=0 mlxlogscore=572
 adultscore=0 clxscore=1015 lowpriorityscore=0 bulkscore=0 impostorscore=0
 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507030075
Received-SPF: pass client-ip=148.163.158.5; envelope-from=gautam@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.237, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Hi Nick,

I did some sanity testing of this series on KVM on LPAR (P10) with the help of
avocado test suites, LGTM

Tested-by: Gautam Menghani <gautam@linux.ibm.com>

