Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5C1CE7718A
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2024 16:33:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOJFZ-0001nw-1p; Thu, 19 Dec 2024 11:19:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tOIcp-0004pZ-5Z
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 10:39:43 -0500
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tOIcn-0004X8-Is
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 10:39:42 -0500
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-385deda28b3so664779f8f.0
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2024 07:39:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734622780; x=1735227580; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=W5xIB6Q3xpywMwriwl34zxXU4p+OU3fl2Ms6nSvvP3g=;
 b=IF0sZ6imUo0Nt32KEIsnrsr2lESHBCWmAsxIV35rEbfrceUSyspSG1EZ3M0dzc4k4D
 yBo1AxEy/NvVjrNNOSPj8bqGFuc9EDMIBS6VZsFEphCbMZdbZNY16zpa2g9JJfRMTEMY
 742kYi+dypjb32BY0NIJemHhJ6+BSrCQwVypGl7qM9vXYrmYWmLYDexEoV7DRiDwyjYp
 hsaYHFXks0ABcpDjuLTq7G8nNFgNQRejEkIwyNrvNBITNcfSlYEckCWTyiR4M355ln1z
 oWPP1v82GcXNT004Zs+KQzJFfga2UEAjnMdG8gLrOFiTfLSLo+CSlAYalGTpRzCNVLIy
 +yzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734622780; x=1735227580;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=W5xIB6Q3xpywMwriwl34zxXU4p+OU3fl2Ms6nSvvP3g=;
 b=kqznLITWAKWEf0ObBi+jOniOECPi/JNMg6N071PBiA9jMEF8px52PR2Kch/BlmPy1O
 DCZsA2VwJZDuEKwn2Uiq4LViacWIsRnSlxAtpTG45p6T73erhI4mhdS8zcNAPRBuRI6F
 ugx/gP91UGB8DSesu+pm/F79NiJkw5MCyu8v/+C5jvHsAcFT0+nFfQzMWBcg6SjPBja3
 Y84jwIgPeq2EfM+iedizA57UkX9s9sByuDhQ6con1fpW63a3/ZUr7UzuaEM1zcKEjW6o
 oxlJ6uQLTkpYzJa94mE4MVm5CCgcQ3nLayANQ70xJgo/k2/hB5YVjLMG3FleRjSdTHz2
 bEag==
X-Gm-Message-State: AOJu0YyBAPgF98uPPRPC+yvyx+Pcpf/nTtVEfiOGOEmegrtYxkHjaz32
 slRo04JK1DbnOvM7XFlbtpAf3s5fvZP7jHYQxbBdPu/Sdp3h2HEJPbxZ9wBIBOh4LXrwJX6WziB
 d
X-Gm-Gg: ASbGncuCQ7W2fCp/3YbWjxOVXyFhLQoMrDLahnAy32PuK98y+S9E0Q9LOKHxR0sXIsx
 1uRfiC4J9bn2ibcu6zoqYrJJ4zIRCZJMOUvpoY/3XgK3PAcI0KjEiPqmpbsFsv4+/bRwv4RDwkW
 G9e64L9KDx56rYza0esjD1/Y4m6Iw0tbCZhjf3t6Poq4aT2fIRR99unuCcc7pSLnGs4JZuyL8/R
 0qP8mXQ3IEhJN5r1JYJ9IlCSv0m/W6WiPsNl8pQ/AttrXAtdD/44gM5WZjWC7KExm0M38z9n+/U
 zrIV
X-Google-Smtp-Source: AGHT+IGv5rd7ZLJrA7Ng7P1DhJdT3DlR3L1JZzaGzslknhJylDOfRM57TjnrYcXF/hgefogMGL1mfw==
X-Received: by 2002:a5d:47cf:0:b0:385:d852:29ed with SMTP id
 ffacd0b85a97d-388e4d8e083mr6933410f8f.36.1734622779863; 
 Thu, 19 Dec 2024 07:39:39 -0800 (PST)
Received: from localhost.localdomain ([78.196.4.158])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43656b4274csm55636845e9.38.2024.12.19.07.39.38
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 19 Dec 2024 07:39:39 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Ani Sinha <anisinha@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 devel@lists.libvirt.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [RFC PATCH 07/10] hw/misc/vmcoreinfo: Factor
 vmcoreinfo_device_realize() out
Date: Thu, 19 Dec 2024 16:38:54 +0100
Message-ID: <20241219153857.57450-8-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241219153857.57450-1-philmd@linaro.org>
References: <20241219153857.57450-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42e.google.com
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

In preparation of implementing a UserCreatable callback
in the next commit, factor vmcoreinfo_device_realize() out.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/misc/vmcoreinfo.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/hw/misc/vmcoreinfo.c b/hw/misc/vmcoreinfo.c
index 55f9d437a94..a0511ea0da4 100644
--- a/hw/misc/vmcoreinfo.c
+++ b/hw/misc/vmcoreinfo.c
@@ -49,9 +49,8 @@ static void vmcoreinfo_reset_hold(Object *obj, ResetType type)
     s->vmcoreinfo.host_format = cpu_to_le16(FW_CFG_VMCOREINFO_FORMAT_ELF);
 }
 
-static void vmcoreinfo_realize(DeviceState *dev, Error **errp)
+static void vmcoreinfo_realize(VMCoreInfoState *s, Error **errp)
 {
-    VMCoreInfoState *s = VMCOREINFO_DEVICE(dev);
     FWCfgState *fw_cfg = fw_cfg_find();
     /* for gdb script dump-guest-memory.py */
     static VMCoreInfoState * volatile vmcoreinfo_state G_GNUC_UNUSED;
@@ -84,13 +83,18 @@ static void vmcoreinfo_realize(DeviceState *dev, Error **errp)
     vmcoreinfo_state = s;
 }
 
+static void vmcoreinfo_device_realize(DeviceState *dev, Error **errp)
+{
+    vmcoreinfo_realize(VMCOREINFO_DEVICE(dev), errp);
+}
+
 static void vmcoreinfo_device_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     ResettableClass *rc = RESETTABLE_CLASS(klass);
 
     dc->vmsd = &vmstate_vmcoreinfo;
-    dc->realize = vmcoreinfo_realize;
+    dc->realize = vmcoreinfo_device_realize;
     dc->hotpluggable = false;
     set_bit(DEVICE_CATEGORY_MISC, dc->categories);
     rc->phases.hold = vmcoreinfo_reset_hold;
-- 
2.47.1


