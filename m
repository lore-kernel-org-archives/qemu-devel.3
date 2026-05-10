Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BF69CD3427
	for <qemu-devel@archiver.kernel.org>; Sun, 10 May 2026 13:49:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wM4XP-0001od-QT; Sun, 10 May 2026 09:49:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wM4XN-0001eJ-Ix
 for qemu-devel@nongnu.org; Sun, 10 May 2026 09:49:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wM4XL-0005Xz-Sz
 for qemu-devel@nongnu.org; Sun, 10 May 2026 09:49:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778420978;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=c9M0jzjB5QWgA6OjrGy+78zDU5Q5ObVFQZ1cmiLj3RA=;
 b=NjGDXcEJiYOnLa/UjirawfOxhFTFegngoKyrRuSu/ymW0DZBwVmo7ybrRbwxe0gr1Iu/6o
 cU1L7YgTAgEwvO29I/obVe1B6hRKjqCAlHhxXdKpobFBP8731J6+S1wp9Hz0JBBiEwAKog
 XLeTh6+in9LlTL9QwOvGfIwtgTgQCrk=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-490-5tvfOHYaOqSwB_vy6y_dnA-1; Sun,
 10 May 2026 09:49:36 -0400
X-MC-Unique: 5tvfOHYaOqSwB_vy6y_dnA-1
X-Mimecast-MFC-AGG-ID: 5tvfOHYaOqSwB_vy6y_dnA_1778420976
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DEE1118005B5
 for <qemu-devel@nongnu.org>; Sun, 10 May 2026 13:49:35 +0000 (UTC)
Received: from localhost (unknown [10.44.24.4])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 07F671955D84; Sun, 10 May 2026 13:49:33 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Sun, 10 May 2026 17:43:29 +0400
Subject: [PATCH 32/54] i386/cpu: convert strList property to QAPI-aware
 registration
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260510-qom-qapi-v1-32-48ba6a1a1fa5@redhat.com>
References: <20260510-qom-qapi-v1-0-48ba6a1a1fa5@redhat.com>
In-Reply-To: <20260510-qom-qapi-v1-0-48ba6a1a1fa5@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=853;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=RpFxiGx7DlKF3M3cA7HlhzjYqpElkc/Xx+/zjTy887U=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqAItwzxyK1c0aBi/YNfaLWLLZfL64ONO25Do+m
 vsDW6gJR5CJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCagCLcAAKCRDa6OEJdZac
 5cgKD/9qRZ+hylW+g4k37r6KsF1k3aqpTTaUdSceTZjXv5F+zyik9/aQoBNV8nyZdHgLM3J51IA
 fb3TzjTI9c+I0JD6yvY+TGzBrkOjvBqCuKye8EeZKCOFSqAs3wl4ISaSHMbWthKJh9WJHeK/GvB
 98fNh3I04d1pSIfPhcTz3KVq5ox/bpO3JlXDXeFBpfmLLBeq8JVkUneUxXd0L+LS+gNqoT86niP
 VYfWVLDUc0ntiPT1TEtr3eWRI0XMH5kXHQE++vIBN/zVSkYfYPQhCeRbBBUdnPijFNalj0bETTz
 667qkhKpIjBt+kloIyoH/tcmBK4MDvfm1SZ5l0++sfwE/R4svEwIZ4lAPJiTK4EVr7FBesODkUq
 JqSCIFpR1LV7qzv0urtQB0imMNCBlf/z/eUP8fIsGrmkTJJvuF6e7qK8mH5vs3u6WdDFeRnC5fo
 JIUpO79H85YygVqac0NeNC1KbTnEAfT7RQdX+yt0qzcBfR3t2dAq3CwXsaY/XkypkYiyKZWTD8k
 x9d0ofHwBpyTjBv/1u3Ao6p2Nr0/jD8C74K7ib3qhimo9Pk4I5XrSOrVysUzW0Tz3aJ95jgHrNk
 G3Dx7Ycf4g0IhN+JuTxzkPvQQo9fPnvGOH3Jz+nw/Em0lDa+TT48s9fNkn3VVN290z1yd7TElqS
 v77MTDaoG4XR2qA==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 target/i386/cpu.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index e902d0e6d3f..b7f5cf6ddb7 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -10963,7 +10963,8 @@ static void x86_cpu_common_class_init(ObjectClass *oc, const void *data)
      * QMP command: they list the features that would have prevented the
      * CPU from running if the "enforce" flag was set.
      */
-    object_class_property_add(oc, "unavailable-features", "strList",
+    object_class_property_add_qapi(oc, "unavailable-features",
+                              &strList_type_info,
                               x86_cpu_get_unavailable_features,
                               NULL, NULL, NULL);
 

-- 
2.54.0


