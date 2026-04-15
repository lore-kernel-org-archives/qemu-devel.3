Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C502CF433CC
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2026 21:56:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wD8DR-0002IT-Se; Wed, 15 Apr 2026 17:56:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wD8DI-0002Fx-Et
 for qemu-devel@nongnu.org; Wed, 15 Apr 2026 17:56:01 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wD8DF-0002h1-05
 for qemu-devel@nongnu.org; Wed, 15 Apr 2026 17:55:59 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-488ad135063so71634205e9.0
 for <qemu-devel@nongnu.org>; Wed, 15 Apr 2026 14:55:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776290155; x=1776894955; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jHqQq9mgfz0/IbHwfpAA/ZimJYVnAn25wtx09Q5wcT0=;
 b=eq0xDjgjWtN1ErEI6QXip1IE3qJrJ5spiDesBpP/e59VghsVMAZDbc3TiWwefmwFjz
 ci3RRIftPxU+ZQimrmHk04duDHRgRv+hFsYiWeqPQJm5d15o+fiLAPZEzXsm2P96TaHA
 79HPAyDiQGZe0lIkWGRlV1Fnk9KHmiOWnwST1gVBTN0Ea8fd0nxCI3K9zg3zsC05k1YZ
 CRRnVO8rRIHuY2yhX8pB8ThyiggqdZkN2bRmeemxloM9qSPCKmxfp9jQezAnQxfpcS+S
 UwBkLmrAXPxmV3XQsA3s9D9iMKW/OOrExruD9933w79jNZFzHJooAMULoV4qWacLG/WX
 NS9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776290155; x=1776894955;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=jHqQq9mgfz0/IbHwfpAA/ZimJYVnAn25wtx09Q5wcT0=;
 b=nWpmHFMXYOyHVuJpAAeuE7AJVKoSJa75chdeidG8Erm8NKPoZAce+2b1FTZz7rLQ8I
 q2T5eREhqNUZNbhwInJ/FhQKLqG1hEaDUm3I1pUeybu/OMWGQNxsro+Dl9ycxRIZ+njx
 dYzcG6pu4KX9G/NOTqnCOFjvkq/ODMqwNhNVdy8iLu1z0o8r8VDurRU8vhAAmxOuLoB4
 Rlxn8AFjIYF8leGSejITM/SfLx6Mux0LttpDzq0Uv/8SlUulKhL3gldOY8aCK1nWfPrM
 2ZXfWYfhrQMYHZiFYlyqXTrXyMyOk6l0p3Bk/wXuPsbeVPgAziVrsagCf/DFfQMS3ie4
 EJHg==
X-Gm-Message-State: AOJu0YyJAnHbNA1JNS3XPvli2z8INxAMi2AoeJiM319B99r5jnvAOl+J
 hkbNp6L0A/W5DVxFNEeCYNfdfm8PcX+Nx6w4zbKp0+8Hgh64cm1t5gxtg/FHfXEobfeCz/avl+1
 B0ENnobQ=
X-Gm-Gg: AeBDieufqcDIxDNgPf3lxhSXhQbNzi+dE4gxu/neHAzZHj+Qpn6JkZGeWC2FCH2paYX
 TZsacHLyC4veBIEjCE+NU80Wfs3GmqHh19IT6Z+BHmPUdW+eAOMIedUCPI6HqEt0wYusGV/SC2k
 TNeKUkUAYbrEP1RgAGOalfikMddQ/cg+cCjP4A8pFS6wGX+LRlzlQnNpe+L/P7mA9CvOuI7d1Qz
 5LjtuMiCSHFUr/5gJGHSzz+gal1ke5TE9H7QAZbX0XqztNq7XOba7pDZyFGeGXvI22qPbJKAhZ/
 2Q7HXnl2Yd5tyEbHSdnC/nSbdAVsXhU0uWADhLHe+MBowKC07POY1jJ585/cNJY85Ba4FP69CoL
 RF86cWDQe9BeHI7UiN8nAEUyR7vfVZ+Gt2NdKVG7SjY7cR+MC9YD0MJdqbf0MH0T3FtkgCUE2gz
 5YVH8wQ9ixLfyWRBb3LUJ6UjBdf7CSyBOMIyWtbQs3GVlSh4tpXggGImUCLtby0ElUaRGJ4FzvG
 RQbcelGt5k=
X-Received: by 2002:a05:600c:8595:b0:485:3b00:f93b with SMTP id
 5b1f17b1804b1-488d6ab8082mr238560215e9.31.1776290155006; 
 Wed, 15 Apr 2026 14:55:55 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488f57da2aesm2566985e9.0.2026.04.15.14.55.53
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 15 Apr 2026 14:55:54 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-s390x@nongnu.org, qemu-riscv@nongnu.org,
 qemu-block@nongnu.org
Subject: [PATCH 2/8] cocci: Do not initialize variable used by QSLIST_FOREACH
 macro
Date: Wed, 15 Apr 2026 23:55:33 +0200
Message-ID: <20260415215539.92629-3-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260415215539.92629-1-philmd@linaro.org>
References: <20260415215539.92629-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
X-Spam_score_int: 4
X-Spam_score: 0.4
X-Spam_bar: /
X-Spam_report: (0.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 SUSPICIOUS_RECIPS=2.51 autolearn=no autolearn_force=no
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

The QSLIST_FOREACH() macro, defined in "qemu/queue.h",
always assigns its iterator variable when entering the
loop. Remove the pointless and possibly misleading
assignment.

Mechanical patch using the following coccinelle spatch:

  @@
  type T;
  identifier e;
  iterator FOREACH_MACRO =~ ".*_FOREACH.*";
  statement S;
  @@
  -    T *e = ...;
  +    T *e;
       ... when != e
       FOREACH_MACRO(e, ...) S

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 ebpf/ebpf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/ebpf/ebpf.c b/ebpf/ebpf.c
index 2d73beb4796..a8d441b02c1 100644
--- a/ebpf/ebpf.c
+++ b/ebpf/ebpf.c
@@ -40,7 +40,7 @@ void ebpf_register_binary_data(int id, const void *data, size_t datalen)
 
 const void *ebpf_find_binary_by_id(int id, size_t *sz, Error **errp)
 {
-    struct ElfBinaryDataEntry *it = NULL;
+    struct ElfBinaryDataEntry *it;
     QSLIST_FOREACH(it, &ebpf_elf_obj_list, node) {
         if (id == it->id) {
             *sz = it->datalen;
-- 
2.53.0


