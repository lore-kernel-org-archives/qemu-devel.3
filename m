Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B10F1C47DD9
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Feb 2024 20:26:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfQUc-0007zu-UP; Wed, 28 Feb 2024 15:25:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rfQUb-0007zK-E7
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 15:25:29 -0500
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rfQUW-0007Lz-9f
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 15:25:29 -0500
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-29ab78237d2so67946a91.1
 for <qemu-devel@nongnu.org>; Wed, 28 Feb 2024 12:25:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709151923; x=1709756723; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FeF7fzEyCne6DT9i0AjI3AaZvbjspKahuYDo6eT9HQw=;
 b=djshCp09lGMTHPRQQcwLiau1Qa3WG+Ao+Hk5wINjaQRphv8GGz6sSLssGtH8Ibeetz
 JCQvpno+ODI25AmCRgyQNcvxyCIKNtB/tqHl9RtR98e32lMTHbru00cBbyIQoBpdixcz
 XdzdexUOFwGRI86rfJ8sX9eT4Lg/yXDSRiLB4vfQh/596BhLBeNml1WPgw0Bxm76dUYY
 sU2TWP7jfvFbXjjsAE6fyWARsr6h6w48n6KkkaRwKW7j9iq0Kt1NtQAEBYW2jj+Q+KGz
 IEeRnlz9/XQ8r/9ECc5fM9C8NhEK6sLB0BidoWKuUzOezDSXXYXQp0dg9Mu2txkYGNR4
 znJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709151923; x=1709756723;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FeF7fzEyCne6DT9i0AjI3AaZvbjspKahuYDo6eT9HQw=;
 b=IY/xJnOftuJHpMAWiUHgcE27JeC+h5vmkPGHPyFHk6W80ngtpe3U3J1LGkOYyueTVW
 30AqCp7we6XrLaN328dpjrY+ur1yha8MK9mP6D2h2LhtN/HlROBwb868BNZbnH7ytUKP
 RnwAWArhZfpCfofzHTcJbpE1C83TdnyDqHrpRD5+dCiahthUZktQI7CazutgYncld6g7
 TYekPPH/InC8GOHrUokWzntzwgn3rRnOAnc2KScVkPISi7wI/Yfq2Ndwpt9q2Bf8KH7O
 qCRli3GxO8AtVN29mgdNHVMWZnpLRBdbcrR23pV3y/j4UiBg5zVgFH2P0Hj+aNKAZ+Yd
 LtEA==
X-Gm-Message-State: AOJu0YzlwYXgI8yvwu0aWc8en0bubEBBPkuqOxHNsosXLDHZuVc59aB7
 8lksixizHkWIQWoLAQ9BB4Cv2+e3R1cM43PLrDPqSvrJlE2o28MAXEQdRO3osixOHFf2/RQfuOJ
 z
X-Google-Smtp-Source: AGHT+IE5XRJrqoVYo7frj9BME26umkgmV05D9tvxvaRCOJcPoPZVG8hS/uHc7cW7L8R37iOnq87MQQ==
X-Received: by 2002:a17:90b:3791:b0:29a:a436:4dda with SMTP id
 mz17-20020a17090b379100b0029aa4364ddamr332457pjb.0.1709151922839; 
 Wed, 28 Feb 2024 12:25:22 -0800 (PST)
Received: from stoup.. (098-147-055-211.res.spectrum.com. [98.147.55.211])
 by smtp.gmail.com with ESMTPSA id
 oh5-20020a17090b3a4500b0029ab712f648sm2118499pjb.38.2024.02.28.12.25.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Feb 2024 12:25:22 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu, richard.purdie@linuxfoundation.org, mjt@tls.msk.ru,
 iii@linux.ibm.com
Subject: [PATCH v2 1/5] linux-user/x86_64: Handle the vsyscall page in
 open_self_maps_{2, 4}
Date: Wed, 28 Feb 2024 10:25:14 -1000
Message-Id: <20240228202518.33180-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240228202518.33180-1-richard.henderson@linaro.org>
References: <20240228202518.33180-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1029;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1029.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

This is the only case in which we expect to have no host memory backing
for a guest memory page, because in general linux user processes cannot
map any pages in the top half of the 64-bit address space.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2170
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/syscall.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index e384e14248..bc8c06522f 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -7994,6 +7994,10 @@ static void open_self_maps_4(const struct open_self_maps_data *d,
         path = "[heap]";
     } else if (start == info->vdso) {
         path = "[vdso]";
+#ifdef TARGET_X86_64
+    } else if (start == TARGET_VSYSCALL_PAGE) {
+        path = "[vsyscall]";
+#endif
     }
 
     /* Except null device (MAP_ANON), adjust offset for this fragment. */
@@ -8082,6 +8086,18 @@ static int open_self_maps_2(void *opaque, target_ulong guest_start,
     uintptr_t host_start = (uintptr_t)g2h_untagged(guest_start);
     uintptr_t host_last = (uintptr_t)g2h_untagged(guest_end - 1);
 
+#ifdef TARGET_X86_64
+    /*
+     * Because of the extremely high position of the page within the guest
+     * virtual address space, this is not backed by host memory at all.
+     * Therefore the loop below would fail.  This is the only instance
+     * of not having host backing memory.
+     */
+    if (guest_start == TARGET_VSYSCALL_PAGE) {
+        return open_self_maps_3(opaque, guest_start, guest_end, flags);
+    }
+#endif
+
     while (1) {
         IntervalTreeNode *n =
             interval_tree_iter_first(d->host_maps, host_start, host_start);
-- 
2.34.1


