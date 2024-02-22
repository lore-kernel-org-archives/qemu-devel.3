Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96FE7C5478C
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Feb 2024 20:45:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdFvM-0007dy-Jw; Thu, 22 Feb 2024 15:44:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rdFvL-0007cE-8U
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 15:44:07 -0500
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rdFvJ-0002kB-OB
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 15:44:07 -0500
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-1dbae7b8ff2so1561925ad.3
 for <qemu-devel@nongnu.org>; Thu, 22 Feb 2024 12:44:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708634644; x=1709239444; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qMAzWUeeNJh47c4bkyOP/O/3UzvTHZWrc2G+MJg3FB0=;
 b=QG8/g7yvT+2v+FhhKtUPWtN34FEgxi2jLwF7nmB0aZs+YN7mG8taaRQjOjopBxGE9C
 eNI0cen+X2wB113lcF56aJdA9MEBD8UlhOnDN9t4Gm893C2Ijxmey+dd1pyAMBmfWBrt
 mCRE4dUcs/fPRFmHP64ULPZ8SPhc09dn5v5Rt/afeHkkLe83Whtb0cybAdp2AW6YoI/N
 ymITuXaqdHUn4uijOjqIy/s4MXyyAt4Ehpj5LD6dUlnQ8kChCy0ZVzAGWsm7UBRZe+6p
 P+utZwY9Uz2lH8NDqadSm8Ds6+LzJ6FucBVOpYYnCZhRmhsDol4WjunWdVCuPEsPAdTE
 ZfMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708634644; x=1709239444;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qMAzWUeeNJh47c4bkyOP/O/3UzvTHZWrc2G+MJg3FB0=;
 b=FiB72rNP+r4U1gjrD7yMM/YQJ3cE6w2vLn7/k77Kbrm5QsFx3drQ4MS3ehD7sVkiss
 gu1lq14zhcPd6WdUC5oG1Y5iHu2xwZ+8Wk46l+Oeq7xIEo42JBjDiJnY+0uIlQkO3qBr
 Y8e3TIwBjhvYEeZWgUYmHTC5SSyiacUd3ekADmqUhH7jrf8kKLZUkHXGr2o6D7YbudmP
 424Co8yGKBzppiFLD6FcUkrpTxVUyyl4TDqhgYcq8e/jt+v/sveh7bS6iHK0wsNjqvDh
 w0mZint3w9e4Q12DtNJ6WP96Sg6wB+76sACLp4vy61wrdyvFL5GpVq8m+R1aqoa7pmvc
 opig==
X-Gm-Message-State: AOJu0Yw140J4JZ2pmiopuDFdLmRm0UDXY7U4zhndjXB9FoIuthlNvlEh
 6OlQ4wjr4ry1DRma5venVaYrLlkL52sz7NzNftG0RdiEEuKFG411VlbPLMop11EhStBeDS88SdE
 p
X-Google-Smtp-Source: AGHT+IFu5GjrHgItmCuhEUfHdFVm5SJvy2RHOWhOQzC6co8WwHNhTsSXE5cyCQmfHS/U6nKKkowzkA==
X-Received: by 2002:a17:903:41c9:b0:1dc:38c7:ba1a with SMTP id
 u9-20020a17090341c900b001dc38c7ba1amr6134454ple.25.1708634644363; 
 Thu, 22 Feb 2024 12:44:04 -0800 (PST)
Received: from stoup.. (173-197-098-125.biz.spectrum.com. [173.197.98.125])
 by smtp.gmail.com with ESMTPSA id
 l12-20020a170902d34c00b001d8f81ecebesm10275500plk.192.2024.02.22.12.44.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Feb 2024 12:44:04 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 25/39] linux-user: Use do_munmap for target_mmap failure
Date: Thu, 22 Feb 2024 10:43:09 -1000
Message-Id: <20240222204323.268539-26-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240222204323.268539-1-richard.henderson@linaro.org>
References: <20240222204323.268539-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x632.google.com
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

For the cases for which the host mmap succeeds, but does
not yield the desired address, use do_munmap to restore
the reserved_va memory reservation.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/mmap.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/linux-user/mmap.c b/linux-user/mmap.c
index 8ebcca4444..cbcd31e941 100644
--- a/linux-user/mmap.c
+++ b/linux-user/mmap.c
@@ -326,7 +326,7 @@ static bool mmap_frag(abi_ulong real_start, abi_ulong start, abi_ulong last,
                        flags | MAP_ANONYMOUS, -1, 0);
         if (p != host_start) {
             if (p != MAP_FAILED) {
-                munmap(p, host_page_size);
+                do_munmap(p, host_page_size);
                 errno = EEXIST;
             }
             return false;
@@ -622,7 +622,7 @@ static abi_long target_mmap__locked(abi_ulong start, abi_ulong len,
             p = mmap(g2h_untagged(start), len, host_prot,
                      flags | MAP_FIXED, fd, host_offset);
             if (p == MAP_FAILED) {
-                munmap(g2h_untagged(start), host_len);
+                do_munmap(g2h_untagged(start), host_len);
                 return -1;
             }
             host_start += offset - host_offset;
@@ -735,7 +735,7 @@ static abi_long target_mmap__locked(abi_ulong start, abi_ulong len,
                      flags, fd, offset1);
             if (p != want_p) {
                 if (p != MAP_FAILED) {
-                    munmap(p, len1);
+                    do_munmap(p, len1);
                     errno = EEXIST;
                 }
                 return -1;
-- 
2.34.1


