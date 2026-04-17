Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDDFFF436B9
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2026 15:44:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDlMO-0000w1-KU; Fri, 17 Apr 2026 11:44:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jhkim@linux.ibm.com>)
 id 1wDlMM-0000ve-Bd; Fri, 17 Apr 2026 11:43:58 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jhkim@linux.ibm.com>)
 id 1wDlMJ-0006T3-7w; Fri, 17 Apr 2026 11:43:58 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63H79uxD1843301; Fri, 17 Apr 2026 15:43:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=nDpGKUsNpC1jffcaTJTtsy+ohDIHggJ+utnKAhnY8
 K0=; b=mftA3xi9spV8BNRjj/ii5atZ3888er7exiW1hO8VFatLQre+Hw8oQR1hC
 9Za4xlWHvRhFmVT23zjudg2EhK4vO6bOi/nH6YhDU8N4QX0Mm94tvfY7VfHpDHXb
 mRJjSjpdoHI8sq/JHQliDIAD1SmPLCoboYsZ9AQUcgDTUKRaaGBwqgj/IG8Y4VOE
 91aiOe+l6nvJmMGyVuN6WERwYhwbMj8XJuV83+5OoUUC8PwZdW7aEuDhETLsj35g
 OCREXXJGVU3fh09vThvOP8EFxnc1HiO8eNxCb+clvjTM+DlpQ5odnS5W8LRmddfa
 c8x1fh6HK//9+Uv4+/fccax0bTZxA==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dh89n3byu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 17 Apr 2026 15:43:50 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 63HDBFr1003253;
 Fri, 17 Apr 2026 15:43:49 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4djbh99ehn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 17 Apr 2026 15:43:49 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com
 [10.241.53.104])
 by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 63HFhMtP29885006
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 17 Apr 2026 15:43:22 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A9A0F5805D;
 Fri, 17 Apr 2026 15:43:47 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 75ACA58052;
 Fri, 17 Apr 2026 15:43:47 +0000 (GMT)
Received: from IBM-GLTZVH3.atx-us.ibm.com (unknown [9.16.58.46])
 by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 17 Apr 2026 15:43:47 +0000 (GMT)
From: Jaehoon Kim <jhkim@linux.ibm.com>
To: qemu-devel@nongnu.org, qemu-s390x@nongnu.org
Cc: richard.henderson@linaro.org, iii@linux.ibm.com, david@kernel.org,
 pasic@linux.ibm.com, borntraeger@linux.ibm.com, farman@linux.ibm.com,
 mjrosato@linux.ibm.com, cohuck@redhat.com,
 Jaehoon Kim <jhkim@linux.ibm.com>
Subject: [PATCH RFC v1 0/1] hw/s390x/ccw: Disable legacy mode
Date: Fri, 17 Apr 2026 10:43:07 -0500
Message-ID: <20260417154332.849664-1-jhkim@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE3MDE1NCBTYWx0ZWRfXxoqd0cNahnVK
 BVAzsGP5iTKVFx66T0catb0DbfrqqQrguhRUXR2Y7fg3CWlh3P9g1zRxlqtmSj9WtVRFRE3YLil
 zGvge/70cV4WOmYoFWmHO6dN67bfBy3iZ1VrWNqITTxvzgVKFy7YhABNt/0KYPgINYnq9euhvxI
 iGHEjZ1Ywv1Af9Ql3/s0FCSi2XTPpMOGawc+twyVbS2AXt4rW9hsLlQks8CGJXh5baHQqZv/5Aq
 1W82YIe1g8BGxa3S90hUurtpEZ2RZd8k2i/cYmv1QmWQlp7Y2DzUut9gqylVboHib6Wg6tKPCEF
 wmdCbEStLKwlBDRTEh9P5Q7Wa5ntqpcL8QZa9HBn7LKkXrpLAjtHUJ7lM3UtxHEI3gWbHqCnGct
 iCg2NBrzZXvmh+PMQEuUQLaPZolY42Z3tmKSa29aBv8GSNNGZ390Y6RXQNBNQqXD8ZUP/KfYuVS
 McnjNjfuOc6Qxjp8Iqw==
X-Authority-Analysis: v=2.4 cv=eJ4jSnp1 c=1 sm=1 tr=0 ts=69e25536 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=YzhqieT6Xnwmm_frs9EA:9
X-Proofpoint-GUID: dc1BQTiwdUbw3n9gEXaG6VR7iiy8gxwZ
X-Proofpoint-ORIG-GUID: dc1BQTiwdUbw3n9gEXaG6VR7iiy8gxwZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-17_01,2026-04-17_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 adultscore=0 priorityscore=1501
 clxscore=1011 bulkscore=0 suspectscore=0 spamscore=0 impostorscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604070000
 definitions=main-2604170154
Received-SPF: pass client-ip=148.163.156.1; envelope-from=jhkim@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
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

Hello,

This RFC proposes disabling legacy virtio-pci devices by default on
s390x starting from machine version 11.1.

Background:

The s390 kernel has never supported the legacy virtio-pci interface
despite QEMU advertising it. IO_SPACE_LIMIT has been 0 since the
initial zPCI implementation (commit cd24834130ac "s390/pci: base
support"), making I/O BARs unusable, so our driver never supported it.

When virtio-pci devices operate in transitional mode, QEMU
unconditionally exposes the legacy interface via BAR0. During PCI
enumeration, this results in firmware warnings such as:

  pci 0005:00:00.0: [Firmware Bug]: BAR 0: invalid; can't size

even though the BAR is never usable on the s390 kernel.

It was also observed that forcing legacy-only mode (disable-modern=on)
does not work on s390x. The guest first attempts virtio_pci_modern_probe()
and then falls back to virtio_pci_legacy_probe(), which tries to map BAR0
via pci_iomap(). Since IO_SPACE_LIMIT=0 on s390, the BAR is unusable, the
mapping fails, and the device probe fails. This further confirms that
legacy support is not practically usable on s390x for new guests.

This patch closes this gap by disabling legacy virtio-pci support
starting from machine version 11.1, effectively making virtio-pci
devices non-transitional and preventing the creation of the unusable
legacy I/O BAR.

Implementation:

The patch introduces s390x-specific global compatibility properties that
set disable-legacy=on as the default for virtio-pci devices. Machine
versions v11.0 and earlier set disable-legacy=off to maintain their
original default behavior for compatibility.

Users can still override the default on the command line if needed:
  - On v11.1+: -global virtio-pci.disable-legacy=off (to enable legacy)
  - On v11.0-: -global virtio-pci.disable-legacy=on (to disable legacy)

I would appreciate feedback on this approach.

Thanks,
Jaehoon Kim

Jaehoon Kim (1):
  hw/s390x/ccw: Disable legacy virtio-pci by default (v11.1+)

 hw/s390x/s390-virtio-ccw.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

-- 
2.50.1


