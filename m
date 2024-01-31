Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17E0BC47DB3
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jan 2024 23:10:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVJiV-00077G-0g; Wed, 31 Jan 2024 18:10:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1rVJiM-00075q-Vo; Wed, 31 Jan 2024 18:09:56 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1rVJiG-0000JQ-Pe; Wed, 31 Jan 2024 18:09:54 -0500
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 40VMZtNB026425; Wed, 31 Jan 2024 23:09:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : content-transfer-encoding : mime-version; s=pp1;
 bh=+RcPhOra2TyTSkSs8sIFOHvo0T1BgcFzYCEhx0R+HUc=;
 b=WOJBGWXtuPGKx+tXMibuy7acTPt8rwr8N5lQs4epjbUgkyVqecm5S9/KbQMOnTVQit+x
 MCrE+AjZB58pTbK+poJIC+Onl39sOSRPEPsyFqDEZOz/HsDLZOauxFO808EB5jFklUdw
 MSEZ0+EHXdSayzqYF3ZgOXZ/pevaAIHy1JhwGFP4HLAd11uBe67erFRfapfm0leteTBg
 kXVrecaikXk9jTo/d/BnL/JsPQThCaaS8WWdSvx174oI1ANJPZqQ+uOM4Lcehe63dqpL
 SBouuOTEl/gL0C1ermva/9qj0xBi6heNcvC21PwF0q3C8i+wfKEgOBXoux5//h8MkSe2 nw== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vyx9e9qhv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 31 Jan 2024 23:09:45 +0000
Received: from m0353727.ppops.net (m0353727.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 40VMmxkV031655;
 Wed, 31 Jan 2024 23:09:44 GMT
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vyx9e9qhm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 31 Jan 2024 23:09:44 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 40VMO1a8010858; Wed, 31 Jan 2024 23:09:43 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3vweckr4q7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 31 Jan 2024 23:09:43 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 40VN9foY44892576
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 31 Jan 2024 23:09:41 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id AD35B20043;
 Wed, 31 Jan 2024 23:09:41 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 32BE820040;
 Wed, 31 Jan 2024 23:09:41 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.171.74.74])
 by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 31 Jan 2024 23:09:41 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@redhat.com>, Thomas Huth <thuth@redhat.com>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org,
 Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH v3 0/4] target/s390x: Emulate CVDG and CVB*
Date: Thu,  1 Feb 2024 00:07:09 +0100
Message-ID: <20240131230938.325919-1-iii@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: ymgYkOS4mN3B1EPLTGiP0rwI8WFvOO_v
X-Proofpoint-ORIG-GUID: M7Df9CTYkTcUEW05zrieHVy17DNab70U
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-31_10,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0
 priorityscore=1501 spamscore=0 mlxscore=0 bulkscore=0 mlxlogscore=573
 adultscore=0 impostorscore=0 clxscore=1015 suspectscore=0 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401310178
Received-SPF: pass client-ip=148.163.156.1; envelope-from=iii@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

v2: https://lists.gnu.org/archive/html/qemu-devel/2024-01/msg05048.html
v2 -> v3: Resurrect an old CVB* patch (Thomas).
          Add Richard's R-b.

v1: https://lists.gnu.org/archive/html/qemu-devel/2024-01/msg02865.html
v1 -> v2: Fix !CONFIG_INT128 builds (Richard).

Hi,

Ido reported that we are missing the CVDG emulation (which is very
similar to the existing CVD emulation). This series adds it along with
a test.

Best regards,
Ilya

Ilya Leoshkevich (3):
  target/s390x: Emulate CVDG
  tests/tcg/s390x: Test CONVERT TO DECIMAL
  tests/tcg/s390x: Test CONVERT TO BINARY

Pavel Zbitskiy (1):
  target/s390x: implement CVB, CVBY and CVBG

 target/s390x/helper.h            |  2 ++
 target/s390x/tcg/insn-data.h.inc |  5 +++
 target/s390x/tcg/int_helper.c    | 61 ++++++++++++++++++++++++++++++++
 target/s390x/tcg/translate.c     | 20 +++++++++++
 tests/tcg/s390x/Makefile.target  |  2 ++
 tests/tcg/s390x/cvb.c            | 47 ++++++++++++++++++++++++
 tests/tcg/s390x/cvd.c            | 45 +++++++++++++++++++++++
 7 files changed, 182 insertions(+)
 create mode 100644 tests/tcg/s390x/cvb.c
 create mode 100644 tests/tcg/s390x/cvd.c

-- 
2.43.0


