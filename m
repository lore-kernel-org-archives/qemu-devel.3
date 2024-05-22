Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9EADC25B77
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2024 10:49:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s9jWn-0000Rh-3u; Wed, 22 May 2024 06:49:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1s9jWl-0000RD-Ma
 for qemu-devel@nongnu.org; Wed, 22 May 2024 06:48:59 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1s9jWj-0002m3-7f
 for qemu-devel@nongnu.org; Wed, 22 May 2024 06:48:58 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-1ee954e0aa6so9500015ad.3
 for <qemu-devel@nongnu.org>; Wed, 22 May 2024 03:48:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1716374935; x=1716979735;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=mqM4Fspwb8wwQhVc9tE0YGZZP9YEJO9lu9jnW/1dzlY=;
 b=TqmqY+LfXVnFWSwURs1uZPTt7Yc2UK1/LDdetli49i1Qky21AGWV+yIxb27GrTASM+
 4CbJM6UXFcwi1g7fcHiIi5R913jet/92q8Em2WtQPyd0EtD9w3opziBVe0hKlC2Jt0p8
 WwpsAVTws8NQ/14HzM6a2xapI36peuzPxts9hXMgpRi3IOdq4FCOFRo9zPOIGTRBK5p7
 ZrtIL0arbZ3VtttT+ZpwRuliZ8zxK87KHLyGgFDyjdAyJS1/IvFi6nrm34uvoAIInUdi
 sZBGyMPiHqyNNxkU++KtUJIAOVQ4ntw+ue4MN9Iw8Voa9BYX1VvPvBEjdMDX2WI5yoPa
 R5XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716374935; x=1716979735;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mqM4Fspwb8wwQhVc9tE0YGZZP9YEJO9lu9jnW/1dzlY=;
 b=t9NHc5kOT0Zu9iF7kjOqkInOiAlwrzBo8ELu9JaK38puroPGvRGWvdHNgvHFAZAUOj
 WLpZjUod6GNVd6LNRtSAr0EJzQIfR5GrwbdDcR6FdwLC05S2e5BMma/BlwHLUSlHEhus
 oAqSOOA/wOtk9XX18qVz1Cju+dLrTDR14zGvnGuhatZEfTrCjA5V+SUgGw5RmOyk+fZw
 eJVmtgbOEmHYRN9yC05/Eo7zptsHjeVy7SYfWspmXjs3SJeCxIdsVxSVUTlEyS9Z+XtJ
 x9Bqm3thiyID/+ScoDVeDK0AdKeigslyXpcMSlBHV/gP8V0QQSAA8wHme3YnPWKxkYxo
 b5RA==
X-Gm-Message-State: AOJu0Yysgz+mEz/fgmeFNyUijJPBNu3cLo66s9N08s3RA0D8hXW9y+s6
 iOCpZdD1fADk/mZN1vD953x5ZLM+/pgjjrCxCUp/sVcW5wr7OntXED5Dh0HirA0=
X-Google-Smtp-Source: AGHT+IEqjwpbgxMA+QxeffW2GKUe+tunJzuVuUZfYu6H9GI6MQq89UkBEsfMJh3Ajsp8MV+kYf1UXA==
X-Received: by 2002:a17:902:db06:b0:1f3:1036:a262 with SMTP id
 d9443c01a7336-1f31c95c473mr16912775ad.12.1716374934755; 
 Wed, 22 May 2024 03:48:54 -0700 (PDT)
Received: from localhost ([157.82.204.135])
 by smtp.gmail.com with UTF8SMTPSA id
 d9443c01a7336-1f32e24f2bfsm3463285ad.238.2024.05.22.03.48.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 22 May 2024 03:48:54 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Wed, 22 May 2024 19:48:37 +0900
Subject: [PATCH v3 2/3] meson: Add -fno-sanitize=function
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240522-xkb-v3-2-c429de860fa1@daynix.com>
References: <20240522-xkb-v3-0-c429de860fa1@daynix.com>
In-Reply-To: <20240522-xkb-v3-0-c429de860fa1@daynix.com>
To: Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Thomas Huth <thuth@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Wainer dos Santos Moschetta <wainersm@redhat.com>, 
 Beraldo Leal <bleal@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Laurent Vivier <lvivier@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>, 
 Laurent Vivier <laurent@vivier.eu>
Cc: qemu-devel@nongnu.org, Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14-dev-01a33
Received-SPF: none client-ip=2607:f8b0:4864:20::62f;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x62f.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

-fsanitize=function enforces the consistency of function types, but
include/qemu/lockable.h contains function pointer casts, which violate
the rule. We already disables exact type checks for CFI with
-fsanitize-cfi-icall-generalize-pointers so disable -fsanitize=function
as well.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 meson.build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/meson.build b/meson.build
index 91a0aa64c640..3c3ad0d5f5eb 100644
--- a/meson.build
+++ b/meson.build
@@ -298,7 +298,7 @@ endforeach
 
 qemu_common_flags = [
   '-D_GNU_SOURCE', '-D_FILE_OFFSET_BITS=64', '-D_LARGEFILE_SOURCE',
-  '-fno-strict-aliasing', '-fno-common', '-fwrapv' ]
+  '-fno-sanitize=function', '-fno-strict-aliasing', '-fno-common', '-fwrapv' ]
 qemu_cflags = []
 qemu_ldflags = []
 

-- 
2.45.1


