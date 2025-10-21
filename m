Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47CDFCCD1AA
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Oct 2025 20:49:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBJHj-00084g-Sw; Tue, 21 Oct 2025 16:48:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vBJHh-0007up-PC
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 16:48:45 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vBJHf-0001AW-HI
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 16:48:45 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-46b303f7469so48895405e9.1
 for <qemu-devel@nongnu.org>; Tue, 21 Oct 2025 13:48:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761079717; x=1761684517; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Iz5ofpUjr7hlyFIjNQUXcsNNAzKh5yHExm0kdxC5s4g=;
 b=Ocggc9bszjPXmKN9YrTMYmwBYujuUMNqm1GVNsbwXBgKQCsgE+rJyfmhWQJ5Jkhlqz
 JH5KniI7yAqjiR00Nf6cUhhyIds7LsRVz3Eo4BTEoU0qukeX4WUSyxfSOXQgZbrtUzSQ
 esUIP3jZ6CX9iRAUgojRTqWBi6ZqYRriXLX9vofS6mdzxA5hOykr/pBO18/6rDcfQkIK
 uMkMWbjm1CyeT6F1NCWX8e7o0sdXdBzFIQsMcxI6V5o/S2FDRcStAKYx+XKNSdsnWNHz
 Cm8z27wKWh6nynJgwrnBG/37OooJTBWr062PTbHUAp/Fe3NtqqeBlyRZ0EBhvn2Xsja3
 dkUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761079717; x=1761684517;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Iz5ofpUjr7hlyFIjNQUXcsNNAzKh5yHExm0kdxC5s4g=;
 b=s1GyWLMC6xa+tESgZVVibf7YSZQFVCuq1n0hpdoWz1gniGeE+zfWwrz3aAyduGZpIg
 5c3jIx/8AxPQq+6OS3L1ExalWI2/FEypG8O+8ETKBw1WCE1WqYXdExUrxvFOCSy5Y/mf
 OPinP5LRuAWKNrm+iJK3AZIpkzeWJdYwjRsnAFKFpLDw3g3ug8qsg/8jcu3NZFHGhnh2
 Ao7PSksbghcf3uFbhbplRyy1ALRHJBUkbgWweN9gC6UwTrX53o6HOpwgLluo7ySXIdJ4
 MsDp/j8HSBd/706Qf9SqAK3nWzdfnJf3WR6FI4xODfRIs2PqSTbDfpO6mGs1CT0TaQ8R
 o9mQ==
X-Gm-Message-State: AOJu0YxsJojQnRm+JRHZjm/q2mUBUn9I8F0QCTxxPcMOHQNsYdisH84K
 mQx+ZhnalmarycHRVu+5rsaTcCtxesgCX92erqbr9MzdOgOn4TTTba4qHQqBJHlYsvgAWtq+4H9
 zDlmN58Q=
X-Gm-Gg: ASbGncucLZFBqLyDcfm20ad40/ypgyXLqBgwYERYrxlFKyFy5IW37yY44u7iCvhNyqU
 wqv9ttHRoBrbv7d0ZwMgUlxVGaLpdjgxN5b7ADnktCoGDsCosXgnMxYG86kJS613zeInettPOF1
 8UJcNpZBnUYHGTXTdpH4nyJ+edCiJfGs/kH5jz4bVu3bcfg5QS+32S2Z7a0Kvv2372lyRPKhwlB
 vIkA1dRRxO1E4MX4p5s2l1+kGhliFWAw06m7h6YPM+0Ac+AWtumK+0p6bTaw3HdG7jZFeujYWT6
 Mk11PnX+w5gsfLATP5FMpG70zT0oMq1DRI6GvVJ3RSXUaP69W63qyBpBGA4S/k1QqQsMo0aw3cv
 8M0AMVqRt3vLXitdCcwAHlzPnSMYBRORLSPcj4tz4gbnxbK77zaZGdlw+zcYzbu7EP9476o73gD
 31ks6TJcut991Hb2P1lyE5U/be5qVi5OfqiBgOMf2knxiQ/qdnSg==
X-Google-Smtp-Source: AGHT+IEcHsFwc9UFzBVJEG8iB++b+nS/YevSOIFTO1lzsNkhZ849MApEwW4vPDX9UI7x5vNVBbpnBQ==
X-Received: by 2002:a05:6000:2287:b0:3ea:80ec:8552 with SMTP id
 ffacd0b85a97d-42704e0eda4mr11022149f8f.57.1761079716912; 
 Tue, 21 Oct 2025 13:48:36 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-427f00b9853sm21721571f8f.33.2025.10.21.13.48.36
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 21 Oct 2025 13:48:36 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 20/45] hw/core/register: remove the `register_finalize_block'
 function
Date: Tue, 21 Oct 2025 22:46:34 +0200
Message-ID: <20251021204700.56072-21-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251021204700.56072-1-philmd@linaro.org>
References: <20251021204700.56072-1-philmd@linaro.org>
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

From: Luc Michel <luc.michel@amd.com>

This function is now unused. Drop it.

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Francisco Iglesias <francisco.iglesias@amd.com>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
Signed-off-by: Luc Michel <luc.michel@amd.com>
Message-ID: <20251017161809.235740-5-luc.michel@amd.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/register.h | 14 --------------
 hw/core/register.c    |  4 ----
 2 files changed, 18 deletions(-)

diff --git a/include/hw/register.h b/include/hw/register.h
index 65c82600e06..7b0f4c8b7a6 100644
--- a/include/hw/register.h
+++ b/include/hw/register.h
@@ -209,18 +209,4 @@ RegisterInfoArray *register_init_block64(DeviceState *owner,
                                          bool debug_enabled,
                                          uint64_t memory_size);
 
-/**
- * This function should be called to cleanup the registers that were initialized
- * when calling register_init_block32(). This function should only be called
- * from the device's instance_finalize function.
- *
- * Any memory operations that the device performed that require cleanup (such
- * as creating subregions) need to be called before calling this function.
- *
- * @r_array: A structure containing all of the registers, as returned by
- *           register_init_block32()
- */
-
-void register_finalize_block(RegisterInfoArray *r_array);
-
 #endif
diff --git a/hw/core/register.c b/hw/core/register.c
index 1612ad174f9..81316d48597 100644
--- a/hw/core/register.c
+++ b/hw/core/register.c
@@ -322,10 +322,6 @@ static void register_array_finalize(Object *obj)
     g_free(r_array->r);
 }
 
-void register_finalize_block(RegisterInfoArray *r_array)
-{
-}
-
 static const TypeInfo register_array_info = {
     .name  = TYPE_REGISTER_ARRAY,
     .parent = TYPE_OBJECT,
-- 
2.51.0


