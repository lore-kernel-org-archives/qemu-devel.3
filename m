Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 691CEC3DA7F
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2024 12:43:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbg0r-0008Mf-0S; Wed, 07 Aug 2024 08:43:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sbg0k-0008GE-Rd
 for qemu-devel@nongnu.org; Wed, 07 Aug 2024 08:43:28 -0400
Received: from mail-lj1-x22a.google.com ([2a00:1450:4864:20::22a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sbg0i-0005Oy-Vc
 for qemu-devel@nongnu.org; Wed, 07 Aug 2024 08:43:26 -0400
Received: by mail-lj1-x22a.google.com with SMTP id
 38308e7fff4ca-2f1870c355cso18416751fa.1
 for <qemu-devel@nongnu.org>; Wed, 07 Aug 2024 05:43:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723034601; x=1723639401; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=62bCHMKIXQfxUU/cuSogWzhBCjagyaLhvUECd2A5+LY=;
 b=evb2L3zbf7MH2Moxxu2vtCPGsnE4Bbyh8RMpmSQcsJvLU3/Nxr/2oaN3z9Mzxm/7CD
 LLReFvrtrMVbzuuagXM2AtXumyIQKxVyiKrVu0w0t+7v5WxfyLvn0/9uHJwYqyrPc8F4
 Bw6czIsPg8TVomt1sX7qnvqx3JnjgsEL0O4UtM186Y5fI+mSeFvrHROQBzi62fAhZduh
 HOSgsfPCDJ0ai+3CGzojeSQVSHt2eI+zsmJz/mZuaH4euLgOuccwW0F8i3bjEKTBfJ3p
 +v7PsddsO7jCxI7USxP8Eab+UGENQet/THq/v4AnGZTsb5poATb3ZK6eLq+NemJ9Cuoc
 /GZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723034601; x=1723639401;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=62bCHMKIXQfxUU/cuSogWzhBCjagyaLhvUECd2A5+LY=;
 b=CoFcjc3ESrqNm0tBqLP5igc0uuFi8MMzssQEf37nmeA5E6tOXz2hUdhTpxcByeXhRl
 tH1AnutmBlUwJ0FFS6puzFkKnvp9F+Lfu2MJlK1EWq77ZYuyn7zcLRlKI5bkB/frUypU
 4JY0+rXz5CAN8jaSw6/lX7ropPb2No64bL1lx65xG6g8fN63YJpXnSULvu4kfi0wGYXD
 llsTOLK1yh8GxfWnaHNy5VnRamn4PqOs/czQE+7hVITJ20ojipkUiAuKZLI7vtNjDHsM
 LNNe/Ef9F3t7jxEj1RkEQIEz6TU+rkVwjV29ome5/C5rxt254PUxGa/8lWcolIZ1RTWP
 O+5Q==
X-Gm-Message-State: AOJu0YxaCASt+f4LPbAoFRaJC1p9n7LqzFzWkY5teHN6Pu7k3QU2w3RY
 +NQimBZQudbPk7i50iY4q38r2hqdAAuwK15aLZ3CqthyFBoJHHGtl0PQhdqWsiAEu7sH8Z5nQoP
 H
X-Google-Smtp-Source: AGHT+IGNyie40yiMy2CPapLOo/TozQaIABAds+fJKEMxxdJwP9PKqr4IWctGyIt2+2H5YUkMM4bwRg==
X-Received: by 2002:a2e:9c90:0:b0:2ef:2c87:3bd7 with SMTP id
 38308e7fff4ca-2f15ab0c200mr114613611fa.37.1723034601460; 
 Wed, 07 Aug 2024 05:43:21 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.212.120])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42905971d06sm26898975e9.19.2024.08.07.05.43.20
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 07 Aug 2024 05:43:20 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Zach van Rijn <me@zv.io>, Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 2/5] linux-user: Display sockaddr buffer as pointer
Date: Wed,  7 Aug 2024 14:43:03 +0200
Message-ID: <20240807124306.52903-3-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240807124306.52903-1-philmd@linaro.org>
References: <20240807124306.52903-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22a;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x22a.google.com
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

Rather than 'raw param', display as pointer to get
"NULL" instead of "0x00000000".

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/strace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/linux-user/strace.c b/linux-user/strace.c
index 73f81e66fc..80f64ff40c 100644
--- a/linux-user/strace.c
+++ b/linux-user/strace.c
@@ -434,7 +434,7 @@ print_sockaddr(abi_ulong addr, abi_long addrlen, int last)
         }
         unlock_user(sa, addr, 0);
     } else {
-        print_raw_param("0x"TARGET_ABI_FMT_lx, addr, 1);
+        print_pointer(addr, 1);
     }
     qemu_log(","TARGET_ABI_FMT_ld"%s", addrlen, get_comma(last));
 }
-- 
2.45.2


