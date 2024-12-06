Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBDB4C3DA4A
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2024 03:13:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJOle-0006mZ-Nk; Thu, 05 Dec 2024 22:12:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tJOlc-0006lV-Jq
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 22:12:32 -0500
Received: from mail-ot1-x333.google.com ([2607:f8b0:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tJOla-0004QI-Rd
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 22:12:31 -0500
Received: by mail-ot1-x333.google.com with SMTP id
 46e09a7af769-71d537b50beso916222a34.1
 for <qemu-devel@nongnu.org>; Thu, 05 Dec 2024 19:12:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733454749; x=1734059549; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=69pr0g6Y3okyXfOdDRckkWb2oJA9va5ZC3/aP8PTogM=;
 b=LwLDDQcI2hX0f42kGchenenVx3HLt3A9RG4/hQmtxCOhBhUmNQu+EpEQ/AVPdYPnnR
 DVlmqh/pvKe35NDk1W/VLqu2leMUqygn0IsRi6JFXrpXQSu5MoHQOhFMZBL7BcT7RI3K
 KBTvK1muhIPj9DvIH1TVHrOobK2zJsolWr6HN5F0Q0lPyMeXQTu91vUKvTiG36uplL5f
 moS8yfdeFS06oOGtOUj4CDjOH7gtHUVmocNtJDL25mlmjeZZ7unw68UhMduLi+W+ak5I
 ZXWvZPpWwil75PCKgZSmFvUGYLCdvvJbnWJ1QLJTeBxwk4b6nGiFoyPOmyuhtbhBeNyX
 ZD7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733454749; x=1734059549;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=69pr0g6Y3okyXfOdDRckkWb2oJA9va5ZC3/aP8PTogM=;
 b=PoVTlPE5t6niwz/YCOGAgwYODTpHis6V0wYfYGsh1aGCZKNQ3DMb6H+k03oI7NURQj
 in//ksguVh1BDjda2F+6ed1YTVVZu6GfLVpx3b0octIOUKVTrZ/5WssW8A6lPzghHdok
 rYoyRIc+9/qxmuiNAI5kheNQhp4dznXGAE4n7AvxQos7Rqnmh6a3TmhFB7pLcPUZEqR/
 jI5rDtbcR3VZ1vgW240eg3ZPlEABgRa15GrHG6SLFGVrj5W/4h14wAtPe0RVcGejBljQ
 dWtG+veZ08nK+z6CyT+EwY4xsmjzfvqHV1KVVWiS1hBL1hhM2PTW6i1PPvcUVlI90LSp
 W5Mg==
X-Gm-Message-State: AOJu0YwJ//oguWQv/GJBjhuaE0P59JtvZhPOwf8yRLTMYejHE8Tyiuiu
 MmR6YJhUa08l4Lvcu8jhnl/Hy+SG/RzckXdFkQVX/voj6pBX/DS0HQ/wBBhme/BdW7xU7k9+37J
 W75fPre9W
X-Gm-Gg: ASbGncvVDpceGVjTzHVi5LNkEG7LdFcixGfKJmhlhv0tkpibRCsU3Sc/hrMl/6HRAeo
 kz72Ip+NkIG8Ba87HBgc717JWBiKKNMQoyExkNGELOT97tSzPfFceXWXz/YGn8EJRlnb9Xk1xAg
 u0sj4t8A5IL9LQWdKjZ8dnY+LNcv2zKL6fhty9B12evqCH0ncodsYVbUUdEwOENF0BNqB9EbYlH
 TaMj7XU8h4OAXh0MAzHB2mgljZy8/ZFao77rilvr7hhxcKIWy3zfNneiuL57URVsgd1i4pYCvyV
 Ph83zhrOPoyND88GheG9coxZXEIqIrHbEbQO
X-Google-Smtp-Source: AGHT+IEdB4xtM7dWRLeVOEiZ4dYo53nAW29Jk0Dx6J+10e0HEqzHM5rBTbajrcpW0OntwndSX5QSpQ==
X-Received: by 2002:a05:6830:378c:b0:71d:528b:b5b5 with SMTP id
 46e09a7af769-71dcf55656dmr1451994a34.19.1733454749714; 
 Thu, 05 Dec 2024 19:12:29 -0800 (PST)
Received: from localhost.localdomain (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-71dc493b2dfsm596442a34.9.2024.12.05.19.12.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Dec 2024 19:12:29 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 1/9] target/arm: Introduce fpst alias for helper.h
Date: Thu,  5 Dec 2024 21:12:16 -0600
Message-ID: <20241206031224.78525-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241206031224.78525-1-richard.henderson@linaro.org>
References: <20241206031224.78525-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::333;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x333.google.com
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

This allows us to declare that the helper requires
a float_status pointer and not a generic void pointer.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/target/arm/helper.h b/target/arm/helper.h
index 9919b1367b..cb722c491b 100644
--- a/target/arm/helper.h
+++ b/target/arm/helper.h
@@ -1,3 +1,7 @@
+#define dh_alias_fpst ptr
+#define dh_ctype_fpst float_status *
+#define dh_typecode_fpst dh_typecode_ptr
+
 DEF_HELPER_FLAGS_1(sxtb16, TCG_CALL_NO_RWG_SE, i32, i32)
 DEF_HELPER_FLAGS_1(uxtb16, TCG_CALL_NO_RWG_SE, i32, i32)
 
-- 
2.43.0


