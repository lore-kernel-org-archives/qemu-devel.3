Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBF8CC021BE
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2025 12:51:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tndLD-0002hx-5g; Thu, 27 Feb 2025 07:50:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tndLB-0002ee-Kv
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 07:50:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tndL9-0003S0-RP
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 07:50:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740660609;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=+y1CAWlbXS/yQQoLXLdLJ8pPYhQS3v760bQVf6N4EuQ=;
 b=bxS9pweQVngCoVyD0itP04dbrvyTcK7eF28fc+o/kQYSpZk97Mrvv1TRTwc5nwL6HMAoQt
 6pvuzSMhi7IQMqp8kEs9kNUOHpTJ2tymvorEmgzey63+diXxqje9831W2/O1XkqIS4TE8P
 5caD3f1TKGhElqzlNVHmEkP8urXbtwU=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-22-EKBk6b9INZ2BYvw8MRZlsg-1; Thu, 27 Feb 2025 07:50:07 -0500
X-MC-Unique: EKBk6b9INZ2BYvw8MRZlsg-1
X-Mimecast-MFC-AGG-ID: EKBk6b9INZ2BYvw8MRZlsg_1740660607
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-abb86503062so107458066b.2
 for <qemu-devel@nongnu.org>; Thu, 27 Feb 2025 04:50:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740660606; x=1741265406;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+y1CAWlbXS/yQQoLXLdLJ8pPYhQS3v760bQVf6N4EuQ=;
 b=DVpGR/gG+vPwKGl9/Gijq+J/QpZgOL71yG4Z+nRoSzaSGrxjxOgLehZ628bXlJkFf3
 kDTEMV783mEkJdAkTErlOchvQjpHZn6qaIJArHMbI35cdVhLf4w2OS/H665lQRo2mkQm
 0fQsuuoBy1s7LcwQG75Nk4os/7amURu0yZ7rZ5wS2szl3AyuX0zn4ElRUViNR8RWmbu6
 pQzrYZFn2A+g5tg6l9e2kFhJTjGANo3weiYQ8E4wgyft0xP7TOIUAhH4As6MnARTAXlg
 gyrig+NFI7poYHW1aZfTQiOgpUBlBmR4zNMZMbjmoSedLfFHCjRf57SeivM32ldNP/y0
 Q2Ow==
X-Gm-Message-State: AOJu0YzQ27n0f9At+rHetINxEZSAsCw5KwpNH/2LdtTLaGbf9YcStsUi
 GFfb5mOf1YaMTnD7b7KNFocH8FbsenKTRKkT0UCoijrK2saKz6KOYL0w+fQUKXfmC6Yt2MOQIzM
 J7nTh1XjnM6W32kKa+pVDAlyZsZt3w09r17NqQ4C65nFUZLTAv4JfBmTSgmaV35/TfgmRh0lCPY
 K00gZsHP7m5bZwq6ZSbiabjZwg91CZU9/hA/CuIH8=
X-Gm-Gg: ASbGncvT0d0XspzDKFXOm8sy3AWVT0iJNHVDxG6A5cQhZ9STHJL7xr5o+quyKZ39C1v
 UpEp+QHjz69ESnXnrKtkIjDt9xe2PaNx/u7raJ6BskL27dqCaKiYcDaGZsT3jFn9TrfglvPVtte
 UjPHtHUdW49nz7c61BPbX3a/BgLUdtPZNWlrE4q5ntb8nn31lGwh0rNSQz4lII2H3OQbZs8Tv1Q
 ei51T0645tsUS45lCSJ0ESefp4cMAPITglWQZ5CboN219hJuE9WQACfNVPOrxFVD9lrG4QfBH9G
 gRqCeKTv68SllZ3M6kXt
X-Received: by 2002:a17:907:9722:b0:abc:7d6:e445 with SMTP id
 a640c23a62f3a-abeeef835f5mr941036666b.54.1740660606100; 
 Thu, 27 Feb 2025 04:50:06 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHmn/vdcGfClMzNZee9ukOE0OqIYpC9/9RJm43CzNtUtpYuU8RwIJSpjc4XHwnsOZdzqnuujw==
X-Received: by 2002:a17:907:9722:b0:abc:7d6:e445 with SMTP id
 a640c23a62f3a-abeeef835f5mr941033866b.54.1740660605656; 
 Thu, 27 Feb 2025 04:50:05 -0800 (PST)
Received: from [192.168.10.48] ([176.206.102.52])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-abf0c7c18a3sm116207666b.185.2025.02.27.04.50.04
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Feb 2025 04:50:05 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] chardev: express dependency on io/
Date: Thu, 27 Feb 2025 13:50:03 +0100
Message-ID: <20250227125003.770661-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.438,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

chardev is using qio functions, so express that in the Meson internal
dependency.  (I found this when adding character devices bindings for
Rust; they initially needed the io dependency added by hand).

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 meson.build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/meson.build b/meson.build
index 0a2c61d2bfa..9b1c0ba6346 100644
--- a/meson.build
+++ b/meson.build
@@ -4013,7 +4013,7 @@ libchardev = static_library('chardev', chardev_ss.sources() + genh,
                             build_by_default: false)
 
 chardev = declare_dependency(objects: libchardev.extract_all_objects(recursive: false),
-                             dependencies: chardev_ss.dependencies())
+                             dependencies: [chardev_ss.dependencies(), io])
 
 hwcore_ss = hwcore_ss.apply({})
 libhwcore = static_library('hwcore', sources: hwcore_ss.sources() + genh,
-- 
2.48.1


