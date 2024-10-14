Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85EB9D16256
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2024 12:28:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t0KBK-0000GF-Iv; Mon, 14 Oct 2024 08:28:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1t0KB6-000078-U3; Mon, 14 Oct 2024 08:28:00 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1t0KB3-0002OG-6o; Mon, 14 Oct 2024 08:27:59 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49EAL5QV019027;
 Mon, 14 Oct 2024 12:27:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
 :to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-type:content-transfer-encoding; s=pp1; bh=
 Wazm2HVIkNqa3GdjwEhQ4FCnD6IkWo0bsxTcvLiNHSM=; b=KWq5oSm6F0WGR0r7
 cPuDkI9gacDSIag17lxcF3DFREHpTdtROyg9JC3cJbReAf/Co1V7xHRPiJ8LFo8B
 2P1Eg0ihgJPC+IszciTJAmyDb2MfTEh9mjxhpmOzuLDNrhPpPm+Bqq+8H27BZQsP
 nJodGId3hdoVEbgmk6GDp6fcWdl9+N/SopCP3IBnE0GNFY0KakPjWphDrmPyfczf
 /6hGfnEGDLBUBpDU5X+uZp7G9XgOO20qiZsqW8kawaSjwugeER74WxGJnfFuR7/h
 MoDmyyGbS4yHBENtDgwHTFuOuf+d2vIz0UcNeR4UM14fZA+3HeENzEpPyoebf1U6
 fgHUMQ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4291f88k9q-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 14 Oct 2024 12:27:52 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 49ECI9Hn019151;
 Mon, 14 Oct 2024 12:27:52 GMT
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4291f88k9m-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 14 Oct 2024 12:27:52 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 49EAh46A027444;
 Mon, 14 Oct 2024 12:27:51 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4283txejyj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 14 Oct 2024 12:27:51 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 49ECRnba54133200
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 14 Oct 2024 12:27:50 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E0AE220043;
 Mon, 14 Oct 2024 12:27:49 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id EF9E220040;
 Mon, 14 Oct 2024 12:27:48 +0000 (GMT)
Received: from ltcrain34-lp1.aus.stglabs.ibm.com (unknown [9.3.101.40])
 by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 14 Oct 2024 12:27:48 +0000 (GMT)
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
To: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Cc: npiggin@gmail.com, danielhb413@gmail.com, clg@kaod.org
Subject: [PATCH v4 06/13] ppc/spapr: remove deprecated machine pseries-2.6
Date: Mon, 14 Oct 2024 17:57:22 +0530
Message-ID: <20241014122729.1136809-7-harshpb@linux.ibm.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241014122729.1136809-1-harshpb@linux.ibm.com>
References: <20241014122729.1136809-1-harshpb@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 9jgUuTi5Cr_fNcsltl6dF7WjOFFgaObM
X-Proofpoint-ORIG-GUID: F2B4b4qoFh8Fg2HST0HgeXdYASN0r16N
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-14_10,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 adultscore=0 phishscore=0 mlxlogscore=915 malwarescore=0 impostorscore=0
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
Removing pseries-2.6 specific code with this patch for now.

Suggested-by: Cédric Le Goater <clg@kaod.org>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
---
 hw/ppc/spapr.c | 18 ------------------
 1 file changed, 18 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index f63843d107..a9c988b8f6 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -5278,24 +5278,6 @@ static void spapr_machine_2_7_class_options(MachineClass *mc)
 
 DEFINE_SPAPR_MACHINE(2, 7);
 
-/*
- * pseries-2.6
- */
-
-static void spapr_machine_2_6_class_options(MachineClass *mc)
-{
-    static GlobalProperty compat[] = {
-        { TYPE_SPAPR_PCI_HOST_BRIDGE, "ddw", "off" },
-    };
-
-    spapr_machine_2_7_class_options(mc);
-    mc->has_hotpluggable_cpus = false;
-    compat_props_add(mc->compat_props, hw_compat_2_6, hw_compat_2_6_len);
-    compat_props_add(mc->compat_props, compat, G_N_ELEMENTS(compat));
-}
-
-DEFINE_SPAPR_MACHINE(2, 6);
-
 static void spapr_machine_register_types(void)
 {
     type_register_static(&spapr_machine_info);
-- 
2.45.2


