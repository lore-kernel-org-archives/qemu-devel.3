Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E9D5C19F2E
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2025 14:29:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tneoP-0006oP-N5; Thu, 27 Feb 2025 09:24:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tnemq-0004HX-M2
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 09:22:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tnemo-0004AM-JR
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 09:22:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740666169;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5YnANE3o7k98qiD5yXSXBYpiijAd3VVlrkAgduC094U=;
 b=QsntAUxcxOkEABr93R1p/exLIkMBd3YYOC1s8lWwXG5zXklFMojRREGG3Nd4xL2wqdpSMH
 ErSOLz7e4/nwwZPFXHKL6aarI3mV7GGzFWpZAt+am077y0Iky2GzNzdAVKDaLVGIWx8cRD
 MzAedDjyFdkeA7AHMK8D9A4kjsCVQw4=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-88-6_cKwmKKO-Wni1--gDOaiQ-1; Thu, 27 Feb 2025 09:22:48 -0500
X-MC-Unique: 6_cKwmKKO-Wni1--gDOaiQ-1
X-Mimecast-MFC-AGG-ID: 6_cKwmKKO-Wni1--gDOaiQ_1740666167
Received: by mail-ed1-f70.google.com with SMTP id
 4fb4d7f45d1cf-5ded3946ff9so1130901a12.3
 for <qemu-devel@nongnu.org>; Thu, 27 Feb 2025 06:22:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740666167; x=1741270967;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5YnANE3o7k98qiD5yXSXBYpiijAd3VVlrkAgduC094U=;
 b=E/2E1So1tI9NPx5oOx8qTEN0JSkPX6f/eVPQDRvcQPgjEtj4adAcpgWTvNuLw3rKfT
 g/Wa8rOxv/+TD0ItNs/8auACsjiRPzXPgClDeKliOqVXt3fYeRdvJzQeOL5TGeTiT87/
 Ohv/LV0iDJ1gUwvKWcauvwdFpcKZ6BzvUMCCvVey7tXZUZNM5Zgk/c6EzDRKea7cvYnL
 JdPRCluUJaYoJT8mXkmFUdswnDYsWAeXM6J4rjF6KXnYtpXkp+xJGO5dWqDvYjXm3Yuj
 jzg2Q44Ywh8cVREZeQpdDFBceBalwZiMCPHKZO3+So/Wl28LIIHbzSao90cQdGAK0ISm
 wOGA==
X-Gm-Message-State: AOJu0YzVuseqjYuJT4zYnCnWVZAIXeNZyr1hTKQDtYqgMjn/7ejRzhEo
 Q7JzRgbEiQJHsA0PwOG85o6Ae0t7k1sqazzuzNoSuuvB0LCNLeEh/RTkzOJO4kAFBvxJkUTFATr
 VwvttFaSc5UtDkuIS1lhLF1kL6KknBPi/gayPSSCDTHse7UhhhVz2BnNyJTQuotHzn0EX2DZgHD
 6iZzFrT6HBWYAhTE1Z0Xul7goMS+I0yTZ7NnkR93E=
X-Gm-Gg: ASbGncsHM6H4aQViB/TI1g5/nE+12vOgCaC8wuiRPVZ4RPRNAV4qWtcnEAqGdZv1OB8
 vFh6dUu9zQLi8ApxR6oni5RB8obruy98iYzDBwxF1OD9PsROAetR6CiwGeOb7xeVtCn5ZY7mFJf
 rsYC9tI1AaKG3/H6YMaQOyiOBKxi8oQ+MWLk4xGVUiNUy0V839DnKNwMKJj0cA8lF8X53+H1x5O
 91BW76xHKNWi3PgKjgw55m3nEiQIcSyctnTq0994U8CsBdPOS5WhLyBNCp6SMD2NVLbmVXgUaVu
 rGdentZzZHL/c7fkx1DZ
X-Received: by 2002:a05:6402:248c:b0:5da:d76:7b2e with SMTP id
 4fb4d7f45d1cf-5e4a0bf28cemr11014797a12.0.1740666166677; 
 Thu, 27 Feb 2025 06:22:46 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFI18O2SZf2XVwBJAzZdSiM75sskBvaScYSlzBp/K0tpUSEfcPx/7NIQUBZO265lJA9h0HCMw==
X-Received: by 2002:a05:6402:248c:b0:5da:d76:7b2e with SMTP id
 4fb4d7f45d1cf-5e4a0bf28cemr11014761a12.0.1740666166220; 
 Thu, 27 Feb 2025 06:22:46 -0800 (PST)
Received: from [192.168.10.48] ([176.206.102.52])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5e4c3b4aa13sm1147054a12.7.2025.02.27.06.22.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Feb 2025 06:22:45 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-rust@nongnu.org,
	zhao1.liu@intel.com
Subject: [PATCH 12/12] rust: bindings: remove more unnecessary Send/Sync impls
Date: Thu, 27 Feb 2025 15:22:19 +0100
Message-ID: <20250227142219.812270-13-pbonzini@redhat.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250227142219.812270-1-pbonzini@redhat.com>
References: <20250227142219.812270-1-pbonzini@redhat.com>
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

Send and Sync are now implemented on the opaque wrappers.  Remove them
from the bindings module, unless the structs are pure data containers
and/or have no C functions defined on them.

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/qemu-api/src/bindings.rs | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/rust/qemu-api/src/bindings.rs b/rust/qemu-api/src/bindings.rs
index c3f36108bd5..3c1d297581e 100644
--- a/rust/qemu-api/src/bindings.rs
+++ b/rust/qemu-api/src/bindings.rs
@@ -25,15 +25,11 @@
 
 // SAFETY: these are implemented in C; the bindings need to assert that the
 // BQL is taken, either directly or via `BqlCell` and `BqlRefCell`.
-unsafe impl Send for BusState {}
-unsafe impl Sync for BusState {}
-
+// When bindings for character devices are introduced, this can be
+// moved to the Opaque<> wrapper in src/chardev.rs.
 unsafe impl Send for CharBackend {}
 unsafe impl Sync for CharBackend {}
 
-unsafe impl Send for ObjectClass {}
-unsafe impl Sync for ObjectClass {}
-
 // SAFETY: this is a pure data struct
 unsafe impl Send for CoalescedMemoryRange {}
 unsafe impl Sync for CoalescedMemoryRange {}
-- 
2.48.1


