Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE763CEACEF
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Nov 2025 20:39:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vL60B-0005Kv-Ux; Mon, 17 Nov 2025 15:39:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vL5zz-0005Jr-Oz
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 15:38:56 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vL5zx-0000cZ-PN
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 15:38:55 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-47755a7652eso32763625e9.0
 for <qemu-devel@nongnu.org>; Mon, 17 Nov 2025 12:38:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763411932; x=1764016732; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IwAOx9Hsl9tPV/fbNKmTyyOWz5fj4m6Yt+dsMAsL3yE=;
 b=WiZbv2fA/4PM7t0bv5ewJXUmSs2S3TXGbpWB0/o6aVzO2Sv2TrHQaiZgLX7YxepP3k
 XIEbjPmoeXRWmcAWQxBScjB25qTgN2W+jYa8otYZYqQYlMoe70Q1K1sUi1YdoHIv5cWF
 nIlnYDlnoYXWUq6ys4x/GZODTw1ElRWZitAWaCJ+OXkbrm09K9c8L5cdBDhuYG6Z/CeM
 KXo834HiVEKBsHJfTOdSr6luNb/Gxg5ckAhn7DD8gHbzi74bCMXdcE49vh0IT2cv1ljD
 fYXgs1YuaDweritKxqsrERy+Gjb7tY0gMzsfT+kZu531nPwYCmzPo4OY58eZLJEBsQcH
 lshQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763411932; x=1764016732;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=IwAOx9Hsl9tPV/fbNKmTyyOWz5fj4m6Yt+dsMAsL3yE=;
 b=i24Y2YgzcwhWpWUSssmeeDgOPObXhptbmsNKwQs2X+mpFqOwTdjGYwpW7dQfoaJLj0
 eXZD8E+OjrT0AzX/4CQhQ14gSrEmrb3yqAKtrYgnm2TmGNKThnP05Dj5jVkZjugI54+f
 mg78nfsLbmXn0qVKdaEYGOM4OhLPGxki0D69Qh4ikXpDxBrWXah8eaAQPH1NZC/fzQEY
 Cg4sK5Tu2Qbh0So3EpqzPageziEvKrfcthydiUavuJiEBpqwuPUPsL3autW/KIiWSMqv
 MlTYzXzN4qd+9JcCQLUwRhZjBWGtSBR3kfzS7ObEvJEe5dupNbI38jzFDJghhs81eD9S
 Rsjg==
X-Gm-Message-State: AOJu0YzPbAhsIbrN2EvCfKX1aaSvm4TUWk77Wdyb6OpRBl/MYgDY+hNz
 i70wOKf4g/SkyXs5GXNVQOFykg5N7m/+DB0hFNrGQ3dh8XX4/4AVWfOq2E1ADj/3/zvIr0pB41n
 l0/TuwMRQYg==
X-Gm-Gg: ASbGncujUTLZYD/xt4+lGCPYioizT/ODPhFVF/BuQcLRaooBNnYLAO/HqmbV1UEmkzr
 1P5oE9lQCGFy66YIsf9bx9BYg2McK6IRedl2b3/BEptAku1Bj3EceIr4a2b+ZqRkTTa9kK5nXK2
 CvWVLuIw+SwqrW5lq1xmZ6jEXccEQyqsgLRnge6HLu8Zw6CUi8CVYq+BJfxBr5SbEJvWUmN/Ps7
 +9xy9FZiNkF8Bv44uZZiEKhrQj1vcxFdSjnv6PhK+qCT7HA4VgC7YvGJdI8h+9MAqURkHp1bQZv
 4XNIfvEwz4d0HfEBb72ENSUVcGPtvwhV3FCR2hvu1kO2RWtIaVnQ1oxQF8DSJ8f40EihJIZJk8S
 5JyVSiuoBzsytAyBmDfaN7qjy4MpZb6bFCjvJ7rSfkNnClFnkEXv3eFL+eUaLuy0BCC+I6zmEjv
 GaZN7uGgNnWhmANT9jLrJRDkDn5i3cj6YEz5rdCmQsW9wRjOPFICNWPyFJsQtv/kVzyidZCHo=
X-Google-Smtp-Source: AGHT+IFz3b9knL/n8h8K6LzdtzVWHarlefA9XTMY6gkk6Uew5Q4u/PObyg7yUaGYeDv4G6ug0rBG0w==
X-Received: by 2002:a05:600c:6052:b0:477:9986:5e6b with SMTP id
 5b1f17b1804b1-47799866420mr56228585e9.28.1763411931622; 
 Mon, 17 Nov 2025 12:38:51 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-477a0f4ff42sm90424585e9.12.2025.11.17.12.38.50
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 17 Nov 2025 12:38:51 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Nick Briggs <nicholas.h.briggs@gmail.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Li Zhijian <lizhijian@fujitsu.com>,
 Kostiantyn Kostiuk <kkostiuk@redhat.com>, Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Andrew Deason <adeason@sinenomine.net>, Eric Blake <eblake@redhat.com>,
 Michael Roth <michael.roth@amd.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Subject: [PATCH-for-10.2 2/3] migration/rdma: Check ntohll() availability with
 meson
Date: Mon, 17 Nov 2025 21:38:33 +0100
Message-ID: <20251117203834.83713-3-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251117203834.83713-1-philmd@linaro.org>
References: <20251117203834.83713-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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
---
 meson.build      | 1 +
 migration/rdma.c | 4 +---
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/meson.build b/meson.build
index df4460035c3..72edd6097a4 100644
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


