Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00FEEFD45FA
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 23:16:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvO6H-0005WO-KC; Wed, 25 Feb 2026 18:15:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vvO6E-0005PV-Pa
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 18:15:23 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vvO69-0002mM-4V
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 18:15:19 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-48069a48629so2848675e9.0
 for <qemu-devel@nongnu.org>; Wed, 25 Feb 2026 15:15:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772061315; x=1772666115; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=EM47/YJFZDKPoa7DcAX8k/MOHo1afw3n6fjicCOcopM=;
 b=vzqOYYdx7QWGXaaw/YES2si16wJMrY61p9HBoHV4Z0j2EpLABMiRMwH+pfMmn+7+gi
 funzF/OFBa2KzPr47y0+7AJFH8rX1zs6fCVvfJjqyPeLhXwQkqxpD32XtFFCDNQAQYX3
 M46jCmS0iEbOPYbu5cSPa2nU88kNNR+Qkp/G+j7pGNa/MHoTyvQ/TOnmB/xsgPQrHmxj
 3oQeXCyZE9mJzOuVfL2RivSJeBMiME/XexNpPtL4IUDi/k4RBswYab9/YSDlbkOu6Z3D
 KlEoEocI94UU+W6UIxUV6+n3UJHv542kEW1X95jB6D36qt8esAR0GOT7gKaxyDJEWWYo
 NiQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772061315; x=1772666115;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=EM47/YJFZDKPoa7DcAX8k/MOHo1afw3n6fjicCOcopM=;
 b=Ca4SBNSmlMpfr6KDaoLuhTMRfgRlO9klbzpJjUOC8Pc77R7ewu0/VAExsOvIBYxhLt
 LUsZ7WYRAQqHL52q4MiddGA2QeUXWht7tRUK7KtTa9wlORKsCAEg01P4C7PDQMt5sjtV
 nTUsV7xEbkheECNtdM0PRNRnKEOBVzuANP1FLLb5gyAvQRn+T5xr8Z5CoTkgo+dZzus6
 kCzsoxICZC7/X8kGQVOvdPPka5EssM8cxXgwIv48nQbSaiCdsJjc7EOfwVYTgROscBZb
 e6etimMuieLxQ4Jhcw70l70/H8QKRAC8uBJfSRwiItmqLdpHVpGqzlMi3p9eAjtuau2R
 49NQ==
X-Gm-Message-State: AOJu0YyvwHDRBcelM+SWImPIwQsrEIDOm/zgi2Vu3KVKBhrdzGbYwRvs
 Y1hdQ1d8EcrMk/D67ZIWdCaoTXxI6DpnktGD3x5V3mrdw2ghJI17c345AwsC6qpauzKgcEAXonr
 gzuNyYo8=
X-Gm-Gg: ATEYQzzHCDpXvb6FawnntVHnjmCSO2GWry5z3XtCGHSaotk5AuQsJt4fr7rRhPkA0Sr
 vZIGlGWi87EPAK5w26Jbuc6fkm8wftwYLHlTj80Yemul/FKsguKf2JQCoO9BphoGFW3wuBBrNul
 7NlAkjIC2hSHk01VYSS2L8Zd+HGnKNJL/0FQdHxPbVcg4WuYpXVyCqA+/m+IQCyzeCRJ4N0E6hk
 00wV/tT+ho+iHiRcobeviXfxMfj4w7rlzAqWVvPYllysmvWySFdh3PLbv8sQ0UlUwLYJ9QVFLY1
 q2Ok0H7eDxuSh+IUo6Z+YHdWga/aALhYaob67WHBCR6q556miTnVZUqRmtvweRlfcY4xCoECGY1
 t8qM1IMfWUCY0fag3zO2Nv48PpT8t5F+e/A8AfMlOHx9CuiajRdttOIwuMgYkENeWCW6Vtqu7pC
 3mY8QsQeddNk7F4LIJUhD+28ZlCCNgSXQL7C/T415dF29CQsFB6CCkOCWvfVVo9OWXNuCN4CTw
X-Received: by 2002:a05:600c:620c:b0:483:43d8:8d68 with SMTP id
 5b1f17b1804b1-483a95f8988mr277904665e9.28.1772061314986; 
 Wed, 25 Feb 2026 15:15:14 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483bfbb6d16sm30045995e9.5.2026.02.25.15.15.13
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 25 Feb 2026 15:15:13 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 09/70] target/ppc: Remove PPC_DEBUG_SPR left-over comment
Date: Thu, 26 Feb 2026 00:13:09 +0100
Message-ID: <20260225231411.96482-10-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260225231411.96482-1-philmd@linaro.org>
References: <20260225231411.96482-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

The PPC_DEBUG_SPR definition was fully removed in commit
61135639821 ("target/ppc: Clean up _spr_register et al").

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20260219191955.83815-3-philmd@linaro.org>
---
 target/ppc/cpu_init.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
index c36fd118a99..c809c1f4d89 100644
--- a/target/ppc/cpu_init.c
+++ b/target/ppc/cpu_init.c
@@ -52,7 +52,6 @@
 #endif
 
 #include "cpu_init.h"
-/* #define PPC_DEBUG_SPR */
 /* #define USE_APPLE_GDB */
 
 static const Property powerpc_cpu_properties[] = {
-- 
2.52.0


