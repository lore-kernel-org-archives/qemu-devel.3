Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48BEED11183
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Nov 2025 13:21:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vObwC-0006gd-Ds; Thu, 27 Nov 2025 08:21:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vObvc-0005Wq-TA
 for qemu-devel@nongnu.org; Thu, 27 Nov 2025 08:21:00 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vObva-00026R-Fw
 for qemu-devel@nongnu.org; Thu, 27 Nov 2025 08:20:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764249653;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oHu41Oa/q8GhaKEt1sOE2Bq7H77riGl0nC0M3nPlAeI=;
 b=K0us2ePHE9ndXhoNPrqw3e8oLdsOv6UmWY3IF67wXcBACbrXTPTLLzeAz6a59R8R83K40Q
 yVlYeoHOcToLkq5qzH1qQTt2p2QsNXQRtqtbsNAWG1tTzFYha5M91NBL/f52Oi5Vgpc9EF
 bJHcmwinrLqoFmkVMbgjf2ujQuU0Kgw=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-122-oiZ9WDSJPb-7QrT8s3mMLA-1; Thu, 27 Nov 2025 08:20:52 -0500
X-MC-Unique: oiZ9WDSJPb-7QrT8s3mMLA-1
X-Mimecast-MFC-AGG-ID: oiZ9WDSJPb-7QrT8s3mMLA_1764249651
Received: by mail-ed1-f70.google.com with SMTP id
 4fb4d7f45d1cf-64537824851so1025193a12.1
 for <qemu-devel@nongnu.org>; Thu, 27 Nov 2025 05:20:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1764249650; x=1764854450; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oHu41Oa/q8GhaKEt1sOE2Bq7H77riGl0nC0M3nPlAeI=;
 b=ZKkkhBzNIVADgYOSb6OyzeRPI9C8ODXcSBiR/J1effW9l4hvXbOc0nKOnk7AH5uB9I
 NVKY7XnqIW5UeACrq+TrcRtbm4p320Iew3zcS7xH9XefX09zaABBm+YIZ5OiFBMJg2MN
 /LQq/0KoZ2zVMutJ7KqWS531/2vcszOlyDtnfy/9FkcKkthj+6YYhtYXFA3V9xYd7SCF
 7NyAskE7TGtVgvl875WH4YXDSMuAkOenjQPY3xKJFiElZFaI+g+8NVIWYZjW5vODBmgG
 1QKvYK5PsmOY8roH1J406twY8FSuGHVFK+TAX4lmBqlUIS2A0ho6xQGKcFBaLAlwMeXV
 uYwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764249650; x=1764854450;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=oHu41Oa/q8GhaKEt1sOE2Bq7H77riGl0nC0M3nPlAeI=;
 b=BVJK35SqEXnykmy+ZxzTEsSuNsE5K8oCystmDGAq2KZCwXIinPQnBnslIdQCzobegM
 gRoMpepLZfE9jE3xghNz+neo1X97F6lip1L+bfIMQzE/JhHMV2sThnJRIXS0NUvFITec
 KYSjlmF3SX6GnSSyd8O5DmWM/k9B9kyi9yZvJIksiVO8M1OKMaSLCV06CgpwqKZIEMJZ
 tKNkJG65BmQXa9QpbFvbcKSxjnn9j6M9jLkkUJHtcU2gPuuV2AKD6ytJgRYVsqJLEi4h
 u548l79HIQSQzxz3DMjgoj8tNKqOzZzsHDlT+STTnfQV8FcfwINWekMXrbH+JiNV24BH
 1zdw==
X-Gm-Message-State: AOJu0YyGwSMV26ysmZa03Ad5bV8uLJspoYGECWtNHcf9PrZiTZUpPdE2
 zk1BBbcI7fVJF2GSsunBEQYlZkqXAG6KCh/W3dHjis5B84JhLz5nYc1tWjxVIJ98tcA/8EmRBlv
 0blPvvxP+DPspIe8nxhunn/XazOIuDRae7NCaJkOR9CxXU1b3Y5UnaHohtqtXnh3KelXoZCpVxu
 +DE4qvoOZifrlzonPgYR+UMmyJ4NDoOFg8jNdZczB/
X-Gm-Gg: ASbGncu72/3zr62FHIxNO/vMSg/9zpm2M/nyG9BktsJZrCQQZr53gtKIoXNo8hti+Wt
 HgtI2n8U/Am3XAvPozM2RpiyxKKeGB5KKstzjjodfUX0Q9PTwjISUBXDPVAZVqPMjwt90ou6/Py
 yirnQxxJUWli3PfCJZ8DyJF583mMX0uVcVAguT6oqc9YCYhmnCFLeQHXMGyluYO1D84LndFuRX2
 nVRUfb9KHOmZLuQObYNqW8vcCXvfYQfeC7ObURvEMtDQVDT5VzzcMNzj/72r9CqIDQ/5kVf/Bnp
 DCozW78ISxx2pWjcqV9+gv60YECvc38g0xv/a7sOKNmJbBoogjD8IgzeBeWAVju5BURpfwnrIUN
 L+pYYGI3EPvuQk/mDWCxVmqTU/TzAtP1SxGu8sLJsrji566onE1l00EsQPB3mAUGJYb1EkXlq3a
 NWGsrrkqA4dPjPEMg=
X-Received: by 2002:a05:6402:2816:b0:640:93b2:fd1e with SMTP id
 4fb4d7f45d1cf-64555cd8cc4mr21660357a12.17.1764249650403; 
 Thu, 27 Nov 2025 05:20:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF4X2jw7lKUrC0VSwQWqFLab02VMT9E/qXYgLu35Aos+c181UH6b58dTLOfMnS++mkvY5wIPQ==
X-Received: by 2002:a05:6402:2816:b0:640:93b2:fd1e with SMTP id
 4fb4d7f45d1cf-64555cd8cc4mr21660325a12.17.1764249649989; 
 Thu, 27 Nov 2025 05:20:49 -0800 (PST)
Received: from [192.168.10.48] ([176.206.119.13])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-64751062261sm1735825a12.33.2025.11.27.05.20.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Nov 2025 05:20:48 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-rust@nongnu.org
Subject: [PATCH 5/9] rust: do not copy the SysBusDevice
Date: Thu, 27 Nov 2025 14:20:32 +0100
Message-ID: <20251127132036.84384-6-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251127132036.84384-1-pbonzini@redhat.com>
References: <20251127132036.84384-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.224,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
 rust/hw/core/src/sysbus.rs | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/rust/hw/core/src/sysbus.rs b/rust/hw/core/src/sysbus.rs
index 68165e89295..ec620639be5 100644
--- a/rust/hw/core/src/sysbus.rs
+++ b/rust/hw/core/src/sysbus.rs
@@ -78,7 +78,7 @@ fn mmio_addr(&self, id: u32) -> Option<u64> {
         assert!(bql::is_locked());
         // SAFETY: the BQL ensures that no one else writes to sbd.mmio[], and
         // the SysBusDevice must be initialized to get an IsA<SysBusDevice>.
-        let sbd = unsafe { *self.upcast().as_ptr() };
+        let sbd = unsafe { &*self.upcast().as_ptr() };
         let id: usize = id.try_into().unwrap();
         if sbd.mmio[id].memory.is_null() {
             None
-- 
2.51.1


