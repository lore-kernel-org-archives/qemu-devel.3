Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5192AC369D0
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2024 11:14:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1stPvY-0000LH-Ld; Wed, 25 Sep 2024 07:11:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1stPvV-00009s-TX
 for qemu-devel@nongnu.org; Wed, 25 Sep 2024 07:11:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1stPvS-0003Wy-Ap
 for qemu-devel@nongnu.org; Wed, 25 Sep 2024 07:11:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1727262677;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7N7BKVbWAiFjTduC3wB4ybIMZXyqbe+MoDRqWm66aDo=;
 b=aQWwbrU3bpbb2wBl/5u8eOX09OVz6yyFEb+f5YvMfKFgIzwEskpa/TmpBfUSWRpHqG1dV/
 mPqJK4w6/9J3UBTmU116a8TmujqfCoRWGlLY9XmMu6+/byKx7emuxLcZS9SiM7DxouHSah
 n+A6vnRl/7PK07nR565xXb8EsSTTDaw=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-462-oUxlCSbcOlSGUtUM5vsKDA-1; Wed,
 25 Sep 2024 07:11:14 -0400
X-MC-Unique: oUxlCSbcOlSGUtUM5vsKDA-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (unknown
 [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 357891944DE8; Wed, 25 Sep 2024 11:11:13 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.193.206])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 416E51956094; Wed, 25 Sep 2024 11:11:10 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 13/44] qobject: replace assert(0) with g_assert_not_reached()
Date: Wed, 25 Sep 2024 13:09:54 +0200
Message-ID: <20240925111029.24082-14-thuth@redhat.com>
In-Reply-To: <20240925111029.24082-1-thuth@redhat.com>
References: <20240925111029.24082-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.108,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

From: Pierrick Bouvier <pierrick.bouvier@linaro.org>

This patch is part of a series that moves towards a consistent use of
g_assert_not_reached() rather than an ad hoc mix of different
assertion mechanisms.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-ID: <20240919044641.386068-6-pierrick.bouvier@linaro.org>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 qobject/qlit.c | 2 +-
 qobject/qnum.c | 8 ++++----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/qobject/qlit.c b/qobject/qlit.c
index be8332136c..a62865b642 100644
--- a/qobject/qlit.c
+++ b/qobject/qlit.c
@@ -118,7 +118,7 @@ QObject *qobject_from_qlit(const QLitObject *qlit)
     case QTYPE_QBOOL:
         return QOBJECT(qbool_from_bool(qlit->value.qbool));
     default:
-        assert(0);
+        g_assert_not_reached();
     }
 
     return NULL;
diff --git a/qobject/qnum.c b/qobject/qnum.c
index 2bbeaedc7b..2138b563a9 100644
--- a/qobject/qnum.c
+++ b/qobject/qnum.c
@@ -85,7 +85,7 @@ bool qnum_get_try_int(const QNum *qn, int64_t *val)
         return false;
     }
 
-    assert(0);
+    g_assert_not_reached();
     return false;
 }
 
@@ -123,7 +123,7 @@ bool qnum_get_try_uint(const QNum *qn, uint64_t *val)
         return false;
     }
 
-    assert(0);
+    g_assert_not_reached();
     return false;
 }
 
@@ -156,7 +156,7 @@ double qnum_get_double(QNum *qn)
         return qn->u.dbl;
     }
 
-    assert(0);
+    g_assert_not_reached();
     return 0.0;
 }
 
@@ -172,7 +172,7 @@ char *qnum_to_string(QNum *qn)
         return g_strdup_printf("%.17g", qn->u.dbl);
     }
 
-    assert(0);
+    g_assert_not_reached();
     return NULL;
 }
 
-- 
2.46.0


