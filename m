Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F146C02198
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2025 21:36:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tiKML-00033B-UN; Wed, 12 Feb 2025 16:33:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tiKMC-0002yl-DS
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 16:33:20 -0500
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tiKMA-0000Ux-FX
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 16:33:20 -0500
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-38dcf8009f0so63973f8f.2
 for <qemu-devel@nongnu.org>; Wed, 12 Feb 2025 13:33:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739395996; x=1740000796; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=en/a7ffbK9haoJlAFPh+g3jAc0kZoPBDHYq0Zc8C/ng=;
 b=VRkD8h1q7eEuiCXyHHs7IAeeCPUhEPZbNnRuP7n/rMretRDUTaqyTxQwAfDxnWXzZr
 5adXrHjixOUxO/Oc6eF533AEx/BY8v0sw1BZcWXJx8U0Zm1biCyj6+YItA2zBXchCF22
 ukvzmBy0WPur5o3pgiZwzUuQoQRhFjY2AMd4GgJDCp5lKZuNUT7wlijxoD/ryxlNjVy7
 Whbt7Mq2ULGl9TI6E3a+FnbQWC15Hy0SAN7tAu1Fd2UlgYix4v7JqBDM+2orMkNgnH6i
 KhpLDw6No6MzmUFeX0p2VsAa9CEY+URd+GnKbxpAXVe46G5ryu0+GHVVD3vO45uOqm6a
 rVEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739395996; x=1740000796;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=en/a7ffbK9haoJlAFPh+g3jAc0kZoPBDHYq0Zc8C/ng=;
 b=RnvIApu4SHzfMlWBscP0Hs6x6jnhDgoTOb/KXfDas8B5T9JnxJhfhCjn1dFhbBg3LA
 Q1/nbn2Jh87XsGmDj7fh6toAV6DDsrdoDdLn3iBjEWV2ieGWM0MH1DLlU9XA291weXNz
 1mwmDP3pE80B6w4FLWz1Nbgt4erySUo28XdXb+6ggWEK7Smzy2O/AJ008F1VCCxTsrot
 3A7o5LLMbOlCMvy44cNsap9jDBGKDWCh0hjAmrpDO/UbZQ5mnKF4d/A2ETgwY3w2+QSf
 xs/xCuLOUyee/Jp6gLyy1YqPiuausTZVRBEzWcEGmqdKeJtGJbLbL8Ow46juFfwUc0aO
 LmWA==
X-Gm-Message-State: AOJu0YzheKDQFx7uwFwv4q5/wX8dgSdwCApInD3P39smyjsKq6Ba6XUX
 K72ub5/31iC+twyouH/t1kDFv5+DGnWOyuuOeedgbeUmgqvDp2RnnSpc7fZdZuOxXj2c2MwPrKZ
 6Vks=
X-Gm-Gg: ASbGncsa5Jqx87Iup8z59G/4kay0nAOvr3MnjAmRhBtgGQHzsmqUl4uJHJeel4Qs9Jq
 4+rQhRXTlo+e/wcvvNdpwm1BdBm1yWra6UwNs0g9oX82LZXVpvF4Uwy+HaHQTa9BC28xBVdeTuG
 8OJZISRJPZrcFiuIQrEwNWji53iQFo9SLltbqlnna9hQGjwYlP7JhwctdOEWZFJuGnWq3l0Sl0H
 kYBBYMkGBU+wyb1YLIAMVGoKjoTLTjRn2f6hHJD6jgFyQpsJTiI7+BdZhXJcctV9ahjkqGp/h8s
 Oc+qNHb1+7oMk1T5XD+EFOU4mPJQmuprGO+LXk9sbg2my5C18c86OkWAFCiKIGc/8g==
X-Google-Smtp-Source: AGHT+IEUgDyZVMNgIkJB1U8Q8yH1O95KOFIEvIEZhMu/qienxCs/xbRlETJVuhWulc4V1EwHU+NGQw==
X-Received: by 2002:a05:6000:2ab:b0:38d:d39a:d13c with SMTP id
 ffacd0b85a97d-38dea256ee7mr4345866f8f.2.1739395996646; 
 Wed, 12 Feb 2025 13:33:16 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38f258f5fb6sm40695f8f.44.2025.02.12.13.33.15
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 12 Feb 2025 13:33:16 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH v3 05/19] target/xtensa: Finalize config in
 xtensa_register_core()
Date: Wed, 12 Feb 2025 22:32:35 +0100
Message-ID: <20250212213249.45574-6-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250212213249.45574-1-philmd@linaro.org>
References: <20250212213249.45574-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
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

Make XtensaConfigList::config not const. Only modify
XtensaConfig within xtensa_register_core(), when the
class is registered, not when it is initialized.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Acked-by: Max Filippov <jcmvbkbc@gmail.com>
---
 target/xtensa/cpu.h    | 2 +-
 target/xtensa/helper.c | 5 +++--
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/target/xtensa/cpu.h b/target/xtensa/cpu.h
index 0e6302c5bd3..8d70bfc0cd4 100644
--- a/target/xtensa/cpu.h
+++ b/target/xtensa/cpu.h
@@ -490,7 +490,7 @@ typedef struct XtensaConfig {
 } XtensaConfig;
 
 typedef struct XtensaConfigList {
-    const XtensaConfig *config;
+    XtensaConfig *config;
     struct XtensaConfigList *next;
 } XtensaConfigList;
 
diff --git a/target/xtensa/helper.c b/target/xtensa/helper.c
index 2978c471c1f..f64699b116d 100644
--- a/target/xtensa/helper.c
+++ b/target/xtensa/helper.c
@@ -173,9 +173,8 @@ static void xtensa_core_class_init(ObjectClass *oc, void *data)
 {
     CPUClass *cc = CPU_CLASS(oc);
     XtensaCPUClass *xcc = XTENSA_CPU_CLASS(oc);
-    XtensaConfig *config = data;
+    const XtensaConfig *config = data;
 
-    xtensa_finalize_config(config);
     xcc->config = config;
 
     /*
@@ -195,6 +194,8 @@ void xtensa_register_core(XtensaConfigList *node)
         .class_data = (void *)node->config,
     };
 
+    xtensa_finalize_config(node->config);
+
     node->next = xtensa_cores;
     xtensa_cores = node;
     type.name = g_strdup_printf(XTENSA_CPU_TYPE_NAME("%s"), node->config->name);
-- 
2.47.1


