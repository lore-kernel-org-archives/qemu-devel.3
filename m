Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21891C369CB
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Apr 2025 08:09:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7VAf-0000rm-TI; Wed, 23 Apr 2025 04:09:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ggala@linux.ibm.com>)
 id 1u7VAd-0000pc-Kq; Wed, 23 Apr 2025 04:09:27 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ggala@linux.ibm.com>)
 id 1u7VAb-0006ke-15; Wed, 23 Apr 2025 04:09:27 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53N6fmQn024709;
 Wed, 23 Apr 2025 08:09:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=CAY1lfGDnq37OKR1zFZklBCcEigeEgpNp//uoCEWv
 /0=; b=lsn4+Ot/NutkfSlTGyRE1Syz84wv0Nd2IFxzOBK5Z82QRxZuIfn8Yq0g+
 +GS7IaoWYpwAPOoMIIIJzkC0BUCF9eoHx50lRl9ylShaXo/qvyrXzKPsIve7KWWh
 7oYxPnJodIVnG8V986mx9pQcZVkJPAEUNmpEJmYlYs/UWfcnauc8Q2eLZLm4Ij7z
 WXVonOoPw14KzdF9uonv8xB1j7CHXeH3PWI1tO+wl7+kXGGGbxo1kE/njh7X8QfF
 UV2K/58PVFg6VHHVXdAqVnSkIgsHHxsB6GTAWt3BqcWGfgcRQwYiEb61GURcZOtu
 qxkPHWQwuQIKhKsA3sll04Vv/1P5A==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 466k77j2ya-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 23 Apr 2025 08:09:19 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53N6V75Q005872;
 Wed, 23 Apr 2025 08:09:18 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 466jfxa3p0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 23 Apr 2025 08:09:18 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com
 [10.241.53.102])
 by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 53N89HwQ21889704
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 23 Apr 2025 08:09:17 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9DCAD58056;
 Wed, 23 Apr 2025 08:09:17 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7BB315803F;
 Wed, 23 Apr 2025 08:09:16 +0000 (GMT)
Received: from t83lp65.lnxne.boe (unknown [9.152.108.100])
 by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 23 Apr 2025 08:09:16 +0000 (GMT)
From: Gautam Gala <ggala@linux.ibm.com>
To: qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>,
 Thomas Huth <thuth@redhat.com>, Steffen Eiden <seiden@linux.ibm.com>,
 Janosch Frank <frankja@linux.ibm.com>
Subject: [PATCH v5 0/3] DIAG 308: extend subcode 10 to return UVC cmd id,
 RC and RRC values upon failure to enter secure mode
Date: Wed, 23 Apr 2025 10:09:12 +0200
Message-ID: <20250423080915.1048123-1-ggala@linux.ibm.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: pAG7w3o0OjL6wwR1oi3jqXwx8LvC2qe-
X-Authority-Analysis: v=2.4 cv=TNdFS0la c=1 sm=1 tr=0 ts=6808a030 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=XR8D0OoHHMoA:10 a=VnNF1IyMAAAA:8 a=20KFwNOVAAAA:8 a=9lonpTW9IpegU1W_ekgA:9
X-Proofpoint-GUID: pAG7w3o0OjL6wwR1oi3jqXwx8LvC2qe-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDIzMDA1NCBTYWx0ZWRfXzucX6pHq/4PG
 B2BHS3TMlIY7risLExykOX3kuPMwqCttU89Ntsm484968oosvnPPy1vMvRq6Zvw66KmIpIaljM5
 XHRGiUjQz9/kE38qE1c5ML4pI50l/ayOxalzRYFIbksgorVhO/FaXHC75irhwqzNTen2h1TksPs
 F29XoLUujftoltaSOqGEavC4HOyf6eRLTgbcq3ARGJNnJcP4rm4w1VrM4D6r5aA2mUleJlA4GJZ
 s8FcXtlbPAo3my3S0Cz406PKBR5G3GHm/730+1rZZrzosECrOj17UBrgfmSiWH1uHLywcm/TJhr
 QuLojCaJjLhmXyTe6/CuMgPm0ZCq1/pe+Q+z5WcyliK5KeQcLkf7a0ZhDL2+0KuZjfs19MvfapP
 vMqgjkhjdv/NmjJ2/PGeEnefqHqi8y93WH2nc3FHOcMwoUJr8DDScuZPVOPmRxBcU0ul2eSy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-23_06,2025-04-22_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0
 priorityscore=1501 mlxscore=0 bulkscore=0 mlxlogscore=991 malwarescore=0
 suspectscore=0 adultscore=0 impostorscore=0 phishscore=0
 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2504230054
Received-SPF: pass client-ip=148.163.156.1; envelope-from=ggala@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

These patches contains updates based on feedback from Janosch Frank 
and Thomas Huth from message-IDs
<7d812276-9f93-4fbd-90d4-b5d1cdd8c63b@linux.ibm.com> and
<5a526ecf-d62d-46c8-9881-fdec381693e3@redhat.com>

Gautam Gala (3):
  target/s390x: Introduce constant when checking if PV header couldn't
    be decrypted
  target/s390x: Introduce function when exiting PV
  target/s390x: Return UVC cmd code, RC and RRC value when DIAG 308
    Subcode 10 fails to enter secure mode

 hw/s390x/ipl.c             | 11 ++++---
 hw/s390x/ipl.h             |  6 ++--
 hw/s390x/s390-virtio-ccw.c | 14 ++++----
 target/s390x/kvm/pv.c      | 66 +++++++++++++++++++++++++-------------
 target/s390x/kvm/pv.h      | 26 +++++++++++----
 5 files changed, 80 insertions(+), 43 deletions(-)

-- 
2.49.0


