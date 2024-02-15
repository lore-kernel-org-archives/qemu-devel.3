Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59618C48BEF
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Feb 2024 06:26:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1raV7A-0002Pt-Bm; Thu, 15 Feb 2024 01:20:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1raV79-0002PS-6B
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 01:20:55 -0500
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1raV77-0005Xl-Nf
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 01:20:54 -0500
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-1d7881b1843so4656725ad.3
 for <qemu-devel@nongnu.org>; Wed, 14 Feb 2024 22:20:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707978052; x=1708582852; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=mDHtjMX+mEQb+/p7zJ9SmZdTAU/DfY9CF76Jhj+l68I=;
 b=u3ei+nhA06wfOBKGdy1US7qnEUWsIj27qpj41UgMieXqcybrSn0krIXS1S0nBRA5et
 t/iYFG6SOibMqOzH6RWwMzeA/Wf0UiZXciaDzE+MYSyKOnOer4OV7wYX9MBV03q6/jo2
 3iZXZQp0aYjEjSd5EOlGSGDq74VAST3RRM3uifA/vJffWJYYJjSOpvUpAlJyf34hrLsT
 zHdJpLmnB9+U6uKbleh4zgHo6kPdpzu1aXmxLnIHxU/IVP+eN85EnxgVsyAnWmf7WXHE
 +r53WJ1kvwNTVmO3U1zoGdUEb112ZedOpO2HagG7rD3Lfl8cpZM0Z8hwMcob3Ky4rqdO
 +jAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707978052; x=1708582852;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mDHtjMX+mEQb+/p7zJ9SmZdTAU/DfY9CF76Jhj+l68I=;
 b=JVyINRQWecGTMjFZqj00ipWTyWCjPIjIU5YkSkj4DFzHxGB1cerZ3V1bDIKyB6c3Au
 UoJYghNEFc6ptewYgEA2cY0Xey6fO4USCcUGNv32moCQ/srVvXYh7JxDYbzzrGtMpp1O
 Ka9Lh8ycqxeRh2T4NLnUIH3dBGkUdPQr6Hq3Akv8ILyQsG7IQmc/hWeQALTyfu/xKrWZ
 HIgxwsnLRbeycmNd6hEZvglN2EyCcbCDeJeFE1hSnq1IrTojwqMBzyvy5kicgoHg1ju1
 DUCI/d5QC0iTAZ+CpQdJl+0u111cwqL6T6jDNDCiF9NLu/Ou32F7s2qIid4XaGl0NsTr
 ozGg==
X-Gm-Message-State: AOJu0Yz7pJjB82QweHFjKtdz0YtNlwL4QXJCo9LGZWz3F1fTAsE+//QA
 SicUbRpc9xdKCwjKmTxX4G4zAxQUcEazKOgEa9afJeWzec3lEZ8jKpp8utOycLKmkwuTnMFC9L+
 A
X-Google-Smtp-Source: AGHT+IEC1NtfJs2QyHSIdtijE2ZK6m4Zy1z2WpvF0QgCIKRbM1j3zN81cBK20pKK6N9FYJmOflccXw==
X-Received: by 2002:a17:902:f68e:b0:1d8:aada:a7f5 with SMTP id
 l14-20020a170902f68e00b001d8aadaa7f5mr850946plg.11.1707978052467; 
 Wed, 14 Feb 2024 22:20:52 -0800 (PST)
Received: from stoup.. (173-197-098-125.biz.spectrum.com. [173.197.98.125])
 by smtp.gmail.com with ESMTPSA id
 d5-20020a170902b70500b001d6f29c12f7sm464418pls.135.2024.02.14.22.20.51
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Feb 2024 22:20:52 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 22/36] linux-user: Use do_munmap for target_mmap failure
Date: Wed, 14 Feb 2024 20:20:04 -1000
Message-Id: <20240215062018.795056-23-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240215062018.795056-1-richard.henderson@linaro.org>
References: <20240215062018.795056-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62d.google.com
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


