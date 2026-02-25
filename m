Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 393E4FD45F1
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 23:22:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvOAP-0007OP-NS; Wed, 25 Feb 2026 18:19:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vvOAN-0007O3-HM
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 18:19:39 -0500
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vvOAL-0003TW-QT
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 18:19:39 -0500
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-43996323357so109916f8f.0
 for <qemu-devel@nongnu.org>; Wed, 25 Feb 2026 15:19:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772061576; x=1772666376; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=nVIDYsjJNo00V4RXjiOYkAXaiezQ6gZ368AnaXXRDiU=;
 b=Tot1qQGmku+j+nnnbKE3XN6Ccse5a8Lym8GLNftgF4NrOUfj9dqdsVC3gVVVhwn6ad
 s8t5prGrUEItW4xfhLoh4t0cDebgbwTZVIxT/dyeRcwwt0rDWHhhpRRawyXeVwuSKvro
 Mi4VQHrsThu9Y1Vg+9TW78dTh1iCN4XLo364t6N8jxOkQG1j5VsQQXQQvoab9TAMNHo6
 uzfAUygX7WVn6+lkFqEYBF9Lm4pgNG8Vxn5arKCzcnjAXmmj8qlZNqQjtLGWExHvgJxx
 RLV9+uLHU+rAUYC1GErJIPpYx91LoP5f8rUVtSQcf0VgSMJrn0KvuBe/Plc+L4vQLaYG
 hwsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772061576; x=1772666376;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=nVIDYsjJNo00V4RXjiOYkAXaiezQ6gZ368AnaXXRDiU=;
 b=S7Mm4tSX9dKuzWSnvx0/Fl3ovkXMYxgEXNYvvqihPwA7buwW6Ispo/TqaG3QXJcqg6
 EPrYmjpdOEgUQcCb6VsDjvgrk4oRWAbuD9ak+4dN9agRd0HrzhXyRbftvkBXOq8eXd71
 mk6/o52WDCbCIUYSn9J82aeliGVh1R7waiS9XhW/swHsTU5KZn60qM94SsS6liZPduP1
 hS4A8Pw0Ga9paBOot4AHeBfdwW/zrRN42IMzf73i+MW2T6VFam9M6qBclI5AE5MdDQup
 qcDDLmVWpWzt8kHr1PCJJTsTWHnilIAShoVwJkb9k9Gq9bKhYQQo2g6Vp8wMEtZz018K
 Pgpw==
X-Gm-Message-State: AOJu0YxxeuCH/ZoP2o64sYdJ1hhB57Gpxr2mVEPuEI6pUb74Gmo6zIeE
 ZqdR2iBN+n3Pffsb9zXmSAvoE1GvxE50l8DUlLzABKcpRKwikZy2W4tNHujc6q4XkOrdxb/Al4K
 8iK5g9Ho=
X-Gm-Gg: ATEYQzwprLui2+36HL3aTQLdnYcwZ6oqTcKYLcZNzkGva71rUzglD37AE9IpLOsqLj2
 IAcSdjnXubNN0piaar4IPV5hNtZ/eSakscnwGn/7c3VuOYcHA7FH1TXLzbHUBE2VW40dGUSMuh0
 I9A/1ldOK3DA07nRQ6NJKUfsnlpiQZ4QqEAjoz06Y51FWwp7VveYZJWdIMLQxRnkEKxEcW/p6sX
 YOiPH9WyGuvQV9QNd9Xt6nvatd7J77JC66thIdmAusCYb4/9n8cyMBlVIzkqRQMRlUTrcxXPKlV
 Co7V7n1L0rcNe6BiGU3cNGK8zVUoycrjXK3UNJ15FOiO3UFWPMeN9ua39XhpFPuoe6zcadm5fqx
 XbCF/gt6PUz3wDFK/kgI5FtuXjRjK5uEpjuEg8iGIGm9gf7qa+ceRC3CwU9xyrswuFTCeR6Lavf
 iw7s3UZ/R4GVS2mCw2hfH0f3+/kbj8ZAMgReARjPg/LEYsJKHq+XBhbTZHxRv1Alxh6qxZNTBA
X-Received: by 2002:a05:6000:2086:b0:437:70d3:44e7 with SMTP id
 ffacd0b85a97d-4396f182eafmr31539809f8f.30.1772061575845; 
 Wed, 25 Feb 2026 15:19:35 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43970c09897sm38194494f8f.17.2026.02.25.15.19.35
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 25 Feb 2026 15:19:35 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 47/70] target/sh4: Build 'monitor.c' once for system binaries
Date: Thu, 26 Feb 2026 00:13:47 +0100
Message-ID: <20260225231411.96482-48-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260225231411.96482-1-philmd@linaro.org>
References: <20260225231411.96482-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42e.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

'monitor.c' can be built once for all qemu-system-sh4* binaries.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20260219191955.83815-40-philmd@linaro.org>
---
 target/sh4/meson.build | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/target/sh4/meson.build b/target/sh4/meson.build
index 221700bcf8c..1327507dfc8 100644
--- a/target/sh4/meson.build
+++ b/target/sh4/meson.build
@@ -7,8 +7,10 @@ sh4_ss.add(files(
   'translate.c',
 ))
 
-sh4_system_ss = ss.source_set()
-sh4_system_ss.add(files('monitor.c'))
+sh4_common_system_ss = ss.source_set()
+sh4_common_system_ss.add(files(
+  'monitor.c',
+))
 
 target_arch += {'sh4': sh4_ss}
-target_common_system_arch += {'sh4': sh4_system_ss}
+target_common_system_arch += {'sh4': sh4_common_system_ss}
-- 
2.52.0


