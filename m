Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCC0CD0D171
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Jan 2026 20:27:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vda7D-0003yL-0u; Wed, 07 Jan 2026 15:26:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vda72-0003ti-Jl
 for qemu-devel@nongnu.org; Wed, 07 Jan 2026 15:26:44 -0500
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vda71-0006SN-5s
 for qemu-devel@nongnu.org; Wed, 07 Jan 2026 15:26:36 -0500
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-43260a5a096so1690323f8f.0
 for <qemu-devel@nongnu.org>; Wed, 07 Jan 2026 12:26:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767817593; x=1768422393; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nvyQ3n8ThDlguGUU5DY49LBGt2QYFivBVFa4EJ7BZ3c=;
 b=wBHJw1G8TSh8eN9oSht0SebDXPeqnTClCvp+vJoFTBRq5Yp9Euq7QqZMWnw8gchxxy
 K6Ze96PBjq1ubvfkd6VAtUfb8k4VfLoj5h+H4792i5IXEy3o91a7lQo0EDf0jk7gh2vp
 XPjbK3z4WDddbKAhQ2U3UK5596SUjptvqpXJK75i5+SyJxsGE3RdGB3NWXyJgKSBS4Z5
 8SpOPzdaPLfVLtsCfbJBYq0ZkDMlNH+cO1gGZtuQvtwHLCdMyfUtvVRquRrhmKecyBuV
 QPGBxuFSBjc2xHN78shmDYqUY7E6vF7xKScK+y1iPkhTH9UCueTz7xrDvO+mWs/EUPNV
 wFtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767817593; x=1768422393;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=nvyQ3n8ThDlguGUU5DY49LBGt2QYFivBVFa4EJ7BZ3c=;
 b=LHhU78kMtvoLLgTiJV48zHvkd6HI+it1thjitKZDmyUbTcH26v8yZ73OfWREaLpKJk
 yRRPiQpUgby4VvXWKwOnVlJgKfAVYq3VONppu2kmSADna8NJHIDDa0JAnF0gSyXb7BEk
 vkt/R0w6jD9CCpLK/H5RlFWArI24kno5JRcvdA0fJqEpts4tYujgdz497AzUqP4hwUeO
 dL6juP1ncr31CSToOLwCuZ8qpg6Ca+//TuP7iIpJt/H0/jc1/sQBFFTQ6KvRUJb7X1f5
 ucECtJ6Hrcl9/k43yk4GzJdsM0+oJhV2bufFPtor8aAY04cYRixY7EGVbiMFuAy/lXAv
 9x+A==
X-Gm-Message-State: AOJu0Yyl4X8eqE3eI5EPN1Y8L1q+knwYRECE0gHb6L3XM1xgIjkiol6I
 C/vBnnepVBVtnumpVAz8Fj2C+doS5TSCjpNw3GievI7JYCiS1t1RLGZ8z2BeNxLELjG6103WdKL
 NVAE1Z1c=
X-Gm-Gg: AY/fxX7+qx7xIVNAMg9wj4lMju7CTMuJBvVwOXEd7Vu7xYS0QFzGpdM+VwyxTqgRawF
 O3jr+FgOGZurKNFKGgQiLAvRsXWf4KoZoDrZy6P49la44ng37d9C+BgryKbeBlziMp7DrSEEjze
 sjfI2q/GhiQ7lnXXV0UuMEkBJDNdBKyG0IQmjqKukJO5jo0zH+FOYFCezfR19GJHlhkOiamNRCf
 Safkx41R4HXZInVpYrM6oYwkGrpwJvnPuQDbWIvk+HIHWDvLTGDRHzlXpjHleP/DGPV+YLG7YtI
 r6TruqLvDjTTyZV4kUmJtVXWR49en/rLl2Bqt+IDosL4h7Cu2MMsB5w70BsgejjxZ32WMtf5PZY
 HRwnz7hWVkEi3ezwRZ+bXuUuzapP30qKKoCziGmM/VwBpB6dKP2rnKbo7ObUFmiW3CRph4KUu8i
 cVmXaJ/tavUbPGsWRz5+SWpWYFZQ+8VG4vewSlwib+puZiqMHutuUl9QWbB3zy
X-Google-Smtp-Source: AGHT+IF5kqqOqM+FZS0N/XZGH/IWZe4pK8OiaSWrJojiNK31Bi/qzpXT2bE2/QmkSHbcn1D6iRKbvg==
X-Received: by 2002:a05:6000:4287:b0:430:f494:6abb with SMTP id
 ffacd0b85a97d-432c378a793mr4582903f8f.8.1767817593350; 
 Wed, 07 Jan 2026 12:26:33 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-432bd0dadcfsm12382201f8f.3.2026.01.07.12.26.32
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 07 Jan 2026 12:26:32 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Anton Johansson <anjo@rev.ng>,
 Max Filippov <jcmvbkbc@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 5/7] target/xtensa: Build 'xtensa-isa.c' in common source set
Date: Wed,  7 Jan 2026 21:25:54 +0100
Message-ID: <20260107202556.55787-6-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260107202556.55787-1-philmd@linaro.org>
References: <20260107202556.55787-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
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

'xtensa-isa.c' is now free of target-specific symbols,
build it as common files (thus forbidding further
uses of such target-specific symbols).

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/xtensa/meson.build | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/target/xtensa/meson.build b/target/xtensa/meson.build
index 69c6946420a..3fdb20db655 100644
--- a/target/xtensa/meson.build
+++ b/target/xtensa/meson.build
@@ -12,6 +12,10 @@ xtensa_ss.add(files(
   'op_helper.c',
   'translate.c',
   'win_helper.c',
+))
+
+xtensa_common_ss = ss.source_set()
+xtensa_common_ss.add(files(
   'xtensa-isa.c',
 ))
 
@@ -24,4 +28,5 @@ xtensa_system_ss.add(files(
 ))
 
 target_arch += {'xtensa': xtensa_ss}
+target_common_arch += {'xtensa': xtensa_common_ss}
 target_common_system_arch += {'xtensa': xtensa_system_ss}
-- 
2.52.0


