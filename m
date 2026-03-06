Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EDEAFCC062
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2026 20:41:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vybyZ-0001Nu-Pb; Fri, 06 Mar 2026 15:40:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1vybyX-0001Nc-JC
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 15:40:45 -0500
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1vybyW-0007x7-1b
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 15:40:45 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id A14F66001D;
 Fri,  6 Mar 2026 20:40:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2D15C4CEF7;
 Fri,  6 Mar 2026 20:40:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1772829642;
 bh=gTH9VfiyNgOKpTys1CM1/vMVRoZk4XBxW+xAr1bBt+4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=IoD3/xrj4FQYsw8f22V0aR08vWOJlPM/p1LlIj0zOenhf49VAftJRG5ia+glIO1Nk
 k3Zfn++PN7VtdCrR9Mya4uWippB3cbi2C8tG9jh9+ORzIXLYPD4n6kjMQ+RCUycR3y
 EQuidurNAUIe+ItyBsqFeLYd2wQ6FfKrc6zJDCoFm7LLx7vmB/gjSlrC0HpxRuL0u/
 KWEMG2+UdMeFHioYBw1V+pXCrtJevGPx3Z5j19TTOMKvhAwWtcOE+4FfM9JG2cMGXI
 Nk5skVojbIL1ToiBnLzRCgN7XpWnDMdcrSD8fW20i8khYceU8sAHlZKypsFRkIA3bs
 2gBEq7DfkHQfQ==
Date: Fri, 6 Mar 2026 21:40:38 +0100
From: Helge Deller <deller@kernel.org>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Helge Deller <deller@gmx.de>
Subject: Re: [PULL 2/6] hw/hppa: Wire up Diva GSP card
Message-ID: <aas7xpjiDx5Bhrs4@p100>
References: <20250207210540.24594-1-deller@kernel.org>
 <20250207210540.24594-3-deller@kernel.org>
 <CAFEAcA_VWSYYE+GdDRwxpWzOX6qVYptjYOe--azOzo4_pre_+A@mail.gmail.com>
 <aasZKZ1FQY5ytrb2@p100>
 <CAFEAcA8MLNYfDe_0chBmo+wwwNJoUHWj4Sg1nhCNSjodCzTOtw@mail.gmail.com>
 <aaseBa-3GVyjKGXh@p100>
 <CAFEAcA_g4tT2dTyWHoTn0hVZ_Soy7W_exh2JEE-C9U+PN4LGPg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA_g4tT2dTyWHoTn0hVZ_Soy7W_exh2JEE-C9U+PN4LGPg@mail.gmail.com>
Received-SPF: pass client-ip=2600:3c04:e001:324:0:1991:8:25;
 envelope-from=deller@kernel.org; helo=tor.source.kernel.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

* Peter Maydell <peter.maydell@linaro.org>:
> You need to increment the version_id and minimum_version_id
> to change the vmstate. Or you could instead replace the line with
>            VMSTATE_UNUSED(1), /* was "disable" */
> (which keeps the migration data structure the same, so no
> version bump needed).
> 
> I have no strong preference; I would probably just bump
> the version numbers personally.

New patch below.
Ok?

Helge


From: Helge Deller <deller@gmx.de>
Subject: [PATCH] hw/char: Drop disable property of Diva GSP card

The "disable" property is not used, so drop it.

Noticed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Helge Deller <deller@gmx.de>

diff --git a/hw/char/diva-gsp.c b/hw/char/diva-gsp.c
index 280d0413c6..2be5183216 100644
--- a/hw/char/diva-gsp.c
+++ b/hw/char/diva-gsp.c
@@ -51,7 +51,6 @@ typedef struct PCIDivaSerialState {
     SerialState  state[PCI_SERIAL_MAX_PORTS];
     uint32_t     level[PCI_SERIAL_MAX_PORTS];
     qemu_irq     *irqs;
-    bool         disable;
 } PCIDivaSerialState;
 
 static void diva_pci_exit(PCIDevice *dev)
@@ -159,20 +158,18 @@ static void diva_pci_realize(PCIDevice *dev, Error **errp)
 
 static const VMStateDescription vmstate_pci_diva = {
     .name = "pci-diva-serial",
-    .version_id = 1,
-    .minimum_version_id = 1,
+    .version_id = 2,
+    .minimum_version_id = 2,
     .fields = (const VMStateField[]) {
         VMSTATE_PCI_DEVICE(dev, PCIDivaSerialState),
         VMSTATE_STRUCT_ARRAY(state, PCIDivaSerialState, PCI_SERIAL_MAX_PORTS,
                              0, vmstate_serial, SerialState),
         VMSTATE_UINT32_ARRAY(level, PCIDivaSerialState, PCI_SERIAL_MAX_PORTS),
-        VMSTATE_BOOL(disable, PCIDivaSerialState),
         VMSTATE_END_OF_LIST()
     }
 };
 
 static const Property diva_serial_properties[] = {
-    DEFINE_PROP_BOOL("disable",  PCIDivaSerialState, disable, false),
     DEFINE_PROP_CHR("chardev1",  PCIDivaSerialState, state[0].chr),
     DEFINE_PROP_CHR("chardev2",  PCIDivaSerialState, state[1].chr),
     DEFINE_PROP_CHR("chardev3",  PCIDivaSerialState, state[2].chr),

