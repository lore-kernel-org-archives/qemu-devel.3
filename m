Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3C69E77180
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2024 16:28:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLPZg-0006gu-90; Wed, 11 Dec 2024 11:28:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tLPZb-0005vc-3c
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 11:28:27 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tLPZY-0000UC-An
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 11:28:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733934502;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bMNv818zenKVONf1gqy04t1JiQM7iMZxJ0aY8hZ0cSo=;
 b=OB7yc/Eg2KlWLRuNOB58bCiQenneF/2zsiCeKgMhNAfdVP1t3l97o8J+vHUtwpnIi1g1oG
 II/AKAQNREN0+zaeRq4d/uqlZDPGbEXD3rv36MOs2Q2knl091uzuC5tjDiM2MOxXPbtgjz
 Mg3hHeJ5tpCYZtcgFgcyS0GMy8T7uKo=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-383-jUWiuBwvP6yEw8SjtPXzGA-1; Wed, 11 Dec 2024 11:28:21 -0500
X-MC-Unique: jUWiuBwvP6yEw8SjtPXzGA-1
X-Mimecast-MFC-AGG-ID: jUWiuBwvP6yEw8SjtPXzGA
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-38629a685fdso2281645f8f.2
 for <qemu-devel@nongnu.org>; Wed, 11 Dec 2024 08:28:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733934498; x=1734539298;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bMNv818zenKVONf1gqy04t1JiQM7iMZxJ0aY8hZ0cSo=;
 b=QbgRbID7wQwW7A/QQIZ1+WKwyDa3MI8FYDKsneWL2gFFMlHQGiGPzCgw1Cv+1ONygf
 peLgRJU4BmqBIepDqhvQTxVnwluECizL0xfbOUC/9WCmAkO2yxVIDshKWdBS8MPawDqt
 h3GIMoTjPqMAoxEf/LLMBlRuame579bb+zYNhS/94hlPi4CGk3GwARxkJ6Yv1aJk2Ixf
 UuOqDASihNFxRveGz7LS4mgX7GHeC9Kn6JXB0LrZOU/RVI/z4ohKqckhM8Mvr/ONotoW
 HSK/DWFVN8PndnHfrmUQCXEcpxbs93HzpgWUSWZPKHrtuNHugtHNzJQz+Onb/K9q5GSV
 fkYw==
X-Gm-Message-State: AOJu0Yxfv4sulBC1K6/VpOm3XW4scQp0ESB3vvu9rHz//vZhaRJU3YmH
 o6IEdkqA1s0a8vYXFvzoyubunuWBuHodPuZPcja0GvrUGMcId/LVL852mUaB/U0cqfZTe201/Sk
 pXKevnoO63KCUXy1doh5INdPrA1mDhADpZfNxfH6v6AFZHxJz3B2S6Nkrt0P19VoGZm3sQYgsU0
 nEo/9bDU6mNBAwKclOH4aFwLCcAbodYQWHDCoC
X-Gm-Gg: ASbGncvqan+ATFk+B/jy4GkbbJe+vlyAP/lZiPatQ6PzzCAspRKkrjB6EwO2nhh2Sms
 Q+7K5NzWJzdGdmPCtETrR0z4SIiN8khpF405+JHQM0NwjzMypjlxT7gAdc8cQ2KjjZZzKFkCbJk
 IbUD187bhdNIn1F9Fc8ZDhUfVGbES6x61QOvf5SVWvDTzRpMrmgZAU0lKVau428CVZzgBvct6GK
 XqGDoGPizUI0bYSEgUZJ4lk/xYR8zNCsxFz5qLamO4/UmHtaP2+PqaD
X-Received: by 2002:a05:6000:1788:b0:385:f3fb:46aa with SMTP id
 ffacd0b85a97d-3864ce98548mr3374575f8f.43.1733934498435; 
 Wed, 11 Dec 2024 08:28:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEEojMbeZara4Y3arn7jlKvJ4yaL8Hv5d6W4fvlWcZX6EOBhakXlzgGIkFA3FSQlwtBftXElA==
X-Received: by 2002:a05:6000:1788:b0:385:f3fb:46aa with SMTP id
 ffacd0b85a97d-3864ce98548mr3374549f8f.43.1733934498042; 
 Wed, 11 Dec 2024 08:28:18 -0800 (PST)
Received: from [192.168.10.3] ([151.81.118.45])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38782514e54sm1641825f8f.85.2024.12.11.08.28.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Dec 2024 08:28:16 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 23/49] hw/rtc: Replace type_register() with
 type_register_static()
Date: Wed, 11 Dec 2024 17:26:53 +0100
Message-ID: <20241211162720.320070-24-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241211162720.320070-1-pbonzini@redhat.com>
References: <20241211162720.320070-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.472,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

From: Zhao Liu <zhao1.liu@intel.com>

Replace type_register() with type_register_static() because
type_register() will be deprecated.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Link: https://lore.kernel.org/r/20241029085934.2799066-6-zhao1.liu@intel.com
---
 hw/rtc/m48t59-isa.c | 2 +-
 hw/rtc/m48t59.c     | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/rtc/m48t59-isa.c b/hw/rtc/m48t59-isa.c
index 6e9723fdf19..b642b82680d 100644
--- a/hw/rtc/m48t59-isa.c
+++ b/hw/rtc/m48t59-isa.c
@@ -161,7 +161,7 @@ static void m48t59_isa_register_types(void)
     for (i = 0; i < ARRAY_SIZE(m48txx_isa_info); i++) {
         isa_type_info.name = m48txx_isa_info[i].bus_name;
         isa_type_info.class_data = &m48txx_isa_info[i];
-        type_register(&isa_type_info);
+        type_register_static(&isa_type_info);
     }
 }
 
diff --git a/hw/rtc/m48t59.c b/hw/rtc/m48t59.c
index 48846d8df40..90299ea56fe 100644
--- a/hw/rtc/m48t59.c
+++ b/hw/rtc/m48t59.c
@@ -679,7 +679,7 @@ static void m48t59_register_types(void)
     for (i = 0; i < ARRAY_SIZE(m48txx_sysbus_info); i++) {
         sysbus_type_info.name = m48txx_sysbus_info[i].bus_name;
         sysbus_type_info.class_data = &m48txx_sysbus_info[i];
-        type_register(&sysbus_type_info);
+        type_register_static(&sysbus_type_info);
     }
 }
 
-- 
2.47.1


