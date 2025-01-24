Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02748C0218C
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2025 09:50:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbGHg-0001tu-Fg; Fri, 24 Jan 2025 04:47:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tbGGJ-0007do-9h
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 04:46:04 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tbGGH-0003y5-FB
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 04:46:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737711960;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=v046WHBDzXsfnIdlJ2KYuzlpoyQwX0KFTxjaaOlycxU=;
 b=UKgBrsAazOrxtoNe3PKE4C/5wEDiUwN/nPQiZOR2JiL/emk80dA1z3muiO9Xv+EusV4qdm
 bUyC4CqJZtpH9INmQzCMDwr++JvsCwmKUXX+9hflaGAkX1ZbvudkdREYoSkNhcFh28ieuD
 CCIlmbs7DDhiRmwDcjOeo3sfkwL/8rw=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-84-ar6S6ekEPU-rw_ZBgnXUAQ-1; Fri, 24 Jan 2025 04:45:58 -0500
X-MC-Unique: ar6S6ekEPU-rw_ZBgnXUAQ-1
X-Mimecast-MFC-AGG-ID: ar6S6ekEPU-rw_ZBgnXUAQ
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-38a873178f2so1041969f8f.1
 for <qemu-devel@nongnu.org>; Fri, 24 Jan 2025 01:45:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737711957; x=1738316757;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=v046WHBDzXsfnIdlJ2KYuzlpoyQwX0KFTxjaaOlycxU=;
 b=J+4+SyHHOUFg49P6RnZycuTDIO1joOTbk9ArrZO6D6SbCMzRQteUwCtgctCR+/yD0+
 x9HH7LcOqOkfWGwLBjaE5SUUr+aYAp6IwFTeaY2z8XrAltBQ2WACEIYmkdEuwcTxDdr7
 /H6CK+5Sc2ewPS+iLBJ3pWFIqKF8ZHl58BKw1N20wGhqtzqflztbWeDout5IbaYClI/x
 tSttdP8/9B3+6TpyLLSqw0Jcq+1+9l6g4Jta5PFkQqyqdlxAy86dJ5YcKfh2XXQz0ZiN
 cH0aUTD17FuHB/9+RUPWqdG/cxN3SfebvsM8reQmjukyR1lrKag1/vlifV/CLw3DLG2p
 jJCA==
X-Gm-Message-State: AOJu0YyQOM3oUemAxxPNMuerdmpF4f8OQGV7YdFzU+wiixlhH47Go6Xe
 D4r+R6YQ62QwdnPLbjHr68e7oxL0Kzd8dq7m7X9LQa330wJ92nyORft7wLMLt1SxmEwATo36FUa
 sCtNhnmsUAELW2YrxTDSU+FuX0auwvp6cuuXU9edQJvBj3SqLtGhmuM6q9IcseACfWbp8fzB18t
 mDxHPGg/a1uXIekDckj6Jze4UAyFajKwHu17ILaKc=
X-Gm-Gg: ASbGncuOQm19XbGideBHFaHhGxL3wv259fQp0HKguQAzZ8A3VkIhqlgyTMsxD9FtEMv
 b2uYoTS3/uZAlGLqZ6jKaHmvqMj8TmbPquVCiQxGSYin4wmVx18awM32fBzpfmD15Bpm/pOI3de
 UXZvZFEV/Qgu1W6gPcVd5z2CfYOKeYoffs7mebZfcV2ZWR4oSxCcRxcVVFwGmoVByaqi+KwswL1
 ZVg3bPeSVgOg1FnHqSeHDfKgs15rpM7KboN18VYmmuknNBsM0wJSWIcJAx8Ur3YIPRA+HO/Lw==
X-Received: by 2002:adf:f682:0:b0:38b:e26d:ea0b with SMTP id
 ffacd0b85a97d-38bf566c314mr23371388f8f.25.1737711957189; 
 Fri, 24 Jan 2025 01:45:57 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH9aq052Xl/vYca/Bt3phpmiYj9f1dU6/LBU0CGe0yDhe+8K1AAYsDCMBwZXbuSUtf/GeDCMg==
X-Received: by 2002:adf:f682:0:b0:38b:e26d:ea0b with SMTP id
 ffacd0b85a97d-38bf566c314mr23371365f8f.25.1737711956840; 
 Fri, 24 Jan 2025 01:45:56 -0800 (PST)
Received: from [192.168.10.48] ([151.95.59.125])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438bd4d2c0esm20268945e9.33.2025.01.24.01.45.56
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jan 2025 01:45:56 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 36/48] rust: pl011: remove unnecessary "extern crate"
Date: Fri, 24 Jan 2025 10:44:30 +0100
Message-ID: <20250124094442.13207-37-pbonzini@redhat.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250124094442.13207-1-pbonzini@redhat.com>
References: <20250124094442.13207-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.043,
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

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/hw/char/pl011/src/lib.rs | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/rust/hw/char/pl011/src/lib.rs b/rust/hw/char/pl011/src/lib.rs
index f30f9850ad4..d10f0805aac 100644
--- a/rust/hw/char/pl011/src/lib.rs
+++ b/rust/hw/char/pl011/src/lib.rs
@@ -25,10 +25,6 @@
 #![allow(clippy::upper_case_acronyms)]
 #![allow(clippy::result_unit_err)]
 
-extern crate bilge;
-extern crate bilge_impl;
-extern crate qemu_api;
-
 use qemu_api::c_str;
 
 pub mod device;
-- 
2.48.1


