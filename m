Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DD61CAC5B0
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Oct 2025 07:20:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4wVw-0002nI-L4; Sat, 04 Oct 2025 03:17:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v4wUs-000215-Ua
 for qemu-devel@nongnu.org; Sat, 04 Oct 2025 03:16:06 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v4wUm-0005Nk-Ln
 for qemu-devel@nongnu.org; Sat, 04 Oct 2025 03:16:02 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-46e6a689bd0so22728075e9.1
 for <qemu-devel@nongnu.org>; Sat, 04 Oct 2025 00:15:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759562154; x=1760166954; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=SvXqmHvlAMeKty2uGnOFtx1knIbqaAJyW0E4J94ATiw=;
 b=vqAU2fq1vwXo/RFnjk1GuELvBBz+NzooSdfVeHTP3i2UJyfqfTgmMzzR2Bm6rYJl1X
 6nVZtJuWynsbPmRDwqR91dEZeqELr87+3cv0SNTpMu84bhOgYjXLMyScPTp+V0bRvfgJ
 82/2b1tkcS8NMDEWC/kXeSRJSUu/fK235v/1UNPjRvWFcP+nJKd/IMfx2bRbiAdKSC7e
 ZrnDgBoNSnEfiWhE0h2es0P5NtJ5eExKf1NkJRpkv+bZeupWtz2wBLIH2/mfZaEyDt31
 eEjWNf9ahmpBWPlrDUIvz/EcgCu8RklTM6A1mlmj/ImommbdHVehquqnECe8IhnRnrJG
 tdrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759562154; x=1760166954;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SvXqmHvlAMeKty2uGnOFtx1knIbqaAJyW0E4J94ATiw=;
 b=mQLygM9gNJUfs1pj2Iv/4MsSa+te+e/JVbFF41OCHvxUvJvOwn4FnSGNdKkOysATcK
 YakOzy6lI60ND+NZMZ13Lv8Lxo8wVHJLkYsmMhpLhk77dAUGY333cO19EQmGE0w/8Usm
 aWQwK9YmJ/q4W567eebLr1ueJlElxYLSQ91Q5uBesBZIDyZSOaCY9TTt0QENsVJY4Q30
 gAdnHRHvSZLiAdNvURNkaqQHgTlwNGJU1Bh+1c3F4r9JLmzaPx4aZXgTvHuvJNfmZS86
 qWnQskLwaTKbvsSoNwHEO9TNKKjNIiEV1UmaUkHajPIWU+A2YetPZkDfGfLj7opJKxGW
 8nsg==
X-Gm-Message-State: AOJu0YxtC3PFoIWXSlA2hYdTH11ngGhkxXUveYBxrbz5+hfPZ5u5F+T8
 raWHMXIugIkCP8XQ661rMuz9m7itMoXjChoORfVPl0TVJyKSaSoa0tX7++uBSCZuDMMY14MZbK7
 thDiHAtMOUQ==
X-Gm-Gg: ASbGncvNx40jH6GvnrchYQc9+wMYCCjroFwWhDElWBfmuPULKVfANIVyDbH2jQ5LyVp
 ydy5N1JfxLAgTCKgXiSgEtrbNsMOXZ33/PSA2QknRtsBBZhEcZfVlob96eVV8EL7TurmjKJ+cM7
 djgwxBS/8AmyIFhMZHFWks83/uxQ9c2g8aNtL2EgATLkFr3Z1A6oZp4VUc7FtN/Pc5q3+fkYlJ8
 7pbTzXdE2J5yAeIdIXs5gtBX9DJvKAikRdUxYfAmmLOFJiwccDnwFgHAoRqkE1xOqDCDIxekcPk
 v/jDcX53W3TNyeLOhiY8yRvSIbDhxqkGXkfaTWjFJe362I2RBGKdBm0uh6M9rtToVuO226FRNF5
 TtuVVkeLN3+Yl+ZeDU80+tKyoisi2TgoQ7Up6Ny0r0LqVWb3tAVwEon/jRtUCz+D8xMe+26k3Ks
 0ngG0315jU9vTiSeguPV3ZBDRv
X-Google-Smtp-Source: AGHT+IFhWI+iE4akEnXKEA6jULNTPUns1PwNkap//PTiszASFfPdPiuEQqqh5kJS4HLATSLNBJN6Jg==
X-Received: by 2002:a05:600c:a55:b0:46e:3e72:a56 with SMTP id
 5b1f17b1804b1-46e71101b21mr33097735e9.1.1759562153732; 
 Sat, 04 Oct 2025 00:15:53 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e619c3a58sm158569315e9.6.2025.10.04.00.15.52
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 04 Oct 2025 00:15:52 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 35/41] system/physmem: Remove _WIN32 #ifdef'ry
Date: Sat,  4 Oct 2025 09:13:01 +0200
Message-ID: <20251004071307.37521-36-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251004071307.37521-1-philmd@linaro.org>
References: <20251004071307.37521-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

Commit fb3ecb7ea40 ("exec: Exclude non portable function for
MinGW") guarded cpu_physical_memory_set_dirty_lebitmap() within
_WIN32 #ifdef'ry because of the non-portable ffsl() call, which
was later replaced for the same reason by commit 7224f66ec3c
("exec: replace ffsl with ctzl"); we don't need that anymore.

Reported-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20251001175448.18933-13-philmd@linaro.org>
---
 include/system/ram_addr.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/include/system/ram_addr.h b/include/system/ram_addr.h
index ca5ae842442..fbf57a05b2a 100644
--- a/include/system/ram_addr.h
+++ b/include/system/ram_addr.h
@@ -155,8 +155,6 @@ void cpu_physical_memory_set_dirty_flag(ram_addr_t addr, unsigned client);
 void cpu_physical_memory_set_dirty_range(ram_addr_t start, ram_addr_t length,
                                          uint8_t mask);
 
-#if !defined(_WIN32)
-
 /*
  * Contrary to cpu_physical_memory_sync_dirty_bitmap() this function returns
  * the number of dirty pages in @bitmap passed as argument. On the other hand,
@@ -265,7 +263,6 @@ uint64_t cpu_physical_memory_set_dirty_lebitmap(unsigned long *bitmap,
 
     return num_dirty;
 }
-#endif /* not _WIN32 */
 
 static inline void cpu_physical_memory_dirty_bits_cleared(ram_addr_t start,
                                                           ram_addr_t length)
-- 
2.51.0


