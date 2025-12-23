Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56ED5E6F095
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Dec 2025 14:34:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vY3Q7-0002qV-HT; Tue, 23 Dec 2025 09:31:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vY3PB-00016f-MO
 for qemu-devel@nongnu.org; Tue, 23 Dec 2025 09:30:34 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vY3P8-0003lw-02
 for qemu-devel@nongnu.org; Tue, 23 Dec 2025 09:30:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1766500224;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6TWzMHm7Js1si41Vstj0CSEhsHDy04wZuQci0sb4Jyc=;
 b=XGIXeMrNhL5xEtMtFx4cciXR8u5KtQ5G9y2G2J+DWF3tfgScL54aQ8MeVxBQ6h0tDBvzYr
 VHy9uCKuKmfAcUbQDqN5jQYcz5Fjf2bkMtwKfmoOKZAy0ccKObT30zEM42B3djUSD7uDdc
 fiDkL1rO4BRMAef7wGW1TPwBNYzxyGM=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-652-zAgFMv7gNJuDSL_sQjE27w-1; Tue, 23 Dec 2025 09:30:22 -0500
X-MC-Unique: zAgFMv7gNJuDSL_sQjE27w-1
X-Mimecast-MFC-AGG-ID: zAgFMv7gNJuDSL_sQjE27w_1766500222
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-8b2e9b2608dso1038241185a.3
 for <qemu-devel@nongnu.org>; Tue, 23 Dec 2025 06:30:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1766500222; x=1767105022; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6TWzMHm7Js1si41Vstj0CSEhsHDy04wZuQci0sb4Jyc=;
 b=eTlak3Q1r48gE8qPpJ/yIZAbA2hDqb1DbFa7h3rxKOus1OXPvW/6CuMBIIuctaUxVh
 4hL6TdKI4Cq877c2A4sCoOozrd46X5TlJPkeordXpSJ7rV5nnwLl5oB3fLo5MDQpIG1D
 VfNt4/bhF//qgTH2de90u3dvhiOtQkdIDvJ3y5v65O3ZLIbMlnQ1ZifehG75mGgqtZ2Q
 W13L5EB2j3LuvIoZkIu5IkyP1jQSGf3U3Il7+ox31LUV66yBGKZarfdHbUe5eEz1geXU
 0D9iJMUb4M2OhHMkiDN/6hrWHv2ZrJ8NwJJ0GjfpGtoazH6W7PkKJlGpTpi3LVfqRphq
 iZSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766500222; x=1767105022;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=6TWzMHm7Js1si41Vstj0CSEhsHDy04wZuQci0sb4Jyc=;
 b=dywPnW7osmo/lZ7MtJA2gfAW5zu4yLPrdVTntLUhU4c9U9Go6x7jyhRxj73+Az80r6
 VbEwowUluwos/osKmb1CSmxlCnxkvoGN1MIG+uq12M7JuN0zubijmhobAdsHLbaJJoWm
 DOgMF3I+2tWo6tOmXl2fDmkzn9ujXBc/Rd2uiiuMxgqyvxH5mYCQKyWnmdIXuCuLt/xF
 Nxw/NKD5ZShhnzqWZMbSIceGE30owiFJFQoJiCJRulGPcj+0pJQRO1bQzgIIaH4EuVm5
 ohBVZrP8rBRlTZOa8qu2do+Bd9EabGfNJCJtpNKfhGiaHpQCHIO7Y8Gyhdw/HufUUquw
 Bk5w==
X-Gm-Message-State: AOJu0YyPXXA5AiUS7FjhklzYt9OCHJWYnNQFZPe3arEfny8LYYLY3dyC
 taRRUN7RZeEr+UFmylQZWmq0PjvZ7uqSEH70ii0bFBB24/qvT5oeu4vf8Z9kH1FaYQpcyieQzd2
 ml1UZgzGc+mpiA6kBfhhvGVC5zENxLgQ192uiH9gG0rZtVv/K5gu1lb0YPIj2LccRgRyYVK9fPd
 dUD6pbyTWhvjP+GaTrq+ZZftX8U08nCsDoEiJOGw==
X-Gm-Gg: AY/fxX4tlOKGabYjE5ZsKVuOPjJUNB5o7ZPBKntGyTdtUCdE2E22kQ2rikwmZwmzjNA
 jvGI0YB4Lxe87L3Lx0C8wAlvsVoXXVXK+T7v00a9jZjl5eY5/b6jd0XEizXQfmX9UNUZau3GdtE
 5ZIvBDLbL/6+m8HqbHXMZRvcyEZBZMQbF0nmzwLX7GMRsStwOWQXnGDpqA3ZFtAPfWzwCV/ksic
 7gYvaFdym+kez//WaDAHsoT4Ada521zXAnSAsV/7UYNjqnjOVW95gYGi2fsU5H0T1yvqgsRIvHv
 RWEz2r6ORdIQdtJALSFh7i7aYoY2m0/CPP39/JZuAlpiYVIIwgxu2jAdRXRXIDOUSW+XxwjWRvA
 3MCs=
X-Received: by 2002:a05:620a:44c5:b0:8a4:e7f6:bf57 with SMTP id
 af79cd13be357-8c08fbc6b6dmr2378858985a.5.1766500221614; 
 Tue, 23 Dec 2025 06:30:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGlDe02Y0jcMIIq0n2zKXgm1VazNKIAt1tPzrBCJWHZBoBaRzcP6Ze83uNqgL1U6tajKyNn2w==
X-Received: by 2002:a05:620a:44c5:b0:8a4:e7f6:bf57 with SMTP id
 af79cd13be357-8c08fbc6b6dmr2378849485a.5.1766500220926; 
 Tue, 23 Dec 2025 06:30:20 -0800 (PST)
Received: from x1.local ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8c096787536sm1096163285a.4.2025.12.23.06.30.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Dec 2025 06:30:20 -0800 (PST)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>,
	Peter Xu <peterx@redhat.com>
Subject: [PULL 16/31] migration: Fix leak of cpr_exec_command
Date: Tue, 23 Dec 2025 09:29:44 -0500
Message-ID: <20251223142959.1460293-17-peterx@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251223142959.1460293-1-peterx@redhat.com>
References: <20251223142959.1460293-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

From: Fabiano Rosas <farosas@suse.de>

Signed-off-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Peter Xu <peterx@redhat.com>
Link: https://lore.kernel.org/r/20251215220041.12657-3-farosas@suse.de
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/migration.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/migration/migration.c b/migration/migration.c
index 1ff728b6a2..f1378c3bf4 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -4140,6 +4140,7 @@ static void migration_instance_finalize(Object *obj)
     MigrationState *ms = MIGRATION_OBJ(obj);
 
     qapi_free_BitmapMigrationNodeAliasList(ms->parameters.block_bitmap_mapping);
+    qapi_free_strList(ms->parameters.cpr_exec_command);
     qemu_mutex_destroy(&ms->error_mutex);
     qemu_mutex_destroy(&ms->qemu_file_lock);
     qemu_sem_destroy(&ms->wait_unplug_sem);
-- 
2.50.1


