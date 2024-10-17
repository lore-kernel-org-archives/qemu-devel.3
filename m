Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 664F7D2F7F4
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2024 06:43:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t1KE8-0001gE-3J; Thu, 17 Oct 2024 02:43:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1t1KE5-0001fF-Ey
 for qemu-devel@nongnu.org; Thu, 17 Oct 2024 02:43:13 -0400
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1t1KE3-0005F4-M6
 for qemu-devel@nongnu.org; Thu, 17 Oct 2024 02:43:13 -0400
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-2e2bd347124so428210a91.1
 for <qemu-devel@nongnu.org>; Wed, 16 Oct 2024 23:43:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1729147390; x=1729752190;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=T6S1/+0v2iIFTN9IgGH3Oc8MyncjueTnrzbQJcQEhw8=;
 b=doI/06lQliCs4Vk34jLYvocAnAipMTopoQ1pltv4w5HKiiUU/LiUev8JyMWuAjAPAx
 AsEiui3jTRssBRnKD7idWDtOPd4j03/HWXp5EBMPU/heRGzVinY0abYzbVFEIPlORSSW
 EHkkGk2oJiwjGz2rMrr2OWJPPYONEkndwyqcg0eljVTID52PtvkloRKbvyH/marQNNQ1
 12bTrXZUJAVk+9vomykjL5mhOMb4zC9xqXyyU6Avd9vJ0KudBCmIPL5rw1Ks1w8JAGCE
 1yE33v89lDlR0nxoRP/xHehACQ0ukEWvPssa9Y8C4XpGOKBz4mxARqVf49fI8Gim1TAC
 /MSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729147390; x=1729752190;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=T6S1/+0v2iIFTN9IgGH3Oc8MyncjueTnrzbQJcQEhw8=;
 b=jAgjk0FE561FnGxeyy0KkVGdE+EtXGfkETzYwTaqbOktnaheJGETklZlAEGQgh55xr
 MoNWyjEl/AENcSKffrT9bXpw/4XdElOVvpk34dtfOmN7ZMbatRMFl6K4TiBAtTnLUVMO
 8+2ekZHo9LVcGWwRrPlLJOcCzBPjabUPzcVpVpj8nO5v2ID+wMeDhVgNYFZv9fBffwXh
 nrStsRfEnaMz9wJrKbFUToKfAfS0Viz/9ZqNwUDc7IIH5ihp7Euv2ZwBtwnW3ScJZPM0
 8JIRQLCGAl/EW/8WVI64jG87Jb8pU3sNX86MCQ5JZ7QHvlMRcrDQza7kLsRETdWW1UHQ
 kvVQ==
X-Gm-Message-State: AOJu0YyDJBpZ26o/+ySk4RnuJGzrFZOZIWHkA9IQ+DaGUVGC0nO+8mqg
 9wbmRffzm/MDdE0Z83CtYcdevFLQs5FsXY8ivzNJI9jF896Wap2LOzVEsr37GDMdjqAur+SkJ6r
 pJDhTkg==
X-Google-Smtp-Source: AGHT+IHlcjSGqarS+g1bhBvZ+/5z18UzVO8XJTedPcuZrk2rXbJ2yPGb6Ke6AXkQXWyOH6X/CTjG1Q==
X-Received: by 2002:a17:90b:4c8c:b0:2e2:c66f:5527 with SMTP id
 98e67ed59e1d1-2e3ab8bcf91mr7405582a91.29.1729147389467; 
 Wed, 16 Oct 2024 23:43:09 -0700 (PDT)
Received: from Hyman-Dev-Euler.zelin.local ([85.208.104.155])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2e3e08eba12sm1044372a91.29.2024.10.16.23.43.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Oct 2024 23:43:09 -0700 (PDT)
From: yong.huang@smartx.com
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, yong.huang@smartx.com
Subject: [PATCH v4 1/6] accel/tcg/icount-common: Remove the reference to the
 unused header file
Date: Thu, 17 Oct 2024 14:42:50 +0800
Message-Id: <5e33b423d0b8506e5cb33fff42b50aa301b7731b.1729146786.git.yong.huang@smartx.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1729146786.git.yong.huang@smartx.com>
References: <cover.1729146786.git.yong.huang@smartx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1030;
 envelope-from=yong.huang@smartx.com; helo=mail-pj1-x1030.google.com
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

From: Hyman Huang <yong.huang@smartx.com>

Signed-off-by: Hyman Huang <yong.huang@smartx.com>
---
 accel/tcg/icount-common.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/accel/tcg/icount-common.c b/accel/tcg/icount-common.c
index 8d3d3a7e9d..30bf8500dc 100644
--- a/accel/tcg/icount-common.c
+++ b/accel/tcg/icount-common.c
@@ -36,7 +36,6 @@
 #include "sysemu/runstate.h"
 #include "hw/core/cpu.h"
 #include "sysemu/cpu-timers.h"
-#include "sysemu/cpu-throttle.h"
 #include "sysemu/cpu-timers-internal.h"
 
 /*
-- 
2.27.0


