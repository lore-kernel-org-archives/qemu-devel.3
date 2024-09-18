Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26C69CDD543
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2024 16:52:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sqxu5-00089C-9P; Wed, 18 Sep 2024 12:51:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chalapathi.v@linux.ibm.com>)
 id 1sqxty-0007oM-QE; Wed, 18 Sep 2024 12:51:39 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chalapathi.v@linux.ibm.com>)
 id 1sqxtx-0007kN-EN; Wed, 18 Sep 2024 12:51:38 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48IEZALw013596;
 Wed, 18 Sep 2024 16:51:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
 :to:cc:subject:date:message-id:mime-version:content-type
 :content-transfer-encoding; s=pp1; bh=ZfeU1qc5JhrVK9/tpNB907/44Y
 ITwVbuXx+cOQeVAxc=; b=ntF4JmI9xGLFcuOgGokv0HaZJvCkMkBB7IkckOCsOS
 CcYjrv0RqScGY+4YKvQhfyPGxxukRNA6tWM6IlZb2F+D6j5BX3KOXune5t7IZBKj
 wecia+bpY3btYB/sUicmKpVryyIU0qbza0SSMemdnfHw+Arzbd4U8KIrayuxGyGy
 5YCd2y8wo0j/FHKN3icnyTcV30/mu+ZN0CdnRzdXVP5osMzGbww4XpwxdUWn9V3w
 WNSMjPYG7ekYSo6ibV3apxofnrQe+XzucQQAI47XaSNPI8TZ6rX7FJn8M1zj1nH6
 RHjGTKXyZwQc+SIHQVg0NbVJezRYq8yA17aDFCmrq9MA==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41n41aq43b-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 18 Sep 2024 16:51:07 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 48IGp7gh000442;
 Wed, 18 Sep 2024 16:51:07 GMT
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41n41aq434-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 18 Sep 2024 16:51:07 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 48IEbGIx001884;
 Wed, 18 Sep 2024 16:51:06 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 41nqh3uy4d-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 18 Sep 2024 16:51:06 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 48IGp2lV32244174
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 18 Sep 2024 16:51:03 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D3AAC20049;
 Wed, 18 Sep 2024 16:51:02 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B90E720040;
 Wed, 18 Sep 2024 16:51:00 +0000 (GMT)
Received: from gfwr515.rchland.ibm.com (unknown [9.10.239.103])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 18 Sep 2024 16:51:00 +0000 (GMT)
From: Chalapathi V <chalapathi.v@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, fbarrat@linux.ibm.com, npiggin@gmail.com,
 clg@kaod.org, calebs@linux.ibm.com, chalapathi.v@ibm.com,
 chalapathi.v@linux.ibm.com, saif.abrar@linux.ibm.com,
 dantan@linux.vnet.ibm.com, milesg@linux.ibm.com, philmd@linaro.org,
 alistair@alistair23.me
Subject: [PATCH-for-9.2 v3 0/3] hw/ssi/pnv_spi: Remove PnvXferBuffer and
 get_seq_index()
Date: Wed, 18 Sep 2024 11:50:42 -0500
Message-Id: <20240918165045.21298-1-chalapathi.v@linux.ibm.com>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: LFdPT8xd8liXFxPlVQFxzeVJCd92sz-Q
X-Proofpoint-ORIG-GUID: ScyyJOVX8hvvwMksPWpAEDaTqL6zu8n2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-18_10,2024-09-18_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0
 lowpriorityscore=0 suspectscore=0 mlxscore=0 mlxlogscore=661 bulkscore=0
 impostorscore=0 phishscore=0 priorityscore=1501 spamscore=0 clxscore=1015
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409180110
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=chalapathi.v@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Hello,

v3:
1. Update the PowerNV maintainer section to include hw/ssi/pnv_spi*
2. Use of PnvXferBuffer results in a additonal process overhead due to
frequent dynamic allocations and hence use an existing Fifo8 buffer.
3. Use a local variable seq_index and use it with in while loop instead
of repeatedly calling get_seq_index() and make sure s->seq_op doesn't
overrun when seq_index is incremented.

Tested:
passed make check and make check-avocado

Supersedes: <20240807202804.56038-1-philmd@linaro.org>

Philippe Mathieu-Daudé (1):
  MAINTAINERS: Cover PowerPC SPI model in PowerNV section

Chalapathi V (2):
  hw/ssi/pnv_spi: Replace PnvXferBuffer with Fifo8 structure
  hw/ssi/pnv_spi: Use local var seq_index instead of get_seq_index().

 MAINTAINERS              |   2 +
 include/hw/ssi/pnv_spi.h |   3 +
 hw/ssi/pnv_spi.c         | 228 +++++++++++++++------------------------
 3 files changed, 89 insertions(+), 144 deletions(-)

-- 
2.39.5


