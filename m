Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EF09F417F1
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 14:53:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzbyG-00051i-2f; Mon, 09 Mar 2026 10:52:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzbxB-0004MJ-Ng
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 10:51:34 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzbx2-0005la-Nl
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 10:51:22 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-48334ee0aeaso95423045e9.1
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2026 07:51:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773067879; x=1773672679; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pgpA3PHGmA2cywOmnIHp4QQstzRdLHRlcUMp4w2UsrY=;
 b=XPK8xWqwdxcH4Oid8Gs2c2kFLDxwvDmC7iqoNR9x1BNr7goxy5z/xUNYdhoN33LinD
 R8sqQ0i1dWXlXV17DLk9ipukWVE0loQ/7XLVr+jMRDHgL7OyCRSDq7uAFNbaWAE11H58
 VWGbLgD0sXClFu2FVA/QbSMQH5MZQtDXdURshR3B3OMl1gSlh8mNVUlgChyRY9/BC1b/
 JgOokskuEtmOR2f0Z0ingR/q09JD04rXkApjZl9b0TwWjEFp48/WDs8V6q6qJmAGNdQz
 foQ6d/UUeioBsJ6Z4/jqNSUdDMCLzyZUj7lUfLtDiRGeU4vIq0EOxdQ35R5/bNgDHaWY
 4KzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773067879; x=1773672679;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=pgpA3PHGmA2cywOmnIHp4QQstzRdLHRlcUMp4w2UsrY=;
 b=tsemqwszWWIHd52mfv/KpulNxU+CdrolZT9fXNvuza1bnSOgcRuLB45E9J9S3Huj1U
 zWqj+SsjnEJcjyRvYHM3nSbBcq8/JBeWt6Zhlw4WhXYSx3McKOjVX9bwGC8Nt8caK4Wm
 5qodLnzautxpBDeQqHlCycV5SsD2MSeO1ZsK9vDmNz9727IXIb22m4/HIZfcM+ynNyI+
 Cu4bTN+0XOckjiWIMqevjafpghZRcPS261Ly5OgIIBPIkfQDYKUUYsJdLMbXcF89hg+7
 BgI6Vyptf2ZI9M1OurZxBQG40ewttHefsl8fA6I5REsEbzjvZHPXdF3QlbX4mBBxMB9s
 aEMA==
X-Gm-Message-State: AOJu0YyVHEJnE5Mco98OHINB0wc0VqE2V46PSey7YuMvcFfrSRrfM2eD
 HzuBM7Qb+zYaWvdjT+DE9nqMuEVtEd4aDs46yXW8KIcd5cm/2gJQS9lIc2F/K3YZuT8eV+LSBlj
 0CPxG0a4=
X-Gm-Gg: ATEYQzym3QmsC/zyNbG9utECZMu6XqXuK0vZf1A3od7q2sasMBllZhOxAz2GQPsoboV
 FB72gMKGez3eL+SvHpuq3qlbccX9iDbGWQPEo3Ht9t8dvaGNTdN+R8exOehHTTC/arfDYENmoKk
 JDR9ayI6DaQZVo4JV9Ev4VWOQuyznJm656i0Q10k1LsnEZ806sGIksZdL9/bs04IAgyQlxnr5yU
 yQ0NRoM7HtV5iwl6G2jimIyaUNEp8X5FCeC3KaAJpjOKWdNaX3a89sHFtSZ6wyEtbxvsNUc2mnX
 E+FpZUiS7Mm6pxgxO46iyMGYfRbPgSw8Dlw4gdCXj1amI4dcJaFCZBLcz7A/dYJw3pzy5VFFOcd
 KCB1xI5snbEkpJYNH1C4qmokayOAPYkM/ystM2ZoBeGSMFOZubiRUAjIckB+QFruf+ua7G4o25L
 Q1JGFO9qFuiaRRmfe3atO/NDe1ggXLZUAsE42z9LJlqh0gFB0osMIg7m54pu3r6weVDPoDm+zlc
 /hqzA==
X-Received: by 2002:a05:600c:3515:b0:485:364e:934e with SMTP id
 5b1f17b1804b1-485364e94admr93028595e9.21.1773067878792; 
 Mon, 09 Mar 2026 07:51:18 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4853a946978sm111340465e9.1.2026.03.09.07.51.17
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 09 Mar 2026 07:51:18 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>, Yi Liu <yi.l.liu@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PATCH v2 09/10] hw/pci-bridge/pcie_rp: Remove PCIESlot::disable_acs
 field
Date: Mon,  9 Mar 2026 15:50:11 +0100
Message-ID: <20260309145013.44327-10-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260309145013.44327-1-philmd@linaro.org>
References: <20260309145013.44327-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

The PCIESlot::disable_acs boolean was only set in the
hw_compat_3_1[] array, via the 'disable-acs=true' property.
We removed all machines using that array, lets remove that
property and all the code around it.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20260307152635.83893-10-philmd@linaro.org>
---
 include/hw/pci/pcie_port.h     | 3 ---
 hw/pci-bridge/pcie_root_port.c | 3 +--
 2 files changed, 1 insertion(+), 5 deletions(-)

diff --git a/include/hw/pci/pcie_port.h b/include/hw/pci/pcie_port.h
index 53cd64c5edf..b28af067a66 100644
--- a/include/hw/pci/pcie_port.h
+++ b/include/hw/pci/pcie_port.h
@@ -60,9 +60,6 @@ struct PCIESlot {
     PCIExpLinkWidth width;
     bool flitmode;
 
-    /* Disable ACS (really for a pcie_root_port) */
-    bool        disable_acs;
-
     /* Indicates whether any type of hot-plug is allowed on the slot */
     bool        hotplug;
 
diff --git a/hw/pci-bridge/pcie_root_port.c b/hw/pci-bridge/pcie_root_port.c
index fe3ced56851..7c3e78010b4 100644
--- a/hw/pci-bridge/pcie_root_port.c
+++ b/hw/pci-bridge/pcie_root_port.c
@@ -117,7 +117,7 @@ static void rp_realize(PCIDevice *d, Error **errp)
     pcie_aer_root_init(d);
     rp_aer_vector_update(d);
 
-    if (rpc->acs_offset && !s->disable_acs) {
+    if (rpc->acs_offset) {
         pcie_acs_init(d, rpc->acs_offset);
     }
     return;
@@ -151,7 +151,6 @@ static void rp_exit(PCIDevice *d)
 static const Property rp_props[] = {
     DEFINE_PROP_BIT(COMPAT_PROP_PCP, PCIDevice, cap_present,
                     QEMU_PCIE_SLTCAP_PCP_BITNR, true),
-    DEFINE_PROP_BOOL("disable-acs", PCIESlot, disable_acs, false),
 };
 
 static void rp_instance_post_init(Object *obj)
-- 
2.53.0


