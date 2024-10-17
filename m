Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 668D6D374A8
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2024 15:16:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t1SCy-000783-N9; Thu, 17 Oct 2024 11:14:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1t1SCw-00077i-DE
 for qemu-devel@nongnu.org; Thu, 17 Oct 2024 11:14:34 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1t1SCu-00014b-Ns
 for qemu-devel@nongnu.org; Thu, 17 Oct 2024 11:14:34 -0400
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49HFBntI019222;
 Thu, 17 Oct 2024 15:14:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :date:from:in-reply-to:message-id:references:subject:to; s=
 corp-2023-11-20; bh=I6kRe7XWAeep7YalOEQJIxLpst0wY/dkjO24wZibC4o=; b=
 Mp20yxItkyuXuqU0ail9GztN9w1CGM1E3Om3daSeR3qdRDoN+aeVnVkfuRja4g7K
 gl9gidDUAX75kJW+RdduiH3pGACbZsGkx21dwguIih8/cv+WpD6ins1NWkxfUXba
 3srYGZ+psiQ2ay96ZxTAwdYLNobBtWXLiTsxhC+wh/eFvP2vOZZ/K6FDSpwbjmKG
 J73pvPH9BO2iO7SaQzqaLBZmNZHTVOXlcTBbhL2CWCi+7y2AjjOaYDRyCPPFqHpH
 BPMKnVel9Kwt8JpnIj7kdhLfCRh/8k3kj74lJAMfEnFOw6HGRIMS5hR0i76SBIv7
 myoGBhyCoxbBUaGKLyUh2g==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 427h5cq32q-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 17 Oct 2024 15:14:29 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 49HE0skJ027565; Thu, 17 Oct 2024 15:14:29 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 427fjgy6b9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 17 Oct 2024 15:14:29 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 49HFEHgh017147;
 Thu, 17 Oct 2024 15:14:28 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with
 ESMTP id 427fjgy62e-9; Thu, 17 Oct 2024 15:14:28 +0000
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
Subject: [RFC V1 08/14] qom: get properties
Date: Thu, 17 Oct 2024 08:14:09 -0700
Message-Id: <1729178055-207271-9-git-send-email-steven.sistare@oracle.com>
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
X-Proofpoint-ORIG-GUID: DYbuSD6wqBf0Xw-a9nDdZE3qJnt73d0M
X-Proofpoint-GUID: DYbuSD6wqBf0Xw-a9nDdZE3qJnt73d0M
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

Extract a subroutine from user_creatable_add_qapi that converts object
options to a dictionary of properties and returns them.  Use g_autoptr
to simplify the code.  No functional change.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
---
 include/qapi/visitor.h          |  1 +
 include/qom/object_interfaces.h |  8 ++++++++
 qom/object_interfaces.c         | 27 ++++++++++++++-------------
 3 files changed, 23 insertions(+), 13 deletions(-)

diff --git a/include/qapi/visitor.h b/include/qapi/visitor.h
index 27b85d4..640b941 100644
--- a/include/qapi/visitor.h
+++ b/include/qapi/visitor.h
@@ -268,6 +268,7 @@ void visit_complete(Visitor *v, void *opaque);
  */
 void visit_free(Visitor *v);
 
+G_DEFINE_AUTOPTR_CLEANUP_FUNC(Visitor, visit_free)
 
 /*** Visiting structures ***/
 
diff --git a/include/qom/object_interfaces.h b/include/qom/object_interfaces.h
index 02b11a7..2384263 100644
--- a/include/qom/object_interfaces.h
+++ b/include/qom/object_interfaces.h
@@ -98,6 +98,14 @@ Object *user_creatable_add_type(const char *type, const char *id,
 void user_creatable_add_qapi(ObjectOptions *options, Error **errp);
 
 /**
+ * user_creatable_get_props:
+ * @options: the object definition
+ *
+ * Convert @options to a dictionary of properties and return it.
+ */
+QDict *user_creatable_get_props(ObjectOptions *options);
+
+/**
  * user_creatable_parse_str:
  * @str: the object definition string as passed on the command line
  * @errp: if an error occurs, a pointer to an area to store the error
diff --git a/qom/object_interfaces.c b/qom/object_interfaces.c
index e0833c8..104d75c 100644
--- a/qom/object_interfaces.c
+++ b/qom/object_interfaces.c
@@ -139,26 +139,27 @@ out:
 
 void user_creatable_add_qapi(ObjectOptions *options, Error **errp)
 {
-    Visitor *v;
-    QObject *qobj;
-    QDict *props;
-    Object *obj;
+    g_autoptr(Visitor) v;
+    g_autoptr(Object) obj;
+    g_autoptr(QDict) props = user_creatable_get_props(options);
 
-    v = qobject_output_visitor_new(&qobj);
-    visit_type_ObjectOptions(v, NULL, &options, &error_abort);
-    visit_complete(v, &qobj);
-    visit_free(v);
-
-    props = qobject_to(QDict, qobj);
     qdict_del(props, "qom-type");
     qdict_del(props, "id");
 
     v = qobject_input_visitor_new(QOBJECT(props));
     obj = user_creatable_add_type(ObjectType_str(options->qom_type),
                                   options->id, props, v, errp);
-    object_unref(obj);
-    qobject_unref(qobj);
-    visit_free(v);
+}
+
+QDict *user_creatable_get_props(ObjectOptions *options)
+{
+    g_autoptr(Visitor) v;
+    QObject *qobj;
+
+    v = qobject_output_visitor_new(&qobj);
+    visit_type_ObjectOptions(v, NULL, &options, &error_abort);
+    visit_complete(v, &qobj);
+    return qobject_to(QDict, qobj);
 }
 
 char *object_property_help(const char *name, const char *type,
-- 
1.8.3.1


