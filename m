Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FB00E77180
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2024 20:38:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tKkVg-0006Wx-F2; Mon, 09 Dec 2024 15:37:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1tKkVG-0006Jh-W7
 for qemu-devel@nongnu.org; Mon, 09 Dec 2024 15:37:24 -0500
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1tKkVD-0003GQ-R8
 for qemu-devel@nongnu.org; Mon, 09 Dec 2024 15:37:13 -0500
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-aa69077b93fso166530166b.0
 for <qemu-devel@nongnu.org>; Mon, 09 Dec 2024 12:37:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=philjordan-eu.20230601.gappssmtp.com; s=20230601; t=1733776630; x=1734381430;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IE9WDOVCTTfWbFzrWk3+NYB4k57W0Vt5GpleV+hnMAc=;
 b=R0ihLEGWWAL5uHJvgsajQpWguyLaiG7k/vnXDE1D66vUfYtYmX2WhfqEWwBuwtdZN+
 zYi1+M34YX6/FFVCLWSmEmLdaNfIHyiwRRjtfXeojFx3PZ3yQX2h5ihvTTUHIpw1Ham9
 1bWtivv4fbXOE2lqugSSpOwbzO6ZaTcDZterXSm9RhaqWSPIVNHAqq7FGKJOz85F4GM3
 H66ZBf7RLI75jrMOwGHki2oEwRvcS0K+20WQJ4quCxp+qigrAbQ4chQKuLI5cTTFS1+D
 ZzK4PiuatXqwg0NNOKdj3HZpWn8xi9PL2Kjb2eAxWRq1RodnWrligqJk/thePaYYMLXj
 YR3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733776630; x=1734381430;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IE9WDOVCTTfWbFzrWk3+NYB4k57W0Vt5GpleV+hnMAc=;
 b=awMVC/lNhELI5yhw0lm8kkTtiiSiV392jis3+wdsRym9Mxa31kruxlYo/qynYAL3yx
 yXYinOsCkl+5L2T4ffTgewlc5/tmkC3UdJCl4ZCxE6Heqdork/G1VoW8EmTRvkT3JWgf
 vgtSEdcUNkZw+xestwBd23NdTkPyIZKDp7EGytW8euryjua8+ln2z5nv8FNih1NhbDaE
 DTrBnCkCbeC0a7MvVjMkSwLe4TtU9NZKw//wyhsnQYv1QlwdtAMQ2cF0XIM6hMsOoIpD
 CM51FCCtCQo4REXcC5DStNNt5av0wUvWCevs4bAtvFeeM4hm4RTquU1Q63hT0rzKMRz+
 qLnA==
X-Gm-Message-State: AOJu0YwWMyHHBZexDbmWFT6gNUZXvyxfK8aam2aRs4adXkw8DNnD+d7g
 gucgUw2fXRZsNsMT3Bst4+/T1U80PoBlw8nKHpOWQC5xK3Bwyq0XS+s/zOGWstqaCBU9bLMj6Wr
 4eQ==
X-Gm-Gg: ASbGncv5q1dqU4jh3UmlYKDpodIEoZFmV9A+Hc9L6jQAUSEaBNW/yFz6dT2lv+ukY5Z
 BtsTHYVxjshKQVdRqxwvb5js3qVbWiB0NiTnFihJjaLVRSAKn7Gs7UDOM2XtiBRLGSW1lIjKQXo
 0wA+s+EI81KymkXED9P5wpn6SJdifPXdKPirx5h8fEBzjDnGvuJjYLX9HdHVlSuFzL+eDJwOFT6
 Wy/5B6H8gnH5JRJ8spo6OLTkRpg7d01oWer/S80WZhORuqvYbIKpE4yrfoa2e1kQn1E+8bYsjs4
 gottLzOdf6hlPgrPy6r/r8OnsmveTQ==
X-Google-Smtp-Source: AGHT+IGswOYxVOkMA+XvzQnaKOD/7lVr+xcvNSKvz9rdbJJ/otbRBczcyzE8RbzHYCp8ocDjO+jPEg==
X-Received: by 2002:a17:906:4ca:b0:aa6:2d86:bd2c with SMTP id
 a640c23a62f3a-aa63a0ed36cmr1178144466b.21.1733776630516; 
 Mon, 09 Dec 2024 12:37:10 -0800 (PST)
Received: from localhost.localdomain (h082218084190.host.wavenet.at.
 [82.218.84.190]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aa692e4e9d5sm141783566b.129.2024.12.09.12.37.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Dec 2024 12:37:10 -0800 (PST)
From: phil@philjordan.eu
To: qemu-devel@nongnu.org
Cc: Cameron Esfahani <dirty@apple.com>, Roman Bolshakov <rbolshakov@ddn.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Alexander Graf <agraf@csgraf.de>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-arm@nongnu.org, Phil Dennis-Jordan <phil@philjordan.eu>
Subject: [PATCH 11/11] hw/intc/apic: Raise exception when setting reserved
 APICBASE bits
Date: Mon,  9 Dec 2024 21:36:29 +0100
Message-Id: <20241209203629.74436-12-phil@philjordan.eu>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20241209203629.74436-1-phil@philjordan.eu>
References: <20241209203629.74436-1-phil@philjordan.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: neutral client-ip=2a00:1450:4864:20::629;
 envelope-from=phil@philjordan.eu; helo=mail-ej1-x629.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NEUTRAL=0.779 autolearn=no autolearn_force=no
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

From: Phil Dennis-Jordan <phil@philjordan.eu>

Signed-off-by: Phil Dennis-Jordan <phil@philjordan.eu>
---
 hw/intc/apic.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/hw/intc/apic.c b/hw/intc/apic.c
index d72cbb2a8f..83e626a45e 100644
--- a/hw/intc/apic.c
+++ b/hw/intc/apic.c
@@ -309,6 +309,11 @@ bool is_x2apic_mode(DeviceState *dev)
 
 static int apic_set_base_check(APICCommonState *s, uint64_t val)
 {
+    /* Refuse to set reserved bits */
+    if (val & MSR_IA32_APICBASE_RESERVED) {
+        return -1;
+    }
+
     /* Enable x2apic when x2apic is not supported by CPU */
     if (!cpu_has_x2apic_feature(&s->cpu->env) &&
         val & MSR_IA32_APICBASE_EXTD) {
-- 
2.39.3 (Apple Git-146)


