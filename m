Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7415C54798
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Mar 2024 13:43:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhV4D-0002HV-1Z; Tue, 05 Mar 2024 08:42:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rhV47-0002Gu-BF
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 08:42:43 -0500
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rhV44-0003x9-UE
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 08:42:42 -0500
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-a449c5411e1so543230066b.1
 for <qemu-devel@nongnu.org>; Tue, 05 Mar 2024 05:42:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709646159; x=1710250959; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nBiR1NjnNqmb5fA74myd/4THTKWykiIDh39Z8PAr++Y=;
 b=FSr2RCh4x5HmShFmZC3b06ows7xsPX68WCP/qtDNfql118456xkSkAmOtD+lbCbh3s
 0FEqhCJSXWAVJ4FvI/HbzzxNj+NgTkzEn9DxyiYpYoaknR22bGVUpp3vGRGYmr4UBJWh
 TppkWnLyt/r34hJnKxubp0tQynzf7Bk50rhBQf8Mtp7oj8yIyoDXWlHUiPna17rJI27m
 XhWbhkRFLcULJs8LcK+i9juG/yN2NMOFVngyoPt/Mion59CopuiA45Xo2ZM53U+ceflH
 VxoLnLq5oA90aEHB1WCwr1WWIQafgVXFgSoJC1k7s0KvIc378nCmryRqgWwHPkFSNiwu
 X8Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709646159; x=1710250959;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nBiR1NjnNqmb5fA74myd/4THTKWykiIDh39Z8PAr++Y=;
 b=aHlkbhxwsfVG9Md88Hqv9xXQadQMyn7YChp9+NJD42TwB2iBCI6QurF3OdY1dy/WOx
 O9yrmRFWzYg2NBvyCHxjn+oFOeGtrdqZ0cjkJxGm8Q7ioJuZuWB+d8e+cCcWA2b+AF0+
 9Fw6q93aKBNXX04/cHi9aEiYi97Ni0N05I5YdzMc6f2QmBGQ47Fa9GJMWmfOTchicsvC
 tHOoXYOxCC6shEiMFvBtc7I0l/guxEhYX6ENvBdu/TnuvdHESfgoOZiNJ5hc/gORMQOP
 EbFQcfyfziNt75UqL8kD74vjE6VHpdlOthu25CNrF2onaLdV5PuyYvZQN15o40C/aISs
 xzMg==
X-Gm-Message-State: AOJu0YyOyg1wvFfcy0tc6Ny6D8cymybNJ4jBMx/U7KnK4nn0kCKouZPM
 t15aXGZXvTrHHBwQLsn0rPsyZmXAIlFM3lxheu/Y942IskaBCjJzIqTMhC9eN7K5/R12lnZQ6kZ
 K
X-Google-Smtp-Source: AGHT+IGlCzBdHb/CuP3L39CooS3sdPaa/BoyfCLBRe8pyO7DyPl6RRC6hDIlmTp4c2pez14Nn4jddw==
X-Received: by 2002:a17:906:830e:b0:a45:446c:6beb with SMTP id
 j14-20020a170906830e00b00a45446c6bebmr4144176ejx.50.1709646158911; 
 Tue, 05 Mar 2024 05:42:38 -0800 (PST)
Received: from m1x-phil.lan ([176.176.177.70])
 by smtp.gmail.com with ESMTPSA id
 f27-20020a170906085b00b00a44ef54b6b6sm3648391ejd.58.2024.03.05.05.42.37
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 05 Mar 2024 05:42:38 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org,
	Thomas Huth <thuth@redhat.com>
Cc: Igor Mammedov <imammedo@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, kvm@vger.kernel.org,
 Marcelo Tosatti <mtosatti@redhat.com>, devel@lists.libvirt.org,
 David Hildenbrand <david@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-9.1 02/18] hw/usb/hcd-xhci: Enumerate xhci_flags setting
 values
Date: Tue,  5 Mar 2024 14:42:04 +0100
Message-ID: <20240305134221.30924-3-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240305134221.30924-1-philmd@linaro.org>
References: <20240305134221.30924-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::635;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x635.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

xhci_flags are used as bits for QOM properties,
expected to be somehow stable (external interface).

Explicit their values so removing any enum doesn't
modify the other ones.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/usb/hcd-xhci.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/usb/hcd-xhci.h b/hw/usb/hcd-xhci.h
index 98f598382a..37f0d2e43b 100644
--- a/hw/usb/hcd-xhci.h
+++ b/hw/usb/hcd-xhci.h
@@ -37,8 +37,8 @@ typedef struct XHCIEPContext XHCIEPContext;
 
 enum xhci_flags {
     XHCI_FLAG_SS_FIRST = 1,
-    XHCI_FLAG_FORCE_PCIE_ENDCAP,
-    XHCI_FLAG_ENABLE_STREAMS,
+    XHCI_FLAG_FORCE_PCIE_ENDCAP = 2,
+    XHCI_FLAG_ENABLE_STREAMS = 3,
 };
 
 typedef enum TRBType {
-- 
2.41.0


