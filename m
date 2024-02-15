Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C148EC4829E
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Feb 2024 06:21:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1raV76-0002Nc-Sc; Thu, 15 Feb 2024 01:20:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1raV74-0002Mt-76
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 01:20:50 -0500
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1raV72-0005W8-G4
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 01:20:49 -0500
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-1d8aadc624dso4185245ad.0
 for <qemu-devel@nongnu.org>; Wed, 14 Feb 2024 22:20:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707978047; x=1708582847; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aJy5WaQ99ApNqzP+t8EteVWeLJYZZHFF49xziucGjOo=;
 b=pIQjbg2ctySqn2luCY29UoF3D7Eo0f3GZnKh47ONb5ajptfCAX7GADqWJcT+nFbldb
 0crTD6fhIFkzDJZA9mwS8se2u1WpMVBtf+fTmjUyk9ymF1zXm3l+neUZvKH9J6BKVSqr
 OP0K0Js++tKj5zyDokjBgbfFmSDezIJjQ28n29guvxLTZn90ZOTkBABGM0K4qbGX9TF3
 UMtwZjagFinRnYP9cl8YclzysmXN+DrusY+dpm8PV6LCUjdZMaL4rWG4rH1n7aXunYXy
 6aSIU0i4R1VmCY7h/B2TNxjxHRM7LdjE4bLuzn6loHwvZVf6elMi/C3+1qohCpvdErLM
 fEzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707978047; x=1708582847;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aJy5WaQ99ApNqzP+t8EteVWeLJYZZHFF49xziucGjOo=;
 b=bSZreLYcJM8gcaSfZPApJVS3Cd+2Wxjm6KUMmjkIRiPze5Rg14/F3jkflf3c1ii+sb
 UzLB7tIReJmKOZWeqxAmSn8vgcYQZmlWA/sHAeW8WPbDrmvWuXEUtuiKjQKoQBaZhjyE
 rfjWhdauJHUC168E0IYP3dAA9cfe9pHDOlwYWyRAekQpEVwesszI60JNC58vu0ISKHek
 tJA583lBZAizcauWlPDY4qQqa0+qinKa7uy234OdGLvRNoLkVog3O3u5BWZcLpsJRaEa
 1UfNF7E6O/1EP+4b0lT0Yr8aonD7n7Ss06z5aBOBVpij67NZGMVItKrB5myx5WW73W4C
 gZ2w==
X-Gm-Message-State: AOJu0YwH8fUNNmWFBaOV6Oqpt0umoQGFbET0kJerO6r9wpYTmN/0PMmI
 UQqm1MKFnNvKZifPWlSB9xel+OW5qEELdE5KZvSwdWuKOQ+7YvIwWm6P53q3FneYo6HAL6SRIt+
 V
X-Google-Smtp-Source: AGHT+IEvApMhR6A9DVyuj4fJEOTS0xAlLmNddoWGME5ULu9c3FFoZR9Jnq4EaWXJTaGB5ArQAaNZOA==
X-Received: by 2002:a17:902:d2c9:b0:1da:2a2c:90da with SMTP id
 n9-20020a170902d2c900b001da2a2c90damr894717plc.12.1707978047312; 
 Wed, 14 Feb 2024 22:20:47 -0800 (PST)
Received: from stoup.. (173-197-098-125.biz.spectrum.com. [173.197.98.125])
 by smtp.gmail.com with ESMTPSA id
 d5-20020a170902b70500b001d6f29c12f7sm464418pls.135.2024.02.14.22.20.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Feb 2024 22:20:46 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Helge Deller <deller@gmx.de>
Subject: [PATCH v4 18/36] linux-user: Fix sub-host-page mmap
Date: Wed, 14 Feb 2024 20:20:00 -1000
Message-Id: <20240215062018.795056-19-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240215062018.795056-1-richard.henderson@linaro.org>
References: <20240215062018.795056-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x635.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

We cannot skip over the_end1 to the_end, because we fail to
record the validity of the guest page with the interval tree.
Remove "the_end" and rename "the_end1" to "the_end".

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Ilya Leoshkevich <iii@linux.ibm.com>
Acked-by: Helge Deller <deller@gmx.de>
Message-Id: <20240102015808.132373-19-richard.henderson@linaro.org>
---
 linux-user/mmap.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/linux-user/mmap.c b/linux-user/mmap.c
index fbaea832c5..48fcdd4a32 100644
--- a/linux-user/mmap.c
+++ b/linux-user/mmap.c
@@ -643,7 +643,7 @@ static abi_long target_mmap__locked(abi_ulong start, abi_ulong len,
                                target_prot, flags, fd, offset)) {
                     return -1;
                 }
-                goto the_end1;
+                goto the_end;
             }
             if (!mmap_frag(real_start, start,
                            real_start + host_page_size - 1,
@@ -690,7 +690,7 @@ static abi_long target_mmap__locked(abi_ulong start, abi_ulong len,
             passthrough_last = real_last;
         }
     }
- the_end1:
+ the_end:
     if (flags & MAP_ANONYMOUS) {
         page_flags |= PAGE_ANON;
     }
@@ -708,7 +708,6 @@ static abi_long target_mmap__locked(abi_ulong start, abi_ulong len,
         }
     }
     shm_region_rm_complete(start, last);
- the_end:
     trace_target_mmap_complete(start);
     if (qemu_loglevel_mask(CPU_LOG_PAGE)) {
         FILE *f = qemu_log_trylock();
-- 
2.34.1


