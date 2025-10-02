Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83209CCA470
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Oct 2025 03:31:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4A0Q-0004We-Vd; Wed, 01 Oct 2025 23:29:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v4A06-0004V7-82
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 23:29:03 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v49zx-0004aq-P7
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 23:29:01 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-46e5b7dfeb0so2114795e9.1
 for <qemu-devel@nongnu.org>; Wed, 01 Oct 2025 20:28:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759375721; x=1759980521; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VL++psIcTnezWEV7BWLGf1XEHbU+wiOL+n3sKTSCz9o=;
 b=KqqF6sbS8dUE4K+EIZw5P3Tk8Q7W1dpzzLPmDJruKaG3/BQ8SxDZ8Ffb9Xc7vy+Epw
 tvUG3vJBTRobEK3HMcrcPxkqsMVGdljMwRjiBtkbO+fQzUmGXet+55WCrftsjdb4do3a
 uoWqKNaLxlsgg8XrujDXcwosGpWgwFCaJrDKNo/tVV9QDubjrd3q77kwTPNKpq9RZeyA
 ZOccfWhn+Bawn4tMCe4i9+wNPasoLbZ4omqXAKrSj/lh5ZBJ8eoJyXeLVo0LUdC8i3OU
 wW8dMr37b12pAMMbEPjznk/zc7Yv2/hzyfk35DOvF30CeojlVWyhJLCDnicRiA3UPI4k
 v2Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759375721; x=1759980521;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VL++psIcTnezWEV7BWLGf1XEHbU+wiOL+n3sKTSCz9o=;
 b=ZK7UnjcIVbKYMTWB87X3poQiNCzssBNa/jVLAEKcqeNUiAzMUH+rtpPPTjf9lZWZ83
 OUI+8FCaZ0fpgpMgyO8Z0lHpLb4ext3W1++NFVPK7Vj+InIKHdXA2/5nWY+HoPGEz7G9
 oNr/2Jjg2+YYu/a3XVyAfs0WN8QzkKZK27UnWr2pGgA1f/nI/5aeJuQlTB+3VstAX5/h
 DFTQtBQVZ13VI6991EF1bnO9PsZcpvzJYTvWg9DsYwJKw20NU4PcSujcJqIqFP7LgiLR
 laTKmxo9fGL54uwyJT5XeywMQnHVbdPrRxqysGqkuAj7XKbkkl/tATLO0R9EcV7mG3ou
 L3GQ==
X-Gm-Message-State: AOJu0YzG38yP3vNjPvu7W1XEp7Byb8QbRrjqk6qwd/25ums0rtLof7Kc
 pqVA7JL/ZRGmuKlZrSjivWy9+yFkiQmaptbPXF+g+R7AjdMl/DufKzMVLLEzn73iPMljMYvZD2i
 3p8YEz1rKRg==
X-Gm-Gg: ASbGncvXyjSHWh8wyhZTYgfSh7F7gpMspNHCoY08f7hdDK1B9sxw0AZnfciuU99sDw6
 9OQ5u37kRux/VZMpzJ+/IvSfsb/qwk8Oipt13jGaSYKo7c5socwFhqQCv7RBqxemSV8UeKIkgJ6
 VZNQs/urhAJotOx++lPBGRVwXKgHEnBfNXoddwZGoj9l9yEpTfvRrSPKx3g7bJT18tZYxGBhTGx
 /Huipbv32zFTqOclf1Wn6ZVjHWK60PKjfsBE7mJAE9gM9Waq432u8dzddT09mCqMpHKQuZX5XP8
 m3m14bW4+15CNlrHcEXiAPzUsZJrwvYTVxzLdxfMer3xDO9c/zMwX4Zmj3F4L1+Rx8PxJYDNEf5
 D8RFgFy5lYwMDWNzyjwtQow+SP6iceCoo76zDKXEhfFwpShVr6/SH6HOeiWyfj8FkwDDHqWajoP
 +L8E4Sn5su3FjLTUJpnnBcuTxJl/p5vg==
X-Google-Smtp-Source: AGHT+IEan6gq7FwOIOX+CQUrYOyZ1ZpzE1JMwvcDmTnfCD9kmJozhNIT9DcGRPkhZkVaK5maYShAEw==
X-Received: by 2002:a05:600c:1d08:b0:46e:396b:f5ae with SMTP id
 5b1f17b1804b1-46e653f35fcmr38896575e9.16.1759375721447; 
 Wed, 01 Oct 2025 20:28:41 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4255d8f017esm1625977f8f.47.2025.10.01.20.28.40
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 01 Oct 2025 20:28:40 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: David Hildenbrand <david@redhat.com>,
 "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Xu <peterx@redhat.com>, kvm@vger.kernel.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Fabiano Rosas <farosas@suse.de>
Subject: [PATCH v3 5/5] system/ramblock: Move RAMBlock helpers out of
 "system/ram_addr.h"
Date: Thu,  2 Oct 2025 05:28:12 +0200
Message-ID: <20251002032812.26069-6-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251002032812.26069-1-philmd@linaro.org>
References: <20251002032812.26069-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/system/ram_addr.h | 11 -----------
 include/system/ramblock.h | 11 +++++++++++
 2 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/include/system/ram_addr.h b/include/system/ram_addr.h
index 53c0c8c3856..6b528338efc 100644
--- a/include/system/ram_addr.h
+++ b/include/system/ram_addr.h
@@ -80,17 +80,6 @@ static inline bool clear_bmap_test_and_clear(RAMBlock *rb, uint64_t page)
     return bitmap_test_and_clear(rb->clear_bmap, page >> shift, 1);
 }
 
-static inline bool offset_in_ramblock(RAMBlock *b, ram_addr_t offset)
-{
-    return (b && b->host && offset < b->used_length) ? true : false;
-}
-
-static inline void *ramblock_ptr(RAMBlock *block, ram_addr_t offset)
-{
-    assert(offset_in_ramblock(block, offset));
-    return (char *)block->host + offset;
-}
-
 static inline unsigned long int ramblock_recv_bitmap_offset(void *host_addr,
                                                             RAMBlock *rb)
 {
diff --git a/include/system/ramblock.h b/include/system/ramblock.h
index 85cceff6bce..76694fe1b5b 100644
--- a/include/system/ramblock.h
+++ b/include/system/ramblock.h
@@ -119,4 +119,15 @@ int ram_block_attributes_state_change(RamBlockAttributes *attr, uint64_t offset,
  */
 bool ram_block_is_pmem(RAMBlock *rb);
 
+static inline bool offset_in_ramblock(RAMBlock *b, ram_addr_t offset)
+{
+    return b && b->host && (offset < b->used_length);
+}
+
+static inline void *ramblock_ptr(RAMBlock *block, ram_addr_t offset)
+{
+    assert(offset_in_ramblock(block, offset));
+    return (char *)block->host + offset;
+}
+
 #endif
-- 
2.51.0


