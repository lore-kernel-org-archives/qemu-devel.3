Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC433C88CB9
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Aug 2025 10:09:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ulPSF-0004mD-8l; Mon, 11 Aug 2025 06:08:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ulPSB-0004le-Nx
 for qemu-devel@nongnu.org; Mon, 11 Aug 2025 06:08:32 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ulPS9-0006MI-58
 for qemu-devel@nongnu.org; Mon, 11 Aug 2025 06:08:31 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-3b7910123a0so3878790f8f.1
 for <qemu-devel@nongnu.org>; Mon, 11 Aug 2025 03:08:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754906905; x=1755511705; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=kpmDvRWC/brKYpYi3H1Xhgtpr9AfpeYTXO2kVXk6was=;
 b=ViT+0s/9kDQ4QxK4KaRT4b/BW+8B+KS4z+x5WNN9eqCM1PCNdr24Ac0lXOV665vpJC
 lDZZNiOV2/qX23+TOd+FAckhYIP6BLzWVgzqEzfPBXKvtSU9jjyY7hmo271T5F4sf1mO
 G5RxCyvxWfGDRCA+W1LgnzMdNKkOmeBxDnmSLpVUNirU1VUbQhdjmEH5M49tHG3rjT3p
 B+LXl9nXNEMcSu4/ZVdSb6jeN3qdrbDOa7j87wMAGeF7PDnWAxxTyaRHb5N1G25nXAFf
 0sUOcfAphGdR71v/6xKMb3xmox216dSsNYCtLikjKLFog69Frhy9ssO8+pp62jnZsFqt
 /qGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754906905; x=1755511705;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=kpmDvRWC/brKYpYi3H1Xhgtpr9AfpeYTXO2kVXk6was=;
 b=EvlsKKQWrgZ0q4T9N/hL7dES3YNpK9KF5OI2Q6WogUAfHJZHMiJ2d4GVP2mOcCNr4U
 hB2qu/vslkrZds1UwAV6VLT8yfCWBFWpW8NSco7Se0JlJNpdZgn5+JPgTHGt0n2wCIec
 1idYqOym0N8L0dktOe/rvw6AbVAlNf43xapDqhEg+K4kwpqftvfmMHufHeg7yQ/vmjoR
 UGhj9kTtivlSOxF5FQ11LMpsebpc80S5wjk7rEUxuhhhbYtQqZXUD9wcIoL+rwzJtQfL
 Jg22aowlw/VWsoy01MR6b/dTN6OZnmtpRHe8i7nrovMd9PUQkSf0IOxciuZxPzvXB3Fq
 2ebA==
X-Gm-Message-State: AOJu0YzAKxjITC41fMpBLvdPZA1HJ2JnnIE1O4SF3lq6qgb/G7yMETK9
 pcFLXnxtYDcQV3FqguJEMLwuqbqVlaJ3YyMpOK4XrXb+Yio87PWGd/3wB9ocxi2lwtnJyoHj0o2
 updfx
X-Gm-Gg: ASbGncvI0cuB/KHzI07LaA4PZS5QJvhyvK6fo33arzY4Me76xaT9hrwWXJaRYQG3tvs
 6CatNvW0TcJe7do4Nz9SReuLkPejCVuHBHnna80MDjVh2jWODDHd+Bxn1ecNbj9BSa7RYIs1WYp
 3sQPBJx//OUqjFyl0TcxI4piSAySf718TcG2xl8rfw0MnsM88G6WBrhg/p2Oq0SoniEohsMTzPy
 sZxcxgXTnMDRJ2hA8eywwO0sZpCK4C6q9W41gGSf0zUXXQvQrRjch4hbqIyOecJ6uombRZLW7eO
 ly4ln+hsvTvzQzkwEJys01LYdzWFbz+w2GMoA+OQ0fPqUPC1K/rxqaaJOgpdNQwacMwaAzGoYli
 cawjcPefciFkeE3sLwdW9DtrbeMT0I/9ln+LEFl/LUbJI3wu39RYHPbjUtLrJaaLf6P1EWouX
X-Google-Smtp-Source: AGHT+IFWBUOE8r4jbw7kq6+AI3A7ygVdEHOlwK08NhKgWZhAHgLMHS+8ZyxMP893pdn4RVzWt5eWDA==
X-Received: by 2002:a05:6000:2207:b0:3b7:93d3:f478 with SMTP id
 ffacd0b85a97d-3b900b8bd5bmr10645435f8f.51.1754906905426; 
 Mon, 11 Aug 2025 03:08:25 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b79c4a2848sm39534016f8f.71.2025.08.11.03.08.24
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 11 Aug 2025 03:08:24 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH] system/rtc: Silent overflow in qemu_timedate_diff()
Date: Mon, 11 Aug 2025 12:08:23 +0200
Message-ID: <20250811100823.94105-1-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x430.google.com
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

Per ctime(3) man-page:

  A negative value for tm_isdst causes the mktime() function to
  attempt to divine whether summer time is in effect for the
  specified time.  The tm_isdst and tm_gmtoff members are forced
  to zero by timegm().

  The mktime() function returns the specified calendar time; if
  the calendar time cannot be represented, it returns -1;

Coverity reports (CID 1547724 Overflowed return value) the
qemu_timedate_diff() method doesn't handle this error path.

Since this method was added in commit f650305967f ("Unify RTCs
that use host time, fix M48t59 alarm") in 2008, and there is no
open issue related to it, keep ignoring this unlikely case, but
add an assertion to make Coverity happy.

Fixes: CID 1547724
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 system/rtc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/system/rtc.c b/system/rtc.c
index 56951288c40..070b99fe6ad 100644
--- a/system/rtc.c
+++ b/system/rtc.c
@@ -98,6 +98,7 @@ time_t qemu_timedate_diff(struct tm *tm)
         struct tm tmp = *tm;
         tmp.tm_isdst = -1; /* use timezone to figure it out */
         seconds = mktime(&tmp);
+        assert(seconds >= 0);
         break;
     }
     default:
-- 
2.49.0


