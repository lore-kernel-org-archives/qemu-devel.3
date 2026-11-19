Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B8CE606A93B
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Nov 2026 20:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=fHfIu7CT
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xU8vv-0003OQ-10; Thu, 19 Nov 2026 15:40:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mliebel@qualcomm.com>)
 id 1xU8vA-0003BA-1z
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 15:39:56 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mliebel@qualcomm.com>)
 id 1xU8v3-0007IX-SR
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 15:39:51 -0500
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AJJ1Mvk2620057
 for <qemu-devel@nongnu.org>; Thu, 19 Nov 2026 20:39:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=b+VJTQX8XD0T6xpN9XMm4k
 MWJzsYi5fJua8JC59VuJA=; b=fHfIu7CTiBiJ6WychMq51tStPWvpI5mjF/gNv5
 UpuW0B0TJCqVfVHmCbU85+ik414HcDVkpUc8R1J5Rcsjje1v4R4nXDgFuxDCR4y/
 fvLMxQUYHVihosyR1rGb633xwzK+CzphpsBLyaSbjToACFBH9X4To1alc2I6IN/U
 kKSX1Fu8JobAZcGgi1Ez0FGbvh1CjBWajBAjFG3fE6v913BMFuUVRv08rTFewYOV
 PrmWLoy+o5FMycUZWRs/9RzsiIdnj47z82NJ91aD9bK65+llGpUvsbguZl1EHWZx
 w8Tf1CKciqhgVN3NPx5+BhiDmOgc4dredgGk8dU+ai17pa7A==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com
 [129.46.96.20])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j1yghjtuk-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 19 Nov 2026 20:39:42 +0000 (GMT)
Received: from pps.filterd (nalasppmta01.qualcomm.com [127.0.0.1])
 by NALASPPMTA01.qualcomm.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AJKdfBU3570560; Thu, 19 Nov 2026 20:39:41 GMT
Received: from hu-devc-lv-u24-a.qualcomm.com (hu-mliebel-lv.qualcomm.com
 [10.81.81.31])
 by NALASPPMTA01.qualcomm.com (PPS) with ESMTPS id 6AJKdfXZ3570547
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 19 Nov 2026 20:39:41 +0000 (GMT)
Received: by hu-devc-lv-u24-a.qualcomm.com (Postfix, from userid 4282937)
 id 6C10B23F14; Thu, 19 Nov 2026 12:39:41 -0800 (PST)
From: Marco Liebel <marco.liebel@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Brian Cain <brian.cain@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Marco Liebel <marco.liebel@oss.qualcomm.com>
Subject: [PATCH v2 00/13] target/hexagon: fix packet execution and fault
 handling
Date: Thu, 19 Nov 2026 12:39:28 -0800
Message-ID: <20261119203941.899748-1-marco.liebel@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
Content-Type: text/plain; charset="utf-8"
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Reinject: loops=2 maxloops=12
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE5MDA4MiBTYWx0ZWRfX7vsYBOuLuHKA
 CXa8nLpNuOrTie899d5+fV3EZvpwFRv5tpmYf09VnPRSdBSBCei8sK046yc+TXMcR/Vg5gCFoPx
 WLVvYOmuwarkOdcLRt4kUB2Q8LTr9T4Aq76C5U4fSe4CEPuBDshH9NAYVmWKbiDCCjSkYcLHF3K
 TACC31GnNan5pNTosBPvkHo/pqGFZSWuNZZTwTmytXj5f3YVX2y1Ubjd1gwch0cQGJhfV3YmPgl
 Rs692hrp8GAiYF52D+RVyLxZUqKCwm4309yzgnvxjfqd3NIoJDJKfbVUvZZWeHb4NTfeI0BtFY+
 U1ew5UR32gj8joJLOEZh34wyx6DfMyfBnoTgAiO540wtFp4CRTbwdCi+OOg8Q0mwdRd6MV569L1
 z8rrzfc+60G187zZJwUMZDzWutGMZTCqCfQxVE0D17wFDHISysgU52z2BRwuWEMf40ktshNh7kO
 file/JvAAM02PKhIK+A==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE5MDA4MiBTYWx0ZWRfX3x0Hym77objs
 knElwKLx4sPE+LQzHHEdi2vfwczubzXlaLVuPPClGP/F1w22QwjGSmqa5AWR2LTziaRB0zfmnQS
 pG0YmyOjYEwQ9NAbGVkm5JDXk/Hmnzc=
X-Authority-Analysis: v=2.4 cv=Vvi2kO2n c=1 sm=1 tr=0 ts=6aff5e8e cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=GaQpPoNlAAAA:8
 a=EUspDBNiAAAA:8 a=yRlCseFeQJHVRpsraEgA:9 a=QEXdDO2ut3YA:10
 a=xF5q_uoM5gZT5J3czcBi:22
X-Proofpoint-GUID: 6B29hve9On5V6c5FtSc0R8K-8bxsOfFw
X-Proofpoint-ORIG-GUID: 6B29hve9On5V6c5FtSc0R8K-8bxsOfFw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-19_05,2026-11-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 malwarescore=0 phishscore=0 spamscore=0
 bulkscore=0 adultscore=0 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611190082
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=mliebel@qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This series is intended for QEMU 11.2.

Changes in v2:

Removed v1 patches 1 (C4 predicate reads) and 7 (packet lookahead).
Brian is carrying them here:
https://patchew.org/QEMU/20261119201603.2377989-1-brian.cain@oss.qualcomm.com/
Apply those fixes before running the full packet regression suite.

Patches 3, 7, 9-12: Use TCG instead of added runtime helpers to reduce
memory-check overhead.

Marco Liebel (13):
  target/hexagon: allow writes to V85 USR coprocessor fields
  target/hexagon: suppress LR writes from a losing call
  target/hexagon: reject HMX operands outside VTCM
  target/hexagon: commit coprocessor results before context changes
  target/hexagon: distinguish packet-page instruction TLB misses
  target/hexagon: report the faulting memory slot
  target/hexagon: retain both scalar packet fault addresses
  target/hexagon: preserve inactive BADVA registers
  target/hexagon: probe scalar packet memory in slot priority order
  target/hexagon: prioritize packet alignment in the fault path
  target/hexagon: validate both stores before packet commit
  target/hexagon: probe VMEMU upper transactions before lower ones
  tests/functional/hexagon: add packet regression tests

 hw/hexagon/hex-subsys.c                  |  4 ++
 include/hw/hexagon/hexagon.h             |  2 +
 target/hexagon/cpu.c                     | 76 +++++++++++++++++++--
 target/hexagon/cpu.h                     | 12 ++++
 target/hexagon/gen_tcg_func_table.py     |  6 ++
 target/hexagon/gen_tcg_funcs.py          | 38 +++++++++++
 target/hexagon/genptr.c                  | 55 ++++++++++++++-
 target/hexagon/genptr.h                  |  4 ++
 target/hexagon/helper.h                  |  5 +-
 target/hexagon/hex_common.py             | 22 ++++++
 target/hexagon/internal.h                |  5 ++
 target/hexagon/op_helper.c               | 72 ++++++++++++++++++--
 target/hexagon/reg_fields_def.h.inc      |  2 +
 target/hexagon/translate.c               | 85 +++++++++++++++++++++---
 target/hexagon/translate.h               | 11 ++-
 tests/functional/hexagon/meson.build     |  2 +
 tests/functional/hexagon/test_packets.py | 47 +++++++++++++
 tests/tcg/hexagon/meson.build            |  2 +
 tests/tcg/hexagon/packet_user.c          | 61 +++++++++++++++++
 19 files changed, 485 insertions(+), 26 deletions(-)
 create mode 100644 tests/functional/hexagon/test_packets.py
 create mode 100644 tests/tcg/hexagon/packet_user.c

-- 
2.43.0


