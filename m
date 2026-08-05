Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77141C56205
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2026 10:38:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wrZ0T-00045S-Dj; Wed, 05 Aug 2026 06:37:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imbrenda@linux.ibm.com>)
 id 1wrZ0L-00044r-PI; Wed, 05 Aug 2026 06:37:47 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imbrenda@linux.ibm.com>)
 id 1wrZ0J-0004vK-Ny; Wed, 05 Aug 2026 06:37:45 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6758lb8p3387311; Wed, 5 Aug 2026 10:37:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=F+nKe5Qpl6Q/aiN+p08bD9S80SrAv309NShdFrkgj
 /s=; b=HSKn38ulS3ZbkF/VUPNzYx1QrIn9V1Af16YuPN4e4+z/sKrYq7WFK2QYX
 bgs7lQ4j2Miw0LHDEijoHt0vq4jw/bsiRW56iRvgnjD3EQvlqVqmPgzLwzoFVH5x
 Vg5IVlBVGTPw9DXssrOtHT8I6NLPQE8a8PZbNVnBi53hxN9ax/oFlAYx1x2eBtpn
 v8UAuO3KCbVOREHUfsDbxZ08+dU+gCW0hUIDbw3iLlBGAawtR+go8D6qnlVrm2Q2
 4VQNpu9npCWK/xrtSx56/oWOdtlQGeLxaHq0MW00tinfyxD7ONdFEi9RdvoLbLpf
 h8jDc8ckNbWKiuc9Xa/i+8FPKNYZg==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs8h52kaj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 05 Aug 2026 10:37:36 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 675AQLks002097;
 Wed, 5 Aug 2026 10:37:35 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fsugw685u-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 05 Aug 2026 10:37:35 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 675AbTYb10682654
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 5 Aug 2026 10:37:29 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1ADE12004D;
 Wed,  5 Aug 2026 10:37:29 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D98B020043;
 Wed,  5 Aug 2026 10:37:28 +0000 (GMT)
Received: from p-imbrenda.ehn-de.ibm.com (unknown [9.224.75.30])
 by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed,  5 Aug 2026 10:37:28 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, borntraeger@de.ibm.com, frankja@linux.ibm.com,
 pasic@linux.ibm.com, mhartmay@linux.ibm.com, david@kernel.org,
 farman@linux.ibm.com, mjrosato@linux.ibm.com,
 richard.henderson@linaro.org, iii@linux.ibm.com, cohuck@redhat.com
Subject: [PATCH v3 0/1] target/s390x: Allow 2G hugepages guest backing
Date: Wed,  5 Aug 2026 12:37:27 +0200
Message-ID: <20260805103728.97602-1-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA1MDA4MSBTYWx0ZWRfXw2G7k5ekH3Yq
 6uemhzA8h1H3buB3TxasE6HQOZ1kxPGy0059nIlvZaxF/rIO0IluqQE10SssDpB4nY78ry4EpVs
 h+VVayCpHsyCfK/TOJijc68SQgeLFoM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA1MDA4MSBTYWx0ZWRfX8ZdGgazjIx4C
 IO6uJLyapV6//q/46+p86bRQhvLMyLW8fgxUHi/OKkp2pS7AjDoAzWifD4y1/Ydou2yxsN0ITua
 5IgI6xOGkWQnL21cyySUms3mtCoj8Ef88FKR3oTMmA9KgWkSbx6OTexJO9M9M0+V9cwevM118rL
 temc801zqiHnXgL4fI6EqoecCqw3LI2k0iQ3beLrk1Z8vYTC6kZFHphn4FL3JAnCjW+AqsKB+Bo
 oFNOlRVINaneR/blUcx/W9dNfnMVcfh0C4wJNunbCXvilWMSNjRmn27sdHLqB9UViDo0TsvINgd
 0tQ/Ik7ecLrpafNe3pTLxvCduDodAAmC5RrMk5bXltslaVxvmIW/7NUKY8zKNb0yiHqrbMYyRjr
 zPfrSC5gOHpCLHfk5gcJQ/gB12MjLYqCsjLjWnzubukqY0yqjfAyks7T3jgdkfMFDX5Ov+I8uLK
 tWD8GppWqp/M0AVkuXw==
X-Authority-Analysis: v=2.4 cv=SI1ykuvH c=1 sm=1 tr=0 ts=6a731271 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=NKObR2d5V9wX7O2UfkQA:9 a=zZCYzV9kfG8A:10
X-Proofpoint-ORIG-GUID: wy72P7u2zDX5gj1SewiUZ0NIaoMI6M2E
X-Proofpoint-GUID: wy72P7u2zDX5gj1SewiUZ0NIaoMI6M2E
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-05_03,2026-08-04_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 suspectscore=0 impostorscore=0 spamscore=0
 phishscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608050081
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=imbrenda@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
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

Allow mapping guest with 2G hugepages on hosts that support it.
    
Add new helper functions to check whether hpages are in effect, and
which size.

v2->v3:
* Remove dead code introduced in the previous version.
* Factor out the capability enablement and error reporting to avoid
  duplicating code and error messages.
* Optimize the control flow and bring it back in line with the previous
  behaviour regarding page sizes, i.e. assuming that if the page size
  is neither 4K nor 1M, then it must be 2G.

v1->v2:
* Rename the global variable to cap_hpage
* Use different values of cap_hpage to distinguish between hpage sizes
* Add wrappers to test for specific hpage sizes

Claudio Imbrenda (1):
  target/s390x: Allow 2G hugepages guest backing

 target/s390x/diag.c          |  2 +-
 target/s390x/kvm/kvm.c       | 36 +++++++++++++++++-------------------
 target/s390x/kvm/kvm_s390x.h |  2 +-
 target/s390x/kvm/stubs.c     |  2 +-
 4 files changed, 20 insertions(+), 22 deletions(-)

-- 
2.55.0


