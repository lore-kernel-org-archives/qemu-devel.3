Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C07FCAC58E
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Sep 2025 21:25:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uwomF-0002ij-2j; Thu, 11 Sep 2025 17:24:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uwom9-0002hz-N8
 for qemu-devel@nongnu.org; Thu, 11 Sep 2025 17:24:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uwom7-0008Qe-P6
 for qemu-devel@nongnu.org; Thu, 11 Sep 2025 17:24:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757625853;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sN2ewjYKseHzqoQc0ThzSP1uQrVGcryEZdT1qKjYcXk=;
 b=HdxnTgh9VIaeIRfzdlX0lPPweQZGgfT/CzaVSU3p+/7URsufXatQ4cZsgEE40pMaWX3lwW
 vnlxTLN9J8KY217C4OFsy5LBlgJgcKxxMp2qtJWiyXLjLYnv1HUscZemQEl5AXop2d2ZuL
 Htiid+ayxLDpKNTF7iYC1ggiohQAufk=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-507-BuCLUof8PbGLrPL9OkXUAg-1; Thu, 11 Sep 2025 17:24:12 -0400
X-MC-Unique: BuCLUof8PbGLrPL9OkXUAg-1
X-Mimecast-MFC-AGG-ID: BuCLUof8PbGLrPL9OkXUAg_1757625852
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-812ae9acaecso286244285a.1
 for <qemu-devel@nongnu.org>; Thu, 11 Sep 2025 14:24:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757625852; x=1758230652;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sN2ewjYKseHzqoQc0ThzSP1uQrVGcryEZdT1qKjYcXk=;
 b=XdjC08IpcFi7eF7HG9TLIySYH8FR+91IDCJ3+TGFAVPPMeVIx7Pq5cyB47/MdSMOg5
 A6oQQlcYtOCBaBJoB7BvDSdb76Pt+CC6/N7v5IOv4SjrvD8Mf3PbzRv4cdzt0dxYr8eB
 s1kUAwHMl98FlMcXjQzH2DToJFH8D5BWfS2F1UKzSQk2CKv8QqQrCDC3KiiE14Iw9Bj9
 41/NsS4wEKOSE6L29Mo9Mv1X6KnDaa5m45jPGd9BzhjKwhS45BniT4pWKSTnVV4hXd0g
 GgnJ+4Yhspi3MhLuyVOS0t/CD+jco/cJxZHDN8ceoGK4irSOFnDPK7Bxc0xRXIuPntum
 x6kw==
X-Gm-Message-State: AOJu0YyJNx/ZFfZLk8/36JYbjIriZk5jiP2xaQQAIdoO/ZSGr4jjkpAs
 Yu++QLr9WqfPS9jTq7pFKzfloOCdnl6GDj7NnN2u03Wr9VhWKEMdylejqNFxWjuYqUwe1oDt4jF
 Pdl2fwuFl89jrdeOj7DXXK76NnsZKk9qU7rJoMPaVePcNBBauW7kJlZnn06Vu56O6xon4wVbmGc
 j0C+FeW+1Ea9WxtVD/X+RD8f61x/mb2FhDF8kHuw==
X-Gm-Gg: ASbGncuHv8Gms6H1csGDV3thqU+Lf+mOUSDQ+6AYtyhftuy1E1U+9NPCcVHVTYGaFxf
 ovLwfM/91jJ7zpYCevT03RoI50EoOdIuJ8cEqGwQaB4OdphiAtWm1yIk1ELLf2XuNGigSVqpRHq
 /dP89/ai5yo9XBykRkN5jeEMa+Iqq5GLsmO6gy5EA1DAHtKTR8w8nsGFzGVocq7fK4qL7ioUCKz
 ViMKVPiXlKVudxY3gs1sA0LmZSQy9pfnF37F90s6TD7WdD6KkJltcsV6GXhPIdO0h3UY6EoKacg
 6K3OVFmY/g5dcZnMy1QZC1UZM7sXUw==
X-Received: by 2002:a05:620a:280b:b0:81f:eb9f:a04c with SMTP id
 af79cd13be357-8240253e58bmr116797385a.54.1757625851514; 
 Thu, 11 Sep 2025 14:24:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEVPd7JCuLDVwwMIoqATnOsV2K6NWcg5uP0bIcBZQGMOgv9WwJq+C+17710a0bbtog4WK98nQ==
X-Received: by 2002:a05:620a:280b:b0:81f:eb9f:a04c with SMTP id
 af79cd13be357-8240253e58bmr116794185a.54.1757625850993; 
 Thu, 11 Sep 2025 14:24:10 -0700 (PDT)
Received: from x1.com ([174.89.135.121]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-820c9845c47sm166032285a.28.2025.09.11.14.24.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Sep 2025 14:24:10 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Juraj Marcin <jmarcin@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 peterx@redhat.com, Fabiano Rosas <farosas@suse.de>
Subject: [PATCH v2 3/3] migration: Make migration_has_failed() work even for
 CANCELLING
Date: Thu, 11 Sep 2025 17:23:55 -0400
Message-ID: <20250911212355.1943494-4-peterx@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250911212355.1943494-1-peterx@redhat.com>
References: <20250911212355.1943494-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

No issue I hit, the change is only from code observation when I am looking
at a TLS premature termination issue.

We set CANCELLED very late, it means migration_has_failed() may not work
correctly if it's invoked before updating CANCELLING to CANCELLED.

Allow that state will make migration_has_failed() working as expected even
if it's invoked slightly earlier.

One current user is the multifd code for the TLS graceful termination,
where it's before updating to CANCELLED.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/migration.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/migration/migration.c b/migration/migration.c
index 10c216d25d..f6f6a6e202 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1702,7 +1702,8 @@ int migration_call_notifiers(MigrationState *s, MigrationEventType type,
 
 bool migration_has_failed(MigrationState *s)
 {
-    return (s->state == MIGRATION_STATUS_CANCELLED ||
+    return (s->state == MIGRATION_STATUS_CANCELLING ||
+            s->state == MIGRATION_STATUS_CANCELLED ||
             s->state == MIGRATION_STATUS_FAILED);
 }
 
-- 
2.50.1


