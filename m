Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E516C6FD1F
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Mar 2024 15:48:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rp90D-0004V7-GD; Tue, 26 Mar 2024 11:46:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rp907-0004Ah-IQ
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 11:46:14 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rp905-0001Gk-RF
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 11:46:11 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-414925ba716so554715e9.2
 for <qemu-devel@nongnu.org>; Tue, 26 Mar 2024 08:46:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711467965; x=1712072765; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=a9aAigC2kGTbid56AicgylDWHcJDSIM2k5pIIBM/YvQ=;
 b=FmYpNi7QecEHtkQhubQskR+WXcoThxDv0g+BLSCZ2xir1KJr/NjBTcI8DUOxqD5LHi
 gvBxstumxYsTnRScTg+PhX0iskLMP4R57PqFdmRVhShgbKhKHs8iCDqUUcc0HEkefY10
 eoQdB4t2laCXVHMmOWjCXU2RvBqN+HZVDI2sCU7+8nP48msST/Y3m2E8YSc9y8lzZ5c4
 Y2dDYml9KYOE466Yl8JBtDlSg3pMfjiNjEBWJUtC9cLx/JvrGQgVJipZeF1gYegRBdQc
 NIGvBqAOpz2nD19Mul1Wtf6zZQdv/0rsDmd9+3zy2q72n3R9fq4hbKQ0wZiG6owfaJmF
 7c9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711467965; x=1712072765;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=a9aAigC2kGTbid56AicgylDWHcJDSIM2k5pIIBM/YvQ=;
 b=GhNhDvNDZxBcJWK3R55FKIXtXwp6bsOStjEXDHcwzFfMTYiu3wp6apZR95i3+jUVVO
 kSy6vUnIXt8JKLX6MqlqdwFomSQKFtU9L2/SUhNPWOwt584IP6m+LwReVxS37GDA/0hC
 jsabyNIX/R4md9RQGmOIhuvibqIlGKgJjiQRx9odWYUlAi3wwRuvrZy8tLxvGgpT28H3
 ioc6kf2p7AJkeSA+UcwdrEGW/7ZnUQo8FMGE3As8ZtaZn5kUBZ56FreWaTDjXkPehJNq
 togUwtbIrC3PIjuRWW3dQgtxaQcdE1XzO6dPWW2MYME2TkoTnokD8m6KRcnAnba2jhBW
 PHLA==
X-Gm-Message-State: AOJu0Yzu6e3hYYL0A0cpaFCCg4WrSLZPzetQ61PThBx0VYwcU+iVi0HV
 E9kY0p9rssz3pwRE9AeVbxqa2CI/+Hzzna0o0hOScqXrmf6CMvbEXsiYp7SWjG1VJiwssq1DHfR
 P
X-Google-Smtp-Source: AGHT+IEjtrSFCNEY47soq5vKoplHVtVUMDMmF4uo4x7IIKcMlaSMqvhHG8ToCvVGq+6FAmFxfFcHxg==
X-Received: by 2002:a5d:464c:0:b0:33b:87fb:7106 with SMTP id
 j12-20020a5d464c000000b0033b87fb7106mr1879099wrs.55.1711467965635; 
 Tue, 26 Mar 2024 08:46:05 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.155.229])
 by smtp.gmail.com with ESMTPSA id
 bx12-20020a5d5b0c000000b0033e45930f35sm2895844wrb.6.2024.03.26.08.46.04
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 26 Mar 2024 08:46:05 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-ppc@nongnu.org,
 Igor Mammedov <imammedo@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha <anisinha@redhat.com>
Subject: [PULL 10/13] hw/smbios: add stub for smbios_get_table_legacy()
Date: Tue, 26 Mar 2024 16:45:01 +0100
Message-ID: <20240326154505.8300-11-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240326154505.8300-1-philmd@linaro.org>
References: <20240326154505.8300-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

From: Igor Mammedov <imammedo@redhat.com>

QEMU build fails with

  hw/i386/fw_cfg.c:74: undefined reference to `smbios_get_table_legacy'

when it's built with only 'microvm' enabled i.e. with config patch

   +++ b/configs/devices/i386-softmmu/default.mak
   @@ -26,7 +26,7 @@

   # Boards:
   #
   -CONFIG_ISAPC=y
   -CONFIG_I440FX=y
   -CONFIG_Q35=y
   +CONFIG_ISAPC=n
   +CONFIG_I440FX=n
   +CONFIG_Q35=n

It happens because I've fogotten/lost smbios_get_table_legacy() stub.

Fix it by adding missing stub as Philippe suggested.

Fixes: b42b0e4daaa5 "smbios: build legacy mode code only for 'pc' machine"
Reported-by: Michael Tokarev <mjt@tls.msk.ru>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20240326122630.85989-1-imammedo@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/smbios/smbios_legacy_stub.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/hw/smbios/smbios_legacy_stub.c b/hw/smbios/smbios_legacy_stub.c
index f29b15316c..7d593dca98 100644
--- a/hw/smbios/smbios_legacy_stub.c
+++ b/hw/smbios/smbios_legacy_stub.c
@@ -13,3 +13,8 @@
 void smbios_add_usr_blob_size(size_t size)
 {
 }
+
+uint8_t *smbios_get_table_legacy(size_t *length, Error **errp)
+{
+    g_assert_not_reached();
+}
-- 
2.41.0


