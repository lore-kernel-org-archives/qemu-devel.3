Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EEC5C3ABC3
	for <qemu-devel@archiver.kernel.org>; Mon, 12 May 2025 08:43:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEOkE-0002LT-LB; Mon, 12 May 2025 04:42:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uEOj4-00081U-BK
 for qemu-devel@nongnu.org; Mon, 12 May 2025 04:41:32 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uEOiz-0001my-61
 for qemu-devel@nongnu.org; Mon, 12 May 2025 04:41:27 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-441ab63a415so41134715e9.3
 for <qemu-devel@nongnu.org>; Mon, 12 May 2025 01:41:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747039281; x=1747644081; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CG3XKTeWK0piQR2+smzX+3iwbFcRaTIDsL5MWdVVSjk=;
 b=NgN58Vp0KK14rmsg8K/JzayyitXi+jDgEUKWK37Hl5s3U10Q1B3OvSCgQzYLHKs29W
 WY3A97ktkH+Q1EFn63mPgnfGBLxnMSNvp84Tr2CZyQEiLFkpRaJV/xQ0YAvZl3iYqH+Z
 ws6fYilPcHg0DedR6zchNwJFS4dIGNmsim0GuhR0wlMlm6CZQpRcfI7aaZgDK8VNkik0
 Fo0+Dpbyp8j6YaijDsHQYatqNlal2B2viYpLRO99KgsgdzJEpKt1Y/mJsf5dO6km/OBV
 ZiyOzWKfFqddsWCg0N2UVfAcjcpP+kMIHwVkB4S0QaIBLeMchT1PN4qnoeHl2WLcXm0i
 Ygxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747039281; x=1747644081;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CG3XKTeWK0piQR2+smzX+3iwbFcRaTIDsL5MWdVVSjk=;
 b=ZTpmEkCBhETFm7XcQJWCDP4bwCcJdprohk9j6utDlKa0Tv99j9mcXuM85XTQ5goDem
 WzuL91necxxoeT2WQltTY3mzX2AJOrrXTD2Zv3R3uWqkIRulr5qfswDvb8nrt6FERT3u
 JFfoBSPfcGEamAaCGdCJ22ZZ8FNAcCxjJI9yh8Jmkm4ZZkwzIqyhlkbe1uuiUB4NNaAE
 ewhUtmC+DFauxKfRtGvVYd9WYOgsSaJhAC9Ajr9lzDZAj3QU+QoOZGBWc8oZO0RgdAep
 J5O1MZ5g6vGHpplDEeRF/0r7OZw89AtkwhBzIIDzGDekqBEwGd1elmn4d7braPeNSHh4
 tBkQ==
X-Gm-Message-State: AOJu0YyrnapRF4LNUg+Sj3cwsiZj85RSXXldSDV/huBGf3lMMJY4Yycn
 +Dfxc6UQF0/6HDvUbSPlbBCBjqbRvz70T7t5afiWSJMOaSZZyr+lNYsRRtDV28KdcyWRISOYcVC
 7SXIwAw==
X-Gm-Gg: ASbGncufjmw0bQAFgS4Tt/a82rk1qBUOemd03ayWF+b4RXUEPTQrYImMSHwK/3jmmPa
 iyrfskwkvSiETM3srgKm1zpUzpl9YUrf+a9bsa2LmYEMUW9DLiNZ5i5wPZrkIL7c8Jcf8rdtnNL
 fhs0bRpmLtgLvFwOq85/fCczu3aIhkiVNvdfNkwqgQ/C8oTDhTKHtsOi2fuJmevJz611xwlFV3+
 fcqq6PHlWT1pylw6cna3hbvU5Cfu1CaNx+qvOnbbQTbcuLjb7QLUWOyj+0xHyLfs3CPlez5uuzl
 3GLeTmyFGh+1Y26b2Nm1Cwi8NVqhzKnktpLtgo+uj04x9OWoeEYlThnSLWrhNwLCCYp+v6YHe6w
 NHSZpz9E4B8rkfr479iLJ1MM=
X-Google-Smtp-Source: AGHT+IE9XmsM/v4yWMXYFciqcglmvn2szksPoXVqFdfTER40y3qoX1HDq+UNbSmntNIeLW3HYfeyqA==
X-Received: by 2002:a05:600c:46c3:b0:43c:fc04:6d35 with SMTP id
 5b1f17b1804b1-442d6d0a9f6mr98072835e9.4.1747039281017; 
 Mon, 12 May 2025 01:41:21 -0700 (PDT)
Received: from localhost.localdomain (129.163.185.81.rev.sfr.net.
 [81.185.163.129]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-442cd34bd84sm159345165e9.22.2025.05.12.01.41.17
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 12 May 2025 01:41:20 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Yanan Wang <wangyanan55@huawei.com>, Kevin Wolf <kwolf@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, qemu-block@nongnu.org,
 Fabiano Rosas <farosas@suse.de>, Fam Zheng <fam@euphon.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jason Wang <jasowang@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>, Hanna Reitz <hreitz@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, John Snow <jsnow@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>
Subject: [PATCH v4 10/19] hw/i386/x86: Remove X86MachineClass::save_tsc_khz
 field
Date: Mon, 12 May 2025 10:39:39 +0200
Message-ID: <20250512083948.39294-11-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250512083948.39294-1-philmd@linaro.org>
References: <20250512083948.39294-1-philmd@linaro.org>
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

The X86MachineClass::save_tsc_khz boolean was only used
by the pc-q35-2.5 and pc-i440fx-2.5 machines, which got
removed. Remove it and simplify tsc_khz_needed().

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
---
 include/hw/i386/x86.h | 5 -----
 hw/i386/x86.c         | 1 -
 target/i386/machine.c | 5 ++---
 3 files changed, 2 insertions(+), 9 deletions(-)

diff --git a/include/hw/i386/x86.h b/include/hw/i386/x86.h
index 258b1343a16..fc460b82f82 100644
--- a/include/hw/i386/x86.h
+++ b/include/hw/i386/x86.h
@@ -27,13 +27,8 @@
 #include "qom/object.h"
 
 struct X86MachineClass {
-    /*< private >*/
     MachineClass parent;
 
-    /*< public >*/
-
-    /* TSC rate migration: */
-    bool save_tsc_khz;
     /* use DMA capable linuxboot option rom */
     bool fwcfg_dma_enabled;
     /* CPU and apic information: */
diff --git a/hw/i386/x86.c b/hw/i386/x86.c
index e2d04092992..f80533df1c5 100644
--- a/hw/i386/x86.c
+++ b/hw/i386/x86.c
@@ -382,7 +382,6 @@ static void x86_machine_class_init(ObjectClass *oc, const void *data)
     mc->get_default_cpu_node_id = x86_get_default_cpu_node_id;
     mc->possible_cpu_arch_ids = x86_possible_cpu_arch_ids;
     mc->kvm_type = x86_kvm_type;
-    x86mc->save_tsc_khz = true;
     x86mc->fwcfg_dma_enabled = true;
     nc->nmi_monitor_handler = x86_nmi;
 
diff --git a/target/i386/machine.c b/target/i386/machine.c
index 6cb561c6322..dd2dac1d443 100644
--- a/target/i386/machine.c
+++ b/target/i386/machine.c
@@ -1060,9 +1060,8 @@ static bool tsc_khz_needed(void *opaque)
 {
     X86CPU *cpu = opaque;
     CPUX86State *env = &cpu->env;
-    MachineClass *mc = MACHINE_GET_CLASS(qdev_get_machine());
-    X86MachineClass *x86mc = X86_MACHINE_CLASS(mc);
-    return env->tsc_khz && x86mc->save_tsc_khz;
+
+    return env->tsc_khz;
 }
 
 static const VMStateDescription vmstate_tsc_khz = {
-- 
2.47.1


