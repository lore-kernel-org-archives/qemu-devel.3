Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D2ACE7718A
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2024 08:35:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOBxa-0004RO-Ra; Thu, 19 Dec 2024 03:32:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tOBxW-0004Qi-8v
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 03:32:38 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tOBxU-00053M-HG
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 03:32:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734597155;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sjB2VJ8djP/uFaRO5FuiFnPqLl7LJ/cFgV1DnxC9eUY=;
 b=Nvw2UHmj5UHtR/Xh9h6+m2PqivEl7xqqGkqnPTHWyquwWMaFCwYlIMSc5u/TqXvCe6itgF
 n5K05N0wQdS2fA23P5nQU1nueuJIx0F+Qsiq8U1X2pQztA7OvwmyBikS52NOi4r6o0JnZr
 Wrw3fKGvOzY9GML8xQ6uVgj/vkDTY1g=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-661-e8rJJAk8MI-2bHMw6O634w-1; Thu, 19 Dec 2024 03:32:33 -0500
X-MC-Unique: e8rJJAk8MI-2bHMw6O634w-1
X-Mimecast-MFC-AGG-ID: e8rJJAk8MI-2bHMw6O634w
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4361c040ba8so3020875e9.1
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2024 00:32:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734597151; x=1735201951;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sjB2VJ8djP/uFaRO5FuiFnPqLl7LJ/cFgV1DnxC9eUY=;
 b=VqiquPmTogf9kU9Xigt9UfCVIZNoetp5Na6bOnEHizqpKIdTBYRzpUPP3hrjHJO4qK
 A/8c4WO9JtHqor+k13qu3nQqSXkw+lfGlb4kiSXq8a9AbVVUkvrdSaW/r+oRI+zPPi56
 hKGo7jVB4hT0DkeXYB0clLaOOFnUB13zdxkM3U/XE0zz7u6SJGmxix+6YctU/5fhfw2Q
 pWh3AKpQCXb6VYosH7D52DIHn0XAPLlT3bpM42vXvtwCryhEFLcQB4iWTEB4i2nPpQR1
 nFDBgKVxSrGBahi5toeYhONSski/c2ec3bZqHTgelZWUjoGhnOwRoSZJVF06Kxt1wAvE
 geNw==
X-Gm-Message-State: AOJu0YyNAAt2t+ZyJ2aSnzg6MJrHtviITSVXsdbnnKnDdtPDu+Di1HJk
 c28SMNhIdCGx6m7kDZ3/2C+veh80ciX6XGcnudQdj30J8c+cTKz1q64DJD3B0biNU895Xyr+jjT
 do6EALFKHcRXBRLwGFmH3/T+D7+RO2CTyeSfGnRxXjrWaAeKcW0D7L8vDn5VzCgLeBo8B/2fS+J
 /MZxyvOy6XiCoVM9B3+7dF1Qp6B1HltN/fFIkU
X-Gm-Gg: ASbGncuJ0fz56IghTstfEHEkNuDHxL1AuUeHdSb/OzkGThjsOJdnb1bwMb/R7ESPh39
 xj5PbAofgDyQCRyQNmrKXsndmnfK9zwmAhD1ehDndUlZUq2VlkloV0pkqPcOIIjuYHDNy6FyR5r
 5ESq5+F1HF0mlXze14RKz2qrkqsOqYFvfjWnk02LV+JMXOwO4SGLTE7dnLKBmiOypE1vUllyHEv
 8/crbUD8LrACpu0s3FDC6atBy7GdTsEcxi/A+gMINvkvce0mbJJWNyMRSmd
X-Received: by 2002:a5d:6c65:0:b0:385:fb2c:6021 with SMTP id
 ffacd0b85a97d-38a19b37343mr2227542f8f.39.1734597151605; 
 Thu, 19 Dec 2024 00:32:31 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEKIo5mU6U86hdFDV7SM7Z/zTRYu1hfJUrxxaNDsPhniKvo5ox08Jqd5wHtGCZ28GbnZYxUuA==
X-Received: by 2002:a5d:6c65:0:b0:385:fb2c:6021 with SMTP id
 ffacd0b85a97d-38a19b37343mr2227513f8f.39.1734597151192; 
 Thu, 19 Dec 2024 00:32:31 -0800 (PST)
Received: from [192.168.10.47] ([151.81.118.45])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4365c08afcbsm21964005e9.21.2024.12.19.00.32.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Dec 2024 00:32:30 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 01/41] migration: Constify migration_properties
Date: Thu, 19 Dec 2024 09:31:48 +0100
Message-ID: <20241219083228.363430-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241219083228.363430-1-pbonzini@redhat.com>
References: <20241219083228.363430-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.116,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

From: Richard Henderson <richard.henderson@linaro.org>

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Link: https://lore.kernel.org/r/20241216035109.3486070-2-richard.henderson@linaro.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 migration/options.h | 2 +-
 migration/options.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/migration/options.h b/migration/options.h
index 79084eed0dd..a360f93a44f 100644
--- a/migration/options.h
+++ b/migration/options.h
@@ -20,7 +20,7 @@
 
 /* migration properties */
 
-extern Property migration_properties[];
+extern const Property migration_properties[];
 
 /* capabilities */
 
diff --git a/migration/options.c b/migration/options.c
index ad8d6989a80..24cc8471aa0 100644
--- a/migration/options.c
+++ b/migration/options.c
@@ -85,7 +85,7 @@
 #define DEFAULT_MIGRATE_VCPU_DIRTY_LIMIT_PERIOD     1000    /* milliseconds */
 #define DEFAULT_MIGRATE_VCPU_DIRTY_LIMIT            1       /* MB/s */
 
-Property migration_properties[] = {
+const Property migration_properties[] = {
     DEFINE_PROP_BOOL("store-global-state", MigrationState,
                      store_global_state, true),
     DEFINE_PROP_BOOL("send-configuration", MigrationState,
-- 
2.47.1


