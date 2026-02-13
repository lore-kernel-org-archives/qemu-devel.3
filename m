Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A29BEF99C1
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Feb 2026 17:51:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqxJz-0006SS-1k; Fri, 13 Feb 2026 12:51:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vqxJx-0006Rs-St
 for qemu-devel@nongnu.org; Fri, 13 Feb 2026 12:51:13 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vqxJw-0006SV-Cc
 for qemu-devel@nongnu.org; Fri, 13 Feb 2026 12:51:13 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-48370174e18so8233035e9.2
 for <qemu-devel@nongnu.org>; Fri, 13 Feb 2026 09:51:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771005070; x=1771609870; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=i5Rm2nH8G35sTm/WpOXpTgkT/f5xci0Rex6AKdW0vFs=;
 b=MJQ+EY2Ll7195U4pVIUfYMs5qty5M3/UbXe9qFprlpN25JKgB0lhosZdVF6sz9UJi4
 ambXnJQXeYjWnaZM2xSwwj3WB/gwy0J+T161tuir8QoNxul71nYkgBscWVHtMlTCP9eV
 jSQFX/VjkAtAUD/XwTYfLL9ldChJ/KtaA/8nDdfhlYBZ4Ggh+jontMWhpiB5Z2UIEhZm
 0Aok/qOE8rjoiZCGrOJ+ujHIcKxq//gYsj39Ors+rbu0lVBzr9aCMJ3eSsSrrb3gX28/
 CPzXMDIq+35YtkYynJgugRNWmsfm37bNiqUfJKJCOLwrKr/467rplVWscbjcRi17pkJp
 5scQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771005070; x=1771609870;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=i5Rm2nH8G35sTm/WpOXpTgkT/f5xci0Rex6AKdW0vFs=;
 b=cgvT7SOIBlj4bmrkalS3PHnU0cvMNY98LDR1dgEMnUR0tVUsTU6vmjEfhLl3HsuBNe
 q5YAaBkDq1/KPUUjNPYP00IueDRzEcSYOauX5xEhGMAAxmFrkb7+bYyk9Mt2Re6yMz+C
 EBqxS0HWoj53w5xHsxQW7ypgG/00Hg4P4Jgf+qbA4npLbb+3ylRcFEsrZdU40a1CSB23
 JgsWxNK1UssgPx+U2Xo1gu3ca39RrpfW0BjQKeBsT1dh7PrcSrlufGG3xib4ltghmSQQ
 ZGc8Ifm6/4MZ5jdew9pSYkECX6vjFM7cKd+P8crt3giVHYcQ5oRhrYVKhmRpaPIvlXET
 gmAg==
X-Gm-Message-State: AOJu0YzqKTmwxwDl00XlleizAB3nbG7+mvWaNjEKUp54g7Q2SKs8xlul
 kok/1+Md1WtGrUHFioGi1lQ5ugyVAR1Ie+jlYOuFd7vUb+jD3FoLLH5fIlMrlH1S83FWzgikqWr
 /grk+K9o=
X-Gm-Gg: AZuq6aIhn5mpNLxwqjWFArFXrWpesKwrF/BTdbOgv/PclLOpWd21I+DZoldrpy73ZIg
 +VjFHhP3cMR8FngtqrCNWintPgQODO4ZJVjmZ/my3hvFSm2dHHyJw1Qh/bXLdo1HIA1V42JaV1I
 OnomPzGprWeMLcE7JA68axYLKawv1SWhlgJ4UmYieSY1inBls5JTZS4WlZZsJNSPd63Oj+uWaTR
 hR46Yfuh/YJSGn8r1+5A3iHRues0sIZSPkEpAuVWP2HAgTv42/3iey78WyZFGQAidGR5/i16VI7
 vtTedXmSF608nyhpZBjZdT0Q78ZEuB1pIj9SYVtC7LpOFnhJPhEO76hCnVGFbH5ehsSBYkvW8xM
 EQuFOVYGZPfByB2yNwIZ9oMst6ECBORZRnsc2bKP1+GGGGV1DEfbKDzRq8qL8ffiHR5K47j+KvQ
 1ofWGFKn//0CcpNvO+kPGOXtJh1Oa0pFyVEx4HBrRnmtU7fbkbQfUnD0tr+4rqSxybk5jx+Gr6l
 FPK8/SHLOk=
X-Received: by 2002:a05:600c:4689:b0:471:114e:5894 with SMTP id
 5b1f17b1804b1-48379be5ba9mr725415e9.25.1771005070300; 
 Fri, 13 Feb 2026 09:51:10 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4835dcfb28dsm205103685e9.11.2026.02.13.09.51.09
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 13 Feb 2026 09:51:09 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, qemu-s390x@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, Fam Zheng <fam@euphon.net>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Subject: [PATCH v4 5/5] system: Reduce 'arch_init.h' scope
Date: Fri, 13 Feb 2026 18:50:32 +0100
Message-ID: <20260213175032.32121-6-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260213175032.32121-1-philmd@linaro.org>
References: <20260213175032.32121-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Better to restrict qemu_arch_available() scope so it is only
used by generic system/ code to parse command line options.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 {include/system => system}/arch_init.h | 0
 1 file changed, 0 insertions(+), 0 deletions(-)
 rename {include/system => system}/arch_init.h (100%)

diff --git a/include/system/arch_init.h b/system/arch_init.h
similarity index 100%
rename from include/system/arch_init.h
rename to system/arch_init.h
-- 
2.52.0


