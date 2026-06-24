Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 384A9CDB479
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2026 13:49:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcNxV-0001Fq-Rd; Wed, 24 Jun 2026 09:48:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1wcNxT-0000xE-VQ; Wed, 24 Jun 2026 09:48:04 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1wcNxS-0002f4-BN; Wed, 24 Jun 2026 09:48:03 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65OAmxlP645070; Wed, 24 Jun 2026 13:47:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=SgcMkG
 V7hvM0ax53/oEu6I10+bV30F43/QldYfio//I=; b=rUCHIIf/fKCIwDxeIEJjXr
 eLZHnFsxHS1T1FpTYYNywvb8JyRAGaVg8l33oJ5hS/CFHtjwrP9snspHE3S73ZiG
 JpA/QG0sIs+nnYwq+8ikKbDzmHYGT1LnxFSJg1Apn3EpuTlpKWzvMGDhkbNLOVo2
 8juQREMhM0VW2pUJj3agG0ucFCGvOgiSjD8/xeoR3gMfbLR8ncrOePuIKInAF30A
 Llb8Zk0YUTuNUlHHHmwBE2EuiKW4EeHdOZyCJZp2Rv0xLp4ADoueLjSI7TB5jTki
 ot7Q9Y0i+7g4a5/MuGxbg/UosYkKil+3lcdZs9kXYQdMO4yIpnhMOHXEknEqrY/Q
 ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ewjk4mf3y-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 24 Jun 2026 13:47:54 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65ODYfNp006094;
 Wed, 24 Jun 2026 13:47:53 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ex56qh2mb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 24 Jun 2026 13:47:53 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 65ODlnPU51380666
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 24 Jun 2026 13:47:49 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3A5692004B;
 Wed, 24 Jun 2026 13:47:49 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2D45B20040;
 Wed, 24 Jun 2026 13:47:41 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com (unknown
 [9.39.19.28]) by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Wed, 24 Jun 2026 13:47:40 +0000 (GMT)
Date: Wed, 24 Jun 2026 19:17:37 +0530
From: Aditya Gupta <adityag@linux.ibm.com>
To: =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
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
Subject: Re: [PATCH 1/8] tests/functional: Add remote interrupts test for
 PowerNV
Message-ID: <ajvfl1XVRUJiovA2@li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com>
References: <20260623141933.577981-1-adityag@linux.ibm.com>
 <20260623141933.577981-2-adityag@linux.ibm.com>
 <2f6d69e5-e11e-4561-a38f-84760525a549@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2f6d69e5-e11e-4561-a38f-84760525a549@redhat.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI0MDExNCBTYWx0ZWRfX2WQeekJyUtaf
 RxZl77J691M+TR8hdPVYUDR+MXrW9k4Zz463wjiIeWh7PeBhPdIM5jYRVGaQtSqSfxzZMgI1qb+
 jTKgaP8rOIQBVT7/lTjncj/XyNLEtl4=
X-Proofpoint-ORIG-GUID: P52uTQVncJ_E0_1umFDYvOsO0oriQPOr
X-Authority-Analysis: v=2.4 cv=Oph/DS/t c=1 sm=1 tr=0 ts=6a3be00a cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=8lG4SYNR4Pdbq3r0qSMA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI0MDExNCBTYWx0ZWRfX55ixbV97ioMo
 /gCldyPY9Dne66dfPfV+K0ojiF0sgfQYs7P6d6e3vy/dK4x7eqWfHtPY9MPjozIh4FsmV62osSR
 KfrW4QhU170MTLc4Nst9H3u8kUltrg2QsG2bcs6tY4rolWW/ZgHyb+cAfpdFlfrgKvV+cmxD5yv
 k/t6zrdInnOGn1u0HUPpHxI0E1YgjW7u7E+0VQOGGv/3qo1BiF0xwCOSp03cxoX++KgCz2YYn+1
 W2jJ2vgfLN/Fu21SyLfU+j+6S3JcODt5oKQlfeHkI7vzd3hWdPXQm+BTL2GrwLrE4nKpB4ir5eX
 1xmSwk7hftmBQC+mFtoZGr/0lyOg8r/700I+sIbsLsoWQP2T0Dzj7tKc1dOVe/BEUa9aTGHfCfE
 imR2ZnIFKStN7Xd5JYvTEF4Bc75kJAsOf9apoEl1naP31kuuqm8kzBMf48ZsrqycFrUWa4A6bFa
 o0LpmwpzfM7UegMxt6A==
X-Proofpoint-GUID: 02UyFluDyZ9exRjSNiEZVvP7EXXjDkCB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-24_03,2026-06-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 bulkscore=0 spamscore=0 priorityscore=1501
 clxscore=1015 impostorscore=0 malwarescore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606240114
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

On 26/06/24 01:44PM, Cédric Le Goater wrote:
> On 6/23/26 16:19, Aditya Gupta wrote:
> > <...snip...>
> >       def do_test_linux_boot(self, command_line = KERNEL_COMMON_COMMAND_LINE):
> >           self.require_accelerator("tcg")
> >           kernel_path = self.ASSET_KERNEL.fetch()
> > @@ -71,6 +75,88 @@ def test_linux_smt_boot(self):
> >           wait_for_console_pattern(self, console_pattern, self.panic_message)
> >           wait_for_console_pattern(self, self.good_message, self.panic_message)
> > +    def test_linux_remote_interrupts(self):
> > +        self.require_accelerator("tcg")
> > +        self.set_machine('powernv')
> > +
> > +        # have more sockets with as few CPUs as possible, increasing the
> > +        # probability to have remote interrupts from one chip to another
> > +        # also have e1000e network device to generate interrupts
> 
> Can you attach the PCI device to a PCI bus known to be on the
> second socket ? and then offline cpus on the second socket,
> so that all IRQ servers are on the first socket.

Makes sense, thanks cedric ! will keep the device attached to 4th
socket, and offline it's CPU, and let the other setting affinity part
same

Thanks,
- Aditya G


