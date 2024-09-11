Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69AFCEE49A0
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2024 12:34:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1soMXu-0005AL-PR; Wed, 11 Sep 2024 08:34:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1soMXs-0004wN-9T
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 08:34:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1soMXq-00012P-Fo
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 08:34:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1726058041;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=B8BWBynZiqu5W0tPrxT2WqoU5n0IrKBPLt4KWbMfpz8=;
 b=QYI4E755MXET1vFeuHLrMUDuMAPyCcNgrB6MaWjhgsy8YOmwaUObLj118yh35gyQwg0kuI
 6Uzmgyjmdple/EUp6wVHShd3dI5/Kbuz4XAdb2crSCeorS84fgVK9Cs42G/+dqtrKoVPvS
 Zesj9CMGeBXjAPwDt89oZyENFLmBF90=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-548-ZF2Fjw8pPDuupRtz-_Bdeg-1; Wed, 11 Sep 2024 08:33:58 -0400
X-MC-Unique: ZF2Fjw8pPDuupRtz-_Bdeg-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-374b35856aeso938407f8f.3
 for <qemu-devel@nongnu.org>; Wed, 11 Sep 2024 05:33:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726058036; x=1726662836;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=B8BWBynZiqu5W0tPrxT2WqoU5n0IrKBPLt4KWbMfpz8=;
 b=M8wQyJCcxqkSpd9DDfasM5EH+mido4HpkACTOIMEPcr3ET66eBTVunOsValbT3zGEL
 gFiR89nP3PnWax8fyWzfNS4C0D7d2scHaGlMi5baI8y0vblve3tBo2Mx6g8V3rpW/Yi8
 Fv+8Pe8iigycsafC0o6+ZGOuHWptROhcCVyIaCbxvRDtqVjC4hC9KuImeoWyAX7lGNkw
 xAXqCU20DEFlGBeK2lFDvobOMYBlkJ/zQRqEuk0sV9usX6+9Yj+TCE94+cbpY05C197u
 CzMSvTlACkHIKON5qfHdTPatCcOutQ5XAu2AIGyKISv0F4aqJVm8cuLFPZX9HvljDptZ
 NXpw==
X-Gm-Message-State: AOJu0YxnGUZF+IVAGGWJNhNVMCL0yjOt+OWqxWPovsPwX9wlZiPooSb2
 7z4pCkj7wkZVLVxC5QjNQscYiiTJZ7HWyJ+aNUw7qrtD8QRG7D5Wgp9iw2AA8rWDZKk7fWrPElx
 DzwGJuGI9l9tEGxkExubcUn6XGfHL6jR0+ddOZc8GAX5LfbQmGxHSrqvutvkYAPK18AVPt6V/QL
 1jvv0Yby0tFbAq4VzXR/r8Dv/Ntv/qoeiexwRS67I=
X-Received: by 2002:a5d:684a:0:b0:374:c022:fa76 with SMTP id
 ffacd0b85a97d-378b07feb93mr1812921f8f.37.1726058036480; 
 Wed, 11 Sep 2024 05:33:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFVwR8ZfTNReuKjdEEN7FcHAuSFYvvecyZ/v+rFPJnXROdocavS5PKCZKDZo2TD+j0LfZ2wsA==
X-Received: by 2002:a5d:684a:0:b0:374:c022:fa76 with SMTP id
 ffacd0b85a97d-378b07feb93mr1812900f8f.37.1726058035999; 
 Wed, 11 Sep 2024 05:33:55 -0700 (PDT)
Received: from avogadro.local ([151.95.101.29])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-378956dd932sm11446224f8f.98.2024.09.11.05.33.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Sep 2024 05:33:55 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: "Richard W.M. Jones" <rjones@redhat.com>
Subject: [PULL 04/17] tests/unit: remove block layer code from
 test-nested-aio-poll
Date: Wed, 11 Sep 2024 14:33:29 +0200
Message-ID: <20240911123342.339482-5-pbonzini@redhat.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240911123342.339482-1-pbonzini@redhat.com>
References: <20240911123342.339482-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

GCC is reporting a NULL pointer dereference when compiling aio_wait_kick()
with LTO.

The issue is that test-nested-aio-poll.c does not call qemu_init_main_loop().
It doesn't _need_ to because it never calls AIO_WAIT_WHILE(), but it seems
that LTO does not do enough dead-code elimination to catch that.

Fortunately aio_wait_kick() is only used in few places, and only in block
layer or system emulation code; and this test only needs the core event loop
functionality.  It does not even need iothreads.   So remove everything that
calls aio_wait_kick(), which is nice for coverage compared to adding the call
to qemu_init_main_loop().

Reported-by: Richard W.M. Jones <rjones@redhat.com>
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2434
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 tests/unit/meson.build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/unit/meson.build b/tests/unit/meson.build
index 490ab8182dc..6c377917636 100644
--- a/tests/unit/meson.build
+++ b/tests/unit/meson.build
@@ -115,7 +115,7 @@ if have_block
   if host_os != 'windows'
     tests += {
       'test-image-locking': [testblock],
-      'test-nested-aio-poll': [testblock],
+      'test-nested-aio-poll': [],
     }
   endif
   if config_host_data.get('CONFIG_REPLICATION')
-- 
2.46.0


