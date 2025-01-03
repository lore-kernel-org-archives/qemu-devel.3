Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 290DEE77188
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jan 2025 23:19:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tTqvt-0007iq-1b; Fri, 03 Jan 2025 18:18:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tTqvp-0007iR-Ou
 for qemu-devel@nongnu.org; Fri, 03 Jan 2025 18:18:18 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tTqvo-0004KF-7I
 for qemu-devel@nongnu.org; Fri, 03 Jan 2025 18:18:17 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4361b0ec57aso126102815e9.0
 for <qemu-devel@nongnu.org>; Fri, 03 Jan 2025 15:18:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735946294; x=1736551094; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=h0uWaX6niLnCBI/QUliR49aUFih24VSMjlfGu4d+wP8=;
 b=xg+mToEzvB96rv7pvisNsdJ3soAmqL93UD8cmey5pvIZQW4deF7qbtIBUeF0fMQxny
 IbI8of7vfE9z/l6Nv6Sn/Vl8FcRhzBdYhmBzu4A86Wqvje9gdlVmdheiHNBiHD8sne0/
 ulpLuJVRdmdouYGXa+mEhziaUsxexb8OsOdgQOkxocgZXIlVjieBiGkCTHUN9wFVrmuV
 1v+2B6hnA3bL8QqqQZBf+TCGl5tgpAfw/9NO5Z6eQpd9dfGxAa9VDYbKrhBIXQXknOYQ
 KYDS4Yw/q/QrCUtJBsuTEjWEE5JYYQGGgF8ILcMBUlOvfzHecDCg1HsbqbSRSv5v9tjO
 uXSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735946294; x=1736551094;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=h0uWaX6niLnCBI/QUliR49aUFih24VSMjlfGu4d+wP8=;
 b=v/uNQ8HQncxgQtnDpz/bu0xvjj06TDbSZRujYDxqDP8T8rEpBOE7ShcgAsMs+DqhSo
 uGQVswXtG7B1FQJIKfY/vi333/jgPPFRlAzsAxV/tdhEv2++2KzCg/J2Y9LTxSeCL4Gv
 7h2f9filrUowEBnZX83AGTpHAegNuBo7E96CjqL+DTtsl9B+GCJgYnWezKI6DG9qXESy
 2JTHKMeKNbluy8yN8B6pJAtbi7BIbqr6ODVgdvEl7HXxsEB27vBnXmXtvQReoB4r7Ia/
 SCQDARiQEHh9paLJjH7E0pQWOXKwm1PAO76Dh8TELxTiloWpprY+RLIOf4eQjnV4fpC0
 Bh8w==
X-Gm-Message-State: AOJu0YwEyLvRQhRyptjaMHPzopmpxD6CTRKCBG/ksrULyrWrOXMxF/lh
 Hzt0pKq15Is9hwZzH8qKwWtnRzLcMgQybjX8kEJr+WLdFMjowuDgxSCa47M8t8jsGtqZntWsS8i
 IxGo=
X-Gm-Gg: ASbGncv0km+Jr/TUFwBecg9G9ri661Qg2NYJx5jPaW51oIOvVZxlTqb11Hy87ybECdv
 NTKqhiZI7/4SrMPTFJrhruYFAuifW5dE7CNp5odYdR8M7ruGUTFLAW9sh+YVtmGR2M0sZ1twlRD
 pxZmIfG9etkZy6G1BvRty/Ly8GGQV/ETLaQKet2G/AupPISjNSmegGpHtcurzqv3u+O2ejLAAS3
 QPzqLy3noEgQKsRqk7zkbGEMCM3FT7+xrIP1FjXq/8zJLvZq9lfRy3jYdWIhxMRAdp9KGjkGTPk
 YOLMctuwYMH4zM/Qn9hr79Jdzs/Im18=
X-Google-Smtp-Source: AGHT+IGm86jMBrvikoaPrqBBLdsolIuJTJr1oY0/8t+djHc/FacKby7SJDxBpWBx+ypu8Stocv9lXA==
X-Received: by 2002:a05:600c:3b20:b0:434:9df4:5485 with SMTP id
 5b1f17b1804b1-43668b76ae9mr375882515e9.32.1735946293538; 
 Fri, 03 Jan 2025 15:18:13 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43661289d3dsm501780615e9.41.2025.01.03.15.18.12
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 03 Jan 2025 15:18:13 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Brian Cain <brian.cain@oss.qualcomm.com>, Anton Johansson <anjo@rev.ng>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [RFC PATCH 5/6] Kconfig: Expose host CONFIG_CAPSTONE definition
Date: Sat,  4 Jan 2025 00:17:37 +0100
Message-ID: <20250103231738.65413-6-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250103231738.65413-1-philmd@linaro.org>
References: <20250103231738.65413-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 meson.build  | 1 +
 Kconfig.host | 3 +++
 2 files changed, 4 insertions(+)

diff --git a/meson.build b/meson.build
index a35ef579c28..28f9120a781 100644
--- a/meson.build
+++ b/meson.build
@@ -3224,6 +3224,7 @@ host_kconfig = \
   (have_ivshmem ? ['CONFIG_IVSHMEM=y'] : []) + \
   (opengl.found() ? ['CONFIG_OPENGL=y'] : []) + \
   (libcbor.found() ? ['CONFIG_LIBCBOR=y'] : []) + \
+  (capstone.found() ? ['CONFIG_CAPSTONE=y'] : []) + \
   (gnutls.found() ? ['CONFIG_GNUTLS=y'] : []) + \
   (x11.found() ? ['CONFIG_X11=y'] : []) + \
   (fdt.found() ? ['CONFIG_FDT=y'] : []) + \
diff --git a/Kconfig.host b/Kconfig.host
index 842cbe0d6c5..23b729db945 100644
--- a/Kconfig.host
+++ b/Kconfig.host
@@ -61,3 +61,6 @@ config HV_BALLOON_POSSIBLE
 
 config HAVE_RUST
     bool
+
+config CAPSTONE
+    bool
-- 
2.47.1


