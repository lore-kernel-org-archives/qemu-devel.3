Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB263E7716A
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Dec 2024 19:14:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tMu2e-0007PT-6o; Sun, 15 Dec 2024 14:12:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tMu0F-0004m8-UP
 for qemu-devel@nongnu.org; Sun, 15 Dec 2024 14:10:08 -0500
Received: from mail-ot1-x32b.google.com ([2607:f8b0:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tMu0D-0001gX-6Y
 for qemu-devel@nongnu.org; Sun, 15 Dec 2024 14:10:07 -0500
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-71e2aa8d5e3so1827456a34.2
 for <qemu-devel@nongnu.org>; Sun, 15 Dec 2024 11:10:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734289803; x=1734894603; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xi4R9boo11xQYFP7RbWeb0vhVfO/Fgh3TkVnelxmyDk=;
 b=uSF2T2bdNQyw5Gxz3t20pC//5nmARodOb+ugscxPvQvPhU5LVHEmKxvNhwd0SdyR+k
 gy1Ms+mQTuzWqUB9MvSuobVnLcTycxO+/Pic0xQxYnvbuEefgJ95dvfi4TlZpoR3wkvX
 tQZdcfA0+1zvNwU7ifHfYeMlnuTQWtQSHe4VGrtT3D2sXCe0JjCOGtVlEA/vPdwCFYzr
 RsrTCURw93uJwTNDotqUgEVBNrv1lb/phD0QnvLl5R+7KBCgqBTLRo5J+KtaIEyshIpJ
 p6Og9/gm0jXCsqi3lTsWYDav0tSXRgTDubT4aWtCOJ9EiyZ3mU8cbkmq1Y5qLOHDePGp
 mhmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734289803; x=1734894603;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xi4R9boo11xQYFP7RbWeb0vhVfO/Fgh3TkVnelxmyDk=;
 b=AV5SYR5Ido0WIuJTkKYZSWvOQpL6z9Mvmu/wbPFIeuD+BMwU66BBqiE0ZAuGpMGjRS
 nCrl022t9PrJVuzcKrLKXJqFP0CavNgHeDwyQzAcxV7xhZnF5v1dkXwtrE8hx2L0hPyg
 axJ/gyrHykNJwWZG2BDF4GlokRJQM4Ps2KHBGFNT+0tzLNiVGoUVKtpeVgGJGYRKl040
 ZIaHoqt3AALX/DqslpnNkm+xDvKeR70jv4SOsMaqvqjLCTI1MRhPiVE9dF5kSaivxvn+
 4RjkrWvO6bMuD9TRIcRlaPA4D0FjJO/NbkoTOT1Dcq/d5pwYRqrknXULkUQCUJzL9adr
 VDpw==
X-Gm-Message-State: AOJu0Yx5kDIEUSh5697tSlPnycgnphYuQUR8IFPhUyPpbkS/Ih1DeIlA
 WHgVzekpzCCYkEPvy16RmnbquSjBZ9lr7FFr/C1JMWQik+h044FaU8/NUBA6VOf3B7wNRWtnOEt
 KLlgEKgEB
X-Gm-Gg: ASbGncvKFrAtJXVHx95WehnUi7q0mfWGTU6/LElVnudGV9LUKefqu0FIvUyE2qdFob/
 dl28z7k01olfjY2n+C+JaezIm+O2AF9D7b2mkQS82h58QnEupJq9v4PJQvyxhP0ZrbJv3HNhtgi
 lseEtTlqJ1fOfqrw/BnE+3+dj2Cb1chDr1qSiUf6XUsw++c2V6hCNkaB2/LV9QE+opyvD+7TW2w
 TDvl+UhIOVhub+6HWXf0pv440lD/dWJ6Fx80DVR3UrNM/tJTs/LOKq5iUyJFipd7s+WAxKixxCB
 z0nSlY2IalRoKfRW3cWTrWQ+owDDyAxIauIBn64wYz0=
X-Google-Smtp-Source: AGHT+IERyFKectWL3Yhb9Cfqn983oniF3orF/38OixBhS8UDpj5qjB1NRuna7RuklLJZ5fcRdLKjfA==
X-Received: by 2002:a05:6830:2713:b0:71d:eee3:fd26 with SMTP id
 46e09a7af769-71e3b82a1b8mr5133943a34.4.1734289803742; 
 Sun, 15 Dec 2024 11:10:03 -0800 (PST)
Received: from localhost.localdomain (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-71e4836f8c2sm1015316a34.34.2024.12.15.11.10.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Dec 2024 11:10:03 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 67/67] docs: Constify all Property in examples
Date: Sun, 15 Dec 2024 13:05:33 -0600
Message-ID: <20241215190533.3222854-68-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241215190533.3222854-1-richard.henderson@linaro.org>
References: <20241215190533.3222854-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32b;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x32b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 docs/devel/migration/compatibility.rst | 4 ++--
 docs/devel/virtio-backends.rst         | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/docs/devel/migration/compatibility.rst b/docs/devel/migration/compatibility.rst
index 5a5417ef06..c787f53738 100644
--- a/docs/devel/migration/compatibility.rst
+++ b/docs/devel/migration/compatibility.rst
@@ -198,7 +198,7 @@ was done::
 
 The relevant parts for migration are::
 
-    @@ -1281,7 +1284,8 @@ static Property virtio_blk_properties[] = {
+    @@ -1281,7 +1284,8 @@ static const Property virtio_blk_properties[] = {
      #endif
          DEFINE_PROP_BIT("request-merging", VirtIOBlock, conf.request_merging, 0,
                          true),
@@ -395,7 +395,7 @@ the old behaviour or the new behaviour::
     index 8a87ccc8b0..5153ad63d6 100644
     --- a/hw/pci/pci.c
     +++ b/hw/pci/pci.c
-    @@ -79,6 +79,8 @@ static Property pci_props[] = {
+    @@ -79,6 +79,8 @@ static const Property pci_props[] = {
          DEFINE_PROP_STRING("failover_pair_id", PCIDevice,
                             failover_pair_id),
          DEFINE_PROP_UINT32("acpi-index",  PCIDevice, acpi_index, 0),
diff --git a/docs/devel/virtio-backends.rst b/docs/devel/virtio-backends.rst
index 9ff092e7a0..a6f9df4845 100644
--- a/docs/devel/virtio-backends.rst
+++ b/docs/devel/virtio-backends.rst
@@ -101,7 +101,7 @@ manually instantiated:
       VirtIOBlock vdev;
   };
 
-  static Property virtio_blk_pci_properties[] = {
+  static const Property virtio_blk_pci_properties[] = {
       DEFINE_PROP_UINT32("class", VirtIOPCIProxy, class_code, 0),
       DEFINE_PROP_BIT("ioeventfd", VirtIOPCIProxy, flags,
                       VIRTIO_PCI_FLAG_USE_IOEVENTFD_BIT, true),
-- 
2.43.0


