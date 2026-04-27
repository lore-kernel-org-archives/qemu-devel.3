Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB687FF885E
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2026 09:59:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHIjZ-000872-TV; Mon, 27 Apr 2026 05:58:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1wHIjV-0007zt-AJ
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 05:58:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1wHIjT-0008AG-Ue
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 05:58:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777283907;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=e9zpsbG1qaE8A7Go/+EGU6gSYRamjFD7eQhgj5ujaP8=;
 b=EJEv/XdzpyespNUu2fDjEPMnUMlkZxTumkTG8jLh1Geis7Te8Wq+SE70fYf+44GRW60+CY
 N7rgiQC6Q8b9yw3rndigFLRMkr/HbcE1oq5LqF5ddmDNC2Gm1YiMULqX0U+ZVkN+bb8dFz
 Vnd1ITTndcnghpH1oPOVdKt5JLja1FY=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-459-IOfPhE-jPY-P1JzASh1iww-1; Mon,
 27 Apr 2026 05:58:25 -0400
X-MC-Unique: IOfPhE-jPY-P1JzASh1iww-1
X-Mimecast-MFC-AGG-ID: IOfPhE-jPY-P1JzASh1iww_1777283904
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0E59B1956050; Mon, 27 Apr 2026 09:58:24 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.44.48.146])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B368D3000709; Mon, 27 Apr 2026 09:58:20 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, Dmitry Frolov <frolov@swemel.ru>,
 Max Filippov <jcmvbkbc@gmail.com>
Subject: [PULL 09/10] target/xtensa: Replace malloc() with g_strdup_printf()
Date: Mon, 27 Apr 2026 11:57:46 +0200
Message-ID: <20260427095747.1070244-10-thuth@redhat.com>
In-Reply-To: <20260427095747.1070244-1-thuth@redhat.com>
References: <20260427095747.1070244-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Dmitry Frolov <frolov@swemel.ru>

malloc() return value is used without a check.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Signed-off-by: Dmitry Frolov <frolov@swemel.ru>
Reviewed-by: Max Filippov <jcmvbkbc@gmail.com>
Message-ID: <20250730062142.1665980-1-frolov@swemel.ru>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 target/xtensa/translate.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/target/xtensa/translate.c b/target/xtensa/translate.c
index 6f9dd9fb5cf..175fd4b5cfc 100644
--- a/target/xtensa/translate.c
+++ b/target/xtensa/translate.c
@@ -112,17 +112,12 @@ void xtensa_collect_sr_names(const XtensaConfig *config)
 
             if (*pname) {
                 if (strstr(*pname, name) == NULL) {
-                    char *new_name =
-                        malloc(strlen(*pname) + strlen(name) + 2);
-
-                    strcpy(new_name, *pname);
-                    strcat(new_name, "/");
-                    strcat(new_name, name);
-                    free(*pname);
+                    char *new_name = g_strdup_printf("%s/%s", *pname, name);
+                    g_free(*pname);
                     *pname = new_name;
                 }
             } else {
-                *pname = strdup(name);
+                *pname = g_strdup(name);
             }
         }
     }
-- 
2.53.0


