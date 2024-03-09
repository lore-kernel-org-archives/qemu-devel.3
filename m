Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90FC7C54791
	for <qemu-devel@archiver.kernel.org>; Sat,  9 Mar 2024 19:27:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rj2Hw-0000dU-O1; Sat, 09 Mar 2024 14:23:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rj2Hq-0000a8-Ue
 for qemu-devel@nongnu.org; Sat, 09 Mar 2024 14:23:16 -0500
Received: from mail-lj1-x231.google.com ([2a00:1450:4864:20::231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rj2Hn-0002YZ-MA
 for qemu-devel@nongnu.org; Sat, 09 Mar 2024 14:23:14 -0500
Received: by mail-lj1-x231.google.com with SMTP id
 38308e7fff4ca-2d28387db09so23614381fa.0
 for <qemu-devel@nongnu.org>; Sat, 09 Mar 2024 11:23:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710012189; x=1710616989; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9jsjeEWjsUkRHeCpOh+pko9UBxzZs1OaWzN0fIY08/s=;
 b=qD2laXfc0kbIGJy8+oNlHK2xm6IqvihqX4SHN+Uvtsw8Rw4xBcTI2H/edOX/ZtgCxW
 +TL3JtMP/tOFwGHSn3gGzRzTqWx1WMPk9BG0HRUIs2CvKZ0OoosuhyAwn8qswI4xmGha
 9LHD3lAQFIJxZKJ6H1KU5rCwDnpMfaybNE3kb/H1udSbB14gMsQ2FcjeHxBk/ErivQD2
 0XbsHPpmbN5NL3ySvkHbbyfsi4uqrSGv7KKkevx+krlatDuelUd/RSHjrvhbBvIF5Mfc
 S4knwHxmZnLne3WZaHpBI4l0CtZ/3tbfwmg+HgLpp2ZzJcW//aZSapzqAQy0dbgQ+nAx
 IDTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710012189; x=1710616989;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9jsjeEWjsUkRHeCpOh+pko9UBxzZs1OaWzN0fIY08/s=;
 b=JNkbhiOqETN3159IMRdSfSwGSP+ttc84l3rWhFI7qBzsl5P0tZd1hE3VYYdqq+kf+H
 3e8jEC5aHnAzmDFxDoW8B2ZLnxbXi/cyL06qYeBsL6j3YRHzYa55eA74Q0R+jCqaK0J4
 lGyP0vEiyIg2oYkibVPrUtl8xJ9w3AodO19KTcQ1LEFtfN5sr5fnTV7MKXUyCOfKj1eQ
 OM5G8hE2s758xP7TKVEZLUq90tzJW3vxqHld4aNVZ/p/nPqD+acKVJtIKvpBWM3kdew3
 fuHGR3mo07PEdNzoLdjlzo0r6M1Wsd28BoaRqoAvMsPn2qFmAoaXoMpZi3coSu5h3c2W
 Ldkg==
X-Gm-Message-State: AOJu0YxgFQijOoEBfIF6WztDPP3vMSj1xRtsSvPdkiJFcmAfmrDk4Wnm
 4bj8qbF14qLk+1AHVGgjhSmS/dcFeNbw+fLppgLk8/nVhlbIixinslQiSeiEbZjovMkoaWaoCzX
 v
X-Google-Smtp-Source: AGHT+IHVJYQKMJoF6M5h+nBzkB9MQSOKRczhtHaq4vuFR2+EzQeH6DE9+nIiaOsLgRl8gEGAHG9UzQ==
X-Received: by 2002:a05:651c:61f:b0:2d4:22b6:e6a4 with SMTP id
 k31-20020a05651c061f00b002d422b6e6a4mr1215415lje.30.1710012188800; 
 Sat, 09 Mar 2024 11:23:08 -0800 (PST)
Received: from m1x-phil.lan ([176.176.181.237])
 by smtp.gmail.com with ESMTPSA id
 fg3-20020a056402548300b005656bbb5b3fsm1153256edb.63.2024.03.09.11.23.07
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 09 Mar 2024 11:23:08 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 David Woodhouse <dwmw@amazon.co.uk>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony Perard <anthony.perard@citrix.com>, Paul Durrant <paul@xen.org>,
 xen-devel@lists.xenproject.org
Subject: [PULL 09/43] hw/xen/xen_pt: Add missing license
Date: Sat,  9 Mar 2024 20:21:36 +0100
Message-ID: <20240309192213.23420-10-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240309192213.23420-1-philmd@linaro.org>
References: <20240309192213.23420-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::231;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x231.google.com
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

Commit eaab4d60d3 ("Introduce Xen PCI Passthrough, qdevice")
introduced both xen_pt.[ch], but only added the license to
xen_pt.c. Use the same license for xen_pt.h.

Suggested-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: David Woodhouse <dwmw@amazon.co.uk>
Message-Id: <20231114143816.71079-17-philmd@linaro.org>
---
 hw/xen/xen_pt.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/hw/xen/xen_pt.h b/hw/xen/xen_pt.h
index 31bcfdf705..d3180bb134 100644
--- a/hw/xen/xen_pt.h
+++ b/hw/xen/xen_pt.h
@@ -1,3 +1,13 @@
+/*
+ * Copyright (c) 2007, Neocleus Corporation.
+ * Copyright (c) 2007, Intel Corporation.
+ *
+ * SPDX-License-Identifier: GPL-2.0-only
+ *
+ * Alex Novik <alex@neocleus.com>
+ * Allen Kay <allen.m.kay@intel.com>
+ * Guy Zana <guy@neocleus.com>
+ */
 #ifndef XEN_PT_H
 #define XEN_PT_H
 
-- 
2.41.0


