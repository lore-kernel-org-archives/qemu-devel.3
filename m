Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E3EFC4345F
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2024 15:37:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2uxj-0002jw-7f; Fri, 03 May 2024 11:36:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s2uxf-0002dh-EC
 for qemu-devel@nongnu.org; Fri, 03 May 2024 11:36:36 -0400
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s2uxY-0002iW-5v
 for qemu-devel@nongnu.org; Fri, 03 May 2024 11:36:34 -0400
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-a5544fd07easo1415802966b.0
 for <qemu-devel@nongnu.org>; Fri, 03 May 2024 08:36:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714750586; x=1715355386; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wFd49aZe/euzrWDlHUHUg155F0vz6PnPtpjDws04jXo=;
 b=lS/lf9U/3LarHv/N0KnfdsehswvsngOToa+iTJRnVXHUyr6AiYvVbPw+yBsgiSE9L3
 45H4bk9PUfnQJR70IPvA3RSp6BhUEF3mnE9r1uZBlFmSm6F9vA583So8vpvilBYC3gbI
 Z7o0thmPU/kmle5RI0JDDTQr0JISJplgoP5S8BfgWsdZ/dAT4eAUM3YaEPYQbBhKn6Bf
 OidCPn36x9Af7wTxDGAAISm4dvitWi/UEoAyxJmTNX9+8ZOIacavfrQBf8VtUzlS2lPN
 bh1KdUMZboD7MDh2Fr8j+QWUgi0zPdsROEXPTsTzJ0xsVarpcZE0wAr96kXESt+i5QXP
 uWfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714750586; x=1715355386;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wFd49aZe/euzrWDlHUHUg155F0vz6PnPtpjDws04jXo=;
 b=L7Z88KN/2UQ9GtPEpX/m3soy/rm0ARFVPHSzCKfCFM5IfVFc+kBa3WaWEx5u/kGPSn
 8RHduo0TGk78+4qw5tZF6/ecdW0Fbn1FFyO4tXuI9Neo7BvqiFv0uTEk4QCjF2UGeWud
 UPFjNelogcIrKNgkb/oiQoOZn5+OFl6fi4aMdlOMMfnUuddnpd+p+dLNPDM6o+2ahHrU
 dwBfdi9kirLxJ/6R+YbEL9uLt6LriCjDuWqrYUI4nFHzHmLyKW19WBp9UjppOIqRTW9z
 zvoCrzDNynRbsrRzaD5VuqQcJSMPd2mMXIRuxTtX5+VHTNGb8DZj0r7EJm8ncrtvMAFZ
 k1Qg==
X-Gm-Message-State: AOJu0YyV1S0ZESvVKCuERdAFgV+W3QKPBlnX1XV7Z3Ox5eGSozXxb51F
 FAl5xLPjQjptS6e+E+SEkIktiqFrcaBU/wCgnWBnHYuyhsc7/6sL8dJe8tM2VOl3A0PBVeqHuCt
 7
X-Google-Smtp-Source: AGHT+IFd7swF3hnq2QoaMpUB/rIG3XWKMkN8LxBYjviRpntebRofr4lhqIDIo5AWY08jOPNgO9OBvA==
X-Received: by 2002:a17:906:6889:b0:a59:86a7:2785 with SMTP id
 n9-20020a170906688900b00a5986a72785mr1907271ejr.28.1714750586240; 
 Fri, 03 May 2024 08:36:26 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.179.187])
 by smtp.gmail.com with ESMTPSA id
 c17-20020a1709060fd100b00a526a992d82sm1810177ejk.4.2024.05.03.08.36.25
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 03 May 2024 08:36:25 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Volker=20R=C3=BCmelin?= <vr_qemu@t-online.de>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 02/14] accel/whpx: Fix NULL dereference in whpx_init_vcpu()
Date: Fri,  3 May 2024 17:36:01 +0200
Message-ID: <20240503153613.38709-3-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240503153613.38709-1-philmd@linaro.org>
References: <20240503153613.38709-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::630;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x630.google.com
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

When mechanically moving the @dirty field to AccelCPUState
in commit 9ad49538c7, we neglected cpu->accel is still NULL
when we want to dereference it.

Fixes: 9ad49538c7 ("accel/whpx: Use accel-specific per-vcpu @dirty field")
Reported-by: Volker Rümelin <vr_qemu@t-online.de>
Suggested-by: Volker Rümelin <vr_qemu@t-online.de>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20240429091918.27429-2-philmd@linaro.org>
---
 target/i386/whpx/whpx-all.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
index b08e644517..a6674a826d 100644
--- a/target/i386/whpx/whpx-all.c
+++ b/target/i386/whpx/whpx-all.c
@@ -2236,7 +2236,7 @@ int whpx_init_vcpu(CPUState *cpu)
     }
 
     vcpu->interruptable = true;
-    cpu->accel->dirty = true;
+    vcpu->dirty = true;
     cpu->accel = vcpu;
     max_vcpu_index = max(max_vcpu_index, cpu->cpu_index);
     qemu_add_vm_change_state_handler(whpx_cpu_update_state, env);
-- 
2.41.0


