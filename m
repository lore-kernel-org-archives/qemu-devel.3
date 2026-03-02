Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5446AD58E7F
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2026 08:45:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vwyte-00023c-CL; Mon, 02 Mar 2026 03:45:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vwytB-0001i5-Ao
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 03:44:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vwyt5-0001XV-R5
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 03:44:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772441061;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JruPiL/RMqNrXj7flD5Mqv0Tag1Q1v6iCWYNayccrwU=;
 b=CKDeKOIiqTEgUU1UYQ9lAPeFfG0mAfsFHmWFfJz/+32yRyaDriBchQA/Mm4Pomk10Q2tya
 WLz+fl949vnXmIjDR/3jAOKH27H0h+PpR0HTAqR/vzGVHKPwD2v8eaMggRkyfgBK0JdnNd
 2efPf724v3YP1qFCfkIntUMN/o8hg2Y=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-317-VFzA-QnfM22Aa4a3R_rqrQ-1; Mon, 02 Mar 2026 03:44:07 -0500
X-MC-Unique: VFzA-QnfM22Aa4a3R_rqrQ-1
X-Mimecast-MFC-AGG-ID: VFzA-QnfM22Aa4a3R_rqrQ_1772441046
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-439b699b9a6so698900f8f.3
 for <qemu-devel@nongnu.org>; Mon, 02 Mar 2026 00:44:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1772441046; x=1773045846; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JruPiL/RMqNrXj7flD5Mqv0Tag1Q1v6iCWYNayccrwU=;
 b=lsj5dSFbDB20uHcgGf8I1CDW1Jfk1A8s/yHWHSKULi84ZUPS0U0LEYvPcxFXtNcvBG
 t377kjkK6QF7CpzH1D2YhDvMYr5zHg/Thn2Hh8t5KlMsV9OwadMeWNx0sNACwYJ2B9Si
 SgI/XQrdm84tWcdf13bB38vUBqqaCGl37mEn7DlQE1Q12vr0ATp5NyIVFE7mKrHSTtft
 tgtYAxesX+fSAEMYnCUkm5Pjg4lPn9VKRW0epGgnfVV1qJ0/LYlyFpvZR3vEp6NwXfa7
 VkgLQtsrfn0oCbMwqL2+mO2kScofxiu78RKcc80OJghfO3cxHDVtaia88mRv2aaGRKt8
 Xrxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772441046; x=1773045846;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=JruPiL/RMqNrXj7flD5Mqv0Tag1Q1v6iCWYNayccrwU=;
 b=bdCa2K+z7TdIKpNE32Be15ZkHdDL0RAhEppBEGp6QWmYx+W+DXsxHk4NKI95rMD2eP
 L7CsxW+xD+vm39S66hj9qgWYYEsomOTzqSOcAxUSDRl28gXC34BYhB4w048TsWmpGF3p
 N95m0OWnNep1NtcCDZOyiLfaz/BCtOROtZZOSelaJgVYFB4ArDnXfs9rU/C3CG1ezvyE
 wru+vBSX070FAC6CpUj4aRZZGL1Q46NEoFhykHa2BE0c2nUE7OTdpO1pM9BYQ3vYuntB
 D0g6IKqqz6tk3BEAsBYx0qVH2v7ffwyskUu1B2sx6IUjl/yqr7Gc2ddZ9FJC/wRCDuKC
 0ViA==
X-Gm-Message-State: AOJu0YyyjHSxEm5mNrjcphOdXjVpmJoRYHpJgJSkTJGfDV7Sn5G5elWP
 p00Lr6B2qhQtpZGcOF0toeja4/4U73IiFPm1Aa1KZ/Pc40G3CkmEKiMhimOYa0aXFy+I4UvTeoO
 Tzrs9CRntfsMiFjhkLgDqbQoJkK3GwPKAukvSplAMkBFOALce877g5UN3nep16yysGgrUNzVCCI
 eaiVD56kywUTYHTNQCyHOyI0TQE7sgSuggJRwSnUBp
X-Gm-Gg: ATEYQzyeV5uY68DV/ipELRA+61flSJw2BjZOcH6V9TiIkfMjoZ7xa25mFFiVNNxC5A5
 bX9ctlo4xI5uuSbpG9z/MVwL3zJ5AJvMxP8WOku63lGN2Tn6AFdSyVOxf6EKBK3esYjlNKG1F/Y
 Sz4eUcQFcfAlLFl30ERwvqrqXYIgCSq3Ofwb6FjP/c885MnuK4lDKEEl8N/KVP8KSBzzjoaoktG
 2Pvl28V1zKJZvunicRrrItQaV/94+30TCgIQ1Dc7wUSnIArnkWm18u5D73soiWI9Kjod0DTsATi
 xbRNJowZHtLg8f8sbOBWIVWqtW1zBwtACwAqhSBUjczxf0YzJpYRt9repIk3NVNgAuwwK1bh/Jk
 nWkpR04UMWYjO5q/xPJwb71YeM6i23DipdPR2rPdfWeERZw+IUys3n6sGd7MMY0Re7WZkcFYGRL
 zUE9DVtxaqoH9Cinv02T3hWHUz/d0=
X-Received: by 2002:a05:6000:40ce:b0:435:a3b9:9b8 with SMTP id
 ffacd0b85a97d-4399ddf8063mr21269457f8f.24.1772441046039; 
 Mon, 02 Mar 2026 00:44:06 -0800 (PST)
X-Received: by 2002:a05:6000:40ce:b0:435:a3b9:9b8 with SMTP id
 ffacd0b85a97d-4399ddf8063mr21269386f8f.24.1772441045445; 
 Mon, 02 Mar 2026 00:44:05 -0800 (PST)
Received: from [192.168.10.48] ([151.95.144.138])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439b130abfasm10459937f8f.34.2026.03.02.00.44.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Mar 2026 00:44:03 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PULL 008/102] whpx: preparatory changes before switching over from
 winhvemulation
Date: Mon,  2 Mar 2026 09:42:03 +0100
Message-ID: <20260302084338.473368-9-pbonzini@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260302084338.473368-1-pbonzini@redhat.com>
References: <20260302084338.473368-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -8
X-Spam_score: -0.9
X-Spam_bar: /
X-Spam_report: (-0.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.012, RCVD_IN_VALIDITY_RPBL_BLOCKED=1.188,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Mohamed Mediouni <mohamed@unpredictable.fr>

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
Link: https://lore.kernel.org/r/20260223233950.96076-8-mohamed@unpredictable.fr
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.h               | 2 +-
 target/i386/emulate/meson.build | 1 +
 target/i386/mshv/meson.build    | 4 ++++
 3 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 9f222a0c9fe..065613722f1 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -2286,7 +2286,7 @@ typedef struct CPUArchState {
     QEMUTimer *xen_periodic_timer;
     QemuMutex xen_timers_lock;
 #endif
-#if defined(CONFIG_HVF) || defined(CONFIG_MSHV)
+#if defined(CONFIG_HVF) || defined(CONFIG_MSHV) || defined(CONFIG_WHPX)
     void *emu_mmio_buf;
 #endif
 
diff --git a/target/i386/emulate/meson.build b/target/i386/emulate/meson.build
index dd047c424a1..1bb35162498 100644
--- a/target/i386/emulate/meson.build
+++ b/target/i386/emulate/meson.build
@@ -7,3 +7,4 @@ emulator_files = files(
 
 i386_system_ss.add(when: [hvf, 'CONFIG_HVF'], if_true: emulator_files)
 i386_system_ss.add(when: 'CONFIG_MSHV', if_true: emulator_files)
+i386_system_ss.add(when: 'CONFIG_WHPX', if_true: emulator_files)
diff --git a/target/i386/mshv/meson.build b/target/i386/mshv/meson.build
index 647e5dafb77..3fadd4598a5 100644
--- a/target/i386/mshv/meson.build
+++ b/target/i386/mshv/meson.build
@@ -6,3 +6,7 @@ i386_mshv_ss.add(files(
 ))
 
 i386_system_ss.add_all(when: 'CONFIG_MSHV', if_true: i386_mshv_ss)
+
+i386_system_ss.add(when: 'CONFIG_WHPX', if_true: files(
+  'x86.c',
+))
-- 
2.53.0


