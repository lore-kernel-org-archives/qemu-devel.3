Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F785C3ABAC
	for <qemu-devel@archiver.kernel.org>; Fri,  2 May 2025 14:23:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uArI5-00039N-Vy; Fri, 02 May 2025 10:23:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uArHu-00037t-He
 for qemu-devel@nongnu.org; Fri, 02 May 2025 10:22:51 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uArHr-0008Pm-G1
 for qemu-devel@nongnu.org; Fri, 02 May 2025 10:22:50 -0400
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5425Wm5U016341;
 Fri, 2 May 2025 14:22:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :date:from:message-id:subject:to; s=corp-2025-04-25; bh=HTKPUHWX
 MqgJHXl/Apy2CFC6Lss1TEGytBqwZzeA9ro=; b=mTgLdEbHsZR37VcMtUKrMv0m
 g/JH+/TQousYlO0qhPi0yPR55JuDmi2S6IkTgPuCI2mpFtGJ+PPeCX7jPy2F+9xn
 VAw4LdEc3gLBqJqxl89Pi8OQpHbDi7EUCj36TeTIkVWRWJT/8zKYDpUbLWMVw5gh
 7UwR1c/1zIzpz1ifZeN+we1NrM8oiXk1VzaRT/raVpJACrMKAQFBv54eE6eqjtuz
 rOSuMMQp98ZCuBcIUV47T9KBB/586ROTJc68uS/UI3KLDj8JB3ph2rd0Rz1qP/fJ
 PJO0KNBra9Xfudb+CJTzVgrLUaPfmW1vL68KM5CpwwBR5ppQ8sFuT2NTXz06iA==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46b6usnbt4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 02 May 2025 14:22:43 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 542EFO1G023814; Fri, 2 May 2025 14:22:41 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 468nxm33p0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 02 May 2025 14:22:41 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 542EIQwm039705;
 Fri, 2 May 2025 14:22:41 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with
 ESMTP id 468nxm33ng-1; Fri, 02 May 2025 14:22:41 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>
Subject: [PATCH V3 0/3] vfio cleanup, pre-cpr
Date: Fri,  2 May 2025 07:22:37 -0700
Message-Id: <1746195760-101443-1-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-02_02,2025-04-30_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=934
 phishscore=0
 suspectscore=0 spamscore=0 adultscore=0 mlxscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2504070000 definitions=main-2505020114
X-Proofpoint-ORIG-GUID: IfepXbeE2U1xVVy3pkQ4VeM0LnLD4SYu
X-Proofpoint-GUID: IfepXbeE2U1xVVy3pkQ4VeM0LnLD4SYu
X-Authority-Analysis: v=2.4 cv=Hd0UTjE8 c=1 sm=1 tr=0 ts=6814d533 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=dt9VzEwgFbYA:10 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=YMEQD7L_wW1zi78ti6QA:9
 cc=ntf awl=host:13130
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTAyMDExNCBTYWx0ZWRfX9APEnfDrA07C
 /JhAMLVEYc6bpSR+MjT6+DWf6rdhaJO/d5RI2oIBgNjb0Us9wjO0eizXGPTbZO1G+T0igsXnxSZ
 /kxIvznJikrh9SyyMvwTWYYeZCm3LqhacfctuAsZurhifmbcZkZM61LjkqA/Gs9h9K3dyG5RIt7
 qa9zl+Sx30CSW5/R/L2Al9vRen8Sor6EqlI3LTG42HyXPXMqVM+/nyYPO2X0AjLiq1ClRjM+7l/
 v6RkY+30U6q2ZmDFiGnwARkBmuPdSD3LVxGgANa6Xpr8ZUmiU6mh0JbtBLRlhJeSnJtn2B5nEvQ
 U7tLJsMuNhYcC18V6cSnUvqzgNgBDQy1b3Tawt26lVg7S16VHud6E1IU6DS3yk5Un1d5k66eLBC
 DtKn7IgdGxtwY904O1p+ysdAWFKZ1BJfu7w572221LVg7NVBguZot8aEAfixsGkEJaeUNgAl
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Cleanup a few vfio functions prior to the introduction of CPR.

These were extracted from 
  https://lore.kernel.org/qemu-devel/1739542467-226739-1-git-send-email-steven.sistare@oracle.com/

Changes in V3:
  * update to master

Steve Sistare (3):
  vfio/container: ram discard disable helper
  vfio/container: reform vfio_container_connect cleanup
  vfio/container: vfio_container_group_add

 hw/vfio/container.c | 131 +++++++++++++++++++++++++++++-----------------------
 1 file changed, 73 insertions(+), 58 deletions(-)

base-commit: 73d29ea2417b58ca55fba1aa468ba38e3607b583

-- 
1.8.3.1


