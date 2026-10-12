Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64E2BCA9ED2
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2026 00:00:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGPuA-0005iz-5G; Mon, 12 Oct 2026 19:58:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongli.zhang@oracle.com>)
 id 1xGPu4-0005gq-RX
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 19:58:00 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongli.zhang@oracle.com>)
 id 1xGPu2-0006HM-Uz
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 19:58:00 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69CMg8qM2685330; Mon, 12 Oct 2026 23:57:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=corp-2025-04-25; bh=GyJN2
 +ifLHYy8//Fw4Lwqf8Z8LeIUb9LbzqArGFsDKM=; b=Cz2h3wbL/jP+2dT7Q/n4T
 0X3gjEvCcovt6pHB4aMAJ1pjnQRkUQ27ACuUTxcwq0YYIA2+vzXQMleC7BUaOiG4
 VlqyJz7YvyX9h2bEutCIOSIu6rNrYvJtgb4e39jflE2XWSAu2+BTnz1q7GWX7LYG
 paIqLe9VJ1I7z4kOxlz02xLc+TsLPbjwvzD8UuKgXQACfrJ3a0RqVjjPsmACfspp
 0e35O5+y4uEbmTL53WVR2EnYpWVDLCQ4mFRSnVoksSN9qFvZ4t/TvMGpNHNRhy1E
 FY7siIztxvrp3sSsQYp1woUnpkIBVWrvGqUPYhGHYssfTy10jxeniYp+pmH3IB5m
 Q==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4h7dwtb597-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 12 Oct 2026 23:57:54 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7)
 with ESMTP id 69CNpevP015071; Mon, 12 Oct 2026 23:57:53 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 4h7btnuhvn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 12 Oct 2026 23:57:53 +0000 (GMT)
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 69CNvfHh025328;
 Mon, 12 Oct 2026 23:57:52 GMT
Received: from donglzha-e6-vfio-setup.osdevelopmeniad.oraclevcn.com
 (donglzha-e6-vfio-setup.allregionaliads.osdevelopmeniad.oraclevcn.com
 [100.100.255.69])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id
 4h7btnuhra-19; Mon, 12 Oct 2026 23:57:52 +0000 (GMT)
From: Dongli Zhang <dongli.zhang@oracle.com>
To: qemu-devel@nongnu.org
Cc: david@kernel.org, imammedo@redhat.com, maciej.szmigiero@oracle.com,
 peterx@redhat.com, farosas@suse.de, mark.kanda@oracle.com,
 bchaney@akamai.com, pierrick.bouvier@oss.qualcomm.com,
 alex@shazbot.org, clg@redhat.com, yi.l.liu@intel.com,
 eric.auger@redhat.com, zhenzhong.duan@intel.com, mst@redhat.com,
 cohuck@redhat.com, pbonzini@redhat.com, armbru@redhat.com,
 eblake@redhat.com
Subject: [PATCH 18/21] system/physmem: add cpr-luo blocker
Date: Mon, 12 Oct 2026 23:56:14 +0000
Message-ID: <20261012235727.398133-19-dongli.zhang@oracle.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20261012235727.398133-1-dongli.zhang@oracle.com>
References: <20261012235727.398133-1-dongli.zhang@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-12_06,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 spamscore=0 adultscore=0 bulkscore=0 malwarescore=0 mlxscore=0
 lowpriorityscore=0 suspectscore=0 mlxlogscore=999 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2610020000 definitions=main-2610120095
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEyMDA5NSBTYWx0ZWRfX2cjhJ4EdGzjR
 3xQTPzHDI4vKraqIHnIuglF3eD2giZ5IuWKxdaIwrRZVNnOz91bMhcD5yVjWQkJ9dcbkE3qei5e
 DEjevyJdcgVsI466tIHuA5wCuf7XtspU8Wq6LcDE/0fVFB3gYMD2wEjPCo2zrusWhZzFpVsxNeH
 V+MWJtptmzYdRb5+YfdS5bQ2uhtA7PzvgdQ44EWsxcNpLCcRsxug2b0ap9IWN699c00t5TPIcKz
 96zIjNsj1hZ8JPfhH8UCSa730uQhfP+ZjIWQj5F24wRxrM6POhy8l8JhcHB8yvzRilJ6cEbP2WJ
 LW1HmOlaloPTPbyACdYO+P78KoXms7WM7Ka7Ge5FWMjbQKOHMe02yt+Zjh+qZ+oBE4vNQHkBZzl
 fSo6HNJDnfTEx4YzDFpivbBa1WrN9R8iKmQh8qV5JuW/Q68v6wWVOBLwMmsKjzR14aNqpkVsrsc
 dbmwHgcpC1ZZcr4AFA6qc3KGxTAX65T7jsXzOA4w=
X-Authority-Analysis: v=2.4 cv=Kp7YSmWN c=1 sm=1 tr=0 ts=6acd7402 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117
 a=zPCbziy225d3KhSqZt3L1A==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=7Gl3-_t3PgB9XO-mQDs3:22 a=yPCof4ZbAAAA:8 a=6nePy_Ue8WTw2CsEWrAA:9
 a=5yU3S35YU4bGjq-dph-N:22 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf awl=host:12107
X-Proofpoint-ORIG-GUID: KEKd4TCPRS72HUrL-kqP6KlG0Jnmbqo1
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEyMDA5NSBTYWx0ZWRfX+S1BdOOEv3XF
 xAqAPQlZ/9A467K4Viz+OoXF4ceNalaO3sck1KLTP3o/b8MJtWPMstib8lSCOhrDiZkRXY5903y
 ZsdnQWBYU7V/eKTSXmoi792FUIGpJSiDcg6ievxAos8RF2k2tN9n
X-Proofpoint-GUID: KEKd4TCPRS72HUrL-kqP6KlG0Jnmbqo1
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=dongli.zhang@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Add a cpr-luo migration blocker for anonymous memory. cpr-luo requires
shared memory, and therefore cannot use memory-backend-ram,
memory-backend-memfd, or memory-backend-shm when "share=on" or
"aux-ram-share=on" is unavailable.

Here is an example if I use regular "-m 8G".

(qemu) migrate_set_parameter mode cpr-luo
(qemu) migrate file:cpr-luo.state
Error: Memory region pc.ram is not compatible with CPR. share=on is
  required for memory-backend objects, and aux-ram-share=on is required.

Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
---
MIG_MODE_CPR_EXEC is missing from some existing blockers found with cscope
"cs find s MIG_MODE_CPR_TRANSFER". I may fix them and send the changes as
an independent patchset.

 system/physmem.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/system/physmem.c b/system/physmem.c
index 263acb5727..fcf40ca3f8 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -2246,7 +2246,8 @@ static void ram_block_add(RAMBlock *new_block, Error **errp)
                        "which is not supported with CPR.",
                        memory_region_name(new_block->mr));
             migrate_add_blocker_modes(&new_block->cpr_blocker,
-                                      BIT(MIG_MODE_CPR_TRANSFER), errp);
+                    BIT(MIG_MODE_CPR_TRANSFER) | BIT(MIG_MODE_CPR_LUO),
+                    errp);
         }
     }
 
@@ -4539,8 +4540,9 @@ void ram_block_add_cpr_blocker(RAMBlock *rb, Error **errp)
                "Memory region %s is not compatible with CPR. share=on is "
                "required for memory-backend objects, and aux-ram-share=on is "
                "required.", memory_region_name(rb->mr));
-    migrate_add_blocker_modes(&rb->cpr_blocker, BIT(MIG_MODE_CPR_TRANSFER),
-                              errp);
+    migrate_add_blocker_modes(&rb->cpr_blocker,
+            BIT(MIG_MODE_CPR_TRANSFER) | BIT(MIG_MODE_CPR_LUO),
+            errp);
 }
 
 void ram_block_del_cpr_blocker(RAMBlock *rb)
-- 
2.43.5


