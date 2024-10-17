Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 826A2D374A8
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2024 15:15:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t1SD5-0007AO-2C; Thu, 17 Oct 2024 11:14:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1t1SD3-00079h-6L
 for qemu-devel@nongnu.org; Thu, 17 Oct 2024 11:14:41 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1t1SD1-00015d-BO
 for qemu-devel@nongnu.org; Thu, 17 Oct 2024 11:14:40 -0400
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49HFBdYS025061;
 Thu, 17 Oct 2024 15:14:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :date:from:in-reply-to:message-id:references:subject:to; s=
 corp-2023-11-20; bh=58pR73D09nC0coDIb8oa8Lf/5Za9PFAA07dzekbg9L0=; b=
 d53KGugHTDeEtsYmcVCOr9D9UFF2MYzHd+7EJwRTZwcX19/Vs5DHeDPnY2Siebak
 uU3HInQMZvLUVqKP0kKPCSfFQ+QT6xe99jQ3QhyUh1f+zkNBaybnZIitZylyGU+T
 J+gHWjmbqrPNw2+xq2qEL2rrlec5d5d0VlcjMavtHxsugGCJOPP1kmdJuvORb0Kx
 uGq5c2mfdCg4Nc7xoJhPjr6ZgIKM1Me5Q5Z3ZhonXAZNwM6Kx1TTEOct5IRbznYZ
 dVPLEydOpP5ZD1GL8DZ+1Crtpmkzk4ZmDUWpdVKeUS9pOpmrRMIE2CydtevnP26/
 lZ73Uvyz8OahYfhcQ9EHhg==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 427g1apg23-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 17 Oct 2024 15:14:33 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 49HElkJP027278; Thu, 17 Oct 2024 15:14:31 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 427fjgy6d5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 17 Oct 2024 15:14:31 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 49HFEHgl017147;
 Thu, 17 Oct 2024 15:14:31 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with
 ESMTP id 427fjgy62e-11; Thu, 17 Oct 2024 15:14:31 +0000
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
Subject: [RFC V1 10/14] qemu-options: pass object to filter
Date: Thu, 17 Oct 2024 08:14:11 -0700
Message-Id: <1729178055-207271-11-git-send-email-steven.sistare@oracle.com>
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
X-Proofpoint-GUID: jgrHm-urMrIQKq9lgHnAEta7c0eJut20
X-Proofpoint-ORIG-GUID: jgrHm-urMrIQKq9lgHnAEta7c0eJut20
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
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

Pass the entire options object to the foreach filter function, rather
than just the type name, so more aspects of the object can be used as
filter criteria in future patches.  No functional change.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
---
 system/vl.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/system/vl.c b/system/vl.c
index 5f5e810..3c592b9 100644
--- a/system/vl.c
+++ b/system/vl.c
@@ -1801,13 +1801,13 @@ static void qemu_apply_legacy_machine_options(QDict *qdict)
     }
 }
 
-static void object_option_foreach_add(bool (*type_opt_predicate)(const char *))
+static void object_option_foreach_add(
+    bool (*type_opt_predicate)(const ObjectOption *opt))
 {
     ObjectOption *opt, *next;
 
     QTAILQ_FOREACH_SAFE(opt, &object_opts, next, next) {
-        const char *type = ObjectType_str(opt->opts->qom_type);
-        if (type_opt_predicate(type)) {
+        if (type_opt_predicate(opt)) {
             user_creatable_add_qapi(opt->opts, &error_fatal);
             qapi_free_ObjectOptions(opt->opts);
             QTAILQ_REMOVE(&object_opts, opt, next);
@@ -1859,8 +1859,10 @@ static void object_option_parse(const char *str)
 /*
  * Very early object creation, before the sandbox options have been activated.
  */
-static bool object_create_pre_sandbox(const char *type)
+static bool object_create_pre_sandbox(const ObjectOption *opt)
 {
+    const char *type = ObjectType_str(opt->opts->qom_type);
+
     /*
      * Objects should in general not get initialized "too early" without
      * a reason. If you add one, state the reason in a comment!
@@ -1884,15 +1886,17 @@ static bool object_create_pre_sandbox(const char *type)
  * cannot be created here, as it depends on the chardev
  * already existing.
  */
-static bool object_create_early(const char *type)
+static bool object_create_early(const ObjectOption *opt)
 {
+    const char *type = ObjectType_str(opt->opts->qom_type);
+
     /*
      * Objects should not be made "delayed" without a reason.  If you
      * add one, state the reason in a comment!
      */
 
     /* Reason: already created. */
-    if (object_create_pre_sandbox(type)) {
+    if (object_create_pre_sandbox(opt)) {
         return false;
     }
 
@@ -2014,9 +2018,9 @@ static void qemu_create_early_backends(void)
  * The remainder of object creation happens after the
  * creation of chardev, fsdev, net clients and device data types.
  */
-static bool object_create_late(const char *type)
+static bool object_create_late(const ObjectOption *opt)
 {
-    return !object_create_early(type) && !object_create_pre_sandbox(type);
+    return !object_create_early(opt) && !object_create_pre_sandbox(opt);
 }
 
 static void qemu_create_late_backends(void)
-- 
1.8.3.1


