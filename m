Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5E4FEE3693
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Feb 2026 14:45:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqXvJ-0005qc-Ra; Thu, 12 Feb 2026 09:44:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vqXux-0005Nh-Op
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 09:43:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vqXuV-000629-6I
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 09:43:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770907394;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ST95/BNrjjmUYvk/3RmRykxO/bM5J4yv/3ZrgUtkelc=;
 b=ewn/f1jK0qO7wnVgxj9XyYvZDAbSUhkvBzQidVJvXrkmhsHtybLlgXCyFK6bD5PReCrPG0
 UdwhNRcrBKndDdRKpRPhGIvUjISRVUCk+rlNPw17l9iTKJi/dUjOudoxrp8z6L27E6UMMb
 FXHCBrfkbG3dZl4JKC7XgLwNKZzM41g=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-74-4ftNYiwsMAS5CxJEPVKisg-1; Thu, 12 Feb 2026 09:43:12 -0500
X-MC-Unique: 4ftNYiwsMAS5CxJEPVKisg-1
X-Mimecast-MFC-AGG-ID: 4ftNYiwsMAS5CxJEPVKisg_1770907391
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-48057c39931so83175005e9.0
 for <qemu-devel@nongnu.org>; Thu, 12 Feb 2026 06:43:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1770907390; x=1771512190; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ST95/BNrjjmUYvk/3RmRykxO/bM5J4yv/3ZrgUtkelc=;
 b=i96gd0j4fZY8I+QSfy9CecIYNbjeTfYLtvz+pBI7UBNvNB3rdU7Z/DXcjn/+1PL1SG
 mE2QI8dVWQGj6wlDKOugMC1pnhB3L0wURf2F4+sHz2KLZMYL9/2ZJg7ylg+9wdIAyaL5
 hch3W+vcL4sPZ+dhijLQxRPLw1cIE1Fsnl/wtYI0p/lhlCm5sA45FydQGWgZ1yBmN5PL
 GExf4uaR1xwvmd4EU0mXQ0gDLe2Cl+PxP6y2g882n7sink5nEyqvfK+cbpTAsSeVzyuh
 Cewjmv33U7MWqIDXylnmVcpPbLs6wNOwtlf+8wkXOEWHpgRTUvBjh30P05BJBMdXMWv+
 XBUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770907390; x=1771512190;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ST95/BNrjjmUYvk/3RmRykxO/bM5J4yv/3ZrgUtkelc=;
 b=Vhcsv4jbBoe86JZ/un/ZXZNVqmCLlwLZWUmENoYX9tYD30blKSi2ZHuxz6COmnFup9
 2n0yuheUUaqnhq0wBhObelAf+1T0+Fbfl77q9WCwjjrwsmhd8UlaRrF3CA+yoIk6Vopb
 hufy0qygdJmKnrIGQP06oD8JoRZvr8V2m0JEjugoQ3iqm0FPX00Dcysv8UQwKJEG/ilE
 ELaDxWufxN+tHiDjrj4serXgjEFPGFpduIkXWcRgSUlg00tg8eik6+8YH3ThLMBKIZG/
 KpTqZgm2oSPF/xbU209QPYhI7S6QaU1J53k0jWK0wnV5y3zStbnXN36xR712QH8LLzrk
 RT6g==
X-Gm-Message-State: AOJu0YzUcm5A4SqgNVe0c7yDzmVIPnm1VzBEybD0CPWXn/Z/8hguY3FY
 2uvX5h//9tVcakDbjx/a99GLbr8psbamdLZ9JZvLJdLoXEKOALaM22MkkfnnN2JDKV+Yk/nDW/d
 otPeKGkuVQTjXShrE8cUgaeTs0Pyuof3BDTUciaTYVtyYJoEMtc+pneL9l2UynoHFpeU8sk7uVo
 1B+NFC5KSNQOk1zuNrK8m5vKGahxPJrhdTn+UrrD4Q
X-Gm-Gg: AZuq6aLl8uvqpppyfXTyP2BtcSqN6yV9NGbhGCcm5wT6S55ut1kGVMKOKMm2LXDNVFx
 C90oNg6BmHcZO6Miu5/4pU8SGFfRZwx3huL2L2DwwlxYmxqOEkbLCpiNAgF9z9GPWVb1DHuuEg/
 4HTCTTnMA0N6fgvxRNBRCZrl+qpMEdUtEbFvODus31vcp89ZXml9UUw+bPyzhblWCP6jj1GzARA
 6VuQOFxrtA2Tk79HoPS+/PTlVC1mPAMBgG3yhL/1dxlIra3WF8CUj50pCeMBzQbSe3e5IbBXO7X
 UzRFyrcq7OZzq98bwH+6efxym/iYKPPseww7QaLsiO813YzxjM2F/bZvLJ3fhverwVinOf7s70V
 rwIME5lzuPlaqpf9rVVcpuRKqldmch/KmLC2WV6W8q3SrQuwlC5nUBRuwZIwhuBGH5GPK9QTGU6
 noGDl/KKdReBKZ4gKts2QUMeo0q5VCS7dNNMJj00SzbFJDLgiDJ6Y=
X-Received: by 2002:a05:600c:450e:b0:477:a219:cdb7 with SMTP id
 5b1f17b1804b1-48365610fecmr46355975e9.0.1770907390660; 
 Thu, 12 Feb 2026 06:43:10 -0800 (PST)
X-Received: by 2002:a05:600c:450e:b0:477:a219:cdb7 with SMTP id
 5b1f17b1804b1-48365610fecmr46355615e9.0.1770907390255; 
 Thu, 12 Feb 2026 06:43:10 -0800 (PST)
Received: from [10.60.241.123] (nat-pool-mxp-t.redhat.com. [149.6.153.186])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4835dd20519sm209226585e9.15.2026.02.12.06.43.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Feb 2026 06:43:08 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Igor Mammedov <imammedo@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Xiaoyao Li <xiaoyao.li@intel.com>
Subject: [PULL 11/41] hw/nvram/fw_cfg: Factor fw_cfg_init_mem_internal() out
Date: Thu, 12 Feb 2026 15:42:13 +0100
Message-ID: <20260212144244.22579-12-pbonzini@redhat.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260212144244.22579-1-pbonzini@redhat.com>
References: <20260212144244.22579-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

Factor fw_cfg_init_mem_internal() out of fw_cfg_init_mem_wide().
In fw_cfg_init_mem_wide(), assert DMA arguments are provided.
Callers without DMA have to use the fw_cfg_init_mem() helper.

Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Link: https://lore.kernel.org/r/20260108033051.777361-11-zhao1.liu@intel.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/nvram/fw_cfg.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/hw/nvram/fw_cfg.c b/hw/nvram/fw_cfg.c
index 7751de3d977..8a21cdae4fc 100644
--- a/hw/nvram/fw_cfg.c
+++ b/hw/nvram/fw_cfg.c
@@ -1054,9 +1054,9 @@ FWCfgState *fw_cfg_init_io_dma(uint32_t iobase, uint32_t dma_iobase,
     return s;
 }
 
-FWCfgState *fw_cfg_init_mem_wide(hwaddr ctl_addr,
-                                 hwaddr data_addr, uint32_t data_width,
-                                 hwaddr dma_addr, AddressSpace *dma_as)
+static FWCfgState *fw_cfg_init_mem_internal(hwaddr ctl_addr,
+                                            hwaddr data_addr, uint32_t data_width,
+                                            hwaddr dma_addr, AddressSpace *dma_as)
 {
     DeviceState *dev;
     SysBusDevice *sbd;
@@ -1088,10 +1088,19 @@ FWCfgState *fw_cfg_init_mem_wide(hwaddr ctl_addr,
     return s;
 }
 
+FWCfgState *fw_cfg_init_mem_wide(hwaddr ctl_addr,
+                                 hwaddr data_addr, uint32_t data_width,
+                                 hwaddr dma_addr, AddressSpace *dma_as)
+{
+    assert(dma_addr && dma_as);
+    return fw_cfg_init_mem_internal(ctl_addr, data_addr, data_width,
+                                    dma_addr, dma_as);
+}
+
 FWCfgState *fw_cfg_init_mem_nodma(hwaddr ctl_addr, hwaddr data_addr,
                                   unsigned data_width)
 {
-    return fw_cfg_init_mem_wide(ctl_addr, data_addr, data_width, 0, NULL);
+    return fw_cfg_init_mem_internal(ctl_addr, data_addr, data_width, 0, NULL);
 }
 
 
-- 
2.52.0


