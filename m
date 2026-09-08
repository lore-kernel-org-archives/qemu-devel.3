Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E47CDC79F82
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2026 15:07:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3xQ4-0003sX-QQ; Tue, 08 Sep 2026 11:07:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x3xQ3-0003sG-JR
 for qemu-devel@nongnu.org; Tue, 08 Sep 2026 11:07:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x3xQ0-0007Za-AO
 for qemu-devel@nongnu.org; Tue, 08 Sep 2026 11:07:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788880041;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+2ComucD3M5r5A8klwzsGR4vaAZaQy9wz5kxvDbH760=;
 b=KfII3vzTImOfe7Ze1MV3l1EPUNOkl5To+mOuN8+O1oM1uK6BqHxPHPDUosPky1qM5PBN01
 XVXempIuVJfOkF/4hVjpaSfEeQGlU1eeSmM31yC9DK+z6PV90jle6kVjtDEB/jRVUe3ix/
 /J/bYcTIvbnc4HEJBrLrW+9z1nzWiCE=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-315-fACtUUteP5m4rCwomadSRg-1; Tue,
 08 Sep 2026 11:07:18 -0400
X-MC-Unique: fACtUUteP5m4rCwomadSRg-1
X-Mimecast-MFC-AGG-ID: fACtUUteP5m4rCwomadSRg_1788880036
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9E6C3195DE61; Tue,  8 Sep 2026 15:07:16 +0000 (UTC)
Received: from localhost (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 9F56730002EA; Tue,  8 Sep 2026 15:07:15 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 08 Sep 2026 19:06:48 +0400
Subject: [GIT PULL 05/15] block/throttle-groups: fix throttle properties
 typename
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260908-qom-qapi-pr-v1-5-a4d75a2573cc@redhat.com>
References: <20260908-qom-qapi-pr-v1-0-a4d75a2573cc@redhat.com>
In-Reply-To: <20260908-qom-qapi-pr-v1-0-a4d75a2573cc@redhat.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, Alberto Garcia <berto@igalia.com>, 
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>, 
 qemu-block@nongnu.org
X-Developer-Signature: v=1; a=openpgp-sha256; l=1072;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=oEb/RFsLpl9NwB+iPtgbrA2byz/f95rErNp/7ygskj0=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqoCSPXxM5QxK307JpS7AOdbMhV5jZsMw4Hdy6D
 z3ifDqaxvOJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaqAkjwAKCRDa6OEJdZac
 5SBaD/9qd2jeGryiRhavse8m+45ddb+5acnGneAT97Vi2y5Coa+F0dn7+ajXi168ELhgB9l45nt
 NMnwq8cFVZFobXKwbcjb4RMHq2m3lf2qWMrJFSnDDZsgrDf4hxe8cptnnpFxtrjXuQL/Zx2jz3a
 2OdcpMAkyKGaeF3MlBX7x+FkDfslImVPkN2cVNi7oMX9+UZ15ulg2XlwIanJM8Zgf/baarhirbj
 I/etkBQN1BkfejwvC5B0k4OJksXhH9kAfx8mwL0HzS1I3S8iq945jU0OLzfrTRC5oQX3DBHcOcg
 V51zJ7s1hlJ2lrGWsEj/XvuNL8W5OU7PBMrKAKwH6nvBWeJ/nJXQxjCdic+B/csHFdAT2YKf8TF
 X5wfP0ZVjp01lHvZRZ5ruS3MmvmD85OacHCw5eFx4XUNMJUctBjV8GNDpH4T8ZI1+dePx9QFjhd
 ngfSYWYdz6T3WrgbXJFKX88FrKH8GQxlDl/9tFkCNEsvN4pLUZQuzRnFIMmz6Phs9+wkbinmglu
 SRKrhsRvhheC3IwUjYQMbWzVMJNM5Q+SGhezUZsPiP2x6dfcIBzvsiBlcdXRzh/KCZsU/b9GMao
 8GVgYC7pCecpYzK75dxvoEj1KWHWFjaGqPuwaBOsqU7oso60fUKibkQrDOvlKCBVvY/eQR2WdHo
 WZTXsaLSDG0VDWg==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

The getter and setter use visit_type_int64, not visit_type_int.

Fixes: 432d889e55e2 ("block: convert ThrottleGroup to object with QOM")
Reviewed-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 block/throttle-groups.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/throttle-groups.c b/block/throttle-groups.c
index 805e47270c7e..2dfd9d62aacd 100644
--- a/block/throttle-groups.c
+++ b/block/throttle-groups.c
@@ -984,7 +984,7 @@ static void throttle_group_obj_class_init(ObjectClass *klass,
     for (i = 0; i < sizeof(properties) / sizeof(ThrottleParamInfo); i++) {
         object_class_property_add(klass,
                                   properties[i].name,
-                                  "int",
+                                  "int64",
                                   throttle_group_get,
                                   throttle_group_set,
                                   NULL, &properties[i]);

-- 
2.55.0.543.g5ebe2ebe4ea8


