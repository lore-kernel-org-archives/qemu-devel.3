Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8792D12662
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Dec 2025 17:53:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQUZE-0001ZF-Ci; Tue, 02 Dec 2025 12:53:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vQUZ3-0001Yg-QM
 for qemu-devel@nongnu.org; Tue, 02 Dec 2025 12:53:26 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vQUZ2-0002L2-6Q
 for qemu-devel@nongnu.org; Tue, 02 Dec 2025 12:53:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764698001;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=elCbdkabqxWCNUGgF8/iWL+STt0p5Ghdwu+SusGofQ0=;
 b=hzIJ/SZ0K1P2ELf4ALdBOLHpgs/b31MPwRT6D0yR/F46jC7mTpqsk0xhAip/7krjv/8mrk
 76V6de8vkBuDyWrhPKrh74IIZ+6pbRRqnaKNovn2r1u729YL8FpGDPbWWeEIvAgHrQkJog
 Qkl6vUYPFdJBnvk4Z5WkcyfckC0FnX0=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-615--i1nzRGFPkm5JMrdS4JF4A-1; Tue, 02 Dec 2025 12:53:20 -0500
X-MC-Unique: -i1nzRGFPkm5JMrdS4JF4A-1
X-Mimecast-MFC-AGG-ID: -i1nzRGFPkm5JMrdS4JF4A_1764698000
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-8826fb20ef0so129161306d6.0
 for <qemu-devel@nongnu.org>; Tue, 02 Dec 2025 09:53:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1764698000; x=1765302800; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=elCbdkabqxWCNUGgF8/iWL+STt0p5Ghdwu+SusGofQ0=;
 b=O4kfzo/Ac707cg1cesth8bl7+43Ry3Iu1RGzgddogNW01NlHvL2KrWNQQZcG6VRnqV
 ng32Hz/oh13gDneqSxlj0FiJBo0xno/RtTinq5qhzdFutyuEuYJ3KEtg3/Bs/mWqrdnH
 EgqcXZ6cGRuKDUN3QOnS2NbZg9QsbcIa0ySy2xfVCn0+8t2JW9fsOd4s5KIwrCULWIGV
 o/ers6GrY53cpk7YIzl5tdXv/aDdkc8JqSNqgPnW9RE6sCuyc7RBL2/EI/dAcUYnNmTd
 JUtGnYj5+QaALQWh/lliHYuMLvCwkYEH1LhpRq4l9SuwRd+uIz7MeYNjCJqaCt6NUGC9
 UhLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764698000; x=1765302800;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=elCbdkabqxWCNUGgF8/iWL+STt0p5Ghdwu+SusGofQ0=;
 b=YLysgu4j/CCQM74zeK56xGQpOPTgBgRc+F3DL2WAx/bB0LOZJtJBqXpADXc733sNPt
 OXbqiYtZTFb/4IzOWGgyGgZjYlNvSsxz9QGqfCyvDlVFKiobIlMRPe3w6Or4La0Vm8J3
 9cxnFjpAOECzXL+xO8TLYZ+6rknnOY+zFLmfa67Z4rdFShV0PfwbKqNBSjjerokWUTpV
 7zYlAqe+hNKz3qYUBnmXnHIJOlZXVY+Sb97B1F8Jouyd4Pz+4s+Td1/bguoeh2h+XDf/
 LlmoxYS0KqqG0NhVo8m6WUBihipNqAAtv3tP76hrH3RkKyiMZYzbf/9KtStE794c6CsH
 Omvg==
X-Gm-Message-State: AOJu0YwQiiaddvbTlL4olZuBXb7Q0b8p+kCToLLmK88JWyh1ZQY7eiJB
 G0eBl7eWQcBFdrbPL0dlPah6cFatfbCmmjVBNxTFdneo5C7qC56whhCL6ZI+ho4bJnsCLFbUWzt
 DgPw8K/AzYFcr1cYU0/D2r2QgsC/OypFG0jQhTVl+okOj+xUUxLoLR+CwRXsJ0mUeOYWy75+hcB
 2tjQNxRrUd/MwvHIxnAU9U6ayWi6py1k08v+gfwg==
X-Gm-Gg: ASbGncvkNIUje2G+ju138r1K0s12G3lcpEUznHP+zwapCTMcJ1wKsJ0/61VIIowv25u
 URmukXjPvL1mxdpR1jX28A82PfsWNcyI4hlTna0yu10H2u/uBJ9sO6NqMJEqD7VK+Ci+JHDHZfI
 Tw5T1Q2iTnJMrwgD8/CVdOW+RgExEKAQTIfEX8WTW3dqS5+TZCHPEasV9MUQB6UDZLlouZgm0Hn
 O7uB+g6+f641UPlcXLW3yh6oQxZ0upOcenM+0oiwA3I2a+KcCCxvDyry/VurGISfzBRhgmG6JmX
 ReweftBuORJ2rXwrgAC8FP9UkU37VxjVsWCXSTqQKCfCbt2Mnv1kedGG2WCW+8uA7QxHtfJoq5K
 A
X-Received: by 2002:a05:6214:2481:b0:880:5357:f5ba with SMTP id
 6a1803df08f44-8847c4995fcmr725342016d6.18.1764697999900; 
 Tue, 02 Dec 2025 09:53:19 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHehlBrlL6P1+4QgaWBS9L0i+Lq7++GOcv08VvvzULG5QsmSHk8tj+p+AtzxA1PuJhAVjUmmA==
X-Received: by 2002:a05:6214:2481:b0:880:5357:f5ba with SMTP id
 6a1803df08f44-8847c4995fcmr725341376d6.18.1764697999302; 
 Tue, 02 Dec 2025 09:53:19 -0800 (PST)
Received: from x1.com ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4efd2fbc481sm99477571cf.10.2025.12.02.09.53.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Dec 2025 09:53:18 -0800 (PST)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, farosas@suse.de, vsementsov@yandex-team.ru,
 armbru@redhat.com, marcandre.lureau@redhat.com, peterx@redhat.com,
 jmarcin@redhat.com
Subject: [PATCH for-11.0 v2 8/7] migration: Use error_propagate() in
 migrate_error_propagate()
Date: Tue,  2 Dec 2025 12:53:17 -0500
Message-ID: <20251202175317.1186544-1-peterx@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251201194510.1121221-1-peterx@redhat.com>
References: <20251201194510.1121221-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

It improves readability, as suggested by Markus.

Suggested-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/migration.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index 70813e5006..d55fde222a 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1555,12 +1555,7 @@ void migrate_error_propagate(MigrationState *s, Error *error)
 {
     QEMU_LOCK_GUARD(&s->error_mutex);
     trace_migrate_error(error_get_pretty(error));
-
-    if (!s->error) {
-        s->error = error;
-    } else {
-        error_free(error);
-    }
+    error_propagate(&s->error, error);
 }
 
 bool migrate_has_error(MigrationState *s)
-- 
2.50.1


