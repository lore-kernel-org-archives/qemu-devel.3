Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5A58C28B2E
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Mar 2025 23:00:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tr397-0004yD-WB; Sat, 08 Mar 2025 17:59:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tr38V-0004aZ-Au
 for qemu-devel@nongnu.org; Sat, 08 Mar 2025 17:59:16 -0500
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tr38T-0005Me-At
 for qemu-devel@nongnu.org; Sat, 08 Mar 2025 17:59:14 -0500
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-2255003f4c6so7089795ad.0
 for <qemu-devel@nongnu.org>; Sat, 08 Mar 2025 14:59:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741474752; x=1742079552; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4RYOsgRtmwYy8s4YT6srd8a+H0Yqb7Eaxx6hDoGO1oc=;
 b=WFhHgOChjqEnBbtVclmad46QYSDRuXuO6cKDT06xo/VowbDoOoihOhAzOSGxDDZJog
 ZRGfHHvZco+5sulltJ1WzCb8Wb7jTZZ5nbwg/BqIH4gwvqB4yFthE3VyysLnEQ0Exf6M
 SjbEdoUTujKy52pieyr3eEhz5jO3oRA0++SfBGUwsw5A3ZcWgxAw1rYOUZe7N2xCEEOE
 CMqMBJszt2fJv2gWJIdMnhp8zHsBLFEGO+izo9eq0YeQSZD2ezdRGVoGK/Oo7/1AQWG7
 arTLQl9/jepKKxmpQgWKtWKjBEPr1I9bHytM489gpoxqBspWanFLB7tB4HYFFCnaqh73
 mG9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741474752; x=1742079552;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4RYOsgRtmwYy8s4YT6srd8a+H0Yqb7Eaxx6hDoGO1oc=;
 b=HJ0nJ0xg2UAghFxnkgtt8K+vLq3dSdTuc/nGRDG3mDCOxrFEnyX32k7scohgTdKZ0X
 H46GLooaQTtUOf+TFXCUVO99DkHDJOHuvluO+TKgolC7QaXoeZZsirjF7g6yLmJ2hJJY
 gOX/BA7B5d8HxucKZrfhui4esffJh0asVZ6plNMcQRgHmCgufvEyRn/PKMCKIuJFKnot
 fhC1WMqfiQpfKaRq6+B7zaBJVmt+zI/elD2zK97fMQ8yuulKOGCNlm90UhajN3esRMNS
 T/I7FiLr3ob8hG34oka+J27RYpAOmoyiRx3nSUd4VjJ+oY26Xl3ACrHM+DjfHGL+Qbza
 Nw+g==
X-Gm-Message-State: AOJu0YyEEMpQZGWTvBhGe4B/M0q713iNosNac2KPZJh+R+pphjSDzry0
 yJe0I37JTVZxeuIinVcLsmkZ0czTmVF13QGYJutOyx9x3lDEIWfoy+ESC2mRwJX8nQO6oJmM8Wx
 i
X-Gm-Gg: ASbGncvWr54dY7Xf5VC2ehqsYi6ka2567TncHuFJBuQaTD81yuW3Bn+uFzsauz3xMbx
 wf0ZpF4U/wODLoDwpL9buN/mEnk3rzlnyYSNmLgX3gBBxGRfJdUFTmfLFvV9EqRm4djdEtT//G1
 3ZXhiCl7VqHWeLGSPpPbn1MdOZMPM6wZmFGdeRhCv0Ct+d0h+EAi4FUm/+7CYjdi8tssYa8TjVp
 rBkV5ms0p1zzeKj2oY4MHbM17+z4ZSufBbazeW05Ta2ZpLBhWke9X++UDFhJGT8yW/cttdaz1CT
 lloQD36z0MBCNOxbWedIW3z73iMyGi93/paAfB3eCxX1BJR5uAnarErHNQxnuPeRN6JKIwdxNsO
 c
X-Google-Smtp-Source: AGHT+IE25RDxI2Iq9VBukwPzF19w4uEhTrU/2prjmNMz2A2ql9AYXXndiI3x4NhqnfHPLYhCNyXGBw==
X-Received: by 2002:a17:902:eb81:b0:224:de2:7fd0 with SMTP id
 d9443c01a7336-22428a8bdb0mr152767285ad.25.1741474752076; 
 Sat, 08 Mar 2025 14:59:12 -0800 (PST)
Received: from stoup.. (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22410a908a0sm51831175ad.162.2025.03.08.14.59.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Mar 2025 14:59:11 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 12/23] system: Build watchpoint.c once
Date: Sat,  8 Mar 2025 14:58:51 -0800
Message-ID: <20250308225902.1208237-14-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250308225902.1208237-1-richard.henderson@linaro.org>
References: <20250308225902.1208237-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62d.google.com
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

Now that watchpoint.c uses cputlb.h instead of exec-all.h,
it can be built once.

Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 system/meson.build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/system/meson.build b/system/meson.build
index 4952f4b2c7..c83d80fa24 100644
--- a/system/meson.build
+++ b/system/meson.build
@@ -3,7 +3,6 @@ specific_ss.add(when: 'CONFIG_SYSTEM_ONLY', if_true: [files(
   'ioport.c',
   'memory.c',
   'physmem.c',
-  'watchpoint.c',
 )])
 
 system_ss.add(files(
@@ -24,6 +23,7 @@ system_ss.add(files(
   'runstate.c',
   'tpm-hmp-cmds.c',
   'vl.c',
+  'watchpoint.c',
 ), sdl, libpmem, libdaxctl)
 
 if have_tpm
-- 
2.43.0


