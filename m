Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90BBAC61DB9
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 22:57:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wz04T-0006Xl-IA; Tue, 25 Aug 2026 18:56:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongli.zhang@oracle.com>)
 id 1wz04R-0006X2-UQ
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 18:56:43 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongli.zhang@oracle.com>)
 id 1wz04P-0004wB-4f
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 18:56:43 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67PFtwvc3909932; Tue, 25 Aug 2026 22:56:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=corp-2025-04-25; bh=144he
 AmGybhzbYjJ9e3+mUthBiOW81MxgO0hQrFffXA=; b=G6zG8KWx+U1wolT6kKe/D
 tEBgHadGrm95tS99kEFP5OXTS1huEuT+wgtPYCbt+FVlyASU6KGyS1GoFtpifvgx
 jQgdbYAI02pIdVPHrB5GY5O+rBkaxOBHCNkciSxadcw75PDkAYLCnqiELcAuZc8L
 rTPvkyZLoDNb7ifEhXAighkxOtnaHgrSuso1IgoBBJ5/5EUxNuCvRJubKuW7EL8W
 UoPoVZUiFn8jGC3aGB+F9VUPuDhktLgDpaT7eyTMvRpbSvqkC19jz9rVD1/e4PjP
 7R6TN5T/YQesba2MmpF3ihC1H34jL7st+75Hxobe1cxUeXgQHS+FAQrfsE0uLoI6
 g==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4g74as53tp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 25 Aug 2026 22:56:37 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7)
 with ESMTP id 67PMo7wJ016551; Tue, 25 Aug 2026 22:56:36 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 4g850vdmdx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 25 Aug 2026 22:56:36 +0000 (GMT)
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 67PMuY4H034200;
 Tue, 25 Aug 2026 22:56:36 GMT
Received: from localhost.localdomain (ca-dev80.us.oracle.com [10.211.9.80])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id
 4g850vdmdc-3; Tue, 25 Aug 2026 22:56:36 +0000 (GMT)
From: Dongli Zhang <dongli.zhang@oracle.com>
To: qemu-devel@nongnu.org
Cc: alex@shazbot.org, clg@redhat.com, peterx@redhat.com, farosas@suse.de,
 maciej.szmigiero@oracle.com, mark.kanda@oracle.com, bchaney@akamai.com,
 joe.jin@oracle.com
Subject: [PATCH 2/2] migration: Avoid inactive SaveVMHandlers in
 qemu_savevm_state_non_iterable()
Date: Tue, 25 Aug 2026 15:49:41 -0700
Message-ID: <20260825225054.807116-3-dongli.zhang@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20260825225054.807116-1-dongli.zhang@oracle.com>
References: <20260825225054.807116-1-dongli.zhang@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-25_06,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 mlxlogscore=999 malwarescore=0 mlxscore=0 adultscore=0 suspectscore=0
 spamscore=0 lowpriorityscore=0 bulkscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2606160000 definitions=main-2608250195
X-Authority-Analysis: v=2.4 cv=StygLvO0 c=1 sm=1 tr=0 ts=6a8e1da5 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=7Gl3-_t3PgB9XO-mQDs3:22 a=yPCof4ZbAAAA:8 a=yh4iPBlkOydvZEHkctMA:9
X-Proofpoint-ORIG-GUID: F9muvEx12CYSRGBoDAVdoD1nHkxOIdl3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI1MDE5NSBTYWx0ZWRfX7Xib0frnsTUA
 mBqqkouoZLbleQJS5fyVhtJ19GmdpYpJFb4h3KTz9nSAioGKly+3gFZ/9GWCeyfI6E8U/+fYAUY
 mGPuBnPY2PYier1ZNBZ2ZL9/WMupvJhDZ74DLoeF/7rLJttdgKoR+qFZRvPoTAko4TbO2l48T7x
 747MWFOnwe+Y7eIqneW6lYPR85lXy/EJ2LBXoLBFr9/fcUaEB6dhcUk1qLeKo9k/a/p1c4ToWdM
 DFOspcjgaMexVERBDWcpgzZZpTCrxIH5FYptawJHS+0njKY+GUKD7Wfyjj3pF5SdDqziw8OBDXe
 odZElNyh+QYWXl3orxcbs2umav5GS5yOShNGb+TMFSASRHLUYzw8/iUeZ9Kvhpl0NdPVbO5s4wp
 q0goAqC2G8Av5szfHVKQpD6ZVOLqBsJD6+8Bt5DbtbBuPEE1Ts9f5zKR5n5kF8R6i81R5sZNX49
 OkXr7hUP/Cfj/7xFIxg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI1MDE5NSBTYWx0ZWRfXzh5NrHZNGrz6
 Quc6r3MwWNyZ5w09nBoiRxHEIG/KJ4VN20Uh/n+YYkbLQYXW95nKH/YHUbvS4+UgxsVb5qYUvJo
 5Hbi6wQuRReL74RcsyYwWCkn1GkBjokjwUh3jml6PnUbx03o/7Bg
X-Proofpoint-GUID: F9muvEx12CYSRGBoDAVdoD1nHkxOIdl3
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

qemu_savevm_state_non_iterable() does not check qemu_savevm_state_active(),
so inactive SaveVMHandlers can still be saved through the non-iterable path.

With mlx5_vfio_pci, this means savevm_vfio_handlers may still call into
vfio_pci_save_config() during cpr-exec or cpr-transfer. The target QEMU
then tries to load that VFIO migration config state and may fail with a PCI
config error.

qemu-system-x86_64: get_pci_config_device: Bad config data: i=0x68 read: 0 device: 40 cmask: ff wmask: 0 w1cmask:0
qemu-system-x86_64: Failed to load element of type pci config for config
qemu-system-x86_64: 0000:91:00.1: Failed to load device config space

Call qemu_savevm_state_active() from qemu_savevm_state_non_iterable() so
inactive SaveVMHandlers, including savevm_vfio_handlers, are skipped.
Neither vfio_pci_save_config() nor vfio_pci_load_config() will be involved.

Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
---
 migration/savevm.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/migration/savevm.c b/migration/savevm.c
index 34dd06f9f7..463bffa15d 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -1107,7 +1107,7 @@ void qemu_savevm_state_end(QEMUFile *f)
 static inline bool qemu_savevm_state_active(SaveStateEntry *se)
 {
     /* When no is_active() hook, always treat it as ACTIVE */
-    if (!se->ops->is_active) {
+    if (!se->ops || !se->ops->is_active) {
         return true;
     }
 
@@ -1753,6 +1753,10 @@ bool qemu_savevm_state_non_iterable(QEMUFile *f, Error **errp)
             continue;
         }
 
+        if (!qemu_savevm_state_active(se)) {
+            continue;
+        }
+
         start_ts_each = qemu_clock_get_us(QEMU_CLOCK_REALTIME);
 
         if (vmstate_save(f, se, vmdesc, errp) < 0) {
-- 
2.43.5


