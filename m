Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0792FC021A9
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2025 08:05:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tkIbV-0005NI-Ex; Tue, 18 Feb 2025 03:05:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tkIbQ-0005Ly-SG
 for qemu-devel@nongnu.org; Tue, 18 Feb 2025 03:05:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tkIbI-0007iq-AM
 for qemu-devel@nongnu.org; Tue, 18 Feb 2025 03:05:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739865902;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=s4rLBdVPxb6okN9/rSullSB3rdps64ovo3v4at/34SA=;
 b=AC1XBmbBzPPHBk0ZQkuzR1sH1ylbjUBml4HYruD4J60NUFV5MK7PSHNJ/Vm/FqusBV6GoR
 Ae1G9bzPQTqgJckyn1cJUty1WejTHxX674pAotUhUhgfxLPMIYOjzEp5Z7Spaz4rPcP1FC
 8coY2IqUtZJhRfJolWx58ycwlebTU0s=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-563-so6zJtsCNAyVHFPj9ZKAEQ-1; Tue, 18 Feb 2025 03:04:59 -0500
X-MC-Unique: so6zJtsCNAyVHFPj9ZKAEQ-1
X-Mimecast-MFC-AGG-ID: so6zJtsCNAyVHFPj9ZKAEQ_1739865898
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-38f32ac838cso2507566f8f.2
 for <qemu-devel@nongnu.org>; Tue, 18 Feb 2025 00:04:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739865897; x=1740470697;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=s4rLBdVPxb6okN9/rSullSB3rdps64ovo3v4at/34SA=;
 b=tbSB44eqGESoBQBG+U5Tyc8atVPQtfFYFejIwsDpYw0WkQ635kIZzeNuPEzAt29DLs
 wC2kWTIV6prz8bqH+tapVe3afeHGceCuAhWH9kyy4luPUDEJGqXXvdylQ4+cAi5SErL4
 KGYUVrC0uhnxISvFn154z9RhTB3B1KBUSISZmK+h1YwYBgV2KqA2PErLwtOfpQ7QRLtb
 sgaRLkXdQG55Dc1G7qcH0U7++PL7UpDfT8m2T0gitZ8E35Uk19QOfucab47ihqQvxJ3S
 P/Z2elMnuBYz2YUGVRWuBe2sopoTs+cuuUZeQm8mK2PdKhy4LBV25zpZ+rbUCrLRWRq7
 sJfQ==
X-Gm-Message-State: AOJu0Yy+nXiNLzLD+vGIQfLrGCMzi/Jt7zypHa9Po/uBXH5/9ZfU4acY
 mTaPX1TU3HW0unxYlv7KOgqlf3MBzqJk0XfnEUFMfdsqwX5N3bXNgqgUmJDTHUdP0nbF9WUhrJw
 D7IV2Aeu5dGc/ndGwn39ZKyViyKhKPyrUOSv4UvnWiassqqX4waaoCYBZeqFaOiLabi9PHR2wNY
 my1L+cq8fSXtdPt9XBQyNKZNWso/GcUWHiuzorq4c=
X-Gm-Gg: ASbGncsHq6+Usn9PXQFVZXmvIQ98/1iP1TuNEpWVr9LSCL5qeggerWbJWwDh9XSlotf
 C+snRHKZ7/yoiNKOT/p8oso1ZE5JFHgxCUTCFHwNuPBE8Wj4xiX0LVGmLvwvNM9lKiE3fikYONp
 7n8GULQGe89RNwcrKJbnxJ7UR0EAAIv8RowLEMZfpavQccV8STPD+G7hHDl2MgzofGeGvbM7KbL
 CaXQfcR3/d+02wmojX0Xdk+ZTZ7qYSBZ3c6rnWzvDRv+W9slc9Y8DuBJNrsBv88OBdN4uk5i96j
 cSA285fPTjU=
X-Received: by 2002:a5d:64ad:0:b0:38d:d299:709f with SMTP id
 ffacd0b85a97d-38f33f4e5e9mr14705157f8f.48.1739865897381; 
 Tue, 18 Feb 2025 00:04:57 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGe6X0H6FoeTpeWkmvS3CDb8HxLFBW0GhixymOR6QnLXgHcuLqgZFzlSwrJSZ301QHTWUMSlw==
X-Received: by 2002:a5d:64ad:0:b0:38d:d299:709f with SMTP id
 ffacd0b85a97d-38f33f4e5e9mr14705105f8f.48.1739865896939; 
 Tue, 18 Feb 2025 00:04:56 -0800 (PST)
Received: from [192.168.10.48] ([176.206.122.109])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38f258dcc50sm14521234f8f.34.2025.02.18.00.04.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Feb 2025 00:04:56 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-rust@nongnu.org
Subject: [PATCH] docs: rust: update description of crates
Date: Tue, 18 Feb 2025 09:04:55 +0100
Message-ID: <20250218080455.426383-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
 docs/devel/rust.rst | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/docs/devel/rust.rst b/docs/devel/rust.rst
index 7964e1fd327..e3f9e16aacb 100644
--- a/docs/devel/rust.rst
+++ b/docs/devel/rust.rst
@@ -139,16 +139,22 @@ anymore.
 Writing Rust code in QEMU
 -------------------------
 
-Right now QEMU includes three crates:
+Right now QEMU includes four crates:
 
 * ``qemu_api`` for bindings to C code and useful functionality
 
 * ``qemu_api_macros`` defines several procedural macros that are useful when
   writing C code
 
-* ``pl011`` (under ``rust/hw/char/pl011``) is the sample device that is being
-  used to further develop ``qemu_api`` and ``qemu_api_macros``.  It is a functional
-  replacement for the ``hw/char/pl011.c`` file.
+* ``pl011`` (under ``rust/hw/char/pl011``) and ``hpet`` (under ``rust/hw/timer/hpet``)
+  are sample device that demonstrate ``qemu_api`` and ``qemu_api_macros``, and are
+  used to further develop them.  These two crates are functional\ [#issues]_ replacements
+  for the ``hw/char/pl011.c`` and ``hw/timer/hpet.c`` files.
+
+.. [#issues] The ``pl011`` crate is synchronized with ``hw/char/pl011.c``
+   as of commit 02b1f7f61928.  The ``hpet`` crate is synchronized as of
+   commit f32352ff9e.  Both are lacking tracing functionality; ``hpet``
+   is also lacking support for migration.
 
 This section explains how to work with them.
 
-- 
2.48.1


