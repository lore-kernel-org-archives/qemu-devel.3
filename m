Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B503C5DF67
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 06:19:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwD9m-0007Yj-2s; Tue, 18 Aug 2026 02:18:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gra@linux.ibm.com>)
 id 1wwD9c-0007Vt-Fi; Tue, 18 Aug 2026 02:18:33 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gra@linux.ibm.com>)
 id 1wwD9Z-0002Jq-EC; Tue, 18 Aug 2026 02:18:31 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67HM1lh12526557; Tue, 18 Aug 2026 06:18:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=pp1; bh=0X1xQn76+Squ8CGeUTYE67uFdY9UHS
 tPu2MMM+8BQZA=; b=dHoqbWRvy3NbrRNdvbuTLkI4jBtxo4PT6FDCm7BNPodD9R
 0Lbv/x7VrwftxyO8HvdU1fD2/5I1crCAwgj0Dwa1dsInvxsxDJl76tKUBGVsTuff
 URu5PO9o9SgV+6C2Ob7eqr73nBJzakk8XcOYAG6RkArymJHyYbFTXAkRq7LCt9A3
 /TroBtCX5ZgEp5LKxKuF/a14QRYtCM+jE3dJ8xIKQ6kWLq89/HDxeyb6UENOfF1k
 u/oomt/olRvRTBMnkkfbyCHh3GbY3TbhcWbc12sPxX6Gtv5sBNm9Cju+hip+zQaJ
 on7OENh+o52zXHqPDBMIeiCOJ09fD31dkaP+ulgA==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g2dhkxapp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 18 Aug 2026 06:18:25 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67I6BKhq012554;
 Tue, 18 Aug 2026 06:18:25 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g32eq1vmj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 18 Aug 2026 06:18:24 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67I6IKBE45941092
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 18 Aug 2026 06:18:20 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0619A20043;
 Tue, 18 Aug 2026 06:18:20 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DAB1E20040;
 Tue, 18 Aug 2026 06:18:19 +0000 (GMT)
Received: from localhost (unknown [9.111.9.197])
 by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 18 Aug 2026 06:18:19 +0000 (GMT)
Date: Tue, 18 Aug 2026 08:18:19 +0200
From: Andreas Grapentin <gra@linux.ibm.com>
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, eric.auger@redhat.com,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>, philmd@linaro.org,
 qemu-ppc@nongnu.org, Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Steffen Eiden <seiden@linux.ibm.com>
Subject: Re: [PATCH v5 8/8] hw/vfio: all vfio files can now be common files
Message-ID: <aoPw6-MGBcTOfxwp@li-d8547bcc-2d90-11b2-a85c-a70f2a37009a.ibm.com>
References: <20260318174733.1717643-1-pierrick.bouvier@linaro.org>
 <20260318174733.1717643-9-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260318174733.1717643-9-pierrick.bouvier@linaro.org>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDA0MyBTYWx0ZWRfX+AE4CXtGPxqf
 2x6GAyW3CI0SNl/jR07pitWAWEf9V/Edw8zrXL4lKLysSdMEQeG4NNyPiKveWy0N+TOPvM/yzDG
 DTwCUJC2S5flTQZDHhe9ozZUTkNahVAw9CF0RI6TeQQlX3EKoeD2SlwpxI67Hm4QFh0JlXN4Hs9
 Du3K1usxkYYHk+KRGaSGX+IipofIBsSWSQVCpT3TnlJLFaFzjrYDQVQDzu6oNl2VpkyywQhc9LH
 CfuoiqUqlJTBTRR5vyfiUsMuflVO/ovY/u39W8iOeEvGlziznDwsgoUAwvUB2qyOhfeJrg6aSC3
 sfRicrv0DMhboIqbCwZmEMn4GpujnxKhU5r8ImUfR8K5eut/GXBNUOhFqCT7xDY/nipX8nrC3aa
 3ATSC0LMv9B7cjgzBcYQBp6odnBwm1vFlPaKgxQxYmw1K6/Bi/THjYFR4hs7CThrLZV3fEUUM+0
 AGTTTMfmeoUaOHoVjCw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDA0MyBTYWx0ZWRfX5LVOxoMq74v6
 6xljC0MsuNV1E45+ot0Tmb2WNrUJCm43dqeD3AaU8ntpZMynNOyTzJXLTIP0Vxz3Zu4QHjzFr5N
 MjWdpk7mHOa2n4N4YMR58VZcnFTd+Uo=
X-Authority-Analysis: v=2.4 cv=JKkLdcKb c=1 sm=1 tr=0 ts=6a83f931 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=kj9zAlcOel0A:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=FPm3a6HYH6nu5nH1MeQA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: L9HUFNX6zKzc6yGnN2XO42qQK35okWQU
X-Proofpoint-GUID: L9HUFNX6zKzc6yGnN2XO42qQK35okWQU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-17_04,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 malwarescore=0 priorityscore=1501
 lowpriorityscore=0 clxscore=1011 adultscore=0 impostorscore=0 spamscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608180043
Received-SPF: pass client-ip=148.163.158.5; envelope-from=gra@linux.ibm.com;
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

On Mar 18 26, Pierrick Bouvier wrote:
> -specific_ss.add_all(when: 'CONFIG_VFIO', if_true: vfio_ss)
> +system_ss.add_all(when: 'CONFIG_VFIO', if_true: vfio_ss)

Apologies for digging out this old thread, but parts of the vfio code
need linux/kvm.h, which includes asm/kvm.h. Consequently it can only be
fully architecture agnostic based on the assumption that KVM will only
ever be able to support one guest architecture which must be the same as
the host architecture.

On s390x, we are currently working on a KVM change that breaks this
assumption:
https://lore.kernel.org/all/20260812153631.3376090-1-seiden@linux.ibm.com/

We are in the process of working out what changes this would require on
the qemu side, and will send a patch series soon for discussion, but
we've noticed that this patch series in particular was a breaking change
for us when moving to v11.1.

Fortunately, this series also extracted the architecture dependent code
in VFIO into the kvm-helpers.c file, so for us the most obvious solution
would be to keep kvm-helpers.c in specific_ss, while the rest of vfio
can go to system_ss. Would that be acceptable?

Thanks,
Andreas

