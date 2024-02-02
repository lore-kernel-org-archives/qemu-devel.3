Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58939C48291
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Feb 2024 15:39:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVvb2-0000Kh-6n; Fri, 02 Feb 2024 10:36:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rVvb0-0000JA-9n
 for qemu-devel@nongnu.org; Fri, 02 Feb 2024 10:36:50 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rVvay-0004TU-ME
 for qemu-devel@nongnu.org; Fri, 02 Feb 2024 10:36:49 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-40fb020de65so19239145e9.2
 for <qemu-devel@nongnu.org>; Fri, 02 Feb 2024 07:36:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706888206; x=1707493006; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=RYd3QrmHD9UKjdfu51z5VjEqtJezN+iOtcmmSJ3N4Eo=;
 b=IL0+I6LW9TtehitUbFW7SGqCZzHYkyhX126hWj3NjoTa92O8+Sl2qVL2kCfEm/N00A
 mOZg8jQgNzgshLOXTmPOR1mNCHM9NAsWfT9RMr1u12I3zR1KADrtFVdPXhSxEebELcrP
 fZXD7omcAzfPzkOW+HApdraHToTAKoV4rKXJi4dVqOSxsyYHC1QTclF6ORPh+bClEqoT
 MRVW/uN9A19t3Bc4u/noPiILayDnxzOT5D1Jv1L9gMyxvFp+EO6PtsfjBExa34Dhs6j1
 w0NgH/le5EiPaTFlXVPXXcQlWqjUkxUJq8IV+BmXcqsizHbrwMEImVKDxGodMFSb4k6O
 lxIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706888206; x=1707493006;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RYd3QrmHD9UKjdfu51z5VjEqtJezN+iOtcmmSJ3N4Eo=;
 b=hjmCslTMMxJv12Y2bEj+AqOU+3b6QBGg/noq0qDRaLoao7ulzltgvcXpMTBg2UcZTG
 6FWJfjVnU4/5ihhuDvnZpCUQuB0cug1iIiYX64NuCE7a9tXXztVOZ60uvIRI9oIqayr6
 ViQRQwxrQOCRlHu/AXcQMGp5LP9HFRVwuJ/tHA7zu1XPcbuD7WGdk3hkHenj+qp9OT7V
 nBiaMCrZvR8agr3CpanKUolSa7G3m0MCpXmTdZ/1Lzhf7Ns9aO6oAZlwMd45TDdeZMR+
 qTt8nzJmXrAANFwRLUheijV1Idckw363hRp840Fcirmpkz46UldlXzUiWNEWIWv0rOay
 ox4Q==
X-Gm-Message-State: AOJu0YyK5gCmSj5hFT6dEYNYMTtZTrOrfHHp1hRUv3ayLy5LBpeQk8Ld
 /HD3Eke7VIqyJU1vrmVSaF9G11PUkn/8MocTtXU6geaXNKvHom07Oe828cw8B6S4QOwB7L5Xwd4
 p
X-Google-Smtp-Source: AGHT+IG2iplXt4MJz53vrW6Dk82/noLxmrcqdxW91c4qAfwyRlwzUnkg8bja0nR+zsrWX23hwfpgaA==
X-Received: by 2002:a05:600c:3152:b0:40e:7852:bc85 with SMTP id
 h18-20020a05600c315200b0040e7852bc85mr6665943wmo.41.1706888206343; 
 Fri, 02 Feb 2024 07:36:46 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 k2-20020a05600c1c8200b0040fafd84095sm214735wms.41.2024.02.02.07.36.46
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Feb 2024 07:36:46 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 16/36] hw/arm/highbank: Check for CPU types in
 machine_run_board_init()
Date: Fri,  2 Feb 2024 15:36:17 +0000
Message-Id: <20240202153637.3710444-17-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240202153637.3710444-1-peter.maydell@linaro.org>
References: <20240202153637.3710444-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Restrict MachineClass::valid_cpu_types[] to the single
valid CPU types.

Instead of ignoring invalid CPU type requested by the user:

  $ qemu-system-arm -M midway -cpu cortex-a7 -S -monitor stdio
  QEMU 8.2.50 monitor - type 'help' for more information
  (qemu) info qom-tree
  /machine (midway-machine)
    /cpu[0] (cortex-a15-arm-cpu)
    ...

we now display an error:

  $ qemu-system-arm -M midway -cpu cortex-a7
  qemu-system-arm: Invalid CPU model: cortex-a7
  The only valid type is: cortex-a15

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Gavin Shan <gshan@redhat.com>
Message-id: 20240129151828.59544-5-philmd@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/highbank.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/hw/arm/highbank.c b/hw/arm/highbank.c
index b8d702c82cc..03670506974 100644
--- a/hw/arm/highbank.c
+++ b/hw/arm/highbank.c
@@ -345,10 +345,15 @@ static void midway_init(MachineState *machine)
 
 static void highbank_class_init(ObjectClass *oc, void *data)
 {
+    static const char * const valid_cpu_types[] = {
+        ARM_CPU_TYPE_NAME("cortex-a9"),
+        NULL
+    };
     MachineClass *mc = MACHINE_CLASS(oc);
 
     mc->desc = "Calxeda Highbank (ECX-1000)";
     mc->init = highbank_init;
+    mc->valid_cpu_types = valid_cpu_types;
     mc->block_default_type = IF_IDE;
     mc->units_per_default_bus = 1;
     mc->max_cpus = 4;
@@ -364,10 +369,15 @@ static const TypeInfo highbank_type = {
 
 static void midway_class_init(ObjectClass *oc, void *data)
 {
+    static const char * const valid_cpu_types[] = {
+        ARM_CPU_TYPE_NAME("cortex-a15"),
+        NULL
+    };
     MachineClass *mc = MACHINE_CLASS(oc);
 
     mc->desc = "Calxeda Midway (ECX-2000)";
     mc->init = midway_init;
+    mc->valid_cpu_types = valid_cpu_types;
     mc->block_default_type = IF_IDE;
     mc->units_per_default_bus = 1;
     mc->max_cpus = 4;
-- 
2.34.1


