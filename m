Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F227C3ABAD
	for <qemu-devel@archiver.kernel.org>; Thu,  1 May 2025 22:36:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAcV9-0001mi-Ov; Thu, 01 May 2025 18:35:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uAcV8-0001mF-L3
 for qemu-devel@nongnu.org; Thu, 01 May 2025 18:35:30 -0400
Received: from mail-io1-xd32.google.com ([2607:f8b0:4864:20::d32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uAcV6-0002ry-UH
 for qemu-devel@nongnu.org; Thu, 01 May 2025 18:35:30 -0400
Received: by mail-io1-xd32.google.com with SMTP id
 ca18e2360f4ac-861b1f04b99so60016239f.0
 for <qemu-devel@nongnu.org>; Thu, 01 May 2025 15:35:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746138926; x=1746743726; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=qqNo+NwPcY+tsGEP3fOZ6p9U29CEuAKhE0bFNxDb6go=;
 b=B0Ahf8sVfkfEgRuBjnvncOU8yV6Zmxlm5bh96XExo7ZxDUW8byqtGZHLcUKzhEO2EA
 KToqE9RnbdvhMxJaSo6bAKW9eT5Ph/PG1CMkyvk6sw3qa2DUNBLQtfRZ0OpRjDtlsjye
 ZF2YL22efQ96UJ52BPN+goq73+qvyrqSvUYsfpfOvNBnAVaY2pEzfSWvGU8DSb2Q8FQh
 uyToazK+Lz4oS8JtdS+a9mfKj5k11Cru5F8LcDMfQ82S/iFyAILaBUFVDgzRYeZgW1/R
 0VgsVb3gaJZgnQG7wVhaOxBJXwSHzyMvdGUGDI0iWaFDJcefvAIU8Cdn5AxIhfR2Q66C
 lz0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746138926; x=1746743726;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qqNo+NwPcY+tsGEP3fOZ6p9U29CEuAKhE0bFNxDb6go=;
 b=Vrc9MBNnClJ9pRaOU331cAE8Ss4eex6NetaBRLRMRiwzI2OkJ0wUTZ+Taoq7/ms8PW
 wKTTJvzERlwzkuIcY3eqRFje2UJ6AsFqLe8K0narJHGV/suMIQKQTZaSyr8fGJYvWA+d
 AORIrkDAIRo6KdykbWNYWCYsik2IgzN43wdqaP2jx68ro4KoXZ3ohEuRMkgF2jmlFo13
 QRQFc1wZX51L+81xq1dubEm37nMprA0LgPz1lXs9Endu7qcXfZ2OkedG8S0GZX2JHad4
 PSAbSN46dee6TVYTVKmjMp0zyyuq9DLN4DZWQ8yax7kc1PPBBI01vrxe9y4WdfbgD7Jm
 xmkA==
X-Gm-Message-State: AOJu0YxdC/6YT9IZb+kGnAWePZelUVP+GMJB2ZzEGwtT+V+lIQ+2y7x2
 9Svf/0XNkDwpy8whl7OJC+KCK4tu5PNNfh0PMYLWS27d2MifJV3GJcphw0YL7btoxzaHfLFOTTw
 N
X-Gm-Gg: ASbGncu0YOz68Y3RwkfVYpBpNF+g2gcEgjLWBb9HbulmDP9hGCNzR6OHLZIf9NpPeVo
 BQ85GCtDZNtnurqK+mcHeHGqIRD8df3aRJZIGPFdtOct6a4/pUsWJ1hu6jxNcnhmJvpi6B5y2q1
 e4lGtx1BsA8zS7n394sYbW1to1zoQ7kP8uxJFc6aERhJ7DWCd53Tgb2w1gVn7ROm4jGAauzKYuH
 lTELPckfn7eoqHUs4lhCJEbg3COoiNb2A1tRz6StOL7oqYNn4kfYlv3koBz5Sa5o2+kt135/l4i
 QJtJrWjDmsQOtAc40NqBrdOwRawumO+a573ETVxkM2LL2GOFuLKoCLFhMpFeJW1AlaItOp77nWb
 IxUq5rOLV2oGJ4BNxeMt6
X-Google-Smtp-Source: AGHT+IGVEKLa17wNdq8JCWcitWO4ULnN9f3w1Nqz59l1wL80hKEgTZCp7Mej9BXaH5PKJ6BYRD95Qg==
X-Received: by 2002:a05:6602:36c5:b0:864:4a9b:f1f1 with SMTP id
 ca18e2360f4ac-866b441b229mr131998939f.14.1746138926585; 
 Thu, 01 May 2025 15:35:26 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4f88aa8d6b7sm78028173.118.2025.05.01.15.35.24
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 01 May 2025 15:35:26 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 0/8] hw/i386/pc: Remove deprecated 2.10,
 2.11 and 2.12 PC machines
Date: Fri,  2 May 2025 00:35:14 +0200
Message-ID: <20250501223522.99772-1-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::d32;
 envelope-from=philmd@linaro.org; helo=mail-io1-xd32.google.com
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

The versioned 'pc' and 'q35' machines up to 2.12 been marked
as deprecated two releases ago, and are older than 6 years,
so according to our support policy we can remove them.

This series includes the 2.10 to 2.12 machines removal.

Philippe Mathieu-Daudé (8):
  hw/i386/pc: Remove deprecated pc-q35-2.10 and pc-i440fx-2.10 machines
  hw/i386/pc: Remove pc_compat_2_10[] array
  hw/pci-host/i440fx: Remove I440FXState::pci_hole64_fix field
  hw/pci-host/q35: Remove Q35PCIHost::pci_hole64_fix field
  hw/i386/pc: Remove deprecated pc-q35-2.11 and pc-i440fx-2.11 machines
  hw/i386/pc: Remove pc_compat_2_11[] array
  hw/i386/pc: Remove deprecated pc-q35-2.12 and pc-i440fx-2.12 machines
  hw/i386/pc: Remove pc_compat_2_12[] array

 include/hw/i386/pc.h      |  9 ---------
 include/hw/pci-host/q35.h |  1 -
 hw/i386/pc.c              | 21 ---------------------
 hw/i386/pc_piix.c         | 28 ----------------------------
 hw/i386/pc_q35.c          | 29 -----------------------------
 hw/pci-host/i440fx.c      |  7 ++-----
 hw/pci-host/q35.c         |  6 ++----
 7 files changed, 4 insertions(+), 97 deletions(-)

-- 
2.47.1


