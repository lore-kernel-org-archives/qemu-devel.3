Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C77C1EE368C
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Feb 2026 14:54:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqXvI-0005o6-Mc; Thu, 12 Feb 2026 09:44:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vqXv3-0005PG-DB
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 09:43:54 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vqXv1-0006BL-S8
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 09:43:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770907427;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kZ15JADujw0LyvCgnaafncrrHu/B+7f+maVF03/vnno=;
 b=eC8hwozc0FBDKRAKFMLYlWLMNS3fPSydPEl58DYiih/kD8LeeHeKmaZgMUngITsSWbxSoE
 hKnjqfDztW2GeRKQb12HyP+eW5ZssnRibcO7JVggIxTA37pxvYkqNSha6AFSn8jXDI8FDD
 I5EUVaujZzR3xdrkspdbsFiXkdtsM+s=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-676-dTngS0uzNU-1nRZ3Rv01NA-1; Thu, 12 Feb 2026 09:43:46 -0500
X-MC-Unique: dTngS0uzNU-1nRZ3Rv01NA-1
X-Mimecast-MFC-AGG-ID: dTngS0uzNU-1nRZ3Rv01NA_1770907425
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-43623192c6aso3965703f8f.3
 for <qemu-devel@nongnu.org>; Thu, 12 Feb 2026 06:43:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1770907424; x=1771512224; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kZ15JADujw0LyvCgnaafncrrHu/B+7f+maVF03/vnno=;
 b=RVWmCCPGsHLlvyWs1qP7kn0V2ZCIyGcE54cSilAEPhJDOEqwRvgyDf2bQsKwkIc7Cx
 G54SS+C3dQIo7aHl6g88lh1rteF3UaRs0CJzF6C4Ff/G5YYzcnawgfXTFIEgSZbKU4hz
 2C0E3hx5XDnOH1DwsbeXwl7HCtjW6MbOipnVwEq/V0s7ksOg2WfSB1Y0sd5I1YZpEnca
 JrWIZMiG5Hi/lanOvNeVGrDxXIvPFmTBrtNjs2TKYOgggkdf5+eEw5PPi9lCF1tBXOVG
 miBW6sM5wTsn0vZVlKCEs3uR6XxF3OX4XztnN9nwsxrMMiN/i3RD712PcExQmQ+5y7ed
 jl+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770907424; x=1771512224;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=kZ15JADujw0LyvCgnaafncrrHu/B+7f+maVF03/vnno=;
 b=EF6e3YpQX56CALD84u+64viLeykLRpI+GvgwaUiY+zGSfG38C6e3oJcWtGzp8k9o5d
 ejvH227CnxQV2LOWtIOfhmAfWFtI2cCzwKdoBgzSmodYYwvAiUvZnuraKHHYhI/zOsx2
 UeYnjzXcEaPULXkOf40NVMD0Y502DJ+3y8rIFzGb6vPA4Zxq7QkwbfbCezkQZM/6luxK
 GGDMo3HlsudIRIGXnRYD3VdN7hjxkR+q2f+r5hdH1vf8O6ArE+2JhayHj4lg5BDqHIW1
 xOcK8s+aRfqHja0oHr3YaZ434svZaKR6+6hLyNDuBEybU1n2YwXSMxBSXr2Qga0w+NRx
 yg4Q==
X-Gm-Message-State: AOJu0YwCQo3vrWlgAMcMN5h9161DQPn8fzPpWYJyI7uO1W9KEwzmWsEK
 f4EBdjfaiRBlv4A9VoE6+m3Ar1fbPJFxYh/Y0CT/3Nl7FWgHPFZsswjLYluI0RPbjDOyk8G1Yge
 iJ09u6N7CxRVTcqLClM5jXLD/ZFr8aFT3kLdiF4Zg4ex9mjvYSD7jAQkvD3d9Irh9XM5s+gd3Ki
 wvTKpgZhIGlAjf/b6zcv9sSEvLOP7axx0TPHT76xWh
X-Gm-Gg: AZuq6aIh2nDKYS2DF9RkbbItbfb+C1j00oaU6R0qPZWbgk36D6XXlvtVln3L65JOeBG
 XZ8GGmtxKbcd7lfdvc2Nm84DPh0zArI36ABVj9f0oCvPLoV61KdFNfe/5aGN220AOcQ4gMxCFd4
 X6tXMA3ansprlGHJVY+4/XEfV6vCEtK2ta2TQgBsmQODcbnv+SrhS+owj+z20vzC1GrnUhVNsWj
 WdmnmZXToi9cS6D/ajT87VQy0MR+gSa+ylJBhluixG26peOhBJZCrhsPfjkXQQXXyVCOxqDks+z
 ++Jfj8y5HsYvwZmGkwLTWJzyz1meOxcmLbaYJxepUW5qXzz3OeTrNLUcfUQkcfjNlqCTlzcs9B4
 qMIPGtBNn68P/Yw+21DkcHoC5/eo32nXDBlp8QXSAb8ctyHQwUqWyxeeA4vTzYHdu8G85WyGFrZ
 Sj0FLbj9/Z9ynOA8lvaK9Ul9iQFLlby92kiJhdd6RySKSH0kQJES8=
X-Received: by 2002:a5d:55c7:0:b0:436:f7e5:e057 with SMTP id
 ffacd0b85a97d-4378f168bb3mr3269300f8f.49.1770907424009; 
 Thu, 12 Feb 2026 06:43:44 -0800 (PST)
X-Received: by 2002:a5d:55c7:0:b0:436:f7e5:e057 with SMTP id
 ffacd0b85a97d-4378f168bb3mr3269255f8f.49.1770907423477; 
 Thu, 12 Feb 2026 06:43:43 -0800 (PST)
Received: from [10.60.241.123] (nat-pool-mxp-t.redhat.com. [149.6.153.186])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43783b09b99sm12762592f8f.0.2026.02.12.06.43.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Feb 2026 06:43:42 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Mark Cave-Ayland <mark.caveayland@nutanix.com>,
 Zhao Liu <zhao1.liu@intel.com>, Igor Mammedov <imammedo@redhat.com>
Subject: [PULL 25/41] hw/core/machine: Remove hw_compat_2_7[] array
Date: Thu, 12 Feb 2026 15:42:27 +0100
Message-ID: <20260212144244.22579-26-pbonzini@redhat.com>
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

The hw_compat_2_7[] array was only used by the pc-q35-2.7 and
pc-i440fx-2.7 machines, which got removed. Remove it.

Reviewed-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Link: https://lore.kernel.org/r/20260108033051.777361-25-zhao1.liu@intel.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/hw/core/boards.h | 3 ---
 hw/core/machine.c        | 9 ---------
 2 files changed, 12 deletions(-)

diff --git a/include/hw/core/boards.h b/include/hw/core/boards.h
index d6ff9f3d233..a99ef4ca469 100644
--- a/include/hw/core/boards.h
+++ b/include/hw/core/boards.h
@@ -882,7 +882,4 @@ extern const size_t hw_compat_2_9_len;
 extern GlobalProperty hw_compat_2_8[];
 extern const size_t hw_compat_2_8_len;
 
-extern GlobalProperty hw_compat_2_7[];
-extern const size_t hw_compat_2_7_len;
-
 #endif
diff --git a/hw/core/machine.c b/hw/core/machine.c
index 2664848c2b0..308bd0b6088 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -284,15 +284,6 @@ GlobalProperty hw_compat_2_8[] = {
 };
 const size_t hw_compat_2_8_len = G_N_ELEMENTS(hw_compat_2_8);
 
-GlobalProperty hw_compat_2_7[] = {
-    { "virtio-pci", "page-per-vq", "on" },
-    { "virtio-serial-device", "emergency-write", "off" },
-    { "ioapic", "version", "0x11" },
-    { "intel-iommu", "x-buggy-eim", "true" },
-    { "virtio-pci", "x-ignore-backend-features", "on" },
-};
-const size_t hw_compat_2_7_len = G_N_ELEMENTS(hw_compat_2_7);
-
 MachineState *current_machine;
 
 static char *machine_get_kernel(Object *obj, Error **errp)
-- 
2.52.0


