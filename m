Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4D8FD68BD7
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2024 21:01:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tC3PA-0007W9-9n; Fri, 15 Nov 2024 15:59:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tC3P6-0007Uz-V9
 for qemu-devel@nongnu.org; Fri, 15 Nov 2024 15:58:56 -0500
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tC3P5-0004MU-AT
 for qemu-devel@nongnu.org; Fri, 15 Nov 2024 15:58:56 -0500
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-7ae3d7222d4so795712a12.3
 for <qemu-devel@nongnu.org>; Fri, 15 Nov 2024 12:58:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731704334; x=1732309134; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rexE46PmQpKj/6771gZyfiaf0DpwcDNDhSjq6mWlBi8=;
 b=dEf7hsQUp3LRk44wpGX3uudWOfm8CCB5IgHTs1n5PKs8Ni7LHpvyzgBFFK+CHGgrjb
 Se/U2JjO6g+8vcxjcBMf6krCIak93q+QNS67HKKHJ8KnwRXq36Soc2qQxIJL1qcMmji5
 iVQwxTXBW8vGG9YsWl6quf9JwODcCaNYU6uwuxmBi7dzolYAf0wg4PtF+LEB2+48+c3n
 yQyrTzBPgl6P0ZK6necJYVo3Ymj5ShA5XLhQm02ECvr6qNz/z3+Tdj4sE5vH7du6MkEu
 fhcSxMAbC4om+nKvnc3czp7e7vUbfBFoSx+/DZF4zMozal2PtT5feXeSAxCwuacyubpY
 7rRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731704334; x=1732309134;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rexE46PmQpKj/6771gZyfiaf0DpwcDNDhSjq6mWlBi8=;
 b=QbAG3R2tJKDfVUfQ/BnlazuZ1Eq3x2SNwokMaqPK42OH01qwWybafmT+WrrnsmSzTn
 drfndGcWK8xogYEf/8yKb8MtnQvOMuEXm6aqkfpdLkoAsCevX7soNrT5KM2ZFTSll0Jt
 AlETyelO0wwlLwaf1Bj3I2QYmbZqaXdbht9ffvWd8h6C46RiubD+Dl2C3SilIzs1Z0Y5
 15B7OqPVbgWt6UthMsnNcwgefkGdqnp6Nydg+QIQALTD5glw4OLQ8l4R0RJf0QtuhV9N
 LOtDJWio96v6k1168yVWQfL8iYVe52XoatfkOH2JgaCGC/IxNxmE3BLKF+vAIg5APnPi
 7FCQ==
X-Gm-Message-State: AOJu0YzkbPCFaB2cT0xNx7u14xbMF3xCe70SFu7hcPv8ZsW/BmL/WBEC
 IOcDso7KirRj8+Te9CSXF2YpOIMNMfUMai+fnU5lkLno5Mlq1sLTOpBExrDrM1cszwOrhmgUihS
 g
X-Google-Smtp-Source: AGHT+IECtsJJiJARF8sGQJjK795wx6u4wtd//l+ie+JyxIj0RAhZqGypa2ZFlvagqbPF/osHqbtKNQ==
X-Received: by 2002:a17:90a:e70c:b0:2e2:d181:6808 with SMTP id
 98e67ed59e1d1-2ea15587b4dmr4924629a91.30.1731704333648; 
 Fri, 15 Nov 2024 12:58:53 -0800 (PST)
Received: from stoup.. ([71.212.136.242]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2ea024a49a8sm3362274a91.23.2024.11.15.12.58.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Nov 2024 12:58:53 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Ilya Leoshkevich <iii@linux.ibm.com>,
	qemu-stable@nongnu.org
Subject: [PULL 03/14] linux-user: Tolerate CONFIG_LSM_MMAP_MIN_ADDR
Date: Fri, 15 Nov 2024 12:58:38 -0800
Message-ID: <20241115205849.266094-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241115205849.266094-1-richard.henderson@linaro.org>
References: <20241115205849.266094-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::530;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x530.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Ilya Leoshkevich <iii@linux.ibm.com>

Running qemu-i386 on a system running with SELinux in enforcing mode
(more precisely: s390x trixie container on Fedora 40) fails with:

    qemu-i386: tests/tcg/i386-linux-user/sigreturn-sigmask: Unable to find a guest_base to satisfy all guest address mapping requirements
      00000000-ffffffff

The reason is that main() determines mmap_min_addr from
/proc/sys/vm/mmap_min_addr, but SELinux additionally defines
CONFIG_LSM_MMAP_MIN_ADDR, which is normally larger: 32K or 64K, but,
in general, can be anything. There is no portable way to query its
value: /boot/config, /proc/config and /proc/config.gz are distro- and
environment-specific.

Once the identity map fails, the magnitude of guest_base does not
matter, so fix by starting the search from 1M or 1G.

Cc: qemu-stable@nongnu.org
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2598
Suggested-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
Message-ID: <20241023002558.34589-1-iii@linux.ibm.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/elfload.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 6cef8db3b5..d6ad77d27d 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -2898,7 +2898,7 @@ static uintptr_t pgb_try_itree(const PGBAddrs *ga, uintptr_t base,
 static uintptr_t pgb_find_itree(const PGBAddrs *ga, IntervalTreeRoot *root,
                                 uintptr_t align, uintptr_t brk)
 {
-    uintptr_t last = mmap_min_addr;
+    uintptr_t last = sizeof(uintptr_t) == 4 ? MiB : GiB;
     uintptr_t base, skip;
 
     while (true) {
-- 
2.43.0


