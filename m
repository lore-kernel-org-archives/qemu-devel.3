Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 760E3CA0FFF
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 16:47:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usNOX-0003kK-FR; Sat, 30 Aug 2025 11:21:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1us14a-0001kn-Uz
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 11:31:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1us14Y-0000UE-73
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 11:31:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756481482;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ngp7yieopXFSA/+lQJw7TEMgciyxdXPlsW+grRCDpfI=;
 b=arF2I2AxU20XlomJJLZF3nTyUZEdoXNm2zGF51YjMMjunhvCDoS1XT4V753e08B3RqxKEK
 7owLPYKwkNJ+BjNeNEvVPV1GhZ/N+e1OWuoVIlAY/1mZMpL4R+e8i3yAEu+eVVHjFF+tl9
 13iRdZpZ9ilrEpF+pfPEVAkF/wrTV8M=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-196-CP3NVr3NO9CAe98yracTyA-1; Fri, 29 Aug 2025 11:31:21 -0400
X-MC-Unique: CP3NVr3NO9CAe98yracTyA-1
X-Mimecast-MFC-AGG-ID: CP3NVr3NO9CAe98yracTyA_1756481479
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-45a1ad21752so13548755e9.1
 for <qemu-devel@nongnu.org>; Fri, 29 Aug 2025 08:31:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756481478; x=1757086278;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ngp7yieopXFSA/+lQJw7TEMgciyxdXPlsW+grRCDpfI=;
 b=moBkRRF679/dxHgtkfIWWv0F14Sq+pQmBBVIqoXjKmoOzu9q0Ucqh4UYncr1OtNzhS
 uzZEawT4vFz2hx49Ml3d82TRs0Tz8GlWQlIOarxBZ+QXUTCeKYe86WzKwDxaqHsGItQ5
 BobDBk5JZH95oMmzWY8KYZOTmAHwrlvxyq2PQCRRxsXwsHdr3nVMg5gLXXaD2qjQkxCm
 11L6aFSViJw16lGXTNXe5VcBSDxm6Zd3p1NbUV/KXFJSfKLd3kviuAgDeE1os1zeF83/
 x1SaRT7+7wNaMielzOUzFv83Cw5/60gERLqLDJHafrHty2oF45GgSqCx3/hhjDwCISvo
 hd7g==
X-Gm-Message-State: AOJu0YxWeNz7AOgExVIFen1W9zXwM7oR/DDUyEH+yNv4hkxJ0JEwx2tq
 aPOXaG6YIUk95uHRsfTuv9tEL07CtN4gafARYSbqNM8UpU7iAUOOY5ahlb7sPgJvTNSlzA4vwxc
 I8tkOI/fjNIcqzi3aRjOxw8VIFKAQcpv/JxGjdY0jE7BUmR0q9PA+hQ+OmwtmiEiWc3YpLWNygu
 jJjXzv2o88srANkxZpeGF4RyuH3m6F6aDai2HkaKE5
X-Gm-Gg: ASbGncsU4T7s/t1XFFxLbFb71AM745JyNGu4EE20Z8I+MhhCRkHIq3I2WIl/SY4eTRf
 8dp9aXRbHlJ5ntR5Zv8qKb5o0Zh7i9d9S2SpLDfJXdN6jz8yG8zjNnPsWdhp3NyTnRGHKu9tXkC
 rQo93dX70PKo+4750y1ESlYZPt6VJbmxpPf+VtaXYtKF9+EabCbX3HKir6WTAuewCsaqfIOj70J
 5YoxM8YNo9jRS88fE6cBI1Au4b9adyl80OMJcz7XzooTbjaCcXYsGHNM0LfaAkoMzWiYB1+sz+m
 3yg5FkXtUyrIsMGzmX+/dEtkvtu6vCDGQ35UKFZ3ONIrCwHgneDF7csZRz6WaUCwE2eIB4UC+WI
 f61hU3GYP7Fl7m6U+7PWTHoA/2rDEdGZE0qScZB4OsGM=
X-Received: by 2002:a05:600c:4588:b0:45b:47e1:ef7c with SMTP id
 5b1f17b1804b1-45b68714514mr117243135e9.18.1756481478091; 
 Fri, 29 Aug 2025 08:31:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHxlFDxF7dRX9RJdG01km0RtGgW67kMB4cmwu8jDL1TDPA9sCP9ygSYa5CE/ODaeMewI6EE/g==
X-Received: by 2002:a05:600c:4588:b0:45b:47e1:ef7c with SMTP id
 5b1f17b1804b1-45b68714514mr117242715e9.18.1756481477534; 
 Fri, 29 Aug 2025 08:31:17 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.56.250])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3d164a57097sm555536f8f.40.2025.08.29.08.31.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Aug 2025 08:31:16 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com,
	richard.henderson@linaro.org,
	imammedo@redhat.com
Subject: [PATCH 05/18] user-exec: remove cpu_interrupt() stub
Date: Fri, 29 Aug 2025 17:31:02 +0200
Message-ID: <20250829153115.1590048-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250829152909.1589668-1-pbonzini@redhat.com>
References: <20250829152909.1589668-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 accel/tcg/user-exec.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/accel/tcg/user-exec.c b/accel/tcg/user-exec.c
index 748bfab04a7..66c25fba7dd 100644
--- a/accel/tcg/user-exec.c
+++ b/accel/tcg/user-exec.c
@@ -46,11 +46,6 @@ __thread uintptr_t helper_retaddr;
 
 //#define DEBUG_SIGNAL
 
-void cpu_interrupt(CPUState *cpu, int mask)
-{
-    g_assert_not_reached();
-}
-
 /*
  * Adjust the pc to pass to cpu_restore_state; return the memop type.
  */
-- 
2.51.0


