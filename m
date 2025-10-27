Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07DE8CCF9E5
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Oct 2025 12:39:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDMTK-0005cY-V6; Mon, 27 Oct 2025 08:37:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vDMTH-0005X4-Vi
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 08:37:12 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vDMTC-0006HN-IU
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 08:37:11 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-4283be7df63so2190179f8f.1
 for <qemu-devel@nongnu.org>; Mon, 27 Oct 2025 05:37:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761568618; x=1762173418; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jRIl7x0MizgYPc3G/UF39YlinV+2/KH7EhfIDyLaI94=;
 b=TPt3jIuPWhrmjsGQaqQND6pFRKzBwNkyIZr1OQ2TF78hbm2dsJfARCyhPXgbWkPUKg
 CWJhF8jhQkMxZjV8uJBMq8EKfYH68U0rtyW8OiLCgRQjvOba1tcnRCl47Y9rkZzod2K8
 4KqH2nDe2ofttf8PJvzOJenw4e0PXS43Jb57aF125hPZfN/T50TTK7JD7unLDIuPMppd
 sudwi3tUpCTqu/N1qnXxcg850AFDrAVvOCYYXRghFCZb8KarKe91bIp0nMpylT2RZaTl
 KazRdD6hABfGxqpSHFQAMUYa/lNlxOAOYugHKFwkq3LYBtndeb3uphR6TIghYfmnQ9Xy
 MCKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761568618; x=1762173418;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jRIl7x0MizgYPc3G/UF39YlinV+2/KH7EhfIDyLaI94=;
 b=YbYz9zecHE0ge+Tk75/I4NNIY8G2ZPQGEjA13a/tAgYYp4qFnSNRJLHkLylDMfXQ5W
 Miw4AkodSUpgca/4O8rzkdfbXxhxRIOxHZmqO54mmrKN8RLBgSxZy/0DHLT0hBFFqMn7
 Yt5fVocabhGO3UQOmtxwc811X9TEuCuDR/CXyEDxhjclADBXg5LzKeTe5iOISzQpndAg
 PijqDUwgf7nA8Bzpn7aZrVeZWRITLrKxDlcpmow8me9aH7JTHJ2CSm+bCLqbTtZxEFIT
 NjgwmeCFYQJA0D0EnlO/W3OMnqGCsI+/JELzoGbgxhx8Se6XckqG5xzw0jWHzpZ+/b6c
 RPIg==
X-Gm-Message-State: AOJu0YwHMWahP9plyYQsSX0brYlcwONgqLTv2Q9IDd41MX/HXN77e9Mf
 CzZuLNVbennSF+KAB/YR0WpeaLugyMQd8cpMxUPoDCCNj8wu438/xpv9yjFY783sHa+s6cBnXxl
 QYZkbJ5w=
X-Gm-Gg: ASbGncucj1/7kV/sBDvowFMHDhwiAcXCrU5XpYVi8DKHbQMmcrVnXXGFHiZN+j1Pop9
 P78+9qNffNmAW7kdQi0dr5efvKMGLN8LMtCwuKpE0ONkV4YG0UT4p7ABOqjpObALRLmjFdni4Lz
 SWoybmLvFuWmLjT1Mto+BYcitU7nMLdptLRNCttcjVzjCd0MwqrFKlYqiNABpnYNVTahbCZJC32
 fCeACfLfO8Xy+D9rKXLWYa7v8R9elcnnprCOmqNOCaD06eLIYL21E3wI219kjxfV7byP5LVhU/6
 GXELleyXDE2SAASYn/M01MbdPo4Befm36c+CQEeWv/jQYAdmWmjwUr/NShy2AaEiXV06rHaoJlP
 aAmGRQlfcFuydS2hDFfb0ey/qx2T9JPCgIKcq2vKVICjpuiPmZjQGzyto+yAt6ClyvgSHJiwkd9
 KDFX3gqD964aOyAJs2WAh1jQW07mX1LDWDLTd9sChpJt68VAtRIw==
X-Google-Smtp-Source: AGHT+IH2Prbndh0uvJjKiUoU3UPX0rGxgzHyo/VdREMmAAmrTo4WaM2iyFDJwTPOS30C5zYMyDFNbw==
X-Received: by 2002:a05:6000:4610:b0:429:66bf:1475 with SMTP id
 ffacd0b85a97d-42966bf1732mr10802747f8f.3.1761568618346; 
 Mon, 27 Oct 2025 05:36:58 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429952df62dsm15181023f8f.45.2025.10.27.05.36.56
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 27 Oct 2025 05:36:57 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Joel Stanley <joel@jms.id.au>, qemu-arm@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 David Hildenbrand <david@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Troy Lee <leetroy@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Helge Deller <deller@gmx.de>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Peter Xu <peterx@redhat.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Jamin Lin <jamin_lin@aspeedtech.com>
Subject: [PATCH 1/6] system/memory: Expose unassigned_mem_ops symbol
Date: Mon, 27 Oct 2025 13:36:38 +0100
Message-ID: <20251027123644.63487-2-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251027123644.63487-1-philmd@linaro.org>
References: <20251027123644.63487-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x432.google.com
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

To log unassigned I/O region accesses, we provide unassigned_io_ops,
exposed in "system/ioport.h". Similarly, expose unassigned_mem_ops
in "system/memory.h" to be able to log accesses to unassigned MMIO.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/system/memory.h  | 2 ++
 system/memory-internal.h | 2 --
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/system/memory.h b/include/system/memory.h
index 3bd5ffa5e0d..f42c6ba31c8 100644
--- a/include/system/memory.h
+++ b/include/system/memory.h
@@ -2714,6 +2714,8 @@ MemTxResult memory_region_dispatch_write(MemoryRegion *mr,
                                          MemOp op,
                                          MemTxAttrs attrs);
 
+extern const MemoryRegionOps unassigned_mem_ops;
+
 /**
  * address_space_init: initializes an address space
  *
diff --git a/system/memory-internal.h b/system/memory-internal.h
index 46f758fa7e4..5588ae35081 100644
--- a/system/memory-internal.h
+++ b/system/memory-internal.h
@@ -28,8 +28,6 @@ static inline AddressSpaceDispatch *address_space_to_dispatch(AddressSpace *as)
 FlatView *address_space_get_flatview(AddressSpace *as);
 void flatview_unref(FlatView *view);
 
-extern const MemoryRegionOps unassigned_mem_ops;
-
 void flatview_add_to_dispatch(FlatView *fv, MemoryRegionSection *section);
 AddressSpaceDispatch *address_space_dispatch_new(FlatView *fv);
 void address_space_dispatch_compact(AddressSpaceDispatch *d);
-- 
2.51.0


