Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEC22D374A8
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2024 15:16:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t1SCr-00075V-BF; Thu, 17 Oct 2024 11:14:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1t1SCq-00075G-6T
 for qemu-devel@nongnu.org; Thu, 17 Oct 2024 11:14:28 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1t1SCo-00013R-A7
 for qemu-devel@nongnu.org; Thu, 17 Oct 2024 11:14:27 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49HFBpD6002238;
 Thu, 17 Oct 2024 15:14:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :date:from:in-reply-to:message-id:references:subject:to; s=
 corp-2023-11-20; bh=yzlVEiJFH9rvFFZkAgkE2I5r8H8b5bRa4IdpedreMGU=; b=
 jVfdXk1M57g2PtnyAXY35jrLlNHjg+ikgAOJZlEP9MKPiZQq1y7juLNd61+s0pwM
 m3Py//YlVn127SVKv44/ckHxSsbb/fVl3v0AHi0HqWadofI9rJRS/BuMJ7wpPgE9
 Wh+gAJxBHds/bKY1c8VCn9qTEJ/ZP/Bl+9ZvALNkGDKYpaMI4zsZul5MkqCsHjmc
 UENybofqwl8cQCqSRhAPeVP+cGLHyFK63lWBAKwX1SNYaDw+82E34ksj35TKEuzB
 66A83UclD/5shMNdaGJjtla9ld6Vi7T34COzMTA6Qld4vP73jj6UV4MkBG2rwZic
 oMncJt75WCvXO4zrWun8ow==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 427fw2ptrm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 17 Oct 2024 15:14:24 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 49HE0skF027565; Thu, 17 Oct 2024 15:14:23 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 427fjgy679-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 17 Oct 2024 15:14:23 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 49HFEHgZ017147;
 Thu, 17 Oct 2024 15:14:22 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with
 ESMTP id 427fjgy62e-5; Thu, 17 Oct 2024 15:14:22 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 David Hildenbrand <david@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>
Subject: [RFC V1 04/14] accel: set accelerator and machine props earlier
Date: Thu, 17 Oct 2024 08:14:05 -0700
Message-Id: <1729178055-207271-5-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1729178055-207271-1-git-send-email-steven.sistare@oracle.com>
References: <1729178055-207271-1-git-send-email-steven.sistare@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-17_16,2024-10-17_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 adultscore=0
 spamscore=0 malwarescore=0 bulkscore=0 suspectscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2410170105
X-Proofpoint-GUID: hxZSA1qmgIlPA4w3zzq6p4eRX3tTz3Gz
X-Proofpoint-ORIG-GUID: hxZSA1qmgIlPA4w3zzq6p4eRX3tTz3Gz
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Make all global and compat properties available before the first objects
are created.  Set accelerator compatibility properties in
configure_accelerators, when the accelerator is chosen, and call
configure_accelerators earlier.  Set machine options earlier.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
---
 accel/accel-system.c |  2 --
 system/vl.c          | 34 ++++++++++++++++++----------------
 2 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/accel/accel-system.c b/accel/accel-system.c
index f6c947d..c8aeae4 100644
--- a/accel/accel-system.c
+++ b/accel/accel-system.c
@@ -41,8 +41,6 @@ int accel_init_machine(AccelState *accel, MachineState *ms)
         ms->accelerator = NULL;
         *(acc->allowed) = false;
         object_unref(OBJECT(accel));
-    } else {
-        object_set_accelerator_compat_props(acc->compat_props);
     }
     return ret;
 }
diff --git a/system/vl.c b/system/vl.c
index b94a6b9..bca2292 100644
--- a/system/vl.c
+++ b/system/vl.c
@@ -2346,6 +2346,7 @@ static int do_configure_accelerator(void *opaque, QemuOpts *opts, Error **errp)
         goto bad;
     }
 
+    object_set_accelerator_compat_props(ac->compat_props);
     acs->accel = accel;
     return 1;
 
@@ -3728,29 +3729,14 @@ void qemu_init(int argc, char **argv)
     parse_memory_options();
 
     qemu_create_machine(machine_opts_dict);
-
-    suspend_mux_open();
-
-    qemu_disable_default_devices();
-    qemu_setup_display();
-    qemu_create_default_devices();
-    qemu_create_early_backends();
-
     qemu_apply_legacy_machine_options(machine_opts_dict);
     qemu_apply_machine_options(machine_opts_dict);
     qobject_unref(machine_opts_dict);
-    phase_advance(PHASE_MACHINE_CREATED);
 
-    /*
-     * Note: uses machine properties such as kernel-irqchip, must run
-     * after qemu_apply_machine_options.
-     */
     accel = configure_accelerators(argv[0]);
-    create_accelerator(accel);
-    phase_advance(PHASE_ACCEL_CREATED);
 
     /*
-     * Beware, QOM objects created before this point miss global and
+     * QOM objects created after this point see all global and
      * compat properties.
      *
      * Global properties get set up by qdev_prop_register_global(),
@@ -3765,6 +3751,22 @@ void qemu_init(int argc, char **argv)
      * called from do_configure_accelerator().
      */
 
+    suspend_mux_open();
+
+    qemu_disable_default_devices();
+    qemu_setup_display();
+    qemu_create_default_devices();
+    qemu_create_early_backends();
+
+    phase_advance(PHASE_MACHINE_CREATED);
+
+    /*
+     * Note: uses machine properties such as kernel-irqchip, must run
+     * after qemu_apply_machine_options.
+     */
+    create_accelerator(accel);
+    phase_advance(PHASE_ACCEL_CREATED);
+
     machine_class = MACHINE_GET_CLASS(current_machine);
     if (!qtest_enabled() && machine_class->deprecation_reason) {
         warn_report("Machine type '%s' is deprecated: %s",
-- 
1.8.3.1


