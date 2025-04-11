Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0240C36010
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Apr 2025 09:23:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u3Ab0-0006hW-VR; Fri, 11 Apr 2025 05:22:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ggala@linux.ibm.com>)
 id 1u3Aax-0006fe-9F; Fri, 11 Apr 2025 05:22:43 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ggala@linux.ibm.com>)
 id 1u3Aav-00066N-CG; Fri, 11 Apr 2025 05:22:43 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53B95CUJ003729;
 Fri, 11 Apr 2025 09:22:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=CGNyN1dhckuTTJmtEC0j3i4lyWuz7i/TZuhKqgeh4
 Cw=; b=QMoo6DoNOLLnShhPChIheputD4UIzm+XSovP7pDUEPIaS7vuf73PgDHQq
 y4zE1YrpaxxRWvZMgBU2T87UcWOljXMSApIp0Y5XrR24v4CFsJia5ONU+eT/6pAx
 PC/2MBUZ2jwiWEf7X1qnGTB9pk5ahMTARvdQ4OL9e47/uwN8NV6cFmfaTskkzv8H
 uGCj4r18aczx8mimDa5GEEG+CU9sddTxs+UoAzbQ0CrDG1msmyINhg7WrZKfAzia
 f0UHXURnw/2tyu3RlPKNAyXQaTS6ze3z9KjyWsnI1Hie8JrG/3hXJgUTagdnEGos
 DU/S4SZX9vDXr3RY9SIrU7bHEze/Q==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45xe13wfbv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 11 Apr 2025 09:22:36 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53B6Tu1F018567;
 Fri, 11 Apr 2025 09:22:35 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 45uh2m24dk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 11 Apr 2025 09:22:35 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com
 [10.241.53.103])
 by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 53B9MYUP65143110
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 11 Apr 2025 09:22:35 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BEB4958056;
 Fri, 11 Apr 2025 09:22:34 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E648F5805A;
 Fri, 11 Apr 2025 09:22:33 +0000 (GMT)
Received: from t83lp65.lnxne.boe (unknown [9.152.108.100])
 by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 11 Apr 2025 09:22:33 +0000 (GMT)
From: Gautam Gala <ggala@linux.ibm.com>
To: qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>,
 Thomas Huth <thuth@redhat.com>
Subject: [PATCH v1 0/3] target/s390x - DIAG 308 extend subcode 10 to return
 UVC cmd id, RC and RRC values upon failure to enter secure mode
Date: Fri, 11 Apr 2025 11:22:30 +0200
Message-ID: <20250411092233.418164-1-ggala@linux.ibm.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: _r7FzTIYmoGDZgtOro4TG726vEn7dW7O
X-Proofpoint-GUID: _r7FzTIYmoGDZgtOro4TG726vEn7dW7O
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-11_03,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 mlxscore=0
 bulkscore=0 malwarescore=0 phishscore=0 mlxlogscore=848 adultscore=0
 suspectscore=0 priorityscore=1501 spamscore=0 impostorscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2504110049
Received-SPF: pass client-ip=148.163.156.1; envelope-from=ggala@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

DIAG 308 (subcode 10 - performing secure execution unpack) response
code when the configuration is unable to enter secure mode has limited
usability as it is a fixed value (0xa02) for variety of different
reasons. The aim is to extend this DIAG to return UVC command ID, RC
and RRC values in addition to the diag response code. This feature can
be used by the stage3a bootloader (s390-tools/rust/pvimg/boot) to read
these new values from the corresponding register and print an
appropriate error message to help pin point the cause.

The response code, UVC RC, RRC, and command ID are returned in bit
positions 48-63, 32-47, 16-31, and 0-15 of register R1 + 1 if the
function does not complete successfully (Previously, only the
response code was returned in bits 48-63).

Gautam Gala (3):
  target/s390x: Introduce constant when checking if PV header couldn't
    be decrypted
  target/s390x: introduce function when exiting PV
  target/s390x: Return UVC cmd code, RC and RRC value when DIAG 308
    Subcode 10 fails to enter secure mode

 hw/s390x/ipl.c             | 11 ++++---
 hw/s390x/ipl.h             |  5 +--
 hw/s390x/s390-virtio-ccw.c | 24 +++++++++++----
 target/s390x/kvm/pv.c      | 62 ++++++++++++++++++++++++--------------
 target/s390x/kvm/pv.h      | 27 ++++++++++++-----
 5 files changed, 86 insertions(+), 43 deletions(-)

-- 
2.49.0


