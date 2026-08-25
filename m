Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 861B2C61DB9
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 22:03:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyzE8-0005yR-RZ; Tue, 25 Aug 2026 18:02:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mathieu.poirier@linaro.org>)
 id 1wyzDA-0003nz-4z
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 18:01:43 -0400
Received: from mail-pg1-x52a.google.com ([2607:f8b0:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mathieu.poirier@linaro.org>)
 id 1wyzD8-0001o0-Ds
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 18:01:39 -0400
Received: by mail-pg1-x52a.google.com with SMTP id
 41be03b00d2f7-cbedd5aece4so1112385a12.0
 for <qemu-devel@nongnu.org>; Tue, 25 Aug 2026 15:01:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787695297; x=1788300097; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=OQr0iH6TQlLlru7OkuZsYY/GXznu3bXNhzmozCgXXt4=;
 b=TCgYHEFuheHiqFkQaTtLJOXf3kFhQcKXEp/sfDkb/dYjWpUZfuVsOKSL6aosHajXza
 R2Msk0KByzbbgtUx1DAWAMZE2p6jgIYhIvF4cc7v/yhaI084NDCffBxVlqMHc1WHWioc
 0mGIMHNYiobMnkjqHWOdQ2qpWFJumqpMR1aHSGalVPz3++EWZjwKdEzt7txfuqHsbOiM
 6CuoOtODyFYZgoi0RNUSHJLN1l529DOUJse3oCINzNX3Mpmjh6EtOsLYDXTkbazZJXxk
 fQiC8iLU4X3nlcXwlSu+HmziW3xrCgsfPSm5T/BvTiLx7n0/W5mO9qFE/OTJnU6DucjM
 jCag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787695297; x=1788300097;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=OQr0iH6TQlLlru7OkuZsYY/GXznu3bXNhzmozCgXXt4=;
 b=B6E4wPH/D9xQNJKCIIkgSfKMQzhtgLnThfBDaafPvYVcpt8qaAyn7Cp5vnsCthJuxv
 IW3aFUFwFgpzGs/A5zpus1qmBB6Omw0VGPT8NmXipX1iC9BTqC75UTMLAr3QyAoV83nG
 lmpJU/yWUB/9onoB7IVG5tdTLnRmdLm1F9+wspQ5hNRZNzsjGlOM1kEFRhztIqa83c03
 n3n3abMm+zx5cRAtwQSEJIJw7X+xJnTqdK8UCR2vCx+HPvierXr23Rvjwjz6vL7/XZDY
 hDJ13/SNaFpBwykDC4nVh/uDKgGS+GMlUgBTuSRI5IdL7KU+PljWC7szh583MGG+06dH
 9TJw==
X-Gm-Message-State: AFuF++nRtYCnGJ2OMKKoQaIO/TwSlYSiTNcGUIAALMhJxTukQLCqqBA9
 +1ncblEIpcxAR2aFwxeAPPTqXsB3oGhhqaWiuOEWycpfHdPOvkGlmvwo0CVFWUl4XwE=
X-Gm-Gg: AR+sD13RKtfaldcCxxE8jiy1/yjERylx2JEdHpuazuPPmYAgfLDhI8gDIYrVojcyb2A
 6OUwjaQ3DpiXU839Q+4dQw3mneqGvEczQxip2hgr6cSmEqpjjtYptf/zgmbjW1SJZXaYMb4iMp/
 BCxe5juG3sRE6ZteURDqCpZd7EBcVCDZCoqCUiUmMKs6vuWsP+99l5TCGflt4791/o1xz/A3gFF
 QFgntq1X8JCKq3oVdRfKXUI2HELN90z+koVwvDm83wXt64/W28QLohdcJFOa9i8l0BktSA8x9kQ
 0KCpv+L8E945TvLLxYRqo3STU4Kba0dvUNUrvqvw+OkE3SabUUw47nW9S3ad3tRh0YD7cXCajv0
 3dj/OzfgeR1hDYRsnn1U73+92b2WEHNIPiD+oTN4wHZe57Q111ku+0TqE79G+Bb/LaL/s8fE5Ly
 f3+4xdsbqgSrdg5HX0NKhL92KYpBRr8qr/98cEA/eBsxyL+1w50NGzHICZZXmw7dfspvFuUGJOR
 TjVx7mcOuwaeE4=
X-Received: by 2002:a17:90b:4d81:b0:38e:7297:a92e with SMTP id
 98e67ed59e1d1-3966d8e8063mr2162748a91.9.1787695296731; 
 Tue, 25 Aug 2026 15:01:36 -0700 (PDT)
Received: from p14s.cg.shawcable.net
 ([2604:3d09:148c:c800:a37a:292f:1363:c0af])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3965d119724sm3090120a91.2.2026.08.25.15.01.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Aug 2026 15:01:36 -0700 (PDT)
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: berrange@redhat.com, kchamart@redhat.com,
 pierrick.bouvier@oss.qualcomm.com, peter.maydell@linaro.org,
 mst@redhat.com, cohuck@redhat.com, pbonzini@redhat.com, eblake@redhat.com,
 armbru@redhat.com, lorenzo.pieralisi@linaro.org, gshan@redhat.com,
 enju.kohei@fujitsu.com
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, kvm@vger.kernel.org,
 mathieu.poirier@linaro.org
Subject: [RFC v3 15/24] hw/arm/virt: Set proper conduit method for Realms
Date: Tue, 25 Aug 2026 16:00:52 -0600
Message-ID: <20260825220101.3443954-16-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260825220101.3443954-1-mathieu.poirier@linaro.org>
References: <20260825220101.3443954-1-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52a;
 envelope-from=mathieu.poirier@linaro.org; helo=mail-pg1-x52a.google.com
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

From: Jean-Philippe Brucker <jean-philippe@linaro.org>

The HVC conduit for PSCI is not supported for Realms, so default
to SMC.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 hw/arm/virt.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index b090233893c5..3418d75eccc4 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -267,6 +267,11 @@ static const int a15irqmap[] = {
     [VIRT_PLATFORM_BUS] = 112, /* ...to 112 + PLATFORM_BUS_NUM_IRQS -1 */
 };
 
+static bool virt_machine_is_confidential(VirtMachineState *vms)
+{
+    return MACHINE(vms)->cgs;
+}
+
 static void create_randomness(MachineState *ms, const char *node)
 {
     struct {
@@ -2902,10 +2907,11 @@ static void machvirt_init(MachineState *machine)
      * if the guest has EL2 then we will use SMC as the conduit,
      * and otherwise we will use HVC (for backwards compatibility and
      * because if we're using KVM then we must use HVC).
+     * Realm guests must also use SMC.
      */
     if (vms->secure && firmware_loaded) {
         vms->psci_conduit = QEMU_PSCI_CONDUIT_DISABLED;
-    } else if (vms->virt) {
+    } else if (vms->virt || virt_machine_is_confidential(vms)) {
         vms->psci_conduit = QEMU_PSCI_CONDUIT_SMC;
     } else {
         vms->psci_conduit = QEMU_PSCI_CONDUIT_HVC;
-- 
2.43.0


