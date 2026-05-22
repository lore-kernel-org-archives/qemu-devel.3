Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8BCACD5BB0
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2026 18:57:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQV3G-0002Qc-0T; Fri, 22 May 2026 14:56:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <misanjum@linux.ibm.com>)
 id 1wQV3D-0002QB-O9; Fri, 22 May 2026 14:56:51 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <misanjum@linux.ibm.com>)
 id 1wQV3B-00016Z-CR; Fri, 22 May 2026 14:56:51 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64MCZas01765513; Fri, 22 May 2026 18:56:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=w/qYXQgw5HFaFWhxC
 2zxpxShMKBiXHQdk6aAkOV9rzc=; b=kf1aYWSCDdEH60WcSkRoFb3QdpEPPKg7S
 amU+d3/hTZ8mAUIkSgCCF4pCio2uVAn1+ITEKOLNOmWvALJN+vklD8WrHwfUe+/f
 AbeqdyFPJNv1E/AvvdB9FyBvYuEe8Ztey/06s+j/OUkrUs6EkB23rdtvuAW2W2mp
 YZQFz6nUCwlX242xZy07qv2h8ZtA88beRKgr35cPPa4qwcc3zVA0kAN23XTtmjDu
 9R/ajxs4t37Jx9JAA4ag6/mKsVyjxns0TKq29n49WuWjN2Pv14k1MJAFYdyFWqRr
 JwZNeKTF1ZMVvTbbazrGxsIAFV1PHP1d2z3S1QeCfZBEpaAteaGcQ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e6h75dfb3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 22 May 2026 18:56:45 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64MIs4g5020678;
 Fri, 22 May 2026 18:56:44 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4e754gt1fs-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 22 May 2026 18:56:44 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com
 [10.241.53.101])
 by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 64MIuhNA7995976
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 22 May 2026 18:56:43 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5AD515805C;
 Fri, 22 May 2026 18:56:43 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 47EB758051;
 Fri, 22 May 2026 18:56:40 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.61.246.98])
 by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 22 May 2026 18:56:39 +0000 (GMT)
From: Misbah Anjum N <misanjum@linux.ibm.com>
To: adityag@linux.ibm.com
Cc: harshpb@linux.ibm.com, amachhiw@linux.ibm.com, milesg@linux.ibm.com,
 npiggin@gmail.com, qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 shivangu@linux.ibm.com, Misbah Anjum N <misanjum@linux.ibm.com>
Subject: Re: [PATCH 0/2] ppc/pnv: Make Power11 as the default CPU
Date: Sat, 23 May 2026 00:26:01 +0530
Message-Id: <20260522185601.27144-1-misanjum@linux.ibm.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20260521200844.1449023-1-adityag@linux.ibm.com>
References: <20260521200844.1449023-1-adityag@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=ffCdDUQF c=1 sm=1 tr=0 ts=6a10a6ed cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=nt1L8KCDP4n4pYK9-skA:9
X-Proofpoint-ORIG-GUID: YuN3sj5221Kij5F7_kzS_QlTNjdUrVSh
X-Proofpoint-GUID: itOFacgMwRskw41zG1L7NSjdXF7d4Wma
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIyMDE4NSBTYWx0ZWRfXwqwVq39SOlBZ
 nLTi80ljEZi449To22AB1MJBvR6SE0icRrSzcn6LyhjFfVcYaEa8uSCX+E3XWr3hOgVqWpaW+il
 1voB8c+7jIo7GEd6YOPlpqDhwA+tfmkm93T2wpBJN5BTWOwvQDzD8xZl51+FBatdygC2glxqyi/
 mnfrFtoanZlrsJ8EfnOalIzO3vyIdA+zkec9/EHH+oh0bOC3Q+DhhOWp4FYrQ7pN7VKcPEXLadT
 HnjnAP1NLJjQnTJJUsPmMJ+XQ2J+QUEIOElWEB9ZdEyg1JgAc5Ju32SRdFELy/zQNWHLqt8GOch
 aaUcyY+Ei8/Aar6ViN/nl2fniGC+wUI8KhDA+WHxRf8/rnudpceYGor9DkfV0+wtWR/9OGfbrh+
 Ham6Izgw/RRuVTh/a7MbM8eICNby/zVrTiRrHUW8+eGXTWDjPWDwpwd4RIpRHkgpQEHnvQkFRCj
 kxW5fsqmaThm5sqHNGg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-22_05,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 phishscore=0 suspectscore=0 adultscore=0
 clxscore=1015 impostorscore=0 lowpriorityscore=0 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605220185
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=misanjum@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
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

Hi Aditya,

I've tested the Power11 default patches on both PSeries and PowerNV guests with various SMP topologies.

Testing Environment:
- Host: SLES 16.1
- Arch: ppc64le
- QEMU: emulator version 11.0.50

PSeries Guest Bringup
Status: Success
qemu-system-ppc64 -name test-vm -machine pseries,accel=kvm -m 4096 -smp 8,sockets=1,cores=8,threads=1 -nographic -serial mon:stdio -drive file=/var/lib/libvirt/images/sles161.qcow2,if=virtio,format=qcow2 -netdev bridge,id=net0,br=virbr0 -device virtio-net-pci,netdev=net0

PowerNV Guest Bringup
Status: Success
qemu-system-ppc64 -name test-vm -machine powernv -m 4096 -smp 8,sockets=1,cores=8,threads=1 -nographic -serial mon:stdio -kernel /boot/vmlinux-6.12.0-160099.36-default -initrd /boot/initrd-6.12.0-160099.36-default -append "root=/dev/sda2 rootwait console=hvc0" -device virtio-scsi-pci,id=scsi0 -drive file=/var/lib/libvirt/images/sles161.qcow2,if=none,id=drive0,format=qcow2 -device scsi-hd,bus=scsi0.0,drive=drive0 -netdev bridge,id=net0,br=virbr0 -device virtio-net-pci,netdev=net0

Different topologies tested for both pseries and powernv
Status: Success
-smp 8,sockets=1,cores=8,threads=1
-smp 8,sockets=1,cores=1,threads=8
-smp 8,sockets=8,cores=1,threads=1
-smp 4,sockets=1,cores=2,threads=2
-smp 4,sockets=2,cores=1,threads=2
-smp 4,sockets=2,cores=2,threads=1

Qemu Unit Test Results
Status: Success
Ok:                337
Fail:              0
Skipped:           9

Result: All tests passed successfully.

Tested-by: Misbah Anjum N <misanjum@linux.ibm.com>

Thanks,
Misbah Anjum N

