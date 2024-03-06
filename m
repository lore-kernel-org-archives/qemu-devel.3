Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A2A4C5475B
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Mar 2024 14:49:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhsa4-0006nM-AH; Wed, 06 Mar 2024 09:49:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rhsZq-0006bk-1U
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 09:49:03 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rhsZn-0004E6-J9
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 09:49:01 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-412f8bf3718so3873115e9.0
 for <qemu-devel@nongnu.org>; Wed, 06 Mar 2024 06:48:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709736537; x=1710341337; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1JocjxziTQra/6RBeDrs7o1Pv+xkFGssg8gkJHYaEJo=;
 b=W6+HXhzf+Hu/xAMuF6Lgxo0UcX53JJzSzimSFIxe8g6x4kWWA9H++nilnvSiNjLsgf
 U6ziuCcsTPuTcrF/B6b3DpDd1+5MgmH0kTXAamUCsOgrS8ChXMcMrZdAzqIom0faGcSb
 2RtqQpAbMWJIeopFX3iUH8/4GhIUJ0ejlEIuZiNZCCTFz1bsMHHoTbgw4Xp298a4Llft
 45f82u8xJqlvNY88/G+BHnpCqwNdghVTiqMY56VNnRZwbZvw8qYS8jzs0u0Z8nRmn5dC
 WlRLqtJlavNXo4ETekvK8Cbzcf0ciSCCcJrSr/GnmY/6OMvOBd+sahHMPQNR7WbNeiJE
 DCug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709736537; x=1710341337;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1JocjxziTQra/6RBeDrs7o1Pv+xkFGssg8gkJHYaEJo=;
 b=kTekzTPaSMItb5wplsdSJtb0Ha+mOzba3sxVI94sdKG/RHftKQlKYk4C5fxQbx+bO5
 ijCx6aPNeMNA/Tz9aWuyHxxyLmRjuiMd9JUYG53NLLMW9lsbgKYU0spb495/TyMrns8h
 E4lWRF3f+aADTwGJZbcd32HeyPGuJTaAZ3P9B4X0gNxOon+rVxGSY+W9MIB5T6U3dZb4
 0dmOrbeFmBpBBGlhl1/Jn5uI/sHRNM18F+eeiyZet61ddH49YDbgI/7ri7Vn703dO/XI
 B6q/SIBLhHUC4mp0tp/4msTxT/MrT4i+rIFxavvk0uHf6SFhlE7HuC6gidg3Oj6+6iZ3
 BOSg==
X-Gm-Message-State: AOJu0YwhqLbVjzc5nf8RIc2AmyMtibvR4jmDNwxjTNg6tuErz8+UfWsM
 KDFW7iXyO9fqEQ/KPmhBcylWnnXfZopmtL6D8IC/GkLEHk/0X95mGFdKDodYECfG9AUnhqNslRD
 h
X-Google-Smtp-Source: AGHT+IFXYoEebiF+4U26Zsyi+7OvJvDsbnJJD9Gbo+YjdlX27SRFYI97uT4iwbIfDxlAn0Gy7SWcmQ==
X-Received: by 2002:a05:600c:190a:b0:412:c9e7:202d with SMTP id
 j10-20020a05600c190a00b00412c9e7202dmr10835994wmq.6.1709736537368; 
 Wed, 06 Mar 2024 06:48:57 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 bg14-20020a05600c3c8e00b004122b7a680dsm21560544wmb.21.2024.03.06.06.48.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Mar 2024 06:48:57 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 0141B5F9F4;
 Wed,  6 Mar 2024 14:40:44 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 27/29] disas/hppa: honour show_opcodes
Date: Wed,  6 Mar 2024 14:40:39 +0000
Message-Id: <20240306144041.3787188-28-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240306144041.3787188-1-alex.bennee@linaro.org>
References: <20240306144041.3787188-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x332.google.com
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

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20240305121005.3528075-28-alex.bennee@linaro.org>

diff --git a/disas/hppa.c b/disas/hppa.c
index 22dce9b41bb..49e2231ae62 100644
--- a/disas/hppa.c
+++ b/disas/hppa.c
@@ -1972,9 +1972,11 @@ print_insn_hppa (bfd_vma memaddr, disassemble_info *info)
 
   insn = bfd_getb32 (buffer);
 
-  info->fprintf_func(info->stream, " %02x %02x %02x %02x   ",
-                (insn >> 24) & 0xff, (insn >> 16) & 0xff,
-                (insn >>  8) & 0xff, insn & 0xff);
+  if (info->show_opcodes) {
+      info->fprintf_func(info->stream, " %02x %02x %02x %02x   ",
+                         (insn >> 24) & 0xff, (insn >> 16) & 0xff,
+                         (insn >>  8) & 0xff, insn & 0xff);
+  }
 
   for (i = 0; i < NUMOPCODES; ++i)
     {
-- 
2.39.2


