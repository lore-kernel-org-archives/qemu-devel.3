Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7B05D0EE18
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Nov 2025 21:49:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vO0ty-0001h9-CB; Tue, 25 Nov 2025 16:48:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vO0tk-0001Yu-Fq
 for qemu-devel@nongnu.org; Tue, 25 Nov 2025 16:48:39 -0500
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vO0ti-0005F0-To
 for qemu-devel@nongnu.org; Tue, 25 Nov 2025 16:48:32 -0500
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-429c7869704so5045942f8f.2
 for <qemu-devel@nongnu.org>; Tue, 25 Nov 2025 13:48:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764107308; x=1764712108; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=PHzH+lCK4DEu5MLOOUlhaw7zhQlxhytN2R2hX7cMvgM=;
 b=M2NvBtVAmyesaUDCtfYpYWnFJnTB2cQXlC/GP1fxBzQRB60ZvPPGPITkxiIrYOcMB5
 6GK05NXGz+tjGQKl/hNbwV9HnkKEoWDGtRrOexNMqQiF9sVjmUkbEK5ZLPmFim4ybL2x
 ftZ4L+KdkhAr2lQYWhYz3NHOHOxnKs0Bz0uHq9LBYRMMn7C/BJgSnDnFnQw3qw3UtIie
 Upr4VHrQ8u5DfkVuwn3o5hFCMOyPwT8lAP9Sar8IqSctn2yJaZ9cihGtbhxjZw7Jwu9/
 X4DgFeAqFYGOn8JH72qblxpcs1tmNXL2dV1QqOP7L0xj598qJv6H6vM941cr5H2Ih19I
 PWjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764107308; x=1764712108;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=PHzH+lCK4DEu5MLOOUlhaw7zhQlxhytN2R2hX7cMvgM=;
 b=S5kHOxXDBlDFmoQJfXY1mu06EwCT3XB8Lnpb8Srby5M9enrIJzvj06bJiRrk2rgOGH
 v+fEK4VFM6JqMime436vcujBKHBgcega3Fpxa6UBT0mWdHB15kfsbSMIOUjBTY2fgEp+
 qi0+W42EsYUGWhWiJb8YTbZpc3opbYtPcTTBTUH6uY+s/RDKMAelzFv+GZ81DlPxKJKL
 3Zy/YM4tVftqcndDrCguJuZLkv1vtCKhk/Ngh3OfVUsxIB8L81GiSEXL/Oe94zCPc5r6
 kvS65tykpd/+lRcLZCZSIFhn+inaIT+JUE57+79pmx2CVK4hhxWCK6VZw+7fPxPTBFoi
 AauA==
X-Gm-Message-State: AOJu0YwCP4cFBHT9+8EFJG0szHmu2TeXqcypNx4UmMJ/cNY7SAWCyG4Z
 LjCTGZWafawMunJPhWx1eAI3VC8ucKipezVp3kGmn3g+oBvoPwn8IqvotrTdwaByfJsk3Oktebe
 86V32DlG/1g==
X-Gm-Gg: ASbGncuPmcha1NW0oOnok9rKM9gLftYQoWj8yCW9KDPcOczGjJf4sEhJBKKVAoKpiBk
 G4uFiAFsBVa8S34IE+SqfpmX54Rk2AHcFSesXsjZ5nAcHOv+e6hakwjQwmUIEry6YHWDtVomTz5
 f1sI4ahtpeitGSoflqTx6qk4iDyhFyWCkl6SJsVEgQNyfbnvDnxR06Q+HxuKAALMIJH4FWVlf4R
 g3oWz0kTe2SJSrL2MY+l/f8K80gp4xwvy/MR2uVOffXOISSYugm9V2uQGsr8BiiMwqDGz7ehKon
 EfM1eLHSiycMqfzoVDjjnT82Zkph4CBQ2nqbbkLnsU7fjAxFxao1QKgsJrnqawi4lnncI0e0yRd
 nrCx6XXBKquyU1kGgbpaBLFjwciHA4/43wg0f6OD4wKBfvu01GB2k3T1J9XpPoNzlw3gypx70Zw
 fdK8/qUjKm/FSVVooVUK0ReTCyfjwfBdAOvAop56Oec037BEesSqxrWASTpk6H
X-Google-Smtp-Source: AGHT+IHcNW54oX7DBvziDn5MwXe4pi3vz++Mui2Niob9Fw/7S7w4CPbdJNtdCOLt844wqK1/pX+vOQ==
X-Received: by 2002:a05:6000:184a:b0:42b:38b1:e32e with SMTP id
 ffacd0b85a97d-42e0f34f998mr4581945f8f.46.1764107308462; 
 Tue, 25 Nov 2025 13:48:28 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42cb7fb91f4sm37231193f8f.31.2025.11.25.13.48.27
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 25 Nov 2025 13:48:27 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 3/9] docs/deprecated: Remove undeprecated SMP description
Date: Tue, 25 Nov 2025 22:47:55 +0100
Message-ID: <20251125214802.1929-4-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251125214802.1929-1-philmd@linaro.org>
References: <20251125214802.1929-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42d.google.com
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

From: Zhao Liu <zhao1.liu@intel.com>

"Unsupported 'parameter=1' SMP configuration" was proposed to be
deprecated in the commit 54c4ea8f3ae6 ("hw/core/machine-smp: Deprecate
unsupported "parameter=1" SMP configurations").

But the related code was reverted later in the commit 9d7950edb0cd
("hw/core: allow parameter=1 for SMP topology on any machine").

Thus, this SMP behavior is still valid and is not actually deprecated.

Remove outdated document descriptions.

Reported-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Message-ID: <20251121084416.1031466-1-zhao1.liu@intel.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 docs/about/deprecated.rst | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
index 30ab72b2a4c..9386cffba26 100644
--- a/docs/about/deprecated.rst
+++ b/docs/about/deprecated.rst
@@ -54,20 +54,6 @@ as short-form boolean values, and passed to plugins as ``arg_name=on``.
 However, short-form booleans are deprecated and full explicit ``arg_name=on``
 form is preferred.
 
-``-smp`` (Unsupported "parameter=1" SMP configurations) (since 9.0)
-'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
-
-Specified CPU topology parameters must be supported by the machine.
-
-In the SMP configuration, users should provide the CPU topology parameters that
-are supported by the target machine.
-
-However, historically it was allowed for users to specify the unsupported
-topology parameter as "1", which is meaningless. So support for this kind of
-configurations (e.g. -smp drawers=1,books=1,clusters=1 for x86 PC machine) is
-marked deprecated since 9.0, users have to ensure that all the topology members
-described with -smp are supported by the target machine.
-
 QEMU Machine Protocol (QMP) commands
 ------------------------------------
 
-- 
2.51.0


