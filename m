Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94495CFD2F6
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Nov 2025 13:16:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vObqQ-0002YT-NU; Thu, 27 Nov 2025 08:15:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vObqL-0002Xi-K9
 for qemu-devel@nongnu.org; Thu, 27 Nov 2025 08:15:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vObqI-0001A4-81
 for qemu-devel@nongnu.org; Thu, 27 Nov 2025 08:15:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764249323;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nudtLyfLpePiOGbflXoAvWZ1qHAsYssnltuIZxxkF4g=;
 b=FpgMPe5xANSk2O74w7r6AEnX8lIZo+FsIAaf/iClPOkoQ72d8Kk8TGhjWf75wjsLPShtTX
 zHZaWzmkVotZZtK6gScHYNVLfKYfhGgRtMco5yuZvbFZMFeBRtGyqK2gz4oxUGva7eaYyX
 z7r80xiL7tdl7nu5ZK8dfRoP/vT2Pzw=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-662-HBQEjPHeNKeAkWEMq4kyeA-1; Thu, 27 Nov 2025 08:15:21 -0500
X-MC-Unique: HBQEjPHeNKeAkWEMq4kyeA-1
X-Mimecast-MFC-AGG-ID: HBQEjPHeNKeAkWEMq4kyeA_1764249321
Received: by mail-ed1-f69.google.com with SMTP id
 4fb4d7f45d1cf-640bae7d83aso957828a12.2
 for <qemu-devel@nongnu.org>; Thu, 27 Nov 2025 05:15:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1764249320; x=1764854120; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=nudtLyfLpePiOGbflXoAvWZ1qHAsYssnltuIZxxkF4g=;
 b=DAMoHQhJhNK/Vu+uZqbxcvLegANYEfXHXMV2ukuqDyOHnAjqz5rzLdZ8KTmhV3Sbqv
 HvJPOBvA7korhoyD2OY3IANtKbYP37+Z2mR1KQPAU+VMr1LIpV3fcAwzgKw/g2F5BseD
 UMVcDXLI1ACzaeapaSrAW3iiyEIjNgW+6wMss5ujJWpOYaFhTE+FAHAwDqP4elaQh/Um
 cxeUhBn1fYalXR212cmIYgwoaH72sye/pXjDuMPKVxECEBOVNDYTE2fPCX8T8POAlAK5
 ZAJ43qTEazgAGrjKKudfP+FaGMke0AGWc3lhDb8heYWo1d1BlMVjaFRfVaZcopwONmsd
 xAzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764249320; x=1764854120;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=nudtLyfLpePiOGbflXoAvWZ1qHAsYssnltuIZxxkF4g=;
 b=Dj/xnBnpGESepuLseBtcVUTcxWSi4NgHlMyQGjLJ66duo4PRqiSJ72YCni/794Hbvb
 Yv1TQD6pQcXtyIZwbv5B2EIxU19dO+DhVy6xGlfNoXOpKxk5Zg+2DZOcSjrs2u4/VhUi
 dc7FxfG5n3+xJW934InIg3REucrUFWzl37XyICBUO2O6Z01WGpF+5CUIlvzD4VrdZQIK
 DRLWWKa56GogqFFfexSOZz7AMafTmHMVmDQ4T4T/R7BI2AfH0nhJ7HEsg3yuUPBRMWjk
 8WeRz1iHwF5+r5O8rGWJuquWiloHKcq2CAgg2C9+ijKpE8Gm62wexXOhICQeAMixYHFH
 q0Vw==
X-Gm-Message-State: AOJu0YyoKW5NPybXd4wMJ1/6+cNcfCa3GIYajJU9saFogmRW05yqlJ0D
 qCZrczXiMVUG6uUCfRtssKa/OXGFBIKqEnZkDcvZ/9gQTgJg/lZyuynZdkNQXvdBnUMslMUCnUk
 E1esaTKuYLIpKfkfx0cfajQipqDOS5C7sE/ciqMe1/1Grebl8Da/I2wlo6IyeHFLRbU2JrpS6AG
 JoyrWqkHO+rJ+Z+BVl2E/wKbunp/Sq7vVMCAyq9g7Q
X-Gm-Gg: ASbGncuqeZ94bcQIo+OgxAslWAGgkhGM1FNznv0XAanS9eoVIzhgfDImw61eazAWFvZ
 GMlM0X8r01g2XrMweSYCDjWD51surIzmTCiQTEt7KBjbAWXlLXYlGfMQSFhahaAe4D3WLYmeSwG
 CSBiF6imF7Z4rkrcednM9vE+Kms5PRkK+/hQBfpTrQxJUrQjrfpgNRbdqG4IVSgXnhViN4jWDeo
 3UuYLiPtIxOsz9T/XsA83xsjcQnR/2sOPkXaUX20wo9uY0EWUdvC+PcjazgKx6QALor7Er+jQ5N
 j4JqYx64F6pwdkF+qDsnZ5iyfhacU5rGfNnfUciMgOZVmcEmyoihbbiFYyTo6FPXZfzG0WfHoWu
 tJdaWCY+EVC8K+eaOTNjSmT3m8eXcBAr3ho5gOtGBdDSaAn4BqLv7OFCoNfMB4sUq2zYjlwjmfD
 cvOAY7w/Fhso6ptJQ=
X-Received: by 2002:a05:6402:27c8:b0:634:b7a2:3eaf with SMTP id
 4fb4d7f45d1cf-64554664dd9mr22772820a12.18.1764249319870; 
 Thu, 27 Nov 2025 05:15:19 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHq+3JBYq0VHEnpAKXaHuGEjh6pmImjM+gkuEc+MaGrfw/Wg0MQ/6FuuWSaUFa7LPFNqhgarg==
X-Received: by 2002:a05:6402:27c8:b0:634:b7a2:3eaf with SMTP id
 4fb4d7f45d1cf-64554664dd9mr22772786a12.18.1764249319398; 
 Thu, 27 Nov 2025 05:15:19 -0800 (PST)
Received: from [192.168.10.48] ([176.206.119.13])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-647510615c0sm1541102a12.30.2025.11.27.05.15.18
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Nov 2025 05:15:18 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 01/28] include: move qemu_irq_handler out of typedefs.h
Date: Thu, 27 Nov 2025 14:14:48 +0100
Message-ID: <20251127131516.80807-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251127131516.80807-1-pbonzini@redhat.com>
References: <20251127131516.80807-1-pbonzini@redhat.com>
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
 include/hw/irq.h        | 2 ++
 include/hw/qdev-core.h  | 1 +
 include/qemu/typedefs.h | 1 -
 3 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/hw/irq.h b/include/hw/irq.h
index 291fdd67df4..81b81ed493c 100644
--- a/include/hw/irq.h
+++ b/include/hw/irq.h
@@ -8,6 +8,8 @@
 #define TYPE_IRQ "irq"
 OBJECT_DECLARE_SIMPLE_TYPE(IRQState, IRQ)
 
+typedef void (*qemu_irq_handler)(void *opaque, int n, int level);
+
 struct IRQState {
     Object parent_obj;
 
diff --git a/include/hw/qdev-core.h b/include/hw/qdev-core.h
index 2caa0cbd26f..9802b6896de 100644
--- a/include/hw/qdev-core.h
+++ b/include/hw/qdev-core.h
@@ -8,6 +8,7 @@
 #include "qemu/rcu_queue.h"
 #include "qom/object.h"
 #include "hw/hotplug.h"
+#include "hw/irq.h"
 #include "hw/resettable.h"
 
 /**
diff --git a/include/qemu/typedefs.h b/include/qemu/typedefs.h
index 4a94af9665a..cf931ff549c 100644
--- a/include/qemu/typedefs.h
+++ b/include/qemu/typedefs.h
@@ -132,7 +132,6 @@ typedef struct IRQState *qemu_irq;
 /*
  * Function types
  */
-typedef void (*qemu_irq_handler)(void *opaque, int n, int level);
 typedef bool (*MigrationLoadThread)(void *opaque, bool *should_quit,
                                     Error **errp);
 typedef bool (*SaveCompletePrecopyThreadHandler)(SaveCompletePrecopyThreadData *d,
-- 
2.51.1


