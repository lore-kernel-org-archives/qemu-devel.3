Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07DCAC54E66
	for <qemu-devel@archiver.kernel.org>; Sat,  9 Mar 2024 19:29:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rj2Lg-0000qg-GW; Sat, 09 Mar 2024 14:27:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rj2K7-0007Fm-HD
 for qemu-devel@nongnu.org; Sat, 09 Mar 2024 14:25:39 -0500
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rj2K2-0003Kx-5B
 for qemu-devel@nongnu.org; Sat, 09 Mar 2024 14:25:34 -0500
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-a449c5411e1so409072966b.1
 for <qemu-devel@nongnu.org>; Sat, 09 Mar 2024 11:25:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710012328; x=1710617128; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=E1R5kgOTA3lFvXSZnN7vgERJPXvNPz5gmsixt+yKpBc=;
 b=J3+6eU/PUwZW9aQ96ujTS6hvGa3rP7nq8miwGloalQ8rrKMJ95FjgCbcts9Cra58lk
 +JHRrnjp+82MalvBHSMDOvcMDP3e1Ba816NJLTRXVurC623MX9LFi/YCdkzLNN+iuKYD
 P1xqRacEG5pfplCPl2nltSyilXUxwIVNiJLQQLxlbE1qIHyrXmk3iecj2qqxLVA+RxDO
 XgqItcnazo+1nqt1IBWwcPdc1pf16Cd8MxaYmgVm8gqBvJjEOZ/ib3KixMueAKD5ntGQ
 HoGCR80UK21t6B2HcpcOJ12OdKePHGGY6KtcARgaUqWhCxoAjypn7xFq1RW6scO/NOIk
 9fjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710012328; x=1710617128;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=E1R5kgOTA3lFvXSZnN7vgERJPXvNPz5gmsixt+yKpBc=;
 b=XHWOIJWjhBEhdOgY4oXuEbRRVQxumy33o72U5uE5HOUit2sr8raUN/ochEIKG1QsBk
 qf0oGNO8488Vi5gXtq6iC2FihL993kC4uho6l7yCyVjEk1XHTwYD6oMieo7IFoQhtP+s
 a4b8Z1M+5enSCscU5DZ7zimfSkQ8miZ2Dbd/XNGGTTRcQshCvPaXAzpv6uJMilRofGoo
 bmZKpKI+TEFJCeXY4q7pbQhz6j4FQb9nG6wbVOV9j61jPe+3MX4MZX8DgTh45hShU51M
 tNVQM1XFR7ViRTBHLsPaYXcpZHSl/UgsJDT4JslVDcvPnn4M/K08R71kCJdMfsSKkVV7
 BTvQ==
X-Gm-Message-State: AOJu0Yyg/lFuh8ofoCEZSrIyalmeLETF4oprRTszFYYJRrCuNt4zY380
 S19uUhjRP5BPfeVq0E57e8rNdaif7zmlr0LCCapc5N1juEutB1+VT2Q4gY54NchmtvkxUiEUbeG
 4
X-Google-Smtp-Source: AGHT+IHnJt8M27LNZsdWUZYAmOdG9O1rxorvjpIsHoYwysnj44GwFfZ16OKHYnr5YK+sg37ilhTTRg==
X-Received: by 2002:a17:907:7644:b0:a43:eb29:a293 with SMTP id
 kj4-20020a170907764400b00a43eb29a293mr1284262ejc.5.1710012327713; 
 Sat, 09 Mar 2024 11:25:27 -0800 (PST)
Received: from m1x-phil.lan ([176.176.181.237])
 by smtp.gmail.com with ESMTPSA id
 hq31-20020a1709073f1f00b00a45c09107d6sm1182777ejc.29.2024.03.09.11.25.26
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 09 Mar 2024 11:25:27 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, qemu-arm@nongnu.org, Zhao Liu <zhao1.liu@intel.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>
Subject: [PULL 32/43] hw/core/machine-smp: Calculate total CPUs once in
 machine_parse_smp_config()
Date: Sat,  9 Mar 2024 20:21:59 +0100
Message-ID: <20240309192213.23420-33-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240309192213.23420-1-philmd@linaro.org>
References: <20240309192213.23420-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::635;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x635.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

From: Zhao Liu <zhao1.liu@intel.com>

In machine_parse_smp_config(), the number of total CPUs is calculated
by:

    drawers * books * sockets * dies * clusters * cores * threads

To avoid missing the future new topology level, use a local variable to
cache the calculation result so that total CPUs are only calculated
once.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20240308160148.3130837-4-zhao1.liu@linux.intel.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/core/machine-smp.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/core/machine-smp.c b/hw/core/machine-smp.c
index 50a5a40dbc..27864c9507 100644
--- a/hw/core/machine-smp.c
+++ b/hw/core/machine-smp.c
@@ -91,6 +91,7 @@ void machine_parse_smp_config(MachineState *ms,
     unsigned cores   = config->has_cores ? config->cores : 0;
     unsigned threads = config->has_threads ? config->threads : 0;
     unsigned maxcpus = config->has_maxcpus ? config->maxcpus : 0;
+    unsigned total_cpus;
 
     /*
      * Specified CPU topology parameters must be greater than zero,
@@ -211,8 +212,8 @@ void machine_parse_smp_config(MachineState *ms,
         }
     }
 
-    maxcpus = maxcpus > 0 ? maxcpus : drawers * books * sockets * dies *
-                                      clusters * cores * threads;
+    total_cpus = drawers * books * sockets * dies * clusters * cores * threads;
+    maxcpus = maxcpus > 0 ? maxcpus : total_cpus;
     cpus = cpus > 0 ? cpus : maxcpus;
 
     ms->smp.cpus = cpus;
@@ -228,8 +229,7 @@ void machine_parse_smp_config(MachineState *ms,
     mc->smp_props.has_clusters = config->has_clusters;
 
     /* sanity-check of the computed topology */
-    if (drawers * books * sockets * dies * clusters * cores * threads !=
-        maxcpus) {
+    if (total_cpus != maxcpus) {
         g_autofree char *topo_msg = cpu_hierarchy_to_string(ms);
         error_setg(errp, "Invalid CPU topology: "
                    "product of the hierarchy must match maxcpus: "
-- 
2.41.0


