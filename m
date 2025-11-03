Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75890CCF9F8
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Nov 2025 21:09:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vG1lp-00013d-U5; Mon, 03 Nov 2025 16:07:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vG1lk-00012f-VR
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 16:07:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vG1lZ-0005NR-24
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 16:07:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762204021;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vklKslWLbNtXTg8FTlEZA3hZadv9klpHSH1s6LHPYGo=;
 b=P64DbGHRwdNEJWpQ8RWK7v5BTZhJe5ORo5nCQQ2Nqzlo5A0PHmVgtO3sJS0I/k+4UKtAk3
 /Rrb+1YSj43N7ioREMhgm5Jpjde10aI0nw1mvXPSH1j/h4aF/VvIUv6NjMYFWsTCzz96w6
 Y1+WTlj7wkYDLUTGI4X1MgyVamLsZlE=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-3-2ZQ43CYsPhefloG4G-0IYw-1; Mon, 03 Nov 2025 16:06:59 -0500
X-MC-Unique: 2ZQ43CYsPhefloG4G-0IYw-1
X-Mimecast-MFC-AGG-ID: 2ZQ43CYsPhefloG4G-0IYw_1762204018
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-892637a3736so1596428985a.1
 for <qemu-devel@nongnu.org>; Mon, 03 Nov 2025 13:06:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1762204018; x=1762808818; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vklKslWLbNtXTg8FTlEZA3hZadv9klpHSH1s6LHPYGo=;
 b=ruvL3B4SuacfhPovDfHyKkWhc6frjQG9q52O1TAdagjYi7nWCyrfGxwE1XU+f39rGn
 MRwL4U6mm2MuodKtY6AAQk5EL0ggeV+JI8G1ZrmhmYl9yQxh7aJAuEz0cKiatgUH65xj
 xBg0PDZyw1S8uIR8O8CDmrMPxqQAeX9UIK0aX7Fd0fAXPJ6XKdeXnDYaX4oXxuoyl3kX
 Zxe7yXaO8kzMlQHudArwGjPbBttCDJN64DhrZ1r1dFMQJe6vs8YLFlc1p7R85L86qmJ7
 5qO+BrSixRQJn+kMFDxWpV3GOvhJzhB0jBk6tHcT2hVKdSYcOWHQvY5kpA9lYBUT7T91
 LJOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762204018; x=1762808818;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vklKslWLbNtXTg8FTlEZA3hZadv9klpHSH1s6LHPYGo=;
 b=V4tlb11FsVtVbs0tZth1eAFi7uwI2Lao7x23+geYI8bOBuePdiqYQLeb2xXyrAshW1
 zrAR7YPWll5Ih7MT60vutJLb/8PPxiuHAYTVtAcZxwbkUoH1OY27HtjH73oiHbvtAlKl
 jMJTssubLP1X3s6KFgG+1P5mqnefwI09QcQJnA8R26gDI6FfrtWY09c2HxiykgwAuMnt
 4/6iaLv/5uSO/TVp1PsMdA41bsZ96VuG4k/OglVBafQMvsMN4wlaS7yvN/KCnyJ4IUm9
 ZpycMnUoECb2/TZP1YL7Y7LkKBdbQiRbg4iUWUw10aO71dp+pa21buzpdZr8DcgGpTnt
 /Ekw==
X-Gm-Message-State: AOJu0YwcUDDsiccNNkMKtpabC4j68vLwDTpS8UpvNleDcNZtfucozqx+
 h4AKRHnyADHZivBF219Bm8dbJI/qUGE3xCuFJehEBlZM1H0XZAHHPxSQWZG9ACHgoeuVka9J9uE
 +QT9VNPq+f9h3SGJ4GhOU40TeFkGtK98oTVgedTtFDYCgk0qGIQ+gZc75xineh41bvbUi5asVf9
 2DB+kIx3aqOqbnTVUYbYKRVrVGkJnuIicEmWLkhw==
X-Gm-Gg: ASbGnculfUZTPikAq+P6soGvD6tBBOb1OXXRM3BLanP501LVCA++OkIGCLnNlBGyP9B
 FpakKfpWZNqIyAhYff+Ev+cnrBKuHubsKyxnQ7rDdB+Nim1gJjmzpu5Rlh5W0N8ItYD73MWaZuy
 PZ0HPd5tiBUQWtpBQZrtZFbETqt5FEndQ1mrGgD3F1J5yo8Pl1dftZjywpfjyWHu0djlCCaj2Vq
 zsIvfR/wKc+QCQDhAO3GF09kdUae0pFkIKmeiFqWSFgoMZo0oIQYV1zqQutiBT5GlvPRtGQJj0Y
 SJtqD+PNzAnRqjlC3hFXXgZjWgv7cR4qBF6csmT07rMYEScLa85bVrRNShZCbn34
X-Received: by 2002:a05:620a:4688:b0:852:9e8:4a02 with SMTP id
 af79cd13be357-8ab9948fb6emr1529288785a.19.1762204018269; 
 Mon, 03 Nov 2025 13:06:58 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHbb4CbHfyXAzKFjXD3Q8aGBNxduSGS2yjvdm4D00l+5Jbz3IRYGa9nk4oeygt4QH8uJSjIVw==
X-Received: by 2002:a05:620a:4688:b0:852:9e8:4a02 with SMTP id
 af79cd13be357-8ab9948fb6emr1529282385a.19.1762204017640; 
 Mon, 03 Nov 2025 13:06:57 -0800 (PST)
Received: from x1.com ([142.188.210.50]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8b0f5468968sm57428185a.19.2025.11.03.13.06.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Nov 2025 13:06:57 -0800 (PST)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, David Hildenbrand <david@redhat.com>,
 peterx@redhat.com, Paolo Bonzini <pbonzini@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: [PULL 20/36] migration: Put Error **errp parameter last
Date: Mon,  3 Nov 2025 16:06:09 -0500
Message-ID: <20251103210625.3689448-21-peterx@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251103210625.3689448-1-peterx@redhat.com>
References: <20251103210625.3689448-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Markus Armbruster <armbru@redhat.com>

qapi/error.h's big comment:

 * - Functions that use Error to report errors have an Error **errp
 *   parameter.  It should be the last parameter, except for functions
 *   taking variable arguments.

is_only_migratable() and add_blockers() have it in the middle.  Clean
them up.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Link: https://lore.kernel.org/r/20251027064503.1074255-4-armbru@redhat.com
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/migration.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index f613b95287..5e74993b46 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1867,7 +1867,7 @@ static bool is_busy(Error **reasonp, Error **errp)
     return false;
 }
 
-static bool is_only_migratable(Error **reasonp, Error **errp, unsigned modes)
+static bool is_only_migratable(Error **reasonp, unsigned modes, Error **errp)
 {
     ERRP_GUARD();
 
@@ -1881,7 +1881,7 @@ static bool is_only_migratable(Error **reasonp, Error **errp, unsigned modes)
     return false;
 }
 
-static int add_blockers(Error **reasonp, Error **errp, unsigned modes)
+static int add_blockers(Error **reasonp, unsigned modes, Error **errp)
 {
     for (MigMode mode = 0; mode < MIG_MODE__MAX; mode++) {
         if (modes & BIT(mode)) {
@@ -1904,12 +1904,12 @@ int migrate_add_blocker_normal(Error **reasonp, Error **errp)
 
 int migrate_add_blocker_modes(Error **reasonp, unsigned modes, Error **errp)
 {
-    if (is_only_migratable(reasonp, errp, modes)) {
+    if (is_only_migratable(reasonp, modes, errp)) {
         return -EACCES;
     } else if (is_busy(reasonp, errp)) {
         return -EBUSY;
     }
-    return add_blockers(reasonp, errp, modes);
+    return add_blockers(reasonp, modes, errp);
 }
 
 int migrate_add_blocker_internal(Error **reasonp, Error **errp)
@@ -1919,7 +1919,7 @@ int migrate_add_blocker_internal(Error **reasonp, Error **errp)
     if (is_busy(reasonp, errp)) {
         return -EBUSY;
     }
-    return add_blockers(reasonp, errp, modes);
+    return add_blockers(reasonp, modes, errp);
 }
 
 void migrate_del_blocker(Error **reasonp)
-- 
2.50.1


