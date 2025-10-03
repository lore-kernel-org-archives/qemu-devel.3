Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22025CAC5B0
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Oct 2025 15:44:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4huY-0005CT-NK; Fri, 03 Oct 2025 11:41:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1v4huE-0004vb-Sc
 for qemu-devel@nongnu.org; Fri, 03 Oct 2025 11:41:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1v4hte-0007hK-Lp
 for qemu-devel@nongnu.org; Fri, 03 Oct 2025 11:41:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759506035;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TCI9CdtrtAK9b9qerBVVa1i7zrINFcMpCM++VkEP7CE=;
 b=ZwDOgpmanrUqk819VII78ilCXlQrOuFaDMpmG415Kf8yiHUJdSMedgnUZziWZX+GaLj9dP
 e8sux4GF+LbL9D1SYZgVH969n+4mK0WurtYZdwZ4aR3dC01M2XMuNC1+z2zHs7QczpcEIc
 MgmIdoHyZTiP3Q2onlDZNVoUXKPl/Kg=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-531-ML7bn3GlMZ2bp0qr_PQmlw-1; Fri, 03 Oct 2025 11:40:33 -0400
X-MC-Unique: ML7bn3GlMZ2bp0qr_PQmlw-1
X-Mimecast-MFC-AGG-ID: ML7bn3GlMZ2bp0qr_PQmlw_1759506033
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-79538b281cdso43983766d6.0
 for <qemu-devel@nongnu.org>; Fri, 03 Oct 2025 08:40:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759506032; x=1760110832;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TCI9CdtrtAK9b9qerBVVa1i7zrINFcMpCM++VkEP7CE=;
 b=iEqsDiwfRT9h1T9cpCNmadG5VBp5HenKP+iYuCZw8vbK8LzHFD076Z8bWfwxZQb4f/
 WspzxBcW3iTUbvw+G6tLskCQ0RozcUL4z3snFq2frD7AjbjfkKAY9nsDluafpsagspJk
 i88dhuo20siTfQzjeyC9sGrym0gsHhdMayQjYj2iHw2ekEO+O4X4OBcOgN0BLOhKixis
 /5RopdZ0VT3DJLCPPi48NqwdhzL771CBRedadYUNHgxMbpO4lydjspV1cwWaLWZ9jqpy
 +L7K1DE9LpZj8/7ZJSwQT88r5HsuNqKKe5CQyxyp8wfi/SJXivJLlJrTrdWm5jxg9bp4
 ntCA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXh4mcKjlZABY+wKKuntM+RFH97x33479yMmUIaW5tH0TxPJkRQ0DLofYu7LkfcBgcD2MGzzc9BQVjA@nongnu.org
X-Gm-Message-State: AOJu0Yx8NDVgJxMRQU57Uba7MCN8gC0Euudwf5rXlbIyYhEpiYxXVrzj
 BotMo/8Up9QcIH6/FT0OsMYv4iqbF0ifjzgZfwy+vn1mEh3AqzzU9wSMt2lpz3zhumlqqrvzmhS
 F0n5UzUXqAP1PrOdkKYoc66v/l58Q7f18TQepBV6T2TOIpTczXkuoD+JrDUsVsCLt
X-Gm-Gg: ASbGncsnyvukmv8urR7MZWB9eV2Bps2XcbqI8yN8z6+txeWUMviY+G6/mjXDA9KMXkb
 yPauIkXAmGSyQGbAGrdU65legZWHKqucWP4/j4069noBwxNakmEgJ7VBUkupWFkxZG+FeR8f8xl
 i+CBqXTkfM+HWaK+DIeZIKYVVwdzsVJ7tmUBMQ2rqHZMnzgnAdRN3U3kOUoUxcWcnFQyfYyeFKy
 s8hJnjIi5CecfcvgF8oDoRjlGIWAP7WED0VlIdqMF93tm8U+w68Iq6fNNxH3vDkJ2HizqRY6e+e
 8eBxAEarlcsqYEvYJdN5EmnFpw+7IBjwYhIx2g==
X-Received: by 2002:a05:6214:2a87:b0:729:1a8e:bbc3 with SMTP id
 6a1803df08f44-878bb82efb9mr97429856d6.16.1759506032507; 
 Fri, 03 Oct 2025 08:40:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHkxLiejO1+JBu1pvttZY+1qDTJXzvp82GySxg64/h5zdAtRSB4Hj4itmnnjIGBPpoiRnhHRw==
X-Received: by 2002:a05:6214:2a87:b0:729:1a8e:bbc3 with SMTP id
 6a1803df08f44-878bb82efb9mr97429536d6.16.1759506032047; 
 Fri, 03 Oct 2025 08:40:32 -0700 (PDT)
Received: from x1.local ([142.188.210.50]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-878bb53d91fsm40656746d6.23.2025.10.03.08.40.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Oct 2025 08:40:31 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, peterx@redhat.com,
 David Hildenbrand <david@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Juraj Marcin <jmarcin@redhat.com>
Subject: [PULL 28/45] migration: Make migration_has_failed() work even for
 CANCELLING
Date: Fri,  3 Oct 2025 11:39:31 -0400
Message-ID: <20251003153948.1304776-29-peterx@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251003153948.1304776-1-peterx@redhat.com>
References: <20251003153948.1304776-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.467,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

No issue I hit, the change is only from code observation when I am looking
at a TLS premature termination issue.

We set CANCELLED very late, it means migration_has_failed() may not work
correctly if it's invoked before updating CANCELLING to CANCELLED.

Allow that state will make migration_has_failed() working as expected even
if it's invoked slightly earlier.

One current user is the multifd code for the TLS graceful termination,
where it's before updating to CANCELLED.

Reviewed-by: Juraj Marcin <jmarcin@redhat.com>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Link: https://lore.kernel.org/r/20250918203937.200833-3-peterx@redhat.com
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/migration.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/migration/migration.c b/migration/migration.c
index 2f55f2784b..3ff85098d5 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1712,7 +1712,8 @@ int migration_call_notifiers(MigrationState *s, MigrationEventType type,
 
 bool migration_has_failed(MigrationState *s)
 {
-    return (s->state == MIGRATION_STATUS_CANCELLED ||
+    return (s->state == MIGRATION_STATUS_CANCELLING ||
+            s->state == MIGRATION_STATUS_CANCELLED ||
             s->state == MIGRATION_STATUS_FAILED);
 }
 
-- 
2.50.1


