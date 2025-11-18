Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0E27CEE34B
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Nov 2025 19:02:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vLQyI-00026z-6H; Tue, 18 Nov 2025 14:02:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vLQyF-0001uI-RR
 for qemu-devel@nongnu.org; Tue, 18 Nov 2025 14:02:31 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vLQyC-00066u-Jp
 for qemu-devel@nongnu.org; Tue, 18 Nov 2025 14:02:31 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-477aa218f20so7669725e9.0
 for <qemu-devel@nongnu.org>; Tue, 18 Nov 2025 11:02:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763492546; x=1764097346; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=GYPvgDJyKQPbQRcUEUxfDE0G1cAgbiOOD5h9fXN0ghI=;
 b=zkpa8MH+m8JGsatrBNIKOizSH27JToQ0X+usNabgsSPZDR8iI/68MQ5wUs1G83v3kR
 0IXoRXDVqpURmbfHvU4mnDKjPfMHfsD2BZuVfYZqVjFO7GgjEn7UsdQVmrw0gfakNO7F
 r/Pc+mAI33E36yrKl9Q1uVMF9aMT4H3A8CmhBvgrJAQ0brftLWtoOxph3OxvK+maFh5e
 qzcBa9Yn0O2jWhIUUWO9k+Z2ACtik59bO8CUwgBGYMT4d15yr0BSRK01WGZ/xPMErklW
 IJIOOepKu0xvsE4e7lbnwMEjdxtXSCRT0IgR7oaggUQYC4w3mjVnagl9RuULbmsLo5aU
 zejQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763492546; x=1764097346;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=GYPvgDJyKQPbQRcUEUxfDE0G1cAgbiOOD5h9fXN0ghI=;
 b=p4eOuvdvuxtVnDF8w7Muy/vkZ4GGHlacu5eGz2LQBOk6KRRv4fg/jvb4WBgSIxca2+
 FKmEGoOt2rjTL/PCsy1NuMWe1NDwvHB8WR07GQBBhBhdAtzQppE/ieBYz3LEVVtORBb3
 HdKENMQt8W09SVUmdp9idpPMOfP0NFQrCutPZgEGAwKyaEr3r1so/41Gsuow+rZKJb70
 0b+IR3KFFDouE0RjIfaP9oNjxHvBMF/HA/2xs8U8vL7jH1ZGRHxj5Zqtli8NHDCXHELv
 NjZJiiDZgb7lm67NvghGFa5QY7hyJCHOhBoYZOSwanHsrhcYMDAK6Brh5hO0q2c9xY26
 Sr/A==
X-Gm-Message-State: AOJu0YzQv/1PUOk+iKaX0eBZtzB2lsZbtloy1uQ4QlxN6gs8KCYmvUfe
 e1gZJz0v86r1GNJJ80UkuYz9NzCvOMk5L9jwbMtCXX3y4qKCllj5dFtUaBT9eYLHDeoNQt9wepV
 JutgqRDnsqw==
X-Gm-Gg: ASbGncsP5lSMHBNwlGJ3JaAUbqEd6y6j0ENjJKGEu7MQhur3DI53vAud964cRDVWxQK
 AWZhUeYtNJyoCteeVC4I1flkvGYp0jBlC6hqXmyCx1dBEs6VaaNDnJ31xNzAuzzgx6Y7qbCs6BO
 Sy+6uxK51bWaXhNhXnYscbQrNE42EX/3/6WLwM+BK5b9+NWaO7ZO3wac4tSOvy5XyLS3dkhV10h
 A+6PL/V/srB//Lwq7X3gOzsbx6/T+sqXiJ+KChAyzxcF9gxYoHgikTyT52Jr/5S17wmStXNcUw/
 Jt4ot3o2PxFsEYVXXT4n0dHOuD9hr0gzAQ98D24KAmc0gmdQe5YqdV7Oi9gHnkecqNnCDFV4zOP
 PaXsnYderEESlsc4pS2hzdAZ3FGmuzY8758kZkEIujhsBxGi4VKrv+g04ISvpwlI0iYoF+KAsiL
 HzCCSwxSeyk+BAgbp0arzAuqZe+TZkG/75njH1h6PPYqpOIUhFOXIMpv0EGpKuOkz7jAKIw/4=
X-Google-Smtp-Source: AGHT+IE4iRrHKXb8LZro41254zMjXM6ISaRTNY3io3+a7Q4K75k8s2QDnLfYms9aeicA7HXSzWS5Iw==
X-Received: by 2002:a05:600c:1f92:b0:46e:32d4:46a1 with SMTP id
 5b1f17b1804b1-4778fe96324mr162456745e9.22.1763492546422; 
 Tue, 18 Nov 2025 11:02:26 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-477b0ffc90fsm5899565e9.2.2025.11.18.11.02.25
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 18 Nov 2025 11:02:25 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 12/18] migration/rdma: Check ntohll() availability with meson
Date: Tue, 18 Nov 2025 20:00:47 +0100
Message-ID: <20251118190053.39015-13-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251118190053.39015-1-philmd@linaro.org>
References: <20251118190053.39015-1-philmd@linaro.org>
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

Commit 44ce1b5d2fc ("migration/rdma: define htonll/ntohll
only if not predefined") tried to only include htonll/ntohll
replacements when their symbol is *defined*, but this doesn't
work, as they aren't:

  ../migration/rdma.c:242:17: error: static declaration of 'htonll' follows non-static declaration
    242 | static uint64_t htonll(uint64_t v)
        |                 ^~~~~~
  In file included from /usr/include/netinet/in.h:73,
                   from /usr/include/sys/socket.h:32,
                   from /home/f4bug/qemu/include/system/os-posix.h:30,
                   from /home/f4bug/qemu/include/qemu/osdep.h:176,
                   from ../migration/rdma.c:17:
  /usr/include/sys/byteorder.h:75:18: note: previous declaration of 'htonll' with type 'uint64_t(uint64_t)' {aka 'long unsigned int(long unsigned int)'}
     75 | extern  uint64_t htonll(uint64_t);
        |                  ^~~~~~
  ../migration/rdma.c:252:17: error: static declaration of 'ntohll' follows non-static declaration
    252 | static uint64_t ntohll(uint64_t v)
        |                 ^~~~~~
  /usr/include/sys/byteorder.h:76:18: note: previous declaration of 'ntohll' with type 'uint64_t(uint64_t)' {aka 'long unsigned int(long unsigned int)'}
     76 | extern  uint64_t ntohll(uint64_t);
        |                  ^~~~~~

Better to check the symbol availability with meson.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Acked-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20251117203834.83713-3-philmd@linaro.org>
---
 meson.build      | 1 +
 migration/rdma.c | 4 +---
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/meson.build b/meson.build
index 5ddec8afd7b..81f9f7b3287 100644
--- a/meson.build
+++ b/meson.build
@@ -2663,6 +2663,7 @@ config_host_data.set('CONFIG_SYNCFS', cc.has_function('syncfs'))
 config_host_data.set('CONFIG_SYNC_FILE_RANGE', cc.has_function('sync_file_range'))
 config_host_data.set('CONFIG_TIMERFD', cc.has_function('timerfd_create'))
 config_host_data.set('CONFIG_GETLOADAVG', cc.has_function('getloadavg'))
+config_host_data.set('CONFIG_ARPA_INET_64', cc.has_function('htonll'))
 config_host_data.set('HAVE_COPY_FILE_RANGE', cc.has_function('copy_file_range'))
 config_host_data.set('HAVE_GETIFADDRS', cc.has_function('getifaddrs'))
 config_host_data.set('HAVE_GLIB_WITH_SLICE_ALLOCATOR', glib_has_gslice)
diff --git a/migration/rdma.c b/migration/rdma.c
index 2d839fce6c4..337b4158899 100644
--- a/migration/rdma.c
+++ b/migration/rdma.c
@@ -238,7 +238,7 @@ static const char *control_desc(unsigned int rdma_control)
     return strs[rdma_control];
 }
 
-#if !defined(htonll)
+#if !defined(CONFIG_ARPA_INET_64)
 static uint64_t htonll(uint64_t v)
 {
     union { uint32_t lv[2]; uint64_t llv; } u;
@@ -246,9 +246,7 @@ static uint64_t htonll(uint64_t v)
     u.lv[1] = htonl(v & 0xFFFFFFFFULL);
     return u.llv;
 }
-#endif
 
-#if !defined(ntohll)
 static uint64_t ntohll(uint64_t v)
 {
     union { uint32_t lv[2]; uint64_t llv; } u;
-- 
2.51.0


