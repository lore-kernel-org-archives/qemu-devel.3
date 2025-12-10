Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF743D3E76E
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Dec 2025 18:38:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vTP3o-00011u-CW; Wed, 10 Dec 2025 13:37:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vTP3m-0000zb-4X
 for qemu-devel@nongnu.org; Wed, 10 Dec 2025 13:37:10 -0500
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vTP3k-0002Qc-HV
 for qemu-devel@nongnu.org; Wed, 10 Dec 2025 13:37:09 -0500
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-42e2d44c727so30455f8f.0
 for <qemu-devel@nongnu.org>; Wed, 10 Dec 2025 10:37:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1765391827; x=1765996627; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Mz5t4JBtFZ7Mb0qu6rwAgOyZr0gZygWWn60jyz5mSJk=;
 b=MunvsppJwIyRE6vl/L+UWzZ4iFJDtFW4DVqhLqEMvZXqBc8KKSeU6qX+ipeoYho2VA
 Ge/cS0/ZnzQvSdTCtidCZndEftYqiY3J/jq3aJl605UWkrqenHa70459xSXfFDMF3bRU
 c4IkGXQTYnsKf3RsQHuY8CREZTSQvMHhaH4aEntERBXPkIV7iPLGYUOrwLLdOK6+Bwys
 wPBxcHA8j0ywKy0bS0stuXRgpMTBE2UEofKk8jbqStUH7xORLiIaxO8PYNsO4lZgvF+f
 w0IJ8/zkGYyy3Exc8fKbiCPov9Apd5ugnvGmvOx4EOjsmmK+yekviFXxuGYK720jBfR7
 BHDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765391827; x=1765996627;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Mz5t4JBtFZ7Mb0qu6rwAgOyZr0gZygWWn60jyz5mSJk=;
 b=COkqdLWvZ0Hg9ptd+wn9cnNPNUkypRjAE3RyZ93iDWcMcYqv93AZAKtG1w+z2AOzeo
 6dPgUUdxffZ/YbXt+v1JiJj4h5qJKD2KmT3X6FD5nZBmTXEAQ/3Ql8cp2OAnp6t/Zg7k
 9CIKvC4+X29RI03TGGU4f4IRRoKwma5D+wD3pzsVreod8/FSKftHWXTB2MYa9s+LeIn2
 yxXnOR4UgBXZCL7D2aj66zr0EczXtbm/B8/imxlFZkx+0kdnJI7GzkRjSkFba9tjsLVG
 tFGQa7feSMONh0BfdA2JRByRrrhoE+NFqckKH0OZ+NJ5GH1254UQbjXnj1PP0i6Iztfp
 qDEQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU34qCjx5f0SgezGU5IT9ftbySJImQGTPfgdB05md2x+ew1p3lsSEJBUPz68xLtWabhypsISgxqDZjj@nongnu.org
X-Gm-Message-State: AOJu0YwI6K2ekEyLmbXxsyhAcJe0XJL0A3DjIyCRqW8cBdo1z3mEGLTB
 zJOXp0ywEfSXbtX1vAag1U66cS2+a1dasOdwJBdlSbrSEKID/GTtAO03n8gJrXeL4us=
X-Gm-Gg: AY/fxX7V/MALX1AEecohE7qdp5972JChlCv44w3S4tH+ZYME2n18mvM3zv6wwouSXPk
 jktaByKGdV+6ETGBCbEPEnL6e5M9KErSnuIlZFSVBUxjwHpPTXkT/K5PSLS8fDPkKxIv2psZPKy
 oPHaEDSa2EN+oyz2UuU3Y0gEFyBxupMNYSM1eC1Ik2tKMoHhd7iVbF/AV2GdDBduvL9Gr/y5Mci
 YusxoetloJ1u1dcGb9n5SDuGcVSEe9LH7VDugDhuCkIXGBRDlPBDYILCok3Oy3XSDC+WzddiVYP
 r1UV5Ka2rTULdJWBgIzAZ7i2PsjDekW4SaqZGpaJ+Tj6yysRbYJ2QMiZWM4SeOBoy5VSUzt6Pf4
 W/mYbb8VrFMVNQ1hK0Aowhq7nFsEQ+mtf9HSZwWm4mwj8aGNqDXME9fZhsY/5yACts9kO4xUjh3
 IHQ00a41hud7j4FxlR
X-Google-Smtp-Source: AGHT+IGhiR1s9trv79NqmlvNx0Ov0ZH6YpiNOfaeWDYN7GVVmzUVnMC6WtLMYmn5qDF8fw4GdtgoUA==
X-Received: by 2002:a05:6000:402b:b0:42b:3c3e:5d2f with SMTP id
 ffacd0b85a97d-42fa3b0fb55mr3769802f8f.39.1765391826733; 
 Wed, 10 Dec 2025 10:37:06 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42fa8a7044csm477702f8f.15.2025.12.10.10.37.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Dec 2025 10:37:05 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH for-11.0 3/7] hw/gpio/omap_gpio: Remove omap_badwidth_* calls
Date: Wed, 10 Dec 2025 18:36:56 +0000
Message-ID: <20251210183700.3446237-4-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251210183700.3446237-1-peter.maydell@linaro.org>
References: <20251210183700.3446237-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x431.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

The omap_badwidth_read* and omap_badwidth_write* functions are
used by various OMAP devices when the guest makes an access
to registers with an invalid width; they do two things:
 - log a GUEST_ERROR for the access
 - call cpu_physical_memory_read() or cpu_physical_memory_write()
   with the offset they are passed in

The first of these produces an unhelpful log message because the
function name that is printed is that of the omap-badwidth_*
function, not that of the read or write function of the device that
called it; this means you can't tell what device is involved.

The second is wrong because the offset is an offset into the device
but we use it as an absolute physical address, so we will access
whatever is at low memory.  That happens to be the boot ROM, so we
will ignore a write and return random garbage on a read.  This bug
has been present since 2011, when we did the conversions to the
MemoryRegion APIs, which involved changing all devices from working
with absolute physical addresses to working with offsets within their
MemoryRegions.  We must have missed updating these functions.

Replace the uses of these functions in omap_gpio.c with an
open-coded call to qemu_log_mask() and RAZ/WI behaviour.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/gpio/omap_gpio.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/hw/gpio/omap_gpio.c b/hw/gpio/omap_gpio.c
index f27806b774a..170c8d1ab53 100644
--- a/hw/gpio/omap_gpio.c
+++ b/hw/gpio/omap_gpio.c
@@ -76,7 +76,9 @@ static uint64_t omap_gpio_read(void *opaque, hwaddr addr,
     int offset = addr & OMAP_MPUI_REG_MASK;
 
     if (size != 2) {
-        return omap_badwidth_read16(opaque, addr);
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: read at offset 0x%" HWADDR_PRIx
+                      " with bad width %d\n", __func__, addr, size);
+        return 0;
     }
 
     switch (offset) {
@@ -116,7 +118,8 @@ static void omap_gpio_write(void *opaque, hwaddr addr,
     int ln;
 
     if (size != 2) {
-        omap_badwidth_write16(opaque, addr, value);
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: write at offset 0x%" HWADDR_PRIx
+                      " with bad width %d\n", __func__, addr, size);
         return;
     }
 
-- 
2.43.0


