Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C7D8606A32A
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Nov 2026 18:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=hilJLAgd
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xTO3A-0001J1-15; Tue, 17 Nov 2026 13:37:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mliebel@qualcomm.com>)
 id 1xTO2n-0001F1-Aa
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 13:36:37 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mliebel@qualcomm.com>)
 id 1xTO2j-0000oo-6y
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 13:36:37 -0500
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AHGJNvE3327638
 for <qemu-devel@nongnu.org>; Tue, 17 Nov 2026 18:36:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=7nGNNGXLVAj2i690v/0z6p
 32ipRBs+bk+9qFkNAeOJM=; b=hilJLAgdndfDZygiVxz5giDX04uAMezUfZrBNk
 l0laGM6JOc295rmkBMGMo9yEYfZPIpPvFKqck/AJjHhc/Ae1x2Jo+g/ZmTRCDic6
 9mOIEDiz6oAkvu+fW+w6hh2962n0nIaOafDpGnaTWNZYy0N3MON72DhVR2BKDCpt
 ejScbVfekttCRvjxIuzEPLaSLZjx2bOY/iA9G1cwzJVN6rtjDSsNa7hI4307c3U9
 NqqzdWSsbinvx3IhNB31OgvQGcRdO+IfmCKW2yjLD9nk0jmSngXuSPxrpXQY5UFK
 QIDn5M/pTljNZWM3Z2bN0mJvCEak+wQm3ni09VhPnE/UaobQ==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com
 [129.46.96.20])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j0tbarm8v-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 17 Nov 2026 18:36:31 +0000 (GMT)
Received: from pps.filterd (nalasppmta05.qualcomm.com [127.0.0.1])
 by NALASPPMTA05.qualcomm.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AHIaUBo3045963; Tue, 17 Nov 2026 18:36:30 GMT
Received: from hu-devc-lv-u24-a.qualcomm.com (hu-mliebel-lv.qualcomm.com
 [10.81.81.31])
 by NALASPPMTA05.qualcomm.com (PPS) with ESMTPS id 6AHIaT823045957
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 17 Nov 2026 18:36:29 +0000 (GMT)
Received: by hu-devc-lv-u24-a.qualcomm.com (Postfix, from userid 4282937)
 id 8C3D624E5C; Tue, 17 Nov 2026 10:36:29 -0800 (PST)
From: Marco Liebel <marco.liebel@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Brian Cain <brian.cain@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Marco Liebel <marco.liebel@oss.qualcomm.com>
Subject: [PATCH 00/14] target/hexagon: fix packet execution and fault handling
Date: Tue, 17 Nov 2026 10:36:15 -0800
Message-ID: <20261117183629.2002840-1-marco.liebel@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
Content-Type: text/plain; charset="utf-8"
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Reinject: loops=2 maxloops=12
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE3MDA3NCBTYWx0ZWRfX3vYaK200ez1A
 Rw51YCi5Iyy9olSessT/E+1Ya4RNsbczS1NBbDA8XD592gZnYWsMH9WmqLN5sj+PBWhJX1rNQZu
 ED60QY9y5KxJiL63hzeYopX5HguQZaZ7sVCyVLm1ctFSvPkB8OfGMCPItrA4L30fM9itZmT8S0D
 Mnz6abej4wfrMat+sDGTyQWgMddEyINBGP/rhzqRtNvsGwIj07A354OnuBfEJav+XBMc+jejqav
 CqthPSgPpynsEU4tyiH2jSHndj/OxmnCcnrcrgYUI0jkEyqSpUaTazSSGCm/4PBUdvJoXVAnwEg
 uHvO7fcTmrM4tyTRBxHHMUX8kqTFSyPlgV5lx562BdKnwceZrECILyQ4Grjv6ONzeTWGmku1YlN
 6Xbao+l+5XMlmOknxKQe0m91XbJj2Ci5OYd/uE99lyz9S+iXowMhMJ+rlcIiEk7owEKO4oulQu9
 1truhyO0oLsk2AAwNxQ==
X-Proofpoint-ORIG-GUID: ZTb1aXxxNRZV2N7fbMduYnsl07wskR-K
X-Authority-Analysis: v=2.4 cv=Vsy2kO2n c=1 sm=1 tr=0 ts=6afc9eaf cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=i-JMi1E5JZCW9h1dySoA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: ZTb1aXxxNRZV2N7fbMduYnsl07wskR-K
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE3MDA3NCBTYWx0ZWRfXxOVzMZzj9Ks/
 F1n1oedFAdnt7o8Vzhe635gstxCKEhChwxmtK3J4nwA89sto8YBay3skvwWLkVA4EQ32cYeCa/X
 QtJGMpIJV/IJ3SJSzsuwuWn1b8u8VvY=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-17_03,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 impostorscore=0 spamscore=0 clxscore=1015 adultscore=0
 malwarescore=0 bulkscore=0 suspectscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611170074
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=mliebel@qualcomm.com; helo=mx0b-0031df01.pphosted.com
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



Marco Liebel (14):
  target/hexagon: read the old predicate value through C4
  target/hexagon: allow writes to V85 USR coprocessor fields
  target/hexagon: suppress LR writes from a losing call
  target/hexagon: reject HMX operands outside VTCM
  target/hexagon: commit coprocessor results before context changes
  target/hexagon: distinguish packet-page instruction TLB misses
  target/hexagon: bound packet lookahead to the current page
  target/hexagon: report the faulting memory slot
  target/hexagon: retain both scalar packet fault addresses
  target/hexagon: preserve inactive BADVA registers
  target/hexagon: probe scalar packet memory in slot priority order
  target/hexagon: check packet alignment before TLB probes
  target/hexagon: validate both stores before packet commit
  target/hexagon: probe VMEMU upper transactions before lower ones

 target/hexagon/cpu.c                 |  39 +++++++--
 target/hexagon/cpu.h                 |  12 +++
 target/hexagon/gen_tcg_func_table.py |   6 ++
 target/hexagon/gen_tcg_funcs.py      |  41 +++++++++
 target/hexagon/genptr.c              |  30 ++++++-
 target/hexagon/genptr.h              |   3 +
 target/hexagon/helper.h              |   8 +-
 target/hexagon/hex_common.py         |  22 +++++
 target/hexagon/op_helper.c           | 119 +++++++++++++++++++++++++--
 target/hexagon/reg_fields_def.h.inc  |   2 +
 target/hexagon/translate.c           |  75 +++++++++++++++--
 target/hexagon/translate.h           |  12 ++-
 tests/tcg/hexagon/meson.build        |   2 +
 tests/tcg/hexagon/packet_user.c      |  82 ++++++++++++++++++
 14 files changed, 426 insertions(+), 27 deletions(-)
 create mode 100644 tests/tcg/hexagon/packet_user.c

-- 
2.43.0


