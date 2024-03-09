Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADC9AC54E66
	for <qemu-devel@archiver.kernel.org>; Sat,  9 Mar 2024 19:27:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rj2Lb-0008HF-QZ; Sat, 09 Mar 2024 14:27:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rj2Jx-00079l-Ib
 for qemu-devel@nongnu.org; Sat, 09 Mar 2024 14:25:32 -0500
Received: from mail-lj1-x229.google.com ([2a00:1450:4864:20::229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rj2Jr-0003Jc-RZ
 for qemu-devel@nongnu.org; Sat, 09 Mar 2024 14:25:23 -0500
Received: by mail-lj1-x229.google.com with SMTP id
 38308e7fff4ca-2d41f33eb05so20557611fa.0
 for <qemu-devel@nongnu.org>; Sat, 09 Mar 2024 11:25:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710012315; x=1710617115; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XGUSMcXRtP0nqAsvDloxBVg/GDCFuWNCjxC0TZD6IEQ=;
 b=VALzPcEGP+swjEk0CC2jH3D7xSbmEfKWg7llXc2ttAtVpaNLIEppsF/Ftm+ZNNNgSg
 oLvw2R8ChC17kazIZUh79XAB2pKm06uskQLzYL3VjWa5up6toM1ECJU1yrhWX0np2Oo9
 SBQkeSPdLXe7rjxkRiXDMstZc3OkNwdJuXy/ohn72Kl7dXGnISL67x4GVBso3PwXQ/qp
 oszvkcWDuneq9HTi5WwRGHj9I5VFoS4Vr5Fhb1hcnh4vEBrsYkwYsyodAbUM/kO2MZmR
 UA1avU3yP2CBcvLhie5FhQ9GlRfn+SHsDod8tpV6ZHfRiqs11AlzBW1WMODAxsKNCoDf
 Yljw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710012315; x=1710617115;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XGUSMcXRtP0nqAsvDloxBVg/GDCFuWNCjxC0TZD6IEQ=;
 b=Uozv3eMf1pKfDbAAWF28qWe7EFYSBy3KOZZffFoQ0VMLNv6zKBGXHmt+B/GdrCHpd3
 LfZyUW9GryoN4lVeFY9E7p9FMbeAekfcZbp7MaqY0ozQpLq9wmj9YaGqlWj1vo5+4RB1
 a8g9H/9wTMm9JXKVqzrtL4i1/5oK89mq3HDwx5o0q5VEgK+VyWhJPqOqcI/ceiUKdemW
 wGsL/OqlHhmmvLAbsICzCFhC20R5TQGe1oV0S2dHtA0oMWqZANAOlLQfr+4F8TTv3C1E
 UyzmSE5fURygisiA22lzc1/+/wrr6RWyubfcElpjbv+yU+QP/bQQqSJCeQjPDVGR89hf
 Yn9Q==
X-Gm-Message-State: AOJu0YygUe1uIc7MlecbjbEhTmYE5uZH9P1n3Fq3zwuVvKzewe+0BS4l
 5mJPPb9kIcViJVJeTyo914iByp7cGZ+gGH052tLJBiHp+koDACunkOylBrvOzw4L1KYXUeTgkH0
 z
X-Google-Smtp-Source: AGHT+IEmK9UTnYDyWWDsJcs7b0d4OIlrfGDbTA9RfFxf5J0o4Iae+IN++bySO9CuxqRiaN6pq2r2Vg==
X-Received: by 2002:a2e:9984:0:b0:2d2:71cc:253d with SMTP id
 w4-20020a2e9984000000b002d271cc253dmr1466595lji.25.1710012315435; 
 Sat, 09 Mar 2024 11:25:15 -0800 (PST)
Received: from m1x-phil.lan ([176.176.181.237])
 by smtp.gmail.com with ESMTPSA id
 w10-20020a056402128a00b005657eefa8e9sm1154766edv.4.2024.03.09.11.25.13
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 09 Mar 2024 11:25:15 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, qemu-arm@nongnu.org, Zhao Liu <zhao1.liu@intel.com>,
 Thomas Huth <thuth@redhat.com>, Prasad Pandit <pjp@fedoraproject.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 devel@lists.libvirt.org, Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>
Subject: [PULL 30/43] hw/core/machine-smp: Remove deprecated "parameter=0" SMP
 configurations
Date: Sat,  9 Mar 2024 20:21:57 +0100
Message-ID: <20240309192213.23420-31-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240309192213.23420-1-philmd@linaro.org>
References: <20240309192213.23420-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::229;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x229.google.com
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

The "parameter=0" SMP configurations have been marked as deprecated
since v6.2.

For these cases, -smp currently returns the warning and adjusts the
zeroed parameters to 1 by default.

Remove the above compatibility logic in v9.0, and return error directly
if any -smp parameter is set as 0.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Prasad Pandit <pjp@fedoraproject.org>
Message-ID: <20240308160148.3130837-2-zhao1.liu@linux.intel.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 docs/about/deprecated.rst       | 16 ----------------
 docs/about/removed-features.rst | 15 +++++++++++++++
 hw/core/machine-smp.c           |  5 +++--
 3 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
index 8565644da6..6e2f557682 100644
--- a/docs/about/deprecated.rst
+++ b/docs/about/deprecated.rst
@@ -36,22 +36,6 @@ and will cause a warning.
 The replacement for the ``nodelay`` short-form boolean option is ``nodelay=on``
 rather than ``delay=off``.
 
-``-smp`` ("parameter=0" SMP configurations) (since 6.2)
-'''''''''''''''''''''''''''''''''''''''''''''''''''''''
-
-Specified CPU topology parameters must be greater than zero.
-
-In the SMP configuration, users should either provide a CPU topology
-parameter with a reasonable value (greater than zero) or just omit it
-and QEMU will compute the missing value.
-
-However, historically it was implicitly allowed for users to provide
-a parameter with zero value, which is meaningless and could also possibly
-cause unexpected results in the -smp parsing. So support for this kind of
-configurations (e.g. -smp 8,sockets=0) is deprecated since 6.2 and will
-be removed in the near future, users have to ensure that all the topology
-members described with -smp are greater than zero.
-
 Plugin argument passing through ``arg=<string>`` (since 6.1)
 ''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
 
diff --git a/docs/about/removed-features.rst b/docs/about/removed-features.rst
index 417a0e4fa1..f9cf874f7b 100644
--- a/docs/about/removed-features.rst
+++ b/docs/about/removed-features.rst
@@ -489,6 +489,21 @@ The ``-singlestep`` option has been turned into an accelerator property,
 and given a name that better reflects what it actually does.
 Use ``-accel tcg,one-insn-per-tb=on`` instead.
 
+``-smp`` ("parameter=0" SMP configurations) (removed in 9.0)
+''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
+
+Specified CPU topology parameters must be greater than zero.
+
+In the SMP configuration, users should either provide a CPU topology
+parameter with a reasonable value (greater than zero) or just omit it
+and QEMU will compute the missing value.
+
+However, historically it was implicitly allowed for users to provide
+a parameter with zero value, which is meaningless and could also possibly
+cause unexpected results in the -smp parsing. So support for this kind of
+configurations (e.g. -smp 8,sockets=0) is removed since 9.0, users have
+to ensure that all the topology members described with -smp are greater
+than zero.
 
 User-mode emulator command line arguments
 -----------------------------------------
diff --git a/hw/core/machine-smp.c b/hw/core/machine-smp.c
index 25019c91ee..96533886b1 100644
--- a/hw/core/machine-smp.c
+++ b/hw/core/machine-smp.c
@@ -105,8 +105,9 @@ void machine_parse_smp_config(MachineState *ms,
         (config->has_cores && config->cores == 0) ||
         (config->has_threads && config->threads == 0) ||
         (config->has_maxcpus && config->maxcpus == 0)) {
-        warn_report("Deprecated CPU topology (considered invalid): "
-                    "CPU topology parameters must be greater than zero");
+        error_setg(errp, "Invalid CPU topology: "
+                   "CPU topology parameters must be greater than zero");
+        return;
     }
 
     /*
-- 
2.41.0


