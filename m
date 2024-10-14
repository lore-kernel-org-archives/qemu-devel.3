Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47DD5D16256
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2024 12:29:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t0KB8-00008A-RR; Mon, 14 Oct 2024 08:28:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1t0KB6-000077-Tc; Mon, 14 Oct 2024 08:28:00 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1t0KB3-0002ON-7d; Mon, 14 Oct 2024 08:28:00 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49EALL49020760;
 Mon, 14 Oct 2024 12:27:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
 :to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-type:content-transfer-encoding; s=pp1; bh=
 rGRHFGDFWrFgquNMp6P8dF0X7/ny0jdcMhxzy2gOkSM=; b=tBQDByixHoqAtsCM
 tDV/xw6DjvURzccUnCxA2FEo6Tx3kEwus0A2a8/NwUg3wcNZAqr5ntXDinjHcmsW
 X9kMiR4rbFlQMXWx8r7Wqttk8n+oYUZ9DBgfiSKkQ0YZ+5+JB4Ac9s81LzAOjHZZ
 K22+Oj6+bz3dwZBGxnajN+hf04MA/YcHI2MlH785KaSWcM47yo/Wxh4WHeF/GiP4
 wMEWQC8h1yUbLhNkKyIzPi4DmPLZMHIN0v/ZC0md8UzGIJt4BY8F+wTBoH+WKknd
 YQKBiODSs5fbvE4YX6rNkr7zbEt7xrZEwHuHmH5ahPvqJOiOMpRZ/+aCQUpfL7WY
 XWqCxw==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4291f88k93-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 14 Oct 2024 12:27:48 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 49ECPj6m007169;
 Mon, 14 Oct 2024 12:27:47 GMT
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4291f88k8w-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 14 Oct 2024 12:27:47 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 49EBinWM006415;
 Mon, 14 Oct 2024 12:27:47 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4284xjxbv9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 14 Oct 2024 12:27:47 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 49ECRjTd22872350
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 14 Oct 2024 12:27:45 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 164F720043;
 Mon, 14 Oct 2024 12:27:45 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2DD572004B;
 Mon, 14 Oct 2024 12:27:44 +0000 (GMT)
Received: from ltcrain34-lp1.aus.stglabs.ibm.com (unknown [9.3.101.40])
 by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 14 Oct 2024 12:27:44 +0000 (GMT)
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
To: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Cc: npiggin@gmail.com, danielhb413@gmail.com, clg@kaod.org
Subject: [PATCH v4 02/13] ppc/spapr: remove deprecated machine pseries-2.2
Date: Mon, 14 Oct 2024 17:57:18 +0530
Message-ID: <20241014122729.1136809-3-harshpb@linux.ibm.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241014122729.1136809-1-harshpb@linux.ibm.com>
References: <20241014122729.1136809-1-harshpb@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: th0qjwDptJHfGJhyN354Cf6dBKTnl8q8
X-Proofpoint-ORIG-GUID: lED3RyQout5BS06Oalrh_AS9YfLzJxcf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-14_10,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 adultscore=0 phishscore=0 mlxlogscore=866 malwarescore=0 impostorscore=0
 spamscore=0 priorityscore=1501 mlxscore=0 suspectscore=0 clxscore=1015
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410140089
Received-SPF: pass client-ip=148.163.158.5; envelope-from=harshpb@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Commit 1392617d3576 intended to tag pseries-2.1 - 2.11 machines as
deprecated with reasons mentioned in its commit log.
Removing pseries-2.2 specific code with this patch for now.

Suggested-by: Cédric Le Goater <clg@kaod.org>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
---
 include/hw/boards.h |  3 ---
 hw/core/machine.c   |  3 ---
 hw/ppc/spapr.c      | 17 -----------------
 3 files changed, 23 deletions(-)

diff --git a/include/hw/boards.h b/include/hw/boards.h
index 44d19e1ffc..7e849bb30d 100644
--- a/include/hw/boards.h
+++ b/include/hw/boards.h
@@ -825,7 +825,4 @@ extern const size_t hw_compat_2_4_len;
 extern GlobalProperty hw_compat_2_3[];
 extern const size_t hw_compat_2_3_len;
 
-extern GlobalProperty hw_compat_2_2[];
-extern const size_t hw_compat_2_2_len;
-
 #endif
diff --git a/hw/core/machine.c b/hw/core/machine.c
index a41d1dbe26..2bbfcd1ede 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -294,9 +294,6 @@ GlobalProperty hw_compat_2_3[] = {
 };
 const size_t hw_compat_2_3_len = G_N_ELEMENTS(hw_compat_2_3);
 
-GlobalProperty hw_compat_2_2[] = {};
-const size_t hw_compat_2_2_len = G_N_ELEMENTS(hw_compat_2_2);
-
 MachineState *current_machine;
 
 static char *machine_get_kernel(Object *obj, Error **errp)
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index e9518ff8b3..34d655d0b3 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -5364,23 +5364,6 @@ static void spapr_machine_2_3_class_options(MachineClass *mc)
 }
 DEFINE_SPAPR_MACHINE(2, 3);
 
-/*
- * pseries-2.2
- */
-
-static void spapr_machine_2_2_class_options(MachineClass *mc)
-{
-    static GlobalProperty compat[] = {
-        { TYPE_SPAPR_PCI_HOST_BRIDGE, "mem_win_size", "0x20000000" },
-    };
-
-    spapr_machine_2_3_class_options(mc);
-    compat_props_add(mc->compat_props, hw_compat_2_2, hw_compat_2_2_len);
-    compat_props_add(mc->compat_props, compat, G_N_ELEMENTS(compat));
-    mc->default_machine_opts = "modern-hotplug-events=off,suppress-vmdesc=on";
-}
-DEFINE_SPAPR_MACHINE(2, 2);
-
 static void spapr_machine_register_types(void)
 {
     type_register_static(&spapr_machine_info);
-- 
2.45.2


