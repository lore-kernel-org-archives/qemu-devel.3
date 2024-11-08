Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39BD5D5E125
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2024 03:31:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t9Fhq-000064-L5; Thu, 07 Nov 2024 22:30:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tomoyuki.hirose@igel.co.jp>)
 id 1t9Fho-000055-2L
 for qemu-devel@nongnu.org; Thu, 07 Nov 2024 22:30:40 -0500
Received: from mail-ot1-x335.google.com ([2607:f8b0:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tomoyuki.hirose@igel.co.jp>)
 id 1t9Fhm-0001JV-Hz
 for qemu-devel@nongnu.org; Thu, 07 Nov 2024 22:30:39 -0500
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-7180f2f5fb0so1136840a34.1
 for <qemu-devel@nongnu.org>; Thu, 07 Nov 2024 19:30:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=igel-co-jp.20230601.gappssmtp.com; s=20230601; t=1731036634; x=1731641434;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YdDTOzE8Etes0rYL2f7MFCzF5u0h8F5dwae5lb252JU=;
 b=YMubqQ1y39AuCwtzlCbTGMxEwO6JHeShtvkXMwj1Weh6Yjcnj6yRJBd2tJhIo985LR
 Je6q7OVAkbmSfm+HuJPaxGP76x3eOXVuUcuNebUnoykbsJ/KxNp97uAVMJRGInOsIOfJ
 trYjCBGleBuxbUNEHe6gbQwOf9GuSWHtHjUfcrB/1pJxGsshzh/wRL1HhUUmqAVZ0W3H
 tlFrgVQsjlvRIPQl67oTo4Cpnpv6NRDkNPfI6SN/2Zrx4UocyceFHv2M+3lngC42sr6K
 7CNpJB/52TF8k75ybrLBS8CrQeEFaktUyD1tFOXu2Dyf3UVIFNS3zwmXWMsl4MaExbEs
 ahVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731036634; x=1731641434;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YdDTOzE8Etes0rYL2f7MFCzF5u0h8F5dwae5lb252JU=;
 b=JxHQobjRLonqyRJBUxn+vrFxIBp8w78WxKkWS/QEt+mdLcKzM65E3rJkpLHBhjKzrM
 3iLxnUXfePGptph0iSJ383elcNeR4zCuCA6ck9Qzx8ZjnJCtnjIgK09WIgihe3vCOvSD
 pzfM4CX8jFXFwQpxxpvFa91+NXxnoyMGRZGEyzc2ouap9CSnd0X1+1/51sQB5fimgaXO
 Llg89knGLQkTBV1yi+IvbMfsUPvitx9cr/ADTIZdS4+UbPsgV7BYr/0NCyJvf1PMJCeA
 woHgDi4IqAr3ewW5I97Bmcteny2xBKF1hOdxZOFPMx/GR305qglNb3aHqaXTOmLFeO5b
 OqKA==
X-Gm-Message-State: AOJu0Yzb5JFM1SIFCPWrxCZ/aJoc/QhLSlacGD9secdNmd6rtSr0g9GK
 IOt/6coih+dKtQGUAPWnwlFHceubrxXfbWDTWRfFuO5HQtm7IqwRscaIdhGiVDbea7AkvFRmSpI
 zxFw=
X-Google-Smtp-Source: AGHT+IEXu0s1GY0UffiljTFVCGJoqox2Xl6bnTZv3GnKuobp6H4w0dAo/HfduPYWhQcb6kU2n/iI4w==
X-Received: by 2002:a05:6830:40c1:b0:718:2eb7:4ebe with SMTP id
 46e09a7af769-71a1c28462cmr1871399a34.27.1731036634271; 
 Thu, 07 Nov 2024 19:30:34 -0800 (PST)
Received: from ThinkPad-T14-hirose.hq.igel.co.jp (napt.igel.co.jp.
 [219.106.231.132]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7f41f65d358sm2326435a12.84.2024.11.07.19.30.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Nov 2024 19:30:33 -0800 (PST)
From: Tomoyuki HIROSE <tomoyuki.hirose@igel.co.jp>
To: qemu-devel@nongnu.org
Cc: Tomoyuki HIROSE <tomoyuki.hirose@igel.co.jp>
Subject: [RFC PATCH 5/5] hw/usb/hcd-xhci: allow unaligned access to Capability
 Registers
Date: Fri,  8 Nov 2024 12:29:49 +0900
Message-ID: <20241108032952.56692-6-tomoyuki.hirose@igel.co.jp>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241108032952.56692-1-tomoyuki.hirose@igel.co.jp>
References: <20241108032952.56692-1-tomoyuki.hirose@igel.co.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::335;
 envelope-from=tomoyuki.hirose@igel.co.jp; helo=mail-ot1-x335.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

According to xHCI spec rev 1.2, unaligned access to xHCI Host
Controller Capability Registers is not prohibited. In addition, the
limit of access size is also unspecified. Actually, some real devices
allow unaligned access and 8-byte access to these registers.

This commit makes it possible to unaligned access and 8-byte access to
Host Controller Capability Registers.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/143
Signed-off-by: Tomoyuki HIROSE <tomoyuki.hirose@igel.co.jp>
---
 hw/usb/hcd-xhci.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/hw/usb/hcd-xhci.c b/hw/usb/hcd-xhci.c
index d85adaca0d..f35cbe526f 100644
--- a/hw/usb/hcd-xhci.c
+++ b/hw/usb/hcd-xhci.c
@@ -3165,9 +3165,11 @@ static const MemoryRegionOps xhci_cap_ops = {
     .read = xhci_cap_read,
     .write = xhci_cap_write,
     .valid.min_access_size = 1,
-    .valid.max_access_size = 4,
+    .valid.max_access_size = 8,
+    .valid.unaligned = true,
     .impl.min_access_size = 4,
     .impl.max_access_size = 4,
+    .impl.unaligned = false,
     .endianness = DEVICE_LITTLE_ENDIAN,
 };
 
-- 
2.43.0


