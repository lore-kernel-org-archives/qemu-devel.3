Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A45ACD3C547
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Oct 2024 06:01:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t22WU-0000rI-CB; Sat, 19 Oct 2024 02:01:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1t22WQ-0000qz-Mf
 for qemu-devel@nongnu.org; Sat, 19 Oct 2024 02:01:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1t22WL-00034D-Kn
 for qemu-devel@nongnu.org; Sat, 19 Oct 2024 02:01:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729317658;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:resent-to:
 resent-from:resent-message-id:in-reply-to:in-reply-to:  references:references; 
 bh=d95iGD4/mKN7eUCuXr/LnAXufyE2M3N2BIqzhui/lrw=;
 b=KFVG5buAeaAbiTAExUAyfPMsqC4zbTahX3B9XESEkXXPsBzxPhPpgjb5U+IDK8mVhMbBxZ
 Zi2Ik0vukpstjNnw+O3Lzx2+TOe4H7MS1aJIZYRufyZSy09n87x3oN+J/IUg0r5dNvm8Xy
 D7Uqlq5x4oSQI3wL7XxiazBrRWezhhY=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-617-nECQXZAON06b2UDNOZR3rQ-1; Sat,
 19 Oct 2024 02:00:55 -0400
X-MC-Unique: nECQXZAON06b2UDNOZR3rQ-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 403D719560A5; Sat, 19 Oct 2024 06:00:54 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.150])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D542E1956086; Sat, 19 Oct 2024 06:00:53 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 8AA9721E6A28; Sat, 19 Oct 2024 08:00:51 +0200 (CEST)
Resent-To: peter.maydell@linaro.org, philmd@linaro.org, qemu-devel@nongnu.org
Resent-From: Markus Armbruster <armbru@redhat.com>
Resent-Date: Sat, 19 Oct 2024 08:00:51 +0200
Resent-Message-ID: <878qukfx7w.fsf@pond.sub.org>
X-From-Line: armbru@redhat.com  Fri Oct 18 15:28:24 2024
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 639B521E6827; Fri, 18 Oct 2024 15:28:24 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 9/9] qerror: QERR_PROPERTY_VALUE_OUT_OF_RANGE is no longer
 used, drop
Date: Fri, 18 Oct 2024 15:28:24 +0200
Message-ID: <20241018132824.3379780-10-armbru@redhat.com>
In-Reply-To: <20241018132824.3379780-1-armbru@redhat.com>
References: <20241018132824.3379780-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.249,
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

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-ID: <20241010150144.986655-8-armbru@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/qapi/qmp/qerror.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/include/qapi/qmp/qerror.h b/include/qapi/qmp/qerror.h
index 101c1141b9..d1db6f18cd 100644
--- a/include/qapi/qmp/qerror.h
+++ b/include/qapi/qmp/qerror.h
@@ -23,7 +23,4 @@
 #define QERR_MISSING_PARAMETER \
     "Parameter '%s' is missing"
 
-#define QERR_PROPERTY_VALUE_OUT_OF_RANGE \
-    "Property %s.%s doesn't take value %" PRId64 " (minimum: %" PRId64 ", maximum: %" PRId64 ")"
-
 #endif /* QERROR_H */
-- 
2.46.0



