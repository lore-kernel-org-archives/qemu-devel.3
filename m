Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D9AEC54791
	for <qemu-devel@archiver.kernel.org>; Sat,  9 Mar 2024 19:32:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rj2Iq-0002sX-1c; Sat, 09 Mar 2024 14:24:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rj2Io-0002lP-He
 for qemu-devel@nongnu.org; Sat, 09 Mar 2024 14:24:14 -0500
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rj2Im-0002k2-4D
 for qemu-devel@nongnu.org; Sat, 09 Mar 2024 14:24:14 -0500
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-5684f95cc9bso26029a12.1
 for <qemu-devel@nongnu.org>; Sat, 09 Mar 2024 11:24:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710012250; x=1710617050; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qjFrwxdzh9cIFuy3VrLZl1YDUiO+UYomEAH8YyqLi9E=;
 b=P7/bU2la/osimESifAkLanHeMCSxf8dYX3GeUifgR0pf3pcS7E5MaTlPj7fN3e+wV7
 h+tBcnWBLvFVFFmvET8ChI2a+tnW35VTa+/NczjcYTDNset2v2ahJU6fClZrNmrkVU7z
 zS2S//Eu4+XRRZD49WfZhvNpnGZlEisclAKZm4vQjQx+w3c3KamRt2KAbrw5udzafMjM
 d05f2FsMifBNjNytjWC5f1ds8JDf8xkJY71/1My2qYsb13WuKd41lIgLzKSwN1pG6MBD
 cpUsdNKCIYb24Ksl2aogcjdCSwVMg6q03On9Qr93jwHtrdInHxP4yLEm0bcjY6uHy/Li
 Owfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710012250; x=1710617050;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qjFrwxdzh9cIFuy3VrLZl1YDUiO+UYomEAH8YyqLi9E=;
 b=c7Ev/UOtZdZ2ozvBl9ZwGVyBzaqgWnvXxOQ4h89lqL9fKDgHH9lgWpu5/0vzktrLi5
 x/rg6KUfXoCKRw53M3/EputaEY0IVUZB5kimZWo5RsAbyu6nUh5+vkAfs1H6WiTu1Ifv
 SyJtCO8RgZWfWXaf4UJFeNGZeB1D+2+fX+OqV9e5CfH4Rb/XdKrvv1aLVE9CgJHnsosk
 nYWE5rO5kS5xuhCA/UZJS266lhO4MNhNw5F3BMF1uW66mQjUm7pQn6R35PRy+NGxA8Se
 DxUUPtjcYKdw+YXy2fnakWtl5o0xOnkcYf4ivDuCO4zkzXZQeKy6sRr25JNKYXCWBRHZ
 NXRw==
X-Gm-Message-State: AOJu0YwMsZY10aAy9r1n+TXWzYPK4Y84+39fTYIk+vfbf0ZPpGIxMfia
 JavOZbAD36PoKVD6bj6VW1EGLDISUApSCb2SOuFBsaCcXnphU1VYNlYhueG2XjeUkaLeraY4jpK
 K
X-Google-Smtp-Source: AGHT+IGuUctMA78NjZdtCAU9Y9aCkZkeDhz16yKH0hbVx551DJFp5YQmApTcRtGHo6YtY4fSt4CW5g==
X-Received: by 2002:a05:6402:5c3:b0:566:cfca:e56f with SMTP id
 n3-20020a05640205c300b00566cfcae56fmr2549323edx.19.1710012250332; 
 Sat, 09 Mar 2024 11:24:10 -0800 (PST)
Received: from m1x-phil.lan ([176.176.181.237])
 by smtp.gmail.com with ESMTPSA id
 9-20020a0564021f4900b00567e27c72c4sm1153365edz.62.2024.03.09.11.24.09
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 09 Mar 2024 11:24:09 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PULL 19/43] hw/i386/pc: Remove pc_compat_1_4..1.7[] left over
 declarations
Date: Sat,  9 Mar 2024 20:21:46 +0100
Message-ID: <20240309192213.23420-20-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240309192213.23420-1-philmd@linaro.org>
References: <20240309192213.23420-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

These definitions were removed in commit ea985d235b
("pc_piix: remove pc-i440fx-1.4 up to pc-i440fx-1.7").

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20240301185936.95175-2-philmd@linaro.org>
---
 include/hw/i386/pc.h | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index 5065590281..b958023187 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -288,18 +288,6 @@ extern const size_t pc_compat_2_1_len;
 extern GlobalProperty pc_compat_2_0[];
 extern const size_t pc_compat_2_0_len;
 
-extern GlobalProperty pc_compat_1_7[];
-extern const size_t pc_compat_1_7_len;
-
-extern GlobalProperty pc_compat_1_6[];
-extern const size_t pc_compat_1_6_len;
-
-extern GlobalProperty pc_compat_1_5[];
-extern const size_t pc_compat_1_5_len;
-
-extern GlobalProperty pc_compat_1_4[];
-extern const size_t pc_compat_1_4_len;
-
 #define DEFINE_PC_MACHINE(suffix, namestr, initfn, optsfn) \
     static void pc_machine_##suffix##_class_init(ObjectClass *oc, void *data) \
     { \
-- 
2.41.0


