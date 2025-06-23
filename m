Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6C11C77B7C
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Jun 2025 16:57:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uTkU3-0004bj-Jh; Mon, 23 Jun 2025 12:57:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pasic@linux.ibm.com>)
 id 1uTkTz-0004bP-Bx; Mon, 23 Jun 2025 12:57:24 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pasic@linux.ibm.com>)
 id 1uTkTx-0000JF-2q; Mon, 23 Jun 2025 12:57:22 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55NG2wcJ022132;
 Mon, 23 Jun 2025 16:57:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=vubcJN
 ByLyOBLq3s0ZbDoMxUjOwXQEVJoXB2meL+Jbg=; b=EHAS9wp0vLlGjt2R/z9+Xy
 diO+0dToJnIXycqYpKV4l/Jf8dhciUzYUtN3XYZpoDNsrKoJ4wCdyXijKK9su6GE
 dus4A6m7fZQNG24cGMHL1NFmnb/tpacspSA5suszywM1hBMSZ7ib7fDMe4Z1ASFi
 aU5JnLqw57v83+1fKrTfb403vh7Q7ecbzrU6b6WMCTU/Ocbtrz8VVyajBrLAe6m5
 vQUiFoG/LYiv0EIGE8Xaaz+tFZXz5CqGd8rduBCkQEpGcNNWBCM9EN+Mq5xBg8tY
 HFoNrEAU2fXUkaRLnm4NsGBX4JfxAt4MiusoIrM3hBDYHfguaw9dWGRdBWXRupRQ
 ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47dmf2ub16-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 23 Jun 2025 16:57:18 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 55NDqxIx006513;
 Mon, 23 Jun 2025 16:57:17 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 47e82nyv8n-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 23 Jun 2025 16:57:17 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 55NGvDia38928848
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 23 Jun 2025 16:57:13 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6BC8320043;
 Mon, 23 Jun 2025 16:57:13 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id AC92F20040;
 Mon, 23 Jun 2025 16:57:12 +0000 (GMT)
Received: from li-ce58cfcc-320b-11b2-a85c-85e19b5285e0 (unknown [9.111.35.149])
 by smtpav05.fra02v.mail.ibm.com (Postfix) with SMTP;
 Mon, 23 Jun 2025 16:57:12 +0000 (GMT)
Date: Mon, 23 Jun 2025 18:57:11 +0200
From: Halil Pasic <pasic@linux.ibm.com>
To: Matthew Rosato <mjrosato@linux.ibm.com>
Cc: qemu-s390x@nongnu.org, thuth@redhat.com, borntraeger@linux.ibm.com,
 farman@linux.ibm.com, alifm@linux.ibm.com, jjherne@linux.ibm.com,
 walling@linux.ibm.com, jrossi@linux.ibm.com, qemu-devel@nongnu.org,
 zycai@linux.ibm.com, Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [PATCH] MAINTAINERS: add reviewers for some s390 areas
Message-ID: <20250623185711.61e0d36b.pasic@linux.ibm.com>
In-Reply-To: <20250623160030.98281-1-mjrosato@linux.ibm.com>
References: <20250623160030.98281-1-mjrosato@linux.ibm.com>
Organization: IBM
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=M5FNKzws c=1 sm=1 tr=0 ts=6859876e cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=kj9zAlcOel0A:10 a=6IFa9wvqVegA:10 a=VnNF1IyMAAAA:8 a=WptR_IWs4pm6bdFlJv4A:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjIzMDEwMiBTYWx0ZWRfX5066Q7gtn5Nh
 6BEI4K01tWiVeQUVZh0g2QFrjv7g2tqTxY0M55lswGutCpmWFuBu+wOXwXroIhO5ef8ksBIqsD6
 +HTHwAordA08CQZ9iEGLscNx74LQl3wBduiUh8l9DSJQk8btNC2rWSCMpTuFagaQs0aEg+LTmot
 iu515Qaij+L3bcHBXMzXoljohhYndBfKj9FNF3PLL/WVvl4ia6EAn6k6hIw+D4La4UFVzdrnJjr
 UbtB+bJh2szGXAAfB7gDf1RPY6bQlbJRKOG8QHjEGC6DU63js+dtzA2Et1PHKVPVV++fDv5FBod
 K7A+dwnV06jYO1uTtiTLfzrZ18lolTi3nqi2PR2spR2yMi99JXHSNrlr1987FTVJk4ra9pcbX7k
 blsMHcGx7nZqT7EQF5izWhV1b9K5lza3L+pVNy6RC9KYinf6QM795eGhooAm2ddugtoYkqq0
X-Proofpoint-GUID: IPgDD8Cpx5_dN01Nr6Zg5f_1rccYZsoA
X-Proofpoint-ORIG-GUID: IPgDD8Cpx5_dN01Nr6Zg5f_1rccYZsoA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-23_04,2025-06-23_07,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 bulkscore=0 malwarescore=0 impostorscore=0 suspectscore=0
 priorityscore=1501 phishscore=0 spamscore=0 clxscore=1011 adultscore=0
 mlxscore=0 mlxlogscore=900 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506230102
Received-SPF: pass client-ip=148.163.158.5; envelope-from=pasic@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
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

On Mon, 23 Jun 2025 12:00:30 -0400
Matthew Rosato <mjrosato@linux.ibm.com> wrote:

> To improve review coverage, assign additional people as reviewers for
> multiple s390 sections.
> 
> Signed-off-by: Matthew Rosato <mjrosato@linux.ibm.com>

Acked-by: Halil Pasic <pasic@linux.ibm.com>

