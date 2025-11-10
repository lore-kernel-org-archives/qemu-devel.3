Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0BD6CCF9E3
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Nov 2025 08:05:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vIMt2-0006iO-Iy; Mon, 10 Nov 2025 03:04:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1vIMt0-0006hv-Ai
 for qemu-devel@nongnu.org; Mon, 10 Nov 2025 03:04:26 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1vIMst-00061t-Fd
 for qemu-devel@nongnu.org; Mon, 10 Nov 2025 03:04:26 -0500
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5A9KlAGT029007
 for <qemu-devel@nongnu.org>; Mon, 10 Nov 2025 08:04:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
 content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=1obR5QbaUStggQY3KTMGN8eR44mpBuWEMWEYFC2rb
 zs=; b=sGb58W8Lh1i/m5cYkh4pmlZWlu5eYZ9uo8eyDVgi+rz3WMpckmhlZiYeH
 UydaZXwWaqn0CbGzgY3x0V2qppMGxzredkZbDxFJQmpDZoQ2o2JrCL6zANjHsTD0
 NZ34uaMmGaHd4at53Dt1tVgPySJQpDyEubW5t2hfZXn2TkfS72FqmP5w+V3VKcyk
 85NelvrtyatTIiRbjl6gYKhl2KmiLfM/Vd3gcUG730fHnQlG1SAmoZOrpg2ZVjJ2
 LvWGamxoJoQrDK1SquHGASHTZvTku5iTYX/wbc0Yzj/JH/cvdh0YYlWOizDScg1c
 JuAhNDYCxyvQHX1YmsPotobSTfwsA==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aa5chww9x-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 10 Nov 2025 08:04:17 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5AA50Rou014755
 for <qemu-devel@nongnu.org>; Mon, 10 Nov 2025 08:04:16 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4aahpjvg34-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 10 Nov 2025 08:04:15 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 5AA84EdC57278784
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <qemu-devel@nongnu.org>; Mon, 10 Nov 2025 08:04:14 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id EEB9F20040
 for <qemu-devel@nongnu.org>; Mon, 10 Nov 2025 08:04:13 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4EDDC20043
 for <qemu-devel@nongnu.org>; Mon, 10 Nov 2025 08:04:13 +0000 (GMT)
Received: from li-1901474c-32f3-11b2-a85c-fc5ff2c001f3.ibm.com.com (unknown
 [9.124.217.7]) by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP
 for <qemu-devel@nongnu.org>; Mon, 10 Nov 2025 08:04:13 +0000 (GMT)
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 0/2] PPC Patches for 10.2 Hard Freeze
Date: Mon, 10 Nov 2025 13:33:59 +0530
Message-ID: <20251110080401.3652497-1-harshpb@linux.ibm.com>
X-Mailer: git-send-email 2.43.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Ss+dKfO0 c=1 sm=1 tr=0 ts=69119c81 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=6UeiqGixMTsA:10 a=f7IdgyKtn90A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=p0WdMEafAAAA:8 a=Oa6x5gj9M5ENrRiD9vEA:9 a=poXaRoVlC6wW9_mwW8W4:22
 a=oH34dK2VZjykjzsv8OSz:22 a=Z5ABNNGmrOfJ6cZ5bIyy:22 a=QOGEsqRv6VhmHaoFNykA:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA4MDA5NSBTYWx0ZWRfXxF/KdYV55y6Q
 NX3iXCVUSnlJTghzXEyIJwaj13Qt5yLHBy3j2NmnXV9BELBp454XcIoCUWqUzQaqON8DpeWZNHG
 xutsiIuxSnK6oo+xFOd3pr6+5W356YPEz6F5q7MW7i5jzEm+ASga1aQjxTylDIDOhz1rUwQ+oMz
 f/LDaqBrlf7IJZxAKAY8tS8b+AMs9yHn0j3c+r2btUyitUphllozofTzmWPNmdIXtuEbiy3zng8
 tjynL+Sli2/gKXu5esMJCnNFIp8y0Zuq1g9Vt704kcTBxWxkKwfK0bMN/IE+wAFN8toQU1bIjqj
 ggabUVpjcK8qy1Y++vi4HXfHLa6qgspxtDd7FT46oYpAE9Fb5sAvHM5/L7p9Ds6u1TG5zO9Kqbv
 5Vc3IY2WaVZPyz8h5KiFbRc5MXCegQ==
X-Proofpoint-GUID: zZwbhniWvDxVq2nj3Hyne2Zat7Y7IVkn
X-Proofpoint-ORIG-GUID: zZwbhniWvDxVq2nj3Hyne2Zat7Y7IVkn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-10_03,2025-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 impostorscore=0 bulkscore=0 phishscore=0
 lowpriorityscore=0 adultscore=0 priorityscore=1501 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2511080095
Received-SPF: pass client-ip=148.163.156.1; envelope-from=harshpb@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

The following changes since commit 917ac07f9aef579b9538a81d45f45850aba42906:

  Merge tag 'for-upstream' of https://gitlab.com/bonzini/qemu into staging (2025-11-05 16:07:18 +0100)

are available in the Git repository at:

  https://gitlab.com/harshpb/qemu.git tags/pull-ppc-for-10.2-d5-20251110

for you to fetch changes up to 3149969a9f4d74ea8e568c91efbe4b2c4d336ba8:

  pc-bios/dtb/pegasos*.dtb: Fix compiled dtb blobs (2025-11-09 16:56:21 +0530)

----------------------------------------------------------------
PPC Patches for 10.2 Hard Freeze

* Pegasos fixes for mem leak and dtb blob updates

----------------------------------------------------------------
BALATON Zoltan (2):
      hw/ppc/pegasos: Fix memory leak
      pc-bios/dtb/pegasos*.dtb: Fix compiled dtb blobs

 hw/ppc/pegasos.c         |   3 ++-
 pc-bios/dtb/pegasos1.dtb | Bin 857 -> 1975 bytes
 pc-bios/dtb/pegasos2.dtb | Bin 1701 -> 2963 bytes
 3 files changed, 2 insertions(+), 1 deletion(-)

