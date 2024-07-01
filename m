Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 231DAC2BD09
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2024 13:32:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOH7w-0008Ih-Ko; Mon, 01 Jul 2024 09:31:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1sOH7n-0008HR-TQ
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 09:31:20 -0400
Received: from mail-pg1-x532.google.com ([2607:f8b0:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1sOH7l-0005Na-Ke
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 09:31:19 -0400
Received: by mail-pg1-x532.google.com with SMTP id
 41be03b00d2f7-713fa1aea36so965400a12.1
 for <qemu-devel@nongnu.org>; Mon, 01 Jul 2024 06:31:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1719840675; x=1720445475; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6TUzEiTYDYxtoBN8a40dqDmyHQkViHYBXJaMnTel9nE=;
 b=WtQ5EsllbhugFLS8ZniB2sQG3owiA3gnZkk46tXBHz17P3OBVQCURbUGeAKzkQSKp5
 QTONWFzv2sayT+o3z9x878vkfF66j/1do8T+Rv/eMEpigCM+P22awpvXM/WGgNfQpJHP
 GCmpIgRafKfyFHN1WSHX1hByzOsmcB/L0VVlICaVSXDaR14Y3mAhoAkCDDk7ZQ5bbNix
 KYZot3aO5BqvrkEu/K2jZ5IQNcFc/yX/u0wz9avRIupzJfYUt/YLTLnXCCIcbKglKO4i
 lgnHndrbrDoMdGGuOrDB+CGvr1NFkE/u0FWRXhxmVODUVlMGXC/OUjOnviitG2ZESWTT
 OYZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719840675; x=1720445475;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6TUzEiTYDYxtoBN8a40dqDmyHQkViHYBXJaMnTel9nE=;
 b=UzhDEj5l4rgo6JiIpabSk9rqklBOShv2UurKmXFh9NzQXRMB14pCkkdFjbluxAtHS5
 x8PjfvXU4txXP4cozdjaaYfsJ95hm9RpywIDLUktN7Mb9MYCp1YB82OgPKBXx/KoqSaQ
 oE64KG9KC7I5FG2m2GocVh2W8du8JxZI6Tm2XvNaH+68cG/XorVlENoAPHrDYPJVmn9L
 e+AW+DpX0a6yPH13MCrF9CZi8XQixiV8GVOugy8jCD8sDgtG8eSlG0/nlr//WHBNjC7f
 hDFvqrZ0ts7V3GKitt9YZlcg0AoKUPN21S8xe1IQlp8f0pHIAqwDjX0oAIu96KLxFcZm
 h61w==
X-Gm-Message-State: AOJu0YzCIIZS+OV+GpH4rk6c9/on2Q6GWIQFVRIA1ZHItGAEtGGZW3fF
 FTZLYRaJ1feO08qhH8gtv6GRCHTsTlBXvkZ0jyXpZUdF6X7HmGfU3DkgZkwT/WJm8tidpUoBccP
 9
X-Google-Smtp-Source: AGHT+IEibPnWg6v0pK2ZYjMH2dhvG2gANOz+c4zEmlVhpqdeWggaPjihKJCPJBLGPhK7fSPIzzmV3w==
X-Received: by 2002:a17:90b:4c8f:b0:2c8:820:71c4 with SMTP id
 98e67ed59e1d1-2c93d71f424mr2787188a91.29.1719840651800; 
 Mon, 01 Jul 2024 06:30:51 -0700 (PDT)
Received: from grind.. ([179.193.8.43]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2c91d3eb34bsm6736935a91.56.2024.07.01.06.30.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jul 2024 06:30:51 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: ajones@ventanamicro.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>
Subject: [PATCH 1/2] system/vl.c: do not allow mixed -accel opts
Date: Mon,  1 Jul 2024 10:30:37 -0300
Message-ID: <20240701133038.1489043-2-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240701133038.1489043-1-dbarboza@ventanamicro.com>
References: <20240701133038.1489043-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::532;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pg1-x532.google.com
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

We're allowing multiple -accel options to be used with different
accelerators, even though we don't have any machine that supports mixed
acceleration.

In fact, it will only parse the first occurence of -accel and, aside
from a help option (e.g. -accel help) that will always cause the process
to print the help text, it will accept every other accel option
regardless of being correct or not. E.g. this:

qemu-system-x86_64 -accel kvm -accel tcg -accel IamNotAnAccel (...)

will happily boot a x86_64 KVM guest.

Do not allow for different accelerators to be used when multiple
instances of -accel are present.

Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>
Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 system/vl.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/system/vl.c b/system/vl.c
index bdd2f6ecf6..32602e68b7 100644
--- a/system/vl.c
+++ b/system/vl.c
@@ -3318,10 +3318,22 @@ void qemu_init(int argc, char **argv)
                     }
                     break;
                 }
-            case QEMU_OPTION_accel:
+            case QEMU_OPTION_accel: {
+                QemuOptsList *list = qemu_find_opts("accel");
+                const char *prev_accel = qemu_opt_get(QTAILQ_LAST(&list->head),
+                                                      "accel");
+
                 accel_opts = qemu_opts_parse_noisily(qemu_find_opts("accel"),
                                                      optarg, true);
                 optarg = qemu_opt_get(accel_opts, "accel");
+
+                if (prev_accel && optarg && strcmp(prev_accel, optarg)) {
+                    printf("Unable to mix accelerators with multiple "
+                           "-accel options (have: '%s' and '%s')\n",
+                           prev_accel, optarg);
+                    exit(1);
+                }
+
                 if (!optarg || is_help_option(optarg)) {
                     printf("Accelerators supported in QEMU binary:\n");
                     GSList *el, *accel_list = object_class_get_list(TYPE_ACCEL,
@@ -3343,6 +3355,7 @@ void qemu_init(int argc, char **argv)
                     exit(0);
                 }
                 break;
+            }
             case QEMU_OPTION_usb:
                 qdict_put_str(machine_opts_dict, "usb", "on");
                 break;
-- 
2.45.2


