Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACDF6E92FF7
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Dec 2025 22:56:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vaM9t-00025L-Hv; Mon, 29 Dec 2025 17:56:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vaM9g-0001sO-Q7
 for qemu-devel@nongnu.org; Mon, 29 Dec 2025 17:56:01 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vaM9f-0001Ej-DT
 for qemu-devel@nongnu.org; Mon, 29 Dec 2025 17:56:00 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4775ae77516so94208425e9.1
 for <qemu-devel@nongnu.org>; Mon, 29 Dec 2025 14:55:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767048957; x=1767653757; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KoNDyCQE+9GYdY7JI1rLbViwKqxWNUa+Im9aqPwQSUg=;
 b=KzxKwJbFrZet9JOI6bcDAMbCZJOf3mdfx1xqgsGJOs3+VrAyTUjJyRvxZTwPgQ+imX
 3GmnRjvGe3+Szdsc/SW2CAVP+3DZfMfYUPe21ZO8KuA5K3wlb4UbKkjMPHlLCJKFWEUr
 8y7mQZ20NE1nF5suGO9uVSHDXuYONDGna8gG1mzxPzBsOvkuShx/KaFgPVTs5el/MygH
 +MMXSF/O3LUZooh7hW7J2j4KOxb8ZmvXPfguHJa6ey9wrd5ncDsMki0bAUsm5xX4IyeA
 PYMzQqs7MlUnzjMVyxbAw83+JUZUNo/qdq+1YaoFfXaW1V5mzfriaONo4xngNzJbKE9p
 BObg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767048957; x=1767653757;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=KoNDyCQE+9GYdY7JI1rLbViwKqxWNUa+Im9aqPwQSUg=;
 b=FSoS+TGUIeKbe89NbNy8rKQZq1giLDSo02TlixbdNlwvLsr4C34fBMnwCe86d1MN/U
 06IyNK++0K70ZzOtMoZqaSMwrHLhNSZajzUvtBh9GxJhGuRMYtNT8ffOtF4p9xvw7qbf
 PWMWi/2rP+6E19SRQ8Kfl7Qrvgkh8iCuULvHdg6SCAuBHKgEghIS7sWjcaj3tfVMZzWN
 HZqMZLNWads7JH6yFteYAJAcHFo1j+CmLLAQzXHxTT0xj5JAEmH4VH+wxx63hUdemNU0
 idUGakt/e1Y7MijYN8gbWEZE4GbWsuJp0kjrUjWA/o7BHaDmHPDZmJPTXo9WM6jJLM00
 bw/A==
X-Gm-Message-State: AOJu0YywEk/38wjhXLyEVJ9P3CLAXw5SpBvXGViwey9MlsQwFC1nZRoi
 RZWXTJsBKvV8ZNS9I5mjwo4ku3Qqk9uX35dP/bWkYzdOPkFxUUDSksZTZV7T0cXrRnVMYTBz4BQ
 qYdjJ6eo=
X-Gm-Gg: AY/fxX6uI95KPsY6ClheMsvnHsWQlRNnTJZuQ8hp/vvoOiiSybalmCqq0KLdBYzDR7L
 ULRUfzDQqKcgCgu6K/HkxHXmH2zzPUrcdnRV2fkkOI0lvbDtnwI9jGw9UJhkMvB/0sX8ufCilmx
 xhC8EwZxntn3nyMGDonfBbZMYKdfC9Ljr0pBzdIPKhV9kAaCwUHylQ36zs8Bp+146p7aR8zRhnF
 FXvFBA9JFXHJrnv8HGa5WevPbA6CJ6BPCBh1yA42vRmia1DMDbyuZZk79zyj8ABEc04AbU6t5eh
 c2HiA3Mim4tUz7kFcCx+Cg7B4loNWnG/eevxGsIayxhrzy/awVDe1Yg6uKTodokOy3Qecf2heP1
 fYbunl6KP1HuuZ4pTUqJlEx4LbI1A2uZRcmzpTI2KLRLMYy3IfCyzF0RZ9eY6LtB1vveNfnwQvT
 TAiIaBlE5jRm5dkYKv0bNXCF9/ebfyCg/JO6AJDKX6Xozta6iJsT51nWa59aER
X-Google-Smtp-Source: AGHT+IHi4H6w6QiPbNVcBiI0hOr1Qgn5sL/NjCYooYqFbTD634rjvRxLC4kBIbx6jAKvXw8V0R/6/A==
X-Received: by 2002:a05:600c:4fd3:b0:477:63b5:6f39 with SMTP id
 5b1f17b1804b1-47d195a702bmr311666965e9.19.1767048957460; 
 Mon, 29 Dec 2025 14:55:57 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d193621c8sm556014335e9.7.2025.12.29.14.55.56
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 29 Dec 2025 14:55:57 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Anton Johansson <anjo@rev.ng>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Sven Schnelle <svens@stackframe.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Helge Deller <deller@gmx.de>, Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 5/5] configs/targets: Forbid HPPA to use legacy native
 endianness APIs
Date: Mon, 29 Dec 2025 23:55:17 +0100
Message-ID: <20251229225517.45078-6-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251229225517.45078-1-philmd@linaro.org>
References: <20251229225517.45078-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

All HPPA-related binaries are buildable without a single use
of the legacy "native endian" API. Unset the transitional
TARGET_USE_LEGACY_NATIVE_ENDIAN_API definition to forbid
further uses of the legacy API.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
---
 configs/targets/hppa-linux-user.mak | 1 +
 configs/targets/hppa-softmmu.mak    | 1 +
 2 files changed, 2 insertions(+)

diff --git a/configs/targets/hppa-linux-user.mak b/configs/targets/hppa-linux-user.mak
index 59190f63358..a0c7398d599 100644
--- a/configs/targets/hppa-linux-user.mak
+++ b/configs/targets/hppa-linux-user.mak
@@ -5,3 +5,4 @@ TARGET_SYSTBL=syscall.tbl
 TARGET_BIG_ENDIAN=y
 # Compromise to ease maintenance vs system mode
 TARGET_LONG_BITS=64
+TARGET_NOT_USING_LEGACY_NATIVE_ENDIAN_API=y
diff --git a/configs/targets/hppa-softmmu.mak b/configs/targets/hppa-softmmu.mak
index ea331107a08..003f9f46dcc 100644
--- a/configs/targets/hppa-softmmu.mak
+++ b/configs/targets/hppa-softmmu.mak
@@ -1,3 +1,4 @@
 TARGET_ARCH=hppa
 TARGET_BIG_ENDIAN=y
 TARGET_LONG_BITS=64
+TARGET_NOT_USING_LEGACY_NATIVE_ENDIAN_API=y
-- 
2.52.0


