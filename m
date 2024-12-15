Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E49BE7716A
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Dec 2024 19:19:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tMtx8-0002Or-Bb; Sun, 15 Dec 2024 14:06:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tMtwZ-0001Lw-1p
 for qemu-devel@nongnu.org; Sun, 15 Dec 2024 14:06:20 -0500
Received: from mail-oo1-xc36.google.com ([2607:f8b0:4864:20::c36])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tMtwW-0001AA-D1
 for qemu-devel@nongnu.org; Sun, 15 Dec 2024 14:06:17 -0500
Received: by mail-oo1-xc36.google.com with SMTP id
 006d021491bc7-5f2da12248fso2170297eaf.1
 for <qemu-devel@nongnu.org>; Sun, 15 Dec 2024 11:06:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734289575; x=1734894375; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/7D9unWrlHZoR8A1dN23AeSaSZJKRolZppIb6v+BQvE=;
 b=BIbGXi3jLljHc1VMbaADM/GoIZj0Wl9xrdqE1BTCt9JlLRWY6AxGNUHXcq/xp55PeQ
 O9vf2kXziTj3SdooccJxNErmhRecgYAWBd+y69xo3zb8E9jzb0Bdg3BESRdhJVjvOkXp
 GPoHsbgoZYmyW4f70Eh2gtwvzTrL9ZqF3LYyXnuoqTYU0hAUf/jBiyfocNgQP+XEC6bt
 Yzd0HfQOk6U6pL2+khC6QbOjxLpoCQ5+GY8KxBsqdGt94oWsdQKwnXptzENS91DqqoA/
 /anqxHWIthkDdyeq3mvEf7vZLPy/sjP2+jYhyp2DspGq+yTFGpQcjLeUY6futKVVBSa+
 leWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734289575; x=1734894375;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/7D9unWrlHZoR8A1dN23AeSaSZJKRolZppIb6v+BQvE=;
 b=dd2VdXJEQlmCog4V4aaXG3rfF14svuaBnoemXV3rbwoaLjYh3LSkCLHWEfpQfxH6rs
 915DUMKlYclVNKZsMnNg60U6HO0YXolsc8hA4IIuknYidZR5JeAeu64dNG0yGypB8Sm4
 6FidPMW7gan8SXqI7ukDIWvrfwHIQfgDfG4U77mJR2GjLUqqyTfR30FS+YXSufIBi/m1
 LplDDSnCj2C2IY30JUBTn+2xFdLJso9UPilpm2VHHq4QEfj4JNox95QVHh4ufYhV/FMy
 dBs61C11P5OMWubygCs4yPLty629HjCJ3EffACj0Cej3zGjwQyvAwLFAANhLsup4pkwB
 RofA==
X-Gm-Message-State: AOJu0Yy4Qwg5ogPhWee49T5JNPzb2sLhErhu7JtaOwvy/iwXOjUANhDq
 hyOyLH+4F1s7GkQJMvEtSccRd3pqi5P6h+oif1t/kIKCTe4a8Kcyua0CXS1VVdVBE/IWnF0GR6s
 nt7OJpeTY
X-Gm-Gg: ASbGnctpP+fuY2R9PMjMFCBW3TziFjKL7ZNDfzjQNGEukgWijgeUuvCPS61vcqJPuL0
 TOQuXxLKOLO3NqW2zVIP6qKdOme55F11nx9OYriGSi/8m1miM9dkg5+bKWNSIUdfaZAs54YUufN
 +G+9B6vXJ4yYN+Ld/Hbew6MlooWJZGvB7sRK7JU/ItzOojTKdghIqGFv0gjCfYi6cZ7r6yECVCf
 Z+hdGmptvlyollQ9WVWIR1WABpBhnAtowkvjTXBYj74UEVoiSv3d409yeGlzDbQHj3YVVn09L6a
 HXF7dtqmkZHxehImMB/hmyyHpchxOdchzVM7wE5qLdU=
X-Google-Smtp-Source: AGHT+IHhyoMuUFa1Wi2ZrHrrsSIkgRylhCcCpewSYlx2G64qXKLgMO5+8oxEEOCpXCOodpB2oeBUDQ==
X-Received: by 2002:a05:6870:1d1:b0:29e:1962:7a23 with SMTP id
 586e51a60fabf-2a3aef703cdmr5561380fac.4.1734289574698; 
 Sun, 15 Dec 2024 11:06:14 -0800 (PST)
Received: from localhost.localdomain (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2a3d2914ac6sm1423214fac.39.2024.12.15.11.06.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Dec 2024 11:06:14 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 26/67] hw/hyperv: Constify all Property
Date: Sun, 15 Dec 2024 13:04:52 -0600
Message-ID: <20241215190533.3222854-27-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241215190533.3222854-1-richard.henderson@linaro.org>
References: <20241215190533.3222854-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c36;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc36.google.com
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 hw/hyperv/hv-balloon.c | 2 +-
 hw/hyperv/syndbg.c     | 2 +-
 hw/hyperv/vmbus.c      | 4 ++--
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/hyperv/hv-balloon.c b/hw/hyperv/hv-balloon.c
index 3a9ef07691..74897b1604 100644
--- a/hw/hyperv/hv-balloon.c
+++ b/hw/hyperv/hv-balloon.c
@@ -1733,7 +1733,7 @@ static void hv_balloon_finalize(Object *obj)
     hv_balloon_unrealize_finalize_common(balloon);
 }
 
-static Property hv_balloon_properties[] = {
+static const Property hv_balloon_properties[] = {
     DEFINE_PROP_BOOL("status-report", HvBalloon,
                      status_report.enabled, false),
 
diff --git a/hw/hyperv/syndbg.c b/hw/hyperv/syndbg.c
index 065e12fb1e..0193addd42 100644
--- a/hw/hyperv/syndbg.c
+++ b/hw/hyperv/syndbg.c
@@ -366,7 +366,7 @@ static const VMStateDescription vmstate_hv_syndbg = {
     .unmigratable = 1,
 };
 
-static Property hv_syndbg_properties[] = {
+static const Property hv_syndbg_properties[] = {
     DEFINE_PROP_STRING("host_ip", HvSynDbg, host_ip),
     DEFINE_PROP_UINT16("host_port", HvSynDbg, host_port, 50000),
     DEFINE_PROP_BOOL("use_hcalls", HvSynDbg, use_hcalls, false),
diff --git a/hw/hyperv/vmbus.c b/hw/hyperv/vmbus.c
index b36bd3d67d..3d1f4d14e8 100644
--- a/hw/hyperv/vmbus.c
+++ b/hw/hyperv/vmbus.c
@@ -2346,7 +2346,7 @@ static void vmbus_dev_unrealize(DeviceState *dev)
     free_channels(vdev);
 }
 
-static Property vmbus_dev_props[] = {
+static const Property vmbus_dev_props[] = {
     DEFINE_PROP_UUID("instanceid", VMBusDevice, instanceid),
     DEFINE_PROP_END_OF_LIST()
 };
@@ -2653,7 +2653,7 @@ static const VMStateDescription vmstate_vmbus_bridge = {
     },
 };
 
-static Property vmbus_bridge_props[] = {
+static const Property vmbus_bridge_props[] = {
     DEFINE_PROP_UINT8("irq", VMBusBridge, irq, 7),
     DEFINE_PROP_END_OF_LIST()
 };
-- 
2.43.0


