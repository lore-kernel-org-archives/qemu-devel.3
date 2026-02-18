Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B3A3E9A047
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Feb 2026 11:46:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vsfzG-0005jo-EE; Wed, 18 Feb 2026 06:44:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vsfz3-0004WV-6j
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 06:44:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vsfz0-0000GS-3v
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 06:44:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771415073;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=igOnGXXgq3eDAiSjsSp69SbZ2aYSYQJQPNazxijENj8=;
 b=SlBIpqtA8j6i1RxQv5BYjbtI8z2MCcFzFoMFjfzE4AOREfT7Dx0FpM/oP5tinV7geZFHH2
 +F6+nxoa2qKl4c3AwZ9camy86peSV4MIyV6B8HWhEy1bVjDpveaYM6/Qf91SfmkYzX9neb
 1QiCdYiISxhbG7J8won0wLQ8pDUjD6k=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-684-Xu-bK31bNL6PIHJFJmUCpQ-1; Wed, 18 Feb 2026 06:44:32 -0500
X-MC-Unique: Xu-bK31bNL6PIHJFJmUCpQ-1
X-Mimecast-MFC-AGG-ID: Xu-bK31bNL6PIHJFJmUCpQ_1771415072
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2a76f2d7744so57571955ad.3
 for <qemu-devel@nongnu.org>; Wed, 18 Feb 2026 03:44:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1771415072; x=1772019872; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=igOnGXXgq3eDAiSjsSp69SbZ2aYSYQJQPNazxijENj8=;
 b=bNJY+G/JXmM7pl4oP/jG/dTPwiO0krF8wHwiN4+pog4Une0f7XqrgPFr2WDHF7/Zr9
 aWFIhnJp7pIRCHYkEFr639j7exGZRMTl6AbYIPQTtCP+yA3Otv1zF9dZro13paSlBCi2
 cCH5QkNMlfPO6K5c66uYxM7/D3doSu5JdSwId8eEVQq9XHRrKiNOzWnNhzSqUM+WeBMK
 +/pTpTpmghWfEE/UGBJWVAZCqhFzBaB/ynT367NL05U26dB4b5YR5YTUoZ/LDP/TMh0B
 o3p50zKvesuLgwAs1MivdD/QYH/XHNipg06KW7jJ285T7v6UCJdrrNaSxxpfOAPJhqYY
 yLqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771415072; x=1772019872;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=igOnGXXgq3eDAiSjsSp69SbZ2aYSYQJQPNazxijENj8=;
 b=ISTYYKl9kQnSEQnJ3MyluKu4sqPs17ggLpB3/tuNXbZwqtUssgcyTyxUaLyXwqKnWP
 NHwy/wxzDO3AFRC3WZoTlH2ISmFsg8H4chfbMdEIpyAbTxYd+XBe+6ykObOHLUQHwM+j
 edYUy2i6QiDsfpMiRnNZbA04Ze4YL3eoZhRz3FyPtBWiCwapZxlP8nUZo0Pbw6AYN2Cg
 4+Gz6kFOOjheBepuhEJyBVjgGH34MaHFkkIf3UV5Afv+/OwOrffLJ/YokkjKmNmElTS7
 3and8fqz3k8Wj6a4vKPCdPWSkVn4KWN+QkxiyZXZ9WVTVbrT+ktzl/LrfF9kObCLgQ/a
 5nxQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX8q4JXDi/BMNowa2rtLFlChOA8IeJLkY3SvfmBIK9FeJwnog+U/plhHKT6wBol9ucZaC1pt+76pUEN@nongnu.org
X-Gm-Message-State: AOJu0YzfMrabAQYNixyfvyUBzmJ61umBu7Gm2KgtxykC4HHLlgFhQOGZ
 D48Uset7DSjedQvZ4ksURzTDM5o8ge+yYFgoVmNx9jHIJVhnVjxMaHddA+Rer5EJxO4pqN9Zuyp
 7vRwIxmyaA1IJtU0izp61BvKcCvR/p+kgdLV/Dpe+ORF06a6a9xCiF6Hf
X-Gm-Gg: AZuq6aJVGjrI04YRwsYrpSiM0J73IhwokVTIqOUVvIMsfNi+X5TjhcEoPL1nc1RHFcm
 cgUEDvrATfdvWGxAczseR4GT2sev9OwwapxZLKc6ss83jXDagJt0Cq6F7xx8IS5fLjHeRJy1G8m
 Kl+M66vr2PhwknWy5xFQk1Ohh3V04qBcMdlbUq20CRkfYGldEFmuzHIUqcWoicWbPKqULniiekc
 q5ehkLmfPWrIzl7HAIv8j1D4gadDiJc96n7ppIy4uf/rANux9HsZ9A49aYAplfnT79mJ0av59rJ
 j4k34oXtr1zDL+n8MfHcdWhaWP8OdttYmnarhK11r4TXogrNPSDaen3sUOUFB371hHPf42Ssv0J
 YFvZxTDEtPW2EBv0yMgys3fsUcW/uqadDjnqXmnZl89KIA3YAX2Dj
X-Received: by 2002:a17:903:38c3:b0:2a0:bb05:df55 with SMTP id
 d9443c01a7336-2ad50ec19f4mr17451675ad.21.1771415071624; 
 Wed, 18 Feb 2026 03:44:31 -0800 (PST)
X-Received: by 2002:a17:903:38c3:b0:2a0:bb05:df55 with SMTP id
 d9443c01a7336-2ad50ec19f4mr17451485ad.21.1771415071261; 
 Wed, 18 Feb 2026 03:44:31 -0800 (PST)
Received: from rhel9-box.lan ([117.99.83.54])
 by smtp.googlemail.com with ESMTPSA id
 d9443c01a7336-2ad1aaeab38sm127803425ad.82.2026.02.18.03.44.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Feb 2026 03:44:31 -0800 (PST)
From: Ani Sinha <anisinha@redhat.com>
To: Peter Xu <peterx@redhat.com>,
	Fabiano Rosas <farosas@suse.de>
Cc: Ani Sinha <anisinha@redhat.com>, kraxel@redhat.com,
 Prasad Pandit <pjp@fedoraproject.org>, qemu-devel@nongnu.org
Subject: [PATCH v5 34/34] migration: return EEXIST when trying to add the same
 migration blocker
Date: Wed, 18 Feb 2026 17:12:27 +0530
Message-ID: <20260218114233.266178-35-anisinha@redhat.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20260218114233.266178-1-anisinha@redhat.com>
References: <20260218114233.266178-1-anisinha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.043,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Currently the code that adds a migration blocker does not check if the same
blocker already exists. Return an EEXIST error code if there is an attempt to
add the same migration blocker again. This way the same migration blocker will
not get added twice.

Suggested-by: Prasad Pandit <pjp@fedoraproject.org>
Signed-off-by: Ani Sinha <anisinha@redhat.com>
---
 migration/migration.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/migration/migration.c b/migration/migration.c
index b103a82fc0..495664e01a 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1696,6 +1696,10 @@ static int add_blockers(Error **reasonp, unsigned modes, Error **errp)
 {
     for (MigMode mode = 0; mode < MIG_MODE__MAX; mode++) {
         if (modes & BIT(mode)) {
+            if (g_slist_index(migration_blockers[mode],
+                                 *reasonp) >= 0) {
+                return -EEXIST;
+            }
             migration_blockers[mode] = g_slist_prepend(migration_blockers[mode],
                                                        *reasonp);
         }
-- 
2.42.0


