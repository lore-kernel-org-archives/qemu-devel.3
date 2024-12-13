Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35145E77180
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2024 19:20:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tMB8x-0000ZG-J5; Fri, 13 Dec 2024 14:16:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tMB7A-0006hr-8P
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 14:14:18 -0500
Received: from mail-oi1-x233.google.com ([2607:f8b0:4864:20::233])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tMB78-0007ZD-5W
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 14:14:15 -0500
Received: by mail-oi1-x233.google.com with SMTP id
 5614622812f47-3eb880e5ac2so1019985b6e.2
 for <qemu-devel@nongnu.org>; Fri, 13 Dec 2024 11:14:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734117252; x=1734722052; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SrDfnd4nexJqpZXbjwhcsQhh4SvuMhCE9tA8eU5koCw=;
 b=t/GUh3GyEu893oPCsyUDxnf1WMNcHlDSoio00NRC6/i5DtXhgKSLz+skx7FEu4OI/N
 kJ2hynA4ifXnKkRdGG0LP6ibsyrA45BBqlNHGIjWDOoathZLTHOtw/zTewbrN6IfpT9C
 pSVRiyCQOkCnGhnXPRG2gfnqS7m0uYAI7ovhC61Sn3Xp45TDpth8Dniy5JmTkJ92lHbx
 u3wYHTa0aG5APkY5dlvBUWbhGCHJaeLP0E6dJxDKFAcIrvkGl/otC+KL7s8cJN62d9A7
 1yIo3aDtoZgA43LQls6iHAuGcE4+wArWx9QY1NcyeJnZFwG1jd7eQ+5GE3r8dTi+Bkbt
 +WtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734117252; x=1734722052;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SrDfnd4nexJqpZXbjwhcsQhh4SvuMhCE9tA8eU5koCw=;
 b=RZ0OpAy6Vwko9yITvTaKCzu3S52ez2UzkM1jsqCjI3a05vBXm52KiNdZuO63/mEMa/
 2OFguqwFiWkHegp3G29ENRzSRHHme6f/htaSsW7ejDQO30rgXHyC22WsZba4VNhqbf7J
 s0CXI9YLlcvJM9jqXMItmGq8E4m1XKlc5/t7lOSiHKMzEZQQ+bbzDJbuJjQ/3GkH70S5
 OLameJcj3ECLKEmVsgu8wV0uMg4FcvZb6jb1ekpyYrEHjHgpAZYv+4e87zEOIGiyYdL7
 LRIn/IEhtTomvlK6D/fOUyNaylgz7gFzg/+bRnxU60fNiPs4he/6HMbnmQEEY0Y6HQco
 Tvww==
X-Gm-Message-State: AOJu0Yyb4FTTIftth+cWFh0kYU9ZDYociuFrlNytFarsGWZuAE22RF5a
 2LQun76a+R5YALOC7q4X2etXfVygeCiGmjkNcROj7M/3igzOoMoqSGMPuiCI6PNhKi4wKzvBJh5
 l7zE+n5gr
X-Gm-Gg: ASbGncsuyJCZZjapx7D3rW//jjpaall5uZWkGYXhF9Tac0lTCmdKk3wztEQmEETRPcg
 P74D9UjR90kqCbKp+hCBmDy8RFhDAOaNyjXVgUIuVfMqOs4PV7Okx1znf3ebNlFIHo0ctVuGvJj
 g2LY8VHLaTbUXBfn8vt5mlko88YIdPJ81u8oLr6S5t8zAk+PBds0bimAq7NWO+1TIxEDYTwQlWT
 aExox1P5NluYhJ/3y+m8zgVLlIHjzeearz6GFcHvU6a+k5rOrT2vbSFW9xiJoar
X-Google-Smtp-Source: AGHT+IHXhM6+cWhPJCruqCEoyGoWYGDjiwRiQ7pUS+Ae3QyN331kWuJNMOv7kOrfzyozCy5qxlE/UQ==
X-Received: by 2002:a05:6808:3c47:b0:3eb:8eb0:8166 with SMTP id
 5614622812f47-3eba6983205mr1891627b6e.36.1734117252628; 
 Fri, 13 Dec 2024 11:14:12 -0800 (PST)
Received: from stoup.. ([187.217.227.247]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3ebb478a497sm3545b6e.10.2024.12.13.11.14.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Dec 2024 11:14:12 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 Jagannathan Raman <jag.raman@oracle.com>
Subject: [PATCH 50/71] hw/remote: Constify all Property
Date: Fri, 13 Dec 2024 13:07:24 -0600
Message-ID: <20241213190750.2513964-55-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241213190750.2513964-1-richard.henderson@linaro.org>
References: <20241213190750.2513964-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::233;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x233.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 hw/remote/proxy.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/remote/proxy.c b/hw/remote/proxy.c
index 302a0a4d4d..6f84fdd3fa 100644
--- a/hw/remote/proxy.c
+++ b/hw/remote/proxy.c
@@ -191,7 +191,7 @@ static void pci_proxy_write_config(PCIDevice *d, uint32_t addr, uint32_t val,
     config_op_send(PCI_PROXY_DEV(d), addr, &val, len, MPQEMU_CMD_PCI_CFGWRITE);
 }
 
-static Property proxy_properties[] = {
+static const Property proxy_properties[] = {
     DEFINE_PROP_STRING("fd", PCIProxyDev, fd),
     DEFINE_PROP_END_OF_LIST(),
 };
-- 
2.43.0


