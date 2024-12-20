Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F24FE7718B
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2024 16:25:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOfjm-0007Zf-KF; Fri, 20 Dec 2024 11:20:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tOfjh-0007CK-MS
 for qemu-devel@nongnu.org; Fri, 20 Dec 2024 11:20:21 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tOfjf-00008e-Tk
 for qemu-devel@nongnu.org; Fri, 20 Dec 2024 11:20:21 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-435f8f29f8aso15634405e9.2
 for <qemu-devel@nongnu.org>; Fri, 20 Dec 2024 08:20:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734711618; x=1735316418; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eS7XCn1x67fCSopIP8en6mFUhhP2kj3st4Xc0cwgiaM=;
 b=HPVhmtaHEZjKuaKTZgIEYZbn6CzIZ019/vA6aTMz1PduZ6qLvpr1ZkYBkbg+G+bHib
 +I+PW+vIiVyx442Spb8yeigjrvObOXPqytLlOPK/Gx1uoT8TVx6a0khM5+OZDiwDI/pG
 1T8DfzkeJI1AijVHcs0zoUVFlUJXJkVP7xkPxwOzxf1yi7HKWvasL3ZRIcV2eBtm1UIG
 68gXu5oUg1nvZiGmjhbwnNMNFplnsylwGxlg59IsgfFPWg3KHoLXxdyeHsVntq7DcN5e
 TMNdVBF6kySSXkNA0S4mUvUFomgoFdn5/40HpGaaOKg0Y1cZmQ3hptRBAdtahNq11BMF
 nGpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734711618; x=1735316418;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eS7XCn1x67fCSopIP8en6mFUhhP2kj3st4Xc0cwgiaM=;
 b=SYU+/42sgrrePOKmP9tQlTTcJ9xZs1L/mUwPqx6tuclDC4EGGUpdadXK+hS+EC39E9
 tQ0fv7M8NEvGIvh8cgefxr5RNosyLxMf9+pB5uO7EW+IoRGtQNsomMRMvqFzaDdrJaCp
 SNE93+pLpO9h8DFs9axCNq7Y3fX8YAOrAaT4OKE05wj7a4K8oYWOzYL5NL9o1COZzOSv
 vOYsx6GAcHDmXQMIpFQSUpKWyq0OMalfOPnfRe9QwuHtogBKdx+wTH2zcIupz9MEiz4u
 Eln9MiEsyZcpMTPaSUY+pSIcdIkhiDO5mtE7TnqK1bHsDPFo3ci6bGJgD7wWilEpv/Cv
 Y4sQ==
X-Gm-Message-State: AOJu0Ywe7+OrNxQJ0cPr7USrNWQdyK3nP9wMZ3vbzDlu7p+W0376GYcD
 kd4HVESggVA+ok9xdWkIatSTa2jml5GtMulDD0K3BPElOeKFR6m+sgV3Lx9PCi357xp8viAfAYi
 i
X-Gm-Gg: ASbGnctxGgShMp7Mps+dtEcbNTbZDqHHK0FX5CWIeE0sLn0fwJIbXrjxWsNuWiSl+ax
 9DUYdwku9HMXuxG8N2NOWL1Cu5Js2OH3dQYKVoE9dKxJmJN+Ww9WvM7jcim8yM1SP7BsGnywBR8
 CZQZD2rPPEbgTvZonSIO5bqjDnH/Q38Is/4LVjSOhxqcWiALQ9EF/JtbD9IG27voeT+/Z1jtdQI
 15jRE8afauU9DqiDEWgWsAXoLrBikF2N1c5690VC2gO/HIAiccy6NJt0oq8jBFLNYky55ujelg=
X-Google-Smtp-Source: AGHT+IEzERc/Xpj953bRSwrRCheaj27yO52tSd6hG3HwY5mNx7f8WVLNqRU0H4jjei3U9Xc6N5bT4w==
X-Received: by 2002:a05:600c:450d:b0:434:a367:2bd9 with SMTP id
 5b1f17b1804b1-43668643616mr33012925e9.14.1734711618125; 
 Fri, 20 Dec 2024 08:20:18 -0800 (PST)
Received: from localhost.localdomain ([78.196.4.158])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43656b11495sm83498655e9.19.2024.12.20.08.20.17
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 20 Dec 2024 08:20:17 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 58/59] meson: Do not define CONFIG_DEVICES on user emulation
Date: Fri, 20 Dec 2024 17:15:49 +0100
Message-ID: <20241220161551.89317-59-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241220161551.89317-1-philmd@linaro.org>
References: <20241220161551.89317-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

CONFIG_DEVICES is not generated on user emulation, so
do not define it.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20241218151256.68625-1-philmd@linaro.org>
---
 meson.build | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/meson.build b/meson.build
index 6149b50db28..f4109cd3cae 100644
--- a/meson.build
+++ b/meson.build
@@ -4110,7 +4110,7 @@ foreach target : target_dirs
   arch_deps = []
   c_args = ['-DCOMPILING_PER_TARGET',
             '-DCONFIG_TARGET="@0@-config-target.h"'.format(target),
-            '-DCONFIG_DEVICES="@0@-config-devices.h"'.format(target)]
+  ]
   link_args = emulator_link_args
 
   target_inc = [include_directories('target' / config_target['TARGET_BASE_ARCH'])]
@@ -4130,6 +4130,7 @@ foreach target : target_dirs
       arch_deps += hw.dependencies()
     endif
 
+    c_args += ['-DCONFIG_DEVICES="@0@-config-devices.h"'.format(target)]
     arch_srcs += config_devices_h[target]
     link_args += ['@block.syms', '@qemu.syms']
   else
-- 
2.47.1


