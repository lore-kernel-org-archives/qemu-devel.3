Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B62FBC54F51
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2026 16:31:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wp7BM-0003f5-PN; Wed, 29 Jul 2026 12:31:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imbrenda@linux.ibm.com>)
 id 1wp7BL-0003em-U3; Wed, 29 Jul 2026 12:30:59 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imbrenda@linux.ibm.com>)
 id 1wp7BJ-0002hG-3c; Wed, 29 Jul 2026 12:30:59 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66TFHn0d356419; Wed, 29 Jul 2026 16:30:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=VrmZ6oWEzawslv5z7qwpzvKCOk1bqmPse8PYp4rEy
 Lo=; b=VND821RKvItKJIn3c+oLAj++vOF1HTmV7wX/UPhSif3741Hb5NBWYW7mL
 Uptg9ZOMT6ov2lMFXYlCv5QzGoP3frrcjq1QdbhycQoSXfwGv36nxF29IGguK6R5
 p5CCSTxYwpDHpWj7qTlzjKyAD6mpobxBIQv7k9M3c20AWKWgJN/Fp2p/63Qtw06C
 ggjhvm61hM/p1XYMP42Kj9JvhbR8pvjBIv0zw842NMDPbgTKT9RW8EdZtipCUYGs
 tot3+Jp6g188nbB/SMfehK8doh/B2KccgBRqIRBrSaVLuIDKBkzZCEJiJlmykPGI
 ZE+e0P0tNfC192DhviCZnyAIhv0wA==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmuw7knfh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 29 Jul 2026 16:30:51 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66TGQFCT010643;
 Wed, 29 Jul 2026 16:30:50 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fn9pgfa5t-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 29 Jul 2026 16:30:50 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 66TGUi8h31195524
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 29 Jul 2026 16:30:44 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5AAAF2004B;
 Wed, 29 Jul 2026 16:30:44 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1F8E520040;
 Wed, 29 Jul 2026 16:30:44 +0000 (GMT)
Received: from p-imbrenda.ehn-de.ibm.com (unknown [9.224.75.30])
 by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 29 Jul 2026 16:30:44 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, borntraeger@de.ibm.com, frankja@linux.ibm.com,
 pasic@linux.ibm.com, mhartmay@linux.ibm.com, david@kernel.org,
 farman@linux.ibm.com, mjrosato@linux.ibm.com,
 richard.henderson@linaro.org, iii@linux.ibm.com, cohuck@redhat.com
Subject: [PATCH v2 0/1] target/s390x: Allow 2G hugepages guest backing
Date: Wed, 29 Jul 2026 18:30:42 +0200
Message-ID: <20260729163043.843517-1-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: BjLqOMOAtL5rjJrBTZGGSvCm17zgciTg
X-Proofpoint-ORIG-GUID: BjLqOMOAtL5rjJrBTZGGSvCm17zgciTg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI5MDEyOSBTYWx0ZWRfX2MQ5i40IkO+l
 6ztGFSStwxy97W+eRZ2XIM8k1gYCTMObw6rmoOvt+c2YFMJwvep0E8eov43OPu1JtuJltCLrJXh
 fjo+f3iAiqBmboiDtAKXZUBDF56NHLCa4Se/baAOtNc1a3VYR1mevI49n7W7QOXb3bj8r9OLN8q
 sC7SNXY7aUiQ5y8ie0W6+7m8jDwPhvCH6WvKm/XybD/QZdyvs0K0ySS/JRXmorjMN9ZjZq19JS6
 9VxKEStLYB7JicQILd4p6AxT4/dybUwoMaZrvwyFyieYWtjnKUQLm1vatnR6hw1f14fKIcMO3wU
 uewAZk2+0Em2wLZYxirhM+8QpAebR1x3orYsiznHu5YHpskGykIevDtQ45oxGkhxeVuaJJjgU59
 70sJuroTQXymKudrfeiqZ2hNY2f/5IgBhUWf6GtuZwq+Chns5qPOUpURs4qCHcDYtPdwcqGbxLa
 1TpkyssxNJNwzo5mnKg==
X-Authority-Analysis: v=2.4 cv=SKFykuvH c=1 sm=1 tr=0 ts=6a6a2abb cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=NKObR2d5V9wX7O2UfkQA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI5MDEyOSBTYWx0ZWRfXx8dnXQIWXVQ5
 NRTzv4oBedNzzC53Vp9KPa7oscPelkakDbS846wmt4rLEeOKhSyTSJTPZGrQHY7QEi9OMi7mB2u
 vyB2Gbfjp2ztANYbTQ4joTGl2ZSJptg=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-29_06,2026-07-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 clxscore=1015 adultscore=0
 lowpriorityscore=0 bulkscore=0 impostorscore=0 phishscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607290129
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

v1->v2:
* Rename the global variable to cap_hpage
* Use different values of cap_hpage to distinguish between hpage sizes
* Add wrappers to test for specific hpage sizes


Claudio Imbrenda (1):
  target/s390x: Allow 2G hugepages guest backing

 target/s390x/diag.c          |  2 +-
 target/s390x/kvm/kvm.c       | 40 +++++++++++++++++++++++-------------
 target/s390x/kvm/kvm_s390x.h |  2 ++
 target/s390x/kvm/stubs.c     | 10 +++++++++
 4 files changed, 39 insertions(+), 15 deletions(-)

-- 
2.55.0


