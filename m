Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B346FC05024
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2024 13:57:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rwjFP-0001iM-7w; Tue, 16 Apr 2024 09:53:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rwjFK-0001dd-DB
 for qemu-devel@nongnu.org; Tue, 16 Apr 2024 09:53:14 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rwjFC-0001Qo-E1
 for qemu-devel@nongnu.org; Tue, 16 Apr 2024 09:53:10 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4187981999fso10838945e9.1
 for <qemu-devel@nongnu.org>; Tue, 16 Apr 2024 06:53:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713275582; x=1713880382; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nlICCskRrlvRdkjV4msjzmW/coeNcYFuGhTikB5Lgzk=;
 b=o/IpkZpJqKB5oTYFYYEbkAeWjfYZ0Q6fN20552PfnQh7+1/a6Pp1XuNe2daYxzHphR
 ceBGs6LGXDexcMqSmSgcCADjX6ELovk8d7BFQHenImTfjBDGg789xPdGbK7exzdayK/k
 Z4D95DJ8ltTilihVVOEuXYe5uvQ+FHR3Y9RDu0XkTlyzkIrwkROG3KG3lzZpug1LSaEt
 FD3zTWV9Rw3Iy0VCRgIvjDuAV1BcHh0PSuL5qb5VN3KhL0Qb7Z7+m78f1ABj3TG2DdCj
 Fog2HDcIYhuSr1OMgR3QNt5Rw/EbY9TWCEAC+222vkgDQJ7GyCEgUNWq5l/gOPG7PYFL
 B++g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713275582; x=1713880382;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nlICCskRrlvRdkjV4msjzmW/coeNcYFuGhTikB5Lgzk=;
 b=SdxyjRQ/o6BsNtX/tRZ4rsNB2I5G2N30qAub3/b3FRYdc/S6Beuox6PBuM8uyKHN8u
 K3DB2/0BXJauHUkHiKvzEt45+avqwbiKouTLMWB3aFEO0XkIohfrKm1gHXgxhTCNNz2K
 UvUOn9Wm8Efk1iJse//nADf2KsGNYexxvBohukc7cT2kpSljC8QRLIlSncDXY3QIbg1F
 WdnvRulyYLb7CouK+PxbJiJXDUI5WbrW5nys3gcZ0Q7+ax9fwv3b33NHmLfwuY4WuFyL
 OHAw+hTuj//shSPGN2Xlp64fcXoKatU3jl59uSsQLNX/YeIU4pzP4vy7BIBLXifp2R2d
 BWWw==
X-Gm-Message-State: AOJu0YxSTtnLvjlOgisDj/aAxnV+Q7vXZjgtEY99V4dey3zEjnupLPM3
 PfqFHiuMv4aT/rabuz3do+dVoeVImKNpS9BmQvr3FPuDB3hQSf34l0SyGkXYJNgdU+zkaLNsDsf
 H
X-Google-Smtp-Source: AGHT+IFLkAP+zDOnOOgoceMFenmSQbQE0pRL/TOiApOGPkF5clFU8nwmq7W/o1+WXm3e+kdzLTwyEA==
X-Received: by 2002:a05:600c:3c87:b0:416:b91c:f310 with SMTP id
 bg7-20020a05600c3c8700b00416b91cf310mr9120012wmb.22.1713275581931; 
 Tue, 16 Apr 2024 06:53:01 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.155.61])
 by smtp.gmail.com with ESMTPSA id
 u24-20020a05600c00d800b004185be4baefsm1704968wmm.0.2024.04.16.06.53.00
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 16 Apr 2024 06:53:01 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org,
	Thomas Huth <thuth@redhat.com>
Cc: Ani Sinha <anisinha@redhat.com>, qemu-riscv@nongnu.org,
 qemu-ppc@nongnu.org, Zhao Liu <zhao1.liu@intel.com>,
 David Hildenbrand <david@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 devel@lists.libvirt.org, Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PATCH v3 01/22] hw/i386/pc: Deprecate 2.4 to 2.7 pc-i440fx machines
Date: Tue, 16 Apr 2024 15:52:30 +0200
Message-ID: <20240416135252.8384-2-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240416135252.8384-1-philmd@linaro.org>
References: <20240416135252.8384-1-philmd@linaro.org>
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

Similarly to the commit c7437f0ddb "docs/about: Mark the
old pc-i440fx-2.0 - 2.3 machine types as deprecated",
deprecate the 2.4 to 2.7 machines.

Suggested-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 docs/about/deprecated.rst | 4 ++--
 hw/i386/pc_piix.c         | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
index 7b548519b5..967ee34267 100644
--- a/docs/about/deprecated.rst
+++ b/docs/about/deprecated.rst
@@ -219,8 +219,8 @@ deprecated; use the new name ``dtb-randomness`` instead. The new name
 better reflects the way this property affects all random data within
 the device tree blob, not just the ``kaslr-seed`` node.
 
-``pc-i440fx-2.0`` up to ``pc-i440fx-2.3`` (since 8.2)
-'''''''''''''''''''''''''''''''''''''''''''''''''''''
+``pc-i440fx-2.0`` up to ``pc-i440fx-2.3`` (since 8.2) and ``pc-i440fx-2.4`` up to ``pc-i440fx-2.7`` (since 9.1)
+'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
 
 These old machine types are quite neglected nowadays and thus might have
 various pitfalls with regards to live migration. Use a newer machine type
diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index 18ba076609..ec9c299b06 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -778,6 +778,7 @@ DEFINE_I440FX_MACHINE(v2_8, "pc-i440fx-2.8", NULL,
 static void pc_i440fx_2_7_machine_options(MachineClass *m)
 {
     pc_i440fx_2_8_machine_options(m);
+    m->deprecation_reason = "old and unattended - use a newer version instead";
     compat_props_add(m->compat_props, hw_compat_2_7, hw_compat_2_7_len);
     compat_props_add(m->compat_props, pc_compat_2_7, pc_compat_2_7_len);
 }
@@ -832,7 +833,6 @@ static void pc_i440fx_2_3_machine_options(MachineClass *m)
 {
     pc_i440fx_2_4_machine_options(m);
     m->hw_version = "2.3.0";
-    m->deprecation_reason = "old and unattended - use a newer version instead";
     compat_props_add(m->compat_props, hw_compat_2_3, hw_compat_2_3_len);
     compat_props_add(m->compat_props, pc_compat_2_3, pc_compat_2_3_len);
 }
-- 
2.41.0


