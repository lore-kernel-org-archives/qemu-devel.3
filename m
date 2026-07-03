Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8C17C43602
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2026 10:22:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfb2F-0000XQ-W9; Fri, 03 Jul 2026 06:22:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1wfb2E-0000XD-7k; Fri, 03 Jul 2026 06:22:14 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1wfb2C-0007bK-Hw; Fri, 03 Jul 2026 06:22:13 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6636IRMG1761050; Fri, 3 Jul 2026 10:22:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=KjDrD/
 czSsEzRNfm0RZXxCRhGms/tHDsGBA7woofpMM=; b=RTx0mKmHGMGTh2AF9cdaWK
 2kv75a30efMAbuMIJqk5yOioLGyCBrSX4mRBD34OxWh5mCH0a5NjSTMsiXmtioCb
 0IYnguVWWsh5wONVR+utdQ77VfD1Nk6jFYMBhA6rnKU8rl9LvwHiQp/34xVkxgJw
 NoXNudgnBmbdCMNZ7ks/gJqlEoDDBvWi16aiHNEktU/JZWsN2kzxtBI0OUQfWIlZ
 KphrhjwVmGp7NNhFsIpbVZcy3eqSKY9Xnwzl0Xoo+taLaHQvlo87SbARcwk2GCC/
 crC7VLzQtkuafg3eZGzmOs5rmOXg/N+Rxt4dBr9YFPA0hH1GrzFsMbv2rj3upWQA
 ==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f26mk673x-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 03 Jul 2026 10:22:07 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 663AK0YC007235;
 Fri, 3 Jul 2026 10:22:06 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f2uhyr2wv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 03 Jul 2026 10:22:06 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 663AM2hh45875644
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 3 Jul 2026 10:22:02 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 915C82004B;
 Fri,  3 Jul 2026 10:22:02 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2D14A2004D;
 Fri,  3 Jul 2026 10:21:56 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com (unknown
 [9.124.212.167])
 by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Fri,  3 Jul 2026 10:21:55 +0000 (GMT)
Date: Fri, 3 Jul 2026 15:51:53 +0530
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
 Chinmay Rath <rathc@linux.ibm.com>, BALATON Zoltan <balaton@eik.bme.hu>,
 Nikhil Kumar Singh <nikhilks@linux.ibm.com>
Subject: Re: [PATCH v4 RESEND 1/8] tests/functional: Add remote interrupts
 test for PowerNV
Message-ID: <akeMqNUv2UlN80cV@li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com>
References: <20260703085955.2318600-1-adityag@linux.ibm.com>
 <20260703085955.2318600-2-adityag@linux.ibm.com>
 <b1d16c72-3485-4cad-ae51-5db4a78e3a48@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b1d16c72-3485-4cad-ae51-5db4a78e3a48@redhat.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDA5OSBTYWx0ZWRfX2iBCLCDv8QGp
 n25hol5NdKWyWyao5w8Fbh+rxtRy6t6dzgV3llg1KnJCEt7bUi87II1gfkCU3ZuBTsBtxlr8qGb
 ULaJNegjVtvydyi2mT9X5+WLrSDFREVMgvT0t/vV7M7681qKm8KTPqEWHMGfn9hGkr7IVAlxAW3
 rPTOsQNbyMy7rz34JfqRAgXsZoLT6J3oMJL4re/tC/Bc6sPApm5PIdP3oaoXMztAOzTvXsHzPYP
 F7+jPlB4xBVFOtmhZ1TKYAs8Ag71N7ElNLyTFgaNSHLEVJOwD/TANzBd+WvZopa+vuLIkJ+YDCh
 RVRPGsOx+1rrp9tOPBF7P9bmXe1HyeAWxJK+fJSg0d4TBuiyJPyF6zRjKUPHGqvVKifIms+186K
 FJ/tPQOUvwJBQAQ37yynROWl7vMZXoPhrb9rItQ6Tv+FT4bgjL7K7OA62NR0ShoPWtDCf3cOm0+
 o4M/CN3fK4fxCxPpTBQ==
X-Proofpoint-GUID: s89IwM5JOrFd09srw7csS_aHwi5CdorS
X-Authority-Analysis: v=2.4 cv=Z8bc2nRA c=1 sm=1 tr=0 ts=6a478d4f cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=20KFwNOVAAAA:8
 a=p9WhX8dcEDoL-X5kCSYA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDA5OSBTYWx0ZWRfX0mKOYO3Jddxe
 Qyry+rabw6v46DQ2616xR1RmpOAHIEG8WtQDwbH8aUL4+X5JljlpnyPwOZWcclvUjRB1ZiR8j+2
 /PJxbv6bzTJbG4rp6p/e3C7jtFbIVpE=
X-Proofpoint-ORIG-GUID: _UUc9XMieHuNR2ws1qvy2zVOuDnPGrBw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 spamscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 phishscore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607030099
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

Hello Cédric,

On 26/07/03 11:17AM, Cédric Le Goater wrote:
> On 7/3/26 10:59, Aditya Gupta wrote:
> > <...snip...>
> > +    def test_linux_remote_interrupts(self):
> > +        self.require_accelerator("tcg")
> > +        self.set_machine('powernv')
> > +
> > +        # Have below setup in this test:
> > +        # 1. e1000e attached to pcie.6, which is from 7th PHB, belonging to 2nd
> > +        #    socket (chip 1), in a powernv boot with default 6 PHBs per socket
> > +        # 2. CPU on 2nd socket (chip 1) disabled
> > +        # 3. RX IRQ's affinity to chip 2, and TX IRQ's affinity to chip 3
> > +        #
> > +        # Then ping is done, to generate interrupts from e1000e which should go
> > +        # to IRQ server on the remote sockets
> > +        self.vm.add_args('-smp', '4,sockets=4,cores=1,threads=1')
> > +        self.vm.add_args('-netdev', 'user,id=net0')
> > +        self.vm.add_args('-device', 'e1000e,netdev=net0,bus=pcie.6')
> 
> 
> 2 sockets are enough.
> 
>     # grep -E  "eth0|nvme" /proc/interrupts
>      76:         12          0  PNV-PCI-MSI 268959744 Edge      nvme0q0
>      77:         62          0  PNV-PCI-MSI 268959745 Edge      nvme0q1
>      78:          0         67  PNV-PCI-MSI 268959746 Edge      nvme0q2
>      79:          0         34  PNV-PCI-MSI 2416443392 Edge      eth0-rx-0
>      80:          0         20  PNV-PCI-MSI 2416443393 Edge      eth0-tx-0
>      81:          0          4  PNV-PCI-MSI 2416443394 Edge      eth0
>     # echo 0 > /sys/devices/system/cpu/cpu1/online
>     # grep -E  "eth0|nvme" /proc/interrupts
>      76:         12  PNV-PCI-MSI 268959744 Edge      nvme0q0
>      77:         62  PNV-PCI-MSI 268959745 Edge      nvme0q1
>      78:          0  PNV-PCI-MSI 268959746 Edge      nvme0q2
>      79:         10  PNV-PCI-MSI 2416443392 Edge      eth0-rx-0
>      80:          0  PNV-PCI-MSI 2416443393 Edge      eth0-tx-0
>      81:          0  PNV-PCI-MSI 2416443394 Edge      eth0
> 
> A non-zero count on eth0-rx is good enough.
> 
>     # ping -W2 -c5 10.0.2.2
>     PING 10.0.2.2 (10.0.2.2): 56 data bytes
>     64 bytes from 10.0.2.2: seq=0 ttl=255 time=7.339 ms
>     64 bytes from 10.0.2.2: seq=1 ttl=255 time=0.673 ms
>     64 bytes from 10.0.2.2: seq=2 ttl=255 time=0.405 ms
>     64 bytes from 10.0.2.2: seq=3 ttl=255 time=0.369 ms
>     64 bytes from 10.0.2.2: seq=4 ttl=255 time=0.516 ms
>     --- 10.0.2.2 ping statistics ---
>     5 packets transmitted, 5 packets received, 0% packet loss
>     # grep -E  "eth0|nvme" /proc/interrupts
>      76:         12  PNV-PCI-MSI 268959744 Edge      nvme0q0
>      77:         62  PNV-PCI-MSI 268959745 Edge      nvme0q1
>      78:          0  PNV-PCI-MSI 268959746 Edge      nvme0q2
>      79:         34  PNV-PCI-MSI 2416443392 Edge      eth0-rx-0
>      80:         10  PNV-PCI-MSI 2416443393 Edge      eth0-tx-0
>      81:          0  PNV-PCI-MSI 2416443394 Edge      eth0
> That's even better I agree.
> 
> 
> Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks for the review and the suggestion.

About using 4 sockets, I used it so the receive and transmit interrupts both go
to different sockets, so more sockets are involved, which I assumed may help
catch some rare cases ? Also, with 4 sockets, affinity setting also gets tested,
which won't happen in 2 sockets as we don't need to set affinity in that case.

I will send a v5 with 2 sockets if you still think otherwise. What do you say ?

Thanks,
- Aditya G

> 
> Thanks,
> 
> C.
> 
> 

