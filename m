Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1615AC3ABAB
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Apr 2025 14:09:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9leP-0002yD-Oy; Tue, 29 Apr 2025 10:09:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u9leO-0002wL-1Y
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 10:09:32 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u9leM-0006RA-G3
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 10:09:31 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4394a823036so59785255e9.0
 for <qemu-devel@nongnu.org>; Tue, 29 Apr 2025 07:09:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745935768; x=1746540568; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eXL4/W2KCy0v23MfOskz73x1LQjRcBzqdAtJsMYaNnI=;
 b=dFJvsBeddabeDJNS/UfMG0oWdNTae/dStcosvLYI0MoXwB9+Vd3YOjxMJwqAWLDW24
 UOg4tAUYPSU/Bhb9TKlxsSXBFF4M5W5Af71Vqa5hwhTFH3A1cx1DXInMdeaK5G0HAzd7
 IadIrgS1PIwIa7T5DXdv7FZqT6eT6IboWY5T/rjCgL7HaXyS83Z/kGf4Oxry+dQbXmns
 7PlWNd5OTlMizhesNY1t4NIzC445W6mAWqHslZVLCPRg1NkJC/32uqQvY1H/XA8G0HQa
 mAsTSg8tPAGhOlKzdtmrFhEsFB8+i+UFH1t6fQ0SY2A13pS2wOul6QD16AZzmb/s6tyJ
 +P7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745935768; x=1746540568;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eXL4/W2KCy0v23MfOskz73x1LQjRcBzqdAtJsMYaNnI=;
 b=u4OxjKSV4aBAiteeDdlbXy4aWW55W+1hSfKr8VW1XkH/uNLi0jVbGiM3+sPb96RMbj
 CQziqU4rSnb13wKRhvBrTIs1m+pSKKr2fP+nC2jJQRd4r1wXfkK2s7Fje5aJm/uNaPE8
 0K5bTyi66aUSs4UAJ9YkehRujHDxtkaOtopeSvX6nidK5ia+YLK4jQw7J6fgzvyk+LxW
 ZytUXoQMYSmDNwpZOYoaXWCHaBipLVfkFNb6y0eLEj3T0IBlkWRvhDTIN1yuXDbVTYjg
 wQWPlzKj3CXOvUq1eoawanjbcmCIWsNAlvRKa2W4NiskFzwUCEb/w2Uoe3ULCnvxC6wY
 PoSw==
X-Gm-Message-State: AOJu0YyIPQr3E+rQcE/5z4ixGWrX73wUMbq15y1cpHhSkWM7c6XcEjRg
 rzUzGG8Zw0XQFcO2lslN4ipUhcpKzP9hnWZ74pNHmzvYhebpZJYyJ4khDRWCzlbFlH11aMWxoLi
 h
X-Gm-Gg: ASbGncvnfAjCjV0DQI4wV/oVIqKhxlKUUUrPFbOyr/85h+GoNsYCH4fTpXke2l9UZVi
 IWR6BOtv1Hi3JRtchnDjtpcAy+sk+sWZhaGYidYjvByX+btESB+sma/fBUZC2YEEpWmvk7rPpj3
 bV1S9adHXjHu6rIsGYKOyxnW6siX1EQewb1q4YEZBuwrFhvnbWGBGy9CKjgT2VCaTKmAWysIyVE
 Uwmd0+i712k9R39aqLR8TlmZ0XFmriebHMcRj2BpKhx6UQ+0TfbiE/O/0FrWZdm3z5/F/PaVfWD
 Mr83wmFZZH+7siiVWgBQHx61/HpAvj1UIWS9UiODDA0gtwlSOlopYTJX9cgnu+WJJx4ZH5MIKzn
 YIgK/867mCcJVb5dSV+rs
X-Google-Smtp-Source: AGHT+IEdRrfAgd3XftcbCdMHLFCzzJRLUiQAR8tVcSfN/HNySPywkwWJ4aBd32Zn1FLecdT6cL/FYw==
X-Received: by 2002:a05:600c:1c24:b0:440:6a37:be09 with SMTP id
 5b1f17b1804b1-441ad3d6bfbmr28873985e9.16.1745935768081; 
 Tue, 29 Apr 2025 07:09:28 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4409d2ac26dsm191313335e9.21.2025.04.29.07.09.26
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 29 Apr 2025 07:09:27 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Hanna Reitz <hreitz@redhat.com>, Fam Zheng <fam@euphon.net>,
 Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 qemu-block@nongnu.org, John Snow <jsnow@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Eduardo Habkost <eduardo@habkost.net>, Jason Wang <jasowang@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Yanan Wang <wangyanan55@huawei.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v2 12/19] hw/core/machine: Remove hw_compat_2_5[] array
Date: Tue, 29 Apr 2025 16:08:18 +0200
Message-ID: <20250429140825.25964-13-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250429140825.25964-1-philmd@linaro.org>
References: <20250429140825.25964-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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
---
 include/hw/boards.h | 3 ---
 hw/core/machine.c   | 9 ---------
 2 files changed, 12 deletions(-)

diff --git a/include/hw/boards.h b/include/hw/boards.h
index 5dc5e3b547d..5f1a0fb7e28 100644
--- a/include/hw/boards.h
+++ b/include/hw/boards.h
@@ -844,7 +844,4 @@ extern const size_t hw_compat_2_7_len;
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


