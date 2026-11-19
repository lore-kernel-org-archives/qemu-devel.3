Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF1D2606A326
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Nov 2026 22:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=hfBsLTnN
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xUA9l-0003AP-St; Thu, 19 Nov 2026 16:59:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mliebel@qualcomm.com>)
 id 1xUA9k-00039d-IS
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 16:59:00 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mliebel@qualcomm.com>)
 id 1xUA9g-0006Zp-SS
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 16:59:00 -0500
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AJJ1N3j2620075
 for <qemu-devel@nongnu.org>; Thu, 19 Nov 2026 21:58:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=xOS0iou/ikRhZ3BTr21qS4
 SsKw/uMDPmjOdVVinOJIg=; b=hfBsLTnN7ETPVANyl4X/UbZ+S2nFuY9jHIRCKe
 TLIiOxkbY4UPzVl80x/S81iQF/kALmS8jyO/Mi54dehDX9BXa1EdhOfuQRShK17C
 QAvaqZCIfUExHi9naB1mHzp3iwCniM/7cf+/nQraZkLUHQQS3qXdoRktPJaNOgCl
 lkpqTlq0QMb923ylaIWrkIp0flDrLRqnS/AW+wcerXZOSScZukE6fL6mcAyxlTt6
 j28MM1MNr9Z5UF4KtYJ/EsGNUUKpeYkK6z2p291gK1XItKx1v4FPN8s/EBIknkLa
 qYmsoTO/lh8jlKAfPQJAOxhX6+ZMrr8Rzwp7o/4vAd8EDzgg==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com
 [129.46.96.20])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j1yghk5qm-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 19 Nov 2026 21:58:54 +0000 (GMT)
Received: from pps.filterd (nalasppmta05.qualcomm.com [127.0.0.1])
 by NALASPPMTA05.qualcomm.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AJLwrod3690561; Thu, 19 Nov 2026 21:58:53 GMT
Received: from hu-devc-lv-u24-a.qualcomm.com (hu-mliebel-lv.qualcomm.com
 [10.81.81.31])
 by NALASPPMTA05.qualcomm.com (PPS) with ESMTPS id 6AJLwrfs3690555
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 19 Nov 2026 21:58:53 +0000 (GMT)
Received: by hu-devc-lv-u24-a.qualcomm.com (Postfix, from userid 4282937)
 id 36FCB24D13; Thu, 19 Nov 2026 13:58:53 -0800 (PST)
From: Marco Liebel <marco.liebel@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Brian Cain <brian.cain@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Marco Liebel <marco.liebel@oss.qualcomm.com>
Subject: [PATCH v3 00/15] target/hexagon: fix packet execution and fault
 handling
Date: Thu, 19 Nov 2026 13:58:38 -0800
Message-ID: <20261119215853.987158-1-marco.liebel@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
Content-Type: text/plain; charset="utf-8"
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Reinject: loops=2 maxloops=12
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE5MDA4OCBTYWx0ZWRfX9BDPGE8bpl4O
 df2Bye7WoAsafQkrp8xRCikcMrHa0c26HjkCF0UYoXhs3lg8VsgdcRAMp462uDWDN+DnvwcHaCx
 PTi31b2hHm35ZM1dFyiiFnwGD5bHC3mhM0HRqaobzpEVxXCvCY//uqF8GdJli58YS71a3GvVc3n
 Jzot2O0Saa93rofx3b9A9A48Wfg4wgzkbARLWur4Vqi4PeRmjb+5SCR7OPKbH+C/QIQ+TyrlrLR
 ZYYySpt2vt7PL7E0RVEixdjn+Ih/hxQ95MS+XPeLomIe3FDwqrxOxuGX8IsifpnD3DtmgX4uYhD
 V6Q2wk5ZJkIr2S3F75g1viTClNy8wIVdQnKrSN36gYO2s6jxHPcRbQvhzSZjVhFHEbYP/r7flYh
 Lw0w6PYAKs5phrk4R7+YK1fspcMV1PfwbbS/PYHe2RhDHRpNumNxDU5fbP4bblEWtDIrRVw201E
 5/gG6zY84/IlaoyVnPA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE5MDA4OCBTYWx0ZWRfXxLr1YHicPyH1
 heaMoQA3osCXF6HmwyPmdLQqXbB/YkS8jmLEVHMvdjZqELZyJUmqdc13wLldl4C+iVm13e5KkkY
 jmQx0qZwC213jXoeN1w45i8EXVYrfD4=
X-Authority-Analysis: v=2.4 cv=Vvi2kO2n c=1 sm=1 tr=0 ts=6aff711e cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=1aH7GHi1rtwsvNJ81EwA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: n5TnuzNkvLvKd6yGTVgeByHT0dUqN5oN
X-Proofpoint-ORIG-GUID: n5TnuzNkvLvKd6yGTVgeByHT0dUqN5oN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-19_05,2026-11-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 malwarescore=0 phishscore=0 spamscore=0
 bulkscore=0 adultscore=0 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611190088
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

Changes in v3:
* Restore patches 1 and 7 from v1.
* Add review tags from v1.

Changes in v2:
* Rework memory checks to use TCG instead of added runtime helpers
  (patches 4, 9, 11-14, using the restored numbering).
* Add a functional packet regression-test commit (patch 15).

Marco Liebel (15):
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
  target/hexagon: prioritize packet alignment in the fault path
  target/hexagon: validate both stores before packet commit
  target/hexagon: probe VMEMU upper transactions before lower ones
  tests/functional/hexagon: add packet regression tests

 hw/hexagon/hex-subsys.c                  |  4 ++
 include/hw/hexagon/hexagon.h             |  2 +
 target/hexagon/cpu.c                     | 76 ++++++++++++++++++--
 target/hexagon/cpu.h                     | 12 ++++
 target/hexagon/gen_tcg_func_table.py     |  6 ++
 target/hexagon/gen_tcg_funcs.py          | 38 ++++++++++
 target/hexagon/genptr.c                  | 55 ++++++++++++++-
 target/hexagon/genptr.h                  |  4 ++
 target/hexagon/helper.h                  |  5 +-
 target/hexagon/hex_common.py             | 22 ++++++
 target/hexagon/internal.h                |  5 ++
 target/hexagon/op_helper.c               | 72 +++++++++++++++++--
 target/hexagon/reg_fields_def.h.inc      |  2 +
 target/hexagon/translate.c               | 90 +++++++++++++++++++++---
 target/hexagon/translate.h               | 17 ++++-
 tests/functional/hexagon/meson.build     |  2 +
 tests/functional/hexagon/test_packets.py | 47 +++++++++++++
 tests/tcg/hexagon/meson.build            |  2 +
 tests/tcg/hexagon/packet_user.c          | 82 +++++++++++++++++++++
 19 files changed, 516 insertions(+), 27 deletions(-)
 create mode 100644 tests/functional/hexagon/test_packets.py
 create mode 100644 tests/tcg/hexagon/packet_user.c

-- 
2.43.0


