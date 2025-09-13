Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A213CCAC58E
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Sep 2025 08:19:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uxLMu-0001ZN-7H; Sat, 13 Sep 2025 04:12:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uxLMW-0000UB-7F
 for qemu-devel@nongnu.org; Sat, 13 Sep 2025 04:12:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uxLMT-00059z-8p
 for qemu-devel@nongnu.org; Sat, 13 Sep 2025 04:11:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757751115;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zW8Yud9mAz5khsnZa/hN0GUGz/pacwIoGiVNpwJ228s=;
 b=GT08JWZL8y/aYwKnHZ+eZc7Ym2rgUrh1JInBNDwaSknhyNokqsetHdzr4O/abOPwcbpQ4o
 TuV8du1mHSkEm4YxIseW5X3wFxjKY9SyLKKp+DE/wmgAqqkbUa/538s4WQie3/rZOdiDln
 K5TWWs5s2lf1LXG4pFjnPUmzAnaUlGg=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-650-BnCo_C4sONORENoWAxB4hw-1; Sat, 13 Sep 2025 04:11:53 -0400
X-MC-Unique: BnCo_C4sONORENoWAxB4hw-1
X-Mimecast-MFC-AGG-ID: BnCo_C4sONORENoWAxB4hw_1757751113
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-45de13167aaso24862275e9.1
 for <qemu-devel@nongnu.org>; Sat, 13 Sep 2025 01:11:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757751112; x=1758355912;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zW8Yud9mAz5khsnZa/hN0GUGz/pacwIoGiVNpwJ228s=;
 b=qwE//GSRJ2NWsIsoVHBkfxjXZLFla9HWohC4/EL3Z9nw92EUYXgrE/NvRO0a/N9mOu
 6eGV1VtSjRZUm5SpSbn7yoWCku28E/Nj2MFF/6zLZbYpegLtQBr0g7x/Zsxnvnx6ldyX
 sngEBhQe8ggyRasV23AYwdJ6uPlXBz62zU35BRbNm/z3gA1/ersWOZgkXMLNF+nWSjHN
 09pGF6VHIJl6zSdsBzk/Dexib6sJ0tVkyYhEH0UthohWUaCf+g8sRF3lX74X2MFI8liG
 fG55E21n8X2mGY4EQ3qL4FYbGdBfd90Bg464fq7JnTi7eGRgqw3bnkT+dy7kXjxzOQ9X
 FsYA==
X-Gm-Message-State: AOJu0YwvKxaQg+AfBhZPhCaoQ1CMc8EsCH+ZvZDoIjKDxsrNXGv/QN4v
 z4PPlswlx9p7DOqAlk30Sv1kIEuYlYx4+cnjlXifb7D3+46fbZO9BceozQ7GEbqxgA/uKL4hgZ4
 LhyPgrAy6TQ73elemEzBuXqPg2eoI/v32Q8AMe2BN/ffu0mWm7tGITp/LWonnmMMCCI84+J9WCG
 k9Y4AJ879Tj5NxJN6y+xCx1L0713Fk1sTRXQXrEfuT
X-Gm-Gg: ASbGncvfCIj4A4yvgj7tnYT9VXCuLuz7VhEzZLukOyGcq3se8Zh462KSMQhnKi8eeaP
 hY0mim/aefhyf1kUmrr7z7rHXpipyaNjHNlPK2SiJJtJpYRGblNtXgE9ixnCEytWsTkK9FUKJ+y
 J+JoIo9UJh1MqxzD2e8e1Zv9DFTRLfFqbLAi6M4FOtouSd8LBaunU67djNk+sw+TDdq4CAXhIsn
 cIrf4gVNv1V9k5m9XOjNIUOysH8Udvqo9qKdfUQWeQ9YQ0Q+zYJGrQsY3Tn8SgqWcvbm4cUFPbs
 lW7MAYzlcgA3nHa4sK/b2FV+hzu7iK6/gMjFof6rXlmWl+t83ZNhogtyjCzwkdq5LJOTGAmB+Ff
 j4aDeswqHx7ndsbqZzAqGrmnM+VQGCzjAmlqW6/N84ww=
X-Received: by 2002:a05:6000:1a86:b0:3e1:3b1c:2c13 with SMTP id
 ffacd0b85a97d-3e765a172f2mr4680202f8f.59.1757751112225; 
 Sat, 13 Sep 2025 01:11:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG9lBazQwUh25ENrxUeIK1AddIkDmeJSrUlXVEGspaeZlCZmZZ40u43eBx130M32qXg0YRlnQ==
X-Received: by 2002:a05:6000:1a86:b0:3e1:3b1c:2c13 with SMTP id
 ffacd0b85a97d-3e765a172f2mr4680185f8f.59.1757751111792; 
 Sat, 13 Sep 2025 01:11:51 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.56.250])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45e016b5c5dsm93762205e9.14.2025.09.13.01.11.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 13 Sep 2025 01:11:49 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 45/61] rust/hpet: drop now unneeded qemu_api dep
Date: Sat, 13 Sep 2025 10:09:26 +0200
Message-ID: <20250913080943.11710-46-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250913080943.11710-1-pbonzini@redhat.com>
References: <20250913080943.11710-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Link: https://lore.kernel.org/r/20250827104147.717203-18-marcandre.lureau@redhat.com
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/Cargo.lock                | 1 -
 rust/hw/timer/hpet/Cargo.toml  | 1 -
 rust/hw/timer/hpet/meson.build | 1 -
 3 files changed, 3 deletions(-)

diff --git a/rust/Cargo.lock b/rust/Cargo.lock
index 021ce6dd48c..c407029afed 100644
--- a/rust/Cargo.lock
+++ b/rust/Cargo.lock
@@ -93,7 +93,6 @@ dependencies = [
  "common",
  "hwcore",
  "migration",
- "qemu_api",
  "qemu_macros",
  "qom",
  "system",
diff --git a/rust/hw/timer/hpet/Cargo.toml b/rust/hw/timer/hpet/Cargo.toml
index 68e8187bb82..08bf97af553 100644
--- a/rust/hw/timer/hpet/Cargo.toml
+++ b/rust/hw/timer/hpet/Cargo.toml
@@ -17,7 +17,6 @@ migration = { path = "../../../migration" }
 bql = { path = "../../../bql" }
 qom = { path = "../../../qom" }
 system = { path = "../../../system" }
-qemu_api = { path = "../../../qemu-api" }
 qemu_macros = { path = "../../../qemu-macros" }
 hwcore = { path = "../../../hw/core" }
 
diff --git a/rust/hw/timer/hpet/meson.build b/rust/hw/timer/hpet/meson.build
index 3b94d5ec0a7..8ab26630d95 100644
--- a/rust/hw/timer/hpet/meson.build
+++ b/rust/hw/timer/hpet/meson.build
@@ -5,7 +5,6 @@ _libhpet_rs = static_library(
   rust_abi: 'rust',
   dependencies: [
     common_rs,
-    qemu_api_rs,
     util_rs,
     migration_rs,
     bql_rs,
-- 
2.51.0


