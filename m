Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A37DEE8FDD9
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Dec 2025 09:24:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vZQQ7-0002W0-43; Sat, 27 Dec 2025 04:17:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vZQQ5-0002Vc-NH
 for qemu-devel@nongnu.org; Sat, 27 Dec 2025 04:17:05 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vZQQ3-0002Mn-68
 for qemu-devel@nongnu.org; Sat, 27 Dec 2025 04:17:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1766827022;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=03LjKavoBUjIfBjE/BXbpgOkNcgb3xBq2RtXn1ZaDnM=;
 b=BO53h8k9PpL6/JhjPrZ8CjB9Bau8seSBVke5RdnneyGAXPXpI9WSOPiaKrVd37dIEyVRP/
 7bbZyomlQHXQQWICuzwhgxR34e0hBT/+OQ4+Wsh4ZV8XhiNOSIDDFCr3+10aCTd+g32fee
 8fGtZjgjCjYdXIB4tfRB56Bxer2frdQ=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-397-2zYGjfa1PEmPOEHN4yfAjg-1; Sat, 27 Dec 2025 04:17:00 -0500
X-MC-Unique: 2zYGjfa1PEmPOEHN4yfAjg-1
X-Mimecast-MFC-AGG-ID: 2zYGjfa1PEmPOEHN4yfAjg_1766827019
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4779b3749a8so54865555e9.1
 for <qemu-devel@nongnu.org>; Sat, 27 Dec 2025 01:17:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1766827019; x=1767431819; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=03LjKavoBUjIfBjE/BXbpgOkNcgb3xBq2RtXn1ZaDnM=;
 b=KAvWS53BQzvmnxNhyj20MciK9j3U86QzvJVg4Tr12Ig2H0sZrmWsSebVRk3v2f60oa
 nJRFMseQgAj93h1Eim/a06vB+hITbHrftYuHv4nCCSlkgRwE9obEFZh8p8WVoNQdo0Gg
 mSfuCNRyUsdaYpaATqtlsjU0tgtLga87N/UhnIXPkK1jczwvWISR6jpMbOSnOJl90yfX
 WQyzxl9dd6X04oP+GiwPYanvxKL44tiaPRjiRX7fm34K2sxBqMQZDdQqPh9buhRL79df
 EofOfzPWsqFbNy7rFle8IRMZyoAz16VJRv1hUSkES+OorqJmOZzRNq4hBAoEW8F1B9p+
 2PUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766827019; x=1767431819;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=03LjKavoBUjIfBjE/BXbpgOkNcgb3xBq2RtXn1ZaDnM=;
 b=rm14E+6GZyrupiSF8QmnrB/iPS9B4LaxP3klpRJQA+pepsKnFN7ay5VXV4WHBoZ5Se
 U++/jdnMy0QB8FRbM+9O0K/znSfeRLkmZdoRH7Uqj7pMnoU7nSJgOninwk3H8/LmIKmy
 tY3JcLHjdjE48GmIj2h2E0KepTSeXlCMEn5qWlSOaaNZBhtyAJ4KvUhTAUlviADii6lc
 FzC855F1mcoexKaOxi3Y6YIu2qKGuvjWDvEjd60u6jqkXAkl/GfNaPd/hkXD4LpSlj3j
 xMCke0rJaPtOkXzoKSgYOMIrgMnWjAtNvRsBKhhZAQ+eCRDieeK2ylSRE2C0ApBGmdgB
 QbEQ==
X-Gm-Message-State: AOJu0Yww8WtiDz/IH/a8NUCO1Xbl4Q2o/WGKF2S4Fxv7X8bDhlk7YGg7
 Ii0dVM1RpTcsEv95RCWni8jE3xFZGGmEVyimIbZjmulzqxK3Y9vvVLzGmucs81/AkR6GqKcscOB
 I4sLaTbGhkFmuOfUrgzGGqL9H45qWZE3A0Cbv6ljsV3YJj5TOD2zbUxsVyCVPnuAPTwDbe1+Ggp
 8VOJ9LQXWZhnoJAUkY0+5MTIwkMg88n8rwqLzSSGbR
X-Gm-Gg: AY/fxX59cRQgIrGP6CTAar/ScwqYXlbCSA4eMMGJK6Gvf+mwq+3f9Ozmch6hjA7fZ27
 qk78TpbefCCcDVFjCVBgcrVwiua9340nSa1yp0ZNGuPARVqJEEj9QjnYtbSyMcaG/Em9HDfFt5g
 OozQfzt11BxDqVBAhNJElWbVcIfXsVdJIiX0pTAAWAjv+C81T29wseDqZYdTcqO5LUkPy7ZtVr0
 jQsjOZTJ+AcmWWy6IStftnO57Ev5x+wIiLuS8irCC7HSZjJ4zO6I0PpjuI5j2MH9xg6PYy+iPK5
 0GydEraPCu/T3SDIuyqYeI+aI6WZhyhzHQ5GZswxQTJaKm3dtpov+41eJaG2DqNMDZT9KLO8KU9
 2HhknfxZydF5oGOfZWqSq7MkgcwG852MiHPcgg75DhGsAbYyCjuwXdf5/BUASTja/1kdB49b5l6
 S7OBH/j2XX9I+Br3M=
X-Received: by 2002:a05:600c:3508:b0:477:1bb6:17de with SMTP id
 5b1f17b1804b1-47d19590bbemr281604955e9.30.1766827018712; 
 Sat, 27 Dec 2025 01:16:58 -0800 (PST)
X-Google-Smtp-Source: AGHT+IESVdqQyUcEecQmt6CU17+78/iPVUZiAae4Cl57sMP+5mW5LRgK5vawlpr9SMJHNZtac+uYCA==
X-Received: by 2002:a05:600c:3508:b0:477:1bb6:17de with SMTP id
 5b1f17b1804b1-47d19590bbemr281604715e9.30.1766827018174; 
 Sat, 27 Dec 2025 01:16:58 -0800 (PST)
Received: from [192.168.10.48] ([151.95.145.106])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47be27c2260sm474493165e9.15.2025.12.27.01.16.57
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 27 Dec 2025 01:16:57 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 019/153] include: move hw/qdev-dma.h to hw/core/
Date: Sat, 27 Dec 2025 10:14:06 +0100
Message-ID: <20251227091622.20725-20-pbonzini@redhat.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251227091622.20725-1-pbonzini@redhat.com>
References: <20251227091622.20725-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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
 include/hw/{ => core}/qdev-dma.h | 0
 hw/usb/hcd-ohci-pci.c            | 2 +-
 hw/usb/hcd-ohci-sysbus.c         | 2 +-
 hw/usb/hcd-ohci.c                | 2 +-
 4 files changed, 3 insertions(+), 3 deletions(-)
 rename include/hw/{ => core}/qdev-dma.h (100%)

diff --git a/include/hw/qdev-dma.h b/include/hw/core/qdev-dma.h
similarity index 100%
rename from include/hw/qdev-dma.h
rename to include/hw/core/qdev-dma.h
diff --git a/hw/usb/hcd-ohci-pci.c b/hw/usb/hcd-ohci-pci.c
index e180e96b5f1..25c400698ee 100644
--- a/hw/usb/hcd-ohci-pci.c
+++ b/hw/usb/hcd-ohci-pci.c
@@ -25,7 +25,7 @@
 #include "migration/vmstate.h"
 #include "hw/pci/pci_device.h"
 #include "hw/sysbus.h"
-#include "hw/qdev-dma.h"
+#include "hw/core/qdev-dma.h"
 #include "hw/qdev-properties.h"
 #include "trace.h"
 #include "hcd-ohci.h"
diff --git a/hw/usb/hcd-ohci-sysbus.c b/hw/usb/hcd-ohci-sysbus.c
index 5c3434153db..8224fb88628 100644
--- a/hw/usb/hcd-ohci-sysbus.c
+++ b/hw/usb/hcd-ohci-sysbus.c
@@ -26,7 +26,7 @@
 #include "hw/usb/usb.h"
 #include "migration/vmstate.h"
 #include "hw/sysbus.h"
-#include "hw/qdev-dma.h"
+#include "hw/core/qdev-dma.h"
 #include "hw/qdev-properties.h"
 #include "trace.h"
 #include "hcd-ohci.h"
diff --git a/hw/usb/hcd-ohci.c b/hw/usb/hcd-ohci.c
index ea3d5d2bd14..588cecef14d 100644
--- a/hw/usb/hcd-ohci.c
+++ b/hw/usb/hcd-ohci.c
@@ -33,7 +33,7 @@
 #include "hw/usb/usb.h"
 #include "migration/vmstate.h"
 #include "hw/sysbus.h"
-#include "hw/qdev-dma.h"
+#include "hw/core/qdev-dma.h"
 #include "hw/qdev-properties.h"
 #include "trace.h"
 #include "hcd-ohci.h"
-- 
2.52.0


