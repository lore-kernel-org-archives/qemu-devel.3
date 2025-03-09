Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05F0AC28B28
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Mar 2025 18:00:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trKp6-00059e-IB; Sun, 09 Mar 2025 13:52:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1trKp5-00059U-Kq
 for qemu-devel@nongnu.org; Sun, 09 Mar 2025 13:52:23 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1trKp4-0004o7-35
 for qemu-devel@nongnu.org; Sun, 09 Mar 2025 13:52:23 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-43bc30adad5so20000015e9.1
 for <qemu-devel@nongnu.org>; Sun, 09 Mar 2025 10:52:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741542739; x=1742147539; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=rGVH3ZQmQ46V7zOspwriiKsX0Emdo3m/I01cSo1IH7Y=;
 b=nyzUPbe+BxoaYJP5thJOBYGwokRFQ2YP86uhLSXqNEmokc7cpqpZk8uuUL24CR7IFf
 thymKOvp/kt1EOtjvS7t4zKJOaQruXaMVSgyXQj91inADEz/tmLdLy+P4l+Rm4ANU7cj
 mTWNCJzaT8RCjTv1CvrO/a9r5SnvZI7uJqbaFVpb8ssmAO/2qIZuN0+y0U/dOzSYUTo2
 kDt5uHKLeKOCBqL1+JqDFiPvC/xan8VOU6TabLlVK66McByWoDNtbzz3Ymyo1YLi3f6F
 4rME4jY4Odqz+tg6rHCqF1LIO9OkT07zrG62/qJhyTBRv7Uv0rN2hocBE6Fr9SgolHst
 xNXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741542739; x=1742147539;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rGVH3ZQmQ46V7zOspwriiKsX0Emdo3m/I01cSo1IH7Y=;
 b=DuZTg7b+q2zOUYX8noIyVVXObzrlBjUxAkjw6TMWJUg4Pb1NGFYWPLTEjw8j1TNDzF
 3WdugMrHSXAQunx/IEWorHXB9MIXLNd7KPJuHcbZJKj/ZmRbefaLCheWk8TRRn+IUglN
 xY2lPA1UZMmJ+MIyq8AY6JLfCv9gQgAVHoWzIo12G9eOghP6pOMQ51xpHng3vV9h12rK
 jbt0ONDqBQQZ2uAPE2wrVIL67anB7Ip/m2glYx+8yC7Q9GVCpLCRkVBUaOKptKbDuD9t
 p6dZr+/Xu+PZsvordkPW+x3a+cu1jVcbwLQ7dK5wFFqSpQ7aLT4Nluj1mNDBJeOYdtXH
 QFRA==
X-Gm-Message-State: AOJu0YzW+ptVqQnYN2a0qOtcMPFwF+YYmAbT3Raf1aGrjVZBwUuLnd9p
 08Ge8zct3bgYKwr6LVKGJWdGhwyFfXVzk4TFGsF07jJPjyIy+OYqVZuk4ic6dZkItgktPW8RIwI
 zPBs=
X-Gm-Gg: ASbGncudwCXeoEG0xbsVf0AQ4lk2/umkE3gqnuqcgneni0G2TTR8us/oD2boQEUQsYc
 DEOvC15TXfc5H4x8px0UQKe5dNeQl+gcDMI4b+k6YtkVUwfZRMctxHyorO7x/vePh8PJEG5vJpj
 AR/dUe8g5tyaH+2JBxACNSbgIRoZjkH+QWfiPgNMeuq03e69N64+xB1E+m5ikJFc5VpYUCjYkZt
 loH0/ug0yxPo+rIrd8pr3WtGXJLMBOaZIEXlqsZxzMgF9ZUP3l955v/2jfB8lwYz5HS2PbqUXM6
 gFRizOrdGgmiQe9Imyp4Ux+E+23Nl8Z7WZn8P0Clpqj4YoHF3lLYuRLOzmNXX2HuTNEH+qFo/uk
 DVazsEOXRm/6y15AMAqo=
X-Google-Smtp-Source: AGHT+IEhpen0OT/wpjIsedM9olTkpqA0r2zexZbUkn3PQErVXSKJU0+PVrkG3oWBI/ZNw5TO5UZs0g==
X-Received: by 2002:a05:600c:358e:b0:43b:cc42:c54f with SMTP id
 5b1f17b1804b1-43c5a60eab5mr77702865e9.14.1741542738896; 
 Sun, 09 Mar 2025 10:52:18 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43cf27f8ef3sm25932595e9.11.2025.03.09.10.52.18
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 09 Mar 2025 10:52:18 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 02/38] bsd-user: Always use mmap_find_vma_aligned() in
 target_mmap()
Date: Sun,  9 Mar 2025 18:51:31 +0100
Message-ID: <20250309175207.43828-3-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250309175207.43828-1-philmd@linaro.org>
References: <20250309175207.43828-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

Massage target_mmap(): calculate alignment once, then
unconditionally call mmap_find_vma_aligned().

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Warner Losh <imp@bsdimp.com>
Message-Id: <20250308122842.76377-2-philmd@linaro.org>
---
 bsd-user/mmap.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/bsd-user/mmap.c b/bsd-user/mmap.c
index 346f2cefd32..dfa6e728ab5 100644
--- a/bsd-user/mmap.c
+++ b/bsd-user/mmap.c
@@ -489,13 +489,12 @@ abi_long target_mmap(abi_ulong start, abi_ulong len, int prot,
      * before we truncate the length for mapping files below.
      */
     if (!(flags & MAP_FIXED)) {
+        abi_ulong alignment;
+
         host_len = len + offset - host_offset;
         host_len = HOST_PAGE_ALIGN(host_len);
-        if ((flags & MAP_ALIGNMENT_MASK) != 0)
-            start = mmap_find_vma_aligned(real_start, host_len,
-                (flags & MAP_ALIGNMENT_MASK) >> MAP_ALIGNMENT_SHIFT);
-        else
-            start = mmap_find_vma(real_start, host_len);
+        alignment = (flags & MAP_ALIGNMENT_MASK) >> MAP_ALIGNMENT_SHIFT;
+        start = mmap_find_vma_aligned(real_start, host_len, alignment);
         if (start == (abi_ulong)-1) {
             errno = ENOMEM;
             goto fail;
-- 
2.47.1


