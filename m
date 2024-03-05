Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B14CBC54798
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Mar 2024 13:46:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhV56-0003Lu-2l; Tue, 05 Mar 2024 08:43:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rhV4l-00039P-PG
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 08:43:24 -0500
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rhV4j-0003zk-Nk
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 08:43:23 -0500
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-563c595f968so8432132a12.0
 for <qemu-devel@nongnu.org>; Tue, 05 Mar 2024 05:43:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709646199; x=1710250999; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/uaVgcIj5CZp4PgaMSlBhVfscYd2B9Mi4dr8ANISE2s=;
 b=NnFvYTlkZ8URXbMCv+NnVDrhJuWL7bvWlgRYgTxdGbRyGtpCPUehurSZ6vBfIRZxTy
 ZpT1+a+NyxlSn70Hp7vLhb8oAHJ8hI5Pgzg6d4ByTgZxY4yywpjgeNvkWFyXrUFNBSk/
 mRqgU2QdDa4Ert1x/1I6lwnHHoHb4IGE004KarU9SbKXDqJyNiKjKPy9QN+7PuWYIAcX
 xKABQ13o5x0EfOUBSM8VVVczOFkYaML85sxm37iYL05tbT+tb8K1Fl637GKpH+CbQoSb
 3etFwzMKYmchho6BLM3xNQv0qnnEm5VOHjiraIqtSWhS0KF2brnNshwcHcAw9CJgdpuE
 ZRaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709646199; x=1710250999;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/uaVgcIj5CZp4PgaMSlBhVfscYd2B9Mi4dr8ANISE2s=;
 b=STtLsAF3zmS3rnj1vSv74xktuh5COuB29IzHkNYZBRxrGNqYjjXloE42WAohvco+Jk
 bnvlhRDjcbzbijBrs0QAhupy0yUV8Q1kNfwNAShfxLMSLyZz8S6FyAvgmHEm2sg4HTMn
 ixCJUrFCQnvrGQt0MQC9TAmsyhh8LOKWuGAfs335p1lfu0sk9inbvIlR5vlUL4KUVObK
 l46p5arLNb7hw0mAgBTivB3l8i+OWwyoHFbK4E4FwfVXu+ZYNnYvW2FIaYVbMJZi/w/k
 OzQZ8LiTm8EzVzw+zKA5+Cd1KEK9LJHVtVv3UHqn7LuFCbTcmtWAfoasZ+ekdMRndWAX
 xCxw==
X-Gm-Message-State: AOJu0Yw+eaI+3eZbix2+wZ8kDOo/jqFIdgUTAYkbG05V2iGWzRlrBAKU
 fORY5kJyr5l37T1sptNdCR+bUXLMxoLvrRBDB5tBTNHu+8eMhWjsJxe9vieKN/VlN76V4AG/REx
 z
X-Google-Smtp-Source: AGHT+IFX0UlicD2nXIVlAQ+n7nrYayFTU70QHqN/oYZVIOnExi3rdtn3EIahhoj5s7wQRhibaK+BUw==
X-Received: by 2002:a17:906:f2d1:b0:a45:7d04:c1fa with SMTP id
 gz17-20020a170906f2d100b00a457d04c1famr2588070ejb.67.1709646199488; 
 Tue, 05 Mar 2024 05:43:19 -0800 (PST)
Received: from m1x-phil.lan ([176.176.177.70])
 by smtp.gmail.com with ESMTPSA id
 q7-20020a170906540700b00a45aeaf9969sm238731ejo.5.2024.03.05.05.43.17
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 05 Mar 2024 05:43:19 -0800 (PST)
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
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: [PATCH-for-9.1 08/18] hw/i386/pc: Remove
 PCMachineClass::smbios_uuid_encoded
Date: Tue,  5 Mar 2024 14:42:10 +0100
Message-ID: <20240305134221.30924-9-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240305134221.30924-1-philmd@linaro.org>
References: <20240305134221.30924-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x533.google.com
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

PCMachineClass::smbios_uuid_encoded was only used by the
pc-i440fx-2.1 machine, which got removed. It is now always
true, remove it.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/i386/pc.h | 1 -
 hw/i386/fw_cfg.c     | 2 +-
 hw/i386/pc.c         | 1 -
 3 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index f77639d94f..f051ddafca 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -109,7 +109,6 @@ struct PCMachineClass {
     /* SMBIOS compat: */
     bool smbios_defaults;
     bool smbios_legacy_mode;
-    bool smbios_uuid_encoded;
     SmbiosEntryPointType default_smbios_ep_type;
 
     /* RAM / address space compat: */
diff --git a/hw/i386/fw_cfg.c b/hw/i386/fw_cfg.c
index 98a478c276..176c086673 100644
--- a/hw/i386/fw_cfg.c
+++ b/hw/i386/fw_cfg.c
@@ -63,7 +63,7 @@ void fw_cfg_build_smbios(PCMachineState *pcms, FWCfgState *fw_cfg)
     if (pcmc->smbios_defaults) {
         /* These values are guest ABI, do not change */
         smbios_set_defaults("QEMU", mc->desc, mc->name,
-                            pcmc->smbios_legacy_mode, pcmc->smbios_uuid_encoded,
+                            pcmc->smbios_legacy_mode, true,
                             pcms->smbios_entry_point_type);
     }
 
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index d417cf106c..409114bba5 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1791,7 +1791,6 @@ static void pc_machine_class_init(ObjectClass *oc, void *data)
     pcmc->has_acpi_build = true;
     pcmc->rsdp_in_ram = true;
     pcmc->smbios_defaults = true;
-    pcmc->smbios_uuid_encoded = true;
     pcmc->gigabyte_align = true;
     pcmc->has_reserved_memory = true;
     pcmc->enforce_aligned_dimm = true;
-- 
2.41.0


