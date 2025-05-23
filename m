Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1909EC54ED1
	for <qemu-devel@archiver.kernel.org>; Fri, 23 May 2025 16:03:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uIUqb-0001sg-W2; Fri, 23 May 2025 12:02:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liam.merwick@oracle.com>)
 id 1uIUqE-0001nz-Bj
 for qemu-devel@nongnu.org; Fri, 23 May 2025 12:01:50 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liam.merwick@oracle.com>)
 id 1uIUqB-0002gT-JN
 for qemu-devel@nongnu.org; Fri, 23 May 2025 12:01:49 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54NFxT4H011710;
 Fri, 23 May 2025 16:01:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
 content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=corp-2025-04-25; bh=/HSM8HF+XvdzD7AJ
 OUGZLdAp3QeqS8wTKQhywnwBqrU=; b=TjHYYmKPXQxfff6avkU4904RFrpK6MxZ
 78zUWbATL69DasbWSJ3BVrtJXfCF0q31N20tHWeo45l7H8DQoiiKGtR05VT310z2
 +xjiAhIqw0PLW4n7mVms9vfF/bPJDLfxFTzy/KYGEr8ZpsBzFNtjsTahdYzqKtfc
 xVpY1GLYAGF0eS2AB5Cm7deF4/ZXuOEqRgb2b+3nr5zR/hxTx9o1fT3lS1zBCEK7
 t7cTxg6R1JqqIYSd6g2JWwZVEF2jw6QqvtDjrkNalQ1WVxq7Eh+70EAR8DPA5wlK
 8NMhWQZ3GNBx0DWuM57161MJQ0a0JuAAFRCJY50nrmXDZOU+Zh5y9w==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46tv4q8079-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 23 May 2025 16:01:37 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 54NFvE9H001898; Fri, 23 May 2025 16:01:36 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 46rwev5r1b-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 23 May 2025 16:01:36 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 54NG1Zq7032523;
 Fri, 23 May 2025 16:01:35 GMT
Received: from lmerwick-vm-ol8.osdevelopmeniad.oraclevcn.com
 (lmerwick-vm-ol8.allregionaliads.osdevelopmeniad.oraclevcn.com
 [100.100.255.219])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id
 46rwev5qyx-1; Fri, 23 May 2025 16:01:35 +0000
From: Liam Merwick <liam.merwick@oracle.com>
To: dwmw@amazon.co.uk, anthony.perard@vates.tech, roger.pau@citrix.com,
 xen-devel@lists.xenproject.org, qemu-devel@nongnu.org,
 liam.merwick@oracle.com
Subject: [PATCH] hw/xen: Fix trace_xs_node_read() params
Date: Fri, 23 May 2025 16:01:34 +0000
Message-ID: <20250523160134.218997-1-liam.merwick@oracle.com>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-23_05,2025-05-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 mlxlogscore=963
 spamscore=0 bulkscore=0 adultscore=0 mlxscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2505230145
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIzMDE0NSBTYWx0ZWRfXzKhc12nOACPq
 ry0AdFC6085lYP89tiCbsgK59zp6dbmGaRNLjkmSFkTDJLkCByJwoyBoF7T3ms3Km+VGNsBnv0w
 bcZQCvQbXst7hNmq8vXblCJsOpzLCj8E4Z77T2KILxalaY2J528WJ8rXiSN3pqT55wXq4LLyvJa
 Lf7EOYZDKVWD0rIrrp1Nt/vkgpoIO6J5HBgV6LPif/qf5xReyirOybjbk1fJ2lg+Ut+5RN3TQbF
 4BPh0x/POI6wgvyXoI0XIFzRNl8qN9Okqk8okEBJrV8D0Y2rdnmgyKO3SuKzGTW2Fy1yr2XB9ot
 aeun3TTD6dparyeqlownuPfW9DdzbFufu4CF+EwADGThttaShBZbXZeVjBeK1rULfVdaTzsMKjm
 EF7FuUwlUsMQBvtmJMMSbTuJI4UizbVeXBDKJJEtpXb4csCcfm9MV08Kanh2eGa4ciqAhYdk
X-Authority-Analysis: v=2.4 cv=VoUjA/2n c=1 sm=1 tr=0 ts=68309be1 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=yPCof4ZbAAAA:8 a=bOG54WbAxldRIBuYn70A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: yj_f9Ug9G2CAGoj9LV9uUD-tIWKa7atM
X-Proofpoint-ORIG-GUID: yj_f9Ug9G2CAGoj9LV9uUD-tIWKa7atM
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=liam.merwick@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.498,
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

When the '--enable-trace-backends=syslog' build option is configured,
the following compilation error is encountered.

In file included from /usr/include/sys/syslog.h:207,
                 from /usr/include/syslog.h:1,
                 from ./trace/trace-hw_xen.h:224,
                 from ../hw/xen/trace.h:1,
                 from ../hw/xen/xen-bus-helper.c:13:
In function ‘syslog’,
    inlined from ‘_nocheck__trace_xs_node_read’ at ../hw/xen/trace-events:41:9,
    inlined from ‘trace_xs_node_read’ at trace/trace-hw_xen.h:903:9,
    inlined from ‘xs_node_read’ at ../hw/xen/xen-bus-helper.c:154:5:
/usr/include/bits/syslog.h:45:3: error: ‘%s’ directive argument is null [-Werror=format-overflow=]
   45 |   __syslog_chk (__pri, __USE_FORTIFY_LEVEL - 1, __fmt, __va_arg_pack ());
      |   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Add a check that 'value' is not null before passing it to trace_xs_node_read().

Fixes: e6cdeee95990 ("hw/xen: Add xs_node_read() helper function")
Signed-off-by: Liam Merwick <liam.merwick@oracle.com>
---
 hw/xen/xen-bus-helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/xen/xen-bus-helper.c b/hw/xen/xen-bus-helper.c
index 288fad422be3..1087a585cc71 100644
--- a/hw/xen/xen-bus-helper.c
+++ b/hw/xen/xen-bus-helper.c
@@ -151,7 +151,7 @@ char *xs_node_read(struct qemu_xs_handle *h, xs_transaction_t tid,
     va_end(ap);
 
     value = qemu_xen_xs_read(h, tid, path, len);
-    trace_xs_node_read(path, value);
+    trace_xs_node_read(path, value ? value : "<null>");
     if (!value) {
         error_setg_errno(errp, errno, "failed to read from '%s'", path);
     }
-- 
2.47.1


