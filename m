Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9531ACD4F4A
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2026 17:26:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wP1j4-0007pt-TM; Mon, 18 May 2026 13:25:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <amachhiw@linux.ibm.com>)
 id 1wP1iz-0007nt-59; Mon, 18 May 2026 13:25:55 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <amachhiw@linux.ibm.com>)
 id 1wP1is-0005Ej-80; Mon, 18 May 2026 13:25:49 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64IGxaV33535366; Mon, 18 May 2026 17:25:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=PuWq72a1qR8AD57joikG9i8ldILiiQXlNrWoBcyi/
 Cg=; b=tUnOcNR8xuRtqu4wxRLzyTCh47eLYEtwZgBzP9PBiZ9OxZCViBycGkNHS
 So119bk1osyajL4CtKBo6kleIsiI3Cdb+u6CMkMBSuvRrQKdeSbuOXz3wIiFZaZq
 wBLoMBlYPt8shp1w7PbZVi899hRSP3uZlBPU+tblciSe0IPJlvU/T8caurvgnDpH
 IjUiQqHN0Av14CMy1kvG6Z+Fz+V1Y2u1WRfJcwt9Zov3/8nPItTDuB4uNdhCi5QU
 gG5baErq0BVLImYxPM+h5SiYU1lMF9EHtHxNHKxv2Q34MogL6ToPuvk9m8Rk5iw8
 6JNEp1HeFcy+dSdiHQuKH3jGxhG3Q==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e6haw0rp5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 18 May 2026 17:25:39 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64IHODoi030664;
 Mon, 18 May 2026 17:25:38 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4e73wjxyqb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 18 May 2026 17:25:38 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 64IHPZtl35979600
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 18 May 2026 17:25:35 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 042F42004B;
 Mon, 18 May 2026 17:25:35 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9C8F220040;
 Mon, 18 May 2026 17:25:31 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.39.29.56])
 by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 18 May 2026 17:25:31 +0000 (GMT)
From: Amit Machhiwal <amachhiw@linux.ibm.com>
To: Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-ppc@nongnu.org
Cc: Amit Machhiwal <amachhiw@linux.ibm.com>,
 Vaibhav Jain <vaibhav@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>,
 Chinmay Rath <rathc@linux.ibm.com>, Glenn Miles <milesg@linux.ibm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>,
 Shivaprasad G Bhat <sbhat@linux.ibm.com>,
 Gautam Menghani <gautam@linux.ibm.com>, qemu-devel@nongnu.org,
 kvm@vger.kernel.org
Subject: [PATCH v3 0/2] Fix GCC 16 const-correctness violations
Date: Mon, 18 May 2026 22:55:14 +0530
Message-ID: <20260518172517.12466-1-amachhiw@linux.ibm.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE4MDE2OCBTYWx0ZWRfX19nDBKIWc5uE
 VdBGE0c0OXXISKdqZC7tHdCIt4XKR4avOkHayvzBlK1VMSXC1ezf4WQCO+ftn5AP0HW41KGiG30
 f32X1KxrrfvX05L/HC1wd30BqaYYIKBQSZ6lzAjIbWtMVvj7x7FhOE2yLsN/5+0zF1zp2QPo9m8
 a4yxG3siO8vGk6kETsrAyLYjaDcIbgNFM9qreujj+0qPaP2+Uyn12fBrUEmpvNr1v4JE6VN/tqp
 7M8yYBTKt1HFabgk/PQjY3Mm6J/5ZhqWveyDP3EV/fFz/Xj0pQO0bjoQGyP9mlhfnw9sa4+9oRa
 E1P/7Tp90ufiOIxARzPK3bpJTYP3I1hKuOBkYQ7RvMjmZuZgy5+yYs9zJtonPKTEa94MCgxd9kg
 Rn6tq0JMG0A+QQgiSMUyVXeNqPsNOiWI9hVeqQxnSNX2hx30aFItRUUR3Zl78rWoInpx3yaILNS
 FfDFjn4sZ9ENzZBwvbw==
X-Authority-Analysis: v=2.4 cv=Np/htcdJ c=1 sm=1 tr=0 ts=6a0b4b93 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=0FG1SPa2GpMCbKQmkacA:9
X-Proofpoint-ORIG-GUID: VJkXXHD-Rm4T9iwLgQEW1JkzpXreE-Na
X-Proofpoint-GUID: 6pIxFtW8DYzlGS5va2QeFQiUC0uDiSW3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-18_03,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 clxscore=1011 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 suspectscore=0 adultscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605180168
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=amachhiw@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
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

GCC 16 has tightened const-correctness checking and now correctly
rejects attempts to modify or assign const-qualified pointers without
proper qualification. This series fixes two such violations that cause
build failures with GCC 16 when using -Werror=discarded-qualifiers.

Both patches follow the same approach: changing local variables to
const-qualified types and using GLib string functions (g_strdup,
g_strndup, g_strstr_len, g_getenv) that work correctly with const
strings, eliminating the need for in-place modifications.

Changes in v3:
- Harsh: g_strndup will abort the program in case of OOM eventually making it a
  dead code. Additionally, typecase (suffix - cname). Also, unlikely() is not
  needed.
    - Remove error handling (GLib functions abort on allocation failure)
    - Remove unlikely() macro (provides no benefit in initialization code)
    - Typecast (suffix - cname)
- Update the commit messages accordingly
- v2: https://lore.kernel.org/all/20260511131018.102168-1-vaibhav@linux.ibm.com/

Changes in v2:
- Avoid pointer aliasing
- Handle memory allocation failure error
- v1: https://lore.kernel.org/all/20260504134344.38958-1-amachhiw@linux.ibm.com

Tested on:
- GCC 16.1.1 (no warnings with -Werror=discarded-qualifiers)
- GCC 15.2.1 (backward compatible)

Amit Machhiwal (2):
  target/ppc/kvm: Fix const violation when trimming CPU alias suffix
  tests/qtest/libqtest: Fix const violation in qtest_verbose()

 target/ppc/kvm.c       | 11 +++++------
 tests/qtest/libqtest.c |  9 ++++-----
 2 files changed, 9 insertions(+), 11 deletions(-)


base-commit: ac6721b88df944ade0048822b2b74210f543d656
-- 
2.50.1 (Apple Git-155)


