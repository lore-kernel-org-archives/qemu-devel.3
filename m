Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8A7CCF2576
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Oct 2024 07:32:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1szt4c-0007lJ-7q; Sun, 13 Oct 2024 03:31:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1szt4a-0007kr-Mo
 for qemu-devel@nongnu.org; Sun, 13 Oct 2024 03:31:28 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1szt4Y-00064T-VO
 for qemu-devel@nongnu.org; Sun, 13 Oct 2024 03:31:28 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-71e52582cf8so446827b3a.2
 for <qemu-devel@nongnu.org>; Sun, 13 Oct 2024 00:31:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1728804685; x=1729409485;
 darn=nongnu.org; 
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=s77a5vU3vVH8tVW9WZPSomumraIRL1/RPd/WxHRdauA=;
 b=yuAkmtDPa7QiTgg4blH56YWL0afUVZIAku2OwEK54DJW1yAS8GgVKWmczeK7eo8Pfr
 GZfWVmGHAkt3JTj4mplaGJKuaRwN9CR4PqHOLfUDOgotMAY7DwHa2/LMJBQj705JlsKj
 2AGOQIey7QxYA8ArIIv/MF0YIn5pIstvJ41BbReonCxLbnQaj2K6oo/Bfnzc/Ew1cXsZ
 iOuZw0tZPkMgfoWiHpXtx4vHQtPCdBkZb/O9QcbOYLWL6NxJ/L7u7y9L0k064VdFZ0mc
 sKhqh33YPcWXbm6DYFX9yBgvW8DMov90/9jqZNczssmmQfnTnblBTlpuWPMwFHE+9pe9
 Z3Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728804685; x=1729409485;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=s77a5vU3vVH8tVW9WZPSomumraIRL1/RPd/WxHRdauA=;
 b=lidqzLKQh61Xvz5YMP0aEuIfxjeB4hBUXzrYofa01hT2Om+0gU4bsD6w9XYrKcJ5v/
 pXnLV34OvfLlmg09/lruNizObA7pPl80nkSiVocF2H7aTBUrxGm5J4XuuUjs6dyn8Bvr
 V7Kl8iymKLqv5KOO5hI4dF8l0Et/+Bva49nOsl+d2R8+FVH/sXYrtfYjqofvJd9ysL3o
 cFM9H2AdBNXOyF2DTEpOOp1gyPSCWzbZRZVGFNyQAtniQvTOaZjHi6n9m1Sr1T6j5KSs
 E1hdQb2hqKRnY+wqIBQx9sqzoCcrKeOBQq+wD0WuMbpZtW17Bf+08aF3cuO0CPJ7pIST
 LIQA==
X-Gm-Message-State: AOJu0YwjrQNl8XDl4coAD0O5wFU9gqgqjHMCSBAaOUD1HXKWZNTCGnJT
 b+xeScxot5L4o3IW3fo5WPE7BwbezieOurthQE8iKqfqtM9EhKwFNv4uKeiIiU8=
X-Google-Smtp-Source: AGHT+IGGpewwtpHrLwXYwHjnNgp5WSATkcx14zwxmkpvjOVbiR1n0mTSAK2jPH5LbSQQNkHnH/ZnBg==
X-Received: by 2002:a05:6a00:2304:b0:71d:fe5b:5eb9 with SMTP id
 d2e1a72fcca58-71e4c151ad7mr8266387b3a.10.1728804685003; 
 Sun, 13 Oct 2024 00:31:25 -0700 (PDT)
Received: from localhost ([157.82.207.107])
 by smtp.gmail.com with UTF8SMTPSA id
 d2e1a72fcca58-71e4cdd06edsm2353836b3a.32.2024.10.13.00.31.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 13 Oct 2024 00:31:24 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Sun, 13 Oct 2024 16:31:13 +0900
Subject: [PATCH] rcu: Call drain_call_rcu at exit
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241013-rcu-v1-1-a93b7c5957f3@daynix.com>
X-B4-Tracking: v=1; b=H4sIAEB3C2cC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxNDA0Nj3aLkUt0kEwszEwNTo0RDA2MloMqCotS0zAqwKdGxtbUArowjtlU
 AAAA=
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14-dev-fd6e3
Received-SPF: none client-ip=2607:f8b0:4864:20::434;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x434.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

call_rcu() callbacks may have potential memory leaks, but QEMU may
sometimes exit before draining the callbacks and leave the leaks
undetected by LeakSanitizer. For example, PCI devices register a
call_rcu() callback by calling address_space_destroy() and they will
not be freed until it gets drained. This hides memory leaks that
is going to happen when PCI devices loose references to the memory
allocations.

Call drain_call_rcu at exit to expose memory leaks by call_rcu()
callbacks deterministically.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 util/rcu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/util/rcu.c b/util/rcu.c
index fa32c942e4bb..118a974e3438 100644
--- a/util/rcu.c
+++ b/util/rcu.c
@@ -415,6 +415,7 @@ static void rcu_init_complete(void)
     qemu_thread_create(&thread, "call_rcu", call_rcu_thread,
                        NULL, QEMU_THREAD_DETACHED);
 
+    atexit(drain_call_rcu);
     rcu_register_thread();
 }
 

---
base-commit: 31669121a01a14732f57c49400bc239cf9fd505f
change-id: 20241013-rcu-b4864052a103

Best regards,
-- 
Akihiko Odaki <akihiko.odaki@daynix.com>


