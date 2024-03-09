Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25A85C54791
	for <qemu-devel@archiver.kernel.org>; Sat,  9 Mar 2024 19:27:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rj2HT-0000JL-5n; Sat, 09 Mar 2024 14:22:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rj2HR-0000IJ-Pp
 for qemu-devel@nongnu.org; Sat, 09 Mar 2024 14:22:49 -0500
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rj2HO-0002UO-Nw
 for qemu-devel@nongnu.org; Sat, 09 Mar 2024 14:22:49 -0500
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-a3122b70439so407739366b.3
 for <qemu-devel@nongnu.org>; Sat, 09 Mar 2024 11:22:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710012165; x=1710616965; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dvPLYlBQAWmf1NvUY3LgRzjhJOxAzzfQLYDmKAk6+Eg=;
 b=uDPoWynIu2dvzNt3Ckd9UUX7TWwWMjKS5raMiqoWEz+PbBQJhFDo7WwtXUI6CdYlt8
 gZ39MX/Yvedvd8FgIbGYtlt7KxB8Z0uV7I1pph3F4mv1Tx3lNwZmgO7NLSG0L5l9y6dj
 6x+VMRCRdD3Ew7kx9Zll3o3qS2qtalPXpu5kD8e10HuGg/tgdPpYLIyTdDEKdEi4DBIg
 nB50eprbzaaIQp5tpddjTOpJxveydBA0zsJqstwSbfMq2SONQ0HZN+/7c6FyWNlWy50P
 mNqfmIFp+hOzPSEuqdPPPUy/qZ8aqmZ/B2WUhEmO65Z+vZxduzgjS9NWoKhLxSTgaYoy
 WONA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710012165; x=1710616965;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dvPLYlBQAWmf1NvUY3LgRzjhJOxAzzfQLYDmKAk6+Eg=;
 b=aDPNRI91dKi/6gjiT0p+gJJsxLnQ0TEbVtVLKY7qfZXHGhy3fumOKBSoRJOA/IlaUS
 lhz5es16XDrQqz9hFZ/Ukwe0R3ODl+Qy0Bi+o3i+cOyrAF7pVo81eI/++IOE06UWzENs
 smf9vfxrDUMW9J5n9YpwLpl+3Go6be5sq9rRLgRlD4sV5N0LoS7AqaRMw++jeOl9JUPv
 ViL83s1bdfiJiytYuM1yjKsMlyzn3l5XSlU+VfIql7zMMKBizXgv9d06eK6a004LFDlR
 5jTh8mo+RVdLFjBSCgFOqOwsqAhbNbBpxNginGA8Btozpsl/08xEV+4+u8VHzzIN9FGU
 Mu3g==
X-Gm-Message-State: AOJu0YyHDNQtbQ0s1tGLvi0HksoCI5nrILKcdChuizB9bZ5LLtQzXUYk
 tMYDOqS5vKCdQfbhJyg6xlhoIrr6eTdOBCu3Nd3n0zzd8jLw7Lca0uBrF+3TRY4OjvxDN8p/0R+
 8
X-Google-Smtp-Source: AGHT+IGN8k3Sm6baTXPm79wHAuc6ayShgYcEDLvukc8XhwEnOb6ThROAcunL2w6kbhV8Y4RYVCKWXg==
X-Received: by 2002:a17:906:c2d2:b0:a43:f22e:57a6 with SMTP id
 ch18-20020a170906c2d200b00a43f22e57a6mr1137454ejb.67.1710012164856; 
 Sat, 09 Mar 2024 11:22:44 -0800 (PST)
Received: from m1x-phil.lan ([176.176.181.237])
 by smtp.gmail.com with ESMTPSA id
 o23-20020a1709062e9700b00a44cf710cc3sm1170300eji.182.2024.03.09.11.22.43
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 09 Mar 2024 11:22:44 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 David Woodhouse <dwmw@amazon.co.uk>, "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PULL 05/43] hw/pci/msi: Restrict xen_is_pirq_msi() call to Xen
Date: Sat,  9 Mar 2024 20:21:32 +0100
Message-ID: <20240309192213.23420-6-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240309192213.23420-1-philmd@linaro.org>
References: <20240309192213.23420-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62a;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62a.google.com
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

Similarly to the restriction in hw/pci/msix.c (see commit
e1e4bf2252 "msix: fix msix_vector_masked"), restrict the
xen_is_pirq_msi() call in msi_is_masked() to Xen.

No functional change intended.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: David Woodhouse <dwmw@amazon.co.uk>
Message-Id: <20231114143816.71079-7-philmd@linaro.org>
---
 hw/pci/msi.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/pci/msi.c b/hw/pci/msi.c
index 041b0bdbec..8104ac1d91 100644
--- a/hw/pci/msi.c
+++ b/hw/pci/msi.c
@@ -23,6 +23,7 @@
 #include "hw/xen/xen.h"
 #include "qemu/range.h"
 #include "qapi/error.h"
+#include "sysemu/xen.h"
 
 #include "hw/i386/kvm/xen_evtchn.h"
 
@@ -308,7 +309,7 @@ bool msi_is_masked(const PCIDevice *dev, unsigned int vector)
     }
 
     data = pci_get_word(dev->config + msi_data_off(dev, msi64bit));
-    if (xen_is_pirq_msi(data)) {
+    if (xen_enabled() && xen_is_pirq_msi(data)) {
         return false;
     }
 
-- 
2.41.0


