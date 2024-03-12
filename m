Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A220C54E67
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 08:26:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjxQv-0007ZT-8X; Tue, 12 Mar 2024 04:24:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rjxQb-0006xF-1b
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 04:24:08 -0400
Received: from mail-lf1-x12e.google.com ([2a00:1450:4864:20::12e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rjxQX-0001Iy-Os
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 04:24:04 -0400
Received: by mail-lf1-x12e.google.com with SMTP id
 2adb3069b0e04-51344bebe2fso3943224e87.2
 for <qemu-devel@nongnu.org>; Tue, 12 Mar 2024 01:24:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710231839; x=1710836639; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6MhT9qADAUndB9gfklgv3b9HSVnHfN7uCmsIepMqwLg=;
 b=xWL/6C/BEhhR51C6D4BIFCZ9he3dZhe3h8yGjAGuPxPUynaUstIjNGhv3hfM8WHMUr
 IpbDVflnh/lI4PFxfYZU/he+8bdUBvD73vaVLh5IodJ7TY/9dfloteeu8sIVgfk4d0t4
 XogbT/MWRl16O9NXDorttmePUj9RV1xsKVWPSsbNCAClCvbTDYmBE8rPVj8lUBg5kZIn
 6DaVzbTaZTDAubClBWVxE7QTrD9gjqKu6WOid3UV/ZAwbcHOP+9YDtIv0QyNLEY+8NEX
 TigUGhlb6D04q+t5fA2n+DLe5Z+CeoUhVf6+z1S/Mm5qllXInkRPPCw0+qR3Z25Du7r4
 v1YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710231839; x=1710836639;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6MhT9qADAUndB9gfklgv3b9HSVnHfN7uCmsIepMqwLg=;
 b=cjrlnKiXSlcwPi6waP3ZU18JxsQMffMdBOc/Dq+CzLO7QWk3AlstSyrTg12OyiBlcd
 yNsg0MT+wbEMkd43By/C4iY/x8CvXWq/Z+UOLD15UKKVlwx4ycPXiPjbVIP9zQwLOhOD
 8QgzzzLQhhygNxvDMFqFHf2mDtHWn35EK79Lig3n8/YniXNf5AcgC6sVMKLLcj1C9AZb
 wCz/4ZueVESers9GgxIfXfgveN+agxhUq2puXw+H59Ho/v833U1VOY9+YoSd2O/UwFZ2
 Sq26TivOEclqr3836xAs6xQPJbukfLh/DhAmSLeQ04XyDzj2vLaszsMVUoOh2t0k/0co
 A3Mg==
X-Gm-Message-State: AOJu0YyDjXGJcwIF0EIXlJUfwKjtcgsa9FHc6o6P4LCiqb6HcS9lHLLK
 JcRwcRbZGauZpfeZy0HeeevFS61uL+PZzaABjrtWGBcpPSvtn1YnHyJ4Rfmx8Mw5Z7bZNHA03mO
 N
X-Google-Smtp-Source: AGHT+IHoqlh31+dI74u90bk1+IwHt2YR/TWPB1r4Y+swRDaL9d/DUXa3yzuFzikZXHElZo/cUxSlGQ==
X-Received: by 2002:ac2:42c8:0:b0:512:d78e:90fa with SMTP id
 n8-20020ac242c8000000b00512d78e90famr5379719lfl.15.1710231839612; 
 Tue, 12 Mar 2024 01:23:59 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.206.139])
 by smtp.gmail.com with ESMTPSA id
 l5-20020a056000022500b0033e712b1d9bsm8482375wrz.77.2024.03.12.01.23.57
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 12 Mar 2024 01:23:59 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, qemu-arm@nongnu.org, qemu-block@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Thomas Huth <thuth@redhat.com>
Subject: [PULL 12/13] meson.build: Always require an objc compiler on macos
 hosts
Date: Tue, 12 Mar 2024 09:22:37 +0100
Message-ID: <20240312082239.69696-13-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240312082239.69696-1-philmd@linaro.org>
References: <20240312082239.69696-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12e;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x12e.google.com
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

From: Peter Maydell <peter.maydell@linaro.org>

We currently only insist that an ObjectiveC compiler is present on
macos hosts if we're building the Cocoa UI.  However, since then
we've added some other parts of QEMU which are also written in ObjC:
the coreaudio audio backend, and the vmnet net backend.  This means
that if you try to configure QEMU on macos with --disable-cocoa the
build will fail:

../meson.build:3741:13: ERROR: No host machine compiler for 'audio/coreaudio.m'

Since in practice any macos host will have an ObjC compiler
available, rather than trying to gate the compiler detection on an
increasingly complicated list of every bit of QEMU that uses ObjC,
just require it unconditionally on macos hosts.

Resolves https://gitlab.com/qemu-project/qemu/-/issues/2138

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Message-ID: <20240311133334.3991537-1-peter.maydell@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 meson.build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/meson.build b/meson.build
index f9dbe7634e..e3fab8ce9f 100644
--- a/meson.build
+++ b/meson.build
@@ -66,7 +66,7 @@ if host_os == 'windows' and add_languages('cpp', required: false, native: false)
   cxx = meson.get_compiler('cpp')
 endif
 if host_os == 'darwin' and \
-   add_languages('objc', required: get_option('cocoa'), native: false)
+   add_languages('objc', required: true, native: false)
   all_languages += ['objc']
   objc = meson.get_compiler('objc')
 endif
-- 
2.41.0


