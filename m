Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EF68E8FDD6
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Dec 2025 09:24:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vZQQb-0004bi-43; Sat, 27 Dec 2025 04:17:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vZQQZ-0004Ot-LF
 for qemu-devel@nongnu.org; Sat, 27 Dec 2025 04:17:35 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vZQQY-0002nP-8a
 for qemu-devel@nongnu.org; Sat, 27 Dec 2025 04:17:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1766827053;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NGZ1x4J+t3Ww35ZOB0iffP3twL5jbSY9E6s3tqgBRTk=;
 b=Y6l8xxfBcu/5Wgzk2oQOI0YWscTKwaZg88N2IwbotcrUyE05JmYd93MmIqpRLbluV9LEQz
 4XnuJZoeFnFqQ/rbmxRN6uVY+MKvl6bzco7qB9bA2/bshz48zBQs++b5/pKYfg3U9XNxDF
 dOqDS1gT1h+PcAFTA2JoRHSYhyn3zyw=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-562-taSur1p7NDipgJVVESXCAg-1; Sat, 27 Dec 2025 04:17:31 -0500
X-MC-Unique: taSur1p7NDipgJVVESXCAg-1
X-Mimecast-MFC-AGG-ID: taSur1p7NDipgJVVESXCAg_1766827050
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-477cf2230c8so77990475e9.0
 for <qemu-devel@nongnu.org>; Sat, 27 Dec 2025 01:17:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1766827049; x=1767431849; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=NGZ1x4J+t3Ww35ZOB0iffP3twL5jbSY9E6s3tqgBRTk=;
 b=oVuvMqb01/bG97sVHrQlRiwJfHj5GvORET0X8F6bL2vNPst6RxNpc4eUVeyK+u9ENb
 rfgwbKzTbuBAz606wHqj001YZko2s21xVwWPjq8c1ysnYB19fq3ImdbGl6CPy4anV5rf
 ZU3Z/z6Mpd93vr4iKFbVQ0/gHfZCeIf+Hvp0xsmnLsuVGqkzWsRbp0g4IPDYsBL1vw7C
 vIAFMpfp1MtjZ2T43TV0MMQA3aggjHanKntnoxnC9w61ectMeJM8osZezzmkt8ReVmha
 oV2dk3iH4yblcP6D4IPgL3fqexpb6GFAQdpzt/8Lm8e7L2jsHALA+U+Rg9Kv+H8LIBBW
 LAhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766827049; x=1767431849;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=NGZ1x4J+t3Ww35ZOB0iffP3twL5jbSY9E6s3tqgBRTk=;
 b=NFKQ1dor5ERrksPTBlbuGkqxoYYSrF7qIzJ9r0e6Bp8a+/qW+w84KHw/+iwXI1OedR
 QWbbFhjKJLzywNRMtOU5bwXIwA8l1noJzh40UBf95e5RamhIko9pi5wGZAeI64kANwYz
 HbEGh/DbX/iieP6krKHvpWAG9tfBiLT26JfBici/nyQdpM2oFjXUldSM6LqO82S/DFeP
 zc5ZjDajrvVoltVhoEhTfNmiYD3FjoAP9RBh0Lt69M6g2/+50VSFw0d09vo3Cis8Hq5n
 TB8Duqd0Ej6Xf6Krr6MLb3CEgpVMgxFlL8bR7m2KAlrTzWGyAPj7xHVF8vequ7+yOlyE
 ppdQ==
X-Gm-Message-State: AOJu0Yz+fmFjCH7M3xgqOl1MNyyA2VRnIp1QG+Aq7U6ARnkElITXkrBS
 qdmi4mW5wP+EdmdAA4mhMfmVu7mEFDx8tlTJkKQdV34bfunCs52oU9oJ1mfzg4qXm8jFS9VCsvJ
 SFIHN4tnbByrJl1FqcI4LWbSzYq8OZf6AN6GW40//DGkWtANEALzmdDtodKUupW/477dGA09086
 3NyLZPd2WjmODHCrSf6gly4f0TY+5UpG57qlneuYHR
X-Gm-Gg: AY/fxX4d1n/856BCO72GnXfhyF9QSQ5udhUruSEQBwlC2RkG62mG1DUcYkoDoDnefEc
 GdeWPVXugMPSO50Hr0fZbFK6ngAsJeB05DWqj4syQItqraQyZb20kA/prEA3izVg7Vexl1friHX
 /dQS+4ZKq75gWkYaLmmriclYgpPlEdk3y40pgXtxYQTcf23RzCytkPNZhePChztwo0RKKN+8suN
 Dlb2aeATM6VSyJKGM0RhrqrHl3DI/5m3+wvsb0Gb9bKqit/4yuBPUxWrmwPosm5Tm2lld2xwaY7
 mnQnDgtGIuYSqN8RsFDJ+vlw+RHZOF+I/YJ2qEvuavKyc/AvfFCv61QRVWNgENeWwLpW4uuambp
 K3MubhuBw9hM8qnUFcvl8tKs4K/0HbifZitHv6guj8nlwaLZPRM2BcBQ3iK0KAtdVdV6Ph81AQC
 Ib4eL0NY815/nMAPw=
X-Received: by 2002:a05:600c:3b8f:b0:475:e09c:960e with SMTP id
 5b1f17b1804b1-47d19593d0dmr357743335e9.32.1766827049545; 
 Sat, 27 Dec 2025 01:17:29 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGM6vMRwVYuFux8yxcs7iuPLGmeN2n6jZ+dzlHBjlkfJ/m3jUZi3s0mheRGifJYQeDoCvwRnA==
X-Received: by 2002:a05:600c:3b8f:b0:475:e09c:960e with SMTP id
 5b1f17b1804b1-47d19593d0dmr357743075e9.32.1766827049141; 
 Sat, 27 Dec 2025 01:17:29 -0800 (PST)
Received: from [192.168.10.48] ([151.95.145.106])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47be273e4d5sm493338065e9.6.2025.12.27.01.17.27
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 27 Dec 2025 01:17:27 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 034/153] rust: fix reference to MemoryRegion
Date: Sat, 27 Dec 2025 10:14:21 +0100
Message-ID: <20251227091622.20725-35-pbonzini@redhat.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251227091622.20725-1-pbonzini@redhat.com>
References: <20251227091622.20725-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Use the wrapper struct, not the C one.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/bql/src/cell.rs | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/rust/bql/src/cell.rs b/rust/bql/src/cell.rs
index 8ade7db629c..f4bfa697d32 100644
--- a/rust/bql/src/cell.rs
+++ b/rust/bql/src/cell.rs
@@ -41,10 +41,11 @@
 //! this rule is not flexible enough. Sometimes it is required to have multiple
 //! references to an object and yet mutate it. In particular, QEMU objects
 //! usually have their pointer shared with the "outside world very early in
-//! their lifetime", for example when they create their
-//! [`MemoryRegion`s](crate::bindings::MemoryRegion).  Therefore, individual
-//! parts of a  device must be made mutable in a controlled manner; this module
-//! provides the tools to do so.
+//! their lifetime", for example when they create their [`MemoryRegion`s].
+//! Therefore, individual parts of a  device must be made mutable in a
+//! controlled manner; this module provides the tools to do so.
+//!
+//! [`MemoryRegion`s]: ../../system/memory/struct.MemoryRegion.html
 //!
 //! ## Cell types
 //!
-- 
2.52.0


