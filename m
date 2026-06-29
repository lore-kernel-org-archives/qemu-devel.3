Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20D3BC43458
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2026 11:40:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weAKu-0000zT-Rh; Mon, 29 Jun 2026 07:39:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1weAKt-0000xn-AF; Mon, 29 Jun 2026 07:39:35 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1weAKq-0002PX-TF; Mon, 29 Jun 2026 07:39:35 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65TAmCp73181299; Mon, 29 Jun 2026 11:39:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=JtwcWg
 PVayABFqkq+CLBjsdFFHHlWyH1GFWPrrmPzqc=; b=qiLB2R3tx8uqHAPRL58XWZ
 b1CR01Jia6f7fsvENhXWRu3I7W1qwDa8J43+iLtcO1GYBSY+/dW36JI7ERjubVhv
 dBtyKbFnL7x5NjkW3vwXYyd96KWZBDQAxcK6tBQZomc5PFcPsihfqGT1+Dl1EPER
 H8kdy1RPTVp3NCNUkvVJoO9SKvzZBuCzhdq9pcxntg5/78dP2EUakid+XS1puviB
 wqhUIRLn4wkBvSmW7aQWuhSLQlfc3RS66tKujMffUD2bDre1J0NsYmhD/gJVUF3E
 KMMUE8pCJQ7byPL8OFQcjG6Ho+2w9lcjRpAzaOh3to2bVRmgxrKnIr6LwfJoGwgw
 ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f26qfs0xj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 29 Jun 2026 11:39:29 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65TBYir1016493;
 Mon, 29 Jun 2026 11:39:28 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f2ruq5cd0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 29 Jun 2026 11:39:28 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 65TBdOfR49152310
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 29 Jun 2026 11:39:24 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 627902004E;
 Mon, 29 Jun 2026 11:39:24 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6F24320040;
 Mon, 29 Jun 2026 11:39:20 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com (unknown
 [9.123.10.203])
 by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Mon, 29 Jun 2026 11:39:20 +0000 (GMT)
Date: Mon, 29 Jun 2026 17:09:18 +0530
From: Aditya Gupta <adityag@linux.ibm.com>
To: =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Shivang Upadhyay <shivangu@linux.ibm.com>,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>,
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
Subject: Re: [PATCH v3 1/8] tests/functional: Add remote interrupts test for
 PowerNV
Message-ID: <akJXAebIn7BHhPRS@li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com>
References: <20260629110411.3051274-1-adityag@linux.ibm.com>
 <20260629110411.3051274-2-adityag@linux.ibm.com>
 <71cffeef-3398-44e6-8e13-130266e789c1@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <71cffeef-3398-44e6-8e13-130266e789c1@redhat.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=RYqgzVtv c=1 sm=1 tr=0 ts=6a425971 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=7NDaL-D_JNWX0BNlmoEA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDA5MiBTYWx0ZWRfX326U21f3F5P3
 ZmjfQMqSJA1pni2y7/JEKqiLMng98KLseFKbpLg7UbVjNIRghJdMwo1nyCIzi2d/qZXHoekEzmT
 NP8ycmqZ/j4gFW5P5FDWyikeA3r6Z/Q=
X-Proofpoint-GUID: KnKkqMB-M5J5oHA9W-sjnD2imNfdkZ4m
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDA5MiBTYWx0ZWRfX9L9s3INCbU3y
 qGMJos97RJXSAka7a1lfqDsdEnOLPkNZq0E89/OXTyT2QXEimrDlXP22ywC/GeXEn3BiQuSp7Qj
 Gw3s5FdmVaFnfetLQY18IcQcHCpdYg42/Ou68Q1Ei5RJNvxI2t57ynVTI5qtMYraTyO3GETf54X
 R5hS1yVlHCdVC8cGjrv6dX7w8Fi3qh5lQARW9ZR9hC9xrwymvCtUlp5mJz+JYzgHFe0Fmche/tO
 ZaOWUkRH37+z6ZFpbSu2CZxMhzzsewzeKJwpB15NJma/Ko10Qwof1kpOhWTZWNY1Iws6Q8rKAa5
 W3lNLcK6N3jal4xT4Ea9YIlqXoFglYARYn/OJa6VRZEB0ArVocqx9AdMI4jV/KuHs3gznHS+2Cq
 uxX/vFrGsfFRQ8TYb9jYfBg8c0JJdF6V5tlWP3FuRf92oeUWhXtorOFg2ADN5TAMlo29/Eas01u
 dBouDnYsdzIP+BJJm2w==
X-Proofpoint-ORIG-GUID: m2y9ZQBwnscvKGIWyzf0BmB-lGtIUgS5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-29_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0
 adultscore=0 priorityscore=1501 suspectscore=0 bulkscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606290092
Received-SPF: pass client-ip=148.163.156.1; envelope-from=adityag@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
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

On 26/06/29 01:20PM, Cédric Le Goater wrote:
> On 6/29/26 13:04, Aditya Gupta wrote:
> > In the past there have been hard to recreate issues where XIVE changes
> > cause qemu crashes due to multi-socket interrupts such as in [1].
> > 
> > Add a functional test explicitly to test whether remote interrupts work.
> > 
> > The test can also work as additional boot test for multi-socket boot,
> > initrd boot test, as well as a check for e1000e to be working in powernv,
> 
> you should consider moving to a more modern nic model: igb, which
> has sr-iov support too.

yes, can do. with igb i see multiple irqs, so test will have to take sum
of all rx irqs, and compare:

	2026-06-29 17:00:46,288: cat /proc/interrupts | grep eth0
	2026-06-29 17:00:46,391: 135:          0          0          0  PNV-PCI-MSI 2416443392 Edge      eth0
	2026-06-29 17:00:46,393: 136:          0          6          0  PNV-PCI-MSI 2416443393 Edge      eth0-rx-0
	2026-06-29 17:00:46,394: 137:          0         14          0  PNV-PCI-MSI 2416443394 Edge      eth0-rx-1
	2026-06-29 17:00:46,395: 138:          0          4          0  PNV-PCI-MSI 2416443395 Edge      eth0-rx-2
	2026-06-29 17:00:46,397: 139:          0          4          0  PNV-PCI-MSI 2416443396 Edge      eth0-rx-3
	2026-06-29 17:00:46,398: 140:          0         16          0  PNV-PCI-MSI 2416443397 Edge      eth0-tx-0
	2026-06-29 17:00:46,399: 141:          0          6          0  PNV-PCI-MSI 2416443398 Edge      eth0-tx-1
	2026-06-29 17:00:46,399: 142:          0          6          0  PNV-PCI-MSI 2416443399 Edge      eth0-tx-2
	2026-06-29 17:00:46,400: 143:          0          4          0  PNV-PCI-MSI 2416443400 Edge      eth0-tx-3

I feel e1000e suffices for this test, should i stay with e1000e or use
igb here ?

Thanks,
- Aditya G


