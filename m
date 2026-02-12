Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09652EE3694
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Feb 2026 14:44:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqXvG-0005ky-U8; Thu, 12 Feb 2026 09:44:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vqXux-0005Nj-Pk
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 09:43:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vqXuZ-00062d-8q
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 09:43:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770907396;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ztjQZUvb3l5UC1d7nkrajfRm5xtDWQi1UWTU3CLPHL8=;
 b=aWGVfgwP96XLlyAtEIvC28y0Uj1VyhZ0UyF7H5YMEcusQslHV6FwhlkN48nVeO9dZaPDyG
 FofvEY0H4khOJAcuqYITIFaFrRNJVBOT3smrTzTVdwyIU9NpbE1pTa6eKUFEWLpWdMsxFu
 b3rCUiLlonHWQ1iu8yY5QCLacXgWMAM=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-163-rNp7jsdIP_2VR9p0Bw0rqg-1; Thu, 12 Feb 2026 09:43:15 -0500
X-MC-Unique: rNp7jsdIP_2VR9p0Bw0rqg-1
X-Mimecast-MFC-AGG-ID: rNp7jsdIP_2VR9p0Bw0rqg_1770907394
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4806fa4a180so60040725e9.2
 for <qemu-devel@nongnu.org>; Thu, 12 Feb 2026 06:43:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1770907394; x=1771512194; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ztjQZUvb3l5UC1d7nkrajfRm5xtDWQi1UWTU3CLPHL8=;
 b=kJ2uwIIxN4mdNRdqzoqjdr7tG3xwYBWxQcsP4DDhXcJSjetgEyOlfiYyLWRHb9vqte
 bJ3dBb82TERoldp/ZJLih0Yn2qrNOXU9AzOBuxsBhi2uXF1o+oXxdr2DhID3kELchKkl
 GDTDnyTkyEKzs5ufoeadXJs5FWMksnHOGDROgV5+mEybER1ePdgqr0DMq0YdMAhmM7mc
 EHUGPAlrfn+/Gjf8Ow+Db73OaZIGCKqcOPZNc4yyPrSWxEIUMLyyylVxl+xcx/Xfxazk
 9Nu33NRRRd98bGxMhYmhvhYn2sM8MGFlgKFx7fKVWK5sKVJSUGM/kAIlUzlABDWKpc9o
 E+NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770907394; x=1771512194;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ztjQZUvb3l5UC1d7nkrajfRm5xtDWQi1UWTU3CLPHL8=;
 b=L8XAZexEeRCJlFRQIiba/A7XFYBG0P4ZmH2H098SJMUnVNY5ak5dm1B5PrhjO7ROaI
 +mmDa9XlPq2L9W5k5JflRimd49A2FOxuC67ExxRJs04Kb+D6H9MpJcucszG6I3s9b2dz
 60Eb4ZD/HepXGJlyKOd6/YJjNy7eebxD39Y/ADLdSyhmNJgPMi+Vd+EgCzjOsiS71DzH
 vJS+AhQfhrI0Cr7P7j0BC07d4aTqa7Cl9AM/MQAq265Nz2l89+OWVWIybcfHU7yRwOS9
 3+/8u4Hf98GKrTi8Awhfr26MuYATVETakHes5sAb8thLVBErN/pfmMvPLuyfcsz+up1J
 Dwxg==
X-Gm-Message-State: AOJu0Ywd3zRU1V/sN484KhBas9VLtB28ZYdofjeEQfLR5P3nSMVpqS6X
 UnEUegon3xhX8i3LuThODQ2e+GKuWGpkF/lTEvsnOCMy+D70EtZEdZhVveDmXdu6vPadnomco5Q
 IeXfLzOc9GsGqq1dCTgwJRF0/8M6wvyt01TzCXKbMkjQAxjy/0GM3/KLtOooW8pmjx/qXcbcfoI
 /usUg/StASbpX5vWaUxA+CoCDVyYw1tvA4SpJgiMOr
X-Gm-Gg: AZuq6aJksXNQqAGv6JhJNnJ5OHhjnwVJOa7FIEYX/0X7M+B4yqK7IL1T4Nmzp6vXV6d
 IzuOfkwDnSPM7HOr/nEAfhZ7qSsZsipnt0vrrkOoELB2RUgmC7+moBoo8OO3i7IAaUREzpeNyJq
 vS5bn6rISdBnVZsTNX04Sn7tnneJJK/Gv9n1bZLQggJRvhoyLL3VNKjc/DEmJZ2tS7hpnIgLsdw
 qKgwAmwX7i21NYvqofFyhnCrkD9d1MioZIjJ3C23McbXHHvp873w0VExi65LiKYUTWs63cdmgx5
 vAjdCZHBQCaeX1hYsXfdr6DGi9nFY/866un+H6vfr+UUgqBaEK3qXyxlc+uqjX4NOBzH2pjzTEW
 xsISio0qiwjB+ON3mGZj0X5f29rRVaR5T4kpb7fjS0otGc6SbpQpWbS5MQ0CBFy5MvgPHZMPSfq
 CWFuBfd5Uf0FLRl8umE0mxE+72PgKsFzJYg16NxoOtu/SzL3MjMXk=
X-Received: by 2002:a05:600c:3b1a:b0:47e:e78a:c834 with SMTP id
 5b1f17b1804b1-4836571ea9bmr49032775e9.34.1770907392131; 
 Thu, 12 Feb 2026 06:43:12 -0800 (PST)
X-Received: by 2002:a05:600c:3b1a:b0:47e:e78a:c834 with SMTP id
 5b1f17b1804b1-4836571ea9bmr49028505e9.34.1770907388090; 
 Thu, 12 Feb 2026 06:43:08 -0800 (PST)
Received: from [10.60.241.123] (nat-pool-mxp-t.redhat.com. [149.6.153.186])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4836131d52bsm41869025e9.28.2026.02.12.06.43.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Feb 2026 06:43:05 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Xiaoyao Li <xiaoyao.li@intel.com>, Igor Mammedov <imammedo@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 10/41] hw/mips/loongson3_virt: Prefer using
 fw_cfg_init_mem_nodma()
Date: Thu, 12 Feb 2026 15:42:12 +0100
Message-ID: <20260212144244.22579-11-pbonzini@redhat.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260212144244.22579-1-pbonzini@redhat.com>
References: <20260212144244.22579-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

fw_cfg_init_mem_wide() is prefered to initialize fw_cfg
with DMA support. Without DMA, use fw_cfg_init_mem_nodma().

Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Link: https://lore.kernel.org/r/20260108033051.777361-10-zhao1.liu@intel.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/mips/loongson3_virt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/mips/loongson3_virt.c b/hw/mips/loongson3_virt.c
index fe51fb66f6f..cd94e9f5f77 100644
--- a/hw/mips/loongson3_virt.c
+++ b/hw/mips/loongson3_virt.c
@@ -287,7 +287,7 @@ static void fw_conf_init(void)
     FWCfgState *fw_cfg;
     hwaddr cfg_addr = virt_memmap[VIRT_FW_CFG].base;
 
-    fw_cfg = fw_cfg_init_mem_wide(cfg_addr, cfg_addr + 8, 8, 0, NULL);
+    fw_cfg = fw_cfg_init_mem_nodma(cfg_addr, cfg_addr + 8, 8);
     fw_cfg_add_i16(fw_cfg, FW_CFG_NB_CPUS, (uint16_t)current_machine->smp.cpus);
     fw_cfg_add_i16(fw_cfg, FW_CFG_MAX_CPUS, (uint16_t)current_machine->smp.max_cpus);
     fw_cfg_add_i64(fw_cfg, FW_CFG_RAM_SIZE, loaderparams.ram_size);
-- 
2.52.0


