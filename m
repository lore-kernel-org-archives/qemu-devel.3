Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F5ABC83F17
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Jul 2025 22:22:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubRZH-0008Mm-BL; Mon, 14 Jul 2025 18:22:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1ubPv5-00073g-7G
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 16:37:06 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1ubPv1-00067s-Lg
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 16:37:02 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56EH5kTV018801;
 Mon, 14 Jul 2025 20:36:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :date:from:message-id:subject:to; s=corp-2025-04-25; bh=yoaT1mY0
 U2E78k0PVUNavML1bjRthVgYfUmqvQL97UA=; b=K80MGEBeiLEb8EqhatI4M2VI
 b6caNDwOsHDS7UKYjTZiHzjzx9c2vKt+oraCYRaff+8DOuhw8UF0CtZYCPw6qpEE
 OTzbBkzGO9l5t0hnfpPDzMus4em7dUpsIN9whqQvesMuZ6SpLPg98xacX3jFj5C8
 ol6PNGvxZxmE2jfeCUL01JvKN7oCHQkg+nvgpihGYXlZtS8Lts0HLLu7eYg9eNBV
 TfSZBmfrJGyiHcP69db+TS3gTn5y0EuRCLt+U6bbnVyvduffZmk/yO2NrRU9/MSX
 ZQ4H83kNML8+iDtPw9Qc+pg7mnT6lZo3qBr84gpi5J1baIcx5GsXt/KERO+c+w==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47ufnqnx9e-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 14 Jul 2025 20:36:57 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 56EK1b4p028917; Mon, 14 Jul 2025 20:36:56 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 47ue58t94u-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 14 Jul 2025 20:36:56 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 56EKat3K001985;
 Mon, 14 Jul 2025 20:36:55 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with
 ESMTP id 47ue58t94g-1; Mon, 14 Jul 2025 20:36:55 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: qemu-devel@nongnu.org
Cc: Jason Wang <jasowang@redhat.com>, Steve Sistare <steven.sistare@oracle.com>
Subject: [PATCH] tap: fix net_init_tap() return code
Date: Mon, 14 Jul 2025 13:36:54 -0700
Message-Id: <1752525414-223746-1-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-14_02,2025-07-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 mlxscore=0 spamscore=0
 suspectscore=0 adultscore=0 mlxlogscore=999 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507140137
X-Proofpoint-GUID: pgbyNy3O8bpG0zO-1C62APC9tOMAbZDc
X-Proofpoint-ORIG-GUID: pgbyNy3O8bpG0zO-1C62APC9tOMAbZDc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE0MDEzOCBTYWx0ZWRfX572y1E1roHBz
 7/F460M/OpHhNlA7hcLr1gSacQP7Kd9LTgcQITJ8zSR2foUGIyd9BRz6irdGh1z0BzlxbOygw34
 P5KSz0acfwkzfbzgaCDD/SqT9fXeVWmiY1duf8CV0keLAnT8zlUzZhWCk123vcT5Aj24PrTgJBI
 FESjPK49dp7F4vwf6o39YSBvOPni3bLyjDKFLDCdq63h42b7AmwWzbJqWZRX9kJVjW+VJlXqZSZ
 TVGbGsIeKUcN5B3oQ7CMvw9dKgHhFofMZ59qeonjhCNN8/CobzXjHvp/pJehKTCSHib3p5sbRlP
 TPHWqlReDrHvMhgSgXtor6TbLCXOkaIynH6AxugGpUCgTX0A6Xghw3BaYMwK7LSS3u6nSTQ1cil
 +CNk2snGr0X2fd01wHK4QD7mgbz3vYmp/1n34IhTNiz+FJW8ZCTA1q9fdoMdYmAqVTaBnNq2
X-Authority-Analysis: v=2.4 cv=U9ySDfru c=1 sm=1 tr=0 ts=68756a69 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=Wb1JkmetP80A:10 a=yPCof4ZbAAAA:8 a=SxLwNlJIcWoldp4Uc8YA:9
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

net_init_tap intends to return 0 for success and -1 on error.  However,
when net_init_tap() succeeds for a multi-queue device, it returns 1,
because of this code where ret becomes 1 when g_unix_set_fd_nonblocking
succeeds:

        ret = g_unix_set_fd_nonblocking(fd, true, NULL);
        if (!ret) {
            ... error ...
    free_fail:
        ...
        return ret;

Luckily, the only current call site checks for negative, rather than non-zero:

  net_client_init1()
      if (net_client_init_fun[](...) < 0)

Also, in the unlikely case that g_unix_set_fd_nonblocking fails and returns
false, ret=0 is returned, and net_client_init1 will use a broken interface.

Fix it to be future proof.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
---
 net/tap.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/tap.c b/net/tap.c
index ae1c7e3..35552c4 100644
--- a/net/tap.c
+++ b/net/tap.c
@@ -854,8 +854,8 @@ int net_init_tap(const Netdev *netdev, const char *name,
                 goto free_fail;
             }
 
-            ret = g_unix_set_fd_nonblocking(fd, true, NULL);
-            if (!ret) {
+            if (!g_unix_set_fd_nonblocking(fd, true, NULL)) {
+                ret = -1;
                 error_setg_errno(errp, errno, "%s: Can't use file descriptor %d",
                                  name, fd);
                 goto free_fail;
-- 
1.8.3.1


