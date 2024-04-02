Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAE5DCD1284
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Apr 2024 14:29:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rrf53-0001eT-QL; Tue, 02 Apr 2024 10:25:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rrf51-0001Zl-Jj
 for qemu-devel@nongnu.org; Tue, 02 Apr 2024 10:25:39 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rrf4y-0008OJ-TX
 for qemu-devel@nongnu.org; Tue, 02 Apr 2024 10:25:39 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4156684ee9cso14166545e9.1
 for <qemu-devel@nongnu.org>; Tue, 02 Apr 2024 07:25:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712067934; x=1712672734; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kQNXAA1wuI9r1xEVFBSvxjPye1eCu2fvaop4AIt2tLo=;
 b=Yt9ERwCRY5n/jJ7PAk7SKe2GNicxXTUNdVu62EJbua+QF+NjOzSHslPVKm+rldTdJp
 8xIhRr8/Vj3JJOeC+dgCHhMhUcuoMyQzrKUjz9GVl83Vm/O2HQPV0eZoDMrHc4PECsOL
 pZxY6UNRA9A30TPz+9EJfhRvCZYaWFBCcAg2h4FTGwqtFC66z+5kGk7A+JHCbUdqjaQq
 qMrroyjV9UqqfxErd6+otvCPDGke79DgJdJFEQWyT7wCIluqRzzD9pekMOkSGuoN9gl7
 TasMGYVH5Tu2OjZnJ3aKDMHxoSAyJQAwxcIh3qDH3cgbS0pgBdiulyGCvz7lUGQLueKF
 T/Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712067934; x=1712672734;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kQNXAA1wuI9r1xEVFBSvxjPye1eCu2fvaop4AIt2tLo=;
 b=v1n/q8D6VrimtpD2p8NjbbKpKK81VwTe5j7O1RSusIldozJHvlxchtJib3tQMCRUFr
 +ExX4j4IgRneP9R0v3U2Vc6kAfmFDK724y0r/L7aXnApCMu7SuNWNXX31MOMKe4Gz693
 39W2g3C6AgtXRdxqXkPP/o+E0Iz6PsPUkWpJ/izW1zfp/UZpkpZQ/+bhovzBQKXbflWy
 ZoWX5ZROq9mJv1gd2pXsGW3c+pGENv7FM9m+1HV9rmUZkP59I3Rzeg5quFtf+zlSIruc
 OPgE80drugymHvsODlxfOFVpdPJjEPIknemlDZoNrmRnroNgQ83SL59CU+TmhSLLG8ss
 RA6g==
X-Gm-Message-State: AOJu0YwpjRHLD8L25YAAMnhKNlrC9id2+YXbAlWJ6IzHHZzjoDo4+JSC
 eTS6ig3kmUuFT5n53ez1iidnn9FGinHzdgKcLSUS2VMpOAvZImmeZ/YBEpy0TUiieCNkqnzkvxh
 dLec=
X-Google-Smtp-Source: AGHT+IEbsSiMV7jilXYs2wV9OBg95AuR2LRSHkUc1BiINN5nAdttK0+iS4lqUtws+mmM3EGdu+r3Vw==
X-Received: by 2002:a1c:4b04:0:b0:415:f755:5a1f with SMTP id
 y4-20020a1c4b04000000b00415f7555a1fmr1630323wma.29.1712067934343; 
 Tue, 02 Apr 2024 07:25:34 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.202.91])
 by smtp.gmail.com with ESMTPSA id
 p12-20020a05600c468c00b00413eb5aa694sm18186167wmo.38.2024.04.02.07.25.32
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 02 Apr 2024 07:25:33 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, qemu-block@nongnu.org, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PULL 09/15] hw/i386/pc: Restrict CXL to PCI-based machines
Date: Tue,  2 Apr 2024 16:24:24 +0200
Message-ID: <20240402142431.70700-10-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240402142431.70700-1-philmd@linaro.org>
References: <20240402142431.70700-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

CXL is based on PCIe. In is pointless to initialize
its context on non-PCI machines.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Message-ID: <20240327161642.33574-1-philmd@linaro.org>
---
 hw/i386/pc.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index e80f02bef4..5c21b0c4db 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1738,7 +1738,9 @@ static void pc_machine_initfn(Object *obj)
     pcms->pcspk = isa_new(TYPE_PC_SPEAKER);
     object_property_add_alias(OBJECT(pcms), "pcspk-audiodev",
                               OBJECT(pcms->pcspk), "audiodev");
-    cxl_machine_init(obj, &pcms->cxl_devices_state);
+    if (pcmc->pci_enabled) {
+        cxl_machine_init(obj, &pcms->cxl_devices_state);
+    }
 
     pcms->machine_done.notify = pc_machine_done;
     qemu_add_machine_init_done_notifier(&pcms->machine_done);
-- 
2.41.0


