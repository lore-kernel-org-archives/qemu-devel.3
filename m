Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73757606A333
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2026 23:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Do+GgMry
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQYgd-0000ln-Kd; Mon, 09 Nov 2026 18:22:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mliebel@qualcomm.com>)
 id 1xQYgR-0000jn-Aq
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 18:21:53 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mliebel@qualcomm.com>)
 id 1xQYgL-0000NU-G1
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 18:21:48 -0500
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A9L9vhM1392252
 for <qemu-devel@nongnu.org>; Mon, 9 Nov 2026 23:21:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=p1NX9bFgvU0tvfGmVz+duQ
 Bhh5ZcFcZyt+bQOxpXAdc=; b=Do+GgMrytraw5s9V9SOihDtKNy9m0MwjO8ImcS
 etS24SyEuDXOet7RcCelpBieB3tPm+8jxq2iQ3xuREUpw8zH5ybrskA22e9dvwaY
 omesYyZ00Lj99sfwwrZgjOvDZ2raN5TIBA5zNAqNvk47987qeQh6q7Ahy6ZHiwUz
 iabfKZ5dGkRqpeNrpuMBRwlgwiPTeF/1VLBxMSNYGGOqcXJki1n/X6zA5cFOQTnU
 ZZiujCxT4EoNes9fIYe6wbJyHbIwQ653MUOOskEODsnN/fJSrJ3PVk4wZH3BLIaK
 SFEH0oDOUF0FLOPzohx1mt9p8Kz7o9zjySd6pX4d59wfRjrQ==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com
 [129.46.96.20])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hucr5tka1-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 09 Nov 2026 23:21:43 +0000 (GMT)
Received: from pps.filterd (nalasppmta04.qualcomm.com [127.0.0.1])
 by NALASPPMTA04.qualcomm.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A9NLh0M2606503; Mon, 9 Nov 2026 23:21:43 GMT
Received: from hu-devc-lv-u24-a.qualcomm.com (hu-mliebel-lv.qualcomm.com
 [10.81.81.31])
 by NALASPPMTA04.qualcomm.com (PPS) with ESMTPS id 6A9NLhEP2606487
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 09 Nov 2026 23:21:43 +0000 (GMT)
Received: by hu-devc-lv-u24-a.qualcomm.com (Postfix, from userid 4282937)
 id D45F225739; Mon,  9 Nov 2026 15:21:42 -0800 (PST)
From: Marco Liebel <marco.liebel@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 philmd@oss.qualcomm.com, Brian Cain <brian.cain@oss.qualcomm.com>,
 Marco Liebel <marco.liebel@oss.qualcomm.com>
Subject: [PATCH v2 0/3] target/hexagon: fix mttcg-related bugs
Date: Mon,  9 Nov 2026 15:21:39 -0800
Message-ID: <20261109232142.4081792-1-marco.liebel@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
Content-Type: text/plain; charset="utf-8"
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Reinject: loops=2 maxloops=12
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA5MDA5MyBTYWx0ZWRfXxxkkArQX6rb2
 shUVm8XcL8U/s1SRtsJ2XM62BhlFhPmEyvlm5wQe8aENUjy+WhfDaUi4F8IchMNdBoTD4jgzah+
 AuStVRU1VLuSYPLpRA2E/wSg6uZGDBw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA5MDA5MyBTYWx0ZWRfX2N8Tm5T/ioKx
 BjLmT0Hk3f0x6HbhatzDB6c/p+F93BCuqXm4H2b2d2DY29P9KnCMNNxGhwRjEL8hXnEVruwgr8Z
 LlNrnUOZsfPMUI4a+L+bqVyrGfobcsELsmtJ/paq3h0vTJ6wO2ouo5LhtpGP89ltxeZ0CT31Fi3
 p07IXiaX7gcU/2g944Z6+S1qfsVYIeqMsubbKZoJGxvLKvJO1lThXt+g38mTx8Ew1FFWYAA1wNv
 yz2jYr3OQYfeLcp0XE+lfZrUjwXMixQ7hPSE8RA0oNQ+89OiEcWVpJ/mb0/fCkHhZUweMVVLd/s
 ZgczJrUgX0vkgKrBXJ0Itwn8mORY1Zd9wVLG3oS7tFFKC+0VJQtcWBkKnM7G/ho8OtZI7Sh6GuH
 oz+3zTdMTZkMn1AuV+jEgcNSlUV6WILIyG2Hecuuw2f9UvXY6S0X2NJLW4w/OzuuWalZKaSzSZk
 kE+8+bM2E9tjtwpeuHw==
X-Authority-Analysis: v=2.4 cv=ErlHPicA c=1 sm=1 tr=0 ts=6af25587 cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=3BDY9-M16uuor2G4aLEA:9
 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10
X-Proofpoint-ORIG-GUID: -Wb0uKh_2TzM4lgQbfG91JXqKGStHYWH
X-Proofpoint-GUID: -Wb0uKh_2TzM4lgQbfG91JXqKGStHYWH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-09_07,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 malwarescore=0 spamscore=0 bulkscore=0
 priorityscore=1501 suspectscore=0 impostorscore=0 lowpriorityscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611090093
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

v2: Add missing signoffs

Marco Liebel (3):
  target/hexagon: preserve guest event fault and CFI state
  target/hexagon: serialize TLB invalidation and IMASK access
  target/hexagon: leave stack exchange to virtual SPSWAP

 hw/hexagon/hexagon_tlb.c   |  1 +
 target/hexagon/genptr.c    | 17 +++++++++--------
 target/hexagon/hexswi.c    | 12 +++++-------
 target/hexagon/op_helper.c |  4 ++++
 target/hexagon/translate.c | 16 ++++++++++++----
 5 files changed, 31 insertions(+), 19 deletions(-)

-- 
2.43.0


