Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F5B2C369A2
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Apr 2025 20:45:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u3LFZ-00030u-Oc; Fri, 11 Apr 2025 16:45:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <annie.li@oracle.com>)
 id 1u3LFZ-00030k-1H
 for qemu-devel@nongnu.org; Fri, 11 Apr 2025 16:45:21 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <annie.li@oracle.com>)
 id 1u3LFX-0001gr-Ig
 for qemu-devel@nongnu.org; Fri, 11 Apr 2025 16:45:20 -0400
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53BJuwnv017290;
 Fri, 11 Apr 2025 20:45:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:reply-to:subject:to; s=corp-2023-11-20;
 bh=+86Cu2iNauSJs7gn8B5x/L6ys9lFgpu3Hl+AJoM9CBo=; b=c8nQiObEO06n
 y3WVk7tzd4+RTTySehtBSj5LiN7X126x/HwxUR7w7yQS5gkjtilJWHb9VSMGzCyf
 Y3WGsvsSG1o/MTSIZW4Nu0ff6Hf9hcxDu2lQOxXG5A7AuGJtQBFihw2MTEZsq1x9
 c1dJvsfMqjCbl2KCKEQtTAaKHq0J1+q9O2y6gKTrSkJ13eaKzCHugv4BgUunkQwh
 WyONoTvjUYfnN0m2mqxWj2rcPZ9WuWr3T0kPaP94nwOQT75MaZTR97iF0PmW7fpM
 9NL2sJYdS192kGqs26XMM8k70UN0JjjbMYOn3EVO54D7P/ukmCF/jyY8LHeSRUWF
 TVyek9cjSg==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45y9pc02et-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 11 Apr 2025 20:45:11 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 53BIxoqR023888; Fri, 11 Apr 2025 20:45:10 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 45ttymjdwc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 11 Apr 2025 20:45:10 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 53BKjAA4022849;
 Fri, 11 Apr 2025 20:45:10 GMT
Received: from localhost.localdomain (dhcp-10-43-12-85.usdhcp.oraclecorp.com
 [10.43.12.85])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id
 45ttymjdug-1; Fri, 11 Apr 2025 20:45:09 +0000
From: Annie Li <annie.li@oracle.com>
To: qemu-devel@nongnu.org
Cc: dave@treblig.org, mst@redhat.com, imammedo@redhat.com, anisinha@redhat.com,
 eduardo@habkost.net, marcel.apfelbaum@gmail.com, philmd@linaro.org,
 wangyanan55@huawei.com, zhao1.liu@intel.com, pbonzini@redhat.com,
 richard.henderson@linaro.org, slp@redhat.com, eblake@redhat.com,
 armbru@redhat.com, annie.li@oracle.com, miguel.luis@oracle.com
Subject: [RFC V3 PATCH 12/13] microvm: enable suspend
Date: Fri, 11 Apr 2025 16:44:46 -0400
Message-ID: <20250411204446.3032-1-annie.li@oracle.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20250411201912.2872-1-annie.li@oracle.com>
References: <20250411201912.2872-1-annie.li@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-11_08,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 spamscore=0
 mlxlogscore=999 phishscore=0 bulkscore=0 adultscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502280000 definitions=main-2504110132
X-Proofpoint-GUID: -_EfKwu-qSxMXBYwNh4HkLKEuMamBzvx
X-Proofpoint-ORIG-GUID: -_EfKwu-qSxMXBYwNh4HkLKEuMamBzvx
Received-SPF: pass client-ip=205.220.177.32; envelope-from=annie.li@oracle.com;
 helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
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
Reply-To: annie.li@oracle.com
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


