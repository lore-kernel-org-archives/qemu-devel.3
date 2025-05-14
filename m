Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BC0FC3ABD8
	for <qemu-devel@archiver.kernel.org>; Wed, 14 May 2025 23:42:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFLjF-0001sn-VR; Wed, 14 May 2025 19:41:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uFLj8-0001hR-72
 for qemu-devel@nongnu.org; Wed, 14 May 2025 19:41:31 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uFLj6-00035W-AX
 for qemu-devel@nongnu.org; Wed, 14 May 2025 19:41:29 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-22fb7659866so4047945ad.1
 for <qemu-devel@nongnu.org>; Wed, 14 May 2025 16:41:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747266087; x=1747870887; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sKwFRPpZTmbwynD7A1A8benKG+PxpGt82n2RkSfjlV4=;
 b=KtGGb/jkVZonBnTyBs/mPyv+u/PAXPPhAqwZF5yWQp0EY6y+W55hjW5OujUfwPRzKm
 Oe6WWHvn4fyfmb9c+pGoNazbCZs6NfIr/VsqVdR65AsW9whBQn2ZuvQj2pUWtp+sLIby
 o7qCiIY7h4IkZ+EQ5eKvrvSwHqO64ej+/eSoWnGjD7eV4VZrtGWG0gPe+X34XYF7NSR1
 a5AjlxjiONpXL1l1L6OZxdf7g6XcpPJzZ+WxPDQ3XV73+WjyYKENzuOglh7elL/dSSG3
 4Z6jEwvFuO4LXOJHL+2vbXxMp/NW1bE3lrAmv5miUDKQ6ZROpZ1nWP5bMJKp5v8wLs2K
 9Yaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747266087; x=1747870887;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sKwFRPpZTmbwynD7A1A8benKG+PxpGt82n2RkSfjlV4=;
 b=T5Lgbfn7WRzttC+ko88glFwy3oVCOGe8Qo6WE1nKanBe1a06L5GCsJiy9uO2N1aMid
 fka+efFgnc+lCNOE8PXqlbEs6vAK0NCS/S8SZFoKRbNDH7AMmQS4lY7jZFSnGeaHuMyE
 VG32O+fv2fwAhX2OyaFTMITyQw4QVsxIsao30/Plq5KK7hG9Or8/KUah0hKcLGMt8oiN
 mKqABgeCbKJf3MuitEflAka5ItWEHF8+H+6P21srQVTPIZa7qeRoMj+52tCRXJ4DiWjp
 34vWc5fx6FGBAU0+NhSuDUjnCkbw8XmOsugI+e9T7eT6OuPKQRMg5K90MMkFBSYWGPSg
 uvNg==
X-Gm-Message-State: AOJu0Yz+Nrpjfw6L0K/jH3K6ihm289t4gtxMK27pAD3pysRDD/HxtYnu
 W/rK8duG3n886f2fy7PGr1sYpfBfVnmmvV2qbiCxwy/o0YF8ZSH1eUkmNgCtadz+XCb5miXOMHt
 gsYw=
X-Gm-Gg: ASbGnctGmoSh1/LNxONLrqDIrmb1o16LV0dpj5BvrJA5iLns107D4e663ErjP8D8CXr
 Ma/znwHrpuSstPyuGkprCGoT4+LkCBdrN0zSsrxGiLfSM0VRMDaXL598DPerOcK2pMXQzZjTJAm
 +VoNrs6jvsiUj8M1vTLpkLrteUQtJf0VtvEbMdmf6BT+5KJb7sIJNZOPskv+bo7B1fMy3AXCVyv
 chC+QJv8PcFevW6b7tr6r35jAD9Z+5xcQTLd0BCHNSX/Wmg1V2ZWIPyNJgg7n57/DXuG6igqKlb
 cgg6H7rrksGs1DoHgJRe9+UotjVYPcFKbqFUxaENEmRuNaWWI7vWOS0DGcaaEA==
X-Google-Smtp-Source: AGHT+IGgn2FvwrHTSn3BfBeDZhUOfle4KRA96PuUO3UPqwZb7DzQM1mdQKjLCMlbUsF2v9JL7Pk39g==
X-Received: by 2002:a17:903:40d0:b0:22e:5e05:b89d with SMTP id
 d9443c01a7336-231b605adafmr5822275ad.16.1747266087146; 
 Wed, 14 May 2025 16:41:27 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22fc828b4e4sm104583615ad.182.2025.05.14.16.41.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 May 2025 16:41:26 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Michael Roth <michael.roth@amd.com>, alex.bennee@linaro.org,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 berrange@redhat.com, Richard Henderson <richard.henderson@linaro.org>,
 peter.maydell@linaro.org, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 12/12] qapi: make all generated files common
Date: Wed, 14 May 2025 16:41:08 -0700
Message-ID: <20250514234108.3746675-13-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250514234108.3746675-1-pierrick.bouvier@linaro.org>
References: <20250514234108.3746675-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x630.google.com
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

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 qapi/meson.build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/qapi/meson.build b/qapi/meson.build
index 7582c2b5bcf..6cc3afce721 100644
--- a/qapi/meson.build
+++ b/qapi/meson.build
@@ -140,6 +140,6 @@ foreach output : qapi_nonmodule_outputs
   if output.endswith('.trace-events')
     qapi_trace_events += qapi_files[i]
   endif
-  specific_ss.add(when: 'CONFIG_SYSTEM_ONLY', if_true: qapi_files[i])
+  system_ss.add(if_true: qapi_files[i])
   i = i + 1
 endforeach
-- 
2.47.2


