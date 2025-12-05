Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56465D3399E
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Dec 2025 17:21:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vRZUM-0006ru-Qm; Fri, 05 Dec 2025 12:21:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vRZUL-0006pN-KO
 for qemu-devel@nongnu.org; Fri, 05 Dec 2025 12:21:01 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vRZUK-0004Ce-1O
 for qemu-devel@nongnu.org; Fri, 05 Dec 2025 12:21:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764955259;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=KOF81beVfSI9XDipd/Sxi50e7XJpaHzuDPeaWzMbEb0=;
 b=K0CtxkeA34MdBjnRzsPIgmusgmQ05LrkWOmBqWHumNW3xo+ocv6OkW89o32yXz5wi3vj9R
 IG4WBBN1WbEtSjwALDZxGhOzsrLVYnDP726GIFFhDBylDt46xQW+T/v+Cjo8pK32/ZbJOO
 T2dkDaILagbssfvxIgpEQ3SwntFIuG8=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-422-Del4vVvbOJaO-vzePX7nkg-1; Fri, 05 Dec 2025 12:20:57 -0500
X-MC-Unique: Del4vVvbOJaO-vzePX7nkg-1
X-Mimecast-MFC-AGG-ID: Del4vVvbOJaO-vzePX7nkg_1764955257
Received: by mail-yw1-f198.google.com with SMTP id
 00721157ae682-78a8110330aso35588677b3.0
 for <qemu-devel@nongnu.org>; Fri, 05 Dec 2025 09:20:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1764955257; x=1765560057; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=KOF81beVfSI9XDipd/Sxi50e7XJpaHzuDPeaWzMbEb0=;
 b=Mf5rmcGC8E171C/GJpcG8tjd36q3RbHbOsW0tBkorhOcJSpXiUvE5HB4A+Rc4NeDYu
 9HwogRwLGggQL5I3MThyCmcmJxdwBfG8fm1gGjtvHn14/w0VNDWP14J0VuSkhpkaEyeJ
 MazrwEAnAfrjrDKPHYyD2FinpRMO8efO2no5TiI+RVAjxhaSsrORH7iUYQNdxSv4t94j
 FAnpOVTaQA7+8J7XMfT7qOXXB4UM7aaljO8hO6I0mUe5NS674pY9ay0Nn60EyIM0yu5f
 rYT1Aik5e8a8zzdvcC5I8dUFMIeMU/1Xfu6BzyZF5RfBHl6J50uLCQi4Bw9LcqZTT4aj
 76RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764955257; x=1765560057;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KOF81beVfSI9XDipd/Sxi50e7XJpaHzuDPeaWzMbEb0=;
 b=h6iFkZQEeqikhUU7cnBdWyJbu5QPoABmKdU9LRSdWjYlOM4lg/rE/PjHNy8dz0ViOK
 agMmiBDUePfVnk9uEj83zzUg7mThij6RSI90GIM4t/PG46unWHTE0WObaQkX18vfRPDt
 wYKq8Hvua/6D4jRu174PSv+0x47CcnZxDQb8Neb6xoZJQnXfIaMiOOeyRN1WPpjp83xr
 A8Mn34NLT8cF/iUoq27+q93k3ucQCM86V0t0JxJ4Cg/dqDyHtWyJ4HF0j2IlhHvnZ6f9
 vB+YNydrakUthnWI0C9Q5bduruLgOW6YogEGgqh+XaNn/SrQOew1Nm10JTDtYr5zVgxS
 a7iA==
X-Gm-Message-State: AOJu0YwpQQnGKs3bpb47FHWIzsAfoQLyJ/2ANUVJoele2Ut3Bd8aUPZc
 G067Q83gCKatwTjJqdGwAfpUS+uawjFmsbFIL06wIo+J94KEdwdejz+mtm87oGXFQmEknECy0g9
 TIdXgRcT8U1rUZTAHwe8cUB2rDfER7gR0c/i9LfM/qmDAwwRErPUHOefsPjz21BbDt5s+9/2xe2
 xk0CY2K0vmuBNkiK1rBnDxX0XmYpO8BYGgXB+8OA==
X-Gm-Gg: ASbGncsvHjZPSjDGTbhLSVmNp3PgXf3FcahaIuScza5Rs6ykCKarmDbUT7o/5s8QrFb
 rlGKfDY1TMVrBudHC15n/9Kyy8HCHfo/77Wo0CRUOXKZ4NMet3o1iTr2h9pzH+gueiQ5NhLnitC
 6ehJZg7gKX8j4aMSl2LGicMa9wLixg/XljvrLMshxthY5KLZ6VTTaJRyrl82akgQV6BCeFLZlRa
 GjlQc286yjKmyWh9NfV59QeLJagWpBRz50qOP5ePTxzeffdEdFV44ULGJ9acuSlnEFn1bB6Na9k
 25WbPN7cWgBUezzlqhqjbIYlTzfv3eB0+15djJh/tQRP6OIrJukJjRUbi1JkapvUN2z7YLKvg9V
 L
X-Received: by 2002:a53:ac9d:0:b0:643:1a78:4492 with SMTP id
 956f58d0204a3-644370972a9mr6324406d50.81.1764955256799; 
 Fri, 05 Dec 2025 09:20:56 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGyAnX4CqfsVfF4nsI5gHqF8gdgxZacA65Ke4d6TQg5NU4xLed9oUozDCjnEYyjygJ+x7Yxmw==
X-Received: by 2002:a53:ac9d:0:b0:643:1a78:4492 with SMTP id
 956f58d0204a3-644370972a9mr6324383d50.81.1764955256141; 
 Fri, 05 Dec 2025 09:20:56 -0800 (PST)
Received: from x1.com ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 00721157ae682-78c1b78e18fsm18674277b3.40.2025.12.05.09.20.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Dec 2025 09:20:55 -0800 (PST)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, Fabiano Rosas <farosas@suse.de>,
 Juraj Marcin <jmarcin@redhat.com>
Subject: [PATCH] migration/options: Add x-ignore-shared
Date: Fri,  5 Dec 2025 12:20:54 -0500
Message-ID: <20251205172054.288909-1-peterx@redhat.com>
X-Mailer: git-send-email 2.50.1
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

This aids scriptings only.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/options.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/migration/options.c b/migration/options.c
index e78324b80c..30bf9afaf0 100644
--- a/migration/options.c
+++ b/migration/options.c
@@ -203,6 +203,7 @@ const Property migration_properties[] = {
                         MIGRATION_CAPABILITY_SWITCHOVER_ACK),
     DEFINE_PROP_MIG_CAP("x-dirty-limit", MIGRATION_CAPABILITY_DIRTY_LIMIT),
     DEFINE_PROP_MIG_CAP("mapped-ram", MIGRATION_CAPABILITY_MAPPED_RAM),
+    DEFINE_PROP_MIG_CAP("x-ignore-share", MIGRATION_CAPABILITY_X_IGNORE_SHARED),
 };
 const size_t migration_properties_count = ARRAY_SIZE(migration_properties);
 
-- 
2.50.1


