Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6639AC41513
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Jun 2024 06:20:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKu44-0001r0-Fv; Sat, 22 Jun 2024 02:17:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sKu3Y-0000aa-Ns
 for qemu-devel@nongnu.org; Sat, 22 Jun 2024 02:17:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sKu3X-0006Vk-4R
 for qemu-devel@nongnu.org; Sat, 22 Jun 2024 02:17:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719037018;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=p4JQad1sT8RnQ9lJzX0OnKgNZZx89u7Pl8uqPcJlXgY=;
 b=MiehcqPztqhpE8QDiHvUijyE5pIpjG1dl6C2qZcZlgIaASpWF2tFJuaFz+pZ0PfRxB/ERV
 aqCShGKIllxvEfHRjt2lUyXqmJXhz7sHv5AJmfZYOMkVBn82Cn3mhMti88WXxiXe7fb6Aa
 Ti4wy9nMx5Zps4k0MiDb2j8ZQuZe9po=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-195-AUg9BaO7NbSlt3qUAt1B9w-1; Sat, 22 Jun 2024 02:16:56 -0400
X-MC-Unique: AUg9BaO7NbSlt3qUAt1B9w-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-a6fdc107e06so19451366b.1
 for <qemu-devel@nongnu.org>; Fri, 21 Jun 2024 23:16:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719037014; x=1719641814;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=p4JQad1sT8RnQ9lJzX0OnKgNZZx89u7Pl8uqPcJlXgY=;
 b=g0XiyXAPURn5OvV2jy/2p7S7RyTuZUrvMQzOzU0VaWZ3T99OPGxKm9vNNRTikpLgl+
 s8XK7GqOm80mJZfH0vrdGqISorvRzLmwPLtP6S00ObXHyBt2D9F2l1mmAYMzrnbhbuEc
 1Hd1RrTGmB5VssMhJwF8i1B1rXoYGDKvlNOwod9S1kXLa1wxalKuD9C4dSd6uWOzjf5j
 WCuI/3S03MBPFISzwfFzolwKA7QLqY3PsKtunYFFyuRIm+Lg1e/tlio0U8Qltunma/nv
 qejfsJaoD/gcfX3nlpyiFqw7bdIKBuUA0+JYCV6HgMrLFdw0k0KqUiJaUWuBrkQcXA5V
 lL3A==
X-Gm-Message-State: AOJu0YxqNZjngoNbmD1N5yxbPrv0u0NNExA2kfDGsFKGmRBSRh9ynlET
 hSj9npCu3I4EqEv9TPPss42t9RyVT39zr5nIfOrZFpI291DYEHImKIyAvVVRP5j7Nvr3XDHeipp
 N2dZXn9kIGKFcZN0mfHjNcniDaBBJM9kAkeVNuxlKhxTEXt8Oz+kLX0+5mim0bt3UFRuGHyw2gi
 77wwOwIP7Z8ath5TAjNINKiGsIpXX3gEn1mtI8
X-Received: by 2002:a17:907:c70f:b0:a6f:b1a8:e43 with SMTP id
 a640c23a62f3a-a6fb1a81d77mr576371566b.16.1719037014461; 
 Fri, 21 Jun 2024 23:16:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGVJrzVnYk/VuAE42mJQuGEC24i5Lc1+31xtKO89YlsLuHr6R/p8FOvP7IlLL4wTPxgMCMpTg==
X-Received: by 2002:a17:907:c70f:b0:a6f:b1a8:e43 with SMTP id
 a640c23a62f3a-a6fb1a81d77mr576370366b.16.1719037014149; 
 Fri, 21 Jun 2024 23:16:54 -0700 (PDT)
Received: from avogadro.local ([151.62.196.71])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a6fcf5605aesm157436766b.151.2024.06.21.23.16.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Jun 2024 23:16:52 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Roman Kiryanov <rkir@google.com>
Subject: [PULL 23/23] exec: don't use void* in pointer arithmetic in headers
Date: Sat, 22 Jun 2024 08:15:57 +0200
Message-ID: <20240622061558.530543-24-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240622061558.530543-1-pbonzini@redhat.com>
References: <20240622061558.530543-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.145,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Roman Kiryanov <rkir@google.com>

void* pointer arithmetic is a GCC extentension which could not be
available in other build tools (e.g. C++). This changes removes this
assumption.

Signed-off-by: Roman Kiryanov <rkir@google.com>
Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
Link: https://lore.kernel.org/r/20240620201654.598024-1-rkir@google.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/exec/memory.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/exec/memory.h b/include/exec/memory.h
index d7591a60d9f..08ecd7e195d 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -2796,7 +2796,7 @@ MemTxResult address_space_write_rom(AddressSpace *as, hwaddr addr,
 #include "exec/memory_ldst_phys.h.inc"
 
 struct MemoryRegionCache {
-    void *ptr;
+    uint8_t *ptr;
     hwaddr xlat;
     hwaddr len;
     FlatView *fv;
-- 
2.45.2


