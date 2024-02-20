Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30F58C5475B
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Feb 2024 15:08:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcRjk-0004LK-KN; Tue, 20 Feb 2024 10:08:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rcRjj-0004KX-5r
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 10:08:47 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rcRjh-0003mS-Iy
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 10:08:46 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-412698ac6f9so10493695e9.0
 for <qemu-devel@nongnu.org>; Tue, 20 Feb 2024 07:08:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708441723; x=1709046523; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DoQEZxzYJVlRUc/fG+BPKnGGJWFI0zTUpD/ARH6eLL4=;
 b=KP0m2D4Ed2bg28mqz31xflJtUHaMQ5c6BRiduFN3AP8h+K4g3w+GKRvfpIVcEZkEuk
 k4cAw+lYv4Zvrhe44+BQk+/hiv/2BwODXh/6TyE0wh6Xx7+Ba2O+Vb0c4eMGWCTRbrQa
 cw9jKW+JhoCo7PQ6HUFvX9kVodkQu9p9M3Vmssw7LXOQQZzLrFY4zqGDVistZfirk25y
 JfO1SngW8E9F76ySZROqgAHn5ki6hetr0q/5Rkew1WTjAROwTtyc4TpQgEvwrIq9eiyP
 c0VKg5UbVr5fbN+CRglqRCUU9ZkDVufBq6QWTumVewRxrma3KyPUUsw0kwKEFAzcq7xg
 hmGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708441723; x=1709046523;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DoQEZxzYJVlRUc/fG+BPKnGGJWFI0zTUpD/ARH6eLL4=;
 b=bKGCgADiOqLO2XJDAV74r71ibSShljbWTifVMXCC8V5EJ3eagmtb7gpGd8RazvfTWJ
 EePn0IfPFLqiQOESVmRy1daNIGrP7uTsF+PMU9HJ3BxELtMej2nCiQt4MAXzuBcmiZ5n
 5JWFQa+rXXEsvhYWhfgOVFAZjFRKo+S1RY3AiR4x27X8tbIyNEqJF0GSUWPQWhOXJS9p
 S70u0fVj5DGMeld8vThX0exHJeC/CktN/C9kYEG7L/+QEzKjzZBBIRuyRkjnPtZpZ5vG
 YVq37HyhGGfgHR+bepvsaJ9V3+kgCkdbyygKZUm5bieJYpA78/xOOM/UA4jcBHwZ8rdW
 /c/A==
X-Gm-Message-State: AOJu0Yw1t8eubmeEVZYkX85bcw4FgSXKUZ/M9SzHDedPM52JVCsmn1WX
 /OA8ImrOdfkAylmZypzjlUm6/z7m86wpZaLAlzihntv0A88l3O09EWZgScEJXduY8K15kinkAdN
 V
X-Google-Smtp-Source: AGHT+IFRgFHA7ibg2iRgyjF2izbBJs5D33IFOcLFWt4tqEfyIBON1t7f/Mq3qYZjvAa+TLMTqVKcBA==
X-Received: by 2002:a05:600c:3513:b0:412:5f5f:1729 with SMTP id
 h19-20020a05600c351300b004125f5f1729mr6633567wmq.20.1708441722947; 
 Tue, 20 Feb 2024 07:08:42 -0800 (PST)
Received: from m1x-phil.lan (mek33-h02-176-184-23-7.dsl.sta.abo.bbox.fr.
 [176.184.23.7]) by smtp.gmail.com with ESMTPSA id
 s10-20020a05600c044a00b004122fbf9253sm14710257wmb.39.2024.02.20.07.08.41
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 20 Feb 2024 07:08:42 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 qemu-s390x@nongnu.org, qemu-ppc@nongnu.org,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 1/4] hw/nmi: Use object_child_foreach_recursive() in
 nmi_children()
Date: Tue, 20 Feb 2024 16:08:30 +0100
Message-ID: <20240220150833.13674-2-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240220150833.13674-1-philmd@linaro.org>
References: <20240220150833.13674-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Replace object_child_foreach() and recursion by a single
object_child_foreach_recursive() call.
Propagate the returned value so callers can check it.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/core/nmi.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/hw/core/nmi.c b/hw/core/nmi.c
index a7bce8a04a..f5220111c1 100644
--- a/hw/core/nmi.c
+++ b/hw/core/nmi.c
@@ -31,8 +31,6 @@ struct do_nmi_s {
     bool handled;
 };
 
-static void nmi_children(Object *o, struct do_nmi_s *ns);
-
 static int do_nmi(Object *o, void *opaque)
 {
     struct do_nmi_s *ns = opaque;
@@ -47,14 +45,13 @@ static int do_nmi(Object *o, void *opaque)
             return -1;
         }
     }
-    nmi_children(o, ns);
 
     return 0;
 }
 
-static void nmi_children(Object *o, struct do_nmi_s *ns)
+static int nmi_children(Object *o, struct do_nmi_s *ns)
 {
-    object_child_foreach(o, do_nmi, ns);
+    return object_child_foreach_recursive(o, do_nmi, ns);
 }
 
 void nmi_monitor_handle(int cpu_index, Error **errp)
@@ -65,10 +62,9 @@ void nmi_monitor_handle(int cpu_index, Error **errp)
         .handled = false
     };
 
-    nmi_children(object_get_root(), &ns);
-    if (ns.handled) {
+    if (nmi_children(object_get_root(), &ns)) {
         error_propagate(errp, ns.err);
-    } else {
+    } else if (!ns.handled) {
         error_setg(errp, "machine does not provide NMIs");
     }
 }
-- 
2.41.0


