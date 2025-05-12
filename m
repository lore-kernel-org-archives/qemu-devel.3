Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 562DBC3ABC3
	for <qemu-devel@archiver.kernel.org>; Mon, 12 May 2025 19:06:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEYT8-0005Rd-92; Mon, 12 May 2025 15:05:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uEYT6-0005R7-FT
 for qemu-devel@nongnu.org; Mon, 12 May 2025 15:05:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uEYT1-0007U8-Bx
 for qemu-devel@nongnu.org; Mon, 12 May 2025 15:05:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747076734;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6ljvXYz3Ammv9IyTNCcBI9y3hT6/YYDHfD78BUikWg4=;
 b=Kttov9wuB/QuHojRn18DIQN7lzzdWHOqVAdkF64bqWLUSh2jCeMJvV02jYj2ReKdy4JuCu
 YntlLJ7N5r/7o/vsvYyd68RqC6U8cQ2OsBGYDyhjUnKkPUJB8+oIXr4iKPrAcNz3LgKoxG
 rw3xSwOHnrPHnCuakivj96DQpOGoOR8=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-357-UIJ6T0w5P2e8NwBxJ3-Btg-1; Mon, 12 May 2025 15:05:33 -0400
X-MC-Unique: UIJ6T0w5P2e8NwBxJ3-Btg-1
X-Mimecast-MFC-AGG-ID: UIJ6T0w5P2e8NwBxJ3-Btg_1747076732
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3a0b7120290so2131918f8f.2
 for <qemu-devel@nongnu.org>; Mon, 12 May 2025 12:05:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747076731; x=1747681531;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6ljvXYz3Ammv9IyTNCcBI9y3hT6/YYDHfD78BUikWg4=;
 b=Qn5l55g4kCEIauFKwdaNUZ6aL+k+fbBN5rRsGZ99PmYpumf4Mdw5+40y6cYCzxrlaN
 L+b36kiPWFn3KiYKbf7pEq77KKqqGjj6Vnt56bYLRKSkUnb462u+oTubHcv3o3lttmkX
 3zJ4ESCOvDzYaANIm+XFoS5nwPDixK0OG9rKz6++LX5KoKfmWD6bsrZWAzmK0oHgbN+U
 nAhL591rVVla2lqeQ2Z2GLbbHeQ2zS+FQXqNFZWNwVeQFdpwhsifOSLu9j3cGbFMT9iK
 TFWn6/mL/Bp9cdAZf9VV04NtY8/OiywtGeUBs36EkBH49T7qJ4kI8MQ4SYyXTTyiA+XI
 OKGw==
X-Gm-Message-State: AOJu0YwGqNgTO8jndGaaBc7KAYNHN240A7n/6+CFn9z/tWtLdmkF2u46
 i6QftsPZT8+wvOGHLBRt7jWCXscvqf8rgC+1HQtVzVjTm0V7wdhYYUhgqNNS5luBeAnJ/ptKjFn
 FRSuOO2/dGZfpOKoZ+UhRHAWFiQSlD2NddQeAW/e+iEPwzzgkZb8c97c3V0Uv6Masn0Ki492U83
 TicKg0eIskSLnYNQayvrje4MGYipZ4t/D08hTr
X-Gm-Gg: ASbGnctEynaOThJ+wh2UssHiETBR5bnBs4OoZl5QmCWvpQff9xC2FsqxhzxZVtQoDua
 g4lAYZQZib5KpdEoNVYjYMkVqP/w6mnUt6LOb3REESaU5wirTZdlSZsAKPQvSk8h/PfVZiI0ApH
 4Jrp70BKPoDf0PzHYtbeJsYjejglYin78r6wU3Ho1yneh2uoRHZPlYbictnhmgFf2uALitlNx53
 nS1Sps4VBpyNF9KEkAPuA8i1j1nXGrvdTlVxOpeC5uqpOcgehwPDcpd3moG9bFdcupDfR4P32W5
 0YJ375tvZidha3s=
X-Received: by 2002:adf:8b53:0:b0:3a0:b1de:1be0 with SMTP id
 ffacd0b85a97d-3a1f6466002mr9694988f8f.31.1747076731707; 
 Mon, 12 May 2025 12:05:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE84NcwA5CvHlZGtaWIVO3t4VNDgnXS2RG7niBBGP5Nt+hG6B0d0DHgHWLBEb0dopAdiPXrEA==
X-Received: by 2002:adf:8b53:0:b0:3a0:b1de:1be0 with SMTP id
 ffacd0b85a97d-3a1f6466002mr9694971f8f.31.1747076731325; 
 Mon, 12 May 2025 12:05:31 -0700 (PDT)
Received: from [192.168.122.1] ([151.95.45.141])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a1f5a2cf0esm13435348f8f.79.2025.05.12.12.05.30
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 May 2025 12:05:30 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 03/16] meson: remove unnecessary dependencies from specific_ss
Date: Mon, 12 May 2025 21:05:11 +0200
Message-ID: <20250512190524.179419-4-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250512190524.179419-1-pbonzini@redhat.com>
References: <20250512190524.179419-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.551,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

All dependencies that are in common_ss (which includes system_ss) automatically
have their include path added when building the target-specific files.  So the
hack in ui/meson.build is not needed anymore since commit 727bb5b477e ("meson:
pick libfdt from common_ss when building target-specific files", 2024-05-10);
drop it.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 ui/meson.build | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/ui/meson.build b/ui/meson.build
index 35fb04cadf3..6371422c460 100644
--- a/ui/meson.build
+++ b/ui/meson.build
@@ -1,7 +1,4 @@
 system_ss.add(pixman)
-specific_ss.add(when: ['CONFIG_SYSTEM_ONLY'], if_true: pixman)   # for the include path
-specific_ss.add(when: ['CONFIG_SYSTEM_ONLY'], if_true: opengl)   # for the include path
-
 system_ss.add(png)
 system_ss.add(files(
   'clipboard.c',
-- 
2.49.0


