Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4068C47DB3
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jan 2024 23:13:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUadO-0005wn-EB; Mon, 29 Jan 2024 18:01:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rUadK-0005vZ-PH
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 18:01:42 -0500
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rUadJ-0008OH-1z
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 18:01:42 -0500
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-290fb65531eso1752052a91.2
 for <qemu-devel@nongnu.org>; Mon, 29 Jan 2024 15:01:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706569299; x=1707174099; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Abpnrf3mk/IImEiBxCwuY+1bvCj+UYnsd1PobWXi05Q=;
 b=uZ6n8tn5t+JMXA2i/yJSgSFeHaUhJXNqdwRx+J7IwqppiwhWGTwdFw0UNQJyVnuHfU
 N92imwoBiFmmcnm8SnKzVyeHjthNzmbp7UdKXvOeJMJ1SWU7aCrUWOBQGAHdOjzJXKKq
 zuGtIMranO5bmETHSpA94Pnh2XWg+3mJxCCrVTNWCd5pZ3Y6RkxRtsBoP6430fI6nXyQ
 YF1SFtQt9fQNBbXo58wC8Xa6WgxIUtCnXhG+608lfwHehixT0KDwc0ES41LgBQxfVBVK
 YO/ExHu9Gi0q4RTpMsnVlGSCYGeb6JZATDW8rJLtmj+G2d5cDfHdbiOEqxMp5I0T9n4H
 c5DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706569299; x=1707174099;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Abpnrf3mk/IImEiBxCwuY+1bvCj+UYnsd1PobWXi05Q=;
 b=Ay6RgPkidwXzePK/u2W+wDErxctlBmttfhAPlTCYJV+7o2f5vi8HT3ySVbGnWqhAhU
 mBYXBIbcEmYQzOPBycGkp70BL3rYUhlgX9dESxmxH3axhd/DUlvYi3F4hI3blmZY65Nu
 quizZ5DpdhVCU+XHeQ+fLArz+i45KP5/8wj0TtvH5rvu3zFmvSe1SdiDRpzEAfpJfjm+
 zBj4vec5an7SbVF0C5R996PrlwwrlMAwDYrW9CTwVkBojIWzOGNmhCWp7F+FUg6+7Ups
 HyFmEBX+HmhBSV29DrpDjwOv4vLr7McP4z5Eb+s7xW2wcMEjEIl0wjqO4WkFrZZaVzHV
 kQiw==
X-Gm-Message-State: AOJu0YyNb8keWOla8DLzl57WT/m1jL4DXXMpt5Jc6G+CsagcrKEweg8i
 ptEOxWfifI9xNnucTW+Fgy1aj2DTBBAW9WIYIZp2KfgPElfqXzEV+zgtqsxtiGicOU7QgInBcf+
 HaP8=
X-Google-Smtp-Source: AGHT+IFWHDVrCfPNw5E7Z4tqYWzqy1D84bDOoWfso9aYKVcfE7c+mZdbAWzNTdfjXck4JWK4ywRJTw==
X-Received: by 2002:a05:6a20:9398:b0:19c:999e:b7a5 with SMTP id
 x24-20020a056a20939800b0019c999eb7a5mr3862829pzh.53.1706569299439; 
 Mon, 29 Jan 2024 15:01:39 -0800 (PST)
Received: from stoup.. ([103.210.27.218]) by smtp.gmail.com with ESMTPSA id
 r10-20020aa78b8a000000b006ddcf56fb78sm6419368pfd.62.2024.01.29.15.01.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jan 2024 15:01:39 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>
Subject: [PULL 06/31] include/exec: typedef abi_ptr to vaddr
Date: Tue, 30 Jan 2024 09:00:56 +1000
Message-Id: <20240129230121.8091-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240129230121.8091-1-richard.henderson@linaro.org>
References: <20240129230121.8091-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102b.google.com
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

From: Anton Johansson <anjo@rev.ng>

Signed-off-by: Anton Johansson <anjo@rev.ng>
Message-Id: <20240119144024.14289-11-anjo@rev.ng>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/cpu_ldst.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/exec/cpu_ldst.h b/include/exec/cpu_ldst.h
index 6061e33ac9..eb8f3f0595 100644
--- a/include/exec/cpu_ldst.h
+++ b/include/exec/cpu_ldst.h
@@ -121,8 +121,8 @@ static inline bool guest_range_valid_untagged(abi_ulong start, abi_ulong len)
     h2g_nocheck(x); \
 })
 #else
-typedef target_ulong abi_ptr;
-#define TARGET_ABI_FMT_ptr TARGET_FMT_lx
+typedef vaddr abi_ptr;
+#define TARGET_ABI_FMT_ptr VADDR_PRIx
 #endif
 
 uint32_t cpu_ldub_data(CPUArchState *env, abi_ptr ptr);
-- 
2.34.1


