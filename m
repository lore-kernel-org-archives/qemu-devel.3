Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05F85C3ABDD
	for <qemu-devel@archiver.kernel.org>; Thu, 15 May 2025 10:32:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFVop-0007eF-5K; Thu, 15 May 2025 06:28:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uFVnX-0005Jb-7D
 for qemu-devel@nongnu.org; Thu, 15 May 2025 06:26:46 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uFVnT-0008Ep-7J
 for qemu-devel@nongnu.org; Thu, 15 May 2025 06:26:42 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-442e9c00bf4so5682645e9.3
 for <qemu-devel@nongnu.org>; Thu, 15 May 2025 03:26:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747304796; x=1747909596; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ADYZiGwQJaZdw9waRlCxaR1oZ/Aa3txDutMzuGy18wY=;
 b=ca0pqXKLGkhdmqUl/VedyRwVpiD5ZPIxY1nySP94v+RuxYMcPOTDwThPo9/R2vIo3c
 WkDOahaCaz9Z2a8vF+lKLerPBITlNJeXAcgXV/nbaqbNIPfjmAGx2BesZxkwTYJ7WGbH
 CGWGwWMKBy5VMxgLRLiKgB+Q3FagmmsTg97WItDpp3n2kqEKO3uKUI/YaFKkcqgHt9h0
 rD4h5a6h4J+zBJLuu3arNybB0Olz+0mDvlO4A6Ixa3oFuAFx8R24/hYgFtK5djg7EFOE
 gTGIecUi6S+R81NR4SWQ1bH6BAdoQoMcA6C7z+gRDPg/YVPJ7VGHv8i79FPP31oqfl4x
 pyeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747304796; x=1747909596;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ADYZiGwQJaZdw9waRlCxaR1oZ/Aa3txDutMzuGy18wY=;
 b=rM4Px1GZiHdjZTRvRXlRYAVAAtEw+CIMzpOQSj3gootqOa47KtDn3idQnYQ0Z76c4d
 wAAB+dHogAMnCQ/7aPCIhaueZgfK6AUNxR0SSOTyZH8joF8dNVLKLVJAqrjBLLFMWV4o
 0hng7lZFs2Iwf0yHuykiA+5z4WorINj9O/VndpuS99QJa9d6XLIHFcUuMTLVJD3Ebub1
 FC7/GrHGvD/odp7k38UWx90C46CmxDQDHZR/gopAJwOMJhtpYNqy6rkEiRkw7fNlqSnO
 9U6rPuP1QeqVdScByLJfrV/kvGq+e8sowJJCbTRmCG74/Ua+1ZrBoa+p39SG7T/26sbZ
 fcLA==
X-Gm-Message-State: AOJu0Yw1FWED2r/gERjJQvefEAPEfAi4kEfA5vHsIJ8xVymSgN1dRYxP
 gwruvOkVVuLxrmvGg8EbZyr8IphNNKQxa0vM5PPDXM8cpkzsTk6rWJl7heTXoiUgrPJed/xrg/t
 56kM=
X-Gm-Gg: ASbGncs+fS6KYMUbMFlVRSZRNH4EIMe319+LVKlyW0WuJHA55u1DoqeGhqEG++5FzJR
 jDRIChCjuFV0hIPLQSRnap6L698KlpK17Pn9TxTjhJrup9qxZk+4eZLwtIgwui7as7Nx5LT/lcI
 +6jhKmsYTCLlTbEmiWowslALxCSXhqAWQ44M794lnlO1ieoUuaD3KzeB8VZfJ3RF5PjNfpHGDp8
 e2e4rFEIU2PeshobpNlkqy739Ljv1+FRWNLZhfH2PW2wpBJkR3IoFb/f7YOjxQUL+eFd/Mp95Hz
 O2R4lL1Vpc4FDovJYlJjWmfDRUZDL5fRVYY7hcoMKdAsdjSoUMtCS3JHXQ==
X-Google-Smtp-Source: AGHT+IGTFueAcZ22VBzXWWY00WInVN8yY6Wo69msJ13NF2OxkUu/X5KkDBjSvy+6PTXvKNHVXRJN7w==
X-Received: by 2002:a05:600c:3f08:b0:43c:fd27:a216 with SMTP id
 5b1f17b1804b1-442f970b20dmr15732035e9.23.1747304795683; 
 Thu, 15 May 2025 03:26:35 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-442f396c3a4sm65657855e9.26.2025.05.15.03.26.34
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 May 2025 03:26:34 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 36/58] target/arm/arch_dump: compile file once (system)
Date: Thu, 15 May 2025 11:25:24 +0100
Message-ID: <20250515102546.2149601-37-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250515102546.2149601-1-peter.maydell@linaro.org>
References: <20250515102546.2149601-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32a.google.com
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

From: Pierrick Bouvier <pierrick.bouvier@linaro.org>

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20250512180502.2395029-27-pierrick.bouvier@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/meson.build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/arm/meson.build b/target/arm/meson.build
index 06d479570e2..95a2b077dd6 100644
--- a/target/arm/meson.build
+++ b/target/arm/meson.build
@@ -15,7 +15,6 @@ arm_ss.add(when: 'TARGET_AARCH64', if_true: files(
 arm_system_ss = ss.source_set()
 arm_common_system_ss = ss.source_set()
 arm_system_ss.add(files(
-  'arch_dump.c',
   'arm-powerctl.c',
   'arm-qmp-cmds.c',
   'cortex-regs.c',
@@ -38,6 +37,7 @@ arm_common_system_ss.add(files('cpu.c'), capstone)
 arm_common_system_ss.add(when: 'TARGET_AARCH64', if_false: files(
   'cpu32-stubs.c'))
 arm_common_system_ss.add(files(
+  'arch_dump.c',
   'debug_helper.c',
   'helper.c',
   'vfp_fpscr.c',
-- 
2.43.0


