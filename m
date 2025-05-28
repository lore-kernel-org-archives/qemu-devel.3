Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DAA1C3ABB2
	for <qemu-devel@archiver.kernel.org>; Wed, 28 May 2025 16:42:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKJrN-0007iW-Ty; Wed, 28 May 2025 12:42:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <annie.li@oracle.com>)
 id 1uKJrF-0007Qc-Cs
 for qemu-devel@nongnu.org; Wed, 28 May 2025 12:42:27 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <annie.li@oracle.com>)
 id 1uKJrD-0007h1-1M
 for qemu-devel@nongnu.org; Wed, 28 May 2025 12:42:24 -0400
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54SCqUtv023680;
 Wed, 28 May 2025 16:42:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=corp-2025-04-25; bh=+86Cu
 2iNauSJs7gn8B5x/L6ys9lFgpu3Hl+AJoM9CBo=; b=rfW56YZv2Uw4g4sovgSxn
 h3e9Ubykvf5Q5MBU+F19ia8IuDMQGyJHH+06++k9gqia7FTKDjJPCmROCad3WtfE
 iqjKuaRDOnrDiZSpBQKasnN3QNBGHNxwyO/dNX+mfuJ85cksSgPUJP7SDwXFdXAn
 4fy3lho4FyNUvxONehAG00frHrDu+Zdmss1I+FTxwAQPSZvP10BuJmIoYso9Fxtd
 wk1JNOVFQPwnQDpXFBipIKDWdk+bg5/JC+UX2w1HwT3oWt2vkZWcXNyyar1Kibqd
 d9YqIi3yhOqy1snh7tX3AquUU1yUj+95GTqHbNdLWwWmARzfptj74qk16Lu0GB/r
 Q==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46v33mxegc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 28 May 2025 16:42:14 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 54SF4YWT027817; Wed, 28 May 2025 16:42:14 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 46u4janrdh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 28 May 2025 16:42:14 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 54SGaYQW006110;
 Wed, 28 May 2025 16:42:13 GMT
Received: from localhost.localdomain (dhcp-10-43-12-51.usdhcp.oraclecorp.com
 [10.43.12.51])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id
 46u4janrbt-1; Wed, 28 May 2025 16:42:13 +0000
From: Annie Li <annie.li@oracle.com>
To: qemu-devel@nongnu.org
Cc: dave@treblig.org, mst@redhat.com, imammedo@redhat.com, anisinha@redhat.com,
 eduardo@habkost.net, marcel.apfelbaum@gmail.com, philmd@linaro.org,
 wangyanan55@huawei.com, zhao1.liu@intel.com, pbonzini@redhat.com,
 richard.henderson@linaro.org, slp@redhat.com, eblake@redhat.com,
 armbru@redhat.com, annie.li@oracle.com, miguel.luis@oracle.com
Subject: [PATCH 12/13] microvm: enable suspend
Date: Wed, 28 May 2025 12:42:03 -0400
Message-ID: <20250528164203.2239-1-annie.li@oracle.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20250528163545.2143-1-annie.li@oracle.com>
References: <20250528163545.2143-1-annie.li@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-28_08,2025-05-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 phishscore=0 suspectscore=0
 adultscore=0 malwarescore=0 bulkscore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2505280145
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI4MDE0NSBTYWx0ZWRfX9HyLwFFMZh1T
 5G/VZ7MHgZkrMcjHznpCcC63ktVieJgaesX2y/okckySUL1bR8047J6S7HL+8H+Ug7Dn5VLGUXC
 qRUMetEW5s/hMw5xBpaH3FO9eolFruaeAWXPPKar9POAKDdD9bMiwioLh8qxFI5cfRsAcNOLMpp
 o3/Sg+1AAPuvj1XWAChjuif2ULE0Vc8fSG/tTRGSQpR/apsuBqweyhwVzf+d5/tk6qnEGjO3qai
 kBPt34O7qSCOtNURy3jKOdKUWoHS1M/0LBT8lIwivlLluEGA5YcdANmlKGCZKbKF7zCIBqQY41O
 92CcI1aNc1qlQUilvdLj27fo91zctW06lbZrS00iFc0naZhUM7vyO9xl8z8GvSz69tQXfnKYOxb
 QrceCJ6FhCrtvvQtR5D4WzZWqh3jPNVrpFHCquHmcC83GtJpS0+M1mSh03sT+a8h5xNr14QX
X-Proofpoint-GUID: rZg2sqQpis8iP1h3UiDf1MJeox3Vi5Fd
X-Authority-Analysis: v=2.4 cv=aO/wqa9m c=1 sm=1 tr=0 ts=68373ce7 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=dt9VzEwgFbYA:10 a=yPCof4ZbAAAA:8 a=rBXmK-BvRmpQW049j8cA:9
X-Proofpoint-ORIG-GUID: rZg2sqQpis8iP1h3UiDf1MJeox3Vi5Fd
Received-SPF: pass client-ip=205.220.165.32; envelope-from=annie.li@oracle.com;
 helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.498,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

The function qemu_wakeup_suspend_enabled combines the suspend
and wakeup together. However, the microvm doesn't support
wakeup yet. Suspend is enabled here, but wakeup doesn't
actually work for microvm now.

Signed-off-by: Annie Li <annie.li@oracle.com>
---
 hw/i386/microvm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/i386/microvm.c b/hw/i386/microvm.c
index eba33c4365..da5d4126e5 100644
--- a/hw/i386/microvm.c
+++ b/hw/i386/microvm.c
@@ -489,6 +489,7 @@ static void microvm_machine_state_init(MachineState *machine)
     qemu_add_machine_init_done_notifier(&mms->machine_done);
     mms->powerdown_req.notify = microvm_powerdown_req;
     qemu_register_powerdown_notifier(&mms->powerdown_req);
+    qemu_register_wakeup_support();
 
     microvm_memory_init(mms);
 
-- 
2.43.5


