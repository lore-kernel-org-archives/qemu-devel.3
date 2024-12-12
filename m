Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D37EE77180
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2024 09:27:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLfTD-00005L-Pj; Thu, 12 Dec 2024 04:26:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tLfT8-0008WK-Ur
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 04:26:51 -0500
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tLfT7-0004Jx-DL
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 04:26:50 -0500
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-385e27c75f4so247961f8f.2
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2024 01:26:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733995607; x=1734600407; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eNG57DpRLzLCRIZNlUcHaasL5EEpkFJjMdjoE5KeIVg=;
 b=rYg2V5S1H1x36knG4ZCxp1HLN9LMof8lndXREeimof5Lk6HpTmTvY2KQf/xQAvyeVQ
 +zW7mrmAgvf2cXrsyw9QXAaQ0noP7ervRAVM0oS5GEMcutiH+PVCZ8kSf4jfWatFzgm5
 WJOeJHIvZIfMpxCSTxXKO2rcz9J3CrFU8DnsUV/IeKRLvvxPikSEP5VVXeBkA/Z+1SxQ
 RcXAHU0paHAOwhCCUKG09ukeGeuLTpPP0piio3H+q4FXS7DsuOhq1I/RgtLv+bIHU+pE
 bASC2W8X4BHbTS55uTqjE2ZrstmDw4xy8U0T0n7WX2ExguGH40Wzo9CVotywlOAGpCcz
 ZJMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733995607; x=1734600407;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eNG57DpRLzLCRIZNlUcHaasL5EEpkFJjMdjoE5KeIVg=;
 b=XMFTLDZlgSOk3Z4LKhNg8sLNdOfrNoD34ZujwY6dt4oTrJRgCPUrdLIqGe/XWTlpkx
 GmVa3+Elzflw/bf/adQflPnZJ5P202Pl2sEz2X22K3eKxiVH5v0dUujQ2ytFebVGbCaz
 hP7CJwwqBSIj+ubQRwTam626klrD8fkYOF/IGQwG0PV5fyPaIRx/BwjetHapYiVfP5Wo
 lEOm+TgVamxURG+YGtZgpI0b6M9qVMhewpTUqw0gfgHJbNpegrTUOndF5yUTiKenzJzY
 R4DiXZqFMyjQlD27xhjlSUn4FzzxxlJDhjC5ImQn2HiyHOveoWeuWUCVMnCuJqc9cghM
 aAdw==
X-Gm-Message-State: AOJu0Yw0QDj/2rZ4Vh1WOdp1JGI+UjcTz+LKbW7lalmAc89H9VcRU2QX
 UiO41MAwHd8b6H/ElHyZCrOPCpIQ0MlLartNQ/xXnpG4n+JBijmH/mnYKY+Ox74c6ZZzX0d4FO9
 8
X-Gm-Gg: ASbGnctGeUTMDB8OdloLQcqMRIkl8DBWeAo1Oy5R1INPOlyDHK06fPC2DWne9jhCaMI
 YbM6VNkii7TJePE0UveTvJZSmpw35L/GdlOpUnB5oKR3DS/P0X0pQt0pjl3A0Mb7W1c5KLlj6wi
 l+dv7Ze8IdrkjHqWweuDLJTGiy3s8eqzWF8Da+nMmNebgCymIC/phX5qT37ORrHWaeja+8aKMbG
 g7gLVi4cnfaK1pK23shtirh17XVvWFn9a/AryikrbSt6kPUFLGOhe870nJdkg2iXwMpl5X+Ttqm
 jWT+k/vwtJkMKbd0jfRQ6Yf0WDdqxdw=
X-Google-Smtp-Source: AGHT+IGQAfoSO1aP3sbgQfNf4TUN0FaWHfn0sm0UVTku4xzi01OWerwmZ/bBlz2lkpw6SeT/mdlI8g==
X-Received: by 2002:a05:6000:1885:b0:385:ec89:2efd with SMTP id
 ffacd0b85a97d-3864ce9247bmr4555146f8f.22.1733995607640; 
 Thu, 12 Dec 2024 01:26:47 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38782521845sm3448273f8f.106.2024.12.12.01.26.44
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 12 Dec 2024 01:26:45 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Pankaj Gupta <pankaj.gupta.linux@gmail.com>,
 Wei Yang <richardw.yang@linux.intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Haozhong Zhang <haozhong.zhang@intel.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 2/2] system: Restrict libpmem and libdaxctl CPPFLAGS to
 physmem.c
Date: Thu, 12 Dec 2024 10:26:32 +0100
Message-ID: <20241212092632.18538-3-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241212092632.18538-1-philmd@linaro.org>
References: <20241212092632.18538-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x435.google.com
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

Only physmem.c includes libpmem and libdaxctl headers.
No need to pass them to all system_ss[] files.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 system/meson.build | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/system/meson.build b/system/meson.build
index f7e2c8b826f..50d915bd80c 100644
--- a/system/meson.build
+++ b/system/meson.build
@@ -2,10 +2,13 @@ specific_ss.add(when: 'CONFIG_SYSTEM_ONLY', if_true: [files(
   'arch_init.c',
   'ioport.c',
   'memory.c',
-  'physmem.c',
   'watchpoint.c',
 )])
 
+specific_ss.add(when: 'CONFIG_SYSTEM_ONLY', if_true: [files(
+  'physmem.c',
+), libpmem, libdaxctl])
+
 system_ss.add(files(
   'balloon.c',
   'bootdevice.c',
@@ -23,7 +26,7 @@ system_ss.add(files(
   'runstate-hmp-cmds.c',
   'runstate.c',
   'tpm-hmp-cmds.c',
-), libpmem, libdaxctl)
+))
 
 system_ss.add(files(
   'vl.c',
-- 
2.45.2


