Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3178C71141
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Jun 2025 20:56:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uPSUm-0000QW-0j; Wed, 11 Jun 2025 16:56:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jhkim@linux.ibm.com>)
 id 1uPSUf-0000PJ-CE
 for qemu-devel@nongnu.org; Wed, 11 Jun 2025 16:56:21 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jhkim@linux.ibm.com>)
 id 1uPSUd-0002VP-F0
 for qemu-devel@nongnu.org; Wed, 11 Jun 2025 16:56:21 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55BChTIh027686;
 Wed, 11 Jun 2025 20:56:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=mmh3Ss7ddWljTbsI3mPPULu7D2xyWae3UVd0kLNf+
 9U=; b=BGL0kZrDnLo7ZfZZGBydFObQdfjTnG8TO4HWUeG1gg4E59ww8IkCqBwUb
 ieRS/VJ8C3fmm3oxU4mx+DR48yJ1cyfaGVhbs3JRS60HKLlpUb0EEsr/00rAssHB
 5Vr+02Wp9CNfdJyvTYiaHV7Ii4EL1hVBWKzZtc71DMXfJBdXgT6uc090tGeOLyhg
 c3HhxZzYLua6Slk6yM0DuEgt9dlVoYtaOt42GAwjhz8aHt2DCd9Eo8pcBrW0AMph
 oVmLKjLzLZFyxjtN1jQESYtOtlO8OvJ+O+JMw1uraVbDwjM+2XydO7yss0aACMK/
 fvSazTLC3Ofi3llaEMq7b3PbvW8Gw==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 474cxjf1r3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 11 Jun 2025 20:56:15 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 55BI1GB9014948;
 Wed, 11 Jun 2025 20:56:14 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4750rp9gev-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 11 Jun 2025 20:56:14 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com
 [10.241.53.103])
 by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 55BKuD2331392494
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 11 Jun 2025 20:56:13 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id EC7FB58052;
 Wed, 11 Jun 2025 20:56:12 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B108D5805A;
 Wed, 11 Jun 2025 20:56:12 +0000 (GMT)
Received: from IBM-GLTZVH3.ibm.com (unknown [9.61.250.224])
 by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 11 Jun 2025 20:56:12 +0000 (GMT)
From: Jaehoon Kim <jhkim@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: jjherne@linux.ibm.com, steven.sistare@oracle.com, peterx@redhat.com,
 farosas@suse.de, lvivier@redhat.com, pbonzini@redhat.com,
 Jaehoon Kim <jhkim@linux.ibm.com>
Subject: [PATCH v4 0/2] migration: Support socket fd for CPR and fix
Date: Wed, 11 Jun 2025 15:56:08 -0500
Message-ID: <20250611205610.147008-1-jhkim@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: dMMssQE08qlEZ3Lr9gv4SuC7GtysD3Tm
X-Proofpoint-GUID: dMMssQE08qlEZ3Lr9gv4SuC7GtysD3Tm
X-Authority-Analysis: v=2.4 cv=fZWty1QF c=1 sm=1 tr=0 ts=6849ed6f cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=6IFa9wvqVegA:10 a=X9ao9dJPHCAfSuR0ugkA:9 a=ZXulRonScM0A:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjExMDE3NiBTYWx0ZWRfX7WXm2rcxT7Ef
 j5lwWW2OLFPKweMB2SSqnAjWWnXsXWqha2ZByDAP6G2aJXBiEICb7s1LvMUTaCzaFlOW5yTYvaA
 ykkm/gvmFx4LgWBeWrfjDJRgA7u+yl7qrDtDa8Nw1oIZ5zIVXJqE1s3B6x2ZOVQ8U0a8S+SDodu
 7fgbemh3eExM01ivJq4YvEScG11BSV9Ut7UD7GeTiHL/fg5Esr8hxflBVC42xtxlQHl5MNUshHh
 BvOL7MxGCNnGbalyw1iK5ZSZAaxL9vbbMmHegTXmee/6KxP+UgunzFKaJCh9eWAEAiKKLuTrB5Y
 X3OWY6ee3Zt1cmdbQJ7x4NLqXwe/fUgxxRaGOgNxc9q0ADD7B3mFDw9Istq7XKqZStALwG8veB7
 1Nl63PAVaDgwsZY7v0q63HgFdgAibZQPBe8knU73rypl5hiZj8OD0z8pAoFcaIz5K4XXWK1W
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-11_09,2025-06-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0
 priorityscore=1501 spamscore=0 bulkscore=0 phishscore=0 suspectscore=0
 adultscore=0 mlxscore=0 malwarescore=0 lowpriorityscore=0 mlxlogscore=604
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506110176
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

This is v4 of the patch series.

Changes since v3:
- [Patch 1/2]: Applid review feedback from Steve Sistare - now using
  '%d' in g_strdup_printf

- [Patch 2/2]: No changes; Kept as-is with Reviewed-by from Steve
  Sistare.

Jaehoon Kim (2):
  tests/migration: Setup pre-listened cpr.sock to remove race-condition.
  migration: Support fd-based socket address in cpr_transfer_input

 migration/cpr-transfer.c          |  7 +++++--
 tests/qtest/migration/cpr-tests.c | 14 ++++++++++++--
 2 files changed, 17 insertions(+), 4 deletions(-)

-- 
2.49.0


