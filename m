Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62281C3ABBC
	for <qemu-devel@archiver.kernel.org>; Mon, 12 May 2025 08:44:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEOjg-0000iL-UQ; Mon, 12 May 2025 04:42:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uEOjH-0008E0-Mw
 for qemu-devel@nongnu.org; Mon, 12 May 2025 04:41:48 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uEOjF-0001oL-7C
 for qemu-devel@nongnu.org; Mon, 12 May 2025 04:41:43 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-43cf628cb14so34988025e9.1
 for <qemu-devel@nongnu.org>; Mon, 12 May 2025 01:41:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747039299; x=1747644099; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tHY1YiLZvCACpZsrrksXO5DebeenPdJJpeqj3sZN6lI=;
 b=fmIkIN0x8itADxVUSEwboYwyqAqNsXJ+YoqhlioiXQsNWEvDwg02RWFyTg4hOPnVnB
 oiipdGlEonhipwRM59ZP0qo4UHV8YUOaNI4yLRVn71ISLjsc+A2ANpgHyuZ+J2jROEhy
 rb7v0Ffz7poWhEtPpQ9+WqI8ednt6T2L2hHQgVEMDWOptDIlpECNHHnzfTX21+9wvPnb
 LotySQNzMLR/scJy7IYMVfZO/SGr6JpAE3iiDojPgWvNmPmjw3JHRfqwoZqzcSvpna3S
 HUxoGMJtQhQPllcNes2oO/j4E+lPs5J4p+HNSY+cOK2VDhSL5Tt2rBxSzh0HLRJVQz+4
 F46A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747039299; x=1747644099;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tHY1YiLZvCACpZsrrksXO5DebeenPdJJpeqj3sZN6lI=;
 b=R/g13TNLwmsZnaDfAInLKvK6wbOpj7K0G/7aYY/I+dRuFk8pel8C63NHk92gJk/+gj
 uddmGmJK03xdkoXBdULwuEaWzvNwzjRUB484RSNVrm7Jxw4mBInbS4xH+aR+FqkP4I/g
 TM0fC6JcNkcLeSkNVbLrJC57FNOQv3rQtQiZ36+k49LeBjTkzrKSRz6etMu2/io+0HIh
 8j+RfT0zYJdmtV81+e3qpKIFB1iOTHEC5e/nLPUSGjyutZWWS0mlH/K6f2LZ7UNNVl35
 /xXaFIMUge6wTVbQmm3BA9Hf7WYlou1Lzj3y+S5LtO1qLaBi+jNzHvdxXQT5LIB4XY6b
 4SQg==
X-Gm-Message-State: AOJu0Yw4jOMynBZF1lTWa4/cUZ4kW6DkHLQNcOORN+Jdg6tNswxxPn+x
 MHGsmZ63ASRvivRzjTwENER5uEFYGRygWRscmFu23jYLY35S8f7ML9tkWFcQ2KzlNcWVG84UbFh
 4yfUqCg==
X-Gm-Gg: ASbGnctrvqXvbpKFJ+h1qSdb+rqt48P0e2EM3xKeFukzlU8vnBDf2q4AaGZ8YKvy1gX
 dE5kfn8oOH/6ijUUYNNC3g5R2+8Q4LlEHmt9n8b67Wo7eE0AiK5mqKHGh3p36NHibmOWdA40Z7p
 LZ5gqn9460jlOEJgyXYabvVjUHRXCQmqSe3U4aB5bMD3DPgKVM33FeDIHxU8hUhHH91JlSfRwot
 OEgS8LQUmW8z7Nq8NT4DDI360nK8CBkKn/1vo1mg0Tk6UvPP9/B9ZjaD85zbJcPnkJuvRTsQOyG
 kwqFxGRYfbl8iYPdeAGj/ginx0TcJKK+1YHoy39J5gz7VF+feGZ9OSRqVVDE/VJGyfgyRO0YP7S
 jL16NloDmyQV0PZhfOm+sezc=
X-Google-Smtp-Source: AGHT+IE0jExCfb3boq1efmnwEz2W8+JJBmiYHfhl8wF/xmr9KtNu08M5a5+idJI3p/xy8HsCYt4/7g==
X-Received: by 2002:a05:600c:c0c3:10b0:439:8878:5029 with SMTP id
 5b1f17b1804b1-442d6d71e58mr66936525e9.2.1747039298621; 
 Mon, 12 May 2025 01:41:38 -0700 (PDT)
Received: from localhost.localdomain (129.163.185.81.rev.sfr.net.
 [81.185.163.129]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-442e9c9a193sm588375e9.21.2025.05.12.01.41.35
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 12 May 2025 01:41:37 -0700 (PDT)
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
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v4 12/19] hw/core/machine: Remove hw_compat_2_5[] array
Date: Mon, 12 May 2025 10:39:41 +0200
Message-ID: <20250512083948.39294-13-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250512083948.39294-1-philmd@linaro.org>
References: <20250512083948.39294-1-philmd@linaro.org>
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

The hw_compat_2_5[] array was only used by the pc-q35-2.5 and
pc-i440fx-2.5 machines, which got removed. Remove it.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
---
 include/hw/boards.h | 3 ---
 hw/core/machine.c   | 9 ---------
 2 files changed, 12 deletions(-)

diff --git a/include/hw/boards.h b/include/hw/boards.h
index ab900dacabc..f424b2b5058 100644
--- a/include/hw/boards.h
+++ b/include/hw/boards.h
@@ -862,7 +862,4 @@ extern const size_t hw_compat_2_7_len;
 extern GlobalProperty hw_compat_2_6[];
 extern const size_t hw_compat_2_6_len;
 
-extern GlobalProperty hw_compat_2_5[];
-extern const size_t hw_compat_2_5_len;
-
 #endif
diff --git a/hw/core/machine.c b/hw/core/machine.c
index d66b02b564c..e7001bf92cd 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -283,15 +283,6 @@ GlobalProperty hw_compat_2_6[] = {
 };
 const size_t hw_compat_2_6_len = G_N_ELEMENTS(hw_compat_2_6);
 
-GlobalProperty hw_compat_2_5[] = {
-    { "isa-fdc", "fallback", "144" },
-    { "pvscsi", "x-old-pci-configuration", "on" },
-    { "pvscsi", "x-disable-pcie", "on" },
-    { "vmxnet3", "x-old-msi-offsets", "on" },
-    { "vmxnet3", "x-disable-pcie", "on" },
-};
-const size_t hw_compat_2_5_len = G_N_ELEMENTS(hw_compat_2_5);
-
 MachineState *current_machine;
 
 static char *machine_get_kernel(Object *obj, Error **errp)
-- 
2.47.1


