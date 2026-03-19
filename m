Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEC6C1091910
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2026 19:11:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3Ilp-0000Bk-4b; Thu, 19 Mar 2026 15:11:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w3Ilm-0000BM-K4
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 15:10:58 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w3Ilk-0008U1-SS
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 15:10:58 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-48541edecf9so14067465e9.1
 for <qemu-devel@nongnu.org>; Thu, 19 Mar 2026 12:10:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773947455; x=1774552255; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eayvJ5Zp7NdtS6KVYiYLFGGBY/XbYTEjOUNmnHg50PU=;
 b=gbIi66VoGN5yePlyC+MJv7jjFNZTMFuLUd15Y7Vcw+jYpOTQjoyUAIJIs9sDwG60yM
 BlHmJETkLVdybuVudrx5jDnupH7S37884klZXdVOruHE+geaEom9KzJ28A5JusY9QqLE
 VZTdhBBb6eU8lsSKNhB9eoKl5c3zM07hkvBctQYdVdf0DMvNtin5iIvHg90+OTZUgkHU
 0MoGVA2q2IteBR10X6+h5ctBCDu25cI4KKa0z521gR2Aay8V6U3avvJMciefDTksdT3d
 sn6uWf6KTbOZIlUdU6yfsIZaT3yLjXsdSWWMoV0v2bVZJJEZPt3PEWxlA/CZn1IDYU3D
 V1+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773947455; x=1774552255;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=eayvJ5Zp7NdtS6KVYiYLFGGBY/XbYTEjOUNmnHg50PU=;
 b=Q9IYlIKML+n3nfOhnlbncckZfi1d0+ZzhaACbWnUnvNf5Y7gp5YLsBXKUEba/g2NvS
 xC0pOV6hsTadSsDL8ShRX0+b0Edrj+T3kkhlryYCUxUhrKgmspiVFbFS95mvyqNS2s2w
 2nk80Rgr26Tv6+nd+/BeirxTFoJUYF1h3JGIjSO4htjl/pa5WTOkBw07neE2h3ch5yZL
 TdBRnCOMPJ9p9sasnJggCIfDJYGlj7FzBHb5b7nMvPWuCKPuTFGpD4F6rdDcymw336V6
 Td1BhuiUZnQWeiWcaqacAKzkjXbolld1RCXxnOe6uK/rlGOcIQ2H/bOHvmQ7J1b3nq+B
 tkKQ==
X-Gm-Message-State: AOJu0Yx+p59SHU+EecOxf9gBl9F+tw3rRHiwUacjHcY/a48cMv1ySA+o
 Fa5UD1Ju0nksNIr2C7WtXcaCtBXYUV5AuUaNj/BMXAX2yfRZETeqvx78Vvr1XfqrBU3/SjgPETO
 YKrulMJo=
X-Gm-Gg: ATEYQzztBmNdLmqqbZGYrw+UtOZ86PTOHl7lPEhbAzsMl4GHd2OO37Jwzp0HDER7L7X
 QZV6ycbA1/4AgoC2Nclae8M/x9xaHLShPYH2BppENox851JGVdk0UfwCs3Tl45SW+KFaPzipIKp
 MPaDZXRjJXzcBbdoDpwXAqlQpBZSWL1HjpD2D9ALuRHOF9a1Q52Ptp8ki75I/q1+hZiDeL7ffTe
 FVADudVe96Wk12UNbGw/BTSKGm4qJ4KqO0jwG4zYgCENXH4As30FufBZUAL1ci6s9wkH5/wMsRP
 04ZKznIcXVvKMwNqJXl/749heoc3kAhgR67xtBVF/WR5aVMEygjFkA/SDMH5qSZCfnZ0GUUR7Jw
 KWDpQ5Sp67eRPA1UuMzqqpwYp79ve5T174EQNJGKNjL2l9751RQA1fKpte+ASt96QOVqJdOnZTF
 f/kw21WJznt4yTnGUDax0tMBdyicGrjwqjAFPwpkqKg92jZE/MrZbl+LjvMBJBy0hALz77YRK0
X-Received: by 2002:a05:600c:8711:b0:485:3f58:d9f with SMTP id
 5b1f17b1804b1-486ff029008mr3708615e9.30.1773947454801; 
 Thu, 19 Mar 2026 12:10:54 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-486fe6d9896sm9506265e9.2.2026.03.19.12.10.53
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 19 Mar 2026 12:10:54 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-11.1 5/8] system/memory: Constify various AddressSpace
 arguments (notify)
Date: Thu, 19 Mar 2026 20:10:14 +0100
Message-ID: <20260319191017.12636-6-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260319191017.12636-1-philmd@linaro.org>
References: <20260319191017.12636-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Mark the AddressSpace structure const when it is only accessed read-only.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/system/memory.h | 2 +-
 system/memory.c         | 6 +++---
 system/physmem.c        | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/system/memory.h b/include/system/memory.h
index 38e4f7b25e5..4c013593cae 100644
--- a/include/system/memory.h
+++ b/include/system/memory.h
@@ -2682,7 +2682,7 @@ void address_space_destroy_free(AddressSpace *as);
  *
  * @as: an initialized #AddressSpace
  */
-void address_space_remove_listeners(AddressSpace *as);
+void address_space_remove_listeners(const AddressSpace *as);
 
 /**
  * address_space_rw: read from or write to an address space.
diff --git a/system/memory.c b/system/memory.c
index 87ebeb93458..40e17ed22c6 100644
--- a/system/memory.c
+++ b/system/memory.c
@@ -2978,7 +2978,7 @@ void memory_global_dirty_log_stop(unsigned int flags)
 }
 
 static void listener_add_address_space(MemoryListener *listener,
-                                       AddressSpace *as)
+                                       const AddressSpace *as)
 {
     unsigned i;
     FlatView *view;
@@ -3043,7 +3043,7 @@ static void listener_add_address_space(MemoryListener *listener,
 }
 
 static void listener_del_address_space(MemoryListener *listener,
-                                       AddressSpace *as)
+                                       const AddressSpace *as)
 {
     unsigned i;
     FlatView *view;
@@ -3148,7 +3148,7 @@ void memory_listener_unregister(MemoryListener *listener)
     listener->address_space = NULL;
 }
 
-void address_space_remove_listeners(AddressSpace *as)
+void address_space_remove_listeners(const AddressSpace *as)
 {
     while (!QTAILQ_EMPTY(&as->listeners)) {
         memory_listener_unregister(QTAILQ_FIRST(&as->listeners));
diff --git a/system/physmem.c b/system/physmem.c
index bbcbcedda15..c00f75bf591 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -3573,7 +3573,7 @@ address_space_unregister_map_client_do(AddressSpaceMapClient *client)
     g_free(client);
 }
 
-static void address_space_notify_map_clients_locked(AddressSpace *as)
+static void address_space_notify_map_clients_locked(const AddressSpace *as)
 {
     AddressSpaceMapClient *client;
 
-- 
2.53.0


