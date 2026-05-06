Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E381CCD3446
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2026 14:09:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKcvz-0004ZD-7a; Wed, 06 May 2026 10:09:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wKcvw-0004Sn-Ce
 for qemu-devel@nongnu.org; Wed, 06 May 2026 10:09:04 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wKcvu-0002CC-Gt
 for qemu-devel@nongnu.org; Wed, 06 May 2026 10:09:03 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4896c22fcbaso50236325e9.0
 for <qemu-devel@nongnu.org>; Wed, 06 May 2026 07:09:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778076540; x=1778681340; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=MaCMp39K2yLioHrKWnLqpJ+dZE3GjbZUzhgA018Ywsc=;
 b=OlO8ZBIjDxvRyEx3YLWMosANwWQ48olx+AOLJAeiaGkCS59biEBy3gKlhEAH3guqPC
 Dju348/DSPgl8jk4KJLnschXn5/LoZ6OVwd5QLKneGhi+fT3oMcDt9fzEgs4Y8hH63sK
 +plCMYhO+Mv+tPRm5qOcexf90IzAVqB973qMwXavBvLKA+pk8RawpJGwNLm3g+zaQGi/
 HQS8sT88z5e2BzEoopePxQaW4dP7iTZD4Xgex//LX6F/NPxdApj+Snv8Y+kGZmruiFY0
 cbp9L71w453wfcLEv8v8J/bcuD6MlQyXEYqM0cFC4OT7FNW/i7YAAO2Ri/X+K8j9PQgt
 qYyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778076540; x=1778681340;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=MaCMp39K2yLioHrKWnLqpJ+dZE3GjbZUzhgA018Ywsc=;
 b=NZ4NDHj3aksqw5tzfgzdsuCoVIBozJO+ZVfaGU9JoPumQo1meIW9wHCjXcfmenYS8q
 LU/eEM/w/12mF7FbnUkWC7gsQNqBMaXeCiite6Vu9lRA+MAC6WPAoGLKrqs/uevKB/4W
 yITgJc4/o4XoBY8aK6pXf9IcFrmNWyxR/xw0uTRRE5OTK8dAGFE/rUogxITFp0Di4D3Q
 f+iyxKmJvqfBi3vbuI1hLwdraGvWd0Tf166ITwKrildj3QsNxJ+69+Alby30+tviGnuP
 wbOZgv/fXDaBEKpOgtqnydv1qFrVLVahYFRC+tNIpaiZo/+D8lzo7kc9SX9mEUCL1UW/
 sK5Q==
X-Gm-Message-State: AOJu0Yy6j+eyzWaxqXNYfCPI1nn+/6kzFHDzmgGiPvI/OijV9lUF+YF5
 Jz8ObSvFR/xzzdkbNHFIFEJGKIfEiZW4QNlZVhGKVs+IhML7iu64JSjPgm1L9g46esuoY9UH6Xx
 MVpecsHI=
X-Gm-Gg: AeBDiev9l1F7gJ8hnPFRLD40lGzc+W5nI+2x6qPWDXLrazFAAFE/5XLw/rAwupFz0Ur
 XpRXm9fHKQugWGU9cb13xgLuzlEL8NfGdZAZFPHdluI7lLp/wwMfx/uCBrGuomcvx+2yO8nw5qH
 dQm177jQKjPZ0E0xNDOeui+OK2NOJR8UOP9iFRoSzpkQiKYqWH+Zeydo6vMM+uWRBR4VuX4m+SP
 EiBAahjZiQpaOLI2/aEHf62ojkqONRG0jkqvZ3FfCNPgihd/AbJ1cYSz71ZlT6mQJVSoKACDiMK
 X1GQjC3OWBERD/o6NY+qxReWSZ3sEl9x68lB+ukcGyDWFUOzq7b8Jpo2R2vHoix4y/Q8t1DlnNs
 wlDQ5gk72JhloR/p/rkwzEi8kjX0AWT3RRYuuoV2kK39PG3d7uFx6vShDyIKEi5cKiy4oVnJnzb
 5TYhhk+yXEyRYhPGX4/0WKZMXLz8TjGrcaIsC+B24ANJwZnr+WHfFZftCRhJybwXsie69x6aQSX
 WIQalj9kbs=
X-Received: by 2002:a05:600c:354b:b0:48a:554d:b9a2 with SMTP id
 5b1f17b1804b1-48e51e0c7c9mr61473365e9.6.1778076539695; 
 Wed, 06 May 2026 07:08:59 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e5389da63sm49799235e9.4.2026.05.06.07.08.58
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 06 May 2026 07:08:58 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 103/110] scripts/checkpatch: Reject another license boilerplate
 pattern
Date: Wed,  6 May 2026 15:55:15 +0200
Message-ID: <20260506135524.20617-104-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260506135524.20617-1-philmd@linaro.org>
References: <20260506135524.20617-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

From: Bernhard Beschow <shentey@gmail.com>

The pattern us used 56 times in QEMU.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Tested-by: Matyas Bobek <matyas.bobek@gmail.com>
Message-ID: <20260414135018.13585-1-shentey@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 scripts/checkpatch.pl | 1 +
 1 file changed, 1 insertion(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index e1cf2ff23b9..d440553a7ed 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -368,6 +368,7 @@ our @typeList = (
 # Match text found in common license boilerplate comments:
 # for new files the SPDX-License-Identifier line is sufficient.
 our @LICENSE_BOILERPLATE = (
+	"licensed under the GPL version 2",
 	"licensed under the terms of the GNU GPL",
 	"under the terms of the GNU General Public License",
 	"under the terms of the GNU Lesser General Public",
-- 
2.53.0


