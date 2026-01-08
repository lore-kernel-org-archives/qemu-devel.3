Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C6B4D14899
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Jan 2026 03:11:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdgPo-0008UH-9t; Wed, 07 Jan 2026 22:10:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vdgOh-0005mY-BE; Wed, 07 Jan 2026 22:09:16 -0500
Received: from mgamail.intel.com ([198.175.65.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vdgOf-0005YH-N2; Wed, 07 Jan 2026 22:09:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1767841753; x=1799377753;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=kNYkiaNSgjNxHBpmze7LKKP0q9ceZ2SXtXvlRLGlXSo=;
 b=FextAjlPKUJ5Rw3lP4xiM51Er8D3VJi/l+OE+51WrkI0NuTZBwzqEi4u
 3Y8bf9mHv8vgFH+YXpC31ZWcLXTd6TBfQV9t+mkwgo4IHfZey1AtvJmKg
 CBH0iPbpSxFQhYrS69Tezn9nOjVozB1M487RAsU5ZJFhwLRAb6+I5ukWS
 kXHcukyROwX79XkvuVjQ9jjyxT3+R7u+p9PFvBcszR1CtlOcUuY1IXb9C
 n4LcBhdE1FzwmLmocnk1rpBW9KT6olT4uRHX66zviO59QuCtKokYHNuZK
 ns9xJbvsBhH5N7mTNgzrkfntJrqu3f7LMd18P1TOMC3nKAYmX+OhLZ5VS Q==;
X-CSE-ConnectionGUID: BbsCl4e8TDWqjHxyF/uB3g==
X-CSE-MsgGUID: kKFX1X2SQJe6mWW9hG5MOw==
X-IronPort-AV: E=McAfee;i="6800,10657,11664"; a="91877570"
X-IronPort-AV: E=Sophos;i="6.21,209,1763452800"; d="scan'208";a="91877570"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Jan 2026 19:09:11 -0800
X-CSE-ConnectionGUID: tPOD766tROaPRuJG7KUpiQ==
X-CSE-MsgGUID: lx/Vopy/STe1TSWeU+qq0w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,209,1763452800"; d="scan'208";a="202211235"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.39])
 by orviesa006.jf.intel.com with ESMTP; 07 Jan 2026 19:09:02 -0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, devel@lists.libvirt.org, kvm@vger.kernel.org,
 qemu-riscv@nongnu.org, qemu-arm@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Sergio Lopez <slp@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Yi Liu <yi.l.liu@intel.com>, Eduardo Habkost <eduardo@habkost.net>,
 Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, Weiwei Li <liwei1518@gmail.com>,
 Amit Shah <amit@kernel.org>, Xiaoyao Li <xiaoyao.li@intel.com>,
 Yanan Wang <wangyanan55@huawei.com>, Helge Deller <deller@gmx.de>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Ani Sinha <anisinha@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 =?UTF-8?q?Cl=C3=A9ment=20Mathieu--Drif?= <clement.mathieu--drif@eviden.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Huacai Chen <chenhuacai@kernel.org>, Jason Wang <jasowang@redhat.com>,
 Mark Cave-Ayland <mark.caveayland@nutanix.com>,
 BALATON Zoltan <balaton@eik.bme.hu>, Peter Krempa <pkrempa@redhat.com>,
 Jiri Denemark <jdenemar@redhat.com>, Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH v6 23/27] hw/audio/pcspk: Remove PCSpkState::migrate field
Date: Thu,  8 Jan 2026 11:30:47 +0800
Message-Id: <20260108033051.777361-24-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260108033051.777361-1-zhao1.liu@intel.com>
References: <20260108033051.777361-1-zhao1.liu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.9; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

The PCSpkState::migrate boolean was only set in the
pc_compat_2_7[] array, via the 'migrate=off' property.
We removed all machines using that array, lets remove
that property, simplifying vmstate_spk[].

Reviewed-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 hw/audio/pcspk.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/hw/audio/pcspk.c b/hw/audio/pcspk.c
index 916c56fa4c0a..0b01544941cb 100644
--- a/hw/audio/pcspk.c
+++ b/hw/audio/pcspk.c
@@ -57,7 +57,6 @@ struct PCSpkState {
     unsigned int play_pos;
     uint8_t data_on;
     uint8_t dummy_refresh_clock;
-    bool migrate;
 };
 
 static const char *s_spk = "pcspk";
@@ -202,18 +201,10 @@ static void pcspk_realizefn(DeviceState *dev, Error **errp)
     }
 }
 
-static bool migrate_needed(void *opaque)
-{
-    PCSpkState *s = opaque;
-
-    return s->migrate;
-}
-
 static const VMStateDescription vmstate_spk = {
     .name = "pcspk",
     .version_id = 1,
     .minimum_version_id = 1,
-    .needed = migrate_needed,
     .fields = (const VMStateField[]) {
         VMSTATE_UINT8(data_on, PCSpkState),
         VMSTATE_UINT8(dummy_refresh_clock, PCSpkState),
@@ -224,7 +215,6 @@ static const VMStateDescription vmstate_spk = {
 static const Property pcspk_properties[] = {
     DEFINE_AUDIO_PROPERTIES(PCSpkState, audio_be),
     DEFINE_PROP_UINT32("iobase", PCSpkState, iobase,  0x61),
-    DEFINE_PROP_BOOL("migrate", PCSpkState, migrate,  true),
     DEFINE_PROP_LINK("pit", PCSpkState, pit, TYPE_PIT_COMMON, PITCommonState *),
 };
 
-- 
2.34.1


