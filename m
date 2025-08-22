Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAAA6CA0EED
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Aug 2025 13:57:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1upSDY-0005zD-7k; Fri, 22 Aug 2025 09:54:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cjchen@igel.co.jp>) id 1upO1s-0005yT-H8
 for qemu-devel@nongnu.org; Fri, 22 Aug 2025 05:25:49 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <cjchen@igel.co.jp>) id 1upO1m-0007FE-Da
 for qemu-devel@nongnu.org; Fri, 22 Aug 2025 05:25:45 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-2445806d44fso15713685ad.1
 for <qemu-devel@nongnu.org>; Fri, 22 Aug 2025 02:25:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=igel-co-jp.20230601.gappssmtp.com; s=20230601; t=1755854740; x=1756459540;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zXgebig47wIeXfp8dqO8PzqCbna3KM2O0dfho6ysf2U=;
 b=s/Cgb1xvvuIYGLC7pCYhMY1IUYSqPoaLPxBvg4u4rNHfKsRQKbiANocmZSTH9+78Xe
 b6GkLk6qgRgPSRstzJstnsCaniqmPZuu8C7uyh6Cbick9HorvmEu5H0GqvsxWx71BVVf
 R6/Nu94ZLOmcaptn1S3+pRScE+FGCjLiAl638PKqe5KS1ZCkjWSImLNnQeP4luk/hvXb
 ESo0JPJ2HtDkmwBMkjXPCfZ4bVbRKYEzQuNbHsZfbSlnnXBYmKmjmEVCKFuoXOH0E3/+
 n9FdAPAFsqVDJ4/x+LWLfT+ENb0458VJ76PqAwFXa+iO+dvwMDeeYI2cb6jR3CX2fM1O
 /JLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755854740; x=1756459540;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zXgebig47wIeXfp8dqO8PzqCbna3KM2O0dfho6ysf2U=;
 b=EouyKHItNkW9Hg6jmSeilyrKeZ0oR3+/HNMIvsTGhFPCgnjL4CY8aC5I0GoUR4nWDU
 HAj0d+24Y/dj0s9V12YlpO1uURS0EoxvG6LYPr5WByJdsNQvzyHwZTihC6yQ3wUQXnN6
 HnyweIb2vqaZtvXThY3q6Rx4mu0YwJvL88szWZuERKhNyIYlX8cO0nshWL9RWG4ntVfx
 zk+6o4KXXgYCO/A45bJ4NzK7iHbK9wx1jIPvMP7Wg4Ge7D6sVBs5ARxtxIcVK+GRl3Sk
 PK+m1uwhfpjQb5/qiJeW3ZWxTeZ8iN3sewos+lHrRX9/2FXAzxZtimvJyDqxyEQvBMur
 HxIQ==
X-Gm-Message-State: AOJu0YyqoIDXkeLmbF8VVfzvYzLroO/imiCwpmlLu/+UCVhRrk+IrEWh
 pTEyenLBPz+3mKZ9lZLxu7oSbN3u5QW6GWtsjo/ARh86s1JknNFPzCy04Yeb+FKKfcLbPgHCwCp
 3T5MZ8Sk=
X-Gm-Gg: ASbGncuItaI/m++IOt1WqHJnw6ORv3jJU3RZXSHVwb+O9jfpi7QxVs5dwUeoKbMFU74
 VPniJR4D2cF78z5AsQcnSTMSyYFhWQIKOa4RPcUH4OTFF968gTd892pf7XEVgKAGxF5xA+kzfVL
 vDoZwCaLQmVHULMPjGb2hA3DpAg9aS8hqG6BJVfPCROIZRTZGvDR1BtjU0Q/bzzjYD9Q+SdPdMf
 Op+HGjui3IMZTOjDDww6UvrZTyAUPtsIext1UX8mjHfN2opYgWVgi5Ejnh19Z2wB433X0aT2X6N
 n6duJIByL5VdS5NsPYUXpMtW7mOpwQires5dN4TdWO0S6j/18jNqBl1TaqLxMswkmrQABP4xg8R
 Dn3F9XX5DDOjppKKnamHnpreJ8gzG3namX2OenoZdSw==
X-Google-Smtp-Source: AGHT+IH8pYTJbnXf7rKnNIsoHQG2QKG2X9mf+U2mWDZhwdN/zTCzSXTLAS1lHezYzzhePUW/JC2CJA==
X-Received: by 2002:a17:902:f70c:b0:246:1c53:6739 with SMTP id
 d9443c01a7336-2462edfad58mr35900195ad.21.1755854740220; 
 Fri, 22 Aug 2025 02:25:40 -0700 (PDT)
Received: from warg.hq.igel.co.jp (napt.igel.co.jp. [219.106.231.132])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-245ed4c6fb7sm78560215ad.89.2025.08.22.02.25.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Aug 2025 02:25:39 -0700 (PDT)
From: CJ Chen <cjchen@igel.co.jp>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org, qemu-riscv@nongnu.org,
 qemu-arm@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Keith Busch <kbusch@kernel.org>,
 Klaus Jensen <its@irrelevant.dk>, Jesper Devantier <foss@defmacro.it>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Tyrone Ting <kfting@nuvoton.com>, Hao Wu <wuhaotsh@google.com>,
 Max Filippov <jcmvbkbc@gmail.com>, Peter Xu <peterx@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Tomoyuki Hirose <hrstmyk811m@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>, CJ Chen <cjchen@igel.co.jp>
Subject: [RFC PATCH v2 6/9] hw/usb/hcd-xhci: allow unaligned access to
 Capability Registers
Date: Fri, 22 Aug 2025 18:24:07 +0900
Message-Id: <20250822092410.25833-7-cjchen@igel.co.jp>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250822092410.25833-1-cjchen@igel.co.jp>
References: <20250822092410.25833-1-cjchen@igel.co.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=cjchen@igel.co.jp; helo=mail-pl1-x62f.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 22 Aug 2025 09:53:58 -0400
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

From: Tomoyuki Hirose <hrstmyk811m@gmail.com>

According to xHCI spec rev 1.2, unaligned access to xHCI Host
Controller Capability Registers is not prohibited. In addition, the
limit of access size is also unspecified. Actually, some real devices
allow unaligned access and 8-byte access to these registers.

This commit makes it possible to unaligned access and 8-byte access to
Host Controller Capability Registers.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/143

Based-on-a-patch-by: Tomoyuki Hirose <hrstmyk811m@gmail.com>
Signed-off-by: CJ Chen <cjchen@igel.co.jp>
Tested-by: CJ Chen <cjchen@igel.co.jp>
Reported-by: Tomoyuki Hirose <hrstmyk811m@gmail.com>
---
 hw/usb/hcd-xhci.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/hw/usb/hcd-xhci.c b/hw/usb/hcd-xhci.c
index 292c378bfc..81e91e6ffb 100644
--- a/hw/usb/hcd-xhci.c
+++ b/hw/usb/hcd-xhci.c
@@ -3190,9 +3190,11 @@ static const MemoryRegionOps xhci_cap_ops = {
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
2.25.1


