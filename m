Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2853ACCA470
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Oct 2025 08:24:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3s5z-0000VU-LX; Wed, 01 Oct 2025 04:21:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v3s5x-0000V0-3R
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 04:21:53 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v3s5l-0005Gb-El
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 04:21:51 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-46e48d6b95fso42881035e9.3
 for <qemu-devel@nongnu.org>; Wed, 01 Oct 2025 01:21:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759306895; x=1759911695; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9FXrBC5DT5H2U+KHBH/fTo7fOpyh9XDm8ZSBZ4mpCC0=;
 b=a497poM6mPsCiYfvZOZH5Fcel/pZkYzjndJ7R7r9AvL0YXwUuCivkWoAm40qZWgGL2
 q57Dh9cPzSDle/1ijZYSuMhCLRvYb2WZ2B6P3clbUD2yCfXMQh1G2ynE8m7/0cjzLyNy
 aJBjJ55LrM3XfUopXmtTFjATLb4GZ+sJiKRYecWthvwn4LdYpFDiDiJKCl3aYKL67e2X
 C2il9VHR0rw14Gd3f3usfmoG9Tzl5VXnIMvIqzXeCZcsiGHXUJ3Eho1BT/fcaUU3hjDP
 o8TuB44FvpeEx3eEL+ee2OcntJ6bVlVVQ9+7rrptpZ1h68C0DJOEAADCVxYmSVcM1jj6
 X1Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759306895; x=1759911695;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9FXrBC5DT5H2U+KHBH/fTo7fOpyh9XDm8ZSBZ4mpCC0=;
 b=S8BYVqGdJU2vR3jm0UzcAiw2l5TYwMAdDxjV73nzCXHiAdMCTUCKjXyrlYU1pzXqG2
 FAfaBn/IIGkKPEruoVvhIwXuAJaJZClvVAA0L1dVOlJzFSahub2fcu0gDk+ddEKHAT+P
 tePsoAf1eNBvFwNr2FdaqCYrS1ouayiDld9EINOtodz3pddrDoycrLA1kXKE4OQykMjK
 KPyfsb1EueYf0hPg3ptd22KY834H5LLiRTXlEflbajyUa2u8g6Mld+EANm9goyADnjZj
 miueY1Wo0K36u4ZZ4qK77Ilf8pUDGq3xU/3UQQmWWLoiLJQ1Ozhz0s+fk3eJii9rWHND
 1oSA==
X-Gm-Message-State: AOJu0YyP49MHpKeRn9cL79mC3iYR2PfZBvgjzrZGO065+edsnMvbkLlX
 ZOoir3Cb4j5GNZgnD0qM1rATYRS/J77UhAcXG0h9yW14wBKgmFHGPBPX1xEQ/3gBNzWKPU5WSWZ
 J82TEN/OKBg==
X-Gm-Gg: ASbGnctjLUC3c2anMGhmCrnMTrir61yqdliYT17X+gNAYh6GRKRwgvjRfJ6nC9EE0lO
 1F74243VbvP2iQCvnknvCVVS8nqTPNDnNjxxZn1ktUkEJIgaQI/QaybtdRIhw21DcKcxBHUqYqN
 p08D6t2ez3SQqc34RMiRuku2mUAvOb3biOWkKt28B1sh9r+kKGwLIXaYoUq/lGtM28G9j35itse
 FKmbEuX2RjLFu1/PwTbgW9pjRT2sacoItZks9pnIFbggwON8jH9UIGYmeuwBrR64ZjNwsamug1F
 iDmSEF0pyLhb94ONTO0LyrLGRg8iD9vNIotR/rxNT0MV04OaMj8KbR5vcgkovN1O8aiIr1IW/Ng
 e7tUDKfCBu58MkZ92ULGdiTPR7N7v8TeZ4LsmZXQfYQgVLz1XlPQyUb7yY++iTwgSiHjkW9BlVV
 ey/mFRnziInk0Qvy65Ke6R
X-Google-Smtp-Source: AGHT+IEVW+a7ZQahLwvXdewpnTcuAcck+Pbu7pXQ3XgPa8cMZnL3kzmIaMWIdBuRBFM46G6yblRD1A==
X-Received: by 2002:a05:600c:698c:b0:46e:4783:1a7a with SMTP id
 5b1f17b1804b1-46e61201fb4mr19588005e9.3.1759306895019; 
 Wed, 01 Oct 2025 01:21:35 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-40fc72b0aeesm26590514f8f.49.2025.10.01.01.21.33
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 01 Oct 2025 01:21:34 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Nicholas Piggin <npiggin@gmail.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>, qemu-arm@nongnu.org,
 Jagannathan Raman <jag.raman@oracle.com>,
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Halil Pasic <pasic@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>,
 Thomas Huth <thuth@redhat.com>, Matthew Rosato <mjrosato@linux.ibm.com>,
 Jason Herne <jjherne@linux.ibm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 kvm@vger.kernel.org, Christian Borntraeger <borntraeger@linux.ibm.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-ppc@nongnu.org,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Fabiano Rosas <farosas@suse.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-s390x@nongnu.org,
 Peter Xu <peterx@redhat.com>
Subject: [PATCH 01/25] system/ram_addr: Remove unnecessary 'exec/cpu-common.h'
 header
Date: Wed,  1 Oct 2025 10:21:01 +0200
Message-ID: <20251001082127.65741-2-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251001082127.65741-1-philmd@linaro.org>
References: <20251001082127.65741-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Nothing in "system/ram_addr.h" requires definitions fromi
"exec/cpu-common.h", remove it.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/system/ram_addr.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/system/ram_addr.h b/include/system/ram_addr.h
index 6b528338efc..f74a0ecee56 100644
--- a/include/system/ram_addr.h
+++ b/include/system/ram_addr.h
@@ -29,7 +29,6 @@
 #include "qemu/rcu.h"
 
 #include "exec/hwaddr.h"
-#include "exec/cpu-common.h"
 
 extern uint64_t total_dirty_pages;
 
-- 
2.51.0


