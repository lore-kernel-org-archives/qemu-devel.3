Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 102F0CEE323
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2024 09:30:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sypUY-0001l4-Jh; Thu, 10 Oct 2024 05:29:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1sypUV-0001k4-AQ
 for qemu-devel@nongnu.org; Thu, 10 Oct 2024 05:29:51 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1sypUT-00041S-22
 for qemu-devel@nongnu.org; Thu, 10 Oct 2024 05:29:50 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49A3qxcE011707;
 Thu, 10 Oct 2024 09:29:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
 :to:cc:subject:date:message-id:content-transfer-encoding
 :mime-version; s=pp1; bh=PyQT/oON0CIBQsDzxfOSpbK4wTUFZw2XZff7ttM
 FM/E=; b=QH5McQPJ3Ge9d/2FOSM7uLB9yfG71OPhDyBI+HhNZjhTGjbFdZasAd7
 XLRMFbxgxSPk4sB2ibZbjONCyWYiLGxYDfk6eKub7TqCfNvzR+DTTRax1Eng/ERc
 szOB9lfm2sBWcP37tSiVSPvDi7Ei4V4Acyaa8TZNmZRDgxzmatuvfjiL5J0EuH9s
 44gXqpmDB84Yjix46pr/k/OXbF+yQ5djloU7JP7kp0Rsl6hH4Uhkb/yQ43eYNxpP
 I74NyGvI8zbhi7K3ImF03793k2+EwmhS9ikqD6fq8SRJOjSSwhnY7ziqnArMfiBR
 3FbDyDf2BDGsnU1zq772eokfn7+27aQ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4267cmshqy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 10 Oct 2024 09:29:45 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 49A71Fvu010718;
 Thu, 10 Oct 2024 09:29:44 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 423j0jpr23-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 10 Oct 2024 09:29:44 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 49A9Thgs54853916
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 10 Oct 2024 09:29:43 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 023F62004E;
 Thu, 10 Oct 2024 09:29:43 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9FD792004B;
 Thu, 10 Oct 2024 09:29:42 +0000 (GMT)
Received: from heavy.ibm.com (unknown [9.171.88.135])
 by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 10 Oct 2024 09:29:42 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 qemu-devel@nongnu.org, Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH 0/4] Minor gdbstub cleanups
Date: Thu, 10 Oct 2024 11:26:55 +0200
Message-ID: <20241010092938.226868-1-iii@linux.ibm.com>
X-Mailer: git-send-email 2.46.2
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: AP99U4kX15ve2Mn8q1HBLd_hYlXI6eBy
X-Proofpoint-GUID: AP99U4kX15ve2Mn8q1HBLd_hYlXI6eBy
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-10_05,2024-10-09_02,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0
 lowpriorityscore=0 malwarescore=0 adultscore=0 priorityscore=1501
 phishscore=0 mlxlogscore=502 mlxscore=0 spamscore=0 suspectscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410100062
Received-SPF: pass client-ip=148.163.156.1; envelope-from=iii@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Hi,

These four patches are from the [1] series, which will probably take a
while. But IMHO they make sense on their own, so I'm sending them as a
separate series.

[1] https://lore.kernel.org/qemu-devel/20240923162208.90745-1-iii@linux.ibm.com/

Best regards,
Ilya

Ilya Leoshkevich (4):
  gdbstub: Make gdb_get_char() static
  gdbstub: Move phy_memory_mode to GDBSystemState
  gdbstub: Move gdb_syscall_mode to GDBSyscallState
  gdbstub: Factor out gdb_try_stop()

 gdbstub/gdbstub.c   | 15 +++++++++++----
 gdbstub/internals.h |  4 ++--
 gdbstub/syscalls.c  | 20 ++++++++++----------
 gdbstub/system.c    | 18 ++++++++----------
 gdbstub/user.c      | 13 +++++--------
 5 files changed, 36 insertions(+), 34 deletions(-)

-- 
2.46.2


